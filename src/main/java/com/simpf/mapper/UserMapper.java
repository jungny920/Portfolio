package com.simpf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.simpf.domain.MemberSample;
import com.simpf.domain.UserInfoVO;
import com.simpf.dto.Criteria;
import com.simpf.dto.LoginDTO;
import com.simpf.dto.MyBoardDTO;
import com.simpf.dto.MyOrderDTO;
import com.simpf.dto.MyReviewDTO;

public interface UserMapper {
	
	// 1. 회원가입
	public void signup(UserInfoVO vo) throws Exception;
	
	// 1.1 아이디 중복체크
	public int checkingID(String ui_id) throws Exception;
	
	// 2. 로그인
	public UserInfoVO login(LoginDTO dto) throws Exception;
	public List<MemberSample> memberList() throws Exception;
	
	// 3. 회원정보 수정 폼
	public UserInfoVO user_info(String ui_id) throws Exception;
	
	// 3.1 회원정보 수정 저장
	public int info_modify(UserInfoVO vo) throws Exception;
	
	// 3.2 비밀번호 변경
	public void password_modify(UserInfoVO vo) throws Exception;
	
	// 4.1 아이디 찾기 : 
	public String find_id(String ui_name) throws Exception;
	
	// 4.2 비밀번호 찾기 : 메일전송
	public UserInfoVO find_pw(@Param("ui_id") String ui_id, @Param("ui_email") String ui_email) throws Exception;

	// 5.1 회원 탈퇴 기능
	public int user_delete(@Param("ui_id") String ui_id, @Param("ui_pw") String ui_pw) throws Exception;
	
	// 마이페이지 쇼핑(주문)내역 (페이징)
	public List<MyOrderDTO> mypageOrderList(@Param("ui_id") String ui_id, @Param("cri") Criteria cri) throws Exception;
	// 마이페이지 상품후기 목록 (페이징)
	public List<MyReviewDTO> mypageReviewList(@Param("ui_id") String ui_id, @Param("cri") Criteria cri) throws Exception;
	// 마이페이지 문의 목록 (페이징)
	public List<MyBoardDTO> mypageBoardList(@Param("ui_id") String ui_id, @Param("cri") Criteria cri) throws Exception;
	// 문의 내용 출력
	public String mypageBoardCnt(long board_num) throws Exception;
	
	// 관리자 유저리스트 출력
	public List<UserInfoVO> adminUserList(Criteria cri) throws Exception;
	// 리스트 출력하기 위한 전체 수
	public int userListCount() throws Exception;
}
