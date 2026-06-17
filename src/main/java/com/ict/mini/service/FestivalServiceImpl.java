package com.ict.mini.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.ict.mini.dao.FestivalDAO;
import com.ict.mini.vo.FestivalReviewVO;
import com.ict.mini.vo.FestivalVO;
import com.ict.mini.vo.PagingVO;

@Service
public class FestivalServiceImpl implements FestivalService{
	@Inject
	FestivalDAO dao;

	@Override
	public List<FestivalVO> dataSelectAll(String sortBy) {
		// TODO Auto-generated method stub
		return dao.dataSelectAll(sortBy);
	}

	@Override
	public int dataInsert(FestivalVO vo) {
		// TODO Auto-generated method stub
		return dao.dataInsert(vo);
	}
	@Override
	public List<FestivalVO> getLikedFestivals(String userid) {
		return dao.getLikedFestivals(userid);
	}

	@Override
	public FestivalVO getFestivalById(int no) {
		// TODO Auto-generated method stub
		return dao.getFestivalById(no);
	}

	@Override
	public List<FestivalVO> calDataSelect(String date, String environment) {
		
		return dao.calDataSelect(date, environment);
	}

	@Override
	public List<FestivalVO> calDataSelect2(String date) {
		// TODO Auto-generated method stub
		return dao.calDataSelect2(date);
	}

	@Override
	public List<FestivalVO> festivalAddrSelect(String addrdetails) {
		return dao.festivalAddrSelect(addrdetails);
	}

	
	@Override
	public List<FestivalVO> festivalTop4() {
		// TODO Auto-generated method stub
		return dao.festivalTop4();
	}

	@Override
	public List<FestivalVO> getOngoingFestivals() {
		// TODO Auto-generated method stub
		return dao.getOngoingFestivals();
	}

	@Override
	public void incrementLikeCount(int no) {
		dao.incrementLikeCount(no);
		
	}

	@Override
	public void decrementLikeCount(int no) {
		dao.decrementLikeCount(no);
		
	}

	@Override
	public void incrementHitCount(int no) {
		// TODO Auto-generated method stub
		dao.incrementHitCount(no);
	}

	@Override
	public List<FestivalVO> SelectAll(PagingVO pVO) {
		
		return dao.SelectAll(pVO);
	}

	@Override
	public int delOneList(int no) {
	
		return dao.delOneList(no);
	}

	@Override
	public void delLists(List<String> delList) {
		dao.delLists(delList);
		
	}

	@Override
	public int totalfestival(PagingVO pVO) {
		
		return dao.totalfestival(pVO);
	}

	@Override
	public List<FestivalVO> SelectAllnopaging() {
		// TODO Auto-generated method stub
		return dao.SelectAllnopaging();
	}
	@Override
	public int reviewInsert(FestivalReviewVO vo) {
		// TODO Auto-generated method stub
		return dao.reviewInsert(vo);
	}

	@Override
	public List<FestivalReviewVO> reviewSelectList(int festival_no) {
		// TODO Auto-generated method stub
		return dao.reviewSelectList(festival_no);
	}

	@Override
	public int reviewUpdate(FestivalReviewVO vo) {
		// TODO Auto-generated method stub
		return dao.reviewUpdate(vo);
	}

	@Override
	public int reviewDelete(int review_no, String userid) {
		// TODO Auto-generated method stub
		return dao.reviewDelete(review_no, userid);
	}

	@Override
	public int getFestivalCount(PagingVO pVO) {
		// TODO Auto-generated method stub
		return dao.getFestivalCount(pVO);
	}

	@Override
	public List<FestivalVO> getPagedFestivalList(PagingVO pVO) {
		// TODO Auto-generated method stub
		return dao.getPagedFestivalList(pVO);
	}
	@Override
	public void addLike(int no, String userid) {
		dao.addLike(no, userid);
		dao.incrementLikeCount(no);
	}

	@Override
	public void removeLike(int no, String userid) {
		dao.removeLike(no, userid);
		dao.decrementLikeCount(no);
	}

	@Override
	public boolean checkIfUserLiked(int no, String userid) {
		// TODO Auto-generated method stub
		return dao.checkIfUserLiked(no, userid);
	}

	@Override
	public int getLikeCount(int no) {
		// TODO Auto-generated method stub
		return dao.getLikeCount(no);
	}

	@Override
	public List<Integer> getUserLikedRestCodes(String userid) {
		// TODO Auto-generated method stub
		return dao.getUserLikedRestCodes(userid);
	}


	
	
}
