package com.simpf.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@ToString
@Getter
@Setter
public class Criteria {

	private int page; // 페이지 번호
	private int amount; // 페이지마다 출력될 게시물 개수
	
	private String type; // 검색종류. (상품명[N], 회사명[C])
	private String keyword; // 검색어
	
	public Criteria() {
		this(1, 5);
	}

	public Criteria(int page, int amount) {
		this.page = page;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		
		return type == null? new String[] {} : type.split("");
	}
}
