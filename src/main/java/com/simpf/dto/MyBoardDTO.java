package com.simpf.dto;

import java.util.Date;

import lombok.Data;

@Data
public class MyBoardDTO {
	// a.board_num, a.ui_id, a.pd_code, p.pd_name, a.board_cg, a.board_title, a.board_cnt, a.board_ast, a.board_date
	
	private long board_num;
	private String ui_id;
	private long pd_code;
	private String pd_name;
	private String board_cg;
	private String board_title;
	private String board_cnt;
	private String board_ast;
	private Date board_date;
}
