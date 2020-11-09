package com.uni.sellers.admin;

import java.util.List;
import java.util.Map;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import com.uni.sellers.datasource.AbstractDAO;

@Repository("adminDAO")
public class AdminDAO extends AbstractDAO{
	 
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 12.
	 * @explain	: 관리자페이지-> 메뉴관리
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTimeLine(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectTimeLine", map);
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 12.
	 * @explain	: 관리자페이지-> 메뉴관리 -> 그리드 메뉴 리스트
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selelctMenuManageList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("admin.selelctMenuManageList", map);
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 12.
	 * @explain	: 관리자페이지-> 메뉴관리 -> 그리드 메뉴 업데이트
	 */
	@SuppressWarnings("unchecked")
	public int updateMenu(Map<String, Object> map) throws Exception{
		return (int)update("admin.updateMenu", map);
	}
	
	//메뉴삭제
	@SuppressWarnings("unchecked")
	public int deleteMenu(Map<String, Object> map) throws Exception{
		return (int)delete("admin.deleteMenu", map);
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 12.
	 * @explain	: 관리자페이지-> 메뉴관리 -> 그리드 메뉴 추가
	 */
	@SuppressWarnings("unchecked")
	public int insertMenu(Map<String, Object> map) throws Exception{
		return (int)insert("admin.insertMenu", map);
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 12.
	 * @explain	: 관리자페이지-> 권한관리 -> 권한 모두 가져오기
	 */
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAuthorityAll(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("admin.selectAuthorityAll", map);
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 12.
	 * @explain	: 관리자페이지-> 권한관리 -> 특정 멤버 권한 추가
	 */
	@SuppressWarnings("unchecked")
	public int insertMemberAuth(Map<String, Object> map) throws Exception{
		return (int)update("admin.insertMemberAuth", map);
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 12. 12.
	 * @explain	: 관리자페이지-> 권한관리 -> 특정 멤버 권한 모두 삭제
	 */
	@SuppressWarnings("unchecked")
	public int deleteMemberAuth(Map<String, Object> map) throws Exception{
		return (int)delete("admin.deleteMemberAuth", map);
	}
	
	//권한별 접근 가능 메뉴
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAuthRoleMenu(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("admin.selectAuthRoleMenu", map);
	}
	
	//회사본부 리스트
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selelctAllInfoDivisionList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("admin.selelctAllInfoDivisionList", map);
	}
	
	//회사팀 리스트
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selelctInfoTeamList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("admin.selelctInfoTeamList", map);
	}
	
	//직원정보관리 리스트
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selelctInfoMemberManageList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("admin.selelctInfoMemberManageList", map);
	}
	
	//직원정보 수정
	@SuppressWarnings("unchecked")
	public int updateInfoMember(Map<String, Object> map) throws Exception{
		return (int)update("admin.updateInfoMember", map);
	}
	
	//직원정보 추가
	@SuppressWarnings("unchecked")
	public int insertInfoMember(Map<String, Object> map) throws Exception{
		return (int)insert("admin.insertInfoMember", map);
	}
	
	//직원 ID,PW 추가
	@SuppressWarnings("unchecked")
	public int insertInfoUser(Map<String, Object> map) throws Exception{
		return (int)insert("admin.insertInfoUser", map);
	}
	
	//신규 직원 멤버권한 추가
	@SuppressWarnings("unchecked")
	public int insertRoleMember(Map<String, Object> map) throws Exception{
		return (int)insert("admin.insertRoleMember", map);
	}
	
	//정보관리(직원)페이지 직군 변경시 CRUD권한 추가
	public int insertRoleCRUD(Map<String, Object> map) throws Exception{
		return (int)insert("admin.insertRoleCRUD", map);
	}
	
	//정보관리(직원)페이지 직군 변경시 팀장 권한 추가
	public int insertRoleTeam(Map<String, Object> map) throws Exception{
		return (int)insert("admin.insertRoleTeam", map);
	}
		
	//정보관리(직원)페이지 직군 변경시 본부장 권한 추가
	public int insertRoleDivision(Map<String, Object> map) throws Exception{
		return (int)insert("admin.insertRoleDivision", map);
	}
	
	//정보관리(직원)페이지 직군 변경시 CRUD권한 삭제
	public int deleteRoleCRUD(Map<String, Object> map) throws Exception{
		return (int)delete("admin.deleteRoleCRUD", map);
	}
	
	//정보관리(직원)페이지 직군 변경시 팀장권한 삭제
	public int deleteRoleTeam(Map<String, Object> map) throws Exception{
		return (int)delete("admin.deleteRoleTeam", map);
	}
	
	//정보관리(직원)페이지 직군 변경시 본부장권한 삭제
	public int deleteRoleDivision(Map<String, Object> map) throws Exception{
		return (int)delete("admin.deleteRoleDivision", map);
	}
	
	//권한 추가
	@SuppressWarnings("unchecked")
	public int insertAuth(Map<String, Object> map) throws Exception{
		return (int)insert("admin.insertAuth", map);
	}
	
	//권한 업데이트
	@SuppressWarnings("unchecked")
	public int updateAuth(Map<String, Object> map) throws Exception{
		return (int)update("admin.updateAuth", map);
	}
	
	
	//권한별 메뉴 추가
	@SuppressWarnings("unchecked")
	public int updateRoleMenu(Map<String, Object> map) throws Exception{
		return (int)update("admin.updateRoleMenu", map);
	}
	
	//테리토리관리 전체 리스트
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectIndustrySegmentAll(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("admin.selectIndustrySegmentAll", map);
	}
	
	//선택한 직원 테리로리 리스트
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTerritoryMemberList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("admin.selectTerritoryMemberList", map);
	}
	
	//세그먼트 관련 회사 리스트
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectIndustrySegmentList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("admin.selectIndustrySegmentList", map);
	}
	
