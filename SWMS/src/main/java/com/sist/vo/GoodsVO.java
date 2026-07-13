package com.sist.vo;
import java.util.*;
import java.util.Date;

import lombok.Data;


import java.sql.*;
/*
 *  GOODS_NO       NOT NULL NUMBER        
	GOODS_CODE     NOT NULL VARCHAR2(50)  
	GOODS_NAME     NOT NULL VARCHAR2(100) 
	GOODS_PRICE    NOT NULL VARCHAR2(50)  
	GOODS_DISCOUNT          NUMBER        
	POSTER_URL     NOT NULL VARCHAR2(260) 
	SUBPOSTER_URL           VARCHAR2(260) 
	BRAND_NO       NOT NULL NUMBER        
	CATEGORY_NO    NOT NULL NUMBER        
	HIT            NOT NULL NUMBER        
	CREATED_AT     NOT NULL DATE          

 */
@Data
public class GoodsVO {
	private int goods_no, goods_discount, brand_no, category_no, hit, like_count, price; 
	private String goods_code, goods_name, goods_price, poster_url, subposter_url, dbday, brand_name, category_name;
	private Date created_at;
}
