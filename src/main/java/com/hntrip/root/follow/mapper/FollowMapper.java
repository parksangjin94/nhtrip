package com.hntrip.root.follow.mapper;

import java.util.List;

import com.hntrip.root.follow.dto.FollowDTO;

public interface FollowMapper {
	public List<FollowDTO> getMyFollow(String id);
	public int addMyFollow(FollowDTO dto);
	public int delMyFollow(FollowDTO dto);
}
