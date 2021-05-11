package com.simpf.service;

import java.util.List;

import org.json.simple.JSONObject;

import com.simpf.domain.CartVO;
import com.simpf.domain.CartVOList;
import com.simpf.dto.CartDTO;

public interface CartService {
	
	public void addCart(CartVO vo) throws Exception;
	
	public List<CartVOList> cartList(String ui_id) throws Exception;
	
	public void deleteCart(long sc_code) throws Exception;
	
	public void allDeleteCart(String ui_id) throws Exception;
	
	public void updateCart(long sc_code, int sc_amount) throws Exception;
	
	public void checkedDeleteCart(List<Long> checkArr) throws Exception;
	
	public List<CartVOList> checkedOrderCart(String ui_id, List<Long> item) throws Exception;
	
	public List<CartDTO> cart_money() throws Exception;
	
	public JSONObject getChartData() throws Exception;
}
