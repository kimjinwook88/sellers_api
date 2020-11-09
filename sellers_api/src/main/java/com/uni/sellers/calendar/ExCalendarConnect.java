package com.uni.sellers.calendar;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.uni.sellers.util.CommonFileUtils;

import microsoft.exchange.webservices.data.core.ExchangeService;
import microsoft.exchange.webservices.data.core.PropertySet;
import microsoft.exchange.webservices.data.core.enumeration.misc.ExchangeVersion;
import microsoft.exchange.webservices.data.core.enumeration.property.BasePropertySet;
import microsoft.exchange.webservices.data.core.enumeration.property.BodyType;
import microsoft.exchange.webservices.data.core.enumeration.property.WellKnownFolderName;
import microsoft.exchange.webservices.data.core.enumeration.property.time.DayOfTheWeek;
import microsoft.exchange.webservices.data.core.enumeration.service.ConflictResolutionMode;
import microsoft.exchange.webservices.data.core.enumeration.service.DeleteMode;
import microsoft.exchange.webservices.data.core.enumeration.service.SendInvitationsOrCancellationsMode;
import microsoft.exchange.webservices.data.core.service.item.Appointment;
import microsoft.exchange.webservices.data.credential.ExchangeCredentials;
import microsoft.exchange.webservices.data.credential.WebCredentials;
import microsoft.exchange.webservices.data.property.complex.EmailAddress;
import microsoft.exchange.webservices.data.property.complex.FolderId;
import microsoft.exchange.webservices.data.property.complex.ItemId;
import microsoft.exchange.webservices.data.property.complex.Mailbox;
import microsoft.exchange.webservices.data.property.complex.MessageBody;
import microsoft.exchange.webservices.data.property.complex.recurrence.pattern.Recurrence;
import microsoft.exchange.webservices.data.property.complex.time.OlsonTimeZoneDefinition;
import microsoft.exchange.webservices.data.search.CalendarView;
import microsoft.exchange.webservices.data.search.FindItemsResults;

@Component("ExCalendarConnect")
public class ExCalendarConnect {

	private ExchangeService service = new ExchangeService(ExchangeVersion.Exchange2010);
	private EmailAddress emAddr;
	
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	public ExCalendarConnect() {
	}
	
	/**
	 * Outlook 로그인
	 * @param map
	 * @param calUserInfoPath
	 * @throws Exception
	 */
	public void loginOutlook(Map<String, Object> map, String calUserInfoPath) throws Exception {
		log.debug("Outlook Login Start");
		
		// Exchange2007 호환여부 설정
		//service.setExchange2007CompatibilityMode(true);
		
		// outlook 로그인 정보 읽어오기
		map.put("MEMBER_ID_NUM", map.get("hiddenModalCreatorId"));
		
		Map<String, Object> loginInfoMap = new HashMap<String, Object>();
		loginInfoMap = readOutlookInfo(map, calUserInfoPath);
		
		String id 		= (String) loginInfoMap.get("logID");
		String pw 		= (String) loginInfoMap.get("logPW");
		
		// 현재 office365 만 사용하고 있기 때문에 생략
		//String serverNm = (String) loginInfoMap.get("serverNm"); 
		
		this.emAddr = new EmailAddress(id);
		
		ExchangeCredentials credentials = new WebCredentials(id, pw);
		service.setCredentials(credentials);
	}
	
	/**
	 * outlook Item ID 존재여부 확인
	 * @param startDate
	 * @param endDate
	 * @param itemId
	 * @return
	 * @throws Exception
	 */
	public Appointment isExists(Date startDate, Date endDate, ItemId itemId) throws Exception {
		
		Appointment result = null;
		
		Calendar cal = Calendar.getInstance();
		cal.clear(Calendar.SECOND);
		cal.setTime(endDate);
		cal.add(Calendar.DATE, 1);
		endDate = cal.getTime();
		
		int NUM_APPTS = 100;
		CalendarView cView = new CalendarView(startDate, endDate, NUM_APPTS);
		PropertySet prop = new PropertySet();
		cView.setPropertySet(prop);
		
		FolderId folderId = new FolderId(WellKnownFolderName.Calendar, new Mailbox(this.emAddr.getAddress()));
		FindItemsResults<Appointment> findResults = service.findAppointments(folderId, cView);
		ArrayList<Appointment> calItem = findResults.getItems();
				
		String sellersId = itemId.toString();
		String outlookId = "";
		for(Appointment Details : calItem) {
			
			Details.load();
			outlookId = Details.getId().toString();
			
			// 반복일정일 경우 Id 가져오는 방식이 다름
			if(Details.getIsRecurring()) {
				Appointment recurrDetails = Appointment.bindToRecurringMaster(service, Details.getId());
				outlookId = recurrDetails.getId().toString();
			}	
			
			if(outlookId.equals(sellersId)) {
				result = Details;				
			}
		}
		
		return result;
	}

