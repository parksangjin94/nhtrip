package com.hntrip.root.member.service;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Date;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.hntrip.root.common.session.MemberSessionName;
import com.hntrip.root.member.dto.MemberDTO;
import com.hntrip.root.member.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired private MemberMapper mapper;
	@Autowired JavaMailSender mailSender;
	BCryptPasswordEncoder encoder;
	MemberSessionName msn;
	public MemberServiceImpl() {
		encoder = new BCryptPasswordEncoder();
	}
	@Override
	public int register(MemberDTO member) {
		String securePw = encoder.encode(member.getPwd());
		member.setPwd(securePw);
		try {
			return mapper.register(member);
		}catch(Exception e){
			e.printStackTrace();
			return 0;
		}	
	}
	@Override
	public MemberDTO chkId(String id) {
		System.out.println("전달된 id값 : " + id);
		return mapper.chkId(id);
	}
	@Override
	public void sendMail(String to, String subject, String body) {
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setTo(to);
			helper.setSubject(subject);
			helper.setText(body, true);
			
			mailSender.send(message);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public int loginCheck(String id, String pwd) {
		MemberDTO dto = new MemberDTO();
		try {
			dto = mapper.getMember(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(dto!=null) {
				//조건문 encoder.matches(pwd, dto.getPwd())로 수정 
			if(encoder.matches(pwd, dto.getPwd())||pwd.equals(dto.getPwd())){
				return 1;
			}
			return 2; // 비번 오류
		}
		return 3; // id 없음
	}
	public void autoLogin(HttpSession session, HttpServletResponse response, String id) {
		
		int limitTime = 60*60*24*180; //180일
		Cookie loginCookie = new Cookie("loginCookie",session.getId());
		loginCookie.setMaxAge(limitTime);
		loginCookie.setPath("/"); //쿠키 범위 최상위
		response.addCookie(loginCookie);
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, 6); //6개월 후	
		Date limitDate = new Date(cal.getTimeInMillis());

		keepLogin(session.getId(), limitDate, id);
	
		System.out.println("id : "+ id);
		System.out.println("sessionId : "+ session.getId());
	}
	public void keepLogin(String session, Date limitDate, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sessionId", session);
		map.put("limitDate", limitDate);
		map.put("id", id);
		mapper.keepLogin(map);

	}

	public void logout(Cookie loginCookie, HttpSession session, HttpServletResponse response) {
		if(loginCookie!=null) {	
			loginCookie.setMaxAge(0);
			loginCookie.setPath("/");
			response.addCookie(loginCookie);
			keepLogin("null", new java.sql.Date(System.currentTimeMillis()),
					(String)session.getAttribute(msn.LOGIN));	
		}
		session.invalidate();
	}
	
	 public String get(String apiUrl, Map<String, String> requestHeaders){
	        HttpURLConnection con = connect(apiUrl);
	        try {
	            con.setRequestMethod("GET");
	            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
	                con.setRequestProperty(header.getKey(), header.getValue());
	            }


	            int responseCode = con.getResponseCode();
	            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
	                return readBody(con.getInputStream());
	            } else { // 에러 발생
	                return readBody(con.getErrorStream());
	            }
	        } catch (IOException e) {
	            throw new RuntimeException("API 요청과 응답 실패", e);
	        } finally {
	            con.disconnect();
	        }
	    }


	    public HttpURLConnection connect(String apiUrl){
	        try {
	            URL url = new URL(apiUrl);
	            return (HttpURLConnection)url.openConnection();
	        } catch (MalformedURLException e) {
	            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
	        } catch (IOException e) {
	            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
	        }
	    }


	    public String readBody(InputStream body){
	        InputStreamReader streamReader = new InputStreamReader(body);
	        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
	            StringBuilder responseBody = new StringBuilder();
	            String line;
	            while ((line = lineReader.readLine()) != null) {
	                responseBody.append(line);
	            }
	            return responseBody.toString();
	        } catch (IOException e) {
	            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
	        }
	    }
		@Override
		public int apiLogin(MemberDTO dto) {
			MemberDTO chkDTO = mapper.getMember(dto.getId());
			if(chkDTO == null) {
				return mapper.apiLogin(dto);
			}else {
				return 2;	// 기존에 네이버로 로그인 및 회원가입 완료한 경우 mapper 처리 하지 않음
			}
			
		}
		@Override
		public String getAccessToken(String authorize_code) {
			String access_Token = "";
			String refresh_Token = "";
			String reqURL = "https://kauth.kakao.com/oauth/token";

			try {
				URL url = new URL(reqURL);
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();

				//    POST 요청을 위해 기본값이 false인 setDoOutput을 true로
				conn.setRequestMethod("POST");
				conn.setDoOutput(true);

				//    POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
				BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
				StringBuilder sb = new StringBuilder();
				sb.append("grant_type=authorization_code");
				sb.append("&client_id=ba90b94fc88f2ca04ef48f2ab43249aa");
				sb.append("&redirect_uri=http://localhost:8085/root/member/kakaoLogin");
				sb.append("&code=" + authorize_code);
				bw.write(sb.toString());
				bw.flush();

				//    결과 코드가 200이라면 성공
				int responseCode = conn.getResponseCode();
				System.out.println("responseCode : " + responseCode);

				//    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				String line = "";
				String result = "";

				while ((line = br.readLine()) != null) {
					result += line;
				}
				System.out.println("response body : " + result);

				//    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
				JsonParser parser = new JsonParser();
				JsonElement element = parser.parse(result);

				access_Token = element.getAsJsonObject().get("access_token").getAsString();
				refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

				System.out.println("access_token : " + access_Token);
				System.out.println("refresh_token : " + refresh_Token);

				br.close();
				bw.close();
			} catch (IOException e) {
				e.printStackTrace();
			} 

			return access_Token;
		}
		@Override
		public MemberDTO getUserInfo(String access_token) {
			String reqURL = "https://kapi.kakao.com/v2/user/me";
			MemberDTO dto = new MemberDTO();
			try {
		        URL url = new URL(reqURL);
		        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		        conn.setRequestMethod("POST");
		        
		        //    요청에 필요한 Header에 포함될 내용
		        conn.setRequestProperty("Authorization", "Bearer " + access_token);
		        
		        int responseCode = conn.getResponseCode();
		        System.out.println("responseCode : " + responseCode);
		        
		        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		        
		        String line = "";
		        String result = "";
		        
		        while ((line = br.readLine()) != null) {
		            result += line;
		        }
		        System.out.println("response body : " + result);
		        
		        JsonParser parser = new JsonParser();
		        JsonElement element = parser.parse(result);
		        String id = element.getAsJsonObject().get("id").toString();
		        JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
		        
		        String email = kakao_account.getAsJsonObject().get("email").getAsString();
		        
		        if(email != "") { // 이메일 정보가 있다면 이메일 주소를 id로 사용함
			        String[] split_email = email.split("@");
			        String kakaoEmailId = "(Kakao)" + split_email[0];
			        dto.setId(kakaoEmailId);
		        }else { // 없는 경우 kakao api 가 제공하는 고유 id 값을 사용함
		        	dto.setId(id);
		        }
		        dto.setEmail(email);
		        
		        return dto;
		    } catch (IOException e) {
		        e.printStackTrace();
		    }
			return dto;
		}
		@Override
		public MemberDTO getMemInfo(String email) {
			MemberDTO dto = new MemberDTO();
			dto = mapper.getMemInfo(email);
			return dto;
		}
		@Override
		public int updatePwd(String id, String pwd) {
			String securePwd = encoder.encode(pwd);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("pwd", securePwd);
			int result = mapper.updatePwd(map);
			return result;
		}
}
