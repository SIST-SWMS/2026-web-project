package com.sist.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.MemberVO;

public class MemberDAO {

	private static SqlSessionFactory ssf;
	static {
		try {
			ssf = CreateSqlSessionFactory.getSsf();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static int memberIdCheck(String id) {
		SqlSession session = null;
		int count = 0;
		try {
			session = ssf.openSession();
			count = session.selectOne("memberIdCheck", id);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return count;
	}

	public static MemberVO isLogin(String id, String pwd) {
		SqlSession session = null;
		MemberVO vo = new MemberVO();
		try {
			session = ssf.openSession();
			int count = session.selectOne("memberIdCheck", id);
			if (count == 0) {
				vo.setMsg("NOID");
			} 
			else {
				MemberVO dbVO = session.selectOne("memberGetPassword", id);
				if (dbVO.getPwd().equals(pwd)) {
					vo.setMsg("OK");
					vo.setId(dbVO.getId());
					vo.setName(dbVO.getName());
					vo.setNickname(dbVO.getNickname());
					vo.setPhone(dbVO.getPhone());
					vo.setZipcode(dbVO.getZipcode());
					vo.setAddress(dbVO.getAddress());
					vo.setAddress_detail(dbVO.getAddress_detail());
					vo.setAuth(dbVO.getAuth());
				} else {
					vo.setMsg("NOPWD");
				}
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return vo;
	}
}
