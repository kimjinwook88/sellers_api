package com.uni.sellers.bizstrategy;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.uni.sellers.common.CommonDAO;
import com.uni.sellers.util.CommonFileUtils;
import com.uni.sellers.util.CommonUtils;

@Service("bizStrategyService")
public class BizStrategyService{
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name="commonFileUtils")
	private CommonFileUtils commonFileUtils;
	
	@Resource(name="bizStrategyDAO")
	private BizStrategyDAO bizStrategyDAO;
	
	@Resource(name="commonDAO")
	private CommonDAO commonDAO;
	
	//사업전략 -> 회사/부문별전략
	public List<Map<String, Object>> selectBizStrategyCategory(Map<String, Object> map) throws Exception {
		return bizStrategyDAO.selectBizStrategyCategory(map);
	}
	
	public List<Map<String, Object>> selectBizStrategyList(Map<String, Object> map) throws Exception {
		return bizStrategyDAO.selectBizStrategyList(map);
	}
	
	public Map<String, Object> selectBizStrategyDetail(Map<String, Object> map) throws Exception {
		return bizStrategyDAO.selectBizStrategyDetail(map);
	}
	
	/**
	 * @author 	: 준이
	 * @Date		: 2017. 03. 17.
	 * @explain	: 사업전략 -> 회사 / 부문별 / 고객별 -> 상세정보 입력
	 */
	public int insertBizStrategy(HttpServletRequest request, Map<String, Object> map) throws Exception {
		int cnt = bizStrategyDAO.insertBizStrategy(map);
		//insertMileStonesBizStrategy(map);
		insertBizStrategyMileStones(map);
		insertBizStrategyIssue(map);
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request, "BIZ_FILE_STORE","BIZ_ID");
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}
		return cnt;
	}
	
	/**
	 * @author 	: 준이
	 * @Date		: 2017. 03. 17.
	 * @explain	: 사업전략 -> 회사 / 부문별 / 고객별 -> 상세정보 수정
	 */
	public int updateBizStrategy(HttpServletRequest request, Map<String, Object> map) throws Exception {
		map.put("filePK", map.get("hiddenModalPK"));
		int cnt = bizStrategyDAO.updateBizStrategy(map);
		//insertMileStonesBizStrategy(map);
		insertBizStrategyMileStones(map);
		insertBizStrategyIssue(map);
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request,"BIZ_FILE_STORE","BIZ_ID");
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}
		return cnt;
	}
	
	/**
	 * @author 	: 준이
	 * @Date		: 2017. 03. 17.
	 * @explain	: 사업전략 -> 회사 / 부문별 / 고객별 -> 상세보기 마일스톤 리스트
	 */
	//public List<Map<String, Object>> selectMileStonesBizStrategyList(Map<String, Object> map) throws Exception {
	public List<Map<String, Object>> selectBizStrategyMileStones(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		//return bizStrategyDAO.selectMileStonesBizStrategyList(map);
		return bizStrategyDAO.selectBizStrategyMileStones(map);
	}
	
	/**
	 * @author 	: 준이
	 * @Date		: 2017. 03. 17.
	 * @explain	: 사업전략 -> 회사 / 부문별 / 고객별 -> 상세정보 마일스톤 입력
	 */
	public int insertBizStrategyMileStones(Map<String, Object> map) throws Exception {
		int cnt = 0;
		ArrayList<HashMap<String, Object>> mileStoneList = CommonUtils.jsonList((map.get("milestone")).toString());
		
		for(Map<String,Object> mileStoneMap : mileStoneList){
			mileStoneMap.putAll(map);
			if(!CommonUtils.isEmpty(mileStoneMap.get("MILESTONE_ID"))){
				//bizStrategyDAO.updateMileStonesBizStrategy(mileStoneMap);
				bizStrategyDAO.updateBizStrategyMileStones(mileStoneMap);
			}else{
				//bizStrategyDAO.insertMileStonesBizStrategy(mileStoneMap);
				bizStrategyDAO.insertBizStrategyMileStones(mileStoneMap);
			}
		}
		
		cnt ++;
		return cnt;
	}
	
	public Map<String, Object> selectProjectPlanDetail(Map<String, Object> map) throws Exception {
		return bizStrategyDAO.selectProjectPlanDetail(map);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	 // 프로젝트 계획 jqgrid 리스트 출력
	public List<Map<String, Object>> selectProjectPlanList(Map<String, Object> map) throws Exception {
		return bizStrategyDAO.selectProjectPlanList(map);
	}
	
	 // 프로젝트 계획 페이지 입력
	public int insertProjectPlan(HttpServletRequest request, Map<String, Object> map) throws Exception {
		//main insert
		int cnt = bizStrategyDAO.insertProjectPlan(map);
		//amount insert
		if(!map.get("selectModalContractAmount").equals("") && map.get("selectModalContractAmount") != null) {
			String ContractDate = (String)map.get("hiddenModalContractDate");
			String ContractPlanAmount = (String)map.get("hiddenModalContractPlanAmount");
			String ContractActualAmount = (String)map.get("hiddenModalContractActualAmount");
			
			String arrContractDate[] = ContractDate.split(",");
			String arrContractPlanAmount[] = ContractPlanAmount.split(",");
			String arrContractActualAmount[] = ContractActualAmount.split(",");
			for(int i=0; i<arrContractDate.length; i++){
				/*log.debug("amountArrDate="+arrContractDate[i]);
				log.debug("amountArr111="+arrContractPlanAmount[i]);
				log.debug("amountArr222="+arrContractActualAmount[i]);*/
				map.put("filePK",map.get("filePK"));
				map.put("hiddenModalProjectId",map.get("filePK"));
				map.put("ContractDate", arrContractDate[i]+"-01");
				map.put("ContractPlanAmount", arrContractPlanAmount[i]);
				map.put("ContractActualAmount", arrContractActualAmount[i]);
				cnt += bizStrategyDAO.insertProjectPlanContract(map);
			}
		}
		if(!map.get("selectModalInvestAmount").equals("") && map.get("selectModalInvestAmount") != null) {
			String InvestDate = (String)map.get("hiddenModalInvestDate");
			String InvestPlanAmount = (String)map.get("hiddenModalInvestPlanAmount");
			String InvestActualAmount = (String)map.get("hiddenModalInvestActualAmount");
			
			String arrInvestDate[] = InvestDate.split(",");
			String arrInvestPlanAmount[] = InvestPlanAmount.split(",");
			String arrInvestActualAmount[] = InvestActualAmount.split(",");
			for(int i=0; i<arrInvestDate.length; i++){
				/*log.debug("amountArrDate="+arrInvestDate[i]);
				log.debug("amountArr111="+arrInvestPlanAmount[i]);
				log.debug("amountArr222="+arrInvestActualAmount[i]);*/
				//map.put("filePK",map.get("filePK"));
				map.put("InvestDate", arrInvestDate[i]+"-01");
				map.put("InvestPlanAmount", arrInvestPlanAmount[i]);
				map.put("InvestActualAmount", arrInvestActualAmount[i]);
				cnt += bizStrategyDAO.insertProjectPlanInvest(map);
			}
		}
		
		//영업기회
		ArrayList<HashMap<String, Object>> oppList = CommonUtils.jsonList((map.get("oppData")).toString());
		bizStrategyDAO.deleteOppProjectPlan(map); //삭제 후 insert
		for(HashMap<String,Object> getMap : oppList){
			getMap.put("pkNo",map.get("filePK"));
			getMap.put("hiddenModalCreatorId", map.get("hiddenModalCreatorId"));
			bizStrategyDAO.insertOppProjectPlan(getMap);
		}
		
		//milestone
		insertMileStonesProjectPlanList(map);
		
		//action plan
		insertProjectPlanIssue(map);
		
		//file
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request,"BIZ_PROJECT_PLAN_FILE_STORE","PROJECT_ID");
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}
		return cnt;
	}
	
	
	public int updateProjectPlan(HttpServletRequest request, Map<String, Object> map) throws Exception {
		int cnt = bizStrategyDAO.updateProjectPlan(map);
		map.put("filePK", map.get("hiddenModalProjectId"));
		
		cnt += bizStrategyDAO.deleteProjectPlanContractAmount(map);
		if(!map.get("selectModalContractAmount").equals("") && map.get("selectModalContractAmount") != null) {
			String ContractDate = (String)map.get("hiddenModalContractDate");
			String ContractPlanAmount = (String)map.get("hiddenModalContractPlanAmount");
			String ContractActualAmount = (String)map.get("hiddenModalContractActualAmount");
			
			String arrContractDate[] = ContractDate.split(",");
			String arrContractPlanAmount[] = ContractPlanAmount.split(",");
			String arrContractActualAmount[] = ContractActualAmount.split(",");
			for(int i=0; i<arrContractDate.length; i++){
				map.put("ContractDate", arrContractDate[i]+"-01");
				map.put("ContractPlanAmount", arrContractPlanAmount[i]);
				map.put("ContractActualAmount", arrContractActualAmount[i]);
				cnt += bizStrategyDAO.insertProjectPlanContract(map);
			}
		}
		
		cnt += bizStrategyDAO.deleteProjectPlanInvestAmount(map);
		if(!map.get("selectModalInvestAmount").equals("") && map.get("selectModalInvestAmount") != null) {
			String InvestDate = (String)map.get("hiddenModalInvestDate");
			String InvestPlanAmount = (String)map.get("hiddenModalInvestPlanAmount");
			String InvestActualAmount = (String)map.get("hiddenModalInvestActualAmount");
			
			String arrInvestDate[] = InvestDate.split(",");
			String arrInvestPlanAmount[] = InvestPlanAmount.split(",");
			String arrInvestActualAmount[] = InvestActualAmount.split(",");
			for(int i=0; i<arrInvestDate.length; i++){
				map.put("InvestDate", arrInvestDate[i]+"-01");
				map.put("InvestPlanAmount", arrInvestPlanAmount[i]);
				map.put("InvestActualAmount", arrInvestActualAmount[i]);
				cnt += bizStrategyDAO.insertProjectPlanInvest(map);
			}
		}
		
		//영업기회
		ArrayList<HashMap<String, Object>> oppList = CommonUtils.jsonList((map.get("oppData")).toString());
		bizStrategyDAO.deleteOppProjectPlan(map); //삭제 후 insert
		for(HashMap<String,Object> getMap : oppList){
			getMap.put("pkNo",map.get("hiddenModalProjectId"));
			getMap.put("hiddenModalCreatorId", map.get("hiddenModalCreatorId"));
			bizStrategyDAO.insertOppProjectPlan(getMap);
		}
		
		//milestone
		insertMileStonesProjectPlanList(map);
		
		//action plan
		insertProjectPlanIssue(map);
				
		//file
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request,"BIZ_PROJECT_PLAN_FILE_STORE","PROJECT_ID");
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}
		return cnt;
	}

	public Map<String, Object> selectSearchProjectPlanDetailGroup(Map<String, Object> map) throws Exception {
		return bizStrategyDAO.selectSearchProjectPlanDetailGroup(map);
	}
	

	
	public List<Map<String, Object>> selectProjectPlanFileList(Map<String, Object> map) throws Exception {
		return bizStrategyDAO.selectProjectPlanFileList(map);
	}

	
	public List<Map<String, Object>> selectMileStonesProjectPlanList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return bizStrategyDAO.selectMileStonesProjectPlanList(map);
	}
	
	
	public Map<String, Object> selectProjectPlanInfo(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return bizStrategyDAO.selectProjectPlanInfo(map);
	}
	
	
	public int insertMileStonesProjectPlanList(Map<String, Object> map) throws Exception {
		int cnt = 0;
		ObjectMapper mapper = new ObjectMapper();
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>(); 
		String jsonData = (map.get("milestone")).toString();		 
		list = mapper.readValue(jsonData, new TypeReference<ArrayList<HashMap<String, String>>>() {});
		
		map.put("project_id", map.get("filePK"));
		int projectIdCount= bizStrategyDAO.selectMileStonesProjectPlanKey(map);
		
		for(int i=0; i<list.size(); i++){
			list.get(i).put("project_id", map.get("filePK"));
			list.get(i).put("category", map.get("selectModalCategory"));
			list.get(i).put("creator_id", map.get("hiddenModalCreatorId"));
			if(list.get(i).get("HIDDEN_STATUS") != null && !list.get(i).get("HIDDEN_STATUS").equals("")){
				list.get(i).put("STATUS", list.get(i).get("HIDDEN_STATUS"));
			}else{
				list.get(i).put("STATUS", "");
			}
			if(((String) list.get(i).get("DUE_DATE")).trim().equals("")){
				list.get(i).put("DUE_DATE", null);
			}
			if(((String) list.get(i).get("CLOSE_DATE")).trim().equals("")){
				list.get(i).put("CLOSE_DATE", null);
			}
			if(projectIdCount > 0){
				bizStrategyDAO.updateMileStonesProjectPlanList(list.get(i));
			}else{
				bizStrategyDAO.insertMileStonesProjectPlanList(list.get(i));
			}
			cnt ++;
		}
		
		return cnt;
	}
	
	
	public int deleteProjectPlan(Map<String, Object> map,HttpServletRequest request) throws Exception {
		map.put("fileBizIds", map.get("hiddenModalPK"));
		map.put("biz_id", map.get("hiddenModalPK"));
		
		List<Map<String, Object>> fileList = bizStrategyDAO.selectProjectPlanFileList(map);
		int cnt = bizStrategyDAO.deleteProjectPlan(map);
		commonFileUtils.deleteFileAll(fileList,request);

		
		return cnt;
	}
	
	
	public List<Map<String, Object>> selectProjectPlanIssue(Map<String, Object> map) throws Exception {
		return bizStrategyDAO.selectProjectPlanIssue(map);
	}
	
	
	public int deleteProjectPlanActionPlan(Map<String, Object> map) throws Exception {
		map.put("action_id", map.get("actionplan_id"));
		int cnt = bizStrategyDAO.deleteProjectPlanActionPlan(map);
		return cnt;
	}

	
	public int insertProjectPlanIssue(Map<String, Object> map) throws Exception {
		int cnt = 0;
		ObjectMapper mapper = new ObjectMapper();
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>(); 
		String jsonData = (map.get("actionPlanData")).toString();		 
		list = mapper.readValue(jsonData, new TypeReference<ArrayList<HashMap<String, String>>>() {});        
		
//		int projectIdCount= bizStrategyDAO.selectActionPlanProjectPlanKey(map);
		
		for(int i=0; i<list.size(); i++){
			list.get(i).put("hiddenModalPK", map.get("filePK"));
			list.get(i).put("creator_id", map.get("creator_id"));
			list.get(i).put("hiddenModalCreatorId", map.get("hiddenModalCreatorId"));
			if(((String) list.get(i).get("DUE_DATE")).trim().equals("")){
				list.get(i).put("DUE_DATE", null);
			}
			if(((String) list.get(i).get("CLOSE_DATE")).trim().equals("")){
				list.get(i).put("CLOSE_DATE", null);
			}
			if(((String) list.get(i).get("ACTION_ID")).trim().equals("")){
				bizStrategyDAO.insertProjectPlanIssue(list.get(i));
			}else{
				bizStrategyDAO.updateProjectPlanIssue(list.get(i));
			}
			cnt ++;
		}
		
		return cnt;
	}
	
	// 사업전략 액션플랜(이슈)
	
	public List<Map<String, Object>> selectBizStrategyIssue(Map<String, Object> map) throws Exception {
		return bizStrategyDAO.selectBizStrategyIssue(map);
	}
	
	/**
	 * @author 	: 준이
	 * @Date		: 2017. 03. 17.
	 * @explain	: 사업전략 -> 회사 / 부문별 / 고객별 -> 이슈 삭제
	 */
	//public int deleteBizStrategyActionPlan(Map<String, Object> map) throws Exception {
	public int deleteBizStrategyIssue(Map<String, Object> map) throws Exception {
		map.put("action_id", map.get("actionplan_id"));
		//int cnt = bizStrategyDAO.deleteBizStrategyActionPlan(map);
		int cnt = bizStrategyDAO.deleteBizStrategyIssue(map);
		return cnt;
	}
	
	/**
	 * @author 	: 준이
	 * @Date		: 2017. 03. 17.
	 * @explain	: 사업전략 -> 회사 / 부문별 / 고객별 -> 이슈 입력
	 */
	public int insertBizStrategyIssue(Map<String, Object> map) throws Exception {
		int cnt = 0;
		ObjectMapper mapper = new ObjectMapper();
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>(); 
		String jsonData = (map.get("actionPlanData")).toString();		 
		list = mapper.readValue(jsonData, new TypeReference<ArrayList<HashMap<String, String>>>() {});        
		
//		int projectIdCount= bizStrategyDAO.selectActionPlanBizStrategyKey(map);
		
		for(int i=0; i<list.size(); i++){
			
			if(null == list.get(i).get("ACTION_OWNER") || list.get(i).get("ACTION_OWNER").equals(""))
			{
				list.get(i).put("ACTION_OWNER_ID", "");
			}
			
			list.get(i).put("hiddenModalPK", map.get("filePK"));
			list.get(i).put("creator_id", map.get("creator_id"));
			list.get(i).put("hiddenModalCreatorId", map.get("hiddenModalCreatorId"));
			if(((String) list.get(i).get("DUE_DATE")).trim().equals("")){
				list.get(i).put("DUE_DATE", null);
			}
			if(((String) list.get(i).get("CLOSE_DATE")).trim().equals("")){
				list.get(i).put("CLOSE_DATE", null);
			}
			if(((String) list.get(i).get("ACTION_ID")).trim().equals("")){
				bizStrategyDAO.insertBizStrategyIssue(list.get(i));
			}else{
				bizStrategyDAO.updateBizStrategyIssue(list.get(i));
			}
			cnt ++;
		}
		return cnt;
	}

	
	//mobile
	public int selectBizStrategyCountMobile(Map<String, Object> map) throws Exception {
		return bizStrategyDAO.selectBizStrategyCountMobile(map);
	}
	
	public List<Map<String, Object>> selectBizStrategyListMobile(Map<String, Object> map) throws Exception {
		return bizStrategyDAO.selectBizStrategyListMobile(map);
	}
	
	public List<Map<String, Object>> gridMileStonesBizStrategyList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return bizStrategyDAO.gridMileStonesBizStrategyList(map);
	}
	
	//사업전략 -> 전략프로젝트 리스트
	public List<Map<String, Object>> selectProjectPlanListMobile(Map<String, Object> map) throws Exception {
		return bizStrategyDAO.selectProjectPlanListMobile(map);
	}
	
	//사업전략 -> 전략프로젝트 MileStones
	public List<Map<String, Object>> gridMileStonesProjectPlanList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return bizStrategyDAO.gridMileStonesProjectPlanList(map);
	}
}
