package com.simpf.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.simpf.dto.Criteria;
import com.simpf.dto.PageDTO;
import com.simpf.service.UserService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/user/*")
public class AdminUserInfoController {
	
	@Setter(onMethod_ = @Autowired)
	private UserService service;
	
	// 회원정보 관련 리스트 출력
	@GetMapping("member_list")
	public void memberSample(Model model) throws Exception {
		log.info("GET member_list..");
		model.addAttribute("member", service.memberList());
	}
	
	@GetMapping("list")
	public String adminUserList(Criteria cri, Model model) throws Exception {
		log.info("GET adminUserList");
		
		cri.setAmount(5);
		model.addAttribute("userList", service.adminUserList(cri));
		int total = service.userListCount();
		model.addAttribute("paging", new PageDTO(cri, total));
		
		return "/admin/user/user_list";
	}
}
