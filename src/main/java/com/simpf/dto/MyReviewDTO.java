package com.simpf.dto;

import java.util.Date;

import lombok.Data;

@Data
public class MyReviewDTO {
	
	//a.rv_num, p.pd_code, p.pd_name, p.pd_image, a.rv_cnt, a.rv_image, a.rv_score, a.rv_date
	
	private long rv_num;
	private long pd_code;
	private String pd_name;
	private String pd_image;
	private String rv_cnt;
	private String rv_image;
	private int rv_score;
	private Date rv_date;
	
}
