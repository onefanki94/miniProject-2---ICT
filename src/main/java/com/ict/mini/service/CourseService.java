package com.ict.mini.service;

import java.util.List;

import com.ict.mini.vo.CourseVO;
import com.ict.mini.vo.PagingVO;

public interface CourseService {
	public int totalRecord(PagingVO pvo);
	public List<CourseVO> courseSelectPaging(PagingVO pvo);
	public int courseInsert(CourseVO vo);
	public CourseVO courseSelect(int news_no); 
	public void hitCount(int news_no, String logId);
	public int courseUpdate(CourseVO vo);
	public int courseDelete(int news_no, String userid);
	public int updateReplyCount(int news_no);
	//일단 쓸것
	public List<CourseVO> cSelectAll();
	//관리자가 하나씩 삭제
	public void cOneDel(int news_no);
	public void delClist(List<String>delClist);
	public  List<CourseVO> getUserCourses(String userid);

}
