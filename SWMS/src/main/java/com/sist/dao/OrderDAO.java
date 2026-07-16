package com.sist.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.CartVO;
import com.sist.vo.OrderDetailVO;

import java.util.*;

public class OrderDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf = CreateSqlSessionFactory.getSsf();
	}

	/*
	 * <select id="orderListData" resultMap="OrderDetailMap" parameterType="hashmap"
	 * > SELECT g.goods_name, s.sizes, g.goods_price FROM stock s JOIN goods g ON
	 * s.goods_no=g.goods_no WHERE s.stock_no=#{stock_no} </select>
	 */
	public static List<OrderDetailVO> orderListData(Map map) {
		SqlSession session = ssf.openSession();
		List<OrderDetailVO> list = session.selectList("orderListData", map);
		session.close();
		return list;
	}

	/*
	 * <select id="myOrderDetailData" resultMap="orderdetailMap"
	 * parameterType="string"> SELECT
	 * o.order_date,o.order_no,o.total_price,o.delivery_status,g.goods_name FROM
	 * order_detail od JOIN orders o ON od.order_no = o.order_no JOIN goods g ON
	 * g.goods_no = od.goods_no WHERE id = #{id} ORDER BY id DESC </select>
	 */

	public static List<OrderDetailVO> myOrderDetailData(String id) {
		SqlSession session = ssf.openSession();
		List<OrderDetailVO> list = session.selectList("myOrderDetailData", id);
		session.close();
		return list;
	}
}
