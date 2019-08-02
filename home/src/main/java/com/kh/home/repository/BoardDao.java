package com.kh.home.repository;

import java.util.List;

import com.kh.home.entity.BoardDto;

public interface BoardDao {

	List<BoardDto> list();
	
	List<BoardDto> list(String type, String keyword);
	
	List<BoardDto> list(String type, String keyword, int i, int j);

	int count(String type, String keyword);

	BoardDto get(int no);

	void read(int no);

	int getSequenceNumber();

	void insert(BoardDto boardDto);

	void delete(int no);

	void edit(BoardDto boardDto);







}
