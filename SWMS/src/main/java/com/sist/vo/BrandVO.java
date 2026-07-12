package com.sist.vo;

import lombok.Data;
/*
BRAND_NO   NOT NULL NUMBER       
BRAND_NAME NOT NULL VARCHAR2(50) 
 * */
@Data
public class BrandVO {
	private int brand_no;
	private String brand_name;
}
