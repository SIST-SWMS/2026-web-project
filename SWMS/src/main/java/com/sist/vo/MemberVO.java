package com.sist.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	private String id, pwd, name, nickname, phone, zipcode, address, address_detail, msg;
	private int auth;
	private Date created_at;
}
