package com.uni.sellers.bizstrategy;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mobile.device.Device;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.uni.sellers.common.CommonDAO;
import com.uni.sellers.datasource.CommandMap;
import com.uni.sellers.util.CommonUtils;

@Controller
public class BizStrategyController {
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="bizStrategyService")
	private BizStrategyService bizStrategyService;
	
	@Resource(name="bizStrategyDAO")
	private BizStrategyDAO bizStrategyDAO;
	
	@Resource(name="commonDAO")
	private CommonDAO commonDAO;

	
	
	/**
	 * @author 	: 준이
	 * @Date		: 2017. 03. 17.
	 * @explain	: 사업전략 -> 회사 / 부문별 전략 -> 첫 페이지
	 */
	@RequestMapping(value="/bizStrategy/viewBizStrategyCompany.do")
	public ModelAndView viewBizStrategyCompany(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("/bizstrategy/bizStrategyOurCompanyList");
		
		map.put("strategy", "CO");
		//필요한 분류값
		List<Map<String,Object>> selectBizStrategyCategory = bizStrategyService.selectBizStrategyCategory(map.getMap());
		mv.addObject("bizStrategySearchDetailGroup",selectBizStrategyCategory);
		mv.addObject("strategy", "CO");
		
		if(!device.isNormal()) {

			if(map.get("searchCategory") != null && !map.get("searchCategory").equals("")) {
				map.put("detailCategory", map.get("searchCategory"));
			}
			else {
				map.put("detailCategory", "회사전략");
			}
			
			mv.addObject("map", map.getMap());

		}
		
		return mv;
	}
	
	/**
	 * @author 	: 준이
	 * @Date		: 2017. 03. 17.
	 * @explain	: 사업전략 -> 고객별 전략 -> 첫 페이지
	 */
	@RequestMapping(value="/bizStrategy/viewBizStrategyClient.do")
	public ModelAndView viewBizStrategyClient(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("/bizstrategy/bizStrategyClientCompanyList");
		map.put("strategy", "CL");
		
		if(device.isNormal()) {
			//필요한 분류값
			List<Map<String,Object>> selectBizStrategyCategory = bizStrategyService.selectBizStrategyCategory(map.getMap());
			mv.addObject("bizStrategySearchDetailGroup",selectBizStrategyCategory);
		}else {
			if(map.get("searchCategory") != null && !map.get("searchCategory").equals("")) {
				map.put("detailCategory", map.get("searchCategory"));
			}
			else {
				map.put("detailCategory", "고객전략");
			}
			
			mv.addObject("map", map.getMap());
		}
		
		mv.addObject("strategy","CL");
		return mv;
	}
	
	/**
	 * @author 	: 준이
	 * @Date		: 2017. 03. 17.
	 * @explain	: 사업전략 -> 회사 / 부문별 / 고객별 -> 리스트
	 */
	@RequestMapping(value="/bizStrategy/selectBizStrategyList.do")
	public ModelAndView selectBizStrategyList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String,Object>> selectBizStrategyList = bizStrategyService.selectBizStrategyList(map.getMap());
		mv.addObject("rows",selectBizStrategyList);
		return mv;
	}
	
	/**
	 * @author 	: 준이
	 * @Date		: 2017. 03. 17.
	 * @explain	: 사업전략 -> 회사 / 부문별 / 고객별 -> 카운트
	 */
	@RequestMapping(value="/bizStrategy/selectBizStrategyListCount.do")
	public ModelAndView selectBizStrategyListCount(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		Map<String,Object> countMap = bizStrategyDAO.selectBizStrategyListCount(map.getMap());
		String latelyUpdate = commonDAO.selectLatelyUpdate(map.getMap());
		//페이징이 처리
		String listCount =  countMap.get("listCount").toString();
		mv.addObject("listPaging", CommonUtils.pagingSum(map.getMap(),Integer.parseInt(listCount)));
		mv.addObject("listCount", countMap.get("listCount"));
		mv.addObject("searchPKArray", countMap.get("searchPKArray"));
		mv.addObject("latelyUpdate", latelyUpdate);
		return mv;
	}
	
	/**
	 * @author 	: 준이
	 * @Date		: 2017. 03. 17.
	 * @explain	: 사업전략 -> 회사 / 부문별 / 고객별 -> 상세보기
	 */
	@RequestMapping(value="/bizStrategy/selectBizStrategyDetail.do")
	public ModelAndView selectBizStrategyDetail(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		if (device.isMobile()) {
			log.info("************************************* 접속 기기 : Mobile");

			//ModelAndView mv = new ModelAndView("/bizstrategy/modalBizStrategy");
			mv.setViewName("/bizstrategy/modalBizStrategy");
			Map<String,Object> selectBizStrategyDetail = bizStrategyService.selectBizStrategyDetail(map.getMap());
			List<Map<String,Object>> selectBizStrategyFileList = bizStrategyDAO.selectBizStrategyFileList(map.getMap());
			//List<Map<String,Object>> selectBizStrategyMilestones = bizStrategyDAO.selectBizStrategyMilestones(map.getMap());

			map.put("hiddenModalPK", map.get("pkNo"));
			List<Map<String,Object>> selectBizStrategyIssueList = bizStrategyDAO.selectBizStrategyIssue(map.getMap());
			
			mv.addObject("detail", selectBizStrategyDetail);
			mv.addObject("fileList",selectBizStrategyFileList);
			mv.addObject("issueList", selectBizStrategyIssueList);
			
			mv.addObject("map", map.getMap());

			log.info("************************************* mv[" + mv.getViewName() + "]");
		}
		else {
			if(map.get("datatype").equals("html")){
				log.info((String)map.get("jsp"));
				mv.setViewName((String)map.get("jsp"));
			}else{
				mv.setViewName("jsonView");
			}
			
			Map<String,Object> selectBizStrategyDetail = bizStrategyService.selectBizStrategyDetail(map.getMap());
			List<Map<String,Object>> selectBizStrategyFileList = bizStrategyDAO.selectBizStrategyFileList(map.getMap());
			List<Map<String,Object>> selectBizStrategyMileStones = bizStrategyService.selectBizStrategyMileStones(map.getMap());
			
			mv.addObject("detail", selectBizStrategyDetail);
			mv.addObject("fileList",selectBizStrategyFileList);
			mv.addObject("milestonesList", selectBizStrategyMileStones);	
		}
		
		return mv;
	}
	
	/**
	 * @author 	: 준이
	 * @Date		: 2017. 03. 17.
	 * @explain	: 사업전략 -> 회사 / 부문별 / 고객별 -> 상세보기
	 */
	@RequestMapping(value="/bizStrategy/insertBizStrategy.do")
	public ModelAndView insertBizStrategy(HttpServletRequest request, CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = bizStrategyService.insertBizStrategy(request, map.getMap());
		mv.addObject("cnt",cnt);
		return mv;
	}
	
	
	/**
	 * @author 	: 준이
	 * @Date		: 2017. 03. 17.
	 * @explain	: 사업전략 -> 회사 / 부문별 / 고객별 -> 상세보기
	 */
	@RequestMapping(value="/bizStrategy/updateBizStrategy.do")
	public ModelAndView updateBizStrategy(HttpServletRequest request, CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = bizStrategyService.updateBizStrategy(request, map.getMap());
		mv.addObject("cnt",cnt);
		return mv;
	}
	
	
	/**
	 * @author 	: 준이
	 * @Date		: 2017. 03. 17.
	 * @explain	: 사업전략 -> 회사 / 부문별 / 고객별 -> 상세보기 마일스톤
	 */
	@RequestMapping(value="/bizStrategy/selectBizStrategyMileStones.do")
	public ModelAndView selectBizStrategyMileStones(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		//List<Map<String,Object>> selectBizStrategyMileStonesList = bizStrategyService.selectMileStonesBizStrategyList(map.getMap());
		List<Map<String,Object>> selectBizStrategyMileStones = bizStrategyService.selectBizStrategyMileStones(map.getMap());
		mv.addObject("rows", selectBizStrategyMileStones);		
		return mv;
	}
	
	
	/**
	 * @author 	: 준이
	 * @Date		: 2017. 03. 17.
	 * @explain	: 사업전략 -> 회사 / 부문별 / 고객별 -> 상세보기 이슈
	 */
	@RequestMapping(value="/bizStrategy/selectBizStrategyIssue.do")
	public ModelAndView selectBizStrategyIssue(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String, Object>> list = bizStrategyService.selectBizStrategyIssue(map.getMap());
		mv.addObject("rows", list);
		return mv;
	}
	
	/**
	 * @author 	: 준이
	 * @Date		: 2017. 03. 17.
	 * @explain	: 사업전략 -> 회사 / 부문별 / 고객별 -> 이슈 삭제
	 */
	@RequestMapping(value="/bizStrategy/deleteBizStrategyIssue.do")
	public ModelAndView deleteBizStrategyIssue(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = bizStrategyService.deleteBizStrategyIssue(map.getMap());
		mv.addObject("cnt" , cnt);
		return mv;
	}
	
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 10. 24.
	 * @explain	: 사업전략 -> 전략 프로젝트 -> 첫 페이지 
	 */
	@RequestMapping(value="/bizStrategy/viewBizStrategyProjectPlan.do")
	public ModelAndView viewBizStrategyProjectPlan(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("/bizstrategy/bizStrategyProjectPlan");
		
		if (device.isMobile()) {
			log.info("************************************* 접속 기기 : Mobile");
			
			if(map.get("searchCategory") != null && !map.get("searchCategory").equals("")) {
				map.put("searchCategory", map.get("searchCategory"));
			}
			else {
				map.put("searchCategory", "1");
			}
			
			mv.addObject("map", map.getMap());
			
			Map<String,Object> countMap = bizStrategyDAO.selectProjectPlanListCount(map.getMap()); 
			mv.addObject("totalCnt", countMap.get("listCount"));
			
//			//String latelyUpdate = bizStrategyDAO.selectProjectPlanLatelyUpdate(map.getMap());
//			mv.addObject("listCount", countMap.get("listCount"));
//			mv.addObject("searchPKArray", countMap.get("searchPKArray"));
//			//mv.addObject("latelyUpdate", latelyUpdate);
			
			log.info("************************************* mv[" + mv.getViewName() + "]");
		}
		
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 10. 24.
	 * @explain	: 사업전략 -> 전략 프로젝트 -> 리스트
	 */
	@RequestMapping(value="/bizStrategy/selectProjectPlanList.do")
	public ModelAndView selectProjectPlanList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String,Object>> projectPlanList = bizStrategyService.selectProjectPlanList(map.getMap());
		mv.addObject("rows",projectPlanList);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 8. 3.
	 * @explain	: 사업전략 -> 전략 프로젝트 리스트 카운트
	 */
	@RequestMapping(value="/bizStrategy/selectProjectPlanCount.do")
	public ModelAndView selectProjectPlanCount(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		Map<String,Object> countMap = bizStrategyDAO.selectProjectPlanListCount(map.getMap());
		String latelyUpdate = commonDAO.selectLatelyUpdate(map.getMap());
		
		if(device.isNormal()) {
			//페이징이 처리
			String listCount =  countMap.get("listCount").toString();
			mv.addObject("listPaging", CommonUtils.pagingSum(map.getMap(),Integer.parseInt(listCount)));
		}else {
			
		}
		mv.addObject("listCount", countMap.get("listCount"));
		mv.addObject("searchPKArray", countMap.get("searchPKArray"));
		mv.addObject("latelyUpdate", latelyUpdate);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 10. 24.
	 * @explain	: 사업전략 -> 전략 프로젝트 -> 본부별 합계
	 */
	@RequestMapping(value="/bizStrategy/selectProjectPlanSum.do")
	public ModelAndView selectProjectPlanSum(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		Map<String,Object> selectProjectPlanSum = bizStrategyDAO.selectProjectPlanSum(map.getMap());
		mv.addObject("selectProjectPlanSum", selectProjectPlanSum);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 10. 24.
	 * @explain	: 사업전략 -> 전략 프로젝트 -> 매출현황
	 */
	@RequestMapping(value="/bizStrategy/selectProjectPlanInfo.do")
	public ModelAndView selectProjectPlan(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		Map<String,Object> selectProjectPlanInfo = bizStrategyService.selectProjectPlanInfo(map.getMap());
		mv.addObject("selectProjectPlanContractInfo",selectProjectPlanInfo.get("selectProjectPlanContractInfo"));
		mv.addObject("selectProjectPlanInvestInfo",selectProjectPlanInfo.get("selectProjectPlanInvestInfo"));
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 8. 3.
	 * @explain	: 사업전략 -> 전략 프로젝트 -> 상세보기
	 */
	@RequestMapping(value="/bizStrategy/selectProjectPlanDetail.do")
	public ModelAndView selectProjectPlanDetail(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		Map<String,Object> selectProjectPlanDetail = bizStrategyService.selectProjectPlanDetail(map.getMap());
		List<Map<String,Object>> selectProjectPlanFileList = bizStrategyDAO.selectProjectPlanFileList(map.getMap());
		List<Map<String,Object>> selectProjectPlanOpportunityList = bizStrategyDAO.selectProjectPlanOpportunityList(map.getMap());
		List<Map<String,Object>> selectMileStonesProjectPlanList = bizStrategyService.selectMileStonesProjectPlanList(map.getMap());
		
		mv.addObject("oppList", selectProjectPlanOpportunityList);
		mv.addObject("detail", selectProjectPlanDetail);
		mv.addObject("fileList",selectProjectPlanFileList);
		mv.addObject("milestonesList", selectMileStonesProjectPlanList);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 8. 3.
	 * @explain	: 사업전략 -> 전략 프로젝트 -> 부서별
	 */
	@RequestMapping(value="/bizStrategy/selectProjectPlanDivision.do")
	public ModelAndView selectProjectPlanDivision(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		Map<String,Object> searchDetailGroup = bizStrategyService.selectSearchProjectPlanDetailGroup(map.getMap());
		mv.addObject("searchDetailGroup", searchDetailGroup);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 8. 3.
	 * @explain	: 사업전략 -> 전략 프로젝트 -> 입력
	 */
	@RequestMapping(value="/bizStrategy/insertProjectPlan.do")
	public ModelAndView insertProjectPlan(HttpServletRequest request, CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = bizStrategyService.insertProjectPlan(request, map.getMap());
		mv.addObject("cnt",cnt);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 8. 3.
	 * @explain	: 사업전략 -> 전략 프로젝트 -> 수정
	 */
	@RequestMapping(value="/bizStrategy/updateProjectPlan.do")
	public ModelAndView updateProjectPlan(HttpServletRequest request, CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = bizStrategyService.updateProjectPlan(request, map.getMap());
		mv.addObject("cnt",cnt);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 8. 3.
	 * @explain	: 사업전략 -> 전략 프로젝트 -> 마일스톤 리스트
	 */
	@RequestMapping(value="/bizStrategy/selectMileStonesProjectPlanList.do")
	public ModelAndView selectMileStonesProjectPlanList(CommandMap map) throws Exception{ 
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String,Object>> selectMileStonesProjectPlanList = bizStrategyService.selectMileStonesProjectPlanList(map.getMap());
		mv.addObject("rows", selectMileStonesProjectPlanList);		
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 8. 3.
	 * @explain	: 사업전략 -> 전략 프로젝트 -> 마일스톤 입력
	 */
	@RequestMapping(value="/bizStrategy/insertMileStonesProjectPlanList.do")
	public ModelAndView insertMileStonesProjectPlanList(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = bizStrategyService.insertMileStonesProjectPlanList(map.getMap());
		mv.addObject("cnt" , cnt);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 8. 3.
	 * @explain	: 사업전략 -> 전략 프로젝트 -> 마일스톤 삭제
	 */
	@RequestMapping(value="/bizStrategy/deleteProjectPlan.do")
	public ModelAndView deleteProjectPlan(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = bizStrategyService.deleteProjectPlan(map.getMap(), request);
		mv.addObject("cnt" , cnt);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 8. 3.
	 * @explain	: 사업전략 -> 전략 프로젝트 -> 이슈 리스트
	 */
	@RequestMapping(value="/bizStrategy/selectProjectPlanIssue.do")
	public ModelAndView selectProjectPlanIssue(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String, Object>> list = bizStrategyService.selectProjectPlanIssue(map.getMap());
		mv.addObject("rows", list);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 8. 3.
	 * @explain	: 사업전략 -> 전략 프로젝트 -> 이슈 입력
	 */
	@RequestMapping(value="/bizStrategy/insertProjectPlanIssue.do")
	public ModelAndView insertProjectPlanIssue(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = bizStrategyService.insertProjectPlanIssue(map.getMap());
		mv.addObject("cnt" , cnt);
		return mv;
	}
	
	@RequestMapping(value="/bizStrategy/deleteProjectPlanActionPlan.do")
	public ModelAndView deleteProjectPlanActionPlan(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = bizStrategyService.deleteProjectPlanActionPlan(map.getMap());
		mv.addObject("cnt" , cnt);
		return mv;
	}

	
	//mobile
	@RequestMapping(value="/bizStrategy/countBizStrategyCompany.do")
	public ModelAndView countBizStrategyCompany(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		
		mv.addObject("totalCnt", bizStrategyService.selectBizStrategyCountMobile(map.getMap()));

		return mv;
	}
	
	@RequestMapping(value="/bizStrategy/gridBizStrategyList.do")
	public ModelAndView gridBizStrategyList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		//map.put("strategy", "biz");
		List<Map<String,Object>> bizStrategyList = bizStrategyService.selectBizStrategyListMobile(map.getMap());
		mv.addObject("row_count", bizStrategyList.size());
		mv.addObject("rows",bizStrategyList);
		
//		List<Map<String,Object>> selectBizStrategyList = bizStrategyService.selectBizStrategyList(map.getMap());
//		mv.addObject("row_count", selectBizStrategyList.size());
//		mv.addObject("rows",selectBizStrategyList);
		
		return mv;
	}
	
	@RequestMapping(value="/bizStrategy/gridMileStonesBizStrategyList.do")
	public ModelAndView gridMileStonesBizStrategyList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> mileStonesbizStrategy = bizStrategyService.gridMileStonesBizStrategyList(map.getMap());
		mv.addObject("rows", mileStonesbizStrategy);
		return mv;
	}
	
	/**
	 * @author 	: 재훈
	 * @Date		: 2017. 6. 23.
	 * @explain	: 사업전략 -> 전략 프로젝트 -> 리스트
	 */
	@RequestMapping(value="/bizStrategy/gridProjectPlanList.do")
	public ModelAndView gridProjectPlanList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> projectPlanList = bizStrategyService.selectProjectPlanListMobile(map.getMap());
		mv.addObject("projectPlanListCount", projectPlanList.size());
		mv.addObject("rows",projectPlanList);
		return mv;
	}
	
	/**
	 * @author 	: 재훈
	 * @Date		: 2017. 6. 23.
	 * @explain	: 사업전략 -> 전략 프로젝트 -> 상세
	 */
	@RequestMapping(value="/bizStrategy/modalProjectPlanInfo.do")
	public ModelAndView modalProjectPlan(CommandMap map) throws Exception{
		//ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView("/bizstrategy/modalProjectPlan");
		
		map.put("pkNo", map.get("project_id"));
		
		mv.addObject("detail", bizStrategyService.selectProjectPlanDetail(map.getMap()));
		Map<String,Object> selectProjectPlanInfo = bizStrategyService.selectProjectPlanInfo(map.getMap());
		mv.addObject("selectProjectPlanContractInfo",selectProjectPlanInfo.get("selectProjectPlanContractInfo"));
		mv.addObject("selectProjectPlanInvestInfo",selectProjectPlanInfo.get("selectProjectPlanInvestInfo"));
		
		//키마일스톤
		List<Map<String,Object>> mileStonesProjectPlan = bizStrategyService.gridMileStonesProjectPlanList(map.getMap());
		mv.addObject("rows", mileStonesProjectPlan);
		
		//첨부파일
		List<Map<String,Object>> selectProjectPlanFileList = bizStrategyDAO.selectProjectPlanFileList(map.getMap());
		mv.addObject("fileList",selectProjectPlanFileList);
		
		//이슈
		//List<Map<String,Object>> selectProjectPlanIssueList = bizStrategyDAO.selectProjectPlanIssueList(map.getMap());
		map.put("hiddenModalPK", map.get("project_id"));
		List<Map<String,Object>> selectProjectPlanIssueList = bizStrategyDAO.selectProjectPlanIssue(map.getMap());
		mv.addObject("issueList",selectProjectPlanIssueList);
		
		return mv;
	}
	
	@RequestMapping(value="/bizStrategy/viewBizStrategyClientCountMobile.do")
	public ModelAndView viewBizStrategyClientCountMobile(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		map.put("strategy", "CL");
		
//			map.put("strategy", "CO");
//			List<Map<String,Object>> bizStrategySearchDetailGroup = bizStrategyService.selectBizStrategyCategory(map.getMap());
//			mv.addObject("bizStrategySearchDetailGroup",bizStrategySearchDetailGroup);

		//map.put("detailCategory", "고객전략");
		mv.addObject("totalCnt", bizStrategyService.selectBizStrategyCountMobile(map.getMap()));
	
		mv.addObject("strategy","CL");
		return mv;
	}
}