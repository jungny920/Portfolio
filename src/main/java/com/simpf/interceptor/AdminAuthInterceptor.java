package com.simpf.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminAuthInterceptor extends HandlerInterceptorAdapter {
	
	private static final Logger log = LoggerFactory.getLogger(AdminAuthInterceptor.class);
	private static final String LOGIN = "adminLogin";
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		
		if(session.getAttribute(LOGIN) == null) {
			log.info("로그인이 필요한 작업입니다.");
			System.out.println("로그인이 필요한 작업입니다.");
			targetSave(request);
			
			response.sendRedirect("/admin/");
			return false; // controller로 제어가 넘어가지 않음
		}
		
		return true; // controller로 제어가 넘어감
	}
	
	// 사용자가 세션이 소멸된 상태이거나 비로그인 시 요청한 주소를 저장하는 작업
	// 정상적으로 로그인이 진행이 되면 요청한 주소로 이동, 없으면 "/"로 이동한다.
	private void targetSave(HttpServletRequest request) {
		
		String uri = request.getRequestURI();
		String queryString = request.getQueryString(); // queryString = /주소?"key=value"
		System.out.println(queryString);
		if(uri == null || queryString == null || queryString.equals("null")) {
			queryString = "";
		} else {
			queryString = "?"+queryString;
		}
		
		if(request.getMethod().equals("GET")) {
			log.info("targetSave: "+(uri+queryString));
			request.getSession().setAttribute("targetUrl", uri+queryString);
		}
	}
	
}
