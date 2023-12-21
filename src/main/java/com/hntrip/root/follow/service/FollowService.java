package com.hntrip.root.follow.service;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.hntrip.root.follow.dto.FollowDTO;

public interface FollowService {
	public void getMyFollow(Model model, int writeNo, HttpSession session);
	public int addMyFollow(FollowDTO dto);
	public int delMyFollow(FollowDTO dto);
}
