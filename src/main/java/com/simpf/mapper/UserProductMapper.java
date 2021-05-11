package com.simpf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.simpf.domain.CategoryVO;
import com.simpf.domain.ProductVO;
import com.simpf.dto.Criteria;

public interface UserProductMapper {
	
	// 1차 카테고리
	public List<CategoryVO> categoryList() throws Exception;
	// 2차 카테고리
	public List<CategoryVO> subCategoryList(String cg_code) throws Exception;
	
	// 2차 카테고리의 상품 출력
	// 파라미터 1개일 경우 필드명을 사용하여 getter메서드 호출
	// 파라미터 2개일 경우 타입이 참조형이면 객체명.필드 형태로 사용, 기본형이면 직접 사용. (xml Mapper 파일)
	public List<ProductVO> categoryProductList(@Param("cri") Criteria cri, @Param("cg_code") String cg_code) throws Exception;
	// 페이징을 위한 상품개수 출력
	public int categoryProductCount(String cg_code) throws Exception;
	// 상품 상세보기
	public ProductVO productDetail(Long pd_code) throws Exception;
	
	// 상품 검색
	public List<ProductVO> productSearch(Criteria cri) throws Exception;
}
