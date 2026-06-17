package com.ict.mini.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ict.mini.service.CalendarService;
import com.ict.mini.service.CourseService;
import com.ict.mini.service.FestivalService;
import com.ict.mini.service.MemberService;
import com.ict.mini.service.MypageService;
import com.ict.mini.service.RestService;
import com.ict.mini.service.RootPageService;
import com.ict.mini.vo.AnswerVO;
import com.ict.mini.vo.CourseVO;
import com.ict.mini.vo.FestivalVO;
import com.ict.mini.vo.InquiryVO;
import com.ict.mini.vo.MemberVO;
import com.ict.mini.vo.PagingVO;
import com.ict.mini.vo.RestVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller

public class RootPageController {

	@Autowired
	FestivalService festivalService;
	@Autowired
	RestService restService;
	@Autowired
	CourseService courseService;
	@Autowired
	MemberService memberService;
	@Autowired
	MypageService mypageService;
	@Autowired
	RootPageService pageService;
	
	//회원정보 페이지 첫 접속
	@GetMapping("/mypage/rootpage")
	public String rootpage() {
		
		return "/adminpage/rootpage";
	}

	@GetMapping("/adminpage/mem")
	@ResponseBody
	public Map<String, Object> memlist(PagingVO pVO, @RequestParam("page") int page) {
	    pVO.setNowPage(page);  // 현재 페이지 설정
	    pVO.setTotalRecord(memberService.totalmem(pVO));  // 총 레코드 수 설정

	    // 총 페이지 수 계산
	    int totalPage = (int) Math.ceil((double) pVO.getTotalRecord() / pVO.getOnePageRecord());
	    pVO.setTotalPage(totalPage);

	    // 오프셋 설정: SQL 쿼리에서 몇 번째 레코드부터 가져올지 결정
	    pVO.setOffset((pVO.getNowPage() - 1) * pVO.getOnePageRecord());

	    // 해당 페이지에 맞는 데이터 가져오기
	    List<MemberVO> members = memberService.memSelectAll(pVO);

	    Map<String, Object> result = new HashMap<String, Object>();
	    result.put("members", members);  // 회원 목록
	    result.put("pVO", pVO);          // 페이징 정보

	    return result;
	}


