package com.ict.mini.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ict.mini.dao.CalendarDao;
import com.ict.mini.service.CalendarService;
import com.ict.mini.service.FestivalService;
import com.ict.mini.vo.CalendarVO;
import com.ict.mini.vo.FestivalVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/calendar")
public class CalendarController {
	@Autowired
	CalendarService calendarService;
	@Autowired
	FestivalService service;
	@GetMapping("/cal")
	public ModelAndView getCalendarList(ModelAndView mv, HttpServletRequest request) {
		String viewpage = "/board/calendar/cal";
		List<CalendarVO> calendar = null;
		mv.setViewName(viewpage);
		return mv;
	}
	
	@GetMapping("/listView/{date}/{environment}")
	@ResponseBody
	public List<FestivalVO> listView(@PathVariable("date") String date,
								@PathVariable("environment") String environment){
		
		List<FestivalVO> list=service.calDataSelect(date,environment);
		log.info("111"+list.toString());
		return list;
		
	}
	@GetMapping("/listView/{date}")
	@ResponseBody
	public List<FestivalVO> listView(@PathVariable("date") String date){
		List<FestivalVO> list=service.calDataSelect2(date);
		log.info("111"+list.toString());
		
		return list;
	}
	
}
