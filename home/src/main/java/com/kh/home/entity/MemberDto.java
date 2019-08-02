package com.kh.home.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class MemberDto {
	private int no;
	private String email, pw, name, birth, phone, question, answer, regist, auth, recent;
}
