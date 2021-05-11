package com.simpf.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.simpf.domain.OrderDetailVOList;
import com.simpf.dto.Criteria;
import com.simpf.dto.PageDTO;
import com.simpf.service.OrderService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/order/*")
public class AdminOrderController {

	@Setter(onMethod_ = @Autowired)
	private OrderService orderService;
	
	
	@GetMapping("list")
	public String orderList(@ModelAttribute("cri") Criteria cri, Model model) throws Exception {
		log.info("GET Order_list..");
		
		model.addAttribute("order_list", orderService.orderInfoList(cri));
		
		int total = orderService.orderCount(cri);
		log.info("주문 개수 : "+total);
		model.addAttribute("paging", new PageDTO(cri, total));
		
		return "/admin/order/order_list";
	}
	
	@ResponseBody
//	@RequestMapping(value = "detail_list", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@GetMapping(value = "detail_list", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<OrderDetailVOList>> orderDetailList(Long ord_code) throws Exception {
		log.info("GET Order Detail List..");
		
		ResponseEntity<List<OrderDetailVOList>> entity = null;
		 
		try {
			entity = new ResponseEntity<>(orderService.orderDetailInfo(ord_code), HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		
		return entity;
	}
	
	// 매출통계 view
	@GetMapping("/sale")
	public String order_sale(Model model, @RequestParam(required = false) Integer year, @RequestParam(required = false) Integer month) throws Exception {
		log.info("order_sale");
		
		// 월별 시작일, 말일구하기.
		Calendar cal = Calendar.getInstance();
		log.info(cal);
		
		int cur_year;
		int cur_month;
		
		if(year != null && month != null) {
			cur_year = year;
			cur_month = month-1; // 클라이언트에서 전송된 값에 -1로 처리해야한다.
		} else {
			cur_year = cal.get(Calendar.YEAR);
			cur_month = cal.get(Calendar.MONTH);
		}

		model.addAttribute("sel_year", cur_year);
		model.addAttribute("sel_month", cur_month+1);
		
		// 월 0~11
		cal.set(cur_year, cur_month, 1);
		
		
		log.info("기준날짜: "+cal);
		
		// 시작일, 말일
		int start_day = cal.getActualMinimum(Calendar.DAY_OF_MONTH);
		int end_day = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		SimpleDateFormat dataFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
		cal.set(cur_year, cur_month, start_day);
		String startDate = dataFormat.format(cal.getTime());
		
		cal.set(cur_year, cur_month, end_day);
		String endDate = dataFormat.format(cal.getTime());
		
		log.info("시작일: "+startDate);
		log.info("말일: "+endDate);
		
		model.addAttribute("date", orderService.orderSales(startDate, endDate));
		
		
		
		return "/admin/order/order_sale";
	}
	
	// 차트관련
	@GetMapping("/chart")
	public ResponseEntity<JSONObject> getChart() throws Exception {
		ResponseEntity<JSONObject> entity = null;
		
		try {
			entity = new ResponseEntity<>(orderService.chartData(), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
}
