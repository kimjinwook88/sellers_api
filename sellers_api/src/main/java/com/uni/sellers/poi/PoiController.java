package com.uni.sellers.poi;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.uni.sellers.datasource.CommandMap;
import com.uni.sellers.poi.PoiService;

@Controller
public class PoiController {
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name="poiService")
	private PoiService poiService;

	@RequestMapping(value="/admin/ExcelDataUpload.do")
	public ModelAndView poiTest(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/poi/excelDataUpload");
		//List<Map<String, Object>> selectCompanyResult = adminService.menuManage(map.getMap());
		return mv;
	}

	@RequestMapping(value="/poi/xlsxDownloadExcelFile.do")
	public ModelAndView xlsxDownloadExcelFile(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int readExel = poiService.xlsxDownloadExcelFile(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}
	
	/**
	* @author 	: 최현경
	* @Date		: 2018. 10. 19.
	* @explain	: 주간보고 엑셀 다운로드
	*/
	@RequestMapping(value="/poi/weeklyReportXlsxDownload.do")
	public void test(CommandMap map, HttpServletRequest request, HttpServletResponse response) throws Exception{
		poiService.weeklyReportXlsxDownload(map.getMap(), request, response);
	}
	
	/**
	 * 성과관리 .xls 버전 컨트롤러
	 * @param map
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/poi/xlsReadErpSalesActual.do")
	public ModelAndView xlsReadErpSalesActual(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsReadErpSalesActual(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	/**
	 * 성과관리 .xlsx 버전 컨트롤러
	 * @param map
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/poi/xlsxReadErpSalesActual.do")
	public ModelAndView xlsxReadErpSalesActual(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsxReadErpSalesActual(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	//ERP 대시보드
	@RequestMapping(value="/poi/xlsxReadErpDashBoard.do")
	public ModelAndView xlsxReadErpDashBoard(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsxReadErpDashBoard(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}
	
	//ERP 대시보드
	@RequestMapping(value="/poi/xlsReadErpDashBoard.do")
	public ModelAndView xlsReadErpDashBoard(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsReadErpDashBoard(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsxReadErpSalesPlan.do")
	public ModelAndView xlsxReadErpSalesPlan(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsxReadErpSalesPlan(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsxReadClientIndividualInfo.do")
	public ModelAndView xlsxReadClientIndividualInfo(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		//		List<Map<String, Object>> readExel = poiService.xlsxReadClientIndividualInfo(map.getMap(), request);
		int readExel = poiService.xlsxReadClientIndividualInfo(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsReadClientIndividualInfo.do")
	public ModelAndView xlsReadClientIndividualInfo(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsReadClientIndividualInfo(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsDownload.do")
	public ModelAndView xlsDownload(CommandMap commandMap, HttpServletResponse response)throws Exception{
		ModelAndView mv = new ModelAndView("/poi/excelDataUpload");

		return mv;

	}

	@RequestMapping(value="/poi/xlsxReadClientCompanyInfo.do")
	public ModelAndView xlsxReadClientCompanyInfo(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsxReadClientCompanyInfo(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsReadClientCompanyInfo.do")
	public ModelAndView xlsReadClientCompanyInfo(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsReadClientCompanyInfo(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsxReadOurMembersInfo.do")
	public ModelAndView xlsxReadOurMembersInfo(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsxReadOurMembersInfo(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsReadOurMembersInfo.do")
	public ModelAndView xlsReadOurMembersInfo(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsReadOurMembersInfo(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsxReadOurDivisionInfo.do")
	public ModelAndView xlsxReadOurDivisionInfo(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsxReadOurDivisionInfo(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsReadOurDivisionInfo.do")
	public ModelAndView xlsReadOurDivisionInfo(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsReadOurDivisionInfo(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsxReadOurTeamInfo.do")
	public ModelAndView xlsxReadOurTeamInfo(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsxReadOurTeamInfo(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsReadOurTeamInfo.do")
	public ModelAndView xlsReadOurTeamInfo(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsReadOurTeamInfo(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsxReadPartnerCompanyInfo.do")
	public ModelAndView xlsxReadPartnerCompanyInfo(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		//		List<Map<String, Object>> readExel = poiService.xlsxReadPartnerCompanyInfo(map.getMap(), request);
		int readExel = poiService.xlsxReadPartnerCompanyInfo(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsReadPartnerCompanyInfo.do")
	public ModelAndView xlsReadPartnerCompanyInfo(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsReadPartnerCompanyInfo(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsxReadPartnerIndividualInfo.do")
	public ModelAndView xlsxReadPartnerIndividualInfo(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		//		List<Map<String, Object>> readExel = poiService.xlsxReadPartnerIndividualInfo(map.getMap(), request);
		int readExel = poiService.xlsxReadPartnerIndividualInfo(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsReadPartnerIndividualInfo.do")
	public ModelAndView xlsReadPartnerIndividualInfo(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsReadPartnerIndividualInfo(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsxReadCodeIndustrySegment.do")
	public ModelAndView xlsxReadCodeIndustrySegment(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsxReadCodeIndustrySegment(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsReadCodeIndustrySegment.do")
	public ModelAndView xlsReadCodeIndustrySegment(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsReadCodeIndustrySegment(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsxReadCodePartnerSegment.do")
	public ModelAndView xlsxReadCodePartnerSegment(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsxReadCodePartnerSegment(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsReadCodePartnerSegment.do")
	public ModelAndView xlsReadCodePartnerSegment(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsReadCodePartnerSegment(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsxReadVendorSolutionArea.do")
	public ModelAndView xlsxReadVendorSolutionArea(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsxReadVendorSolutionArea(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsReadVendorSolutionArea.do")
	public ModelAndView xlsReadVendorSolutionArea(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsReadVendorSolutionArea(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsxReadErpCompanyCredit.do")
	public ModelAndView xlsxReadErpCompanyCredit(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsxReadErpCompanyCredit(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsReadErpCompanyCredit.do")
	public ModelAndView xlsReadErpCompanyCredit(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsReadErpCompanyCredit(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsxReadErpSalesProject.do")
	public ModelAndView xlsxReadErpSalesProject(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsxReadErpSalesProject(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsReadErpSalesProject.do")
	public ModelAndView xlsReadErpSalesProject(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsReadErpSalesProject(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsxReadErpCompanyAr.do")
	public ModelAndView xlsxReadErpCompanyAr(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsxReadErpCompanyAr(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}

	@RequestMapping(value="/poi/xlsReadErpCompanyAr.do")
	public ModelAndView xlsReadErpCompanyAr(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String, Object>> readExel = poiService.xlsReadErpCompanyAr(map.getMap(), request);
		mv.addObject("rows", readExel);
		return mv;
	}




	@RequestMapping(value="/poi/insert.do")
	public ModelAndView insert(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = poiService.insert(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}
	
	

}
