package com.hntrip.root.board.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;


public interface BoardService {
   public void searchByCountry(String word,Model model); 
   public void searchByCity(String word, Model model);
   public void searchByTitle(String word, Model model);
   public void getMyData(Model model, int writeNo);
   public int upHit(int writeNo);
   public int downHit(int writeNo);
   public void registerSave(MultipartHttpServletRequest mul,
         HttpServletRequest request);
   
   public void getMember(String id, Model model);
}