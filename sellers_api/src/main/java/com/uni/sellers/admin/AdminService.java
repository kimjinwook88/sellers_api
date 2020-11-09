package com.uni.sellers.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.uni.sellers.common.CommonDAO;
import com.uni.sellers.partnermanagement.PartnerManagementDAO;
import com.uni.sellers.poi.PoiDAO;
import com.uni.sellers.util.CommonFileUtils;
import com.uni.sellers.util.CommonUtils;

@Service("adminService")
public class AdminService{
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name="commonFileUtils")
	private CommonFileUtils commonFileUtils;
	
	@Resource(name="adminDAO")
	private AdminDAO adminDAO;
	
	@Resource(name="commonDAO")
	private CommonDAO commonDAO;
	
	@Resource(name="poiDAO")
	private PoiDAO poiDAO;
	
	@Resource(name = "partnerManagementDAO")
	private PartnerManagementDAO partnerManagementDAO;
	
	@Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 12.
	 * @explain	: 관리자페이지-> 메뉴관리
	 */
	public List<Map<String, Object>> menuManage(Map<String, Object> map) throws Exception {
		return adminDAO.selectTimeLine(map);
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 12.
	 * @explain	: 관리자페이지-> 메뉴관리 -> 그리드 메뉴 리스트
	 */
	@Cacheable("commonCache")
	public List<Map<String, Object>> selelctMenuManageList(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> menuList = adminDAO.selelctMenuManageList(map);
		List<Map<String, Object>> actionGridList = new ArrayList<Map<String, Object>>();
		//mysql 재귀쿼리 안돼서 java로 구현
		int menu_lv = 1;
		for(int i=0; i<menuList.size(); i++){
			if(menuList.get(i).get("MENU_LEVEL") != null && !"".equals(menuList.get(i).get("MENU_LEVEL"))){
				//최상위 메뉴 ID가져와서 MENU_ID랑 MENU_PARENT가 같은것
				if(menu_lv == (int)menuList.get(i).get("MENU_LEVEL")){ 
					actionGridList.add(menuList.get(i));
					for(int j=0; j<menuList.size(); j++){
						if(menuList.get(i).get("MENU_ID").equals(menuList.get(j).get("MENU_PARENT"))){
							actionGridList.add(menuList.get(j));
						}
					}
				}
			}
		}
		return actionGridList;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 12.
	 * @explain	: 관리자페이지-> 메뉴관리 -> 그리드 메뉴 업데이트
	 */
	public int updateMenu(Map<String, Object> map) throws Exception {
		int cnt = 0;
		//메뉴 리스트
		ArrayList<HashMap<String, Object>> menuList = CommonUtils.jsonList((map.get("menuList")).toString());
		for(Map<String,Object> menuMap : menuList){
			if(CommonUtils.isEmpty(menuMap.get("MENU_ID"))){
				cnt = adminDAO.insertMenu(menuMap);
			}else{
				cnt = adminDAO.updateMenu(menuMap);
			}
		}
		return cnt;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 12.
	 * @explain	: 관리자페이지-> 권한관리 -> 그리드 권한 추가
	 */
	public int updateAuth(Map<String, Object> map) throws Exception {
		int cnt = 0;
		//메뉴 리스트
		ArrayList<HashMap<String, Object>> authList = CommonUtils.jsonList((map.get("authList")).toString());
		for(Map<String,Object> authMap : authList){
			if(CommonUtils.isEmpty(authMap.get("AUTHORITY_ID"))){
				cnt = adminDAO.insertAuth(authMap);
			}else{
				cnt = adminDAO.updateAuth(authMap);
			}
		}
		return cnt;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 12.
	 * @explain	: 관리자페이지-> 권한관리(메뉴) -> 권한별 메뉴 입력
	 */
	public int updateRoleMenu(Map<String, Object> map) throws Exception {
		int cnt = 0;
		if(CommonUtils.isEmpty(map.get("menu_list"))){
			map.put("menu_list","");
		}
		cnt = adminDAO.updateRoleMenu(map);
		return cnt;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 12.
	 * @explain	: 관리자페이지-> 메뉴관리 -> 그리드 메뉴 업데이트
	 */
	public int insertMemberAuth(Map<String, Object> map) throws Exception {
		int cnt = 0;
		cnt = adminDAO.deleteMemberAuth(map);
		if(!CommonUtils.isEmpty(map.get("auth_list"))){
			String arr[] = map.get("auth_list").toString().split(",");
			for(int i=0; i<arr.length; i++){
				map.put("auth_code", arr[i]);
				cnt = adminDAO.insertMemberAuth(map);
			}
		}
		return cnt;
	}
	
	//권한별 접근 가능 메뉴
	public List<Map<String, Object>> selectAuthRoleMenu(Map<String, Object> map) throws Exception {
		return adminDAO.selectAuthRoleMenu(map);
	}
	
	//회사본부 리스트
	public List<Map<String, Object>> selelctAllInfoDivisionList(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> list = adminDAO.selelctAllInfoDivisionList(map);
		return list;
	}
	
	//회사팀 리스트
	public List<Map<String, Object>> selelctInfoTeamList(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> list = adminDAO.selelctInfoTeamList(map);
		return list;
	}
	
	//직원정보관리 리스트
	public List<Map<String, Object>> selelctInfoMemberManageList(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> list = adminDAO.selelctInfoMemberManageList(map);
		return list;
	}
	
	//직원정보 수정
	public int updateInfoMember(Map<String, Object> map) throws Exception {
		int cnt = 0;
		//메뉴 리스트
		ArrayList<HashMap<String, Object>> memberList = CommonUtils.jsonList((map.get("memberList")).toString());
		for(Map<String,Object> memberMap : memberList){
			if(CommonUtils.isEmpty(memberMap.get("MEMBER_ID"))){
				cnt = adminDAO.insertInfoMember(memberMap);
				//로그인 정보 추가
				String user_pw = "uni123";
				memberMap.put("user_pw", bcryptPasswordEncoder.encode(user_pw));
				adminDAO.insertInfoUser(memberMap); 
				
				//신규직원 멤버권한추가
				adminDAO.insertRoleMember(memberMap);
			}else{
				cnt = adminDAO.updateInfoMember(memberMap);
			}
			
			//직군 수정시 권한 수정
			//임원, 관리직, 영업직
			if(!memberMap.get("POSITION_TYPE").equals(memberMap.get("POSITION_TYPE2"))){
				// 0 : 공란, 기술직(권한x) // 1 : 임원, 영업직(CRUD권한) // 2 : 관리직(CRUD, 팀장, 본부장 권한)
				int positionTypeNow = -1; //현 직군
				int positionTypePrev = -1; //전 직군
				if(memberMap.get("POSITION_TYPE").equals("") || memberMap.get("POSITION_TYPE").equals("기술직")){
					positionTypeNow = 0;
				}else if(memberMap.get("POSITION_TYPE").equals("임원") || memberMap.get("POSITION_TYPE").equals("영업직")){
					positionTypeNow = 1;
				}else if(memberMap.get("POSITION_TYPE").equals("관리직")){
					positionTypeNow = 2;
				}
				
				if(memberMap.get("POSITION_TYPE2").equals("") || memberMap.get("POSITION_TYPE2").equals("기술직")){
					positionTypePrev = 0;
				}else if(memberMap.get("POSITION_TYPE2").equals("임원") || memberMap.get("POSITION_TYPE2").equals("영업직")){
					positionTypePrev = 1;
				}else if(memberMap.get("POSITION_TYPE2").equals("관리직")){
					positionTypePrev = 2;
				}
				
				//CRUD, 팀장, 본부장 권한 삭제 or 추가
				if(positionTypePrev == 0 && positionTypeNow == 1){
					adminDAO.insertRoleCRUD(memberMap);
				}else if(positionTypePrev == 0 && positionTypeNow == 2){
					adminDAO.insertRoleCRUD(memberMap);
					adminDAO.insertRoleTeam(memberMap);
					adminDAO.insertRoleDivision(memberMap);
				}else if(positionTypePrev == 1 && positionTypeNow == 0){
					adminDAO.deleteRoleCRUD(memberMap);
				}else if(positionTypePrev == 1 && positionTypeNow == 2){
					adminDAO.insertRoleTeam(memberMap);
					adminDAO.insertRoleDivision(memberMap);
				}else if(positionTypePrev == 2 && positionTypeNow == 0){
					adminDAO.deleteRoleCRUD(memberMap);
					adminDAO.deleteRoleTeam(memberMap);
					adminDAO.deleteRoleDivision(memberMap);
				}else if(positionTypePrev == 2 && positionTypeNow == 1){
					adminDAO.deleteRoleTeam(memberMap);
					adminDAO.deleteRoleDivision(memberMap);
				}
				
			}
			
		}
		
		return cnt;
	}
	
	//선택한 직원 테리토리 리스트
	public List<Map<String, Object>> selectTerritoryMemberList(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> list = adminDAO.selectTerritoryMemberList(map);
		return list;
	}
	
	//세그먼트 관련 회사 리스트
	public List<Map<String, Object>> selectIndustrySegmentList(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> list = adminDAO.selectIndustrySegmentList(map);
		return list;
	}
	
	//선택한 직원 테리토리 추가
	public int insertMemberTerritory(Map<String, Object> map) throws Exception {
		int cnt = 0;
		if(!CommonUtils.isEmpty(map.get("company_list"))){
			String arr[] = map.get("company_list").toString().split(",");
			for(int i=0; i<arr.length; i++){
				map.put("company_id", arr[i]);
				cnt = adminDAO.insertMemberTerritory(map);
			}
		}
		return cnt;
	}
	
	//선택한 테리토리 삭제
	public int deleteMemberTerritory(Map<String, Object> map) throws Exception {
		int cnt = 0;
		cnt = adminDAO.deleteMemberTerritory(map);
		return cnt;
	}
	
	//산업코드 저장
	public int updateIndustrySegment(Map<String, Object> map) throws Exception {
		int cnt = 0;
		//메뉴 리스트
		ArrayList<HashMap<String, Object>> industrySegmentList = CommonUtils.jsonList((map.get("industrySegmentList")).toString());
		for(Map<String,Object> industrySegmentMap : industrySegmentList){
			if(CommonUtils.isEmpty(adminDAO.selectIndustrySegmentAll(industrySegmentMap))){
				cnt = adminDAO.insertIndustrySegment(industrySegmentMap);
			}else if(!industrySegmentMap.get("SEGMENT_CODE").toString().equals("")){
				cnt = adminDAO.updateIndustrySegment(industrySegmentMap);
			}
		}
		return cnt;
	}
	
	//협력사분류코드 저장
	public int updatePartnerSegment(Map<String, Object> map) throws Exception {
		int cnt = 0;
		//메뉴 리스트
		
		//PARTNER_CODE = 기존 값 
		//PARTNER_CODE_NAME = 새로 입력하거나 수정한 값
		ArrayList<HashMap<String, Object>> partnerSegmentList = CommonUtils.jsonList((map.get("PartnerSegmentList")).toString());
		for(Map<String,Object> partnerSegmentMap : partnerSegmentList){
			if(CommonUtils.isEmpty(partnerSegmentMap.get("PARTNER_CODE").toString())){
				cnt = adminDAO.insertPartnerSegment(partnerSegmentMap);
				//신규 등록 시 파트너사 협업에 추가
				partnerSegmentMap.put("create_id", map.get("global_member_id"));
				cnt = partnerManagementDAO.createSalesLinkage(partnerSegmentMap);
			}else{
				if(adminDAO.updatePartnerSegment(partnerSegmentMap) > 0){ //코드 테이블 변경
					if(partnerSegmentMap.get("USE_YN").toString().equals("Y")){//사용이 N -> Y 로 바뀔경우 파트너사 협업에 있는지 확인해서 추가
						if(partnerManagementDAO.selectSalesLinkageCodeCount(partnerSegmentMap.get("PARTNER_CODE").toString()) == 0){
							partnerSegmentMap.put("create_id", map.get("global_member_id"));
							cnt = partnerManagementDAO.createSalesLinkage(partnerSegmentMap);
						}else{
							//변경시 파트너사 협업에 변경
							cnt = partnerManagementDAO.updateSalesLinkageCode(partnerSegmentMap);
						}
					}
				}
			}
		}
		return cnt;
	}
	
	public Map<String,Object> deletePartnerSegment(Map<String, Object> map) {
		Map<String, Object> msgMap = new HashMap<String,Object>();
		try {
			adminDAO.deletePartnerSegment(map);
			msgMap.put("cnt", 1);
		}  /*catch (MySQLIntegrityConstraintViolationException e) {
			log.debug("뭐여");
			msgMap.put("error_msg", "벤더사에서 사용하고 있는 코드입니다.");
			msgMap.put("cnt", 0);
		}*/ catch(Exception e){
			msgMap.put("error_msg", "벤더사에서 사용하고 있는 코드입니다.");
			msgMap.put("cnt", 0);
		}
		return msgMap;
	}
	
	//협력사분류코드 저장
	public int updateVendorSolutionArea(Map<String, Object> map) throws Exception {
		int cnt = 0;
		//메뉴 리스트
		ArrayList<HashMap<String, Object>> vendorSolutionAreaList = CommonUtils.jsonList((map.get("vendorSolutionAreaList")).toString());
		for(Map<String,Object> vendorSolutionAreaMap : vendorSolutionAreaList){
			if(CommonUtils.isEmpty(vendorSolutionAreaMap.get("SOLUTION_ID"))){
				cnt = adminDAO.insertVendorSolutionArea(vendorSolutionAreaMap);
			}else{
				cnt = adminDAO.updateVendorSolutionArea(vendorSolutionAreaMap);
			}
		}
		return cnt;
	}
	
	
	//협력사분류코드 저장
	public int updateOurProductInfo(Map<String, Object> map) throws Exception {
		int cnt = 0;
		//메뉴 리스트
		ArrayList<HashMap<String, Object>> OurProductInfoList = CommonUtils.jsonList((map.get("OurProductInfoList")).toString());
		for(Map<String,Object> ourProductInfoMap : OurProductInfoList){
			if(CommonUtils.isEmpty(ourProductInfoMap.get("PRODUCT_NO"))){
				cnt = adminDAO.insertOurProductInfo(ourProductInfoMap);
			}else{
				cnt = adminDAO.updateOurProductInfo(ourProductInfoMap);
			}
		}
		return cnt;
	}
	
	//협력사분류코드 삭제
	public int deleteOurProductInfo(Map<String, Object> map) {
		int cnt = 0;
		try {
			cnt = adminDAO.deleteOurProductInfo(map);
		} catch (Exception e) {
			e.printStackTrace();
			cnt = -1;
			return cnt;
		}
		return cnt;
	}
	
	// 직원 Target 입력
	public int updateMemberTarget(Map<String,Object> map) throws Exception {
		int cnt = 0;
		ArrayList<HashMap<String, Object>> memberTargetList = CommonUtils.jsonList((map.get("memberTargetList")).toString());
		for(Map<String,Object> memberTargetMap : memberTargetList){
			memberTargetMap.put("searchTargetYear",map.get("searchTargetYear"));

			//기존에 Target 있는지 확인해서 update insert 구분.. sql에서
			//12달 루프~
			for(int i=1; i<=12; i++){
				memberTargetMap.put("MONTH",i);
				memberTargetMap.put("TARGET_REV",memberTargetMap.get("TARGET_REV_"+i));
				memberTargetMap.put("TARGET_GP",memberTargetMap.get("TARGET_GP_"+i));
				cnt = adminDAO.updateMemberTarget(memberTargetMap);
			}
		}
		
		return cnt;
	}
	
	
	//팀 정보 입력 및 수정
	public int updateTeamInfo(Map<String, Object> map) throws Exception {
		int cnt = 0;
		//메뉴 리스트
		ArrayList<HashMap<String, Object>> teamList = CommonUtils.jsonList((map.get("teamList")).toString());
		for(Map<String,Object> teamMap : teamList){
			if(CommonUtils.isEmpty(teamMap.get("TEAM_NO"))){
				cnt = adminDAO.insertTeamInfo(teamMap);
			}else{
				cnt = adminDAO.updateTeamInfo(teamMap);
			}
		}
		return cnt;
	}
}
