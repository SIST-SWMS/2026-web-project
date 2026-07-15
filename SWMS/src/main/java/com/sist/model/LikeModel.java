package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.LikeDAO;
import com.sist.vo.LikeVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class LikeModel {
	@RequestMapping("like/likeOn.do")
	public String likeOn(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		String goods_no=request.getParameter("goods_no");
		LikeVO vo=new LikeVO();
		vo.setId(id);
		vo.setGoods_no(Integer.parseInt(goods_no));
		LikeDAO.likeOn(vo);
		/* LikeDAO.goodsLikeUpdate(Integer.parseInt(goods_no)); */
		
		return "redirect:../goods/detail.do?goods_no="+goods_no;
	}
	
	@RequestMapping("like/likeOff.do")
	public String likeOff(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		String goods_no=request.getParameter("goods_no");
		LikeVO vo=new LikeVO();
		vo.setId(id);
		vo.setGoods_no(Integer.parseInt(goods_no));
		LikeDAO.likeOff(vo);
		/* LikeDAO.goodsLikeUpdate(Integer.parseInt(goods_no)); */
		
		return "redirect:../goods/detail.do?goods_no="+goods_no;
	}
}
