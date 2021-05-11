package com.simpf.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.simpf.service.UserProductService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@ControllerAdvice(basePackages = {"com.simpf.controller"})
@Log4j
public class GlobalControllerAdvice {
	
	@Setter(onMethod_ = @Autowired)
	private UserProductService userProductService;
	
	@ModelAttribute
	public void categoryList(Model model) throws Exception {
		log.info("ADVICE! categoryList..");
		
		model.addAttribute("mainCategoryList", userProductService.categoryList());
	}
	
	
}
