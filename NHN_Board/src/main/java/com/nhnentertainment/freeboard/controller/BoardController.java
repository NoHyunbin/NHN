package com.nhnentertainment.freeboard.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
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
}
