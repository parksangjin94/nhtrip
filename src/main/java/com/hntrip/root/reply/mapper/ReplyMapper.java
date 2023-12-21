package com.hntrip.root.reply.mapper;

import java.util.List;

import com.hntrip.root.reply.dto.ReplyDTO;

public interface ReplyMapper {
	public List<ReplyDTO> replyData(int writeNo);
	public int replyAdd(ReplyDTO dto);
}
