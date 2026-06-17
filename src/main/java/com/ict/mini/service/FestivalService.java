package com.ict.mini.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ict.mini.vo.FestivalReviewVO;
import com.ict.mini.vo.FestivalVO;
import com.ict.mini.vo.PagingVO;

public interface FestivalService {
	// 모든 축제 리스트를 가져오는 메서드
	public List<FestivalVO> dataSelectAll(String sortBy);
	// 새로운 축제 정보를 추가하는 메서드
	public int dataInsert(FestivalVO vo);
	// 특정 축제 정보를 가져오는 메서드
	public FestivalVO getFestivalById(int no);
	// 축제 달력(날씨정보O)
	public List<FestivalVO> calDataSelect(String date,String environment);
	// 축제 달력(날씨정보X)
	public List<FestivalVO> calDataSelect2(String date);
	// 지역별 축제리스트
	public List<FestivalVO> festivalAddrSelect(String addrdetails);
	public List<FestivalVO> SelectAll(PagingVO pVO);
	//축제 top4
	public List<FestivalVO> festivalTop4();
	// 날짜가 지난 축제 제외
    public List<FestivalVO> getOngoingFestivals();
    // 찜하기 수 업데이트
    public void incrementLikeCount(int no);
    public void decrementLikeCount(int no);
    // 조회수
    public void incrementHitCount(int no);
	//09050505마지막
    //관리자 축제 삭제
    public int delOneList(int no);
    //관리자 축제 한번에 삭제
    public void delLists(List<String> delList);
    public int totalfestival(PagingVO pVO);
    public List<FestivalVO> SelectAllnopaging();
    public List<FestivalVO> getLikedFestivals(String userid);
    

	public int getFestivalCount(PagingVO pVO);
	public List<FestivalVO> getPagedFestivalList(PagingVO pVO);

	 // 사용자가 특정 레스토랑에 좋아요를 추가
	    void addLike(@Param("no") int no, @Param("userid") String userid);

	    // 사용자가 특정 레스토랑에 좋아요를 제거
	    void removeLike(@Param("no") int no, @Param("userid") String userid);

	    // 사용자가 특정 레스토랑에 좋아요를 눌렀는지 확인
	    boolean checkIfUserLiked(@Param("no") int no, @Param("userid") String userid);

	    // 특정 레스토랑의 좋아요 수 조회
	    int getLikeCount(@Param("no") int no);

	    // 사용자가 좋아요를 누른 레스토랑 코드 리스트 조회
	    List<Integer> getUserLikedRestCodes(@Param("userid") String userid);
	    public int reviewInsert(FestivalReviewVO vo);
	    //댓글목록
	    public List<FestivalReviewVO> reviewSelectList(int festival_no);
	    //댓글 수정
	    public int reviewUpdate(FestivalReviewVO vo);
	    //댓글 삭제
	    public int reviewDelete (int review_no, String userid);

 	

	
	
}
