package com.sist.vo;

import java.util.Date;

import lombok.Data;

@Data
public class HistoryVO {
	private int no, stock_no, order_no, quantity, inout_size;
	private String chk, created_by, dbday, goods_name;
	private Date inout_date, created_at;
}
