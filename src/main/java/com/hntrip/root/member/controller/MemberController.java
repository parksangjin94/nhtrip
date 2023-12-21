package com.hntrip.root.member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.http.Cookie;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hntrip.root.common.session.MemberSessionName;
import com.hntrip.root.member.dto.MemberDTO;
import com.hntrip.root.member.service.MemberService;


@Controller
@RequestMapping("member")
public class MemberController implements MemberSessionName{
	@Autowired MemberService ms;

	@RequestMapping("/naverLogin")
	public String naverLogin() {
		return "member/naverLogin";
	}
	@RequestMapping("/naverCallback")
	public String naverCallback(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws UnsupportedEncodingException {
	    String clientId = "gOu7UJfHmcwmD8ic4Ar5";//애플리케이션 클라이언트 아이디값";
	    String clientSecret = "cwGnDVvG0_";//애플리케이션 클라이언트 시크릿값";
	    String code = request.getParameter("code");
	    String state = request.getParameter("state");
	    String redirectURI = URLEncoder.encode("http://localhost:8085/root/member/naverCallback", "UTF-8");
	    String apiURL;
	    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
	    apiURL += "client_id=" + clientId;
	    apiURL += "&client_secret=" + clientSecret;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&code=" + code;
	    apiURL += "&state=" + state;

	    System.out.println("apiURL="+apiURL);
	    try {
	      URL url = new URL(apiURL);
	      HttpURLConnection con = (HttpURLConnection)url.openConnection();
	      con.setRequestMethod("GET");
	      int responseCode = con.getResponseCode();
	      BufferedReader br;
	      System.out.print("responseCode="+responseCode);
	      if(responseCode==200) { // 정상 호출
	        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	      } else {  // 에러 발생
	        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	      }
	      String inputLine;
	      StringBuffer res = new StringBuffer();
	      while ((inputLine = br.readLine()) != null) {
	        res.append(inputLine);
	      }
	      br.close();
	      if(responseCode==200) {
	    	  //System.out.println("res 코드 : " + res.toString());
	    	  // 로그인하는 네이버 ID 마다 다른 토큰값 처리
	    	  JSONParser parsing = new JSONParser();
	    	  Object obj = null;
	    	  obj = parsing.parse(res.toString());
	    	  JSONObject jsonObj = (JSONObject)obj;
	    	  String token = (String)jsonObj.get("access_token"); // 네이버 로그인 접근 토큰;
	    	  System.out.println("토큰값 : " + jsonObj.get("access_token"));
	          String header = "Bearer " + token; // Bearer 다음에 공백 추가

	          String apiURL1 = "https://openapi.naver.com/v1/nid/me";
	         
	          Map<String, String> requestHeaders = new HashMap<>();
	          requestHeaders.put("Authorization", header);
	          String responseBody = ms.get(apiURL1,requestHeaders);
	          System.out.println(responseBody);
	          
	          // 회원정보 수집
	          obj = parsing.parse(responseBody);
	          jsonObj = (JSONObject)obj;
	          JSONObject resObj = (JSONObject)jsonObj.get("response");
	          
	          MemberDTO dto = new MemberDTO();
	         //String id = (String)resObj.get("id");
	         //id = "(NAVER)"+ id.substring(0,5) + id.substring(12,17) + id.substring(22,24);
	         //System.out.println("id값 : " + id);
	          String email = (String)resObj.get("email");
	          System.out.println("e메일 값 : " + email);
	          String[] split_email = email.split("@");
		      String naverId = "(NAVER)" + split_email[0];
	          dto.setId(naverId); dto.setEmail(email);
	          ms.apiLogin(dto);
	          session.setAttribute(LOGIN, naverId);
	    	  return "/board/main";
	      }
	    } catch (Exception e) {
	    	System.out.println("정보가져오기 실패!!");
	    	System.out.println(e);
	      return "/member/login";
	    }
	    return "/index";
	}
	
	@RequestMapping("/index")
	public String index() {
		return "index";
	}
	@RequestMapping("/register_form")
	public String register_form() {
		return "member/register";
	}
	
	@RequestMapping("/register")
	public String register(MemberDTO member, Model model){
		int result = ms.register(member);
		if(result==1) {
			model.addAttribute("msg", "회원가입 되었습니다!!");
			model.addAttribute("url","/root/member/login");
			return "/member/loginfailed";
		}else {
			model.addAttribute("msg", "회원가입에 실패했습니다. 다시 입력해주세요.");
			model.addAttribute("url","/root/member/register_form");
			return "/member/loginfailed";
		}
	}
	
	@GetMapping(value="chkId", produces="application/json; charset=utf-8")
	@ResponseBody
	public MemberDTO chkId(@RequestParam String id) {
		System.out.println("중복 확인하는 id값 : " + id);
		return ms.chkId(id);
	}
	
	@ResponseBody
	@PostMapping(value="sendMail", produces="application/json; charset=utf-8")
	public MemberDTO sendMail(HttpServletResponse response,
							@RequestBody MemberDTO dto) throws IOException {
		System.out.println("입력된 이메일 주소 : " + dto.getEmail());
		System.out.println("입력된 랜덤코드값 : " + dto.getCode());
		String email_addr = dto.getEmail();
		String auth_code = dto.getCode();
		
		StringBuffer sb = new StringBuffer();
		sb.append("<div style=\"background-image : url('https://d1blyo8czty997.cloudfront.net/review-photos/97199/2128/800x800/1527300111.jpg');\r\n"
				+ "				height : 500px; width : 500px; text-align: center\">");
		sb.append("<p style=\"font-size:18px; color:white; padding-top: 180px\">");
		sb.append("여행자를 위한 다이어리 HNTrip 이메일 인증코드 입니다.</p>");
		sb.append("<p style=\"font-size:22px; color:white;\">");
		sb.append("인증코드 : " + auth_code + "</p>");
		sb.append("<p style=\"font-size:18px; color:white;\">");
		sb.append("회원가입 페이지에 입력해주세요. </p>");
		sb.append("</div>");
		
		String str = sb.toString();
				
		ms.sendMail(email_addr,"[회원가입] HNTrip 이메일 인증코드 메일입니다.", str);
		
		response.setContentType("text/html; charset=utf-8");
//		PrintWriter out = response.getWriter();
//		out.print("메일을 전송하였습니다");
		return dto;
	}
	@GetMapping("login")
	public String login() {
		return "member/login";
	}
	@PostMapping("loginCheck")
	public String loginCheck(@RequestParam String id,
							@RequestParam String pwd,
							@RequestParam(required = false) String autoLogin,
							RedirectAttributes rs,
							Model model) {
		int result = 0;
		result = ms.loginCheck(id, pwd);
		if(result == 1) {
			rs.addAttribute("id",id);
			rs.addAttribute("autoLogin",autoLogin);
			return "redirect:successLogin";
		}else if(result == 2) {
			model.addAttribute("msg", "PASSWORD IS INCORRECT"); //비밀번호 오류
		}else if(result == 3) {
			model.addAttribute("msg", "THERE IS NO REGISTERED ID"); //ID 없음
		}else {
			model.addAttribute("msg", "SYSTEM ERROR SORRY"); //ID 없음
		}
		model.addAttribute("url","/root/member/login");
		return "/member/loginfailed";
	}
	@GetMapping("successLogin")
	public String successLogin(@RequestParam String id, 
								@RequestParam(required = false) String autoLogin,
								HttpSession session, HttpServletResponse response) {
		if(autoLogin!=null){		
			ms.autoLogin(session, response, id);
		}
		session.setAttribute(LOGIN, id);
		System.out.println(session.getAttribute(LOGIN));
		return "redirect:/board/main?id="+id;
	}
	@GetMapping("logout")
	public String logout(HttpSession session, HttpServletResponse response,		
						@CookieValue(value="loginCookie", required = false) 
						Cookie loginCookie) {
		if(session.getAttribute(LOGIN)!=null) {
			ms.logout(loginCookie, session, response);	
		}
		response.addHeader(null, null);
		return "redirect:/index";
	}
	
	@GetMapping("kakaoLogin")
	public String kakaoLogin(@RequestParam("code") String code, HttpSession session) {
		String access_token = ms.getAccessToken(code);
		//System.out.println("access_token 값 : " + access_token);
		MemberDTO dto = new MemberDTO();
		dto = ms.getUserInfo(access_token);
		String id = dto.getId();
		if(ms.apiLogin(dto) != 0 || ms.apiLogin(dto) == 2 ) {
			session.setAttribute(LOGIN, id);
			return "/board/main";
		}
		return "member/login"; // 로그인에 오류가 발생한 경우
	}
	
	@GetMapping("findInfo")
	public String findInfo() {
		return "/member/findInfo";
	}
	
	@RequestMapping("findMemberInfo")
	public String findMemberInfo(@RequestParam String email, HttpServletRequest request, Model model) {
		System.out.println("입력된 이메일 주소 : " + email);
		MemberDTO dto = new MemberDTO();
		dto = ms.getMemInfo(email);
		if(dto == null) {
			model.addAttribute("msg", "등록된 이메일이 없습니다. 다시 확인해주세요.");
			model.addAttribute("url","/root/member/findInfo");
			return "/member/loginfailed";
		}else {
			String id = dto.getId();
			StringBuffer sb = new StringBuffer();
			sb.append("<div style=\"background-image : url('https://d1blyo8czty997.cloudfront.net/review-photos/97199/2128/800x800/1527300111.jpg');\r\n"
					+ "				height : 500px; width : 500px; text-align: center\">");
			sb.append("<p style=\"font-size:18px; color:white; padding-top: 180px\">");
			sb.append("여행자를 위한 다이어리 HNTrip 이메일 인증코드 입니다.</p>");
			sb.append("<p style=\"font-size:22px; color:white;\">");
			sb.append("가입된 ID : " + id + " 입니다.</p>");
			sb.append("<p style=\"font-size:18px; color:white;\">");
			sb.append("비밀번호 변경은 아래 링크에서 가능합니다. </p><br>");
			sb.append("<a style=\"color:white; font-size:18px;\" href=\"http://localhost:8085/root/member/changePwd\">비밀번호 변경하기</a>");
			sb.append("</div>");
			
			String str = sb.toString();
			ms.sendMail(email,"HNTrip 회원정보 찾기 관련 메일입니다.", str);
			model.addAttribute("msg", "입력하신 주소로 메일이 발송되었습니다. 메일을 확인해주세요.");
			model.addAttribute("url","/root/member/login");
			return "/member/loginfailed";
		}
	}
	
	@GetMapping("changePwd")
	public String changePwd() {
		return "member/changePwd";
	}
	
	@RequestMapping("changeMemPwd")
	public String changeMemPwd(@RequestParam String id, @RequestParam String pwd, Model model) {
		int result = ms.updatePwd(id, pwd);
		if(result == 1) {
			model.addAttribute("msg", "비밀번호가 성공적으로 변경되었습니다.");
			model.addAttribute("url","/root/member/login");
			return "/member/loginfailed";
		}else {
			model.addAttribute("msg", "비밀번호 변경에 실패했습니다! 다시 시도해주세요.");
			model.addAttribute("url","/root/member/changePwd");
			return "/member/loginfailed";
		}
			
	}
}
