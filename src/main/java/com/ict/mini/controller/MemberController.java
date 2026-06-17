package com.ict.mini.controller;

import java.io.Console;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ict.mini.service.MemberService;
import com.ict.mini.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/mypage")
public class MemberController {

	@Inject
	MemberService service;
	//로그인 폼으로 이동
		@GetMapping("/login")
		public String login() {
			// /WEB-INF/views/member/login.jsp
			return "/mypage/login"; //로그인 뷰페이지 명
		}
		//로그인 (DB조회)
		@PostMapping("/loginOk")
		public String loginOk(MemberVO vo, HttpSession session) {//아이디,비번 request
			System.out.println(vo.toString());
			MemberVO resultVo = service.loginOk(vo);//아이디와 비번이 있으면 담고 , 없으면 null이 들어온다.
			//System.out.println(resultVo.toString());
			
			if(resultVo==null) {//로그인실패-> 로그인폼
				return "/mypage/login";
				
			}else {//로그인 성공하면 -> 세션 로그인 정보기록 -> 홈
				session.setAttribute("logId", resultVo.getUserid());
				session.setAttribute("logName", resultVo.getUsername());
				session.setAttribute("logStatus", "Y");
				
				return "/mypage/loginOk"; //redirect는 뷰페이지로 이동하지 않고 원하는 컨트롤러 매핑으로 바로 이동한다.
			}	
		}
		
	//로그아웃
		@GetMapping("/logout")
		public String logout(HttpSession session) {
			session.invalidate();
			return "redirect:/";
		}
	//회원가입
		@GetMapping("/join")
		public String join() {
			return "/mypage/join";
		}
		 //아이디 중복검사
		@GetMapping("/idDoubleCheck")
		public ModelAndView idDoubleCheck(String userid) {
			
			//db 조회
			int result = service.idDoubleCheck(userid);
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("result", result);
			mav.addObject("userid", userid); //뷰페이지에서 필요함
			mav.setViewName("mypage/idDoubleCheck");
		
			
			return mav; 
		}
		//회원가입
		@PostMapping("/joinOk")
		public ModelAndView joinOk(MemberVO vo) {
			
			int result=0;
			//insert -> int 
			try {
				result = service.memberInsert(vo);
			}catch(Exception e){
				
			}
			ModelAndView mav = new ModelAndView();
			mav.addObject("result",result);
			mav.setViewName("mypage/joinResult");
			
			return mav;
		}
		//회원정보 수정폼
		@GetMapping("/joinEdit")
		public ModelAndView joinEdit(HttpSession session) {
			//세션에 있는 로그인 아이디 -> 해당아이디의 정보를 DB에서 Select하기
			String userid = (String)session.getAttribute("logId");
			
			MemberVO vo = service.memberSelect(userid);
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("vo", vo);
			mav.setViewName("mypage/joinEdit");
			
			return mav;
			
		}
		
		//회원정보 수정(DB update)
		@PostMapping("/joinEditOk")
		public String joinEditOk(MemberVO vo, HttpSession session) {
			vo.setUserid((String)session.getAttribute("logId"));
			
			service.memberUpdate(vo);
			
			return "redirect:joinEdit";
			
		}
		
		//회원탈퇴
	    @GetMapping("/unjoins")
	    public  ModelAndView unjoins(HttpSession session){
	        String userid = (String)session.getAttribute("logId");
	
	       service.unjoins(userid);
	        
	        ModelAndView mav = new ModelAndView();
	        //회원탈퇴후 세션에 있는 로그인 정보를 지우고 홈으로 이동한다.
	        mav.setViewName("redirect:logout");
	        return mav;
	    }
		
	 // 아이디 찾기 GET 요청 처리
	    @GetMapping("/findId")
	    public String getFindId(HttpSession session, Model model) {
	        String logId = (String) session.getAttribute("logId");
	        String logName = (String) session.getAttribute("logName");

	        if (logId != null && logName != null) {
	            model.addAttribute("logId", logId);
	            model.addAttribute("logName", logName);
	        }

	        // 세션에서 foundId를 제거하여 이전 값이 남아있지 않도록 합니다.
	        session.removeAttribute("foundId");

	        return "mypage/findId";
	    }


