package com.ict.mini.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ict.mini.vo.LikeVO;
import com.ict.mini.vo.PagingVO;
import com.ict.mini.vo.RestReviewVO;
import com.ict.mini.vo.RestVO;

public interface RestDAO {

	// 맛집 리스트 페이지
	public List<RestVO> getRestByCategory(String category);
	
	// 상세보기 페이지
	public RestVO getRestViewByCode(int rest_code);
	
	//맛집 전체출력
	public List<RestVO> restAllSelect();
	//맛집 지역별출력
	public List<RestVO> restAddrSelect(String addrdetails);
	//맛집TOP3
	public List<RestVO> restTop3();
	
	// 카카오맵 맛집 위치 출력
	List<RestVO> getKakaoMap(int rest_code);
	
	// 비슷한 맛집 출력
	List<RestVO> getSimilarRestaurant(int rest_code);
	
	// 리뷰 목록 보여주기
	List<RestReviewVO> getReviewSelect(int rest_code);
	
	// 사용자가 특정 레스토랑에 좋아요를 추가
    void addLike(@Param("rest_code") int rest_code, @Param("userid") String userid);

    // 사용자가 특정 레스토랑에 좋아요를 제거
    void removeLike(@Param("rest_code") int rest_code, @Param("userid") String userid);

    // 사용자가 특정 레스토랑에 좋아요를 눌렀는지 확인
    boolean checkIfUserLiked(@Param("rest_code") int rest_code, @Param("userid") String userid);


    // 특정 레스토랑의 좋아요 수 조회
    int getLikeCount(@Param("rest_code") int rest_code);

    // 사용자가 좋아요를 누른 레스토랑 코드 리스트 조회
    List<Integer> getUserLikedRestCodes(@Param("userid") String userid);
    
    void incrementLikeCount(@Param("rest_code") int rest_code);
    void decrementLikeCount(@Param("rest_code") int rest_code);
    // 리뷰 등록하기
    public int addReview(RestReviewVO restreviewVO);
    
    // 리뷰 수정하기
    public int reviewEdit(RestReviewVO vo);
    
    // 리뷰 삭제하기
    public int reviewDel(int review_no);
    
    // 리뷰 목록 불러오기 2
    RestReviewVO getReviewByNo(int review_no);
    
    // 별점 평균값 구하기
    Double getAverageRating(int rest_code);

    
	// festival 명서님것
	public List<RestVO> getPopularRestaurants();
	
	//수정님것
	 public List<RestVO> getLikedRestaurants(String userid);
	//관리자가 맛집하나씩 삭제
    public void restDel(int rest_code);
    //관리자가 맛집 한번에 삭제
    public void delRlist(List<String> delRlist);
    //맛집 총가게수
    public int totalrest(PagingVO pVO);
    public List<RestVO> restAllSelectpaging(PagingVO pVO);
}


	

