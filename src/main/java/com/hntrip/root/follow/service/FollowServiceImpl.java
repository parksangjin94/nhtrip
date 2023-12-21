package com.hntrip.root.follow.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.hntrip.root.board.mapper.BoardMapper;
import com.hntrip.root.common.session.MemberSessionName;
import com.hntrip.root.follow.dto.FollowDTO;
import com.hntrip.root.follow.mapper.FollowMapper;

@Service
public class FollowServiceImpl implements FollowService{
	@Autowired FollowMapper fwm;
	@Autowired BoardMapper bm;
	
	public void getMyFollow(Model model, int writeNo, HttpSession session) {
		//내가 팔로우한 아이디 목록
		List<FollowDTO> list = fwm.getMyFollow(session.getAttribute(MemberSessionName.LOGIN).toString());
		//현재 글 번호 작성자
		String writeId = bm.getMyData(writeNo).getId();
		if(list.size() != 0) {
			for(FollowDTO listId : list) {
				if(listId.getFollowId().equals(writeId)) {
					model.addAttribute("myFollow", true);
					return;
				}
			}
		}
		model.addAttribute("myFollow", false);
	}
	public int addMyFollow(FollowDTO dto) {
		int result = 0;
		try {
			result = fwm.addMyFollow(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public int delMyFollow(FollowDTO dto) {
		int result = 0;
		try {
			result = fwm.delMyFollow(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
