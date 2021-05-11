package com.simpf.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.simpf.domain.CategoryVO;
import com.simpf.domain.ProductVO;
import com.simpf.dto.Criteria;
import com.simpf.dto.PageDTO;
import com.simpf.service.AdminProductService;
import com.simpf.util.FileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/admin/product/*")
@Log4j
public class AdminProductController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminProductService service;
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	// 상품등록 폼: 1차 카테고리 정보를 출력해야한다.
	@GetMapping("/insert")
	public String product_insert(Model model) throws Exception {
		log.info("GET product_insert..");
		
		
		model.addAttribute("category", service.getCategoryList());
		
		return "/admin/product/product_insert";
	}
	
	// 2차 카테고리 출력
	@ResponseBody
	@GetMapping("/categoryList/{cg_code}")
	public ResponseEntity<List<CategoryVO>> subCategory(@PathVariable("cg_code") String cg_code) throws Exception {
		
		ResponseEntity<List<CategoryVO>> entity = null;
		
		try {
			
			entity = new ResponseEntity<List<CategoryVO>>(service.getSubCategoryList(cg_code), HttpStatus.OK);
			
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return entity;
	}
	// 상품 등록
	@PostMapping("/insert")
	public String product_insert(ProductVO vo, RedirectAttributes rttr) throws Exception {
		log.info("insert.." + vo);
		
		// 1) 파일업로드 작업
		vo.setPd_image(FileUtils.uploadFile(uploadPath, vo.getFile1().getOriginalFilename(), vo.getFile1()));
		// 2) 상품DB 삽입
		service.product_insert(vo);
		
		return "redirect:/admin/product/list";
	}
	
	// CKEditor 4.0 업로드 처리(상품 상세설명에 사용하는 이미지에 대한 업로드)
	@PostMapping("/imgUpload")
	public void imgUpload(HttpServletRequest req, HttpServletResponse res, MultipartFile upload) {
		log.info("imgUpload");
		// 출력스트림을 이용하여 파일업로드 작업.
		
		OutputStream out = null;
		PrintWriter printWriter = null;
		
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html; charset=utf-8");
		
		try {
			String fileName = upload.getOriginalFilename();
			byte[] bytes = upload.getBytes();
			
			// was(tomcat 9.0)에서 관리하는 프로젝트의 루트경로를 참고, 실제 업로드 경로를 반환
			String uploadPath = req.getSession().getServletContext().getRealPath("/") + "resources\\upload\\";
			
			// 리눅스 업로드 경로
			//String uploadPath = "/usr/local/tomcat/tomcat-9/webapps/upload/";
			if(!new File(uploadPath).exists()) new File(uploadPath).mkdir();
			
			uploadPath = uploadPath + fileName;
			
			log.info("CKEditor 파일업로드 경로 : "+uploadPath);
			
			out = new FileOutputStream(new File(uploadPath));
			out.write(bytes);
			
			// CKEditor에게 업로드한 파일정보를 돌려주어야 한다.
			printWriter = res.getWriter();
			// 클라이언트가 직접 요청하는 경로
			//String fileUrl = "/ckeditor/upload/" + fileName;
			String fileUrl = "/upload/" + fileName;
			
			// {"filename":"abc.gif", "uploaded":1, "url":"/upload/abc.gif"} json포맷
			printWriter.println("{\"filename\":\"" + fileName + "\", \"uploaded\":1,\"url\":\"" + fileUrl + "\"}");
			printWriter.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(printWriter != null) {
				printWriter.close();
			}
		}
	}
	// 상품 리스트
	@GetMapping("/list")
	public String product_list(@ModelAttribute("cri") Criteria cri, Model model) throws Exception {
		log.info("GET product_list..");
		
		// 리스트 출력
		model.addAttribute("pro_list", service.product_list(cri));
		// 페이징
		int total = service.product_count(cri);
		
		model.addAttribute("paging", new PageDTO(cri, total));
		
		return "/admin/product/product_list";
	}
	
	// 상품 수정 폼
	@GetMapping("/update")
	public String product_update(@RequestParam("pd_code") Long pd_code, @ModelAttribute("cri") Criteria cri, Model model) throws Exception {
		log.info("GET product_update..");

		// 수정폼 정보 출력
		ProductVO vo = service.product_info(pd_code);
		
		// 1차 카테고리
		model.addAttribute("category", service.getCategoryList());
		
		// 2차 카테고리
		String cg_parent_code = vo.getCg_parent_code();
		List<CategoryVO> cateVO = service.getSubCategoryList(cg_parent_code);
		model.addAttribute("sub_category", cateVO);
		
		model.addAttribute("product", vo);
		
		return "/admin/product/product_update";
	}
	// 상품이미지 뷰
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		
		
		return FileUtils.getFile(uploadPath, fileName);
	}
	
	// 상품 수정
	@PostMapping("/update")
	public String product_update(ProductVO vo, Criteria cri, RedirectAttributes rttr) throws Exception {
		log.info("update..");
		
		// 상품 이미지 변경 시
		if(vo.getFile1() != null && vo.getFile1().getSize() > 0) {
			// 기존 이미지파일 삭제
			String oldImageFileName = vo.getPd_image();
			FileUtils.deleteFile(uploadPath, oldImageFileName);
			
			vo.setPd_image(FileUtils.uploadFile(uploadPath, vo.getFile1().getOriginalFilename(), vo.getFile1()));
			
		}
		service.product_update(vo);
		// 리스트의 원래상태 정보
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/admin/product/list";
	}
	
	// 상품 삭제
	@GetMapping("/delete")
	public String product_delete(ProductVO vo, Criteria cri, RedirectAttributes rttr) throws Exception {
		log.info("delete..");
		
		FileUtils.deleteFile(uploadPath, vo.getPd_image());
		
		service.product_delete(vo.getPd_code());
		
		// 리스트의 원래상태 정보 (페이지는 1로 가기)
		rttr.addAttribute("page", 1);
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/admin/product/list";
	}
	
	// 상품 목록에서 판매여부 바꾸기
	@PostMapping("/buyUpdate")
	@ResponseBody
	public ResponseEntity<String> buyUpdate() throws Exception {
		log.info("POST buy update..");
		
		return null;
	}
	
}
