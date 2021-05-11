package com.simpf.dto;

import lombok.Data;

@Data
public class ChartDTO {
	
	/*
	 	select count(*) chart_count, sum(ord_total_price) chart_price, to_char(ord_date, 'yyyy-mm-dd') chart_date
		from MALL_ORDER
		where ord_date between TRUNC(sysdate , 'd') and TRUNC(sysdate , 'd')+6
		group by to_char(ord_date, 'yyyy-mm-dd')
		order by to_char(ord_date, 'yyyy-mm-dd') desc;
	*/
	
	private int chart_count;
	private long chart_price;
	private String chart_date;
}
