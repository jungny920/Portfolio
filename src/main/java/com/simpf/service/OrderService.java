package com.simpf.service;

import java.util.List;

import org.json.simple.JSONObject;

import com.simpf.domain.OrderDetailVO;
import com.simpf.domain.OrderDetailVOList;
import com.simpf.domain.OrderVO;
import com.simpf.dto.ChartDTO;
import com.simpf.dto.Criteria;
import com.simpf.dto.OrderSalesDTO;

public interface OrderService {
	
	public void orderBuy(OrderVO vo, String ui_id) throws Exception;
	
	public void directOrderBuy(OrderVO vo, OrderDetailVO dvo) throws Exception;
	// 사용자 - 선택 장바구니 구매
	public void checkedOrder(OrderVO vo, String ui_id, List<Long> item) throws Exception;
	// 관리자 - 주문내역 리스트 출력
	public List<OrderVO> orderInfoList(Criteria cri) throws Exception;
	// 리스트 개수 출력
	public int orderCount(Criteria cri) throws Exception;
	// 주문리스트 내역 상세정보
	public List<OrderDetailVOList> orderDetailInfo(long ord_code) throws Exception;
	// 통계관련 뷰
	public List<OrderSalesDTO> orderSales(String startDate, String endDate) throws Exception;
	
	public List<ChartDTO> salesChart() throws Exception;
	public JSONObject chartData() throws Exception;
}
