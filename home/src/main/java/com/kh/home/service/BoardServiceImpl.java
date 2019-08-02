package com.kh.home.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.home.entity.BoardDto;
import com.kh.home.repository.BoardDao;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardDao boardDao;
	
	@Override
	//이 표시가 붙은 메소드는 모든 작업이 하나의 트랜잭션이 됨
	//사용하려면 sprin-tx 모듈을 추가한 뒤<tx:annotation-driven/>태그로 활성화
	//transactionManager라는 bean을 등록해야 사용 가능
//	 - 설정 파일 위치는 무관
	@Transactional
	public BoardDto read(int no) {
		boardDao.read(no);
		return boardDao.get(no);
	}

//	목표 : 글등록(단, 새글과 답글을 구분하여 등록) - parent 유무
//	- 새글은 parent가 0
//	- 답글은 parent가 0이 아님
//	결과 : 등록된 글의 번호

//	[1]번호를 구한다(no)
//	[2]  (답글일 경우) team번호를 구해와야한다.(no)
//		  (새글일 경우) team번호는 게시글 번호와 같다.(no)
//	[3]등록 처리를 수행한다
	
	
	@Override
	@Transactional
	public int write(BoardDto boardDto) {
		int no = boardDao.getSequenceNumber();
		boardDto.setNo(no);
		if(boardDto.getParent()==0) { //새글일 때는
			boardDto.setTeam(no);
		}
		else {//답글일 때는
			BoardDto find = boardDao.get(boardDto.getParent());
			int team = find.getTeam();
			int depth = find.getDepth();
			boardDto.setTeam(team);
			boardDto.setDepth(depth+1);
		}
		boardDao.insert(boardDto);
		return no;
	}

}
