package com.sist.model;

import java.util.List;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class GoodsModel {

	@RequestMapping("goods/list.do")
	public String goods_list(HttpServletRequest request, HttpServletResponse response) {

		request.setAttribute("goods_content", "../goods/goods_main.jsp");
		request.setAttribute("main_jsp", "../goods/goods.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("goods/detail.do")
	public String goods_detail(HttpServletRequest request, HttpServletResponse response) {
		
		request.setAttribute("main_jsp", "../goods/detail.jsp");
		return "../main/main.jsp";
	}
}