	    // 아이디 찾기 POST 요청 처리
	    @PostMapping("/findId")
	    public String postFindId(@RequestParam("email") String email, @RequestParam("username") String username, HttpSession session, Model model) {
	        Map<String, Object> params = new HashMap<String, Object>();
	        params.put("email", email);
	        params.put("username", username);
	        
	        MemberVO member = service.findMemberByEmailAndName(params);

	        if (member != null) {
	            // 아이디 찾기 성공
	            String foundId = member.getUserid();
	            session.setAttribute("foundId", foundId);
	            model.addAttribute("foundId", foundId);
	        } else {
	            // 아이디 찾기 실패
	            model.addAttribute("error", "해당 이메일과 이름으로 등록된 아이디를 찾을 수 없습니다.");
	            session.removeAttribute("foundId");  // 실패 시 세션에서 foundId 제거
	        }

	        return "mypage/findId";
	    }
	    
	   

	    // 비밀번호 찾기 폼을 보여줍니다.
	    @GetMapping("/findPwd")
	    public String showFindPasswordForm(Model model) {
	        model.addAttribute("pwd", 0);  // 첫 번째 단계로 설정
	        return "mypage/findPwd";
	    }

	    // 첫 번째 단계: 아이디 검증 및 다음 단계로 이동
	    @PostMapping("/findPwdStep1")
	    public String findPwdStep1(@RequestParam("userid") String userid, Model model) {
	        boolean userExists = service.checkUserIdExists(userid);
	        if (!userExists) {
	            model.addAttribute("useridErrorMessage", "해당 아이디가 존재하지 않습니다.");
	            model.addAttribute("pwd", 0);  // 첫 번째 단계로 유지
	            return "mypage/findPwd";
	        }
	        model.addAttribute("pwd", 1);  // 두 번째 단계로 이동
	        return "mypage/findPwd";
	    }

	    // 두 번째 단계: 이름과 전화번호 검증 및 다음 단계로 이동
	    @PostMapping("/findPwdStep2")
	    public String findPwdStep2(@RequestParam("username") String username, @RequestParam("tel") String tel, Model model) {
	        // Map에 username과 tel을 추가
	        Map<String, Object> params = new HashMap<String, Object>();
	        params.put("username", username);
	        params.put("tel", tel);

	        // 서비스에서 사용자 검증
	        boolean validUser = service.checkUsernameAndTel(params);
	        String a = service.findUserid(params);
	        
	        // 검증 결과에 따라 처리
	        if (!validUser) {
	            model.addAttribute("usernameErrorMessage", "이름이 일치하지 않습니다.");
	            model.addAttribute("telErrorMessage", "전화번호가 일치하지 않습니다.");
	            model.addAttribute("pwd", 1);  // 두 번째 단계로 유지
	            return "mypage/findPwd";
	        }
	        model.addAttribute("id", a);
	        // 유효한 사용자면 비밀번호 변경 단계로 이동
	        model.addAttribute("pwd", 2);
	        return "mypage/findPwd";
	    }


	    // 비밀번호 변경
	    @PostMapping("/changePwd")
	    public String changePwd(@RequestParam("userpwd") String userpwd, @RequestParam("userpwd2") String userpwd2,@RequestParam("userid") String userid, Model model) {
	    	
	        if (!userpwd.equals(userpwd2)) {
	            model.addAttribute("pwdErrorMessage", "비밀번호가 일치하지 않습니다.");
	            model.addAttribute("pwd2ErrorMessage", "비밀번호 확인이 일치하지 않습니다.");
	            model.addAttribute("pwd", 2);  // 비밀번호 변경 단계로 유지
	            return "mypage/findPwd";
	        }
	        // 비밀번호 변경 로직
	        
	        service.updatePassword(userpwd,userid);
	        
	        model.addAttribute("successMessage", "비밀번호가 성공적으로 변경되었습니다.");
	        return "mypage/findPwd";  // 비밀번호 변경 후 로그인 페이지로 이동
	    }
		
}