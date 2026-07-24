package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.*;
import com.sist.vo.*;
public class ReviewDAO {
    private static SqlSessionFactory ssf;
    static
    {
    	ssf=CreateSqlSessionFactory.getSsf();
    }
    /*
     * <insert id="reviewInsert" parameterType="ReviewVO">
	  INSERT INTO review(review_no,goods_no,subject,content,id,hit,like_count,created_at,image)
	  VALUES(review_no_seq,#{review_no},#{goods_no},#{subject},#{content},#{id},0,0,SYSDATE,${image})
	 </insert>
     */
    public static void reviewInsert(ReviewVO vo)
    {
    	SqlSession session=ssf.openSession();
    	session.insert("reviewInsert",vo);
    	session.commit();
    	session.close();
    }
    /*
     *
    */ 
      
	/*
	 * <select id="reviewDetail" parameterType="ReviewVO"> SELECT
	 * subject,content,hit,goods_no,id FROM review WHERE
	 * subject=#{subject},#{content},hit=#{hit},good_no=#{goods_no},id=#{id}
	 * </select>
	 */
    public static ReviewVO reviewDetail(int review_no)
    {
        SqlSession session = ssf.openSession();
        ReviewVO vo = session.selectOne("reviewDetail"	, review_no);
        session.close();
        return vo;
    }
    
    /*
     * <select id="reviewTotal" parameterType="int" >
		 SELECT CEIL(COUNT(*)/10.0)
		 FROM review 
		</select>
     * 
     */
  
     
    
	/*
	 * public static ReviewVO reviewDetail(int no) { SqlSession
	 * session=ssf.openSession(); ReviewVO vo=session.selectOne("reviewDetail",no);
	 * session.close(); return vo;
	 * 
	 * }
	 */
    /*
     * <select id="reviewListData" resultType="ReviewVO" parameterType="string">
		select 
		     o.order_no,
		     o.order_date,
		     o.delivery_status,
		     g.poster_url,
		     g.goods_no,
		     g.goods_name,
		     r.review_no
		FROM orders o 
		JOIN order_detail od ON o.order_no=od.order_no
		JOIN goods g ON od.goods_no=g.goods_no
		LEFT JOIN review r ON r.order_no = o.order_no AND r.goods_no = g.goods_no
		WHERE o.id=#{id} AND o.delivery_status='배송완료'
		ORDER BY o.order_date DESC
	 </select>
     * 
     */
    public static List<ReviewVO> reviewListData(String id)
    {
    	SqlSession session=ssf.openSession();
    	List<ReviewVO> list=session.selectList("reviewListData",id);
    	session.close();
    	return list;
    }
    
    /*
     * 
     * 
     */
    
    public static ReviewVO reviewDetailData(int order_no, int goods_no)
    {
        SqlSession session = ssf.openSession();
        Map<String, Object> params = new HashMap<>();
        params.put("order_no", order_no);
        params.put("goods_no", goods_no);
        ReviewVO vo = session.selectOne("reviewDetailData", params);
        session.close();
        return vo;
    }
    
    public static void reviewUpdate(ReviewVO vo)
    {
        SqlSession session = ssf.openSession();
        session.update("reviewUpdate", vo);
        session.commit();
        session.close();
    }

    public static void reviewDelete(int review_no)
    {
        SqlSession session = ssf.openSession();
        session.delete("reviewDelete", review_no);
        session.commit();
        session.close();
    }
    
    /*
     *  <select id="reviewListPaged" resultType="ReviewVO" parameterType="map">
		    SELECT r.review_no, r.subject, r.content, r.hit, r.image, r.created_at,
		           g.goods_name AS "goods.goods_name",
		           g.poster_url AS "goods.poster_url"
		    FROM review r
		    JOIN goods g ON r.goods_no = g.goods_no
		    WHERE r.id = #{id}
		    ORDER BY r.created_at DESC
		    OFFSET #{start} ROWS FETCH NEXT 10 ROWS ONLY
		</select>
     * 
     * 
     */
    public static List<ReviewVO> reviewListPaged(Map map)
    {
    	SqlSession session = ssf.openSession();
    	List<ReviewVO> list=session.selectList("reviewListPaged",map);
    	session.close();
    	return list;
    	
    }
    
    public static int reviewTotal(int start)
    {
    	SqlSession session = ssf.openSession();
    	int total=session.selectOne("reviewTotal",start);
    	session.close();
    	return total;
    }
}
