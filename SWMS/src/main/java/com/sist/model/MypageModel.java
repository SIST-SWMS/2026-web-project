package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class MypageModel {

	@RequestMapping("mypage/mypage.do")
	public String mypage(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("mypage_content", "../mypage/mypage_main.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
	}
	

	@RequestMapping("mypage/orderList.do")
	public String mypage_order_list(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("mypage_content", "../mypage/order_list.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
	}

	
	@RequestMapping("mypage/detail.do")
	public String mypage_order_detail(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("mypage_content", "../mypage/order_view.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
	}
	
	
	@RequestMapping("mypage/claimList.do")
	public String mypage_claim_list(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("mypage_content", "../mypage/claim_list.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("mypage/reviewList.do")
	public String mypage_review_list(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("mypage_content", "../mypage/review_list.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
	}
	
	
	@RequestMapping("mypage/qnaList.do")
	public String mypage_qna_list(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("mypage_content", "../mypage/qna_list.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
	}
	
}
