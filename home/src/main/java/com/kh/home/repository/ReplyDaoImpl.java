package com.kh.home.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.home.entity.ReplyDto;

@Repository
public class ReplyDaoImpl implements ReplyDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void regist(ReplyDto replyDto) {
		sqlSession.insert("reply.insert",replyDto);
	}

	@Override
	public List<ReplyDto> list(int no) {
		
		return sqlSession.selectList("reply.list", no);
	}
}
