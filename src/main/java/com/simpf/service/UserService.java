package com.simpf.service;

import java.util.List;

import com.simpf.domain.MemberSample;
import com.simpf.domain.UserInfoVO;
import com.simpf.dto.Criteria;
import com.simpf.dto.LoginDTO;
import com.simpf.dto.MyBoardDTO;
import com.simpf.dto.MyOrderDTO;
import com.simpf.dto.MyReviewDTO;

public interface UserService {
	
	// 회원가입
	public void signup(UserInfoVO vo) throws Exception;
	
	// 아이디 중복확인
	public int checkingID(String ui_id) throws Exception;
	
	// 로그인
	public UserInfoVO login(LoginDTO dto) throws Exception;
	public List<MemberSample> memberList() throws Exception;
	
	// 회원정보 조회
	public UserInfoVO user_info(String ui_id) throws Exception;
	
	// 회원정보 수정
	public boolean info_modify(UserInfoVO vo) throws Exception;
	
	// 비밀번호 변경
	public void password_modify(UserInfoVO vo) throws Exception;
		
	// 아이디 찾기
	public String find_id(String ui_name) throws Exception;
	
	// 패스워드 찾기
	public UserInfoVO find_pw(String ui_id, String ui_email) throws Exception;
	
	// 회원 탈퇴
	public boolean user_delete(String ui_id, String ui_pw) throws Exception;
	
	// 마이페이지
	// 1. 쇼핑(주문)내역
	public List<MyOrderDTO> mypageOrderList(String ui_id, Criteria cri) throws Exception;
	// 2. 후기 목록
	public List<MyReviewDTO> mypageReviewList(String ui_id, Criteria cri) throws Exception;
	// 3. 문의 목록
	public List<MyBoardDTO> mypageBoardList(String ui_id, Criteria cri) throws Exception;
	// 3.1 문의 내용
	public String mypageBoardCnt(long board_num) throws Exception;
	
	// 관리자 유저리스트 출력
	public List<UserInfoVO> adminUserList(Criteria cri) throws Exception;
	// 리스트 출력하기 위한 전체 수
	public int userListCount() throws Exception;
}
