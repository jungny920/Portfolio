package com.simpf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.simpf.domain.CategoryVO;
import com.simpf.domain.ProductVO;
import com.simpf.dto.Criteria;
import com.simpf.mapper.AdminProductMapper;

import lombok.Setter;

@Service
public class AdminProductServiceImpl implements AdminProductService {

	@Setter(onMethod_ = @Autowired)
	private AdminProductMapper product_mapper;
	
	@Override
	public List<CategoryVO> getCategoryList() throws Exception {
		// TODO Auto-generated method stub
		return product_mapper.getCategoryList();
	}

	@Override
	public List<CategoryVO> getSubCategoryList(String cg_code) throws Exception {
		// TODO Auto-generated method stub
		return product_mapper.getSubCategoryList(cg_code);
	}

	@Override
	public void product_insert(ProductVO vo) throws Exception {
		// TODO Auto-generated method stub
		product_mapper.product_insert(vo);
	}

	@Override
	public ProductVO product_info(Long pd_code) throws Exception {
		// TODO Auto-generated method stub
		return product_mapper.product_info(pd_code);
	}

	@Override
	public List<ProductVO> product_list(Criteria cri) throws Exception {
		
		return product_mapper.product_list(cri);
	}

	@Override
	public int product_count(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return product_mapper.product_count(cri);
	}

	@Override
	public void product_update(ProductVO vo) throws Exception {
		// TODO Auto-generated method stub
		product_mapper.product_update(vo);
	}

	@Override
	public void product_delete(Long pd_code) throws Exception {
		// TODO Auto-generated method stub
		product_mapper.product_delete(pd_code);
	}

	
}
