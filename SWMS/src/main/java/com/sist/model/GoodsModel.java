package com.sist.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.GoodsDAO;
import com.sist.vo.GoodsVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class GoodsModel {
	 private GoodsDAO dao = new GoodsDAO();
	// 1.  메인 홈 화면 메뉴에서 처음 상품 목록으로 진입
    @RequestMapping("goods/goods_main.do")
    public String goods_main(HttpServletRequest request, HttpServletResponse response) {
        // 처음 화면 진입 시 초기 데이터 세팅
        Map map = new HashMap();    
        map.put("category_no", 1);  
        map.put("start", 0); 
        map.put("sort", "default");         

        List<GoodsVO> list = dao.goodsListData(map);    
        int totalpage = dao.goodsTotalPage(0);        

        // 최초 틀 읽을 변수
        request.setAttribute("list", list);   
        request.setAttribute("curpage", 1);
        request.setAttribute("totalpage", totalpage);
        
        request.setAttribute("main_jsp", "../goods/goods_main.jsp");
        return "../main/main.jsp";
    }
    
    // 2. 화면이 완전히 뜬 상태에서 카테고리 버튼, 셀렉트박스, 페이지 번호를 조작
    @RequestMapping("goods/goods_main_ajax.do")
    public String goods_list_ajax(HttpServletRequest request, HttpServletResponse response) {
        String cno = request.getParameter("category_no");
        String page = request.getParameter("page");
        String sort = request.getParameter("sort");  
        
        if(page == null) 
        	page = "1";
        if(sort == null) 
        	sort = "default";
        
        int curpage = Integer.parseInt(page);
        int start = (curpage - 1) * 12;   
        
        Map map = new HashMap();    
        map.put("category_no", Integer.parseInt(cno));  
        map.put("start", start);   
        map.put("sort", sort);         

        List<GoodsVO> list = dao.goodsListData(map);    
        int totalpage = dao.goodsTotalPage(Integer.parseInt(cno));        

        request.setAttribute("list", list);   
        request.setAttribute("curpage", curpage);
        request.setAttribute("totalpage", totalpage);
        
        return "../goods/goods_main_ajax.jsp"; 
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
