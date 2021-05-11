package com.simpf.controller;

import javax.annotation.Resource;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.simpf.util.FileUtils;

@RestController
@RequestMapping("/util/*")
public class UtilController {
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@GetMapping("/image")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		return FileUtils.getFile(uploadPath, fileName);
	}
	
}
