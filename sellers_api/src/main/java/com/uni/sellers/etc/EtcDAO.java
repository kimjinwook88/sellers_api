package com.uni.sellers.etc;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.uni.sellers.datasource.AbstractDAO;

@Repository("etcDAO")
public class EtcDAO extends AbstractDAO{ 
	
	//고도리 대시보드 _ 본부
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientGodoryDashBoardDivision(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("etc.selectClientGodoryDashBoardDivision", map);
	}
	
	//고도리 대시보드 _ 팀
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGodoryDashBoardTeam(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("etc.selectGodoryDashBoardTeam", map);
	}
	
	//고도리 대시보드 _ 직원
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGodoryDashBoardMember(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("etc.selectGodoryDashBoardMember", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectGodoryCount(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("etc.selectGodoryCount", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGodoryList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("etc.selectGodoryList", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectGodoryDetail(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("etc.selectGodoryDetail", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertClientGodory(Map<String, Object> map) throws Exception{
		return (int)insert("etc.insertClientGodory", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertClientGodorySolvePlan(Map<String, Object> map) throws Exception{
		return (int)insert("etc.insertClientGodorySolvePlan", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateClientGodorySolvePlan(Map<String, Object> map) throws Exception{
		return (int)insert("etc.updateClientGodorySolvePlan", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateClientGodory(Map<String, Object> map) throws Exception{
		return (int)insert("etc.updateClientGodory", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGodoryManager(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("etc.selectGodoryManager", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSolvePlanIssue(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectList("etc.selectSolvePlanIssue", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridCeoOnHand(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("etc.gridCeoOnHand", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertCeoOnHand(Map<String, Object> map) throws Exception{
		int cnt = 0;
		cnt = (int)insert("etc.insertCeoOnHand", map);
		/*cnt =  (int)insert("kyungnong.insertCheckList", map); //초기데이터
		cnt =  (int)insert("kyungnong.insertCheckListOwner", map); //초기데이터
*/		return cnt; 
	};
	
	@SuppressWarnings("unchecked")
	public int updateCeoOnHandMilestone(Map<String, Object> map) throws Exception{
		return (int)insert("etc.updateCeoOnHandMilestone", map); 
	};
	
	@SuppressWarnings("unchecked")
	public int insertCeoOnHandMilestone(Map<String, Object> map) throws Exception{
		return (int)insert("etc.insertCeoOnhandMilestone", map); 
	};
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCeoOnHandDetail(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("etc.selectCeoOnHandDetail", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCeoOnHandMilestons(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("etc.selectCeoOnHandMilestons", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateCeoOnHand(Map<String, Object> map) throws Exception{
		return (int)update("etc.updateCeoOnHand", map);
	}
	
}
