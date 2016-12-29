package com.nhnentertainment.freeboard.service;

import static org.junit.Assert.assertEquals;

import java.text.SimpleDateFormat;
import java.util.Date;

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
@ContextConfiguration(locations = "classpate:/spring/*.xml")
public class BoardServiceTest {
	
	@Autowired
	BoardDao boardDao;

	@Test
	public void testWrite() {
		Board board = new Board();
		BoardService boardService = new BoardService();
		long time = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String str = dayTime.format(new Date(time));
		
		board.setBno(1);
		board.setBemail("user1@naver.com");
		board.setBcontent("content1");
		board.setBpassword("12345");
		board.setBwritetime(str);
		board.setBmodifytime(str);
		
		assertEquals("success", boardService.write(board));
	}
/*
	@Test
	public void testList() {
		fail("Not yet implemented");
	}

	@Test
	public void testInfo() {
		fail("Not yet implemented");
	}

	@Test
	public void testModify() {
		fail("Not yet implemented");
	}
*/
}
