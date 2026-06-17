package com.ict.mini.service;

import java.util.List;

import com.ict.mini.vo.CourseReplyVO;

public interface CourseReplyService {
	//´ñ±Ûµî·Ï
		public int replyInsert(CourseReplyVO vo);
		//´ñ±Û¸ñ·Ï
		public List<CourseReplyVO> replySelectList(int news_no);
		//´ñ±Û¼öÁ¤
		public int replyUpdate(CourseReplyVO vo);
		//´ñ±Û»èÁ¦
		public int replyDelete(int reply_no, String userid);
}
