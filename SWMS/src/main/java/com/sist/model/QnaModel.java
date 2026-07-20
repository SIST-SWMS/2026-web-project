package com.sist.model;
import java.util.*;
import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.QnaDAO;
import com.sist.vo.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class QnaModel {
    @RequestMapping("mypage/qna.do")
    public String qna(HttpServletRequest request, HttpServletResponse response) 
    {
    	int goods_no=Integer.parseInt(request.getParameter("goods_no"));
    	
    	QnaVO vo=QnaDAO.qnaDetailData(goods_no);
    	List<QnaVO> list=new ArrayList<>();
    	list.add(vo);
    	request.setAttribute("list", list);
    	 request.setAttribute("mypage_content", "../mypage/qna.jsp");
 	    request.setAttribute("main_jsp", "../mypage/mypage.jsp");
 	    return "../main/main.jsp";
    }
}
