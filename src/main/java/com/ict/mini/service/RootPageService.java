package com.ict.mini.service;

import java.util.List;

import com.ict.mini.vo.InquiryVO;
import com.ict.mini.vo.PagingVO;

public interface RootPageService {

	public int totalAllinquiry(PagingVO pVO);
	public List<InquiryVO> Allinquiry (PagingVO pVO);

	
}
