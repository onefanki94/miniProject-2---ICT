package com.ict.mini;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ict.mini.service.CalendarService;
import com.ict.mini.service.FestivalService;
import com.ict.mini.service.RestService;
import com.ict.mini.vo.CalendarVO;
import com.ict.mini.vo.FestivalVO;
import com.ict.mini.vo.RestVO;
import com.mysql.cj.log.Log;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class HomeController {
	@Autowired
	CalendarService calendarService;
	@Autowired
	FestivalService festivalservice;
	@Autowired
	RestService restservice;
	
	@GetMapping("/")
	public String courseList() {

		return "/home";	
	}
	@GetMapping("/mainFestivalList/{addrdetails}")
	@ResponseBody
	public List<FestivalVO> mainFestivalList(@PathVariable("addrdetails")String addrdetails,HttpSession session, Model model){
		List<FestivalVO> list;
		session.setAttribute("addrSelect",addrdetails);
		session.setAttribute("firstVisit", "1");
		model.addAttribute("firstVisit", session.getAttribute("firstVisit"));
		log.info(addrdetails);
		if(addrdetails.equals("부산")) {
			list=festivalservice.SelectAllnopaging();
			session.setAttribute("list", list);
			log.info(list.toString());	
		}else {
			list=festivalservice.festivalAddrSelect(addrdetails);
			session.setAttribute("list", list);
		}
		return list;
		
	}
	
	@GetMapping("/mainRestList/{addrdetails}")
	@ResponseBody
	public List<RestVO> mainRestList(@PathVariable("addrdetails")String addrdetails,HttpSession session){
		List<RestVO> list;
		log.info(addrdetails);
		if(addrdetails.equals("부산")) {
			list=restservice.restAllSelect();
			session.setAttribute("restlist", list);	
		}else {
			list=restservice.restAddrSelect(addrdetails);
			session.setAttribute("restlist", list);	
		}
		return list;
	}
	@GetMapping("/festivalRank")
	@ResponseBody
	public List<FestivalVO> festivalRank(){
		List<FestivalVO> list =festivalservice.festivalTop4();
		log.info(list.toString());
		return list;
	}
	@GetMapping("/restRank")
	@ResponseBody
	public List<RestVO> restRank(){
		List<RestVO> list = restservice.restTop3();
		return list;
	}
	@GetMapping("/test")
	public String test() {
		return "/test";
	}
}


	
	

