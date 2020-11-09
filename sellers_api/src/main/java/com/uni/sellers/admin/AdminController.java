package com.uni.sellers.admin;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.uni.sellers.common.CommonDAO;
import com.uni.sellers.datasource.CommandMap;
import com.uni.sellers.security.ReloadableFilterInvocationSecurityMetadataSource;

@Controller
public class AdminController {
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="adminService")
	private AdminService adminService;
	
	@Resource(name="adminDAO")
	private AdminDAO adminDAO;
	
	@Resource(name="commonDAO")
	private CommonDAO commonDAO;

	@Autowired
	private ReloadableFilterInvocationSecurityMetadataSource reloadableFilterInvocationSecurityMetadataSource;
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 12.
	 * @explain	: 관리자페이지-> 메뉴관리
	 */
	@RequestMapping(value="/admin/menuManage.do")
	public ModelAndView menuManage(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/admin/menuManage");
		//List<Map<String,Object>> selectCompanyResult = adminService.menuManage(map.getMap());
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 12.
	 * @explain	: 관리자페이지-> 메뉴관리 -> 그리드 메뉴 리스트
	 */
	@RequestMapping(value="/admin/selelctMenuManageList.do")
	public ModelAndView selelctMenuManageList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> selelctMenuManageList = adminService.selelctMenuManageList(map.getMap());
    	mv.addObject("rows", selelctMenuManageList);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 12.
	 * @explain	: 관리자페이지-> 메뉴관리 -> 그리드 메뉴 업데이트
	 */
	@RequestMapping(value="/admin/updateMenu.do")
	public ModelAndView updateMenu(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = adminService.updateMenu(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}
	
	//메뉴 삭제
	@RequestMapping(value="/admin/deleteMenu.do")
	public ModelAndView deleteMenu(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = adminDAO.deleteMenu(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 12.
	 * @explain	: 관리자페이지->권한관리 -> 그리드 권한 추가
	 */
	@RequestMapping(value="/admin/updateAuth.do")
	public ModelAndView updateAuth(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = adminService.updateAuth(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}
	
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 15.
	 * @explain	: 관리자페이지-> 권한관리 
	 */
	@RequestMapping(value="/admin/authManage.do")
	public ModelAndView authManage(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/admin/authManage");
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 15.
	 * @explain	: 관리자페이지-> 권한관리 
	 */
	@RequestMapping(value="/admin/authMemberManage.do")
	public ModelAndView authMemberManage(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/admin/authMemberManage");
		map.put("use_yn", "Y");
		List<Map<String,Object>> list = adminDAO.selectAuthorityAll(map.getMap());
		mv.addObject("authListAll", list);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 15.
	 * @explain	: 관리자페이지-> 권한관리 -> 그리드 권한 가져오기
	 */
	@RequestMapping(value="/admin/selectAuthorityAll.do")
	public ModelAndView selectAuthorityAll(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> list = adminDAO.selectAuthorityAll(map.getMap());
		mv.addObject("rows", list);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 15.
	 * @explain	: 관리자페이지-> 권한관리 (메뉴)
	 */
	@RequestMapping(value="/admin/authRoleMenu.do")
	public ModelAndView authRoleMenu(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/admin/authRoleMenu");
		map.put("use_yn", "Y");
		List<Map<String,Object>> list = adminDAO.selectAuthorityAll(map.getMap());
		List<Map<String,Object>> selelctMenuManageList = adminService.selelctMenuManageList(map.getMap());
		mv.addObject("authListAll", list);
		mv.addObject("menuList", selelctMenuManageList);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 15.
	 * @explain	: 관리자페이지-> 권한관리 (메뉴) -> 접근가능메뉴
	 */
	@RequestMapping(value="/admin/selectAuthRoleMenu.do")
	public ModelAndView selectAuthRoleMenu(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> selectAuthRoleMenu = adminService.selectAuthRoleMenu(map.getMap());
		mv.addObject("list", selectAuthRoleMenu);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 15.
	 * @explain	: 관리자페이지-> 권한관리 (메뉴) -> 등록
	 */
	@RequestMapping(value="/admin/updateRoleMenu.do")
	public ModelAndView updateRoleMenu(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = adminService.updateRoleMenu(map.getMap());
		reloadableFilterInvocationSecurityMetadataSource.reload();
		mv.addObject("cnt", cnt);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 15.
	 * @explain	: 관리자페이지-> 권한관리 (직원) -> 등록
	 */
	@RequestMapping(value="/admin/insertMemberAuth.do")
	public ModelAndView insertMemberAuth(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = adminService.insertMemberAuth(map.getMap());
		reloadableFilterInvocationSecurityMetadataSource.reload();
		mv.addObject("cnt", cnt);
		return mv;
	}
	
	//직원정보관리
	@RequestMapping(value="/admin/infoMemberManage.do")
	public ModelAndView infoMemberManage(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/admin/infoMemberManage");
		List<Map<String,Object>> selelctAllInfoDivisionList = adminService.selelctAllInfoDivisionList(map.getMap());
		List<Map<String,Object>> selelctAllInfoTeamList = adminService.selelctInfoTeamList(map.getMap());
		mv.addObject("selelctAllInfoDivisionList", selelctAllInfoDivisionList);
		mv.addObject("selelctAllInfoTeamList", selelctAllInfoTeamList);
		return mv;
	}
	
	//직원정보관리페이지 리스트
	@RequestMapping(value="/admin/selelctInfoMemberManageList.do")
	public ModelAndView selelctInfoMemberManageList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> selelctInfoMemberManageList = adminService.selelctInfoMemberManageList(map.getMap());
    	mv.addObject("rows", selelctInfoMemberManageList);
		return mv;
	}
	
	//직원정보관리 본부선택 > 팀리스트
		@RequestMapping(value="/admin/selelctInfoTeamList.do")
		public ModelAndView selelctInfoTeamList(CommandMap map) throws Exception{
			ModelAndView mv = new ModelAndView("jsonView");
			List<Map<String,Object>> selelctInfoTeamList = adminService.selelctInfoTeamList(map.getMap());
	    	mv.addObject("selelctInfoTeamList", selelctInfoTeamList);
			return mv;
		}
	
	//직원정보 수정
	@RequestMapping(value="/admin/updateInfoMember.do")
	public ModelAndView updateInfoMember(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = adminService.updateInfoMember(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}
	//직원정보관리 끝
	
	
	//직원별 고객사테레토리관리
	@RequestMapping(value="/admin/territoryMemberManage.do")
	public ModelAndView territoryMemberManage(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/admin/territoryMemberManage");
		List<Map<String,Object>> selectIndustrySegmentAll = adminDAO.selectIndustrySegmentAll(map.getMap());
		mv.addObject("industrySegmentAll", selectIndustrySegmentAll);
		return mv;
	}
	
	//선택한 직원 테레토리 리스트
	@RequestMapping(value="/admin/selectTerritoryMemberList.do")
	public ModelAndView selectTerritoryMemberList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> selectTerritoryMemberList = adminService.selectTerritoryMemberList(map.getMap());
    	mv.addObject("selectTerritoryMemberList", selectTerritoryMemberList);
		return mv;
	}
	
	//세그먼트코드 별 고객사 리스트
	@RequestMapping(value="/admin/selectIndustrySegmentList.do")
	public ModelAndView selectIndustrySegmentList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> selectIndustrySegmentList = adminService.selectIndustrySegmentList(map.getMap());
    	mv.addObject("selectIndustrySegmentList", selectIndustrySegmentList);
		return mv;
	}
	
	//선택 직원 테리토리 추가
	@RequestMapping(value="/admin/insertMemberTerritory.do")
	public ModelAndView insertMemberTerritory(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> selectMemberTerritoryArrayList = adminDAO.selectMemberTerritoryArrayList(map.getMap());
		map.put("check_list", selectMemberTerritoryArrayList);
		
		int cnt = adminService.insertMemberTerritory(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}
	
	//선택 테리토리 삭제
	@RequestMapping(value="/admin/deleteMemberTerritory.do")
	public ModelAndView deleteMemberTerritory(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = adminService.deleteMemberTerritory(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}
	//직원별 고객사테레토리관리 끝
	
	
	
	//코드관리(산업분류코드)
	@RequestMapping(value="/admin/codeIndustrySegmentManage.do")
	public ModelAndView codeIndustrySegmentManage(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/admin/codeIndustrySegmentManage");
		return mv;
	}
	
	//산업분류코드 전체 리스트
	@RequestMapping(value="/admin/selectIndustrySegmentAll.do")
	public ModelAndView selectIndustrySegmentAll(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> selectIndustrySegmentAll = adminDAO.selectIndustrySegmentAll(map.getMap());
		mv.addObject("industrySegmentAll", selectIndustrySegmentAll);
		return mv;
	}
	
	//산업코드 저장
	@RequestMapping(value="/admin/updateIndustrySegment.do")
	public ModelAndView updateIndustrySegment(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = adminService.updateIndustrySegment(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}
	
	//코드관리(협력사분류코드)
	@RequestMapping(value="/admin/codePartnerSegmentManage.do")
	public ModelAndView codePartnerSegmentManage(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/admin/codePartnerSegmentManage");
		return mv;
	}
	
	//협력사분류코드 전체 리스트
	@RequestMapping(value="/admin/selectPartnerSegmentAll.do")
	public ModelAndView selectPartnerSegmentAll(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> selectPartnerSegmentAll = adminDAO.selectPartnerSegmentAll(map.getMap());
		mv.addObject("selectPartnerSegmentAll", selectPartnerSegmentAll);
		return mv;
	}
	
	//협력사분류코드 저장
	@RequestMapping(value="/admin/updatePartnerSegment.do")
	public ModelAndView updatePartnerSegment(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = adminService.updatePartnerSegment(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}
	
	//협력사분류코드 삭제
	@RequestMapping(value="/admin/deletePartnerSegment.do")
	public ModelAndView deletePartnerSegment(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		Map<String,Object> returnMap = adminService.deletePartnerSegment(map.getMap());
		mv.addObject("returnMap", returnMap);
		return mv;
	}
	
	//코드관리(솔루션분류코드)
	@RequestMapping(value="/admin/codeVendorSolutionAreaManage.do")
	public ModelAndView codeVendorSolutionAreaManage(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/admin/codeVendorSolutionAreaManage");
		return mv;
	}
	
	//협력사분류코드 전체 리스트
	@RequestMapping(value="/admin/selectVendorSolutionAreaAll.do")
	public ModelAndView selectVendorSolutionAreaAll(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> selectVendorSolutionAreaAll = adminDAO.selectVendorSolutionAreaAll(map.getMap());
		mv.addObject("selectVendorSolutionAreaAll", selectVendorSolutionAreaAll);
		return mv;
	}
	
	//협력사분류코드 저장
	@RequestMapping(value="/admin/updateVendorSolutionArea.do")
	public ModelAndView updateVendorSolutionArea(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = adminService.updateVendorSolutionArea(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}
	
	//코드관리(제품별코드)
	@RequestMapping(value="/admin/codeOurProductInfoManage.do")
	public ModelAndView codeOurProductInfoManage(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/admin/codeOurProductInfoManage");
		return mv;
	}
	
	//제품별코드 전체 리스트
	@RequestMapping(value="/admin/selectOurProductInfoAll.do")
	public ModelAndView selectOurProductInfoAll(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> selectOurProductInfoAll = adminDAO.selectOurProductInfoAll(map.getMap());
		mv.addObject("selectOurProductInfoAll", selectOurProductInfoAll);
		return mv;
	}
	
	//제품별코드 저장
	@RequestMapping(value="/admin/updateOurProductInfo.do")
	public ModelAndView updateOurProductInfo(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = adminService.updateOurProductInfo(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}
	
	//제품별코드 삭제
	@RequestMapping(value="/admin/deleteOurProductInfo.do")
	public ModelAndView deleteOurProductInfo(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = adminService.deleteOurProductInfo(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}
	//코드관리 끝
	
	
	
	
	//직원 Target 시작

	//직원 Target 페이지 ~
	@RequestMapping(value="/admin/targetMemberManage.do")
	public ModelAndView targetMemberManage(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/admin/targetMemberManage");
		return mv;
	}
	
	//직원 Target 가져오기~
	@RequestMapping(value="/admin/selectMemberTarget.do")
	public ModelAndView selectMemberTarget(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		mv.addObject("rows", adminDAO.selectMemberTarget(map.getMap()));
		return mv;
	}
	
	//직원 Target 입력 및 수정~
	@RequestMapping(value="/admin/updateMemberTarget.do")
	public ModelAndView updateMemberTarget(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = adminService.updateMemberTarget(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}
	
	
	//본부 팀 관리 시작
	
	//본부 팀 관리 페이지 - 팀관리
	@RequestMapping(value="/admin/ourTeamManage.do")
	public ModelAndView ourTeamManage(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/admin/ourTeamManage");
		List<Map<String,Object>> selelctInfoMemberManageList = adminService.selelctInfoMemberManageList(map.getMap());
		mv.addObject("selelctInfoMemberManageList", selelctInfoMemberManageList);
		return mv;
	}
	//본부 팀 관리 페이지 - 팀관리 입력 및 수정
	@RequestMapping(value="/admin/updateTeamInfo.do")
	public ModelAndView updateTeamInfo(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = adminService.updateTeamInfo(map.getMap());
		mv.addObject("cnt", cnt);
		return mv;
	}
}