	/**
	 * Excahnge 서버에 접속 
	 * OUTLOOK 캘린더 -> Seller's 캘린더 ( 일정 가저오기 )
	 * @param outlookLoginId
	 * @param outlookLoginPw
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> outlookCalendarConnect(String outlookLoginId, String outlookLoginPw, List<Map<String, Object>> syncEventMap, String serverNm, String SERVER_URL, Map<String, Object> map)
			throws Exception {

		log.debug("outlookCalendarConnect Call. ");
		//CommonPropertiesUtile getPropertyInfo = new CommonPropertiesUtile();

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> outlookMap = new HashMap<String, Object>();


		String outlookId 		= outlookLoginId;
		String outlookPassword 	= outlookLoginPw;
		// System.out.println("복호화된 ID : " + outlookId);
		// System.out.println("복호화된 PW : " + outlookPassword);

		//ExchangeService service = new ExchangeService(ExchangeVersion.Exchange2007_SP1);
		//ExchangeService service = new ExchangeService(ExchangeVersion.Exchange2010);
		
		log.debug("Outlook Login Start");
		// 로그인.
		ExchangeCredentials credentials = new WebCredentials(outlookId, outlookPassword);
		this.emAddr 			= new EmailAddress(outlookId);

		service.setCredentials(credentials);
		service.setMaximumPoolingConnections(500);
        
		try {
			//서버경로 .properties 에서 읽어온다.

			//			String serverUrl = getPropertyInfo.propertyInfo(serverNm);
			service.setUrl(new URI(SERVER_URL));
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}

		// 날짜 범위 설정.
		
		/*
		Calendar startCal 	= Calendar.getInstance();
		Calendar endCal 	= Calendar.getInstance();
		DateFormat df 		= new SimpleDateFormat("yyyy-MM");
		
		startCal.setTime(new Date());
		// startCal.add(Calendar.DATE, -3);
		startCal.add(Calendar.MONTH, 0);
		String startDate = df.format(startCal.getTime());
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM");

		endCal.setTime(new Date());
		// endCal.add(Calendar.DATE, 3);
		endCal.add(Calendar.MONTH, 1);
		String endDate = df.format(endCal.getTime());
		*/
		
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM");
		SimpleDateFormat transFormat2 = new SimpleDateFormat("yyyy-MM-dd");
		
		String yearMonthStart = map.get("selectYear")+"-"+map.get("selectMonth");
		int yearMonth = Integer.parseInt(map.get("selectMonth").toString()) + 01 ;
		String yearMonthEnd = map.get("selectYear") + "-" + Integer.toString(yearMonth);
		
		Calendar cal = Calendar.getInstance();
		cal.clear(Calendar.SECOND);

		try {
			// String으로 된 날짜를 Date 형태로 변환.
//			Date start 	= transFormat.parse(startDate);
//			Date end 	= transFormat.parse(endDate);
			Date start;
			Date end;
			
			//일정검색일 경우 날짜변경.
			if(map.get("textSearchStartDate") != null && !map.get("textSearchStartDate").equals("")){
				start = transFormat2.parse(map.get("textSearchStartDate").toString());
				yearMonthStart = map.get("textSearchStartDate").toString();
				
				if(map.get("textSearchEndDate") != null && !map.get("textSearchEndDate").equals("")){
					end = transFormat2.parse(map.get("textSearchEndDate").toString());
				}else{
					//그달 달력 끝날까지 일정 가져오기..
					cal.setTime(start);
					cal.add(Calendar.MONTH, 1);
					cal.add(Calendar.DATE, 15-cal.get(Calendar.DAY_OF_WEEK));
					end = cal.getTime();
				}
			}else{
				
				start = transFormat2.parse((String) map.get("startDate"));
				cal.setTime(start);
				start = cal.getTime();

				end = transFormat2.parse((String) map.get("endDate"));
				cal.setTime(end);
				end = cal.getTime();
				
//				start = transFormat.parse(yearMonthStart);
//				end = transFormat.parse(yearMonthEnd);
//				
//				//그달 달력 첫날부터 끝날까지 일정 가져오기..
//				cal.setTime(start);
//				cal.add(Calendar.DATE, 1-cal.get(Calendar.DAY_OF_WEEK));
//				start = cal.getTime();
//				
//				cal.setTime(end);
//				cal.add(Calendar.DATE, 15-cal.get(Calendar.DAY_OF_WEEK));
//				end = cal.getTime();
			}
			
			
			int NUM_APPTS = 100;
			// Set the start and end time and number of appointments to
			// retrieve.
			CalendarView cView = new CalendarView(start, end, NUM_APPTS);
			PropertySet prop = new PropertySet();
			cView.setPropertySet(prop);
			FolderId folderId = new FolderId(WellKnownFolderName.Calendar, new Mailbox(emAddr.getAddress()));
			FindItemsResults<Appointment> findResults = service.findAppointments(folderId, cView);
			ArrayList<Appointment> calItem = findResults.getItems();
			PropertySet itemPropertySet = new PropertySet(BasePropertySet.FirstClassProperties);
			itemPropertySet.setRequestedBodyType(BodyType.Text);
			int numItems = findResults.getTotalCount();

			log.debug("Outlook Login Complete");
			log.debug("Getting Events List from Outlook Calendar");
			int z=0; //remove 
			if(numItems==0)
			{
				outlookMap.put("errMsg", "해달 월에 불러올 사내캘린더 일정이 없습니다.");
				outlookMap.put("errStatus", "2");
				list.add(outlookMap);
			}
			else 
			{
				//outlook 일정 가져오기.
				for (int i = 0; i < numItems; i++) {
					outlookMap = new HashMap<String, Object>();
					Appointment Details = Appointment.bind(service, calItem.get(i).getId(), itemPropertySet);
					calItem.get(i).load();

					outlookMap.put("DTSTART", calItem.get(i).getStart()); 		 	// 시작일자
					
					int tmp = 0;
					//일정 검색일 경우 날짜범위 지정.
				    if(map != null){
				    	SimpleDateFormat formatter_one = new SimpleDateFormat("yyyy-MM-dd");
				    	String compareDate = "";
				    	String searchStartDate = "";
				    	String searchEndDate = "";
				    	compareDate = formatter_one.format(outlookMap.get("DTSTART"));
					    
				    	int compareResult = 0;
					    if(map.get("textSearchStartDate") != null && !map.get("textSearchStartDate").equals("")){
					    	searchStartDate = map.get("textSearchStartDate").toString();
					    	if(map.get("textSearchEndDate") != null && !map.get("textSearchEndDate").equals("")){ //검색조건 시작일, 종료일 둘다
					    		searchEndDate = map.get("textSearchEndDate").toString();
					    		compareResult = compareDate(compareDate, searchStartDate, searchEndDate); //날짜 비교
					    	}else{ //검색조건 시작일만
					    		compareResult = compareDate(compareDate, searchStartDate, searchEndDate); //날짜 비교
					    	}
					    }else if(map.get("textSearchEndDate") != null && !map.get("textSearchEndDate").equals("")){ //검색조건 종료일만
					    	searchEndDate = map.get("textSearchEndDate").toString();
					    	compareResult = compareDate(compareDate, searchStartDate, searchEndDate); //날짜 비교
					    }
					    if(compareResult < 0){
			    			tmp = 1;
			    		}
				    }
					
				    outlookMap.put("SUMMARY", calItem.get(i).getSubject()); 	 	// 제목
					outlookMap.put("DTEND", calItem.get(i).getEnd()); 			 	// 종료일자
					outlookMap.put("DESCRIPTION", Details.getBody().toString()); 	// 상세내용
					outlookMap.put("LOCATION", calItem.get(i).getLocation()); 		// 위치 
					
					//일정검색어가 있을경우 제목과 비교.
				    if(map.get("textSearch") != null && !map.get("textSearch").equals("")){
				    	if(!outlookMap.get("SUMMARY").toString().matches("(?i).*"+ map.get("textSearch").toString() +".*")){
					    	tmp = 1;
					    }
				    }
				    
				    
				    if(tmp == 1){ //날짜 or 검색어가 없으면 list에 안담고 다음 맵으로 넘어감.
				    	continue;
				    }

					//					System.out.println("aslkfjsklfjsdf : " + calItem.get(i).getICalUid());

					outlookMap.put("errMsg", "아웃룩 로그인 성공.");
					outlookMap.put("errStatus", "1");
					outlookMap.put("MEMBER_ID_NUM", map.get("MEMBER_ID_NUM"));
					
					//list.add(outlookMap);		
					
					// 셀러스 일정과 비교하여, 싱크되지 않은 데이터만 list에 추가
					boolean syncCheck = false;
					String outlookEventId = Details.getId().toString();
					String syncEventId = "";
					
					// 반복일정일 경우 Id 가져오는 방식이 다름
					if(Details.getIsRecurring()) {
						Appointment recurrDetails = Appointment.bindToRecurringMaster(service, Details.getId());
						outlookEventId = recurrDetails.getId().toString();
					}									

					if(!syncEventMap.equals("") || syncEventMap != null){
						//셀러스 일정 비교하여, sync된 데이터는 outlook 일정에서 지우기.
						for(int j=0; j < syncEventMap.size(); j++){
							
							syncEventId = (String) syncEventMap.get(j).get("OUTLOOK_ID");
							
							if(outlookEventId.equals(syncEventId)) {
								syncCheck = true;
								break;
							}

							//							System.out.println("lskflsdfsdfsdfa : " + calItem.get(i).getId());

							/*if( calItem.get(i).getSubject().equals(syncEventMap.get(j).get("EVENT_SUBJECT"))
									&& (Details.getBody().toString().replace(System.getProperty("line.separator"), "").trim()).equals(syncEventMap.get(j).get("EVENT_DETAIL").toString().replace(System.getProperty("line.separator"), "").trim())
									)
							{
								//중복된 일정 list remove
								list.remove(i-z);
								z++;
							}//if
*/						}//for
					}
					
					if(!syncCheck) {
						list.add(outlookMap);	
					}
				}//for
			}

		} catch (Exception e) {
			e.printStackTrace();
			log.debug("Outlook Login Fail");
			outlookMap.put("errMsg", "사내캘린더 ID / PASSWORD 잘못되었습니다. \n다시 로그인 하십시오.");

			//로그인 및 일정가져오기 실패
			outlookMap.put("errStatus", "0");

			list.add(outlookMap);
			return list;
		}finally{
			service.close();
		}
		
