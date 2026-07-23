package com.sist.model;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.GoodsDAO;
import com.sist.dao.LikeDAO;
import com.sist.vo.GoodsVO;
import com.sist.vo.LikeVO;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sist.vo.*;
import com.sist.dao.*;
@Controller
public class GoodsModel {

    // 1. 상품 메인 리스트 
    @RequestMapping("goods/list.do")
    public String goods_list(HttpServletRequest request, HttpServletResponse response) {
        String cno = request.getParameter("cno");
        if(cno==null) cno="1";
        
        String page = request.getParameter("page");
        if(page==null) page="1";
        
        int curpage=Integer.parseInt(page);
        int start=(curpage-1) * 12;
        
        Map map = new HashMap();    
        map.put("category_no", Integer.parseInt(cno));  
        map.put("start", start);   
        map.put("sort", "default");         
        
        HttpSession session = request.getSession();
        String id = (String) session.getAttribute("id");
        map.put("id", id == null ? "" : id);

        List<GoodsVO> list = GoodsDAO.goodsListData(map);   
		
		/*
		 * for(GoodsVO vo:list) { LikeDAO.goodsLikeUpdate(vo.getGoods_no()); }
		 */
		 
        int totalpage = GoodsDAO.goodsTotalPage(Integer.parseInt(cno));        

        final int BLOCK=10;
        int startPage=((curpage-1)/BLOCK*BLOCK)+1;
        int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
        if(endPage>totalpage) endPage=totalpage;

        request.setAttribute("list", list);
        request.setAttribute("curPage", curpage); 
        request.setAttribute("totalPage", totalpage);
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);
        request.setAttribute("currentCno", cno);
        
