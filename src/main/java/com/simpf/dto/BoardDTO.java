package com.simpf.dto;

import java.util.List;

import com.simpf.domain.BoardVO;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class BoardDTO {
	
	private int count;
	private List<BoardVO> list;
}
