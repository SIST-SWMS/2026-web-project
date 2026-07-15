package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.sist.vo.*;
import com.sist.dao.*;

@Controller
public class ReviewModel {
	@RequestMapping("mypage/review.do")
	public String review(HttpServletRequest request, HttpServletResponse response) {
		String no = request.getParameter("no");
		request.setAttribute("no", no);
		request.setAttribute("mypage_content", "../mypage/review.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
		/*
		 * request.setAttribute("mypage_content", "../mypage/review_list.jsp");
		 * request.setAttribute("main_jsp", "../mypage/mypage.jsp"); return
		 * "../main/main.jsp";
		 */
	}

	@RequestMapping("mypage/review_ok.do")
	public String review_ok(HttpServletRequest request, HttpServletResponse response) {
	   String goods_no=request.getParameter("goods_no"); // 상품 번호
		String hit = request.getParameter("rating");
		String subject = request.getParameter("title");
		String content = request.getParameter("content");
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id"); // 사용자 id

		ReviewVO vo = new ReviewVO();
		vo.setGoods_no(Integer.parseInt(goods_no));
		vo.setSubject(subject);
		vo.setContent(content);
		vo.setId(id);
		vo.setHit(hit);
		
		System.out.println(vo.toString());

		ReviewDAO.reviewInsert(vo);
		
		return "redirect:../mypage/reviewList.do";
	}	
	
}
