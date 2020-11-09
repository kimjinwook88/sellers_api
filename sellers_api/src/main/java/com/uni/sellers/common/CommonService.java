package com.uni.sellers.common;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mobile.device.Device;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.uni.sellers.calendar.CalendarDAO;
import com.uni.sellers.calendar.CalendarService;
import com.uni.sellers.datasource.CommandMap;
import com.uni.sellers.tracking.TrackingDAO;
import com.uni.sellers.tracking.TrackingService;
import com.uni.sellers.util.CommonDateUtils;
import com.uni.sellers.util.CommonFileUtils;
import com.uni.sellers.util.CommonUtils;

@Service("commonService")
public class CommonService{
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Resource(name="commonFileUtils")
	private CommonFileUtils commonFileUtils;
	
	@Resource(name="commonDAO")
	private CommonDAO commonDAO;
	
	@Resource(name="commonMailService")
	private CommonMailService commonMailService;
	
	@Resource(name="CalendarService")
	private CalendarService CalendarService;

	@Resource(name="calendarDAO")
	private CalendarDAO calendarDAO;

	@Resource(name="trackingService")
	private TrackingService trackingService;
	
	@Resource(name="trackingDAO")
	private TrackingDAO trackingDAO;
	
	@Value("#{config['flag.trackingSendMail']}")
	private String trackingSendMail;
	@Value("#{config['flag.trackingSendMailName']}")
	private String trackingSendMailName;
	
	@Value("#{config['flag.sendCoachingTalkMail']}")
	private String sendCoachingTalkMail;
	
	@Value("#{config['flag.sendCoachingTalkNotice']}")
	private String sendCoachingTalkNotice;
	
	@Value("#{config['flag.sendCoachingTalkMobile']}")
	private String sendCoachingTalkMobile;

