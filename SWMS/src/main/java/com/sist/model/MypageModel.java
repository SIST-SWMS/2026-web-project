package com.sist.model;

import java.util.List;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.MemberDAO;
import com.sist.dao.OrderDAO;
import com.sist.vo.MemberVO;
import com.sist.vo.OrderDetailVO;
import com.sist.dao.*;
import com.sist.vo.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MypageModel {

	@RequestMapping("mypage/mypage.do")
	public String mypage(HttpServletRequest request, HttpServletResponse response) {
		// 최근목록 불러오기
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");

		List<OrderDetailVO> list = OrderDAO.myOrderDetailData(id);
		request.setAttribute("list", list);
		
		
		
		
		request.setAttribute("mypage_content", "../mypage/mypage_main.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
	}
	

	@RequestMapping("mypage/orderList.do")
	public String mypage_order_list(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("mypage_content", "../mypage/order_list.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
	}

	
	@RequestMapping("mypage/detail.do")
	public String mypage_order_detail(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("mypage_content", "../mypage/order_view.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
	}
	
	
	@RequestMapping("mypage/claimList.do")
	public String mypage_claim_list(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("mypage_content", "../mypage/claim_list.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("mypage/reviewList.do")
	public String mypage_review_list(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");

		List<ReviewVO> list = ReviewDAO.reviewListData(id);
		request.setAttribute("list", list);
		request.setAttribute("mypage_content", "../mypage/review_list.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
	}
	
	
	@RequestMapping("mypage/qnaList.do")
	public String mypage_qna_list(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");

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
	
	// 최근 주문 내역
	@RequestMapping("mypage/recent_order.do")
	public String mypage_recent_order(HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		System.out.println(id);
		
		// dao에 특정 아이디에 대한 정보 보내고 dao에서 보낸 데이터까지 받음
	    List<OrderDetailVO> list =	OrderDAO.myOrderDetailData(id);
	    // jsp에 내용 전송
	    
	    request.setAttribute("list", list);
	    
	    
	    
	    request.setAttribute("mypage_content", "../mypage/recent_order.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
	} 
	
}
