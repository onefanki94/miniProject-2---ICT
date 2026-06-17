package com.ict.mini.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.mini.dao.CourseDAO;
import com.ict.mini.vo.CourseVO;
import com.ict.mini.vo.PagingVO;

@Service
public class CourseServiceImpl implements CourseService {
	@Autowired
	CourseDAO dao;

	
	@Override
	public List<CourseVO> getUserCourses(String userid) {
		return dao.getUserCourses(userid);
	}

	@Override
	public List<CourseVO> courseSelectPaging(PagingVO pvo) {
		return dao.courseSelectPaging(pvo);
	}

	@Override
	public int totalRecord(PagingVO pvo) {
		return dao.totalRecord(pvo);
	}

	@Override
	public int courseInsert(CourseVO vo) {
		return dao.courseInsert(vo);
	}

	
	@Override
	public void hitCount(int news_no, String logId) {
		dao.hitCount(news_no, logId);
	}

	@Override
	public CourseVO courseSelect(int news_no) {
		return dao.courseSelect(news_no);
	}

	@Override
	public int courseUpdate(CourseVO vo) {
		return dao.courseUpdate(vo);
	}

	@Override
	public int courseDelete(int news_no, String userid) {
		return dao.courseDelete(news_no, userid);
	}

	@Override
	public int updateReplyCount(int news_no) {
		return dao.updateReplyCount(news_no);
	}

	@Override
	public List<CourseVO> cSelectAll() {
		
		return dao.cSelectAll();
	}

	@Override
	public void cOneDel(int news_no) {
		dao.cOneDel(news_no);
		
	}

	@Override
	public void delClist(List<String> delClist) {
		dao.delClist(delClist);
		
	}

}
