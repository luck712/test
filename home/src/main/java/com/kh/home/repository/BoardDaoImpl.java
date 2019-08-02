package com.kh.home.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.home.entity.BoardDto;

@Repository
public class BoardDaoImpl implements BoardDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<BoardDto> list() {
		return sqlSession.selectList("board.list");
	}
	
	@Override
	public List<BoardDto> list(String type, String keyword) {
		Map<String, String> param = new HashMap<>();
		

		if(type !=null && keyword != null) {
		param.put("type", type.replace("+", "||")); // 더하기가 오라클에서 작동이 안되기 때문에 더하기를 ||로 바꿈
		param.put("keyword", keyword);
		}
		return sqlSession.selectList("board.list3", param);
	}

	@Override
	public List<BoardDto> list(String type, String keyword, int i, int j) {
		Map<String, Object> param = new HashMap<>();
		
		//검색일 때 검색어를 mybatis에 전달
		if(type != null && keyword != null) {
			param.put("type", type.replace("+", "||"));
			param.put("keyword", keyword);
		}
		
		//검색이든 목록이든 페이징 구간을 전달
		param.put("start", i);
		param.put("end", j);
				
		return sqlSession.selectList("board.list4", param);
	}

	@Override
	public int count(String type, String keyword) {
		Map<String, String> param = new HashMap<>();
		if(type != null && keyword != null) {
			param.put("type", type.replace("+", "||"));
			param.put("keyword", keyword);
		}
		return sqlSession.selectOne("board.count", param);
	}

	@Override
	public BoardDto get(int no) {
		return sqlSession.selectOne("board.get", no);
	}

	@Override
	public void read(int no) {
		sqlSession.update("board.read", no);
	}

	@Override
	public int getSequenceNumber() {
		return sqlSession.selectOne("board.seq");
	}

	@Override
	public void insert(BoardDto boardDto) {
		sqlSession.insert("board.insert", boardDto);
	}

	@Override
	public void delete(int no) {
		sqlSession.delete("board.delete",no);
	}

	@Override
	public void edit(BoardDto boardDto) {
		sqlSession.update("board.edit", boardDto);
	}

	



}
