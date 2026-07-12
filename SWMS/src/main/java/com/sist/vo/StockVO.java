package com.sist.vo;

import java.util.Date;

import lombok.Data;

@Data
public class StockVO {
	private int no, goods_no, goods_size, quantity;
	private Date created_at, updated_at;
}
