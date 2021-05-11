package com.simpf.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.lang.Nullable;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

// 인증처리 작업: HttpSession 로그인생성
public class UserLoginInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(UserLoginInterceptor.class);
	private static final String LOGIN = "loginStatus";
	
	// Object handler: URL Mapping주소에 해당하는 메서드 자체를 가리킨다.
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		return true;
	}
	
	// Mapping(/login) > postHandle 메서드 실행 후 뷰 화면처리 작업이 진행됨.
	// ModelAndView: (Model + View)
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			@Nullable ModelAndView modelAndView) throws Exception {
		/*
		UserInfoVO vo = new UserInfoVO();
		modelAndView.setViewName("userInfo");
		modelAndView.addObject("userInfoVO", vo);
		*/
		// 로그인 인증처리 하기위한 세션객체 확보
		HttpSession session = request.getSession();
		// 로그인 Model정보를 참조하는 작업
		ModelMap modelMap = modelAndView.getModelMap();
		Object userVO = modelMap.get("userVO");
		
		if(userVO != null) {
			logger.debug("로그인 성공 - 인터셉터");
			session.setAttribute(LOGIN, userVO);
			
			
			Object tragetUrl = session.getAttribute("targetUrl");
			
			response.sendRedirect(tragetUrl != null ? (String) tragetUrl : "/");
		}
		
		// response.sendRedirect("/"); 이 위치에서는 지원이 되지않는다.
	}
}
