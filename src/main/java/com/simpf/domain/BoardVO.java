package com.simpf.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class BoardVO {
	/*
	  	BOARD_NUM   NUMBER          PRIMARY KEY,
	    UI_ID       VARCHAR2(20)    NOT NULL,
	    PD_CODE     NUMBER          NOT NULL,
	    BOARD_CG    VARCHAR(50)     NOT NULL,
	    BOARD_TITLE VARCHAR(100)    NOT NULL,
	    BOARD_CNT   VARCHAR(500)    NOT NULL,
	    BOARD_AST   VARCHAR(20)     DEFAULT '미답변' NOT NULL,
	    BOARD_DATE  DATE            DEFAULT SYSDATE NOT NULL
	    
	    ui_id, pd_code, board_num, board_cg, board_title, board_cnt, board_ast, board_date
	 */

	private long board_num;
	private String ui_id;
	private long pd_code;
	private String board_cg;
	private String board_title;
	private String board_cnt;
	private String board_ast;
	private Date board_date;
}
