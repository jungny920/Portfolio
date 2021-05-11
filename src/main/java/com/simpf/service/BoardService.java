package com.simpf.service;

import com.simpf.domain.BoardVO;
import com.simpf.dto.BoardDTO;
import com.simpf.dto.Criteria;

public interface BoardService {
	
	// 문의하기
	public void addQuestion(BoardVO vo) throws Exception;
	
	public BoardDTO listQuestion(Criteria cri, long pd_code) throws Exception;
}
