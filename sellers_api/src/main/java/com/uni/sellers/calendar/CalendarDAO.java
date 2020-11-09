package com.uni.sellers.calendar;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.uni.sellers.datasource.AbstractDAO;
import com.uni.sellers.util.CommonDateUtils;

@Repository("calendarDAO")

public class CalendarDAO extends AbstractDAO{

	@SuppressWarnings("unchecked")
	public int addCalendar(Map<String, Object> map) throws Exception{
		return (int)insert("calendar.addCalendar", map);
	}

	@SuppressWarnings("unchecked")
	public int deleteCalendar(Map<String, Object> map) throws Exception{
		return (int)delete("calendar.deleteCalendar", map);
	}

	@SuppressWarnings("unchecked")
	public int deleteShareMember(Map<String, Object> map) throws Exception{
		return (int)delete("calendar.deleteShareMember", map);
	}

	@SuppressWarnings("unchecked")
	public int deleteInviteMemberList(Map<String, Object> map) throws Exception{
		return (int)delete("calendar.deleteInviteMemberList", map);
	}

	@SuppressWarnings("unchecked")
	public int reNameCalendar(Map<String, Object> map) throws Exception{
		return (int)update("calendar.reNameCalendar", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> getCalendarList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("calendar.getCalendarList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> getShareCalList(Map<String, Object> map) throws Exception{
		return (List<Map<String,Object>>)selectList("calendar.getShareCalList", map);
	}

	@SuppressWarnings("unchecked")
	public int insertCalendarEvent(Map<String, Object> map) throws Exception{
		return (int)insert("calendar.insertCalendarEvent", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCalendarEvent(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("calendar.selectCalendarEvent", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCalendarEventRRuleSync(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("calendar.selectCalendarEventRRuleSync", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCalendarInviteTable(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("calendar.selectCalendarInviteTable", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCalendarEventDateTime(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("calendar.selectCalendarEventDateTime", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectUserName(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("calendar.selectUserName", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectMyCalendarMaster(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("calendar.selectMyCalendarMaster", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectInvitedCalendarMaster(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("calendar.selectInvitedCalendarMaster", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> insertConviteAgree(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("calendar.insertConviteAgree", map);
	}

	@SuppressWarnings("unchecked")
	public int updateCalendarInviteEvent(Map<String, Object> map) throws Exception{
		return (int)update("calendar.updateCalendarInviteEvent", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateCalendarEvent(Map<String, Object> map) throws Exception{
		return (int)update("calendar.updateCalendarEvent", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateCalendarRRuleSyncEvent(Map<String, Object> map) throws Exception{
		return (int)update("calendar.updateCalendarRRuleSyncEvent", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateCalendarRRuleEvent(Map<String, Object> map) throws Exception{
		return (int)update("calendar.updateCalendarRRuleEvent", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateCalendarRRuleEvent2(Map<String, Object> map) throws Exception{
		return (int)update("calendar.updateCalendarRRuleEvent2", map);
	}

	@SuppressWarnings("unchecked")
	public int updateCaceledEventSubject(Map<String, Object> map) throws Exception{
		return (int)update("calendar.updateCaceledEventSubject", map);
	}



	@SuppressWarnings("unchecked")
	public int updateInvitedCalendarMaster(Map<String, Object> map) throws Exception{
		return (int)update("calendar.updateInvitedCalendarMaster", map);
	}

	@SuppressWarnings("unchecked")
	public int insertNoticeCancelEvent(Map<String, Object> map) throws Exception{
		return (int)insert("calendar.insertNoticeCancelEvent", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertInvitedCalendarMaster(Map<String, Object> map) throws Exception{
		return (int)insert("calendar.insertInvitedCalendarMaster", map);
	}


	@SuppressWarnings("unchecked")
	public int deleteCalendarRepeatRule(Map<String, Object> map) throws Exception{
		return (int)delete("calendar.deleteCalendarRepeatRule", map);
	}

	@SuppressWarnings("unchecked")
	public int deleteCalendarInviteEvent(Map<String, Object> map) throws Exception{
		return (int)delete("calendar.deleteCalendarInviteEvent", map);
	}

	@SuppressWarnings("unchecked")
	public int deleteCalendarEvent(Map<String, Object> map) throws Exception{
		return (int)delete("calendar.deleteCalendarEvent", map);
	}

	@SuppressWarnings("unchecked")
	public int deleteCalEvent(Map<String, Object> map) throws Exception{
		//return (int)delete("calendar.deleteCalEvent", map);
		return (int)update("calendar.deleteCalEvent", map);
	}
	
	public int deleteCalRRuleSyncEvent(Map<String, Object> map) throws Exception{
		//return (int)delete("calendar.deleteCalEvent", map);
		return (int)update("calendar.deleteCalRRuleSyncEvent", map);
	}
	
	public int deleteCalendarEventRRuleSyncID(Map<String, Object> map) throws Exception{
		//return (int)delete("calendar.deleteCalEvent", map);
		return (int)update("calendar.deleteCalendarEventRRuleSyncID", map);
	}
	public int deleteCalendarEventRRuleSyncID2(Map<String, Object> map) throws Exception{
		//return (int)delete("calendar.deleteCalEvent", map);
		return (int)update("calendar.deleteCalendarEventRRuleSyncID2", map);
	}

	@SuppressWarnings("unchecked")
	public int deleteNotice(Map<String, Object> map) throws Exception{
		return (int)delete("calendar.deleteNotice", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> calendarEventList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("calendar.calendarEventList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> holidayEventList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("calendar.holidayEventList", map);
	}

	@SuppressWarnings("unchecked")
	public int selectRruleCheck(Map<String, Object> map) throws Exception{
		return (int)selectOne("calendar.selectRruleCheck", map);
	}

	@SuppressWarnings("unchecked")
	public int insertRepeatEvent(Map<String, Object> map) throws Exception{
		return (int)insert("calendar.insertRepeatEvent", map);
	}

	@SuppressWarnings("unchecked")
	public int updateRepeatEvent(Map<String, Object> map) throws Exception{
		return (int)update("calendar.updateRepeatEvent", map);
	}

	@SuppressWarnings("unchecked")
	public int deleteRepeatEvent(Map<String, Object> map) throws Exception{
		return (int)delete("calendar.deleteRepeatEvent", map);
	}

	@SuppressWarnings("unchecked")
	public int updateICSdir(Map<String, Object> map) throws Exception{
		return (int)update("calendar.updateICSdir", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> sellersCalendarEvent(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("calendar.sellersCalendarEvent", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSellersOutlookCalSyncEvent(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("calendar.selectSellersOutlookCalSyncEvent", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectInviteEvent(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("calendar.selectInviteEvent", map);
	}

	@SuppressWarnings("unchecked")
	public void insertInviteEvent(Map<String, Object> map) throws Exception{
		insert("calendar.insertInviteEvent", map);
	}

	@SuppressWarnings("unchecked")
	public int updateInviteEvent(Map<String, Object> map) throws Exception{
		return (int)update("calendar.updateInviteEvent", map);
	}

	//일정초대자 리스트
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getInviteMemberList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("calendar.getInviteMemberList", map);
	}

	//외부캘린더 공유
	@SuppressWarnings("unchecked")
	public void changeOutCalendarSync(Map<String, Object> map) throws Exception{
		update("calendar.changeOutCalendarSync", map);
	}

	@SuppressWarnings("unchecked")
	public int insertShareCalendar(Map<String, Object> map) throws Exception{
		return (int)insert("calendar.insertShareCalendar", map);
	}

	@SuppressWarnings("unchecked")
	public int insertShareCalendarNotice(Map<String, Object> map) throws Exception{
		return (int)insert("calendar.insertShareCalendarNotice", map);
	}

	@SuppressWarnings("unchecked")
	public int updateShareCalendar(Map<String, Object> map) throws Exception{
		return (int)update("calendar.updateShareCalendar", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> selectShareCalendar(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("calendar.selectShareCalendar", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> shareCalendarList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("calendar.shareCalendarList", map);
	}

	@SuppressWarnings("unchecked")
	public int updateCalendar(Map<String, Object> map) throws Exception{
		return (int)update("calendar.updateCalendar", map);
	}

	//Face Time
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridIndividualFaceTime(Map<String, Object> map) throws Exception{
		if(map.get("viewType") != null && "y".equals(map.get("viewType"))){
			return (List<Map<String, Object>>)selectList("calendar.gridIndividualFaceTime_year", map);
		}else if("m".equals(map.get("viewType"))){
			return (List<Map<String, Object>>)selectList("calendar.gridIndividualFaceTime_month", map);
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
			return (List<Map<String, Object>>)selectList("calendar.gridIndividualFaceTime_quarter", map);
		}
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectDivisionNteamInfo(Map<String, Object> map) throws Exception{

		return (Map<String, Object>)selectOne("calendar.selectDivisionNteamInfo", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> myProductivity(Map<String, Object> map) throws Exception{
		Map<String, Object> groupMap = new HashMap<String, Object>();

		groupMap.put("faceYear",selectList("calendar.faceTimeSearchDetailGroup1", map));
		//groupMap.put("faceMonth",selectList("calendar.faceTimeSearchDetailGroup2", map));
		//groupMap.put("faceQuarter",selectList("calendar.faceTimeSearchDetailGroup4", map));
		//groupMap.put("facePost",selectList("calendar.faceTimeSearchDetailGroup3", map));
		//groupMap.put("faceTeam",selectList("calendar.faceTimeSearchDetailGroup5", map));
		groupMap.put("faceMember",selectList("calendar.faceTimeSearchDetailGroup6", map));
		
		return groupMap;
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectEventDetail(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("calendar.selectEventDetail", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> listRruleCheckDate(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("calendar.listRruleCheckDate", map);
	}
	
	//캘린더2.0
	@SuppressWarnings("unchecked")
	public int insertRepeatEvent2(Map<String, Object> map) throws Exception{
		return (int)insert("calendar.insertRepeatEvent2", map);
	}
	
	//캘린더2.0
	@SuppressWarnings("unchecked")
	public int insertCalendarRepeatEvent(Map<String, Object> map) throws Exception{
		return (int)insert("calendar.insertCalendarRepeatEvent", map);
	}

	//캘린더2.0
	@SuppressWarnings("unchecked")
	public int updateCalEventRruleExDate(Map<String, Object> map) throws Exception{
		return (int)update("calendar.updateCalEventRruleExDate", map);
	}
	
	//캘린더2.0
	@SuppressWarnings("unchecked")
	public int updateCalEventRrule(Map<String, Object> map) throws Exception{
		return (int)update("calendar.updateCalEventRrule", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> calendarEventListMobile(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("calendar.calendarEventListMobile", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCalendarEventMobile(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("calendar.selectCalendarEventMobile", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCalendarRepeatRule(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("calendar.selectCalendarRepeatRule", map);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCalendarRepeatGarbageData(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("calendar.selectCalendarRepeatGarbageData", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> calendarEventListMobile2(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("calendar.calendarEventListMobile2", map);
	}
	
	@SuppressWarnings("unchecked")
	public int upsertGoogleEventId(Map<String, Object> map) throws Exception{
		return (int)update("calendar.upsertGoogleEventId", map);
	}
	
	@SuppressWarnings("unchecked")
	public String selectGoogleId(Map<String, Object> map) throws Exception{
		return (String)selectOne("calendar.selectGoogleId", map);
	}
	
	public int deleteExDateEvent(Map<String, Object> map) throws Exception{
		return (int)update("calendar.deleteExDateEvent", map);
	}
	
	public int deleteExDateEventRrule(Map<String, Object> map) throws Exception{
		return (int)update("calendar.deleteExDateEventRrule", map);
	}

	public int updateCalEventRruleBySyncId(Map<String, Object> map) {
		return (int)update("calendar.updateCalEventRruleBySyncId", map);
	}
	
	public int deleteCalEventAndExEvent(Map<String, Object> map) {
		return (int)update("calendar.deleteCalEventAndExEvent", map);
	}

	public int deleteCalEventAndRrule(Map<String, Object> map) {
		return (int)update("calendar.deleteCalEventAndRrule", map);
	}
}
