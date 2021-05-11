package com.simpf.dto;

import java.util.Date;

import lombok.Data;

@Data
public class MyOrderDTO {
	
	//d.ui_id, p.pd_code, o.ord_code, pd_image, p.pd_name, d.ord_price, d.ord_amount, o.ord_date
	
	private String ui_id;
	private long pd_code;
	private long ord_code;
	private String pd_image;
	private String pd_name;
	private int ord_price;
	private int ord_amount;
	private Date ord_date;
	
	
}
