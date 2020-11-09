package com.uni.sellers.partnermanagement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.uni.sellers.datasource.AbstractDAO;

@Repository("partnerManagementDAO")
public class PartnerManagementDAO extends AbstractDAO{

	//============================================파트너 영업==============================================


	//Capacity
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridCapacity(Map<String, Object> map) throws Exception{
		List<Map<String, Object>> list = null;
		if("in".equals(map.get("selectViewList"))){
			list = (List<Map<String, Object>>)selectList("partnerManagement.gridCapacityIn", map);
		}else{
			list = (List<Map<String, Object>>)selectList("partnerManagement.gridCapacityBp", map);
		}
		return list;
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> partnerSalesGroup(Map<String, Object> map) throws Exception{
		Map<String, Object> groupMap = new HashMap<String, Object>();
		groupMap.put("account_year",selectList("partnerManagement.partnerSalesGroup1", map));
		groupMap.put("max_account_year",selectList("partnerManagement.partnerSalesGroup2", map));
		return groupMap;
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCapacityPartnerList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectCapacityPartnerList", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCapacityPartnerAction(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("partnerManagement.selectCapacityPartnerAction", map);
	}

	@SuppressWarnings("unchecked")
	public int insertCapacityBp(Map<String, Object> map) {
		return (int)update("partnerManagement.updateCapacityCompanyBp", map);
	}

	@SuppressWarnings("unchecked")
	public int deleteCapacityParnter(Map<String, Object> map) {
		return (int)delete("partnerManagement.deleteCapacityParnter", map);
	}

	@SuppressWarnings("unchecked")
	public int deleteCapacityParnterAll(Map<String, Object> map) {
		return (int)delete("partnerManagement.deleteCapacityParnterAll", map);
	}

	@SuppressWarnings("unchecked")
	public int createCapacity(Map<String, Object> map) {
		return (int)insert("partnerManagement.createCapacity", map);
	}

	@SuppressWarnings("unchecked")
	public int insertCapacityIn(Map<String, Object> map) {
		return (int)update("partnerManagement.updateCapacityCompanyIn", map);
	}

	@SuppressWarnings("unchecked")
	public int insertCapacityParnter(Map<String, Object> map) {
		return (int)insert("partnerManagement.insertCapacityParnter", map);
	}

	@SuppressWarnings("unchecked")
	public int insertCapacityAction(Map<String, Object> map) {
		return (int)insert("partnerManagement.insertCapacityAction", map);
	}

	@SuppressWarnings("unchecked")
	public int updateCapacityAction(Map<String, Object> map) {
		return (int)update("partnerManagement.updateCapacityAction", map);
	}

	@SuppressWarnings("unchecked")
	public int selectCapacityGapCount(Map<String, Object> map) throws Exception{
		return (int)selectOne("partnerManagement.selectCapacityGapCount", map);
	}

	@SuppressWarnings("unchecked")
	public int updateCondition(Map<String, Object> map) throws Exception{
		return (int)update("partnerManagement.updateCondition", map);
	}











	//Recruitment
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridRecruitment(Map<String, Object> map) throws Exception{
		List<Map<String, Object>> list = null;
		if("in".equals(map.get("selectViewList"))){
			list = (List<Map<String, Object>>)selectList("partnerManagement.gridRecruitmentIn", map);
		}else{
			list = (List<Map<String, Object>>)selectList("partnerManagement.gridRecruitmentBp", map);
		}
		return list;
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridRecruitmentCRB(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.gridRecruitmentCRB", map);
	}

	@SuppressWarnings("unchecked")
	public int insertRecruitment(Map<String, Object> map) throws Exception{
		int cnt = 0;
		if(map.get("RECRUITMENT_ID") != null && !map.get("RECRUITMENT_ID").equals("")){
			cnt = (int)update("partnerManagement.updateRecruitment", map);
		}else{
			cnt = (int)insert("partnerManagement.insertRecruitment", map);
		}
		return cnt;

	}

	@SuppressWarnings("unchecked")
	public int selectCRBid(Map<String, Object> map) throws Exception{
		return  (int)selectOne("partnerManagement.selectCRBid", map);
	}

	@SuppressWarnings("unchecked")
	public int insertRecruitmentCRB(Map<String, Object> map) throws Exception{
		int cnt = 0;
		if(map.get("CRB_LOG_ID") != null && !"".equals(map.get("CRB_LOG_ID"))){
			cnt = (int)update("partnerManagement.updateRecruitmentCRB", map);
		}else{
			cnt = (int)insert("partnerManagement.insertRecruitmentCRB", map);
		}
		return cnt;
	}

	@SuppressWarnings("unchecked")
	public int createCRB(Map<String, Object> map) throws Exception{
		int cnt = 0;
		cnt = (int)insert("partnerManagement.createCRB", map);
		//cnt = (int)insert("partnerManagement.createRecruitmentCRB", map);
		return cnt;
	}

	@SuppressWarnings("unchecked")
	public int insertRecruitmentFileCRB(Map<String, Object> map) throws Exception{
		return (int)insert("partnerManagement.insertRecruitmentFileCRB", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> crbGroup(Map<String, Object> map) throws Exception{ 
		Map<String, Object> groupMap = new HashMap<String, Object>();
		groupMap.put("crb_seq",selectList("partnerManagement.CRBGroup1", map));
		return groupMap;
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCRBseq(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectCRBseq", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> recruitmentCRBFileList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.recruitmentCRBFileList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCRBbpNameJson(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectCRBbpNameJson", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCadenceDetail(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("partnerManagement.selectCadenceDetail", map);
	}









	//Enablement
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridEnablement(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.gridEnablement", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectEnablementCount(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("partnerManagement.selectEnablementCount", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectEnablementDetail(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("partnerManagement.selectEnablementDetail", map);
	}

	//안씀
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> enablementFileList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.enablementFileList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectEnablementFileList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectEnablementFileList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridMileStonesEnablement(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.gridMileStonesEnablement", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> enablementSearchDetailGroup(Map<String, Object> map) throws Exception{
		Map<String, Object> groupMap = new HashMap<String, Object>();
		groupMap.put("edu_area",selectList("partnerManagement.enablementSearchDetailGroup1", map));
		/*groupMap.put("company_name",selectList("partnerManagement.clientSatisfactionSearchDetailGroup2", map));*/
		return groupMap;
	}

	@SuppressWarnings("unchecked")
	public int insertEnablement(Map<String, Object> map) {
		return (int)insert("partnerManagement.insertEnablement", map);
	}

	@SuppressWarnings("unchecked")
	public int updateEnablement(Map<String, Object> map) {
		return (int)update("partnerManagement.updateEnablement", map);
	}

	@SuppressWarnings("unchecked")
	public int updateMilestonesEnablement(Map<String, Object> map) {
		return (int)update("partnerManagement.updateMilestonesEnablement", map);
	}

	@SuppressWarnings("unchecked")
	public int insertMilestonesEnablement(Map<String, Object> map) {
		return (int)insert("partnerManagement.insertMilestonesEnablement", map);
	}














	//SalesLinkage
	@SuppressWarnings("unchecked")
	public int createSalesLinkage(Map<String, Object> map) {
		return (int)insert("partnerManagement.createSalesLinkage", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridSalesLinkage(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.gridSalesLinkage", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCadenceDateList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectCadenceDateList", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> salesLinkageDetailGroup(Map<String, Object> map) throws Exception{
		Map<String, Object> groupMap = new HashMap<String, Object>();
		groupMap.put("linkage_year",selectList("partnerManagement.salesLinkageDetailGroup1", map));
		groupMap.put("max_linkage_year",selectList("partnerManagement.salesLinkageDetailGroup2", map));
		groupMap.put("category_count",(int)selectOne("partnerManagement.salesLinkageDetailGroup3", map));
		return groupMap;
	}

	@SuppressWarnings("unchecked")
	public int updateSalesLinkage(Map<String, Object> map) throws Exception{
		return (int)insert("partnerManagement.updateSalesLinkage", map);
	}

	@SuppressWarnings("unchecked")
	public int insertSalesLinkageHistory(Map<String, Object> map) throws Exception{
		return (int)insert("partnerManagement.insertSalesLinkageHistory", map);
	}

	@SuppressWarnings("unchecked")
	public int updateSalesLinkageHistory(Map<String, Object> map) throws Exception{
		return (int)insert("partnerManagement.updateSalesLinkageHistory", map);
	}

	@SuppressWarnings("unchecked")
	public int insertSalesLinkageHistoryFile(Map<String, Object> map) throws Exception{
		return (int)insert("partnerManagement.insertSalesLinkageHistoryFile", map);
	}

	@SuppressWarnings("unchecked")
	public int updateCadenceActionPlan(Map<String, Object> map) throws Exception{
		return (int)update("partnerManagement.updateCadenceActionPlan", map);
	}

	@SuppressWarnings("unchecked")
	public int insertCadenceActionPlan(Map<String, Object> map) throws Exception{
		return (int)insert("partnerManagement.insertCadenceActionPlan", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> salesLinkageFileList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.salesLinkageFileList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridActionPlanSalesLinkage(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.gridActionPlanSalesLinkage", map);
	}

	@SuppressWarnings("unchecked")
	public int selectSalesLinkageCodeCount(String code) throws Exception{
		return (int)selectOne("partnerManagement.selectSalesLinkageCodeCount", code);
	}

	@SuppressWarnings("unchecked")
	public int updateSalesLinkageCode(Map<String, Object> map) throws Exception{
		return (int)update("partnerManagement.updateSalesLinkageCode", map);
	}

	
	//Fullfillment - standard ver.
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFullfillment(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectFullfillment", map);
	}
	
	//FullfillmentCount - 더존 erp 연동 신용평가현황 테이블
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectFullfillmentCount(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("partnerManagement.selectFullfillmentCount", map);
	}
	
	//Fullfillment - 더존 erp 연동 신용평가현황 테이블
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFullfillmentERP(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectFullfillmentERP", map);
	}


	//=======================================고객개인정보 관리===============================================
	@SuppressWarnings("unchecked")
	public Map<String, Object> partnerIndividualInfoSearchDetailGroup(Map<String, Object> map) throws Exception{
		Map<String, Object> groupMap = new HashMap<String, Object>();
		groupMap.put("event_category",selectList("partnerManagement.partnerIndividualInfoSearchDetailGroup", map));
		/*groupMap.put("company_name",selectList("salesActive.partnerIndividualInfoSearchDetailGroup", map));*/
		return groupMap;
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridPartnerIndividualInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.gridPartnerIndividualInfo", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> partnerIndividualPhotoList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.partnerIndividualPhotoList", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectPartnerIndividualPhoto(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("partnerManagement.selectPartnerIndividualPhoto", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectPartnerIndividualNameCard(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("partnerManagement.selectPartnerIndividualNameCard", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectPartnerIndividualInfo(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("partnerManagement.selectPartnerIndividualInfo", map);
	}

	@SuppressWarnings("unchecked")
	public int deletePartnerIndividualPhoto(Map<String, Object> map) throws Exception{
		return (int)delete("partnerManagement.deleteIndividualPhoto", map);
	}

	@SuppressWarnings("unchecked")
	public int updatePartnerIndividualInfo(Map<String, Object> map) throws Exception{
		return (int)insert("partnerManagement.updatePartnerIndividualInfo", map);
	}

	@SuppressWarnings("unchecked")
	public int insertPartnerIndividualInfo(Map<String, Object> map) throws Exception{
		return (int)insert("partnerManagement.insertPartnerIndividualInfo", map);
	}

	@SuppressWarnings("unchecked")
	public int deletePartnerIndividualInfo(Map<String, Object> map) {
		return (int)delete("partnerManagement.deletePartnerIndividualInfo", map);
	}

	////////////////////////////////////////////협력사개인정보 카드 view/////////////////////////////////////////
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridPartnerIndividualInfoList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.gridPartnerIndividualInfoList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridPartnerIndividualInfoList2(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.gridPartnerIndividualInfoList2", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridPartnerIndividualDetail(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.gridPartnerIndividualDetail", map);
	}

	//=======================================고객사정보 관리===============================================
	@SuppressWarnings("unchecked")
	public Map<String, Object> partnerCompanyInfoSearchDetailGroup(Map<String, Object> map) throws Exception{
		Map<String, Object> groupMap = new HashMap<String, Object>();
		groupMap.put("event_category",selectList("partnerManagement.partnerCompanyInfoSearchDetailGroup", map));
		/*groupMap.put("company_name",selectList("salesActive.partnerIndividualInfoSearchDetailGroup", map));*/
		return groupMap;
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPartnerInfoSearchPartnerCode(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectList("partnerManagement.selectPartnerInfoSearchPartnerCode", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPartnerCompanyList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectPartnerCompanyList", map);
	}

	@SuppressWarnings("unchecked")
	public int updatePartnerCompanyInfo(Map<String, Object> map) throws Exception{
		return (int)insert("partnerManagement.updatePartnerCompanyInfo", map);
	}

	@SuppressWarnings("unchecked")
	public int insertPartnerCompanyInfo(Map<String, Object> map) throws Exception{
		return (int)insert("partnerManagement.insertPartnerCompanyInfo", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCodePartnerSegmentAll(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectCodePartnerSegmentAll", map);
	}


	////////////////////////////////////////////고객개인정보 view/////////////////////////////////////////
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridPartnerCompany(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.gridPartnerCompany", map);
	}



	////////////////////////////////////////////고객사정보 view///////////////////////////////////////////
	@SuppressWarnings("unchecked")
	public Map<String, Object> partnerCompanyInfoViewSearchDetailGroup(Map<String, Object> map) throws Exception{
		Map<String, Object> groupMap = new HashMap<String, Object>();
		groupMap.put("event_category",selectList("partnerManagement.partnerCompanyInfoSearchDetailGroup", map));
		/*groupMap.put("company_name",selectList("salesActive.partnerIndividualInfoSearchDetailGroup", map));*/
		return groupMap;
	}


	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPartnerCompanyIndividualList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectPartnerCompanyIndividualList", map);
	}



	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> listPartnerCompanyInfoLeftList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.listPartnerCompanyInfoLeftList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> listPartnerCompanyInfoLeftList2(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.listPartnerCompanyInfoLeftList2", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPartnerCompanyInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectPartnerCompanyInfo", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPartnerClient(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectPartnerClient", map);
	}

	@SuppressWarnings("unchecked")
	public int selectCompanyPartnerCount(Map<String, Object> map) throws Exception{
		return (int)selectOne("partnerManagement.selectCompanyPartnerCount", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> companyOrganizationChart(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectPartnerCompanyOrganizationChart", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> companyIndividualSkillMap(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.companyIndividualSkillMap", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPartnerCompanyOrderStatus(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectPartnerCompanyOrderStatus", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectPartnerCompanyOrderQuarterLength(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("partnerManagement.selectPartnerCompanyOrderQuarterLength", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPartnerCompanyOrderList1(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectPartnerCompanyOrderList1", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPartnerCompanyOrderList2(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectPartnerCompanyOrderList2", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPartnerCompanyOrderList3(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectPartnerCompanyOrderList3", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPartnerCompanyOrder(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectPartnerCompanyOrder", map);
	}

	public int updatePartnerCompanyInfoOrder(Map<String, Object> map) throws Exception{
		return (int)update("partnerManagement.updatePartnerCompanyInfoOrder", map);
	}

	@SuppressWarnings("unchecked")
	public int insertPartnerCompanyInfoOrder(Map<String, Object> map) throws Exception{
		return (int)insert("partnerManagement.insertPartnerCompanyInfoOrder", map);
	}

	@SuppressWarnings("unchecked")
	public int deletePartnerCompanyOrder(Map<String, Object> map) {
		return (int)delete("partnerManagement.deletePartnerCompanyOrder", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectPartnerCompanySaleQuarterLength(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("partnerManagement.selectPartnerCompanySaleQuarterLength", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPartnerCompanySaleList1(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectPartnerCompanySaleList1", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPartnerCompanySaleList2(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectPartnerCompanySaleList2", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPartnerCompanySaleList3(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectPartnerCompanySaleList3", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPartnerCompanySale(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectPartnerCompanySale", map);
	}

	public int updatePartnerCompanyInfoSale(Map<String, Object> map) throws Exception{
		return (int)update("partnerManagement.updatePartnerCompanyInfoSale", map);
	}

	@SuppressWarnings("unchecked")
	public int insertPartnerCompanyInfoSale(Map<String, Object> map) throws Exception{
		return (int)insert("partnerManagement.insertPartnerCompanyInfoSale", map);
	}

	@SuppressWarnings("unchecked")
	public int deletePartnerCompanySale(Map<String, Object> map) {
		return (int)delete("partnerManagement.deletePartnerCompanySale", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPartnerCompanyFileList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectPartnerCompanyFileList", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectPartnerCompanyOrganizationChart(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("partnerManagement.selectPartnerCompanyOrganizationChart", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectAllPartnerCompanyInfo(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("partnerManagement.selectAllPartnerCompanyInfo", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> partnerIndividualSkillList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.partnerIndividualSkillList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> partnerEnableLogList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.partnerEnableLogList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectVendorSolutionAreaList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selectVendorSolutionAreaList", map);
	}

	@SuppressWarnings("unchecked")
	public int insertSolutionArea(Map<String, Object> map) throws Exception{
		return (int)insert("partnerManagement.insertSolutionArea", map);
	}

	@SuppressWarnings("unchecked")
	public int updateSolutionArea(Map<String, Object> map) throws Exception{
		return (int)insert("partnerManagement.updateSolutionArea", map);
	}

	@SuppressWarnings("unchecked")
	public int deleteSolutionArea(Map<String, Object> map) throws Exception{
		return (int)delete("partnerManagement.deleteSolutionArea", map);
	}

    @SuppressWarnings("unchecked")
    public Map<String, Object> salesLinkageDetail(Map<String, Object> map) throws Exception{
        return (Map<String, Object>)selectOne("partnerManagement.salesLinkageDetail", map);
    }
	
    /**
	 * @explain : 모바일 파트너사 협업 -> 파트너 게이트 -> 전체 파트너
	 */
	@SuppressWarnings("unchecked")
	public int totalPartnerIndividualCnt(Map<String, Object> map) throws Exception{
		return (int)selectOne("partnerManagement.totalPartnerIndividualCnt", map);
	}
	
	/**
	 * @explain : 모바일 파트너사 협업 -> 파트너사 게이트 -> 금주 신규 고객
	 */
	@SuppressWarnings("unchecked")
	public int partnerIndividualNewCnt(Map<String, Object> map) throws Exception{
		String[] weekCnt = {"0", "1", "2", "3", "4", "5", "6"} ;
		map.put("weekCnt", weekCnt);
		return (int)selectOne("partnerManagement.weekPartnerIndividualNewCreateCnt", map);
	}
	
	/**
	 * @explain : 모바일 파트너사 협업관리 -> 파트너 정보 -> 영역별 현황
	 */
	@SuppressWarnings("unchecked")
	public  List<Map<String, Object>> selecetPartnerIndividualStatusByAreaList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("partnerManagement.selecetPartnerIndividualStatusByAreaList", map);
	}

	/**
	 * 모바일 파트너사 협업관리 -> 파트너사 개인 리스트 총 개수
	 * @param map
	 * @return
	 */
	public Map<String, Object> selectPartnerIndividualInfoCount(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("partnerManagement.selectPartnerIndividualInfoCount", map);
	}
	
	/**
	 * 모바일 파트너사 협업관리 -> 파트너사 개인 리스트 총 개수
	 * @param map
	 * @return
	 */
	public Map<String, Object> selectPartnerCompanyCount(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("partnerManagement.selectPartnerCompanyCount", map);
	}
}