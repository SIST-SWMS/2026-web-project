package com.sist.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.LikeVO;

public class LikeDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
	/*
	 *  <insert id="likeOn" parameterType="com.sist.vo.LikeVO">
			INSERT INTO goods_like VALUES (
				goods_like_like_no_seq.nextval,
				#{goods_no},
				#{id}
			)
		</insert>
		*/
	public static void likeOn(LikeVO vo) {
		SqlSession session=ssf.openSession(true);
		session.insert("likeOn",vo);
		session.close();
	}
	/*
		<delete id="likeOff" parameterType="com.sist.vo.LikeVO">
			DELETE FROM goods_like
			WHERE id=#{id} AND good_no=#{goods_no}
		</delete>
		*/
	public static void likeOff(LikeVO vo) {
		SqlSession session=ssf.openSession(true);
		session.delete("likeOff",vo);
		session.close();
	}
	/*
		<select id="likeCount" resultType="int" parameterType="int">
			SELECT COUNT(*)
			FROM goods_like
			WHERE goods_no=#{goods_no}
		</select>
		*/
	public static int likeCount(int goods_no) {
		SqlSession session=ssf.openSession();
		int count=session.selectOne("likeCount", goods_no);
		session.close();
		return count;
	}
	/*
		<select id="likeCheck" resultType="int" parameterType="com.sist.vo.LikeVO">
			SELECT COUNT(*)
			FROM goods_like
			WHERE goods_no=#{goods_no} AND id=#{id}
		</select>
		*/
	public static int likeCheck(LikeVO vo) {
		SqlSession session=ssf.openSession();
		int count=session.selectOne("likeCheck", vo);
		session.close();
		return count;
	}
	/*
		<update id="goodsLikeUpdate">
			UPDATE goods_like SET
			likecount=(SELECT COUNT(*)
						FROM goods_like
						WHERE goods_no=#{goods_no})
			WHERE no=#{goods_no}
		</update>
	 */
	
	/*
	 * public static void goodsLikeUpdate(int goods_no) { SqlSession
	 * session=ssf.openSession(true); session.update("goodsLikeUpdate", goods_no);
	 * session.close(); }
	 */
	 
}
