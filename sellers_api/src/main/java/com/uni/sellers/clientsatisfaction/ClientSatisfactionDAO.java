package com.uni.sellers.clientsatisfaction;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.uni.sellers.datasource.AbstractDAO;

@Repository("clientSatisfactionDAO")
public class ClientSatisfactionDAO extends AbstractDAO{

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> clientContactFileList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientSatisfaction.clientContactFileList", map);
	}

	//셀러스 standard 버전 작업//////////////////////////////////////////

	//고객이슈 대시보드 _ 본부
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientIssueDashBoardDivision(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientSatisfaction.selectClientIssueDashBoardDivision", map);
	}

	//고객이슈 대시보드 _ 팀
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientIssueDashBoardTeam(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientSatisfaction.selectClientIssueDashBoardTeam", map);
	}

	//고객이슈 대시보드 _ 직원
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientIssueDashBoardMember(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientSatisfaction.selectClientIssueDashBoardMember", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectClientIssue(Map<String, Object> map) throws Exception{
		Map<String, Object> groupMap = new HashMap<String, Object>();
		groupMap.put("issue_category",selectList("clientSatisfaction.clientIssueSearchDetailGroup1", map));
		groupMap.put("company_name",selectList("clientSatisfaction.clientIssueSearchDetailGroup2", map));
		return groupMap;
	}
	
	/**
	 * @explain : 모바일 고객만족 -> 고객이슈 -> 고객이슈 접수 및 처리현황 테이블 data
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientIssueStatus(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientSatisfaction.selectClientIssueStatus", map);
	}
	
	/**
	 * @explain : 모바일 고객만족 -> 고객이슈 -> 이슈 종류별 테이블 data
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientIssueTypeStatus(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientSatisfaction.selectClientIssueTypeStatus", map);
	}
	
	/**
	 * @explain : 모바일 고객만족 -> 고객만족 -> 고객이슈 현황
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectClientIssueStatusCount(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientSatisfaction.selectClientIssueStatusCount", map);
	}
	
	/**
	 * @explain : 모바일 고객영업활동 -> 영업기회 -> 팀이름 리스트
	 */
	@SuppressWarnings("unchecked")
	public  List<HashMap<String, Object>> selectTeamNameList(Map<String, Object> map) throws Exception{
		return (List<HashMap<String, Object>>)selectList("common.selectNameList", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectIssueCount(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientSatisfaction.selectIssueCount", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientIssueList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientSatisfaction.selectClientIssueList", map);
	}


	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSolvePlanIssue(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientSatisfaction.selectSolvePlanIssue", map);
	}


	@SuppressWarnings("unchecked")
	public Map<String, Object> selectClientIssueDetail(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientSatisfaction.selectClientIssueDetail", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientIssueFileList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientSatisfaction.selectClientIssueFileList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientIssueCompany(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientSatisfaction.selectClientIssueCompany", map);
	}

	@SuppressWarnings("unchecked")
	public int updateClientIssueSolvePlan(Map<String, Object> map) throws Exception{
		return (int)insert("clientSatisfaction.updateClientIssueSolvePlan", map);
	}
	//셀러스 standard 버전 END//////////////////////////////////////////








	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> clientIssueFileList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientSatisfaction.clientIssueFileList", map);
	}

	@SuppressWarnings("unchecked")
	public int insertClientIssue(Map<String, Object> map) throws Exception{
		return (int)insert("clientSatisfaction.insertClientIssue", map);
	}


	@SuppressWarnings("unchecked")
	public int insertClientIssueSolvePlan(Map<String, Object> map) throws Exception{
		return (int)insert("clientSatisfaction.insertClientIssueSolvePlan", map);
	}

	@SuppressWarnings("unchecked")
	public int updateClientIssue(Map<String, Object> map) throws Exception{
		return (int)insert("clientSatisfaction.updateClientIssue", map);
	}


	@SuppressWarnings("unchecked")
	public int deleteClientIssue(Map<String, Object> map) throws Exception{
		return (int)delete("clientSatisfaction.deleteClientIssue", map);
	}


	@SuppressWarnings("unchecked")
	public int deleteClientIssueActionPlan(Map<String, Object> map) throws Exception{
		return (int)delete("clientSatisfaction.deleteClientIssueActionPlan", map);
	}



	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> clientSatisfactionSearchDetailGroup(Map<String, Object> map) throws Exception{
		//return (Map<String, Object>) selectList("clientSatisfaction.clientSatisfactionSearchDetailGroup2", map));*/
		return (List<Map<String, Object>>) selectList("clientSatisfaction.clientSatisfactionSearchDetailGroup1", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridClientSatisfaction(Map<String, Object> map) throws Exception{
		/*if(!"Y".equals(map.get("resultInSearch"))){ //결과 내 검색
			}else{
				return (List<Map<String, Object>>)selectList("clientSatisfaction.gridSearchInClientContact", map);
			}*/
		return (List<Map<String, Object>>)selectList("clientSatisfaction.gridClientSatisfaction", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> clientSatisfactionFileList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientSatisfaction.clientSatisfactionFileList", map);
	}

	@SuppressWarnings("unchecked")
	public int insertClientSatisfaction(Map<String, Object> map) throws Exception{
		return (int)insert("clientSatisfaction.insertClientSatisfaction", map);
	}

	@SuppressWarnings("unchecked")
	public int updateClientSatisfaction(Map<String, Object> map) throws Exception{
		return (int)insert("clientSatisfaction.updateClientSatisfaction", map);
	}

	@SuppressWarnings("unchecked")
	public int deleteClientSatisfaction(Map<String, Object> map) throws Exception{
		return (int)delete("clientSatisfaction.deleteClientSatisfaction", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridClientSatisfactionDetailList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectList("clientSatisfaction.gridClientSatisfactionDetailList", map);
	}

	@SuppressWarnings("unchecked")
	public int insertClientSatisfactionDetailList(Map<String, Object> map) throws Exception{
		return (int)insert("clientSatisfaction.insertClientSatisfactionDetailList", map);
	}

	//2016-10-10 고객만족 심윤영 start
	@SuppressWarnings("unchecked")
	public int insertClientSatisfactionDetail(Map<String, Object> map) throws Exception{
		return (int)insert("clientSatisfaction.insertClientSatisfactionDetail", map);
	}

	@SuppressWarnings("unchecked")
	public int updateClientSatisfactionDetail(Map<String, Object> map) throws Exception{
		return (int)update("clientSatisfaction.updateClientSatisfactionDetail", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridSolvePlanClientSatisfaction(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientSatisfaction.gridSolvePlanClientSatisfaction", map);
	}

	@SuppressWarnings("unchecked")
	public int insertClientSatisfactionSolvePlan(Map<String, Object> map) throws Exception{
		return (int)insert("clientSatisfaction.insertClientSatisfactionSolvePlan", map);
	}

	@SuppressWarnings("unchecked")
	public int updateClientSatisfactionSolvePlan(Map<String, Object> map) throws Exception{
		return (int)insert("clientSatisfaction.updateClientSatisfactionSolvePlan", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridClientSatisfactionDetailIssue(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientSatisfaction.gridClientSatisfactionDetailIssue", map);
	}

	@SuppressWarnings("unchecked")
	public int deleteClientSatisfactionFollowUpAction(Map<String, Object> map) throws Exception{
		return (int)delete("clientSatisfaction.deleteClientSatisfactionFollowUpAction", map);
	}

	@SuppressWarnings("unchecked")
	public int insertClientSatisfactionDetailIssue(Map<String, Object> map) throws Exception{
		return (int)insert("clientSatisfaction.insertClientSatisfactionDetailIssue", map);
	}

	@SuppressWarnings("unchecked")
	public int updateClientSatisfactionDetailIssue(Map<String, Object> map) throws Exception{
		return (int)update("clientSatisfaction.updateClientSatisfactionDetailIssue", map);
	}

	@SuppressWarnings("unchecked")
	public int checkClientSatisfactionDetailIssue(Map<String, Object> map) throws Exception{
		return (int)selectOne("clientSatisfaction.checkClientSatisfactionDetailIssue", map);
	}
	//2016-10-10 고객만족 심윤영 end

	@SuppressWarnings("unchecked")
	public int deleteClientSatisfactionDetailList(Map<String, Object> map) throws Exception{
		return (int)delete("clientSatisfaction.deleteClientSatisfactionDetailList", map);
	}
	@SuppressWarnings("unchecked")
	public int updateClientSatisfactionDetailList(Map<String, Object> map) throws Exception{
		return (int)insert("clientSatisfaction.updateClientSatisfactionDetailList", map);
	}

	//리스트 형식
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectClientSatisfactionMasterListCount(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientSatisfaction.selectClientSatisfactionMasterListCount", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectClientSatisfactionListCount(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientSatisfaction.selectClientSatisfactionListCount", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientSatisfactionMasterList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectList("clientSatisfaction.selectClientSatisfactionMasterList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientSatisfactionList(Map<String, Object> map) {
		/*if(!"Y".equals(map.get("resultInSearch"))){ //결과 내 검색
			}else{
				return (List<Map<String, Object>>)selectList("clientSatisfaction.gridSearchInClientContact", map);
			}*/
		return (List<Map<String, Object>>)selectList("clientSatisfaction.selectClientSatisfactionList", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectClientSatisfactionDetail(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientSatisfaction.selectClientSatisfactionDetail", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientSatisfactionFileList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectList("clientSatisfaction.selectClientSatisfactionFileList", map);
	}


	//============================================장기 프로젝트==============================================

	//장기프로젝트 관리
	@SuppressWarnings("unchecked") // 프로젝트 계획 리스트
	public Map<String, Object> projectMGMTDetailGroup(Map<String, Object> map) throws Exception{
		Map<String, Object> groupMap = new HashMap<String, Object>();
		groupMap.put("company_name",selectList("clientSatisfaction.projectMGMTDetailGroup", map));
		return groupMap;

	}

	@SuppressWarnings("unchecked") 
	public Map<String, Object> selectProjectMGMTDetail(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientSatisfaction.selectProjectMGMTDetail", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProjectMGMTFileList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectList("clientSatisfaction.selectProjectMGMTFileList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProjectMGMTList(Map<String, Object> map) {
		/*if(!"Y".equals(map.get("resultInSearch"))){ //결과 내 검색
			}else{
				return (List<Map<String, Object>>)selectList("clientSatisfaction.gridSearchInClientContact", map);
			}*/
		return (List<Map<String, Object>>)selectList("clientSatisfaction.selectProjectMGMTList", map);
	}

	@SuppressWarnings("unchecked")
	public int insertProjectMGMT(Map<String, Object> map) {
		return (int)insert("clientSatisfaction.insertProjectMGMT", map);
	}

	@SuppressWarnings("unchecked")
	public int updateProjectMGMT(Map<String, Object> map) {
		return (int)update("clientSatisfaction.updateProjectMGMT", map);

	}
	
	//팀구성 복수 입력
	@SuppressWarnings("unchecked")
	public int insertTeamMemberList(Map<String, Object> map) throws Exception{
		delete("clientSatisfaction.deleteTeamMemberList", map);
		return (int)insert("clientSatisfaction.insertTeamMemberList", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectProjectMGMTListCount(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientSatisfaction.selectProjectMGMTListCount", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> projectMGMTFileList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientSatisfaction.projectMGMTFileList", map);
	}

	@SuppressWarnings("unchecked")
	public int deleteProjectMGMT(Map<String, Object> map) throws Exception{
		return (int)delete("clientSatisfaction.deleteProjectMGMT", map);
	}

	@SuppressWarnings("unchecked")
	public int updateProjectMGMTMilestons(Map<String, Object> map) throws Exception{
		return (int)update("clientSatisfaction.updateProjectMGMTMilestons", map);
	}

	@SuppressWarnings("unchecked")
	public int insertProjectMGMTMilestons(Map<String, Object> map) throws Exception{
		return (int)insert("clientSatisfaction.insertProjectMGMTMilestons", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProjectMGMTMilestons(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientSatisfaction.selectProjectMGMTMilestons", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridProjectIssue(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientSatisfaction.gridProjectIssue", map);
	}

	@SuppressWarnings("unchecked")
	public int insertProjectIssue(Map<String, Object> map) throws Exception{
		return (int)insert("clientSatisfaction.insertProjectIssue", map);
	}

	@SuppressWarnings("unchecked")
	public int updateProjectIssue(Map<String, Object> map) throws Exception{
		return (int)insert("clientSatisfaction.updateProjectIssue", map);
	}

	@SuppressWarnings("unchecked")
	public int deleteProjectIssue(Map<String, Object> map) throws Exception{
		return (int)delete("clientSatisfaction.deleteProjectIssue", map);
	}

	@SuppressWarnings("unchecked")
	public int selectProjectIssue(Map<String, Object> map) throws Exception{
		return (int)selectOne("clientSatisfaction.selectProjectIssue", map);
	}

	@SuppressWarnings("unchecked")
	public int insertProjectMGMTContract(Map<String, Object> map) throws Exception{
		return (int)insert("clientSatisfaction.insertProjectMGMTContract", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectProjectMGMTInfo(Map<String, Object> map) throws Exception{
		Map<String, Object> InfoMap = new HashMap<String, Object>();
		InfoMap.put("selectProjectMGMTContractInfo",selectList("clientSatisfaction.selectProjectMGMTContractInfo", map));
		return InfoMap;
	}

	@SuppressWarnings("unchecked")
	public int deleteProjectMGMTContractAmount(Map<String, Object> map) throws Exception{
		return (int)delete("clientSatisfaction.deleteProjectMGMTContractAmount", map);
	}


	//고객만족도 대시보드
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientSatisfactionDashBoard(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientSatisfaction.selectClientSatisfactionDashBoard", map);
	}



	// 이슈 고객사별 대시보드 selectClientIssueCompanyDashBoard
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientIssueCompanyDashBoard(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientSatisfaction.selectClientIssueCompanyDashBoard", map);
	}
	
	/**
	 * @explain : 모바일 고객만족 -> 고객만족 -> 고객만족도 현황 (년도/분기별)
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectClientSatisfactionTotalStatus(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientSatisfaction.selectClientSatisfactionTotalStatus", map);
	}
	
	/**
	 * @explain : 모바일 고객만족 -> 고객만족 -> 조사 현황 (년도/분기별) 팀 리스트
	 */
	public List<Map<String, Object>> selectClientSatisfactionMasterTeamList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>)selectList("clientSatisfaction.selectClientSatisfactionMasterTeamList", map);
	}
	
	/**
	 * @explain : 모바일 고객만족 -> 고객만족 -> 조사 현황 (년도/분기별)
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientSatisfactionMasterListM(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectList("clientSatisfaction.selectClientSatisfactionMasterListM", map);
	}
}