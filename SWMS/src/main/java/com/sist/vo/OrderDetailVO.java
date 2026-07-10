package com.sist.vo;

import lombok.Data;

/*
 * 	ORDER_DETAIL_NO NOT NULL NUMBER       
	ORDER_NO        NOT NULL NUMBER       
	GOODS_NO        NOT NULL NUMBER       
	SIZES           NOT NULL NUMBER       
	QUANTITY        NOT NULL NUMBER       
	PRICE           NOT NULL NUMBER       
	STATUS                   VARCHAR2(50)
 */
@Data
public class OrderDetailVO {
	private int order_detail_no,order_no,goods_no,sizes,quantity,price;
	private String status;
}