		//일정검색 중 리스트에 일정이 하나도 없을경우 리스트에 담아줌. 
		if(list.size() == 0){
			outlookMap = new HashMap<String, Object>();
			outlookMap.put("errMsg", "아웃룩 일정 없음.");
			outlookMap.put("errStatus", "9");
			list.add(outlookMap);
		}
		
		return list;
	}
	
	/**
	 * Outlook 반복일정 설정
	 * @param map
	 * @return
	 */
	public Recurrence setOutlookCalendarRule(Map<String, Object> map, Date startDate) throws Exception {
		
		Recurrence recurrence = null;
		
		// 1. 반복빈도 (매주:2, 매월:1, 분기:3, 반기:4)
		String freq = map.get("selectModalFreq").toString();
		
		// 2. 반복간격
		int interval = Integer.parseInt(map.get("selectModalInterval").toString());	
		
		// 3. 반복일 (매주에만 해당)(BYDAY=MO,TU,WE,TH,FR,SA,SU)
		String ruleByWeekday = null;
		
		// 4. 반복마감일 (매월, 분기, 반기에만 해당, 추후 기능정의 및 수정 필요)
		// ex) '17'일(BYMONTHDAY=17) or '2'번째 '화'요일(BYDAY=+2TU)
		String ruleBy = null;
		String ruleByMonthday = null;
		
		// 5. 종료일 (일정 시작일을 기준으로 계산)
		Calendar cal = Calendar.getInstance();
		cal.clear(Calendar.SECOND);
		cal.setTime(startDate);
		
		// 반복빈도 체크
		if( freq.equals("2") ) { // 매주
			// 반복일
			ruleByWeekday = map.get("hiddenModalRuleByweekday").toString();	
							
			if(ruleByWeekday.length() > 6) {
				
				// 앞부분의 'BYDAY=' 제거
				ruleByWeekday = ruleByWeekday.substring(6, ruleByWeekday.length());
				String[] weekdayArr = ruleByWeekday.split(",");
				int arrSize = weekdayArr.length;
				
				// 반복일을 담을 배열 선언
				DayOfTheWeek[] daysOfTheWeek = new DayOfTheWeek[arrSize];
				
				for(int i=0; i<arrSize; i++) {
					String weekday = weekdayArr[i];							
					switch(weekday) {
						case "MO":
							daysOfTheWeek[i] = DayOfTheWeek.Monday;
							break;
						case "TU":
							daysOfTheWeek[i] = DayOfTheWeek.Tuesday;
							break;
						case "WE":
							daysOfTheWeek[i] = DayOfTheWeek.Wednesday;
							break;
						case "TH":
							daysOfTheWeek[i] = DayOfTheWeek.Thursday;
							break;
						case "FR":
							daysOfTheWeek[i] = DayOfTheWeek.Friday;
							break;
						case "SA":
							daysOfTheWeek[i] = DayOfTheWeek.Saturday;
							break;
						case "SU":
							daysOfTheWeek[i] = DayOfTheWeek.Sunday;
							break;
					}
				}
				
				recurrence = new Recurrence.WeeklyPattern(startDate, interval, daysOfTheWeek);	
			}else {
				recurrence = new Recurrence.WeeklyPattern(startDate, interval);
			}
			
		// 매월, 분기, 반기
		}else if(freq.equals("1") || freq.equals("3") || freq.equals("4")) {
			
			if(freq.equals("3")) {
				interval = 3;
			}else if(freq.equals("4")) {
				interval = 6;
			}
			
			ruleBy = map.get("hiddenModalRuleBy").toString();
			ruleByMonthday = map.get("hiddenModalRuleBymonthday").toString();
			
			int dayOfMonth = Integer.parseInt(ruleByMonthday);			
			recurrence = new Recurrence.MonthlyPattern(startDate, interval, dayOfMonth);
		}
		
		/*반복 종료일
		  loop : 계속반복 (=4년반복)
		  count : 횟수반복 (=**번 반복)
		  until : 종료일 지정 (=**년 **월 **일까지 반복)*/
		switch (map.get("hiddenModalEndCondition").toString()) {
			case "loop": 
				map.put("END_RULE", "loop");
				cal.add(Calendar.YEAR, Integer.parseInt(map.get("hiddenModalLoopNum").toString()));
				recurrence.setEndDate(cal.getTime());
				break;
				
			case "count": 
				map.put("END_RULE", "count");
				recurrence.setNumberOfOccurrences(Integer.parseInt(map.get("hiddenModalCountNum").toString()));
				break;
				
			case "until":
				map.put("END_RULE", "until");
				
				String ruleEndDateTime 			= map.get("hiddenModalEndRuleDate").toString();
				SimpleDateFormat formatter_one 	= new SimpleDateFormat("yyyy-MM-dd");
				Date ruleEndDate 				= formatter_one.parse(ruleEndDateTime);
				cal.setTime(ruleEndDate);
				
				recurrence.setEndDate(cal.getTime());
				break;
				
			default:
				break;
		}
		
		return recurrence;
	}

	/**
	 * outlook 일정 등록 Sync 
	 * Seller's 캘린더 -> OUTLOOK 캘린더 Sync  (내보내기) _Event 단위
	 * @param map
	 * @throws Exception
	 */
	public String insertOutlookCalendarSync(Map<String, Object> map, String CALENDAR_SYNC_URL, String calUserInfoPath) throws Exception {
		log.debug("insertOutlookCalendarSync Call. ");
		
		// 리턴할 outlook ID 값
		String outlookId = "";
		
		// 1. 로그인
		this.loginOutlook(map, calUserInfoPath);
		
		//==================== 모달창 입력 내용 ==========================
		// 제목
		String subject 			= map.get("textModalEventSubject").toString();
		
		// 상세내용
		MessageBody body 		= new MessageBody((String) map.get("textareaModalEventDetail").toString().replace(System.getProperty("line.separator"), "<br>"));	

		// 장소
		String location			= (String) map.get("textModalEventLocation");

		// 시작/종료 날짜,시간
		String start 			= (String) map.get("textModalStartDate");							
		String end 				= (String) map.get("textModalEndDate");		
		String startTime 		= (String) map.get("selectModalStartDateTime");						
		String endTime			= (String) map.get("selectModalEndDateTime");					

		if(startTime == null || startTime.isEmpty()) {
			startTime = "00:00";
		}
		if(endTime == null || endTime.isEmpty()) {
			endTime = "24:00";
		}
		
		// 날짜/시간 변환
		String startDateTime 	= start + " "+startTime+":00";
		String endDateTime 		= end + " "+endTime+":00";
		DateFormat transFormat 	= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date startDate 			= transFormat.parse(startDateTime);
		Date endDate 			= transFormat.parse(endDateTime);

		// 종일 여부
		boolean isAllDay = false;

		if (map.get("hiddenModalAllday_YN").equals("Y")){
			isAllDay = true;
		}
		//==================== 모달창 입력 내용 ==========================
		
		//==================== 아웃룩 일정 등록 ==========================
		service.setUrl(new URI(CALENDAR_SYNC_URL));
		
		// 2. 일정생성
		Appointment meeting = new Appointment(service);
		
		meeting.setSubject(subject);																// 제목
		meeting.setBody(body);																		// 상세내용
		meeting.setLocation(location);																// 장소
		meeting.setIsAllDayEvent(isAllDay);		
		meeting.setStart(startDate);																// 시작날짜시간
		meeting.setStartTimeZone(new OlsonTimeZoneDefinition(TimeZone.getTimeZone("Asia/Seoul")));	// 시작 Timezone
		meeting.setEnd(endDate);																	// 종료날짜시간
		meeting.setEndTimeZone(new OlsonTimeZoneDefinition(TimeZone.getTimeZone("Asia/Seoul")));	// 종료 Timezone	
						
		// 3. 반복여부 체크 및 설정
		if(null != map.get("checkboxModalRepeat") && map.get("checkboxModalRepeat").equals("Y"))
		{
			// 반복 Rule
			Recurrence recurrence = this.setOutlookCalendarRule(map, startDate);
								
			// 일정에 룰 적용
			meeting.setRecurrence(recurrence);	
		}
		
		//데일리, 위크, 먼스 , 이어
		
//		meeting.setRecurrence(new Recurrence.DailyPattern(meeting.getStart(), 3));
		
		//작업중
//        EndDateRecurrenceRange range = new EndDateRecurrenceRange(meeting.getStart(), patternEndTime); //반복 범위
//		meeting.setRecurrence(new Recurrence.MonthlyPattern(meeting.getStart(), Integer.parseInt(map.get("selectModalInterval").toString()), 19)); //반볼날짜 : db byMonthDay
		
		//meeting.RequiredAttendees.Add("Mack.Chaves@contoso.com");
		//meeting.RequiredAttendees.Add("Sadie.Daniels@contoso.com");
		//meeting.OptionalAttendees.Add("Magdalena.Kemp@contoso.com");
		//meeting.ReminderMinutesBeforeStart = 60;

		//Send the meeting request
		//meeting.save(SendInvitationsMode.SendToAllAndSaveCopy);
		
		// 4. 일정 등록
		meeting.save();
		
		// 5. 일정을 저장하여 생성된 outlook Id 를 리턴시키기 위해 변수에 담는다.
		outlookId = meeting.getId().toString();
		
		service.close();
		log.debug("[Seller's calendar -> outlook calendar] Insert Sync SUCCESS");
		
		return outlookId;
	}
	
	/**
	 * outlook 일정 업데이트 Sync 
	 * Seller's 캘린더 -> OUTLOOK 캘린더 Sync  (내보내기) _Event 단위
	 * @param map
	 * @throws Exception
	 */
	public void updateOutlookCalendarSync(Map<String, Object> map, List<Map<String,Object>> calList, String CALENDAR_SYNC_URL, String calUserInfoPath) throws Exception {
		log.debug("updateOutlookCalendarSync Call. ");
		
		// 1. 로그인
		this.loginOutlook(map, calUserInfoPath);
		
		//==================== 모달창 입력 내용 ==========================
		
		// 제목
		String subject 			= map.get("textModalEventSubject").toString();
		
		// 상세내용
		MessageBody body 		= new MessageBody((String) map.get("textareaModalEventDetail").toString().replace(System.getProperty("line.separator"), "<br>"));

		// 장소
		String location			= (String) map.get("textModalEventLocation");
		
		// 시작/종료 날짜,시간
		String start 			= (String) map.get("textModalStartDate");							
		String end 				= (String) map.get("textModalEndDate");		
		String startTime 		= (String) map.get("selectModalStartDateTime");						
		String endTime			= (String) map.get("selectModalEndDateTime");					

		if(startTime == null || startTime.isEmpty()) {
			startTime = "00:00";
		}
		if(endTime == null || endTime.isEmpty()) {
			endTime = "24:00";
		}
		
		// 날짜/시간 변환
		String startDateTime 	= start + " "+startTime+":00";
		String endDateTime 		= end + " "+endTime+":00";
		DateFormat transFormat 	= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date startDate 			= transFormat.parse(startDateTime);
		Date endDate 			= transFormat.parse(endDateTime);
				
		// 종일 여부
		boolean isAllDay = false;

		if (map.get("hiddenModalAllday_YN").equals("Y")){
			isAllDay = true;
		}
		
		//==================== 모달창 입력 내용 ==========================
		
		// 2. 일정 수정
		service.setUrl(new URI(CALENDAR_SYNC_URL));
				
		ItemId itemId = new ItemId();
		itemId = ItemId.getItemIdFromString((String) map.get("hiddenModalOutlookId"));
		
		PropertySet itemPropertySet = new PropertySet(BasePropertySet.FirstClassProperties);
		itemPropertySet.setRequestedBodyType(BodyType.Text);
		
		// 3. 아이디 존재여부 확인	
		// 수정 전 날짜로 확인
		String orgStart		= map.get("hiddenModalOrgStartDate").toString();	
		DateFormat transFormat2 	= new SimpleDateFormat("yyyy-MM-dd");
		Date orgStartDate	= transFormat2.parse(orgStart);
		Date orgEndDate  	= transFormat2.parse(orgStart);
		
		Appointment existsChk = this.isExists(orgStartDate, orgEndDate, itemId);
		if(existsChk != null) {
			Appointment Details = Appointment.bind(service, itemId, itemPropertySet);
			
			// 4. 반복여부 체크 및 설정
			if(String.valueOf(map.get("checkboxModalRepeat")).equals("Y"))
			{								
				// 반복 케이스 
				String rruleCase = String.valueOf(map.get("rruleCase"));				
				
				if(map.get("rruleCase") == null || rruleCase.isEmpty()) {
					rruleCase = "1";
				}	
				
				// 반복 인덱스
				int order = 0;			
				
				switch (rruleCase) {
					case "0": // 반복일정었던 일정을 반복일정으로 수정
						
						// 반복 Rule
						Recurrence recurrence = this.setOutlookCalendarRule(map, startDate);
											
						// 일정에 룰 적용
						Details.setRecurrence(recurrence);	
						
						break;
					case "1": // 선택한 일정만 수정
						
						// 반복횟수 설정 시
//						if(map.get("hiddenModalRruleDateOrder") == null || String.valueOf(map.get("hiddenModalRruleDateOrder")).isEmpty()) {
//							break;
//						}
//						
//						order = Integer.parseInt(String.valueOf(map.get("hiddenModalRruleDateOrder")));
//						Details = Appointment.bindToOccurrence(service, itemId, (order+1));	
						
						Details = existsChk;
						
						break;
					case "2": // 선택한 일정부터 이후 모든 일정 수정
						// outlook 에서는 적용불가하므로 리턴시킨다
						return;
					case "3": // 모든 일정 수정			
						
						// 모든 일정을 선택할 경우 start date 가 반복일정의 시작날로 넘어오기 때문에, end date를 대신 사용
						startDateTime 	= end + " "+startTime+":00";
						startDate 		= transFormat.parse(startDateTime);
						
						break;
					default:
						break;
				}
				
			}
			
			Details.setSubject(subject);
			Details.setBody(body);
			Details.setLocation(location);
			Details.setIsAllDayEvent(isAllDay);
			Details.setStart(startDate);																// 시작날짜시간
			Details.setStartTimeZone(new OlsonTimeZoneDefinition(TimeZone.getTimeZone("Asia/Seoul")));	// 시작 Timezone
			Details.setEnd(endDate);																	// 종료날짜시간
			Details.setEndTimeZone(new OlsonTimeZoneDefinition(TimeZone.getTimeZone("Asia/Seoul")));	// 종료 Timezone
			
			Details.update(ConflictResolutionMode.AlwaysOverwrite, SendInvitationsOrCancellationsMode.SendOnlyToChanged);
		}
		
		service.close();
		log.debug("[Seller's calendar -> outlook calendar] Update Sync SUCCESS");
		///////////////////////////////////////////////////////////////////
		////                   ↓↓↓↓↓ 이전 소스 ↓↓↓↓↓↓↓                   /////
		///////////////////////////////////////////////////////////////////
		
		//CommonPropertiesUtile getPropertyInfo = new CommonPropertiesUtile();
		//System.out.println("복호화된 ID : " + outlookId);
		//System.out.println("복호화된 PW : " + outlookPassword);
	
		//ExchangeService service = new ExchangeService(ExchangeVersion.Exchange2007_SP1);
		//ExchangeService service = new ExchangeService(ExchangeVersion.Exchange2010);
		
//			// 날짜 범위 설정.
//			Calendar startCal = Calendar.getInstance();
//			Calendar endCal = Calendar.getInstance();
//			DateFormat df = new SimpleDateFormat("yyyy-MM");
//
//			startCal.setTime(new Date());
//			//startCal.add(Calendar.DATE, -3);
//			startCal.add(Calendar.MONTH, -1);
//			String startDate = df.format(startCal.getTime());
//			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM");
//
//			endCal.setTime(new Date());
//			//endCal.add(Calendar.DATE, 3);
//			endCal.add(Calendar.MONTH, 1);
//			String endDate = df.format(endCal.getTime());
//
//			try {		
//				// String으로 된 날짜를 Date 형태로 변환.
//				Date start = transFormat.parse(startDate);
//				Date end = transFormat.parse(endDate);
//
//				int NUM_APPTS = 100;
//
//				// Set the start and end time and number of appointments to
//				// retrieve.
//				CalendarView cView = new CalendarView(start, end, NUM_APPTS);
//				PropertySet prop = new PropertySet();
//				cView.setPropertySet(prop);
//				FolderId folderId = new FolderId(WellKnownFolderName.Calendar, new Mailbox(emAddr.getAddress()));
//				FindItemsResults<Appointment> findResults = service.findAppointments(folderId, cView);
//				ArrayList<Appointment> calItem = findResults.getItems();
//				PropertySet itemPropertySet = new PropertySet(BasePropertySet.FirstClassProperties);
//				itemPropertySet.setRequestedBodyType(BodyType.Text);
//				int numItems = findResults.getTotalCount();
//
//				log.debug("Outlook Login Complete");
//				log.debug("Get Outlook Calendar List");
//				
//				for (int i = 0; i < numItems; i++) {
//					Appointment Details = Appointment.bind(service, calItem.get(i).getId(), itemPropertySet);
//					calItem.get(i).load();
//
//					if (calItem.get(i).getSubject().equals(map.get("EVENT_SUBJECT"))
//							//&& calItem.get(i).getStart().equals(map.get("START_DATETIME"))
//							//&& calItem.get(i).getEnd().equals(map.get("END_DATETIME"))
//							&& (Details.getBody().toString().trim()).equals(map.get("EVENT_DETAIL").toString().trim())) {
//
//						MessageBody body = new MessageBody((String) map.get("textareaModalEventDetail").toString()
//								.replace(System.getProperty("line.separator"), "<br>"));
//						Details.setSubject(map.get("textModalEventSubject").toString());
//						// Details.setStart(map.);
//						// Details.setEnd(value);
//						Details.setBody(body);
//						Details.update(ConflictResolutionMode.AlwaysOverwrite, SendInvitationsOrCancellationsMode.SendOnlyToChanged);
//					}
//				}
//			} catch (Exception e) {
//				log.debug("Outlook Login Fail");
//				throw e;
//			}
	}


	/**
	 * outlook 일정 삭제 Sync 
	 * Seller's 캘린더 -> OUTLOOK 캘린더 Sync  (내보내기) _Event 단위
	 * @param map
	 * @throws Exception
	 */
	public void deleteOutlookEvent(Map<String, Object> map, Map<String, Object> eventInfo, String CALENDAR_SYNC_URL, String calUserInfoPath) throws Exception {
		log.debug("deleteOutlookCalendarSync Call. ");
		
		// 1. 로그인
		this.loginOutlook(map, calUserInfoPath);
		
		/*
		  	// 아웃룩 이벤트 삭제시 시간 비교하기 위해
		  	Date eventStartDate = (Date) eventInfo.get("START_DATETIME");
		  	Date eventEnddate = (Date) eventInfo.get("END_DATETIME");
		  	
		  	// 이벤트 시작시간, 이벤트 종료시간
		  	String compareEventStartDate = CommonDateUtils.dateToString2(eventStartDate);
		  	String compareEventEndDate = CommonDateUtils.dateToString2(eventEnddate);
			
		  	log.debug("이벤트 시작시간 : " + compareEventStartDate);
		  	log.debug("이벤트 종료시간 : " + compareEventEndDate); 
		*/		 

		/*  
		  	이벤트 삭제시, 공개 Y(SHARE_YN="Y") 일 때 사내캘린더 일정도 삭제한다. (sync 처리)
			아웃룩 로그인 상태여야 하고 && 공개상태 "Y"인 일정에 대해서만 삭제
			원래 일정 (공개/비공개) 기능은 동료에게 나의 캘린더를 공유 했을 때 일정을 보여줄지 말지를 정하기 위한 옵션이다.
			비공개 일정을 사내 캘린더에도 Sync 처리 하기 위한 일정비공개 기능이 없기 때문에 비공개 일정은 사내 캘린더에 insert 하지 않는다.
			비공개 일정을 사내 캘린더에 insert를 하지 않았으니, 삭제시에도 굳이 Exchange 서버에 접근할 필요가 없기 때문에 ShareYN="N" 일 경우에는 아래 로직을 태우지 않는다. 
		*/
		
		service.setUrl(new URI(CALENDAR_SYNC_URL));
		
		// 2. 공개여부 체크 후 일정 삭제
		String ShareYN = (String) eventInfo.get("SHARE_YN");
		if(ShareYN.equals("Y")) {
			
			ItemId itemId = new ItemId();
			itemId = ItemId.getItemIdFromString((String) eventInfo.get("OUTLOOK_ID"));
			
			PropertySet itemPropertySet = new PropertySet(BasePropertySet.FirstClassProperties);
			itemPropertySet.setRequestedBodyType(BodyType.Text);
						
			// 아이디 존재여부 확인
			// 시작/종료 날짜,시간
			String start 			= (String) map.get("hiddenModalOrgStartDate");							
			String end 				= (String) map.get("hiddenModalOrgStartDate");						

			// 날짜/시간 변환
			DateFormat transFormat 	= new SimpleDateFormat("yyyy-MM-dd");
			Date startDate 			= transFormat.parse(start);
			Date endDate 			= transFormat.parse(end);
			
			Appointment existsChk = this.isExists(startDate, endDate, itemId);			
			if(existsChk != null) {
				Appointment Details = Appointment.bind(service, itemId, itemPropertySet);
				Details.load();
				// 3. 반복여부 체크 및 설정
				if(null != map.get("checkboxModalRepeat") && map.get("checkboxModalRepeat").equals("Y"))
				{
					// 반복일정 삭제
					int order = 0;
					Appointment recurrDetails = null;
					String rruleCase = String.valueOf(map.get("rruleCase"));				
					
					if(rruleCase == null || rruleCase.isEmpty()) {
						rruleCase = "1";
					}					
					
					switch (rruleCase) {
						case "1": // 선택한 일정만 삭제
//							if(eventInfo.get("EX_DATE_YN") != null && eventInfo.get("EX_DATE_YN").equals("Y"))
//							{
//								String ex_date = eventInfo.get("EX_DATE").toString();
//							}
												
//							String start 			= (String) map.get("textModalStartDate");							
//							String end 				= (String) map.get("textModalEndDate");		
//							String startTime 		= (String) map.get("selectModalStartDateTime");						
//							String endTime			= (String) map.get("selectModalEndDateTime");					
		//
//							// 날짜/시간 변환
//							String startDateTime 	= start + " "+startTime+":00";
//							String endDateTime 		= end + " "+endTime+":00";
//							DateFormat transFormat 	= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//							Date startDate 			= transFormat.parse(startDateTime);
//							Date endDate 			= transFormat.parse(endDateTime);
//												
//							CalendarView calView = new CalendarView(startDate, endDate);
//							calView.setPropertySet(new PropertySet(BasePropertySet.IdOnly, AppointmentSchema.Subject, AppointmentSchema.Start, AppointmentSchema.IsRecurring, AppointmentSchema.AppointmentType));
//							
//							FindItemsResults<Appointment> findResults = service.FindAppointments(WellKnownFolderName.Calendar, calView);
							
//							Appointment recurrDetails = Appointment.bindToOccurrence(service, itemId, 1);	
							
							// 날짜를 검색해서 해당 outlook Id 가 있을 경우 삭제한다.
							existsChk.delete(DeleteMode.MoveToDeletedItems);
							
							// 반복횟수 설정 시
//							if(map.get("hiddenModalRruleDateOrder") == null || String.valueOf(map.get("hiddenModalRruleDateOrder")).isEmpty()) {
//								break;
//							}
//							
//							order = Integer.parseInt(String.valueOf(map.get("hiddenModalRruleDateOrder")));
//							recurrDetails = Appointment.bindToOccurrence(service, itemId, (order+1));	
//							
//							recurrDetails.delete(DeleteMode.MoveToDeletedItems);
							
							break;
						case "2": // 선택한 일정부터 이후 모든 일정 삭제
																			
							endDate = transFormat.parse(String.valueOf(map.get("END_DATE")));
							
							Recurrence rec = Details.getRecurrence();
							
							// 반복일정의 첫번째 일정일 경우 모든 일정 삭제
							Date recurrStartDate = rec.getStartDate();	
							int compare = recurrStartDate.compareTo(endDate);
							if(compare >= 0) {
								Details.delete(DeleteMode.MoveToDeletedItems);
							}else {
								rec.setEndDate(endDate);
								Details.setRecurrence(rec);
								
								Details.update(ConflictResolutionMode.AlwaysOverwrite);
							}
														
							break;
						case "3": // 모든 일정 삭제
							Details.delete(DeleteMode.MoveToDeletedItems);
							break;
						default:
							break;
					}
				} else {
					Details.delete(DeleteMode.HardDelete);
				}	
			}
		}
			
		service.close();	
		log.debug("[Seller's calendar -> outlook calendar] Delete Sync SUCCESS");
		
		///////////////////////////////////////////////////////////////////
		////                   ↓↓↓↓↓ 이전 소스 ↓↓↓↓↓↓↓                   /////
		///////////////////////////////////////////////////////////////////
			
//			// 날짜 범위 설정.
//			Calendar startCal 	= Calendar.getInstance();
//			Calendar endCal 	= Calendar.getInstance();
//			DateFormat df 		= new SimpleDateFormat("yyyy-MM");
//
//			startCal.setTime(new Date());
//			// startCal.add(Calendar.DATE, -3);
//			startCal.add(Calendar.MONTH, -1);
//			String startDate = df.format(startCal.getTime());
//			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM");
//
//			endCal.setTime(new Date());
//			// endCal.add(Calendar.DATE, 3);
//			endCal.add(Calendar.MONTH, 1);
//			String endDate = df.format(endCal.getTime());
//
//			try {
//				
//				// String으로 된 날짜를 Date 형태로 변환.
//				Date start 	= transFormat.parse(startDate);
//				Date end 	= transFormat.parse(endDate);
//
//				int NUM_APPTS = 100;
//
//				// Set the start and end time and number of appointments to
//				// retrieve.
//				CalendarView cView = new CalendarView(start, end, NUM_APPTS);
//				PropertySet prop = new PropertySet();
//				cView.setPropertySet(prop);
//				FolderId folderId = new FolderId(WellKnownFolderName.Calendar, new Mailbox(emAddr.getAddress()));
//				FindItemsResults<Appointment> findResults = service.findAppointments(folderId, cView);
//				ArrayList<Appointment> calItem = findResults.getItems();
//				PropertySet itemPropertySet = new PropertySet(BasePropertySet.FirstClassProperties);
//				itemPropertySet.setRequestedBodyType(BodyType.Text);
//				int numItems = findResults.getTotalCount();
//
//				for (int i = 0; i < numItems; i++) {
//					Appointment Details = Appointment.bind(service, calItem.get(i).getId(), itemPropertySet);
//					calItem.get(i).load();
//
//					//				System.out.println("calItemID:" + Details.getICalUid());
//					//				System.out.println("제목 : " + calItem.get(i).getSubject());
//					String outlookEventStartDate = CommonDateUtils.dateToString2(calItem.get(i).getStart()); //아웃룩 일정 시작시간
//					String outlookEventEndDate = CommonDateUtils.dateToString2(calItem.get(i).getEnd()); //아웃룩 일정 시작시간
//					//				System.out.println("시작시간 : " + outlookEventStartDate);
//
//					//삭제
//					if(calItem.get(i).getSubject().equals(map.get("textModalEventSubject"))  //제목 비교
////							&& calItem.get(i).getLocation().equals(map.get("textModalEventLocation"))  // 장소 비교
//							&& outlookEventStartDate.compareTo(compareEventStartDate) == 0  // 시작시간 비교
//							&& outlookEventEndDate.compareTo(compareEventEndDate) == 0 //종료시간 비교
//							)
//					{
//						//사내캘린더 ( office 365 일정 삭제 )
//						calItem.get(i).delete(DeleteMode.HardDelete);
//					}
//				}
//
//				log.debug("deleteOutlookEvent SUCCESS");
//
//			} catch (Exception e) {
//				log.debug("deleteOutlookEvent Error");
//				e.printStackTrace();
//			}
	}

	/**
	 * 일정 추가 (outlook Sync 처리할 때, Outlook ID, PASSWORD 가져오기)
	 * @param map
	 * @param list
	 * @return
	 * @throws Exception
	 */
	//	public Map<String, Object> readOutlookInfo(Map<String, Object> map, List<Map<String,Object>> calList) throws Exception {
	public Map<String, Object> readOutlookInfo(Map<String, Object> map, String calUserInfoPath) throws Exception {

		log.debug("readOutlookInfo Call. ");

		CommonFileUtils cfu = new CommonFileUtils();
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		/*
		for(int i=0; i<calList.size(); i++)
		{
			//일단, office365 만 싱크되게끔 
			if(calList.get(i).get("CALENDAR_NAME").equals("아웃룩 캘린더") || 
					calList.get(i).get("CALENDAR_NAME").equals("Office365 캘린더")
				)
			{
				String calType = "";
				calType = "office365";

				//암호화된 파일을 읽어 온다. ( 복호화 )
				list = cfu.readOutlookInfoFile(map, list, calType);

				for(int j=0; j<list.size(); j++)
				{
					map.put("logID", (String) list.get(j).get("outlookId"));
					map.put("logPW", (String) list.get(j).get("outlookPw"));
					map.put("creatorID", (String) list.get(j).get("creatorId"));
					map.put("serverNm", (String) list.get(j).get("serverNm"));
				}

				if(map.get("logID") ==null && map.get("logPW") == null)
				{
					log.debug("로그인정보없음");
				}
			}
		}
		 */

		// office365만 되게끔
		String calType = "";
		calType = "office365";

		//암호화된 파일을 읽어 온다. ( 복호화 )
		list = cfu.readOutlookInfoFile(map, list, calType, calUserInfoPath);
		for(int j=0; j<list.size(); j++)
		{
			map.put("logID", (String) list.get(j).get("outlookId"));
			map.put("logPW", (String) list.get(j).get("outlookPw"));
			map.put("creatorID", (String) list.get(j).get("creatorId"));
			map.put("serverNm", (String) list.get(j).get("serverNm"));
		}

		if(map.get("logID") ==null && map.get("logPW") == null)
		{
			log.debug("로그인정보없음");
		}


		/*
		if(map.get("selectModalSyncCalendarID").equals("Office365"))
		{
			calType = "office365";

			//암호화된 파일을 읽어 온다. ( 복호화 )
			list = cfu.readOutlookInfoFile(map, list, calType);

			for(int j=0; j<list.size(); j++)
			{
				map.put("logID", (String) list.get(j).get("outlookId"));
				map.put("logPW", (String) list.get(j).get("outlookPw"));
				map.put("creatorID", (String) list.get(j).get("creatorId"));
				map.put("serverNm", (String) list.get(j).get("serverNm"));
			}

			if(map.get("logID") ==null && map.get("logPW") == null)
			{
				log.debug("로그인정보없음");
			}

		}else if(map.get("selectModalSyncCalendarID").equals("Outlook"))
		{
			calType = "outlook";

			//암호화된 파일을 읽어 온다. ( 복호화 )
			list = cfu.readOutlookInfoFile(map, list, calType);

			for(int j=0; j<list.size(); j++)
			{
				map.put("logID", (String) list.get(j).get("outlookId"));
				map.put("logPW", (String) list.get(j).get("outlookPw"));
				map.put("creatorID", (String) list.get(j).get("creatorId"));
				map.put("serverNm", (String) list.get(j).get("serverNm"));
			}

			if(map.get("logID") ==null && map.get("logPW") == null)
			{
				log.debug("로그인정보없음");
			}
		}
		 */
		return map;
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
	
}