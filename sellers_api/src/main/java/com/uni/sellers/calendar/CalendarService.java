package com.uni.sellers.calendar;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.google.api.client.auth.oauth2.Credential;
import com.uni.sellers.common.CommonMailService;
import com.uni.sellers.util.CommonDateUtils;
import com.uni.sellers.util.CommonFileUtils;

import net.fortuna.ical4j.model.DateList;
import net.fortuna.ical4j.model.Recur;

@Service("CalendarService")
public class CalendarService{
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name="googleCalendarService")
	private GoogleCalendarService googleCalendarService;
	
	@Resource(name="commonFileUtils")
	private CommonFileUtils commonFileUtils;

	@Resource(name="calendarDAO")
	private CalendarDAO calendarDAO;

	@Resource(name="commonMailService")
	private CommonMailService commonMailService;

	@Value("#{config['url.calendarSync']}")
	private String CALENDAR_SYNC_URL;

	@Value("#{config['path.calUserInfo']}")
	private String calUserInfoPath;
	
	private String rrule;
	
	
	public int addCalendar(HttpServletRequest request, Map<String, Object> map) throws Exception {
		int cnt = calendarDAO.addCalendar(map);
		return cnt;
	}
	
	public int deleteCalendar(HttpServletRequest request, Map<String, Object> map) throws Exception {
		CommonFileUtils cfu = new CommonFileUtils();
		int cnt = calendarDAO.deleteCalendar(map);
		
		//outlook or google 캘린더 삭제 (파일삭제)
		if ( cnt == 0 ) {
			cfu.deleteFile(map, calUserInfoPath);
		}
		return cnt;
	}


	public int deleteShareMember(HttpServletRequest request, Map<String, Object> map) throws Exception {
		int cnt = calendarDAO.deleteShareMember(map);
		return cnt;
	}

	//일정초대자 리스트 삭제
	public int deleteInviteMemberList(HttpServletRequest request, Map<String, Object> map) throws Exception {
		int cnt = calendarDAO.deleteInviteMemberList(map);
		return cnt;
	}


	public int reNameCalendar(HttpServletRequest request, Map<String, Object> map) throws Exception {
		int cnt = calendarDAO.reNameCalendar(map);
		return cnt;
	}

	public Map<String, Object> downICS(HttpServletRequest request, Map<String, Object> map) throws Exception {

		commonFileUtils.downICS(map, request);

		if(map.get("calendar").equals("google"))
		{
			map.put("CALENDAR_NAME", "Google 캘린더");
			map.put("textCalendarName", "Google 캘린더");
			map.put("hiddenModalCreatorId", map.get("creatorId"));

			//Google DB Upsert
			int cnt = calendarDAO.updateICSdir(map);
			if(cnt < 1){
				calendarDAO.addCalendar(map);
				calendarDAO.updateICSdir(map);
			}
		}

		return map;
	}
	/*

	public void updateICSdir(Map<String, Object> map) throws Exception {

		if(map.get("calendar").equals("google")){
			map.put("CALENDAR_NAME", "구글 캘린더");
		}else{
			map.put("CALENDAR_NAME", "MS 캘린더");
		}

		calendarDAO.updateICSdir(map);
	}
	 */

	public List<Map<String,Object>> getCalendarList(HttpServletRequest request, Map<String, Object> map) throws Exception {
		log.debug("getCalendarList Call. ");
		
		List<Map<String,Object>> list = new ArrayList<>();
		
		//동료 캘린더 보기
		if(map.get("shareMemberId") != null){
			map.put("MEMBER_ID_NUM", map.get("shareMemberId"));
			list = calendarDAO.getCalendarList(map);
			
			/*
			for(int z=0; z<list.size(); z++){
				if(!list.get(z).get("CALENDAR_NAME").equals("나의 캘린더")){
					list.remove(z);
				}
			}
			 */
			for(int z=0; z<list.size(); z++){
				if(!list.get(z).get("CALENDAR_TYPE").equals("1")){
					list.remove(z);
				}
			}
		}else{
			list = calendarDAO.getCalendarList(map);

			//나의 캘린더가 생성된 후에, 동료캘린거 정보 담기
			if(list.size() > 0)
			{
				List<Map<String,Object>> shareCalList = calendarDAO.getShareCalList(map);
				Map<String,Object>	shareMap = null;


				for(int j=0; j<shareCalList.size(); j++)
				{
					shareMap = new HashMap<>();

					shareMap.put("CALENDAR_NAME", shareCalList.get(j).get("CALENDAR_NAME"));
					shareMap.put("MEMBER_ID_NUM", shareCalList.get(j).get("MEMBER_ID_NUM"));
					shareMap.put("CALENDAR_ID", shareCalList.get(j).get("CALENDAR_ID"));
					shareMap.put("MEMBER_NAME", shareCalList.get(j).get("MEMBER_NAME"));
					shareMap.put("POSITION_STATUS", shareCalList.get(j).get("POSITION_STATUS"));
					list.add(shareMap);

				}
			}

			/***
			 * 캘릭더 리스트를 가지고 와서,
			 * 구글캘린더 ics 파일 업데이트를 진행한다.(최신 ics 파일연동)
			 * 사용안함
			 */
			/*for(int i=0; i<list.size(); i++){
				if(list.get(i).get("CALENDAR_NAME").equals("Google 캘린더"))
				{
					if(list.get(i).get("GOOGLE_ICS") != null)
					{
						map.put("downURL", list.get(i).get("GOOGLE_ICS"));
						map.put("calendar", "google");
						map.put("creatorId", list.get(i).get("MEMBER_ID_NUM"));
						commonFileUtils.downICS(map, request);
					}
				}
			}*/
			
			//google 인증상태일 경우 캘린가져오기
			/*Credential credential = googleCalendarService.getCheckAuthorize(map.get("MEMBER_ID_NUM").toString());
			if(credential != null) {
				request.getSession().setAttribute("gcToken", credential.getAccessToken());
				list = googleCalendarService.selectGoogleCalendarList(request, list);
			}*/
		}
		//		return calendarDAO.getCalendarList(map);
		return list;
	}
	
	 
	public List<Map<String,Object>> getShareCalendarList(HttpServletRequest request, Map<String, Object> map) throws Exception {
		List<Map<String,Object>> shareCalList = calendarDAO.getShareCalList(map);
		return shareCalList;
	}


	/**
	 * 일정관리 시작 날짜, 시간을 가져와서 가공
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public String getCalendarAlarmDateTime(Map<String, Object> map) throws Exception{
		log.debug("getCalendarAlarmDateTime Call. ");

		String alarmDateTime ="";

		String day = (String) map.get("textModalStartDate");
		String time = (String) map.get("selectModalStartDateTime");
		
		if(map.get("checkboxModalAllday") != null && map.get("checkboxModalAllday").equals("Y")) {
			time = "00:00";
		}
		/*
		String[] dayArray;
		String[] timeArray;

		dayArray = day.split("-");
		timeArray = time.split(":");

		alarmDateTime = dayArray[0]+dayArray[1]+dayArray[2]+timeArray[0]+timeArray[1];
		 */

		alarmDateTime = day+" "+time;
		
		return alarmDateTime;
	}


	/**
	 * 캘린더 일정을 등록하거나 수정할 때, 미리알림 시간을 가공한다.
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> alarmMap(Map<String, Object> map) throws Exception {
		log.debug("alarmMap Call. ");

		String alarmDatetime 	= getCalendarAlarmDateTime(map);
		String beforeDatetime	="";
		
		if(map.get("radioModalAlam") != null && !map.get("radioModalAlam").toString().equals("")){
			if(map.get("radioModalAlam").equals("oneHour"))
			{
				beforeDatetime = CommonDateUtils.getDateBeforeTimeMinute(alarmDatetime, 60);	// 한시간
				map.put("radioModalAlam", beforeDatetime);
				map.put("alarmFlag", "H");
				map.put("reminderTime", 60);
			}
			else if(map.get("radioModalAlam").equals("oneDay"))
			{
				beforeDatetime = CommonDateUtils.getDateBeforeTimeMinute(alarmDatetime, 1440);	// 하루
				map.put("radioModalAlam", beforeDatetime);
				map.put("alarmFlag", "D");
				map.put("reminderTime", 1440);
			}
			else if(map.get("radioModalAlam").equals("oneWeek"))
			{
				beforeDatetime = CommonDateUtils.getDateBeforeTimeMinute(alarmDatetime, 10080);	// 일주일
				map.put("radioModalAlam", beforeDatetime);
				map.put("alarmFlag", "W");
				map.put("reminderTime", 10080);
			}else if(map.get("radioModalAlam").equals("notNotice"))
			{
				map.put("radioModalAlam", null);
				map.put("alarmFlag", "N");
				map.put("reminderTime", 0);
			}
		}

		return map;
	}

	/**
	 * 일정초대 메일 보내기
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void sendMailService(Map<String, Object> map) throws Exception {
		log.debug("sendMailService Call. ");

		int cnt = 0;

		//초대하는 자 이름을 가져온다.
		map.put("MEMBER_ID_NUM", map.get("hiddenModalCreatorId"));
		List<Map<String,Object>> list = calendarDAO.getCalendarList(map);
		String HAN_NAME = (String) list.get(0).get("HAN_NAME");
		String eamil = (String) list.get(0).get("EMAIL");
		if(null == map.get("hiddenModalEmail") || "".equals(map.get("hiddenModalEmail"))){
			map.put("hiddenModalEmail", eamil); //초대하는 사람 이메일
		}

		//미팅초대
		//ex : {0392/jangsh@unipoint.co.kr/장성훈,0486/jwkim@unipoint.co.kr/김진욱}
		if(!map.get("hiddenModalMemberList").toString().isEmpty())
		{
			//초대자 다중일 때, list에 담아서 메일 한번에 보내기
			ArrayList<Object> toAddr = new ArrayList<>();
			ArrayList<Object> toIdList = new ArrayList<>();
			ArrayList<Object> toNameList = new ArrayList<>();
			map.put("EVENT_ID", map.get("EVENT_ID").toString());

			String[] arrayList;
			String memberInfo = (String) map.get("hiddenModalMemberList");
			arrayList = memberInfo.split(",");

			String invitedMemberIdNum = "";
			String invitedMemberEmail = "";
			String invitedMemberName  = "";

			int tmp = 0;
			for(int i=0; i<arrayList.length; i++)
			{
				String[] individualInfo;
				memberInfo = arrayList[i];
				individualInfo = memberInfo.split("/");
				invitedMemberIdNum 	= individualInfo[0];	//초대 받는자 ID
				invitedMemberEmail 	= individualInfo[1];	//초대 받는자 이메일
				invitedMemberName	= individualInfo[2];	//초대 받는자 이름

				
				//참석자명단.
				if(i==0)
				{
					for(int j=0; j<arrayList.length; j++)
					{
						String[] individualInfoArray;
						memberInfo = arrayList[j];
						individualInfoArray = memberInfo.split("/");
						
						//String invitedMemberIdNum2 	= individualInfoArray[0];	//초대 받는자 ID
						//String invitedMemberEmail2 	= individualInfoArray[1];	//초대 받는자 이메일
						String invitedMemberName2	= individualInfoArray[2];	//초대 받는자 이름
						
						//다수 수신자 이름 담기 ( 참석자 명단에 쓰임 )
						toNameList.add(invitedMemberName2);
					}
				}
				map.put("invitedMemberIdNum", invitedMemberIdNum);
				map.put("invitedMemberEmail", invitedMemberEmail);
				map.put("invitedMemberName", invitedMemberName);

				if(!map.get("sendMailFlag").equals("Y"))
				{
					map.put("SEND_STATUS_YN", "N");

					//DB insert
					calendarDAO.insertInviteEvent(map);
				}
				else if(map.get("sendMailFlag").equals("Y"))
				{
					try{

						cnt = commonMailService.calendarMeetingSendMail(map, toAddr, toNameList);

						//메일 보내기 성공한 후, 초대 DB에 insert
						if(cnt == 0){
							map.put("SEND_STATUS_YN", "Y");
							//DB insert
							calendarDAO.insertInviteEvent(map);
						}else if(cnt != 0){
							map.put("SEND_STATUS_YN", "N");
							calendarDAO.insertInviteEvent(map);
						}
					}catch(Exception e){

						cnt = -1;
						map.put("SEND_STATUS_YN", "N");
						//DB insert
						calendarDAO.insertInviteEvent(map);

						throw new Exception();
					}

					if(cnt == 0){
						//캘린더 공유받은 사람에게 알림 메시지로 알려준다.
						map.put("memberID", invitedMemberIdNum);
						map.put("noticeDetail", HAN_NAME+"님이 캘린더 일정에 초대하였습니다. 메일에서 확인하시기 바랍니다.");
						map.put("noticeCategory", "캘린더 일정 초대");
						calendarDAO.insertShareCalendarNotice(map);
					}

				}
			}//for end
		}
	}

	/**
	 * 셀러스 캘린더 <-> 사내 캘린더 Sync
	 * @param map
	 * @param cnt
	 * @return
	 * @throws Exception
	 */
	public void calendarSyncService(Map<String, Object> map) throws Exception {
		log.debug("calendarSyncService Call. ");

		//seller's 캘린더 일정 등록할 때, 캘린더sync 여부 Y 일 경우, 일정등록 outlook에 바로 싱크처리
		//비공개 일정은 Sync 처리 안한다. radioModalShareYN="N" 일경우
		if(map.get("hiddenModalSync_YN").equals("Y") && map.get("radioModalShareYN").equals("Y"))
		{
			ExCalendarConnect ec = new ExCalendarConnect();
			map.put("MEMBER_ID_NUM", map.get("hiddenModalCreatorId"));
			
			// outlook Id 값을 리턴받아 DB에 update 시킨다.
			String outlookId = ec.insertOutlookCalendarSync(map, CALENDAR_SYNC_URL, calUserInfoPath);
			if(outlookId != null && !outlookId.isEmpty()) {
				map.put("hiddenModalEventId", map.get("EVENT_ID"));
				map.put("outlookId", outlookId);
				calendarDAO.updateCalendarEvent(map);
			}
		}
	}

	/**
	 * 반복일정과 등록일정 및 업데이트일정에 대한 요일, 시간이 겹치는지 Check.
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int checkRruleEventDateTime(Map<String, Object> map) throws Exception{
		log.debug("checkRruleEventDateTime Call. ");
		
		int cnt =0;

		String rruleStartList[];
		String rruleEndList[];
		Map<String, Object> rruleStartMap = new HashMap<String, Object>();
		Map<String, Object> rruleEndMap = new HashMap<String, Object>();

		rruleStartList = map.get("rruleStartList").toString().split(",");
		rruleEndList = map.get("rruleEndList").toString().split(",");

		for(int a=0; a<rruleStartList.length; a++){
			if(a==0){
				rruleStartMap.put("rruleStartDate["+a+"]", rruleStartList[a].toString().substring(20, 36));
				rruleEndMap.put("rruleEndDate["+a+"]", rruleEndList[a].toString().substring(18, 34));
			}else{
				rruleStartMap.put("rruleStartDate["+a+"]", rruleStartList[a].toString().substring(19, 35));
				rruleEndMap.put("rruleEndDate["+a+"]", rruleEndList[a].toString().substring(17, 33));
			}
		}

		for(int j=0; j<rruleStartMap.size(); j++)
		{
			String rruleStartDateTime = (String) rruleStartMap.get("rruleStartDate["+j+"]");
			String rruleEndDateTime = (String) rruleEndMap.get("rruleEndDate["+j+"]");

			if(rruleStartDateTime.substring(0, 10).compareTo(map.get("textModalStartDate").toString())==0)
			{
				String rruleStartTime = rruleStartDateTime.substring(11, 16);								//반복일정 시작 시간
				String rruleEndTime = rruleEndDateTime.substring(11, 16);									//반복일정 종료 시간
				String modalStartDateTime = map.get("selectModalStartDateTime").toString();					//새로운 일정 시작 시간
				String modalEndDateTime = map.get("selectModalEndDateTime").toString();						//새로운 일정 종료 시간

				if((rruleStartTime.compareTo(modalStartDateTime) < 0 && rruleEndTime.compareTo(modalStartDateTime) > 0)
						|| (rruleStartTime.compareTo(modalEndDateTime) < 0 && rruleEndTime.compareTo(modalEndDateTime) > 0)
						|| (rruleStartTime.compareTo(modalStartDateTime) == 0))
				{
					//일정등록
					cnt = -2;
					break;
				}
			}//if
		}

		return cnt;
	}

	/**
	 * 일정등록할 때, 그날 일정에 시간이 겹치면 일정등록이 되지 않는다.
	 * ex) 기존에 9시~10시에 일정 '미팅'이 등록되어 있는 상태에서
	 * ex) 새로운 일정 9시~10시 또는 8시30분~9시30분 '고객만남' 미팅을 등록하려 할 때, 기존에 잡혀있는 일정 '미팅' 시간과 겹치는 현상이 발생하면 새로운 일정 '고개만남'을 등록시 상태 알려주기.
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int checkCalendarEventDateTime(Map<String, Object> map) throws Exception{
		log.debug("checkCalendarEventDateTime Call. ");
		
		int cnt =0;

		List<Map<String, Object>> eventDateList = calendarDAO.selectCalendarEventDateTime(map);
		if(eventDateList.size() > 0)
		{
			for(int i=0; i<eventDateList.size(); i++)
			{

				String todayEventDateStartTime = eventDateList.get(i).get("EVENT_START_TIME").toString();	//기존 일정 시작 시간
				String todayEventDateEndTime = eventDateList.get(i).get("EVENT_END_TIME").toString();		//기존 일정 종료 시간
				String modalStartDateTime = map.get("selectModalStartDateTime").toString();					//새로운 일정 시작 시간
				String modalEndDateTime = map.get("selectModalEndDateTime").toString();						//새로운 일정 종료 시간

				//등록하고자하는 일정에 대한 시작시간, 종료시간이 기존에 등록되어 있는 일정 시간시간과 종료시간 사이에 중첩될 경우.
				//등록하고자하는 일정에 대한 시작시간이 기존에 등록되어있는 일정 시간과 같을경우
				if((todayEventDateStartTime.compareTo(modalStartDateTime) < 0 && todayEventDateEndTime.compareTo(modalStartDateTime) > 0)
						|| (todayEventDateStartTime.compareTo(modalEndDateTime) < 0 && todayEventDateEndTime.compareTo(modalEndDateTime) > 0)
						|| (todayEventDateStartTime.compareTo(modalStartDateTime) == 0))
				{
					map.put("todayEventDateStartTime", todayEventDateStartTime);
					map.put("todayEventDateEndTime", todayEventDateEndTime);
					map.put("todayEventSubJect", eventDateList.get(i).get("EVENT_SUBJECT"));

					cnt = -1;
					break;
				}
			}//for
		}//if

		return cnt;
	}

	/**
	 * 캘린더 이벤트 추가
	 * @param map
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public int insertCalendarEvent(Map<String, Object> map, HttpServletRequest request) throws Exception {
		log.debug("insertCalendarEvent Call. ");
		
		int cnt = 0;
		int rruleEventCnt = 0;

		// 1. 알람 시간 가공
		Map<String, Object> alarmMap = alarmMap(map);
		map.putAll(alarmMap);

		// 2. 일정 중복 체크
		if(null != map.get("rruleStartList") && !map.get("rruleStartList").equals("[]"))
		{
			rruleEventCnt = checkRruleEventDateTime(map);		//cnt 0:반복일정과 중복없음     , -2: 반복일정과 날짜, 시간 중복
		}
		int calendarEventCnt = checkCalendarEventDateTime(map);	//cnt 0:캘린더일정과 중복없음   , -1: 캘린더일정과 날짜, 시간 중복
		
		if(rruleEventCnt != 0 || calendarEventCnt != 0)
		{
			//해당시간 일정 있는지 알려주는 상태 값
			map.put("insertDupEvent", "Y");
		}

		// 3. 일정 등록
		int insertCnt = 0;
		insertCnt = calendarDAO.insertCalendarEvent(map);
		
		// 4. 반복일정 체크
        if(map.get("hiddenModalRepeat_YN").equals("Y") && (map.get("rruleSyncID") == null || String.valueOf(map.get("rruleSyncID")).isEmpty()))  
		{
			insertCnt += upsertCalendarEventRRule(map);	
		}

		// 5. 일정초대메일 및 outlook sync
		if(insertCnt > 0)
		{
			// 일정 초대 메일 보내기
			sendMailService(map);

            /*if(map.get("outlookLoginYn").equals("Y") && (map.get("rruleSyncID") == null || String.valueOf(map.get("rruleSyncID")).isEmpty())) {
                if(map.get("rruleChoiceFlag") == null || String.valueOf(map.get("rruleChoiceFlag")) == "") {
                    // 일정 Sync 처리(seller's Calendar와 사내 Calendar)
                    calendarSyncService(map);
                }
            }else {
                cnt = -9;
            }*/
		}
		// 6. google 캘린더 insert
		if(insertCnt > 0 && (map.get("rruleSyncID") == null || String.valueOf(map.get("rruleSyncID")).isEmpty()))
		{
			/*Credential credential = googleCalendarService.getCheckAuthorize(map.get("MEMBER_ID_NUM").toString()); //인증상태 체크
			if(credential != null) {
				String googleEventId = googleCalendarService.insertGoogleCalendarEvent(map);
				map.put("googleEventId", googleEventId);
				calendarDAO.upsertGoogleEventId(map);
			}*/
		}

		return cnt;
	}
	
	/**
	 * 캘린더 이벤트 수정
	 * @param map
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public int updateCalendarEvent(Map<String, Object> map, HttpServletRequest request) throws Exception {
		log.debug("updateCalendarEvent Call. ");
		
		int cnt =0;
		int rruleEventCnt = 0;
		int calendarEventCnt =0;
		
		// 1. 알림 시간 설정
		Map<String, Object> alarmMap = alarmMap(map);
		map.putAll(alarmMap);

		// 일정이 오후 1시에서 오후 2시로 수정했으면, 기존에 1시에 insert 된 notice 메시지는 삭제한다.
		// 오후 2시일정에 설정된 미리알림 시간에 도달하면, 페이지 새로고침할 때, top.jsp 에서 Notice 테이블에 알림 내역을 insert 한다.
		calendarDAO.deleteNotice(map);

		// 2. 일정 중복 체크
		if(null != map.get("rruleStartList") && !map.get("rruleStartList").equals("[]")){
			rruleEventCnt = checkRruleEventDateTime(map);		//cnt 0:반복일정과 중복없음     , -2: 반복일정과 날짜, 시간 중복
		} 
		calendarEventCnt = checkCalendarEventDateTime(map);		//cnt 0:캘린더일정과 중복없음   , -1: 캘린더일정과 날짜, 시간 중복
		
		if(calendarEventCnt !=0 || rruleEventCnt !=0 ) {
			map.put("insertDupEvent", "Y");
		}

		// 3. 이동시간 체크 (이벤트 코드가 '고객컨택' 이였다가, 다른 이벤트 코드로 변경할 때 전후 이동시간을 0으로 셋팅)
		if(!map.get("selectModalEventCode").equals("1"))
		{
			map.put("selectModalBeforeMoveTimeMin", "0");
			map.put("selectModalAfterMoveTimeMin", "0");
		}
		
		// 3.5. 수정 이전의 날짜/시간 가져오기
		// Map<String, Object> beforeUpdateMap = calendarDAO.selectCalendarEvent(map);
		
		// 4. 반복일정 체크 후 일정 업데이트 (캘린더 2.0)
		int upCnt = 0; 
		if(map.get("rruleCase").toString().equals("0")) 	// 반복일정아닌 Event를 수정할 때 rruleCase = 0
		{ 		
			upCnt = calendarDAO.updateCalendarEvent(map); 	// 일정 업데이트
			
			if(map.get("hiddenModalRepeat_YN").equals("Y")) // 반복일정 아닌 Event를 반복일정으로 수정할 때 hiddenModalRepeat_YN = Y 
			{ 
				// 반복일정 룰 만드는 메서드 태움
				upCnt += upsertCalendarEventRRule(map);	
			}
		}
		else	// 반복일정 일 경우 rruleCase != 0 
		{ 
			upCnt = updateCalendarRRuleEvent(map, request);
		}
		
		// 5. outlook 일정 업데이트 & 초대메일
        if(upCnt > 0)
        {
            // 일정 초대메일 보내기
            sendUpdateMailService(map);
                        
            // 공개일정인지 체크
            if(String.valueOf(map.get("radioModalShareYN")).equals("Y")) {
            	// Outlook 로그인 여부 확인
            	if(String.valueOf(map.get("outlookLoginYn")).equals("Y")) {
            		
            		if(!(String.valueOf(map.get("checkboxModalRepeat")).equals("Y") && String.valueOf(map.get("rruleCase")).equals("2"))) {
            			// 사내캘린더 연동
                        calendarSyncUpdate(map, request);
            		}
            	}else {
            		cnt = -9;
            	}
            }
        }
        
        // 6. google 캘린더 update
 		if(upCnt > 0)
 		{
 			/*Credential credential = googleCalendarService.getCheckAuthorize(map.get("global_member_id").toString()); //인증상태 체크
 			if(credential != null) {
 				map.put("googleId", calendarDAO.selectGoogleId(map));
 				googleCalendarService.updateGoogleCalendarEvent(map);
 			}*/
 		}

		return cnt;
	}
	
	/**
	 * 캘린더 일정 삭제
	 * @param map
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public int deleteCalendarEvent(Map<String, Object> map,HttpServletRequest request) throws Exception {
		map.put("hiddenModalEventId", map.get("hiddenModalEventId"));
		int cnt = 0;

		// 1. 초대 취소메일 발송
		// 	 (일정 삭제시, 초대메일은 보낸 이력이 있으면, 취소메일을 보내준다.)
		List<Map<String, Object>> inviteTabList = calendarDAO.selectCalendarInviteTable(map);
		if(inviteTabList.size() > 0)
		{
			deleteCalendarEventCanceled(map, inviteTabList);
		}
		
		// 2. 반복일정 체크 후 일정 삭제 (캘린더 2.0)
		if(map.get("rruleCase").toString().equals("0")){ // 반복일정 X
			
			// 일정 삭제는 DB calendar_event 테이블에서 delete_yn 필드를 'Y'로 update 한다. 
			// 일정 가져올때는 delete_yn 필드가 'N'인 것만을 가져온다.
			cnt = calendarDAO.deleteCalEvent(map);
			
		}else{ // 반복일정 O
			
			map.put("delFlag", "Y");
			cnt = updateCalendarRRuleEvent(map, request);
		}
		
		// 3. outlook 일정 삭제
		if(cnt > 0) {
			
			// outlook 로그인 상태가 아니면 바로 리턴
			if(!String.valueOf( map.get("outlookLoginYn")).equals("Y")) {
				cnt = -9;
			}else {
				if(map.get("hiddenModalOutlookId") != null && !String.valueOf(map.get("hiddenModalOutlookId")).isEmpty()) {
					// 시작날짜 종료 날짜 가져오기
					Map<String, Object> eventInfo = calendarDAO.selectCalendarEvent(map);

					ExCalendarConnect ecc = new ExCalendarConnect();
					ecc.deleteOutlookEvent(map, eventInfo, CALENDAR_SYNC_URL, calUserInfoPath);
				}
			}
			
			
			// 4. google 일정 삭제
			/*Credential credential = googleCalendarService.getCheckAuthorize(map.get("global_member_id").toString()); //인증상태 체크
 			if(credential != null) {
 				map.put("EVENT_ID", map.get("hiddenModalEventId"));
 				map.put("googleId", calendarDAO.selectGoogleId(map));
 				googleCalendarService.deleteGoogleCalendarEvent(map);
 			}*/
		}
		return cnt;
	}


	public Map<String, Object> selectCalendarEvent(Map<String, Object> map, HttpServletRequest request) throws Exception {
		log.debug("selectCalendarEvent Call. ");
		
		Map<String,Object> sce = null;
		
		if(map.get("is_mobile") != null && map.get("is_mobile").equals("Y")) {
			sce = calendarDAO.selectCalendarEventMobile(map);
		}
		else {
			sce = calendarDAO.selectCalendarEvent(map);
		}
		

		//미팅 초대받은사람이 수락여부 회신을 주었을 경우에만 아래 로직 수행. 
		if(map.get("invitedFlag") != null && map.get("invitedFlag").equals("Y"))
		{

			
			Map<String,Object> sun = new HashMap<>();

			//수락여부 List 가져오기
			List<Map<String,Object>> InviteMemberList = getInviteMemberList(request, map);

			if (map.get("status").equals("Y")) {
				
				//calendar_event 테이블과 calendar_invite_event 테이블 연결하기 위해 INVITE_ID를 insert 해준다
				sce.put("hiddenModalEventId", sce.get("EVENT_ID"));
				List<Map<String, Object>> listOne = calendarDAO.selectCalendarInviteTable(sce);
				
				sce.put("INVITE_ID", listOne.get(0).get("INVITE_ID"));
				

				//초대 수락자 이름 가져오기
				sun = calendarDAO.selectUserName(map);
				sce.putAll(sun);
				sce.put("answerResult", "Y");

				/*
				//수락 여부 회신메일 보내기
				CommonMailService cmsi = new CommonMailService();
				cmsi.answerMail(sce, InviteMemberList);
				 */

				//이벤트 수락시, DB에 EVENT insert
				sce.put("CALENDAR_ID", map.get("inviteCalId"));
				sce.put("MEMBER_ID_NUM", map.get("inviteId"));
				sce.put("ALARM_PERIOD", map.get("ALARM_PERIOD"));
				sce.put("ALARM_TARGET", map.get("ALARM_TARGET"));
				sce.put("ALARM_FLAG", map.get("ALARM_FLAG"));

				calendarDAO.insertConviteAgree(sce);
			} else if(map.get("status").equals("N")){

				sun = calendarDAO.selectUserName(map);
				sce.putAll(sun);
				sce.put("answerResult", "N");

				/*
				//수락 여부 회신메일 보내기
				CommonMailService cmsi = new CommonMailService();
				cmsi.answerMail(sce, InviteMemberList);
				 */
			}
		}

		return sce;
	}


	public void updateCalendarInviteEvent(Map<String, Object> map) throws Exception {
		calendarDAO.updateCalendarInviteEvent(map);
	}

	
	
	//반복일정 전체 수정 버튼을 눌렀을때, 단일 일정에 대해서도 수정
	public void selectRRuleSyncEvent(Map<String, Object> map) throws Exception {
		
		List<Map<String,Object>> syncEventList = calendarDAO.selectCalendarEventRRuleSync(map);	// 단일 이벤트 있는지 체크
		
		if(syncEventList.size() > 0)
		{
			//DB rrule_sync_id 필드에 값이 있는지 체크하기위해 
			//map.put("rruleSyncEventYN", "Y");
			//rrule_sync_id 필드에 값 있는 것들을 업데이트
			calendarDAO.updateCalendarRRuleSyncEvent(map);
		}
	}
	
	
	
	/**
	 * 일정 업데이트할 때, 
	 * 저장or초대 메일 보내고 저장
	 * @param map
	 * @throws Exception
	 */
	public void sendUpdateMailService(Map<String, Object> map) throws Exception{
		int sendSuccess = 0;
		
		// 초대메일 보내지 않고 그냥 저장.
		if(!map.get("sendMailFlag").equals("Y"))
		{
			// 새로운 참석자 초대할 경우.
			if(!map.get("hiddenModalMemberList").toString().isEmpty())
			{

				String[] arrayList;
				String memberInfo = (String) map.get("hiddenModalMemberList");

				arrayList = memberInfo.split(",");

				for(int j=0; j<arrayList.length; j++)
				{
					String[] individualInfo;
					memberInfo = arrayList[j];
					individualInfo = memberInfo.split("/");

					String invitedMemberIdNum 	= individualInfo[0];	//초대자 받는자 ID
					String invitedMemberEmail 	= individualInfo[1];	//초대자 받는자 이메일
					String invitedMemberName	= individualInfo[2];	//초대자 받는자 이름

					map.put("EVENT_ID", map.get("hiddenModalEventId"));
					map.put("invitedMemberIdNum", invitedMemberIdNum);
					map.put("invitedMemberEmail", invitedMemberEmail);
					map.put("SEND_STATUS_YN", "N");
					map.put("selectModalCalendarID", map.get("hiddenModalCalendarId"));

					//inviteEvent Table insert
					calendarDAO.insertInviteEvent(map);
				}
			}
		}
		// 초대메일 보내고 저장할 경우.
		else 
		{
			//메일 보낼 때, 다중 초대자에게 한번에 메일 보내기위해 list에 담아 놓는다.
			ArrayList<Object> toAddr = new ArrayList<>();
			ArrayList<Object> toMemberIdNum = new ArrayList<>();
			ArrayList<Object> toNameList = new ArrayList<>();

			//해당 Event ID 값을 세팅
			map.put("EVENT_ID", map.get("hiddenModalEventId"));

			//기존에 저장한 초대자가 있는지 select 한다.
			List<Map<String,Object>> getInviteList = calendarDAO.selectInviteEvent(map);
			for(int i=0; i < getInviteList.size(); i++)
			{
				String selectEmail	= (String) getInviteList.get(i).get("EMAIL");
				String selectMemberIdNum = (String) getInviteList.get(i).get("MEMBER_ID_NUM");
				String selectInvitedMember = (String) getInviteList.get(i).get("HAN_NAME");

				toAddr.add(selectEmail);					//기존 초대자(초대받는 자) Email 주소를 list에 담는다.
				toMemberIdNum.add(selectMemberIdNum);		//기존 초대자(초대받는 자) ID를 list에 담는다.
				toNameList.add(selectInvitedMember);		//기존 초대자(초대받는 자) 이름을 list에 담는다.
			}

			// 새로운 참석자를 초대할 경우.
			if(!map.get("hiddenModalMemberList").toString().isEmpty())
			{
				// 새로운 참석자를 초대
				String[] arrayList;
				String memberInfo = (String) map.get("hiddenModalMemberList");
				arrayList = memberInfo.split(",");

				for(int j=0; j<arrayList.length; j++)
				{
					String[] individualInfo;
					memberInfo = arrayList[j];
					individualInfo = memberInfo.split("/");

					String invitedMemberIdNum 	= individualInfo[0];	//초대 받는자 ID
					String invitedMemberEmail 	= individualInfo[1];	//초대 받는자 이메일
					String invitedMemberName	= individualInfo[2];	//초대 받는자 이름

					// 새로 추가할 참석자 Email 주소를 list에 담는다.
					toAddr.add(invitedMemberEmail);
					// 새로 추가할 참석자 MEMBER_ID_NUM 을 list에 담는다.
					toMemberIdNum.add(invitedMemberIdNum);
					// 새로 추가할 참석자 이름을 list에 담는다.
					toNameList.add(invitedMemberName);

					//insert 위해 map에 put
					map.put("invitedMemberIdNum", invitedMemberIdNum);
					map.put("invitedMemberEmail", invitedMemberEmail);
					map.put("SEND_STATUS_YN", "N"); //일단 미발신으 insert
					map.put("selectModalCalendarID", map.get("hiddenModalCalendarId"));

					//inviteEvent Table insert
					calendarDAO.insertInviteEvent(map);
				}
			}

			//기존 저장한 초대자와 새로 추가된 초대자 모두에게 메일을 전송
			for(int i=0; i<toAddr.size(); i++)
			{
				map.put("invitedMemberEmail", toAddr.get(i));
				map.put("invitedMemberIdNum", toMemberIdNum.get(i));

				//메일보내기
				sendSuccess = commonMailService.calendarMeetingSendMail(map, toAddr, toNameList);

				//메일 보내기 성공후
				if( sendSuccess == 0 )
				{
					// 참석자 목록 TABLE 업데이트 ( 발신상태 'Y' )
					calendarDAO.updateInviteEvent(map);

					//초대 받는 사람에게 알림 기능_초대하는 자 이름을 가져온다.
					map.put("MEMBER_ID_NUM", map.get("hiddenModalCreatorId"));
					List<Map<String,Object>> list = calendarDAO.getCalendarList(map);
					String HAN_NAME = (String) list.get(0).get("HAN_NAME");
					map.put("noticeDetail", HAN_NAME+"님이 캘린더 일정에 초대하였습니다. 메일에서 확인하시기 바랍니다.");
					map.put("noticeCategory", "캘린더 일정 초대");
					
					//캘린더 공유받은 사람에게 알림 메시지로 알려준다.
					map.put("memberID", map.get("invitedMemberIdNum"));
					calendarDAO.insertShareCalendarNotice(map);
				}
			}//for end
		}
	}

	/**
	 * outlook 일정 업데이트
	 * @param map
	 * @param request
	 * @throws Exception 
	 */
	public void calendarSyncUpdate(Map<String, Object> map, HttpServletRequest request) throws Exception{
		
		ExCalendarConnect cc = new ExCalendarConnect();
		Map<String,Object> updateCalEventMap = new HashMap<String, Object>();

		map.put("MEMBER_ID_NUM", map.get("hiddenModalCreatorId"));
		List<Map<String,Object>> calList = calendarDAO.getCalendarList(map);

		//status : 0 -> 수락,  1-> 거절,  2-> 모달 업데이트
		//map.put("status", "2");

		// 이벤트 가져오기.
		updateCalEventMap = selectCalendarEvent(map, request);
		map.putAll(updateCalEventMap);

		// 업데이트  sync  
		cc.updateOutlookCalendarSync(map, calList, CALENDAR_SYNC_URL, calUserInfoPath);
	}
	
	/**
	 * 일정 초대 삭제할때, 취소 메일 보내기
	 * @param map
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public void deleteCalendarEventCanceled(Map<String, Object> map, List<Map<String, Object>> inviteTabList)throws Exception {
		
		for(int i=0; i<inviteTabList.size(); i++)
		{
			/*
			System.out.println("==================================================================");
			System.out.println("초대받은 사람 이름 : " + inviteTabList.get(i).get("HAN_NAME"));
			System.out.println("초대받은사람 사번 : " + inviteTabList.get(i).get("MEMBER_ID_NUM"));
			System.out.println("이메일!!! : : : " + inviteTabList.get(i).get("EMAIL"));
			System.out.println("INVITE_YN :  " + inviteTabList.get(i).get("INVITE_YN"));
			System.out.println("일정제목 : " + inviteTabList.get(i).get("EVENT_SUBJECT"));
			System.out.println("일정시작시간 : " + inviteTabList.get(i).get("START_DATETIME"));
			System.out.println("일정종료시간 : " + inviteTabList.get(i).get("END_DATETIME"));
			System.out.println("==================================================================");
			*/
			
			map.put("EMAIL", inviteTabList.get(i).get("EMAIL"));						//초대 받는자 Email
			map.put("SEND_USER_EMAIL", inviteTabList.get(i).get("SEND_USER_EMAIL"));	//초대 하는 사람 Email
			map.put("SEND_USER_NAME", inviteTabList.get(i).get("SEND_USER_NAME"));		//초대 하는 사람 이름
			map.put("START_DATETIME", inviteTabList.get(i).get("START_DATETIME"));		//일정 시작
			map.put("END_DATETIME", inviteTabList.get(i).get("END_DATETIME"));			//일정 종료
			map.put("selectModalEventCode", inviteTabList.get(i).get("EVENT_CODE"));	//이벤트 코드
			
			
			String invitedID = inviteTabList.get(i).get("INVITE_ID").toString();
			
			if(null != inviteTabList.get(i).get("INVITE_YN") && "Y".equals(inviteTabList.get(i).get("INVITE_YN")))
			{//수락
				
				
				map.put("INVITE_ID", invitedID);
				map.put("EVENT_SUBJECT", "[canceled]"+map.get("textModalEventSubject"));
				
				//일정 초대 받은 사람이 일정 수락을 클릭하였는데, 취소가 되었으니, 
				//수락한 일정에 대한 제목을 [canceled]를 붙여주는 update
				calendarDAO.updateCaceledEventSubject(map);
				
				//취소메일 전송
				map.put("EVENT_SUBJECT", "'"+map.get("textModalEventSubject")+"'");
				commonMailService.calendarEventCanceledMailSend(map);
				
				
				
				//취소 알림
				map.put("memberID", inviteTabList.get(i).get("MEMBER_ID_NUM"));								//초대 받는 사람 사번
				map.put("noticeDetail", "일정 '"+map.get("textModalEventSubject")+"' 취소 되었습니다.");
				String shareURL = "/calendar/calendarOfColleagueView.do?&shareMemberId="+inviteTabList.get(i).get("INVITED_CANCELED_EVENT_ID");
				map.put("shareURL", shareURL);
				map.put("canceledEventID", inviteTabList.get(i).get("INVITED_CANCELED_EVENT_ID"));
				map.put("noticeCategory", "일정알림");
				map.put("noticeCode", map.get("selectModalEventCode"));
				calendarDAO.insertNoticeCancelEvent(map);
				
			}
			else
			{//미응답 or 거절
				//일정 초대 메일을 보냈으나 아직 수락/거절 여부를 선택하지 않았을 경우
				//메일로 취소 메일 보내준다.
				
				log.debug("미응답");
				//취소메일 전송
				map.put("EVENT_SUBJECT", "'"+map.get("textModalEventSubject")+"'");
				commonMailService.calendarEventCanceledMailSend(map);
			}
		}
	}

	
	
	/**
	 * 반복일정 반복룰 해독 후 일정List
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> calendarRRuleEventList(List<Map<String, Object>> list, Map<String, Object> map) throws Exception {
		int size = list.size();
		
		for(int i=0; i<size; i++)
		{			
			Map<String, Object> eventMap = list.get(i);
			
			// 반복일정 리스트에 담지 않는 경우
			// 1. 반복일정이 아닌 경우
			// 2. 단일일정(반복일정 중 하나만 수정한 일정)일 경우
			//    (반복일정에 해당되지만 rrule 을 가지지 않은 일정. EX_EVENT_YN 이 'Y')
            if(!eventMap.get("REPEAT_YN").equals("Y") || 
            		(String.valueOf(eventMap.get("EX_EVENT_YN")).equals("Y")
            				&& eventMap.get("RRULE_SYNC_ID") != null && !String.valueOf(eventMap.get("RRULE_SYNC_ID")).isEmpty())) {
				continue;
			}
			
			Recur recur = null; 
			String rruleStart = eventMap.get("start").toString();
			String rruleEnd = eventMap.get("end").toString();
			String rruleStartDate = "";
			String rruleEndDate = "";
			String rruleStartTime = "";
			String rruleEndTime = "";
			
			// 1. 종일 여부 체크
			if(eventMap.get("allDay") == null || eventMap.get("allDay").toString().equals("0"))
			{
				rruleStartTime = rruleStart.substring(rruleStart.indexOf(" "));
				rruleEndTime = rruleEnd.substring(rruleEnd.indexOf(" "));
			}
			
			// 2. 시작날짜 설정
			Calendar cal = Calendar.getInstance();
			cal.clear(Calendar.SECOND);
			
			SimpleDateFormat formatter_one = new SimpleDateFormat("yyyy-MM-dd");
			Date startDate = formatter_one.parse(rruleStart);
			Date endDate = formatter_one.parse(rruleEnd);
			Date untilDate = new Date();
			
			cal.setTime(startDate);
			Date until = cal.getTime();
			
			cal.add(Calendar.DATE, 1);
			Date start = cal.getTime();
			
			int difDays = (int) (endDate.getTime() - startDate.getTime()) / (24 * 60 * 60 * 1000);
			
			// 3. 종료일 
			if(eventMap.get("END_RULE") != null)
			{
				switch (eventMap.get("END_RULE").toString()) { 
					case "loop": // 계속반복 == 4년반복
						cal.add(Calendar.YEAR, 4);
						until = cal.getTime();
						break;
						
					case "until": // 종료일 == **년 **월 **일 까지 반복
						untilDate = formatter_one.parse(eventMap.get("RECURRENCE_END_DATE").toString());
						cal.setTime(untilDate);
						until = cal.getTime();
						break;
					
					case "count": // 횟수반복 == **번 반복 (99년 반복으로 설정해두고 화면에서 횟수만큼만 출력)
						cal.add(Calendar.YEAR, 99); 
						until = cal.getTime();
						break;
						
					default:
						break;
				}
			}
			
			// 4. 반복 Rule 체크
			if(eventMap.get("RECURRENCE_RULE") != null) {
				
				recur = new Recur(eventMap.get("RECURRENCE_RULE").toString());
				
				//종료일의 시간이 00시 까지이므로 해당 종료일의 일정이 제외가 된다. 때문에 그 다음날 00시까지로 계산한다.
				cal.setTime(until);
				cal.add(Calendar.DATE, 2);
				until = cal.getTime();
				
				net.fortuna.ical4j.model.Date recurStart = new net.fortuna.ical4j.model.Date(start);
				net.fortuna.ical4j.model.Date recurUntil = new net.fortuna.ical4j.model.Date(until);
												
				DateList recurrences = recur.getDates(recurStart, recurUntil, net.fortuna.ical4j.model.parameter.Value.DATE);
				
				int recurSize = recurrences.size();
				for (int j=0; j<recurSize; j++) 
				{
					Map<String, Object> rruleMap = new HashMap<String, Object>();
					
				    Date recurrence = (Date) recurrences.get(j);
				    rruleStartDate = formatter_one.format(recurrence);
				    				    			    
				    // 5. 반복 제외일정 인지 아닌지 확인
				    int tmp = 0; // 0 : 반복일정, 1 : 반복 제외일정
				    
				    if(eventMap.get("EX_DATE") != null && !eventMap.get("EX_DATE").equals(""))
				    {
				    	String[] ex_date = eventMap.get("EX_DATE").toString().split(",");
				    	
				    	for(String exDate : ex_date)
				    	{
				    		if(rruleStartDate.equals(exDate)){
				    			tmp = 1;
				    			break;
				    		}
				    	}
				    }
				    
				    // 6. 일정 검색일 경우
				    if(map != null){
				    	int CompareResult = 0;
					    if(map.get("textSearchStartDate") != null && !map.get("textSearchStartDate").equals(""))
					    {
					    	if(map.get("textSearchEndDate") != null && !map.get("textSearchEndDate").equals("")) // 검색조건 시작일, 종료일 둘다 체크
					    	{ 
					    		CompareResult = compareDate(rruleStartDate, map.get("textSearchStartDate").toString(), map.get("textSearchEndDate").toString()); //날짜 비교
					    	}
					    	else //검색조건 시작일만 체크
					    	{ 
					    		CompareResult = compareDate(rruleStartDate, map.get("textSearchStartDate").toString(), null); //날짜 비교
					    	}
					    }
					    else if(map.get("textSearchEndDate") != null && !map.get("textSearchEndDate").equals("")) // 검색조건 종료일만으로 체크
					    { 
					    	CompareResult = compareDate(rruleStartDate, null, map.get("textSearchEndDate").toString()); //날짜 비교
					    }
					    
					    if(CompareResult < 0){
			    			tmp = 1;
			    		}
				    }
				    
				    // 반복 제외 일정일 경우 아래 로직을 실행하지 않는다.
				    if(tmp == 1){
				    	continue;
				    }
				    
				    cal.setTime(recurrence);
				    cal.add(Calendar.DATE, difDays);
				    rruleEndDate = formatter_one.format(cal.getTime());
				    
				    // 7. 반복일정 중 첫번째 일정인지 체크
				    if(j!=0){
				    	rruleMap.put("REPEAT_FIRST", 'N');
				    }else{
				    	rruleMap.put("REPEAT_FIRST", 'Y');
				    }
				    
				    rruleMap.put("FIRST_EVENT_START_DATE", rruleStart.substring(0, rruleStart.indexOf(" ")));
				    
				    // 8. 종일 일정이면 시간X
				    String all_day = "0";
				    if(eventMap.get("allDay") == null || eventMap.get("allDay").toString().equals("0")){
				    	rruleMap.put("start", rruleStartDate + rruleStartTime);
					    rruleMap.put("end", rruleEndDate + rruleEndTime);
				    }else{
				    	all_day = eventMap.get("allDay").toString();
				    	rruleMap.put("start", rruleStartDate);
					    rruleMap.put("end", rruleEndDate);
				    }
				    
				    // 9. event 기본 정보
				    if(eventMap.get("EVENT_ID") != null && !eventMap.get("EVENT_ID").equals("")){
				    	rruleMap.put("EVENT_ID", eventMap.get("EVENT_ID").toString());
				    }
				    if(eventMap.get("CALENDAR_ID") != null && !eventMap.get("CALENDAR_ID").equals("")){
				    	rruleMap.put("CALENDAR_ID", eventMap.get("CALENDAR_ID").toString());
				    }
				    if(eventMap.get("EVENT_CODE") != null && !eventMap.get("EVENT_CODE").equals("")){
				    	rruleMap.put("EVENT_CODE", eventMap.get("EVENT_CODE").toString());
				    }
				    
				    rruleMap.put("title", eventMap.get("title").toString());
				    rruleMap.put("EVENT_DETAIL", eventMap.get("EVENT_DETAIL").toString());
				    rruleMap.put("allDay", all_day);
				    
				    if(eventMap.get("TIME_GAP") != null && !eventMap.get("TIME_GAP").equals("")){
				    	rruleMap.put("TIME_GAP", eventMap.get("TIME_GAP").toString());
				    }
				    if(eventMap.get("BEFORE_MOVE_TIME") != null && !eventMap.get("BEFORE_MOVE_TIME").equals("")){
				    	rruleMap.put("BEFORE_MOVE_TIME", eventMap.get("BEFORE_MOVE_TIME").toString());
				    }
				    if(eventMap.get("AFTER_MOVE_TIME") != null && !eventMap.get("AFTER_MOVE_TIME").equals("")){
				    	rruleMap.put("AFTER_MOVE_TIME", eventMap.get("AFTER_MOVE_TIME").toString());
				    }
				    if(eventMap.get("textColor") != null && !eventMap.get("textColor").equals("")){
				    	rruleMap.put("textColor", eventMap.get("textColor").toString());
				    }
				    if(eventMap.get("backgroundColor") != null && !eventMap.get("backgroundColor").equals("")){
				    	rruleMap.put("backgroundColor", eventMap.get("backgroundColor").toString());
				    }
				    
				    rruleMap.put("REPEAT_YN", eventMap.get("REPEAT_YN").toString());
				    
				    if(eventMap.get("RECURRENCE_RULE") != null && !eventMap.get("RECURRENCE_RULE").equals("")){
				    	rruleMap.put("RECURRENCE_RULE", eventMap.get("RECURRENCE_RULE").toString());
				    }
				    if(eventMap.get("RECURRENCE_END_DATE") != null && !eventMap.get("RECURRENCE_END_DATE").equals("")){
				    	rruleMap.put("RECURRENCE_END_DATE", eventMap.get("RECURRENCE_END_DATE").toString());
				    }
				    if(eventMap.get("RECURRENCE_ID") != null && !eventMap.get("RECURRENCE_ID").equals("")){
				    	rruleMap.put("RECURRENCE_ID", eventMap.get("RECURRENCE_ID").toString());
				    }
				    if(eventMap.get("RECURRENCE_FREQ") != null && !eventMap.get("RECURRENCE_FREQ").equals("")){
				    	rruleMap.put("RECURRENCE_FREQ", eventMap.get("RECURRENCE_FREQ").toString());
				    }
				    if(eventMap.get("RECURRENCE_INTERVAL") != null && !eventMap.get("RECURRENCE_INTERVAL").equals("")){
				    	rruleMap.put("RECURRENCE_INTERVAL", eventMap.get("RECURRENCE_INTERVAL").toString());
				    }
				    
				    rruleMap.put("RECURRENCE_DateOrder", j);
				    				    
				    if(eventMap.get("RECURRENCE_COUNT") != null && !eventMap.get("RECURRENCE_COUNT").equals("")){
				    	rruleMap.put("RECURRENCE_COUNT", eventMap.get("RECURRENCE_COUNT").toString());
				    }
				    if(eventMap.get("RECURRENCE_BYWEEKDAY") != null && !eventMap.get("RECURRENCE_BYWEEKDAY").equals("")){
				    	rruleMap.put("RECURRENCE_BYWEEKDAY", eventMap.get("RECURRENCE_BYWEEKDAY").toString());
				    }
				    if(eventMap.get("RECURRENCE_BYMONTHDAY") != null && !eventMap.get("RECURRENCE_BYMONTHDAY").equals("")){
				    	rruleMap.put("RECURRENCE_BYMONTHDAY", eventMap.get("RECURRENCE_BYMONTHDAY").toString());
				    }
				    if(eventMap.get("LOCATION") != null && !eventMap.get("LOCATION").equals("")){
				    	rruleMap.put("LOCATION", eventMap.get("LOCATION").toString());
				    }
				    if(eventMap.get("SHARE_YN") != null && !eventMap.get("SHARE_YN").equals("")){
				    	rruleMap.put("SHARE_YN", eventMap.get("SHARE_YN").toString());
				    }
				    if(eventMap.get("ALARM_FLAG") != null && !eventMap.get("ALARM_FLAG").equals("")){
				    	rruleMap.put("ALARM_FLAG", eventMap.get("ALARM_FLAG").toString());
				    }
				    if(eventMap.get("ALARM_TARGET") != null && !eventMap.get("ALARM_TARGET").equals("")){
				    	rruleMap.put("ALARM_TARGET", eventMap.get("ALARM_TARGET").toString());
				    }
				    if(eventMap.get("EX_DATE_YN") != null && !eventMap.get("EX_DATE_YN").equals("")){
				    	rruleMap.put("EX_DATE_YN", eventMap.get("EX_DATE_YN").toString());
				    }
				    
				    if(eventMap.get("PAST_YN") != null && !eventMap.get("PAST_YN").equals("")){
				    	rruleMap.put("PAST_YN", eventMap.get("PAST_YN").toString());
				    }
				    if(eventMap.get("START_TIME") != null && !eventMap.get("START_TIME").equals("")){
				    	rruleMap.put("START_TIME", eventMap.get("START_TIME").toString());
				    }
				    if(eventMap.get("END_TIME") != null && !eventMap.get("END_TIME").equals("")){
				    	rruleMap.put("END_TIME", eventMap.get("END_TIME").toString());
				    }				    
				    if(eventMap.get("OUTLOOK_ID") != null && !eventMap.get("OUTLOOK_ID").equals("")){
				    	rruleMap.put("OUTLOOK_ID", eventMap.get("OUTLOOK_ID").toString());
				    }
				    if(eventMap.get("GOOGLE_ID") != null && !eventMap.get("GOOGLE_ID").equals("")){
				    	rruleMap.put("GOOGLE_ID", eventMap.get("GOOGLE_ID").toString());
				    }
				    if(eventMap.get("SYNC_FLAG") != null && !eventMap.get("SYNC_FLAG").equals("")){
				    	rruleMap.put("SYNC_FLAG", eventMap.get("SYNC_FLAG").toString());
				    }
				    if(eventMap.get("RRULE_SYNC_ID") != null && !eventMap.get("RRULE_SYNC_ID").equals("")){
				    	rruleMap.put("RRULE_SYNC_ID", eventMap.get("RRULE_SYNC_ID").toString());
				    }
				    if(eventMap.get("EX_EVENT_YN") != null && !eventMap.get("EX_EVENT_YN").equals("")){
				    	rruleMap.put("EX_EVENT_YN", eventMap.get("EX_EVENT_YN").toString());
				    }
				    
				    //반복일정 날짜 변환(모바일에서 해당 날짜 적용하기 위함)
				    if(rruleMap.get("start") != null && !rruleMap.get("start").equals("")){
				    	Date convert_start_day = new SimpleDateFormat("yyyy-MM-dd").parse(rruleMap.get("start").toString());
				        String start_day = new SimpleDateFormat("yyyyMMdd").format(convert_start_day );
				    	rruleMap.put("START_DAY", start_day);
				    }
				    if(rruleMap.get("end") != null && !rruleMap.get("end").equals("")){
				    	Date convert_end_day = new SimpleDateFormat("yyyy-MM-dd").parse(rruleMap.get("end").toString().substring(0, 10));
				    	String end_day = new SimpleDateFormat("yyyyMMdd").format(convert_end_day );
				    	rruleMap.put("END_DAY", end_day);
				    }
				    
				    list.add(rruleMap);
				}
				list.remove(i);
				i = i-1;
				size = size-1;				
			}
		}
		
		//날짜 기준 정렬(모바일 페이지 일정 목록에 정렬하기 위함)
		Collections.sort(list, new Comparator<Map<String, Object >>() {
			@Override
			public int compare(Map<String, Object> first, Map<String, Object> second) {
//				return first.get("START_DAY").toString().compareTo(second.get("START_DAY").toString()); //ascending order
				return second.get("START_DAY").toString().compareTo(first.get("START_DAY").toString()); //descending order
			}
		});

		return list;
	}

	/**
	 * 일정 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> calendarEventList(Map<String, Object> map) throws Exception {
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		// 1. 공유 캘린더 이벤트 가져오기.
		List<Map<String, Object>> sharedEventlist =null;
		if(map.get("hiddenMemberIdNum") != null)
		{
			map.put("calendarCheck_id", map.get("CALENDAR_ID"));

			// map.get("hiddenMemberIdNum") -> 공유된 캘린더 동료 ID
			map.put("hiddenModalCreatorId", map.get("hiddenMemberIdNum"));
			
			sharedEventlist = calendarDAO.calendarEventList(map);
			
			for(int k=0; k < sharedEventlist.size(); k++)
			{
				if(sharedEventlist.get(k).get("SHARE_YN").equals("N"))
				{
					sharedEventlist.get(k).put("title", "비공개");
					sharedEventlist.get(k).put("EVENT_SUBJECT", "비공개");
					sharedEventlist.get(k).put("EVENT_DETAIL", "비공개");
					sharedEventlist.get(k).put("LOCATION", "비공개");
					sharedEventlist.get(k).put("EVENT_CODE", "00");
				}
			}
			
			list.addAll(sharedEventlist);
			
			//반복일정 이벤트 룰 해독
			//list = calendarRRuleEventList(list, map);
		}
		else
		{
			if(map.get("order_by") != null) {
				//캘린더 이벤트 가져오기(모바일 일정목록)
				list = calendarDAO.calendarEventListMobile2(map);
			}
			else {
				//캘린더 이벤트 가져오기
				list = calendarDAO.calendarEventList(map);
			}
			
			//반복일정 이벤트 룰 해독 
			//list = calendarRRuleEventList(list, map);
		}
		
		// 2. 반복일정 체크 (반복일정 이벤트 룰 해독)
		list = this.calendarRRuleEventList(list, map);
		
		// 3. 미팅 전 이동시간, 후 이동시간 구하기.
		for(int i=0; i<list.size(); i++)
		{
			//이벤트코드가 고객 대면일 때, 이동시간 데이터를 체크
			if(list.get(i).get("EVENT_CODE").equals("1"))
			{
				list = getBeforeAfterTime(list);
			}
		}

		return list;
	}


	//
	public List<Map<String, Object>> getBeforeAfterTime(List<Map<String, Object>> list)throws Exception{

		//이동시간
		Map<String, Object> beForeAfterTimeMap;

		for(int i =0; i<list.size(); i++){

			//미팅전 이동시간
			if(list.get(i).get("BEFORE_MOVE_TIME") != null && !list.get(i).get("BEFORE_MOVE_TIME").toString().equals("0")){
				beForeAfterTimeMap = new HashMap<String, Object>();

				//미팅 시작시간.
//				Date start = new Date();
//				start = (Date) list.get(i).get("start");
				
				String start = list.get(i).get("start").toString();

				SimpleDateFormat ori_transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				Date new_start = ori_transFormat.parse(start);
				
				SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//				String to = transFormat.format(start);
				String to = transFormat.format(new_start);

				//미팅전 이동시간
//				int beFore = (int) list.get(i).get("BEFORE_MOVE_TIME");
				int beFore = Integer.parseInt(list.get(i).get("BEFORE_MOVE_TIME").toString());


				//미팅 시작시간 - 미징전 이동시간
				String beForeMovetime = CommonDateUtils.getDateBeforeTimeMinute(to, beFore);

				Date bStart = new Date();
				Date bEnd = new Date();

				SimpleDateFormat Format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				bStart = Format.parse(beForeMovetime);	// 미팅 시작전 이동 시작 시간
				bEnd = Format.parse(to);				// 미팅 시작 시간

				beForeAfterTimeMap.put("start", bStart);
				beForeAfterTimeMap.put("end", bEnd);
				beForeAfterTimeMap.put("textColor", "black");
				beForeAfterTimeMap.put("backgroundColor", "white");
				beForeAfterTimeMap.put("EVENT_CODE", "5");
				beForeAfterTimeMap.put("title", "이동시간");

				list.add(beForeAfterTimeMap);
			}

			//미팅후 이동시간
			if(list.get(i).get("AFTER_MOVE_TIME") != null && !list.get(i).get("AFTER_MOVE_TIME").toString().equals("0")){
				beForeAfterTimeMap = new HashMap<String, Object>();

				//미팅 종료시간.
//				Date end = new Date();
//				end = (Date) list.get(i).get("end");
				
				String end = list.get(i).get("end").toString();

				SimpleDateFormat ori_transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				Date new_end = ori_transFormat.parse(end);
				
				SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//				String to = transFormat.format(end);
				String to = transFormat.format(new_end);

				//미팅후 이동시간
//				int after = (int) list.get(i).get("AFTER_MOVE_TIME");
				int after = Integer.parseInt(list.get(i).get("AFTER_MOVE_TIME").toString());


				//미팅 시작후 + 미팅후 이동시간
				String afterMovetime = CommonDateUtils.getDateAfterTimeMinute(to, after);

				Date bStart = new Date();
				Date bEnd = new Date();

				SimpleDateFormat Format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				bStart = Format.parse(to);						// 미팅 종료 시간
				bEnd = Format.parse(afterMovetime);				// 미팅 종료후 이동시간

				beForeAfterTimeMap.put("start", bStart);
				beForeAfterTimeMap.put("end", bEnd);
				beForeAfterTimeMap.put("textColor", "black");
				beForeAfterTimeMap.put("backgroundColor", "white");
				beForeAfterTimeMap.put("EVENT_CODE", "5");
				beForeAfterTimeMap.put("title", "이동시간");

				list.add(beForeAfterTimeMap);
			}
		}

		return list; 
	}


	public List<Map<String, Object>> holidayEventList(Map<String, Object> map) throws Exception {
		return calendarDAO.holidayEventList(map);
	}


	public List<Map<String, Object>> googleIcsEventList(Map<String, Object> map) throws Exception {
		CommonFileUtils cu = new CommonFileUtils();
		List<Map<String, Object>> list = null;
		map.put("MEMBER_ID_NUM", map.get("hiddenModalCreatorId"));
		List<Map<String,Object>> calList = calendarDAO.getCalendarList(map);

		for(int i=0; i<calList.size(); i++)
		{
			if(calList.get(i).get("CALENDAR_TYPE").equals("3"))
			{
				list = cu.getGoogleIcsEventList(map, calUserInfoPath);
			}
		}
		list = calendarRRuleEventList(list, map);
		
		return list;
	}
	
	
	public void sellersIcsEventList(Map<String, Object> map) throws Exception {

		List<Map<String, Object>> list = calendarDAO.sellersCalendarEvent(map);
		CommonFileUtils cfu = new CommonFileUtils();

		cfu.outIcsEventList(list, map);

		log.debug("ICS file generates complete ");
	}


	/**
	 * outlook 일정 가져오기
	 */
	public List<Map<String, Object>> outlookCalendar(Map<String, Object> map) throws Exception {

		log.debug("outlookCalendar Call. ");
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		CommonFileUtils cu = new CommonFileUtils();
		ExCalendarConnect cc = new ExCalendarConnect();

		map.put("MEMBER_ID_NUM", map.get("hiddenModalCreatorId"));
		
		List<Map<String,Object>> calList = calendarDAO.getCalendarList(map);
		for(int i=0; i<calList.size(); i++)
		{
			if(calList.get(i).get("CALENDAR_NAME").equals("아웃룩 캘린더"))
			{

				list = new ArrayList<Map<String, Object>>();

				String calType = "outlook"; //캘린더 분기

				String outlookId 	= "";
				String outlookPw 	= "";
				String creatorId 	= "";
				String serverNm		= "";
				String loginUserId 	= (String) map.get("hiddenModalCreatorId");

				//암호화된 파일을 읽어 온다. ( 복호화 )
				list = cu.readOutlookInfoFile(map, list, calType, calUserInfoPath);

				for(int j=0; j<list.size(); j++)
				{
					outlookId 	= (String) list.get(j).get("outlookId");
					outlookPw 	= (String) list.get(j).get("outlookPw");
					creatorId 	= (String) list.get(j).get("creatorId");
					serverNm	= (String) list.get(j).get("serverNm");
				}
				if(outlookId !=null && outlookPw !=null)
				{
					if(creatorId.equals(loginUserId))
					{
						List<Map<String, Object>> syncEventMap = calendarDAO.selectSellersOutlookCalSyncEvent(map);

						//아웃룩 Exchange 접속후 일정 가져오기.
						list = cc.outlookCalendarConnect(outlookId, outlookPw, syncEventMap, serverNm, CALENDAR_SYNC_URL, map);
					}
				}

				break;
			}else{
				map.put("errStatus", "2");
				list.add(map);
			}
		}
		return list;
	}

	/**
	 * office365 캘린더 일정 가져오기
	 */

	public List<Map<String, Object>> office365Calendar(Map<String, Object> map) throws Exception {

		log.debug("office365Calendar Call. ");
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		CommonFileUtils cu = new CommonFileUtils();
		ExCalendarConnect cc = new ExCalendarConnect();

		//		map.put("MEMBER_ID_NUM", map.get("hiddenModalCreatorId"));
		
		if(null == map.get("hiddenUserId"))
		{//동료 캘린더보기에서 넘어올때는 hiddenUserId가 null이고 동료ID가 hiddenModalCreatorId에 담겨있다.
			map.put("hiddenUserId", map.get("hiddenModalCreatorId"));
		}
		
		map.put("MEMBER_ID_NUM", map.get("hiddenUserId"));
		
		List<Map<String,Object>> calList = calendarDAO.getCalendarList(map);
		for(int i=0; i<calList.size(); i++)
		{
			if(calList.get(i).get("CALENDAR_TYPE").equals("2"))
			{
				list = new ArrayList<Map<String, Object>>();

				String calType = "office365";

				String outlookId 	= "";
				String outlookPw 	= "";
				String creatorId 	= "";
				String serverNm		= "";
				//				String loginUserId 	= (String) map.get("hiddenModalCreatorId");
				String loginUserId 	= (String) map.get("hiddenUserId");
				map.put("hiddenModalCreatorId", map.get("hiddenUserId"));

				//암호화된 파일을 읽어 온다. ( 복호화 )
				list = cu.readOutlookInfoFile(map, list, calType, calUserInfoPath);
				String loginfilePath = (String) list.get(0).get("userLoginInfoFilePath");

				for(int j=0; j<list.size(); j++)
				{
					outlookId = (String) list.get(j).get("outlookId");
					outlookPw = (String) list.get(j).get("outlookPw");
					creatorId = (String) list.get(j).get("creatorId");
					serverNm	= (String) list.get(j).get("serverNm");
				}
				if(outlookId !=null && outlookPw !=null)
				{
					if(creatorId.equals(loginUserId))
					{
						List<Map<String, Object>> syncEventMap = calendarDAO.selectSellersOutlookCalSyncEvent(map);

						//아웃룩 Exchange 접속후 일정 가져오기.
						list = cc.outlookCalendarConnect(outlookId, outlookPw, syncEventMap, serverNm, CALENDAR_SYNC_URL, map);

						//실패시 기존 Office 365 DB 정보 삭제
						if(list.get(0).get("errStatus") != null && list.get(0).get("errStatus").equals("0"))
						{
							Map<String,Object> delCalIdMap = new HashMap<>();
							delCalIdMap.put("calendarId", calList.get(i).get("CALENDAR_ID"));

							//잘못된 로그인 정보 파일 삭제
							cu.deleteIncorrectUserLoginInfo(loginfilePath);

							//실패시 기존 Office 365 DB 정보 삭제
							calendarDAO.deleteCalendar(delCalIdMap);
						}
					}
				}

				break;
			}else{
				//동료캘린더 보기에서 동료 Office365 캘린더가 존재하지 않을때 그냥 pass
				map.put("errStatus", "3");
				list.add(map);
			}
		}
		return list;
	}

	//calendarOfColleagueView
	public List<Map<String, Object>> shareCalendarList(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> list = null;

		list = calendarDAO.shareCalendarList(map);
		return list;
	}


	//아웃룩 아이디, 패스워드 저장

	public void outlookCalendarUsrInfoSave(Map<String, Object> map) throws Exception {

		log.debug("outlookCalendarUsrInfoSave Call. ");
		
		CommonFileUtils cu = new CommonFileUtils();

		//사내 캘린더 DB upsert
		int cnt = calendarDAO.updateCalendar(map);
		if(cnt<1){
			map.put("hiddenModalCreatorId", map.get("creatorId"));
			calendarDAO.addCalendar(map);
		}

		String outlookLoginId 	= (String) map.get("outlookId");
		String outlookLoginPw 	= (String) map.get("outlookPassword");
		String creatorId 		= (String) map.get("creatorId");
		String flag				= (String) map.get("flag");


		//아웃룩 ID, PASSWORD 를 파일 암호화하여 저장.
		cu.outlookInfoSave(creatorId, outlookLoginId, outlookLoginPw, flag, calUserInfoPath);

	}

	//일정초대자 리스트

	public List<Map<String, Object>> getInviteMemberList(HttpServletRequest request,Map<String, Object> map) throws Exception {

		/*map.put("hiddenModalEventId", map.get("eventId"));*/

		return calendarDAO.getInviteMemberList(map);
	}


	//알림창에 수락여부 insert
	public void insertNoticeInvitedYN(Map<String, Object> map) throws Exception {

		log.debug("insertNoticeInvitedYN Call. ");
		
		//일정을 초대한 사람에게 수락여부 알리기위해 초대한사람 ID를 가져온다.
		//List<Map<String, Object>> selectUser = calendarDAO.selectMainUserMemberId(map);
		/*
			map.put("mainUserId", selectUser.get(j).get("MEMBER_ID_NUM"));
			map.put("eventSubJect", selectUser.get(j).get("EVENT_SUBJECT"));
			map.put("eventStartDateTime", selectUser.get(j).get("START_DATETIME"));
			map.put("invitedUserName", selectUser.get(j).get("HAN_NAME"));
		 */
		List<Map<String, Object>> invitedMemberList = calendarDAO.getInviteMemberList(map);

		for(int i=0; i<invitedMemberList.size(); i++){
			map.put("mainUserId", invitedMemberList.get(i).get("MEMBER_ID_NUM"));
			map.put("eventSubJect", invitedMemberList.get(i).get("EVENT_SUBJECT"));
			map.put("eventStartDateTime", invitedMemberList.get(i).get("START_DATETIME"));
			map.put("invitedUserName", invitedMemberList.get(i).get("HAN_NAME"));

			if(invitedMemberList.get(i).get("INVITE_YN") != null)
			{

				if(invitedMemberList.get(i).get("INVITE_YN").equals("수락"))
				{
					map.put("memberID", map.get("mainUserId"));
					map.put("noticeDetail", map.get("invitedUserName")+"님이 일정 "+"\'"+ map.get("eventStartDateTime")+ " "+map.get("eventSubJect") +"\' 에 수락하였습니다.");
					map.put("noticeCategory", "일정초대수락여부");
					map.put("shareURL", "");
					calendarDAO.insertShareCalendarNotice(map);
				}
				else if(invitedMemberList.get(i).get("INVITE_YN").equals("거절"))
				{
					map.put("memberID", map.get("mainUserId"));
					map.put("noticeCategory", "일정초대수락여부");
					map.put("shareURL", "");
					map.put("noticeDetail", map.get("invitedUserName")+"님이 일정 "+"\'"+ map.get("eventStartDateTime")+ " "+map.get("eventSubJect") +"\' 에 거절하였습니다.");
					calendarDAO.insertShareCalendarNotice(map);
				}
			}
		}

		//calendarDAO.insertNoticeInvitedYN(map);
	}

	//외부캘린더 공유

	public void changeOutCalendarSync(Map<String, Object> map) throws Exception {
		calendarDAO.changeOutCalendarSync(map);
	}

	//캘린더 공유
	public int insertShareCalendar(Map<String, Object> map) throws Exception {
		log.debug("insertShareCalendar Call. ");
		
		int cnt=0;
		String memberList = (String) map.get("MemberList");
		String[] arrayList;
		String[] shareMemberIdArray;


		// map.get("MemberList") 값이 '0456/yysim@unipoint.co.kr/오은혜' 넘어온다.
		// common 에서 직원 및 미팅 초대자등 검색해오는 function을 같이 사용하기 때문.
		// 그래서 split 로 필요한 0456 값만 가져다가 쓴다.
		if(memberList != null && !memberList.equals(""))
		{
			arrayList = memberList.split(",");

			for(int i=0; i<arrayList.length; i++)
			{
				int up=0;
				memberList = arrayList[i];
				shareMemberIdArray = memberList.split("/");

				for(int j=0; j<shareMemberIdArray.length; j++)
				{
					map.put("memberID",shareMemberIdArray[0]);
				}

				//upsert
				up = calendarDAO.updateShareCalendar(map);
				if(up < 1){
					//캘린더 공유 TABLE 에 insert
					cnt = calendarDAO.insertShareCalendar(map);

					//초대하는 자 이름을 가져온다.
					map.put("MEMBER_ID_NUM", map.get("creatorId"));
					List<Map<String,Object>> list = calendarDAO.getCalendarList(map);
					String HAN_NAME = (String) list.get(0).get("HAN_NAME");

					//캘린더 공유받은 사람에게 알림 메시지로 알려준다.
					map.put("noticeDetail", HAN_NAME+"님이 캘린더를 공유하였습니다.");
					map.put("noticeCategory", "캘린더공유");

					String shareMemberId = (String) map.get("creatorId");
					String shareURL = "/calendar/calendarOfColleagueView.do?&shareMemberId="+shareMemberId;
					map.put("shareURL", shareURL);
					calendarDAO.insertShareCalendarNotice(map);
				}
			}
			/*
			for(int i=0; i<array.length; i++)
			{
				int up=0;
				memberList = array[i];
				map.put("memberID", memberList);

				//upsert
				up = calendarDAO.updateShareCalendar(map);
				if(up<=0){
					cnt = calendarDAO.insertShareCalendar(map);
				}
			}
			 */
		}

		return cnt;
	}


	public List<Map<String, Object>> selectShareCalendar(Map<String, Object> map) throws Exception {
		//		List<Map<String,Object>> list = calendarDAO.getCalendarList(map);

		return calendarDAO.selectShareCalendar(map);
	}


	public List<Map<String, Object>> shareCalViewList(Map<String, Object> map) throws Exception {
		List<Map<String,Object>> list = new ArrayList<>();

		//		ShareCalView scv = new ShareCalView();
		//		list = scv.init(map);

		return calendarDAO.selectShareCalendar(map);
	}


	/**
	 * 초대받은 자 캘린더가 존재하는지 파악
	 * 없으면 생성
	 * @param map
	 * @return
	 * @throws Exception
	 */

	public Map<String, Object> updateInvitedCalendarMaster(Map<String, Object> map) throws Exception {

		Map<String, Object> calInfoMap = new HashMap<>();

		//캘린더 upsert
		int cnt = calendarDAO.updateInvitedCalendarMaster(map);

		if(cnt < 1)
		{
			//캘린더 없을 경우, 캘린더 생성.
			cnt = calendarDAO.insertInvitedCalendarMaster(map);
		}

		//캘린더 아이디 가져오기
		calInfoMap = calendarDAO.selectInvitedCalendarMaster(map);

		return calInfoMap;
	}

	//Face Time

	public List<Map<String, Object>> gridIndividualFaceTime(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		List<Map<String, Object>> list = calendarDAO.gridIndividualFaceTime(map);

		int thisBasisTime = Integer.parseInt(list.get(0).get("THIS_BASIS_TIME").toString());

		int dayCount = thisBasisTime / 8;

		list.get(0).put("dayCount", dayCount+"일");

		return list;
		//		return salesManagementDAO.gridFaceTime(map);
	}


	//본부, 팀 정보 가져오기

	public Map<String, Object> selectDivisionNteamInfo(Map<String, Object> map) throws Exception {
		Map<String, Object> infoMap = calendarDAO.selectDivisionNteamInfo(map);
		return infoMap;
	}

	public Map<String, Object> myProductivity(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return calendarDAO.myProductivity(map);
	}

	public Map<String, Object> selectEventDetail(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return calendarDAO.selectEventDetail(map);
	}

	public List<Map<String, Object>> listRruleCheckDate(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return calendarDAO.listRruleCheckDate(map);
	}

	public Map<String, Object> selectCalendarEvent(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return calendarDAO.selectCalendarEvent(map);
	}
	
	
	/**
	 * @author 	: 준이
	 * @Date		: 2017. 05. 04.
	 * @explain	: 일정관리 -> 반복일정 추가 시 반복룰 설정.
	 */
	public int upsertCalendarEventRRule(Map<String, Object> map) throws Exception {
		//Recur recur = null; 
		int cnt = 0;
		rrule = "";
		//시작날짜 설정
		Calendar cal = Calendar.getInstance();
		cal.clear(Calendar.SECOND);
		
		// 일정 시작/종료 날짜
		SimpleDateFormat formatter_one = new SimpleDateFormat("yyyy-MM-dd");
		Date startDate = formatter_one.parse(map.get("textModalStartDate").toString());
		Date endDate = formatter_one.parse(map.get("textModalEndDate").toString());
		Date untilDate = new Date();
		
		cal.setTime(startDate);
		Date start = cal.getTime();
		Date until = cal.getTime();
		
		int difDays = (int) (endDate.getTime() - startDate.getTime()) / (24 * 60 * 60 * 1000);
		
		/*반복빈도 selectModalFreq
		  매주 : FREQ=WEEKLY
		  매월 : FREQ=MONTHLY
		  분기 : FREQ=MONTHLY;INTERVAL=3
		  반기 : FREQ=MONTHLY;INTERVAL=6*/
		switch (map.get("selectModalFreq").toString()) {
		case "2": //매주 and 반복간격  : if(반복빈도 ==매주or매월) 1~9(주,달)에 한번 - INTERVAL=1~9
			rrule += "FREQ=WEEKLY;INTERVAL=" + map.get("selectModalInterval").toString() + ";";
			
			/*반복일
			  매주 : 반복일 -요일(복수선택 가능) BYDAY=MO,TU,WE,TH,FR,SA,SU*/
			String ruleByWeekDay = map.get("hiddenModalRuleByweekday").toString();
			if(ruleByWeekDay.length() > 6){
				rrule += ruleByWeekDay + ";";
			}
			
			break;
			
			/*반복마감일
			  매월, 분기, 반기 : 반복마감일 - '17'일(BYMONTHDAY=17) or '2'번째 '화'요일(BYDAY=+2TU)*/
		case "1": //매월 and 반복간격  : if(반복빈도 ==매주or매월) 1~9(주,달)에 한번 - INTERVAL=1~9
			rrule += "FREQ=MONTHLY;INTERVAL=" + map.get("selectModalInterval").toString() + ";" + map.get("hiddenModalRuleBy").toString() + map.get("hiddenModalRuleBymonthday").toString() + ";";
			break;
			
		case "3": //분기
			rrule += "FREQ=MONTHLY;INTERVAL=3;" + map.get("hiddenModalRuleBy").toString() + map.get("hiddenModalRuleBymonthday").toString() + ";";
			break;
			
		case "4": //반기
			rrule += "FREQ=MONTHLY;INTERVAL=6;" + map.get("hiddenModalRuleBy").toString() + map.get("hiddenModalRuleBymonthday").toString() + ";";
			break;
			
		default:
			break;
		}
		
		/*반복 종료일
		  loop : 계속반복 (=4년반복)
		  count : 횟수반복 (=**번 반복)
		  until : 종료일 지정 (=**년 **월 **일까지 반복)*/
		switch (map.get("hiddenModalEndCondition").toString()) {
		case "loop": 
			map.put("END_RULE", "loop");
			cal.add(Calendar.YEAR, Integer.parseInt(map.get("hiddenModalLoopNum").toString()));
			until = cal.getTime();
			break;
			
		case "count": 
			map.put("END_RULE", "count");
			cal.add(Calendar.YEAR, 99); //end날짜 99년으로 잡아둠 그냥..
			until = cal.getTime();
			rrule += "COUNT=" + map.get("hiddenModalCountNum").toString() + ";";
			break;
			
		case "until":
			map.put("END_RULE", "until");
			untilDate = formatter_one.parse(map.get("hiddenModalEndRuleDate").toString());
			cal.setTime(untilDate);
			until = cal.getTime();
			rrule += "UNTIL=" + map.get("hiddenModalEndRuleDate").toString().replaceAll("-", "") + ";";
			break;
			
		default:
			break;
		}
		rrule = rrule.substring(0, rrule.length()-1); //마지막 ;제거
		
		//반복룰 저장.
		map.put("rrule", rrule);
		
		if(null != map.get("rruleChoiceFlag")  && map.get("rruleChoiceFlag").equals("flagAll"))
		{
			cnt = calendarDAO.updateRepeatEvent(map);
		}
		else if (null != map.get("rruleChoiceFlag") && map.get("rruleChoiceFlag").equals("flagAfter"))
		{
			cnt = calendarDAO.insertRepeatEvent(map);
		}
		else //null == map.get("rruleChoiceFlag")
		{
			cnt = calendarDAO.insertRepeatEvent(map);
		}
		
		//Date dUntil = recur.getUntil();
		
		return cnt;
	}
	
	/**
	 * @author 	: 준이
	 * @Date		: 2017. 05. 31.
	 * @explain	: 일정관리 -> 반복일정 선택일정/선택일정부터/모든일정 수정 선택.
	 */
	public int updateCalendarRRuleEvent(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = 1;
		
		try
		{
			if(map.get("rruleCase").toString().equals("1"))		//선택한 일정만 삭제(반복일정 제외).
			{ 
				if(map.get("hiddenModalEXDate_YN").toString().equals("Y"))
				{
					map.put("EX_DATE", ','+map.get("hiddenModalOrgStartDate").toString());
				}
				
				//제외 날자 세팅
				calendarDAO.updateCalEventRruleExDate(map);
				
				if(String.valueOf(map.get("delFlag")).equals("Y"))
				{
					// 수정하여 row가 따로 존재할 때(단일일정일 경우)는 row를 삭제해줘야 한다
					if(String.valueOf(map.get("hiddenModalExEventYn")).equals("Y")) {
						calendarDAO.deleteCalEventAndExEvent(map);
					}
				}
				else{
					//단일 Event upsert ( rruleSyncId 가 있고, rrule이 없으면 단일일정으로 판단 )
					int exists = calendarDAO.selectRruleCheck(map);
					if(map.get("hiddenModalRruleSyncId") != null && !String.valueOf(map.get("hiddenModalRruleSyncId")).isEmpty() && (exists == 0)) {
						calendarDAO.updateCalendarEvent(map);	
					}else {
						map.put("rruleSyncID", map.get("EVENT_ID"));
						insertCalendarEvent(map, request);
					}
				}
				
			}
			else if(map.get("rruleCase").toString().equals("2"))	//선택일정 부터 향후 일정까지 삭제(반복일정 수정).
			{ 
				String rruleEndDate = map.get("hiddenModalOrgStartDate").toString();
				SimpleDateFormat formatter_one = new SimpleDateFormat("yyyy-MM-dd");
				Date endDate = formatter_one.parse(rruleEndDate);
				Calendar cal = Calendar.getInstance();
				cal.clear(Calendar.SECOND);
				
				cal.setTime(endDate);
				cal.add(Calendar.DATE, -1);
				rruleEndDate = formatter_one.format(cal.getTime());
				
				//TODO : 테스트
				
				map.put("END_RULE", "until");
				map.put("END_DATE", rruleEndDate);
				
				//반복일정 테이블 업데이트 until
				calendarDAO.updateCalEventRrule(map);
				
				// '이번일정만' 수정으로 추가된 row를 선택하여 '향후일정' 수정/삭제를 하려 하는 경우
				//    -> rruleSyncId 로 본래 rrule을 찾아 until을 넣어준다
				if(map.get("hiddenModalRruleSyncId") != null && !String.valueOf(map.get("hiddenModalRruleSyncId")).isEmpty()) {
					calendarDAO.updateCalEventRruleBySyncId(map);
				}
				
				//삭제
				if(null != map.get("delFlag") && map.get("delFlag").equals("Y"))
				{
					// 향후일정 삭제의 경우의 수
					// 1. 아무런 추가 row 없이 rrule 에 until 만 추가해주면 되는 경우
					//    -> 추가 로직 없음
					// 2. '이번일정만' 수정으로 추가된 row가 있을 경우
					//    -> 추가된 row를 삭제 (삭제하려는 일정의 날짜보다 뒤에 있는 row를 찾아 삭제)
					//    -> row가 rrule 을 가지고 있을 경우 rrule 도 같이 삭제해준다.
					calendarDAO.deleteExDateEvent(map);
					calendarDAO.deleteExDateEventRrule(map);
					
					// 3. '이번일정만' 수정으로 추가된 row를 선택하여 '향후일정' 수정/삭제를 하려 하는 경우
					//    -> rruleSyncId 로 본래 rrule을 찾아 until을 넣어준다
					if(map.get("hiddenModalRruleSyncId") != null && !String.valueOf(map.get("hiddenModalRruleSyncId")).isEmpty()) {
						calendarDAO.updateCalEventRruleBySyncId(map);
					}
				}
				else
				{
					//
					//향후 모든 일정 수정을 눌렀을 때, 발생하는 쓰레기 데이터 삭제
					
					Map<String, Object> garbageMap = calendarDAO.selectCalendarRepeatGarbageData(map);
					/*
					System.out.println("asflkasjfsd : " + garbageMap.get("END_DATE"));
					System.out.println("asflkmflasf : " + garbageMap.get("START_DATE").toString().compareTo(garbageMap.get("END_DATE").toString()));
					
					if(null != garbageMap.get("END_DATE") && (garbageMap.get("START_DATE").toString().compareTo(garbageMap.get("END_DATE").toString()) > 0) )
					{
						System.out.println("aslfkjasflksjflks f 이걸 왜타??");
						calendarDAO.deleteCalendarRepeatRule(map);
						calendarDAO.deleteCalendarEvent(map);
					}
					*/
					
					Map<String, Object> startDateCompareMap = calendarDAO.selectCalendarRepeatGarbageData(map);
		
					//EX_DATE 체크					
					// 단일일정의 경우 rruleSyncId 로 EX_DATE 를 체크한다
					List<Map<String, Object>> exDateMap = calendarDAO.selectCalendarRepeatRule(map);
					
					if(exDateMap.size() > 0 && !"".equals(exDateMap.get(0).get("EX_DATE")))
					{
						String[] arrayExDate = exDateMap.get(0).get("EX_DATE").toString().split(",");
						String[] arrayEventId = new String[exDateMap.size()];
						
						for(int i=0; i<exDateMap.size(); i++)
						{
							arrayEventId[i] = (String) exDateMap.get(i).get("EVENT_ID");
							
							String EX_DATE = arrayExDate[i];
							String EVENT_ID = arrayEventId[i];
							
							if(map.get("hiddenModalStartRuleDate").toString().compareTo(EX_DATE) < 0)
							{
								//날짜가 바꼇을 때,
								if(null != map.get("hiddenModalRRuleStartDateFlag") && map.get("hiddenModalRRuleStartDateFlag").equals("difStartDate"))
								{
									if(null != garbageMap.get("END_DATE") && (garbageMap.get("START_DATE").toString().compareTo(garbageMap.get("END_DATE").toString()) > 0) )
									{
										calendarDAO.deleteCalendarEventRRuleSyncID(map);
									}
									
									//단일 일정 삭제
									map.put("hiddenModalEventId", EVENT_ID);
									//calendarDAO.deleteCalRRuleSyncEvent(map);
									calendarDAO.deleteCalendarEventRRuleSyncID(map);
									
									
									//for문 돌지만 한번만 태움
									if(i == 0 )
									{
										//새로운 반복일정 insert
										map.put("rruleChoiceFlag", "flagAfter");
										insertCalendarEvent(map, request);
									}
								}
								else
								{//날짜말고 제목 등이 바꼇을 때,
									
									//새로운 repeat db 데이터 insert 할때, EX_DATE 값
									map.put("exDate", Arrays.toString(arrayExDate).substring(1, Arrays.toString(arrayExDate).indexOf("]")).replaceAll(" ", ""));
									
									//for문 돌지만 한번만 태움
									if(i == 0 )
									{
										if(startDateCompareMap.get("START_DATE").toString().compareTo(map.get("hiddenModalStartRuleDate").toString()) == 0)
										{
											calendarDAO.deleteCalendarEventRRuleSyncID2(map);
										}else{
											map.put("END_RULE", "until");
											map.put("END_DATE", rruleEndDate);
											
											//반복일정 테이블 업데이트 until
											calendarDAO.updateCalEventRrule(map);
										}
										
										//새로운 일정 & 반복일정 insert
										map.put("rruleChoiceFlag", "flagAfter");
										insertCalendarEvent(map, request);
									}
									
									//RRULE_SYNC_ID 새로운 반복일정 ID로 변경
									map.put("newEventID", map.get("EVENT_ID"));
									map.put("hiddenModalEventId", EVENT_ID);
									//#hiddenModalRRuleSettingCompareFlag").val("changeRruleSetting");
									if(null != map.get("hiddenModalRRuleSettingCompareFlag") && map.get("hiddenModalRRuleSettingCompareFlag").equals("changeRruleSetting"))
									{//반복룰 바꾸었을 때, ( 날짜 바꾸지 않고 ) 
										calendarDAO.deleteCalendarEventRRuleSyncID2(map); //반복룰 설정으로 인해 생긴 단일 일정 쓰레기 데이터 삭제
									}else
									{//제목만 바꾸었을 때, ( 날짜 바꾸지 않
										
										calendarDAO.updateCalendarRRuleEvent2(map);		//단일 일정 업데이트 ( 제목, sync_id 등_ 새로운 반복일정과 Sync)
									}
									
								}
							}
							else
							{
								// 수정하는 일정 범위에 포함되는 (단일일정 또는 반복일정은 삭제해준다.)								
								calendarDAO.deleteExDateEvent(map);
								calendarDAO.deleteExDateEventRrule(map);
																
								//for문 돌지만 한번만 태움
								if(i == 0 )
								{
									//새로운 일정 & 반복일정 insert
									map.put("rruleChoiceFlag", "flagAfter");
									insertCalendarEvent(map, request);
									
									//RRULE_SYNC_ID 새로운 반복일정 ID로 변경
									map.put("newEventID", map.get("hiddenModalEventId"));
									map.put("hiddenModalEventId",  map.get("EVENT_ID"));
									
									calendarDAO.updateCalendarRRuleEvent(map);		//단일 일정 업데이트 ( 제목, sync_id 등_ 새로운 반복일정과 Sync)
								}
							}
						}//for()
					}//if()
					else
					{//EX_DATE 값이 비어있을때 ( 단일 일정이 없을때 )
						
						//날짜가 바꼇을 때,
						if(null != map.get("hiddenModalRRuleStartDateFlag") && map.get("hiddenModalRRuleStartDateFlag").equals("difStartDate"))
						{
							if(null != garbageMap.get("END_DATE") && (garbageMap.get("START_DATE").toString().compareTo(garbageMap.get("END_DATE").toString()) > 0) )
							{
								calendarDAO.deleteCalendarEventRRuleSyncID(map);
							}
							
							if(map.get("radioModalEndRule").equals("until"))
							{
								map.put("END_RULE", "loop");
								map.put("hiddenModalEndCondition", "loop");
								map.put("hiddenModalLoopNum", "4");
								map.put("hiddenModalEndRuleDate", null);
							}
							
							map.put("rruleChoiceFlag", "flagAfter");
							insertCalendarEvent(map, request);
							
							map.put("hiddenModalEventId", garbageMap.get("EVENT_ID"));
							selectRRuleSyncEvent(map);
							
						}
						else
						{//날짜말고 제목 등이 바뀌었을 때 or 반복룰 설정으로 바뀌었을 때.
							
							//Map<String, Object> startDateCompareMap = calendarDAO.selectCalendarRepeatGarbageData(map);
							
							if(startDateCompareMap.get("START_DATE").toString().compareTo(map.get("hiddenModalStartRuleDate").toString()) == 0)
							{//반복 일정 처음 날짜 데이터를 수정하였을 경우
								
								Map<String, Object> rruleSyncCheckMap = calendarDAO.selectCalendarEvent(map);
								calendarDAO.deleteCalendarEventRRuleSyncID(map);
								
								//반복룰 설정을 변경한 후, 향후 일정을 선택 하였을 때, 바뀐 날짜를 첫 DATE 로 수정해 준다.
								map.put("textModalStartDate", map.get("hiddenModalFollowingStartDate"));		//calendar_event	start_date
								map.put("hiddenModalEndDate", map.get("hiddenModalFollowingStartDate"));		//calendar_event	end_date
								map.put("hiddenModalStartRuleDate", map.get("hiddenModalFollowingStartDate"));	//calendar_repeat
								
								//맵에 기존 값들이 담겨져 있어서 초기 값으로 수정해주기
								if(map.get("radioModalEndRule").equals("until"))
								{
									map.put("END_RULE", "loop");
									map.put("hiddenModalEndCondition", "loop");
									map.put("hiddenModalLoopNum", "4");
									map.put("hiddenModalEndRuleDate", null);
									
								}
								else if(map.get("radioModalEndRule").equals("loop"))
								{
								}
								
								map.put("rruleChoiceFlag", "flagAfter");
								insertCalendarEvent(map, request);
							}
							else
							{//반복 일정 중에서 중간 날짜 데이터를 수정하였을 경우
								
//								if(null != map.get("hiddenModalRRuleSettingCompareFlag") && map.get("hiddenModalRRuleSettingCompareFlag").equals("changeRruleSetting"))
//								{
								
									//반복룰 변경 했을 경우( 요일 체크박스 수정 했을 경우 기존 반복일정과 Sync 되지 않고 새로운 반복일정 생성)
									if(null != map.get("hiddenModalChangeCheckRuleByweekday") && map.get("hiddenModalChangeCheckRuleByweekday").equals("true"))
									{
										
										//반복룰 설정을 변경한 후, 향후 일정을 선택 하였을 때, 바뀐 날짜를 시작 DATE 로 수정해 준다.
										map.put("textModalStartDate", map.get("hiddenModalFollowingStartDate"));		//calendar_event	start_date
										map.put("hiddenModalEndDate", map.get("hiddenModalFollowingStartDate"));		//calendar_event	end_date
										map.put("hiddenModalStartRuleDate", map.get("hiddenModalFollowingStartDate"));	//calendar_repeat
										
										map.put("rruleChoiceFlag", "flagAfter");
										insertCalendarEvent(map, request);
									}
									else
									{//반복룰 변경 X
										
										//날짜&반복룰 이외(ex 제목) 변경시에 기존 반복일정과 Sync

										//repeat 테이블 필드
										map.put("syncFlag", map.get("hiddenModalEventId"));
										
										map.put("rruleChoiceFlag", "flagAfter");
										insertCalendarEvent(map, request);
										
										//RRULE_SYNC_ID 새로운 반복일정 ID로 변경
										map.put("newEventID", map.get("hiddenModalEventId"));
										map.put("hiddenModalEventId",  map.get("EVENT_ID"));
										
										calendarDAO.updateCalendarRRuleEvent(map);		//단일 일정 업데이트 ( 제목, sync_id 등_ 새로운 반복일정과 Sync)
									}
//								}
									
								/*
								else
								{
									System.out.println("asfklsjfsd : " + map);

									//repeat 테이블 필드
									map.put("syncFlag", map.get("hiddenModalEventId"));
									
									map.put("rruleChoiceFlag", "flagAfter");
									insertCalendarEvent(map, request);
									
									//RRULE_SYNC_ID 새로운 반복일정 ID로 변경
									map.put("newEventID", map.get("hiddenModalEventId"));
									map.put("hiddenModalEventId",  map.get("EVENT_ID"));
									
									calendarDAO.updateCalendarRRuleEvent(map);		//단일 일정 업데이트 ( 제목, sync_id 등_ 새로운 반복일정과 Sync)
								}
								*/
							}
						}
					}
				}
			}
			else if(map.get("rruleCase").toString().equals("3"))	//전체일정 삭제(delete_yn 수정).
			{ 
				//삭제
				if(null != map.get("delFlag") && map.get("delFlag").equals("Y"))
				{					
					// rrule 삭제
					calendarDAO.deleteCalendarRepeatRule(map);
					// 범위에 포함되는 event 삭제
					calendarDAO.deleteCalEventAndExEvent(map);
				}
				else
				{
					Map<String, Object> rruleSyncCheckMap = calendarDAO.selectCalendarEvent(map);
					
					if(null != rruleSyncCheckMap.get("RRULE_SYNC_ID"))
					{
						map.put("newEventID", rruleSyncCheckMap.get("RRULE_SYNC_ID"));
						calendarDAO.updateCalendarRRuleEvent2(map);
						
						map.put("hiddenModalEventId", rruleSyncCheckMap.get("RRULE_SYNC_ID"));
						map.put("newEventID", null);
						calendarDAO.updateCalendarRRuleEvent2(map);
					}
					else
					{
						//최초 반복일정 날짜, 새로 바뀐 START_DATE 값
						map.get("hiddenModalAllEventsStartDate");

						map.put("textModalStartDate", map.get("hiddenModalAllEventsStartDate"));
						map.put("selectModalStartDateTime", map.get("selectModalStartDateTime"));

						
						map.put("hiddenModalEndDate", map.get("hiddenModalAllEventsEndDate"));
						map.put("selectModalEndDateTime", map.get("selectModalEndDateTime"));
						
						//전체 수정일 경우엔 최초 반복일정에 대한 날짜는 변경되지 않고 시간만 변경되도록 
						//아래 if문이 필요 있나???
						/*
						if(null != map.get("hiddenModalRRuleSettingAllEventFlag") && map.get("hiddenModalRRuleSettingAllEventFlag").equals("changeRruleSettingAllEvent"))
						{
							System.out.println("asklfjsdf : " + rruleSyncCheckMap.get("START_DATETIME").toString().substring(0, 10));
							map.put("textModalStartDate", rruleSyncCheckMap.get("START_DATETIME").toString().substring(0, 10));
							map.put("selectModalStartDateTime", map.get("selectModalStartDateTime"));
							
							map.put("hiddenModalEndDate", rruleSyncCheckMap.get("END_DATETIME").toString().substring(0, 10));
							map.put("selectModalEndDateTime", map.get("selectModalEndDateTime"));
						}
						*/
						//일정 업데이트
//						calendarDAO.updateCalendarRRuleEvent2(map); // rrule 변경
						calendarDAO.updateCalendarRRuleEvent(map); 	// 시간 날짜 변경
						
						map.put("hiddenModalStartRuleDate", map.get("textModalStartDate"));
						
						//반복일정
						map.put("rruleChoiceFlag", "flagAll");
						upsertCalendarEventRRule(map);
					}
					
					
					//단일 일정 체크
					selectRRuleSyncEvent(map);	
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception(e);
		}
		
		return cnt;
	}
	
	/**
	 * @author 	: 준이
	 * @Date		: 2017. 06. 01.
	 * @explain	: 일정관리 -> 일정검색 -> 검색조건의 시작일, 종료일 범위인지 날짜 비교.
	 */
	public int compareDate(String compareDate, String searchStartDate, String searchEndDate) throws Exception {
		int cnt = -2;
		if(searchStartDate != null && !searchStartDate.equals("")){
			cnt = compareDate.compareTo(searchStartDate); 
			if(searchEndDate != null && !searchEndDate.equals("") && cnt >= 0){
				cnt = searchEndDate.compareTo(compareDate);
			}
		}else{
			cnt = searchEndDate.compareTo(compareDate);
		}
		
		return cnt; //0보다 같거나 커야 리스트에 나옴.
	}
	
	public List<Map<String, Object>> calendarEventListMobile(HttpServletRequest request,Map<String, Object> map) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		list = calendarDAO.calendarEventListMobile(map);
		
		return list;
	}
	
	public Map<String, Object> selectMyCalendarMaster(Map<String, Object> map) throws Exception {
		Map<String, Object> calMap = new HashMap<String, Object>();
		
		calMap = calendarDAO.selectMyCalendarMaster(map);
		
		return calMap;
	}
	
}/////