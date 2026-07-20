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

	// 장바구니에서 결제하기 눌렀을때 주문서 작성 화면으로
	@RequestMapping("order/order.do")
	public String order(HttpServletRequest request, HttpServletResponse response) {
		String stock_no = request.getParameter("stock_no");
		String quantity = request.getParameter("quantity");
		HttpSession session = request.getSession();
		String id = session.getAttribute("id").toString();
		MemberVO mvo = MemberDAO.memberDetailData(id);
		
		//System.out.println("stock_no: "+stock_no);
		
		Map map = new HashMap();
		map.put("stock_no", Integer.parseInt(stock_no));
		map.put("id", id);
		
		List<OrderDetailVO> list = OrderDAO.orderListData(map);
		
		String price = list.get(0).getPrice_str().replaceAll("[^0-9]", "");
		int quantity_num = Integer.parseInt(quantity);
		int totalPrice = quantity_num * Integer.parseInt(price);
		
		DecimalFormat df = new DecimalFormat("#,###");
		String totalPrice_str = df.format(totalPrice);
		
		request.setAttribute("totalPrice", totalPrice);
		request.setAttribute("totalPrice_str", totalPrice_str);
		request.setAttribute("list", list);
		request.setAttribute("quantity", quantity);
		request.setAttribute("goods_price", price);
		
		request.setAttribute("mvo", mvo);
		request.setAttribute("id", id);
		
		request.setAttribute("stock_no", stock_no);
		request.setAttribute("list_size", list.size());
		
		
		request.setAttribute("main_jsp", "../order/checkout.jsp");
		return "../main/main.jsp";
	}
	
	// 주문서 작성에서 결제하기 눌렀을때 결제 내역 처리
	@RequestMapping("order/order_ok.do")
	public void order_ok(HttpServletRequest request, HttpServletResponse response) 
	{
		HttpSession session = request.getSession();
		String id = session.getAttribute("id").toString();
		MemberVO mvo = MemberDAO.memberDetailData(id);
		
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
//		System.out.println("vo 값 들어오는지 확인");
//		System.out.println(vo.getOrder_no());
//		System.out.println(vo.getId());
//		System.out.println(vo.getDelivery_name());
//		System.out.println(vo.getDelivery_phone());
//		System.out.println(vo.getDelivery_zipcode());
//		System.out.println(vo.getDelivery_addr());
//		System.out.println(vo.getDelivery_addr_detail());
//		System.out.println(vo.getDelivery_msg());
//		System.out.println(vo.getTotal_price());
		
		
		// 받아둔 주문번호로 주문 상세 생성하기
		OrderDetailVO odvo = new OrderDetailVO();
		odvo.setOrder_no(order_no);
		odvo.setGoods_no(Integer.parseInt(goods_no));
		odvo.setSizes(Integer.parseInt(sizes));
		odvo.setQuantity(Integer.parseInt(quantity));
		odvo.setPrice(Integer.parseInt(goods_price));
		odvo.setStatus("결제완료"); // 정확히 뭐라고 넣어놔야하는지 확인
		//OrderDAO.insertOrderDetailData(odvo);
		
		//List<OrderDetailVO> list = OrderDAO.orderListData(map);
		
//		try 
//		{
//			Map map2 = new HashMap();
//			//map2.put("list",list);
//			map2.put("id", id);
//			map2.put("quantity", map2);
//			
//			ObjectMapper mapper = new ObjectMapper();
//			String json = mapper.writeValueAsString(map2);
//			
//			response.setContentType("text/plain;charset=UTF-8");
//			PrintWriter out = response.getWriter();
//			out.write(json);
//			
//		} catch (Exception ex) {
//			ex.printStackTrace();
//		}
		
		//return "../main/main.jsp"; // 주문이 완료되었습니다 페이지를 보여줘야하는데 일단은
	}
	
}
