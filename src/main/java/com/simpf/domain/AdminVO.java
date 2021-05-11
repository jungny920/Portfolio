package com.simpf.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class AdminVO {
	/*
		ADMIN_ID        VARCHAR2(20)    PRIMARY KEY,
	    ADMIN_PW        VARCHAR2(16)    NOT NULL,
	    ADMIN_NAME      VARCHAR2(20)    NOT NULL,
	    ADMIN_DATE      DATE            DEFAULT SYSDATE
	 */
	
	private String admin_id;
	private String admin_pw;
	private String admin_name;
	private Date admin_date;
}
