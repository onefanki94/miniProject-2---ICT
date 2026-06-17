package com.ict.mini.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class InquiryVO {
	private int index;
	private String userid;
	private String subject;
	private String content;
	private String writedate;
	private int Ok;
	
	
}
