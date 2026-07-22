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
		
		List<CartVO> list = CartDAO.cartListData(id);
		
		for(int i = 0; i < list.size(); i++)
		{
			String priceStr = "";
			int priceNum = 0;
			priceStr = list.get(i).getGvo().getGoods_price().replaceAll("[^0-9]", "");
			priceNum = Integer.parseInt(priceStr);					
			list.get(i).getGvo().setPrice(priceNum);
			//System.out.println(priceNum);
			
			// 할인율 계산
			int discount = list.get(i).getGvo().getGoods_discount();
			int afterPrice = priceNum - (priceNum * discount/100);
			list.get(i).getGvo().setAfter_iPrice(afterPrice);
			//TODO : ##,### 포맷팅 해서 after_sPrice 변수에 넣어두기
		}
		
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
	
	@RequestMapping("cart/selected_delete.do")
	public String cart_selected_delete(HttpServletRequest request, HttpServletResponse response) 
	{
		String deletes = request.getParameter("deletes");	// 하나의 문자열로 받은 goods_no
		String[] arr = deletes.split(",");
		//List<String> nList = new ArrayList<String>();
		for(int i = 0; i < arr.length; i++)
		{
			//nList.add(arr[i]);	// split 한 goods_no 들을 배열에 저장
			CartDAO.cartDeleteData(Integer.parseInt(arr[i]));
			System.out.println(arr[i]);
		}
		//System.out.println(nList);

		
		//CartDAO.cartDeleteData(Integer.parseInt(goods_no));
		return "redirect:../cart/cart.do";
	}
}
