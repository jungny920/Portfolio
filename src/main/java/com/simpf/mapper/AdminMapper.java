package com.simpf.mapper;

import com.simpf.domain.AdminVO;

public interface AdminMapper {
	
	// 관리자계정 로그인
	public AdminVO login(AdminVO vo) throws Exception;
	
	// 로그인 시 접속시간 갱신(최신화)
	public void login_update(String admin_id) throws Exception;
	
	// 관리자계정 추가
	public void adminSignup(AdminVO vo) throws Exception;
}
