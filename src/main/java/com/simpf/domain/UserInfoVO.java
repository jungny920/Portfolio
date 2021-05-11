package com.simpf.domain;

import java.util.Date;

import lombok.Data;

@Data
public class UserInfoVO {
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
	
	private String ui_id;
	private String ui_name;
	private String ui_pw;
	private String ui_phone;
	private String ui_email;
	
	private String ui_event_sms;
	private String ui_zcode;
	private String ui_addr;
	private String ui_addr_d;
	private int ui_point;
	
	private String ui_grade;
	private Date ui_reg_date;
	private Date ui_update_date;
	
}
