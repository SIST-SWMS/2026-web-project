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

	// 회원가입- 회원추가
	@RequestMapping("member/join_ok.do")
	public void member_join_ok(HttpServletRequest request, HttpServletResponse response) {
		MemberVO vo = new MemberVO();

		vo.setId(request.getParameter("id"));
		vo.setPwd(request.getParameter("pwd"));
		vo.setName(request.getParameter("name"));
		vo.setNickname(request.getParameter("nickname"));
		vo.setPhone(request.getParameter("phone"));
		vo.setZipcode(request.getParameter("zipcode"));
		vo.setAddress(request.getParameter("address"));
		vo.setAddress_detail(request.getParameter("address_detail"));

		MemberDAO.memberInsert(vo);

		try {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script>");
			out.println("alert('회원가입이 완료되었습니다. 로그인해주세요.');");
			out.println("location.href='../member/login.do';");
			out.println("</script>");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	// 아이디 중복체크
	@RequestMapping("member/idcheck.do")
	public String member_idcheck(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");

		if (id == null)
			id = "";

		int count = MemberDAO.idCount(id);

		request.setAttribute("id", id);
		request.setAttribute("count", count);

		return "../member/idcheck.jsp";
	}

	// 닉네임 중복체크
	@RequestMapping("member/nickcheck.do")
	public String member_nickcheck(HttpServletRequest request, HttpServletResponse response) {
		String nickname = request.getParameter("nickname");

		if (nickname == null)
			nickname = "";

		int count = MemberDAO.nickCount(nickname);

		request.setAttribute("nickname", nickname);
		request.setAttribute("count", count);

		return "../member/nickcheck.jsp";
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
			session.setAttribute("auth", vo.getAuth() == 0 ? "adm" : "user");
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
	public String member_detail(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		String id = (String) session.getAttribute("id");

		MemberVO vo = MemberDAO.memberDetailData(id);

		request.setAttribute("vo", vo);

		request.setAttribute("mypage_content", "../mypage/member_detail.jsp");

		request.setAttribute("main_jsp", "../mypage/mypage.jsp");

		return "../main/main.jsp";
	}

	// 비밀번호 입력화면 이동 -> jsp를 하나 새로 만들어야해 기존의 기능들과는 또다른 기능이라서
	@RequestMapping("member/editMember.do")
	public String member_editMember(HttpServletRequest request, HttpServletResponse response) {

		return "../mypage/pwd_check.jsp";
	}

	// 비밀번호가 맞냐/틀리냐
	@RequestMapping("member/pwdCheck.do")
	public String member_pwdCheck(HttpServletRequest request, HttpServletResponse response) {

		String pwd1 = request.getParameter("pwd");

		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");

		String pwd2 = MemberDAO.memberFindPassword(id);

		if (pwd1.equals(pwd2)) {

			MemberVO member = MemberDAO.memberDetailData(id);

			request.setAttribute("vo", member);

			request.setAttribute("mypage_content", "../mypage/member_update.jsp");

			request.setAttribute("main_jsp", "../mypage/mypage.jsp");

			return "../main/main.jsp";

		} else {
			System.out.println("비밀번호 불일치");

			request.setAttribute("msg", "비밀번호가 틀렸습니다.");

			return "../mypage/pwd_check.jsp";
		}
	}

	@RequestMapping("member/update_ok.do")
	public String member_update_ok(HttpServletRequest request, HttpServletResponse response) {

		MemberVO vo = new MemberVO();

		vo.setId(request.getParameter("id"));
		vo.setName(request.getParameter("name"));
		vo.setNickname(request.getParameter("nickname"));
		vo.setPhone(request.getParameter("phone"));
		vo.setZipcode(request.getParameter("zipcode"));
		vo.setAddress(request.getParameter("address"));
		vo.setAddress_detail(request.getParameter("address_detail"));

		
		
		MemberDAO.memberUpdate(vo);
		
		
		
		
		 
		
		
		return "redirect:../member/detail.do";
	}

}
