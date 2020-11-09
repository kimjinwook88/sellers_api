package com.uni.sellers.tracking;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.uni.sellers.datasource.AbstractDAO;

@Repository("trackingDAO")
public class TrackingDAO extends AbstractDAO{
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientIssueTracking(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectClientIssueTracking", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientIssueActionPlanTracking() throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectClientIssueActionPlanTracking");
	}

	@SuppressWarnings("unchecked")
	public int insertNotice(Map<String, Object> map) throws Exception{
		return (int)insert("tracking.insertNotice", map);
	}
	
	@SuppressWarnings("unchecked")
	public int deleteTrackingNotice() throws Exception{
		return (int)delete("tracking.deleteTrackingNotice", "");
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOuruserInfo(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectOuruserInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientContactFollowUpActionTracking() throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectClientContactFollowUpActionTracking");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOpportunityMilestonesTracking() throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectOpportunityMilestonesTracking");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOpportunityContractDateTracking() throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectOpportunityContractDateTracking");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOpportunityAmountTracking(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectOpportunityAmountTracking", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectHiddenOpportunityActionPlanTracking() throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectHiddenOpportunityActionPlanTracking");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientSatisfactionFollowUpActionTracking() throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectClientSatisfactionFollowUpActionTracking");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectServiceProjectMilestonesTracking() throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectServiceProjectMilestonesTracking");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectServiceProjectIssueTracking() throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectServiceProjectIssueTracking");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBizStrategyCompanyKeyMilestonesTracking(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectBizStrategyCompanyKeyMilestonesTracking", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBizStrategyCompanyIssueTracking(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectBizStrategyCompanyIssueTracking", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBizStrategyProjectPlanMilestonesTracking() throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectBizStrategyProjectPlanMilestonesTracking");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBizStrategyProjectPlanIssueTracking() throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectBizStrategyProjectPlanIssueTracking");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientOpportunityCheckListTracking() throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectClientOpportunityCheckListTracking");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectClientOpportunityWinPlanTracking() throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectClientOpportunityWinPlanTracking");
	}
	
	@SuppressWarnings("unchecked")
	public int deleteOffice365CalendarEvent(Map<String, Object> map) throws Exception{
		return (int)delete("tracking.deleteOffice365CalendarEvent", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertOffice365CalendarEvent(List<Map<String, Object>> list) throws Exception{
		return (int)insert("tracking.insertOffice365CalendarEvent", list);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTodayCalendarEventMemberList() throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectTodayCalendarEventMemberList");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMemberCalendarEventTracking(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectMemberCalendarEventTracking", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMemberTrackingOption(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectMemberTrackingOption", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProposalsInfoTracking(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectProposalsInfoTracking", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertUserTrackingOption(Map<String, Object> map) throws Exception{
		return (int)insert("tracking.insertUserTrackingOption", map); 
	};
	
	@SuppressWarnings("unchecked")
	public int updateUserTrackingOption(Map<String, Object> map) throws Exception{
		return (int)update("tracking.updateUserTrackingOption", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDivisionMember(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("tracking.selectDivisionMember", map);
	}
}
