package com.simpf.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.simpf.domain.BoardVO;
import com.simpf.domain.UserInfoVO;
import com.simpf.dto.BoardDTO;
import com.simpf.dto.Criteria;
import com.simpf.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
public class BoardController {

	@Setter(onMethod_ = @Autowired)
	private BoardService boardService;
	
	// 문의 리스트 출력
	@GetMapping(value = "/list/{pd_code}/{page}", 
			produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<BoardDTO> boardList(@PathVariable("pd_code") Long pd_code, @PathVariable("page") int page) throws Exception {
		log.info("GET board list");
		
		ResponseEntity<BoardDTO> entity;
		Criteria cri = new Criteria(page, 10);
		
		try {
			entity = new ResponseEntity<>(boardService.listQuestion(cri, pd_code), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	// 문의하기
	@ResponseBody
	@PostMapping("/add")
	public ResponseEntity<String> addQuestion(BoardVO vo, HttpSession session) throws Exception {
		log.info("POST addQuestion");
		
		String user = ((UserInfoVO) session.getAttribute("loginStatus")).getUi_id();
		vo.setUi_id(user);
		
		ResponseEntity<String> entity;
		
		try {
			boardService.addQuestion(vo);
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
}
