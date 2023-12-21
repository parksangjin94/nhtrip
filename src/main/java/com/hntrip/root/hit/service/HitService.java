package com.hntrip.root.hit.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.hntrip.root.hit.dto.HitDTO;

public interface HitService {
	public void getMyHit(Model model, int writeNo,HttpSession session);
	public void addMyHit(int writeNo, String id);
	public void delMyHit(int writeNo, String id);
	public List<HitDTO> allMyHit(String id);
}
