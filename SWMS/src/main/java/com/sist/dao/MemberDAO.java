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
	
	/*
	 * <select id="memberDetailData" resultType="MemberVO"
		parameterType="string">

		select id,pwd,name,nickname,phone,zipcode,address,address_detail
		from member
		where id=#{id}
	</select>
	 */
	
	public static MemberVO memberDetailData(String id)
	{
	    SqlSession session=ssf.openSession();

	    MemberVO vo=session.selectOne(
	            "memberDetailData",
	            id);

	    session.close();

	    return vo;
	}
	
	/*
	 *  <select id="memberFindPassword" resultType="string"
		parameterType="string">
		SELECT pwd FROM member
		WHERE id = #{id}
	    </select>
	 */
	// 디비에서 검색한 데이터 가져와서 담아놓고 모델에 전달만
	public static String memberFindPassword(String id)
	{
		SqlSession session =ssf.openSession();
		String dbpwd = session.selectOne("memberFindPassword",id);
		session.close();
		
		return dbpwd;
	}
	
	
	
	// 회원정보 수정
	public static void memberUpdate(MemberVO vo)
	{
	    SqlSession session = ssf.openSession(true);

	    session.update("memberUpdate", vo);

	    session.close();
	}
	
	// 회원가입
	public static void memberInsert(MemberVO vo)
	{
	    SqlSession session=ssf.openSession(true);
	    session.insert("memberInsert",vo);
	    session.close();
	}
	
	// 디비에서 아이디 몇개인지 중복체크
	public static int idCount(String id)
	{
	    SqlSession session=ssf.openSession();
	    int count=session.selectOne("idCount", id);
	    session.close();
	    return count;
	}
	
	// 닉네임 중복체크
	public static int nickCount(String nickname)
	{
	    SqlSession session=ssf.openSession();
	    int count=session.selectOne("nickCount", nickname);
	    session.close();
	    return count;
	}
}
