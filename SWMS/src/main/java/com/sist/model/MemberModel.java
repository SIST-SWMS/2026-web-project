package com.sist.model;

import java.io.PrintWriter;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.MemberDAO;
import com.sist.vo.MemberVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MemberModel {

	@RequestMapping("member/join.do")
	public String join(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("main_jsp", "../member/join.jsp");
		return "../main/main.jsp";
	}

	@RequestMapping("member/login.do")
	public String login(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("main_jsp", "../member/login.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("member/logout.do")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:../main/main.do";
	}

	@RequestMapping("member/login_ok.do")
	public void login_ok(HttpServletRequest request, HttpServletResponse response) {

		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");

		MemberVO vo = MemberDAO.isLogin(id, pwd);
		if (vo.getMsg().equals("OK")) {
			HttpSession session = request.getSession();
			// 상태 유지 => 데이터값을 유지 (사용자의 기본 정보)
			session.setAttribute("id", vo.getId());
			session.setAttribute("name", vo.getName());
			session.setAttribute("nickname", vo.getNickname());
			session.setAttribute("auth", vo.getAuth()==0?"adm":"user");
		}

		try {
			response.setContentType("text/html;charset-UTF-8");
			PrintWriter out = response.getWriter();
			out.write(vo.getMsg());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("member/detail.do")
	public String member_update(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("mypage_content", "../member/detail.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
	}

}
