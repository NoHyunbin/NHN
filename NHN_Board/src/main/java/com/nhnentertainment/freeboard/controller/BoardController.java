package com.nhnentertainment.freeboard.controller;

import java.util.List;
import java.util.regex.Pattern;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.nhnentertainment.freeboard.dto.Board;
import com.nhnentertainment.freeboard.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	// 방명록 보기(main)
	@RequestMapping("/list")
	public String list(@RequestParam(required=false, defaultValue="") String search, Model model) {
		logger.info("list 실행");
		List<Board> list = boardService.list(search);
		model.addAttribute("list", list);
		return "home";
	}
	
	// 글쓰기
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String write(Board board, Model model) {
		logger.info("write() POST 실행");
		String result = "success";
		try {			
			String bemailPattern = "\\w+@\\w+[.]\\w+";
			boolean bemailPatternCheck = Pattern.matches(bemailPattern, board.getBemail());
			
			if ( !bemailPatternCheck ) {
				logger.info("이메일 형식오류");
				result = "Email Pattern Error";
			} else {
				logger.info("글쓰기 성공");
				boardService.write(board);				
			}
		} catch (Exception e) {
			result = "fail";
		}

		model.addAttribute("result", result);
		return "result";
	}
	
	// 수정
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modify(Board board, Model model) {
		logger.info("modify() POST 실행");
		String result = "success";
		String oldPw = boardService.info(board.getBno()).getBpassword();
		
		if( !oldPw.equals(board.getBpassword()) ) {
			result = "password error";
		} else {
			try {
				boardService.modify(board);
			} catch (Exception e) {
				result = "fail";
			}
		}

		model.addAttribute("result", result);
		return "result";
	}
}
