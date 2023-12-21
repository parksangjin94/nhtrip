package com.hntrip.root.board.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hntrip.root.board.dto.BoardDTO;
import com.hntrip.root.board.mapper.BoardMapper;
import com.hntrip.root.file.dto.FileDTO;
import com.hntrip.root.file.mapper.FileMapper;
import com.hntrip.root.file.service.FileService;

@Service
public class BoardServiceImpl implements BoardService{
   @Autowired BoardMapper bm;
   @Autowired FileService fs;
   @Autowired FileMapper fm;
   
   public void getMyData(Model model, int writeNo) {
      model.addAttribute("myData", bm.getMyData(writeNo));
   }
   public int upHit(int writeNo) {
      bm.upHit(writeNo);
      //System.out.println("hit : "+ bm.nowHit(writeNo).getHit());
      return bm.nowHit(writeNo).getHit();
   }
   public int downHit(int writeNo) {
      bm.downHit(writeNo);
      return bm.nowHit(writeNo).getHit();
   }      
   public void searchByCountry(String word, Model model) {      
      try {
         model.addAttribute("filelist", fs.searchWriteNo(bm.searchByCountry(word)));      
      } catch (Exception e) {
         e.printStackTrace();
      }      
   }
   public void searchByCity(String word, Model model) {
      try {
         model.addAttribute("filelist", fs.searchWriteNo(bm.searchByCity(word)));   
         
      } catch (Exception e) {
         e.printStackTrace();
      }
   }
   public void searchByTitle(String word, Model model) {
      try {
         model.addAttribute("filelist", fs.searchWriteNo(bm.searchByTitle(word)));   

      } catch (Exception e) {
         e.printStackTrace();
      }
   }
   @Override
   public void registerSave(MultipartHttpServletRequest mul, HttpServletRequest request) {
      BoardDTO board = new BoardDTO();
      board.setId(mul.getParameter("id"));
      board.setTitle(mul.getParameter("title"));
      board.setContent(mul.getParameter("content"));
      board.setCountry(mul.getParameter("country"));
      board.setCity(mul.getParameter("city"));
      board.setSaveDate(mul.getParameter("saveDate"));
      bm.insert(board);
      int writeNo = bm.getwriteNo(mul.getParameter("id"));
      List<MultipartFile> fileList = mul.getFiles("file_name"); //선택한 파일들의 정보를 fileList에 저장한다 다수의 파일이기 때문에 List형태로 저장한다
      List<FileDTO> file= new ArrayList<FileDTO>();
      if(fileList.size()!=0) {
         for(String mf : fs.saveFile(fileList)) {
            FileDTO dto = new FileDTO();
            dto.setFileName(mf);
            dto.setWriteNo(writeNo);
            file.add(dto);
         }
         /*
         for(int i=0; i<fs.saveFile(fileList).size(); i++) {
            dto.setFileName(fs.saveFile(fileList).get(i));
         }
         */
      }
      
      /*
      for(MultipartFile mf : fileList) {
         FileDTO dto = new FileDTO();
         dto.setFileName(mf.getOriginalFilename());
         dto.setWriteNo(writeNo);
         file.add(dto);
      }
      */
      fm.insert(file);
      
   }
   public void getMember(String id, Model model) {
         
         model.addAttribute("info", bm.getMember(id));
         model.addAttribute("country",bm.getCountry(id));
         //System.out.println("id : " + id);
         //List<BoardDTO> list = bm.getMember(id);
         //System.out.println(list.size());
      }
}