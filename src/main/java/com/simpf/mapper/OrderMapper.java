package com.simpf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.simpf.domain.OrderDetailVO;
import com.simpf.domain.OrderDetailVOList;
import com.simpf.domain.OrderVO;
import com.simpf.dto.ChartDTO;
import com.simpf.dto.Criteria;
import com.simpf.dto.OrderSalesDTO;

public interface OrderMapper {
	
	// 주문 정보 추가
	public void addOrder(OrderVO vo) throws Exception;
	// 주문 상세정보(주문내역) 추가
	public void addOrderDetail(@Param("ord_code") long ord_code, @Param("ui_id") String ui_id) throws Exception;
	// 즉시구매 주문 상세정보 추가작업.
	public void directAddOrder(OrderDetailVO vo) throws Exception;
	
	// 관리자 - 주문내역 리스트 출력
	public List<OrderVO> orderInfoList(Criteria cri) throws Exception;
	// 리스트 개수 출력
	public int orderCount(Criteria cri) throws Exception;
	// 주문리스트 내역 상세정보
	public List<OrderDetailVOList> orderDetailInfo(long ord_code) throws Exception;
	// 매출 통계 뷰
	public List<OrderSalesDTO> orderSales(@Param("startDate") String startDate, @Param("endDate") String endDate) throws Exception;
	
	public List<ChartDTO> salesChart() throws Exception;
}
