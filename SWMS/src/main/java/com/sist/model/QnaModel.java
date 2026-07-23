package com.sist.model;
import java.util.*;
import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
    /*
     * <insert id="qnaInsert" parameterType="QnaVO">
	  INSERT INTO qna(qna_no,parent_no,type,subject,content,status,id,is_secret,created_at,goods_no)
	  VALUES(qna_no_seq.nextval,#{parent_no},#{type}#{subject},#{content},#{status},#{id},#{is_secret},SYSDATE,#{goods_no})
	  
	 </insert>
     * 
     */
    @RequestMapping("mypage/qna_ok.do")
    public String qna_ok(HttpServletRequest request, HttpServletResponse response)
    {
    	String goods_no=request.getParameter("goods_no");
    	String type=request.getParameter("type");
    	String subject=request.getParameter("subject");
    	String is_secret=request.getParameter("secret");
    	String content=request.getParameter("content");
    	HttpSession session=request.getSession();
    	String id=(String)session.getAttribute("id"); 
    	
    	QnaVO vo=new QnaVO();
    	vo.setGoods_no(Integer.parseInt(goods_no));
    	vo.setType(type);
    	vo.setSubject(subject);
    	vo.setIs_secret(is_secret !=null?"y":"n");
    	vo.setContent(content);
    	vo.setId(id);
    	vo.setStatus("답변대기");
    	vo.setParent_no(0);
    	
    	QnaDAO.qnaInsert(vo);
    	return "redirect:../mypage/qnaList.do";
    }
    
    @RequestMapping("mypage/qna_view.do")
    public String qna_view(HttpServletRequest request, HttpServletResponse response)
    {
    	HttpSession session = request.getSession();
    	String id = (String) session.getAttribute("id");
    	if (id == null) {
    		return "redirect:../member/login.do";
    	}
    	int qna_no = Integer.parseInt(request.getParameter("qna_no"));
    	QnaVO vo = QnaDAO.qnaDetail(qna_no);
        QnaVO answer=QnaDAO.QnaAnswer(vo.getParent_no());
    	request.setAttribute("vo",vo);
    	request.setAttribute("answer", answer);
    	request.setAttribute("mypage_content","../mypage/qna_view.jsp");
    	request.setAttribute("main_jsp","../mypage/mypage.jsp");
    	return "../main/main.jsp";
    }
    
    @RequestMapping("mypage/qna_edit.do")
	public String qna_edit(HttpServletRequest request, HttpServletResponse response)
	{
         HttpSession session=request.getSession();
         String id=(String)session.getAttribute("id");
         String no=request.getParameter("qna_no");
         if (id == null) {
 	    	return "redirect:../member/login.do";
 	    }
        QnaVO vo=QnaDAO.qnaUpdateData(Integer.parseInt(no));
        if (vo == null || !id.equals(vo.getId())) {
	        return "redirect:../mypage/qnaList.do";
	    }
        
	    request.setAttribute("vo", vo);   	
    	request.setAttribute("mypage_content","../mypage/qna_edit.jsp");
    	request.setAttribute("main_jsp","../mypage/mypage.jsp");
    	return "../main/main.jsp";
	}
    
    @RequestMapping("mypage/qna_edit_ok.do")
    public String qna_edit_ok(HttpServletRequest request, HttpServletResponse response)
    {
    	String no=request.getParameter("qna_no");
    	String type=request.getParameter("type");
    	String subject=request.getParameter("title");
    	String is_secret=request.getParameter("secret");
    	String content=request.getParameter("content");
    	System.out.println(content);
    	QnaVO vo=new QnaVO();
    	vo.setQna_no(Integer.parseInt(no));
    	vo.setType(type);
    	vo.setSubject(subject);
    	vo.setIs_secret(is_secret != null ? "y" : "n");
    	vo.setContent(content);
    	
    	QnaDAO.qnaUpdate(vo);
    	return "redirect:../mypage/qna_view.do?qna_no="+no;
    	
    }
    
    @RequestMapping("mypage/qna_delete.do")
	public String qna_delete(HttpServletRequest request, HttpServletResponse response)
	{
	    HttpSession session = request.getSession();
	    String id = (String) session.getAttribute("id");
	    String no = request.getParameter("no");
	    if (id == null) {
	        return "redirect:../member/login.do";
	    }

	    QnaVO vo = QnaDAO.qnaDetail(Integer.parseInt(no));
	    if (vo == null || !id.equals(vo.getId())) {
	        return "redirect:../mypage/qnaList.do";
	    }

	    QnaDAO.qnaDelete(Integer.parseInt(no));

	    return "redirect:../mypage/qnaList.do";
	}
	
}
