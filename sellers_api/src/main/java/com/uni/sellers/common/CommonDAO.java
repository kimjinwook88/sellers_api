package com.uni.sellers.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import com.uni.sellers.datasource.AbstractDAO;

@Repository("commonDAO")
public class CommonDAO extends AbstractDAO{
	
	@SuppressWarnings("unchecked")
	public int insertSendQ(Map<String, Object> map) throws Exception{
		return (int)insert("common.insertSendQ", map);
	}


	@SuppressWarnings("unchecked")
	public Map<String, Object> selectLoginProccess(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("common.selectLoginProccess", map);
	}

	@SuppressWarnings("unchecked")
	public String selectLatelyUpdate(Map<String, Object> map) throws Exception{
		return (String)selectOne("common.selectLatelyUpdate", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAuthority(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("common.selectAuthority", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCompanyGroup() throws Exception{
		return (List<Map<String, Object>>)selectList("common.selectCompanyGroup");
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchCompanyInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("common.searchCompanyInfo", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchCustomerInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("common.searchCustomerInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchClientInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("common.searchClientInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchClientMaster(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("common.searchClientMaster", map);
	}

	//이름으로 검색
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchMemberInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("common.searchMemberInfo", map);
	}

	//아이디로 검색 추후 통합..
	@SuppressWarnings("unchecked")
	public Map<String, Object> searchMemberInfo2(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("common.searchMemberInfo2", map);
	}

	//메일공유 로그 insert
	//공유테이블이름, PK, 보낸사람, 받는사람
	@SuppressWarnings("unchecked")
	public int insertEmailShareLog(String tableName, int pkNo, String toMemberId, String fromMemberId) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reference_table_name",tableName);
		map.put("reference_id", pkNo);
		map.put("from_member_id", fromMemberId);
		map.put("to_member_id", toMemberId);
		return (int)insert("common.insertEmailShareLog", map);
	}


	//캘린더 초대 직원 검색
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchCalendarMemberInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("common.searchCalendarMemberInfo", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectInviteMemberInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("common.selectInviteMemberInfo", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchPartnerInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("common.searchPartnerInfo", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchPartnerMemberInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("common.searchPartnerMemberInfo", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchInviteMemberInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("common.searchInviteMemberInfo", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPartnerInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("common.selectPartnerInfo", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("common.selectFileInfo", map);
	}

	@SuppressWarnings("unchecked")
	public int insertFile(Map<String, Object> map) throws Exception{
		return (int)insert("common.insertFile", map);
	}

	@SuppressWarnings("unchecked")
	public int deleteFile(Map<String, Object> map) throws Exception{
		return (int)delete("common.deleteFile", map);
	}

	@SuppressWarnings("unchecked")
	public int insertNotice(Map<String, Object> map) throws Exception{
		return (int)insert("common.insertNotice", map);
	}

	@SuppressWarnings("unchecked")
	public int selectNoticeCount(Map<String, Object> map) throws Exception{
		return (int)selectOne("common.selectNoticeCount", map);
	}
	
	@SuppressWarnings("unchecked")
	@Cacheable("commonCache")
	public List<Map<String, Object>> searchProductInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("common.searchProductInfo", map);
	}

	@SuppressWarnings("unchecked")
	@Cacheable("commonCache")
	public List<Map<String, Object>> selectCalendarAlarmInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("common.selectCalendarAlarmInfo", map);
	}

	@SuppressWarnings("unchecked")
	public int insertShareCalendarNotice(Map<String, Object> map) throws Exception{
		return (int)insert("common.insertShareCalendarNotice", map);
	}

	@SuppressWarnings("unchecked")
	public int updateNotice(Map<String, Object> map) throws Exception{
		return (int)update("common.updateNotice", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateProductividyRRuleEvent(Map<String, Object> map) throws Exception{
		return (int)update("common.updateProductividyRRuleEvent", map);
	}

	//권한별 접근 가능한 URL 조회
	@SuppressWarnings("unchecked")
	public  List<Map<String, Object>> selectRolesAndUrl() throws Exception{
		return (List<Map<String, Object>>)selectList("common.selectRolesAndUrl");
	}

	@SuppressWarnings("unchecked")
	public int updatePassword(Map<String, Object> map) throws Exception{
		return (int)update("common.updatePassword", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNoticeDetail(Map<String, Object> map) throws Exception{
		//update("common.updateNoticeConfirm", map);
		return (List<Map<String, Object>>)selectList("common.selectNoticeDetail", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCalendarShareTable(Map<String, Object> map) throws Exception{
		//update("common.updateNoticeConfirm", map);
		return (List<Map<String, Object>>)selectList("common.selectCalendarShareTable", map);
	}

	@SuppressWarnings("unchecked")
	public int updateNoticeDetail(Map<String, Object> map) throws Exception{
		return (int)update("common.updateNoticeConfirm", map);
	}

	//Menu
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMenu(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("common.selectMenu", map);
	}
	//심윤영... 사진 경로 업데이트
	@SuppressWarnings("unchecked")
	public void updateFile(Map<String, Object> map) throws Exception{
		update("common.updateFile", map);
	}
	//심윤영
	@SuppressWarnings("unchecked")
	public int deletePhoto(Map<String, Object> map) throws Exception{
		return (int)delete("common.deletePhoto", map);
	}
	
	@SuppressWarnings("unchecked")
	public void deleteNoticeDetail(Map<String, Object> map) throws Exception{
		delete("common.deleteNoticeDetail", map);
	}

	//Schedule(생산성)
	@SuppressWarnings("unchecked")
	public int callFaceTime(String currentDate) throws Exception{
		return (int)update("common.callFaceTime", currentDate);
	}

	//생산성 반복일정 insert
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProductividyRRuleEvent(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("common.selectProductividyRRuleEvent", map);
	}
	
	//Schedule(영업기회)
	@SuppressWarnings("unchecked")
	public int callOpportunity() throws Exception{
		return (int)update("common.callOpportunity", null);
	}

	//제품별 코드 가져오기
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProductList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("common.selectProductList", map);
	}
	
	//코칭톡 입력
	@SuppressWarnings("unchecked")
	public int insertCoachingTalk(Map<String, Object> map) throws Exception{
		return (int)insert("common.insertCoachingTalk", map);
	}
	
	//코칭톡 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCoachingTalk(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("common.selectCoachingTalk", map);
	}
	
	//로그인 히스토리
	public void insertLoginHistory(Map<String, Object> map){
		insert("common.insertLoginHistory", map);
	}
	
	//로그아웃 히스토리
	public void updateLogoutHistory(Map<String, Object> map){
		update("common.updateLogoutHistory", map);
	}
	
	//페이지 접근 기록
	public void insertPageContatct(Map<String, Object> map){
		insert("common.insertPageContatct", map);
	}
	
	//ERP Proejct 코드 연동
	public void callErpDashboardCheckList(){
		update("common.callErpDashboardCheckList", null);
	}
	
	//영업기회 sales cycle update
	public void callUpdateOpportunitySalesCycle(){
		update("common.callUpdateOpportunitySalesCycle", null);
	}
	
	//SLECT 1 조회
	public void select1(){
		selectOne("common.select1", null);
	}
	
	//첨부파일 삭제 후 리로드
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> reloadFile(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("common.reloadFile", map);
	}
	
	//
	@SuppressWarnings("unchecked")
	public int selectUserPageRowCount(Map<String, Object> map) throws Exception{
		return (int)selectOne("common.selectUserPageRowCount", map);
	}
	
	//사용자 특정날짜 생산성 조회
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectMemberFaceTime(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("common.selectMemberFaceTime", map);
	}
	
	//사용자  생산성 고객컨택시간 수정 
	@SuppressWarnings("unchecked")
	public int updateMemberFaceTime(Map<String, Object> map) throws Exception{
		return (int)update("common.updateMemberFaceTime", map);
	}
	
	//사용자 생산성 생성
	@SuppressWarnings("unchecked")
	public int insertMemberFaceTime(Map<String, Object> map){
		return (int)insert("common.insertMemberFaceTime", map);
	}

	//최영완
	//로그아웃 할때 사용자 토큰값 제거
	@SuppressWarnings("unchecked")
	public int deleteLogOutToken(Map<String, Object> map) throws Exception{
		return (int)delete("common.deleteLogOutToken", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMenuSub(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>) selectList("common.selectMenuSub", map);
	}
}