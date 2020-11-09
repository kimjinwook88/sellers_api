package com.uni.sellers.calendar;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mobile.device.Device;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.google.api.client.auth.oauth2.Credential;
import com.uni.sellers.datasource.CommandMap;
import com.uni.sellers.salesmanagement.SalesManagementService;

@Controller
@SessionAttributes({"userInfo","applicationCompanyGroup","auth"})
public class CalendarController {
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name="CalendarService")
	private CalendarService calendarService;
	
	@Resource(name="calendarDAO")
	private CalendarDAO calendarDAO;

	@Resource(name="salesManagementService")
	private SalesManagementService salesManagementService;
	
//	@Resource(name="googleCalendarService")
//	private GoogleCalendarService googleCalendarService;
	
	private Credential credential;
	
	//Calendar 페이지 start
	@RequestMapping(value="/calendar/viewCalendar.do")
	public ModelAndView openCalendarList(HttpServletRequest request, CommandMap map,HttpSession session, Device device) throws Exception{

		ModelAndView mv = new ModelAndView("/calendar/calendarView");
		
		if (device.isMobile()) {
			log.info("************************************* 접속 기기 : Mobile");
			
			List<Map<String,Object>> calendarList = calendarService.getCalendarList(request, (Map<String, Object>) session.getAttribute("userInfo"));
			mv.addObject("calendarList", calendarList);
			
			mv.addObject("notice_event_id", map.get("notice_event_id"));
			
			//날짜 확인 (YYYYMMDD)
			Calendar c = Calendar.getInstance();
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
			String curDate = "";
			
			if (map.get("curDate") != null){
				//입력된 날짜가 있으면 거기에 맞춤
				curDate = map.get("curDate").toString();
			} else {
				//세션에도 없으면 오늘날짜 가져옴
				curDate = transFormat.format(c.getTime());
			}
			
			//현재날짜
			Date cd = transFormat.parse(curDate);
			c.setTime(cd);
			mv.addObject("cYear", c.get(Calendar.YEAR));
			mv.addObject("cMonth", c.get(Calendar.MONTH) + 1);
			mv.addObject("cDay", c.get(Calendar.DAY_OF_MONTH));
			
			mv.addObject("startRange", curDate+"000000");
			mv.addObject("endRange", curDate+"235959");
			
			//이전날짜
			Calendar cPrev = Calendar.getInstance();
			cPrev.setTime(cd);
			cPrev.add(Calendar.MONTH, -1);
			mv.addObject("prevMonth", transFormat.format(cPrev.getTime()));
			
			//다음날짜
			Calendar cNext = Calendar.getInstance();
			cNext.setTime(cd);
			cNext.add(Calendar.MONTH, 1);
			mv.addObject("nextMonth", transFormat.format(cNext.getTime()));
			
			log.info("************************************* mv[" + mv.getViewName() + "]");
		}
		else {
			List<Map<String,Object>> calendarList = calendarService.getCalendarList(request, (Map<String, Object>) session.getAttribute("userInfo"));
			mv.addObject("calendarList", calendarList);
		}
		return mv;
	}
	
	@RequestMapping(value="/calendar/calendarOfColleagueView.do")
	public ModelAndView openShareCalendarList(HttpServletRequest request, CommandMap map,HttpSession session) throws Exception{

		ModelAndView mv = new ModelAndView("/calendar/calendarOfColleagueView");
		
		List<Map<String,Object>> calendarList = calendarService.getCalendarList(request, map.getMap());
		mv.addObject("calendarList", calendarList);	
		return mv;
	}

	//Calendar 생성
	@RequestMapping(value="/calendar/addCalendar.do")
	public ModelAndView insertCalendar(HttpServletRequest request, CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = calendarService.addCalendar(request, map.getMap());
		mv.addObject("cnt",cnt);
		return mv;
	}

	//Calendar 삭제
	@RequestMapping(value="/calendar/deleteCalendar.do")
	public ModelAndView deleteCalendar(HttpServletRequest request, CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int cnt = calendarService.deleteCalendar(request, map.getMap());
		mv.addObject("cnt",cnt);
		return mv;
	}

	//Calendar Name 수정
	@RequestMapping(value="/calendar/reNameCalendar.do")
	public ModelAndView reNameCalendar(HttpServletRequest request, CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = calendarService.reNameCalendar(request, map.getMap());
		mv.addObject("cnt",cnt);
		return mv;
	}

	//ICS파일 다운
	@RequestMapping(value="/calendar/downICS.do")
	public ModelAndView downICS(HttpServletRequest request, CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		Map<String, Object> filePath = calendarService.downICS(request, map.getMap());
		//		CalendarService.updateICSdir(map.getMap());
		//mv.addObject("cnt",cnt);
		return mv;
	}

	//Event 추가.
	@RequestMapping(value="/calendar/insertCalendarEvent.do")
	public ModelAndView insertCalendarEvent(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = calendarService.insertCalendarEvent(map.getMap(), request);
		mv.addObject("cnt", cnt);
		mv.addObject("map", map.getMap());
		return mv;
	}

	//Event 수정
	@RequestMapping(value="/calendar/updateCalendarEvent.do")
	public ModelAndView updateCalendarEvent(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		int cnt = calendarService.updateCalendarEvent(map.getMap(), request);
		mv.addObject("cnt", cnt);
		mv.addObject("map", map.getMap());
		return mv;
	}

	//Event 삭제
	@RequestMapping(value="/calendar/deleteCalendarEvent.do")
	public ModelAndView deleteCalendarEvent(CommandMap map, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = calendarService.deleteCalendarEvent(map.getMap(), request);
		mv.addObject("cnt" , cnt);
		return mv;
	}

	//Event 조회
	@RequestMapping(value="/calendar/calendarEventList.do")
	public ModelAndView calendarEventList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}

		List<Map<String,Object>> calendarEventList = calendarService.calendarEventList(map.getMap());
		mv.addObject("events", calendarEventList);

		List<Map<String,Object>> holidayEventList = calendarService.holidayEventList(map.getMap());
		mv.addObject("holidays", holidayEventList);


		//google ICS 파일 정보 읽어온다.
