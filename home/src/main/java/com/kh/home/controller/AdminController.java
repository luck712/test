package com.kh.home.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.home.entity.MemberDto;
import com.kh.home.repository.MemberDao;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private MemberDao memberDao;

	
	//회원 검색 기능
	
	//목표 : 회원 검색어를 받아서 검색한 뒤 목록을 전달
	//파라미터 : type, keyword
	@GetMapping("/search")
	public String search(
			@RequestParam(required = false) String type,
			@RequestParam(required = false) String keyword,
			Model model) {
		if(type != null && keyword != null) {
		List<MemberDto> list = memberDao.search(type, keyword);
		model.addAttribute("list", list);
		}
		return "admin/search";
	}
	//상세 정보 보기
	// 이메일을 이용하여 회원정보를 불러온뒤 뷰로 전달(model)
	@GetMapping("/info")
	public String info(Model model, @RequestParam String email) {
		MemberDto memberDto = memberDao.get(email);
		model.addAttribute("mdto", memberDto);
		return "admin/info";
	}
	//회원 탈퇴
	//이메일을 이용하여 회원 삭제 후 search로 이동(redirect)
	@GetMapping("/delete")
	public String delete(
			@RequestParam String email,
			//검색 상태를 유지하기 위한 파라미터
			@RequestParam String type,
			@RequestParam String keyword,
			Model model
			) {
		memberDao.delete(email);
//		return "redirect:search?type="+type+"&keyword="+keyword;
		
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		return "redirect:search";
	}
	
	//회원 정보 수정
	@GetMapping("/edit")
	public String edit(
			@RequestParam String email, Model model
			) {
		MemberDto memberDto = memberDao.get(email);
		model.addAttribute("mdto", memberDto);
		return "admin/edit";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute MemberDto memberDto, Model model) {
		memberDao.edit(memberDto);
//		return "redirect:info?email="+memberDto.getEmail();
		model.addAttribute("email", memberDto.getEmail());
		return "redirect:info";
		
	}
}
