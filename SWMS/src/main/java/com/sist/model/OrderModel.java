package com.sist.model;

import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.*;

import com.fasterxml.jackson.databind.ObjectMapper;
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
		MemberVO mvo = MemberDAO.memberDetailData(id);
		
		//System.out.println("stock_no: "+stock_no);
		
		Map map = new HashMap();
		map.put("stock_no", Integer.parseInt(stock_no));
		map.put("id", id);
		
		List<OrderDetailVO> list = OrderDAO.orderListData(map);
		
		String price = list.get(0).getPrice_str().replaceAll("[^0-9]", "");
		int quantity_num = Integer.parseInt(quantity);
		int totalPrice = quantity_num * Integer.parseInt(price);
		
		DecimalFormat df = new DecimalFormat("#,###");
		String totalPrice_str = df.format(totalPrice);
		
		request.setAttribute("totalPrice", totalPrice);
		request.setAttribute("totalPrice_str", totalPrice_str);
		request.setAttribute("list", list);
		request.setAttribute("quantity", quantity);
		
		request.setAttribute("mvo", mvo);
		request.setAttribute("id", id);
		
		request.setAttribute("stock_no", stock_no);
		request.setAttribute("list_size", list.size());
		
		
		request.setAttribute("main_jsp", "../order/checkout.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("order/order_ok.do")
	public void order_ok(HttpServletRequest request, HttpServletResponse response) 
	{
		String delivery_name = request.getParameter("name");
		String delivery_phone = request.getParameter("phone");
		String delivery_post= request.getParameter("zipcode");
		String delivery_addr1 = request.getParameter("addr");
		String delivery_addr2= request.getParameter("addr_detail");
		String delivery_msg = request.getParameter("msg");
		String total_price = request.getParameter("total_price");
		
		String stock_no = request.getParameter("stock_no");
		String quantity = request.getParameter("quantity");
		HttpSession session = request.getSession();
		String id = session.getAttribute("id").toString();
		MemberVO mvo = MemberDAO.memberDetailData(id);
		
		//System.out.println("stock_no: "+stock_no);
		
//		Map map = new HashMap();
//		map.put("stock_no", Integer.parseInt(stock_no));
//		map.put("id", id);
		
		//List<OrderDetailVO> list = OrderDAO.orderListData(map);
		
		System.out.println(delivery_name);
		System.out.println(delivery_phone);
		System.out.println(delivery_post);
		System.out.println(delivery_addr1);
		System.out.println(delivery_addr2);
		System.out.println(delivery_msg);
		System.out.println(total_price);
		
		try 
		{
			Map map2 = new HashMap();
			//map2.put("list",list);
			map2.put("id", id);
			map2.put("quantity", map2);
			
			ObjectMapper mapper = new ObjectMapper();
			String json = mapper.writeValueAsString(map2);
			
			response.setContentType("text/plain;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write(json);
			
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		//return "../main/main.jsp"; // 주문이 완료되었습니다 페이지를 보여줘야하는데 일단은
	}
	
}
