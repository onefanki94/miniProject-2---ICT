package com.ict.mini.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.ict.mini.dao.CourseReplyDAO;
import com.ict.mini.vo.CourseReplyVO;

@Service
public class CourseReplyServiceImpl implements CourseReplyService {
	@Inject
	CourseReplyDAO dao;

	@Override
	public int replyInsert(CourseReplyVO vo) {
		// TODO Auto-generated method stub
		return dao.replyInsert(vo);
	}

	@Override
	public List<CourseReplyVO> replySelectList(int news_no) {
		// TODO Auto-generated method stub
		return dao.replySelectList(news_no);
	}

	@Override
	public int replyUpdate(CourseReplyVO vo) {
		// TODO Auto-generated method stub
		return dao.replyUpdate(vo);
	}

	@Override
	public int replyDelete(int reply_no, String userid) {
		// TODO Auto-generated method stub
		return dao.replyDelete(reply_no, userid);
	}
	
}
