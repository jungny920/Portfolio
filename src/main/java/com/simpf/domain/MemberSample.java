package com.simpf.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberSample {
	/*
		UI_ID           VARCHAR2(20)    PRIMARY KEY,
	    UI_NAME         VARCHAR2(30)    NOT NULL,
	    UI_PW           VARCHAR2(20)    NOT NULL,
	    UI_PHONE        VARCHAR2(15)    NOT NULL,
	    UI_EMAIL        VARCHAR2(50)    NOT NULL,
	    UI_EVENT_SMS    CHAR(1)         NOT NULL, (Y / N)
	    
		UI_ZCODE        CHAR(5)         NOT NULL,
	    UI_ADDR         VARCHAR2(100)   NOT NULL,
	    UI_ADDR_D       VARCHAR2(200)   NOT NULL,
	    
	    UI_POINT        NUMBER          DEFAULT 0           NOT NULL,
	    UI_GRADE        VARCHAR2(15)    DEFAULT 'NORMAL'  	NOT NULL,
	    UI_REG_DATE 	DATE            DEFAULT SYSDATE     NOT NULL,
	    UI_UPDATE_DATE  DATE            DEFAULT SYSDATE     NOT NULL
	*/
	
	private String user_id;
	private String user_name;
	private String user_pw;
	private String user_phone;
	private String user_email;
	
	private String user_event_sms;
	private String user_zcode;
	private String user_addr;
	private String user_addr_d;
	private int user_point;
	
	private String user_grade;
	private Date user_reg_date;
	private Date user_update_date;
	
}
