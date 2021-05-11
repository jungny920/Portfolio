package com.simpf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.simpf.domain.MemberSample;
import com.simpf.domain.UserInfoVO;
import com.simpf.dto.Criteria;
import com.simpf.dto.LoginDTO;
import com.simpf.dto.MyBoardDTO;
import com.simpf.dto.MyOrderDTO;
import com.simpf.dto.MyReviewDTO;
import com.simpf.mapper.UserMapper;

import lombok.Setter;

@Service // bean name = userServiceImpl
public class UserServiceImpl implements UserService {
	
	@Setter(onMethod_ = @Autowired)
	private UserMapper mapper;
	
	@Override
	public void signup(UserInfoVO vo) throws Exception {
		// 회원가입
		mapper.signup(vo);
	}

	@Override
	public int checkingID(String ui_id) throws Exception {
		// 아이디 중복확인
		return mapper.checkingID(ui_id);
	}

	@Override
	public UserInfoVO login(LoginDTO dto) throws Exception {
		// 로그인
		return mapper.login(dto);
	}

	@Override
	public UserInfoVO user_info(String ui_id) throws Exception {
		// 회원정보 확인
		return mapper.user_info(ui_id);
	}

	@Override
	public boolean info_modify(UserInfoVO vo) throws Exception {
		// 회원정보 수정
		return mapper.info_modify(vo) == 1;
	}
	
	@Override
	public String find_id(String ui_name) throws Exception {
		// 아이디 찾기
		return mapper.find_id(ui_name);
	}

	@Override
	public UserInfoVO find_pw(String ui_id, String ui_email) throws Exception {
		// 비밀번호 찾기
		return mapper.find_pw(ui_id, ui_email);
	}

	@Override
	public boolean user_delete(String ui_id, String ui_pw) throws Exception {
		// 회원 탈퇴
		return mapper.user_delete(ui_id, ui_pw) == 1;
	}

	@Override
	public List<MemberSample> memberList() throws Exception {
		// resultMap 관련 연습용 예제
		return mapper.memberList();
	}

	@Override
	public void password_modify(UserInfoVO vo) throws Exception {
		// 비밀번호 변경
		mapper.password_modify(vo);
	}

	@Override
	public List<MyOrderDTO> mypageOrderList(String ui_id, Criteria cri) throws Exception {
		// 마이페이지 
		// 1. 쇼핑(주문)내역
		return mapper.mypageOrderList(ui_id, cri);
	}

	@Override
	public List<MyReviewDTO> mypageReviewList(String ui_id, Criteria cri) throws Exception {
		// 2. 상품후기 목록
		return mapper.mypageReviewList(ui_id, cri);
	}

	@Override
	public List<MyBoardDTO> mypageBoardList(String ui_id, Criteria cri) throws Exception {
		// 3. 문의 목록
		return mapper.mypageBoardList(ui_id, cri);
	}

	@Override
	public String mypageBoardCnt(long board_num) throws Exception {
		// 3.1 문의내용
		return mapper.mypageBoardCnt(board_num);
	}

	@Override
	public List<UserInfoVO> adminUserList(Criteria cri) throws Exception {
		// 관리자 리스트
		return mapper.adminUserList(cri);
	}

	@Override
	public int userListCount() throws Exception {
		// 전체 유저수
		return mapper.userListCount();
	}

}
