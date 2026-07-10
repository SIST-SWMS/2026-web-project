package com.sist.vo;
/*
 * 	ORDER_NO             NOT NULL NUMBER        
	ID                   NOT NULL VARCHAR2(20)  
	ORDER_DATE           NOT NULL DATE          
	DELIVERY_NAME        NOT NULL VARCHAR2(51)  
	DELIVERY_PHONE       NOT NULL VARCHAR2(20)  
	DELIVERY_ZIPCODE     NOT NULL VARCHAR2(10)  
	DELIVERY_ADDR        NOT NULL VARCHAR2(200) 
	DELIVERY_ADDR_DETAIL          VARCHAR2(200) 
	DELIVERY_MSG                  VARCHAR2(600) 
	TOTAL_PRICE          NOT NULL NUMBER        
	DELIVERY_STATUS      NOT NULL VARCHAR2(50)
 */
import java.util.*;
import lombok.Data;

@Data
public class OrdersVO {
	private int order_no,total_price;
	private String id,delivery_name,delivery_phone,delivery_zipcode,delivery_addr,delivery_addr_detail,
		delivery_msg,delivery_status;
	private Date order_date;
}
