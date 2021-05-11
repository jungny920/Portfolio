package com.simpf.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.simpf.dto.CartDTO;
import com.simpf.service.CartService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@AllArgsConstructor
@RequestMapping("/chart/*")
public class ChartController {

	@Setter(onMethod_ = @Autowired)
	private CartService cartSerivce;
	/*
	@GetMapping("/chart_ex")
	public ResponseEntity<String[][]> getChartData() throws Exception {
		log.info("차트..");
		ResponseEntity<String[][]> entity = null;
		
		String[][] chartData = null;
		
		try {
			// 장바구니 더미데이터 준비 후 실행
			//List<CartDTO> items = cartSerivce.cart_money();
			List<CartDTO> items = new ArrayList<CartDTO>();
			Random random = new Random();
			
			for(int i=0; i<5; i++) {
				CartDTO cart = new CartDTO();
				int price = random.nextInt(10000 - 1000 + 1) + 1000;
				cart.setAmount(price);
				cart.setPd_name("전자제품"+i);
				
				items.add(cart);
			}
			
			JSONArray row = new JSONArray();
			JSONObject name = new JSONObject();
			name.put("상품명", "가격");
			row.add(name);

			for(CartDTO dto : items) {
				JSONObject cell = new JSONObject();
				cell.put(dto.getPd_name(), dto.getAmount());
				
				row.add(cell);
			}
			
			
			
			for(int i=0; i<row.size(); i++) {
				
			}
			
			
			entity = new ResponseEntity<>(chartData, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		Random rand = new Random();
		
		
		return entity;
	}*/
	// 차트에 사용할 데이터를 2차원 배열형태로 작업하여 String변수에 저장.
	@ResponseBody
	@GetMapping("/chart_ex")
	public ResponseEntity<String> getChartData2() {
		ResponseEntity<String> entity = null;
		
		List<CartDTO> items = new ArrayList<CartDTO>();
		Random random = new Random();
		
		for(int i=1; i<=5; i++) {
			CartDTO cart = new CartDTO();
			int price = random.nextInt(10000 - 1000 + 1) + 1000;
			cart.setAmount(price);
			cart.setPd_name("전자제품"+i);
			
			items.add(cart);
		}
		/*
		  [
		 	['상품명', '가격'],
          	['전자제품1', 15000],
          	['전자제품2', 25000],
          	['전자제품3', 35000],
          	['전자제품4', 18000],
          	['전자제품5', 25000]
          ]
          */
		String str = "[";
		str += "['상품명', '가격'],";
		for(CartDTO dto : items) {
			str += "['"+dto.getPd_name()+"',"+dto.getAmount()+"]";
		}
		str += "]";
		
		log.info(str);
		
		entity = new ResponseEntity<String>(str, HttpStatus.OK);
		
		return entity;
	}
	
	@GetMapping("/chartData")
	public ResponseEntity<JSONObject> getChart() throws Exception {
		ResponseEntity<JSONObject> entity = null;
		
		try {
			entity = new ResponseEntity<>(cartSerivce.getChartData(), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	// /chart/chart (view) 
	@GetMapping("/chart")
	public ModelAndView chart() {
		
		/*
		ModelAndView mv = new ModelAndView();
		mv.setViewName("jsp파일명");
		mv.addObject("memberVO", "DB에서 불러온 데이터");
		return mv;
		*/
		return new ModelAndView("/chart/chart");
	}
}
