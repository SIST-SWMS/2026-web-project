package com.sist.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.CartVO;
import com.sist.vo.OrderDetailVO;
import com.sist.vo.OrdersVO;

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
	public static OrderDetailVO orderListData(Map map) {
		SqlSession session = ssf.openSession();
		OrderDetailVO vo = session.selectOne("orderListData", map);
		session.close();
		return vo;
	}
	
	/*
	 * 	<select id="getOrderNo" resultType="int">
			SELECT order_no_seq.nextval from dual
		</select>
	 */
	public static int getOrderNo()
	{
		SqlSession session = ssf.openSession();
		int no = session.selectOne("getOrderNo");
		session.close();
		return no;
	}
	
	/*
	 * 	<insert id="insertOrderData" parameterType="OrdersVO">
			INSERT INTO orders (order_no,id,delivery_name,delivery_phone,delivery_zipcode,delivery_addr,delivery_addr_detail,delivery_msg,total_price)
			VALUES (
				#{no},
				#{id},
				#{delivery_name},
				#{delivery_phone},
				#{delivery_zipcode},
				#{delivery_addr},
				#{delivery_addr_detail}',
				#{delivery_msg},
				#{price})
		</insert>
	 */
	public static void insertOrderData(OrdersVO vo)
	{
		SqlSession session = ssf.openSession(true);
		session.insert("insertOrderData", vo);
		session.close();
	}
	
	/*
	 * 	<insert id="insertOrderDetailData" parameterType="OrderDetailVO">
			INSERT INTO order_detail (order_detail_no,order_no,goods_no,sizes,quantity,price,status)
			VALUES (
				order_detail_no_seq.NEXTVAL,
				#{order_no},
				#{goods_no},
				#{sizes},
				#{quantity},
				#{price},
				#{status}
			)
		</insert>
	 */
	public static void insertOrderDetailData(OrderDetailVO vo)
	{
		SqlSession session = ssf.openSession(true);
		session.insert("insertOrderDetailData", vo);
		session.close();
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
