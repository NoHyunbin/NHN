package com.nhnentertainment.freeboard.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.nhnentertainment.freeboard.dao.BoardDao;
import com.nhnentertainment.freeboard.dto.Board;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations="file:src/main/webapp/WEB-INF/spring/servlet-context.xml")
public class BoardServiceTest {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	BoardDao boardDao;

	@Test
	public void testWrite() {
		// ------------ 글 쓰기 내용 부분 ------------ //
		Board board = new Board();		
		board.setBemail("JUnit_Test2@naver.com");
		board.setBpassword("12345");
		board.setBcontent("boardService.write Test2");
		// ------------ 글 쓰기 내용 부분 ------------ //
		
		// 글쓰기 작업을 완료하면 성공
		assertEquals("success", boardService.write(board));
	}

	@Test
	public void testList() {
		// 글이 있으면 성공 
		assertNotNull(boardService.list(""));
	}

	@Test
	public void testInfo() {
		// 괄호안의 숫자(게시글 번호)에 해당하는 글이 있으면 성공
		assertNotNull(boardService.info(1));
	}

	@Test
	public void testModify() {
		// ------------ 글 수정 내용 부분 ------------ //
		Board board = new Board();		
		board.setBno(5); // 수정하고자 하는 게시글 번호
		board.setBcontent("JUnit boardService.modify Test2"); // 수정할 내용
		// ------------ 글 수정 내용 부분 ------------ //
		
		// 수정 작업을 완료하면 성공
		assertEquals("success", boardService.modify(board));
	}

}
