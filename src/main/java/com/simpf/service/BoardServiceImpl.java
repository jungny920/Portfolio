package com.simpf.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.simpf.domain.BoardVO;
import com.simpf.dto.BoardDTO;
import com.simpf.dto.Criteria;
import com.simpf.mapper.BoardMapper;

import lombok.Setter;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	@Override
	public void addQuestion(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		boardMapper.addQuestion(vo);
	}

	@Override
	public BoardDTO listQuestion(Criteria cri, long pd_code) throws Exception {
		// TODO Auto-generated method stub
		
		BoardDTO dto = new BoardDTO(boardMapper.listCount(pd_code), boardMapper.listQuestion(cri, pd_code));
		
		return dto;
	}

}
