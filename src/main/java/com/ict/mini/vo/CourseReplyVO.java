package com.ict.mini.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public class CourseReplyVO {
		private int reply_no;
		private int news_no;
		private String userid;
		private String comments;
		private String writedate;
		
}

