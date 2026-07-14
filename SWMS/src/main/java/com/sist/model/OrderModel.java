package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class OrderModel {

	@RequestMapping("order/order.do")
	public String order(HttpServletRequest request, HttpServletResponse response) {
		String no = request.getParameter("no");
		String quantity = request.getParameter("quantity");
		HttpSession session = request.getSession();
		String id = session.getAttribute("id").toString();
		
		//request.setAttribute("", );
		
		
		request.setAttribute("main_jsp", "../order/checkout.jsp");
		return "../main/main.jsp";
	}
	
}
