package com.ict.mini.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.mini.service.CourseService;
import com.ict.mini.service.FestivalService;
import com.ict.mini.service.MemberService;
import com.ict.mini.service.MypageService;
import com.ict.mini.service.RestService;
import com.ict.mini.vo.AnswerVO;
import com.ict.mini.vo.CourseVO;
import com.ict.mini.vo.FestivalVO;
import com.ict.mini.vo.InquiryVO;
import com.ict.mini.vo.PagingVO;
import com.ict.mini.vo.RestVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MypageController {
	@Inject
	MypageService service;
	@Autowired
	CourseService courseService;
    @Autowired
    FestivalService festivalService;
    @Autowired
    RestService restService;
	@Autowired
	MemberService memberService;
		
	@GetMapping("/mypage/mypage")
	public String myPage(HttpSession session, Model model) {
	    String username = (String) session.getAttribute("logName");
	    String userid = (String) session.getAttribute("logId");
	    String imgname = memberService.getUserimg(userid);
	    log.info(imgname);
	    // 기본 이미지 경로 설정
	    String defaultImg = "/user.png"; // 기본 이미지 파일명과 경로

	    if (username != null) {
	        model.addAttribute("greeting", username + "님");
	        // 사용자 이미지가 있는 경우, 해당 이미지 경로 설정
	        model.addAttribute("userimg", imgname != null ? imgname : defaultImg);
	    }

	    return "/mypage/mypage"; // 마이페이지 뷰로 이동
	}
	
	
	   //마이페이지 이미지 설정
	 
	   
	   @PostMapping("/mypage/updateProfileImage")
	   public ResponseEntity<Map<String, String>> updateProfileImage(@RequestParam("userimgfile") MultipartFile file, Model model,HttpSession session,HttpServletRequest request) {
	       log.info("파일 업로드 요청 수신");
	       String UPLOAD_DIR = session.getServletContext().getRealPath("/resources/uploadfile/");
	       log.info(UPLOAD_DIR);
	       String webPath = request.getContextPath() + "/resources/uploadfile/";
	       log.info("웹 경로: {}", webPath);  
	       model.addAttribute("webPath", webPath);
	       if (file.isEmpty()) {
	           log.warn("업로드된 파일이 비어있음");
	           Map<String, String> response = new HashMap<String, String>();
	           response.put("error", "파일이 비어있습니다.");
	           return ResponseEntity.badRequest().body(response);
	       }

	       try {
	           // 파일 이름 생성 및 저장 경로 설정
	           String fileName = file.getOriginalFilename();
	           File targetFile = new File(UPLOAD_DIR + fileName);
	           log.info("파일 저장 경로: {}", targetFile.getAbsolutePath());

	           // 파일 저장
	           file.transferTo(targetFile);
	           log.info("파일이 성공적으로 저장됨: {}", fileName);

	           // 사용자 세션에서 사용자 ID 가져오기
	           String userId = (String) session.getAttribute("logId");
	           log.info("세션에서 사용자 ID 가져오기: {}", userId);

	           if (userId != null) {
	               // 사용자 DB 업데이트
	               log.info("사용자 DB 업데이트 시작");
	               service.updateUserProfileImage(userId, fileName);
	               log.info("사용자 DB 업데이트 완료");

	               // 세션에서 이미지 URL 업데이트
	               String fileUrl = webPath + fileName;
	               session.setAttribute("imgname", fileUrl);
	               log.info("세션 이미지 URL 업데이트 완료: {}", fileUrl);

	               // 성공적으로 업로드된 파일의 URL 반환
	               Map<String, String> response = new HashMap<String, String>();
	               response.put("imgUrl", fileUrl);
	               log.info("test"+response);
	               return ResponseEntity.ok().body(response);
	           } else {
	               log.warn("세션에서 사용자 ID를 찾을 수 없음");
	               Map<String, String> response = new HashMap<String, String>();
	               response.put("error", "사용자 ID를 찾을 수 없습니다.");
	               return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
	           }

	       } catch (IOException e) {
	           log.error("파일 업로드 중 오류 발생", e);
	           Map<String, String> response = new HashMap<String, String>();
	           response.put("error", "파일 업로드 실패");
	           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	       }
	   }
	    

	    


// 좋아요한 목록 보이게
    @GetMapping("/mypage/mypage_list_fav")
    public String getLikedItems(Model model, HttpSession session) {
    	log.info("ttttt");
        String userid = (String) session.getAttribute("logId");
        log.info("User ID: " + userid); // userid 값 로그로 확인
        if (userid != "") {
        	log.info(userid);
            List<FestivalVO> likedFestivals = festivalService.getLikedFestivals(userid);
            List<RestVO> likedRestaurants = restService.getLikedRestaurants(userid);
            log.info(likedFestivals.toString());
            log.info(likedRestaurants.toString());
            
            model.addAttribute("likedFestivals", likedFestivals);
            model.addAttribute("likedRestaurants", likedRestaurants);
        }
        return "mypage/mypage_list_fav"; // JSP 페이지 경로
    }
	

	//마이페이지 자기가 쓴 코스글
	@RequestMapping(value = "/mypage/mypage_list_cs2", method = RequestMethod.GET)
	public String getMyCourses(HttpSession session, Model model) {
		   log.info("test");
	    String userid = (String) session.getAttribute("logId");
	    if (userid == null) {
	        // 로그인하지 않은 경우 또는 세션에 `logId`가 없는 경우
	        return "redirect:/login"; // 로그인 페이지로 리디렉션하거나 적절한 처리를 합니다.
	    }
	    List<CourseVO> course = courseService.getUserCourses(userid);
	    log.info(course.toString());
	    model.addAttribute("course", course);
	    return "/mypage/mypage_list_cs";  // 뷰 페이지 이름
	}
	
	
	
	
		
	@GetMapping("/mypage/qnaList")
	public String qna(){
		
		return "/mypage/qnaList";
	}
	@PostMapping("/mypage/qnaList")
	@ResponseBody
	public Map<String, Object> qnaList(PagingVO pVO,HttpSession session
										,@RequestParam(value = "userid") String userid,
										@RequestParam(value="page") int page){
		log.info(userid);
		log.info(page+"");
		pVO.setNowPage(page);  // 현재 페이지 설정
		log.info(pVO.toString());
	    pVO.setTotalRecord(service.totalmyinquiry(pVO,userid));  // 총 레코드 수 설정
	    int totalPage = (int) Math.ceil((double) pVO.getTotalRecord() / pVO.getOnePageRecord());
	    pVO.setTotalPage(totalPage);
	    pVO.setOffset((pVO.getNowPage() - 1) * pVO.getOnePageRecord());
		List<InquiryVO> list= service.myinquiry(userid,pVO);
		log.info(list.toString());
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", list);
		result.put("pVO", pVO);
		
		return result;
		
	}
	@GetMapping("/mypage/inquiryWrite")
	public String inquiryWrite() {
		return "/mypage/inquiryWrite";
	}
	
	@PostMapping("/mypage/write")
	public String write(InquiryVO vo,HttpSession session){
		log.info(vo.toString());
		String userid=(String)session.getAttribute("logId");
		vo.setUserid(userid);
		int writeOk= service.qnaWrite(vo);
		if(writeOk==1) {
			return "redirect:/mypage/qnaList";
		}else {
			return "/mypage/Writefalse"; 
		}
		
	}
	@GetMapping("/mypage/inquiryView/{index}")
	public ModelAndView qnaView(@PathVariable("index")int index,HttpServletRequest request,InquiryVO vo) {
		ModelAndView mav = new ModelAndView();
		 request.setAttribute("excludeHeader", true);
		vo=service.selectoneqna(index);
		log.info("asdfa"+vo.toString());
		
		AnswerVO avo= service.selectAnswer(index);
	
		if(avo!=null) {
			mav.addObject("avo", avo);
			log.info("nullte11st"+avo.toString());
		}
		
		mav.addObject("vo",vo);
		mav.setViewName("/mypage/qnaView");
		return mav;
		
	}
	
}
