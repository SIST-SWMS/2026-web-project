package com.sist.model;

import java.util.*;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.OrderDAO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.sist.dao.*;
import com.sist.vo.*;

@Controller
public class OrderModel {

	@RequestMapping("order/order.do")
	public String order(HttpServletRequest request, HttpServletResponse response) {
		String stock_no = request.getParameter("stock_no");
		String quantity = request.getParameter("quantity");
		HttpSession session = request.getSession();
		String id = session.getAttribute("id").toString();
		
		System.out.println("stock_no: "+stock_no);
		
		Map map = new HashMap();
		map.put("stock_no", Integer.parseInt(stock_no));
		map.put("id", id);
		
		List<OrderDetailVO> list = OrderDAO.orderListData(map);
		
		String price = list.get(0).getPrice_str().replaceAll("[^0-9]", "");
		int quantity_num = Integer.parseInt(quantity);
		int totalPrice = quantity_num * Integer.parseInt(price);
		
		request.setAttribute("totalPrice", totalPrice);
		request.setAttribute("list", list);
		request.setAttribute("quantity", quantity);
		
		
		request.setAttribute("main_jsp", "../order/checkout.jsp");
		return "../main/main.jsp";
	}
	
}
