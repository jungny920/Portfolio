package com.simpf.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.simpf.domain.AdminVO;
import com.simpf.service.AdminService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
public class AdminController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminService service;
	@Inject
	private BCryptPasswordEncoder cryPasswordEnc;
	
	@GetMapping("/")
	public String login() {
		log.info("GET login..");
		
		return "/admin/login";
	}
	
	@GetMapping("/main")
	public String admin(HttpSession session) {
		log.info("GET process..");
		
		if(session.getAttribute("adminLogin") == null) {
			return "redirect:/admin/";
		}
		
		return "/admin/main";
	}
	
	// 관리자 계정 추가페이지
	@GetMapping("join")
	public String adminSignup() {
		log.info("GET JOIN");
		
		return "/admin/signup";
	}
	// 계정추가
	@PostMapping("signup")
	public String signup(AdminVO vo) throws Exception {
		log.info("POST SIGN UP");
		
		vo.setAdmin_pw(cryPasswordEnc.encode(vo.getAdmin_pw()));
		service.adminSignup(vo);
		
		return "redirect:/admin/";
	}
	
	
	
	@PostMapping("login")
	public String login(AdminVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {
		log.info("POST login..");
		//로그인 작업 adminLogin
		AdminVO admin = service.login(vo);
		
		if(admin != null && cryPasswordEnc.matches(vo.getAdmin_pw(), admin.getAdmin_pw())) {
			log.info("로그인 성공!");
			session.setAttribute("adminLogin", admin);
		} else {
			log.info("로그인 실패");
			rttr.addFlashAttribute("adminStatus", "fail");
			return "redirect:/admin/";
		}
		
		rttr.addFlashAttribute("adminStatus", "login");
		return "redirect:/admin/main";
	}
	
	@GetMapping("logout")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		log.info("GET logout..");
		
		session.invalidate();
		rttr.addFlashAttribute("adminStatus", "logout");
		
		return "redirect:/admin/";
	}
}
