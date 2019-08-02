package com.kh.home.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.home.entity.MemberDto;

@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public boolean regist(MemberDto memberDto) {
		try {
			sqlSession.insert("member.regist", memberDto);
		return true;
	}
	catch(Exception e) {
		
		return false;
	}
}

	@Override
	public MemberDto login(MemberDto memberDto) {
		MemberDto result= sqlSession.selectOne("member.login", memberDto);
			return result;
	}

	@Override
	public MemberDto get(String email) {
		return sqlSession.selectOne("member.info", email);
	}

	@Override
	public void delete(String email) {  //void는 return할 필요 없음
		sqlSession.delete("member.delete", email);
	}

	@Override
	public void chage(MemberDto memberDto) {
		sqlSession.update("member.change", memberDto);
	}

	@Override
	public List<MemberDto> search(String type, String keyword) {
		Map<String, String> param = new HashMap<>();
		param.put("type", type);
		param.put("keyword", keyword);
		return sqlSession.selectList("member.search", param);
	}

	@Override
	public void edit(MemberDto memberDto) {
		sqlSession.update("member.edit", memberDto);
	}

	
}
