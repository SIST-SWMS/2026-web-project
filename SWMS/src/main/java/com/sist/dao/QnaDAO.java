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
}
