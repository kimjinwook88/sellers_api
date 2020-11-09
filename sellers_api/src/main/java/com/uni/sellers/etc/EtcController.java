package com.uni.sellers.etc;

import java.sql.*;
import java.util.HashMap;
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


@Controller
public class EtcController {
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="etcService")
	private EtcService etcService;
	
	@Resource(name="etcDAO")
	private EtcDAO etcDAO;
	
	@Resource(name="commonDAO")
	private CommonDAO commonDAO;
	
	/**
	 * @author 	: 훈이
	 * @Date	: 2017. 9. 25.
	 * @explain	: 고도뤼~ 대시보드 
	 */
	@RequestMapping(value="/etc/viewClientGodoryDashBoard.do")
	public ModelAndView viewClientGodoryDashBoard(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		mv = new ModelAndView("/etc/clientGodoryDashBoard");
		
		return mv;
	}
	
	/**
	 * @author 	: 훈이
	 * @Date	: 2017. 9. 25.
	 * @explain	: 고도뤼~ -> 고도뤼 대시보드 본부
	 */
	@RequestMapping(value="/etc/selectGodoryDashBoardDivision.do")
	public ModelAndView selectGodoryDashBoardDivision(CommandMap map) throws Exception{
		ModelAndView mv = null;
		if(map.getMap().get("datatype").equals("html"))
		{
			mv = new ModelAndView((String) map.getMap().get("jsp"));
		}
		else if(map.getMap().get("datatype").equals("json"))
		{
			mv = new ModelAndView("jsonView");
		}
		
		List<Map<String,Object>> selectClientIssueDashBoardDivision= etcDAO.selectClientGodoryDashBoardDivision(map.getMap());
		mv.addObject("selectClientIssueDashBoardDivision", selectClientIssueDashBoardDivision);
		
		return mv;
	}
	
	/**
	 * @author 	: 훈이
	 * @Date	: 2017. 9. 25.
	 * @explain	: 고도뤼~ -> 고도뤼 대시보드 팀
	 */
	@RequestMapping(value="/etc/selectGodoryDashBoardTeam.do")
	public ModelAndView selectGodoryDashBoardTeam(CommandMap map) throws Exception{
		ModelAndView mv = null;
		if(map.getMap().get("datatype").equals("html"))
		{
			mv = new ModelAndView((String) map.getMap().get("jsp"));
		}
		else if(map.getMap().get("datatype").equals("json"))
		{
			mv = new ModelAndView("jsonView");
		}
		List<Map<String,Object>> selectClientIssueDashBoardTeam= etcDAO.selectGodoryDashBoardTeam(map.getMap());
		mv.addObject("selectClientIssueDashBoardTeam", selectClientIssueDashBoardTeam);
		return mv;
	}
	
	
	/**
	 * @author 	: 훈이
	 * @Date	: 2017. 3. 15.
	 * @explain	: 고도뤼~ -> 고도뤼 대시보드 멤버
	 */
	@RequestMapping(value="/etc/selectGodoryDashBoardMember.do")
	public ModelAndView selectGodoryDashBoardMember(CommandMap map) throws Exception{
		ModelAndView mv = null;
		if(map.getMap().get("datatype").equals("html"))
		{
			mv = new ModelAndView((String) map.getMap().get("jsp"));
		}
		else if(map.getMap().get("datatype").equals("json"))
		{
			mv = new ModelAndView("jsonView");
		}
		List<Map<String,Object>> selectClientIssueDashBoardMember= etcDAO.selectGodoryDashBoardMember(map.getMap());
		mv.addObject("selectClientIssueDashBoardMember", selectClientIssueDashBoardMember);
		return mv;
	}
	
	/**
	 * @author 	: 훈이
	 * @Date		: 2017. 9. 25.
	 * @explain	: 고도뤼~ -> 리스트 첫 페이지
	 */
	@RequestMapping(value="/etc/viewGodoryList.do")
	public ModelAndView viewGodoryList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/etc/clientGodoryList");
		
		/*
		Map<String,Object> searchDetailGroup = clientSatisfactionService.selectClientIssue(map.getMap());
		mv.addObject("searchDetailGroup", searchDetailGroup);
		*/
		return mv;
	}
	
	/**
	 * @author 	: 훈이
	 * @Date		: 2017. 09. 25.
	 * @explain	: 영업관리 -> 고도리~ 카운트
	 */
	@RequestMapping(value="/etc/selectGodoryListCount.do")
	public ModelAndView selectGodoryListCount(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		Map<String, Object> countMap = etcDAO.selectGodoryCount(map.getMap());
		String latelyUpdate = commonDAO.selectLatelyUpdate(map.getMap());
		mv.addObject("listCount", countMap.get("listCount"));
		mv.addObject("searchPKArray", countMap.get("searchPKArray"));
		mv.addObject("latelyUpdate", latelyUpdate);
		return mv;
	}
	
	/**
	 * @author 	: 훈이
	 * @Date		: 2017.09. 25.
	 * @explain	: 영업활동 -> 고도뤼~ 리스트
	 */
	@RequestMapping(value="/etc/selectGodoryList.do")
	public ModelAndView selectGodoryList(CommandMap map, Device device) throws Exception{
		//ModelAndView mv = new ModelAndView("/etc/clientGodoryListAjax");
		
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String,Object>> gridGodory= etcDAO.selectGodoryList(map.getMap());
		mv.addObject("rows", gridGodory);
		
		if (device.isMobile()) {
		    log.info("************************************* 접속 기기 : Mobile");
		    //mv.setViewName("jsonView");
		}
		return mv;
	}
	
	/**
	 * @author 	: 봉준
	 * @Date		: 2017.12. 11.
	 * @explain	: 고도리 담당자 검색
	 */
	@RequestMapping(value="/etc/selectGodoryManager.do")
	public ModelAndView selectGodoryManager(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String,Object>> gridGodory= etcDAO.selectGodoryManager(map.getMap());
		mv.addObject("rows", gridGodory);
		
		return mv;
	}
	
	/**
	 * @author 	: 훈이
	 * @Date		: 2017. 01. 31.
	 * @explain	: 고객만족 -> 고도리~ 리스트 상세보기
	 */
	@RequestMapping(value="/etc/selectGodoryDetail.do")
	public ModelAndView selectGodoryDetail(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		Map<String,Object> selectIssueDetail = etcDAO.selectGodoryDetail(map.getMap());
		//List<Map<String,Object>> selectIssueFileList = clientSatisfactionDAO.selectClientIssueFileList(map.getMap());
		mv.addObject("detail", selectIssueDetail);
		//mv.addObject("fileList",selectIssueFileList);
		
        if (device.isMobile()) {
            log.info("************************************* 접속 기기 : Mobile");
            if (map.get("datatype")==null) {
                mv.setViewName("/etc/selectGodoryDetail");
            }
            log.info("************************************* mv[" + mv.getViewName() + "]");
        }	    
	
        return mv;
	}
	
	/**
	 * @author 	: 재훈
	 * @Date		: 2017. 10. 27.
	 * @explain	: 고객만족 -> 고도리~ 모바일 등록, 수정
	 */
	@RequestMapping(value="/etc/formGodoryDetail.do")
	public ModelAndView formGodoryDetail(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("/etc/formGodoryDetail");
		Map<String,Object> selectIssueDetail = etcDAO.selectGodoryDetail(map.getMap());
		//List<Map<String,Object>> selectIssueFileList = clientSatisfactionDAO.selectClientIssueFileList(map.getMap());
		mv.addObject("detail", selectIssueDetail);
		//mv.addObject("fileList",selectIssueFileList);
		
		return mv;
	}
	
	/**
	 * @author 	: 훈이
	 * @Date		: 2016. 09. 22.
	 * @explain	: 영업활동 -> 고도리 gridSolvePlanIssue
	 */
	@RequestMapping(value="/etc/selectSolvePlanIssue.do")
	public ModelAndView selectSolvePlanIssue(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> gridSolvePlanIssue = etcDAO.selectSolvePlanIssue(map.getMap());
		mv.addObject("rows" , gridSolvePlanIssue);
		return mv;
	}
	
	/**
	 * @author 	: 훈이
	 * @Date		: 2017. 09. 26.
	 * @explain	: 영업활동 -> 고도리~ insert
	 */
	@RequestMapping(value="/etc/insertClientGodory.do")
	public ModelAndView insertClientGodory(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = etcService.insertClientGodory(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}
	
	/**
	 * @author 	: 훈이
	 * @Date		: 2016. 6. 7.
	 * @explain	: 영업활동 -> 고객이슈 update
	 */
	@RequestMapping(value="/etc/updateClientGodory.do")
	public ModelAndView updateClientGodory(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = etcService.updateClientGodory(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}
	
	
	////////////////////////////////////////////////////////////////////////////////////
	//ceo 체크리스트
	@RequestMapping(value="/etc/viewCeoOnHandList.do")
	public ModelAndView viewCeoOnHandList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/etc/ceoOnHandList");
		return mv;
	}
	
	/**
	* @author 	: 훈이
	* @Date		: 2016. 6. 4.
	* @explain	: 영업활동 -> 영업기회 리스트 카운트
	*/
	@RequestMapping(value="/etc/selectCeoOnHandListCount.do")
	public ModelAndView selectCeoOnHandListCount(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		/*
		Map<String,Object> countMap = clientSalesActiveDAO.selectOpportunityCount(map.getMap());
		String latelyUpdate = commonDAO.selectLatelyUpdate(map.getMap());
		mv.addObject("listCount", countMap.get("listCount"));
		mv.addObject("searchPKArray", countMap.get("searchPKArray"));
		mv.addObject("latelyUpdate", latelyUpdate);
		*/
	return mv;
	}
	
	/**
	* @author 	: 훈이
	* @Date		: 2016. 6. 4.
	* @explain	: 영업활동 -> 영업기회 그리드
	*/
	@RequestMapping(value="/etc/selectCeoOnHandList.do")
	public ModelAndView selectCeoOnHandList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		List<Map<String, Object>> gridOpportunity= etcService.gridCeoOnHand(map.getMap());
		mv.addObject("rows", gridOpportunity);
	return mv;
	}
	
	@RequestMapping(value="/etc/selectCeoOnHandMilestons.do")
	public ModelAndView selectCeoOnHandMilestons(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> list = etcDAO.selectCeoOnHandMilestons(map.getMap());
		mv.addObject("rows", list);
	return mv;
	}
	
	/**
	* @author 	: 훈이
	* @Date		: 2016. 6. 7.
	* @explain	: 영업활동 -> 영업기회 insert
	*/
	@RequestMapping(value="/etc/insertCeoOnHand.do")
	public ModelAndView insertCeoOnHand(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		
		int cnt = etcService.insertCeoOnHand(map.getMap(), request);
		mv.addObject("cnt", cnt);
	return mv;
	}
	
	@RequestMapping(value = "/etc/updateCeoOnHand.do")
	public ModelAndView updateCeoOnHand(CommandMap map, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");
		
		int cnt = etcService.updateCeoOnHand(map.getMap(), request);
		mv.addObject("cnt", cnt);
	return mv;
	}
	
	/**
	* @author 	: 훈이
	* @Date		: 2016. 8. 3.
	* @explain	: 사업전략 -> 전략 프로젝트 상세정보
	*/
	@RequestMapping(value="/etc/selectCeoOnHandDetail.do")
	public ModelAndView selectCeoOnHandDetail(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		Map<String,Object> selectOpportunityDetail = etcDAO.selectCeoOnHandDetail(map.getMap());
		mv.addObject("detail", selectOpportunityDetail);
		
        if (device.isMobile()) {
            log.info("************************************* 접속 기기 : Mobile");
            if (map.get("datatype")==null) {
                mv.setViewName("/kyungnong/selectCeoOnHandDetail");
            }
            log.info("************************************* mv[" + mv.getViewName() + "]");
        }       
		
	return mv;
	}
	
	/**
	* @author 	: 재훈
	* @Date		: 2017. 10. 25.
	* @explain	: CEO Check List 등록,수정 폼(모바일)
	*/
	@RequestMapping(value="/etc/formCeoOnHandDetail.do")
	public ModelAndView formCeoOnHandDetail(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		Map<String,Object> selectOpportunityDetail = etcDAO.selectCeoOnHandDetail(map.getMap());
		mv.addObject("detail", selectOpportunityDetail);
		
		if (device.isMobile()) {
			log.info("************************************* 접속 기기 : Mobile");
			if (map.get("datatype")==null) {
				mv.setViewName("/etc/formCeoOnHandDetail");
			}
			log.info("************************************* mv[" + mv.getViewName() + "]");
		}
		
		return mv;
	}
	
}
