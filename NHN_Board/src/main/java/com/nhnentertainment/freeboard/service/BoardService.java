package com.nhnentertainment.freeboard.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.nhnentertainment.freeboard.dao.BoardDao;
import com.nhnentertainment.freeboard.dto.Board;

@Component
public class BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardService.class);
	
	public String write(Board board) {
		logger.info("write 실행");
		boardDao.insert(board);		
		return "success";
	}
	
	public List<Board> list(String Search) {
		logger.info("list 실행");
		return boardDao.selectBySearch(Search);
	}
	
	public Board info(int bno) {
		logger.info("info 실행");
		return boardDao.selectByBno(bno);
	}
	
	public String modify(Board board) {
		logger.info("modify 실행");
		int row = boardDao.update(board);
		if ( row != 1 ) return "fail";		
		return "success";
	}
/*	
	public String delete(int bno) {
		logger.info("delete 실행");
		String result = "success";
		
		return result;
	}
*/
}
