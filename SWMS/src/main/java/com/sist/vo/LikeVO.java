package com.sist.vo;
/*
 * LIKE_NO    NOT NULL NUMBER       
	ID         NOT NULL VARCHAR2(20) 
	GOODS_NO   NOT NULL NUMBER       
	CREATED_AT NOT NULL DATE      
 */
import java.util.*;

import lombok.Data;
@Data
public class LikeVO {
	private int like_no, goods_no;
	private String id, dbday;
	private Date created_at;
}
