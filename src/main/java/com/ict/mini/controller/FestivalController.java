package com.ict.mini.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ict.mini.service.FestivalService;
import com.ict.mini.service.RestService;
import com.ict.mini.vo.FestivalReviewVO;
import com.ict.mini.vo.FestivalVO;
import com.ict.mini.vo.PagingVO;
import com.ict.mini.vo.RestVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/festival")
public class FestivalController {
	@Inject
	FestivalService service;
	
	@Inject
    RestService restService;
	
	@GetMapping("/festivalList")
	public ModelAndView dataList(
	    @RequestParam(value = "sortBy", defaultValue = "hit") String sortBy,
	    @RequestParam(value = "page", defaultValue = "1") int page,  // 현재 페이지 번호
	    PagingVO pVO
	) {
	    ModelAndView mav = new ModelAndView();

	    // 페이지와 정렬 기준 설정
	    pVO.setSort(sortBy);
	    pVO.setNowPage(page);  // 현재 페이지 번호 설정

	    // 한 페이지당 보여줄 레코드 수 설정
	    int pageSize = pVO.getOnePageRecord(); 
	    pVO.setOffset((page - 1) * pageSize);  // offset 계산

	    // 총 데이터 개수 설정
	    pVO.setTotalRecord(service.getFestivalCount(pVO));
	    log.info(pVO.toString());  // PagingVO 확인

	    // 페이징된 리스트 가져오기
	    List<FestivalVO> festivalList = service.getPagedFestivalList(pVO);

	    // 페이지 관련 정보 및 데이터를 뷰로 전달
	    mav.addObject("festivalList", festivalList);
	    mav.addObject("sortBy", sortBy); // 정렬 기준 전달
	    mav.addObject("pVO", pVO); // 페이징 정보 전달

	    // 뷰 설정
	    mav.setViewName("/board/festival/festivalList");
	    return mav;
	}

	
	
	@GetMapping("/festivalView/{no}")
    public String viewFestival(@PathVariable("no") int no, Model model) {
		// 조회수 증가
	    service.incrementHitCount(no);
        // no 값을 이용해 DB에서 해당 축제의 상세 정보를 조회
        FestivalVO festival = service.getFestivalById(no);
        
        if (festival == null) {
            // 만약 null이면 오류 처리나 기본 페이지로 리다이렉트 등을 처리할 수 있습니다.
            System.out.println("없쪄 " + no);
            return "redirect:/board/festival/festivalList"; // 기본 리스트 페이지로 리다이렉트
        }

        // 인기 있는 음식점 4개 조회
        List<RestVO> popularRestaurants = restService.getPopularRestaurants();
        model.addAttribute("popularRestaurants", popularRestaurants);
        
        // 축제 정보 모델에 추가
        model.addAttribute("festival", festival);
        
        // 진행 중인 축제 목록 조회
        List<FestivalVO> ongoingFestivals = service.getOngoingFestivals(); // 진행중인 축제 목록 조회
        model.addAttribute("ongoingFestivals", ongoingFestivals);
        
        return "/board/festival/festivalView"; 
 
	}
	// 좋아요 토글
    @PostMapping("/festivalView/{no}/Togglelikes")
    @ResponseBody
    public Map<String, Object> toggleLikes(@PathVariable("no") int no,
                                            @RequestParam("userid") String userid) {
        boolean currentStatus = service.checkIfUserLiked(no, userid);

        if (currentStatus) {
            service.removeLike(no, userid);
        } else {
            service.addLike(no, userid);
        }

        int updatedLikeCount = service.getLikeCount(no);

        Map<String, Object> response = new HashMap();
        response.put("likes", !currentStatus);
        response.put("likeCount", updatedLikeCount);
        return response;
    }

    // 특정 사용자의 좋아요 상태 조회
    @GetMapping("/festivalView/{no}/mylikes")
    @ResponseBody
    public Map<String, Object> getUserLikes(@PathVariable("no") int no, HttpSession session) {
        Map<String, Object> response = new HashMap();
        String userid = (String) session.getAttribute("logId");

        if (userid == null) {
            response.put("error", "로그인이 필요한 기능입니다.");
            return response;
        }

        try {
            List<Integer> likedRestCodes = service.getUserLikedRestCodes(userid);
            response.put("likes", likedRestCodes.contains(no) ? Collections.singletonList(no) : Collections.emptyList());
        } catch (Exception e) {
            response.put("error", "오류 발생.");
            e.printStackTrace();
        }

        return response;
    }
 // 리뷰 작성
    @PostMapping("/festivalView/review/write")
    public String writeOk(FestivalReviewVO vo, HttpSession session){
      vo.setUserid((String)session.getAttribute("logId"));
      log.info(vo.toString());

      int result = 0;
      try {
         result = service.reviewInsert(vo);
      }catch(Exception e) {
         result = 0;
      }
      return result+"";
   }
    //댓글목록 선택
    @GetMapping("/festivalView/{festival_no}/festivalList") 
    @ResponseBody
    public List<FestivalReviewVO> list(@PathVariable("festival_no") Integer festival_no) { 
       if (festival_no == null) {
              throw new IllegalArgumentException("Festival number is required.");
          }
       return service.reviewSelectList(festival_no);
    } 
    //댓글수정(DB)
    @PostMapping("/festivalView/{festival_no}/edit") 
    public String edit(FestivalReviewVO vo, HttpSession session) {
          vo.setUserid((String) session.getAttribute("logId"));
          
          // 수정 성공 여부를 문자열로 반환
          return String.valueOf(service.reviewUpdate(vo));
      }
    //댓글삭제
    @PostMapping("/festivalView/{festival_no}/delete") 
    public String del(@RequestParam(required = false) Integer review_no, HttpSession session) { 
       if (review_no == null) {
              throw new IllegalArgumentException("리뷰 번호가 없습니다.");
          }
      String userid = (String)session.getAttribute("logId");
       return service.reviewDelete(review_no, userid)+""; }

    
}


