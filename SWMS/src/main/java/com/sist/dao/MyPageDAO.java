package com.sist.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.OrderDetailVO;

public class MyPageDAO {

	private static SqlSessionFactory ssf;
	static {
		try {
			ssf = CreateSqlSessionFactory.getSsf();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 주문목록 - 주문내역 상세보기 조회
	public static List<OrderDetailVO> orderListDetailData(int order_no) {
		SqlSession session = ssf.openSession();

		List<OrderDetailVO> list = session.selectList("orderListDetailData", order_no);

		session.close();

		return list;
	}
} 
