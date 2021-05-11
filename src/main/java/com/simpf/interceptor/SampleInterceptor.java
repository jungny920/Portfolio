package com.simpf.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.log4j.Log4j;

@Log4j
public class SampleInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.debug("=== preHandle ===");
		
		System.out.println("=== preHandle ===");
		
		return super.preHandle(request, response, handler);
//		return false; > false일 경우 컨트롤러로 제어가 넘어가지 않는다.
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		log.debug("=== postHandle ===");
		
		System.out.println("=== postHandle ===");
		
		super.postHandle(request, response, handler, modelAndView);
	}
	
}
