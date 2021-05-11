package com.simpf.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class CartVOList {
	/*
		c.sc_code, 		
		c.sc_amount, 
		
		p.pd_code,
		p.pd_image, 
		p.pd_name, 
		p.pd_price,
		p.pd_company
		p.pd_amount
		
	 */
	private long sc_code;
	private int sc_amount;
	
	private long pd_code;
	private String pd_image;
	private String pd_name;
	private int pd_price;
	private String pd_company;
	private int pd_amount;
}
