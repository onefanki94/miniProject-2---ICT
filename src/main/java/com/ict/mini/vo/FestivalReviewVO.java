package com.ict.mini.vo;

import lombok.Data;

@Data
public class FestivalReviewVO {
   public int review_no;
   public int festival_no;
   public String userid;
   public String contents;
   public String writedate;
   public int rating;
}
