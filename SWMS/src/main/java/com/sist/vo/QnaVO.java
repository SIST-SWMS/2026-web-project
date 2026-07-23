package com.sist.vo;
import java.util.*;

import lombok.Data;
/*
 * QNA_NO     NOT NULL NUMBER       
	PARENT_NO           NUMBER       
	TYPE                VARCHAR2(10) 
	SUBJECT    NOT NULL VARCHAR2(50) 
	CONTENT    NOT NULL CLOB         
	STATUS     NOT NULL VARCHAR2(20) 
	ID         NOT NULL VARCHAR2(20) 
	IS_SECRET  NOT NULL VARCHAR2(10) 
	CREATED_AT          DATE         
	GOODS_NO            NUMBER
 * 
 */
@Data
public class QnaVO {
     private int qna_no,parent_no,goods_no;
     private String type,subject,content,status,id,is_secret,dbday;
     private Date created_at;
     private GoodsVO goods = new GoodsVO();
}
