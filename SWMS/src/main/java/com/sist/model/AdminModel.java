package com.sist.model;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sist.commons.UploadConfig;
import com.sist.commons.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.commons.FileUploadUtil;
import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.AdminDAO;
import com.sist.vo.BrandVO;
import com.sist.vo.CategoryVO;
import com.sist.vo.GoodsVO;
import com.sist.vo.HistoryVO;
import com.sist.vo.OrderDetailVO;
import com.sist.vo.StockVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
public class AdminModel {

	// 관리자 메인화면 조회
	@RequestMapping("admin/admin.do")
	public String admin(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("admin_content", "../admin/dashboard.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
		return "../main/main.jsp";
	}

	// 상품 관리 화면 전환
	@RequestMapping("admin/goods_list.do")
	public String goods_list(HttpServletRequest request, HttpServletResponse response) {

		// 브랜드, 카테고리 가져다 뿌리기
		List<BrandVO> bList = AdminDAO.SearchBrand();
		List<CategoryVO> cList = AdminDAO.SearchCategory();

		request.setAttribute("bList", bList);
		request.setAttribute("cList", cList);
		request.setAttribute("admin_menu", "goods");
		request.setAttribute("admin_content", "../admin/goods_list.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
		return "../main/main.jsp";
	}

	// 상품 관리 목록 조회
	@RequestMapping("admin/goods_list_vue.do")
	public void goods_list_vue(HttpServletRequest request, HttpServletResponse response) {
		final int BLOCK = 10;
		String page = request.getParameter("page");
		String category = request.getParameter("category");
		String brand = request.getParameter("brand");
		String fd = request.getParameter("fd");

		if (page == null) {
			page = "1";
		}

		int curpage = Integer.parseInt(page);
		int start = (curpage - 1) * BLOCK;
		int category_no = Integer.parseInt(category);
		int brand_no = Integer.parseInt(brand);

		Map map = new HashMap();
		map.put("start", start);
		map.put("category", category_no);
		map.put("brand", brand_no);
		map.put("fd", fd);

		int totalpage = AdminDAO.adminGoodsTotal(map);
		int startPage = ((curpage - 1) / BLOCK * BLOCK) + 1;
		int endPage = (((curpage - 1) / BLOCK) * BLOCK) + BLOCK;
		if (endPage > totalpage) {
			endPage = totalpage;
		}
		List<GoodsVO> list = AdminDAO.adminGoodsList(map);

		try {

			map = new HashMap();
			map.put("fd", fd);
			map.put("category", category);
			map.put("brand", brand);
			map.put("list", list);
			map.put("curpage", curpage);
			map.put("totalpage", totalpage);
			map.put("startPage", startPage);
			map.put("endPage", endPage);

			ObjectMapper mapper = new ObjectMapper();
			String json = mapper.writeValueAsString(map);

			response.setContentType("text/plain;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write(json);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 상품 상세보기
	@RequestMapping("admin/goods_view.do")
	public String goods_view(HttpServletRequest request, HttpServletResponse response) {
		String no = request.getParameter("no");

		GoodsVO vo = AdminDAO.adminGoodsData(Integer.parseInt(no));
		List<StockVO> list = AdminDAO.goodsStockList(Integer.parseInt(no));

		request.setAttribute("vo", vo);
		request.setAttribute("list", list);
		request.setAttribute("admin_content", "../admin/goods_view.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
		return "../main/main.jsp";
	}

	// 상품 등록 화면 전환
	@RequestMapping("admin/goods_insert.do")
	public String goods_insert(HttpServletRequest request, HttpServletResponse response) {

		// 브랜드, 카테고리 가져다 뿌리기
		List<BrandVO> bList = AdminDAO.SearchBrand();
		List<CategoryVO> cList = AdminDAO.SearchCategory();

		request.setAttribute("bList", bList);
		request.setAttribute("cList", cList);

		request.setAttribute("admin_content", "../admin/goods_insert.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
		return "../main/main.jsp";
	}

	// 상품 등록
	@RequestMapping("admin/goods_insert_ok.do")
	public String goods_insert_ok(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String uploadPath = UploadConfig.getUploadPath();

		String category_no = request.getParameter("category");
		String brand_no = request.getParameter("brand");
		String goods_code = request.getParameter("goods_code");
		String goods_name = request.getParameter("goods_name");
		String goods_price = request.getParameter("goods_price");
		String goods_discount = request.getParameter("goods_discount");

		Part filePart = request.getPart("poster_url");
		String poster_url = "";
		if (filePart != null) {
			poster_url = FileUploadUtil.upload(uploadPath, filePart);
		}

		filePart = request.getPart("subposter_url");
		String subposter_url = "";
		if (subposter_url != null) {
			subposter_url = FileUploadUtil.upload(uploadPath, filePart);
		}

		GoodsVO vo = new GoodsVO();
		vo.setCategory_no(Integer.parseInt(category_no));
		vo.setBrand_no(Integer.parseInt(brand_no));
		vo.setGoods_code(goods_code);
		vo.setGoods_name(goods_name);
		vo.setGoods_price(goods_price);
		vo.setGoods_discount(Integer.parseInt(goods_discount));
		vo.setPoster_url(poster_url);
		vo.setSubposter_url(subposter_url);
		
		int goods_no = AdminDAO.adminGoodsInsert(vo);
		
		String[] sizes = request.getParameterValues("sizes");
		if (sizes != null) {
		    for (String size : sizes) {
		        StockVO svo = new StockVO();
		        svo.setGoods_no(goods_no);
		        svo.setGoods_size(Integer.parseInt(size));
		        svo.setQuantity(0);  // 초기 재고
		        AdminDAO.adminStockInsert(svo);
		    }
		}
		
		return "redirect:../admin/goods_view.do?no=" + goods_no;
	}

	// 상품 수정 화면 전환
	@RequestMapping("admin/goods_update.do")
	public String goods_update(HttpServletRequest request, HttpServletResponse response) {

		String no = request.getParameter("no");
		GoodsVO vo = AdminDAO.adminGoodsData(Integer.parseInt(no));
		request.setAttribute("vo", vo);

		// 브랜드, 카테고리 가져다 뿌리기
		List<BrandVO> bList = AdminDAO.SearchBrand();
		List<CategoryVO> cList = AdminDAO.SearchCategory();

		request.setAttribute("bList", bList);
		request.setAttribute("cList", cList);

		request.setAttribute("admin_content", "../admin/goods_update.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
		return "../main/main.jsp";
	}

	// 상품 수정
	@RequestMapping("admin/goods_update_ok.do")
	public String goods_update_ok(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String uploadPath = UploadConfig.getUploadPath();

		String goods_no = request.getParameter("goods_no");

		String category_no = request.getParameter("category");
		String brand_no = request.getParameter("brand");
		String goods_code = request.getParameter("goods_code");
		String goods_name = request.getParameter("goods_name");
		String price = request.getParameter("price");
		String discount = request.getParameter("discount");

		String oldPoster = request.getParameter("old_poster_url");
		String oldSubposter = request.getParameter("old_subposter_url");

		Part filePart = request.getPart("poster_url");
		String poster_url = FileUploadUtil.upload(uploadPath, filePart);
		if (poster_url == null || poster_url.equals("")) {
			poster_url = oldPoster;
		}

		filePart = request.getPart("subposter_url");
		String subposter_url = FileUploadUtil.upload(uploadPath, filePart);
		if (subposter_url == null || subposter_url.equals("")) {
			subposter_url = oldSubposter;
		}

		GoodsVO vo = new GoodsVO();
		vo.setGoods_no(Integer.parseInt(goods_no));
		vo.setCategory_no(Integer.parseInt(category_no));
		vo.setBrand_no(Integer.parseInt(brand_no));
		vo.setGoods_code(goods_code);
		vo.setGoods_name(goods_name);
		vo.setGoods_price(price);
		vo.setGoods_discount(Integer.parseInt(discount));
		vo.setPoster_url(poster_url);
		vo.setSubposter_url(subposter_url);

		System.out.println(vo.toString());

		AdminDAO.adminGoodsUpdate(vo);

		return "redirect:../admin/goods_view.do?no=" + goods_no;
	}

	// 재고 관리 목록 조회
	@RequestMapping("admin/stock_list.do")
	public String stock_list(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("admin_content", "../admin/stock_list.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
		return "../main/main.jsp";
	}

	// 재고 관리 상세 조회
	@RequestMapping("admin/stock_view.do")
	public String stock_view(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("admin_content", "../admin/stock_view.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
		return "../main/main.jsp";
	}

	// 재고 등록 화면 전환
	@RequestMapping("admin/stock_insert.do")
	public String stock_insert(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("admin_content", "../admin/stock_insert.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
		return "../main/main.jsp";
	}

	// 재고 수정 화면 전환
	@RequestMapping("admin/stock_update.do")
	public String stock_update(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("admin_content", "../admin/stock_update.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
		return "../main/main.jsp";
	}

	// 출고 관리 화면 전환
	@RequestMapping("admin/stockout.do")
	public String stockout_list(HttpServletRequest request, HttpServletResponse response) {
		
		request.setAttribute("admin_content", "../admin/stockout.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
		return "../main/main.jsp";
	}
	
	// 출고 관리 목록 조회
	@RequestMapping("admin/stockout_vue.do")
	public void stockout_list_vue(HttpServletRequest request, HttpServletResponse response) {
		
		final int BLOCK = 10;
		String page = request.getParameter("page");
		String status = request.getParameter("status");
		String memberId = request.getParameter("memberId");
		
		
		System.out.println("page" + page);
		System.out.println("status" + status);
		System.out.println("memberId" + memberId);
		
		if (page == null) {
			page = "1";
		}
		
		int curpage = Integer.parseInt(page);
		int start = (curpage - 1) * BLOCK;
		
		Map map = new HashMap();
		map.put("start", start);
		map.put("status", status);
		map.put("memberId", memberId);
		
		int totalpage = AdminDAO.adminOrderTotal(map);
		int startPage = ((curpage - 1) / BLOCK * BLOCK) + 1;
		int endPage = (((curpage - 1) / BLOCK) * BLOCK) + BLOCK;
		if (endPage > totalpage) {
			endPage = totalpage;
		}
		List<OrderDetailVO> list = AdminDAO.adminOrderList(map);
		
		try {
			map = new HashMap();
			map.put("list", list);
			map.put("curpage", curpage);
			map.put("totalpage", totalpage);
			map.put("startPage", startPage);
			map.put("endPage", endPage);

			ObjectMapper mapper = new ObjectMapper();
			String json = mapper.writeValueAsString(map);

			response.setContentType("text/plain;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write(json);

		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	// 출고 처리
	@RequestMapping("admin/delivery_ok.do")
	public void delivery_ok(HttpServletRequest request, HttpServletResponse response) {
		
		String order_detail_no = request.getParameter("order_detail_no");
		String order_no = request.getParameter("order_no");
		String sizes = request.getParameter("sizes");
		String quantity = request.getParameter("quantity");
		String goods_no = request.getParameter("goods_no");
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		OrderDetailVO vo = new OrderDetailVO();
		vo.setOrder_detail_no(Integer.parseInt(order_detail_no));
		vo.setOrder_no(Integer.parseInt(order_no));
		vo.setSizes(Integer.parseInt(sizes));
		vo.setQuantity(Integer.parseInt(quantity));
		vo.setGoods_no(Integer.parseInt(goods_no));
		vo.setStatus("배송완료");
		
		String msg = AdminDAO.adminDeliveryOk(vo, id);
		
		try {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write(msg);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	// 반품 처리
	@RequestMapping("admin/return_ok.do")
	public void return_ok(HttpServletRequest request, HttpServletResponse response) {
		String order_detail_no = request.getParameter("order_detail_no");
		String order_no = request.getParameter("order_no");
		String sizes = request.getParameter("sizes");
		String quantity = request.getParameter("quantity");
		String goods_no = request.getParameter("goods_no");
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		OrderDetailVO vo = new OrderDetailVO();
		vo.setOrder_detail_no(Integer.parseInt(order_detail_no));
		vo.setSizes(Integer.parseInt(sizes));
		vo.setQuantity(Integer.parseInt(quantity));
		vo.setGoods_no(Integer.parseInt(goods_no));
		vo.setStatus("반품완료");
		
		AdminDAO.adminReturnOk(vo, id);
		
		request.setAttribute("admin_content", "../admin/stockout.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
	}

	// 입출고 내역 조회 화면 전환
	@RequestMapping("admin/io_list.do")
	public String io_list(HttpServletRequest request, HttpServletResponse response) {
		
		request.setAttribute("admin_content", "../admin/io_list.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
		return "../main/main.jsp";
	}
	
	// 입출고 내역 조회
	@RequestMapping("admin/io_list_vue.do")
	public void io_list_vue(HttpServletRequest request, HttpServletResponse response) {
		
		final int BLOCK = 10;
		String page = request.getParameter("page");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String chk = request.getParameter("chk");
		String goodsName = request.getParameter("goodsName");
		
		System.out.println("page :: " + page);
		System.out.println("startDate :: " + startDate);
		System.out.println("endDate :: " + endDate);
		System.out.println("chk :: " + chk);
		System.out.println("goodsName :: " + goodsName);
		
		if (page == null) {
			page = "1";
		}
		
		int curpage = Integer.parseInt(page);
		int start = (curpage - 1) * BLOCK;
		
		Map map = new HashMap();
		map.put("start", start);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("chk", chk);
		map.put("goodsName", goodsName);
		
		int totalpage = AdminDAO.ioListTotal(map);
		int startPage = ((curpage - 1) / BLOCK * BLOCK) + 1;
		int endPage = (((curpage - 1) / BLOCK) * BLOCK) + BLOCK;
		if (endPage > totalpage) {
			endPage = totalpage;
		}
		List<HistoryVO> list = AdminDAO.ioListData(map);
		
		try {
			map = new HashMap();
			map.put("list", list);
			map.put("curpage", curpage);
			map.put("totalpage", totalpage);
			map.put("startPage", startPage);
			map.put("endPage", endPage);

			ObjectMapper mapper = new ObjectMapper();
			String json = mapper.writeValueAsString(map);

			response.setContentType("text/plain;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write(json);

		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	// 입출고 내역 상세보기
	@RequestMapping("admin/io_view.do")
	public String io_view(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("admin_content", "../admin/io_view.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
		return "../main/main.jsp";
	}

	// QNA 목록조회
	@RequestMapping("admin/qna_list.do")
	public String qna_list(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("admin_content", "../admin/qna_list.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
		return "../main/main.jsp";
	}

	// QNA 상세보기
	@RequestMapping("admin/qna_view.do")
	public String qna_view(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("admin_content", "../admin/qna_view.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
		return "../main/main.jsp";
	}

}