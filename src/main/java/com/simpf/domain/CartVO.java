package com.simpf.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@AllArgsConstructor
public class CartVO {
	/*
	  	SC_CODE     NUMBER          PRIMARY KEY,
	    UI_ID       VARCHAR2(20)    NOT NULL,
	    PD_CODE     NUMBER     	    NOT NULL,
	    SC_AMOUNT   NUMBER          NOT NULL
	 */
	
	private long sc_code;
	private String ui_id;
	private long pd_code;
	private int sc_amount;
	
	
}
