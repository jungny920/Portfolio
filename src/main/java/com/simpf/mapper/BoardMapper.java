package com.simpf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.simpf.domain.BoardVO;
import com.simpf.dto.Criteria;

public interface BoardMapper {
	
	// 문의하기
	public void addQuestion(BoardVO vo) throws Exception;
	// 문의 리스트 출력
	public List<BoardVO> listQuestion(@Param("cri") Criteria cri, @Param("pd_code") long pd_code) throws Exception;
	// 문의 페이징위한 전체개수
	public int listCount(long pd_code) throws Exception;

}