	//회원 한명씩 탈퇴
	@PostMapping("adminpage/userDel")
	@ResponseBody
	public String userDel(@RequestParam("userid")String userid) {
		log.info(userid);
		memberService.delOneUser(userid);
		return "/mypage/rootpage";
	}
	//회원 한번에 탈퇴
	@PostMapping("/adminpage/memDel")
	@ResponseBody
	public ModelAndView memDel(@RequestParam(value = "test[]", required = false) List<String> delList) {
	    ModelAndView mav = new ModelAndView();
	    if (delList != null && !delList.isEmpty()) {
	        log.info("삭제할 회원 목록: " + delList.toString());
	        // 여기에 삭제 로직 추가
	        memberService.delUsers(delList);
	    } else {
	        log.info("삭제할 회원이 선택되지 않았습니다.");
	    }

	    mav.setViewName("/adminpage/rootpage");
	    return mav;
	}
	//boardList첫 접속
	@GetMapping("/adminpage/boardList")
	public String boardList() {
		return "/adminpage/boardList";
	}
	//축제리스트보기
	@GetMapping("/adminpage/listSelect")
	@ResponseBody
	public Map<String, Object> listSelect(HttpSession session,PagingVO pVO, @RequestParam("page") int page){
		pVO.setNowPage(page);  // 현재 페이지 설정
	    pVO.setTotalRecord(festivalService.totalfestival(pVO));  // 총 레코드 수 설정

	    // 총 페이지 수 계산
	    int totalPage = (int) Math.ceil((double) pVO.getTotalRecord() / pVO.getOnePageRecord());
	    pVO.setTotalPage(totalPage);

	    // 오프셋 설정: SQL 쿼리에서 몇 번째 레코드부터 가져올지 결정
	    pVO.setOffset((pVO.getNowPage() - 1) * pVO.getOnePageRecord());
		List<FestivalVO>flist=festivalService.SelectAll(pVO);
	    Map<String, Object> result = new HashMap<String, Object>();
	    result.put("flist", flist);  // 회원 목록
	    result.put("pVO", pVO);          // 페이징 정보
		session.setAttribute("rootlist", "festival");
		return result;
	}
	//축제리스트하나씩삭제
	@GetMapping("/adminpage/listDel/{no}")
	public String listDel(@PathVariable("no")int no){
		festivalService.delOneList(no);
		return "/adminpage/boardList";
		
	}
	//축제리스트 한번에 삭제
	@PostMapping("/adminpage/listDel")
	@ResponseBody
	public ModelAndView boardListDel(@RequestParam(value = "test[]", required = false) List<String> delList) {
	    ModelAndView mav = new ModelAndView();
	    if (delList != null && !delList.isEmpty()) {
	        log.info("삭제할 글 목록: " + delList.toString());
	        // 여기에 삭제 로직 추가
	        festivalService.delLists(delList);
	    } else {
	        log.info("삭제할 글이 선택되지 않았습니다.");
	    }

	    mav.setViewName("/adminpage/boardList");
	    return mav;
	}
	//맛집리스트보기
	@GetMapping("/adminpage/restList")
	@ResponseBody
	public  Map<String, Object> restList(HttpSession session,PagingVO pVO, @RequestParam("page") int page){
		pVO.setNowPage(page);  // 현재 페이지 설정
	    pVO.setTotalRecord(restService.totalrest(pVO));  // 총 레코드 수 설정
	    // 총 페이지 수 계산
	    int totalPage = (int) Math.ceil((double) pVO.getTotalRecord() / pVO.getOnePageRecord());
	    pVO.setTotalPage(totalPage);
	    // 오프셋 설정: SQL 쿼리에서 몇 번째 레코드부터 가져올지 결정
	    pVO.setOffset((pVO.getNowPage() - 1) * pVO.getOnePageRecord());

		List<RestVO> rlist=restService.restAllSelectpaging(pVO);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("rlist", rlist);
		result.put("pVO", pVO);  
		session.setAttribute("rootlist", "rest");
		return result;
	}
	//맛집 하나씩 삭제
	@GetMapping("/adminpage/rlistDel/{rest_code}")
	public String restDel(@PathVariable("rest_code")int rest_code) {
		restService.restDel(rest_code);
		return "/adminpage/boardList";
	}
//	맛집 한번에 삭제
	@PostMapping("/adminpage/rlistDel")
	public String rlistDel(@RequestParam(value="rest_code[]",required=false)List<String> delRlist) {
		if(delRlist!=null &&!delRlist.isEmpty()) {
			restService.delRlist(delRlist);
		}
		return "redirect:/adminpage/boardList";
	}
	//코스 리스트보기
	@GetMapping("/adminpage/courseList")
	@ResponseBody
	public Map<String, Object> courseList(HttpSession session,PagingVO pVO, @RequestParam("page") int page){
		session.setAttribute("rootlist", "course");
		pVO.setNowPage(page);  // 현재 페이지 설정
	    pVO.setTotalRecord(courseService.totalRecord(pVO));  // 총 레코드 수 설정

	    // 총 페이지 수 계산
	    int totalPage = (int) Math.ceil((double) pVO.getTotalRecord() / pVO.getOnePageRecord());
	    pVO.setTotalPage(totalPage);

	    // 오프셋 설정: SQL 쿼리에서 몇 번째 레코드부터 가져올지 결정
	    pVO.setOffset((pVO.getNowPage() - 1) * pVO.getOnePageRecord());
		List<CourseVO> clist=courseService.courseSelectPaging(pVO);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("clist", clist);  // 회원 목록
		result.put("pVO", pVO);          // 페이징 정보

		return result;
	}
	//코스 하나씩 삭제
	@GetMapping("/adminpage/clistDel/{news_no}")
	public String clistDel(@PathVariable("news_no")int news_no) {
		courseService.cOneDel(news_no);
		
		return "redirect:/adminpage/boardList";
		
	}
	@PostMapping("/adminpage/clistDel")
	public String clistDel(@RequestParam(value="news_no[]",required=false) List<String> delClist){
		if(delClist!=null &&!delClist.isEmpty()) {
			courseService.delClist(delClist);
		}
		return "redirect:/adminpage/boardList";
	}
	@PostMapping("/adminpage/answerWrite")
	public ModelAndView answerWrite(AnswerVO vo) {
		ModelAndView mav = new ModelAndView();
		log.info(vo.toString());
		
		int result=mypageService.answerWrite(vo); 
		log.info(result+"");
		if(result==1) {
			mypageService.answerset(vo);
			mav.setViewName("redirect:/mypage/inquiryView/"+vo.getIndex());
		}
		return mav;
		
	}
	@PostMapping("adminpage/answerEdit")
	public ModelAndView answerEdit(AnswerVO vo) {
		ModelAndView mav = new ModelAndView();
		mypageService.editResult(vo);
		
			mav.addObject("vo", vo);
			mav.setViewName("redirect:/mypage/inquiryView/"+vo.getIndex());
		
		
		return mav;
	
	}
	@GetMapping("/adminpage/adminQnaList")
	public String adqnalist() {
		return "/adminpage/adminqnalist";
	}
	@PostMapping("/adminpage/qnaList")
	@ResponseBody
	public Map<String, Object> qnaList(PagingVO pVO,HttpSession session
										,@RequestParam(value = "userid") String userid,
										@RequestParam(value="page") int page){
		log.info(userid);
		log.info(page+"");
		pVO.setNowPage(page);  // 현재 페이지 설정
		log.info(pVO.toString());
	    pVO.setTotalRecord(pageService.totalAllinquiry(pVO));  // 총 레코드 수 설정
	    int totalPage = (int) Math.ceil((double) pVO.getTotalRecord() / pVO.getOnePageRecord());
	    pVO.setTotalPage(totalPage);
	    pVO.setOffset((pVO.getNowPage() - 1) * pVO.getOnePageRecord());
		List<InquiryVO> list= pageService.Allinquiry(pVO);
		log.info(list.toString());
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", list);
		result.put("pVO", pVO);
		
		
		return result;
		
	}
	
}
