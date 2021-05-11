package com.simpf.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ProductVO {
	/*
	 	상품 테이블 : MALL_PRODUCT
	 	
		PD_CODE     	NUMBER          PRIMARY KEY,    
	    CG_CODE     	VARCHAR2(20)    NOT NULL,
	    CG_PARENT_CODE  VARCHAR2(20)    NOT NULL,
	    PD_NAME     	VARCHAR2(100)   NOT NULL,
	    PD_PRICE    	NUMBER          NOT NULL,		// 가격
	    PD_DISCOUNT 	NUMBER          DEFAULT 0       NOT NULL,	// 할인금액
	    PD_COMPANY  	VARCHAR2(50)    NOT NULL,
	    PD_CONTENT  	VARCHAR2(1000)  NOT NULL,
	    PD_IMAGE    	VARCHAR2(60)    NOT NULL,
	    PD_AMOUNT   	NUMBER          NOT NULL,		// 재고
	    PD_BUY      	CHAR(1)         NOT NULL,		// 상품 구매가능 여부 (y/n)
	    PD_DATE     	DATE            DEFAULT SYSDATE NOT NULL,
	    PD_DATE_UP  	DATE            DEFAULT SYSDATE NOT NULL 
	 */
	
	private long pd_code;
	private String cg_code;
	private String cg_parent_code;
	private String pd_name;
	private int pd_price;
	private int pd_discount;
	private String pd_company;
	private String pd_content;
	private String pd_image;
	private int pd_amount;
	private String pd_buy;
	private Date pd_date;
	private Date pd_date_up;
	
	// 파일첨부 파라미터 작업
	private MultipartFile file1;
}
