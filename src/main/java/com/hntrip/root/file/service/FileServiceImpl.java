package com.hntrip.root.file.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hntrip.root.board.dto.BoardDTO;
import com.hntrip.root.file.dto.FileDTO;
import com.hntrip.root.file.mapper.FileMapper;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.hntrip.root.hit.dto.HitDTO;

@Service
public class FileServiceImpl implements FileService {
   @Autowired FileMapper fm;
   
   public void getMyImg(Model model, int writeNo) {
      model.addAttribute("myImg", fm.getMyImg(writeNo));
   }   
   public List<FileDTO> searchWriteNo(List<BoardDTO> WriteNoList) {
      return fm.searchWriteNo(WriteNoList);      

   }
   public void hitMyImg(List<HitDTO> wirteNo, Model model) {
      try {
         model.addAttribute("hitList", fm.hitMyImg(wirteNo));   
      } catch (Exception e) {
         e.printStackTrace();
      }
   }
   @Override
   public List<String> saveFile(List<MultipartFile> fileList) {
      int cnt = 0;
      List<String> FileList = new ArrayList<String>();
      for(MultipartFile mf : fileList) {
         String sysFilename = cnt+mf.getOriginalFilename(); //파일리스트내의 파일들의 파일순서, 파일 명을 설정한다
         cnt++;
         File saveFile = new File(IMAGE_REPO+"/"+sysFilename); //파일경로랑 파일 이름과 합쳐진다
      try {
         mf.transferTo(saveFile); //파일경로 저장
      } catch (Exception e) {
         e.printStackTrace();
      }
      FileList.add(sysFilename);
      }
      return FileList;
      
      
      
      
      
   }
   
   
}