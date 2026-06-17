package com.ict.mini.dao;

import java.util.List;
import java.util.Map;

import com.ict.mini.vo.MemberVO;
import com.ict.mini.vo.PagingVO;

public interface MemberDAO {
	//로그인
		public MemberVO loginOk(MemberVO vo); 
	//아이디 중복검사
		public int idDoubleCheck(String userid);
		//회원등록
		public int memberInsert(MemberVO vo);
		//회원선택
		public MemberVO memberSelect(String userid);
		//회원정보수정(DB)
		public int memberUpdate(MemberVO vo);
	
		//회원탈퇴
		public int unjoins(String userid ); 
			 	
		//아이디찾기
		public MemberVO findMemberByEmailAndName(Map<String, Object> params);
		
		// 사용자 ID가 존재하는지 확인
		public boolean checkUserIdExists(String userid);  
		
		// 사용자 이름과 전화번호 검증
		public boolean checkUsernameAndTel(Map<String, Object> params);
		
		 // 비밀번호 업데이트
		public int updatePassword(String userpwd, String userid);   
		public String findUserid(Map<String, Object> params);
		// 회원정보관리
		public List<MemberVO> memSelectAll(PagingVO pVO);
		// 총회원수 구하기
		public int totalmem(PagingVO pVO);
		// 관리자가 유저 한명씩 탈퇴시키기
		public int delOneUser(String userid);
		
		// 관리자가 유저한번에 여러명 탈퇴시키기
		
		public int delUsers(List<String> delList);
		public String getUserimg(String userid);
		
		
		
}
