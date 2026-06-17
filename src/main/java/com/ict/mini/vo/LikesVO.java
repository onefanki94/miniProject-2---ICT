package com.ict.mini.vo;

import lombok.Data;


@Data

public class LikesVO {
    private int userid;        // 회원 ID
    private int no;   // 좋아요 한 게시글 ID
    private int rest_code;     // 좋아요 한 음식점 코드

}