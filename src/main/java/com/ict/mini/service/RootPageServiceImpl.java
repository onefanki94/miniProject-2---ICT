package com.ict.mini.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;


import com.ict.mini.dao.RootPageDAO;
import com.ict.mini.vo.InquiryVO;
import com.ict.mini.vo.PagingVO;


@Service
public class RootPageServiceImpl implements RootPageService {
	@Inject
	RootPageDAO dao;
	@Override
	public int totalAllinquiry(PagingVO pVO) {
		// TODO Auto-generated method stub
		return dao.totalAllinquiry(pVO);
	}

	@Override
	public List<InquiryVO> Allinquiry(PagingVO pVO) {
		// TODO Auto-generated method stub
		return dao.Allinquiry(pVO);
	}

}
