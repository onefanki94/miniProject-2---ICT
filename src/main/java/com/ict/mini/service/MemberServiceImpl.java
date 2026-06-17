package com.ict.mini.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.ict.mini.dao.MemberDAO;
import com.ict.mini.vo.MemberVO;
import com.ict.mini.vo.PagingVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Inject
	MemberDAO dao;
	
	@Override
	public MemberVO loginOk(MemberVO vo) {
		return dao.loginOk(vo);
	}

	@Override
	public int idDoubleCheck(String userid) {
		return dao.idDoubleCheck(userid);
	}

	@Override
	public int memberInsert(MemberVO vo) {
		return dao.memberInsert(vo);
	}

	@Override
	public MemberVO memberSelect(String userid) {
		return dao.memberSelect(userid);
	}

	@Override
	public int memberUpdate(MemberVO vo) {
		return dao.memberUpdate(vo);
	}
	
	@Override
	public int unjoins(String userid) {
		return dao.unjoins(userid);
	}

	@Override
	public MemberVO findMemberByEmailAndName(Map<String, Object> params) {
		return dao.findMemberByEmailAndName(params);
	}
	
//비밀번호 찾기
	@Override
	public boolean checkUserIdExists(String userid) {
		return dao.checkUserIdExists(userid);
	}

	@Override
	public boolean checkUsernameAndTel(Map<String, Object> params) {
		return dao.checkUsernameAndTel(params);
	}

	@Override
	public int updatePassword(String userpwd, String userid) {
		return dao.updatePassword(userpwd, userid);
	}

	@Override
	public String findUserid(Map<String, Object> params) {
		return dao.findUserid(params);
	}

	@Override
	public List<MemberVO> memSelectAll(PagingVO pVO) {
		
		return dao.memSelectAll(pVO);
	}

	@Override
	public int delOneUser(String userid) {
		
		return dao.delOneUser(userid);
	}

	@Override
	public int delUsers(List<String> delList) {
		// TODO Auto-generated method stub
		return dao.delUsers(delList);
	}

	@Override
	public int totalmem(PagingVO pVO) {
		
		return dao.totalmem(pVO);
	}

	@Override
	public String getUserimg(String userid) {
		return dao.getUserimg(userid);
	}

	


	

	

	

	

	

	

	
	
	
}
