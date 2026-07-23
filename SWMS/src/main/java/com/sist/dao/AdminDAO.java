package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.BrandVO;
import com.sist.vo.CategoryVO;
import com.sist.vo.DashVO;
import com.sist.vo.GoodsVO;
import com.sist.vo.HistoryVO;
import com.sist.vo.OrderDetailVO;
import com.sist.vo.QnaVO;
import com.sist.vo.StockVO;

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

	public static GoodsVO adminGoodsData(int no) {
		SqlSession session = ssf.openSession();
		GoodsVO vo = session.selectOne("adminGoodsData", no);
		session.close();
		return vo;
	}

	public static List<StockVO> goodsStockList(int no) {
		SqlSession session = ssf.openSession();
		List<StockVO> list = session.selectList("goodsStockList", no);
		session.close();
		return list;
	}

	public static void adminGoodsUpdate(GoodsVO vo) {
		SqlSession session = ssf.openSession(true);
		session.update("adminGoodsUpdate", vo);
		session.close();
	}

	public static int adminGoodsInsert(GoodsVO vo) {
		SqlSession session = ssf.openSession();
		session.insert("adminGoodsInsert", vo);
		session.commit();
		session.close();
		return vo.getGoods_no();
	}

	public static void adminStockInsert(StockVO svo) {
		SqlSession session = ssf.openSession();
		session.insert("adminStockInsert", svo);
		session.commit();
		session.close();
	}

	public static List<OrderDetailVO> adminOrderList(Map map) {
		SqlSession session = ssf.openSession();
		List<OrderDetailVO> list = session.selectList("adminOrderList", map);
		session.close();
		return list;
	}

	public static int adminOrderTotal(Map map) {
		SqlSession session = ssf.openSession();
		int total = session.selectOne("adminOrderTotal", map);
		session.close();
		return total;
	}

	public static String adminDeliveryOk(OrderDetailVO vo, String id) {
		SqlSession session = ssf.openSession();
		String msg = "";
		// stock 테이블에 있는지 조회
		StockVO svo = session.selectOne("getStock", vo);
		if (vo.getQuantity() <= svo.getQuantity()) {
			msg = "YES";

			// 있으면 stock에서 차감하고
			session.update("updateStockOut", vo);

			// history테이블에 insert
			HistoryVO hvo = new HistoryVO();
			hvo.setStock_no(svo.getNo());
			hvo.setOrder_no(vo.getOrder_no());
			hvo.setQuantity(vo.getQuantity());
			hvo.setInout_size(vo.getSizes());
			hvo.setChk("출고");
			hvo.setCreated_by(id);
			session.insert("outStockHistory", hvo);

			// 상태 업데이트
			session.update("updateOrderDetailStatus", vo);
			session.commit();

		} else { // 부족하면 msg에 NO 보냄
			msg = "NO";
		}
		session.close();
		return msg;
	}

	public static void adminReturnOk(OrderDetailVO vo, String id) {
		SqlSession session = ssf.openSession();

		// get stock_no
		StockVO svo = session.selectOne("getStock", vo);
		// stock 다시 올려주고
		session.update("updateStockOut", vo);

		// history테이블에 insert
		HistoryVO hvo = new HistoryVO();
		hvo.setStock_no(svo.getNo());
		hvo.setOrder_no(vo.getOrder_no());
		hvo.setQuantity(vo.getQuantity());
		hvo.setInout_size(vo.getSizes());
		hvo.setChk("반품");
		hvo.setCreated_by(id);
		session.insert("outStockHistory", hvo);

		// 상태 업데이트
		session.update("updateOrderDetailStatus", vo);
		session.commit();

		session.close();
	}

	public static List<HistoryVO> ioListData(Map map) {
		SqlSession session = ssf.openSession();
		List<HistoryVO> list = session.selectList("ioListData", map);
		session.close();
		return list;
	}

	public static int ioListTotal(Map map) {
		SqlSession session = ssf.openSession();
		int total = session.selectOne("ioListTotal", map);
		session.close();
		return total;
	}

	public static List<GoodsVO> adminStockList(Map map) {
		SqlSession session = ssf.openSession();
		List<GoodsVO> list = session.selectList("adminStockList", map);
		session.close();
		return list;
	}

	public static int adminStockTotal(Map map) {
		SqlSession session = ssf.openSession();
		int total = session.selectOne("adminStockTotal", map);
		session.close();
		return total;
	}

	public static List<GoodsVO> stockSearchList(String keyword) {
		SqlSession session = ssf.openSession();
		List<GoodsVO> list = session.selectList("stockSearchList", keyword);
		session.close();
		return list;
	}

	public static List<StockVO> stockSizeData(int goods_no) {
		SqlSession session = ssf.openSession();
		List<StockVO> list = session.selectList("stockSizeData", goods_no);
		session.close();
		return list;
	}

	public static void stockInsert(StockVO vo, String id) {
		SqlSession session = ssf.openSession();

		// stock insert
		session.insert("stockInsert", vo);

		// history테이블에 insert
		HistoryVO hvo = new HistoryVO();
		hvo.setStock_no(vo.getNo());
		hvo.setQuantity(vo.getQuantity());
		hvo.setInout_size(vo.getGoods_size());
		hvo.setChk("입고");
		hvo.setCreated_by(id);
		session.insert("inStockHistory", hvo);

		session.commit();
		session.close();
	}

	public static void stockUpdate(StockVO vo, String id) {

		SqlSession session = ssf.openSession();

		// stock update
		session.update("stockUpdate", vo);

		// history테이블에 insert
		HistoryVO hvo = new HistoryVO();
		hvo.setStock_no(vo.getNo());
		hvo.setQuantity(vo.getQuantity());
		hvo.setInout_size(vo.getGoods_size());
		hvo.setChk("입고");
		hvo.setCreated_by(id);
		session.insert("inStockHistory", hvo);

		session.commit();
		session.close();

	}

	public static void stockForceUpdate(StockVO vo, String id) {
		SqlSession session = ssf.openSession();

		// stock update
		session.update("stockForceUpdate", vo);

		// history테이블에 insert
		HistoryVO hvo = new HistoryVO();
		hvo.setStock_no(vo.getNo());
		hvo.setQuantity(vo.getQuantity());
		hvo.setInout_size(vo.getGoods_size());
		hvo.setChk("수정");
		hvo.setCreated_by(id);
		session.insert("inStockHistory", hvo);

		session.commit();
		session.close();

	}

	public static List<DashVO> salesList() {
		SqlSession session = ssf.openSession();
		List<DashVO> list = session.selectList("salesList");
		session.close();
		return list;
	}

	public static List<OrderDetailVO> dashOrderList() {
		SqlSession session = ssf.openSession();
		List<OrderDetailVO> list = session.selectList("dashOrderList");
		session.close();
		return list;
	}

	public static List<QnaVO> dashQnaList() {
		SqlSession session = ssf.openSession();
		List<QnaVO> list = session.selectList("dashQnaList");
		session.close();
		return list;
	}
	
	public static int dashCountOrder() {
		SqlSession session = ssf.openSession();
		int count = session.selectOne("dashCountOrder");
		session.close();
		return count;
	}
	
	public static int dashTotalPrice() {
		SqlSession session = ssf.openSession();
		int count = session.selectOne("dashTotalPrice");
		session.close();
		return count;
	}
	
	public static int dashCountStockLess() {
		SqlSession session = ssf.openSession();
		int count = session.selectOne("dashCountStockLess");
		session.close();
		return count;
	}
	
	public static int dashCountNotDelivery() {
		SqlSession session = ssf.openSession();
		int count = session.selectOne("dashCountNotDelivery");
		session.close();
		return count;
	}


	public static List<QnaVO> adminQnaListData(Map map) {
		SqlSession session = ssf.openSession();
		List<QnaVO> list = session.selectList("adminQnaListData", map);
		session.close();
		return list;
	}
	
	public static int adminQnaListTotal(Map map) {
		SqlSession session = ssf.openSession();
		int total = session.selectOne("adminQnaListTotal", map);
		session.close();
		return total;
	}

	public static QnaVO adminQnaData(int qna_no) {
		SqlSession session = ssf.openSession();
		QnaVO vo = session.selectOne("adminQnaData", qna_no);
		session.close();
		return vo;
	}

	public static QnaVO adminQnaParentData(int parent_no) {
		SqlSession session = ssf.openSession();
		QnaVO vo = session.selectOne("adminQnaParentData", parent_no);
		session.close();
		return vo;
	}

	public static int adminQnaAnswerInsert(QnaVO vo) {
		SqlSession session = ssf.openSession();
		session.insert("adminQnaAnswerInsert", vo);
		session.commit();
		session.close();
		return vo.getQna_no();
	}

	public static void adminQnaOriginUpdate(QnaVO vo) {
		SqlSession session = ssf.openSession();
		session.update("adminQnaOriginUpdate", vo);
		session.commit();
		session.close();
		
	}

	public static void adminQnaAnswerUpdate(QnaVO vo) {
		SqlSession session = ssf.openSession();
		session.update("adminQnaAnswerUpdate", vo);
		session.commit();
		session.close();
	}

	public static void adminQnaAnswerDelete(int parent_no) {
		SqlSession session = ssf.openSession();
		session.update("adminQnaAnswerDelete", parent_no);
		session.commit();
		session.close();
	}

	public static List<DashVO> bestList() {
		SqlSession session = ssf.openSession();
		List<DashVO> list = session.selectList("bestList");
		session.close();
		return list;
	}
}
