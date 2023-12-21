package com.hntrip.root.reply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hntrip.root.reply.dto.ReplyDTO;
import com.hntrip.root.reply.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService{
	@Autowired ReplyMapper rm;
	
	public List<ReplyDTO> replyData(int writeNo){
		return rm.replyData(writeNo);
	}
	public int replyAdd(ReplyDTO dto) {
		int result = 0;
		try {
			result = rm.replyAdd(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
