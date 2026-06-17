package com.ict.mini.service;

import java.util.List;
import java.util.Map;


import com.ict.mini.vo.MemberVO;
import com.ict.mini.vo.PagingVO;

public interface MemberService {
	public MemberVO loginOk(MemberVO vo);
	public int idDoubleCheck(String userid);
	public int memberInsert(MemberVO vo);
	public MemberVO memberSelect(String userid);
	public int memberUpdate(MemberVO vo);
	public int unjoins(String userid); 
	public  MemberVO findMemberByEmailAndName(Map<String, Object> params);
	
	public boolean checkUserIdExists(String userid);  // 사용자 ID가 존재하는지 확인
	public boolean checkUsernameAndTel(Map<String, Object> params);
	public int updatePassword(String userpwd, String userid);  // 비밀번호 업데이트
	public String findUserid(Map<String, Object> params);
	public List<MemberVO> memSelectAll(PagingVO pVO);
	public int delOneUser(String userid);
	public int delUsers(List<String> delList);
	// 총회원수 구하기
	public int totalmem(PagingVO pVO);
	public String getUserimg(String userid);
   
}