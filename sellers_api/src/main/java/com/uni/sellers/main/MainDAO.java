package com.uni.sellers.main;

import java.util.List;
import java.util.Map;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import com.uni.sellers.datasource.AbstractDAO;

@Repository("mainDAO")
public class MainDAO extends AbstractDAO{

	/////////////////////개발 완료후 삭제 소스 시작///////////////////////
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectErrNbugList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectErrNbugList", map);
	}
	@SuppressWarnings("unchecked")
	public int updateErrNbugSuccessStatus(Map<String, Object> map) throws Exception{
		return (int)update("main.updateErrNbugSuccessStatus", map);
	}
	
	@SuppressWarnings("unchecked")
	public int deleteQ(Map<String, Object> map) throws Exception{
		return (int)delete("main.deleteQ", map);
	}
	
	//////////////////////개발 완료후 삭제 소스 끝///////////////////////////
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMainSetUp(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectMainSetUp", map);
	}
	
	/**
	 * 모바일 랜딩페이지 -> 실적현황 그래프 (누적) selextBox option (TEAM)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectResultGraphOptionTeam(Map<String, Object> map) throws Exception{
		//return (List<Map<String, Object>>)selectList("main.selectResultGraphOptionTeam", map);
		
		for(String key : map.keySet()){
			log.info("key = " + key + " / value = " + map.get(key));
		}
		
		return (List<Map<String, Object>>)selectList("common.selectNameList2", map);
	}
	
	/**
	 * 모바일 랜딩페이지 -> 실적현황 그래프 (누적) selextBox option (MEMBER)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectResultGraphOptionMember(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectResultGraphOptionMember", map);
	}
	/**
	 * 모바일 랜딩페이지(셀러) -> 영업기회 그래프 DATA
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectOpportunityGraphData(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("main.selectOpportunityGraphData", map);
	}	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTimeLine(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectTimeLine", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSalesAct(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectSalesAct", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSalesAct2(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectSalesAct2", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectHiddenSalesAct(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectHiddenSalesAct", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientIssue(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectClientIssue", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNewUpdate(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectNewUpdate", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTrackingList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectTrackingList", map);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectResult(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("main.selectResult", map);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCompanyResult(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("main.selectCompanyResult", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectResultGraph(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectResultGraph", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMyCompanyList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectMyCompanyList", map);
	}
	@SuppressWarnings("unchecked")
	public int selectMyCompanyListCount(Map<String, Object> map) throws Exception{
		return (int)selectOne("main.selectMyCompanyListCount", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectContactList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectContactList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNewCstmList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectNewCstmList", map);
	}
	@SuppressWarnings("unchecked")
	public int insertMainModule(Map<String, Object> map) throws Exception{
		return (int)insert("main.insertMainModule", map);
	}
	@SuppressWarnings("unchecked")
	public int insertMainMenu(Map<String, Object> map) throws Exception{
		return (int)insert("main.insertMainMenu", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMainModuleSetUp(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectMainModuleSetUp", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMainMenuSetUp(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectMainMenuSetUp", map);
	}
	@SuppressWarnings("unchecked")
	@Cacheable("commonCache")
	public List<Map<String, Object>> selectMemberMenu(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectMemberMenu", map);
	}
	@SuppressWarnings("unchecked")
	@Cacheable("commonCache")
	public List<Map<String, Object>> selectMemberMobileMenu(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectMemberMobileMenu", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectUserMobileLandingPage(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectUserMobileLandingPage", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMobileLandingPageMenuList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectMobileLandingPageMenuList", map);
	}
	@SuppressWarnings("unchecked")
	public int insertUserMobileLandingPageMenu(Map<String, Object> map) throws Exception{
		return (int)insert("main.insertUserMobileLandingPageMenu", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSalesActBubbleChart(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectSalesActBubbleChart", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSalesActDonutChart(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectSalesActDonutChart", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSalesActDonutChart2(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectSalesActDonutChart2", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectForecastDonutChart(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectForecastDonutChart", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectForecastDonutChart2(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectForecastDonutChart2", map);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectSalesActDonutChartY2Y(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("main.selectSalesActDonutChartY2Y", map);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectSalesActDonutChartY2Y_last(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("main.selectSalesActDonutChartY2Y_last", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSalesDivision(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectSalesDivision", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSalesTeam(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectSalesTeam", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSalesMember(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("main.selectSalesMember", map);
	}
	@SuppressWarnings("unchecked")
	public int insertUserMobileToken(Map<String, Object> map) throws Exception{
		return (int)insert("main.insertUserMobileToken", map);
	}
}
