package com.simpf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.simpf.domain.CartVO;
import com.simpf.domain.CartVOList;
import com.simpf.dto.CartDTO;

public interface CartMapper {
	
	// 장바구니 추가
	public void addCart(CartVO vo) throws Exception;
	// 장바구니 리스트 출력
	public List<CartVOList> cartList(String ui_id) throws Exception;
	// 장바구니 목록 삭제
	public void deleteCart(long sc_code) throws Exception;
	// 장바구니 전체 삭제
	public void allDeleteCart(String ui_id) throws Exception;
	// 장바구니 수량 변경
	public void updateCart(@Param("sc_code") long sc_code, @Param("sc_amount") int sc_amount) throws Exception;
	// 선택한 장바구니 삭제
	public void checkedDeleteCart(List<Long> checkArr) throws Exception;
	// 선택 장바구니 구매 페이지 이동
	public List<CartVOList> checkedOrderCart(@Param("ui_id") String ui_id, @Param("item") List<Long> item) throws Exception;
	// 장바구니 차트
	public List<CartDTO> cart_money() throws Exception;
}
