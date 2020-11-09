package com.uni.sellers.duzon;

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
public class DuzonController {
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="duzonService")
	private DuzonService duzonService;
	
	@Resource(name="duzonDAO")
	private DuzonDAO duzonDAO;
	
	@Resource(name="commonDAO")
	private CommonDAO commonDAO;
	
	/**
	* @author 	: 봉준
	* @Date		: 2018. 03. 08.
	* @explain	: 사원명부
	*/
	@RequestMapping(value="/duzon/selectOurMemberInfo.do")
	public void selectOurMemberInfo(CommandMap map, Device device) throws Exception{
		duzonService.selectOurMemberInfo(map.getMap());
		duzonService.selectOurMemberInfo2(map.getMap());
	}
	
	/**
	* @author 	: 욱2
	* @Date		: 2018. 03. 16.
	* @explain	: 부서
	*/
	@RequestMapping(value="/duzon/selectOurDivisionInfo.do")
	public void selectOurDivisionInfo(CommandMap map, Device device) throws Exception{
		List<Map<String, Object>> list = duzonService.selectOurDivisionInfo(map.getMap());
		duzonService.selectOurDivisionInfo2(map.getMap(), list);
	}
	
	/**
	 * @author 	: 욱2
	 * @Date		: 2018. 03. 16.
	 * @explain	: 팀
	 */
	@RequestMapping(value="/duzon/selectOurTeamInfo.do")
	public void selectOurTeamInfo(CommandMap map, Device device) throws Exception{
		List<Map<String, Object>> list = duzonService.selectOurTeamInfo(map.getMap());
		duzonService.selectOurTeamInfo2(map.getMap(), list);
	}
	
	/**
	 * @author 	: 욱2
	 * @Date		: 2018. 04. 18.
	 * @explain	: 사전손익 연동
	 */
	@RequestMapping(value="/duzon/selectSfaPfls.do")
	public void selectSfaPfls(CommandMap map, Device device) throws Exception{
		//duzonService.deleteSfaPfls(null);
		duzonService.selectSfaPfls(null);
	}
	
	/**
	 * @author 	: 욱2
	 * @Date		: 2018. 04. 18.
	 * @explain	: 개인별달성현황 연동
	 */
	@RequestMapping(value="/duzon/selectErpSalesActual.do")
	public void selectErpSalesActual(CommandMap map, Device device) throws Exception{
		duzonService.selectErpSalesActual(null);
	}
	
	/**
	 * @author 	: 욱2
	 * @Date		: 2018. 04. 18.
	 * @explain	: 사전손익 -> 영업기회 연동
	 */
	@RequestMapping(value="/duzon/updateOppToInst.do")
	public void updateOppToInst(CommandMap map, Device device) throws Exception{
		duzonService.updateOppToInst(null);
	}
	
    
	/**
	 * @author 	: 욱2
	 * @Date		: 2018. 04. 18.
	 * @explain	: 주간보고서 연동
	 */
	@RequestMapping(value="/duzon/selectDashBoardCheckList.do")
	public void selectDashBoardCheckList(CommandMap map, Device device) throws Exception{
		duzonService.selectDashBoardCheckList(null);
	}
	
	/**
	* @author 	: 봉준
	* @Date		: 2018. 03. 08.
	* @explain	: 매출목표
	*/
	@RequestMapping(value="/duzon/selectSalesGoalInfo.do")
	public void selectSalesGoalInfo(CommandMap map, Device device) throws Exception{
		duzonService.selectSalesGoalInfo(map.getMap());
	}
	
	/**
	* @author 	: 봉준
	* @Date		: 2018. 03. 08.
	* @explain	: 신용평가현황
	*/
	@RequestMapping(value="/duzon/selectCreditRatingStatusInfo.do")
	public void selectCreditRatingStatusInfo(CommandMap map, Device device) throws Exception{
		duzonService.selectCreditRatingStatusInfo(map.getMap());
	}
	
	/**
	* @author 	: 봉준
	* @Date		: 2018. 03. 22.
	* @explain	: 고객사정보
	*/
	@RequestMapping(value="/duzon/selectClientCompanyInfo.do")
	public void selectClientCompanyInfo(CommandMap map, Device device) throws Exception{
		duzonService.selectClientCompanyInfo(map.getMap());
		duzonService.updateCloseClientIndividualinfo(map.getMap());
	}
	
	/**
	* @author 	: 봉준
	* @Date		: 2018. 03. 22.
	* @explain	: 거래처대표정보
	*/
	@RequestMapping(value="/duzon/selectClientSalesmanInfo.do")
	public void selectClientSalesmanInfo(CommandMap map, Device device) throws Exception{
		duzonService.selectClientSalesmanInfo(map.getMap());
	}
	
	/**
	 * @author 	: 봉준
	 * @Date		: 2018. 03. 22.
	 * @explain	: 거래처대표정보
	 */
	@RequestMapping(value="/duzon/selectClientSalesmanInfo2.do")
	public ModelAndView selectClientSalesmanInfo2(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		duzonService.selectClientSalesmanInfo(map.getMap());
		return mv;
	}
	
	/**
	* @author 	: 봉준
	* @Date		: 2018. 03. 22.
	* @explain	: 품목정보
	*/
	@RequestMapping(value="/duzon/selectOurProductInfo.do")
	public void selectOurProductInfo(CommandMap map, Device device) throws Exception{
		duzonService.selectOurProductInfo(map.getMap());
	}
	
	/**
	* @author 	: 봉준
	* @Date		: 2018. 03. 22.
	* @explain	: 공통코드정보(프로젝트형태, 영업구분)
	*/
	@RequestMapping(value="/duzon/selectComCode.do")
	public void selectComCode(CommandMap map, Device device) throws Exception{
		duzonService.selectComCode(map.getMap());
	}
	
	/**
	 * @author 	: 욱
	 * @Date		: 2018. 04. 18.
	 * @explain	: 더존 영업기회로 전환
	 */
	@RequestMapping(value="/duzon/updateOppToErp.do")
	public ModelAndView updateOppToErp(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		duzonService.selectOppToErp(map.getMap()); //select
		duzonService.updateOppToErp(map.getMap()); //update
		duzonDAO.updateOppNo(map.getMap()); //opp_id update
		return mv;
	}
	
	/**
	 * @author 	: 욱
	 * @Date		: 2018. 04. 19.
	 * @explain	: 더존 영업기회 프로젝트 코드 있는것들만 연동
	 */
	@RequestMapping(value="/duzon/selectErpSfaSoptyH.do")
	public ModelAndView selectErpSfaSoptyH(CommandMap map, Device device) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		duzonService.selectErpSfaSoptyH(map.getMap());
		return mv;
	}
	
	
	/**
	 * @author 	: 봉준
	 * @Date		: 2018. 05. 30.
	 * @explain	: 거래처대표 검색
	 */
	@RequestMapping(value="/duzon/searchSalesManInfo.do")
	public ModelAndView searchSalesManInfo(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> list = duzonDAO.searchSalesManInfo(map.getMap());
		mv.addObject("list", list);
		return mv;
	}
}
