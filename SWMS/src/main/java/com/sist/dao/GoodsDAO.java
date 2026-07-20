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
	 /*
	<!-- 1. 재고 있는지 확인 -->
	<select id="stockQuantityCheck" resultType="int" parameterType="map">    
	SELECT quantity  
	FROM stock     
	WHERE goods_no = #{goods_no} 
	AND goods_size = #{goods_size}
	</select>
	*/
	public static StockVO stockQuantityCheck(Map map) {
		SqlSession session=ssf.openSession();
		StockVO vo=session.selectOne("stockQuantityCheck", map);
		session.close();
		return vo;
	}
		
	 /*
	<!-- 2. 장바구니에 똑같은 상품+사이즈가 있는지 확인  -->
	<select id="cartCount" resultType="int" parameterType="map">  
	SELECT COUNT(*)   
	FROM cart     
	WHERE id = #{id} 
	AND stock_no = #{stock_no} 
	AND sizes = #{sizes}
	</select>
	*/
	 public static int cartCount(Map map) {
		 SqlSession session=ssf.openSession();
		 int count=session.selectOne("cartCount",map);
		 session.close();
		 return count;
	 }
	 /*
	<!-- 3. 장바구니에 이미 있으면 수량만 추가  -->
	<update id="cartUpdate" parameterType="map">   
	UPDATE cart 
	SET quantity = quantity + #{quantity}   
	WHERE id = #{id}       
	AND stock_no = #{stock_no}       
	AND sizes = #{sizes}
	</update>
	*/
	public static void cartUpdate(Map map) {
		SqlSession session=ssf.openSession(true);
		session.update("cartUpdate",map);
		session.commit();
		session.close();
	}
	 /*
	<!-- 4. 장바구니에 없으면 새로 담기 -->
	<insert id="cartInsert" parameterType="map">   
	INSERT INTO cart (cart_no, id, stock_no, sizes, quantity)    
	VALUES (cart_no_seq.nextval, #{id}, #{stock_no}, #{sizes}, #{quantity})
	</insert>
	  */
	public static void cartInsert(Map map) {
		SqlSession session=ssf.openSession(true);
		session.insert("cartInsert",map);
		session.commit();
		session.close();
	}
	
	/*
	 <!-- 상품의 리뷰 목록 가져오기 -->
	 <select id="goodsReviewList" resultType="ReviewVO" parameterType="int">
	    SELECT review_no, subject, content, id, hit, TO_CHAR(created_at, 'yyyy-MM-dd') as dbday
	    FROM review
	    WHERE goods_no = #{goods_no}
	    ORDER BY review_no DESC
	</select>
	 */
	public static List<ReviewVO> goodsReviewList(int goods_no) {
		SqlSession session=ssf.openSession();
		List<ReviewVO> list=session.selectList("goodsReviewList", goods_no);
		session.close();
		return list;
	}
}
