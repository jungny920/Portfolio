package com.simpf.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class CategoryVO {
	/*
	  	카테고리 테이블 : MALL_CATEGORY
	  	
		CG_CODE         VARCHAR2(20)    PRIMARY KEY,
	    CG_PARENT_CODE  VARCHAR2(20),
	    CG_NAME         VARCHAR2(50)    NOT NULL 
	 */
	
	private String cg_code;
	private String cg_parent_code;
	private String cg_name;
	
}
