package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class AdminModel {
	
	// 관리자 메인화면 조회
	@RequestMapping("admin/admin.do")
	public String admin(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("admin_content", "../admin/dashboard.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
		return "../main/main.jsp";
	}
	
	// 상품 관리 목록 조회
	@RequestMapping("admin/goods_list.do")
	public String goods_list(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("admin_content", "../admin/goods_list.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
		return "../main/main.jsp";
	}

	// 상품 상세보기
	@RequestMapping("admin/goods_view.do")
	public String goods_view(HttpServletRequest request, HttpServletResponse response) {
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
		request.setAttribute("admin_content", "../admin/goods_update.jsp");
		request.setAttribute("main_jsp", "../admin/admin.jsp");
		return "../main/main.jsp";
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
