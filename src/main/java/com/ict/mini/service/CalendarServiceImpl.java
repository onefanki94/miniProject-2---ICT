package com.ict.mini.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.mini.dao.CalendarDao;
import com.ict.mini.vo.CalendarVO;

@Service
public class CalendarServiceImpl implements CalendarService {

	@Autowired
	private CalendarDao dao;

	
	

  }