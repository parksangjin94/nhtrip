package com.hntrip.root.member.mapper;

import com.hntrip.root.member.dto.MemberDTO;
import java.util.Map;

public interface MemberMapper {
	public int register(MemberDTO member);
	public MemberDTO chkId(String id);
	public MemberDTO getMember(String id);
	public void keepLogin(Map<String, Object> map); 
	public int apiLogin(MemberDTO member);
	public MemberDTO getMemInfo(String email);
	public int updatePwd(Map<String, Object> map);
}
