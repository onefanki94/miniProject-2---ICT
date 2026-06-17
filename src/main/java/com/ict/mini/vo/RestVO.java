package com.ict.mini.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RestVO {
    private int rest_code;
    private String store_name;
    private String zipcode;
    private String addr;
    private String X_point;
    private String Y_point;
    private String explanation;
    private String tel;
    private String opentime;
    private String rest;
    private String repMenu;    
    private String menu1; // Update this to menu1 as in the table definition
    private String reservation;
    private String category;
    private String imageurl;
    private String imageurl1;
    private String imageurl2;
    private String imageurl3;
    private int hit;
    private int likes;
}
