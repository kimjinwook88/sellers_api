package com.uni.sellers.tracking;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.uni.sellers.calendar.CalendarService;
import com.uni.sellers.clientsalesactive.ClientSalesActiveDAO;
import com.uni.sellers.common.CommonDAO;
import com.uni.sellers.common.CommonMailService;
import com.uni.sellers.fcm.FirebaseCloudMessagingService;
import com.uni.sellers.restful.RestfulDAO;
import com.uni.sellers.util.CommonDateUtils;
import com.uni.sellers.util.CommonFileUtils;
import com.uni.sellers.util.CommonUtils;

@Service("trackingService")
public class TrackingService{
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name="commonFileUtils")
	private CommonFileUtils commonFileUtils;
	
	@Resource(name="commonMailService")
	private CommonMailService commonMailService;
	
	@Resource(name="CalendarService")
	private CalendarService calendarService;

	@Resource(name="trackingDAO")
	private TrackingDAO trackingDAO;

	@Resource(name="commonDAO")
	private CommonDAO commonDAO;
	
	@Resource(name="clientSalesActiveDAO")
	private ClientSalesActiveDAO clientSalesActiveDAO;
	
	@Resource(name="restfulDAO")
	private RestfulDAO restfulDAO;
	
	@Resource(name="firebaseCloudMessagingService")
	private FirebaseCloudMessagingService firebaseCloudMessagingService;
	
	
	@Value("#{config['flag.trackingSendMail']}")
	private String trackingSendMail;
	@Value("#{config['flag.trackingSendMailName']}")
	private String trackingSendMailName;
	
	//캘린더 일정
	@Value("#{config['flag.trackingMenuCalendarEvent']}")
	private String trackingMenuCalendarEvent;
	
	@Value("#{config['flag.trackingMenuCalendarEventMail']}")
	private String trackingMenuCalendarEventMail;
	
	@Value("#{config['path.calUserInfo']}")
	private String calUserInfoPath;
	
	//전체 date 트래킹 select
	//사용자 use_yn check
	public void checkTrackingList() throws Exception{
		//스케줄 실행될때마다, TRACKING LOG를 전체 싹 한번 지우고 다시 TRACKING 체크 진행 
		trackingDAO.deleteTrackingNotice();
		
		//1.고객컨택 Follow-Up-Action
		trackingMenuClientContactFollowUpAction();
		
		//2.영업기회 마일스톤
		trackingMenuOpportunityMilestones();
		
		//3.영업기회 윈플랜
		trackingMenuOpportunityWinPlan();
		
		//4.영업기회 계약일
		trackingMenuOpportunityContractDate();
		
		//5.영업기회 매출계획일
		trackingMenuOpportunityAmount("SP");
		
		//6.영업기회 수금계획일
		trackingMenuOpportunityAmount("CP");
		
		//7.잠재영업기회 Action Plan
		trackingMenuHiddenOpportunityActionPlan();
		
		//8.고객이슈
		trackingMenuClientIssue();
		
		//9.고객이슈 해결방법
		trackingMenuClientIssueActionPlan();
		
		//10.고객만족도 Follow-Up-Action
		trackingMenuClientSatisfactionFollowUpAction();
		
		//11.서비스 프로젝트 마일스톤
		trackingMenuServiceProjectMilestones();
		
		//12.서비스 프로젝트 이슈
		trackingMenuServiceProjectIssue();
		
		//13.제안서정보_제출일
		trackingMenuProposalsInfo("SED");
		
		//14.제안서정보_제안발표일
		trackingMenuProposalsInfo("SPD");
		
		//15.제안서정보_결과발표일
		trackingMenuProposalsInfo("SRD");
		
		//16.회사/부문별전략 키마일스톤
		trackingMenuBizStrategyCompanyKeyMilestones();
		
		//17.회사/부문별전략 이슈
		trackingMenuBizStrategyCompanyIssue();
		
		//18.고객별전략 키마일스톤
		trackingMenuBizStrategyClientKeyMilestones();
		
		//19.고객별전략 이슈
		trackingMenuBizStrategyClientIssue();
		
		//20.전략프로젝트 마일스톤
		trackingMenuBizStrategyProjectPlanMilestones();
		
		//21.전략프로젝트 이슈
		trackingMenuBizStrategyProjectPlanIssue();
	}
	
	//사용자 트래킹 설정 값 선택 : 사번 비교 해서 트래킹 설정 값 지정 없으면? default
	public Map<String, Object> setMemberTrackingOption(String memberId, List<Map<String, Object>> list) throws Exception {
		for(int i=0; i<list.size(); i++){
			if(list.get(i).get("MEMBER_ID_NUM") != null && memberId.equals(list.get(i).get("MEMBER_ID_NUM"))){
				return list.get(i);
			}
		}
		return list.get(list.size()-1);
	}
	
	//중복 제거
	public List<String> containsMemerList(List<String> list){
		List<String> resultList = new ArrayList<String>();
		
		for(int i=0; i<list.size(); i++) {
            if( (list.get(i) != null && !"".equals(list.get(i))) && !resultList.contains(list.get(i)) ) {
            	resultList.add(list.get(i));
            }
        }
		return resultList;
	}
	
	//배열 값 스트링 묶기
	public String setMemberIdArray(String[] memberIdArray){
		String returnMemberIds = "";
		
		for(int i=0; i<memberIdArray.length; i++){
			returnMemberIds += "'"+ memberIdArray[i] +"'";
			if(i+1 != memberIdArray.length){
				returnMemberIds += ",";
			}
		}
		return returnMemberIds;
	}
	
	//팀구성원 추가
	public List<String> addTeamMemberList(List<String> list, String teamMemberIds){
		List<String> resultList = list;
		String splitTeamMemberIds[] = teamMemberIds.split(",");
		
		for(int i=0; i<splitTeamMemberIds.length; i++){
			if(splitTeamMemberIds[i] != null && !"".equals(splitTeamMemberIds[i])){
				resultList.add(splitTeamMemberIds[i]);
			}
		}
		return resultList;
	}
	
	//모바일앱 알림보내기
	public void sendMobileNotice(String member_id_num, String title, String body, String pushUrl) throws Exception{
		List<Map<String, Object>> tokenList = new ArrayList<Map<String, Object>>();
		Map<String, Object> userMap = new HashMap<String, Object>();
		
		userMap.put("member_id_num", member_id_num);
		userMap.put("title", title);
		userMap.put("body", body);
		userMap.put("pushUrl", pushUrl);
		
		tokenList = restfulDAO.selectUserDeviceKey(userMap);
		
		if(tokenList != null && tokenList.size() > 0){
			firebaseCloudMessagingService.sendToFcm(userMap, tokenList);
		}else {
			log.info("token값을 확인해주세요.");
		}
	}
	
	//목표일 기준의 이벤트 트래킹 설정확인
	public void checkMemberTrackingTypeCloseDate(String meberIdNum, String trackingCategory, Map<String, Object> trackingDataMap, Map<String, Object> trackingOptionMap) throws Exception{
		if("Y".equals(trackingOptionMap.get("FULL_USE_YN"))){
			Map<String, Object> dateMap = new HashMap<String, Object>();
			
			long calDateDays = 0;
			String closeDate = null;
			String todayDate = null;
			String dueDate = null;
			String afterDay = null;
			
			//트래킹 개인설정
			String beforeDueDate = String.valueOf(trackingOptionMap.get("BEFORE_DUE_DATE"));
			String afterDueDate = String.valueOf(trackingOptionMap.get("AFTER_DUE_DATE"));
			String frqncBeforeUseYN = String.valueOf(trackingOptionMap.get("FRQNC_BEFROE_USE_YN"));
			String frqncBeforeDates = String.valueOf(trackingOptionMap.get("FRQNC_BEFROE"));
			String frqncAfterUseYN = String.valueOf(trackingOptionMap.get("FRQNC_AFTER_USE_YN"));
			String frqncAfterDates = String.valueOf(trackingOptionMap.get("FRQNC_AFTER"));
			
			if("1".equals(trackingCategory)){ //고객컨택 팔로업액션 tracking
				dueDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("SOLVE_DUE_DATE"));
				//closeDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("SOLVE_CLOSE_DATE"));
				todayDate = CommonDateUtils.getToday();	//오늘날짜 ( by CommonDateUtils )
				afterDay = CommonDateUtils.getBeforeDueDate(beforeDueDate);	//오늘 날짜부터 Cycle 날짜 후 날짜가 무엇인지 ?? 이게필요한가?
				calDateDays = CommonDateUtils.getCalDateDays(dueDate, todayDate);	//오늘날짜 - 해결마감일 ( 날짜 차이 계산 )
				
			}else if("2".equals(trackingCategory)){ //영업기회 마일스톤 tracking
				dueDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("DUE_DATE"));
				//closeDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("CLOSE_DATE"));
				todayDate = CommonDateUtils.getToday();	//오늘날짜 ( by CommonDateUtils )
				afterDay = CommonDateUtils.getBeforeDueDate(beforeDueDate);	//오늘 날짜부터 Cycle 날짜 후 날짜가 무엇인지 ?? 이게필요한가?
				calDateDays = CommonDateUtils.getCalDateDays(dueDate, todayDate);	//오늘날짜 - 해결마감일 ( 날짜 차이 계산 )
				
			}else if("3".equals(trackingCategory)){ //영업기회 윈플랜 tracking
				dueDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("DUE_DATE"));
				//closeDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("CLOSE_DATE"));
				todayDate = CommonDateUtils.getToday();	//오늘날짜 ( by CommonDateUtils )
				afterDay = CommonDateUtils.getBeforeDueDate(beforeDueDate);	//오늘 날짜부터 Cycle 날짜 후 날짜가 무엇인지 ?? 이게필요한가?
				calDateDays = CommonDateUtils.getCalDateDays(dueDate, todayDate);	//오늘날짜 - 해결마감일 ( 날짜 차이 계산 )
				
			}else if("4".equals(trackingCategory)){ //영업기회 계약일 tracking
				dueDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("CONTRACT_DATE"));
				//closeDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("CLOSE_DATE"));
				todayDate = CommonDateUtils.getToday();	//오늘날짜 ( by CommonDateUtils )
				afterDay = CommonDateUtils.getBeforeDueDate(beforeDueDate);	//오늘 날짜부터 Cycle 날짜 후 날짜가 무엇인지 ?? 이게필요한가?
				calDateDays = CommonDateUtils.getCalDateDays(dueDate, todayDate);	//오늘날짜 - 해결마감일 ( 날짜 차이 계산 )
				
			}else if("7".equals(trackingCategory)){ //잠재영업기회 액션플랜 해결목표일 tracking
				dueDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("DUE_DATE"));
				//closeDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("CLOSE_DATE"));
				todayDate = CommonDateUtils.getToday();	//오늘날짜 ( by CommonDateUtils )
				afterDay = CommonDateUtils.getBeforeDueDate(beforeDueDate);	//오늘 날짜부터 Cycle 날짜 후 날짜가 무엇인지 ?? 이게필요한가?
				calDateDays = CommonDateUtils.getCalDateDays(dueDate, todayDate);	//오늘날짜 - 해결마감일 ( 날짜 차이 계산 )
				
			}else if("8".equals(trackingCategory)){ //고객이슈 해결목표일 tracking
				dueDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("DUE_DATE"));
				//closeDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("ISSUE_CLOSE_DATE"));
				todayDate = CommonDateUtils.getToday();	//오늘날짜 ( by CommonDateUtils )
				afterDay = CommonDateUtils.getBeforeDueDate(beforeDueDate);	//오늘 날짜부터 Cycle 날짜 후 날짜가 무엇인지 ?? 이게필요한가?
				calDateDays = CommonDateUtils.getCalDateDays(dueDate, todayDate);	//오늘날짜 - 해결마감일 ( 날짜 차이 계산 )
				
			}else if("9".equals(trackingCategory)){ //고객이슈_액션플랜 해결목표일 tracking
				dueDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("DUE_DATE"));
				closeDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("CLOSE_DATE"));
				todayDate = CommonDateUtils.getToday();	//오늘날짜 ( by CommonDateUtils )
				afterDay = CommonDateUtils.getBeforeDueDate(beforeDueDate);	//오늘 날짜부터 Cycle 날짜 후 날짜가 무엇인지 ?? 이게필요한가?
				calDateDays = CommonDateUtils.getCalDateDays(dueDate, todayDate);	//오늘날짜 - 해결마감일 ( 날짜 차이 계산 )
				
			}else if("10".equals(trackingCategory)){ //고객만족도_팔로업액션 해결목표일 tracking
				dueDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("DUE_DATE"));
				//closeDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("CLOSE_DATE"));
				todayDate = CommonDateUtils.getToday();	//오늘날짜 ( by CommonDateUtils )
				afterDay = CommonDateUtils.getBeforeDueDate(beforeDueDate);	//오늘 날짜부터 Cycle 날짜 후 날짜가 무엇인지 ?? 이게필요한가?
				calDateDays = CommonDateUtils.getCalDateDays(dueDate, todayDate);	//오늘날짜 - 해결마감일 ( 날짜 차이 계산 )
				
			}else if("11".equals(trackingCategory)){ //서비스프로젝트_마일스톤 해결목표일 tracking
				dueDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("ACT_DUE_DATE"));
				//closeDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("ACT_CLOSE_DATE"));
				todayDate = CommonDateUtils.getToday();	//오늘날짜 ( by CommonDateUtils )
				afterDay = CommonDateUtils.getBeforeDueDate(beforeDueDate);	//오늘 날짜부터 Cycle 날짜 후 날짜가 무엇인지 ?? 이게필요한가?
				calDateDays = CommonDateUtils.getCalDateDays(dueDate, todayDate);	//오늘날짜 - 해결마감일 ( 날짜 차이 계산 )
				
			}else if("12".equals(trackingCategory)){ //서비스프로젝트_이슈 해결목표일 tracking
				dueDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("DUE_DATE"));
				//closeDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("ISSUE_CLOSE_DATE"));
				todayDate = CommonDateUtils.getToday();	//오늘날짜 ( by CommonDateUtils )
				afterDay = CommonDateUtils.getBeforeDueDate(beforeDueDate);	//오늘 날짜부터 Cycle 날짜 후 날짜가 무엇인지 ?? 이게필요한가?
				calDateDays = CommonDateUtils.getCalDateDays(dueDate, todayDate);	//오늘날짜 - 해결마감일 ( 날짜 차이 계산 )
				
			}else if("13".equals(trackingCategory)){ //제안발표_제출일 tracking
				dueDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("TARGET_DATE"));
				todayDate = CommonDateUtils.getToday();	//오늘날짜 ( by CommonDateUtils )
				afterDay = CommonDateUtils.getBeforeDueDate(beforeDueDate);	//오늘 날짜부터 Cycle 날짜 후 날짜가 무엇인지 ?? 이게필요한가?
				calDateDays = CommonDateUtils.getCalDateDays(dueDate, todayDate);	//오늘날짜 - 해결마감일 ( 날짜 차이 계산 )
				
			}else if("14".equals(trackingCategory)){ //제안발표_발표일 tracking
				dueDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("TARGET_DATE"));
				todayDate = CommonDateUtils.getToday();	//오늘날짜 ( by CommonDateUtils )
				afterDay = CommonDateUtils.getBeforeDueDate(beforeDueDate);	//오늘 날짜부터 Cycle 날짜 후 날짜가 무엇인지 ?? 이게필요한가?
				calDateDays = CommonDateUtils.getCalDateDays(dueDate, todayDate);	//오늘날짜 - 해결마감일 ( 날짜 차이 계산 )
				
			}else if("15".equals(trackingCategory)){ //제안발표_결과일 tracking
				dueDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("TARGET_DATE"));
				todayDate = CommonDateUtils.getToday();	//오늘날짜 ( by CommonDateUtils )
				afterDay = CommonDateUtils.getBeforeDueDate(beforeDueDate);	//오늘 날짜부터 Cycle 날짜 후 날짜가 무엇인지 ?? 이게필요한가?
				calDateDays = CommonDateUtils.getCalDateDays(dueDate, todayDate);	//오늘날짜 - 해결마감일 ( 날짜 차이 계산 )
				
			}else if("16".equals(trackingCategory)){ //회사/부문전략_키마일스톤 목표일 tracking
				dueDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("ACT_DUE_DATE"));
				//closeDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("ACT_CLOSE_DATE"));
				todayDate = CommonDateUtils.getToday();	//오늘날짜 ( by CommonDateUtils )
				afterDay = CommonDateUtils.getBeforeDueDate(beforeDueDate);	//오늘 날짜부터 Cycle 날짜 후 날짜가 무엇인지 ?? 이게필요한가?
				calDateDays = CommonDateUtils.getCalDateDays(dueDate, todayDate);	//오늘날짜 - 해결마감일 ( 날짜 차이 계산 )
				
			}else if("17".equals(trackingCategory)){ //회사/부문전략_이슈 목표일 tracking
				dueDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("DUE_DATE"));
				//closeDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("CLOSE_DATE"));
				todayDate = CommonDateUtils.getToday();	//오늘날짜 ( by CommonDateUtils )
				afterDay = CommonDateUtils.getBeforeDueDate(beforeDueDate);	//오늘 날짜부터 Cycle 날짜 후 날짜가 무엇인지 ?? 이게필요한가?
				calDateDays = CommonDateUtils.getCalDateDays(dueDate, todayDate);	//오늘날짜 - 해결마감일 ( 날짜 차이 계산 )
				
			}else if("18".equals(trackingCategory)){ //고객전략_키마일스톤 목표일 tracking
				dueDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("ACT_DUE_DATE"));
				//closeDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("ACT_CLOSE_DATE"));
				todayDate = CommonDateUtils.getToday();	//오늘날짜 ( by CommonDateUtils )
				afterDay = CommonDateUtils.getBeforeDueDate(beforeDueDate);	//오늘 날짜부터 Cycle 날짜 후 날짜가 무엇인지 ?? 이게필요한가?
				calDateDays = CommonDateUtils.getCalDateDays(dueDate, todayDate);	//오늘날짜 - 해결마감일 ( 날짜 차이 계산 )
				
			}else if("19".equals(trackingCategory)){ //고객전략_이슈 해결목표일 tracking
				dueDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("DUE_DATE"));
				//closeDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("CLOSE_DATE"));
				todayDate = CommonDateUtils.getToday();	//오늘날짜 ( by CommonDateUtils )
				afterDay = CommonDateUtils.getBeforeDueDate(beforeDueDate);	//오늘 날짜부터 Cycle 날짜 후 날짜가 무엇인지 ?? 이게필요한가?
				calDateDays = CommonDateUtils.getCalDateDays(dueDate, todayDate);	//오늘날짜 - 해결마감일 ( 날짜 차이 계산 )
				
			}else if("20".equals(trackingCategory)){ //전략프로젝트_마일스톤 목표일 tracking
				dueDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("ACT_DUE_DATE"));
				//closeDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("ACT_CLOSE_DATE"));
				todayDate = CommonDateUtils.getToday();	//오늘날짜 ( by CommonDateUtils )
				afterDay = CommonDateUtils.getBeforeDueDate(beforeDueDate);	//오늘 날짜부터 Cycle 날짜 후 날짜가 무엇인지 ?? 이게필요한가?
				calDateDays = CommonDateUtils.getCalDateDays(dueDate, todayDate);	//오늘날짜 - 해결마감일 ( 날짜 차이 계산 )
				
			}else if("21".equals(trackingCategory)){ //전략프로젝트_이슈 해결목표일 tracking
				dueDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("DUE_DATE"));
				//closeDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("CLOSE_DATE"));
				todayDate = CommonDateUtils.getToday();	//오늘날짜 ( by CommonDateUtils )
				afterDay = CommonDateUtils.getBeforeDueDate(beforeDueDate);	//오늘 날짜부터 Cycle 날짜 후 날짜가 무엇인지 ?? 이게필요한가?
				calDateDays = CommonDateUtils.getCalDateDays(dueDate, todayDate);	//오늘날짜 - 해결마감일 ( 날짜 차이 계산 )
				
			}
			
			dateMap.put("dueDate", dueDate);
			//dateMap.put("closeDate", closeDate);
			dateMap.put("todayDate", todayDate);
			dateMap.put("afterDay", afterDay);
			dateMap.put("calDateDays", calDateDays);
			
			if(calDateDays<=0 && (calDateDays + Integer.parseInt(beforeDueDate))>=0){ //todayDate가 dueDate와 같거나 이전일 경우
				if(frqncBeforeUseYN.equals("Y")){
					String[] memberFrqncBeforeDatesArray = frqncBeforeDates.split(",");
					for(int i=0; i<memberFrqncBeforeDatesArray.length; i++){
						//알림 일 체크(== 0)이면 트래킹
						if((int)calDateDays + Integer.parseInt(memberFrqncBeforeDatesArray[i]) == 0){
							if( "Y".equals(trackingOptionMap.get("ALARM_USE_YN")) || //더셀러스 알람 메세지 전송
								"Y".equals(trackingOptionMap.get("MAIL_USE_YN")) || //메일 전송
								"Y".equals(trackingOptionMap.get("MOBILE_USE_YN")) //모바일 앱 푸쉬 알림 전송
							){
								sendMemberTrackingTypeCloseDate(meberIdNum, trackingCategory, trackingDataMap, trackingOptionMap, dateMap);
							}
						}
					}
				}else{ //목표일까지 매일알림
					if( "Y".equals(trackingOptionMap.get("ALARM_USE_YN")) || //더셀러스 알람 메세지 전송
						"Y".equals(trackingOptionMap.get("MAIL_USE_YN")) || //메일 전송
						"Y".equals(trackingOptionMap.get("MOBILE_USE_YN")) //모바일 앱 푸쉬 알림 전송
					){
						sendMemberTrackingTypeCloseDate(meberIdNum, trackingCategory, trackingDataMap, trackingOptionMap, dateMap);
					}
				}
			}else if(calDateDays>0 && (calDateDays - Integer.parseInt(beforeDueDate))<0){ //목표일 이후로 afterDueDate 까지
				if(frqncAfterUseYN.equals("Y")){ //빈도 설정여부 확인
					String[] memberFrqncAfterDatesArray = frqncAfterDates.split(",");
					for(int i=0; i<memberFrqncAfterDatesArray.length; i++){
						//알림 일 체크(== 0)이면 
						if((int)calDateDays - Integer.parseInt(memberFrqncAfterDatesArray[i]) == 0){
							if( "Y".equals(trackingOptionMap.get("ALARM_USE_YN")) || //더셀러스 알람 메세지 전송
								"Y".equals(trackingOptionMap.get("MAIL_USE_YN")) || //메일 전송
								"Y".equals(trackingOptionMap.get("MOBILE_USE_YN")) //모바일 앱 푸쉬 알림 전송
							){
								sendMemberTrackingTypeCloseDate(meberIdNum, trackingCategory, trackingDataMap, trackingOptionMap, dateMap);
							}
							
						}
					}
				}else{ //afterDueDate까지 매일알림
					if( "Y".equals(trackingOptionMap.get("ALARM_USE_YN")) || //더셀러스 알람 메세지 전송
						"Y".equals(trackingOptionMap.get("MAIL_USE_YN")) || //메일 전송
						"Y".equals(trackingOptionMap.get("MOBILE_USE_YN")) //모바일 앱 푸쉬 알림 전송
					){
						sendMemberTrackingTypeCloseDate(meberIdNum, trackingCategory, trackingDataMap, trackingOptionMap, dateMap);
					}
					
				}
			}
		}
	}
	
	//목표일 트래킹 알림 데이터 세팅 및 전송 로직
	public void sendMemberTrackingTypeCloseDate(String meberIdNum, String trackingCategory, Map<String, Object> trackingDataMap, Map<String, Object> trackingOptionMap, Map<String, Object> dateMap) throws Exception {
		log.debug("::트래킹 전송");
		//트래킹 대상 설정 변수
		//List<String> memberList = null;

		//공통변수
		String eventId = null;
		String URL = null;

		//목표일 계산 변수
		String beforeDueDate = String.valueOf(trackingOptionMap.get("BEFORE_DUE_DATE"));
		String afterDueDate = String.valueOf(trackingOptionMap.get("AFTER_DUE_DATE"));
		long calDateDays = (long) dateMap.get("calDateDays");
		//String closeDate = (String) dateMap.get("closeDate");;
		String todayDate = (String) dateMap.get("todayDate");;
		String dueDate = (String) dateMap.get("dueDate");;
		String afterDay = (String) dateMap.get("afterDay");;
		
		//알람 변수
		String noticeCode = "";
		String noticeCategory = "";
		String noticeDetail = "";
		int OVER_DUE_FLAG = 0;
		
		//메일 변수
		String menuName = "";
		String eventSubject = "";
		String delayItem = "";
		String delayItemDetail = "";
		String noticeDetail2 = "";
		String status = "";
		String ownerName = "";
		
		//모바일푸쉬 변수
		
		// ============ 데이터 공통화 및 세팅 start ============
		if("1".equals(trackingCategory)){ //고객컨택 팔로업액션 목표일 tracking
			eventId = trackingDataMap.get("EVENT_ID").toString();
			URL = "/clientSalesActive/viewClientContactList.do?&event_id="+trackingDataMap.get("EVENT_ID");
			
			noticeCode = "고객컨택 FOLLOW-UP-ACTION";
			noticeCategory = "TRACKING";
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				noticeDetail = "'"+trackingDataMap.get("CONTENTS")+"'"+"<br /> ※해결 목표일 D+"+calDateDays+"일!!!";
				OVER_DUE_FLAG = (int)calDateDays;
			}else if(dueDate.compareTo(todayDate) == 0){ //해결 목표일 == 당일
				noticeDetail = "'"+trackingDataMap.get("CONTENTS")+"'"+"<br /> ※해결 목표일 D-Day!!!";
				OVER_DUE_FLAG = 0;
			}else if( (dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate)) ){
				noticeDetail = "'"+trackingDataMap.get("CONTENTS")+"'"+"<br /> ※해결 목표일 D-"+(-calDateDays)+"일!!!";
				OVER_DUE_FLAG = 0;
			}
			
			menuName = "고객컨택";
			eventSubject = (String) trackingDataMap.get("EVENT_SUBJECT");
			delayItem = "Follow-Up-Action";
			delayItemDetail = (String) trackingDataMap.get("CONTENTS");
			status = "";
			ownerName = (String) trackingDataMap.get("SOLVE_OWNER");
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				status = "[고객컨택 FollowUpAction] -'"+trackingDataMap.get("CONTENTS")+"' 해결 목표일이 "+calDateDays+"일 경과되었습니다.";
			}else if(dueDate.compareTo(todayDate) == 0){
				status = "[고객컨택 FollowUpAction] -'"+trackingDataMap.get("CONTENTS")+"' 해결 목표일이 오늘 까지 입니다.";
			}else if((dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate))){
				status = "[고객컨택 FollowUpAction] -'"+trackingDataMap.get("CONTENTS")+"' 해결 목표일이 "+(-calDateDays)+"일 남았습니다.";
			}
		}else if("2".equals(trackingCategory)){ //영업기회 마일스톤 tracking
			eventId = trackingDataMap.get("OPPORTUNITY_ID").toString();
			URL = "/clientSalesActive/viewOpportunityList.do?&opportunity_id="+trackingDataMap.get("OPPORTUNITY_ID");
			
			noticeCode = "영업기회 MILESTONE";
			noticeCategory = "TRACKING";
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("KEY_MILESTONE")+"'"+"<br /> ※해결 목표일 D+"+calDateDays+"일!!!";
				OVER_DUE_FLAG = (int)calDateDays;
			}else if(dueDate.compareTo(todayDate) == 0){ //해결 목표일 == 당일
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("KEY_MILESTONE")+"'"+"<br /> ※해결 목표일 D-Day!!!";
				OVER_DUE_FLAG = 0;
			}else if( (dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate)) ){
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("KEY_MILESTONE")+"'"+"<br /> ※해결 목표일 D-"+(-calDateDays)+"일!!!";
				OVER_DUE_FLAG = 0;
			}
			
			menuName = "영업기회";
			eventSubject = (String) trackingDataMap.get("SUBJECT");
			delayItem = "Milestones";
			delayItemDetail = (String) trackingDataMap.get("KEY_MILESTONE");
			status = "";
			ownerName = (String) trackingDataMap.get("ACT_NAME");
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				status = "[영업기회-Milestones] -'"+trackingDataMap.get("KEY_MILESTONE")+"' 해결 목표일이 "+calDateDays+"일 경과되었습니다.";
			}else if(dueDate.compareTo(todayDate) == 0){
				status = "[영업기회-Milestones] -'"+trackingDataMap.get("KEY_MILESTONE")+"' 해결 목표일이 오늘까지 입니다.";
			}else if((dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate))){
				status = "[영업기회-Milestones] -'"+trackingDataMap.get("KEY_MILESTONE")+"' 해결 목표일이 "+(-calDateDays)+"일 남았습니다.";
			}
		}else if("3".equals(trackingCategory)){ //영업기회 윈플랜 tracking
			eventId = trackingDataMap.get("OPPORTUNITY_ID").toString();
			URL = "/clientSalesActive/viewOpportunityList.do?&opportunity_id="+trackingDataMap.get("OPPORTUNITY_ID");
			
			noticeCode = "영업기회 WinPlan";
			noticeCategory = "TRACKING";
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("ACTION_PLAN_NAME")+"'"+"<br /> ※해결 목표일 D+"+calDateDays+"일!!!";
				OVER_DUE_FLAG = (int)calDateDays;
			}else if(dueDate.compareTo(todayDate) == 0){ //해결 목표일 == 당일
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("ACTION_PLAN_NAME")+"'"+"<br /> ※해결 목표일 D-Day!!!";
				OVER_DUE_FLAG = 0;
			}else if( (dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate)) ){
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("ACTION_PLAN_NAME")+"'"+"<br /> ※해결 목표일 D-"+(-calDateDays)+"일!!!";
				OVER_DUE_FLAG = 0;
			}
			
			menuName = "영업기회";
			eventSubject = (String) trackingDataMap.get("SUBJECT");
			delayItem = "WIN PLAN > How to Fix";
			delayItemDetail = (String) trackingDataMap.get("ACTION_PLAN_NAME");
			status = "";
			ownerName = (String) trackingDataMap.get("ACTION_OWNER_NAME");
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				status = "[영업기회 WIN PLAN] -'"+trackingDataMap.get("ACTION_PLAN_NAME")+"' 해결 목표일이 "+calDateDays+"일 경과되었습니다.";
			}else if(dueDate.compareTo(todayDate) == 0){
				status = "[영업기회 WIN PLAN] -'"+trackingDataMap.get("ACTION_PLAN_NAME")+"' 해결 목표일이 오늘까지 입니다.";
			}else if((dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate))){
				status = "[영업기회 WIN PLAN] -'"+trackingDataMap.get("ACTION_PLAN_NAME")+"' 해결 목표일이 "+(-calDateDays)+"일 남았습니다.";
			}
		}else if("4".equals(trackingCategory)){ //영업기회 계약일 tracking
			eventId = trackingDataMap.get("OPPORTUNITY_ID").toString();
			URL = "/clientSalesActive/viewOpportunityList.do?&opportunity_id="+trackingDataMap.get("OPPORTUNITY_ID");
			
			noticeCode = "영업기회 계약일";
			noticeCategory = "TRACKING";
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-'"+"<br /> ※계약일 D+"+calDateDays+"일!!!";
				noticeDetail2 = "'"+trackingDataMap.get("SUBJECT")+"-'"+" ※계약일 D+"+calDateDays+"일!!!";
				OVER_DUE_FLAG = (int)calDateDays;
			}else if(dueDate.compareTo(todayDate) == 0){ //해결 목표일 == 당일
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-'"+" ※계약일 D-Day!!!";
				noticeDetail2 = "'"+trackingDataMap.get("SUBJECT")+"-'"+" ※계약일 D-Day!!!";
				OVER_DUE_FLAG = 0;
			}else if( (dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate)) ){
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-'"+"<br /> ※계약일 D-"+(-calDateDays)+"일!!!";
				noticeDetail2 = "'"+trackingDataMap.get("SUBJECT")+"-'"+" ※계약일 D-"+(-calDateDays)+"일!!!";
				OVER_DUE_FLAG = 0;
			}
			
			menuName = "영업기회";
			eventSubject = (String) trackingDataMap.get("SUBJECT");
			delayItem = "계약일";
			status = "";
			ownerName = (String) trackingDataMap.get("IDENTIFIER_NAME");
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				status = "[영업기회] -'"+trackingDataMap.get("SUBJECT")+"' 계약일이 "+calDateDays+"일 경과되었습니다.";
			}else if(dueDate.compareTo(todayDate) == 0){
				status = "[영업기회] -'"+trackingDataMap.get("SUBJECT")+"' 계약일이 오늘까지 입니다.";
			}else if((dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate))){
				status = "[영업기회] -'"+trackingDataMap.get("SUBJECT")+"' 계약일이 "+(-calDateDays)+"일 남았습니다.";
			}
		}else if("7".equals(trackingCategory)){ //잠재영업기회 액션플랜 해결목표일 tracking
			eventId = trackingDataMap.get("OPPORTUNITY_HIDDEN_ID").toString();
			URL = "/clientSalesActive/viewHiddenOpportunityList.do?&opportunity_hidden_id="+trackingDataMap.get("OPPORTUNITY_HIDDEN_ID");
			
			noticeCode = "잠재영업기회 ACTION-PLAN";
			noticeCategory = "TRACKING";
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("DETAIL_CONENTS")+"'"+"<br /> ※해결 목표일 D+"+calDateDays+"일!!!";
				OVER_DUE_FLAG = (int)calDateDays;
			}else if(dueDate.compareTo(todayDate) == 0){ //해결 목표일 == 당일
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("DETAIL_CONENTS")+"'"+"<br /> ※해결 목표일 D-Day!!!";
				OVER_DUE_FLAG = 0;
			}else if( (dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate)) ){
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("DETAIL_CONENTS")+"'"+"<br /> ※해결 목표일 D-"+(-calDateDays)+"일!!!";
				OVER_DUE_FLAG = 0;
			}
			
			menuName = "잠재영업기회";
			eventSubject = (String) trackingDataMap.get("SUBJECT");
			delayItem = "Action Plan";
			delayItemDetail = (String) trackingDataMap.get("DETAIL_CONENTS");
			status = "";
			ownerName = (String) trackingDataMap.get("ACTION_OWNER");
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				status = "[잠재영업기회 ACTION PLAN] -'"+trackingDataMap.get("DETAIL_CONENTS")+"' 해결 목표일이 "+calDateDays+"일 경과되었습니다.";
			}else if(dueDate.compareTo(todayDate) == 0){
				status = "[잠재영업기회 ACTION PLAN] -'"+trackingDataMap.get("DETAIL_CONENTS")+"' 해결 목표일이 오늘까지 입니다.";
			}else if((dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate))){
				status = "[잠재영업기회 ACTION PLAN] -'"+trackingDataMap.get("DETAIL_CONENTS")+"' 해결 목표일이 "+(-calDateDays)+"일 남았습니다.";
			}
		}else if("8".equals(trackingCategory)){ //고객이슈 해결목표일 tracking
			eventId = trackingDataMap.get("ISSUE_ID").toString();
			URL = "/clientSatisfaction/viewClientIssueList.do?&issueId="+trackingDataMap.get("ISSUE_ID");
			
			noticeCode = "고객이슈";
			noticeCategory = "TRACKING";
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				noticeDetail = "'"+trackingDataMap.get("ISSUE_SUBJECT")+"'"+"<br /> ※해결 목표일 D+"+calDateDays+"일!!!";
				OVER_DUE_FLAG = (int)calDateDays;
			}else if(dueDate.compareTo(todayDate) == 0){ //해결 목표일 == 당일
				noticeDetail = "'"+trackingDataMap.get("ISSUE_SUBJECT")+"'"+"<br /> ※해결 목표일 D-Day!!!";
				OVER_DUE_FLAG = 0;
			}else if( (dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate)) ){
				noticeDetail = "'"+trackingDataMap.get("ISSUE_SUBJECT")+"'"+"<br /> ※해결 목표일 D-"+(-calDateDays)+"일!!!";
				OVER_DUE_FLAG = 0;
			}
			
			menuName = "고객이슈";
			eventSubject = (String) trackingDataMap.get("ISSUE_SUBJECT");
			delayItem = "이슈";
			delayItemDetail = (String) trackingDataMap.get("ISSUE_DETAIL");
			status = "";
			ownerName = (String) trackingDataMap.get("SOLVE_OWNER_NAME");
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				status = "'"+trackingDataMap.get("ISSUE_SUBJECT")+"' 해결 목표일이 "+calDateDays+"일 경과되었습니다.";
			}else if(dueDate.compareTo(todayDate) == 0){
				status = "'"+trackingDataMap.get("ISSUE_SUBJECT")+"' 해결 목표일이 오늘까지 입니다.";
			}else if((dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate))){
				status = "'"+trackingDataMap.get("ISSUE_SUBJECT")+"' 해결 목표일 "+(-calDateDays)+"일 남았습니다.";
			}
		}else if("9".equals(trackingCategory)){ //고객이슈_액션플랜 해결목표일 tracking
			eventId = trackingDataMap.get("ISSUE_ID").toString();
			URL = "/clientSatisfaction/viewClientIssueList.do?&issueId="+trackingDataMap.get("ISSUE_ID");
			
			noticeCode = "고객이슈 해결계획";
			noticeCategory = "TRACKING";
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				noticeDetail = "'"+trackingDataMap.get("ISSUE_SUBJECT")+"-"+trackingDataMap.get("SOLVE_PLAN")+"'"+"<br /> ※해결 목표일 D+"+calDateDays+"일!!!";
				OVER_DUE_FLAG = (int)calDateDays;
			}else if(dueDate.compareTo(todayDate) == 0){ //해결 목표일 == 당일
				noticeDetail = "'"+trackingDataMap.get("ISSUE_SUBJECT")+"-"+trackingDataMap.get("SOLVE_PLAN")+"'"+"<br /> ※해결 목표일 D-Day!!!";
				OVER_DUE_FLAG = 0;
			}else if( (dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate)) ){
				noticeDetail = "'"+trackingDataMap.get("ISSUE_SUBJECT")+"-"+trackingDataMap.get("SOLVE_PLAN")+"'"+"<br /> ※해결 목표일 D-"+(-calDateDays)+"일!!!";
				OVER_DUE_FLAG = 0;
			}
			
			menuName = "고객이슈";
			eventSubject = (String) trackingDataMap.get("ISSUE_SUBJECT");
			delayItem = "이슈해결계획";
			delayItemDetail = (String) trackingDataMap.get("SOLVE_PLAN");
			status = "";
			ownerName = (String) trackingDataMap.get("SOLVE_OWNER_NAME");
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				status = "[이슈해결계획] -'"+trackingDataMap.get("SOLVE_PLAN")+"' 해결 목표일이 "+calDateDays +"일 경과되었습니다.";
			}else if(dueDate.compareTo(todayDate) == 0){
				status = "[이슈해결계획] -'"+trackingDataMap.get("SOLVE_PLAN")+"' 해결 목표일이 오늘까지 입니다.";
			}else if((dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate))){
				status = "[이슈해결계획] -'"+trackingDataMap.get("SOLVE_PLAN")+"' 해결 목표일이 "+(-calDateDays)+"일 남았습니다.";
			}
		}else if("10".equals(trackingCategory)){ //고객만족도_팔로업액션 해결목표일 tracking
			eventId = trackingDataMap.get("CSAT_ID").toString();
			URL = "/clientSatisfaction/viewClientSatisfactionList.do?&returnCSatId="+trackingDataMap.get("CSAT_ID");
			
			noticeCode = "고객만족도 FOLLOW-UP-ACTION";
			noticeCategory = "TRACKING";
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				noticeDetail = "'"+trackingDataMap.get("CSAT_ACTION_DETAIL")+"'"+"<br /> ※해결 목표일 D+"+calDateDays+"일!!!";
				OVER_DUE_FLAG = (int)calDateDays;
			}else if(dueDate.compareTo(todayDate) == 0){ //해결 목표일 == 당일
				noticeDetail = "'"+trackingDataMap.get("CSAT_ACTION_DETAIL")+"'"+"<br /> ※해결 목표일 D-Day!!!";
				OVER_DUE_FLAG = 0;
			}else if( (dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate)) ){
				noticeDetail = "'"+trackingDataMap.get("CSAT_ACTION_DETAIL")+"'"+"<br /> ※해결 목표일 D- "+(-calDateDays)+"일!!!";
				OVER_DUE_FLAG = 0;
			}
			
			menuName = "고객만족도";
			eventSubject = (String) trackingDataMap.get("CSAT_SUBJECT");
			delayItem = "Follow Up Action";
			delayItemDetail = (String) trackingDataMap.get("CSAT_ACTION_DETAIL");
			status = "";
			ownerName = (String) trackingDataMap.get("SOLVE_OWNER");
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				status = "[고객만족도 FollowUpAction] -'"+trackingDataMap.get("CSAT_ACTION_DETAIL")+"' 해결 목표일이 "+calDateDays+"일 경과되었습니다.";
			}else if(dueDate.compareTo(todayDate) == 0){
				status = "[고객만족도 FollowUpAction] -'"+trackingDataMap.get("CSAT_ACTION_DETAIL")+"' 해결 목표일이 오늘까지 입니다.";
			}else if((dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate))){
				status = "[고객만족도 FollowUpAction] -'"+trackingDataMap.get("CSAT_ACTION_DETAIL")+"' 해결 목표일이 "+(-calDateDays)+"일 남았습니다.";
			}
		}else if("11".equals(trackingCategory)){ //서비스프로젝트_마일스톤 해결목표일 tracking
			eventId = trackingDataMap.get("PROJECT_ID").toString();
			URL = "/clientSatisfaction/viewServiceProject.do?&returnProjectMGMTId="+trackingDataMap.get("PROJECT_ID");
			
			noticeCode = "서비스프로젝트 MILESTONE";
			noticeCategory = "TRACKING";
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				noticeDetail = "'"+trackingDataMap.get("PROJECT_SUBJECT")+"-"+trackingDataMap.get("CATEGORY")+"'"+"<br /> ※해결 목표일 D+"+calDateDays+"일!!!";
				OVER_DUE_FLAG = (int)calDateDays;
			}else if(dueDate.compareTo(todayDate) == 0){ //해결 목표일 == 당일
				noticeDetail = "'"+trackingDataMap.get("PROJECT_SUBJECT")+"-"+trackingDataMap.get("CATEGORY")+"'"+"<br /> ※해결 목표일 D-Day!!!";
				OVER_DUE_FLAG = 0;
			}else if( (dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate)) ){
				noticeDetail = "'"+trackingDataMap.get("PROJECT_SUBJECT")+"-"+trackingDataMap.get("CATEGORY")+"'"+"<br /> ※해결 목표일 D-"+(-calDateDays)+"일!!!";
				OVER_DUE_FLAG = 0;
			}
			
			menuName = "서비스프로젝트";
			eventSubject = (String) trackingDataMap.get("PROJECT_SUBJECT");
			delayItem = "MileStone";
			delayItemDetail = (String) trackingDataMap.get("CATEGORY");
			status = "";
			ownerName = (String) trackingDataMap.get("OUR_EXEC_PM_NAME");
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				status = "[서비스프로젝트 Milestone] -'"+trackingDataMap.get("CATEGORY")+"' 해결 목표일이 "+calDateDays+"일 경과되었습니다.";
			}else if(dueDate.compareTo(todayDate) == 0){
				status = "[서비스프로젝트 Milestone] -'"+trackingDataMap.get("CATEGORY")+"' 해결 목표일이 오늘까지 입니다.";
			}else if((dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate))){
				status = "[서비스프로젝트 Milestone] -'"+trackingDataMap.get("CATEGORY")+"' 해결 목표일이 "+(-calDateDays)+"일 남았습니다.";
			}
		}else if("12".equals(trackingCategory)){ //서비스프로젝트_이슈 해결목표일 tracking
			eventId = trackingDataMap.get("PROJECT_ID").toString();
			URL = "/clientSatisfaction/viewServiceProject.do?&returnProjectMGMTId="+trackingDataMap.get("PROJECT_ID");

			noticeCode = "서비스프로젝트 ISSUE";
			noticeCategory = "TRACKING";
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				noticeDetail = "'"+trackingDataMap.get("PROJECT_SUBJECT")+"-"+trackingDataMap.get("ISSUE_DETAIL")+"'"+"<br /> ※해결 목표일 D+"+calDateDays+"일!!!";
				OVER_DUE_FLAG = (int)calDateDays;
			}else if(dueDate.compareTo(todayDate) == 0){ //해결 목표일 == 당일
				noticeDetail = "'"+trackingDataMap.get("PROJECT_SUBJECT")+"-"+trackingDataMap.get("ISSUE_DETAIL")+"'"+"<br /> ※해결 목표일 D-Day!!!";
				OVER_DUE_FLAG = 0;
			}else if( (dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate)) ){
				noticeDetail = "'"+trackingDataMap.get("PROJECT_SUBJECT")+"-"+trackingDataMap.get("ISSUE_DETAIL")+"'"+"<br /> ※해결 목표일 D-"+(-calDateDays)+"일!!!";
				OVER_DUE_FLAG = 0;
			}
			
			menuName = "서비스프로젝트";
			eventSubject = (String) trackingDataMap.get("PROJECT_SUBJECT");
			delayItem = "ISSUE";
			delayItemDetail = (String) trackingDataMap.get("DETAIL_CONTENTS");
			status = "";
			ownerName = (String) trackingDataMap.get("SOLVE_OWNER");
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				status = "[서비스프로젝트 ISSUE] -'"+trackingDataMap.get("ISSUE_DETAIL")+"' 해결 목표일이 "+calDateDays+"일 경과하였습니다.";
			}else if(dueDate.compareTo(todayDate) == 0){
				status = "[서비스프로젝트 ISSUE] -'"+trackingDataMap.get("ISSUE_DETAIL")+"' 해결 목표일이 오늘까지 입니다.";
			}else if((dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate))){
				status = "[서비스프로젝트 ISSUE] -'"+trackingDataMap.get("ISSUE_DETAIL")+"' 해결 목표일이 "+(-calDateDays)+"일 남았습니다.";
			}
		}else if("13".equals(trackingCategory)){ //제안발표_제출일 tracking
			eventId = trackingDataMap.get("PROPOSAL_ID").toString();
			URL = "/salesManagement/viewProposalsInfoList.do?&proposal_id="+trackingDataMap.get("PROPOSAL_ID");
			
			noticeCode = "제안서 제출일";
			noticeCategory = "TRACKING";
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				noticeDetail = "'"+trackingDataMap.get("PROPOSAL_SUBJECT")+"'"+"<br /> ※"+noticeCode+" D+"+calDateDays+"일!!!";
				OVER_DUE_FLAG = (int)calDateDays;
			}else if(dueDate.compareTo(todayDate) == 0){ //해결 목표일 == 당일
				noticeDetail = "'"+trackingDataMap.get("PROPOSAL_SUBJECT")+"'"+"<br /> ※"+noticeCode+" D-Day!!!";
				OVER_DUE_FLAG = 0;
			}else if( (dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate)) ){
				noticeDetail = "'"+trackingDataMap.get("PROPOSAL_SUBJECT")+"'"+"<br /> ※"+noticeCode+" D-"+(-calDateDays)+"일!!!";
				OVER_DUE_FLAG = 0;
			}
			
			menuName = "제안서정보";
			eventSubject = (String) trackingDataMap.get("PROPOSAL_SUBJECT");
			delayItem = "제출일";
			delayItemDetail = (String) trackingDataMap.get("DETAIL_CONTENTS");
			status = "";
			ownerName = (String) trackingDataMap.get("HAN_NAME");
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				status = "[제안서정보 제출일] -'"+trackingDataMap.get("PROPOSAL_SUBJECT")+"' 제출일이 "+calDateDays+"일 경과하였습니다.";
			}else if(dueDate.compareTo(todayDate) == 0){
				status = "[제안서정보 제출일] -'"+trackingDataMap.get("PROPOSAL_SUBJECT")+"' 제출일이 오늘까지 입니다.";
			}else if((dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate))){
				status = "[제안서정보 제출일] -'"+trackingDataMap.get("PROPOSAL_SUBJECT")+"' 제출일이 "+(-calDateDays)+"일 남았습니다.";
			}
		}else if("14".equals(trackingCategory)){ //제안발표_발표일 tracking
			eventId = trackingDataMap.get("PROPOSAL_ID").toString();
			URL = "/salesManagement/viewProposalsInfoList.do?&=proposal_id"+trackingDataMap.get("PROPOSAL_ID");
			
			noticeCode = "제안서 제안발표일";
			noticeCategory = "TRACKING";
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				noticeDetail = "'"+trackingDataMap.get("PROPOSAL_SUBJECT")+"'"+"<br /> ※"+noticeCode+" D+"+calDateDays+"일!!!";
				OVER_DUE_FLAG = (int)calDateDays;
			}else if(dueDate.compareTo(todayDate) == 0){ //해결 목표일 == 당일
				noticeDetail = "'"+trackingDataMap.get("PROPOSAL_SUBJECT")+"'"+"<br /> ※"+noticeCode+" D-Day!!!";
				OVER_DUE_FLAG = 0;
			}else if( (dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate)) ){
				noticeDetail = "'"+trackingDataMap.get("PROPOSAL_SUBJECT")+"'"+"<br /> ※"+noticeCode+" D-"+(-calDateDays)+"일!!!";
				OVER_DUE_FLAG = 0;
			}
			
			menuName = "제안서정보";
			eventSubject = (String) trackingDataMap.get("PROPOSAL_SUBJECT");
			delayItem = "제안발표일";
			delayItemDetail = (String) trackingDataMap.get("DETAIL_CONTENTS");
			status = "";
			ownerName = (String) trackingDataMap.get("HAN_NAME");
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				status = "[제안서정보 제안발표일] -'"+trackingDataMap.get("PROPOSAL_SUBJECT")+"' 제안발표일이 "+calDateDays+"일 경과하였습니다.";
			}else if(dueDate.compareTo(todayDate) == 0){
				status = "[제안서정보 제안발표일] -'"+trackingDataMap.get("PROPOSAL_SUBJECT")+"' 제안발표일이 오늘까지 입니다.";
			}else if((dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate))){
				status = "[제안서정보 제안발표일] -'"+trackingDataMap.get("PROPOSAL_SUBJECT")+"' 제안발표일이 "+(-calDateDays)+"일 남았습니다.";
			}
		}else if("15".equals(trackingCategory)){ //제안발표_결과일 tracking
			eventId = trackingDataMap.get("PROPOSAL_ID").toString();
			URL = "/salesManagement/viewProposalsInfoList.do?&proposal_id="+trackingDataMap.get("PROPOSAL_ID");
			
			noticeCode = "제안서 결과발표일";
			noticeCategory = "TRACKING";
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				noticeDetail = "'"+trackingDataMap.get("PROPOSAL_SUBJECT")+"'"+"<br /> ※"+noticeCode+" D+"+calDateDays+"일!!!";
				OVER_DUE_FLAG = (int)calDateDays;
			}else if(dueDate.compareTo(todayDate) == 0){ //해결 목표일 == 당일
				noticeDetail = "'"+trackingDataMap.get("PROPOSAL_SUBJECT")+"'"+"<br /> ※"+noticeCode+" D-Day!!!";
				OVER_DUE_FLAG = 0;
			}else if( (dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate)) ){
				noticeDetail = "'"+trackingDataMap.get("PROPOSAL_SUBJECT")+"'"+"<br /> ※"+noticeCode+" D-"+(-calDateDays)+"일!!!";
				OVER_DUE_FLAG = 0;
			}
			
			menuName = "제안서정보";
			eventSubject = (String) trackingDataMap.get("PROPOSAL_SUBJECT");
			delayItem = "결과발표일";
			delayItemDetail = (String) trackingDataMap.get("DETAIL_CONTENTS");
			status = "";
			ownerName = (String) trackingDataMap.get("HAN_NAME");
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				status = "[제안서정보 결과발표일] -'"+trackingDataMap.get("PROPOSAL_SUBJECT")+"' 결과발표일이 "+calDateDays+"일 경과하였습니다.";
			}else if(dueDate.compareTo(todayDate) == 0){
				status = "[제안서정보 결과발표일] -'"+trackingDataMap.get("PROPOSAL_SUBJECT")+"' 결과발표일이 오늘까지 입니다.";
			}else if((dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate))){
				status = "[제안서정보 결과발표일] -'"+trackingDataMap.get("PROPOSAL_SUBJECT")+"' 결과발표일이 "+(-calDateDays)+"일 남았습니다.";
			}
		}else if("16".equals(trackingCategory)){ //회사/부문전략_키마일스톤 목표일 tracking
			//전략 카테고리
			int category = 1;
			switch (trackingDataMap.get("CATEGORY").toString()) {
			case "회사전략":
				category = 1;
				break;
			case "본부전략":
				category = 3;
				break;
			case "팀전략":
				category = 4;
				break;
			}
			
			eventId = trackingDataMap.get("BIZ_ID").toString();
			URL = "/bizStrategy/viewBizStrategyCompany.do?&bizId="+trackingDataMap.get("BIZ_ID")+"&searchCategory="+category;
			
			noticeCode = "회사/부문별전략 KEY-MILESTONE";
			noticeCategory = "TRACKING";
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("KEY_MILESTONE")+"'"+"<br /> ※해결 목표일 D+"+calDateDays+"일!!!";
				OVER_DUE_FLAG = (int)calDateDays;
			}else if(dueDate.compareTo(todayDate) == 0){ //해결 목표일 == 당일
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("KEY_MILESTONE")+"'"+"<br /> ※해결 목표일 D-Day!!!";
				OVER_DUE_FLAG = 0;
			}else if( (dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate)) ){
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("KEY_MILESTONE")+"'"+"<br /> ※해결 목표일 D-"+(-calDateDays)+"일!!!";
				OVER_DUE_FLAG = 0;
			}
			
			menuName = "회사/부문별전략";
			eventSubject = (String) trackingDataMap.get("SUBJECT");
			delayItem = "Key MileStones";
			delayItemDetail = (String) trackingDataMap.get("KEY_MILESTONE");
			status = "";
			ownerName = (String) trackingDataMap.get("RESPONSIBILITY_LEADER_NAME");
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				status = "[회사/부문별 Key Milestones] -'"+trackingDataMap.get("KEY_MILESTONE")+"' 해결 목표일이"+calDateDays+"일 경과 되었습니다.";
			}else if(dueDate.compareTo(todayDate) == 0){
				status = "[회사/부문별 Key Milestones] -'"+trackingDataMap.get("KEY_MILESTONE")+"' 해결 목표일이 오늘까지 입니다.";
			}else if((dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate))){
				status = "[회사/부문별 Key Milestones] -'"+trackingDataMap.get("KEY_MILESTONE")+"' 해결 목표일이 "+(-calDateDays)+"일 남았습니다.";
			}
		}else if("17".equals(trackingCategory)){ //회사/부문전략_이슈 해결목표일 tracking
			//전략 카테고리
			int category = 1;
			switch (trackingDataMap.get("CATEGORY").toString()) {
			case "회사전략":
				category = 1;
				break;
			case "본부전략":
				category = 3;
				break;
			case "팀전략":
				category = 4;
				break;
			}
			
			eventId = trackingDataMap.get("BIZ_ID").toString();
			URL = "/bizStrategy/viewBizStrategyCompany.do?&bizId="+trackingDataMap.get("BIZ_ID")+"&searchCategory="+category;
			
			noticeCode = "회사/부문별전략 ISSUE";
			noticeCategory = "TRACKING";
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("ACTION_PLAN_NAME")+"'"+"<br /> ※해결 목표일 D+"+calDateDays+"일!!!";
				OVER_DUE_FLAG = (int)calDateDays;
			}else if(dueDate.compareTo(todayDate) == 0){ //해결 목표일 == 당일
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("ACTION_PLAN_NAME")+"'"+"<br /> ※해결 목표일 D-Day!!!";
				OVER_DUE_FLAG = 0;
			}else if( (dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate)) ){
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("ACTION_PLAN_NAME")+"'"+"<br /> ※해결 목표일 D-"+(-calDateDays)+"일!!!";
				OVER_DUE_FLAG = 0;
			}
			
			menuName = "회사/부문별전략";
			eventSubject = (String) trackingDataMap.get("SUBJECT");
			delayItem = "이슈 해결계획";
			delayItemDetail = (String) trackingDataMap.get("ACTION_PLAN_NAME");
			status = "";
			ownerName = (String) trackingDataMap.get("ACTION_OWNER");
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				status = "[회사/부문별 Issue] -'"+trackingDataMap.get("ACTION_PLAN_NAME")+"' 해결 목표일이 "+calDateDays+"일 경과 되었습니다.";
			}else if(dueDate.compareTo(todayDate) == 0){
				status = "[회사/부문별 Issue] -'"+trackingDataMap.get("ACTION_PLAN_NAME")+"' 해결 목표일이 오늘까지 입니다";
			}else if((dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate))){
				status = "[회사/부문별 Issue] -'"+trackingDataMap.get("ACTION_PLAN_NAME")+"' 해결 목표일이 "+(-calDateDays)+"일 남았습니다.";
			}
		}else if("18".equals(trackingCategory)){ //고객전략_키마일스톤 목표일 tracking
			eventId = trackingDataMap.get("BIZ_ID").toString();
			URL = "/bizStrategy/viewBizStrategyClient.do?&bizId="+trackingDataMap.get("BIZ_ID");
			
			noticeCode = "고객별전략 KEY-MILESTONE";
			noticeCategory = "TRACKING";
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("KEY_MILESTONE")+"'"+"<br /> ※해결 목표일 D+"+calDateDays+"일!!!";
				OVER_DUE_FLAG = (int)calDateDays;
			}else if(dueDate.compareTo(todayDate) == 0){ //해결 목표일 == 당일
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("KEY_MILESTONE")+"'"+"<br /> ※해결 목표일 D-Day!!!";
				OVER_DUE_FLAG = 0;
			}else if( (dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate)) ){
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("KEY_MILESTONE")+"'"+"<br /> ※해결 목표일 D-"+(-calDateDays)+"일!!!";
				OVER_DUE_FLAG = 0;
			}
			
			menuName = "고객별전략";
			eventSubject = (String) trackingDataMap.get("SUBJECT");
			delayItem = "Key MileStones";
			delayItemDetail = (String) trackingDataMap.get("KEY_MILESTONE");
			status = "";
			ownerName = (String) trackingDataMap.get("ACT_NAME");
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				status = "[고객별전략 MILESTONE] -'"+trackingDataMap.get("KEY_MILESTONE")+"' 해결 목표일이 "+calDateDays+"일 경과 되었습니다.";
			}else if(dueDate.compareTo(todayDate) == 0){
				status = "[고객별전략 MILESTONE] -'"+trackingDataMap.get("KEY_MILESTONE")+"' 해결 목표일이 오늘까지 입니다";
			}else if((dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate))){
				status = "[고객별전략 MILESTONE] -'"+trackingDataMap.get("KEY_MILESTONE")+"' 해결 목표일이 "+(-calDateDays)+"일 남았습니다.";
			}
		}else if("19".equals(trackingCategory)){ //고객전략_이슈 해결목표일 tracking
			eventId = trackingDataMap.get("BIZ_ID").toString();
			URL = "/bizStrategy/viewBizStrategyClient.do?&bizId="+trackingDataMap.get("BIZ_ID");

			noticeCode = "고객별전략 ISSUE";
			noticeCategory = "TRACKING";
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("ACTION_PLAN_NAME")+"'"+"<br /> ※해결 목표일 D+"+calDateDays+"일!!!";
				OVER_DUE_FLAG = (int)calDateDays;
			}else if(dueDate.compareTo(todayDate) == 0){ //해결 목표일 == 당일
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("ACTION_PLAN_NAME")+"'"+"<br /> ※해결 목표일 D-Day!!!";
				OVER_DUE_FLAG = 0;
			}else if( (dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate)) ){
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("ACTION_PLAN_NAME")+"'"+"<br /> ※해결 목표일 D-"+(-calDateDays)+"일!!!";
				OVER_DUE_FLAG = 0;
			}
			
			menuName = "고객별전략";
			eventSubject = (String) trackingDataMap.get("SUBJECT");
			delayItem = "ISSUE";
			delayItemDetail = (String) trackingDataMap.get("ACTION_PLAN_NAME");
			status = "";
			ownerName = (String) trackingDataMap.get("ACTION_OWNER");
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				status = "[고객별전략 ISSUE] -'"+trackingDataMap.get("ACTION_PLAN_NAME")+"' 해결 목표일이 "+calDateDays+"일 경과되었습니다.";
			}else if(dueDate.compareTo(todayDate) == 0){
				status = "[고객별전략 ISSUE] -'"+trackingDataMap.get("ACTION_PLAN_NAME")+"' 해결 목표일이 오늘가지 입니다.";
			}else if((dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate))){
				status = "[고객별전략 ISSUE] -'"+trackingDataMap.get("ACTION_PLAN_NAME")+"' 해결 목표일이 "+(-calDateDays)+"일 남았습니다.";
			}
		}else if("20".equals(trackingCategory)){ //전략프로젝트_마일스톤 해결목표일 tracking
			eventId = trackingDataMap.get("PROJECT_ID").toString();
			URL = "/bizStrategy/viewBizStrategyProjectPlan.do?&bizProjectId="+trackingDataMap.get("PROJECT_ID");

			noticeCode = "전략프로젝트 MILESTONE";
			noticeCategory = "TRACKING";
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("KEY_MILESTONE")+"'"+"<br /> ※해결 목표일 D+"+calDateDays+"일!!!";
				OVER_DUE_FLAG = (int)calDateDays;
			}else if(dueDate.compareTo(todayDate) == 0){ //해결 목표일 == 당일
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("KEY_MILESTONE")+"'"+"<br /> ※해결 목표일 D-Day!!!";
				OVER_DUE_FLAG = 0;
			}else if( (dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate)) ){
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("KEY_MILESTONE")+"'"+"<br /> ※해결 목표일 D-"+(-calDateDays)+"일!!!";
				OVER_DUE_FLAG = 0;
			}
			
			menuName = "전략프로젝트";
			eventSubject = (String) trackingDataMap.get("SUBJECT");
			delayItem = "MileStone";
			delayItemDetail = (String) trackingDataMap.get("KEY_MILESTONE");
			status = "";
			ownerName = (String) trackingDataMap.get("ACT_NAME");
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				status = "[전략프로젝트 Milestone] -'"+trackingDataMap.get("KEY_MILESTONE")+"' 해결 목표일이 "+calDateDays+"일 경과 되었습니다.";
			}else if(dueDate.compareTo(todayDate) == 0){
				status = "[전략프로젝트 MILESTONE] -'"+trackingDataMap.get("KEY_MILESTONE")+"' 해결 목표일이 오늘까지 입니다";
			}else if((dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate))){
				status = "[전략프로젝트 MILESTONE] -'"+trackingDataMap.get("KEY_MILESTONE")+"' 해결 목표일이 "+(-calDateDays)+"일 남았습니다.";
			}
		}else if("21".equals(trackingCategory)){ //전략프로젝트_이슈 해결목표일 tracking
			eventId = trackingDataMap.get("PROJECT_ID").toString();
			URL = "/bizStrategy/viewBizStrategyProjectPlan.do?&bizProjectId="+trackingDataMap.get("PROJECT_ID");

			noticeCode = "전략프로젝트 ISSUE";
			noticeCategory = "TRACKING";
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("ACTION_PLAN_NAME")+"'"+"<br /> ※해결 목표일 D+"+calDateDays+"일!!!";
				OVER_DUE_FLAG = (int)calDateDays;
			}else if(dueDate.compareTo(todayDate) == 0){ //해결 목표일 == 당일
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("ACTION_PLAN_NAME")+"'"+"<br /> ※해결 목표일 D-Day!!!";
				OVER_DUE_FLAG = 0;
			}else if( (dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate)) ){
				noticeDetail = "'"+trackingDataMap.get("SUBJECT")+"-"+trackingDataMap.get("ACTION_PLAN_NAME")+"'"+"<br /> ※해결 목표일 D-"+(-calDateDays)+"일!!!";
				OVER_DUE_FLAG = 0;
			}
			
			menuName = "전략프로젝트";
			eventSubject = (String) trackingDataMap.get("SUBJECT");
			delayItem = "ISSUE";
			delayItemDetail = (String) trackingDataMap.get("ACTION_PLAN_NAME");
			status = "";
			ownerName = (String) trackingDataMap.get("ACTION_OWNER");
			
			if(dueDate.compareTo(todayDate) < 0 && calDateDays <= Integer.parseInt(afterDueDate) && calDateDays > 0){
				status = "[전략프로젝트 ISSUE] -'"+trackingDataMap.get("ACTION_PLAN_NAME")+"' 해결 목표일이 "+calDateDays+"일 경과 되었습니다.";
			}else if(dueDate.compareTo(todayDate) == 0){
				status = "[전략프로젝트 ISSUE] -'"+trackingDataMap.get("ACTION_PLAN_NAME")+"' 해결 목표일이 오늘까지 입니다.";
			}else if((dueDate.compareTo(afterDay) <= 0 && calDateDays <= Integer.parseInt(afterDueDate))){
				status = "[전략프로젝트 ISSUE] -'"+trackingDataMap.get("ACTION_PLAN_NAME")+"' 해결 목표일이 "+(-calDateDays)+"일 남았습니다.";
			}
		}
		// ============ 데이터 공통화 및 세팅 end ============
			
		if("Y".equals(trackingOptionMap.get("ALARM_USE_YN"))){ //알람 메세지 전송 데이터 세팅
			Map<String, Object> alarmMap = new HashMap<String, Object>();
			
			alarmMap.put("noticeCategory", noticeCategory);
			alarmMap.put("shareURL", URL);
			alarmMap.put("hiddenModalEventId", eventId);
			alarmMap.put("noticeCode", noticeCode);
			alarmMap.put("noticeDetail", noticeDetail);
			alarmMap.put("OVER_DUE_FLAG", OVER_DUE_FLAG);
			alarmMap.put("memberID", meberIdNum);
			
			if("4".equals(trackingCategory)){ //영업기회 계약일
				alarmMap.put("noticeDetail2", noticeDetail);
			}
			
			trackingDAO.insertNotice(alarmMap);
		}
		
		if("Y".equals(trackingOptionMap.get("MAIL_USE_YN"))){ //메일 전송 데이터 세팅
			ArrayList<Object> toAddr = new ArrayList<>();
			Map<String, Object> userMap = new HashMap<String, Object>();
			Map<String, Object> emailInfoMap = new HashMap<String, Object>();
			
			userMap.clear();
			userMap.put("MEMBER_ID_NUM", meberIdNum);
			List<Map<String, Object>> mailList = trackingDAO.selectOuruserInfo(userMap);
			String userEmail = "";
			if(null != mailList.get(0).get("EMAIL")) userEmail = mailList.get(0).get("EMAIL").toString();
			toAddr.add(userEmail);
			
			emailInfoMap.put("status", status);
			
			emailInfoMap.put("fromMail", trackingSendMail);
			emailInfoMap.put("fromMailName", trackingSendMailName);
			emailInfoMap.put("menuName", menuName);
			emailInfoMap.put("eventSubject", eventSubject);
			emailInfoMap.put("delayItem", delayItem);
			emailInfoMap.put("delayItemDetail", delayItemDetail);
			emailInfoMap.put("dueDate", dueDate);
			emailInfoMap.put("ownerName", ownerName);
			emailInfoMap.put("linkURL", URL);
			
			if("1".equals(trackingCategory)){ //고객컨택 팔로업액션 해결목표일
				emailInfoMap.put("position", trackingDataMap.get("POSITION_STATUS"));
				emailInfoMap.put("clientInfos", trackingDataMap.get("CUSTOMER_INFOS"));
				
				commonMailService.trackingTestSendMail(emailInfoMap, toAddr); //메일 보내기.
			}else if("2".equals(trackingCategory)){ //영업기회 마일스톤 목표일
				emailInfoMap.put("clientCompanyName", trackingDataMap.get("COMPANY_NAME"));
				emailInfoMap.put("clientIndividualName", trackingDataMap.get("END_USER"));
				emailInfoMap.put("position", trackingDataMap.get("POSITION_STATUS"));
				
				commonMailService.trackingMenuOpportunityMilestonesSendMail(emailInfoMap, toAddr); //메일 보내기.
			}else if("3".equals(trackingCategory)){ //영업기회 윈플랜 목표일
				emailInfoMap.put("clientCompanyName", trackingDataMap.get("COMPANY_NAME"));
				emailInfoMap.put("clientIndividualName", trackingDataMap.get("CUSTOMER_NAME"));
				emailInfoMap.put("position", trackingDataMap.get("ACTION_OWNER_POSITION"));
				emailInfoMap.put("clientInfos", trackingDataMap.get("COMPANY_NAME"));
				
				commonMailService.trackingTestSendMail(emailInfoMap, toAddr); //메일 보내기.
			}else if("4".equals(trackingCategory)){ //영업기회 계약일
				emailInfoMap.put("clientCompanyName", trackingDataMap.get("END_CLIENT_NAME"));
				emailInfoMap.put("clientIndividualName", trackingDataMap.get("SALES_COMPANY_NAME"));
				emailInfoMap.put("position", trackingDataMap.get("IDENTIFIER_POSITION"));
				emailInfoMap.put("contractAmount", trackingDataMap.get("CONTRACT_AMOUNT"));
				emailInfoMap.put("contractDate", CommonDateUtils.dateToString((Date) trackingDataMap.get("CONTRACT_DATE")));
				
				commonMailService.trackingMenuOpportunityContractDateSendMail(emailInfoMap, toAddr); //메일 보내기.
			}else if("7".equals(trackingCategory)){ //잠재영업기회 액션플랜 해결목표일
				emailInfoMap.put("clientCompanyName", trackingDataMap.get("COMPANY_NAME"));
				emailInfoMap.put("endUser", trackingDataMap.get("END_USER"));
				emailInfoMap.put("position", trackingDataMap.get("POSITION_STATUS"));
				
				commonMailService.trackingMenuHiddenOpportunityActionPlanSendMail(emailInfoMap, toAddr); //메일 보내기.
			}else if("8".equals(trackingCategory)){ //고객이슈 해결목표일
				emailInfoMap.put("position", trackingDataMap.get("POSITION_STATUS"));
				emailInfoMap.put("clientInfos", trackingDataMap.get("CUSTOMER_INFOS"));
				
				commonMailService.trackingTestSendMail(emailInfoMap, toAddr); //메일 보내기.
			}else if("9".equals(trackingCategory)){ //고객이슈 액션플랜
				emailInfoMap.put("position", trackingDataMap.get("POSITION_STATUS"));
				emailInfoMap.put("clientInfos", trackingDataMap.get("CUSTOMER_INFOS"));
				
				commonMailService.trackingTestSendMail(emailInfoMap, toAddr); //메일 보내기.
			}else if("10".equals(trackingCategory)){ //고객만족도 팔로업액션
				emailInfoMap.put("position", trackingDataMap.get("POSITION_STATUS"));
				
				commonMailService.trackingMenuClientSatisfactionActionPlanSendMail(emailInfoMap, toAddr); //메일 보내기.
			}else if("11".equals(trackingCategory)){ //서비스프로젝트 마일스톤
				emailInfoMap.put("position", trackingDataMap.get("OUR_EXEC_PM_POSITION"));
				emailInfoMap.put("clientCompanyName", trackingDataMap.get("COMPANY_NAME"));
				emailInfoMap.put("clientIndividualName", trackingDataMap.get("CUSTOMER_NAME"));
				emailInfoMap.put("clientExePmcName", trackingDataMap.get("CLIENT_EXEC_PM_NAME"));
				emailInfoMap.put("salesRepresntiveName", trackingDataMap.get("SALES_REPRESENTIVE_NAME"));
				emailInfoMap.put("clientInfos", trackingDataMap.get("COMPANY_NAME"));
				
				commonMailService.trackingTestSendMail(emailInfoMap, toAddr); //메일 보내기.
			}else if("12".equals(trackingCategory)){ //서비스프로젝트 이슈
				emailInfoMap.put("position", trackingDataMap.get("SOLVE_OWNER_POSITION"));
				emailInfoMap.put("clientCompanyName", trackingDataMap.get("COMPANY_NAME"));
				emailInfoMap.put("clientIndividualName", trackingDataMap.get("CUSTOMER_NAME"));
				emailInfoMap.put("clientExePmcName", trackingDataMap.get("CLIENT_EXEC_PM_NAME"));
				emailInfoMap.put("ownerExecPmName", trackingDataMap.get("OUR_EXEC_PM_ID"));
				emailInfoMap.put("ownerSalesManName", trackingDataMap.get("SALES_REPRESENTIVE_ID"));
				emailInfoMap.put("clientInfos", trackingDataMap.get("COMPANY_NAME"));
				
				commonMailService.trackingTestSendMail(emailInfoMap, toAddr); //메일 보내기.
			}else if("13".equals(trackingCategory)){ //제안서정보 제출일
				emailInfoMap.put("clientCompanyName", trackingDataMap.get("COMPANY_NAME"));
				emailInfoMap.put("clientIndividualName", trackingDataMap.get("CUSTOMER_NAME"));
				emailInfoMap.put("position", trackingDataMap.get("POSITION_STATUS"));
				emailInfoMap.put("clientInfos", trackingDataMap.get("CUSTOMER_INFOS"));
				
				commonMailService.trackingTestSendMail(emailInfoMap, toAddr); //메일 보내기.
			}else if("14".equals(trackingCategory)){ //제안서정보 발표일
				emailInfoMap.put("clientCompanyName", trackingDataMap.get("COMPANY_NAME"));
				emailInfoMap.put("clientIndividualName", trackingDataMap.get("CUSTOMER_NAME"));
				emailInfoMap.put("position", trackingDataMap.get("POSITION_STATUS"));
				emailInfoMap.put("clientInfos", trackingDataMap.get("CUSTOMER_INFOS"));
				
				commonMailService.trackingTestSendMail(emailInfoMap, toAddr); //메일 보내기.
			}else if("15".equals(trackingCategory)){ //제안서정보 결과발표일
				emailInfoMap.put("clientCompanyName", trackingDataMap.get("COMPANY_NAME"));
				emailInfoMap.put("clientIndividualName", trackingDataMap.get("CUSTOMER_NAME"));
				emailInfoMap.put("position", trackingDataMap.get("POSITION_STATUS"));
				emailInfoMap.put("clientInfos", trackingDataMap.get("CUSTOMER_INFOS"));
				
				commonMailService.trackingTestSendMail(emailInfoMap, toAddr); //메일 보내기.
			}else if("16".equals(trackingCategory)){ //회사/부문별전략 키마일스톤
				emailInfoMap.put("position", trackingDataMap.get("RESPONSIBILITY_POSITION"));
				emailInfoMap.put("ownerExecPmName", trackingDataMap.get("HIDDEN_ACT_ID"));
				
				commonMailService.trackingMenuBizStrategyCompanyKeyMilestonesSendMail(emailInfoMap, toAddr);
			}else if("17".equals(trackingCategory)){ //회사/부문별전략 이슈
				emailInfoMap.put("position", trackingDataMap.get("ACTION_OWNER_POSITION"));
				
				commonMailService.trackingMenuBizStrategyCompanyIssueSendMail(emailInfoMap, toAddr);
			}else if("18".equals(trackingCategory)){ //고객별전략 키마일스톤
				emailInfoMap.put("position", trackingDataMap.get("ACT_POSITION"));
				emailInfoMap.put("ownerExecPmName", trackingDataMap.get("HIDDEN_ACT_ID"));
				
				commonMailService.trackingMenuBizStrategyClientKeyMilestonesSendMail(emailInfoMap, toAddr);
			}else if("19".equals(trackingCategory)){ //고객별전략 이슈
				emailInfoMap.put("clientInfos", "고객별전략");
				
				commonMailService.trackingTestSendMail(emailInfoMap, toAddr);
			}else if("20".equals(trackingCategory)){ //전략프로젝트 키마일스톤
				emailInfoMap.put("position", trackingDataMap.get("ACT_POSITION"));
				emailInfoMap.put("clientCompanyName", trackingDataMap.get("COMPANY_NAME"));
				
				commonMailService.trackingMenuBizStrategyProjectPlanMilestonesSendMail(emailInfoMap, toAddr);
			}else if("21".equals(trackingCategory)){ //전략프로젝트 이슈
				emailInfoMap.put("position", trackingDataMap.get("ACTION_OWNER_POSITION"));
				emailInfoMap.put("clientCompanyName", trackingDataMap.get("COMPANY_NAME"));
				
				commonMailService.trackingMenuBizStrategyProjectPlanIssueSendMail(emailInfoMap, toAddr);
			}
		}
		
		if("Y".equals(trackingOptionMap.get("MOBILE_USE_YN"))){ //모바일 푸시알림
			sendMobileNotice(meberIdNum, eventSubject, status, URL);
		}
	}
	
	
	//이벤트 기준 트래킹 설정확인
	public void checkMemberTrackingTypeEvents(Map<String, Object> typeMap, List<Map<String, Object>> eventList, Map<String, Object> trackingOptionMap) throws Exception {
		if("Y".equals(trackingOptionMap.get("FULL_USE_YN"))){
			Map<String, Object> dateMap = new HashMap<String, Object>();
			List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
			String trackingCategory = typeMap.get("TRACKING_CATEGORY").toString();
			
			long calDateDays = 0;
			String closeDate = null;
			String todayDate = null;
			String dueDate = null;
			String afterDay = null;
			
			//트래킹 개인설정
			String beforeDueDate = String.valueOf(trackingOptionMap.get("BEFORE_DUE_DATE"));
			String afterDueDate = String.valueOf(trackingOptionMap.get("AFTER_DUE_DATE"));
			String frqncBeforeUseYN = String.valueOf(trackingOptionMap.get("FRQNC_BEFROE_USE_YN"));
			String frqncBeforeDates = String.valueOf(trackingOptionMap.get("FRQNC_BEFROE"));
			String frqncAfterUseYN = String.valueOf(trackingOptionMap.get("FRQNC_AFTER_USE_YN"));
			String frqncAfterDates = String.valueOf(trackingOptionMap.get("FRQNC_AFTER"));
			
			for(int k=0; k<eventList.size(); k++){
				if("5".equals(trackingCategory) || "6".equals(trackingCategory)){ //영업기회 매출계획일 tracking OR 영업기회 수금계획일 tracking
					dueDate = CommonDateUtils.dateToString((Date) eventList.get(k).get("BASIS_MONTH"));
					//closeDate = CommonDateUtils.dateToString((Date) trackingDataMap.get("CLOSE_DATE"));
					todayDate = CommonDateUtils.getToday();	//오늘날짜 ( by CommonDateUtils )
					afterDay = CommonDateUtils.getBeforeDueDate(beforeDueDate);	//오늘 날짜부터 Cycle 날짜 후 날짜가 무엇인지 ?? 이게필요한가?
					calDateDays = CommonDateUtils.getCalDateDays(dueDate, todayDate);	//오늘날짜 - 해결마감일 ( 날짜 차이 계산 )
				}
				
				dateMap.put("dueDate", dueDate);
				//dateMap.put("closeDate", closeDate);
				dateMap.put("todayDate", todayDate);
				dateMap.put("afterDay", afterDay);
				dateMap.put("calDateDays", calDateDays);
				
				if(calDateDays<=0 && (calDateDays + Integer.parseInt(beforeDueDate))>=0){ //todayDate가 dueDate와 같거나 이전일 경우
					if(frqncBeforeUseYN.equals("Y")){
						String[] memberFrqncBeforeDatesArray = frqncBeforeDates.split(",");
						for(int i=0; i<memberFrqncBeforeDatesArray.length; i++){
							//알림 일 체크(== 0)이면 트래킹
							if((int)calDateDays + Integer.parseInt(memberFrqncBeforeDatesArray[i]) == 0){
								list.add(eventList.get(k));
							}
						}
					}else{ //목표일까지 매일알림
						list.add(eventList.get(k));
					}
				}else if(calDateDays>0 && (calDateDays - Integer.parseInt(beforeDueDate))<0){ //목표일 이후로 afterDueDate 까지
					if(frqncAfterUseYN.equals("Y")){ //빈도 설정여부 확인
						String[] memberFrqncAfterDatesArray = frqncAfterDates.split(",");
						for(int i=0; i<memberFrqncAfterDatesArray.length; i++){
							//알림 일 체크(== 0)이면 
							if((int)calDateDays - Integer.parseInt(memberFrqncAfterDatesArray[i]) == 0){
								list.add(eventList.get(k));
							}
						}
					}else{ //afterDueDate까지 매일알림
						list.add(eventList.get(k));
					}
				}
			}
			
			sendMemberTrackingTypeEvents(typeMap, list, trackingOptionMap, dateMap);
			
		}
	}
	
	public void sendMemberTrackingTypeEvents(Map<String, Object> typeMap, List<Map<String, Object>> trackingDataList, Map<String, Object> trackingOptionMap, Map<String, Object> dateMap) throws Exception{
		if(trackingDataList != null){
			
			String trackingCategory = typeMap.get("TRACKING_CATEGORY").toString();
			String memberID = (String)typeMap.get("memberList");
			
			//공통변수
			String eventId = null;
			String URL = "#";
	
			//목표일 계산 변수
			String beforeDueDate = String.valueOf(trackingOptionMap.get("BEFORE_DUE_DATE"));
			String afterDueDate = String.valueOf(trackingOptionMap.get("AFTER_DUE_DATE"));
			long calDateDays = (long) dateMap.get("calDateDays");
			//String closeDate = (String) dateMap.get("closeDate");;
			String todayDate = (String) dateMap.get("todayDate");;
			String dueDate = (String) dateMap.get("dueDate");;
			String afterDay = (String) dateMap.get("afterDay");;
			
			//알람 변수
			String noticeCode = "";
			String noticeCategory = "";
			String noticeDetail = "";
			int OVER_DUE_FLAG = 0;
			
			//메일 변수
			String menuName = "";
			String eventSubject = "";
			String delayItem = "";
			String delayItemDetail = "";
			String noticeDetail2 = "";
			String status = "";
			String ownerName = "";
			
			if("5".equals(trackingCategory)){ //영업기회 매출계획
				noticeCode = "영업기회 매출계획";
				noticeCategory = "TRACKING";
				status = "영업기회 매출계획 - 총"+ trackingDataList.size() + "건의  매출계획이 임박했습니다.";
				menuName = "영업기회 - 매출/수금계획";
			}else if("6".equals(trackingCategory)){ //영업기회 수금계획
				noticeCode = "영업기회 수금계획";
				noticeCategory = "TRACKING";
				status = "영업기회 수금계획 - 총"+ trackingDataList.size() + "건의  수금계획 임박했습니다.";
				menuName = "영업기회 - 매출/수금계획";
			}
			noticeDetail = "총 " + trackingDataList.size() + "건의 " + noticeCode + "이 임박했습니다. 셀러스와 메일에서 확인하시기 바랍니다.";
			
			
			if("Y".equals(trackingOptionMap.get("ALARM_USE_YN"))){ //알람 메세지 전송 데이터 세팅
				Map<String, Object> alarmMap = new HashMap<String, Object>();
				
				alarmMap.put("noticeCategory", noticeCategory);
				alarmMap.put("noticeCode", noticeCode);
				alarmMap.put("OVER_DUE_FLAG", OVER_DUE_FLAG);
				alarmMap.put("noticeDetail", noticeDetail);
				alarmMap.put("memberID", memberID);
				
				trackingDAO.insertNotice(alarmMap); //알람 메세지 보내기.
			}
			
			if("Y".equals(trackingOptionMap.get("MAIL_USE_YN"))){ //메일 전송 데이터 세팅
				if(trackingDataList.size()>0){
					ArrayList<Object> toAddr = new ArrayList<>();
					Map<String, Object> emailInfoMap = new HashMap<String, Object>();
					
					String userEmail = "";
					if(null != trackingDataList.get(0).get("EMAIL")) userEmail = trackingDataList.get(0).get("EMAIL").toString();
					toAddr.add(userEmail);
					
					emailInfoMap.put("status", status);
					emailInfoMap.put("menuName", menuName);
					
					emailInfoMap.put("fromMail", trackingSendMail);
					emailInfoMap.put("fromMailName", trackingSendMailName);
					emailInfoMap.put("linkURL", URL);
					
					commonMailService.trackingMenuOpportunityAmountEventMail(emailInfoMap, trackingDataList, toAddr); //메일 보내기.
				}
			}
			
			if("Y".equals(trackingOptionMap.get("MOBILE_USE_YN"))){ //모바일 푸시알림
				sendMobileNotice(memberID, noticeCode + "일정 알림!", noticeDetail, URL);
			}
		
		}
	}
	
	
	public void trackingMenuClientContactFollowUpAction() throws Exception{
		Map<String, Object> map = new HashMap<>();
		List<Map<String, Object>> clientContactFollowUpAction = trackingDAO.selectClientContactFollowUpActionTracking();
		
		for(int i=0; i<clientContactFollowUpAction.size(); i++){
			List<String> containsMemerList = new ArrayList<String>();
			Map<String, Object> memberTrackingOption = new HashMap<String, Object>();
			String[] memberIdArray = {};
			String memberIdNum = "";
			
			containsMemerList.add((String)clientContactFollowUpAction.get(i).get("SOLVE_OWNER_ID"));
			containsMemerList.add((String)clientContactFollowUpAction.get(i).get("CREATOR_ID"));
			
			//팀구성원 유무 확인
			if(clientContactFollowUpAction.get(i).get("TEAM_MEMBER_ID") != null && !"".equals(clientContactFollowUpAction.get(i).get("TEAM_MEMBER_ID"))){
				containsMemerList = addTeamMemberList(containsMemerList, (String)clientContactFollowUpAction.get(i).get("TEAM_MEMBER_ID")); //팀구성원 추가
			}
			
			containsMemerList = containsMemerList(containsMemerList); //중복제거
			memberIdArray = new String[containsMemerList.size()];
			
			for(int j=0; j<containsMemerList.size(); j++){
				memberIdArray[j] = containsMemerList.get(j);
			}
			
			memberIdArray = new HashSet<String>(Arrays.asList(memberIdArray)).toArray(new String[0]);
			String memIds = setMemberIdArray(memberIdArray);
			map.put("memberList", memIds);
			map.put("TRACKING_CATEGORY", 1); //고객컨택 팔로업액션 트래킹설정 값
			List<Map<String, Object>> memberTrackingOptionList = trackingDAO.selectMemberTrackingOption(map); //사용자 트래킹 설정 조회
			
			for(int k=0; k<containsMemerList.size(); k++){
				memberIdNum = (String)containsMemerList.get(k);
				
				//memberTrackingOptionList이 1이면 default뿐이니 탈필요없음...
				if(memberTrackingOptionList.size()>1){
					memberTrackingOption = setMemberTrackingOption(memberIdNum, memberTrackingOptionList);
				}else{
					memberTrackingOption = memberTrackingOptionList.get(0);
				}
				
				checkMemberTrackingTypeCloseDate(memberIdNum, map.get("TRACKING_CATEGORY").toString(), clientContactFollowUpAction.get(i), memberTrackingOption); //사용자 기준으로 트래킹 이벤트 전송
			}
			
		}
	}
	
	public void trackingMenuOpportunityMilestones() throws Exception {
		Map<String, Object> map = new HashMap<>();
		List<Map<String, Object>> opportunityMilestones = trackingDAO.selectOpportunityMilestonesTracking();
		
		for(int i=0; i<opportunityMilestones.size(); i++){
			List<String> containsMemerList = new ArrayList<String>();
			Map<String, Object> memberTrackingOption = new HashMap<String, Object>();
			String[] memberIdArray = {};
			String memberIdNum = "";
			
			containsMemerList.add((String)opportunityMilestones.get(i).get("ACT_ID"));
			containsMemerList.add((String)opportunityMilestones.get(i).get("IDENTIFIER_ID"));
			containsMemerList.add((String)opportunityMilestones.get(i).get("OWNER_ID"));
			
			//팀구성원 유무 확인
			if(opportunityMilestones.get(i).get("TEAM_MEMBER_ID") != null && !"".equals(opportunityMilestones.get(i).get("TEAM_MEMBER_ID"))){
				containsMemerList = addTeamMemberList(containsMemerList, (String)opportunityMilestones.get(i).get("TEAM_MEMBER_ID")); //팀구성원 추가
			}
			
			containsMemerList = containsMemerList(containsMemerList); //중복제거
			memberIdArray = new String[containsMemerList.size()];
			
			for(int j=0; j<containsMemerList.size(); j++){
				memberIdArray[j] = containsMemerList.get(j);
			}
			
			memberIdArray = new HashSet<String>(Arrays.asList(memberIdArray)).toArray(new String[0]);
			String memIds = setMemberIdArray(memberIdArray);
			map.put("memberList", memIds);
			map.put("TRACKING_CATEGORY", 2); //영업기회 마일스톤 트래킹설정 값
			List<Map<String, Object>> memberTrackingOptionList = trackingDAO.selectMemberTrackingOption(map); //사용자 트래킹 설정 조회
			
			for(int k=0; k<containsMemerList.size(); k++){
				memberIdNum = (String)containsMemerList.get(k);
				
				//memberTrackingOptionList이 1이면 default뿐이니 탈필요없음...
				if(memberTrackingOptionList.size()>1){
					memberTrackingOption = setMemberTrackingOption(memberIdNum, memberTrackingOptionList);
				}else{
					memberTrackingOption = memberTrackingOptionList.get(0);
				}
				
				checkMemberTrackingTypeCloseDate(memberIdNum, map.get("TRACKING_CATEGORY").toString(), opportunityMilestones.get(i), memberTrackingOption); //사용자 기준으로 트래킹 이벤트 전송
			}
			
		}
	}
	
	public void trackingMenuOpportunityWinPlan() throws Exception{
		Map<String, Object> map = new HashMap<>();
		List<Map<String, Object>> clientOpportunityWinplan = trackingDAO.selectClientOpportunityWinPlanTracking();
		
		for(int i=0; i<clientOpportunityWinplan.size(); i++){
			List<String> containsMemerList = new ArrayList<String>();
			Map<String, Object> memberTrackingOption = new HashMap<String, Object>();
			String[] memberIdArray = {};
			String memberIdNum = "";
			
			containsMemerList.add((String)clientOpportunityWinplan.get(i).get("SOLVE_OWNER_ID"));
			containsMemerList.add((String)clientOpportunityWinplan.get(i).get("IDENTIFIER_ID"));
			containsMemerList.add((String)clientOpportunityWinplan.get(i).get("OWNER_ID"));
			
			//팀구성원 유무 확인
			if(clientOpportunityWinplan.get(i).get("TEAM_MEMBER_ID") != null && !"".equals(clientOpportunityWinplan.get(i).get("TEAM_MEMBER_ID"))){
				containsMemerList = addTeamMemberList(containsMemerList, (String)clientOpportunityWinplan.get(i).get("TEAM_MEMBER_ID")); //팀구성원 추가
			}
			
			containsMemerList = containsMemerList(containsMemerList); //중복제거
			memberIdArray = new String[containsMemerList.size()];
			
			for(int j=0; j<containsMemerList.size(); j++){
				memberIdArray[j] = containsMemerList.get(j);
			}
			
			memberIdArray = new HashSet<String>(Arrays.asList(memberIdArray)).toArray(new String[0]);
			String memIds = setMemberIdArray(memberIdArray);
			map.put("memberList", memIds);
			map.put("TRACKING_CATEGORY", 3); //영업기회 마일스톤 트래킹설정 값
			List<Map<String, Object>> memberTrackingOptionList = trackingDAO.selectMemberTrackingOption(map); //사용자 트래킹 설정 조회
			
			for(int k=0; k<containsMemerList.size(); k++){
				memberIdNum = (String)containsMemerList.get(k);
				
				//memberTrackingOptionList이 1이면 default뿐이니 탈필요없음...
				if(memberTrackingOptionList.size()>1){
					memberTrackingOption = setMemberTrackingOption(memberIdNum, memberTrackingOptionList);
				}else{
					memberTrackingOption = memberTrackingOptionList.get(0);
				}
				
				checkMemberTrackingTypeCloseDate(memberIdNum, map.get("TRACKING_CATEGORY").toString(), clientOpportunityWinplan.get(i), memberTrackingOption); //사용자 기준으로 트래킹 이벤트 전송
			}
			
		}
	}
	
	public void trackingMenuOpportunityContractDate() throws Exception {
		Map<String, Object> map = new HashMap<>();
		List<Map<String, Object>> clientOpportunityContractDate = trackingDAO.selectOpportunityContractDateTracking();
		
		for(int i=0; i<clientOpportunityContractDate.size(); i++){
			List<String> containsMemerList = new ArrayList<String>();
			Map<String, Object> memberTrackingOption = new HashMap<String, Object>();
			String[] memberIdArray = {};
			String memberIdNum = "";
			
			containsMemerList.add((String)clientOpportunityContractDate.get(i).get("IDENTIFIER_ID"));
			containsMemerList.add((String)clientOpportunityContractDate.get(i).get("OWNER_ID"));
			containsMemerList.add((String)clientOpportunityContractDate.get(i).get("EXEC_ID"));
			
			//팀구성원 유무 확인
			if(clientOpportunityContractDate.get(i).get("TEAM_MEMBER_ID") != null && !"".equals(clientOpportunityContractDate.get(i).get("TEAM_MEMBER_ID"))){
				containsMemerList = addTeamMemberList(containsMemerList, (String)clientOpportunityContractDate.get(i).get("TEAM_MEMBER_ID")); //팀구성원 추가
			}
			
			containsMemerList = containsMemerList(containsMemerList); //중복제거
			memberIdArray = new String[containsMemerList.size()];
			
			for(int j=0; j<containsMemerList.size(); j++){
				memberIdArray[j] = containsMemerList.get(j);
			}
			
			memberIdArray = new HashSet<String>(Arrays.asList(memberIdArray)).toArray(new String[0]);
			String memIds = setMemberIdArray(memberIdArray);
			map.put("memberList", memIds);
			map.put("TRACKING_CATEGORY", 4); //영업기회 계약일 트래킹설정 값
			List<Map<String, Object>> memberTrackingOptionList = trackingDAO.selectMemberTrackingOption(map); //사용자 트래킹 설정 조회
			
			for(int k=0; k<containsMemerList.size(); k++){
				memberIdNum = (String)containsMemerList.get(k);
				
				//memberTrackingOptionList이 1이면 default뿐이니 탈필요없음...
				if(memberTrackingOptionList.size()>1){
					memberTrackingOption = setMemberTrackingOption(memberIdNum, memberTrackingOptionList);
				}else{
					memberTrackingOption = memberTrackingOptionList.get(0);
				}
				
				checkMemberTrackingTypeCloseDate(memberIdNum, map.get("TRACKING_CATEGORY").toString(), clientOpportunityContractDate.get(i), memberTrackingOption); //사용자 기준으로 트래킹 이벤트 전송
			}
		}
		
	}
	
	public void trackingMenuOpportunityAmount(String amountType) throws Exception{
		Map<String, Object>	map = new HashMap<String, Object>();
		map.put("TYPE", amountType);
		List<Map<String, Object>> clientOpportunityAmount = trackingDAO.selectOpportunityAmountTracking(map);
		map.clear();
		
		for(int i=0; i<clientOpportunityAmount.size(); i++){
			Map<String, Object> memberTrackingOption = new HashMap<String, Object>();
			List<Map<String, Object>> list = new ArrayList<>();
			
			map.put("memberList", clientOpportunityAmount.get(i).get("MEMBER_ID_NUM"));
			if("SP".equals(amountType)){
				map.put("TRACKING_CATEGORY", 5); //영업기회 매출금액 트래킹설정 값
			}else if("CP".equals(amountType)){
				map.put("TRACKING_CATEGORY", 6); //영업기회 수금금액 트래킹설정 값
			}
			
			List<Map<String, Object>> memberTrackingOptionList = trackingDAO.selectMemberTrackingOption(map); //사용자 트래킹 설정 조회
			
			//memberTrackingOptionList이 1이면 default뿐이니 탈필요없음...
			if(memberTrackingOptionList != null){
				memberTrackingOption = memberTrackingOptionList.get(0);
				
				if(i+1<clientOpportunityAmount.size()){	//i+1이 list size값보다 적을때
					if(!clientOpportunityAmount.get(i).get("MEMBER_ID_NUM").equals(clientOpportunityAmount.get(i+1).get("MEMBER_ID_NUM"))){	//다음 데이터 사번이 다르면 알림 발송 로직
						list.add(clientOpportunityAmount.get(i));	//이번 데이터까지 담고
						
						checkMemberTrackingTypeEvents(map, list, memberTrackingOption); //이벤트 기준으로 트래킹 이벤트 전송
					}else {	//사번이 같으면 데이터 list에 쌓기
						list.add(clientOpportunityAmount.get(i));
					}
				}else{ //i가  list size값과 같아지면 마지막 알림 발송 로직
					list.add(clientOpportunityAmount.get(i)); //마지막 데이터까지 담고
					
					checkMemberTrackingTypeEvents(map, list, memberTrackingOption); //이벤트 기준으로 트래킹 이벤트 전송
				}
			}
		}
	}
	
	public void trackingMenuHiddenOpportunityActionPlan() throws Exception{
		Map<String, Object> map = new HashMap<>();
		List<Map<String, Object>> clientHiddenOpportunityActionPlan = trackingDAO.selectHiddenOpportunityActionPlanTracking();
		
		for(int i=0; i<clientHiddenOpportunityActionPlan.size(); i++){
			List<String> containsMemerList = new ArrayList<String>();
			Map<String, Object> memberTrackingOption = new HashMap<String, Object>();
			String[] memberIdArray = {};
			String memberIdNum = "";
			
			containsMemerList.add((String)clientHiddenOpportunityActionPlan.get(i).get("SALESMAN_ID"));
			containsMemerList.add((String)clientHiddenOpportunityActionPlan.get(i).get("ACTION_OWNER_ID"));
			
			//팀구성원 유무 확인
			if(clientHiddenOpportunityActionPlan.get(i).get("TEAM_MEMBER_ID") != null && !"".equals(clientHiddenOpportunityActionPlan.get(i).get("TEAM_MEMBER_ID"))){
				containsMemerList = addTeamMemberList(containsMemerList, (String)clientHiddenOpportunityActionPlan.get(i).get("TEAM_MEMBER_ID")); //팀구성원 추가
			}
			
			containsMemerList = containsMemerList(containsMemerList); //중복제거
			memberIdArray = new String[containsMemerList.size()];
			
			for(int j=0; j<containsMemerList.size(); j++){
				memberIdArray[j] = containsMemerList.get(j);
			}
			
			memberIdArray = new HashSet<String>(Arrays.asList(memberIdArray)).toArray(new String[0]);
			String memIds = setMemberIdArray(memberIdArray);
			map.put("memberList", memIds);
			map.put("TRACKING_CATEGORY", 7); //잠재영업기회_액션플랜 트래킹설정 값
			List<Map<String, Object>> memberTrackingOptionList = trackingDAO.selectMemberTrackingOption(map); //사용자 트래킹 설정 조회
			
			for(int k=0; k<containsMemerList.size(); k++){
				memberIdNum = (String)containsMemerList.get(k);
				
				//memberTrackingOptionList이 1이면 default뿐이니 탈필요없음...
				if(memberTrackingOptionList.size()>1){
					memberTrackingOption = setMemberTrackingOption(memberIdNum, memberTrackingOptionList);
				}else{
					memberTrackingOption = memberTrackingOptionList.get(0);
				}
				
				checkMemberTrackingTypeCloseDate(memberIdNum, map.get("TRACKING_CATEGORY").toString(), clientHiddenOpportunityActionPlan.get(i), memberTrackingOption); //사용자 기준으로 트래킹 이벤트 전송
			}
		}
	}
	
	public void trackingMenuClientIssue() throws Exception {
		//트래킹 select - 기존쿼리 유지
		Map<String, Object>	map = new HashMap<String, Object>();
		List<Map<String, Object>> clientIssueList = trackingDAO.selectClientIssueTracking(map);
		
		for(int i=0; i<clientIssueList.size(); i++){
			List<String> containsMemerList = new ArrayList<String>();
			Map<String, Object> memberTrackingOption = new HashMap<String, Object>();
			String[] memberIdArray = {};
			String memberIdNum = "";
			
			containsMemerList.add((String)clientIssueList.get(i).get("SALES_REPRESENTIVE_ID"));
			containsMemerList.add((String)clientIssueList.get(i).get("SOLVE_OWNER"));
			
			//팀구성원 유무 확인
			if(clientIssueList.get(i).get("TEAM_MEMBER_ID") != null && !"".equals(clientIssueList.get(i).get("TEAM_MEMBER_ID"))){
				containsMemerList = addTeamMemberList(containsMemerList, (String)clientIssueList.get(i).get("TEAM_MEMBER_ID")); //팀구성원 추가
			}
			
			containsMemerList = containsMemerList(containsMemerList); //중복제거
			memberIdArray = new String[containsMemerList.size()];
			
			for(int j=0; j<containsMemerList.size(); j++){
				memberIdArray[j] = containsMemerList.get(j);
			}
			
			memberIdArray = new HashSet<String>(Arrays.asList(memberIdArray)).toArray(new String[0]);
			String memIds = setMemberIdArray(memberIdArray);
			map.put("memberList", memIds);
			map.put("TRACKING_CATEGORY", 8); //고객이슈 트래킹설정 값
			List<Map<String, Object>> memberTrackingOptionList = trackingDAO.selectMemberTrackingOption(map); //사용자 트래킹 설정 조회
			
			for(int k=0; k<containsMemerList.size(); k++){
				memberIdNum = (String)containsMemerList.get(k);
				
				//memberTrackingOptionList이 1이면 default뿐이니 탈필요없음...
				if(memberTrackingOptionList.size()>1){
					memberTrackingOption = setMemberTrackingOption(memberIdNum, memberTrackingOptionList);
				}else{
					memberTrackingOption = memberTrackingOptionList.get(0);
				}
				
				checkMemberTrackingTypeCloseDate(memberIdNum, map.get("TRACKING_CATEGORY").toString(), clientIssueList.get(i), memberTrackingOption); //사용자 기준으로 트래킹 이벤트 전송
			}
		}
	}
	
	public void trackingMenuClientIssueActionPlan() throws Exception {
		//트래킹 select - 기존쿼리 유지
		Map<String, Object>	map = new HashMap<String, Object>();
		List<Map<String, Object>> clientIssueActionList = trackingDAO.selectClientIssueActionPlanTracking();
		
		for(int i=0; i<clientIssueActionList.size(); i++){
			List<String> containsMemerList = new ArrayList<String>();
			Map<String, Object> memberTrackingOption = new HashMap<String, Object>();
			String[] memberIdArray = {};
			String memberIdNum = "";
			
			containsMemerList.add((String)clientIssueActionList.get(i).get("SALES_REPRESENTIVE_ID"));
			containsMemerList.add((String)clientIssueActionList.get(i).get("SOLVE_OWNER_ID1"));
			containsMemerList.add((String)clientIssueActionList.get(i).get("SOLVE_OWNER_ID2"));
			
			//팀구성원 유무 확인
			if(clientIssueActionList.get(i).get("TEAM_MEMBER_ID") != null && !"".equals(clientIssueActionList.get(i).get("TEAM_MEMBER_ID"))){
				containsMemerList = addTeamMemberList(containsMemerList, (String)clientIssueActionList.get(i).get("TEAM_MEMBER_ID")); //팀구성원 추가
			}
			
			containsMemerList = containsMemerList(containsMemerList); //중복제거
			memberIdArray = new String[containsMemerList.size()];
			
			for(int j=0; j<containsMemerList.size(); j++){
				memberIdArray[j] = containsMemerList.get(j);
			}
			
			memberIdArray = new HashSet<String>(Arrays.asList(memberIdArray)).toArray(new String[0]);
			String memIds = setMemberIdArray(memberIdArray);
			map.put("memberList", memIds);
			map.put("TRACKING_CATEGORY", 9); //고객이슈_액션플랜 트래킹설정 값
			List<Map<String, Object>> memberTrackingOptionList = trackingDAO.selectMemberTrackingOption(map); //사용자 트래킹 설정 조회
			
			for(int k=0; k<containsMemerList.size(); k++){
				memberIdNum = (String)containsMemerList.get(k);
				
				//memberTrackingOptionList이 1이면 default뿐이니 탈필요없음...
				if(memberTrackingOptionList.size()>1){
					memberTrackingOption = setMemberTrackingOption(memberIdNum, memberTrackingOptionList);
				}else{
					memberTrackingOption = memberTrackingOptionList.get(0);
				}
				
				checkMemberTrackingTypeCloseDate(memberIdNum, map.get("TRACKING_CATEGORY").toString(), clientIssueActionList.get(i), memberTrackingOption); //사용자 기준으로 트래킹 이벤트 전송
			}
		}
	}
	
	public void trackingMenuClientSatisfactionFollowUpAction() throws Exception {
		//트래킹 select - 기존쿼리 유지
		Map<String, Object>	map = new HashMap<String, Object>();
		List<Map<String, Object>> clientSatisfactionFollowUpAction = trackingDAO.selectClientSatisfactionFollowUpActionTracking();
		
		for(int i=0; i<clientSatisfactionFollowUpAction.size(); i++){
			List<String> containsMemerList = new ArrayList<String>();
			Map<String, Object> memberTrackingOption = new HashMap<String, Object>();
			String[] memberIdArray = {};
			String memberIdNum = "";
			
			containsMemerList.add((String)clientSatisfactionFollowUpAction.get(i).get("CSAT_SURVEY_ID"));
			containsMemerList.add((String)clientSatisfactionFollowUpAction.get(i).get("SOLVE_OWNER_ID"));
			
			//팀구성원 유무 확인
			if(clientSatisfactionFollowUpAction.get(i).get("TEAM_MEMBER_ID") != null && !"".equals(clientSatisfactionFollowUpAction.get(i).get("TEAM_MEMBER_ID"))){
				containsMemerList = addTeamMemberList(containsMemerList, (String)clientSatisfactionFollowUpAction.get(i).get("TEAM_MEMBER_ID")); //팀구성원 추가
			}
			
			containsMemerList = containsMemerList(containsMemerList); //중복제거
			memberIdArray = new String[containsMemerList.size()];
			
			for(int j=0; j<containsMemerList.size(); j++){
				memberIdArray[j] = containsMemerList.get(j);
			}
			
			memberIdArray = new HashSet<String>(Arrays.asList(memberIdArray)).toArray(new String[0]);
			String memIds = setMemberIdArray(memberIdArray);
			map.put("memberList", memIds);
			map.put("TRACKING_CATEGORY", 10); //고객만족도_팔로업액션 트래킹설정 값
			List<Map<String, Object>> memberTrackingOptionList = trackingDAO.selectMemberTrackingOption(map); //사용자 트래킹 설정 조회
			
			for(int k=0; k<containsMemerList.size(); k++){
				memberIdNum = (String)containsMemerList.get(k);
				
				//memberTrackingOptionList이 1이면 default뿐이니 탈필요없음...
				if(memberTrackingOptionList.size()>1){
					memberTrackingOption = setMemberTrackingOption(memberIdNum, memberTrackingOptionList);
				}else{
					memberTrackingOption = memberTrackingOptionList.get(0);
				}
				
				checkMemberTrackingTypeCloseDate(memberIdNum, map.get("TRACKING_CATEGORY").toString(), clientSatisfactionFollowUpAction.get(i), memberTrackingOption); //사용자 기준으로 트래킹 이벤트 전송
			}
		}
	}
	
	public void trackingMenuServiceProjectMilestones() throws Exception {
		//트래킹 select - 기존쿼리 유지
		Map<String, Object>	map = new HashMap<String, Object>();
		List<Map<String, Object>> serviceProjectMilestones = trackingDAO.selectServiceProjectMilestonesTracking();
		
		for(int i=0; i<serviceProjectMilestones.size(); i++){
			List<String> containsMemerList = new ArrayList<String>();
			Map<String, Object> memberTrackingOption = new HashMap<String, Object>();
			String[] memberIdArray = {};
			String memberIdNum = "";
			
			containsMemerList.add((String)serviceProjectMilestones.get(i).get("SALES_REPRESENTIVE_ID"));
			containsMemerList.add((String)serviceProjectMilestones.get(i).get("OUR_PM_ID"));
			containsMemerList.add((String)serviceProjectMilestones.get(i).get("OUR_EXEC_PM_ID"));
			
			//팀구성원 유무 확인
			if(serviceProjectMilestones.get(i).get("TEAM_MEMBER_ID") != null && !"".equals(serviceProjectMilestones.get(i).get("TEAM_MEMBER_ID"))){
				containsMemerList = addTeamMemberList(containsMemerList, (String)serviceProjectMilestones.get(i).get("TEAM_MEMBER_ID")); //팀구성원 추가
			}
			
			containsMemerList = containsMemerList(containsMemerList); //중복제거
			memberIdArray = new String[containsMemerList.size()];
			
			for(int j=0; j<containsMemerList.size(); j++){
				memberIdArray[j] = containsMemerList.get(j);
			}
			
			memberIdArray = new HashSet<String>(Arrays.asList(memberIdArray)).toArray(new String[0]);
			String memIds = setMemberIdArray(memberIdArray);
			map.put("memberList", memIds);
			map.put("TRACKING_CATEGORY", 11); //서비스프로젝트_마일스톤 트래킹설정 값
			List<Map<String, Object>> memberTrackingOptionList = trackingDAO.selectMemberTrackingOption(map); //사용자 트래킹 설정 조회
			
			for(int k=0; k<containsMemerList.size(); k++){
				memberIdNum = (String)containsMemerList.get(k);
				
				//memberTrackingOptionList이 1이면 default뿐이니 탈필요없음...
				if(memberTrackingOptionList.size()>1){
					memberTrackingOption = setMemberTrackingOption(memberIdNum, memberTrackingOptionList);
				}else{
					memberTrackingOption = memberTrackingOptionList.get(0);
				}
				
				checkMemberTrackingTypeCloseDate(memberIdNum, map.get("TRACKING_CATEGORY").toString(), serviceProjectMilestones.get(i), memberTrackingOption); //사용자 기준으로 트래킹 이벤트 전송
			}
		}
	}
	
	public void trackingMenuServiceProjectIssue() throws Exception {
		//트래킹 select - 기존쿼리 유지
		Map<String, Object>	map = new HashMap<String, Object>();
		List<Map<String, Object>> serviceProjectIssue = trackingDAO.selectServiceProjectIssueTracking();
		
		for(int i=0; i<serviceProjectIssue.size(); i++){
			List<String> containsMemerList = new ArrayList<String>();
			Map<String, Object> memberTrackingOption = new HashMap<String, Object>();
			String[] memberIdArray = {};
			String memberIdNum = "";
			
			containsMemerList.add((String)serviceProjectIssue.get(i).get("SALES_REPRESENTIVE_ID"));
			containsMemerList.add((String)serviceProjectIssue.get(i).get("OUR_PM_ID"));
			containsMemerList.add((String)serviceProjectIssue.get(i).get("OUR_EXEC_PM_ID"));
			containsMemerList.add((String)serviceProjectIssue.get(i).get("SOLVE_OWNER_ID"));
			
			//팀구성원 유무 확인
			if(serviceProjectIssue.get(i).get("TEAM_MEMBER_ID") != null && !"".equals(serviceProjectIssue.get(i).get("TEAM_MEMBER_ID"))){
				containsMemerList = addTeamMemberList(containsMemerList, (String)serviceProjectIssue.get(i).get("TEAM_MEMBER_ID")); //팀구성원 추가
			}
			
			containsMemerList = containsMemerList(containsMemerList); //중복제거
			memberIdArray = new String[containsMemerList.size()];
			
			for(int j=0; j<containsMemerList.size(); j++){
				memberIdArray[j] = containsMemerList.get(j);
			}
			
			memberIdArray = new HashSet<String>(Arrays.asList(memberIdArray)).toArray(new String[0]);
			String memIds = setMemberIdArray(memberIdArray);
			map.put("memberList", memIds);
			map.put("TRACKING_CATEGORY", 12); //서비스프로젝트_이슈 트래킹설정 값
			List<Map<String, Object>> memberTrackingOptionList = trackingDAO.selectMemberTrackingOption(map); //사용자 트래킹 설정 조회
			
			for(int k=0; k<containsMemerList.size(); k++){
				memberIdNum = (String)containsMemerList.get(k);
				
				//memberTrackingOptionList이 1이면 default뿐이니 탈필요없음...
				if(memberTrackingOptionList.size()>1){
					memberTrackingOption = setMemberTrackingOption(memberIdNum, memberTrackingOptionList);
				}else{
					memberTrackingOption = memberTrackingOptionList.get(0);
				}
				
				checkMemberTrackingTypeCloseDate(memberIdNum, map.get("TRACKING_CATEGORY").toString(), serviceProjectIssue.get(i), memberTrackingOption); //사용자 기준으로 트래킹 이벤트 전송
			}
		}
	}
	
	public void trackingMenuProposalsInfo(String suggestType) throws Exception {
		Map<String, Object>	map = new HashMap<String, Object>();
		map.put("TYPE", suggestType);
		List<Map<String, Object>> proposalsInfoList = trackingDAO.selectProposalsInfoTracking(map);
		
		for(int i=0; i<proposalsInfoList.size(); i++){
			if(proposalsInfoList.get(i) != null){
				List<String> containsMemerList = new ArrayList<String>();
				Map<String, Object> memberTrackingOption = new HashMap<String, Object>();
				String[] memberIdArray = {};
				String memberIdNum = "";
				
				containsMemerList.add((String)proposalsInfoList.get(i).get("PROPOSAL_LEADER_ID"));
				
				//팀구성원 유무 확인
				if(proposalsInfoList.get(i).get("TEAM_MEMBER_ID") != null && !"".equals(proposalsInfoList.get(i).get("TEAM_MEMBER_ID"))){
					containsMemerList = addTeamMemberList(containsMemerList, (String)proposalsInfoList.get(i).get("TEAM_MEMBER_ID")); //팀구성원 추가
				}
				
				containsMemerList = containsMemerList(containsMemerList); //중복제거
				memberIdArray = new String[containsMemerList.size()];
				
				for(int j=0; j<containsMemerList.size(); j++){
					memberIdArray[j] = containsMemerList.get(j);
				}
				
				memberIdArray = new HashSet<String>(Arrays.asList(memberIdArray)).toArray(new String[0]);
				String memIds = setMemberIdArray(memberIdArray);
				map.put("memberList", memIds);
				if("SED".equals(suggestType)){
					map.put("TRACKING_CATEGORY", 13); //제안서 제출일 트래킹설정 값
				}else if("SPD".equals(suggestType)){
					map.put("TRACKING_CATEGORY", 14); //제안서 제안발표일 트래킹설정 값
				}else if("SRD".equals(suggestType)){
					map.put("TRACKING_CATEGORY", 15); //제안서 결과발표일 트래킹설정 값
				}
				List<Map<String, Object>> memberTrackingOptionList = trackingDAO.selectMemberTrackingOption(map); //사용자 트래킹 설정 조회
				
				for(int k=0; k<containsMemerList.size(); k++){
					memberIdNum = (String)containsMemerList.get(k);
					
					//memberTrackingOptionList이 1이면 default뿐이니 탈필요없음...
					if(memberTrackingOptionList.size()>1){
						memberTrackingOption = setMemberTrackingOption(memberIdNum, memberTrackingOptionList);
					}else{
						memberTrackingOption = memberTrackingOptionList.get(0);
					}
					
					checkMemberTrackingTypeCloseDate(memberIdNum, map.get("TRACKING_CATEGORY").toString(), proposalsInfoList.get(i), memberTrackingOption); //사용자 기준으로 트래킹 이벤트 전송
				}
			}
		}
	}
	
	public void trackingMenuBizStrategyCompanyKeyMilestones() throws Exception {
		//트래킹 select - 기존쿼리 유지
		Map<String, Object>	map = new HashMap<String, Object>();
		map.put("category", "our");
		List<Map<String, Object>> bizStrategyCompanyKeyMilestones = trackingDAO.selectBizStrategyCompanyKeyMilestonesTracking(map);
		map.clear();
		
		for(int i=0; i<bizStrategyCompanyKeyMilestones.size(); i++){
			List<String> containsMemerList = new ArrayList<String>();
			Map<String, Object> memberTrackingOption = new HashMap<String, Object>();
			String[] memberIdArray = {};
			String memberIdNum = "";
			
			containsMemerList.add((String)bizStrategyCompanyKeyMilestones.get(i).get("HIDDEN_ACT_ID"));
			containsMemerList.add((String)bizStrategyCompanyKeyMilestones.get(i).get("RESPONSIBILITY_LEADER"));
			
			//팀구성원 유무 확인
			if(bizStrategyCompanyKeyMilestones.get(i).get("TEAM_MEMBER_ID") != null && !"".equals(bizStrategyCompanyKeyMilestones.get(i).get("TEAM_MEMBER_ID"))){
				containsMemerList = addTeamMemberList(containsMemerList, (String)bizStrategyCompanyKeyMilestones.get(i).get("TEAM_MEMBER_ID")); //팀구성원 추가
			}
			
			containsMemerList = containsMemerList(containsMemerList); //중복제거
			memberIdArray = new String[containsMemerList.size()];
			
			for(int j=0; j<containsMemerList.size(); j++){
				memberIdArray[j] = containsMemerList.get(j);
			}
			
			memberIdArray = new HashSet<String>(Arrays.asList(memberIdArray)).toArray(new String[0]);
			String memIds = setMemberIdArray(memberIdArray);
			map.put("memberList", memIds);
			map.put("TRACKING_CATEGORY", 16); //회사/부문별전략 키마일스톤 트래킹설정 값
			List<Map<String, Object>> memberTrackingOptionList = trackingDAO.selectMemberTrackingOption(map); //사용자 트래킹 설정 조회
			
			for(int k=0; k<containsMemerList.size(); k++){
				memberIdNum = (String)containsMemerList.get(k);
				
				//memberTrackingOptionList이 1이면 default뿐이니 탈필요없음...
				if(memberTrackingOptionList.size()>1){
					memberTrackingOption = setMemberTrackingOption(memberIdNum, memberTrackingOptionList);
				}else{
					memberTrackingOption = memberTrackingOptionList.get(0);
				}
				
				checkMemberTrackingTypeCloseDate(memberIdNum, map.get("TRACKING_CATEGORY").toString(), bizStrategyCompanyKeyMilestones.get(i), memberTrackingOption); //사용자 기준으로 트래킹 이벤트 전송
			}
		
		}
	}
	
	public void trackingMenuBizStrategyCompanyIssue() throws Exception {
		//트래킹 select - 기존쿼리 유지
		Map<String, Object>	map = new HashMap<String, Object>();
		map.put("category", "our");
		List<Map<String, Object>> bizStrategyCompanyIssue = trackingDAO.selectBizStrategyCompanyIssueTracking(map);
		map.clear();
		
		for(int i=0; i<bizStrategyCompanyIssue.size(); i++){
			List<String> containsMemerList = new ArrayList<String>();
			Map<String, Object> memberTrackingOption = new HashMap<String, Object>();
			String[] memberIdArray = {};
			String memberIdNum = "";
			
			containsMemerList.add((String)bizStrategyCompanyIssue.get(i).get("ACTION_OWNER_ID"));
			containsMemerList.add((String)bizStrategyCompanyIssue.get(i).get("RESPONSIBILITY_LEADER"));
			
			//팀구성원 유무 확인
			if(bizStrategyCompanyIssue.get(i).get("TEAM_MEMBER_ID") != null && !"".equals(bizStrategyCompanyIssue.get(i).get("TEAM_MEMBER_ID"))){
				containsMemerList = addTeamMemberList(containsMemerList, (String)bizStrategyCompanyIssue.get(i).get("TEAM_MEMBER_ID")); //팀구성원 추가
			}
			
			containsMemerList = containsMemerList(containsMemerList); //중복제거
			memberIdArray = new String[containsMemerList.size()];
			
			for(int j=0; j<containsMemerList.size(); j++){
				memberIdArray[j] = containsMemerList.get(j);
			}
			
			memberIdArray = new HashSet<String>(Arrays.asList(memberIdArray)).toArray(new String[0]);
			String memIds = setMemberIdArray(memberIdArray);
			map.put("memberList", memIds);
			map.put("TRACKING_CATEGORY", 17); //회사/부문별전략 이슈 트래킹설정 값
			List<Map<String, Object>> memberTrackingOptionList = trackingDAO.selectMemberTrackingOption(map); //사용자 트래킹 설정 조회
			
			for(int k=0; k<containsMemerList.size(); k++){
				memberIdNum = (String)containsMemerList.get(k);
				
				//memberTrackingOptionList이 1이면 default뿐이니 탈필요없음...
				if(memberTrackingOptionList.size()>1){
					memberTrackingOption = setMemberTrackingOption(memberIdNum, memberTrackingOptionList);
				}else{
					memberTrackingOption = memberTrackingOptionList.get(0);
				}
				
				checkMemberTrackingTypeCloseDate(memberIdNum, map.get("TRACKING_CATEGORY").toString(), bizStrategyCompanyIssue.get(i), memberTrackingOption); //사용자 기준으로 트래킹 이벤트 전송
			}
			
		}
	}
	
	public void trackingMenuBizStrategyClientKeyMilestones() throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("category", "client");
		List<Map<String, Object>> bizStrategyCompanyKeyMilestones = trackingDAO.selectBizStrategyCompanyKeyMilestonesTracking(map);
		map.clear();
		
		for(int i=0; i<bizStrategyCompanyKeyMilestones.size(); i++){
			List<String> containsMemerList = new ArrayList<String>();
			Map<String, Object> memberTrackingOption = new HashMap<String, Object>();
			String[] memberIdArray = {};
			String memberIdNum = "";
			
			containsMemerList.add((String)bizStrategyCompanyKeyMilestones.get(i).get("HIDDEN_ACT_ID"));
			containsMemerList.add((String)bizStrategyCompanyKeyMilestones.get(i).get("RESPONSIBILITY_LEADER"));
			
			//팀구성원 유무 확인
			if(bizStrategyCompanyKeyMilestones.get(i).get("TEAM_MEMBER_ID") != null && !"".equals(bizStrategyCompanyKeyMilestones.get(i).get("TEAM_MEMBER_ID"))){
				containsMemerList = addTeamMemberList(containsMemerList, (String)bizStrategyCompanyKeyMilestones.get(i).get("TEAM_MEMBER_ID")); //팀구성원 추가
			}
			
			containsMemerList = containsMemerList(containsMemerList); //중복제거
			memberIdArray = new String[containsMemerList.size()];
			
			for(int j=0; j<containsMemerList.size(); j++){
				memberIdArray[j] = containsMemerList.get(j);
			}
			
			memberIdArray = new HashSet<String>(Arrays.asList(memberIdArray)).toArray(new String[0]);
			String memIds = setMemberIdArray(memberIdArray);
			map.put("memberList", memIds);
			map.put("TRACKING_CATEGORY", 18); //고객전략 키마일스톤 트래킹설정 값
			List<Map<String, Object>> memberTrackingOptionList = trackingDAO.selectMemberTrackingOption(map); //사용자 트래킹 설정 조회
			
			for(int k=0; k<containsMemerList.size(); k++){
				memberIdNum = (String)containsMemerList.get(k);
				
				//memberTrackingOptionList이 1이면 default뿐이니 탈필요없음...
				if(memberTrackingOptionList.size()>1){
					memberTrackingOption = setMemberTrackingOption(memberIdNum, memberTrackingOptionList);
				}else{
					memberTrackingOption = memberTrackingOptionList.get(0);
				}
				
				checkMemberTrackingTypeCloseDate(memberIdNum, map.get("TRACKING_CATEGORY").toString(), bizStrategyCompanyKeyMilestones.get(i), memberTrackingOption); //사용자 기준으로 트래킹 이벤트 전송
			}
			
		}
	}
	
	public void trackingMenuBizStrategyClientIssue() throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("category", "client");
		List<Map<String, Object>> bizStrategyCompanyIssue = trackingDAO.selectBizStrategyCompanyIssueTracking(map);
		map.clear();
		
		for(int i=0; i<bizStrategyCompanyIssue.size(); i++){
			List<String> containsMemerList = new ArrayList<String>();
			Map<String, Object> memberTrackingOption = new HashMap<String, Object>();
			String[] memberIdArray = {};
			String memberIdNum = "";
			
			containsMemerList.add((String)bizStrategyCompanyIssue.get(i).get("ACTION_OWNER_ID"));
			containsMemerList.add((String)bizStrategyCompanyIssue.get(i).get("RESPONSIBILITY_LEADER"));
			
			//팀구성원 유무 확인
			if(bizStrategyCompanyIssue.get(i).get("TEAM_MEMBER_ID") != null && !"".equals(bizStrategyCompanyIssue.get(i).get("TEAM_MEMBER_ID"))){
				containsMemerList = addTeamMemberList(containsMemerList, (String)bizStrategyCompanyIssue.get(i).get("TEAM_MEMBER_ID")); //팀구성원 추가
			}
			
			containsMemerList = containsMemerList(containsMemerList); //중복제거
			memberIdArray = new String[containsMemerList.size()];
			
			for(int j=0; j<containsMemerList.size(); j++){
				memberIdArray[j] = containsMemerList.get(j);
			}
			
			memberIdArray = new HashSet<String>(Arrays.asList(memberIdArray)).toArray(new String[0]);
			String memIds = setMemberIdArray(memberIdArray);
			map.put("memberList", memIds);
			map.put("TRACKING_CATEGORY", 19); //고객전략 이슈 트래킹설정 값
			List<Map<String, Object>> memberTrackingOptionList = trackingDAO.selectMemberTrackingOption(map); //사용자 트래킹 설정 조회
			
			for(int k=0; k<containsMemerList.size(); k++){
				memberIdNum = (String)containsMemerList.get(k);
				
				//memberTrackingOptionList이 1이면 default뿐이니 탈필요없음...
				if(memberTrackingOptionList.size()>1){
					memberTrackingOption = setMemberTrackingOption(memberIdNum, memberTrackingOptionList);
				}else{
					memberTrackingOption = memberTrackingOptionList.get(0);
				}
				
				checkMemberTrackingTypeCloseDate(memberIdNum, map.get("TRACKING_CATEGORY").toString(), bizStrategyCompanyIssue.get(i), memberTrackingOption); //사용자 기준으로 트래킹 이벤트 전송
			}
			
		}
	}
	
	public void trackingMenuBizStrategyProjectPlanMilestones() throws Exception {
		Map<String, Object> map = new HashMap<>();
		List<Map<String, Object>> bizStrategyProjectPlanMilestones = trackingDAO.selectBizStrategyProjectPlanMilestonesTracking();
		
		for(int i=0; i<bizStrategyProjectPlanMilestones.size(); i++){
			List<String> containsMemerList = new ArrayList<String>();
			Map<String, Object> memberTrackingOption = new HashMap<String, Object>();
			String[] memberIdArray = {};
			String memberIdNum = "";
			
			containsMemerList.add((String)bizStrategyProjectPlanMilestones.get(i).get("ACT_ID"));
			containsMemerList.add((String)bizStrategyProjectPlanMilestones.get(i).get("SALES_OWNER"));
			containsMemerList.add((String)bizStrategyProjectPlanMilestones.get(i).get("EXEC_OWNER"));
			
			//팀구성원 유무 확인
			if(bizStrategyProjectPlanMilestones.get(i).get("TEAM_MEMBER_ID") != null && !"".equals(bizStrategyProjectPlanMilestones.get(i).get("TEAM_MEMBER_ID"))){
				containsMemerList = addTeamMemberList(containsMemerList, (String)bizStrategyProjectPlanMilestones.get(i).get("TEAM_MEMBER_ID")); //팀구성원 추가
			}
			
			containsMemerList = containsMemerList(containsMemerList); //중복제거
			memberIdArray = new String[containsMemerList.size()];
			
			for(int j=0; j<containsMemerList.size(); j++){
				memberIdArray[j] = containsMemerList.get(j);
			}
			
			memberIdArray = new HashSet<String>(Arrays.asList(memberIdArray)).toArray(new String[0]);
			String memIds = setMemberIdArray(memberIdArray);
			map.put("memberList", memIds);
			map.put("TRACKING_CATEGORY", 20); //전략프로젝트 마일스톤 트래킹설정 값
			List<Map<String, Object>> memberTrackingOptionList = trackingDAO.selectMemberTrackingOption(map); //사용자 트래킹 설정 조회
			
			for(int k=0; k<containsMemerList.size(); k++){
				memberIdNum = (String)containsMemerList.get(k);
				
				//memberTrackingOptionList이 1이면 default뿐이니 탈필요없음...
				if(memberTrackingOptionList.size()>1){
					memberTrackingOption = setMemberTrackingOption(memberIdNum, memberTrackingOptionList);
				}else{
					memberTrackingOption = memberTrackingOptionList.get(0);
				}
				
				checkMemberTrackingTypeCloseDate(memberIdNum, map.get("TRACKING_CATEGORY").toString(), bizStrategyProjectPlanMilestones.get(i), memberTrackingOption); //사용자 기준으로 트래킹 이벤트 전송
			}
			
		}
	}
	
	public void trackingMenuBizStrategyProjectPlanIssue() throws Exception {
		Map<String, Object> map = new HashMap<>();
		List<Map<String, Object>> bizStrategyProjectPlanIssue = trackingDAO.selectBizStrategyProjectPlanIssueTracking();
		
		for(int i=0; i<bizStrategyProjectPlanIssue.size(); i++){
			List<String> containsMemerList = new ArrayList<String>();
			Map<String, Object> memberTrackingOption = new HashMap<String, Object>();
			String[] memberIdArray = {};
			String memberIdNum = "";
			
			containsMemerList.add((String)bizStrategyProjectPlanIssue.get(i).get("ACTION_OWNER_ID"));
			containsMemerList.add((String)bizStrategyProjectPlanIssue.get(i).get("SALES_OWNER"));
			containsMemerList.add((String)bizStrategyProjectPlanIssue.get(i).get("EXEC_OWNER"));
			
			//팀구성원 유무 확인
			if(bizStrategyProjectPlanIssue.get(i).get("TEAM_MEMBER_ID") != null && !"".equals(bizStrategyProjectPlanIssue.get(i).get("TEAM_MEMBER_ID"))){
				containsMemerList = addTeamMemberList(containsMemerList, (String)bizStrategyProjectPlanIssue.get(i).get("TEAM_MEMBER_ID")); //팀구성원 추가
			}
			
			containsMemerList = containsMemerList(containsMemerList); //중복제거
			memberIdArray = new String[containsMemerList.size()];
			
			for(int j=0; j<containsMemerList.size(); j++){
				memberIdArray[j] = containsMemerList.get(j);
			}
			
			memberIdArray = new HashSet<String>(Arrays.asList(memberIdArray)).toArray(new String[0]);
			String memIds = setMemberIdArray(memberIdArray);
			map.put("memberList", memIds);
			map.put("TRACKING_CATEGORY", 21); //전략프로젝트 이슈 트래킹설정 값
			List<Map<String, Object>> memberTrackingOptionList = trackingDAO.selectMemberTrackingOption(map); //사용자 트래킹 설정 조회
			
			for(int k=0; k<containsMemerList.size(); k++){
				memberIdNum = (String)containsMemerList.get(k);
				
				//memberTrackingOptionList이 1이면 default뿐이니 탈필요없음...
				if(memberTrackingOptionList.size()>1){
					memberTrackingOption = setMemberTrackingOption(memberIdNum, memberTrackingOptionList);
				}else{
					memberTrackingOption = memberTrackingOptionList.get(0);
				}
				
				checkMemberTrackingTypeCloseDate(memberIdNum, map.get("TRACKING_CATEGORY").toString(), bizStrategyProjectPlanIssue.get(i), memberTrackingOption); //사용자 기준으로 트래킹 이벤트 전송
			}
			
		}
	}
	
	public List<Map<String, Object>> selectUserTrackingOption(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> list = trackingDAO.selectMemberTrackingOption(map);
		List<Map<String, Object>> option = new ArrayList<Map<String, Object>>();
		
		if(list.size()>0){
			String memberId = list.get(0).get("MEMBER_ID_NUM").toString();
			for(int i=0; i<list.size(); i++){
				if(!memberId.equals(list.get(i).get("MEMBER_ID_NUM").toString())){
					break;
				}else{
					option.add(list.get(i));
				}
			}
		}
		
		return option;
	}
	
	public int upsertUserTrackingOption(Map<String, Object> map) throws Exception {
		int cnt = 0;
		ArrayList<HashMap<String, Object>> trackingOptionList = CommonUtils.jsonList((map.get("trackingOptionData")).toString());
		
		for(Map<String,Object> getMap : trackingOptionList){
			String sortFrqncBeforeDate = "";
			String sortFrqncAfterDate = "";
			String[] frqncBeforeStrings = null;
			int[] frqncBeforeNums = null;
			String[] frqncAfterStrings = null;
			int[] frqncAfterNums = null;
			
			if(getMap.get("FRQNC_BEFROE") != null && !"".equals(getMap.get("FRQNC_BEFROE"))){
				frqncBeforeStrings = getMap.get("FRQNC_BEFROE").toString().split(",");
				frqncBeforeNums = new int[frqncBeforeStrings .length];
				
				for(int i=0; i<frqncBeforeStrings.length; i++){
					frqncBeforeNums[i] = Integer.parseInt(frqncBeforeStrings[i]);	
				}
				
				Arrays.sort(frqncBeforeNums);
				
				for(int array : frqncBeforeNums){
					sortFrqncBeforeDate += String.valueOf(array) + ",";
				}
				sortFrqncBeforeDate = sortFrqncBeforeDate.substring(0, sortFrqncBeforeDate.length()-1);
				
				if("Y".equals(getMap.get("FRQNC_BEFROE_USE_YN"))){
					getMap.put("BEFORE_DUE_DATE", frqncBeforeStrings[frqncBeforeStrings.length-1]);
				}
			}
			
			if(getMap.get("FRQNC_AFTER") != null && !"".equals(getMap.get("FRQNC_AFTER"))){
				frqncAfterStrings = getMap.get("FRQNC_AFTER").toString().split(",");
				frqncAfterNums = new int[frqncAfterStrings .length];
				
				for(int i=0;i< frqncAfterStrings.length; i++){
					frqncAfterNums[i] = Integer.parseInt(frqncAfterStrings[i]);	
				}
				
				Arrays.sort(frqncAfterNums);
				
				for(int array : frqncAfterNums){
					sortFrqncAfterDate += String.valueOf(array) + ",";
				}
				sortFrqncAfterDate = sortFrqncAfterDate.substring(0, sortFrqncAfterDate.length()-1);
				if("Y".equals(getMap.get("FRQNC_AFTER_USE_YN"))){
					getMap.put("FRQNC_AFTER", frqncAfterStrings[frqncAfterStrings.length-1]);
				}
			}
			//본부장 하위 직원들 전체 트래킹 설정 적용. 
			map.put("TRACKING_CATEGORY", getMap.get("TRACKING_CATEGORY"));
			List<Map<String, Object>> divisionMemberList = trackingDAO.selectDivisionMember(map); //같은 본부 직원들 select
			for(int i=0; i<divisionMemberList.size(); i++){
				getMap.put("MEMBER_ID_NUM", divisionMemberList.get(i).get("MEMBER_ID_NUM"));
				if(null == divisionMemberList.get(i).get("INSERT_YN")){
					cnt = trackingDAO.insertUserTrackingOption(getMap);
				}else{
					cnt = trackingDAO.updateUserTrackingOption(getMap);
				}
			}
		}
		
		return cnt;
	}
	
}
