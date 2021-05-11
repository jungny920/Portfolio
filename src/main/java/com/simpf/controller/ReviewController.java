package com.simpf.controller;

import javax.annotation.Resource;
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

import com.simpf.domain.ReviewVO;
import com.simpf.domain.UserInfoVO;
import com.simpf.dto.Criteria;
import com.simpf.dto.ReviewDTO;
import com.simpf.service.ReviewService;
import com.simpf.util.FileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/review/*")
public class ReviewController {

	// @AllArgsConstructor: 모든 필드에 생성자메서드가 생성이되고 생성자는 어노테이션을 생략하고 자동으로 주입받을 수 있다.
	@Setter(onMethod_ = @Autowired)
	private ReviewService reviewService; 
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	// 리뷰 페이지 출력
	@GetMapping(value = "/pages/{pd_code}/{page}", 
			produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<ReviewDTO> reviewListPage(@PathVariable("pd_code") Long pd_code, @PathVariable("page") int page) throws Exception {
		log.info("GET reviewListPage..");
		
		ResponseEntity<ReviewDTO> entity;
		Criteria cri = new Criteria(page, 5);
		
		try {
			entity = new ResponseEntity<>(reviewService.reviewList(cri, pd_code), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 리뷰(상품후기) 추가
	@ResponseBody
	@PostMapping("/add")
	public ResponseEntity<String> reviewAdd(ReviewVO vo, HttpSession session) throws Exception {
		log.info("POST reviewAdd.." + vo);
		ResponseEntity<String> entity;
		
		String user = ((UserInfoVO) session.getAttribute("loginStatus")).getUi_id();
		
		vo.setUi_id(user);
		
		try {
			if(vo.getFile1().getSize() != 0 && vo.getFile1() != null) {
				// 리뷰 이미지 파일 존재 시 출력
				vo.setRv_image(FileUtils.uploadFile(uploadPath, vo.getFile1().getOriginalFilename(), vo.getFile1()));
			} else {
				// 리뷰 이미지 파일 존재하지 않으면 출력하지않음
				vo.setRv_image("");
			}
			
			log.info("리뷰 이미지!!"+vo.getRv_image());
			
			reviewService.reviewAdd(vo);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	// 상품후기 수정 AJAX 처리
	@ResponseBody
	@PostMapping("/modify")
	public ResponseEntity<String> reviewModify(ReviewVO vo) throws Exception {
		log.info("POST modify.." + vo);
		ResponseEntity<String> entity;
		
		// 이미지파일 수정여부 확인 후 기존 이미지 삭제 및 추가
		// 수정 전 기존 데이터 비교하기 위한 ReviewVO
		ReviewVO data = reviewService.reviewData(vo.getRv_num());
		
		try {
			// 리뷰 이미지 등록 확인
			if(vo.getFile1().getSize() != 0 && vo.getFile1() != null) {
				// 이미지 파일 추가 작업
				vo.setRv_image(FileUtils.uploadFile(uploadPath, vo.getFile1().getOriginalFilename(), vo.getFile1()));
				
				// 기존 리뷰 이미지 존재 여부 확인
				if(data.getRv_image() != null) {
					// 기존 이미지 존재하면 이미지 삭제 작업
					FileUtils.deleteFile(uploadPath, data.getRv_image());
				}
				
			} else {
				// 리뷰 이미지 파일 존재하지 않으면 출력하지않음
				if(vo.getRv_image() == null) {
					vo.setRv_image("");
				}
			}
			
			reviewService.reviewModify(vo);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 상품후기 삭제 AJAX 처리
	@ResponseBody
	@PostMapping("/delete")
	public ResponseEntity<String> reviewDelete(ReviewVO vo) throws Exception {
		log.info("POST modify.." + vo);
		ResponseEntity<String> entity;
		
		ReviewVO data = reviewService.reviewData(vo.getRv_num());
		
		try {
			if(data.getRv_image() != null) {
				FileUtils.deleteFile(uploadPath, vo.getRv_image());
			}
			
			reviewService.reviewDelete(vo.getRv_num());
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
