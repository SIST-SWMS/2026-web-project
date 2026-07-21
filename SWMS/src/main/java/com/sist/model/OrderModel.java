package com.sist.model;

import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.OrderDAO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.sist.dao.*;
import com.sist.vo.*;

@Controller
public class OrderModel {
	
	// 장바구니에서 여러개 물품 결제하기 눌렀을때 주문서 작성 화면으로 넘어감
	@RequestMapping("order/before_order.do")
	public String before_order(HttpServletRequest request, HttpServletResponse response)
	{
		// 장바구니에서 여러개 물품 결제하기
		String cart_nos = request.getParameter("cart_nos");
		String stock_nos = request.getParameter("stock_nos");
		String quantities = request.getParameter("quantities");
		System.out.println("카트번호모음: "+cart_nos);
		System.out.println("재고번호모음: "+stock_nos);
		System.out.println("갯수모음: "+quantities);
		
		HttpSession session = request.getSession();
		String id = session.getAttribute("id").toString();
		MemberVO mvo = MemberDAO.memberDetailData(id);
		
		String[] cart_no = cart_nos.split(",");
		String[] stock_no = stock_nos.split(",");
		String[] quantity = quantities.split(",");
		
		List<String> cnList = new ArrayList<String>();
		List<String> snList = new ArrayList<String>();
		List<String> qList = new ArrayList<String>();
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<OrderDetailVO> list = new ArrayList<OrderDetailVO>();
		
		int totalPrice = 0;
		List<String> plist = new ArrayList<String>();
		//String price = "";
		
		for(int i = 0; i < cart_no.length; i++)
		{			
			map.put("stock_no", Integer.parseInt(stock_no[i]));
			map.put("id", id);
			OrderDetailVO vo = OrderDAO.orderListData(map);
			vo.setQuantity(Integer.parseInt(quantity[i]));
			list.add(vo);
			cnList.add(cart_no[i]); // vo에 cart_no가 없어서 임의로 담아줌 (결제완료 후 장바구니 삭제 용도)
			snList.add(quantity[i]);
			qList.add(quantity[i]);
			
			// 주문서에 보여주는 총 상품 결제 가격
			String price = vo.getPrice_str().replaceAll("[^0-9]", "");
			totalPrice += vo.getQuantity() * Integer.parseInt(price);
			vo.setPrice(Integer.parseInt(price));
			vo.setStock_no(Integer.parseInt(stock_no[i]));
		}
		
		
		DecimalFormat df = new DecimalFormat("#,###");
		String totalPrice_str = df.format(totalPrice);
		
		request.setAttribute("mvo", mvo);
		request.setAttribute("id", id);
		
		request.setAttribute("list", list);		// 주문상세목록에 보여줄 상품들 리스트
		request.setAttribute("quantity", qList);	// 각 상품 주문 갯수 리스트 (list에도 저장되어있긴 함)
		
		request.setAttribute("totalPrice", totalPrice);	// 총 상품 가격 int
		request.setAttribute("totalPrice_str", totalPrice_str);	// 총 상품 가격 String+포맷팅
		request.setAttribute("goods_price", plist);	// 숫자만 남겨놓은 개별 상품 가격 String
		
		request.setAttribute("stock_no", snList);
		
		request.setAttribute("main_jsp", "../order/checkout.jsp");
		return "../main/main.jsp";
	}

