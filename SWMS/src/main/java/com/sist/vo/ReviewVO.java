package com.sist.vo;
import java.util.*;

import lombok.Data;
/*
 * REVIEW_NO  NOT NULL NUMBER         
	GOODS_NO   NOT NULL NUMBER         
	SUBJECT    NOT NULL VARCHAR2(50)   
	CONTENT    NOT NULL CLOB           
	ID         NOT NULL VARCHAR2(20)   
	HIT                 CHAR(1)        
	LIKE_COUNT          NUMBER         
	CREATED_AT          DATE           
	IMAGE               VARCHAR2(2000) 
 * 
 */
@Data
public class ReviewVO {
     private int review_no,goods_no,like_count,order_no;
     private String subject,content,hit,image,dbday,id,nickname;
     private Date created_at;
     private Boolean bCheck;
     private GoodsVO goods;
     private OrderDetailVO od;
     private OrdersVO ov;
}
