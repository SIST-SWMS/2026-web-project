package com.sist.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.GoodsDAO;
import com.sist.vo.GoodsVO;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class GoodsModel {

	@RequestMapping("goods/goods_main_ajax.do")
	public String goods_list_ajax(HttpServletRequest request, HttpServletResponse response) {
		String cno=request.getParameter("category_no");
		String page=request.getParameter("page");
		String sort = request.getParameter("sort");  
		
		if(page==null)
			page="1";
		int curpage=Integer.parseInt(page);
		int start = (curpage - 1) * 12;   
		
		
		Map map = new HashMap();    
		map.put("category_no", Integer.parseInt(cno));  
		map.put("start", start);   
		map.put("sort", sort);         

		List<GoodsVO> list = GoodsDAO.goodsListData(map);    
		int totalPage = GoodsDAO.goodsTotalPage(Integer.parseInt(cno));        

		//request.setAttribute("list", list);   
		request.setAttribute("main_jsp", "../goods/goods_main");
		 //return "../goods/goods_main_ajax.jsp"; 
		return "../main/main.jsp";
	}
	
	/*@RequestMapping("goods/list.do")
	public String goods_list(HttpServletRequest request, HttpServletResponse response) {

		request.setAttribute("goods_content", "../goods/goods_main.jsp");
		request.setAttribute("main_jsp", "../goods/goods.jsp");
		return "../main/main.jsp";
	}*/
	@RequestMapping("goods/detail.do")
	public String goods_detail(HttpServletRequest request, HttpServletResponse response) {
		
		request.setAttribute("main_jsp", "../goods/detail.jsp");
		return "../main/main.jsp";
	}
}
