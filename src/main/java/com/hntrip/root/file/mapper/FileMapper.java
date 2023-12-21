package com.hntrip.root.file.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hntrip.root.board.dto.BoardDTO;
import com.hntrip.root.file.dto.FileDTO;
import com.hntrip.root.hit.dto.HitDTO;

public interface FileMapper {
   public List<FileDTO> getMyImg(int writeNo);
   public List<FileDTO> searchWriteNo(List<BoardDTO> WriteNoList);
   public List<FileDTO> hitMyImg(List<HitDTO> list);
   public void insert(List<FileDTO> file);
}