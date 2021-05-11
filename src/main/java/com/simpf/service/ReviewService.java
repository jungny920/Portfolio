package com.simpf.service;

import com.simpf.domain.ReviewVO;
import com.simpf.dto.Criteria;
import com.simpf.dto.ReviewDTO;

public interface ReviewService {
	
	public ReviewDTO reviewList(Criteria cri, long pd_code) throws Exception;
	
	public void reviewAdd(ReviewVO vo) throws Exception;

	public void reviewModify(ReviewVO vo) throws Exception;
	
	public void reviewDelete(long rv_num) throws Exception;
	
	public ReviewVO reviewData(long rv_num) throws Exception;
}
