
package com.ict.mini.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.mini.dao.RestDAO;
import com.ict.mini.vo.LikeVO;
import com.ict.mini.vo.PagingVO;
import com.ict.mini.vo.RestReviewVO;
import com.ict.mini.vo.RestVO;

@Service
public class RestServiceImpl implements RestService {
	@Autowired
	RestDAO dao;
	

	@Override
	public List<RestVO> getRestByCategory(String category) {
		return dao.getRestByCategory(category);
	}

	@Override
	public RestVO getRestViewByCode(int rest_code) {
		return dao.getRestViewByCode(rest_code);
	}

	@Override
	public List<RestVO> restAllSelect() {
		
		return dao.restAllSelect();
	}

	@Override
	public List<RestVO> restAddrSelect(String addrdetails) {
		return dao.restAddrSelect(addrdetails);
	}

	@Override
	public List<RestVO> restTop3() {
		return dao.restTop3();
	}

	@Override
	public List<RestVO> getKakaoMap(int rest_code) {
		return dao.getKakaoMap(rest_code);
	}

	@Override
	public List<RestVO> getSimilarRestaurant(int rest_code) {
		return dao.getSimilarRestaurant(rest_code);
	}

	@Override
	public List<RestReviewVO> getReviewSelect(int rest_code) {
		return dao.getReviewSelect(rest_code);
	}
	

    @Override
	public List<RestVO> getPopularRestaurants() {
		// TODO Auto-generated method stub
		return dao.getPopularRestaurants();
	}

	@Override
	public void restDel(int rest_code) {
	
		 dao.restDel(rest_code);
		
	}

	@Override
	public void delRlist(List<String> delRlist) {
		dao.delRlist(delRlist);
		
	}

	@Override
	public int totalrest(PagingVO pVO) {
		// TODO Auto-generated method stub
		return dao.totalrest(pVO);
	}

	@Override
	public List<RestVO> restAllSelectpaging(PagingVO pVO) {
		
		return dao.restAllSelectpaging(pVO);
	}

	@Override
	public void addLike(int rest_code, String userid) {
		dao.addLike(rest_code, userid);
		
	}

	@Override
	public void removeLike(int rest_code, String userid) {
		dao.removeLike(rest_code, userid);
	}

	@Override
	public boolean checkIfUserLiked(int rest_code, String userid) {
		
		return dao.checkIfUserLiked(rest_code, userid);
	}

	@Override
	public int getLikeCount(int rest_code) {
	
		return dao.getLikeCount(rest_code);
	}

	@Override
	public List<Integer> getUserLikedRestCodes(String userid) {
		
		return dao.getUserLikedRestCodes(userid);
	}

	@Override
	public void incrementLikeCount(int rest_code) {
		dao.incrementLikeCount(rest_code);
		
	}

	@Override
	public void decrementLikeCount(int rest_code) {
		dao.decrementLikeCount(rest_code);
		
	}

	@Override
	public int addReview(RestReviewVO restreviewVO) {
	
		return dao.addReview(restreviewVO);
	}

	@Override
	public int reviewEdit(RestReviewVO vo) {
		
		return dao.reviewEdit(vo);
	}

	

	@Override
	public Double getAverageRating(int rest_code) {
	
		return dao.getAverageRating(rest_code);
	}

	@Override
	public List<RestVO> getLikedRestaurants(String userid) {
		
		return dao.getLikedRestaurants(userid);
	}

	@Override
	public int reviewDel(int review_no) {
		
		return dao.reviewDel(review_no);
	}

	@Override
	public RestReviewVO getReviewByNo(int review_no) {
		// TODO Auto-generated method stub
		return dao.getReviewByNo(review_no);
	}
}

	

