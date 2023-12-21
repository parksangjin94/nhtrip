package com.hntrip.root.hit.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hntrip.root.common.session.MemberSessionName;
import com.hntrip.root.file.service.FileService;
import com.hntrip.root.hit.service.HitService;

@Controller
@RequestMapping("board")
public class HitController {
	@Autowired HitService hs;
	@Autowired FileService fs;
	
	@GetMapping("likes")
	public String likes(Model model, HttpSession session) {
		Object obj = session.getAttribute(MemberSessionName.LOGIN);
		String id = (String)obj;
		fs.hitMyImg(hs.allMyHit(id), model);
		return "board/likes";
	}
}
