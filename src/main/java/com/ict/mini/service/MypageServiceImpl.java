package com.ict.mini.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.ict.mini.dao.MypageDAO;
import com.ict.mini.vo.AnswerVO;
import com.ict.mini.vo.FestivalVO;
import com.ict.mini.vo.InquiryVO;
import com.ict.mini.vo.PagingVO;
import com.ict.mini.vo.RestVO;

@Service
public class MypageServiceImpl implements MypageService {
	@Inject
	MypageDAO dao;
	
	
	@Override
	public void updateUserProfileImage(String userId, String fileName) {
		dao.updateUserProfileImage(userId, fileName);
		
	}

	@Override
	public int totalmyinquiry(PagingVO pVO,String userid) {
		return dao.totalmyinquiry(pVO,userid);
	}

	@Override
	public List<InquiryVO> myinquiry(String userid, PagingVO pVO) {
		return dao.myinquiry(userid, pVO);
	}

	@Override
	public List<AnswerVO> answer(String userid) {
		return dao.answer(userid);
	}

	@Override
	public List<FestivalVO> getLikedFestivals(String userid) {
		// TODO Auto-generated method stub
		return dao.getLikedFestivals(userid);
	}

	@Override
	public List<RestVO> getLikedRestaurants(String userid) {
		// TODO Auto-generated method stub
		return dao.getLikedRestaurants(userid);
	}

	@Override
	public int qnaWrite(InquiryVO vo) {
		return dao.qnaWrite(vo);
	}

	@Override
	public InquiryVO selectoneqna(int index) {
		return dao.selectoneqna(index);
	}

	@Override
	public int answerWrite(AnswerVO vo) {
		// TODO Auto-generated method stub
		return dao.answerWrite(vo);
	}

	@Override
	public AnswerVO selectAnswer(int index) {
		// TODO Auto-generated method stub
		return dao.selectAnswer(index);
	}

	@Override
	public int editResult(AnswerVO vo) {
		return dao.editResult(vo);
	}

	@Override
	public void answerset(AnswerVO vo) {
		dao.answerset(vo);
		
	}

}
