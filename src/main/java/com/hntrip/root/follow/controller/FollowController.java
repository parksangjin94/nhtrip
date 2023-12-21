package com.hntrip.root.follow.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hntrip.root.follow.dto.FollowDTO;
import com.hntrip.root.follow.service.FollowService;

@RestController
@RequestMapping("board")
public class FollowController {
	@Autowired FollowService fws;
	
	@PostMapping(value="addFollow", produces="application/json;charset=utf-8")
	public boolean addFollow(@RequestBody FollowDTO dto) {
		System.out.println("addFollow");
		int result = fws.addMyFollow(dto);
		if(result == 1) {
			return true;
		}else {
			return false;
		}
	}
	@PostMapping(value="delFollow", produces="application/json;charset=utf-8")
	public boolean delFollow(@RequestBody FollowDTO dto) {
		System.out.println("delFollow");
		int result = fws.delMyFollow(dto);
		if(result == 1) {
			return true;
		}else {
			return false;
		}
	}
}
