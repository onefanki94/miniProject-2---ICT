package com.ict.mini.vo;

import lombok.Data;

@Data
public class LikeVO {
	private int like_code;
	private int rest_code;
	private String userid;
	private int likes;
	private int likesCount;
}
