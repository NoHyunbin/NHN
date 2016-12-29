package com.nhnentertainment.freeboard.dto;

import static org.junit.Assert.*;

import org.junit.Test;

public class BoardTest {

	@Test
	public void testGetBno() {
		Board board = new Board();
		board.setBno(0);
		assertEquals(0, board.getBno());
	}

}
