package com.hntrip.root.member.dto;

import java.sql.Date;

public class MemberDTO {
	private String id;
	private String pwd;
	private String name;
	private String email;
	private String session_id;
	private Date limit_date;
	private String code;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSession_id() {
		return session_id;
	}
	public void setSession_id(String session_id) {
		this.session_id = session_id;
	}
	public Date getLimit_date() {
		return limit_date;
	}
	public void setLimit_date(Date limit_date) {
		this.limit_date = limit_date;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
}