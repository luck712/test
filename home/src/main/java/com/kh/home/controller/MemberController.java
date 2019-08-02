package com.kh.home.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.home.entity.MemberDto;
import com.kh.home.repository.MemberDao;

@Controller
@RequestMapping("/member")
public class MemberController {

	@GetMapping("/regist")
	public String regist() {
		return "member/regist";
	}
	
	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private MemberDao memberDao;
	
	@PostMapping("/regist")
	public String regist(@ModelAttribute MemberDto memberDto) { //entity에 있는 Dto 가져오는거
		boolean result = memberDao.regist(memberDto);
		if(result)
			return "member/regist_result";
		else
			return "member/regist_fail";
	}
	
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto memberDto, 
									@RequestParam(required = false) String remember,
									HttpSession session,
									HttpServletResponse response) {
		MemberDto result = memberDao.login(memberDto);
		if(result !=null) {
			session.setAttribute("ok", result.getEmail());
			session.setAttribute("auth", result.getAuth());
			
			//쿠키객체를 만들고 체크여부에 따라 시간 설정 후 response에 추가
			Cookie c = new Cookie("saveId", memberDto.getEmail());
			if(remember == null) //체크 안했을때
				c.setMaxAge(0);
			else //체크 했을때
				c.setMaxAge(4 * 7* 24 * 60 * 60); // 4주
			response.addCookie(c);
			
			return "redirect:/";
		}
		else {
			return "member/login_fail";
		}
	}
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("ok");
		session.removeAttribute("auth");
		return "redirect:/";
	}
	//내정보 보기 기능
	@GetMapping("/info")
	public String info(Model model, HttpSession session) {
		String email = (String) session.getAttribute("ok");
		model.addAttribute("mdto", memberDao.get(email));
		return "member/info";
	}
	//회원 탈퇴 기능 = DB에서 데이터 삭제 + 세션 정보 초기화(로그아웃)
	//필요한 객체 - 세션 -> 이메일 -> 삭제 -> 로그아웃
	@GetMapping("/delete")
	public String delete( HttpSession session) {
		String email = (String) session.getAttribute("ok");
		memberDao.delete(email);
		session.removeAttribute("ok");
		session.removeAttribute("auth");
		return "member/goodbye";
	}
	//회원 정보 수정 기능
	//요청 -> 수정입력 -> 수정처리 -> 내정보(입력이 있는 경우는get, post 두개로 나눠서 함)
	@GetMapping("/change")
	public String change(HttpSession session, Model model) {
		String email = (String)session.getAttribute("ok");
		MemberDto memberDto = memberDao.get(email);
		model.addAttribute("mdto", memberDto);
		return "member/change_info";
	}
	@PostMapping("/change")
	public String change(@ModelAttribute MemberDto memberDto) {
		memberDao.chage(memberDto);
		return "redirect:info";
	}
}
