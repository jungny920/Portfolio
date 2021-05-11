package com.simpf.dto;

import java.util.List;

import com.simpf.domain.ReviewVO;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ReviewDTO {
	
	private int reviewCnt; // 상품후기 개수
	private List<ReviewVO> reviewList; // 상품후기 목록
}
