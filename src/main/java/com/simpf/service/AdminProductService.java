package com.simpf.service;

import java.util.List;

import com.simpf.domain.CategoryVO;
import com.simpf.domain.ProductVO;
import com.simpf.dto.Criteria;

public interface AdminProductService {
	
	public List<CategoryVO> getCategoryList() throws Exception;
	
	public List<CategoryVO> getSubCategoryList(String cg_code) throws Exception;
	
	public void product_insert(ProductVO vo) throws Exception;
	
	public ProductVO product_info(Long pd_code) throws Exception;
	
	public List<ProductVO> product_list(Criteria cri) throws Exception;
	
	public int product_count(Criteria cri) throws Exception;
	
	public void product_update(ProductVO vo) throws Exception;
	
	public void product_delete(Long pd_code) throws Exception;
}
