package com.uni.sellers.main;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mobile.device.Device;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.uni.sellers.common.CommonDAO;
import com.uni.sellers.datasource.CommandMap;


@Controller
public class MainController {
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name="mainService")
	private MainService mainService;

	@Resource(name="mainDAO")
	private MainDAO mainDAO;

	@Resource(name="commonDAO")
	private CommonDAO commonDAO;

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 10. 24.
	 * @explain	: 랜딩페이지 -> 첫 화면
	 */
	@RequestMapping(value="/main/index.do")
	public ModelAndView mainLanding(CommandMap map, HttpServletRequest request, Device device) throws Exception{
		ModelAndView mv = new ModelAndView();
		/*if(((String)map.get("global_role_code")).contains("ROLE_MEMBER")){ //영업대표
			mv.setViewName("/main/mainMember");
		}else{ //팀장 이상
			mv.setViewName("/main/main");
		}*/
		/*map.put("searchQuarter",5);
		Map<String,Object> selectCompanyResult = mainService.selectCompanyResult(map.getMap());
		mv.addObject("selectCompanyResult",selectCompanyResult);*/
		//테스트를 위함
//		response.sendRedirect("/test/trackingTest.do");
		
		if (device.isNormal()) {
			mv.setViewName("/main/main");
			List<Map<String,Object>> selectMainModuleSetUp = mainService.selectMainModuleSetUp(map.getMap());
			List<Map<String,Object>> selectMainMenuSetUp = mainService.selectMainMenuSetUp(map.getMap());
			mv.addObject("selectMainModuleSetUp",selectMainModuleSetUp);
			mv.addObject("selectMainMenuSetUp",selectMainMenuSetUp);
		}else {
			//mv.setViewName("/main/mainLandingPage"); //모바일 아이콘형식 화면
			
			// 2020.01.08. 디유넷 소스 병합
			mv.setViewName("/main/main");
			
			List<Map<String,Object>> selectMainSetUp = mainService.selectMainSetUp(map.getMap());
			mv.addObject("selectMainSetUp",selectMainSetUp);
			
			//공통영역
			List<Map<String,Object>> selectResultGraphOptionTeam = mainService.selectResultGraphOptionTeam(map.getMap());
			List<Map<String,Object>> selectResultGraphOptionMember = mainService.selectResultGraphOptionMember(map.getMap());
			
			mv.addObject("OptionTeam",selectResultGraphOptionTeam);
			mv.addObject("OptionMember",selectResultGraphOptionMember);
			
			// 일정/모니터링
			mv.addObject("notice_event_id", map.get("notice_event_id"));

			//날짜 확인 (YYYYMMDD)
			Calendar c = Calendar.getInstance();
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
			String curDate = "";
			if (map.get("curDate") != null){
				//입력된 날짜가 있으면 거기에 맞춤
				curDate = map.get("curDate").toString();
			} else {
				//세션에도 없으면 오늘날짜 가져옴
				curDate = transFormat.format(c.getTime());
			}
			
			//현재날짜
			Date cd = transFormat.parse(curDate);
			c.setTime(cd);
			mv.addObject("cYear", c.get(Calendar.YEAR));
			mv.addObject("cMonth", c.get(Calendar.MONTH) + 1);
			mv.addObject("cDay", c.get(Calendar.DAY_OF_MONTH));
			
			//이전날짜
			Calendar cPrev = Calendar.getInstance();
			cPrev.setTime(cd);
			cPrev.add(Calendar.DATE, -1);
			mv.addObject("prevDate", transFormat.format(cPrev.getTime()));
			
			//다음날짜
			Calendar cNext = Calendar.getInstance();
			cNext.setTime(cd);
			cNext.add(Calendar.DATE, 1);
			mv.addObject("nextDate", transFormat.format(cNext.getTime()));
		}
		
		return mv;
	}
	
	/**
	 * @author 	: 봉준
	 * @Date		: 2018. 10. 23.
	 * @explain	: 모바일 마이페이지(초기 랜딩페이지)
	 */
	@RequestMapping(value="/main/myActivePage.do")
	public ModelAndView mainLanding(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("/main/main");
		
		List<Map<String,Object>> selectMainModuleSetUp = mainService.selectMainModuleSetUp(map.getMap());
		List<Map<String,Object>> selectMainMenuSetUp = mainService.selectMainMenuSetUp(map.getMap());
		mv.addObject("selectMainModuleSetUp",selectMainModuleSetUp);
		mv.addObject("selectMainMenuSetUp",selectMainMenuSetUp);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2018. 08. 31.
	 * @explain	: 랜딩페이지 -> 첫 화면 -> 모달 클릭 시
	 */
	@RequestMapping(value="/main/mainSetupTable.do")
	public ModelAndView mainSetupTable(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		if(map.get("mainCategory").equals("1")){
			List<Map<String,Object>> selectMainModuleSetUp = mainService.selectMainModuleSetUp(map.getMap());
			mv.addObject("selectMainModuleSetUp",selectMainModuleSetUp);
		}else {
			List<Map<String,Object>> selectMainMenuSetUp = mainService.selectMainMenuSetUp(map.getMap());
			mv.addObject("selectMainMenuSetUp",selectMainMenuSetUp);
		}
		return mv;
	}
	
	//////////////////////////////////////// 개발 완료후 삭제 소스////////////////////////////////////////
	
	
	//에러 버그 문의
	@RequestMapping(value="/main/selectErrNbugList.do")
	public ModelAndView selectErrNbugList(CommandMap map) throws Exception{
		ModelAndView mv = null;
		if(map.getMap().get("flag").equals("getErrNbugListCount")){
			mv = new ModelAndView("jsonView");
		}else if(map.getMap().get("flag").equals("getErrNbugList")){
			if(null != map.getMap().get("sender") && map.getMap().get("sender").equals("Y"))
			{
				mv = new ModelAndView("/common/top_Ajax2");
			}else{
				mv = new ModelAndView("/common/top_Ajax");
			}
		}
		List<Map<String,Object>> selectTimeLine = mainDAO.selectErrNbugList(map.getMap());
		
		mv.addObject("list",selectTimeLine);
		return mv;
	}
	
	//에러 버그 문의
	@RequestMapping(value="/main/updateErrNbugSuccessStatus.do")
	public ModelAndView updateErrNbugSuccessStatus(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int selectTimeLine = mainDAO.updateErrNbugSuccessStatus(map.getMap());
		mv.addObject("list",selectTimeLine);
		return mv;
	}
	
	@RequestMapping(value="/main/deleteQ.do")
	public ModelAndView deleteQ(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int deleteQ = mainDAO.deleteQ(map.getMap());
		mv.addObject("deleteQ", deleteQ);
		
		return mv;
	}
	
	///////////////////////////////////개발 완료 후 삭제 소스 끝//////////////////////////////////////////////
	

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 11. 03.
	 * @explain	: 랜딩페이지 -> 일정
	 */
	@RequestMapping(value="/main/selectTimeLine.do")
	public ModelAndView selectTimeLine(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		if(!device.isNormal()){
			map.put("deviceCheck", "mobile");
		}
		
		List<Map<String,Object>> selectTimeLine = mainService.selectTimeLine(map.getMap());
		mv.addObject("list",selectTimeLine);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 11. 03.
	 * @explain	: 랜딩페이지 -> 진행중인 영엽활동
	 */
	@RequestMapping(value="/main/selectSalesAct.do")
	public ModelAndView selectSalesAct(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		List<Map<String,Object>> selectSalesAct = null;
		
		if(device.isNormal()) {
			selectSalesAct = mainService.selectSalesAct(map.getMap());
			mv.addObject("list",selectSalesAct);
		}else {
			map.put("deviceCheck", "mobile");
			
			selectSalesAct = mainService.selectSalesAct(map.getMap());
			mv.addObject("row",selectSalesAct);
			
			Map<String,Object> selectOpportunityGraphData= mainService.selectOpportunityGraphData(map.getMap());
			mv.addObject("graph_data", selectOpportunityGraphData);
		}		
		
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2018. 07. 12.
	 * @explain	: 랜딩페이지 -> 진행중인 영엽활동2
	 */
	@RequestMapping(value="/main/selectSalesAct2.do")
	public ModelAndView selectSalesAct2(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		List<Map<String,Object>> selectSalesAct2 = mainService.selectSalesAct2(map.getMap());
		mv.addObject("list",selectSalesAct2);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date	: 2018. 07. 03.
	 * @explain	: 랜딩페이지 -> 진행중인 잠재영업기회
	 */
	@RequestMapping(value="/main/selectHiddenSalesAct.do")
	public ModelAndView selectHiddenSalesAct(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		List<Map<String,Object>> selectHiddenSalesAct = mainService.selectHiddenSalesAct(map.getMap());
		mv.addObject("list",selectHiddenSalesAct);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date	: 2018. 07. 03.
	 * @explain	: 랜딩페이지 -> 고객이슈
	 */
	@RequestMapping(value="/main/selectClientIssue.do")
	public ModelAndView selectClientIssue(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		List<Map<String,Object>> selectClientIssue = null;
		
		if(device.isNormal()) {
			selectClientIssue = mainService.selectClientIssue(map.getMap());
			mv.addObject("list",selectClientIssue);
		}else {
			map.put("deviceCheck", "mobile");
			
			selectClientIssue = mainService.selectClientIssue(map.getMap());
			mv.addObject("row", selectClientIssue);
		}
		
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 11. 03.
	 * @explain	: 랜딩페이지 -> 신규 및 업데이트 영업활동
	 */
	@RequestMapping(value="/main/selectNewUpdate.do")
	public ModelAndView selectNewUpdate(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		List<Map<String,Object>> selectNewUpdate = mainService.selectNewUpdate(map.getMap());
		mv.addObject("list",selectNewUpdate);
		return mv;
	}
	
	/**
	 * @author 	: 장성훈남
	 * @Date		: 2017. 04. 11.
	 * @explain	: 랜딩페이지 -> TRACKING
	 */
	@RequestMapping(value="/main/selectTrackingList.do")
	public ModelAndView selectTrackingList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		List<Map<String,Object>> selectTrackingList = mainService.selectTrackingList(map.getMap());
		mv.addObject("list",selectTrackingList);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 11. 03.
	 * @explain	: 랜딩페이지 -> 성과 탭
	 */
	@RequestMapping(value="/main/selectResult.do")
	public ModelAndView selectResult(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		map.put("category_main", "0"); //회사별
		Map<String,Object> selectResult = mainService.selectResult(map.getMap());
		map.put("category_main", "1"); //부서별
		Map<String,Object> selectDivisionResult = mainService.selectResult(map.getMap());
		map.put("category_main", "2"); //개인
		Map<String,Object> selectMyResult = mainService.selectResult(map.getMap());
		
		mv.addObject("list",selectResult);
		mv.addObject("list2",selectDivisionResult);
		mv.addObject("list3",selectMyResult);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 11. 03.
	 * @explain	: 랜딩페이지 -> 성과 탭 모바일
	 */
	@RequestMapping(value="/main/selectResultMobile.do")
	public ModelAndView selectResultMobile(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		map.put("category_main", "2"); //개인
		Map<String,Object> selectMyResult = mainService.selectResult(map.getMap());
		
		mv.addObject("list",selectMyResult);
		return mv;
	}

	

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 11. 17.
	 * @explain	: 랜딩페이지 -> 성과 탭 회사 전체
	 */
	@RequestMapping(value="/main/selectCompanyResult.do")
	public ModelAndView selectCompanyResult(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		Map<String,Object> selectCompanyResult = mainService.selectResult(map.getMap());
		mv.addObject("list",selectCompanyResult);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 11. 04.
	 * @explain	: 랜딩페이지 -> 성과 그래프
	 */
	@RequestMapping(value="/main/selectResultGraph.do")
	public ModelAndView selectResultGraph(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else if(map.get("datatype").equals("json")){
			mv.setViewName("jsonView");
		}
		List<Map<String,Object>> selectResultGraph = mainService.selectResultGraph(map.getMap());
		mv.addObject("list",selectResultGraph);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 11. 04.
	 * @explain	: 랜딩페이지 -> 영업대표 나의 고객
	 */
	@RequestMapping(value="/main/selectMyCompanyList.do")
	public ModelAndView selectMyCompanyList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		List<Map<String,Object>> selectMyCompanyList = mainService.selectMyCompanyList(map.getMap());
		int selectMyCompanyListCount = mainDAO.selectMyCompanyListCount(map.getMap());
		mv.addObject("count",selectMyCompanyListCount);
		mv.addObject("list",selectMyCompanyList);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 11. 04.
	 * @explain	: 랜딩페이지 -> 영업대표 최근 컨택
	 */
	@RequestMapping(value="/main/selectContactList.do")
	public ModelAndView selectContactList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		List<Map<String,Object>> selectContactList = mainService.selectContactList(map.getMap());
		mv.addObject("list",selectContactList);
		return mv;
	}
	
	/**
	 * @author 	: 봉준
	 * @Date	: 2017. 10. 26.
	 * @explain	: 랜딩페이지 -> 최근한달 등록 신규고객의 고객사 리스트
	 */
	//경농버전 고객 카테고리별(농민,영향력자,거래선) 인원수 >> 고객사별 인원수로 소스 수정함.
	@RequestMapping(value="/main/selectNewCpnList.do")
	public ModelAndView selectNewCpnList(CommandMap map) throws Exception{
		ModelAndView mv = null;
		if(map.getMap().get("datatype").equals("html"))
		{
			mv = new ModelAndView((String) map.getMap().get("jsp"));
		}
		else if(map.getMap().get("datatype").equals("json"))
		{
			mv = new ModelAndView("jsonView");
		}
		
		List<Map<String,Object>> selectNewCpnList = mainService.selectNewCpnList(map.getMap());
		
		mv.addObject("CpnRows", selectNewCpnList);
		mv.addObject("CstTotal", selectNewCpnList.get(2).get("TOTAL"));
		
		return mv;
	}
	
	/**
	 * @author 	: 봉준
	 * @Date	: 2017. 10. 26.
	 * @explain	: 랜딩페이지 -> 최근한달 등록 신규고객
	 */
	//경농버전 고객 카테고리별(농민,영향력자,거래선) 인원수 >> 고객사별 인원수로 소스 수정함.
	@RequestMapping(value="/main/selectNewCstmList.do")
	public ModelAndView selectNewCstmList(CommandMap map) throws Exception{
		ModelAndView mv = null;
		if(map.getMap().get("datatype").equals("html"))
		{
			mv = new ModelAndView((String) map.getMap().get("jsp"));
		}
		else if(map.getMap().get("datatype").equals("json"))
		{
			mv = new ModelAndView("jsonView");
		}
		
		List<Map<String,Object>> selectNewCstmList = mainService.selectNewCstmList(map.getMap());
		
		mv.addObject("CstRows", selectNewCstmList);
		
		return mv;
	}
	
	/**
	 * @author 	: 욱
	 * @Date	: 2018. 07. 02.
	 * @explain	: 랜딩페이지 -> 모듈설정 저장
	 */
	@RequestMapping(value="/main/insertMainModule.do")
	public ModelAndView insertMainModule(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		mainService.insertMainModule(map.getMap());
		return mv;
	}
	
	/**
	 * @author 	: 욱
	 * @Date	: 2018. 09. 03.
	 * @explain	: 랜딩페이지 -> 메인메뉴 순서 저장
	 */
	@RequestMapping(value="/main/insertMainMenu.do")
	public ModelAndView insertMainMenu(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		mainService.insertMainMenu(map.getMap());
		return mv;
	}
	
	/**
	 * @author 	: 욱
	 * @Date	: 2018. 09. 03.
	 * @explain	: 메뉴 -> 개인 메뉴 순서 불러오기
	 */
	@RequestMapping(value="/main/selectMemberMenu.do")
	public ModelAndView selectMemberMenu(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		mv.addObject("rows", mainService.selectMemberMenu(map.getMap()));
		return mv;
	}
	
	@RequestMapping(value="/main/selectMemberMobileMenu.do")
	public ModelAndView selectMemberMobileMenu(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		mv.addObject("list", mainService.selectMemberMobileMenu(map.getMap()));
		return mv;
	}
	
	/**
	 * @author 	: 봉준
	 * @Date	: 2018. 10. 22.
	 * @explain	: 모바일 아이콘 형식 랜딩페이지
	 */
	@RequestMapping(value="/main/selectUserMobileLandingPage.do")
	public ModelAndView selectUserMobileLandingPage(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		mv.addObject("list", mainDAO.selectUserMobileLandingPage(map.getMap()));
		return mv;
	}
	
	/**
	 * @author 	: 봉준
	 * @Date	: 2018. 10. 22.
	 * @explain	: 모바일 아이콘 형식 랜딩페이지
	 */
	@RequestMapping(value="/main/selectMobileLandingPageMenuList.do")
	public ModelAndView selectMobileLandingPageMenuList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		mv.addObject("list", mainDAO.selectMobileLandingPageMenuList(map.getMap()));
		return mv;
	}
	
	/**
	 * @author 	: 봉준
	 * @Date	: 2018. 10. 22.
	 * @explain	: 모바일 아이콘 형식 랜딩페이지
	 */
	@RequestMapping(value="/main/insertUserMobileLandingPageMenu.do")
	public ModelAndView insertUserMobileLandingPageMenu(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		mv.addObject("cnt", mainService.insertUserMobileLandingPageMenu(map.getMap()));
		return mv;
	}
	
	/**
	 * @author 	: 봉준
	 * @Date	: 2018. 11. 22.
	 * @explain	: 버블차트
	 */
	@RequestMapping(value="/main/selectSalesActBubbleChart.do")
	public ModelAndView selectSalesActBubbleChart(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
			mv.addObject("salesActList", mainService.selectSalesActBubbleChart(map.getMap()));
		}
		
		return mv;
	}
	
	/**
	 * @author 	: 최현경
	 * @Date	: 2018. 11. 22.
	 * @explain	: 도넛차트
	 */
	@RequestMapping(value="/main/selectSalesActDonutChart.do")
	public ModelAndView selectSalesActDonutChart(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		Map<String,Object> map2 = mainService.selectSalesActDonutChart(map.getMap());
		mv.addObject("selectList", map2.get("selectList"));
		mv.addObject("salesActList", map2.get("salesActList"));
		mv.addObject("forecastList", map2.get("forecastList"));
		mv.addObject("forecastList2", map2.get("forecastList2"));
		mv.addObject("y2yList", map2.get("y2yList"));
		mv.addObject("selectFacePost", map.getMap().get("selectFacePost"));
		
		return mv;
	}
	
	
	/**
	 * @author 	: 김동용
	 * @Date	: 2019. 09. 20.
	 * @explain	: 모바일 토큰 값 저장
	 */
	@RequestMapping(value="/main/insertUserMobileToken.do")
	public ModelAndView insertUserMobileToken(CommandMap map, HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		session.setAttribute("userToken", map.get("userDi"));//최영완
		mainService.insertUserMobileToken(map.getMap());
		return mv;
	}
}