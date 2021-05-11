package com.simpf.service;

import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.simpf.domain.OrderDetailVO;
import com.simpf.domain.OrderDetailVOList;
import com.simpf.domain.OrderVO;
import com.simpf.dto.ChartDTO;
import com.simpf.dto.Criteria;
import com.simpf.dto.OrderSalesDTO;
import com.simpf.mapper.CartMapper;
import com.simpf.mapper.OrderMapper;

import lombok.Setter;

@Service
public class OrderServiceImpl implements OrderService {

	@Setter(onMethod_ = @Autowired)
	private OrderMapper orderMapper;
	
	@Setter(onMethod_ = @Autowired)
	private CartMapper cartMapper;
	
	@Override
	@Transactional
	public void orderBuy(OrderVO vo, String ui_id) throws Exception {
		// 사용자 - 카트 구매
		orderMapper.addOrder(vo);
		orderMapper.addOrderDetail(vo.getOrd_code(), ui_id);
		cartMapper.allDeleteCart(ui_id);
	}

	@Override
	@Transactional
	public void checkedOrder(OrderVO vo, String ui_id, List<Long> item) throws Exception {
		// 사용자 - 선택 카트 구매
		orderMapper.addOrder(vo);
		orderMapper.addOrderDetail(vo.getOrd_code(), ui_id);
		cartMapper.allDeleteCart(ui_id);
	}
	
	@Override
	@Transactional
	public void directOrderBuy(OrderVO vo, OrderDetailVO dvo) throws Exception {
		// 사용자 - 즉시구매
		orderMapper.addOrder(vo);
		dvo.setOrd_code(vo.getOrd_code());
		orderMapper.directAddOrder(dvo);
	}

	@Override
	public List<OrderVO> orderInfoList(Criteria cri) throws Exception {
		// 관리자 - 주문조회
		return orderMapper.orderInfoList(cri);
	}

	@Override
	public int orderCount(Criteria cri) throws Exception {
		// 주문 전체 개수
		return orderMapper.orderCount(cri);
	}

	@Override
	public List<OrderDetailVOList> orderDetailInfo(long ord_code) throws Exception {
		// 관리자 - 주문상세조회
		return orderMapper.orderDetailInfo(ord_code);
	}

	@Override
	public List<OrderSalesDTO> orderSales(String startDate, String endDate) throws Exception {
		// 관리자 - 주문 통계 출력
		return orderMapper.orderSales(startDate, endDate);
	}

	@Override
	public List<ChartDTO> salesChart() throws Exception {
		return orderMapper.salesChart();
	}
	//일주일 매출관련 차트
	@Override
	public JSONObject chartData() throws Exception {
		
		List<ChartDTO> items = orderMapper.salesChart();
		
		JSONObject col1 = new JSONObject(); // {"label", "날짜"}
		JSONObject col2 = new JSONObject();
		//JSONObject col3 = new JSONObject();

		col1.put("label", "날짜");
		col2.put("label", "매출액");
		//col3.put("label", "주문개수");
		
		col1.put("type", "string");
		col2.put("type", "number");
		//col3.put("type", "number");
		
		JSONArray title = new JSONArray(); // [{}, {}, {}, ...]
		title.add(col1);
		title.add(col2);
		//title.add(col3);
		
		JSONObject data = new JSONObject();// {"cols", [{}, {}, ...]}
        data.put("cols", title);
		
        JSONArray body = new JSONArray();
        for(ChartDTO dto : items) {
        	
        	JSONObject date = new JSONObject();
        	date.put("v", dto.getChart_date());
        	
        	JSONObject price = new JSONObject();
        	price.put("v", dto.getChart_price());
        	
//        	JSONObject count = new JSONObject();
//        	count.put("v", dto.getChart_count());
        	
        	JSONArray row = new JSONArray();
        	row.add(date);
        	row.add(price);
        	//row.add(count);
        	
        	JSONObject cell = new JSONObject(); 
            cell.put("c", row);
            
            body.add(cell);
        }
        data.put("rows", body);
        
		return data;
	}
	
	
}
