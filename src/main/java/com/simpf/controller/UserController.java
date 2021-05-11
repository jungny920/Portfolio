package com.simpf.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.simpf.domain.UserInfoVO;
import com.simpf.dto.Criteria;
import com.simpf.dto.EmailDTO;
import com.simpf.dto.LoginDTO;
import com.simpf.dto.MyBoardDTO;
import com.simpf.dto.MyOrderDTO;
import com.simpf.dto.MyReviewDTO;
import com.simpf.service.EmailService;
import com.simpf.service.UserService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/*")
public class UserController {
	
	@Setter(onMethod_ = @Autowired)
	private UserService service;
	
	@Setter(onMethod_ = @Autowired)
	private EmailService emailService;
	
	@Inject
	private BCryptPasswordEncoder cryPasswordEnc;
	
	
	// 1. 로그인 주소
	@GetMapping("/login")
	public void login() {
		log.info("GET login..");
		// 특정 페이지에서 로그인 후 특정페이지로 돌아가는 작업?
	}
	// 1.1 로그인 기능
	@PostMapping("/loginPost")
	public void login(LoginDTO dto, RedirectAttributes rttr, HttpSession session, Model model) throws Exception {
		log.info("login.. "+dto);
		
		UserInfoVO vo = service.login(dto);
		
		if(vo == null) return;
		
		// 성공, ID틀림, PW틀림,
		String result = "failID";
		
		// 1.1.1 ID체크
		if(vo != null) {
			
			// 1.1.2 PW체크
			if(cryPasswordEnc.matches(dto.getUi_pw(), vo.getUi_pw())) {
				// 1.1.2.1 로그인 성공 : Success
				// session.setAttribute("loginStatus", vo); 해당작업 인터셉터에서 진행
				
				// 인터셉터에서 참조할 모델작업
				model.addAttribute("userVO", vo);
				
				//result = "loginSuccess";
				result = "success";
				log.info("로그인 성공!");
			} else {
				// 1.1.2.2 로그인 실패 : PW틀림
				result = "failPW";
				log.info("로그인 실패.. PW가 다릅니다.");
				return;
			}
		}
		rttr.addFlashAttribute("status", result);
	}
	
	// 1.2 로그아웃 기능
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		log.info("logout..");
		
		session.invalidate();
		
		String result = "logout";
		
		rttr.addFlashAttribute("status", result);
		
		return "redirect:/";
	}
	
	// 2. 회원가입 주소
	@GetMapping("/signup")
	public void signup() {
		log.info("GET sign..");
	}
	
	// 2.1 회원가입
	@PostMapping("/signup")
	public String signup(UserInfoVO vo) throws Exception {
		log.info("sign up.. " + vo);
		// 입력받은 비밀번호를 암호화하는 작업.
		vo.setUi_pw(cryPasswordEnc.encode(vo.getUi_pw()));
		
		service.signup(vo);
		
		return "redirect:/";
	}
	
	// 2.1.1 아이디 중복체크
	@ResponseBody
	@RequestMapping(value = "/signup/checkingID", method = RequestMethod.POST,
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<String> checkingID(@RequestParam("ui_id") String ui_id) {
		ResponseEntity<String> entity = null;
		try {
			int result = service.checkingID(ui_id);
			
			if(result == 0) {
				entity = new ResponseEntity<String>("success", HttpStatus.OK);
			} else {
				entity = new ResponseEntity<String>("fail", HttpStatus.OK);
			}			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("Exception", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	// 2.1.2 이메일 인증
	@ResponseBody
	@RequestMapping(value = "/authCode", method=RequestMethod.POST)
	public ResponseEntity<String> checkAuthcode(@RequestParam("code") String code, HttpSession session){
		
		ResponseEntity<String> entity = null;
		
		try {
			// 사용자가 메일로 받은 인증코드와 세션으로 저장해둔 인증코드를 비교하는 구문
			if(code.equals(session.getAttribute("authcode"))) {
				// 인증코드 일치
				entity= new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
				
				session.removeAttribute("authcode");
				
				//isAuthCheck = true; // 최종 회원가입시 인증체크 상태를 확인.
			} else {
				// 인증코드 불일치
				entity= new ResponseEntity<String>("FAIL", HttpStatus.OK);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			entity= new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 3. ID, PW찾기 폼
	@GetMapping("/find")
	public void find() {
		log.info("GET find..");
	}
	
	// 3.1.2 ID 찾기 기능 : 화면출력
	@PostMapping("/find/id")
	@ResponseBody
	public ResponseEntity<String> find_id(@RequestParam("ui_name") String ui_name) throws Exception {
		log.info("find_id.. " + ui_name );
		
		ResponseEntity<String> entity = null;
		
		// 디테일하게 변경할 것.
		
		String ui_id = service.find_id(ui_name);
		
		
		if(ui_id != null) {
			entity = new ResponseEntity<>(ui_id, HttpStatus.OK);
		} else {
			entity = new ResponseEntity<>(HttpStatus.OK);
		}
		
		return entity;
	}
	
	// 3.2.2 PW 찾기 기능
	@ResponseBody
	@PostMapping("/find/pw")
	public ResponseEntity<String> find_pw(@RequestParam("ui_id") String ui_id, @RequestParam("ui_email") String ui_email, EmailDTO edto, RedirectAttributes rttr) throws Exception {
		log.info("find/pw.. " + ui_id + ", " + edto);
		
		ResponseEntity<String> entity = null;
		
		//LoginDTO dto = new LoginDTO();
		
		UserInfoVO vo = service.find_pw(ui_id, ui_email);
		
		String new_pw = "";
		
		if(vo != null) {
			String email = vo.getUi_email();
			
			for(int i=0; i<12; i++) {
				new_pw += (char)((Math.random() * 26)+97);
			}
			
			// 비밀번호 암호화작업
			String enc_pw = cryPasswordEnc.encode(new_pw);
			vo.setUi_pw(enc_pw);
			
			// update 하여 비밀번호 변경작업
			service.password_modify(vo);
			
			// 요청한 이메일로 비밀번호 전송
			/* aws 보안상 이메일 전송 안됨.
			edto.setReceiveMail(email);
			edto.setSubject("요청하신 임시 비밀번호입니다.\n로그인하여 비밀번호를 변경해주세요.");
			edto.setMessage(vo.getUi_id()+" 님의 비밀번호입니다.");
			
			emailService.sendMail(edto, new_pw);
			*/
			
			log.info("임시 비밀번호 발송"+email);
			log.info("===== 비밀번호 : "+new_pw);
			
			entity = new ResponseEntity<>(new_pw, HttpStatus.OK);
		} else {
			entity = new ResponseEntity<>(HttpStatus.OK);
		}
		
		
		/*
		UserInfoVO vo = service.find_pw(ui_id, ui_name);
		EmailDTO dto = new EmailDTO();
		
		
		if(vo != null) {
			// 메일전송 작업
			dto.setReceiveMail(vo.getUi_email());
			dto.setSubject("요청하신 비밀번호입니다.");
			dto.setMessage("비밀번호: ");			
			emailService.sendMail(dto, vo.getUi_pw());

			entity = new ResponseEntity<>(vo.getUi_pw(), HttpStatus.OK);
		} else {
			entity = new ResponseEntity<>(HttpStatus.OK);
		}
		*/
		return entity;
	}
	
	// 4.0 회원정보 수정 전 비밀번호 입력
	@GetMapping("/auth")
	public void auth_password() {
		log.info("GET auth");
	}
	
	// 회원정보 수정 확인 후 페이지 이동
	@PostMapping("/auth")
	public String auth_password(String ui_pw, HttpSession session, RedirectAttributes rttr, Model model) throws Exception {
		log.info("POST auth");
		
		UserInfoVO user = (UserInfoVO) session.getAttribute("loginStatus");
		
		if(cryPasswordEnc.matches(ui_pw, user.getUi_pw())) {
			
			model.addAttribute(service.user_info(user.getUi_id()));
			return "/user/modify";
		}
		
		rttr.addFlashAttribute("status", "fail");
		
		return "redirect:/user/auth";
	}
	
	// 4. 회원정보 수정 주소
	@GetMapping("/modify")
	public void user_info(HttpSession session, Model model) throws Exception {
		log.info("GET modify..");
		
		// session에 저장된 "loginStatus" Attribute를 불러와 UserInfoVO로 타입을 변환, ui_id를 가져온다.
		//String ui_id = ((UserInfoVO) session.getAttribute("loginStatus")).getUi_id();
		/*
		UserInfoVO vo = service.user_info(ui_id);
		model.addAttribute("vo", vo);
		*/
		// key: userInfoVO (첫글자는 소문자)
		//model.addAttribute(service.user_info(ui_id));
	}
	
	// 4.1 회원정보 수정 기능
	@PostMapping("/modify")
	public String info_modify(UserInfoVO vo, RedirectAttributes rttr, HttpSession session) throws Exception {
		log.info("info modify..");
		
		String result = "modify_FAIL";

		String ui_id = ((UserInfoVO) session.getAttribute("loginStatus")).getUi_id();
		vo.setUi_id(ui_id);
		
		if(service.info_modify(vo) == true) {
			result = "modify_OK";
		} else
		
		rttr.addFlashAttribute("status", result);
		
		return "redirect:/";
	}
	
	// 4.1.1 비밀번호 수정 폼
	@GetMapping("/password")
	public void password() {
		log.info("GET password");
	}
	// 4.1.2 비밀번호 수정 기능
	@ResponseBody
	@PostMapping("/password")
	public ResponseEntity<String> password(String ui_pw, String new_pw, HttpSession session) throws Exception {
		log.info("POST 비밀번호 변경");
		
		ResponseEntity<String> entity;
		
		UserInfoVO user = (UserInfoVO) session.getAttribute("loginStatus");
		
		try {
			// 암호화 비밀번호 확인 후 암호화 시켜 비밀번호 변경.
			if(cryPasswordEnc.matches(ui_pw, user.getUi_pw())) {
				user.setUi_pw(cryPasswordEnc.encode(new_pw));
				service.password_modify(user);

				entity = new ResponseEntity<>("success", HttpStatus.OK);
				session.invalidate();
			} else {
				entity = new ResponseEntity<>("password", HttpStatus.OK);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 5. 회원 탈퇴 폼
	@GetMapping("/delete")
	public void delete() throws Exception {
		log.info("GET delete..");
	}
	
	// 5.1 회원 탈퇴 기능
	@ResponseBody
	@PostMapping("/delete")
	public ResponseEntity<String> delete(String ui_pw, HttpSession session) throws Exception {
		log.info("delete..");
		
		ResponseEntity<String> entity;
		UserInfoVO user = (UserInfoVO) session.getAttribute("loginStatus");
		
		try {
			// 비밀번호 비교
			if(cryPasswordEnc.matches(ui_pw, user.getUi_pw())) {
				
				service.user_delete(user.getUi_id(), user.getUi_pw());
				entity = new ResponseEntity<>("success", HttpStatus.OK);
				
				session.invalidate();
			} else {
				entity = new ResponseEntity<>("fail", HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 6. 마이페이지
	@GetMapping("/mypage")
	public String mypage() {
		log.info("My Page");
		
		
		return "/user/mypage";
	}
	
	
	// 6.1 쇼핑(주문)내역 AJAX 요청 리스트
	@GetMapping(value = "/mypage/order/{page}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<MyOrderDTO>> mypageOrderList(HttpSession session, @PathVariable("page") Integer page) throws Exception {
		log.info("My Page Order List..");
		ResponseEntity<List<MyOrderDTO>> entity;
		
		String user = ((UserInfoVO) session.getAttribute("loginStatus")).getUi_id();
		
		Criteria cri = new Criteria(page, 3);
		
		try {
			entity = new ResponseEntity<>(service.mypageOrderList(user, cri), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.OK);
		}
		
		return entity;
	}
	// 6.2 상품후기 목록 AJAX 요청
	@GetMapping(value = "/mypage/review/{page}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<MyReviewDTO>> mypageReviewList(HttpSession session, @PathVariable("page") Integer page) throws Exception {
		log.info("My Page Review List..");
		ResponseEntity<List<MyReviewDTO>> entity;
		
		String user = ((UserInfoVO) session.getAttribute("loginStatus")).getUi_id();
		
		Criteria cri = new Criteria(page, 5);
		
		try {
			entity = new ResponseEntity<>(service.mypageReviewList(user, cri), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.OK);
		}
		
		return entity;
	}
	
	// 6.3 문의내역 목록 AJAX 요청
	@GetMapping(value = "/mypage/board/{page}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<MyBoardDTO>> mypageBoardList(HttpSession session, @PathVariable("page") Integer page) throws Exception {
		log.info("My Page Board List..");
		ResponseEntity<List<MyBoardDTO>> entity;
		
		String user = ((UserInfoVO) session.getAttribute("loginStatus")).getUi_id();
		
		Criteria cri = new Criteria(page, 5);
		
		try {
			entity = new ResponseEntity<>(service.mypageBoardList(user, cri), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.OK);
		}
		
		return entity;
	}
	
	@ResponseBody
	@GetMapping(value = "/mypage/board/cnt", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<String> mypageBoardCnt(long board_num) throws Exception {
		log.info("My Page Board Content");
		ResponseEntity<String> entity;
		
		try {
			entity = new ResponseEntity<>(service.mypageBoardCnt(board_num), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.OK);
		}
		
		return entity;
	}
}
