package com.simpf.dto;

import lombok.Data;

@Data
public class OrderSalesDTO {
// to_char(b.dt, 'YYYY-MM-DD') as dat, to_char(b.dt, 'DY') as day, nvl(a.cnt, 0) as cnt
	
	
//	private Date dat;
	private String dat;
	private String day;
	private int cnt;
	private int price;
	
}
