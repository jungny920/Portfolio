package com.simpf.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ReviewVO {
	/*
		RV_NUM      NUMBER          PRIMARY KEY,
		UI_ID       VARCHAR2(20)    NOT NULL,
		PD_CODE     NUMBER          NOT NULL,
		RV_CNT      VARCHAR2(100)   NOT NULL,
		RV_IMAGE    VARCHAR2(60),
		RV_SCORE    NUMBER          NOT NULL,
		RV_DATE     DATE            DEFAULT SYSDATE NOT NULL
		
		rv_num, ui_id, pd_code, rv_cnt, rv_image, rv_score, rv_date
     */
	
	private long rv_num;
	private String ui_id;
	private long pd_code;
	private String rv_cnt;
	private String rv_image;
	private int rv_score;
	private Date rv_date;
	
	private MultipartFile file1;
}