	public Map<String, Object> loginProccess(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) commonDAO.selectLoginProccess(map);
	}


	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		map.put("fileTableName", findFileTable(map));
		return (Map<String, Object>) commonDAO.selectFileInfo(map);
	}


	public int insertFile(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return (int) commonDAO.insertFile(map);
	}


	public int deleteFile(Map<String, Object> map, HttpServletRequest request) throws Exception {
		Map<String, Object> fileInfo = selectFileInfo(map);
		int cnt = commonDAO.deleteFile(map);
		commonFileUtils.deleteFile(fileInfo,request);
		return cnt;
	}


	public String findFileTable(Map<String, Object> map) throws Exception {
		String fileTableName = "";
		switch ((String)map.get("fileTableName")) {
		case "1":
			fileTableName = "BIZ_FILE_STORE";
			break;
		case "2":
			fileTableName = "BIZ_PROJECT_PLAN_FILE_STORE";
			break;			
		case "3":
			fileTableName = "CLIENT_EVENT_FILE_STORE";
			break;			
		case "4":
			fileTableName = "CLIENT_ISSUE_FILE_STORE";
			break;
		case "5":
			fileTableName = "CLIENT_SAT_FILE_STORE";
			break;
		case "6":
			fileTableName = "OPPORTUNITY_FILE_STORE";
			break;
		case "7":
			fileTableName = "PARTNER_ENABLE_FILE_STORE";
			break;
		case "8":
			fileTableName = "PROPOSAL_FILE_STORE";
			break;
		case "9":
			fileTableName = "PROJECT_MGMT_FILE_STORE";
			break;
		case "10":
			fileTableName = "PARTNER_CRB_FILE_STORE";
			break;
		case "11":
			fileTableName = "PARTNER_SALES_LINAKGE_FILE_STORE";
			break;
		case "12":
			fileTableName = "CLIENT_COMPANY_INFO_FILE_STORE";
			break;
		case "15":
			fileTableName = "PARTNER_COMPANY_INFO_FILE_STORE";
			break;
		}
		return fileTableName; 
	}


	public List<Map<String, Object>> searchCompanyInfo(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return commonDAO.searchCompanyInfo(map);
	}


	public List<Map<String, Object>> searchPartnerInfo(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return commonDAO.searchPartnerInfo(map);
	}


	public List<Map<String, Object>> searchPartnerMemberInfo(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return commonDAO.searchPartnerMemberInfo(map);
	}


	public List<Map<String, Object>> searchInviteMemberInfo(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub

		List<Map<String, Object>> list = commonDAO.searchInviteMemberInfo(map);
		//		return commonDAO.searchPartnerInfo(map);
		return list;
	}


	public List<Map<String, Object>> selectPartnerInfo(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return commonDAO.selectPartnerInfo(map);
	}




	public int selectNoticeCount(Map<String, Object> map) throws Exception {



		return commonDAO.selectNoticeCount(map);
	}




	public int selectCalendarAlarmInfo(Map<String, Object> map) throws Exception {

		/**
		 * 캘린더 일정 미리알림 관련 시간정보 가져오기
		 */
		int cnt =0;

		List<Map<String, Object>> eventList = commonDAO.selectCalendarAlarmInfo(map);

		for(int i=0; i<eventList.size(); i++)
		{
			//			if(eventList.get(i).get("ALARM_PERIOD") !=null){
			if(eventList.get(i).get("ALARM_FLAG") != null && !eventList.get(i).get("ALARM_FLAG").equals("N") )
			{
				/**
				 * ALARM_FLAG 
				 * H: 1시간전
				 * D: 하루전
				 * W: 일주일전
				 * 
				 * 분기할 필요 없이, 날짜/시간 전체를 비교하기때문에 한로직으로 가능
				 */

				//현재시간
				String todayDateTime = CommonDateUtils.getTodayDateTime();

				//일정시작시간
				Date scheduleStart = (Date) eventList.get(i).get("START_DATETIME");
				String scheduleStartTime = CommonDateUtils.dateToString2(scheduleStart);

				/*
				//일정시작시간 1시간전
				//String beforeStartTime = CommonDateUtils.getDateBeforeTimeMinute(scheduleStartTime, 60); // 1시간 전
				 */

				//DB 알림시간
				Date alarmTime = (Date) eventList.get(i).get("ALARM_PERIOD");
				String alarmStr = CommonDateUtils.dateToString2(alarmTime);

				log.debug("오늘 시간 : " + todayDateTime);
				log.debug("알람 시간 : " + alarmStr);
				log.debug("일정시작 시간 : " + scheduleStartTime);

				//알람 미리 알림 시간(오후12시)이 현재 시간(오후12시)보다 같거나, || 현재시간(오후12시)가 알람 미리 알림시간(오후11시59분)보다 크면서, &&  일정시간(오후2시 미팅)이 현재 시간(오후1시)보다 클경우
				if( (alarmStr.compareTo(todayDateTime) == 0 || todayDateTime.compareTo(alarmStr) > 0) && scheduleStartTime.compareTo(todayDateTime) > 0)
				{
					String noticeDetail  = scheduleStartTime+" 에 일정 '" + eventList.get(i).get("EVENT_SUBJECT") +"'가 있습니다.";
					//알림
					map.put("memberID", eventList.get(i).get("MEMBER_ID_NUM"));
					map.put("noticeDetail", noticeDetail);
					map.put("noticeCategory", "일정알림");
					map.put("NOTICE_CODE", eventList.get(i).get("EVENT_CODE"));
					map.put("event_id", eventList.get(i).get("EVENT_ID"));

					int a = commonDAO.updateNotice(map);
					if(a<1)
					{
						commonDAO.insertShareCalendarNotice(map);
					}
				}
				else 
				{
					//알림 안함
					log.debug("noAlarm");
				}
			}
		}

		return cnt;
	}



	public int updatePassword(Map<String, Object> map) throws Exception {

		/**
		 * returnStatus : 
		 * 0-> 패스워드 변경 성공, 
		 * 9-> 기존 패스워드 불일치, 
		 * 8-> 새 패스워드 불일치,
		 * 7-> DB update 실패
		 */

		int returnStatus = 0;

		String currentPw 		= (String) map.get("currentPassword");
		String changePw 		= (String) map.get("changePassword");
		String changePwConfirm 	= (String) map.get("changePasswordConfirm");

		Map<String, Object> userInfo = new HashMap<String, Object>();

		map.put("member_id_num", map.get("global_member_id"));
		//map.put("company_cd", map.get("global_company_cd"));
		try {
			//암호화된 패스워드 가져오기
			userInfo = commonDAO.selectLoginProccess(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if(userInfo != null && bcryptPasswordEncoder.matches((CharSequence) currentPw, (String) userInfo.get("PASSWORD_ENC"))){
			log.debug("현재 비밀번호 일치");

			if (changePw.matches(changePwConfirm)){
				log.debug("새 패스워드 일치");

				changePw = bcryptPasswordEncoder.encode(changePw);
				log.debug("암호화된 패스워드 : " + changePw);

				map.put("changePassword", changePw);

				//패스워드 Update
				int upCnt = commonDAO.updatePassword(map);
				if(upCnt == 1){
				}else{
					returnStatus = 7;
				}

			}else {
				log.debug("새 패스워드 확인 불일치");
				returnStatus=8;

				return returnStatus;
			}
		}else {
			log.debug("현재 비밀번호 불일치");

			//현재 비밀번호가 틀림
			returnStatus=9;

			return returnStatus; 
		}

		//int cnt = commonDAO.updatePwCnt(map);
		return returnStatus;
	}



	public List<Map<String, Object>> selectNoticeDetail(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		List<Map<String, Object>> list = commonDAO.selectNoticeDetail(map);
		
		/**
		 * 공유를 했다가 공유한 사람이 공유삭제를 눌렀을 때, 공유받은 사람 알림창에서 바로가기 클릭하였을 때 보여지는 현상이 발생.
		 * 보여지지 않게 수정_2017-06-16
		 */
		for(int i=0; i<list.size(); i++)
		{
			
			if(list.get(i).get("NOTICE_CATEGORY").equals("캘린더공유") && list.get(i).get("NOTICE_DEL_YN").equals("N"))
			{
				Map<String, Object>	checkMap = new HashMap<String, Object>();
				
				String redirectUrl = list.get(i).get("NOTICE_REDIRECT_URL").toString();
				int index = redirectUrl.indexOf("shareMemberId=");
				String fromMemberIdNum = "";
				if(index != -1) {
					fromMemberIdNum = redirectUrl.substring(index+14);
				}
				
				checkMap.put("fromMemberIdNum", fromMemberIdNum);
				checkMap.put("toMemberIdNum", list.get(i).get("MEMBER_ID_NUM"));
				checkMap.put("noticeID", list.get(i).get("NOTICE_ID"));
				
				//calendar_share 테이블에 공유 정보가 있는지 체크
				List<Map<String, Object>> checkList = commonDAO.selectCalendarShareTable(checkMap);
				
				if(checkList.size() <= 0)
				{
					//calendar_share 테이블에 공유 정보 없으면 알림에서 삭제. ( NOTICE_DEL_YN 을 Y로 업데이트 )
					commonDAO.deleteNoticeDetail(checkMap);
				}
			}
		}
		
		return list;
	}

	

	public int updateNoticeDetail(Map<String, Object> map) throws Exception {
		return commonDAO.updateNoticeDetail(map);
	}

	//Schedule(생산성)
	public void callFaceTime(String currentDate) throws Exception {
		//프로시저 실행
		commonDAO.callFaceTime(currentDate);
	}
	
	/**
	 * 반복일정 관련 생산성
	 * @param currentDate
	 * @throws Exception
	 */
	public void callRRuleEventProductivity(String currentDate) throws Exception {
		//반복일정 ins ert관련
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		CommandMap map = new CommandMap();
		
		//반복일정에 대한 일정 이벤트 가져오기 위한 Flag
		map.put("productividyRRuleEvent", "Y");
		
		//캘린더 이벤트 리스트 가져오기
		list = calendarDAO.calendarEventList(map.getMap());
		
		//반복 이벤트 리스트 해독
		list = CalendarService.calendarRRuleEventList(list, null);
		
		//오늘 날짜 ( yyyyMMdd )
		//String todayDate = CommonDateUtils.getTodayFormat();
		String todayDate = currentDate;
		
		//어제 날짜 ( yyyyMMdd )
		String beforeTodayDate = CommonDateUtils.getToday(CommonDateUtils.getDate(todayDate, -1));
		
		//어제 날짜 포맷 변환 ( yyyy-MM-dd )
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date d1 = sdf.parse(beforeTodayDate);
		sdf.applyPattern("yyyy-MM-dd");
		
		//어제날짜 ( yyyy-MM-dd )
		beforeTodayDate = sdf.format(d1);
		
		//오늘날짜 (yyyy-MM-dd)
		SimpleDateFormat aaa = new SimpleDateFormat("yyyyMMdd");
		Date d2 = aaa.parse(currentDate);
		aaa.applyPattern("yyyy-MM-dd");
		todayDate = aaa.format(d2);
		
		for(int i=0; i<list.size(); i++)
		{
			HashMap<String, Object> rruleMap = new HashMap<String, Object>();
			
			//rrule 리스트에 있는 반복일정 일자 ( yyyy-MM-dd ), 이벤트ID, 이벤트코드, 오늘날짜
			rruleMap.put("rruleDate", list.get(i).get("start"));
			rruleMap.put("rruleEventID", list.get(i).get("EVENT_ID"));
			rruleMap.put("rruleEventCode", list.get(i).get("EVENT_CODE"));
			rruleMap.put("date", beforeTodayDate);
			
			/**
			 * 생산성 프로시저가 00:00에 기동함
			 * ex) 
			 * 5월 23일 59:23에 기동
			 * 생산성 관련 데일리 DB에 insert 해야하므로
			 * 반복일정 list에 5월23일 일정이 있는지 체크한다
			 */
			//00:00 시간 기준으로 어제 날짜  ==  이벤트 시작일
			if(beforeTodayDate.equals(rruleMap.get("rruleDate").toString().substring(0, 10)))
			{
				//생산성 테이블에 저장되어있는 데이터
				List<Map<String, Object>> analList = commonDAO.selectProductividyRRuleEvent(rruleMap);
				
				//생산성 테이블에 업데이트할 Map
				HashMap<String, Object> analMap = new HashMap<String, Object>();

				analMap.put("analTimeID", analList.get(0).get("ANAL_TIME_ID"));
				analMap.put("activityCode_1", analList.get(0).get("ACTIVITY_CODE_1_TIME"));
				analMap.put("activityCode_2", analList.get(0).get("ACTIVITY_CODE_2_TIME"));
				analMap.put("activityCode_3", analList.get(0).get("ACTIVITY_CODE_3_TIME"));
				analMap.put("activityCode_4", analList.get(0).get("ACTIVITY_CODE_4_TIME"));
				analMap.put("activityCode_5", analList.get(0).get("ACTIVITY_CODE_5_TIME"));
				analMap.put("activityCode_6", analList.get(0).get("ACTIVITY_CODE_6_TIME"));
				analMap.put("activityCode_7", analList.get(0).get("ACTIVITY_CODE_7_TIME"));
				
				int startTimeHour = Integer.parseInt(analList.get(0).get("START_DATETIME").toString().substring(11, 13));
				int startTimeMin = Integer.parseInt(analList.get(0).get("START_DATETIME").toString().substring(14, 16));
				int endTimeHour = Integer.parseInt(analList.get(0).get("END_DATETIME").toString().substring(11, 13));
				int endTimeMin = Integer.parseInt(analList.get(0).get("END_DATETIME").toString().substring(14, 16));
				
				double compareHour = endTimeHour - startTimeHour;
				double compareMin = endTimeMin - startTimeMin;
				
				//하루종일
				double analData = 0; 
				if(analList.get(0).get("ALLDAY_YN").equals("Y")){
					analData = 8;
				}
				else
				{//시간 단위 계산
					if(compareMin == 30)
					{
						compareMin = 0.5;
					}
					else
					{
						compareMin = 0;
					}
					analData = compareHour + compareMin;
				}
				
				String analMapSumData = "";
				if(rruleMap.get("rruleEventCode").equals("1"))
				{
					double activityCode1 = Double.parseDouble(analMap.get("activityCode_1").toString());
					activityCode1 = activityCode1 + analData;
					
					analMapSumData = Double.toString(activityCode1);
					analMap.put("activityCode_1", analMapSumData);
				}
				else if(rruleMap.get("rruleEventCode").equals("2"))
				{
					double activityCode2 = Double.parseDouble(analMap.get("activityCode_2").toString());
					activityCode2 = activityCode2 + analData;
					
					analMapSumData = Double.toString(activityCode2);
					analMap.put("activityCode_2", analMapSumData);
				}
				else if(rruleMap.get("rruleEventCode").equals("3"))
				{
					double activityCode3 = Double.parseDouble(analMap.get("activityCode_3").toString());
					activityCode3 = activityCode3 + analData;
					
					analMapSumData = Double.toString(activityCode3);
					analMap.put("activityCode_3", analMapSumData);
				}
				else if(rruleMap.get("rruleEventCode").equals("4"))
				{
					double activityCode4 = Double.parseDouble(analMap.get("activityCode_4").toString());
					activityCode4 = activityCode4 + analData;
					
					analMapSumData = Double.toString(activityCode4);
					analMap.put("activityCode_4", analMapSumData);
				}
				else if(rruleMap.get("rruleEventCode").equals("5"))
				{
					double activityCode5 = Double.parseDouble(analMap.get("activityCode_5").toString());
					activityCode5 = activityCode5 + analData;
					
					analMapSumData = Double.toString(activityCode5);
					analMap.put("activityCode_5", analMapSumData);
				}
				else if(rruleMap.get("rruleEventCode").equals("6"))
				{
					double activityCode6 = Double.parseDouble(analMap.get("activityCode_6").toString());
					activityCode6 = activityCode6 + analData;
					
					analMapSumData = Double.toString(activityCode6);
					analMap.put("activityCode_6", analMapSumData);
				}
				else if(rruleMap.get("rruleEventCode").equals("7"))
				{
					double activityCode7 = Double.parseDouble(analMap.get("activityCode_7").toString());
					activityCode7 = activityCode7 + analData;
					
					analMapSumData = Double.toString(activityCode7);
					analMap.put("activityCode_7", analMapSumData);
				}
				//anal_individual_time 테이블 업데이트 ( 반복일정 생산성 부여 )
				commonDAO.updateProductividyRRuleEvent(analMap);
			}//if
		}//for
	}

	//Schedule(영업기회)
	public void callOpportunity() throws Exception {
		commonDAO.callOpportunity();
	}
	
	public int insertCoachingTalk(Map<String, Object> map) throws Exception {
		int cnt = 0;
		
		cnt = commonDAO.insertCoachingTalk(map);
		
		//코칭톡입력 성공시 게시물관련자들에게 알림보내기
		if(cnt == 1){
			String noticeDetail = "[영업기회] aaaa에 댓글이 달렸습니다 <바로가기>";
			String noticeURL = "";
			String menuName = "";
			String mobileURL = "";
			String mobileIp = "http://211.41.100.56:8080";
			
			String talkUserName = map.get("talkName").toString(); //코칭톡 사용자 명
			
			map.put("NOTICE_CATEGORY", "COACHING TALK");
			map.put("EVENT_ID", map.get("dataId"));
			//map.put("NOTICE_CODE", "");
			
			if(map.get("category").equals("OPP")){ //영업기회 알림보내야될 사람 : OI, OO
				noticeDetail = "[영업기회]"+ talkUserName +"님이'"+ map.get("subject").toString() +"'에 코칭톡을 남겼습니다.";
				noticeURL = "/clientSalesActive/viewOpportunityList.do?opportunity_id="+map.get("dataId").toString()+"&coaching_talk=Y";
				mobileURL = mobileIp+"/clientSalesActive/viewOpportunityList.do?opportunity_id="+map.get("dataId").toString()+"&coaching_talk=Y"; //최영완
				menuName = "영업기회";
				
			}else if(map.get("category").equals("HOPP")){ //잠재영업기회 알림보내야될 사람 : creatorId(작성자), OI
				noticeDetail = "[잠재영업기회]"+ talkUserName +"님이'"+ map.get("subject").toString() +"'에 코칭톡을 남겼습니다.";
				noticeURL = "/clientSalesActive/viewHiddenOpportunityList.do?opportunity_hidden_id="+map.get("dataId").toString()+"&coaching_talk=Y";
				mobileURL = mobileIp+"/clientSalesActive/viewHiddenOpportunityList.do?opportunity_hidden_id="+map.get("dataId").toString()+"&coaching_talk=Y"; //최영완
				menuName = "잠재영업기회";
				
			}else if(map.get("category").equals("ISSUE")){ //고객이슈 알림내용보내야될 사람 : creatorId(작성자), OI, SO(이슈해결책임자)
				noticeDetail = "[고객이슈]"+ talkUserName +"님이'"+ map.get("subject").toString() +"'에 코칭톡을 남겼습니다.";
				noticeURL = "/clientSatisfaction/viewClientIssueList.do?issue_id="+map.get("dataId").toString()+"&coaching_talk=Y";
				mobileURL = mobileIp+"/clientSatisfaction/viewClientIssueList.do?issue_id="+map.get("dataId").toString()+"&coaching_talk=Y"; //최영완
				menuName = "고객이슈";
				
			}else if(map.get("category").equals("SVPJ")){
				noticeDetail = "[서비스프로젝트]"+ talkUserName +"님이'"+ map.get("subject").toString() +"'에 코칭톡을 남겼습니다.";
				noticeURL = "/clientSatisfaction/viewServiceProject.do?returnProjectMGMTId="+map.get("dataId").toString()+"&coaching_talk=Y";
				mobileURL = mobileIp+"/clientSatisfaction/viewServiceProject.do?returnProjectMGMTId="+map.get("dataId").toString()+"&coaching_talk=Y"; //최영완
				menuName = "서비스프로젝트";
				
			}else if(map.get("category").equals("CONTACT")){
				noticeDetail = "[고객컨택]"+ talkUserName +"님이'"+ map.get("subject").toString() +"'에 코칭톡을 남겼습니다.";
				noticeURL = "/clientSalesActive/viewClientContactList.do?event_id="+map.get("dataId").toString()+"&coaching_talk=Y";
				mobileURL = mobileIp+"/clientSalesActive/viewClientContactList.do?event_id="+map.get("dataId").toString()+"&coaching_talk=Y"; //최영완
				menuName = "고객컨택";
			}
			
			map.put("MOBILE_REDIRECT_URL", mobileURL);//최영완
			map.put("NOTICE_DETAIL", noticeDetail);
			map.put("NOTICE_REDIRECT_URL", noticeURL);
			
			ArrayList<Object> toAddr = new ArrayList<>();
			String[] teamMemberIdArray = null;
			if(map.get("teamMemberIdArray") != null && !"".equals(map.get("teamMemberIdArray"))){
				teamMemberIdArray = map.get("teamMemberIdArray").toString().split(",");
				
				for(int q=0; q<teamMemberIdArray.length; q++){
					if(!map.get("global_member_id").equals(teamMemberIdArray[q])){
						map.put("MEMBER_ID_NUM", teamMemberIdArray[q]);
						
						//웹 알림보내기
						if(sendCoachingTalkNotice.equals("Y")) {
							commonDAO.insertNotice(map);
						}
						
						//모바일앱 알림보내기
						if(sendCoachingTalkMobile.equals("Y")) {
							trackingService.sendMobileNotice(teamMemberIdArray[q], noticeDetail, map.get("coachingTalk").toString(), mobileURL);
						}
						
						//메일 알림 보낼 인원 세팅
						if(sendCoachingTalkMail.equals("Y")) {
							List<Map<String, Object>> mailList = trackingDAO.selectOuruserInfo(map);
							String userEmail = "";
							if(null != mailList.get(0).get("EMAIL")) userEmail = mailList.get(0).get("EMAIL").toString();
							toAddr.add(userEmail);
						}
					}
				}
				
				//메일 알림보내기
				if(sendCoachingTalkMail.equals("Y") && toAddr.size() > 0) {
					Map<String, Object> emailInfoMap = new HashMap<String, Object>();
					emailInfoMap.put("fromMail", trackingSendMail);
					emailInfoMap.put("fromMailName", trackingSendMailName);
					emailInfoMap.put("menuName", menuName);
					emailInfoMap.put("eventSubject", map.get("subject").toString());
					emailInfoMap.put("eventDetail", noticeDetail);
					emailInfoMap.put("talkUserName", talkUserName);
					emailInfoMap.put("linkURL", noticeURL);
					
					commonMailService.sendCoachingTalkMail(emailInfoMap, toAddr);
				}
				
			}
			
		}
		
		return cnt;
	}
	
	/**
	 * @author  : 욱이
	 * @date : 2017. 4. 27.
	 * @explain : 로그인 후 히스토리 남기자
	 */
	public void insertLoginHistory(Map<String, Object> map, Device device, HttpServletRequest request) throws Exception {
		if (device.isNormal()) {
			map.put("login_category", "PC");
		} else if (device.isTablet()) {
			map.put("login_category", "Tablet");
		} else if (device.isMobile()) {
			map.put("login_category", "Mobile");
		}
		map.put("login_browser", CommonUtils.getBrowser());
		map.put("login_ip", CommonUtils.getIp(request));
		log.info("@접속IP : " + CommonUtils.getIp(request));
		commonDAO.insertLoginHistory(map);
	}
	
	/**
	 * @author  : 욱이
	 * @date : 2017. 4. 28.
	 * @explain : 로그아웃 히스토리 (최근 로그인 날짜 찾아서 로그아웃 날짜 업데이트)
	 */
	public void updateLogoutHistory(Map<String, Object> map){
		commonDAO.updateLogoutHistory(map);
	}
	
	/**
	 * @author  : 욱이
	 * @date : 2017. 05. 02.
	 * @explain : 페이지 접근
	 */
	public void insertPageContatct(Map<String, Object> map){
		commonDAO.insertPageContatct(map);
	}
	
	/**
	 * @author  : 준이
	 * @date : 2017. 07. 27.
	 * @explain : 첨부파일 삭제 후 리로드
	 */
	public List<Map<String, Object>> reloadFile(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		map.put("findCloumnName", findCloumnName(map));
		map.put("fileTableName", findFileTable(map));
		return commonDAO.reloadFile(map);
	}
	
	/**
	 * @author  : 준이
	 * @date : 2017. 07. 27.
	 * @explain : 파일첨부 테이블 참조키 컬럼
	 */
	public String findCloumnName(Map<String, Object> map) throws Exception {
		String findCloumnName = "";
		switch ((String)map.get("fileTableName")) {
		case "1":
			findCloumnName = "BIZ_ID";
			break;
		case "2":
			findCloumnName = "PROJECT_ID";
			break;			
		case "3":
			findCloumnName = "EVENT_ID";
			break;			
		case "4":
			findCloumnName = "ISSUE_ID";
			break;
		case "5":
			findCloumnName = "CSAT_ID";
			break;
		case "6":
			findCloumnName = "OPPORTUNITY_ID";
			break;
		case "7":
			findCloumnName = "EDU_PLAN_ID";
			break;
		case "8":
			findCloumnName = "PROPOSAL_ID";
			break;
		case "9":
			findCloumnName = "PROJECT_ID";
			break;
		case "10":
			findCloumnName = "BIZ_SEGMENT";
			break;
		case "11":
			findCloumnName = "LINAKGE_ID";
			break;
		case "12":
			findCloumnName = "COMPANY_ID";
			break;
		case "15":
			findCloumnName = "PARTNER_ID";
			break;
		}
		return findCloumnName; 
	}
	
	//최영완
	//로그아웃 할때 사용자 토큰값 제거
	public int deleteLogOutToken(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return commonDAO.deleteLogOutToken(map);
	}
}