package com.hntrip.root.reply.service;

import java.util.List;

import com.hntrip.root.reply.dto.ReplyDTO;

public interface ReplyService {
	public List<ReplyDTO> replyData(int writeNo);
	public int replyAdd(ReplyDTO dto);
}
