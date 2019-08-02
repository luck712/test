package com.kh.home.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.home.entity.BoardDto;
import com.kh.home.entity.ReplyDto;
import com.kh.home.repository.BoardDao;
import com.kh.home.repository.ReplyDao;
import com.kh.home.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private BoardService boardService;
	//목표 : 게시판 목록을 화면에 출력하도록 전달
//	@GetMapping("/list")
//	public String list(Model model) {
//		List<BoardDto> list = boardDao.list();
//		model.addAttribute("list", list);
//		return "board/list";
//	}
	//[2] 검색과 결합
	@GetMapping("/list")
	public String list(Model model,
			@RequestParam(required = false) String type,
			@RequestParam(required = false) String keyword,
			@RequestParam(required = false, defaultValue = "1") int page
			) {
		
//		page를 이용하여 시작번호(start) 와 종료번호(end)를 구한다 - 게시글 분할이 완료
//		start = pagesize * page -(pagesize -1)
//		end = pagesize * page
		int pagesize = 10;
		int start = pagesize * page - (pagesize - 1);
		int end = pagesize * page;
		
//		page를 이용하여 시작블록과 종료블록을 구한다 - 네비게이터 완료
//		 - 이 값들은 페이지에서 사용하므로 전달해줘야 한다.
//		startBlock = (page - 1) / blocksize * blocksize + 1
//		endBlock = startBlock + (blocksize -1)
		int blocksize = 10;
		int startBlock = (page - 1) / blocksize * blocksize +1;
		int endBlock = startBlock + (blocksize - 1);
		
//		endBlock을 전체 게시글 수를 이용하여 조정
		int count = boardDao.count(type, keyword);
		int pageCount = (count -1) / pagesize +1;
		if(endBlock > pageCount) {
			endBlock = pageCount;
		}
		model.addAttribute("page", page);
		model.addAttribute("startBlock", startBlock);
		model.addAttribute("endBlock", endBlock);
		
		List<BoardDto> list = boardDao.list(type, keyword, start, end);
		model.addAttribute("list", list);
		return "board/list";
	}
	
	//목표 : 게시글 번호를 받아서 정보를 구한 뒤 출력 페이지에 전달
	@GetMapping("/content")
	public String content(HttpSession session, Model model, @RequestParam int no) {
		//조회수 중복 방지 처리
		@SuppressWarnings("unchecked")
		Set<Integer> set= (Set<Integer>) session.getAttribute("read");
		if(set == null)
			set = new HashSet<>();
		
		boolean first = set.add(no); //true:처음 읾음, false : 두번 이상
		
		session.setAttribute("read", set);
		//조회수 중복 방지 처리
		
		if(first) 
			model.addAttribute("bdto", boardService.read(no));
		else 
			model.addAttribute("bdto", boardDao.get(no));
		
		// 댓글 가져오는 기능
		List<ReplyDto> list = replyDao.list(no);
		model.addAttribute("list", list);
		return "board/content";
	}
	
//	목표 : 글쓰기 입력창을 출력하는 것
	@GetMapping("/write")
	public String write() {
		return "board/write";
	}
	
//	목표 : 글쓰기 등록 처리
//	준비 : (새글)title, content, head (답글) title, content, head, parent
//추가 : 작성자를 추가해야함(세선)
	@PostMapping("/write")
	public String write(HttpSession session, @ModelAttribute BoardDto boardDto, Model model) {
		String email = (String)session.getAttribute("ok");
		boardDto.setWriter(email);
		
		int no = boardService.write(boardDto);
		
		model.addAttribute("no", no);
		return "board/content";
	}
	
	//목표 : 번호를 받아 해당 게시글을 삭제한 후 목록으로 이동
	@GetMapping("/delete")
	public String delete(@RequestParam int no) {
		boardDao.delete(no);
		return "redirect:list";
	}
	
	//목표 : 번호를 받아서 글 정보를 불러온 뒤 화면에 전달
	@GetMapping("/edit")
	public String edit(@RequestParam int no, Model model) {
		model.addAttribute("bdto", boardDao.get(no));
		return "board/edit";
	}
	
	//목표 : 수정된 정보를 받아서 변경 처리 후 상세보기로 이동
	// - Redirect 할 떄에는 Model보다는 Model을 확장한 RedirectAttributes 클래스를 사용
	// - RedirectAttributes를 사용하면 post방식의 첨부가 가능
	@PostMapping("/edit")
	public String edit(@ModelAttribute BoardDto boardDto, RedirectAttributes model) {
		boardDao.edit(boardDto);
		model.addAttribute("no", boardDto.getNo());
		return "redirect:content";
	}
	
	@Autowired
	private ReplyDao replyDao;
	//댓글 등록
	@PostMapping("/comments")
	public String reply(@ModelAttribute ReplyDto replyDto, Model model, HttpSession session) {
		String writer = (String)session.getAttribute("ok");
		replyDto.setWriter(writer);
		replyDao.regist(replyDto);
		model.addAttribute("no",	replyDto.getOrigin());
		return "redirect:content";
	}
}