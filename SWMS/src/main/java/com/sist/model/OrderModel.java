package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class OrderModel {

	@RequestMapping("order/order.do")
	public String order(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("main_jsp", "../order/checkout.jsp");
		return "../main/main.jsp";
	}
	
}
