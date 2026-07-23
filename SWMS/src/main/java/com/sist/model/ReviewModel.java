 package com.sist.model;

import java.util.*;

import com.sist.commons.FileUploadUtil;
import com.sist.commons.UploadConfig;
import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import com.sist.vo.*;
import com.sist.dao.*;

@Controller
public class ReviewModel {
	@RequestMapping("mypage/review.do")
	public String review(HttpServletRequest request, HttpServletResponse response) {
	    int order_no = Integer.parseInt(request.getParameter("order_no"));
	    int goods_no = Integer.parseInt(request.getParameter("goods_no"));

	    ReviewVO vo = ReviewDAO.reviewDetailData(order_no, goods_no);
	    List<ReviewVO> list = new ArrayList<>();
	    list.add(vo);
	    request.setAttribute("list", list);

	    request.setAttribute("mypage_content", "../mypage/review.jsp");
	    request.setAttribute("main_jsp", "../mypage/mypage.jsp");
	    return "../main/main.jsp";
	}

	@RequestMapping("mypage/review_ok.do")
	public String review_ok(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String uploadPath = UploadConfig.getUploadPath();
		
	   String goods_no=request.getParameter("goods_no"); // 상품 번호
		String hit = request.getParameter("rating");
		String subject = request.getParameter("title");
		String content = request.getParameter("content");
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id"); // 사용자 id
		String order_no = request.getParameter("order_no");
		

		
		Part filePart = request.getPart("image");
		String image = "";
		if (filePart != null) {
			image = FileUploadUtil.upload(uploadPath, filePart);
		}

		ReviewVO vo = new ReviewVO();
		vo.setOrder_no(Integer.parseInt(order_no));
		vo.setGoods_no(Integer.parseInt(goods_no));
		vo.setSubject(subject);
		vo.setContent(content);
		vo.setId(id);
		vo.setHit(hit);
		vo.setImage(image);
		
		System.out.println(vo.toString());

		ReviewDAO.reviewInsert(vo);
		
		return "redirect:../mypage/reviewList.do";
	}
	
	@RequestMapping("mypage/review_view.do")
	public String review_view(HttpServletRequest request, HttpServletResponse response) {
		
		
		
		
	    HttpSession session = request.getSession();
	    String id = (String) session.getAttribute("id");
	    String no = request.getParameter("no");
	    if (id == null) {
	        return "redirect:../member/login.do";
	    }

	    ReviewVO vo = ReviewDAO.reviewDetail(Integer.parseInt(no));
	    
	    if (vo == null || !id.equals(vo.getId())) {
	        return "redirect:../mypage/reviewList.do";
	    }
	    request.setAttribute("vo", vo);
	    request.setAttribute("mypage_content", "../mypage/review_view.jsp");
	    request.setAttribute("main_jsp", "../mypage/mypage.jsp");
	    return "../main/main.jsp";
	}
	
	
	@RequestMapping("mypage/review_edit.do")
	public String review_edit(HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session = request.getSession();
	    String id = (String) session.getAttribute("id");
	    String no = request.getParameter("no");
	    if (id == null) {
	    	return "redirect:../member/login.do";
	    }
	    ReviewVO vo = ReviewDAO.reviewDetail(Integer.parseInt(no));
	    if (vo == null || !id.equals(vo.getId())) {
	        return "redirect:../mypage/reviewList.do";
	    }

	    request.setAttribute("vo", vo);
	    request.setAttribute("mypage_content", "../mypage/review_edit.jsp");
	    request.setAttribute("main_jsp", "../mypage/mypage.jsp");
	    return "../main/main.jsp";
	}
	
	@RequestMapping("mypage/review_edit_ok.do")
	public String review_edit_ok(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String uploadPath = UploadConfig.getUploadPath();
		
		Part filePart = request.getPart("image");
		String image = "";
		if (filePart != null) {
			image = FileUploadUtil.upload(uploadPath, filePart);
		}
		
	    String no = request.getParameter("review_no");
	    String hit = request.getParameter("rating");
	    String subject = request.getParameter("title");
	    String content = request.getParameter("content");

	    ReviewVO vo = new ReviewVO();
	    vo.setReview_no(Integer.parseInt(no));
	    vo.setSubject(subject);
	    vo.setContent(content);
	    vo.setHit(hit);
	    vo.setImage(image);

	    ReviewDAO.reviewUpdate(vo);

	    return "redirect:../mypage/review_view.do?no=" + no;
	}

	@RequestMapping("mypage/review_delete.do")
	public String review_delete(HttpServletRequest request, HttpServletResponse response)
	{
	    HttpSession session = request.getSession();
	    String id = (String) session.getAttribute("id");
	    String no = request.getParameter("no");
	    if (id == null) {
	        return "redirect:../member/login.do";
	    }

	    ReviewVO vo = ReviewDAO.reviewDetail(Integer.parseInt(no));
	    if (vo == null || !id.equals(vo.getId())) {
	        return "redirect:../mypage/reviewList.do";
	    }

	    ReviewDAO.reviewDelete(Integer.parseInt(no));

	    return "redirect:../mypage/reviewList.do";
	}
	
}
