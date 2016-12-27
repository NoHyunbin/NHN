package com.nhnentertainment.freeboard.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.nhnentertainment.freeboard.dto.Board;

@Component
public class BoardDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardDao.class);
	
	// 방명록 쓰기
	public int insert(Board board) {
		logger.info("insert 실행");
		String sql = "insert into board(bemail, bpassword, bcontent) values(?, ?, ?)";
		int row = jdbcTemplate.update(
				sql,
				board.getBemail(),
				board.getBpassword(),
				board.getBcontent()
		);
		
		return row;
	}

	// 메일을 키워드로 글 검색
	public List<Board> selectBySearch(String search) {
		logger.info("selectBySearch 실행");
		String sql = "select bno, bemail, bpassword, bcontent, bwritetime, bmodifytime from board where bemail like ? order by bno desc";
		
		List<Board> list = jdbcTemplate.query(
				sql,
				new Object[]{"%"+search+"%"},
				new RowMapper<Board>() {
					@Override
					public Board mapRow(ResultSet rs, int row) throws SQLException {
						Board board = new Board();
						board.setBno(rs.getInt("bno"));
						board.setBemail(rs.getString("bemail"));
						board.setBpassword(rs.getString("bpassword"));
						board.setBcontent(rs.getString("bcontent"));
						board.setBwritetime(rs.getString("bwritetime"));
						board.setBmodifytime(rs.getString("bmodifytime"));
						return board;
					}					
				}
			);
		return list;
	}

	// 게시글 상세 조회
	public Board selectByBno(int bno) {
		String sql = "select bno, bemail, bpassword, bcontent, bwritetime, bmodifytime from board where bno=?";
		
		List<Board> list = jdbcTemplate.query(sql, new Object[] {bno}, new RowMapper<Board>() {
			@Override
			public Board mapRow(ResultSet rs, int row) throws SQLException {
				Board board = new Board();
				board.setBno(rs.getInt("bno"));
				board.setBemail(rs.getString("bemail"));
				board.setBpassword(rs.getString("bpassword"));
				board.setBcontent(rs.getString("bcontent"));
				board.setBwritetime(rs.getString("bwritetime"));
				board.setBmodifytime(rs.getString("bmodifytime"));
				return board;
			}
		});
		return (list.size() != 0)?list.get(0) : null;
	}

	// 방명록 수정
	public int update(Board board) {
		String sql = "update board set bcontent=?, bmodifytime=now() where bno=?";
		int row = jdbcTemplate.update(
				sql,
				board.getBcontent(),
				board.getBno()
		);
		return row;
	}

}
