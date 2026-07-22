package com.sist.vo;

import java.util.Date;

import lombok.Data;
@Data
public class GoodsLikeVO {
    private int like_no;
    private String id;
    private int goods_no;
    private Date created_at;
    private GoodsVO gvo = new GoodsVO();
  
}