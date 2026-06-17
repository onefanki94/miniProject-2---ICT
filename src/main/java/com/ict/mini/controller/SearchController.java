package com.ict.mini.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ict.mini.service.SearchService;
import com.ict.mini.vo.CourseVO;
import com.ict.mini.vo.FestivalVO;
import com.ict.mini.vo.PagingVO;
import com.ict.mini.vo.RestVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class SearchController {

	@Autowired
    SearchService service;

    @GetMapping("/searchResult")
    public String searchResult(FestivalVO vo, RestVO rvo, CourseVO cvo, Model model,
    		@RequestParam(value = "searchWord", defaultValue = "") String searchWord,
            @RequestParam(value = "page", defaultValue = "1") int page) {
    	
    	PagingVO pvo = new PagingVO();
        pvo.setPage(page);
       
        pvo.setSearchWord(searchWord);
        
        pvo.setTotalFestival(service.countFestivals(searchWord));
        pvo.setTotalFood(service.countFoods(searchWord));
        
        List<FestivalVO> list = service.searchFestivals(pvo);
        List<RestVO> restlist = service.searchFoods(pvo);
        List<CourseVO> courselist = service.searchCourses(pvo);
        
        model.addAttribute("list", list);
        model.addAttribute("restlist", restlist);
        model.addAttribute("courselist", courselist);
        model.addAttribute("pvo", pvo);
        //model.addAttribute("searchWord", searchWord);
        return "/searchResult"; 
    }
    
    @GetMapping("/searchFestivals")
    @ResponseBody
    public List<FestivalVO> searchFestivals(@RequestParam(value = "searchWord", defaultValue = "") String searchWord,
                                            @RequestParam(value = "page", defaultValue = "1") int page) {
        log.info(searchWord);
        log.info(page+"");
    	PagingVO pvo = new PagingVO();
        pvo.setPage(page);
        //pvo.setSize(8);
        pvo.setSearchWord(searchWord);
        pvo.setTotalFestival(service.countFestivals(searchWord));
        log.info(pvo.toString());
        return service.searchFestivals(pvo);
    }

    @GetMapping("/searchFoods")
    @ResponseBody
    public List<RestVO> searchFoods(@RequestParam(value = "searchWord", defaultValue = "") String searchWord,
                                    @RequestParam(value = "page", defaultValue = "1") int page) {
        PagingVO pvo = new PagingVO();
        pvo.setPage(page);
        //pvo.setSize(8);
        pvo.setSearchWord(searchWord);
        pvo.setTotalFood(service.countFoods(searchWord));
        
        return service.searchFoods(pvo);
    }
    @GetMapping("/searchCourses")
    @ResponseBody
    public List<CourseVO> searchCourses(@RequestParam(value = "searchWord", defaultValue = "") String searchWord,
                                    @RequestParam(value = "page", defaultValue = "1") int page) {
        PagingVO pvo = new PagingVO();
        pvo.setPage(page);
        //pvo.setSize(8);
        pvo.setSearchWord(searchWord);
        pvo.setTotalFood(service.countCourses(searchWord));
        
        return service.searchCourses(pvo);
    }
}
