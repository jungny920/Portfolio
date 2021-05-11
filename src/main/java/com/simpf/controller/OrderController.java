package com.simpf.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.simpf.domain.CartVOList;
import com.simpf.domain.OrderDetailVO;
import com.simpf.domain.OrderVO;
import com.simpf.domain.ProductVO;
import com.simpf.domain.UserInfoVO;
import com.simpf.service.CartService;
import com.simpf.service.OrderService;
import com.simpf.service.UserProductService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/order/*")
public class OrderController {
	
	@Setter(onMethod_ = @Autowired)
	private CartService cartService;
	@Setter(onMethod_ = @Autowired)
	private OrderService orderService;
	@Setter(onMethod_ = @Autowired)
	private UserProductService productService;
	
	
	@RequestMapping(value = "/order", method = {RequestMethod.GET, RequestMethod.POST})
	public String orderList(HttpSession session, @ModelAttribute("type") String type, @RequestParam(required = false) Long pd_code, @RequestParam(required = false) Integer ord_amount, Model model) throws Exception {
		log.info("GET & POST order..");
		
		// 사용자별 장바구니 내역, 주문입력 폼 구성작업
		String user_id = ((UserInfoVO) session.getAttribute("loginStatus")).getUi_id();
		
		// type: direct(즉시구매), cart(장바구니) 구분
		if(type.equals("cart")) {
			// 장바구니 구매
			log.info("장바구니 구매 "+type);
			model.addAttribute("cart_list", cartService.cartList(user_id));
			// 사용하지 않는 값이지만 주문하기 클릭시 OrderDetailVO에서 값을 요구하기때문에 0값을 작성함
			model.addAttribute("pd_code", 0);
			model.addAttribute("ord_price", 0);
			model.addAttribute("ord_amount", 0);
			
		} else if(type.equals("direct")) {
			// 즉시구매
			log.info("즉시 구매 "+type);
			// 구매 상품에 대한 정보를 표시.
			ProductVO vo = productService.productDetail(pd_code);
			
			
			// 매개변수가 있는 생성자를 만들어서 디폴트생성자도 만들어 줄 것.
			CartVOList cart = new CartVOList(0, ord_amount, pd_code, vo.getPd_image(), vo.getPd_name(), vo.getPd_price(), vo.getPd_company(), vo.getPd_amount());
			
			List<CartVOList> list = new ArrayList<CartVOList>();
			list.add(cart);
			
			model.addAttribute("cart_list", list);
			
			// 즉시구매 시 상품 상세정보를 폼에 삽입하기 위한 모델작업.
			model.addAttribute("pd_code", pd_code);
			model.addAttribute("ord_price", vo.getPd_price());
			model.addAttribute("ord_amount", ord_amount);
						
		}
		return "/order/orderList";
	}
	
	// order.jsp에서 type파라미터 정보를 받아와야 한다 (즉시구매, 장바구니 구분하기 위함)
	@PostMapping("/orderBuy")
	public String orderBuy(OrderVO vo, OrderDetailVO dvo, String type, HttpSession session) throws Exception {
		log.info("POST orderBuy..");
		
		String user_id = ((UserInfoVO) session.getAttribute("loginStatus")).getUi_id();
		vo.setUi_id(user_id);
		dvo.setUi_id(user_id);
		// type: direct(즉시구매), cart(장바구니) 구분
		if(type.equals("cart")) {
			
			log.info("order: "+vo);
			log.info("detail: "+dvo);
			
			// 장바구니 구매
			orderService.orderBuy(vo, user_id);
		} else if(type.equals("direct")) {
			// 즉시 구매
			// 주문, 주문 상세 테이블 작업
			orderService.directOrderBuy(vo, dvo);
			
		}
		
		return "redirect:/";
	}
	
	
}
