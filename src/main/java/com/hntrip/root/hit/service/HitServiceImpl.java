package com.hntrip.root.hit.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.hntrip.root.common.session.MemberSessionName;
import com.hntrip.root.hit.dto.HitDTO;
import com.hntrip.root.hit.mapper.HitMapper;

@Service
public class HitServiceImpl implements HitService {
	@Autowired HitMapper hm;
	public void getMyHit(Model model, int writeNo, HttpSession session) {
		List<HitDTO> list = hm.getMyHit(writeNo);
		if(list.size() != 0) {
			for(int i=0; i<list.size(); i++) {
				if(list.get(i).getId().equals((String)session.getAttribute(MemberSessionName.LOGIN))) {
					model.addAttribute("myHit", true);
					return;
				}
			}
		}
		model.addAttribute("myHit", false);
	}
	public void addMyHit(int writeNo, String id) {
		HitDTO dto = new HitDTO();
		dto.setWriteNo(writeNo); dto.setId(id);
		hm.addMyHit(dto);
	}
	public void delMyHit(int writeNo, String id) {
		HitDTO dto = new HitDTO();
		dto.setWriteNo(writeNo); dto.setId(id);
		hm.delMyHit(dto);
	}
	public List<HitDTO> allMyHit(String id) {
		try {
			List<HitDTO> list = hm.allMyHit(id);
			return list;			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
