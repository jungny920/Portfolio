package com.simpf.service;

import com.simpf.domain.AdminVO;

public interface AdminService {
	
	public AdminVO login(AdminVO vo) throws Exception;
	
	public void adminSignup(AdminVO vo) throws Exception;
}
