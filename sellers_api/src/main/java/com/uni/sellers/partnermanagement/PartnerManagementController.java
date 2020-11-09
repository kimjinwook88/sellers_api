package com.uni.sellers.partnermanagement;

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
public class PartnerManagementController {
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name="partnerManagementService")
	private PartnerManagementService partnerManagementService;

	@Resource(name="partnerManagementDAO")
	private PartnerManagementDAO partnerManagementDAO;

	@Resource(name="commonDAO")
	private CommonDAO commonDAO;

	////////////////////////////////////////파트너영업 start ////////////////////////////////////////////////
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 8.
	 * @explain	: 영업활동 -> 파트너 영업 -> Capacity분석
	 */
	@RequestMapping(value="/partnerManagement/viewPartnerSales.do")
	public ModelAndView viewPartnerSales(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/partnerManagement/partnerCooperationSalesTabView");
		Map<String,Object> searchDetailGroup = partnerManagementService.partnerSalesGroup(map.getMap());
		mv.addObject("searchDetailGroup",searchDetailGroup);
		mv.addObject("selectAccountYear",map.get("selectAccountYear"));
		mv.addObject("selectViewList",map.get("selectViewList"));
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 8.
	 * @explain	: 영업활동 -> 파트너 영업 -> Capacity 생성하기
	 */
	@RequestMapping(value="/partnerManagement/createCapacity.do")
	public ModelAndView createCapacity(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = partnerManagementService.createCapacity(map.getMap());
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 8.
	 * @explain	: 영업활동 -> 파트너 영업 -> Capacity분석 partner리스트
	 */
	@RequestMapping(value="/partnerManagement/selectCapacityPartnerList.do")
	public ModelAndView selectCapacityPartnerList(CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String,Object>> selectCapacityPartnerList = partnerManagementService.selectCapacityPartnerList(map.getMap());
		mv.addObject("selectCapacityPartnerList",selectCapacityPartnerList);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 09. 07.
	 * @explain	: 영업활동 -> 파트너 영업 -> Action
	 */
	@RequestMapping(value="/partnerManagement/selectCapacityPartnerAction.do")
	public ModelAndView selectCapacityPartnerAction(CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		Map<String,Object> selectCapacityPartnerAction = partnerManagementDAO.selectCapacityPartnerAction(map.getMap());
		mv.addObject("selectCapacityPartnerAction",selectCapacityPartnerAction);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 17.
	 * @explain	: 영업활동 -> 파트너 영업 -> Capacity grid
	 */
	@RequestMapping(value="/partnerManagement/gridCapacity.do")
	public ModelAndView gridCapacity(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> gridCapacity= partnerManagementService.gridCapacity(map.getMap());
		mv.addObject("rows", gridCapacity);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 30.
	 * @explain	: 영업활동 -> 파트너 영업 -> Capacity Insert
	 */
	@RequestMapping(value="/partnerManagement/insertCapacity.do")
	public ModelAndView insertCapacity(CommandMap map, HttpServletRequest request) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt= partnerManagementService.insertCapacity(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 30.
	 * @explain	: 영업활동 -> 파트너 영업 -> deleteCapacityParnter
	 */
	@RequestMapping(value="/partnerManagement/deleteCapacityParnter.do")
	public ModelAndView deleteCapacityParnter(CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt= partnerManagementService.deleteCapacityParnter(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 30.
	 * @explain	: 영업활동 -> 파트너 영업 -> insertCapacityParnter
	 */
	@RequestMapping(value="/partnerManagement/insertCapacityParnter.do")
	public ModelAndView insertCapacityParnter(CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		int cnt= partnerManagementService.insertCapacityParnter(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 7.17.
	 * @explain	: 영업활동 -> 파트너 영업 -> insertCapacityAction
	 */
	@RequestMapping(value="/partnerManagement/insertCapacityAction.do")
	public ModelAndView insertCapacityGap(CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt= partnerManagementService.insertCapacityAction(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 17.
	 * @explain	: 영업활동 -> 파트너 영업 -> Recruitment
	 */
	@RequestMapping(value="/partnerManagement/viewPartnerRecruitment.do")
	public ModelAndView viewPartnerRecruitment(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/partnerManagement/partnerCooperationRecruitmentTabView");
		Map<String,Object> searchDetailGroup = partnerManagementService.partnerSalesGroup(map.getMap());
		mv.addObject("searchDetailGroup",searchDetailGroup);
		mv.addObject("selectViewList",map.get("selectViewList"));
		mv.addObject("selectAccountYear",map.get("selectAccountYear"));
		//CRB
		Map<String,Object> searchCRBGroup = partnerManagementDAO.crbGroup(map.getMap());
		mv.addObject("searchCRBGroup",searchCRBGroup);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 17.
	 * @explain	: 영업활동 -> 파트너 영업 -> Recruitment grid
	 */
	@RequestMapping(value="/partnerManagement/selectCRBseq.do")
	public ModelAndView selectCRBseq(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> selectCRBseq= partnerManagementDAO.selectCRBseq(map.getMap());
		mv.addObject("selectCRBseq", selectCRBseq);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 17.
	 * @explain	: 영업활동 -> 파트너 영업 -> Recruitment grid
	 */
	@RequestMapping(value="/partnerManagement/gridRecruitment.do")
	public ModelAndView gridRecruitment(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> gridRecruitment= partnerManagementService.gridRecruitment(map.getMap());
		mv.addObject("rows", gridRecruitment);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 17.
	 * @explain	: 영업활동 -> 파트너 영업 -> Recruitment createRecruitment
	 */
	@RequestMapping(value="/partnerManagement/insertRecruitment.do")
	public ModelAndView insertRecruitment(CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = partnerManagementService.insertRecruitment(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 17.
	 * @explain	: 영업활동 -> 파트너 영업 -> Recruitment gridRecruitmentCRB
	 */
	@RequestMapping(value="/partnerManagement/gridRecruitmentCRB.do")
	public ModelAndView createRecruitment(CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String,Object>> gridRecruitmentCRB = partnerManagementService.gridRecruitmentCRB(map.getMap());
		mv.addObject("rows", gridRecruitmentCRB);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 17.
	 * @explain	: 영업활동 -> 파트너 영업 -> Recruitment createCRB
	 */
	@RequestMapping(value="/partnerManagement/createCRB.do")
	public ModelAndView createCRB(CommandMap map, HttpServletRequest request) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = partnerManagementDAO.createCRB(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}


	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 17.
	 * @explain	: 영업활동 -> 파트너 영업 -> Recruitment insertRecruitmentCRB
	 */
	@RequestMapping(value="/partnerManagement/insertRecruitmentCRB.do")
	public ModelAndView insertRecruitmentCRB(CommandMap map, HttpServletRequest request) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = partnerManagementService.insertRecruitmentCRB(map.getMap(),request);
		mv.addObject("cnt", cnt);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 07. 24.
	 * @explain	: 영업활동 -> 파트너 영업 -> Recruitment insertRecruitmentCRB File List
	 */
	@RequestMapping(value="/partnerManagement/recruitmentCRBFileList.do")
	public ModelAndView recruitmentCRBFileList(CommandMap map, HttpServletRequest request) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String,Object>> fileList = partnerManagementService.recruitmentCRBFileList(map.getMap());
		mv.addObject("fileList", fileList);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 07. 24.
	 * @explain	: 영업활동 -> 파트너 영업 -> Recruitment selectCRBbpNameJson
	 */
	@RequestMapping(value="/partnerManagement/selectCRBbpNameJson.do")
	public ModelAndView selectCRBbpNameJson(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> selectCRBbpNameJson = partnerManagementDAO.selectCRBbpNameJson(map.getMap());
		mv.addObject("rows", selectCRBbpNameJson);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 17.
	 * @explain	: 영업활동 -> 파트너 영업 -> Enablement
	 */
	@RequestMapping(value="/partnerManagement/viewPartnerEnablement.do")
	public ModelAndView viewPartnerEnablement(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/partnerManagement/partnerCooperationEnablementTabView");
		Map<String,Object> searchDetailGroup = partnerManagementService.enablementSearchDetailGroup(map.getMap());
		mv.addObject("searchDetailGroup", searchDetailGroup);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 17.
	 * @explain	: 영업활동 -> 파트너 영업 -> Enablement grid
	 */
	@RequestMapping(value="/partnerManagement/gridEnablement.do")
	public ModelAndView gridEnablement(CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("/partnerManagement/partnerCooperationEnablementAjax");
		
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String,Object>> gridEnablement= partnerManagementService.gridEnablement(map.getMap());
		mv.addObject("rows", gridEnablement);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 17.
	 * @explain	: 파트너사협업 -> 파트너 스킬 및 교육 -> 리스트 카운트
	 */
	@RequestMapping(value="/partnerManagement/selectEnablementCount.do")
	public ModelAndView selectEnablementCount(CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		Map<String,Object> countMap = partnerManagementDAO.selectEnablementCount(map.getMap());
		String latelyUpdate = commonDAO.selectLatelyUpdate(map.getMap());
		mv.addObject("listCount", countMap.get("listCount"));
		mv.addObject("searchPKArray", countMap.get("searchPKArray"));
		mv.addObject("latelyUpdate", latelyUpdate);
		return mv;
	}


	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 10. 14.
	 * @explain	: 파트너사협업 -> 파트너 스킬 및 교육 -> 상세보기
	 */
	@RequestMapping(value="/partnerManagement/selectEnablementDetail.do")
	public ModelAndView selectEnablementDetail(CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		Map<String,Object> selectEnablementDetail = partnerManagementService.selectEnablementDetail(map.getMap());
		List<Map<String,Object>> selectEnablementFileList = partnerManagementDAO.selectEnablementFileList(map.getMap());
		mv.addObject("detail", selectEnablementDetail);
		mv.addObject("fileList",selectEnablementFileList);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 17.
	 * @explain	: 영업활동 -> 파트너 영업 -> milestones
	 */
	@RequestMapping(value="/partnerManagement/gridMileStonesEnablement.do")
	public ModelAndView gridMileStonesEnablement(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> gridMileStonesEnablement = partnerManagementService.gridMileStonesEnablement(map.getMap());
		mv.addObject("rows", gridMileStonesEnablement);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 20.
	 * @explain	: 영업활동 -> 파트너 영업 -> Enablement -> milestons insert
	 */
	@RequestMapping(value="/partnerManagement/insertMilestonesEnablement.do")
	public ModelAndView insertMilestonesEnablement(CommandMap map, HttpServletRequest request) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		int cnt= partnerManagementService.insertMilestonesEnablement(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 20.
	 * @explain	: 영업활동 -> 파트너 영업 -> Enablement -> insert
	 */
	@RequestMapping(value="/partnerManagement/insertEnablement.do")
	public ModelAndView insertEnablement(CommandMap map, HttpServletRequest request) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt= partnerManagementService.insertEnablement(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 20.
	 * @explain	: 영업활동 -> 파트너 영업 -> Enablement -> update
	 */
	@RequestMapping(value="/partnerManagement/updateEnablement.do")
	public ModelAndView updateEnablement(CommandMap map, HttpServletRequest request) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");

		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt= partnerManagementService.updateEnablement(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 17.
	 * @explain	: 영업활동 -> 파트너 영업 -> SalesLinkage
	 */
	@RequestMapping(value="/partnerManagement/viewPartnerSalesLinkage.do")
	public ModelAndView viewPartnerSalesLinkage(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/partnerManagement/partnerCooperationSalesLinkageTabView");
		Map<String,Object> searchDetailGroup = partnerManagementService.salesLinkageDetailGroup(map.getMap());
		mv.addObject("searchDetailGroup", searchDetailGroup);
		mv.addObject("selectAccountYear",map.get("selectAccountYear"));
		mv.addObject("selectViewList",map.get("selectViewList"));
		return mv;
	}
	
    /**
     * @author  : comgyver
     * @Date        : 2017. 6. 16.
     * @explain : 파트너사 협업관리 -> 파트너 협업 -> 상세보기 페이지 이동
     */
    @RequestMapping(value="/partnerManagement/partnerCooperationSalesLinkageModal.do")
    public ModelAndView partnerCooperationSalesLinkageModal(CommandMap map) throws Exception{
        ModelAndView mv = new ModelAndView("/partnerManagement/partnerCooperationSalesLinkageModal");
        Map<String,Object> searchDetail = partnerManagementService.salesLinkageDetail(map.getMap());
        mv.addObject("searchDetail", searchDetail);
        mv.addObject("linkage_id",map.get("linkage_id"));

        return mv;
    }	

    /**
     * @author  : comgyver
     * @Date        : 2017. 6. 16.
     * @explain : 파트너사 협업관리 -> 파트너 협업 -> 기본정보 상세
     */
    @RequestMapping(value="/partnerManagement/partnerCooperationSalesLinkage.do")
    public ModelAndView partnerCooperationSalesLinkage(CommandMap map) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        Map<String,Object> searchDetail = partnerManagementService.salesLinkageDetail(map.getMap());
        mv.addObject("searchDetail", searchDetail);
        mv.addObject("linkage_id", map.get("linkage_id"));
        return mv;
    }     
    
    /**
     * @author  : comgyver
     * @Date        : 2017. 6. 16.
     * @explain : 파트너사 협업관리 -> 파트너 협업 -> 수정폼으로 이동
     */
    @RequestMapping(value="/partnerManagement/partnerCooperationSalesLinkageInsertForm.do")
    public ModelAndView partnerCooperationSalesLinkageInsertForm(CommandMap map) throws Exception{
        ModelAndView mv = new ModelAndView("/partnerManagement/partnerCooperationSalesLinkageInsertForm");
        Map<String,Object> searchDetail = partnerManagementService.salesLinkageDetail(map.getMap());
        mv.addObject("searchDetail", searchDetail);
        mv.addObject("linkage_id", map.get("linkage_id"));
        return mv;
    }   
    
    /**
     * @author  : comgyver
     * @Date        : 2017. 6. 16.
     * @explain : 파트너사 협업관리 -> 파트너 협업 -> Cadence 등록 폼으로 이동
     */
    @RequestMapping(value="/partnerManagement/partnerCooperationSalesCadenceInsertForm.do")
    public ModelAndView partnerCooperationSalesCadenceInsertForm(CommandMap map) throws Exception{
        ModelAndView mv = new ModelAndView("/partnerManagement/partnerCooperationSalesCadenceInsertForm");
        Map<String,Object> searchDetail = partnerManagementService.salesLinkageDetail(map.getMap());
        mv.addObject("searchDetail", searchDetail);
        mv.addObject("linkage_id", map.get("linkage_id"));
        return mv;
    }     
    
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 17.
	 * @explain	: 영업활동 -> 파트너 영업 -> SalesLinkage grid
	 */
	@RequestMapping(value="/partnerManagement/gridSalesLinkage.do")
	public ModelAndView gridSalesLinkage(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> gridSalesLinkage= partnerManagementService.gridSalesLinkage(map.getMap());
		mv.addObject("rows", gridSalesLinkage);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 17.
	 * @explain	: 영업활동 -> 파트너 영업 -> SalesLinkage create
	 */
	@RequestMapping(value="/partnerManagement/createSalesLinkage.do")
	public ModelAndView createSalesLinkage(CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt= partnerManagementService.createSalesLinkage(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 07. 05.
	 * @explain	: 영업활동 -> 파트너 영업 -> SalesLinkage updateSalesLinkage
	 */
	@RequestMapping(value="/partnerManagement/updateSalesLinkage.do")
	public ModelAndView updateSalesLinkage(CommandMap map, HttpServletRequest request) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt= partnerManagementService.updateSalesLinkage(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 07. 05.
	 * @explain	: 영업활동 -> 파트너 영업 -> SalesLinkage insertSalesLinkageHistory
	 */
	@RequestMapping(value="/partnerManagement/insertSalesLinkageHistory.do")
	public ModelAndView insertSalesLinkageHistory(CommandMap map, HttpServletRequest request) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}		
		
		int cnt= partnerManagementService.insertSalesLinkageHistory(map.getMap(),request);
		mv.addObject("cnt", cnt);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 07. 26.
	 * @explain	: 영업활동 -> 파트너 영업 -> SalesLinkage salesLinkageFileList
	 */
	@RequestMapping(value="/partnerManagement/salesLinkageFileList.do")
	public ModelAndView salesLinkageFileList(CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String,Object>> salesLinkageFileList = partnerManagementService.salesLinkageFileList(map.getMap());
		mv.addObject("salesLinkageFileList", salesLinkageFileList);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 07. 27.
	 * @explain	: 영업활동 -> 파트너 영업 -> SalesLinkage selectCadenceDateList
	 */
	@RequestMapping(value="/partnerManagement/selectCadenceDateList.do")
	public ModelAndView selectCadenceDateList(CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String,Object>> selectCadenceDateList = partnerManagementService.selectCadenceDateList(map.getMap());
		mv.addObject("selectCadenceDateList", selectCadenceDateList);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 07. 27.
	 * @explain	: 영업활동 -> 파트너 영업 -> SalesLinkage selectCadenceDetail
	 */
	@RequestMapping(value="/partnerManagement/selectCadenceDetail.do")
	public ModelAndView selectCadenceDetail(CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		Map<String,Object> selectCadenceDetail = partnerManagementService.selectCadenceDetail(map.getMap());
		mv.addObject("selectCadenceDetail", selectCadenceDetail);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 09. 05.
	 * @explain	: 파트너사협업 관리 -> SalesLinkage -> Action Plan
	 */
	@RequestMapping(value="/partnerManagement/gridActionPlanSalesLinkage.do")
	public ModelAndView gridActionPlanSalesLinkage(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> gridActionPlanSalesLinkage= partnerManagementDAO.gridActionPlanSalesLinkage(map.getMap());
		mv.addObject("rows", gridActionPlanSalesLinkage);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 17.
	 * @explain	: 영업활동 -> 파트너 영업 -> Fullfillment
	 */
	@RequestMapping(value="/partnerManagement/viewPartnerFullfillment.do")
	public ModelAndView viewPartnerFullfillment(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/partnerManagement/partnerCooperationFullfillmentTabView");
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 17.
	 * @explain	: 영업활동 -> 파트너 영업 -> Fullfillment grid
	 */
	@RequestMapping(value="/partnerManagement/selectFullfillment.do")
	public ModelAndView selectFullfillment(CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("/partnerManagement/partnerCoopertationFullfillmentAjax");
		
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		/////////////////////////////////////////////// standard ver.Fullfillment start ///////////////////////////////////////////////
		
		//List<Map<String,Object>> selectFullfillment= partnerManagementService.selectFullfillment(map.getMap());
		//mv.addObject("rows", selectFullfillment);
		
		/////////////////////////////////////////////// standard ver.Fullfillment end ///////////////////////////////////////////////
		
		
		/////////////////////////////////////////////// 더존 ERP 연동 관련 소스 start ///////////////////////////////////////////////
		
		//년도별 신용평가현황 리스트 카운트
		String listCount = String.valueOf(partnerManagementDAO.selectFullfillmentCount(map.getMap()).get("listCount"));
		//페이징이 처리
		mv.addObject("listPaging", CommonUtils.pagingSum(map.getMap(),Integer.parseInt(listCount)));
		mv.addObject("rows", partnerManagementService.selectFullfillmentERP(map.getMap()));
		
		//검색값 유지
		mv.addObject("searchYear",map.get("searchYear"));
		mv.addObject("searchCompanyName",map.get("searchCompanyName"));
		
		//////////////////////////////////////////////// 더존 ERP 연동 관련 소스 end ///////////////////////////////////////////////
		return mv;
	}

	//파트너사 -> 전체 협력사 발주현황
	@RequestMapping(value="/partnerManagement/listPartnerCompanyOrderStatus.do")
	public ModelAndView listPartnerCompanyOrderStatus(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/partnerManagement/listPartnerCompanyOrderStatus");
		return mv;
	}

	@RequestMapping(value="/partnerManagement/listPartnerCompanyOrderStatusAjax.do")
	public ModelAndView selectPartnerCompanyOrderStatus(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/partnerManagement/listPartnerCompanyOrderStatusAjax");
		List<Map<String,Object>> listPartnerCompanyOrderStatus = partnerManagementService.selectPartnerCompanyOrderStatus(map.getMap());

		mv.addObject("listPartnerCompanyOrderStatus", listPartnerCompanyOrderStatus);
		mv.addObject("searchYear", map.get("searchYear"));

		return mv;
	}

	//파트너사 -> 협력사 발주현황
	@RequestMapping(value="/partnerManagement/listPartnerCompanyOrder.do")
	public ModelAndView listPartnerCompanyOrder(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/partnerManagement/listPartnerCompanyInfoListDetailOrderList");
		mv.addObject("companyId",map.get("companyId"));
		return mv;
	}

	@RequestMapping(value="/partnerManagement/selectPartnerCompanyOrderList.do")
	public ModelAndView selectPartnerCompanyOrderList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/partnerManagement/listPartnerCompanyInfoListDetailOrderListAjax");
		List<Map<String,Object>> selectPartnerCompanyOrderList = partnerManagementService.selectPartnerCompanyOrderList(map.getMap());
		mv.addObject("statusList",selectPartnerCompanyOrderList);
		return mv;
	}

	@RequestMapping(value="/partnerManagement/selectPartnerCompanyOrder.do")
	public ModelAndView selectPartnerCompanyOrder(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> gridPartnerCompanyInfo= partnerManagementService.selectPartnerCompanyOrder(map.getMap());
		mv.addObject("rows", gridPartnerCompanyInfo);
		return mv;
	}

	@RequestMapping(value="/partnerManagement/updatePartnerCompanyInfoOrder.do")
	public ModelAndView updatePartnerCompanyInfoOrder(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = partnerManagementService.updatePartnerCompanyInfoOrder(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}

	@RequestMapping(value="/partnerManagement/deletePartnerCompanyOrder.do")
	public ModelAndView deletePartnerCompanyOrder(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = partnerManagementService.deletePartnerCompanyOrder(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}

	//파트너사 -> 협력사 매출현황
	@RequestMapping(value="/partnerManagement/listPartnerCompanySale.do")
	public ModelAndView listPartnerCompanySale(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/partnerManagement/listPartnerCompanyInfoListDetailSaleList");
		mv.addObject("companyId",map.get("companyId"));
		return mv;
	}

	@RequestMapping(value="/partnerManagement/selectPartnerCompanySaleList.do")
	public ModelAndView selectPartnerCompanySaleList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/partnerManagement/listPartnerCompanyInfoListDetailSaleListAjax");
		List<Map<String,Object>> selectPartnerCompanySaleList = partnerManagementService.selectPartnerCompanySaleList(map.getMap());
		mv.addObject("statusList",selectPartnerCompanySaleList);
		return mv;
	}

	@RequestMapping(value="/partnerManagement/selectPartnerCompanySale.do")
	public ModelAndView selectPartnerCompanySale(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> gridPartnerCompanyInfo= partnerManagementService.selectPartnerCompanySale(map.getMap());
		mv.addObject("rows", gridPartnerCompanyInfo);
		return mv;
	}

	@RequestMapping(value="/partnerManagement/updatePartnerCompanyInfoSale.do")
	public ModelAndView updatePartnerCompanyInfoSale(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = partnerManagementService.updatePartnerCompanyInfoSale(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}

	@RequestMapping(value="/partnerManagement/deletePartnerCompanySale.do")
	public ModelAndView deletePartnerCompanySale(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = partnerManagementService.deletePartnerCompanySale(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}
	
	@RequestMapping(value="/partnerManagement/selectSolutionArea.do")
	public ModelAndView selectSolutionArea(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> list = partnerManagementService.selectVendorSolutionAreaList(map.getMap());
		String option = "<option role=\"option\">===선택===</option>";
		for(int i=0; i<list.size(); i++){
			option += "<option role=\"option\" value=\""+ list.get(i).get("SOLUTION_ID") +"\">"+ list.get(i).get("SOLUTION_AREA") +"</option>";
		}
		mv.addObject("rows", option);

		return mv;
	}

	@RequestMapping(value="/partnerManagement/insertSolutionArea.do")
	public ModelAndView insertSaleseStatus(CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = partnerManagementService.insertSolutionArea(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}

	@RequestMapping(value="/partnerManagement/deleteSolutionArea.do")
	public ModelAndView deleteProjectIssue(CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = partnerManagementService.deleteSolutionArea(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}
	
	
	
	//////////////////////////////////////// 파트너사 정보 관련 ////////////////////////////////////////////////
	//파트너사정보 게이트 페이지
	@RequestMapping(value="/partnerManagement/viewPartnerCompanyInfoGate.do")
	public ModelAndView listPartnerCompanyGate(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("/partnerManagement/partnerCompanyInfoGate");
		
		if (device.isMobile()) {
			log.info("************************************* 접속 기기 : Mobile");
			if (map.get("datatype") == null) {
				//mv.setViewName("/partnerManagement/partnerCompanyInfoGate");
				List<Map<String,Object>> listPartnerCompanyInfoLeftList= partnerManagementService.listPartnerCompanyInfoLeftList(map.getMap());
				mv.addObject("rows", listPartnerCompanyInfoLeftList);
				mv.addObject("map", map.getMap());
			}
			log.info("************************************* mv[" + mv.getViewName() + "]");
		}
		
		return mv;
	}
	
	@RequestMapping(value="/partnerManagement/selectCodePartnerSegmentAll.do")
	public ModelAndView selectCodePartnerSegmentAll(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		mv.addObject("partnerSegmentCode",partnerManagementDAO.selectCodePartnerSegmentAll(map.getMap()));
		return mv;
	}

	@RequestMapping(value="/partnerManagement/viewPartnerCompanyInfoDetail.do")
	public ModelAndView viewPartnerCompanyInfoDetail(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("/partnerManagement/partnerCompanyInfoDetailView");
		List<Map<String, Object>> partnerSegmentCode = partnerManagementService.selectPartnerInfoSearchPartnerCode(map.getMap());

		if (device.isMobile()) {
			log.info("************************************* 접속 기기 : Mobile");
			if (map.get("datatype") == null) {
				//mv.setViewName("/partnerManagement/partnerCompanyInfoGate");
				map.put("companyId", map.get("company_id"));
				mv.addObject("selectPartnerCompanyInfo", partnerManagementService.selectPartnerCompanyInfo(map.getMap()));
				//mv.addObject("companyOrganizationChart", partnerManagementService.companyOrganizationChart(map.getMap()));

				mv.addObject("map", map.getMap());
			}
			log.info("************************************* mv[" + mv.getViewName() + "]");
		}

		mv.addObject("companyId", map.get("company_id"));
		mv.addObject("searchDetail", map.get("searchDetail"));
		mv.addObject("partnerSegmentCode", partnerSegmentCode);
		return mv;
	}
	
	@RequestMapping(value="/partnerManagement/formPartnerCompanyInfoDetail.do")
	public ModelAndView formPartnerCompanyInfoDetail(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("/partnerManagement/formPartnerCompanyInfoDetailView");
		//List<Map<String, Object>> partnerSegmentCode = partnerManagementService.selectPartnerInfoSearchPartnerCode(map.getMap());

		if (device.isMobile()) {
			log.info("************************************* 접속 기기 : Mobile");
			if (map.get("mode") != null && map.get("mode").equals("update")) {
				map.put("companyId", map.get("company_id"));
				mv.addObject("selectPartnerCompanyInfo", partnerManagementService.selectPartnerCompanyInfo(map.getMap()));
				//mv.addObject("companyOrganizationChart", partnerManagementService.companyOrganizationChart(map.getMap()));

				mv.addObject("map", map.getMap());
			}
			log.info("************************************* mv[" + mv.getViewName() + "]");
		}

//		mv.addObject("companyId", map.get("company_id"));
//		mv.addObject("searchDetail", map.get("searchDetail"));
//		mv.addObject("partnerSegmentCode", partnerSegmentCode);
		return mv;
	}
	
	@RequestMapping(value="/partnerManagement/selectPartnerSkill.do")
	public ModelAndView selectPartnerSkill(CommandMap map) throws Exception{
		//ModelAndView mv = new ModelAndView("/partnerManagement/partnerCompanyIndividualSkillAjax");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}

		List<Map<String, Object>> companyIndividualSkillMap = partnerManagementService.companyIndividualSkillMap(map.getMap());
		mv.addObject("companyIndividualSkillMap", companyIndividualSkillMap);

		return mv;
	}
	
	//파트너사 조직도,첨부파일 리스트
	@RequestMapping(value="/partnerManagement/selectPartnerCompanyFileList.do")
	public ModelAndView selectPartnerCompanyFileList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}

		List<Map<String,Object>> selectPartnerCompanyFileList = partnerManagementService.selectPartnerCompanyFileList(map.getMap());
		mv.addObject("fileList",selectPartnerCompanyFileList);
		mv.addObject("companyId",map.get("companyId"));

		return mv;
	}
		
	//파트너사 정보 첨부파일 업로드
	@RequestMapping(value="/partnerManagement/updatePartnerCompanyFile.do")
	public ModelAndView updatePartnerCompanyFile(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = partnerManagementService.updatePartnerCompanyFile(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}
	
	/**
	 * @author 	: 장성훈
	 * @Date		: 2016. 6. 8.
	 * @explain	: 파트너관리 -> 파트너개인정보 관리 insert
	 */
	@RequestMapping(value="/partnerManagement/insertPartnerCompanyInfo.do")
	public ModelAndView insertPartnerCompanyInfo(CommandMap map, HttpServletRequest request) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		Map<String, Object> clientMap = partnerManagementService.insertPartnerCompanyInfo(map.getMap(), request);
		mv.addObject("cnt", clientMap.get("cnt"));
		mv.addObject("filePK", clientMap.get("filePK"));
		return mv;
	}
	
	/**
	 * @author 	: 장성훈
	 * @Date		: 2016. 7. 17.
	 * @explain	: 파트너관리 -> 파트너사정보 관리 그리드
	 */
	@RequestMapping(value="/partnerManagement/selectPartnerCompanyList.do")
	public ModelAndView selectPartnerCompanyList(CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		List<Map<String,Object>> selectPartnerCompanyList= partnerManagementService.selectPartnerCompanyList(map.getMap());
		mv.addObject("rows", selectPartnerCompanyList);
		return mv;
	}

	/**
	 * @author 	: 장성훈
	 * @Date		: 2016. 7. 17.
	 * @explain	: 파트너관리 -> 파트너사정보 관리 update
	 */
	@RequestMapping(value="/partnerManagement/updatePartnerCompanyInfo.do")
	public ModelAndView updatePartnerCompanyInfo(CommandMap map, HttpServletRequest request) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = partnerManagementService.updatePartnerCompanyInfo(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}
	
	@RequestMapping(value="/partnerManagement/selectPartnerCompanyInfo.do")
	public ModelAndView selectCompanyInfo(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		mv.addObject("selectPartnerCompanyInfo", partnerManagementService.selectPartnerCompanyInfo(map.getMap()));
		mv.addObject("companyOrganizationChart", partnerManagementService.companyOrganizationChart(map.getMap()));

		//페이징이 먼저 실행 되어야 한다.
		mv.addObject("listPaging", CommonUtils.pagingSum(map.getMap(),partnerManagementDAO.selectCompanyPartnerCount(map.getMap())));
		mv.addObject("partnerCompanyList", partnerManagementService.selectPartnerClient(map.getMap()));

		//검색값 유지
		mv.addObject("textSearchClient",map.getMap().get("textSearchClient"));
		return mv;
	}
	
	@RequestMapping(value="/partnerManagement/selectPartnerCompanyInfoLeftList.do")
	public ModelAndView selectPartnerCompanyInfoLeftList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String,Object>> listPartnerCompanyInfoLeftList= partnerManagementService.listPartnerCompanyInfoLeftList(map.getMap());
		mv.addObject("rows", listPartnerCompanyInfoLeftList);
		return mv;
	}

	//////////////////////////////////////// 파트너사 개인정보 관련 ////////////////////////////////////////////////
	
	//파트너개인정보 게이트 페이지
	@RequestMapping(value="/partnerManagement/viewPartnerIndividualInfoGate.do")
	public ModelAndView viewPartnerIndividualInfoGate(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("/partnerManagement/partnerIndividualInfoGate");

		if(device.isNormal()) {
			List<Map<String,Object>> selectVendorSolutionArea= partnerManagementService.selectVendorSolutionAreaList(map.getMap());
			mv.addObject("VendorSolutionArea", selectVendorSolutionArea);
		}else {
			if (map.get("search_result") != null && map.get("search_result").equals("Y")) {
				List<Map<String,Object>> gridPartnerIndividualInfo = partnerManagementService.gridPartnerIndividualInfoList(map.getMap());
				mv.addObject("rows", gridPartnerIndividualInfo);
				mv.addObject("map", map.getMap());
			}
		}
		
		return mv;
	}
	
	@RequestMapping(value="/partnerManagement/selectPartnerIndividualDetail.do")
	public ModelAndView gridPartnerIndividualDetail(CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("/partnerManagement/partnerIndividualInfoDetailAjax");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}

		mv.addObject("PartnerIndividualCompanyList", partnerManagementService.selectPartnerCompanyIndividualList(map.getMap()));
		mv.addObject("defaultInfo", partnerManagementService.gridPartnerIndividualDetail(map.getMap()));
		mv.addObject("defaultPhoto", partnerManagementService.partnerIndividualPhotoList(map.getMap()));
		mv.addObject("defaultSkillMap", partnerManagementService.partnerIndividualSkillList(map.getMap()));
		mv.addObject("defaultEnableLog", partnerManagementService.partnerEnableLogList(map.getMap()));

		return mv;
	}
	
	@RequestMapping(value="/partnerManagement/selectPartnerIndividualInfoList2.do")
	public ModelAndView selectPartnerIndividualInfoList2(CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("/partnerManagement/partnerIndividualInfoListLeftAjax");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String,Object>> gridPartnerIndividualInfo= partnerManagementService.gridPartnerIndividualInfoList(map.getMap());
		mv.addObject("rows", gridPartnerIndividualInfo);
		return mv;
	}
	
	@RequestMapping(value="/partnerManagement/viewPartnerIndividualInfoDetail.do")
	public ModelAndView viewPartnerIndividualInfoDetail(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("/partnerManagement/partnerIndividualInfoDetailView");

		if (device.isMobile()) {
			log.info("************************************* 접속 기기 : Mobile");

			List<Map<String, Object>> defaultInfo = partnerManagementService.gridPartnerIndividualDetail(map.getMap());
			List<Map<String, Object>> defaultPhoto = partnerManagementService.partnerIndividualPhotoList(map.getMap());

			mv.addObject("defaultInfo", defaultInfo);
			mv.addObject("defaultPhoto", defaultPhoto);

			log.info("************************************* mv[" + mv.getViewName() + "]");
		}
		else {
			List<Map<String,Object>> selectVendorSolutionArea= partnerManagementService.selectVendorSolutionAreaList(map.getMap());
			mv.addObject("VendorSolutionArea", selectVendorSolutionArea);
		}

		mv.addObject("coutomerId", map.get("customer_id"));
		mv.addObject("companyId", map.get("company_id"));
		mv.addObject("searchDetail", map.get("search_detail"));
		return mv;
	}
	
	@RequestMapping(value="/partnerManagement/formPartnerIndividualInfoDetail.do")
	public ModelAndView formPartnerIndividualInfoDetail(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("/partnerManagement/formPartnerIndividualInfoDetailView");

		if(!device.isNormal()) {
			if(map.get("mode") != null && map.get("mode").equals("upd")) {
				List<Map<String, Object>> defaultInfo = partnerManagementService.gridPartnerIndividualDetail(map.getMap());
				List<Map<String, Object>> defaultPhoto = partnerManagementService.partnerIndividualPhotoList(map.getMap());
	
				mv.addObject("defaultInfo", defaultInfo);
				mv.addObject("defaultPhoto", defaultPhoto);
			}
			
			mv.addObject("map", map.getMap());
		}else {
//			List<Map<String,Object>> selectVendorSolutionArea= partnerManagementService.selectVendorSolutionAreaList(map.getMap());
//			mv.addObject("VendorSolutionArea", selectVendorSolutionArea);
		}

		mv.addObject("coutomerId", map.get("customer_id"));
		mv.addObject("companyId", map.get("company_id"));
		mv.addObject("searchDetail", map.get("search_detail"));
		return mv;
	}
	
	@RequestMapping(value="/partnerManagement/selectPartnerIndividualInfoList.do")
	public ModelAndView selectPartnerIndividualInfoList(CommandMap map) throws Exception{
		ModelAndView mv = null;
		if(map.get("datatype").equals("json"))
		{
			mv = new ModelAndView("jsonView");
		}
		else if(map.get("datatype").equals("html"))
		{
			mv = new ModelAndView("/partnerManagement/partnerIndividualInfoLeftAjax");
		}

		List<Map<String,Object>> gridPartnerIndividualInfo= partnerManagementService.gridPartnerIndividualInfoList(map.getMap());
		mv.addObject("rows", gridPartnerIndividualInfo);
		return mv;
	}
	
	/**
	 * @author 	: 장성훈
	 * @Date		: 2016. 7. 17.
	 * @explain	: 파트너관리 -> 파트너개인정보 관리 update
	 */
	@RequestMapping(value="/partnerManagement/updatePartnerIndividualInfo.do")
	public ModelAndView updatePartnerIndividualInfo(CommandMap map, HttpServletRequest request) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = partnerManagementService.updatePartnerIndividualInfo(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}

	/**
	 * @author 	: 장성훈
	 * @Date		: 2016. 6. 9.
	 * @explain	: 영업활동 -> 파트너개인정보 관리 delete    //  작업해야함
	 */
	@RequestMapping(value="/partnerManagement/deletePartnerIndividualInfo.do")
	public ModelAndView deletePartnerIndividualInfo(CommandMap map, HttpServletRequest request) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = partnerManagementService.deletePartnerIndividualInfo(map.getMap(), request);
		mv.addObject("cnt", cnt);
		return mv;
	}	

	/**
	 * @author 	: 장성훈
	 * @Date		: 2016. 6. 8.
	 * @explain	: 파트너관리 -> 파트너개인정보 관리 insert
	 */
	@RequestMapping(value="/partnerManagement/insertPartnerIndividualInfo.do")
	public ModelAndView insertPartnerIndividualInfo(CommandMap map, HttpServletRequest request) throws Exception{
//		ModelAndView mv = new ModelAndView("jsonView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = partnerManagementService.insertPartnerIndividualInfo(map.getMap(), request);
		mv.addObject("cnt", cnt);
		mv.addObject("returnPK", map.get("filePK"));
		return mv;
	}
	
	/**
	 * @author 	: 장성훈
	 * @Date		: 2017. 3. 22.
	 * @explain	: 파트너관리 -> 파트너정보 개인 스킬
	 */
	@RequestMapping(value="/partnerManagement/selectPartnerIndividualSkill.do")
	public ModelAndView selectPartnerIndividualSkill(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> list = partnerManagementService.partnerIndividualSkillList(map.getMap());
		mv.addObject("rows", list);

		return mv;
	}
	
	/**
	 * @explain	: 모바일 파트너사개인정보 > 현황
	 */
	@RequestMapping(value="/partnerManagement/selectPartnerIndividualCnt.do")
	public ModelAndView selectPartnerIndividualCnt(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
				
		// 전체 파트너 (파트너사 현황)
		int totalPartnerIndividualCnt = partnerManagementService.totalPartnerIndividualCnt(map.getMap());
		mv.addObject("totalPartnerIndividualCnt",  totalPartnerIndividualCnt);

		// 금주 신규파트너 (파트너사 현황)
		int partnerIndividualNewCnt = partnerManagementService.partnerIndividualNewCnt(map.getMap());
		mv.addObject("partnerIndividualNewCnt", partnerIndividualNewCnt);
		
		// 영역별 현황
		List<Map<String,Object>> selecetPartnerIndividualStatusByAreaList= partnerManagementService.selecetPartnerIndividualStatusByAreaList(map.getMap());
		mv.addObject("selecetStatusByAreaList", selecetPartnerIndividualStatusByAreaList);

		return mv;
	}
	
	/**
	 * @explain	: 모바일 파트너사개인정보 > 총개수
	 */
	@RequestMapping(value="/partnerManagement/selectPartnerIndividualInfoCount.do")
	public ModelAndView selectPartnerIndividualInfoCount(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
				
		Map<String, Object> cntMap = partnerManagementDAO.selectPartnerIndividualInfoCount(map.getMap());
		mv.addObject("listCount",  cntMap.get("listCount"));
		return mv;
	}
	
	/**
	 * @explain	: 모바일 파트너사정보 > 총개수
	 */
	@RequestMapping(value="/partnerManagement/selectPartnerCompanyCount.do")
	public ModelAndView selectPartnerCompanyCount(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		
		Map<String, Object> cntMap = partnerManagementDAO.selectPartnerCompanyCount(map.getMap());
		mv.addObject("listCount",  cntMap.get("listCount"));
		return mv;
	}
}
