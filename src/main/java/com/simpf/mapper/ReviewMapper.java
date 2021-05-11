package com.simpf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.simpf.domain.ReviewVO;
import com.simpf.dto.Criteria;

public interface ReviewMapper {

	public List<ReviewVO> reviewList(@Param("cri") Criteria cri, @Param("pd_code") long pd_code) throws Exception;
	
	public int reviewCount(long pd_code) throws Exception;
	
	public void reviewAdd(ReviewVO vo) throws Exception;
	
	public void reviewModify(ReviewVO vo) throws Exception;
	
	public void reviewDelete(long rv_num) throws Exception;
	
	public ReviewVO reviewData(long rv_num) throws Exception;
}
