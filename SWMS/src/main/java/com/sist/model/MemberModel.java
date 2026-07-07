package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class MemberModel {
	
	@RequestMapping("member/join.do")
	public String join(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("main_jsp", "../member/join.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("member/login.do")
	public String login(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("main_jsp", "../member/login.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("member/detail.do")
	public String member_update(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("mypage_content", "../member/detail.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
	}
	
}
