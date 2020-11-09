package com.uni.sellers.dashBoard;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.uni.sellers.datasource.CommandMap;

@Controller
@SessionAttributes({"userInfo","applicationCompanyGroup","auth"})
public class DashBoardController {
	Logger log = LoggerFactory.getLogger(this.getClass());

//	@Resource(name="CalendarService")
//	private CalendarService calendarService;
//
//	@Resource(name="salesManagementService")
//	private SalesManagementService salesManagementService;

	@RequestMapping(value="/test/TestDashBoard.do")
	public ModelAndView TestDashBoard(HttpServletRequest request, CommandMap map,HttpSession session) throws Exception{
		System.out.println("aslfmjsalfsjlfksjlkf");
		ModelAndView mv = new ModelAndView("/dashBoard/dashBoardView2");
		
		return mv;
	}
}