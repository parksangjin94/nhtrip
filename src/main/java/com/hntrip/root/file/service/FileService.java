package com.hntrip.root.file.service;

import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.hntrip.root.board.dto.BoardDTO;
import com.hntrip.root.file.dto.FileDTO;

import com.hntrip.root.hit.dto.HitDTO;


public interface FileService {
   public static final String IMAGE_REPO = "C:/spring/image_repo";
   public void getMyImg(Model model, int writeNo);
   public List<FileDTO> searchWriteNo(List<BoardDTO> WriteNoList);
   public void hitMyImg(List<HitDTO> wirteNo, Model model);
   public List<String> saveFile(List<MultipartFile> fileList);
}