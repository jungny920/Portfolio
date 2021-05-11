package com.simpf.mapper;

import java.util.List;

import com.simpf.domain.CategoryVO;
import com.simpf.domain.ProductVO;
import com.simpf.dto.Criteria;

public interface AdminProductMapper {
	
	// 1차 카테고리
	public List<CategoryVO> getCategoryList() throws Exception;
	
	// 2차 카테고리
	public List<CategoryVO> getSubCategoryList(String cg_code) throws Exception;
	
	// 상품 등록
	public void product_insert(ProductVO vo) throws Exception;
	
	// 삼품 변경 폼 출력
	public ProductVO product_info(Long pd_code) throws Exception;
	
	// 상품 리스트 출력
	public List<ProductVO> product_list(Criteria cri) throws Exception;
	
	// 전체 등록 상품 개수 리턴
	public int product_count(Criteria cri) throws Exception;
	
	// 상품 수정
	public void product_update(ProductVO vo) throws Exception;
	
	// 상품 삭제
	public void product_delete(Long pd_code) throws Exception;
}
