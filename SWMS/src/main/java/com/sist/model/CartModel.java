package com.sist.model;

import java.io.PrintWriter;
import java.util.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.sist.vo.*;
import com.sist.dao.*;

@Controller
public class CartModel {
	@RequestMapping("cart/cart.do")
	public String cart_cart(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("main_jsp", "../cart/cart.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("cart/cart_vue.do")
	public void cart_cart_vue(HttpServletRequest request, HttpServletResponse response) 
	{
		HttpSession session = request.getSession();
		String id = session.getAttribute("id").toString();
		System.out.println(id);
		System.out.println(session.getAttribute("id"));
		
		List<CartVO> list = CartDAO.cartListData(id);
		
		try 
		{
			Map map = new HashMap();
			map.put("list",list);
			map.put("id", id);
			
			ObjectMapper mapper = new ObjectMapper();
			String json = mapper.writeValueAsString(map);
			
			response.setContentType("text/plain;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write(json);
			
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	@RequestMapping("cart/delete.do")
	public String cart_delete(HttpServletRequest request, HttpServletResponse response) 
	{
		String goods_no = request.getParameter("no");
		CartDAO.cartDeleteData(Integer.parseInt(goods_no));
		return "redirect:../cart/cart.do";
	}
}
