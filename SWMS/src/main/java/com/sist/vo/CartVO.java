package com.sist.vo;
/*
 * 	CART_NO    NOT NULL NUMBER       
	ID         NOT NULL VARCHAR2(20) 
	STOCK_NO   NOT NULL NUMBER       
	SIZES      NOT NULL NUMBER       
	QUANTITY   NOT NULL NUMBER       
	CREATED_AT NOT NULL DATE
 */
import java.util.*;
import lombok.Data;

@Data
public class CartVO {
	private int cart_no,stock_no,sizes,quantity;
	private String id;
	private Date created_at;
}
