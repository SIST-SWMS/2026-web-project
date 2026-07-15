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
	 /*
	  * <update id="goodsHitIncrement" parameterType="int">
			UPDATE goods SET
			hit=hit+1
			WHERE goods_no=#{goods_no}
		</update>
		*/
	 /*
		<select id="goodsDetailData" resultType="GoodsVO" parameterType="int">
			SELECT goods_no, goods_name, goods_code, b.brand_name, goods_price, poster_url, subposter_url, hit
			FROM goods g JOIN brand b
			ON g.brand_no=b.brand_no AND g.goods_no=#{goods_no} 	
		</select>
	  */
	 public static GoodsVO goodsDetailData (int no) {
		 SqlSession session=ssf.openSession(true);
		 session.update("goodsHitIncrement",no);
		 GoodsVO vo=session.selectOne("goodsDetailData",no);
		 session.close();
		 return vo;
	 }
	 /*
	  * <select id="goodsFindListData" resultType="GoodsVO" parameterType="hashmap">
			SELECT goods_no, goods_name
			FROM goods
			WHERE ${column} LIKE '%'||#{fd}||'%'
			ORDER BY goods_no ASC
			OFFSET #{start} ROWS FETCH NEXT 12 ROWS ONLY	
		</select>
		<select id="goodsFindTotalPage" resultType="int" parameterType="hashmap">
			SELECT CEIL(COUNT(*)/12.0)
			FROM goods
			WHERE ${cno} LIKE '%'||#{fd}||'%'
		</select>
	  */
	 public static List<GoodsVO> goodsFindListData(Map map) {
		 SqlSession session=ssf.openSession();
		 List<GoodsVO> list=session.selectList("goodsFindListData",map);
		 session.close();
		 return list;
	 }
	 public static int goodsFindTotalPage(Map map) {
		 SqlSession session=ssf.openSession();
		 int total=session.selectOne("goodsFindTotalPage",map);
		 session.close();
		 return total;
	 }
}
