package com.simpf.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.simpf.domain.ReviewVO;
import com.simpf.dto.Criteria;
import com.simpf.dto.ReviewDTO;
import com.simpf.mapper.ReviewMapper;

import lombok.Setter;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Setter(onMethod_ = @Autowired)
	private ReviewMapper reviewMapper;
	
	@Override
	@Transactional
	public ReviewDTO reviewList(Criteria cri, long pd_code) throws Exception {
		
		ReviewDTO dto = new ReviewDTO(reviewMapper.reviewCount(pd_code), reviewMapper.reviewList(cri, pd_code));
		
		return dto;
	}

	@Override
	public void reviewAdd(ReviewVO vo) throws Exception {
		reviewMapper.reviewAdd(vo);
	}

	@Override
	public void reviewModify(ReviewVO vo) throws Exception {
		reviewMapper.reviewModify(vo);
	}

	@Override
	public void reviewDelete(long rv_num) throws Exception {
		reviewMapper.reviewDelete(rv_num);
	}

	@Override
	public ReviewVO reviewData(long rv_num) throws Exception {
		// TODO Auto-generated method stub
		return reviewMapper.reviewData(rv_num);
	}

}