        request.setAttribute("goods_content", "../goods/goods_main.jsp");
        request.setAttribute("main_jsp", "../goods/goods.jsp");
        return "../main/main.jsp";
    }
    
    // 2. 상품 리스트 Ajax
    @RequestMapping("goods/goods_main_ajax.do")
    public String goods_list_ajax(HttpServletRequest request, HttpServletResponse response) {
        String cno=request.getParameter("category_no");
        String page=request.getParameter("page");
        String sort=request.getParameter("sort");  
        
        if(page==null) page="1";
        if(sort==null) sort="default";
        
        int curpage = Integer.parseInt(page);
        int start = (curpage-1) * 12;   
        
        Map map = new HashMap();    
        map.put("category_no", Integer.parseInt(cno));  
        map.put("start", start);   
        map.put("sort", sort);         
        
        HttpSession session = request.getSession();
        String id = (String) session.getAttribute("id");
        map.put("id", id == null ? "" : id);

        List<GoodsVO> list = GoodsDAO.goodsListData(map);    
        int totalpage=GoodsDAO.goodsTotalPage(Integer.parseInt(cno));        

        final int BLOCK = 10;
        int startPage=((curpage-1)/BLOCK*BLOCK)+1;
        int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
        if(endPage>totalpage) endPage=totalpage;

        request.setAttribute("list", list);   
        request.setAttribute("curPage", curpage);
        request.setAttribute("totalPage", totalpage);
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);
        
        return "../goods/goods_main_ajax.jsp"; 
    }
    
    // 3. 상품 상세 보기 
    @RequestMapping("goods/detail.do")
    public String goods_detail(HttpServletRequest request, HttpServletResponse response) {
        String goods_no=request.getParameter("goods_no");
        
        if(goods_no!=null) {
        	int gno = Integer.parseInt(goods_no);
            GoodsVO vo = GoodsDAO.goodsDetailData(gno);
            request.setAttribute("vo", vo);
            
            List<ReviewVO> rList = GoodsDAO.goodsReviewList(gno);
            request.setAttribute("rList", rList);
            
            List<QnaVO> qList = GoodsDAO.goodsQnaList(gno);
            request.setAttribute("qList", qList);
            
            List<StockVO> stockList = GoodsDAO.goodsStockCheckList(gno);
            request.setAttribute("stockList", stockList);
            
            HttpSession session = request.getSession();
            String id = (String) session.getAttribute("id");

            int check = 0; // 기본은 안 누른 상태(0)
            if(id != null) {
                LikeVO lvo = new LikeVO();
                lvo.setId(id);
                lvo.setGoods_no(gno);
                check = LikeDAO.likeCheck(lvo);
            }
            int likecount = LikeDAO.likeCount(gno);

            request.setAttribute("check", check);
            request.setAttribute("likecount", likecount);
        }
        
        if(goods_no!=null) {
        	int gno = Integer.parseInt(goods_no);
            GoodsVO vo = GoodsDAO.goodsDetailData(gno);
            
            // 촤근 본 상품 쿠키에 저장
            Cookie[] cookies = request.getCookies();

            String recent = "";

            if(cookies != null)
            {
                for(Cookie c : cookies)
                {
                    if(c.getName().equals("recent_goods"))
                    {
                        recent = c.getValue();
                    }
                }
            }


            // 기존 목록에서 현재 상품 제거 (중복 방지)
            String[] arr = recent.split("_");

            StringBuilder sb = new StringBuilder();

            sb.append(gno);


            // 최신 상품을 앞에 추가
            for(String s : arr)
            {
                if(!s.equals("") && !s.equals(String.valueOf(gno)))
                {
                    sb.append("_").append(s);
                }
            }


            // 최대 5개 제한
            String[] result = sb.toString().split("_");

            String value = "";

            for(int i=0; i<result.length && i<5; i++)
            {
                if(i>0)
                    value += "_";

                value += result[i];
            }


            // 쿠키 저장
            Cookie cookie = new Cookie("recent_goods", value);
            cookie.setPath("/");
            cookie.setMaxAge(60*60*24*7);

            response.addCookie(cookie);
            
            request.setAttribute("vo", vo);
            
            List<ReviewVO> rList = GoodsDAO.goodsReviewList(gno);
            request.setAttribute("rList", rList);
            
            List<QnaVO> qList = GoodsDAO.goodsQnaList(gno);
            request.setAttribute("qList", qList);
            
            HttpSession session = request.getSession();
            String id = (String) session.getAttribute("id");

            int check = 0; // 기본은 안 누른 상태(0)
            if(id != null) {
                LikeVO lvo = new LikeVO();
                lvo.setId(id);
                lvo.setGoods_no(gno);
                check = LikeDAO.likeCheck(lvo);
            }
            int likecount = LikeDAO.likeCount(gno);

            request.setAttribute("check", check);
            request.setAttribute("likecount", likecount);
        }
        
        request.setAttribute("main_jsp", "../goods/detail.jsp");
        return "../main/main.jsp";
    }

    // 4. 검색 메인 화면 열기
    @RequestMapping("goods/find.do")
    public String goods_find(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("goods_content", "../goods/find.jsp");
        request.setAttribute("main_jsp", "../goods/goods.jsp");
        return "../main/main.jsp";
    }
    
    // 5. 검색 데이터 전송 
    @RequestMapping("goods/find_vue.do")
    public void goods_find_vue(HttpServletRequest request, HttpServletResponse response) {
        String page=request.getParameter("page");
        String cno=request.getParameter("cno"); 
        String fd=request.getParameter("fd"); // 검색어 
        HttpSession session = request.getSession();
        String id = (String)session.getAttribute("id");
	   
        if(page==null) 
        	page = "1";
        if(cno==null) 
        	cno = "0"; 
        if(id == null) 
	        id = ""; 
	     
        int curpage = Integer.parseInt(page);
        
        // DB 전송
        Map map=new HashMap();
        map.put("cno", Integer.parseInt(cno)); // 숫자로 형변환!
        map.put("fd", fd);
        map.put("start", (curpage*12)-12);
        map.put("id", id);
        
        List<GoodsVO> list=GoodsDAO.goodsFindListData(map);
        int totalpage=GoodsDAO.goodsFindTotalPage(map);
        
        final int BLOCK=10;
        int startPage=((curpage-1)/BLOCK*BLOCK)+1;
        int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
        if(endPage>totalpage) endPage=totalpage;
        
        try {
            // Vue로 보낼 데이터
            Map responseMap = new HashMap();
            responseMap.put("fd", fd);
            responseMap.put("cno", cno); 
            responseMap.put("list", list);
            responseMap.put("curpage", curpage);
            responseMap.put("totalpage", totalpage);
            responseMap.put("startPage", startPage);
            responseMap.put("endPage", endPage);
            
            ObjectMapper mapper=new ObjectMapper();
            String json=mapper.writeValueAsString(responseMap);
            
            // 전송
            response.setContentType("text/plain;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.write(json);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
 // 장바구니 담기
    @RequestMapping("goods/cart_insert.do")
    public void cart_insert(HttpServletRequest request, HttpServletResponse response) {
        try {
            HttpSession session=request.getSession();
            String id=(String) session.getAttribute("id");

            response.setContentType("text/plain;charset=UTF-8");
            PrintWriter out=response.getWriter();
            
            if(id==null) {
                out.write("NO_LOGIN"); 
                return;
            }
            
            // 화면에서 보낸 데이터 받기
            String goods_no=request.getParameter("goods_no");
            String goods_size=request.getParameter("sizes");
            String requestQty=request.getParameter("quantity"); 
            int reqQuantity=Integer.parseInt(requestQty);
            
            // 재고번호와 남은 수량 가져오기
            Map stockMap=new HashMap();
            stockMap.put("goods_no", Integer.parseInt(goods_no));
            stockMap.put("goods_size", Integer.parseInt(goods_size));
            
            StockVO svo=GoodsDAO.stockQuantityCheck(stockMap); ; 
            
            // 해당 사이즈의 재고 데이터 자체가 없을 때
            if(svo==null) {
                out.write("NO_STOCK_DATA");
                return;
            }
            // 재고가 요청보다 적을때
            if(svo.getQuantity() < reqQuantity) {
                out.write("OUT_OF_STOCK");
                return;
            }
            
            Map cartMap=new HashMap();
            cartMap.put("id", id);
            cartMap.put("stock_no", svo.getNo()); 
            cartMap.put("sizes", Integer.parseInt(goods_size));
            cartMap.put("quantity", reqQuantity);
            
            // 장바구니 테이블 조회 및 담기
            int cartCount=GoodsDAO.cartCount(cartMap);
            
            if(cartCount>0) {
                GoodsDAO.cartUpdate(cartMap); // 이미 있으면 수량 증가
            } else {
                GoodsDAO.cartInsert(cartMap); // 없으면 새로 추가
            }
            
            out.write("SUCCESS");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @RequestMapping("main/main.do") 
    public String main_page(HttpServletRequest request, HttpServletResponse response) {
        
        List<GoodsVO> gList = GoodsDAO.goodsMainView();
        request.setAttribute("gList", gList);
        
        request.setAttribute("main_jsp", "../main/home.jsp");
        return "../main/main.jsp";
    }
    
    @RequestMapping("goods/getStockNo.do")
    public void goods_getStockNo(HttpServletRequest request, HttpServletResponse response) {
        try {
            String goods_no = request.getParameter("goods_no");
            String goods_size = request.getParameter("goods_size");
            
            PrintWriter out = response.getWriter();
            
            if (goods_no == null || goods_no.trim().equals("")) {
                System.out.println("에러: goods_no 값이 비어있습니다!");
                out.print("0");
                return;
            }

            Map<String, Object> map = new HashMap<>();
            map.put("goods_no", Integer.parseInt(goods_no)); 
            map.put("goods_size", goods_size);
            
            // DB에서 재고 번호 조회
            StockVO svo = GoodsDAO.stockQuantityCheck(map);
            
            if (svo != null) {
                out.print(svo.getNo()); // 재고 번호 반환
            } else {
                out.print("0"); // 재고 없음 반환
            }
            
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
}