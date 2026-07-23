package com.sist.dao;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.*;
import com.sist.commons.*;

public class CartDAO {
	private static SqlSessionFactory ssf;
	static
	{
		ssf = CreateSqlSessionFactory.getSsf();
	}
	
	/*
	 * 	<select id="cartListData" resultType="CartVO" parameterType="string">
			SELECT c.cart_no,s.no,g.goods_no,
				c.sizes,c.quantity,
			    g.poster_url,g.goods_name,g.goods_price,g.brand_no
			FROM cart c JOIN stock s ON c.stock_no=s.no
			JOIN goods g ON s.no=g.goods_no
			WHERE c.id=#{id}
			ORDER BY c.created_at DESC
		</select>
	 */
	public static List<CartVO> cartListData(String id)
	{
		SqlSession session = null;
		List<CartVO> list = null;
		try 
		{
			session = ssf.openSession();
			list = session.selectList("cartListData", id);
			
		} catch (Exception ex) {
			if(session != null) session.close();
		}
		
		return list;
	}
	
	/*
	 * 	<delete id="cartDeleteData" parameterType="int">
			DELETE FROM cart WHERE cart_no=#{cart_no};
		</delete>
	 */
	public static void cartDeleteData(int goods_no)
	{
		SqlSession session = ssf.openSession(true);
		session.delete("cartDeleteData", goods_no);
		session.close();
	}
	
	/*
	 * 	<update id="cartUpdateQuantity" parameterType="CartVO">
			UPDATE cart SET quantity = quantity + #{newQuan}
			WHERE id=#{id} and cart_no=#{cart_id}
		</update>
	 */
	public static void cartUpdqteQuantity(CartVO vo)
	{
		SqlSession session = ssf.openSession(true);
		session.update("cartUpdateQuantity", vo);
		session.close();
	}

}
