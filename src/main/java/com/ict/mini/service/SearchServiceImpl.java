package com.ict.mini.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.mini.dao.SearchDAO;
import com.ict.mini.vo.CourseVO;
import com.ict.mini.vo.FestivalVO;
import com.ict.mini.vo.PagingVO;
import com.ict.mini.vo.RestVO;

import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class SearchServiceImpl implements SearchService {
	
	@Autowired
	SearchDAO dao;

	@Override
	public List<FestivalVO> searchFestivals(PagingVO pvo) {
		//int offset = (pvo.getPage()-1)*pvo.getSize();
		//pvo.setOffset(offset);
		log.info(pvo.toString());
		return dao.searchFestivals(pvo);
	}

	@Override
	public List<RestVO> searchFoods(PagingVO pvo) {
		int offset = (pvo.getPage()-1)*pvo.getSize();
		pvo.setOffset(offset);
		return dao.searchFoods(pvo);
	}

	@Override
	public int countFestivals(String searchWord) {
		return dao.countFestivals(searchWord);
	}

	@Override
	public int countFoods(String searchWord) {
		return dao.countFoods(searchWord);
	}

	@Override
	public List<CourseVO> searchCourses(PagingVO pvo) {
		return dao.searchCourses(pvo);
	}

	@Override
	public int countCourses(String searchWord) {
		return dao.countCourses(searchWord);
	}


}
