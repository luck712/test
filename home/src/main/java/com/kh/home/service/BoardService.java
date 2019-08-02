package com.kh.home.service;

import com.kh.home.entity.BoardDto;

public interface BoardService {
	BoardDto read(int no);

	int write(BoardDto boardDto);
}
