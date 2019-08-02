package com.kh.home.entity;

import com.kh.home.entity.MemberDto.MemberDtoBuilder;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class BoardDto {
	private int no, read, parent, depth, team;
	private String head, title, writer, content, when;

}
