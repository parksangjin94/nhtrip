package com.hntrip.root.member.service;

import java.io.InputStream;
import java.net.HttpURLConnection;
import java.sql.Date;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hntrip.root.member.dto.MemberDTO;

public interface MemberService {
	public int register(MemberDTO member);
	public MemberDTO chkId(String id);
	public void sendMail(String to, String subject, String body);
	public int loginCheck(String id, String pwd);
	public void autoLogin(HttpSession session, HttpServletResponse response, String id);
	public void keepLogin(String session, Date limitDate, String id);
	public void logout(Cookie loginCookie, HttpSession session, HttpServletResponse response);
	public String get(String apiUrl, Map<String, String> requestHeaders);
	public HttpURLConnection connect(String apiUrl);
	public String readBody(InputStream body);
	public int apiLogin(MemberDTO dto);
	public String getAccessToken(String authorize_code);
	public MemberDTO getUserInfo(String access_token);
	public MemberDTO getMemInfo(String email);
	public int updatePwd(String id, String pwd);
}