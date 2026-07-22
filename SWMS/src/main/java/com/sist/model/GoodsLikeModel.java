package com.sist.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.GoodsLikeDAO;
import com.sist.vo.GoodsLikeVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class GoodsLikeModel {

	// 좋아요 목록
	@RequestMapping("mypage/likeList.do")
	public String mypage_like_list(HttpServletRequest request, HttpServletResponse response) {
	    HttpSession session = request.getSession();
	    String id = (String) session.getAttribute("id");

	    List<GoodsLikeVO> list = GoodsLikeDAO.likeListData(id);

	    request.setAttribute("list", list);
	    request.setAttribute("mypage_content", "../mypage/like_list.jsp");
	    request.setAttribute("main_jsp", "../mypage/mypage.jsp");

	    return "../main/main.jsp";
	}

	// 좋아요 선택 삭제
	@RequestMapping("mypage/likeDelete.do")
	public String mypage_like_delete(HttpServletRequest request, HttpServletResponse response) {
	    HttpSession session = request.getSession();
	    String id = (String) session.getAttribute("id");

	    String[] goods = request.getParameterValues("goods_no");

	    if (goods != null) {
	        Map<String, Object> map = new HashMap<String, Object>();
	        map.put("id", id);
	        map.put("goodsList", goods);

	        GoodsLikeDAO.likeDelete(map);
	    }

	    return "redirect:likeList.do";
	}
}