package com.simpf.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.simpf.domain.AdminVO;
import com.simpf.mapper.AdminMapper;

import lombok.Setter;

@Service
public class AdminServiceImpl implements AdminService {

	@Setter(onMethod_ = @Autowired)
	private AdminMapper adminMapper;
	
	@Override
	@Transactional
	public AdminVO login(AdminVO vo) throws Exception {
		
		AdminVO admin = adminMapper.login(vo);
		
		if(admin != null) {
			// 로그인 시간 업데이트
			adminMapper.login_update(vo.getAdmin_id());
		}
		// 이전 로그인 시간
		return admin;
	}

	@Override
	public void adminSignup(AdminVO vo) throws Exception {
		adminMapper.adminSignup(vo);
	}

}
