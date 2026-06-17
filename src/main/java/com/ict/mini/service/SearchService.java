package com.ict.mini.service;

import java.util.List;

import com.ict.mini.vo.CourseVO;
import com.ict.mini.vo.FestivalVO;
import com.ict.mini.vo.PagingVO;
import com.ict.mini.vo.RestVO;

public interface SearchService {
	List<FestivalVO> searchFestivals(PagingVO pvo);
	List<RestVO> searchFoods(PagingVO pvo);
	List<CourseVO> searchCourses(PagingVO pvo);
	public int countFestivals(String searchWord);
	public int countFoods(String searchWord);
	public int countCourses(String searchWord);
}
