package com.uni.sellers.salesmanagement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.uni.sellers.datasource.AbstractDAO;

@Repository("salesManagementDAO")
public class SalesManagementDAO extends AbstractDAO{

	//제안관리
	@SuppressWarnings("unchecked") 
	public int insertProposalsInfo(Map<String, Object> map) throws Exception{
		return (int)insert("salesManagement.insertProposalsInfo", map);
	}
	@SuppressWarnings("unchecked") 
	public int updateProposalsInfo(Map<String, Object> map) throws Exception{
		return (int)update("salesManagement.updateProposalsInfo", map);
	}
	@SuppressWarnings("unchecked") 
	public Map<String, Object> selectProposalsInfoDetail(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("salesManagement.selectProposalsInfoDetail", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProposalsInfotList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("salesManagement.selectProposalsInfotList", map);
	}
	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> selectProposalsInfoFileList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("salesManagement.selectProposalsInfoFileList", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> suggestSearchDetailGroup(Map<String, Object> map) throws Exception{
		Map<String, Object> groupMap = new HashMap<String, Object>();
		groupMap.put("company_name",selectList("salesManagement.suggestSearchDetailGroup1", map));
		return groupMap;
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectProposalsInfoListCount(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("salesManagement.selectProposalsInfoListCount", map);
	}
	@SuppressWarnings("unchecked")
	public String selectProposalsInfoLatelyUpdate(Map<String, Object> map) throws Exception{
		return (String)selectOne("salesManagement.selectProposalsInfoLatelyUpdate", map);
	}
	

	
	
	//성과관리
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectResultDashBoardDivision(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("salesManagement.selectResultDashBoardDivision", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectResultDashBoardTeam(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("salesManagement.selectResultDashBoardTeam", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectResultDashBoardMember(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("salesManagement.selectResultDashBoardMember", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectResultDashBoardCompany(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("salesManagement.selectResultDashBoardCompany", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectResultDashBoardCompanyGroup(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("salesManagement.selectResultDashBoardCompanyGroup", map);
	}
	
	//생산성
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGraphData(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("salesManagement.selectGraphData", map);
	}

	//나의 생산성
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMyProductivityGraphData(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("salesManagement.selectMyProductivityGraphData", map);
	}
	
	//Face Time TEST!!@!@!@!@!$!#
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> test2(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("salesManagement.test2", map);
	}
	
	//Face Time TEST!!@!@!@!@!$!#
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> test3(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("salesManagement.test3", map);
	}
	
	//Face Time TEST!!@!@!@!@!$!#
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> test4(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("salesManagement.test4", map);
	}
	
	
	//Face Time
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridFaceTime(Map<String, Object> map) throws Exception{
		if(map.get("viewType") != null && "y".equals(map.get("viewType"))){
			return (List<Map<String, Object>>)selectList("salesManagement.gridFaceTime_year", map);
		}else if("m".equals(map.get("viewType"))){
			return (List<Map<String, Object>>)selectList("salesManagement.gridFaceTime_month", map);
		}else{
			if("1".equals(map.get("selectFaceQuarter"))){
				map.put("quarterDate", map.get("selectFaceYear")+"0101");
			}else if("2".equals(map.get("selectFaceQuarter"))){
				map.put("quarterDate", map.get("selectFaceYear")+"0401");
			}else if("3".equals(map.get("selectFaceQuarter"))){
				map.put("quarterDate", map.get("selectFaceYear")+"0701");
			}else{
				map.put("quarterDate", map.get("selectFaceYear")+"1001");
			}
			log.debug("?"+map.get("quarterDate"));
			return (List<Map<String, Object>>)selectList("salesManagement.gridFaceTime_quarter", map);
		}
	}
	
	//회서 전체 평균
	//일단 월, 분기만 적용
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> companyAvgMap(Map<String, Object> map) throws Exception{
		if(map.get("viewType") != null && "y".equals(map.get("viewType"))){
//			return (List<Map<String, Object>>)selectList("salesManagement.gridFaceTime_year_avg", map);
			return (List<Map<String, Object>>)selectList("salesManagement.gridFaceTime_year", map);
		}else if("m".equals(map.get("viewType"))){
			return (List<Map<String, Object>>)selectList("salesManagement.gridFaceTime_month_avg", map);
		}else{
			if("1".equals(map.get("selectFaceQuarter"))){
				map.put("quarterDate", map.get("selectFaceYear")+"0101");
			}else if("2".equals(map.get("selectFaceQuarter"))){
				map.put("quarterDate", map.get("selectFaceYear")+"0401");
			}else if("3".equals(map.get("selectFaceQuarter"))){
				map.put("quarterDate", map.get("selectFaceYear")+"0701");
			}else{
				map.put("quarterDate", map.get("selectFaceYear")+"1001");
			}
			log.debug("?"+map.get("quarterDate"));
			return (List<Map<String, Object>>)selectList("salesManagement.gridFaceTime_quarter_avg", map);
		}
	}
	
	@SuppressWarnings("unchecked")
	public HashMap<String, Object> faceTimeSearchDetailGroup(Map<String, Object> map) throws Exception{
		HashMap<String, Object> groupMap = new HashMap<String, Object>();
		
		groupMap.put("faceYear",selectList("salesManagement.faceTimeSearchDetailGroup1", map));
//		groupMap.put("faceMonth",selectList("salesManagement.faceTimeSearchDetailGroup2", map));
//		groupMap.put("faceQuarter",selectList("salesManagement.faceTimeSearchDetailGroup4", map));
		groupMap.put("facePost",selectList("salesManagement.faceTimeSearchDetailGroup3", map));
		groupMap.put("faceTeam",selectList("salesManagement.faceTimeSearchDetailGroup5", map));
		groupMap.put("faceMember",selectList("salesManagement.faceTimeSearchDetailGroup6", map));

		return groupMap;
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDivisionList(Map<String, Object> map) {
		return  (List<Map<String, Object>>)selectList("salesManagement.selectDivisionList", map);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap<String, Object> selectWeeklyReportYear(Map<String, Object> map) {
		HashMap<String, Object> groupMap = new HashMap<String, Object>();
		
		groupMap.put("yearTarget",selectOne("salesManagement.selectYearTarget", map));
		groupMap.put("quarterTarget",selectOne("salesManagement.selectQuaterTarget", map));
		groupMap.put("siReport",selectOne("salesManagement.selectSiReport", map));
		groupMap.put("maReport",selectOne("salesManagement.selectMaReport", map));
		groupMap.put("etcReport",selectOne("salesManagement.selectEtcReport", map));
		
		return  groupMap;
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectWeeklyReportQuarter(Map<String, Object> map) {
		return  (List<Map<String, Object>>)selectList("salesManagement.selectWeeklyReportQuarter", map);
	}	
	
	/*@SuppressWarnings("unchecked")
	public Map<String, Object> clientContactSearchDetailGroup(Map<String, Object> map) throws Exception{
		Map<String, Object> groupMap = new HashMap<String, Object>();
		groupMap.put("event_category",selectList("salesActive.clientContactSearchDetailGroup1", map));
		groupMap.put("company_name",selectList("salesActive.clientContactSearchDetailGroup2", map));
		return groupMap;
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridClientContact(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("salesActive.gridClientContact", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> clientContactFileList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("salesActive.clientContactFileList", map);
	}
	@SuppressWarnings("unchecked")
	public int deleteClientContact(Map<String, Object> map) throws Exception{
		return (int)delete("salesActive.deleteClientContact", map);
	}*/
	
	
	
	@SuppressWarnings("unchecked")
	public int insertTestData(Map<String, Object> map) throws Exception{
		return (int)insert("salesManagement.insertTestData", map);
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> listTestUser(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("salesManagement.listTestUser", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> listTestDivision(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("salesManagement.listTestDivision", map);
	}
	
}
