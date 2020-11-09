package com.uni.sellers.clientsatisfaction;

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
import com.uni.sellers.util.CommonUtils;

@Controller
public class ClientSatisfactionController {
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name="clientSatisfactionService")
	private ClientSatisfactionService clientSatisfactionService;

	@Resource(name="clientSatisfactionDAO")
	private ClientSatisfactionDAO clientSatisfactionDAO;

	@Resource(name="commonDAO")
	private CommonDAO commonDAO;


	//////////////////////////// 셀러스 유니버전 작업 //////////////////////////

	/**
	 * @author 	: 훈이
	 * @Date	: 2017. 3. 15.
	 * @explain	: 고객만족 -> 고객이슈 대시보드
	 */
	@RequestMapping(value="/clientSatisfaction/viewClientIssueDashBoard.do")
	public ModelAndView viewClientIssueDashBoard(CommandMap map) throws Exception{
		//ModelAndView mv = new ModelAndView("/clientSatisfaction/clientIssueDashBoard");

		ModelAndView mv = null;
		if(map.getMap().get("tabFlag") == null 
				|| map.getMap().get("tabFlag").equals("")
				|| map.getMap().get("tabFlag").equals("individual")) 
		{
			// 영업대표별 탭 화면
			mv = new ModelAndView("/clientSatisfaction/clientIssueIndividualDashBoard");
		}else if(map.getMap().get("tabFlag").equals("clientCompany"))
		{
			//고객사별 탭 화면
			mv = new ModelAndView("/clientSatisfaction/clientIssueCompanyDashBoard");
		}

		return mv;
	}

	/**
	 * @author 	: 훈이
	 * @Date	: 2017. 3. 15.
	 * @explain	: 고객만족 -> 고객이슈 대시보드 본부
	 */
	@RequestMapping(value="/clientSatisfaction/selectClientIssueDashBoardDivision.do")
	public ModelAndView selectClientIssueDashBoardDivision(CommandMap map) throws Exception{
		ModelAndView mv = null;
		if(map.getMap().get("datatype").equals("html"))
		{
			mv = new ModelAndView((String) map.getMap().get("jsp"));
		}
		else if(map.getMap().get("datatype").equals("json"))
		{
			mv = new ModelAndView("jsonView");
		}
		List<Map<String,Object>> selectClientIssueDashBoardDivision= clientSatisfactionDAO.selectClientIssueDashBoardDivision(map.getMap());
		mv.addObject("selectClientIssueDashBoardDivision", selectClientIssueDashBoardDivision);
		return mv;
	}

	/**
	 * @author 	: 훈이
	 * @Date	: 2017. 3. 15.
	 * @explain	: 고객만족 -> 고객이슈 대시보드 팀
	 */
	@RequestMapping(value="/clientSatisfaction/selectClientIssueDashBoardTeam.do")
	public ModelAndView selectClientIssueDashBoardTeam(CommandMap map) throws Exception{
		ModelAndView mv = null;
		if(map.getMap().get("datatype").equals("html"))
		{
			mv = new ModelAndView((String) map.getMap().get("jsp"));
		}
		else if(map.getMap().get("datatype").equals("json"))
		{
			mv = new ModelAndView("jsonView");
		}
		List<Map<String,Object>> selectClientIssueDashBoardTeam= clientSatisfactionDAO.selectClientIssueDashBoardTeam(map.getMap());
		mv.addObject("selectClientIssueDashBoardTeam", selectClientIssueDashBoardTeam);
		return mv;
	}

	/**
	 * @author 	: 훈이
	 * @Date	: 2017. 3. 15.
	 * @explain	: 고객만족 -> 고객이슈 대시보드 멤버
	 */
	@RequestMapping(value="/clientSatisfaction/selectClientIssueDashBoardMember.do")
	public ModelAndView selectClientIssueDashBoardMember(CommandMap map) throws Exception{
		ModelAndView mv = null;
		if(map.getMap().get("datatype").equals("html"))
		{
			mv = new ModelAndView((String) map.getMap().get("jsp"));
		}
		else if(map.getMap().get("datatype").equals("json"))
		{
			mv = new ModelAndView("jsonView");
		}
		List<Map<String,Object>> selectClientIssueDashBoardMember= clientSatisfactionDAO.selectClientIssueDashBoardMember(map.getMap());
		mv.addObject("selectClientIssueDashBoardMember", selectClientIssueDashBoardMember);
		return mv;
	}


	/**
	 * @author 	: 훈이
	 * @Date		: 2016. 6. 4.
	 * @explain	: 영업활동 -> 고객이슈 리스트 첫 페이지
	 */
	@RequestMapping(value="/clientSatisfaction/viewClientIssueList.do")
	public ModelAndView viewClientIssueList(CommandMap map, Device device)throws Exception{
		ModelAndView mv = new ModelAndView("/clientSatisfaction/clientIssueList");
		Map<String,Object> searchDetailGroup = clientSatisfactionService.selectClientIssue(map.getMap());
		mv.addObject("searchDetailGroup", searchDetailGroup);		
		return mv;
	}


	/**
	 * @author 	: 훈이
	 * @Date		: 2016. 08. 22.
	 * @explain	: 영업관리 -> 고객이슈 카운트
	 */
	@RequestMapping(value="/clientSatisfaction/selectIssueListCount.do")
	public ModelAndView selectIssueListCount(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		
		if(!device.isNormal()){
			map.put("deivceCheck", "mobile");
		}
		
		Map<String, Object> countMap = clientSatisfactionDAO.selectIssueCount(map.getMap());
		String latelyUpdate = commonDAO.selectLatelyUpdate(map.getMap());
		
		if(device.isNormal()) {
			//페이징이 처리
			String listCount =  countMap.get("listCount").toString();
			mv.addObject("listPaging", CommonUtils.pagingSum(map.getMap(),Integer.parseInt(listCount)));
		}else {
			mv.addObject("searchNoArray", countMap.get("searchNoArray"));
			mv.addObject("searchNameArray", countMap.get("searchNameArray"));
		}
		
		mv.addObject("listCount", countMap.get("listCount"));
		mv.addObject("searchPKArray", countMap.get("searchPKArray"));
		mv.addObject("latelyUpdate", latelyUpdate);
		return mv;
	}

	/**
	 * @author 	: 훈이
	 * @Date		: 2016. 6. 4.
	 * @explain	: 영업활동 -> 고객이슈 리스트
	 */
	@RequestMapping(value="/clientSatisfaction/selectClientIssueList.do")
	public ModelAndView selectClientIssueList(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("/clientSatisfaction/clientIssueListAjax");
		
		if (!device.isNormal()) {		   
		    mv.setViewName("jsonView");
		    map.put("deivceCheck", "mobile");
		}
		
		List<Map<String,Object>> gridClientIssue= clientSatisfactionService.selectClientIssueList(map.getMap());
		mv.addObject("rows", gridClientIssue);
				
		return mv;
	}

	/**
	 * @author 	: 훈이
	 * @Date		: 2016. 09. 22.
	 * @explain	: 영업활동 -> 고객이슈 gridSolvePlanIssue
	 */
	@RequestMapping(value="/clientSatisfaction/selectSolvePlanIssue.do")
	public ModelAndView selectSolvePlanIssue(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> gridSolvePlanIssue = clientSatisfactionDAO.selectSolvePlanIssue(map.getMap());
		mv.addObject("rows" , gridSolvePlanIssue);
		return mv;
	}


	/**
	 * @author 	: 훈이
	 * @Date		: 2016. 6. 7.
	 * @explain	: 영업활동 -> 고객이슈 insert
	 */
	@RequestMapping(value="/clientSatisfaction/insertClientIssue.do")
	public ModelAndView insertClientIssue(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		Map<String,Object> getMap = clientSatisfactionService.insertClientIssue(map.getMap(), request);
		mv.addObject("cnt", getMap.get("cnt"));
		mv.addObject("returnPK", getMap.get("filePK"));
		return mv;
	}


	/**
	 * @author 	: 훈이
	 * @Date		: 2017. 01. 31.
	 * @explain	: 고객만족 -> 이슈 리스트 상세보기
	 */
	@RequestMapping(value="/clientSatisfaction/selectClientIssueDetail.do")
	public ModelAndView selectClientIssueDetail(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		Map<String,Object> selectIssueDetail = clientSatisfactionService.selectClientIssueDetail(map.getMap());
		List<Map<String,Object>> selectIssueFileList = clientSatisfactionDAO.selectClientIssueFileList(map.getMap());
		mv.addObject("detail", selectIssueDetail);
		mv.addObject("fileList",selectIssueFileList);
		
        if (device.isMobile()) {
            log.info("************************************* 접속 기기 : Mobile");
            List<Map<String,Object>> selectSolvePlanList = clientSatisfactionDAO.selectSolvePlanIssue(map.getMap());
    		mv.addObject("planList" , selectSolvePlanList);
            if (map.get("datatype")==null) {
                mv.setViewName("/clientSatisfaction/clientIssueDetail");
            }
            log.info("************************************* mv[" + mv.getViewName() + "]");
        }	    
		return mv;
	}


	/**
	 * @author 	: 훈이
	 * @Date		: 2016. 6. 7.
	 * @explain	: 영업활동 -> 고객이슈 update
	 */
	@RequestMapping(value="/clientSatisfaction/updateClientIssue.do")
	public ModelAndView updateClientIssue(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = clientSatisfactionService.updateClientIssue(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}

	/**
	 * @author 	: 훈이
	 * @Date		: 2016. 6. 7.
	 * @explain	: 고객만족 -> 이슈 대시보드 고객사별 Ajax
	 */
	@RequestMapping(value="/clientSatisfaction/selectClientIssueCompanyDashBoard.do")
	public ModelAndView selectClientIssueCompanyDashBoard(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/clientSatisfaction/clientIssueCompanyDashBoardGroupAjax");

		List<Map<String,Object>> selectClientIssueCompanyDashBoardDep1= clientSatisfactionDAO.selectClientIssueCompanyDashBoard(map.getMap());
		mv.addObject("selectClientIssueCompanyDashBoardDep1", selectClientIssueCompanyDashBoardDep1);
		return mv;
	}


	@RequestMapping(value="/clientSatisfaction/selectClientIssueCompany.do")
	public ModelAndView selectClientIssueCompany(CommandMap map) throws Exception{

		ModelAndView mv = new ModelAndView("/clientSatisfaction/clientIssueCompanyDashBoardAjax");

		List<Map<String,Object>> selectClientIssueCompanyDashBoardDep2= clientSatisfactionDAO.selectClientIssueCompany(map.getMap());
		mv.addObject("selectClientIssueCompanyDashBoardDep2", selectClientIssueCompanyDashBoardDep2);
		return mv;
	}

    /**
     * @author  : 민성기
     * @Date    : 2017. 4. 7.
     * @explain : 영업활동 -> 고객컨택 등록/수정 폼으로 이동
     */
    @RequestMapping(value="/clientSatisfaction/clientIssueInsertForm.do")
    public ModelAndView clientIssueInsertForm(CommandMap map, HttpServletRequest request) throws Exception{
        ModelAndView mv = new ModelAndView("clientSatisfaction/clientIssueInsertForm");
        mv.addObject("mode", map.get("mode"));
        mv.addObject("pkNo", map.get("pkNo"));
        return mv;
    }       

	//////////////////////////////// 셀러스 유니버전 작업 END //////////////////////////








	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 3.
	 * @explain	: 영업활동 -> 고객이슈 파일리스트
	 */
	@RequestMapping(value="/clientSatisfaction/clientIssueFileList.do")
	public ModelAndView clientIssueFileList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> clientIssueFileList = clientSatisfactionService.clientIssueFileList(map.getMap());
		mv.addObject("clientIssueFileList", clientIssueFileList);
		return mv;
	}




	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 7.
	 * @explain	: 영업활동 -> 고객이슈 delete
	 */
	@RequestMapping(value="/clientSatisfaction/deleteClientIssue.do")
	public ModelAndView deleteClientIssue(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = clientSatisfactionService.deleteClientIssue(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}


	@RequestMapping(value="/clientSatisfaction/deleteClientIssueActionPlan.do")
	public ModelAndView deleteClientIssueActionPlan(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = clientSatisfactionService.deleteClientIssueActionPlan(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}


	////////////////////////////////////////고객만족 start ////////////////////////////////////////////////
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 8.
	 * @explain	: 영업활동 -> 고객만족도 첫 페이지
	 */
	@RequestMapping(value="/clientSatisfaction/viewClientSatisfactionList.do")
	public ModelAndView viewClientSatisfactionList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/clientSatisfaction/clientSatisfactionList");
		List<Map<String,Object>> searchDetailGroup = clientSatisfactionService.clientSatisfactionSearchDetailGroup(map.getMap());
		mv.addObject("searchDetailGroup", searchDetailGroup);

		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 8.
	 * @explain	: 영업활동 -> 고객만족 그리드
	 */
	@RequestMapping(value="/clientSatisfaction/gridClientSatisfaction.do")
	public ModelAndView gridClientSatisfaction(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> gridClientSatisfaction= clientSatisfactionService.gridClientSatisfaction(map.getMap());
		mv.addObject("rows", gridClientSatisfaction);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 8.
	 * @explain	: 영업활동 -> 고객만족 파일리스트
	 */
	@RequestMapping(value="/clientSatisfaction/clientSatisfactionFileList.do")
	public ModelAndView clientSatisfactionFileList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> clientSatisfactionFileList = clientSatisfactionService.clientSatisfactionFileList(map.getMap());
		mv.addObject("clientSatisfactionFileList", clientSatisfactionFileList);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 8.
	 * @explain	: 영업활동 -> 고객만족 insert
	 */
	@RequestMapping(value="/clientSatisfaction/insertClientSatisfaction.do")
	public ModelAndView insertClientSatisfaction(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = clientSatisfactionService.insertClientSatisfaction(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 9.
	 * @explain	: 영업활동 -> 고객만족 update
	 */
	@RequestMapping(value="/clientSatisfaction/updateClientSatisfaction.do")
	public ModelAndView updateClientSatisfaction(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		Map<String,Object> detailMap = clientSatisfactionService.updateClientSatisfaction(map.getMap(), request);
		mv.addObject("cnt", detailMap.get("cnt"));
		mv.addObject("returnPK", detailMap.get("returnPK"));
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 9.
	 * @explain	: 영업활동 -> 고객만족 delete
	 */
	@RequestMapping(value="/clientSatisfaction/deleteClientSatisfaction.do")
	public ModelAndView deleteClientSatisfaction(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = clientSatisfactionService.deleteClientSatisfaction(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}	

	@RequestMapping(value="/clientSatisfaction/gridClientSatisfactionDetailList.do")
	public ModelAndView gridClientSatisfactionDetailList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> clientSatisfactionDetail = clientSatisfactionService.gridClientSatisfactionDetailList(map.getMap());
		mv.addObject("rows", clientSatisfactionDetail);		
		return mv;
	}

	@RequestMapping(value="/clientSatisfaction/insertClientSatisfactionDetailList.do")
	public ModelAndView insertClientSatisfactionDetailList(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = clientSatisfactionService.insertClientSatisfactionDetailList(map.getMap());
		mv.addObject("cnt" , cnt);
		return mv;
	}

	@RequestMapping(value="/clientSatisfaction/deleteClientSatisfactionDetailList.do")
	public ModelAndView deleteClientSatisfactionDetailList(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = clientSatisfactionService.deleteClientSatisfactionDetailList(map.getMap());
		mv.addObject("cnt" , cnt);
		return mv;
	}

	///////////////////////////////////// 리스트형식 /////////////////////////////////////////////////
	@RequestMapping(value="/clientSatisfaction/selectClientSatisfactionMasterListCount.do")
	public ModelAndView selectClientSatisfactionMasterListCount(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		
		if(!device.isNormal()){
			map.put("deviceCheck", "mobile");
		}
		
		Map<String,Object> countMap = clientSatisfactionDAO.selectClientSatisfactionMasterListCount(map.getMap());
		String latelyUpdate = commonDAO.selectLatelyUpdate(map.getMap());
		
		if(device.isNormal()) {
			//페이징이 처리
			String listCount =  countMap.get("listCount").toString();
			mv.addObject("listPaging", CommonUtils.pagingSum(map.getMap(),Integer.parseInt(listCount)));
		}else {
			mv.addObject("mListCount", countMap.get("mListCount"));
			mv.addObject("searchNoArray", countMap.get("searchNoArray"));
			mv.addObject("searchNameArray", countMap.get("searchNameArray"));
		}
		
		mv.addObject("listCount", countMap.get("listCount"));
		mv.addObject("searchPKArray", countMap.get("searchPKArray"));
		mv.addObject("latelyUpdate", latelyUpdate);
		return mv;
	}

	@RequestMapping(value="/clientSatisfaction/selectClientSatisfactionListCount.do")
	public ModelAndView selectClientSatisfactionListCount(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		Map<String,Object> countMap = clientSatisfactionDAO.selectClientSatisfactionListCount(map.getMap());
		String latelyUpdate = commonDAO.selectLatelyUpdate(map.getMap());
		//페이징이 처리
		String listCount =  countMap.get("listCount").toString();
		mv.addObject("listPaging", CommonUtils.pagingSum(map.getMap(),Integer.parseInt(listCount)));
		mv.addObject("listCount", countMap.get("listCount"));
		mv.addObject("searchPKArray", countMap.get("searchPKArray"));
		mv.addObject("latelyUpdate", latelyUpdate);
		return mv;
	}

	@RequestMapping(value="/clientSatisfaction/selectClientSatisfactionMasterList.do")
	public ModelAndView selectClientSatisfactionMasterList(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("/clientSatisfaction/clientSatisfactionMasterAjax");
		
		if (!device.isNormal()) {
            mv.setViewName("jsonView");
            map.put("deviceCheck", "mobile");
        }
		
		List<Map<String,Object>> selectClientSatisfactionMasterList = clientSatisfactionService.selectClientSatisfactionMasterList(map.getMap());
		mv.addObject("rows", selectClientSatisfactionMasterList);

		return mv;
	}

	@RequestMapping(value="/clientSatisfaction/selectClientSatisfactionList.do")
	public ModelAndView selectClientSatisfactionList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/clientSatisfaction/clientSatisfactionAjax");
		List<Map<String,Object>> selectClientSatisfactionList = clientSatisfactionService.selectClientSatisfactionList(map.getMap());
		mv.addObject("rows", selectClientSatisfactionList);
		return mv;
	}

	@RequestMapping(value="/clientSatisfaction/selectClientSatisfactionDetail.do")
	public ModelAndView selectClientSatisfactionDetail(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		Map<String,Object> selectClientSatisfactionDetail = clientSatisfactionService.selectClientSatisfactionDetail(map.getMap());
		List<Map<String,Object>> selectClientSatisfactionFileList = clientSatisfactionDAO.selectClientSatisfactionFileList(map.getMap());
		mv.addObject("detail", selectClientSatisfactionDetail);
		mv.addObject("fileList", selectClientSatisfactionFileList);

		if (device.isMobile()) {
            mv.setViewName("/clientSatisfaction/clientSatisfactionDetail");
        }

		return mv;
	}

	//2016-10-10 심윤영 start
	@RequestMapping(value="/clientSatisfaction/insertClientSatisfactionDetail.do")
	public ModelAndView insertClientSatisfactionDetail(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = clientSatisfactionService.insertClientSatisfactionDetail(map.getMap());
		mv.addObject("cnt" , cnt);
		mv.addObject("returnPK",map.get("filePK"));
		return mv;
	}

	@RequestMapping(value="/clientSatisfaction/updateClientSatisfactionDetail.do")
	public ModelAndView updateClientSatisfactionDetail(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = clientSatisfactionService.updateClientSatisfactionDetail(map.getMap());
		mv.addObject("cnt" , cnt);
		return mv;
	}

	@RequestMapping(value="/clientSatisfaction/gridSolvePlanClientSatisfaction.do")
	public ModelAndView gridSolvePlanClientSatisfaction(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> gridSolvePlanClientSatisfaction = clientSatisfactionDAO.gridSolvePlanClientSatisfaction(map.getMap());
		mv.addObject("rows" , gridSolvePlanClientSatisfaction);
		return mv;
	}

	@RequestMapping(value="/clientSatisfaction/gridClientSatisfactionDetailIssue.do")
	public ModelAndView gridClientSatisfactionDetailIssue(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> gridClientSatisfactionDetailIssue = clientSatisfactionDAO.gridClientSatisfactionDetailIssue(map.getMap());
		mv.addObject("rows" , gridClientSatisfactionDetailIssue);
		return mv;
	}
	//2016-10-10 심윤영 end

	/**
	 * @author 	: 준이
	 * @Date		: 2017. 3. 16.
	 * @explain	: 고객만족 -> 고객만족도 follow up action 삭제
	 */
	@RequestMapping(value="/clientSatisfaction/deleteClientSatisfactionFollowUpAction.do")
	public ModelAndView deleteClientSatisfactionFollowUpAction(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = clientSatisfactionDAO.deleteClientSatisfactionFollowUpAction(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}

	////////////////////////////////////////고객만족 end ////////////////////////////////////////////////






	////////////////////////////////////////서비스프로젝트 start ////////////////////////////////////////////////
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 4.
	 * @explain	: 영업활동 -> 장기프로젝트 관리 첫 페이지
	 */
	@RequestMapping(value="/clientSatisfaction/viewServiceProject.do")
	public ModelAndView serviceProjectView(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/clientSatisfaction/serviceProjectView");
		Map<String,Object> searchDetailGroup = clientSatisfactionService.projectMGMTDetailGroup(map.getMap());
		mv.addObject("searchDetailGroup",searchDetailGroup);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 08. 26.
	 * @explain	: 영업활동 -> 장기프로젝트 관리 리스트
	 */
	@RequestMapping(value="/clientSatisfaction/selectProjectMGMTList.do")
	public ModelAndView selectProjectMGMTList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/clientSatisfaction/serviceProjectAjax");
		List<Map<String,Object>> selectProjectMGMTList= clientSatisfactionService.selectProjectMGMTList(map.getMap());
		mv.addObject("rows", selectProjectMGMTList);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 08. 26.
	 * @explain	: 영업활동 -> 장기프로젝트 관리 리스트 카운트
	 */
	@RequestMapping(value="/clientSatisfaction/selectProjectMGMTListCount.do")
	public ModelAndView selectProjectMGMTListCount(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		Map<String,Object> countMap = clientSatisfactionDAO.selectProjectMGMTListCount(map.getMap());
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
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 4.
	 * @explain	: 영업활동 -> 장기프로젝트 상세보기
	 */
	@RequestMapping(value="/clientSatisfaction/selectProjectMGMTDetail.do")
	public ModelAndView selectProjectMGMTDetail(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		Map<String,Object> selectProjectMGMTDetail = clientSatisfactionService.selectProjectMGMTDetail(map.getMap());
		List<Map<String,Object>> selectProjectMGMTFileList = clientSatisfactionDAO.selectProjectMGMTFileList(map.getMap());
		mv.addObject("detail", selectProjectMGMTDetail);
		mv.addObject("fileList",selectProjectMGMTFileList);
		return mv;
	}


	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 4.
	 * @explain	: 영업활동 -> 장기프로젝트 관리 파일
	 */
	@RequestMapping(value="/clientSatisfaction/projectMGMTFileList.do")
	public ModelAndView projectMGMTFileList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> projectMGMTFileList = clientSatisfactionService.projectMGMTFileList(map.getMap());
		mv.addObject("projectMGMTFileList", projectMGMTFileList);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 4.
	 * @explain	: 영업활동 -> 장기프로젝트 관리 insert
	 */
	@RequestMapping(value="/clientSatisfaction/insertProjectMGMT.do")
	public ModelAndView insertProjectMGMT(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = clientSatisfactionService.insertProjectMGMT(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}

	@RequestMapping(value="/clientSatisfaction/updateProjectMGMT.do")
	public ModelAndView updateProjectMGMT(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = clientSatisfactionService.updateProjectMGMT(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}

	@RequestMapping(value = "/clientSatisfaction/deleteProjectMGMT.do")
	public ModelAndView deleteProjectMGMT(CommandMap map, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = clientSatisfactionService.deleteProjectMGMT(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}

	//Milestons
	@RequestMapping(value= "/clientSatisfaction/updateProjectMGMTMilestons.do")
	public ModelAndView updateProjectMGMTMilestons(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = clientSatisfactionService.updateProjectMGMTMilestons(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}

	@RequestMapping(value="/clientSatisfaction/insertProjectMGMTMilestons.do")
	public ModelAndView insertProjectMGMTMilestons(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = clientSatisfactionService.insertProjectMGMTMilestons(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}

	@RequestMapping(value="/clientSatisfaction/selectProjectMGMTMilestons.do")
	public ModelAndView selectProjectMGMTMilestons(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> list = clientSatisfactionService.selectProjectMGMTMilestons(map.getMap());
		mv.addObject("list", list);
		return mv;
	}

	@RequestMapping(value="/clientSatisfaction/gridProjectIssue.do")
	public ModelAndView gridProjectIssue(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> list = clientSatisfactionService.gridProjectIssue(map.getMap());
		mv.addObject("rows", list);
		return mv;
	}

	@RequestMapping(value="/clientSatisfaction/insertProjectIssue.do")
	public ModelAndView insertProjectIssue(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = clientSatisfactionService.insertProjectIssue(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}

	@RequestMapping(value="/clientSatisfaction/deleteProjectIssue.do")
	public ModelAndView deleteProjectIssue(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = clientSatisfactionService.deleteProjectIssue(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}

	@RequestMapping(value="/clientSatisfaction/selectProjectMGMTInfo.do")
	public ModelAndView selectProjectPlan(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		Map<String,Object> selectProjectMGMTInfo = clientSatisfactionService.selectProjectMGMTInfo(map.getMap());
		mv.addObject("selectProjectMGMTContractInfo",selectProjectMGMTInfo.get("selectProjectMGMTContractInfo"));
		return mv;
	}
	//////////////////////////////////////장기프로젝트 end ////////////////////////////////////////////////


	/**
	 * @author 	: 준이
	 * @Date		: 2017. 3. 16.
	 * @explain	: 고객만족 -> 고객만족도 대시보드 페이지
	 */
	//@RequestMapping(value="/clientSatisfaction/listClientSatisfactionDashBoard.do")
	@RequestMapping(value="/clientSatisfaction/viewClientSatisfactionDashBoard.do")
	public ModelAndView listClientSatisfactionDashBoard(CommandMap map) throws Exception{
		//ModelAndView mv = new ModelAndView("/clientSatisfaction/listClientSatisfactionDashBoard");
		ModelAndView mv = new ModelAndView("/clientSatisfaction/clientSatisfactionDashBoard");
		return mv;
	}

	/**
	 * @author 	: 준이
	 * @Date		: 2017. 3. 16.
	 * @explain	: 고객만족 -> 고객사별 고객만족도 리스트 조회
	 */
	@RequestMapping(value="/clientSatisfaction/selectClientSatisfactionDashBoard.do")
	public ModelAndView selectClientSatisfactionDashBoard(CommandMap map) throws Exception{
		ModelAndView mv = null;
		if(map.getMap().get("datatype").equals("html"))
		{
			mv = new ModelAndView((String) map.getMap().get("jsp"));
		}
		else if(map.getMap().get("datatype").equals("json"))
		{
			mv = new ModelAndView("jsonView");
		}
		
		List<Map<String,Object>> list = clientSatisfactionService.selectClientSatisfactionDashBoard(map.getMap());
		mv.addObject("list", list);
		return mv;
	}
	
	////////////////////////////////////////// 모바일 버전 병합 ////////////////////////////////////////////////

	/**
	 * @explain	: 모바일 고객만족 -> 고객이슈 > 고객이슈 현황
	 */
	@RequestMapping(value="/clientSatisfaction/selectClientIssueStatusCount.do")
	public ModelAndView selectClientIssueStatusCount(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		Map<String,Object> selectClientIssueStatusCount= clientSatisfactionDAO.selectClientIssueStatusCount(map.getMap()); 
		mv.addObject("selectClientIssueStatusCount", selectClientIssueStatusCount);
		
		return mv;
	}			
				
	/**
	 * @explain	: 모바일 고객만족 -> 고객이슈 > 고객이슈 접수 및 처리현황
	 */
	@RequestMapping(value="/clientSatisfaction/selectClientIssueStatus.do")
	public ModelAndView selectClientIssueStatus(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String, Object>> selectClientIssueStatus= clientSatisfactionService.selectClientIssueStatus(map.getMap());
		mv.addObject("selectClientIssueStatus", selectClientIssueStatus);
		
		return mv;
	}

	/**
	 * @explain	: 모바일 고객만족 -> 고객이슈 > 이슈 종류별 현황
	 */
	@RequestMapping(value="/clientSatisfaction/selectClientIssueTypeStatus.do")
	public ModelAndView selectClientIssueTypeStatus(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String,Object>> selectClientIssueTypeStatus= clientSatisfactionService.selectClientIssueTypeStatus(map.getMap()); 
		mv.addObject("selectClientIssueTypeStatus", selectClientIssueTypeStatus);
		
		return mv;
	}
	
	/**
	 * @explain	: 모바일 고객만족 -> 고객만족 > 만족도 현황
	 */
	@RequestMapping(value="/clientSatisfaction/selectClientSatisfactionTotalStatus.do")
	public ModelAndView selectClientSatisfactionTotalStatus(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		Map<String, Object> selectClientSatisfactionTotalStatus= clientSatisfactionDAO.selectClientSatisfactionTotalStatus(map.getMap()); 
		mv.addObject("selectClientSatisfactionTotalStatus", selectClientSatisfactionTotalStatus);
		
		return mv;
	}
	
	/**
	 * @explain	: 모바일 고객만족 -> 고객만족 > 조사현황 팀(본부) 리스트
	 */
	@RequestMapping(value="/clientSatisfaction/selectClientSatisfactionMasterTeamList.do")
	public ModelAndView selectClientSatisfactionMasterTeamList(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
			
		// 본부/팀/멤버 리스트
		if(!map.get("global_role_code").toString().contains("ROLE_MEMBER")) {
			List<Map<String,Object>> selectTeamNameList = clientSatisfactionDAO.selectClientSatisfactionMasterTeamList(map.getMap());
			mv.addObject("selectTeamNameList", selectTeamNameList);
		}
	
		return mv;
	}
	
	/**
	 * @explain	: 모바일 고객만족 -> 고객만족 > 조사현황
	 */
	@RequestMapping(value="/clientSatisfaction/selectClientSatisfactionMasterListM.do")
	public ModelAndView selectClientSatisfactionMasterListM(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String,Object>> selectClientSatisfactionMasterList = clientSatisfactionService.selectClientSatisfactionMasterListM(map.getMap());
		mv.addObject("rows", selectClientSatisfactionMasterList);
	
		return mv;
	}
}