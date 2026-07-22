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

	// 화면 이동용
	@RequestMapping("member/join.do")
	public String join(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("main_jsp", "../member/join.jsp");
		return "../main/main.jsp";
	}
	
	// 회원가입 
	@RequestMapping("member/join_ok.do")
	public String join_ok(HttpServletRequest request,
	        HttpServletResponse response)
	{

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

	    return "redirect:../member/login.do";
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
	public String member_update(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("mypage_content", "../member/detail.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
	}

	// 수정버튼 메서드 만들기
	// 비밀번호 입력화면 이동 -> jsp를 하나 새로 만들어야해 기존의 기능들과는 또다른 기능이라서
	@RequestMapping("member/editMember.do")
	public String member_editMember(HttpServletRequest request, HttpServletResponse response) {

		return "../mypage/pwd_check.jsp";
	}

	// 비밀번호가 맞냐/틀리냐
	@RequestMapping("member/pwdCheck.do")
	public String member_pwdCheck(HttpServletRequest request, HttpServletResponse response) {
		// 사용자가 입력한 비밀번호 가져오기
		String pwd1 = request.getParameter("pwd");

		// 세션 열어서 요청한 값 가져오기
		// getAttribute => object를 반환해서 내가 꺼낸 값의 자료형 추가로 붙여주기
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");

		// dao 호출해서 부탁한 정보 가져온 거 담아
		String pwd2 = MemberDAO.memberFindPassword(id);

		// 그다음 둘을 비교 => 문자열 비교는 equals()
		if(pwd1.equals(pwd2))
		{
			// 비번 일치 => 회원정보 수정페이지로 이동
			return "../mypage/member_update.jsp";
		}
		else
		{
			request.setAttribute("msg", "비밀번호가 틀렸습니다.");
			return "../mypage/pwd_check.jsp";
		}

		
	} 

}
