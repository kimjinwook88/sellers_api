package com.uni.sellers.tracking;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.uni.sellers.common.CommonDAO;
import com.uni.sellers.datasource.CommandMap;

@Controller
public class TrackingController {
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name="trackingService")
	private TrackingService trackingService;

	@Resource(name="trackingDAO")
	private TrackingDAO trackingDAO;

	@Resource(name="commonDAO")
	private CommonDAO commonDAO;

	
	
	/**
	 * @author 	: 장성훈
	 * @Date		: 2017. 04. 05.
	 * @explain	: Tracking
	 */
	@RequestMapping(value="/test/trackingTest.do")
	public ModelAndView trackingTest(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("/main/main");
		//Tracking 실행 TEST
		int cnt=0;
		trackingService.checkTrackingList();
		
		return mv;
	}
	
	/**
	 * @author 	: 심윤영
	 * @Date		: 2019. 01. 09.
	 * @explain	: 사용자 트래킹 사용자 설정 페이지
	 */
	@RequestMapping(value="/tracking/viewUserTrackingOption.do")
	public ModelAndView viewUserTrackingOption(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/tracking/userTrackingOption");
		return mv;
	}
	
	/**
	 * @author 	: 심윤영
	 * @Date		: 2019. 01. 09.
	 * @explain	: 본부장 전체 트래킹 사용자 설정 조회(유니포인트ver) 
	 */
	@RequestMapping(value="/tracking/selectUserTrackingOption.do") //COM_AUTHORITY 테이블에 본부장권한 데이터 추가 필요
	public ModelAndView selectUserTrackingOption(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String, Object>> userTrackingOption = trackingService.selectUserTrackingOption(map.getMap());
		mv.addObject("userTrackingOption",userTrackingOption);
		
		return mv;
	}
	
	//트래킹 사용자 설정 저장
	@RequestMapping(value="/tracking/upsertUserTrackingOption.do")
	public ModelAndView upsertUserTrackingOption(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = trackingService.upsertUserTrackingOption(map.getMap());
		mv.addObject("cnt",cnt);
		return mv;
	}
	
}