//		if(map.get("google").equals("google")){
//			List<Map<String,Object>> googleIcsData = calendarService.googleIcsEventList(map.getMap());
//			mv.addObject("googleIcsData", googleIcsData);
//		}
		
//		if(map.get("google").equals("google")){
//			Map<String,Object> returnMap= googleCalendarService.selectGoogleCalendarEvent(map.getMap(), calendarEventList);
//			mv.addObject("googleCalendar", returnMap.get("googleCalendar"));
//			mv.addObject("events", returnMap.get("calendarEventList"));
//		}

		if(map.get("outlook").equals("outlook")) {
			//outlookCalendar 로그인 정보파일에서 ID/PW 읽고 접속시도 후 일정 Get
			List<Map<String,Object>> outlookCalList = calendarService.outlookCalendar(map.getMap());
			mv.addObject("outlookCalList", outlookCalList);
		}
		
		if(map.get("office365").equals("office365")) {
			//office365Calendar 로그인 정보파일에서 ID/PW 읽고 접속시도 후 일정 Get
			List<Map<String,Object>> office365Calendar = calendarService.office365Calendar(map.getMap());
			mv.addObject("office365Calendar", office365Calendar);
		}
		
//		List<Map<String,Object>> shareCalendarList = CalendarService.shareCalendarList(map.getMap());
//		mv.addObject("shareCalendarEventList", shareCalendarList);
		

		return mv;
	}

	@RequestMapping(value="/calendar/calendarSharedUserEventList.do")
	public ModelAndView calendarSharedUserEventList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}

		List<Map<String,Object>> calendarEventList = calendarService.calendarEventList(map.getMap());
		mv.addObject("events", calendarEventList);

		List<Map<String,Object>> holidayEventList = calendarService.holidayEventList(map.getMap());
		mv.addObject("holidays", holidayEventList);
		
		List<Map<String,Object>> office365Calendar = calendarService.office365Calendar(map.getMap());
		mv.addObject("office365Calendar", office365Calendar);

		return mv;
	}
	/*
	@RequestMapping(value="/calendar/makeICS.do")
	public ModelAndView sellersIcsEventList(HttpServletRequest request, CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/calendar/calendar");
		CalendarService.sellersIcsEventList(map.getMap());

		return mv;
	}
	 */
	// 아웃룩 개인정보 저장
	@RequestMapping(value="/calendar/outlookCalendar.do")
	public ModelAndView outlookCalendar(HttpServletRequest request, CommandMap map) throws Exception{
//		ModelAndView mv = new ModelAndView("/calendar/calendarView");
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}

		calendarService.outlookCalendarUsrInfoSave(map.getMap());

		return mv;
	}

	// 일정초대 
	@RequestMapping(value="/calendar/calendarEventConviteResult.do")
	public ModelAndView calendarEventConviteResult(HttpServletRequest request, CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/calendar/calendarEventConviteResult");
		Map<String, Object> eventMap = new HashMap<String, Object>();

		//일정 초대 받은 사람에게 수락여부 받았다는 FLAG
		map.put("invitedFlag", "Y");

		//status : 0 -> 수락,  1-> 거절,  2-> 모달 업데이트
		if(map.get("status").equals("0")) 
		{
			//수락

			//			jFrame
			//			CommonMailEventGui cmeg = new CommonMailEventGui();
			//			cmeg.calendarEventGui();

			//초대받은자 캘린더 있는지 파악후, 없으면 캘린더 생성
			Map<String, Object> uicm = calendarService.updateInvitedCalendarMaster(map.getMap());
			map.put("inviteCalId", uicm.get("CALENDAR_ID"));

			//수락 'Y'업데이트
			map.put("status", "Y");
			calendarService.updateCalendarInviteEvent(map.getMap());


			//초대 even Select (초대받은 일정 가져오기)
			eventMap = calendarService.selectCalendarEvent(map.getMap(), request);
			eventMap.put("status", map.get("status"));


			//최초 초대 보낸 사람한테 알림창으로 초대여부를 알림.
			calendarService.insertNoticeInvitedYN(map.getMap());
		}
		else 
		{

			//거절 'N" 업데이트
			map.put("status", "N");
			calendarService.updateCalendarInviteEvent(map.getMap());

			//거절
			eventMap = calendarService.selectCalendarEvent(map.getMap(), request);
			eventMap.put("status", map.get("status"));

			//최초 초대 보낸 사람한테 알림창으로 초대여부를 알림.
			calendarService.insertNoticeInvitedYN(map.getMap());
		}

		mv.addObject("eventMap", eventMap);
		return mv;
	}

	//일정초대자 리스트
	@RequestMapping(value="/calendar/getInviteMemberList.do")
	public ModelAndView getInviteMemberList(HttpServletRequest request, CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String,Object>> InviteMemberList = calendarService.getInviteMemberList(request, map.getMap());
		mv.addObject("InviteMemberList", InviteMemberList);
		return mv;
	}

	/*
	//외부캘린더 공유
	@RequestMapping(value="/calendar/outCalendarSync.do")
	public ModelAndView outCalendarSync(HttpServletRequest request, CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		String syncYN = "";
		if(map.get("syncYN").equals("Y")) {
			map.put("syncYN", "N");
			CalendarService.changeOutCalendarSync(map.getMap());
			syncYN = "N";
		}else {
			map.put("syncYN", "Y");
			CalendarService.changeOutCalendarSync(map.getMap());
			syncYN = "Y";
		}
		mv.addObject("syncYN", syncYN);
		return mv;
	}
	 */

	//내부캘린더 공유 insert
	@RequestMapping(value="/calendar/insertShareCalendar.do")
	public ModelAndView insertShareCalendar(HttpServletRequest request, CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = calendarService.insertShareCalendar(map.getMap());
		mv.addObject("cnt",cnt);
		return mv;
	}

	@RequestMapping(value="/calendar/selectShareCalendar.do")
	public ModelAndView selectShareCalendar(HttpServletRequest request, CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}

		List<Map<String,Object>> selectShareCalendar = calendarService.selectShareCalendar(map.getMap());
		mv.addObject("selectShareCalendar", selectShareCalendar);

		return mv;
	}

	//나의 캘린더 공유 동료 리스트 삭제
	@RequestMapping(value="/calendar/deleteShareMember.do")
	public ModelAndView deleteShareMember(HttpServletRequest request, CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = calendarService.deleteShareMember(request, map.getMap());
		mv.addObject("cnt",cnt);
		return mv;
	}

	//일정 초대자 리스트 삭제
	@RequestMapping(value="/calendar/deleteInviteMemberList.do")
	public ModelAndView deleteInviteMemberList(HttpServletRequest request, CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		int cnt = calendarService.deleteInviteMemberList(request, map.getMap());
		mv.addObject("cnt",cnt);
		return mv;
	}

	/**
	 * 나의(영업대표) 생산성 년도, 월, 분기 데이터 가져오기
	 * @param request
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/calendar/myProductivity.do")
	public ModelAndView myProductivity(HttpServletRequest request, CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/salesManagement/productivityIndividual");
		mv.addObject("hiddenUserId", map.get("hiddenUserId"));

		Map<String,Object> searchDetailGroup = calendarService.myProductivity(map.getMap());
		mv.addObject("searchDetailGroup", searchDetailGroup);
		mv.addObject("selectFaceYear",map.get("selectFaceYear"));
		mv.addObject("selectFaceMonth",map.get("selectFaceMonth"));
		mv.addObject("selectFaceQuarter",map.get("selectFaceQuarter"));
		mv.addObject("selectFacePost",map.get("selectFacePost"));
		mv.addObject("viewType",map.get("viewType"));

		return mv;
	}

	/**
	 * 알림 - 일정 상세보기 내용 가져오기.
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/calendar/selectEventDetail.do")
	public ModelAndView selectEventDetail(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		if(map.get("datatype").equals("html")){
			log.info((String) map.get("jsp"));
			mv.setViewName((String) map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		Map<String,Object> selectEventDetail= calendarService.selectEventDetail(map.getMap());
		mv.addObject("detail", selectEventDetail);
		return mv;
	}

	@RequestMapping(value="/calendar/listRruleCheckDate.do")
	public ModelAndView listRruleCheckDate(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		List<Map<String,Object>> listRruleCheckDate= calendarService.listRruleCheckDate(map.getMap());
		mv.addObject("rows", listRruleCheckDate);
		return mv;
	}
	
	@RequestMapping(value="/calendar/calendarEventListMobile.do")
	public ModelAndView calendarEventListMobile(HttpServletRequest request, CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
//		if(map.get("datatype").equals("html")){
//			log.info((String)map.get("jsp"));
//			mv.setViewName((String)map.get("jsp"));
//		}else{
//			mv.setViewName("jsonView");
//		}
		
		mv.setViewName("jsonView");

		List<Map<String,Object>> calendarEventList = null;
		
		if(map.get("event_id_pos") != null && map.get("event_id_pos").equals("Y")) {
			calendarEventList = calendarService.calendarEventListMobile(request, map.getMap());
		}
		else {
			calendarEventList = calendarService.calendarEventList(map.getMap());
		}
		
		mv.addObject("events", calendarEventList);
		
//		List<Map<String,Object>> holidayEventList = calendarService.holidayEventList(request, map.getMap());
//		mv.addObject("holidays", holidayEventList);
//
//
//		//google ICS 파일 정보 읽어온다.
//		if(map.get("google").equals("google")){
//			List<Map<String,Object>> googleIcsData = calendarService.googleIcsEventList(map.getMap());
//			mv.addObject("googleIcsData", googleIcsData);
//		}
//
//		if(map.get("outlook").equals("outlook")) {
//			//outlookCalendar 로그인 정보파일에서 ID/PW 읽고 접속시도 후 일정 Get
//			List<Map<String,Object>> outlookCalList = calendarService.outlookCalendar(map.getMap());
//			mv.addObject("outlookCalList", outlookCalList);
//		}
//		
//		if(map.get("office365").equals("office365")) {
//			//office365Calendar 로그인 정보파일에서 ID/PW 읽고 접속시도 후 일정 Get
//			List<Map<String,Object>> office365Calendar = calendarService.office365Calendar(map.getMap());
//			mv.addObject("office365Calendar", office365Calendar);
//		}
		/*
		List<Map<String,Object>> shareCalendarList = CalendarService.shareCalendarList(map.getMap());
		mv.addObject("shareCalendarEventList", shareCalendarList);
		 */

		return mv;
	}
	
	@RequestMapping(value="/calendar/modalCalendarForm.do")
	public ModelAndView modalCalendarForm(HttpServletRequest request, CommandMap map, HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView("/calendar/modalCalendarForm");
		
		List<Map<String,Object>> calendarList = calendarService.getCalendarList(request, (Map<String, Object>) session.getAttribute("userInfo"));
		mv.addObject("calendarList", calendarList);
		
		String mode = "";
		if (map.get("mode") != null){
			mode = map.get("mode").toString();
		}
		if (mode.equals("M")){
			mv.addObject("mode", "M");
			
			//조회 + 수정
			String eventId = map.get("eventId").toString();
			map.put("hiddenModalEventId", eventId);
			//초대 정보 가져오기
			map.put("is_mobile", "Y"); //모바일 지정
			mv.addObject("detail", this.calendarService.selectCalendarEvent(map.getMap(), request));
			
//			if(map.get("eventId") != null && !map.get("eventId").equals("")) {
//				map.put("event_id_list", map.get("eventId"));
//				
//				List<Map<String,Object>> calendarEventList = calendarService.calendarEventListMobile(request, map.getMap());
//				mv.addObject("events", calendarEventList);
//			}
			
		} else {
			mv.addObject("mode", "I");
			
			//신규입력

			//날짜 확인 (YYYYMMDD)
			Calendar c = Calendar.getInstance();
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
			String curDate = "";
			if (map.get("curDate") != null && !map.get("curDate").equals("")){
				//입력된 날짜가 있으면 거기에 맞춤
				curDate = map.get("curDate").toString();
			} else {
				//세션에도 없으면 오늘날짜 가져옴
				curDate = transFormat.format(c.getTime());
			}
			
			curDate = curDate.substring(0, 4) + '-' + curDate.substring(4, 6) + '-' + curDate.substring(6, 8);
			mv.addObject("curDate", curDate);
		}
		
		return mv;
	}
	
	@RequestMapping(value="/calendar/calendar.do")
	public ModelAndView openCalendarList(HttpServletRequest request, CommandMap map,HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView("/calendar/calendar");
		List<Map<String,Object>> calendarList = calendarService.getCalendarList(request, (Map<String, Object>) session.getAttribute("userInfo"));
		
		//날짜 확인 (YYYYMMDD)
		Calendar c = Calendar.getInstance();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
		String curDate = "";
		if (map.get("curDate") != null && !map.get("curDate").equals("")){
			//입력된 날짜가 있으면 거기에 맞춤
			curDate = map.get("curDate").toString();
			session.setAttribute("curDate", curDate);
		} else if (session.getAttribute("curDate") != null){
			//입력된 날짜가 없으면 세션에서 불러옴
			curDate = session.getAttribute("curDate").toString();
		} else {
			//세션에도 없으면 오늘날짜 가져옴
			curDate = transFormat.format(c.getTime());
			session.setAttribute("curDate", curDate);
		}
		
		//현재날짜
		Date cd = transFormat.parse(curDate);
		c.setTime(cd);
		mv.addObject("cYear", c.get(Calendar.YEAR));
		mv.addObject("cMonth", c.get(Calendar.MONTH) + 1);
		mv.addObject("cDay", c.get(Calendar.DAY_OF_MONTH));
		
		mv.addObject("startRange", curDate+"000000");
		mv.addObject("endRange", curDate+"235959");
		
		//이전날짜
		Calendar cPrev = Calendar.getInstance();
		cPrev.setTime(cd);
		cPrev.add(Calendar.DATE, -1);
		mv.addObject("prevDate", transFormat.format(cPrev.getTime()));
		
		//다음날짜
		Calendar cNext = Calendar.getInstance();
		cNext.setTime(cd);
		cNext.add(Calendar.DATE, 1);
		mv.addObject("nextDate", transFormat.format(cNext.getTime()));
		
		mv.addObject("calendarList", calendarList);
		return mv;
	}
	
	@RequestMapping(value="/calendar/calendarEvent.do")
	public ModelAndView openCalendarEventList(HttpServletRequest request, CommandMap map,HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView("/calendar/calendarEvent");

		List<Map<String,Object>> calendarList = calendarService.getCalendarList(request, (Map<String, Object>) session.getAttribute("userInfo"));
		mv.addObject("calendarList", calendarList);
		
		//날짜 확인 (YYYYMMDD)
		Calendar c = Calendar.getInstance();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
		String curDate = "";
		curDate = transFormat.format(c.getTime());
		
		mv.addObject("curDate", curDate);
		
		return mv;
	}
	
	
	
	
	/* ======================== OAuth인증 Google API TEST ===================== */
	
	/**
	 * 캘린더 - 구글 OAuth 인증
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/calendar/insertGoogleOAuthKey.do")
	public ModelAndView insertGoogleOAuthKey(HttpServletRequest request, CommandMap map, HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		/*Credential credential;
		if("2".equals(map.getMap().get("category"))){ //다른 아이디로 연동
			credential = null;
		}*/
