package com.hntrip.root.hit.mapper;

import java.util.List;

import com.hntrip.root.hit.dto.HitDTO;

public interface HitMapper {
	public List<HitDTO> getMyHit(int writeNo);
	public void addMyHit(HitDTO dto);
	public void delMyHit(HitDTO dto);
	public List<HitDTO> allMyHit(String id);
}
