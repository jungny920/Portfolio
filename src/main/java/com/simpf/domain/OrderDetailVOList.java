package com.simpf.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class OrderDetailVOList {
	/*
	  	UI_ID       VARCHAR2(20)    NOT NULL,
	    ORD_CODE    NUMBER          NOT NULL,
	    PD_CODE     NUMBER          NOT NULL,
	    ORD_PRICE   NUMBER          NOT NULL,
	    ORD_AMOUNT  NUMBER          NOT NULL
	 */
	
	private String ui_id;
	private long ord_code;
	private long pd_code;
	private long ord_price;
	private int ord_amount;
	
	private String pd_name;
	private String pd_image;
	private String pd_company;
}
