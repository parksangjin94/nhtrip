package com.hntrip.root.board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hntrip.root.board.service.BoardService;
import com.hntrip.root.common.session.MemberSessionName;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hntrip.root.file.service.FileService;
import com.hntrip.root.follow.service.FollowService;
import com.hntrip.root.hit.service.HitService;

@Controller
@RequestMapping("board")

public class BoardController implements MemberSessionName {
   @Autowired BoardService bs;
   @Autowired FileService fs;
   @Autowired HitService hs;
   @Autowired FollowService fws;
   
   @GetMapping("test")
   public String test() {
      return "board/test";
   }

   @GetMapping("testregister")
   public String testregister() {
      return "board/testregister";
   }
   
   @GetMapping("main")
   public String main(String id, Model model ) {
       bs.getMember(id, model);
      return "board/main";
   }
   
   @GetMapping("register")
   public String register() {
      return "/board/register";
   }
   
   @PostMapping("registerSave")
   public String registerSave(MultipartHttpServletRequest mul,
         HttpServletRequest request) {
      bs.registerSave(mul, request);
      
      return "redirect:/board/main?id="+mul.getParameter("id");
   }
   @GetMapping("mypage")
   public String mypage(Model model, @RequestParam int writeNo, HttpSession session) {
      bs.getMyData(model, writeNo);
      fs.getMyImg(model, writeNo);
      hs.getMyHit(model, writeNo, session);
      fws.getMyFollow(model, writeNo, session);
      return "board/mypage";
   }
   @GetMapping("upHit")
   @ResponseBody
   public String upHit(@RequestParam int writeNo,HttpSession session) {
      System.out.println("Hit");
      hs.addMyHit(writeNo,(String)session.getAttribute(MemberSessionName.LOGIN));
      return bs.upHit(writeNo)+"";
   }
   @GetMapping("downHit")
   @ResponseBody
   public String downHit(@RequestParam int writeNo,HttpSession session) {
      System.out.println("downHit");
      hs.delMyHit(writeNo,(String)session.getAttribute(MemberSessionName.LOGIN));
      return bs.downHit(writeNo)+"";

   }
   @PostMapping("/search")
   public String search(@RequestParam String key, @RequestParam String word, Model model
//         @RequestParam(required = false, defaultValue= "1") int num
         ) {
      if(word!=null) {
         if(key.equals("country")) {
            bs.searchByCountry(word, model);
         }
         else if(key.equals("city")) {
            bs.searchByCity(word, model);
         }
         else if(key.equals("title")) {
            bs.searchByTitle(word, model);
         }
         return "board/search";
      }else {
         return "redirect:/index";
      }
   }
}