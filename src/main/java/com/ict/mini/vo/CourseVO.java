package com.ict.mini.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CourseVO {
	private int news_no;
	private String subject;
	private String content;
	private String userid;
	private int hit;
	private String writedate;
	private String ip;
	private String thumb;
	private String schedule;
	private int reply_count;


	
	
	public CourseVO(String subject, String content, String userid, String ip){
		this.subject = subject;
		this.content = content;
		this.userid = userid;
		this.ip = ip;
	}

}

