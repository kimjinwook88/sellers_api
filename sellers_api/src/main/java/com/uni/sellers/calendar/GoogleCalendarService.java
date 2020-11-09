package com.uni.sellers.calendar;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.client.util.DateTime;
import com.google.api.client.util.store.FileDataStoreFactory;
import com.google.api.services.calendar.Calendar;
import com.google.api.services.calendar.CalendarScopes;
import com.google.api.services.calendar.model.CalendarList;
import com.google.api.services.calendar.model.CalendarListEntry;
import com.google.api.services.calendar.model.Event;
import com.google.api.services.calendar.model.EventDateTime;
import com.google.api.services.calendar.model.EventReminder;
import com.google.api.services.calendar.model.Events;
import com.uni.sellers.util.CommonUtils;

@Component("googleCalendarService")
public class GoogleCalendarService {
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Value("#{config['path.googleAuth']}")
	private String googleAuthPath;
	
	@Resource(name="calendarDAO")
	private CalendarDAO calendarDAO;
	
	private final String APPLICATION_NAME = "Google Calendar API Java Quickstart";
	private java.io.File DATA_STORE_DIR;
	private FileDataStoreFactory DATA_STORE_FACTORY;
	private final JsonFactory JSON_FACTORY = JacksonFactory.getDefaultInstance();
	private HttpTransport HTTP_TRANSPORT;
	private final List<String> SCOPES = Arrays.asList(CalendarScopes.CALENDAR);
	
	public void setGoogleData(String member_id_num) throws Exception{
		String os = System.getProperty("os.name").toLowerCase();
		HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
		log.info("googleAuthPath ===========" + googleAuthPath);
		log.info("OS ===========" + os);
		if (os.contains("linux")) {  //리눅스 일경우
			DATA_STORE_DIR = new java.io.File(googleAuthPath,".credentials_sellers/calendar-java-quickstart_sellers"+File.separator+member_id_num);
			DATA_STORE_FACTORY = new FileDataStoreFactory(DATA_STORE_DIR);
		}else {
			DATA_STORE_DIR = new java.io.File(System.getProperty("user.home"),".credentials_sellers/calendar-java-quickstart_sellers"+File.separator+member_id_num);
			DATA_STORE_FACTORY = new FileDataStoreFactory(DATA_STORE_DIR);
		}
	}
	
	public Credential authorize(String member_id_num) throws Exception {
		setGoogleData(member_id_num);
		
		InputStream in = GoogleCalendarService.class.getResourceAsStream("/client_secret.json");
		GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(in));

		GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(HTTP_TRANSPORT, JSON_FACTORY,
				clientSecrets, SCOPES).setDataStoreFactory(DATA_STORE_FACTORY).setAccessType("offline").build();
		Credential credential = new AuthorizationCodeInstalledAppCustom(flow, new LocalServerReceiver()).authorize("user");
		//System.out.println("Credentials saved to " + DATA_STORE_DIR.getAbsolutePath());
		return credential;
	}
	
	public Credential newAuthorize(String member_id_num) throws Exception {
		setGoogleData(member_id_num);
		
		//인증 삭제
		File[] files = DATA_STORE_FACTORY.getDataDirectory().listFiles();
		for(File file : files){
			if(file.exists()) {
				file.delete();
			}
		}
		
		DATA_STORE_FACTORY = new FileDataStoreFactory(DATA_STORE_DIR);
		InputStream in = GoogleCalendarService.class.getResourceAsStream("/client_secret.json");
		GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(in));
		
		GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(HTTP_TRANSPORT, JSON_FACTORY,
				clientSecrets, SCOPES).setDataStoreFactory(DATA_STORE_FACTORY).setAccessType("offline").build();
		
		Credential credential = new AuthorizationCodeInstalledApp(flow, new LocalServerReceiver()).authorize("user");
		
		return credential;
	}
	
	public Credential delAuthorize(String member_id_num) throws Exception {
		setGoogleData(member_id_num);
		
		//인증 삭제
		File[] files = DATA_STORE_FACTORY.getDataDirectory().listFiles();
		for(File file : files){
			if(file.exists()) {
				file.delete();
			}
		}
		
		DATA_STORE_FACTORY = new FileDataStoreFactory(DATA_STORE_DIR);
		InputStream in = GoogleCalendarService.class.getResourceAsStream("/client_secret.json");
		GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(in));
		
		GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(HTTP_TRANSPORT, JSON_FACTORY,
				clientSecrets, SCOPES).setDataStoreFactory(DATA_STORE_FACTORY).setAccessType("offline").build();
		
		return flow.loadCredential("user");
	}

	public Calendar getCalendarService(String member_id_num) throws Exception {
		Credential credential = authorize(member_id_num);
		return new Calendar.Builder(HTTP_TRANSPORT, JSON_FACTORY, credential).setApplicationName(APPLICATION_NAME)
				.build();
	}
	
	public Credential getCheckAuthorize(String member_id_num) throws Exception {
		setGoogleData(member_id_num);
		
		if(DATA_STORE_FACTORY != null) {
		InputStream in = GoogleCalendarService.class.getResourceAsStream("/client_secret.json");
		GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(in));

		GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(HTTP_TRANSPORT, JSON_FACTORY,
				clientSecrets, SCOPES).setDataStoreFactory(DATA_STORE_FACTORY).setAccessType("offline").build();
			return flow.loadCredential("user");
		}else {
			return null;
		}
	}
	
	
	/**
	 * 캘린더 - 구글 캘린더 리스트 가져오기
	 * @param list
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> selectGoogleCalendarList(HttpServletRequest request, List<Map<String,Object>> list) throws Exception{
		HttpSession session = request.getSession();
		Map<String, Object> userInfo = (Map<String, Object>) session.getAttribute("userInfo");
		String member_id_num = (String) userInfo.get("MEMBER_ID_NUM");
		String member_name = (String) userInfo.get("HAN_NAME");
		String position_status = (String) userInfo.get("POSITION_STATUS");
		
		com.google.api.services.calendar.Calendar service = this.getCalendarService((String) userInfo.get("MEMBER_ID_NUM"));
		
		// 캘린더 조회
		String pageToken = null;
		Map<String,Object>	gMap = null;
		do {
			CalendarList calendarList = service.calendarList().list().setPageToken(pageToken).execute();
			List<CalendarListEntry> items = calendarList.getItems();
			for (CalendarListEntry calendarListEntry : items) { 
				if(calendarListEntry.getPrimary() !=null && calendarListEntry.getPrimary()) { //마스터 캘린더만
					gMap = new HashMap<String, Object>();
					gMap.put("CALENDAR_NAME", calendarListEntry.getSummary()); //제목
					gMap.put("MEMBER_ID_NUM", member_id_num); //key
					gMap.put("CALENDAR_ID", calendarListEntry.getId());
					gMap.put("MEMBER_NAME", member_name);
					gMap.put("POSITION_STATUS", position_status);
					gMap.put("CALENDAR_TYPE", 3); //google calendar type
					list.add(gMap);
				}
			}
			pageToken = calendarList.getNextPageToken();
		} while (pageToken != null);
		
		return list;
	}
	
	/**
	 * 구글 일정 가져오기
	 * @param calendarEventList
	 * @throws Exception
	 * @author jwkim
	 */
	public Map<String, Object> selectGoogleCalendarEvent(Map<String, Object> map, List<Map<String,Object>> calendarEventList) throws Exception {
		com.google.api.services.calendar.Calendar service = this.getCalendarService(map.get("global_member_id").toString());
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date s = format.parse(map.get("startDate").toString());
		Date e = format.parse(map.get("endDate").toString());
		
		DateTime startDate = new DateTime(s);
		DateTime endDate = new DateTime(e);
		
		List<String> reEventList = new ArrayList<String>();
		List<Map<String, Object>> googleList = new ArrayList<Map<String, Object>>();
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		//google calendar event select
		//일반 일정 add
		String pageToken = null;
		/*do {
			  Events events = service.events().list("primary")
					  .setTimeMin(startDate)
					  .setTimeMax(endDate)
	                  .setSingleEvents(false)
	                  .setPageToken(pageToken)
					  .execute();
			  List<Event> items = events.getItems();
			  for (Event event : items) {
					List<String> kk = event.getRecurrence();
					System.out.println("TT" + kk);
					System.out.println("TT" + event.getRecurringEventId());
//				  if(!CommonUtils.isEmpty(event.getRecurringEventId())){ //반복일정 key add
//					  reEventList.add(event.getRecurringEventId());
//				  }else { //반복일정 아닌것만 
//					  Map<String, Object> googleMap = new HashMap<String, Object>();
//					  Map<String, Object> dateMap = googleDateParser(event);
//					  googleMap.put("title", event.getSummary());
//					  googleMap.put("LOCATION", event.getLocation());
//					  googleMap.put("EVENT_DETAIL", event.getDescription());
//					  googleMap.put("start", dateMap.get("start"));
//					  googleMap.put("end", dateMap.get("end"));
//					  googleMap.put("START_DAY", dateMap.get("start_day"));
//					  googleMap.put("END_DAY", dateMap.get("end_day"));
//					  googleMap.put("START_TIME", dateMap.get("start_time"));
//					  googleMap.put("END_TIME", dateMap.get("end_time"));
//					  googleMap.put("color", event.getColorId());
//					  googleMap.put("allDay", (event.getStart().toString().length() == 21) ? "1" : "0");
//					  googleMap.put("googleId", event.getId());
//					  googleList.add(googleMap);
//				  }
			  }
			  pageToken = events.getNextPageToken();
			} while (pageToken != null);*/
		
		do {
		  Events events = service.events().list("primary")
				  .setTimeMin(startDate)
				  .setTimeMax(endDate)
				  .setOrderBy("startTime")
                  .setSingleEvents(true)
                  .setPageToken(pageToken)
				  .execute();
		  List<Event> items = events.getItems();
		  for (Event event : items) {
			  if(!CommonUtils.isEmpty(event.getRecurringEventId())){ //반복일정 key add
				  reEventList.add(event.getRecurringEventId());
			  }else { //반복일정 아닌것만 
				  Map<String, Object> googleMap = new HashMap<String, Object>();
				  Map<String, Object> dateMap = googleDateParser(event);
				  googleMap.put("title", event.getSummary());
				  googleMap.put("LOCATION", event.getLocation());
				  googleMap.put("EVENT_DETAIL", event.getDescription());
				  googleMap.put("start", dateMap.get("start"));
				  googleMap.put("end", dateMap.get("end"));
				  googleMap.put("START_DAY", dateMap.get("start_day"));
				  googleMap.put("END_DAY", dateMap.get("end_day"));
				  googleMap.put("START_TIME", dateMap.get("start_time"));
				  googleMap.put("END_TIME", dateMap.get("end_time"));
				  googleMap.put("color", event.getColorId());
				  googleMap.put("allDay", (event.getStart().toString().length() == 21) ? "1" : "0");
				  googleMap.put("googleId", event.getId());
				  googleMap.put("googleCalendarId", event.getICalUID());
				  googleList.add(googleMap);
			  }
		  }
		  pageToken = events.getNextPageToken();
		} while (pageToken != null);
		
		//반복일정 add
		List<String> result1 = reEventList.stream().distinct().collect(Collectors.toList()); //중복 제거
		for(String rrId : result1) {
			Events recurringEvents = service.events().instances("primary", rrId)
					  .setTimeMin(startDate)
					  .setTimeMax(endDate)
					  .execute();
			  List<Event> recurringItems = recurringEvents.getItems();
			  for (Event reItem : recurringItems) {
				  Map<String, Object> reGoogleMap = new HashMap<String, Object>();
				  Map<String, Object> reDateMap = googleDateParser(reItem);
				  reGoogleMap.put("title", reItem.getSummary());
				  reGoogleMap.put("LOCATION", reItem.getLocation());
				  reGoogleMap.put("EVENT_DETAIL", reItem.getDescription());
				  reGoogleMap.put("start", reDateMap.get("start"));
				  reGoogleMap.put("end", reDateMap.get("end"));
				  reGoogleMap.put("START_DAY", reDateMap.get("start_day"));
				  reGoogleMap.put("END_DAY", reDateMap.get("end_day"));
				  reGoogleMap.put("START_TIME", reDateMap.get("start_time"));
				  reGoogleMap.put("END_TIME", reDateMap.get("end_time"));
				  reGoogleMap.put("color", reItem.getColorId());
				  reGoogleMap.put("allDay", (reItem.getStart().toString().length() == 21) ? "1" : "0");
				  reGoogleMap.put("googleId", reItem.getId());
				  reGoogleMap.put("googleCalendarId", reItem.getICalUID());
				  googleList.add(reGoogleMap);
			  }
		}
		//googleList = calendarRRuleEventList(googleList, map);
		
		//google과 연동된 데이터는 중복 제거 후 기존 셀러스 events에 put
		for(int i=0; i<calendarEventList.size(); i++) {
			for(int j=0; j<googleList.size(); j++) {
				if(calendarEventList.get(i).get("GOOGLE_ID") == null) { //null일경우 비교 안해
					continue;
				}
				if(calendarEventList.get(i).get("RECURRENCE_RULE") != null) { //반복일정 구글과 셀러스 중복 삭제 위해
					if((googleList.get(j).get("googleId").toString().indexOf(calendarEventList.get(i).get("GOOGLE_ID").toString()) != -1
							&& "0".equals(calendarEventList.get(i).get("allDay").toString())
							&& googleList.get(j).get("START_DAY").toString().equals(calendarEventList.get(i).get("START_DAY").toString())
							&& googleList.get(j).get("END_DAY").toString().equals(calendarEventList.get(i).get("END_DAY").toString())
							&& googleList.get(j).get("START_TIME").toString().equals(calendarEventList.get(i).get("START_TIME").toString())
							&& googleList.get(j).get("END_TIME").toString().equals(calendarEventList.get(i).get("END_TIME").toString()))
						||
						(googleList.get(j).get("googleId").toString().indexOf(calendarEventList.get(i).get("GOOGLE_ID").toString()) != -1
						&& "1".equals(calendarEventList.get(i).get("allDay").toString())
						&& googleList.get(j).get("START_DAY").toString().equals(calendarEventList.get(i).get("START_DAY").toString())
						&& googleList.get(j).get("END_DAY").toString().equals(calendarEventList.get(i).get("END_DAY").toString()))) {
						
						calendarEventList.get(i).put("GOOGLE_ID", googleList.get(j).get("googleId"));
						calendarEventList.get(i).put("GOOGLE_CALENDAR_ID", googleList.get(j).get("googleCalendarId"));
						googleList.remove(j); //구글 리스트에서 삭제
						break;
					}
				}else { //일반일정
					if(googleList.get(j).get("googleId").toString().indexOf(calendarEventList.get(i).get("GOOGLE_ID").toString()) != -1) {
						calendarEventList.get(i).put("GOOGLE_CALENDAR_ID", googleList.get(j).get("googleCalendarId"));
						googleList.remove(j); //구글 리스트에서 삭제
						break;
					}
				}
			}
		}
		
		returnMap.put("googleCalendar", googleList);
		returnMap.put("calendarEventList", calendarEventList);
		
		return returnMap;
	}
	
	/**
	 * 구글 일정 등록
	 * @param eventMap
	 * @throws Exception
	 * @author jwkim
	 */
	public String insertGoogleCalendarEvent(Map<String, Object> eventMap) throws Exception {
			com.google.api.services.calendar.Calendar service = this.getCalendarService(eventMap.get("global_member_id").toString());
			
			//데이터 처리
			String summary = eventMap.get("textModalEventSubject").toString();
			String location = eventMap.get("textModalEventLocation").toString();
			String description = eventMap.get("textareaModalEventDetail").toString();
			SimpleDateFormat sFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
			SimpleDateFormat gFormat  = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX");
			String startDayTime = "";
			String endDayTime = "";
			Date s = null;
			Date e = null;
			//종일
			if(eventMap.get("hiddenModalAllday_YN").equals("Y")) {
				startDayTime = eventMap.get("textModalStartDate").toString();
				endDayTime = eventMap.get("hiddenModalEndDate").toString();
			}else {
				startDayTime = eventMap.get("textModalStartDate").toString()+"T"+eventMap.get("selectModalStartDateTime").toString()+":00";
				endDayTime = eventMap.get("textModalEndDate").toString()+"T"+eventMap.get("selectModalEndDateTime").toString()+":00";
				s = sFormat.parse(startDayTime);
				e = sFormat.parse(endDayTime);
				startDayTime = gFormat.format(s);
				endDayTime = gFormat.format(e);
			}
			int reminder = (eventMap.get("reminderTime") != null) ? (int)eventMap.get("reminderTime") : 0;
			
			//google api
			Event event = new Event()
			    .setSummary(summary)			//제목 
			    .setLocation(location)				//위치
			    .setDescription(description);		//상세내용

			DateTime startDateTime = new DateTime(startDayTime);	//시작시간
			DateTime endDateTime =  new DateTime(endDayTime);	//종료시간
			EventDateTime start = null;
			EventDateTime end  = null;
			if(eventMap.get("hiddenModalAllday_YN").equals("Y")) { //종일은 yyyy-mm-dd
				start = new EventDateTime().setDate(startDateTime).setTimeZone("Asia/Seoul");
				end = new EventDateTime().setDate(endDateTime).setTimeZone("Asia/Seoul");
			}else {
				start = new EventDateTime().setDateTime(startDateTime).setTimeZone("Asia/Seoul");
				end = new EventDateTime().setDateTime(endDateTime).setTimeZone("Asia/Seoul");
			}
			event.setStart(start);
			event.setEnd(end);
			
			//반복
			String rrule = "";
			if(eventMap.get("hiddenModalRepeat_YN").equals("Y")) {
				rrule = eventMap.get("rrule").toString();
				rrule = "RRULE:"+rrule;
				String[] recurrence = new String[] {rrule};
				event.setRecurrence(Arrays.asList(recurrence));
			}
			
			//참석자 인듯?
			/*EventAttendee[] attendees = new EventAttendee[] {
			    new EventAttendee().setEmail("lpage@example.com"),
			    new EventAttendee().setEmail("sbrin@example.com"),
			};
			event.setAttendees(Arrays.asList(attendees));*/
			
			//미리알림
			EventReminder[] reminderOverrides = new EventReminder[] {
			    new EventReminder().setMethod("email").setMinutes(reminder),
			    new EventReminder().setMethod("popup").setMinutes(reminder),
			};
			
			Event.Reminders reminders = new Event.Reminders()
			    .setUseDefault(false)
			    .setOverrides(Arrays.asList(reminderOverrides));
			event.setReminders(reminders);
			
			event = service.events().insert("primary", event).execute();
			
			return event.getId();
	}
	
	/**
	 * 구글 일정 업데이트
	 * @param eventMap
	 * @throws Exception
	 * @author jwkim
	 */
	public void updateGoogleCalendarEvent(Map<String, Object> eventMap) throws Exception {
		com.google.api.services.calendar.Calendar service = this.getCalendarService(eventMap.get("global_member_id").toString());
		Event event = service.events().get("primary", eventMap.get("hiddenModalGoogleId").toString()).execute(); 
		
		if(!CommonUtils.isEmpty(eventMap.get("hiddenModalGoogleId"))) {
			//반복일정 이후 일정 모두 수정일 경우만 예외
			if(eventMap.get("hiddenModalRepeat_YN").equals("Y") && eventMap.get("rruleCase").toString().equals("2")) {
				String rrule = "";
				String[] rruleArray = eventMap.get("rrule").toString().split(";");
				SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd'T'HHmmss");
				SimpleDateFormat sFormat = new SimpleDateFormat("yyyy-MM-dd");
				SimpleDateFormat gFormat  = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
				java.util.Calendar cal = java.util.Calendar.getInstance();
				String startDayTime = "";
				Date s = null;
				event = service.events().get("primary", eventMap.get("hiddenModalGoogleId").toString().split("_")[0]).execute();
				
				if(event != null && !"cancelled".equals(event.getStatus())) { // 구글 유요한 이벤트인지 확인
					//UNTIL 값 생성
					if(eventMap.get("hiddenModalAllday_YN").equals("Y")) { //하루종일
						s = sFormat.parse(eventMap.get("textModalStartDate").toString());
						cal.setTime(s);
						cal.add(java.util.Calendar.DATE,-1);
						startDayTime = format.format(cal.getTime());
					}else {
						s = gFormat.parse(eventMap.get("textModalStartDate").toString()+"T"+eventMap.get("selectModalStartDateTime").toString()+":00");
						cal.setTime(s);
						cal.add(java.util.Calendar.DATE,-1);
						startDayTime = format.format(cal.getTime());
					}
					
					//반복룰 만들기
					for(String rruleSingle : rruleArray) {
						if(rruleSingle.indexOf("COUNT") == -1 &&  rruleSingle.indexOf("UNTIL") == -1){
							rrule += rruleSingle+";"; 
						}
					}
					rrule = "RRULE:"+rrule +"UNTIL="+startDayTime + "Z";
					
					event.setRecurrence(Arrays.asList(new String[] {rrule})); //반복룰만 업데이트
					
					service.events().update("primary", event.getId(), event).execute();
				}
			}else { //나머지 일정
				
				//유요한 일정인지 확인 후
				if(event != null && !"cancelled".equals(event.getStatus())) {
					//데이터 처리
					String rrule = "";
					String summary = eventMap.get("textModalEventSubject").toString();
					String location = eventMap.get("textModalEventLocation").toString();
					String description = eventMap.get("textareaModalEventDetail").toString();
					SimpleDateFormat sFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
					SimpleDateFormat gFormat  = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX");
					String startDayTime = "";
					String endDayTime = "";
					Date s = null;
					Date e = null;
					EventDateTime start = null;
					EventDateTime end  = null;
					
					if(eventMap.get("hiddenModalRepeat_YN").equals("Y")) { 		//반복일정 수정
						if(eventMap.get("rruleCase").toString().equals("1")) {//선택한 일정만 수정
							event = service.events().get("primary", eventMap.get("hiddenModalGoogleId").toString()).execute();
						}else if(eventMap.get("rruleCase").toString().equals("3")) { //이후 일정 모두 수정
							event = service.events().get("primary", eventMap.get("hiddenModalGoogleId").toString().split("_")[0]).execute();
							rrule = eventMap.get("rrule").toString();
							rrule = "RRULE:"+rrule;
						}
						event.setRecurrence(Arrays.asList(new String[] {rrule})); //반복룰
					}
					
					//종일
					if(eventMap.get("hiddenModalAllday_YN").equals("Y")) {
						startDayTime = eventMap.get("textModalStartDate").toString();
						endDayTime = eventMap.get("hiddenModalEndDate").toString();
					}else {
						startDayTime = eventMap.get("textModalStartDate").toString()+"T"+eventMap.get("selectModalStartDateTime").toString()+":00";
						endDayTime = eventMap.get("textModalEndDate").toString()+"T"+eventMap.get("selectModalEndDateTime").toString()+":00";
						s = sFormat.parse(startDayTime);
						e = sFormat.parse(endDayTime);
						startDayTime = gFormat.format(s);
						endDayTime = gFormat.format(e);
					}
					
					DateTime startDateTime = new DateTime(startDayTime);	//시작시간
					DateTime endDateTime =  new DateTime(endDayTime);	//종료시간
					if(eventMap.get("hiddenModalAllday_YN").equals("Y")) { //종일은 yyyy-mm-dd
						start = new EventDateTime().setDate(startDateTime).setTimeZone("Asia/Seoul");
						end = new EventDateTime().setDate(endDateTime).setTimeZone("Asia/Seoul");
					}else {
						start = new EventDateTime().setDateTime(startDateTime).setTimeZone("Asia/Seoul");
						end = new EventDateTime().setDateTime(endDateTime).setTimeZone("Asia/Seoul");
					}
					
					int reminder = (eventMap.get("reminderTime") != null) ? (int)eventMap.get("reminderTime") : 0;
					
					
					// Make a change
					event.setSummary(summary)	//제목 
				    .setLocation(location)				//위치
				    .setDescription(description)		//상세내용
					.setStart(start)							//시작시간
					.setEnd(end);							//종료시간
					
					
					//참석자 인듯?
					/*EventAttendee[] attendees = new EventAttendee[] {
					    new EventAttendee().setEmail("lpage@example.com"),
					    new EventAttendee().setEmail("sbrin@example.com"),
					};
					event.setAttendees(Arrays.asList(attendees));*/
					
					//미리알림
					EventReminder[] reminderOverrides = new EventReminder[] {
					    new EventReminder().setMethod("email").setMinutes(reminder),
					    new EventReminder().setMethod("popup").setMinutes(reminder),
					};
					
					Event.Reminders reminders = new Event.Reminders()
					    .setUseDefault(false)
					    .setOverrides(Arrays.asList(reminderOverrides));
					event.setReminders(reminders);
					
					// Update the event
					Event updateEvent = service.events().update("primary", event.getId(), event).execute();
					eventMap.put("googleEventId", updateEvent.getId().toString().split("_")[0]);
					calendarDAO.upsertGoogleEventId(eventMap);
				}
				
			}
			
		}
	}
	

	/**
	 * 구글 일정 삭제
	 * @param eventMap
	 * @throws Exception
	 * @author jwkim
	 */
	public void deleteGoogleCalendarEvent(Map<String, Object> eventMap) throws Exception {
		com.google.api.services.calendar.Calendar service = this.getCalendarService(eventMap.get("global_member_id").toString());
		if(!CommonUtils.isEmpty(eventMap.get("hiddenModalGoogleId"))) {
			String hiddenModalGoogleId = "";
			Event event = null;
			
			//향후 일정 삭제 - update, 처음일정일 경우에는 전체 삭제
			if(eventMap.get("hiddenModalRepeat_YN").equals("Y") && eventMap.get("rruleCase").toString().equals("2")) {
				eventMap.put("hiddenModalAllday_YN", "Y");
				eventMap.put("rrule", eventMap.get("hiddenModalRruleString"));
				this.updateGoogleCalendarEvent(eventMap);
			}else {
				//반복일정 삭제
				if(eventMap.get("hiddenModalRepeat_YN").equals("Y")) { 		
					if(eventMap.get("rruleCase").toString().equals("1")) {//선택한 일정만 삭제
						hiddenModalGoogleId = eventMap.get("hiddenModalGoogleId").toString();
					}else if(eventMap.get("rruleCase").toString().equals("3")){ //모든 일정 삭제
						hiddenModalGoogleId = eventMap.get("hiddenModalGoogleId").toString().split("_")[0];
					}else { // 향우일정삭제 - 처음일정일 선택일 경우에는 전체 삭제
						hiddenModalGoogleId = eventMap.get("hiddenModalGoogleId").toString().split("_")[0];
					}
				}else { //반복일정 아닌것 삭제
					hiddenModalGoogleId = eventMap.get("hiddenModalGoogleId").toString().split("_")[0];
				}
				
				event = service.events().get("primary", hiddenModalGoogleId).execute();
				
				if(event != null && !"cancelled".equals(event.getStatus())) {
					event.setStatus("cancelled");
					service.events().update("primary", event.getId(), event).execute();
				}
			}
		}
	}
	
	
	/**google calendar date parser
	 * @param event
	 * @return map
	 */
	public Map<String, Object> googleDateParser(Event event) {
		  DateFormat hhMm = new SimpleDateFormat("HH:mm");
	      DateFormat yyyyMMdd = new SimpleDateFormat("yyyMMdd");
	      Map<String, Object> map = new HashMap<String, Object>();
		//하루종일
		if(event.getStart().toString().length() == 21) { //yyyy-mm-dd length
			map.put("start", event.getStart().getDate().getValue());
			map.put("end", event.getEnd().getDate().getValue());
			map.put("start_day", yyyyMMdd.format(event.getStart().getDate().getValue()));
			map.put("end_day", yyyyMMdd.format(event.getEnd().getDate().getValue()));
			map.put("start_time", hhMm.format(event.getStart().getDate().getValue()));
			map.put("end_time", hhMm.format(event.getEnd().getDate().getValue()));
		}else { //하루종일 아닌거~
		    map.put("start", event.getStart().getDateTime().getValue());
		    map.put("end", event.getEnd().getDateTime().getValue());
		    map.put("start_day", yyyyMMdd.format(event.getStart().getDateTime().getValue()));
		    map.put("end_day", yyyyMMdd.format(event.getEnd().getDateTime().getValue()));
		    map.put("start_time", hhMm.format(event.getStart().getDateTime().getValue()));
		    map.put("end_time", hhMm.format(event.getEnd().getDateTime().getValue()));
		}
		return map;
	}
	
	public String getLocalServerIp()
	{
		try
		{
		    for (Enumeration<NetworkInterface> en = NetworkInterface.getNetworkInterfaces(); en.hasMoreElements();)
		    {
		        NetworkInterface intf = en.nextElement();
		        for (Enumeration<InetAddress> enumIpAddr = intf.getInetAddresses(); enumIpAddr.hasMoreElements();)
		        {
		            InetAddress inetAddress = enumIpAddr.nextElement();
		            if (!inetAddress.isLoopbackAddress() && !inetAddress.isLinkLocalAddress() && inetAddress.isSiteLocalAddress())
		            {
		            	return inetAddress.getHostAddress().toString();
		            }
		        }
		    }
		}
		catch (SocketException ex) {}
		return null;
	}
			
	public static void main(String[] args) throws Exception {
//		GoogleCalendarService gc = new GoogleCalendarService();
//		com.google.api.services.calendar.Calendar service = gc.getCalendarService();
//		//google api
//		Event event = service.events().get("primary", "bb0h0v30e4evhsv4qsnjjus6hk").execute();
//		
//		String[] recurrence = new String[] {"RRULE:FREQ=WEEKLY;INTERVAL=1;BYDAY=WE;UNTIL=20191119T000000Z"};
//		
//		event.setRecurrence(Arrays.asList(recurrence));
//		
//		Event updateEvent = service.events().update("primary", event.getId(), event).execute();
//		System.out.println("==test==1");
//		// Retrieve the event from the API
//		
//		Event e = new Event();
//		e.setSummary("제목")			//제목 
//	    .setLocation("위치")				//위치
//	    .setDescription("상세내용");		//상세내용
//		DateTime startDateTime = new DateTime("2019-11-20");	//시작시간
//		DateTime endDateTime =  new DateTime("2019-11-21");	//종료시간
//		EventDateTime start = null;
//		EventDateTime end  = null;
//		start = new EventDateTime().setDate(startDateTime).setTimeZone("Asia/Seoul");
//		end = new EventDateTime().setDate(endDateTime).setTimeZone("Asia/Seoul");
//		e.setRecurringEventId("bb0h0v30e4evhsv4qsnjjus6hk");
//		e.setStart(start);
//		e.setEnd(end);
//		
//		String[] recurrence2 = new String[] {"RRULE:FREQ=WEEKLY;INTERVAL=1;BYDAY=WE;UNTIL=20191130T000000Z"};
//		e.setRecurrence(Arrays.asList(recurrence2));
////		
//		String calendarId = "primary";
//		e = service.events().insert(calendarId, e).execute();
//		System.out.println("==test==2");
		
	}
	
	
}
