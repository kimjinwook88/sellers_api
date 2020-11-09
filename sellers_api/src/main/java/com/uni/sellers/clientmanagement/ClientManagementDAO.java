package com.uni.sellers.clientmanagement;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.uni.sellers.datasource.AbstractDAO;

@Repository("clientManagementDAO")
public class ClientManagementDAO extends AbstractDAO{

	//=======================================고객개인정보 관리===============================================
	@SuppressWarnings("unchecked")
	public Map<String, Object> clientIndividualInfoSearchDetailGroup(Map<String, Object> map) throws Exception{
		Map<String, Object> groupMap = new HashMap<String, Object>();
		groupMap.put("event_category",selectList("clientManagement.clientIndividualInfoSearchDetailGroup", map));
		/*groupMap.put("company_name",selectList("clientManagement.clientIndividualInfoSearchDetailGroup", map));*/
		return groupMap;
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridClientIndividualInfoManage(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.gridClientIndividualInfoManage", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridClientIndividualInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.gridClientIndividualInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> clientIndividualPhotoList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.clientIndividualPhotoList", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectClientIndividualNameCard(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientManagement.selectClientIndividualNameCard", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectClientIndividualPhoto(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientManagement.selectClientIndividualPhoto", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectClientIndividualInfo(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientManagement.selectClientIndividualInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public int deleteClientIndividualPhoto(Map<String, Object> map) throws Exception{
		return (int)delete("clientManagement.deleteIndividualPhoto", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateClientIndividualInfo(Map<String, Object> map) throws Exception{
		return (int)insert("clientManagement.updateClientIndividualInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertClientIndividualInfo(Map<String, Object> map) throws Exception{
		return (int)insert("clientManagement.insertClientIndividualInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public int deleteClientIndividualInfo(Map<String, Object> map) {
		return (int)delete("clientManagement.deleteClientIndividualInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertSalesStatus(Map<String, Object> map) throws Exception{
		return (int)insert("clientManagement.insertSalesStatus", map);
	}
	
	@SuppressWarnings("unchecked")
	public int deleteSalesStatus(Map<String, Object> map) throws Exception{
		return (int)delete("clientManagement.deleteSalesStatus", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateSalesStatus(Map<String, Object> map) throws Exception{
		return (int)insert("clientManagement.updateSalesStatus", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridSalesStatus(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.gridSalesStatus", map);
	}
	
	//=======================================고객사정보 관리===============================================
	@SuppressWarnings("unchecked")
	public Map<String, Object> clientCompanyInfoSearchDetailGroup(Map<String, Object> map) throws Exception{
		Map<String, Object> groupMap = new HashMap<String, Object>();
		groupMap.put("event_category",selectList("clientManagement.clientCompanyInfoSearchDetailGroup", map));
		/*groupMap.put("company_name",selectList("clientManagement.clientIndividualInfoSearchDetailGroup", map));*/
		return groupMap;
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridClientCompanyInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.gridClientCompanyInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateClientCompanyInfo(Map<String, Object> map) throws Exception{
		return (int)insert("clientManagement.updateClientCompanyInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertClientCompanyInfo(Map<String, Object> map) throws Exception{
		return (int)insert("clientManagement.insertClientCompanyInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertClientCompanyITInfo(Map<String, Object> map) throws Exception{
		return (int)insert("clientManagement.insertClientCompanyITInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertSalesTerritoryAlignMap(Map<String, Object> map) throws Exception{
		return (int)insert("clientManagement.insertSalesTerritoryAlignMap", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectClientCompanyOrganizationChart(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientManagement.selectClientCompanyOrganizationChart", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectClientCompanyInfo(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientManagement.selectClientCompanyInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAllIndustrySegmentCode(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.selectAllIndustrySegmentCode", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridClientCompanyProjectList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.gridClientCompanyProjectList", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectClientCompanyProjectListCount(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientManagement.selectClientCompanyProjectListCount", map);
	}
	
	////////////////////////////////////////////고객개인정보 view/////////////////////////////////////////
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridClientIndividualDetail(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.gridClientIndividualDetail", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridClientIndividualInfoList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.gridClientIndividualInfoList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridClientIndividualInfoList2(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.gridClientIndividualInfoList2", map);
	}
	
	////////////////////////////////////////////고객사정보 view///////////////////////////////////////////
	@SuppressWarnings("unchecked")
	public Map<String, Object> clientCompanyInfoViewSearchDetailGroup(Map<String, Object> map) throws Exception{
		Map<String, Object> groupMap = new HashMap<String, Object>();
		groupMap.put("event_category",selectList("clientManagement.clientCompanyInfoSearchDetailGroup", map));
		/*groupMap.put("company_name",selectList("clientManagement.clientIndividualInfoSearchDetailGroup", map));*/
		return groupMap;
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridClientCompanyInfoView(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.gridClientCompanyInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridClientCompanyInfoView2(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.gridClientCompanyInfo2", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridClientCompanyInfoView3(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.gridClientCompanyInfo3", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridCompanyClient(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.gridCompanyClient", map);
	}
	
	@SuppressWarnings("unchecked")
	public int selectCompanyClientCount(Map<String, Object> map) throws Exception{
		return (int)selectOne("clientManagement.selectCompanyClientCount", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> companyOrganizationChart(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.companyOrganizationChart", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridCurrentOpportunity(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.gridCurrentOpportunity", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridServiceProject(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.gridServiceProject", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientCompanyFileList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.selectClientCompanyFileList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridClientContactView(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.gridClientContactView", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridClientContactView2(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.gridClientContactView2", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientIndividualHistoryList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.selectClientIndividualHistoryList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectIndividualHistory(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.selectIndividualHistory", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectIndividualContactHistory(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.selectIndividualContactHistory", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchIndividualHistory(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.searchIndividualHistory", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectIndividualDetail(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.selectIndividualDetail", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertIndividualHistory(Map<String, Object> map) throws Exception{
		return (int)insert("clientManagement.insertIndividualHistory", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateIndividualHistory2(Map<String, Object> map) throws Exception{
		return (int)update("clientManagement.updateIndividualHistory2", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateIndividualHistory3(Map<String, Object> map) throws Exception{
		return (int)update("clientManagement.updateIndividualHistory3", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateClientIndividualUseYN(Map<String, Object> map) throws Exception{
		return (int)update("clientManagement.updateClientIndividualUseYN", map);
	}
	
	@SuppressWarnings("unchecked")
	public int deleteIndividualAllHistory(Map<String, Object> map) throws Exception{
		return (int)delete("clientManagement.deleteIndividualAllHistory", map);
	}
	
	@SuppressWarnings("unchecked")
	public int deleteIndividualHistory(Map<String, Object> map) throws Exception{
		return (int)delete("clientManagement.deleteIndividualHistory", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBeforeIndividualHistory(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.selectBeforeIndividualHistory", map);
	}
	
	
	
	
	//태원
	@SuppressWarnings("unchecked")
	public int slectClientCompanyMaxId(Map<String, Object> map) throws Exception{
		return (int)insert("clientManagement.slectClientCompanyMaxId", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertSalesTerritoryAlignAllMap(Map<String, Object> map) throws Exception{
		return (int)insert("clientManagement.insertSalesTerritoryAlignAllMap", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAllMemberIdNum() throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.selectAllMemberIdNum");
	}
	
	@SuppressWarnings("unchecked")
	public int deleteClientCompanyProjectList(Map<String, Object> map) throws Exception{
		return (int)delete("clientManagement.deleteClientCompanyProjectList", map);
	}
	
	/**
	 * @author  : 욱이
	 * @date : 2017. 2. 27.
	 * @explain : 고객사정보 -> 프로젝트 관리 이력 -> 상세보기 
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectClientCompanyProjectMg(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientManagement.selectClientCompanyProjectMg", map);
	}
	
	/**
	 * @author  : 욱이
	 * @date : 2017. 2. 27.
	 * @explain : 고객사정보 -> 프로젝트 관리 이력 -> 상세보기 ( 프로젝트 인원 ) 
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientCompanyProjectMgPerson(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.selectClientCompanyProjectMgPerson", map);
	}
	
	/**
	 * @author  : 욱이
	 * @date : 2017. 2. 27.
	 * @explain : 고객사정보 -> 프로젝트 관리 이력 -> insert 
	 */
	@SuppressWarnings("unchecked")
	public int insertClientCompanyProjectMg(Map<String, Object> map) throws Exception{
		return (int)insert("clientManagement.insertClientCompanyProjectMg", map);
	}
	
	/**
	 * @author  : 욱이
	 * @date : 2017. 2. 27.
	 * @explain : 고객사정보 -> 프로젝트 관리 이력 -> update 
	 */
	@SuppressWarnings("unchecked")
	public int updateClientCompanyProjectMg(Map<String, Object> map) throws Exception{
		return (int)update("clientManagement.updateClientCompanyProjectMg", map);
	}
	
	/**
	 * @author  : 욱이
	 * @date : 2017. 2. 27.
	 * @explain : 고객사정보 -> 프로젝트 관리 이력 -> 프로젝트 인원 insert 
	 */
	@SuppressWarnings("unchecked")
	public int insertClientCompanyProjectMgPerson(Map<String, Object> map) throws Exception{
		return (int)insert("clientManagement.insertClientCompanyProjectMgPerson", map);
	}
	
	/**
	 * @author  : 욱이
	 * @date : 2017. 2. 27.
	 * @explain : 고객사정보 -> 프로젝트 관리 이력 -> 프로젝트 인원 update
	 */
	@SuppressWarnings("unchecked")
	public int updateClientCompanyProjectMgPerson(Map<String, Object> map) throws Exception{
		return (int)update("clientManagement.updateClientCompanyProjectMgPerson", map);
	}
	
	/**
	 * @author  : 욱이
	 * @date : 2017. 03. 06.
	 * @explain : 고객사정보 -> 프로젝트 관리 이력 -> 프로젝트 인원 delete
	 */
	@SuppressWarnings("unchecked")
	public int deleteClientCompanyProjectMgPerson(Map<String, Object> map) throws Exception{
		return (int)delete("clientManagement.deleteClientCompanyProjectMgPerson", map);
	}
	
	@SuppressWarnings("unchecked")
	public int deleteClientCompanyProject(Map<String, Object> map) throws Exception{
		return (int)delete("clientManagement.deleteClientCompanyProject", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientCompanyProject(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.selectClientCompanyProject", map);
	}
	
	@SuppressWarnings("unchecked")
	public int deleteClientCompanySeqProject(Map<String, Object> map) throws Exception{
		return (int)delete("clientManagement.deleteClientCompanySeqProject", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateClientIndividualSequenceInfo(Map<String, Object> map) throws Exception{
		return (int)insert("clientManagement.updateClientIndividualSequenceInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public int selectClientCompanyCnt(Map<String, Object> map) throws Exception{
		return (int)selectOne("clientManagement.selectClientCompanyCnt", map);
	}
	
	@SuppressWarnings("unchecked")
	public int selectClientIndividualCnt(Map<String, Object> map) throws Exception{
		return (int)selectOne("clientManagement.selectClientIndividualCnt", map);
	}

	/**
	 * @author  : 준이
	 * @date : 2017. 03. 20.
	 * @explain : 고객사정보 -> 영업기회탭 -> 리스트 클릭시 권한 조회
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRoleCheck(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("clientManagement.selectRoleCheck", map);
	}
	
	/**
	 * @author  : 심
	 * @date : 2018. 08. 31.
	 * @explain : 고객사정보 -> 영업기회탭 -> 리스트 클릭시 권한 조회
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectClientItInfo(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientManagement.selectClientItInfo", map);
	}
	
	/**
	 * @author  : 현경
	 * @date : 2018. 09. 05.
	 * @explain 고객사정보 -> 정보수정 -> IT 정보 update
	 */
	@SuppressWarnings("unchecked")
	public int updateClientCompanyITInfo(Map<String, Object> map) throws Exception{
		return (int)update("clientManagement.updateClientCompanyITInfo", map);
	}
	
	////////////////////////////////////////디유넷 소스 병합 시 추가된 서비스 Start ////////////////////////////////////////////
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객개인정보 게이트 -> 고객 호감도 현황(개인)
	 */
	@SuppressWarnings("unchecked")
	public  List<HashMap<String, Object>> clientLikeabilityIndividualCnt(Map<String, Object> map) throws Exception{
		return (List<HashMap<String, Object>>)selectList("clientManagement.clientLikeabilityIndividualCnt", map);
	}
	
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객개인정보 게이트 -> 고객 호감도 현황
	 */
	@SuppressWarnings("unchecked")
	public  List<HashMap<String, Object>> clientLikeabilityCnt(Map<String, Object> map) throws Exception{
		return (List<HashMap<String, Object>>)selectList("clientManagement.clientLikeabilityCnt", map);
	}
	
	/**
	 * @explain : 모바일 고객사 및  고객개인정보-> 고객개인 게이트 -> 팀이름 셀렉트박스 옵션
	 */
	@SuppressWarnings("unchecked")
	public  List<HashMap<String, Object>> selectTeamNameList(Map<String, Object> map) throws Exception{
		return (List<HashMap<String, Object>>)selectList("common.selectNameList", map);
	}
	
	/**
	 * @explain : 모바일 고객개인 전체 게이트  : 나의 전체 고객
	 */
	@SuppressWarnings("unchecked")
	public int totalClientIndividualCnt(Map<String, Object> map) throws Exception{
		return (int)selectOne("clientManagement.totalClientCnt", map);
	}
	
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객개인정보 게이트 -> 팀정보
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> teamInfo(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientManagement.teamInfo", map);
	}
	
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객개인정보 게이트 -> selectbox option (CEO, TEAM, MEMBER)
	 */
	@SuppressWarnings("unchecked")
	public List<HashMap<String, Object>> lineGraphSelectOption(Map<String, Object> map) throws Exception{
		return (List<HashMap<String, Object>>)selectList("common.selectNameList", map);
	}
	
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객개인정보 게이트 -> 고객관계수립 그래프 데이터 (CEO, TEAM, MEMBER)
	 */
	@SuppressWarnings("unchecked")
	public List<HashMap<String, Object>> relationCEOStatus(Map<String, Object> map) throws Exception{
		return (List<HashMap<String, Object>>)selectList("clientManagement.relationCEOStatus", map);
	}
	
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객개인 게이트 -> 금주 신규 고객
	 * 최영완20200122
	 */
	@SuppressWarnings("unchecked")
	public int clientIndividualNewCnt(Map<String, Object> map) throws Exception{
		String[] weekCnt = {"0", "1", "2", "3", "4", "5", "6"} ;
		map.put("weekCnt", weekCnt);
		return (int)selectOne("clientManagement.clientIndividualNewCnt", map);
	}
	
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객개인정보 게이트 -> 고객관계수립 추이 그래프(꺾은선) 데이터 (CEO, TEAM, MEMBER)
	 */
	@SuppressWarnings("unchecked")
	public List<HashMap<String, Object>> lineGraphData(Map<String, Object> map) throws Exception{
		return (List<HashMap<String, Object>>)selectList("clientManagement.lineGraphData", map);
	}
	
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객사 게이트 -> 주요 고객개인 리스트 top 10 리스트
	 */
	@SuppressWarnings("unchecked")
	public List<HashMap<String, Object>> selectIndividualTopList(Map<String, Object> map) throws Exception{
		return (List<HashMap<String, Object>>)selectList("clientManagement.selectIndividualTopList", map);
	}
	
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객사 게이트 -> 주요 신규고객개인 리스트
	 */
	@SuppressWarnings("unchecked")
	public List<HashMap<String, Object>> selectIndividualTopNewList(Map<String, Object> map) throws Exception{
		return (List<HashMap<String, Object>>)selectList("clientManagement.selectIndividualTopNewList", map);
	}
	
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객개인정보 게이트 -> 고객관계수립
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> quarterRelationStatus(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientManagement.quarterRelationStatus", map);
	}
	
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객개인정보 게이트 -> 고객관계수립
	 */
	@SuppressWarnings("unchecked")
	public List<HashMap<String, Object>> quarterRelationStatus2(Map<String, Object> map) throws Exception{
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		for(int i = 1; i < 5; i++){
			map.put("quarterValue", i);
			list = (List<HashMap<String, Object>>)selectList("clientManagement.quarterRelationStatus2", map);
		}
		return list;
	}
	
	/**
	 * @explain : 모바일 고객사 및  고객개인정보-> 고객개인 게이트 -> 리스트 카운트
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectClientIndividualInfoMConut(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientManagement.selectClientIndividualInfoMConut", map);
	}
	
	/**
	 * @author  : 최영완
	 * @date : 2020. 01. 21.
	 * @explain : 고객사 및 고객개인정보 -> 고객사 게이트 -> 금주 신규 고객
	 */
	@SuppressWarnings("unchecked")
	public int clientCompanyNewCnt(Map<String, Object> map) throws Exception{
		String[] weekCnt = {"0", "1", "2", "3", "4", "5", "6"} ;
		map.put("weekCnt", weekCnt);
		return (int)selectOne("clientManagement.weekClientNewCreateCnt", map);
	}
	
	/**
	 * @author  : 최영완
	 * @date : 2020. 01. 21.
	 * @explain : 고객사 및 고객개인정보 -> 고객개인정보 게이트 -> 고객관계수립
	 */
	@SuppressWarnings("unchecked")
	public int totalClientCompanyCnt(Map<String, Object> map) throws Exception{
		return (int)selectOne("clientManagement.totalClientCompanyCnt", map);
	}
	
	
	/**
	 * @author  : 최영완
	 * @date : 2020. 01. 21.
	 * @explain : 고객사 및 고객개인정보 -> 고객개인정보 게이트 -> 잠재고객수
	 */
	@SuppressWarnings("unchecked")
	public int clientHiddenCompanyCount(Map<String, Object> map) throws Exception{
		return (int)selectOne("clientManagement.clientHiddenCompanyCount", map);
	}
	
	/**
	 * @author  : 최영완
	 * @date : 2020. 01. 21.
	 * @explain : 고객사 및 고객개인정보 -> 고객개인정보 게이트 -> 고객tk관계수립 추이 그래프(꺾은선) 데이터 (CEO, TEAM, MEMBER)
	 */
	@SuppressWarnings("unchecked")
	public List<HashMap<String, Object>> lineGraphData3(Map<String, Object> map) throws Exception{
		return (List<HashMap<String, Object>>)selectList("clientManagement.lineGraphData3", map);
	}
	
	/**
	 * @author  : 최영완
	 * @date : 2020. 01. 21.
	 * @explain : 고객사 및 고객개인정보 -> 고객사 게이트 -> 주요 고객개인 리스트 top 10 리스트
	 */
	@SuppressWarnings("unchecked")
	public List<HashMap<String, Object>> selectCompanyTopNewList(Map<String, Object> map) throws Exception{
		return (List<HashMap<String, Object>>)selectList("clientManagement.selectCompanyTopNewList", map);
	}
	
	/**
	 * @author  : 최영완
	 * @date : 2020. 01. 21.
	 * @explain : 고객사 및 고객개인정보 -> 고객사 게이트 -> 최근 1주간 영업활동
	 */
	@SuppressWarnings("unchecked")
	public  List<HashMap<String, Object>> clientWeekContact(Map<String, Object> map) throws Exception{
		return (List<HashMap<String, Object>>)selectList("clientManagement.clientWeekContact", map);
	}
	
	/**
	 * @author  : 최영완
	 * @date : 2020. 01. 21.
	 * @explain : 고객사 및 고객개인정보 -> 고객사 게이트 -> 영업기회 테이블 DATA
	 */
	@SuppressWarnings("unchecked")
	public List<HashMap<String, Object>> oppTableDate(Map<String, Object> map) throws Exception{
		return (List<HashMap<String, Object>>)selectList("clientManagement.oppTableDate", map);
	}
	
	/**
	 * @author  : 최영완
	 * @date : 2020. 01. 21.
	 * @explain : 고객사 및 고객개인정보 -> 고객사 게이트 -> 영업기회 테이블 DATA
	 */
	@SuppressWarnings("unchecked")
	public List<HashMap<String, Object>> oppGraphData(Map<String, Object> map) throws Exception{
		return (List<HashMap<String, Object>>)selectList("clientManagement.oppGraphData", map);
	}
	
	/**
	 * @author  : 최영완	
	 * @date : 2020. 01. 21.
	 * @explain : 고객사 및 고객개인정보 -> 고객사 게이트 -> 영업대표 영업현황
	 */
	@SuppressWarnings("unchecked")
	public  List<HashMap<String, Object>> clientOppCnt(Map<String, Object> map) throws Exception{
		return (List<HashMap<String, Object>>)selectList("clientManagement.clientOppCnt", map);
	}
	
	/**
	 * @author  : 최영완
	 * @date : 2020. 01. 29.
	 * @explain : 고객사 및  고객개인정보-> 고객사 게이트 -> 리스트 카운트
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectClientCompanyCount(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("clientManagement.selectClientCompanyCount", map);
	}
	////////////////////////////////////////디유넷 소스 병합 시 추가된 서비스 End //////////////////////////////////////////////
}