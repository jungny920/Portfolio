package com.simpf.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.simpf.domain.CategoryVO;
import com.simpf.domain.ProductVO;
import com.simpf.dto.Criteria;
import com.simpf.dto.PageDTO;
import com.simpf.service.UserProductService;
import com.simpf.util.FileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/product/*")
public class UserProductController {
	
	@Setter(onMethod_ = @Autowired)
	private UserProductService userProductService;
	
	@ResponseBody
	@GetMapping("/subCategoryList/{cg_code}")
	public ResponseEntity<List<CategoryVO>> subCategoryList(@PathVariable("cg_code") String cg_code) throws Exception {
		log.info("GET subCategoryList...");
		
		ResponseEntity<List<CategoryVO>> entity;
		try {
			entity = new ResponseEntity<>(userProductService.subCategoryList(cg_code), HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	// 카테고리 상품 뷰
	@GetMapping("/list")
	public String categoryProductList(@ModelAttribute("cri") Criteria cri, String cg_code, Model model) throws Exception {
		log.info("GET list..");
		
		cri.setAmount(9);
		model.addAttribute("product", userProductService.categoryProductList(cri, cg_code));
		
		int total = userProductService.categoryProductCount(cg_code);
		model.addAttribute("paging", new PageDTO(cri, total));
		
		return "/product/product_list";
	}
	
	// 상품 상세설명 뷰
	@GetMapping("/detail")
	public String productDetail(Long pd_code, Model model) throws Exception {
		log.info("GET detail..");
		
		ProductVO vo = userProductService.productDetail(pd_code);
		vo.setPd_image(FileUtils.thumbToOriginName(vo.getPd_image()));
		
		model.addAttribute("detail", vo);
		
		return "/product/product_detail";
	}
	
	@GetMapping("/search")
	public String productDetail(Criteria cri, Model model) throws Exception {
		log.info("GET search..");
		
		model.addAttribute("product", userProductService.productSearch(cri));
		
		return "/product/product_list";
	}
	
}