	// 장바구니에서 바로구매를 눌렀을때(1개 상품 구매) 주문서 작성 화면으로
	@RequestMapping("order/order.do")
	public String order(HttpServletRequest request, HttpServletResponse response) {
		// 상세페이지에서 바로구매
		// 장바구니에서 바로구매
		String stock_no = request.getParameter("stock_no");
		String quantity = request.getParameter("quantity");
		HttpSession session = request.getSession();
		String id = session.getAttribute("id").toString();
		MemberVO mvo = MemberDAO.memberDetailData(id);
		
		//System.out.println("stock_no: "+stock_no);
		
		Map map = new HashMap();
		map.put("stock_no", Integer.parseInt(stock_no));
		map.put("id", id);
		
		OrderDetailVO vo = OrderDAO.orderListData(map);
		vo.setQuantity(Integer.parseInt(quantity)); // vo에도 갯수 담아주기
		List<OrderDetailVO> list = new ArrayList<OrderDetailVO>();
		list.add(vo); // 여러개 결제와 형태를 통일하기 위해 list에 담아줌
		
		String price = vo.getPrice_str().replaceAll("[^0-9]", "");
		int quantity_num = Integer.parseInt(quantity);
		int totalPrice = quantity_num * Integer.parseInt(price);
		
		DecimalFormat df = new DecimalFormat("#,###");
		String totalPrice_str = df.format(totalPrice);
		
		request.setAttribute("mvo", mvo);
		request.setAttribute("id", id);
		
		request.setAttribute("list", list);
		request.setAttribute("quantity", quantity);
		
		request.setAttribute("totalPrice", totalPrice);	// 총 상품 가격 int
		request.setAttribute("totalPrice_str", totalPrice_str);	// 총 상품 가격 String+포맷팅
		request.setAttribute("goods_price", price);	// 숫자만 남겨놓은 개별 상품 가격 String
		
		
		request.setAttribute("stock_no", stock_no);
		
		
		request.setAttribute("main_jsp", "../order/checkout.jsp");
		return "../main/main.jsp";
	}
	
	// 주문서 작성에서 결제하기 눌렀을때 결제 내역 처리
	@RequestMapping("order/order_ok.do")
	public void order_ok(HttpServletRequest request, HttpServletResponse response) 
	{
		HttpSession session = request.getSession();
		String id = session.getAttribute("id").toString();
		
		// 배송 정보 받기
		String delivery_name = request.getParameter("name");
		String delivery_phone = request.getParameter("phone");
		String delivery_post= request.getParameter("zipcode");
		String delivery_addr1 = request.getParameter("addr");
		String delivery_addr2= request.getParameter("addr_detail");
		String delivery_msg = request.getParameter("msg");
		String total_price = request.getParameter("total_price");
		
		// 구매 상품 정보 받기
		String goods_no = request.getParameter("goods_no");
		String sizes = request.getParameter("sizes");
		String stock_no = request.getParameter("stock_no");
		String quantity = request.getParameter("quantity");
		String goods_price = request.getParameter("goods_price");
		
		// 넘어오는 데이터 확인용
		System.out.println(delivery_name);
		System.out.println(delivery_phone);
		System.out.println(delivery_post);
		System.out.println(delivery_addr1);
		System.out.println(delivery_addr2);
		System.out.println(delivery_msg);
		System.out.println(total_price);
		
		System.out.println(stock_no);
		System.out.println(quantity);
		System.out.println(goods_no);
		System.out.println(sizes);
		System.out.println(goods_price);
		
		// 주문 번호 먼저 받아두기 (계속 사용해야하므로)
		int order_no = OrderDAO.getOrderNo();
		// 받아둔 주문번호로 주문목록 생성하기
		OrdersVO vo = new OrdersVO();
		vo.setOrder_no(order_no);
		vo.setId(id);
		vo.setDelivery_name(delivery_name);
		vo.setDelivery_phone(delivery_phone);
		vo.setDelivery_zipcode(delivery_post);
		vo.setDelivery_addr(delivery_addr1);
		vo.setDelivery_addr_detail(delivery_addr2);
		vo.setDelivery_msg(delivery_msg);
		vo.setTotal_price(Integer.parseInt(total_price));
		OrderDAO.insertOrderData(vo);
		
		// 받아둔 주문번호로 주문 상세 생성하기
		OrderDetailVO odvo = new OrderDetailVO();
		odvo.setOrder_no(order_no);
		odvo.setGoods_no(Integer.parseInt(goods_no));
		odvo.setSizes(Integer.parseInt(sizes));
		odvo.setQuantity(Integer.parseInt(quantity));
		odvo.setPrice(Integer.parseInt(goods_price));
		odvo.setStatus("결제완료"); // 정확히 뭐라고 넣어놔야하는지 확인
		OrderDAO.insertOrderDetailData(odvo);
	}
	
	// 주문이 완료되었습니다
	@RequestMapping("order/complete_order.do")
	public String complete_order(HttpServletRequest request, HttpServletResponse response) 
	{
		request.setAttribute("main_jsp", "../order/complete_order.jsp");
		return "../main/main.jsp";
	}
	
	
}
