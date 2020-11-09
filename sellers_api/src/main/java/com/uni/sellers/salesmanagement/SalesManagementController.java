package com.uni.sellers.salesmanagement;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.uni.sellers.common.CommonDAO;
import com.uni.sellers.datasource.CommandMap;
import com.uni.sellers.util.CommonUtils;

@Controller
public class SalesManagementController {
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="salesManagementService")
	private SalesManagementService salesManagementService;
	
	@Resource(name="salesManagementDAO")
	private SalesManagementDAO salesManagementDAO;
	
	@Resource(name="commonDAO")
	private CommonDAO commonDAO;
	////////////////////////////////////////제안관리 start ////////////////////////////////////////////////
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 20.
	 * @explain	: 영업관리 -> 제안관리 리스트  viewProposalsInfoList
	 */
	@RequestMapping(value="/salesManagement/viewProposalsInfoList.do")
	public ModelAndView listSuggest(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/salesManagement/proposalsInfoList");
		Map<String,Object> searchDetailGroup = salesManagementService.suggestSearchDetailGroup(map.getMap());
		map.put("use_yn", "Y");
		//사용안해서 주석 처리 2017-07-20 김진욱
		//searchDetailGroup.put("selectProductList", commonDAO.selectProductList(map.getMap()));
		mv.addObject("searchDetailGroup", searchDetailGroup);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 08. 08.
	 * @explain	: 영업관리 -> 제안관리 리스트 카운트
	 */
	@RequestMapping(value="/salesManagement/selectProposalsInfoListCount.do")
	public ModelAndView selectProposalsInfoListCount(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		Map<String,Object> countMap = salesManagementDAO.selectProposalsInfoListCount(map.getMap());
		String latelyUpdate = salesManagementDAO.selectProposalsInfoLatelyUpdate(map.getMap());
		//페이징이 처리
		String listCount =  countMap.get("listCount").toString();
		mv.addObject("listPaging", CommonUtils.pagingSum(map.getMap(),Integer.parseInt(listCount)));
		mv.addObject("listCount", countMap.get("listCount"));
		mv.addObject("searchPKArray", countMap.get("searchPKArray"));
		mv.addObject("latelyUpdate", latelyUpdate);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 8. 09.
	 * @explain	: 영업관리 -> 제안관리 리스트
	 */
	@RequestMapping(value="/salesManagement/selectProposalsInfotList.do")
	public ModelAndView selectProposalsInfotList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/salesManagement/proposalsInfoAjax");
		List<Map<String,Object>> selectSuggestList= salesManagementService.selectProposalsInfotList(map.getMap());
		mv.addObject("rows", selectSuggestList);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 8. 9.
	 * @explain	: 영업관리 -> 제안관리 상세보기
	 */
	@RequestMapping(value="/salesManagement/selectProposalsInfoDetail.do")
	public ModelAndView selectProposalsDetail(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		Map<String,Object> selectProposalsInfoDetail = salesManagementService.selectProposalsInfoDetail(map.getMap());
		List<Map<String,Object>> selectProposalsInfoFileList = salesManagementDAO.selectProposalsInfoFileList(map.getMap());
		mv.addObject("detail", selectProposalsInfoDetail);
		mv.addObject("fileList",selectProposalsInfoFileList);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 7. 7.
	 * @explain	: 영업관리 -> 제안관리 insert
	 */
	@RequestMapping(value="/salesManagement/insertProposalsInfo.do")
	public ModelAndView insertProposalsInfo(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = salesManagementService.insertProposalsInfo(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 7. 7.
	 * @explain	: 영업관리 -> 제안관리 update
	 */
	@RequestMapping(value="/salesManagement/updateProposalsInfo.do")
	public ModelAndView updateProposalsInfo(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = salesManagementService.updateProposalsInfo(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}
	
	
//////////////////////////////////////제안관리 end ////////////////////////////////////////////////
	
	
	
	
////////////////////////////////////////성과관리 start ////////////////////////////////////////////////
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 20.
	 * @explain	: 영업관리 -> 성과관리 리스트
	 */
	@RequestMapping(value="/salesManagement/viewPerformManagement.do")
	public ModelAndView viewPerformManagement(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/salesManagement/resultManagementDashBoard");
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 11. 08.
	 * @explain	: 영업관리 -> 성과관리 -> 부서
	 */
	
	@RequestMapping(value="/salesManagement/selectResultDashBoardDivision.do")
	public ModelAndView selectResultDashBoardDivision(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		List<Map<String,Object>> selectResultDashBoardDivision= salesManagementService.selectResultDashBoardDivision(map.getMap());
		mv.addObject("selectResultDashBoardDivision", selectResultDashBoardDivision);
		return mv;
	}
	
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 11. 08.
	 * @explain	: 영업관리 -> 성과관리 -> 팀
	 */
	
	@RequestMapping(value="/salesManagement/selectResultDashBoardTeam.do")
	public ModelAndView selectResultDashBoardTeam(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		List<Map<String,Object>> selectResultDashBoardTeam= salesManagementService.selectResultDashBoardTeam(map.getMap());
		mv.addObject("selectResultDashBoardTeam", selectResultDashBoardTeam);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 11. 08.
	 * @explain	: 성과관리 -> 개인별 / 고객사별
	 */
	//개인별 탭
	@RequestMapping(value="/salesManagement/selectResultDashBoardMember.do")
	public ModelAndView selectResultDashBoardMember(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		List<Map<String,Object>> selectResultDashBoardMember= salesManagementService.selectResultDashBoardMember(map.getMap());
		mv.addObject("selectResultDashBoardMember", selectResultDashBoardMember);
		
		return mv;
	}
	
	//고객사별 그룹
	@RequestMapping(value="/salesManagement/selectResultDashBoardCompanyGroup.do")
	public ModelAndView selectResultDashBoardCompanyGroup(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		List<Map<String,Object>> selectResultDashBoardCompanyGroup= salesManagementService.selectResultDashBoardCompanyGroup(map.getMap());
		mv.addObject("selectResultDashBoardCompanyGroup", selectResultDashBoardCompanyGroup);
		
		return mv;
	}
	//고객사별 탭
	@RequestMapping(value="/salesManagement/selectResultDashBoardCompany.do")
	public ModelAndView selectResultDashBoardCompany(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		List<Map<String,Object>> selectResultDashBoardCompany= salesManagementService.selectResultDashBoardCompany(map.getMap());
		mv.addObject("selectResultDashBoardCompany", selectResultDashBoardCompany);
		
		return mv;
	}
	
////////////////////////////////////////성과관리 end ////////////////////////////////////////////////
	
	
	
	
////////////////////////////////////////Face Time start ////////////////////////////////////////////////
	/**
	 * @author 	: 장성훈
	 * @Date		: 2016.10. 27.
	 * @explain	: 영업관리 -> Face Time 리스트
	 */
	@RequestMapping(value="/salesManagement/gridFaceTime.do")
	public ModelAndView gridFaceTime(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> gridFaceTime= salesManagementService.gridFaceTime(map.getMap());
		mv.addObject("rows", gridFaceTime);
		
		return mv;
	}
	
	@RequestMapping(value="/salesManagement/gridFaceTimeAjax.do")
	public ModelAndView gridFaceTimeAjax(CommandMap map) throws Exception{
		ModelAndView mv = null;
		
		if(map.getMap().get("individualData") != null)
		{
			mv = new ModelAndView("/salesManagement/productivityIndividualTabAjax");
		}else 
		{
			mv = new ModelAndView("/salesManagement/productivityTabAjax");
		}
		
		List<Map<String,Object>> viewType = new ArrayList<Map<String, Object>>();
		Map<String,Object> tmp = new HashMap<>();
		
		List<Map<String,Object>> gridFaceTime= salesManagementService.gridFaceTime(map.getMap());
		mv.addObject("rows", gridFaceTime);
		
		//==============
		Calendar oCalendar = Calendar.getInstance( );
		/*
		System.out.println("현재 년: " +  oCalendar.get(Calendar.YEAR)); //2017
	    System.out.println("현재 월: " + (oCalendar.get(Calendar.MONTH) + 1));  //1
	    System.out.println("이번분기:" + Math.ceil( currentMonth() / 3.0 )); //1.0
	    */
		
	    //현재 기준
	    int todayMonth = (oCalendar.get(Calendar.MONTH) + 1);
	    int todayYear = oCalendar.get(Calendar.YEAR);
	    int todayQuarter = (int) Math.ceil( currentMonth() / 3.0 );
	    
	    //입력 받은 기준
	    int selectMonth = Integer.parseInt(map.getMap().get("selectFaceMonth").toString());
	    int selectYear = Integer.parseInt(map.getMap().get("selectFaceYear").toString());
	    int selectQuarter =  Integer.parseInt((String) map.getMap().get("selectFaceQuarter"));
	    
	    if(map.getMap().get("viewType").equals("m"))
	    {
	    	if(selectYear == todayYear)
	    	{
	    		if(selectMonth == todayMonth)
	    		{
	    			tmp.put("thisName", "이번달");
	    			tmp.put("lastName", "전달대비");
	    		}
	    		else
	    		{
		    		tmp.put("thisName", selectMonth+"월");
	    			tmp.put("lastName", selectMonth-1 +"월대비");
	    		}
	    	}
	    	else
	    	{
	    		tmp.put("thisName", selectYear+"년 "+selectMonth+"월");
    			tmp.put("lastName", selectMonth-1 +"월대비");
	    	}
	    	
	    	/*
	    	if(map.getMap().get("selectFaceMonth").equals(Integer.toString(todayMonth))){
	    		tmp.put("thisName", "이번달");
	    		tmp.put("lastName", "전달대비");
	    	}else{
	    		tmp.put("thisName", map.getMap().get("selectFaceMonth")+"월");
	    		tmp.put("lastName", Integer.parseInt((String) map.getMap().get("selectFaceMonth"))-1 +"월대비");
	    	}
	    	*/
	    	
	    }else if(map.getMap().get("viewType").equals("y"))
	    {
	    	if(Integer.parseInt((String) map.getMap().get("selectFaceYear")) == todayYear){
	    		tmp.put("thisName", "이번년");
	    		tmp.put("lastName", "전년대비");
	    	}else{
	    		tmp.put("thisName", map.getMap().get("selectFaceYear")+"년");
	    		tmp.put("lastName", Integer.parseInt((String) map.getMap().get("selectFaceYear"))-1 +"년대비");
	    	}
	    }
	    else
	    {
	    	if(selectYear == todayYear)
	    	{
	    		if(selectQuarter == todayQuarter)
	    		{
	    			tmp.put("thisName", "이번분기");
		    		tmp.put("lastName", "전분기대비");
	    		}
	    		else
	    		{
		    		tmp.put("thisName", selectQuarter+"분기");
		    		tmp.put("lastName", selectQuarter-1 +"분기대비");
		    	}
	    	}
	    	else
	    	{
	    		tmp.put("thisName", selectYear+"년 "+selectQuarter+"분기");
    			tmp.put("lastName", selectQuarter-1 +"분기대비");
	    	}
	    }
	    viewType.add(tmp);
	    mv.addObject("viewType", viewType);
		return mv;
	}
	
	public static int currentMonth() 
	{
	    Calendar cal = Calendar.getInstance();

	    return cal.get(Calendar.MONTH) + 1; // 현재 월만 반환
	}
	
	
	/**
	 * 회사전체, 본부전체, 팀전체
	 * 로그인 정보 권한 별로 열리는 페이지를 다르게 한다.
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/salesManagement/viewProductivity.do")
	public ModelAndView viewProductivity(CommandMap map, HttpServletResponse res) throws Exception{
		ModelAndView mv = null;

		String role = "";
		
		if(map.getMap().get("global_role_code").toString().contains("ROLE_ADMIN")){
			role = "ROLE_CEO";
		}
		
		if (map.getMap().get("global_role_code").toString().contains("ROLE_CEO"))
		{
			role = "ROLE_CEO";
		}else if (map.getMap().get("global_role_code").toString().contains("ROLE_DIVISION"))
		{
			role = "ROLE_DIVISION";
		}else if (map.getMap().get("global_role_code").toString().contains("ROLE_TEAM"))
		{
			role = "ROLE_TEAM";
		}else if (map.getMap().get("global_role_code").toString().contains("ROLE_MEMBER"))
		{
			role = "ROLE_MEMBER";
		}
		
		//영업대표(사원급)일 경우에는 캘린더 페이지로 이동하여 생산성을 확인한다.
		if(role.equals("ROLE_MEMBER"))
		{
			res.sendRedirect("/calendar/viewCalendar.do?&myProductivity=Y");
		}
		//영업대표(사원급)이 아닌경우 처리 (CEO, 본부장, 팀장등)
		else
		{
			Map<String,Object> searchDetailGroup = salesManagementService.faceTimeSearchDetailGroup(map.getMap());
			
			// 영업직군이 아닌 부서는 캘린더 페이지로 이동하여 생산성을 확인한다.
			@SuppressWarnings("unchecked")
			List<Map<String, Object>> facePost = (List<Map<String, Object>>) searchDetailGroup.get("facePost");
			if(facePost.size() < 1){
				res.sendRedirect("/calendar/viewCalendar.do?&myProductivity=Y");
			}
			
			//CEO
			if(role.equals("ROLE_CEO"))
			{
				
				if(map.get("roleChildDivision") != null)
				{	//CEO가 본부별 생산성 보기
					mv = new ModelAndView("/salesManagement/productivityCeo_division");
//					map.put("rolePage", "division");
				}
				else if(map.get("roleChildTeam") != null)
				{	//CEO가 팀별 생산성 보기
					mv = new ModelAndView("/salesManagement/productivityCeo_team");
//					map.put("rolePage", "team");
				}
				else
				{	//CEO가 회사 전체 생산성 보기
					mv = new ModelAndView("/salesManagement/productivityCeo");
//					map.put("rolePage", "total");
				}
				
			}
			//본부장
			else if(role.equals("ROLE_DIVISION"))
			{
				if(map.get("roleChild") != null) 
				{	//본부장이 팀내 팀원들 생산성 보기
					mv = new ModelAndView("/salesManagement/productivityDivision_team");
				}
				else 
				{	//본부장이 그 본부에 속한 전체 팀 생산성 보기
					mv = new ModelAndView("/salesManagement/productivityDivision");
				}
			}
			//팀장
			else if(role.equals("ROLE_TEAM"))
			{	//팀장이 그 팀에 속한 팀원들 생산성 보기
				
				mv = new ModelAndView("/salesManagement/productivityTeam");
			}
			
			mv.addObject("searchDetailGroup", searchDetailGroup);
			mv.addObject("selectFaceYear",map.get("selectFaceYear"));
			mv.addObject("selectFaceMonth",map.get("selectFaceMonth"));
			mv.addObject("selectFaceQuarter",map.get("selectFaceQuarter"));
			mv.addObject("selectFacePost",map.get("selectFacePost"));
			mv.addObject("selectFaceTeam",map.get("selectFaceTeam"));
			mv.addObject("viewType",map.get("viewType"));
			
			
//			mv.addObject("roleStatus",map.get("role"));
//			mv.addObject("rolePage", map.get("rolePage"));
		}

		return mv;
	}
	
	
	@RequestMapping(value="/salesManagement/insertData.do")
	public void insertTestData(CommandMap map) throws Exception{
		int cnt = salesManagementService.insertTestData(map.getMap());
		
		log.debug("insert 완료된 건수 : " + cnt);
		
	}
////////////////////////////////////////Face Time end ////////////////////////////////////////////////
	
	//////////////////////////////////////// 주간보고 start
	//////////////////////////////////////// ////////////////////////////////////////////////
	/**
	 * @author : 최현경
	 * @Date : 2018. 10. 19.
	 * @explain : 성과관리 -> 주간보고 viewWeeklyReportTabAjax
	 */
	@RequestMapping(value = "/salesManagement/viewWeeklyReportTabAjax.do")
	public ModelAndView viewWeeklyReportTabAjax(CommandMap map) throws Exception {
		ModelAndView mv = new ModelAndView("/salesManagement/weeklyReportTabAjax");
		List<Map<String, Object>> diviosnList = salesManagementService.selectDivisionList(map.getMap());
		mv.addObject("divisionList", diviosnList);
		return mv;
	}

	/**
	 * 연도별 주간보고서 가져옴. (개발중)
	 * 
	 * @author : 최현경
	 * @Date : 2018. 10. 23.
	 * @explain : 성과관리 -> 주간보고 selectWeeklyReportYear
	 */
	@RequestMapping(value = "/salesManagement/selectWeeklyReportYear.do")
	public ModelAndView selectWeeklyReportYear(CommandMap map) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName((String) map.get("jsp"));

		Map<String, Object> weeklyReportYear = salesManagementService.selectWeeklyReportYear(map.getMap());
		mv.addObject("weeklyReportYear", weeklyReportYear.get("weeklyReportYear"));
		mv.addObject("weeklyReportTotalYear", weeklyReportYear.get("weeklyReportTotalYear"));

		return mv;
	}

	/**
	 * 분기별 주간보고서 가져옴. (개발중)
	 * 
	 * @author : 최현경
	 * @Date : 2018. 10. 25.
	 * @explain : 성과관리 -> 주간보고 selectWeeklyReportQuarter
	 */
	@RequestMapping(value = "/salesManagement/selectWeeklyReportQuarter.do")
	public ModelAndView selectWeeklyReportQuarter(CommandMap map) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName((String) map.get("jsp"));

		List<Map<String, Object>> weeklyReportQuarter = salesManagementService.selectWeeklyReportQuarter(map.getMap());
		mv.addObject("weeklyReportQuarter", weeklyReportQuarter);

		return mv;
	}
}