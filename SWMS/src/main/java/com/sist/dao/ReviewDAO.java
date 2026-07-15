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
    
    
    
}
