package com.simpf.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// list 페이지의 페이징번호 출력 작업을 위해 필요한 클래스
@Getter
@Setter
@ToString
public class PageDTO {

	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total; // 테이블의 모든 데이터 개수
	private Criteria cri; // 현재 페이지번호, 출력할 게시물 개수
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int) (Math.ceil(cri.getPage() / 10.0)) * 10;
		this.startPage = this.endPage - 9;
		
		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
		
		if(realEnd <= endPage)
			this.endPage = realEnd;
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
}
