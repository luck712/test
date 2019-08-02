package com.kh.home.entity;

import com.kh.home.entity.BoardDto.BoardDtoBuilder;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ReplyDto {
	private int no, origin;
	private String writer, content, when;

}