	//테리토리 추가 전 작업
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMemberTerritoryArrayList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("admin.selectMemberTerritoryArrayList", map);
	}
	
	//선택한 직원 테리토리 추가
	@SuppressWarnings("unchecked")
	public int insertMemberTerritory(Map<String, Object> map) throws Exception{
		return (int)update("admin.insertMemberTerritory", map);
	}
	
	//선택한  테리토리 삭제
	@SuppressWarnings("unchecked")
	public int deleteMemberTerritory(Map<String, Object> map) throws Exception{
		return (int)delete("admin.deleteMemberTerritory", map);
	}
	
	//산업코드 추가
	@SuppressWarnings("unchecked")
	public int insertIndustrySegment(Map<String, Object> map) throws Exception{
		return (int)insert("admin.insertIndustrySegment", map);
	}
	
	//산업코드 업데이트
	@SuppressWarnings("unchecked")
	public int updateIndustrySegment(Map<String, Object> map) throws Exception{
		return (int)update("admin.updateIndustrySegment", map);
	}
	
	//협력사분류코드 전체 리스트
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPartnerSegmentAll(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("admin.selectPartnerSegmentAll", map);
	}
	
	//협력사분류코드 추가
	@SuppressWarnings("unchecked")
	public int insertPartnerSegment(Map<String, Object> map) throws Exception{
		return (int)insert("admin.insertPartnerSegment", map);
	}
	
	//협력사분류코드 업데이트
	@SuppressWarnings("unchecked")
	public int updatePartnerSegment(Map<String, Object> map) throws Exception{
		return (int)update("admin.updatePartnerSegment", map);
	}
	
	//협력사분류코드 삭제
	@SuppressWarnings("unchecked")
	public int deletePartnerSegment(Map<String, Object> map) throws Exception{
		return (int)delete("admin.deletePartnerSegment", map);
	}
	
	//협력사분류코드 전체 리스트
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectVendorSolutionAreaAll(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("admin.selectVendorSolutionAreaAll", map);
	}
	
	//협력사분류코드 추가
	@SuppressWarnings("unchecked")
	public int insertVendorSolutionArea(Map<String, Object> map) throws Exception{
		return (int)insert("admin.insertVendorSolutionArea", map);
	}
	
	//협력사분류코드 업데이트
	@SuppressWarnings("unchecked")
	public int updateVendorSolutionArea(Map<String, Object> map) throws Exception{
		return (int)update("admin.updateVendorSolutionArea", map);
	}
	
	//제품분류코드 전체 리스트
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOurProductInfoAll(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("admin.selectOurProductInfoAll", map);
	}
	
	//제품분류코드 추가
	@SuppressWarnings("unchecked")
	public int insertOurProductInfo(Map<String, Object> map) throws Exception{
		return (int)insert("admin.insertOurProductInfo", map);
	}
	
	//제품분류코드 업데이트
	@SuppressWarnings("unchecked")
	public int updateOurProductInfo(Map<String, Object> map) throws Exception{
		return (int)update("admin.updateOurProductInfo", map);
	}
	
	//제품분류코드 삭제
	@SuppressWarnings("unchecked")
	public int deleteOurProductInfo(Map<String, Object> map) throws Exception{
		return (int)delete("admin.deleteOurProductInfo", map);
	}
	
	//직원 Target 리스트
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>>  selectMemberTarget(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>> )selectList("admin.selectMemberTarget", map);
	}
	
	//직원 Target 리스트
	@SuppressWarnings("unchecked")
	public int updateMemberTarget(Map<String, Object> map) throws Exception{
		return (int)insert("admin.updateMemberTarget", map);
	}
	
	//팀정보 입력 및 수정
	@SuppressWarnings("unchecked")
	public int insertTeamInfo(Map<String, Object> map) throws Exception{
		return (int)insert("admin.insertTeamInfo", map);
	}
	@SuppressWarnings("unchecked")
	public int updateTeamInfo(Map<String, Object> map) throws Exception{
		return (int)update("admin.updateTeamInfo", map);
	}

	/*@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSalesAct(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectSalesAct", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNewUpdate(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectNewUpdate", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectResult(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectResult", map);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCompanyResult(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("main.selectCompanyResult", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectResultGraph(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectResultGraph", map);
	}
*/	
}
