package com.sist.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.CartVO;
import com.sist.vo.OrderDetailVO;

import java.util.*;

public class OrderDAO {
	private static SqlSessionFactory ssf;
	static
	{
		ssf = CreateSqlSessionFactory.getSsf();
	}
	
	/*
	 * 	<select id="orderListData" resultMap="OrderDetailMap" parameterType="hashmap" >
			SELECT g.goods_name, s.sizes, g.goods_price
			FROM stock s
			JOIN goods g ON s.goods_no=g.goods_no
			WHERE s.stock_no=#{stock_no}
		</select>
	 */
	public static List<OrderDetailVO> orderListData(Map map)
	{
		SqlSession session = ssf.openSession();
		List<OrderDetailVO> list = session.selectList("orderListData", map);
		session.close();
		return list;
	}
}
