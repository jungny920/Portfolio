package com.simpf.service;

import java.util.List;

import com.simpf.domain.CategoryVO;
import com.simpf.domain.ProductVO;
import com.simpf.dto.Criteria;

public interface UserProductService {
	
	public List<CategoryVO> categoryList() throws Exception;
	
	public List<CategoryVO> subCategoryList(String cg_code) throws Exception;
	// 2차 카테고리의 상품 출력
	public List<ProductVO> categoryProductList(Criteria cri, String cg_code) throws Exception;
	// 페이징을 위한 상품개수 출력
	public int categoryProductCount(String cg_code) throws Exception;
	// 상품 상세설명
	public ProductVO productDetail(Long pd_code) throws Exception;
	// 상품 검색
	public List<ProductVO> productSearch(Criteria cri) throws Exception;
}
