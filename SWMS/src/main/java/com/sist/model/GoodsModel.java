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

    @RequestMapping("goods/list.do")
    public String goods_list(HttpServletRequest request, HttpServletResponse response) {
        
        // 1. 카테고리 번호 받기 
        String cno = request.getParameter("cno");
        if(cno == null) cno = "1";
        
        // 2. 페이지 번호 받기 
        String page = request.getParameter("page");
        if(page == null) page = "1";
        
        int curpage = Integer.parseInt(page);
        int start = (curpage - 1) * 12;
        
        // 3. DB 조회용 Map 세팅
        Map map = new HashMap();    
        map.put("category_no", Integer.parseInt(cno));  
        map.put("start", start); 
        map.put("sort", "default");         

        List<GoodsVO> list = GoodsDAO.goodsListData(map);    
        int totalpage = GoodsDAO.goodsTotalPage(Integer.parseInt(cno));      

        // 4. 블록별 페이지네이션 계산
        final int BLOCK = 10;
        int startPage = ((curpage-1)/BLOCK*BLOCK)+1;
        int endPage = ((curpage-1)/BLOCK*BLOCK)+BLOCK;
        if(endPage>totalpage) 
        	endPage=totalpage;

        // 5. 화면으로 넘겨줄 데이터 
        request.setAttribute("list", list);
        request.setAttribute("curPage", curpage); 
        request.setAttribute("totalPage", totalpage);
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);
        request.setAttribute("currentCno", cno);
        
        // 6. 이중 인클루드 경로
        request.setAttribute("goods_content", "../goods/goods_main.jsp");
        request.setAttribute("main_jsp", "../goods/goods.jsp");
        return "../main/main.jsp";
    }
    
    @RequestMapping("goods/goods_main_ajax.do")
    public String goods_list_ajax(HttpServletRequest request, HttpServletResponse response) {
        
        String cno = request.getParameter("category_no");
        String page = request.getParameter("page");
        String sort = request.getParameter("sort");  
        
        if(page == null) page = "1";
        if(sort == null) sort = "default";
        
        int curpage = Integer.parseInt(page);
        int start = (curpage - 1) * 12;   
        
        Map map = new HashMap();    
        map.put("category_no", Integer.parseInt(cno));  
        map.put("start", start);   
        map.put("sort", sort);         

        List<GoodsVO> list = GoodsDAO.goodsListData(map);    
        int totalpage = GoodsDAO.goodsTotalPage(Integer.parseInt(cno));        

        final int BLOCK = 10;
        int startPage = ((curpage - 1) / BLOCK * BLOCK) + 1;
        int endPage = ((curpage - 1) / BLOCK * BLOCK) + BLOCK;
        if(endPage > totalpage) endPage = totalpage;

        request.setAttribute("list", list);   
        request.setAttribute("curPage", curpage);
        request.setAttribute("totalPage", totalpage);
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);
        
        return "../goods/goods_main_ajax.jsp"; 
    }
    @RequestMapping("goods/detail.do")
	public String goods_detail(HttpServletRequest request, HttpServletResponse response) {
		
		request.setAttribute("main_jsp", "../goods/detail.jsp");
		return "../main/main.jsp";
	}
}
