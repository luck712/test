package com.kh.home.repository;

import java.util.List;

import com.kh.home.entity.ReplyDto;

public interface ReplyDao {

	void regist(ReplyDto replyDto);

	List<ReplyDto> list(int no);


}
