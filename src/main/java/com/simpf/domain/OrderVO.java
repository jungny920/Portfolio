package com.simpf.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class OrderVO {
	/*
	  	ORD_CODE        NUMBER          PRIMARY KEY,
	  	UI_ID           VARCHAR2(20)    NOT NULL,
	  --PD_CODE         NUMBER          NOT NULL,
	    ORD_NAME        VARCHAR(30)     NOT NULL,
	    ORD_PHONE       VARCHAR(15)     NOT NULL,
		ORD_ZCODE       CHAR(5)         NOT NULL,
	    ORD_ADDR        VARCHAR2(100)   NOT NULL,
	    ORD_ADDR_D      VARCHAR2(200)   NOT NULL,
    	ORD_TOTAL_PRICE NUMBER          NOT NULL,
	    ORD_DATE        DATE            DEFAULT SYSDATE NOT NULL
	 */
	
	private long ord_code;
	private String ui_id;
	//private long pd_code;
	private String ord_name;
	private String ord_phone;
	private String ord_zcode;
	private String ord_addr;
	private String ord_addr_d;
	private int ord_total_price;
	private Date ord_date;
	
}
