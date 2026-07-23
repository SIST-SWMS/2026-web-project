package com.sist.model;

import java.util.ArrayList;
import java.util.List;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.OrderDAO;
import com.sist.dao.*;
import com.sist.vo.*;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MypageModel {

	// 마이페이지 메인
	@RequestMapping("mypage/mypage.do")
	public String mypage(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		String name = (String) session.getAttribute("name");

		if (id == null) {
			return "redirect:../member/login.do";
		}

		List<OrderDetailVO> list = OrderDAO.myOrderDetailData(id);

		request.setAttribute("list", list);

		List<GoodsLikeVO> likeList = GoodsLikeDAO.likeListData(id);

		request.setAttribute("likeList", likeList);

		request.setAttribute("name", name);

		request.setAttribute("mypage_content", "../mypage/mypage_main.jsp");

		request.setAttribute("main_jsp", "../mypage/mypage.jsp");

		return "../main/main.jsp";
	}

	// 주문 목록
	@RequestMapping("mypage/orderList.do")
	public String mypage_order_list(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		String id = (String) session.getAttribute("id");

		if (id == null) {
			return "redirect:../member/login.do";
		}

		List<OrderDetailVO> list = OrderDAO.myOrderDetailData(id);

		request.setAttribute("list", list);

		request.setAttribute("mypage_content", "../mypage/order_list.jsp");

		request.setAttribute("main_jsp", "../mypage/mypage.jsp");

		return "../main/main.jsp";
	}

	// 주문 상세
	@RequestMapping("mypage/orderListDetail.do")
	public String order_detail(HttpServletRequest request, HttpServletResponse response) {

		String order_no = request.getParameter("order_no");

		int no = Integer.parseInt(order_no);

		List<OrderDetailVO> list = MyPageDAO.orderListDetailData(no);

		request.setAttribute("list", list);

		request.setAttribute("mypage_content", "../mypage/order_detail.jsp");

		request.setAttribute("main_jsp", "../mypage/mypage.jsp");

		return "../main/main.jsp";
	}

	// 취소/교환/반품
	@RequestMapping("mypage/claimList.do") 
	public String claimList(HttpServletRequest request, HttpServletResponse response) {

	    HttpSession session = request.getSession();
	    String id = (String) session.getAttribute("id");

	    List<OrderDetailVO> list = MyPageDAO.claimListData(id);

	    request.setAttribute("list", list);
	    request.setAttribute("mypage_content", "../mypage/claim_list.jsp");
	    request.setAttribute("main_jsp", "../mypage/mypage.jsp");

	    return "../main/main.jsp";
	}

	// 리뷰 목록
	@RequestMapping("mypage/reviewList.do")
	public String reviewList(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		String id = (String) session.getAttribute("id");

		if (id == null) {
			return "redirect:../member/login.do";
		}

		List<ReviewVO> list = ReviewDAO.reviewListData(id);

		request.setAttribute("list", list);

		request.setAttribute("mypage_content", "../mypage/review_list.jsp");

		request.setAttribute("main_jsp", "../mypage/mypage.jsp");

		return "../main/main.jsp";
	}

	// 문의 목록
	@RequestMapping("mypage/qnaList.do")
	public String qnaList(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		String id = (String) session.getAttribute("id");

		if (id == null) {
			return "redirect:../member/login.do";
		}

		List<QnaVO> list = QnaDAO.qnaListData(id);

		request.setAttribute("list", list);

		request.setAttribute("mypage_content", "../mypage/qna_list.jsp");

		request.setAttribute("main_jsp", "../mypage/mypage.jsp");

		return "../main/main.jsp";
	}

	@RequestMapping("mypage/member_detail.do")
	public String mypage_member_detail(HttpServletRequest request, HttpServletResponse response) {
		// 디비에 있는 회원정보 가져온다
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		if (id == null) {
			return "redirect:../member/login.do";
		}

		List<QnaVO> list = QnaDAO.qnaListData(id);

		request.setAttribute("list", list);
		request.setAttribute("mypage_content", "../mypage/member_detail.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
	}

	// 최근 주문
	@RequestMapping("mypage/recent_order.do")
	public String recent_order(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		String id = (String) session.getAttribute("id");

		if (id == null) {
			return "redirect:../member/login.do";
		}

		List<OrderDetailVO> list = OrderDAO.myOrderDetailData(id);

		request.setAttribute("list", list);

		request.setAttribute("mypage_content", "../mypage/recent_order.jsp");

		request.setAttribute("main_jsp", "../mypage/mypage.jsp");

		return "../main/main.jsp";
	}

	// 최근 본 상품 쿠키
	@RequestMapping("mypage/recent.do")
	public String recent_goods(HttpServletRequest request, HttpServletResponse response) {

		List<GoodsVO> list = new ArrayList<>();

		Cookie[] cookies = request.getCookies();

		if (cookies != null) {

			for (Cookie c : cookies) {

				if (c.getName().equals("recent_goods")) {

					String[] arr = c.getValue().split("_");

					for (String s : arr) {

						GoodsVO vo = GoodsDAO.goodsDetailData(Integer.parseInt(s));

						list.add(vo);
					}
				}
			}
		}

		request.setAttribute("list", list);

		request.setAttribute("mypage_content", "../mypage/recent_list.jsp");

		request.setAttribute("main_jsp", "../mypage/mypage.jsp");

		return "../main/main.jsp";
	}

	// 좋아요 목록
	@RequestMapping("mypage/likeList.do")
	public String likeList(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		String id = (String) session.getAttribute("id");

		if (id == null) {
			return "redirect:../member/login.do";
		}

		List<GoodsLikeVO> list = GoodsLikeDAO.likeListData(id);

		request.setAttribute("list", list);

		request.setAttribute("mypage_content", "../mypage/like_list.jsp");

		request.setAttribute("main_jsp", "../mypage/mypage.jsp");

		return "../main/main.jsp";
	}

}