package com.ict.mini.vo;

import lombok.Data;

@Data
public class RestReviewVO {
	private int review_no;
	private int rest_code;
	private String userid;
	private String contents;
	private String writedate;
	private int rating;
}
