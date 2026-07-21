package com.sist.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.*;
import com.sist.vo.*;
public class QnaDAO {
    private static SqlSessionFactory ssf;
    static
    {
    	ssf=CreateSqlSessionFactory.getSsf();
    }
    
    /*
     *  <select id="qnaListData" resultType="QnaVO" parameterType="string">
		   SELECT q.goods_no,
		          g.goods_name,
		          g.poster_url
		   FROM goods g
		   JOIN qna q ON g.goods_no=q.goods_no
		   WHERE q.id=#{id}
		   ORDER BY q.qna_no DESC                   
		  </select>
     * 
     */
    public static List<QnaVO> qnaListData(String id)
    {
    	SqlSession session=ssf.openSession();
    	List<QnaVO> list=session.selectList("qnaListData",id);
    	session.close();
    	return list;
    }
    
    public static QnaVO qnaDetailData(int goods_no)
    {
        SqlSession session = ssf.openSession();
        Map<String, Object> params = new HashMap<>();
        params.put("goods_no", goods_no);
        QnaVO vo = session.selectOne("qnaDetailData", params);
        session.close();
        return vo;
    }
    /*
     * <insert id="qnaInsert" parameterType="QnaVO">
		  INSERT INTO qna(qna_no,parent_no,type,subject,content,status,id,is_secret,created_at,goods_no)
		  VALUES(qna_no_seq.nextval,#{parent_no},#{type}#{subject},#{content},#{status},#{id},#{is_secret},SYSDATE,#{goods_no})
		  
		 </insert>
     * 
     */
    public static void qnaInsert(QnaVO vo)
    {
    	SqlSession session=ssf.openSession(true);
    	session.insert("qnaInsert",vo);
    	session.close();
    }
    /*
     *  <select id="qnaDetail" resultType="QnaVO" parameterType="int">
		   SELECT qna_no, parent_no, type, subject, content, status, id, is_secret, created_at, goods_no
		    FROM qna
		    WHERE qna_no = #{qna_no}
		 </select>
     * 
     */
    public static QnaVO qnaDetail(int qna_no)
    {
    	SqlSession session=ssf.openSession();
    	QnaVO vo=session.selectOne("qnaDetail",qna_no);
    	session.close();
    	return vo;
    }
    
    /*
     * <update id="qnaUpdate" parameterType="QnaVO">
	   UPDATE qna SET
	   type=#{type},
	   subject=#{subject},
	   content=#{content},
	   is_secret=#{is_secret}
	   WHERE qna_no=#{qna_no}   
	 </update>
     * 
     */
    public static QnaVO qnaUpdateData(int no)
    {
        SqlSession session = ssf.openSession();
        QnaVO vo = session.selectOne("qnaUpdateData", no);
        session.close();
        return vo;
    }
    
    public static void qnaUpdate(QnaVO vo)
    {
    	SqlSession session=ssf.openSession();
    	session.update("qnaUpdate",vo);
    	session.commit();
    	session.close();
    }
    
   
    
    /*
     * <delete id="qnaDelete" parameterType="int">
	   DELETE FROM qna
	   WHERE qna_no=#{qna_no}
	 </delete>
     * 
     */
    
    public static void qnaDelete(int vo)
    {
    	SqlSession session=ssf.openSession();
    	session.delete("qnaDelete",vo);
    	session.commit();
    	session.close();
    }
}
