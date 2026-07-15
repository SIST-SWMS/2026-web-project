package com.sist.model;

import java.io.File;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.commons.FileUploadUtil;
import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.AdminDAO;
import com.sist.vo.BrandVO;
import com.sist.vo.CategoryVO;
import com.sist.vo.GoodsVO;
import com.sist.vo.StockVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
		request.setAttribute("admin_content", "../admin/goods_insert.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
		return "../main/main.jsp";
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

			String uploadPath = "C:\\uploads";

			String goods_no = request.getParameter("goods_no");
			System.out.println("goods_no :: " + goods_no);
			 
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

	// 출고 관리 목록 조회
	@RequestMapping("admin/stockout.do")
	public String stockout_list(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("admin_content", "../admin/stockout.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
		return "../main/main.jsp";
	}

	// 입출고 내역 조회
	@RequestMapping("admin/io_list.do")
	public String io_list(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("admin_content", "../admin/io_list.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
		return "../main/main.jsp";
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
