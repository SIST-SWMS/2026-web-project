package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.BrandVO;
import com.sist.vo.CategoryVO;
import com.sist.vo.GoodsVO;

public class AdminDAO {
	private static SqlSessionFactory ssf;
	static {
		try {
			ssf = CreateSqlSessionFactory.getSsf();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static List<GoodsVO> adminGoodsList(Map map) {
		SqlSession session = ssf.openSession();
		List<GoodsVO> list = session.selectList("adminGoodsList", map);
		session.close();
		return list;
	}
	
	public static int adminGoodsTotal(Map map) {
		SqlSession session = ssf.openSession();
		int total = session.selectOne("adminGoodsTotal", map);
		session.close();
		return total;
	}

	public static List<CategoryVO> SearchCategory() {
		SqlSession session = ssf.openSession();
		List<CategoryVO> list = session.selectList("SearchCategory");
		session.close();
		return list;
	}
	public static List<BrandVO> SearchBrand() {
		SqlSession session = ssf.openSession();
		List<BrandVO> list = session.selectList("SearchBrand");
		session.close();
		return list;
	}
}
