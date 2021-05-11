package com.simpf.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.simpf.domain.CartVO;
import com.simpf.domain.CartVOList;
import com.simpf.domain.UserInfoVO;
import com.simpf.dto.CartDTO;
import com.simpf.service.CartService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/cart/*") // 공통주소로 사용, jsp폴더명
public class CartController {
	
	@Setter(onMethod_ = @Autowired)
	private CartService service;
	
	@ResponseBody
	@PostMapping("/add")
	public ResponseEntity<String> addCartProduct(Long pd_code, int pd_amount, HttpSession session, HttpServletResponse response) throws Exception {
		log.info("AJAX add.."+pd_code+pd_amount);
		
		ResponseEntity<String> entity;
		
		if(session.getAttribute("loginStatus") == null) {
			log.info("로그인이 필요한 작업입니다.");
			entity = new ResponseEntity<>("LoginRequired", HttpStatus.OK);
			return entity;
		}

		UserInfoVO user = (UserInfoVO) session.getAttribute("loginStatus");
		CartVO cart = new CartVO(0, user.getUi_id(), pd_code, pd_amount);
		
		
		try {
			service.addCart(cart);
			entity = new ResponseEntity<>("success", HttpStatus.OK); 
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST); 
		}
		
		
		return entity;
	}
	
	// 장바구니 폼
	@GetMapping("/list")
	public String cartList(HttpSession session, Model model) throws Exception {
		log.info("GET list..");
		
		String user_id = ((UserInfoVO) session.getAttribute("loginStatus")).getUi_id();
		
		model.addAttribute("cart_list", service.cartList(user_id));
		
		
		return "/cart/cartList";
	}
	
	// 장바구니 삭제
	@ResponseBody
	@PostMapping("/delete")
	public ResponseEntity<String> cartDelete(Long sc_code) throws Exception {
		log.info("POST delete..");
		
		ResponseEntity<String> entity;
		
		try {
			service.deleteCart(sc_code);
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return entity;
	}
	
	// 장바구니 전체 비우기
	@ResponseBody
	@PostMapping("/allDelete")
	public ResponseEntity<String> cartAllDelete(HttpSession session) throws Exception {
		log.info("POST allDelete..");
		
		ResponseEntity<String> entity;
		String ui_id = ((UserInfoVO) session.getAttribute("loginStatus")).getUi_id();
		
		try {
			service.allDeleteCart(ui_id);;
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return entity;
	}
	/*
	@GetMapping("/allDelete")
	public String cartAllDelete(HttpSession session) throws Exception {
		log.info("GET allDelete..");
		
		String ui_id = ((UserInfoVO) session.getAttribute("loginStatus")).getUi_id();
		
		service.allDeleteCart(ui_id);;
		
		return "redirect:/cart/list";
	}
	*/
	
	// 선택 장바구니 구매
	@ResponseBody
	@PostMapping(value = "/checkedOrder", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<CartVOList>> cartOrder(@RequestParam("item[]") List<Long> item, HttpSession session) throws Exception {
		
		ResponseEntity<List<CartVOList>> entity;
		String user_id = ((UserInfoVO) session.getAttribute("loginStatus")).getUi_id();
		
		try {
			entity = new ResponseEntity<>(service.checkedOrderCart(user_id, item) , HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.OK);
		}
		
		return entity;
	}
	
	
	// 선택한 상품 제거
	@ResponseBody
	@PostMapping("/checkedDelete")
	public ResponseEntity<String> cartCheckedDelete(@RequestParam("checkArr[]") List<Long> checkArr) throws Exception {
		log.info("POST checkedDelete..");
		
		ResponseEntity<String> entity = null;
		
		try {
			service.checkedDeleteCart(checkArr);
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return entity;
	}
	
	// 수량 변경
	@ResponseBody
	@PostMapping("/update")
	public ResponseEntity<String> cartUpdate(Long sc_code, Integer sc_amount) throws Exception {
		log.info("POST update..");
		
		ResponseEntity<String> entity;
		
		try {
			service.updateCart(sc_code, sc_amount);
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return entity;
	}
	
	
	
	// 차트관련 예제
	@GetMapping("/chart_sample")
	public void chart_sample(Model model) {
		log.info("chart_sample");
		
		
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
		int num = 0;
		String str = "[";
		str += "['상품명', '가격'],";
		for(CartDTO dto : items) {
			str += "['"+dto.getPd_name()+"',"+dto.getAmount()+"]";
			
			num++;
			if(num<items.size()) str += ",";
		}
		str += "]";
		
		log.info(str);
		
		model.addAttribute("chart", str);
	}
	
	
	
}
