package com.sist.vo;

import lombok.Data;

/*
CATEGORY_NO   NOT NULL NUMBER       
CATEGORY_NAME NOT NULL VARCHAR2(50) 
 * */
@Data
public class CategoryVO {
	private int category_no;
	private String category_name;
}