//		Credential credential = GoogleCalendarService.authorize();
//		request.getSession().setAttribute("gcToken", credential.getAccessToken());
		return mv;
	}
	
	
	/**
	 * 캘린더 - 구글 OAuth 인증
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/calendar/googleOAuth.do")
	public ModelAndView googleOAuth(HttpServletRequest request, CommandMap map, HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		String category = map.getMap().get("category").toString();
		String token = null;
		
//		if("1".equals(category)) { //인증하기
//			credential = googleCalendarService.authorize(map.getMap().get("global_member_id").toString());
//			token = credential.getAccessToken();
//		}else if("2".equals(category)){ //다른 아이디로 연동
//			credential = googleCalendarService.newAuthorize(map.getMap().get("global_member_id").toString());
//			token = credential.getAccessToken();
//		}else if("3".equals(category)){ //인증 삭제
//			credential = googleCalendarService.delAuthorize(map.getMap().get("global_member_id").toString());
//			token = null;
//		}else {
//			log.info("error : 구글 인증 확인 필요");
//		}
		request.getSession().setAttribute("gcToken", token);
		
		return mv;
	}
	
	
	
	/**
	 * 캘린더 - 구글 캘린더 리스트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/calendar/getGoogleCalendarList.do")
	public ModelAndView getGoogleCalendarList(HttpServletRequest request, CommandMap map, HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView("/calendar/calendarEvent");
		
		//List<Map<String,Object>> list = calendarService.getGoogleCalendarList(request, map.getMap());
		
         return mv;
 	}
	
	
}
