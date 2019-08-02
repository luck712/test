package com.kh.home.repository;

import java.util.List;

import com.kh.home.entity.MemberDto;

public interface MemberDao {
	boolean regist(MemberDto memberDto);

	MemberDto login(MemberDto memberDto);

	MemberDto get(String email);

	void delete(String email);

	void chage(MemberDto memberDto);

	List<MemberDto> search(String type, String keyword);

	void edit(MemberDto memberDto);




}
