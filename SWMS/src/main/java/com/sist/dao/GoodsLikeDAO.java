package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.GoodsLikeVO;

public class GoodsLikeDAO {
    private static SqlSessionFactory ssf;

    static {
        ssf = CreateSqlSessionFactory.getSsf();
    }

    // 좋아요 목록
    public static List<GoodsLikeVO> likeListData(String id) {
        SqlSession session = ssf.openSession();

        List<GoodsLikeVO> list = session.selectList("likeListData", id);

        session.close();
        return list;
    }

    // 좋아요 삭제
    public static void likeDelete(Map map) {
        SqlSession session = ssf.openSession(true);

        session.delete("likeDelete", map);

        
        session.close();
    }
}