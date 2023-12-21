package com.hntrip.root.board.mapper;

import java.util.List;

import com.hntrip.root.board.dto.BoardDTO;


public interface BoardMapper {
   public List<BoardDTO> searchByCountry(String word);
   public List<BoardDTO> searchByCity(String word);
   public List<BoardDTO> searchByTitle(String word);
   public BoardDTO getMyData(int writeNo);
   public void upHit(int writeNo);
   public void downHit(int writeNo);
   public BoardDTO nowHit(int writeNo);
   public void insert(BoardDTO board);
   public int getwriteNo(String id);
   public List<BoardDTO> getMember(String id);
   public List<BoardDTO> getCountry(String id);
   
}