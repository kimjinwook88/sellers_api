package com.uni.sellers.bizstrategy;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.uni.sellers.datasource.AbstractDAO;

@Repository("bizStrategyDAO")
public class BizStrategyDAO extends AbstractDAO{
	 
	//사업전략 -> 회사/부문별전략
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBizStrategyCategory(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("bizStrategy.selectBizStrategyCategory", map);
	}
	
	@SuppressWarnings("unchecked")
	 public List<Map<String, Object>> selectBizStrategyList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("bizStrategy.selectBizStrategyList", map);
	 }
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBizStrategyListCount(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("bizStrategy.selectBizStrategyListCount", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBizStrategyDetail(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("bizStrategy.selectBizStrategyDetail", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBizStrategyMileStones(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("bizStrategy.selectBizStrategyMileStones", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertBizStrategy(Map<String, Object> map) throws Exception{
		return (int)insert("bizStrategy.insertBizStrategy", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateBizStrategy(Map<String, Object> map) throws Exception{
		return (int)update("bizStrategy.updateBizStrategy", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertBizStrategyMileStones(Map<String, Object> map) throws Exception{
		return (int)insert("bizStrategy.insertBizStrategyMileStones", map);
	}

	@SuppressWarnings("unchecked")
	public int updateBizStrategyMileStones(Map<String, Object> map) throws Exception{
		return (int)insert("bizStrategy.updateBizStrategyMileStones", map);
	}
	
	@SuppressWarnings("unchecked")
	public int selectMileStonesBizStrategyKey(Map<String, Object> map) throws Exception{
		return (int)selectOne("bizStrategy.selectMileStonesBizStrategyKey", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBizStrategyFileList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("bizStrategy.selectBizStrategyFileList", map);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//사업전략 -> 전략프로젝트
	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> selectProjectPlanList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("bizStrategy.selectProjectPlanList", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectProjectPlanListCount(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("bizStrategy.selectProjectPlanListCount", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectProjectPlanDetail(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("bizStrategy.selectProjectPlanDetail", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectSearchProjectPlanDetailGroup(Map<String, Object> map) throws Exception{
		Map<String, Object> groupMap = new HashMap<String, Object>();
		groupMap.put("division",selectList("bizStrategy.selectSearchProjectPlanDetailGroup1", map));
		return groupMap;
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectProjectPlanSum(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("bizStrategy.selectProjectPlanSum", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertProjectPlan(Map<String, Object> map) throws Exception{
		return (int)insert("bizStrategy.insertProjectPlan", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertProjectPlanContract(Map<String, Object> map) {
		return (int)insert("bizStrategy.insertProjectPlanContract", map);
	}

	@SuppressWarnings("unchecked")
	public int insertProjectPlanInvest(Map<String, Object> map) {
		return (int)insert("bizStrategy.insertProjectPlanInvest", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateProjectPlan(Map<String, Object> map) throws Exception{
		return (int)update("bizStrategy.updateProjectPlan", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProjectPlanFileList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("bizStrategy.selectProjectPlanFileList", map);
	}

	@SuppressWarnings("unchecked")
	public int insertProjectPlanFile(Map<String, Object> map) throws Exception{
		return (int)insert("bizStrategy.insertProjectPlanFile",map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMileStonesProjectPlanList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("bizStrategy.selectMileStonesProjectPlanList", map);
	}

	@SuppressWarnings("unchecked")
	public int selectMileStonesProjectPlanKey(Map<String, Object> map) throws Exception{
		return (int)selectOne("bizStrategy.selectMileStonesProjectPlanKey", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> selectProjectPlanOpportunityList(Map<String, Object> map) throws Exception{
		return (List<Map<String,Object>>)selectList("bizStrategy.selectProjectPlanOpportunityList", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertOppProjectPlan(Map<String, Object> map) throws Exception{
		return (int)insert("bizStrategy.insertOppProjectPlan", map);
	}
	
	@SuppressWarnings("unchecked")
	public int deleteOppProjectPlan(Map<String, Object> map) throws Exception{
		return (int)delete("bizStrategy.deleteOppProjectPlan", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertMileStonesProjectPlanList(HashMap<String, Object> map) throws Exception{
		return (int)insert("bizStrategy.insertMileStonesProjectPlanList", map);
	}

	@SuppressWarnings("unchecked")
	public int updateMileStonesProjectPlanList(HashMap<String, Object> map) throws Exception{
		return (int)insert("bizStrategy.updateMileStonesProjectPlanList", map);
	}

	@SuppressWarnings("unchecked")
	public int deleteProjectPlan(Map<String, Object> map) throws Exception{
		return (int)delete("bizStrategy.deleteProjectPlan", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectProjectPlanInfo(Map<String, Object> map) throws Exception{
		Map<String, Object> InfoMap = new HashMap<String, Object>();
		InfoMap.put("selectProjectPlanContractInfo",selectList("bizStrategy.selectProjectPlanContractInfo", map));
		InfoMap.put("selectProjectPlanInvestInfo",selectList("bizStrategy.selectProjectPlanInvestInfo", map));
		return InfoMap;
	}

	@SuppressWarnings("unchecked")
	public int deleteProjectPlanContractAmount(Map<String, Object> map) throws Exception{
		return (int)delete("bizStrategy.deleteProjectPlanContractAmount", map);
	}

	@SuppressWarnings("unchecked")
	public int deleteProjectPlanInvestAmount(Map<String, Object> map) throws Exception{
		return (int)delete("bizStrategy.deleteProjectPlanInvestAmount", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProjectPlanIssue(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("bizStrategy.selectProjectPlanIssue", map);
	}

	@SuppressWarnings("unchecked")
	public int selectActionPlanProjectPlanKey(Map<String, Object> map) throws Exception{
		return (int)selectOne("bizStrategy.selectActionPlanProjectPlanKey", map);
	}

	@SuppressWarnings("unchecked")
	public int insertProjectPlanIssue(HashMap<String, Object> map) throws Exception{
		return (int)insert("bizStrategy.insertProjectPlanIssue", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateProjectPlanIssue(HashMap<String, Object> map) throws Exception{
		return (int)insert("bizStrategy.updateProjectPlanIssue", map);
	}

	@SuppressWarnings("unchecked")
	public int deleteProjectPlanActionPlan(Map<String, Object> map) throws Exception{
		return (int)delete("bizStrategy.deleteProjectPlanActionPlan", map);
	}

	// 사업전략 : 이슈해결계획
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBizStrategyIssue(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("bizStrategy.selectBizStrategyIssue", map);
	}

	@SuppressWarnings("unchecked")
	public int selectActionPlanBizStrategyKey(Map<String, Object> map) throws Exception{
		return (int)selectOne("bizStrategy.selectActionPlanBizStrategyKey", map);
	}

	@SuppressWarnings("unchecked")
	public int insertBizStrategyIssue(HashMap<String, Object> map) throws Exception{
		return (int)insert("bizStrategy.insertBizStrategyIssue", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateBizStrategyIssue(HashMap<String, Object> map) throws Exception{
		return (int)insert("bizStrategy.updateBizStrategyIssue", map);
	}
	
	@SuppressWarnings("unchecked")
	public int deleteBizStrategyIssue(Map<String, Object> map) throws Exception{
		return (int)delete("bizStrategy.deleteBizStrategyIssue", map);
	}

	
	//mobile
	@SuppressWarnings("unchecked")
	public int selectBizStrategyCountMobile(Map<String, Object> map) throws Exception{
		return (int)selectOne("bizStrategy.selectBizStrategyCountMobile", map);
	}
	 
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBizStrategyListMobile(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("bizStrategy.selectBizStrategyListMobile", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridMileStonesBizStrategyList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("bizStrategy.gridMileStonesBizStrategyList", map);
	}
	
	//사업전략 -> 전략프로젝트 리스트
	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> selectProjectPlanListMobile(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("bizStrategy.selectProjectPlanListMobile", map);
	}
	
	//사업전략 -> 전략프로젝트 MileStones
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridMileStonesProjectPlanList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("bizStrategy.gridMileStonesProjectPlanList", map);
	}
}
