package com.ict.mini.dao;

import java.util.List;

import com.ict.mini.vo.InquiryVO;
import com.ict.mini.vo.PagingVO;

public interface RootPageDAO {
	public int totalAllinquiry(PagingVO pVO);
	public List<InquiryVO> Allinquiry (PagingVO pVO);

	
}
