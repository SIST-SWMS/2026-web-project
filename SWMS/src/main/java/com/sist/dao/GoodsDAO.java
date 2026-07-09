package com.sist.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import java.util.*;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.*;
public class GoodsDAO {
	public static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
	/*
	 * <select id="goodsListData" resultType="GoodsVO" parameterType="map">
		SELECT goods_no, goods_code, goods_name, goods_price, goods_discount, poster_url, subposter_url, b.brand_name, hit,
				(SELECT COUNT(*) FROM goods_like gl WHERE g.goods_no=#{goods_no}) as like_count
		FROM goods g JOIN brand b
		ON g.brand_no=b.brand_no
		WHERE g.category_no=#{category_no}
	</select>
	*/
	
	  public static List<GoodsVO> goodsListData(Map map) { 
	  SqlSession session=ssf.openSession();
	  List<GoodsVO> list=session.selectList("goodsListData", map);
	  session.close();
	  return list; 
	  }
	 
	/*
	<select id="goodsTotalPage" resultType="int">
		SELECT CEIL(COUNT(*)/12.0) 
		FROM goods
	</select>
	 */
	 public static int goodsTotalPage(int category_no) {
		 SqlSession session=ssf.openSession();
		 int total=session.selectOne("goodsTotalPage", category_no);
		 session.close();
		 return total;
	 }
}
