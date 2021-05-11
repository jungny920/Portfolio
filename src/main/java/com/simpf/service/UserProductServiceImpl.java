package com.simpf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.simpf.domain.CategoryVO;
import com.simpf.domain.ProductVO;
import com.simpf.dto.Criteria;
import com.simpf.mapper.UserProductMapper;

import lombok.Setter;

@Service
public class UserProductServiceImpl implements UserProductService {

	@Setter(onMethod_ = @Autowired)
	private UserProductMapper userProductMapper;
	
	@Override
	public List<CategoryVO> categoryList() throws Exception {
		// TODO Auto-generated method stub
		return userProductMapper.categoryList();
	}

	@Override
	public List<CategoryVO> subCategoryList(String cg_code) throws Exception {
		// TODO Auto-generated method stub
		return userProductMapper.subCategoryList(cg_code);
	}

	@Override
	public List<ProductVO> categoryProductList(Criteria cri, String cg_code) throws Exception {
		// TODO Auto-generated method stub
		return userProductMapper.categoryProductList(cri, cg_code);
	}

	@Override
	public int categoryProductCount(String cg_code) throws Exception {
		// TODO Auto-generated method stub
		return userProductMapper.categoryProductCount(cg_code);
	}

	@Override
	public ProductVO productDetail(Long pd_code) throws Exception {
		// TODO Auto-generated method stub
		return userProductMapper.productDetail(pd_code);
	}

	@Override
	public List<ProductVO> productSearch(Criteria cri) throws Exception {
		// 상품 검색
		return userProductMapper.productSearch(cri);
	}

	

}
