package com.uni.sellers.clientsalesactive;

import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mobile.device.Device;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.uni.sellers.calendar.CalendarDAO;
import com.uni.sellers.common.CommonDAO;
import com.uni.sellers.common.CommonMailService;
import com.uni.sellers.util.CommonDateUtils;
import com.uni.sellers.util.CommonFileUtils;
import com.uni.sellers.util.CommonUtils;

@Service("clientSalesActiveService")
public class ClientSalesActiveService{
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="commonFileUtils")
	private CommonFileUtils commonFileUtils;
	
	@Resource(name="clientSalesActiveDAO")
	private ClientSalesActiveDAO clientSalesActiveDAO;
	
	@Resource(name="commonDAO")
	private CommonDAO commonDAO;
	
	@Resource(name="commonMailService")
    private CommonMailService commonMailService;
	
	@Resource(name="calendarDAO")
	private CalendarDAO calendarDAO;
	
	protected static SimpleDateFormat mFmtDate = new SimpleDateFormat( "yyyy-MM-dd", java.util.Locale.ENGLISH ) ;
	
	//고객컨택
	public List<Map<String, Object>> selectClientContactList(Map<String, Object> map) throws Exception {
		return clientSalesActiveDAO.selectClientContactList(map);
	}
	
	//지워도 되는지 모르겠음 2017 03 16 김진욱
	/*public Map<String, Object> clientContactSearchDetailGroup(Map<String, Object> map) throws Exception {
		return clientSalesActiveDAO.clientContactSearchDetailGroup(map);
	}*/
	
	public Map<String, Object> selectContactDetail(Map<String, Object> map) throws Exception {
		return clientSalesActiveDAO.selectContactDetail(map);
	}

	
	public List<Map<String, Object>> clientContactFileList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.clientContactFileList(map);
	}

	
	public Map<String, Object> insertClientContact(Map<String, Object> map, HttpServletRequest request, Device device) throws Exception {
		//캘린더 일정과 생산성 데이터 등록
		//insertCalendarEventAndProductivity(map);
		
		//아래부터 실제 고객컨택 등록 로직 
		int cnt = clientSalesActiveDAO.insertClientContact(map);
		
		//고객명 입력
		String[] clientArray = null;
		
		if(device.isNormal()) {
			clientArray = ((String) map.get("hiddenModalCustomerId")).split(",");
		}else {
			clientArray = ((String) map.get("hiddenModalCustomerIdList")).split(",");
		}				
				
		map.put("clientArray", clientArray);
		map.put("clientListCategory", "1");
		cnt = clientSalesActiveDAO.insertClientList(map);
		
		//Follow Up Action 입력
		ArrayList<HashMap<String, Object>> actionGridList = new ArrayList<>();
		
		String followUpAction = String.valueOf(map.get("contactFollowUpAction"));
		if(map.get("contactFollowUpAction") != null & !followUpAction.isEmpty()) {
			actionGridList = CommonUtils.jsonList(followUpAction);    
			
			for(Map<String,Object> getMap : actionGridList){
				getMap.put("pkNo",map.get("filePK"));
				getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
				cnt = clientSalesActiveDAO.insertContactFollowUpAction(getMap);
			}
		}		
		
		if(Boolean.valueOf((String)map.get("shareFlag"))){
			//컨택내용 공유
			if(!map.get("hiddenModalMemberList").toString().isEmpty()){
				String[] arrayList;
				ArrayList<Object> toAddr = new ArrayList<>();
				ArrayList<Object> toMember = new ArrayList<>();
				
				String memberInfo = (String) map.get("hiddenModalMemberList");
				arrayList = memberInfo.split(",");
				
				String shareMemberIdNum = "";
				String sharedMemberEmail = "";
				
				for(int i=0; i<arrayList.length; i++){
					String[] individualInfo;
					memberInfo = arrayList[i];
					individualInfo = memberInfo.split("/");
					shareMemberIdNum 	= individualInfo[0];	//공유 받는자 ID
					sharedMemberEmail 	= individualInfo[1];	//공유 받는자 이메일
					toAddr.add(sharedMemberEmail);
					toMember.add(shareMemberIdNum);
				}
				//메일 보내기
				commonMailService.shareContactSendMail(map,actionGridList,toAddr);
				//메일 로그
				for(Object toMemberId : toMember){
					commonDAO.insertEmailShareLog("client_event_log", (int)map.get("filePK"), toMemberId.toString(), map.get("hiddenModalCreatorId").toString());
				}
			}
		}
		
		//map, request, 파일테이블명, Foreign Key
		List<Map<String,Object>> fileList = commonFileUtils.insertFile(map, request, "CLIENT_EVENT_FILE_STORE","EVENT_ID");
		for(int i=0, size=fileList.size(); i < size; i++){
			commonDAO.insertFile(fileList.get(i));
			cnt ++;
		}
		
		map.put("cnt", cnt);
		
		return map;
	}
	
	
	public int updateClientContact(Map<String, Object> map, HttpServletRequest request, Device device) throws Exception {
		//캘린더 일정과 생산성 데이터 수정
		//updateCalendarEventAndProductivity(map);

		//아래부터 실제 고객컨택 수정 로직 
		int cnt = clientSalesActiveDAO.updateClientContact(map);

		//고객명 입력
		
		if(!device.isNormal()) {
			String[] clientArray = ((String) map.get("hiddenModalCustomerIdList")).split(",");
			map.put("clientArray", clientArray);
		}else {
			String[] clientArray = ((String) map.get("hiddenModalCustomerId")).split(",");
			map.put("clientArray", clientArray);
		}
		
		map.put("clientListCategory", "1");
		cnt = clientSalesActiveDAO.insertClientList(map);
				
		//Follow Up Action 입력
		ArrayList<HashMap<String, Object>> actionGridList = new ArrayList<>();
		
		String followUpAction = String.valueOf(map.get("contactFollowUpAction"));
		if(map.get("contactFollowUpAction") != null & !followUpAction.isEmpty()) {
			actionGridList = CommonUtils.jsonList(followUpAction);    
			
			for(Map<String,Object> getMap : actionGridList){
				getMap.put("pkNo",map.get("hiddenModalPK"));
				getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
				if(getMap.get("ACTION_ID") != null && !"".equals(getMap.get("ACTION_ID"))){
					cnt = clientSalesActiveDAO.updateContactFollowUpAction(getMap);
				}else{
					cnt = clientSalesActiveDAO.insertContactFollowUpAction(getMap);
				}
			}
		}	
		
		if(Boolean.valueOf((String)map.get("shareFlag"))){
			map.put("filePK",Integer.valueOf((String)map.get("hiddenModalPK")));
			//컨택내용 공유
			if(!map.get("hiddenModalMemberList").toString().isEmpty()){
				String[] arrayList;
				ArrayList<Object> toAddr = new ArrayList<>();
				ArrayList<Object> toMember = new ArrayList<>();
				
				String memberInfo = (String) map.get("hiddenModalMemberList");
				arrayList = memberInfo.split(",");
				
				String shareMemberIdNum = "";
				String sharedMemberEmail = "";
				
				for(int i=0; i<arrayList.length; i++){
					String[] individualInfo;
					memberInfo = arrayList[i];
					individualInfo = memberInfo.split("/");
					shareMemberIdNum 	= individualInfo[0];	//공유 받는자 ID
					sharedMemberEmail 	= individualInfo[1];	//공유 받는자 이메일
					toAddr.add(sharedMemberEmail);
					toMember.add(shareMemberIdNum);
				}
				//메일 보내기
				commonMailService.shareContactSendMail(map,actionGridList,toAddr);
				//메일 로그
				for(Object toMemberId : toMember){
					commonDAO.insertEmailShareLog("client_event_log", (int)map.get("filePK"), toMemberId.toString(), map.get("hiddenModalCreatorId").toString());
				}
			}
		}
		
		
		map.put("filePK", map.get("hiddenModalPK"));
		map.put("filePKArray", map.get("hiddenModalPK"));
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request,"CLIENT_EVENT_FILE_STORE","EVENT_ID");
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}
		return cnt;
	}

	//캘린더 일정과 생산성 데이터 등록
	public void insertCalendarEventAndProductivity(Map<String, Object> map) throws Exception{
		//캘린더 생성여부 확인,생성 후 캘린더id 반환
		int calMstId = calMasterCheck(map);
		
		//캘린더 일정 등록 후 이벤트id 반환
		int calEvtId = insertClientContactToCalendarEvent(map, calMstId);
		map.put("CALENDAR_EVENT_ID", calEvtId);
		
		String todayDate = CommonDateUtils.getToday();
		String eventDate = (String) map.get("textModalEventDate"); //컨택일
		if(eventDate.compareTo(todayDate) < 0){ //등록된 일정의 날짜가 오늘보다 이전일 경우
			Map<String, Object> analMap = new HashMap<String, Object>();
			//생산성분석 테이블에 일정의 날짜 사용자 데이터 있는지 select
			analMap.put("MEMBER_ID_NUM", map.get("hiddenModalCreatorId"));
			analMap.put("ANAL_DATE", eventDate);
			analMap = commonDAO.selectMemberFaceTime(analMap);
			
			if(analMap != null){ // 잇으면 update
				float actCodeOneTime = Float.parseFloat(String.valueOf(analMap.get("ACTIVITY_CODE_1_TIME"))); //고객컨택분석 수치
				float eventActTime = Float.parseFloat(String.valueOf(map.get("hiddenModalAfterAnalEventTime")));
				analMap.put("ACTIVITY_CODE_1_TIME", actCodeOneTime + eventActTime);
				
				commonDAO.updateMemberFaceTime(analMap);
			}else{ //없으면 insert
				analMap = new HashMap<String, Object>();
				analMap.put("MEMBER_ID_NUM", map.get("hiddenModalCreatorId"));
				analMap.put("ANAL_DATE", eventDate);
				float eventActTime = Float.parseFloat(String.valueOf(map.get("hiddenModalAfterAnalEventTime")));
				analMap.put("ACTIVITY_CODE_1_TIME", eventActTime);
				
				commonDAO.insertMemberFaceTime(analMap);
			}
		}
	}
	
	//캘린더 일정과 생산성 데이터 수정
	public void updateCalendarEventAndProductivity(Map<String, Object> map) throws Exception{
		//캘린더 생성여부 확인,생성 후 캘린더id 반환
		int calMstId = calMasterCheck(map);
		if(map.get("hiddenModalCalendarEventId") != null && !"".equals(map.get("hiddenModalCalendarEventId"))){ //고객컨택과 연동된 캘린더일정이 있으면
			//해당 일정 수정
			updateClientContactToCalendarEvent(map, calMstId);
			
			String todayDate = CommonDateUtils.getToday();
			String beforeEventDate = (String) map.get("hiddenModalBeforeEventDate"); //수정 전 컨택일
			String eventDate = (String) map.get("textModalEventDate"); //컨택일
			Map<String, Object> analMap = null;
			
			if(beforeEventDate.compareTo(todayDate) < 0){ //등록했던 일정의 날짜가 오늘보다 이전일 경우
				analMap = new HashMap<String, Object>();
				
				//생산성분석 테이블에 일정의 날짜 사용자 데이터 있는지 select
				analMap.put("MEMBER_ID_NUM", map.get("hiddenModalCreatorId"));
				analMap.put("ANAL_DATE", beforeEventDate);
				analMap = commonDAO.selectMemberFaceTime(analMap);
				
				if(analMap != null){ // 잇으면 update
					float actCodeOneTime = Float.parseFloat(String.valueOf(analMap.get("ACTIVITY_CODE_1_TIME"))); //고객컨택분석 수치
					float eventActTime = Float.parseFloat(String.valueOf(map.get("hiddenModalBeforeAnalEventTime")));
					analMap.put("ACTIVITY_CODE_1_TIME", actCodeOneTime - eventActTime);
					
					commonDAO.updateMemberFaceTime(analMap);
				}
			}
			if(eventDate.compareTo(todayDate) < 0){ //등록된 일정의 날짜가 오늘보다 이전일 경우
				analMap = new HashMap<String, Object>();
				
				//생산성분석 테이블에 일정의 날짜 사용자 데이터 있는지 select
				analMap.put("MEMBER_ID_NUM", map.get("hiddenModalCreatorId"));
				analMap.put("ANAL_DATE", eventDate);
				analMap = commonDAO.selectMemberFaceTime(analMap);
				
				if(analMap != null){ // 잇으면 update
					float actCodeOneTime = Float.parseFloat(String.valueOf(analMap.get("ACTIVITY_CODE_1_TIME"))); //고객컨택분석 수치
					float eventActTime = Float.parseFloat(String.valueOf(map.get("hiddenModalAfterAnalEventTime")));
					analMap.put("ACTIVITY_CODE_1_TIME", actCodeOneTime + eventActTime);
					
					commonDAO.updateMemberFaceTime(analMap);
				}else{ //없으면 insert
					analMap = new HashMap<String, Object>();
					analMap.put("MEMBER_ID_NUM", map.get("hiddenModalCreatorId"));
					analMap.put("ANAL_DATE", eventDate);
					float eventActTime = Float.parseFloat(String.valueOf(map.get("hiddenModalAfterAnalEventTime")));
					analMap.put("ACTIVITY_CODE_1_TIME", eventActTime);
					
					commonDAO.insertMemberFaceTime(analMap);
				}
			}
			
		}else{ //고객컨택과 연동된 캘린더일정이 없으면
			//캘린더 일정 등록 후 이벤트id 반환
			int calEvtId = insertClientContactToCalendarEvent(map, calMstId);
			map.put("hiddenModalCalendarEventId", calEvtId);
			
			String todayDate = CommonDateUtils.getToday();
			String eventDate = (String) map.get("textModalEventDate"); //컨택일
			if(eventDate.compareTo(todayDate) < 0){ //등록된 일정의 날짜가 오늘보다 이전일 경우
				Map<String, Object> analMap = new HashMap<String, Object>();
				//생산성분석 테이블에 일정의 날짜 사용자 데이터 있는지 select
				analMap.put("MEMBER_ID_NUM", map.get("hiddenModalCreatorId"));
				analMap.put("ANAL_DATE", eventDate);
				analMap = commonDAO.selectMemberFaceTime(analMap);
				
				if(analMap != null){ // 잇으면 update
					float actCodeOneTime = Float.parseFloat(String.valueOf(analMap.get("ACTIVITY_CODE_1_TIME"))); //고객컨택분석 수치
					float eventActTime = Float.parseFloat(String.valueOf(map.get("hiddenModalAfterAnalEventTime")));
					analMap.put("ACTIVITY_CODE_1_TIME", actCodeOneTime + eventActTime);
					
					commonDAO.updateMemberFaceTime(analMap);
				}else{ //없으면 insert
					analMap = new HashMap<String, Object>();
					analMap.put("MEMBER_ID_NUM", map.get("hiddenModalCreatorId"));
					analMap.put("ANAL_DATE", eventDate);
					float eventActTime = Float.parseFloat(String.valueOf(map.get("hiddenModalAfterAnalEventTime")));
					analMap.put("ACTIVITY_CODE_1_TIME", eventActTime);
					
					commonDAO.insertMemberFaceTime(analMap);
				}
			}
		}
	}
	
	//캘린더 생성유무 확인 및 생성 and 캘린더id값 전달
	public int calMasterCheck(Map<String, Object> map) throws Exception{
		Map<String, Object> calMap = new HashMap<String, Object>();
		String memberId = (String)map.get("hiddenModalCreatorId");
		int calendarMasterId;
		calMap.put("inviteId", memberId);
		
		calMap = calendarDAO.selectInvitedCalendarMaster(calMap);
		
		//없으면 캘린더 생성
		if(calMap == null){
			calMap = new HashMap<String, Object>();
			calMap.put("hiddenModalCreatorId", memberId);
			calMap.put("textCalendarName", "나의 캘린더");
			
			calendarDAO.addCalendar(calMap);
			calendarMasterId = (int)calMap.get("filePK");
		}else{
			calendarMasterId = ((BigInteger)calMap.get("CALENDAR_ID")).intValue();
		}
		
		return calendarMasterId;
	}
	
	//고객컨택 등록시 일정 등록
	public int insertClientContactToCalendarEvent(Map<String, Object> map, int calendarMasterId) throws Exception{
		Map<String, Object> eventMap = new HashMap<String, Object>();
		
		eventMap.put("hiddenModalCalendarId", calendarMasterId);
		eventMap.put("hiddenModalCreatorId", map.get("hiddenModalCreatorId"));
		eventMap.put("selectModalEventCode", 1);
		eventMap.put("textModalEventSubject", map.get("textModalSubject"));
		eventMap.put("hiddenModalAllday_YN", "N");
		eventMap.put("hiddenModalRepeat_YN", "N");
		eventMap.put("alarmFlag", "N");
		eventMap.put("textModalStartDate", map.get("textModalEventDate"));
		eventMap.put("selectModalStartDateTime", map.get("selectModalStartDateTime"));
		eventMap.put("hiddenModalEndDate", map.get("textModalEventDate"));
		eventMap.put("selectModalEndDateTime", map.get("selectModalEndDateTime"));
		
		StringBuilder detailContent = new StringBuilder();
		detailContent.append("컨택방법 : "+(String)map.get("selectModalCategory")+"\n");
		detailContent.append("컨택고객 : "+(String)map.get("hiddenModalCcList")+"\n");
		detailContent.append("상새내용\n"+(String)map.get("textareaModalEventContents"));
		eventMap.put("textareaModalEventDetail", detailContent.toString());
		
		calendarDAO.insertCalendarEvent(eventMap);
		int eventId = (int)eventMap.get("EVENT_ID");
		
		return eventId;
	}
	
	//고객컨택수정 시 연동된 일정도 수정
	public int updateClientContactToCalendarEvent(Map<String, Object> map, int calendarMasterId) throws Exception{
		Map<String, Object> eventMap = new HashMap<String, Object>();
		
		eventMap.put("hiddenModalCalendarId", calendarMasterId);
		eventMap.put("selectModalEventCode", 1);
		eventMap.put("textModalEventSubject", map.get("textModalSubject"));
		eventMap.put("hiddenModalAllday_YN", "N");
		eventMap.put("hiddenModalRepeat_YN", "N");
		eventMap.put("alarmFlag", "N");
		eventMap.put("radioModalShareYN", "N");
		eventMap.put("textModalStartDate", map.get("textModalEventDate"));
		eventMap.put("selectModalStartDateTime", map.get("selectModalStartDateTime"));
		eventMap.put("hiddenModalEndDate", map.get("textModalEventDate"));
		eventMap.put("selectModalEndDateTime", map.get("selectModalEndDateTime"));
		
		StringBuilder detailContent = new StringBuilder();
		detailContent.append("컨택방법 : "+(String)map.get("selectModalCategory")+"\n");
		detailContent.append("컨택고객 : "+(String)map.get("hiddenModalCcList")+"\n");
		detailContent.append("상새내용\n"+(String)map.get("textareaModalEventContents"));
		eventMap.put("textareaModalEventDetail", detailContent.toString());
		
		eventMap.put("hiddenModalEventId", map.get("hiddenModalCalendarEventId"));
		
		int cnt = calendarDAO.updateCalendarEvent(eventMap);
		
		return cnt;
	}
	
	public int deleteClientContact(Map<String, Object> map, HttpServletRequest request) throws Exception {
		map.put("filePK", map.get("hiddenModalPK"));
		map.put("filePKArray", map.get("hiddenModalPK"));
		
		List<Map<String, Object>> fileList = clientSalesActiveDAO.clientContactFileList(map);
		int cnt = clientSalesActiveDAO.deleteClientContact(map);		
		commonFileUtils.deleteFileAll(fileList,request);
		return cnt;
	}
	
	
	public List<Map<String, Object>> gridContactActionItems(Map<String, Object> map) throws Exception {
		return clientSalesActiveDAO.gridContactActionItems(map);		
	}
	
	
	public int insertContactActionItem(Map<String, Object> map) throws Exception {
		int cnt = 0;
		ObjectMapper mapper = new ObjectMapper();
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>(); 
		String jsonData = (map.get("detailsData")).toString();		 
		list = mapper.readValue(jsonData, new TypeReference<ArrayList<HashMap<String, String>>>() {});        
		
		for(Map<String,Object> getMap : list){
			getMap.put("hiddenModalPK",map.get("hiddenModalPK"));
			getMap.put("hiddenModalCreatorId",map.get("creator_id"));
			if(getMap.get("ACTION_ID") != null && !"".equals(getMap.get("ACTION_ID"))){
				cnt = clientSalesActiveDAO.updateContactActionItem(getMap);
			}else{
				cnt = clientSalesActiveDAO.insertContactActionItem(getMap);
			}
		}
		return cnt;
	}
	
	
	public int deleteContactActionItem(Map<String, Object> map) throws Exception {
		return clientSalesActiveDAO.deleteContactActionItem(map);
	}
	
	
	public Map<String, Object> insertHiddenOpportunity(Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		int cnt = clientSalesActiveDAO.insertHiddenOpportunity(map);
		
		
		ArrayList<HashMap<String, Object>> actionPlanList = CommonUtils.jsonList((map.get("hiddenActionPlan")).toString());
		
		for(Map<String,Object> getMap : actionPlanList){
			getMap.put("returnPK",map.get("filePK"));
			getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
			cnt = clientSalesActiveDAO.insertHiddenOpportunityActionPlan(getMap);
		}
		
		if(Boolean.valueOf((String)map.get("shareFlag"))){
			//잠재기회 공유
			if(!map.get("hiddenModalMemberList").toString().isEmpty()){
				String[] arrayList;
				ArrayList<Object> toAddr = new ArrayList<>();
				ArrayList<Object> toMember = new ArrayList<>();
				
				String memberInfo = (String) map.get("hiddenModalMemberList");
				arrayList = memberInfo.split(",");
				
				String shareMemberIdNum = "";
				String sharedMemberEmail = "";
				
				for(int i=0; i<arrayList.length; i++){
					String[] individualInfo;
					memberInfo = arrayList[i];
					individualInfo = memberInfo.split("/");
					shareMemberIdNum 	= individualInfo[0];	//공유 받는자 ID
					sharedMemberEmail 	= individualInfo[1];	//공유 받는자 이메일
					toAddr.add(sharedMemberEmail);
					toMember.add(shareMemberIdNum);
				}
				//메일 보내기
				commonMailService.shareHiddenOppSendMail(map,actionPlanList,toAddr);
				//메일 로그
				for(Object toMemberId : toMember){
					commonDAO.insertEmailShareLog("opportunity_hidden_log", (int)map.get("filePK"), toMemberId.toString(), map.get("hiddenModalCreatorId").toString());
				}
			}
		}
		
		map.put("cnt", cnt);
		
		
		return map;
	}
	
	//임시저장 확인 카운트
	public int selectTempCountOpp(Map<String, Object> map) throws Exception {
		return clientSalesActiveDAO.selectTempCountOpp(map);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//잠재기회
	
	public List<Map<String, Object>> selectHiddenOpportunity(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		List<Map<String, Object>> list = clientSalesActiveDAO.selectHiddenOpportunity(map);
		//List<Map<String, Object>> actionStatusList = null;
		
		/*for(int i=0; i< list.size(); i++){
			
			Map<String, Object> tmp = new HashMap<>();
			
			map.put("OPPORTUNITY_HIDDEN_ID", list.get(i).get("OPPORTUNITY_HIDDEN_ID"));
			actionStatusList = clientSalesActiveDAO.selectHiddenOpportunityActionStatus(map);
			
			for(int j=0; j< actionStatusList.size(); j++){
				
				actionStatusList.get(j).get("STATUS");
				
				if(actionStatusList.get(j).get("STATUS").equals("G")){
					tmp.put("green", actionStatusList.get(j).get("STATUS"));
				}else if(actionStatusList.get(j).get("STATUS").equals("Y")){
					tmp.put("yellow", actionStatusList.get(j).get("STATUS"));
				}else if(actionStatusList.get(j).get("STATUS").equals("R")){
					tmp.put("red", actionStatusList.get(j).get("STATUS"));
				}
				
			}
			
			if(tmp.get("green") !=null && tmp.get("yellow")==null && tmp.get("red")==null){
				list.get(i).put("HIDDEN_OPPORTINITY_ACTION_STATUS", "#1ab394");
			}else if (tmp.get("yellow") !=null && tmp.get("red") ==null){
				list.get(i).put("HIDDEN_OPPORTINITY_ACTION_STATUS", "#ffc000");
			}else if (tmp.get("red") !=null){
				list.get(i).put("HIDDEN_OPPORTINITY_ACTION_STATUS", "#f20056");
			}
		}*/
		
		return list;
	}
	
	
	public Map<String, Object> selectHiddenOpportunityDetail(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.selectHiddenOpportunityDetail(map);
	}
	
	
	public int updateHiddenOpportunity(Map<String, Object> map) throws Exception {
		int cnt = 0;
		cnt = clientSalesActiveDAO.updateHiddenOpportunity(map);
				
		ArrayList<HashMap<String, Object>> actionPlanList = CommonUtils.jsonList((map.get("hiddenActionPlan")).toString());
		
		for(Map<String,Object> getMap : actionPlanList){
			getMap.put("returnPK",map.get("hiddenModalPK"));
			getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
			if(getMap.get("ACTION_ID") != null && !"".equals(getMap.get("ACTION_ID"))){
				cnt = clientSalesActiveDAO.updateHiddenOpportunityActionPlan(getMap);
			}else{
				cnt = clientSalesActiveDAO.insertHiddenOpportunityActionPlan(getMap);
			}
		}
		
		if(Boolean.valueOf((String)map.get("shareFlag"))){
			map.put("filePK",Integer.valueOf((String)map.get("hiddenModalPK")));
			//잠재기회 공유
			if(!map.get("hiddenModalMemberList").toString().isEmpty()){
				String[] arrayList;
				ArrayList<Object> toAddr = new ArrayList<>();
				ArrayList<Object> toMember = new ArrayList<>();
				
				String memberInfo = (String) map.get("hiddenModalMemberList");
				arrayList = memberInfo.split(",");
				
				String shareMemberIdNum = "";
				String sharedMemberEmail = "";
				
				for(int i=0; i<arrayList.length; i++){
					String[] individualInfo;
					memberInfo = arrayList[i];
					individualInfo = memberInfo.split("/");
					shareMemberIdNum 	= individualInfo[0];	//공유 받는자 ID
					sharedMemberEmail 	= individualInfo[1];	//공유 받는자 이메일
					toAddr.add(sharedMemberEmail);
					toMember.add(shareMemberIdNum);
				}
				//메일 보내기
				commonMailService.shareHiddenOppSendMail(map,actionPlanList,toAddr);
				//메일 로그
				for(Object toMemberId : toMember){
					commonDAO.insertEmailShareLog("opportunity_hidden_log", (int)map.get("filePK"), toMemberId.toString(), map.get("hiddenModalCreatorId").toString());
				}
			}
		}
		
		return cnt;
	}
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//영업기회 리스트
	public List<Map<String, Object>> gridOpportunity(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.gridOpportunity(map);
	}

	
	public Map<String, Object> opportunitySearchDetailGroup(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.opportunitySearchDetailGroup(map);
	}
	
	
	public Map<String, Object> selectOpportunityDetail(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.selectOpportunityDetail(map);
	}

	//영업기회 파일
	public List<Map<String, Object>> opportunityFileList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.opportunityFileList(map);
	}

	//영업기회 매출품목
	public List<Map<String, Object>> selectOpportunityProductSalesList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.selectOpportunityProductSalesList(map);
	}
	
	//영업기회 매입품목
	public List<Map<String, Object>> selectOpportunityProductPsList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.selectOpportunityProductPsList(map);
	}
	
	public int insertOpportunity(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = clientSalesActiveDAO.insertOpportunity(map);
		
		//영업 단계
		ArrayList<HashMap<String, Object>> scCheckList = CommonUtils.jsonList((map.get("scCheckList")).toString());
		ArrayList<HashMap<String, Object>> scCheckList2 = new ArrayList<HashMap<String,Object>>(); 
		for(HashMap<String, Object> getMap : scCheckList){
			getMap.put("pkNo",map.get("filePK"));
			scCheckList2.add(getMap);
		}
		
		if(!scCheckList2.isEmpty()) {
			clientSalesActiveDAO.insertOpportunityScCheck(scCheckList2);
		}
		
		//매출 품목
		ArrayList<HashMap<String, Object>> productSalesList = CommonUtils.jsonList((map.get("productSalesData")).toString());
		for(Map<String,Object> getMap : productSalesList){
			getMap.put("pkNo",map.get("filePK"));
			cnt = clientSalesActiveDAO.insertOpportunityProductSales(getMap);
		}
		
		//매입 품목
		ArrayList<HashMap<String, Object>> productPsList = CommonUtils.jsonList((map.get("productPsData")).toString());
		for(Map<String,Object> getMap : productPsList){
			getMap.put("pkNo",map.get("filePK"));
			cnt = clientSalesActiveDAO.insertOpportunityProductPs(getMap);
		}
		
		//매출 계획 
		ArrayList<HashMap<String, Object>> salesPlanList = CommonUtils.jsonList((map.get("salesPlanData")).toString());
		if(salesPlanList.size() == 0) {
			map.put("pkNo",map.get("filePK"));
			cnt = clientSalesActiveDAO.insertOpportunitySalesPlan(map);
		}else {
			for(Map<String,Object> getMap : salesPlanList){
				getMap.put("pkNo",map.get("filePK"));
				getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
				getMap.put("hiddenModalOwnerId",map.get("hiddenModalOwnerId"));
				cnt = clientSalesActiveDAO.insertOpportunitySalesPlan(getMap);
			}
		}
		
		
		//매출 계획 스플릿
		ArrayList<HashMap<String, Object>> salesSplitList = CommonUtils.jsonList((map.get("salesSplitData")).toString());
		for(Map<String,Object> getMap : salesSplitList){
			getMap.put("pkNo",map.get("filePK"));
			cnt = clientSalesActiveDAO.insertOpportunitySalesSplit(getMap);
		}
		
		//마일스톤
		clientSalesActiveDAO.deleteOpportunityMilestone(map); //삭제 후 insert
		ArrayList<HashMap<String, Object>> mileStoneList = CommonUtils.jsonList((map.get("mileStoneData")).toString());    
		for(Map<String,Object> getMap : mileStoneList){
			getMap.put("pkNo",map.get("filePK"));
			getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
			cnt = clientSalesActiveDAO.insertOpportunityMilestone(getMap);
		}
		
		/*clientSalesActiveDAO.deleteSalesCheckList(map); //삭제 후 insert
		ArrayList<HashMap<String, Object>> checkMasterList = CommonUtils.jsonList((map.get("checkMasterList")).toString());
		ArrayList<HashMap<String, Object>> checkSubList = CommonUtils.jsonList((map.get("checkSubList")).toString());
		//CheckList Main
		for(Map<String, Object> getMap : checkMasterList){
			getMap.put("filePK",map.get("filePK"));
			getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
			cnt = clientSalesActiveDAO.insertCheckList(getMap);
		}
		//CheckList sub
		for(Map<String, Object> getMap : checkSubList){
			getMap.put("hiddenModalPK",map.get("filePK"));
			getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
			cnt = clientSalesActiveDAO.insertSalesCycleActionPlan(getMap);
		}*/
		
		if(!"mobile".equals(map.get("deviceCheck").toString())){
			clientSalesActiveDAO.deleteSalesWinList(map); //삭제 후 insert
			ArrayList<HashMap<String, Object>> winMasterList = CommonUtils.jsonList((map.get("winMasterList")).toString());
			ArrayList<HashMap<String, Object>> winSubList = CommonUtils.jsonList((map.get("winSubList")).toString());
			//WinPlan Main
			for(Map<String, Object> getMap : winMasterList){
				getMap.put("filePK",map.get("filePK"));
				getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
				cnt = clientSalesActiveDAO.insertCheckListOwner(getMap);
			}
			//WinPlan sub
			for(Map<String, Object> getMap : winSubList){
				getMap.put("hiddenModalPK",map.get("filePK"));
				getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
				cnt = clientSalesActiveDAO.insertSalesCycleWinPlan(getMap);
			}		
		}
		
		//map, request, 파일테이블명, Foreign Key
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request, "OPPORTUNITY_FILE_STORE","OPPORTUNITY_ID");
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}
		
		//영업기회가 close되면 성과테이블 insert
		/*if("6".equals(map.get("hiddenModalSalesCycle")) && "In".equals(map.get("radioModalForecastYN"))){
			clientSalesActiveDAO.deleteOpportunitySalesActual((int)map.get("filePK"));
			for(Map<String,Object> getMap : salesPlanList){
				getMap.put("member_id_num", (String)map.get("hiddenModalIdentifierId"));
				getMap.put("opportunity_id", (int)map.get("filePK"));
				cnt = clientSalesActiveDAO.insertOpportunitySalesActual(getMap);
			}
		}*/
		return cnt;
	}

	
	public int updateOpportunity(Map<String, Object> map, HttpServletRequest request) throws Exception {
		//업데이트 전 히스토리 남기기 (영업기회, 매출)
		clientSalesActiveDAO.insertHistoryOpportunity(map);
		
		int cnt = clientSalesActiveDAO.updateOpportunity(map);
		
		//영업 단계
		ArrayList<HashMap<String, Object>> scCheckList = CommonUtils.jsonList((map.get("scCheckList")).toString());
		ArrayList<HashMap<String, Object>> scCheckList2 = new ArrayList<HashMap<String,Object>>(); 
		for(HashMap<String, Object> getMap : scCheckList){
			getMap.put("pkNo",map.get("hiddenModalPK"));
			scCheckList2.add(getMap);
		}
		if(!scCheckList2.isEmpty()) {
			clientSalesActiveDAO.insertOpportunityScCheck(scCheckList2);
		}
		
		//매출 품목
		ArrayList<HashMap<String, Object>> productSalesList = CommonUtils.jsonList((map.get("productSalesData")).toString());
		clientSalesActiveDAO.deleteOpportunityProductSales(map);
		for(Map<String,Object> getMap : productSalesList){
			getMap.put("pkNo",map.get("hiddenModalPK"));
			cnt = clientSalesActiveDAO.insertOpportunityProductSales(getMap);
		}
		
		//매입 품목
		ArrayList<HashMap<String, Object>> productPsList = CommonUtils.jsonList((map.get("productPsData")).toString());
		clientSalesActiveDAO.deleteOpportunityProductPs(map);
		for(Map<String,Object> getMap : productPsList){
			getMap.put("pkNo",map.get("hiddenModalPK"));
			cnt = clientSalesActiveDAO.insertOpportunityProductPs(getMap);
		}
				
		//매출 계획 
		ArrayList<HashMap<String, Object>> salesPlanList = CommonUtils.jsonList((map.get("salesPlanData")).toString());
		clientSalesActiveDAO.deleteOpportunitySalesPlan(map);
		if(salesPlanList.size() == 0) {
			map.put("pkNo",map.get("hiddenModalPK"));
			cnt = clientSalesActiveDAO.insertOpportunitySalesPlan(map);
		}else {
			for(Map<String,Object> getMap : salesPlanList){
				getMap.put("pkNo",map.get("hiddenModalPK"));
				getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
				getMap.put("hiddenModalOwnerId",map.get("hiddenModalOwnerId"));
				cnt = clientSalesActiveDAO.insertOpportunitySalesPlan(getMap);
			}
		}
		
		//매출 계획 스플릿
		ArrayList<HashMap<String, Object>> salesSplitList = CommonUtils.jsonList((map.get("salesSplitData")).toString());
		clientSalesActiveDAO.deleteOpportunitySalesSplit(map);
		for(Map<String,Object> getMap : salesSplitList){
			getMap.put("pkNo",map.get("hiddenModalPK"));
			cnt = clientSalesActiveDAO.insertOpportunitySalesSplit(getMap);
		}
		
		//마일스톤
		map.put("filePK", map.get("hiddenModalPK"));
		clientSalesActiveDAO.deleteOpportunityMilestone(map); //삭제 후 insert
		ArrayList<HashMap<String, Object>> mileStoneList = CommonUtils.jsonList((map.get("mileStoneData")).toString());    
		for(Map<String,Object> getMap : mileStoneList){
			getMap.put("pkNo",map.get("hiddenModalPK"));
			getMap.put("hiddenModalPK",map.get("hiddenModalPK"));
			getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
			cnt = clientSalesActiveDAO.insertOpportunityMilestone(getMap);
		}
		
		//CheckList
		/*clientSalesActiveDAO.deleteSalesCheckList(map); //삭제 후 insert
		ArrayList<HashMap<String, Object>> checkMasterList = CommonUtils.jsonList((map.get("checkMasterList")).toString());
		ArrayList<HashMap<String, Object>> checkSubList = CommonUtils.jsonList((map.get("checkSubList")).toString());
		//CheckList Main
		for(Map<String, Object> getMap : checkMasterList){
			getMap.put("filePK",map.get("hiddenModalPK"));
			getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
			cnt = clientSalesActiveDAO.insertCheckList(getMap);
		}
		
		//CheckList sub
		for(Map<String, Object> getMap : checkSubList){
			getMap.put("hiddenModalPK",map.get("hiddenModalPK"));
			getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
			cnt = clientSalesActiveDAO.insertSalesCycleActionPlan(getMap);
		}*/
		
		if(!"mobile".equals(map.get("deviceCheck").toString())){
			clientSalesActiveDAO.deleteSalesWinList(map); //삭제 후 insert
			ArrayList<HashMap<String, Object>> winMasterList = CommonUtils.jsonList((map.get("winMasterList")).toString());
			ArrayList<HashMap<String, Object>> winSubList = CommonUtils.jsonList((map.get("winSubList")).toString());
			//WinPlan Main
			for(Map<String, Object> getMap : winMasterList){
				getMap.put("filePK",map.get("filePK"));
				getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
				cnt = clientSalesActiveDAO.insertCheckListOwner(getMap);
			}
			//WinPlan sub
			for(Map<String, Object> getMap : winSubList){
				getMap.put("hiddenModalPK",map.get("filePK"));
				getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
				cnt = clientSalesActiveDAO.insertSalesCycleWinPlan(getMap);
			}			
		}
		
		//map, request, 파일테이블명, Foreign Key
		map.put("filePK", map.get("hiddenModalPK"));
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request,"OPPORTUNITY_FILE_STORE","OPPORTUNITY_ID");
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}
		
		//영업기회가 close되면 성과테이블 insert
		/*if("6".equals((String)map.get("hiddenModalSalesCycle")) && "In".equals((String)map.get("radioModalForecastYN"))){
			clientSalesActiveDAO.deleteOpportunitySalesActual(Integer.parseInt((String) map.get("filePK")));
			for(Map<String,Object> getMap : salesPlanList){
				getMap.put("member_id_num", (String)map.get("hiddenModalIdentifierId"));
				getMap.put("opportunity_id", Integer.parseInt((String) map.get("filePK")));
				cnt = clientSalesActiveDAO.insertOpportunitySalesActual(getMap);
			}
		}else{
		//영업기회가 close에서 바뀔수도 있으니 close가 아니면 삭제 -> 추후 로직 변경해야한다 삭제 말고~
			clientSalesActiveDAO.deleteOpportunitySalesActual(Integer.parseInt((String) map.get("filePK")));
		}*/
		return cnt;
	}

	
	public int deleteOpportunity(Map<String, Object> map, HttpServletRequest request) throws Exception {
		map.put("filePK", map.get("hiddenModalPK"));
		map.put("filePKArray", map.get("hiddenModalPK"));
		
		List<Map<String, Object>> fileList = clientSalesActiveDAO.opportunityFileList(map);
		commonFileUtils.deleteFileAll(fileList,request);
		
		int cnt = clientSalesActiveDAO.deleteOpportunity(map);
		
		return cnt;
	}

	
	public List<Map<String, Object>> selectOpportunityMilestons(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.selectOpportunityMilestons(map);

	}
	
	public int insertSalesCycleActionPlan(Map<String, Object> map) throws Exception {
		int cnt = 0;
		String checklist_id = "";
		
		ObjectMapper mapper = new ObjectMapper();
		ArrayList<HashMap<String, Object>> paramList = new ArrayList<HashMap<String,Object>>(); 
		String jsonData = (map.get("saleCycleActionPlanData")).toString();
		paramList = mapper.readValue(jsonData, new TypeReference<ArrayList<HashMap<String, String>>>() {});        
		
		for(Map<String, Object> paramMap : paramList){
			
			paramMap.put("hiddenModalPK",map.get("hiddenModalPK"));
			paramMap.put("hiddenModalCreatorId",map.get("creator_id"));
			
			if(!checklist_id.equals((String) paramMap.get("CHECKLIST_ID"))){
				checklist_id = (String) paramMap.get("CHECKLIST_ID");
				cnt = clientSalesActiveDAO.updateSalesCheckList(paramMap);
			}
			
			if(paramMap.get("ACTION_ID") != null && !"".equals(paramMap.get("ACTION_ID"))){
				cnt = clientSalesActiveDAO.updateSalesCycleActionPlan(paramMap);
			}else{
				cnt = clientSalesActiveDAO.insertSalesCycleActionPlan(paramMap);
			}
		}
		
		return cnt;
	}
	
	
	public int insertSalesCycleWinPlan(Map<String, Object> map) throws Exception {
		int cnt = 0;
		String checklist_id = "";
		
		ObjectMapper mapper = new ObjectMapper();
		ArrayList<HashMap<String, Object>> paramList = new ArrayList<HashMap<String,Object>>(); 
		String jsonData = (map.get("saleCycleWinPlanData")).toString();		 
		paramList = mapper.readValue(jsonData, new TypeReference<ArrayList<HashMap<String, String>>>() {});        
		
		for(Map<String, Object> paramMap : paramList){

			paramMap.put("hiddenModalPK",map.get("hiddenModalPK"));
			paramMap.put("hiddenModalCreatorId",map.get("creator_id"));
			
			if(!checklist_id.equals((String) paramMap.get("CHECKLIST_ID"))){
				checklist_id = (String) paramMap.get("CHECKLIST_ID");
				cnt = clientSalesActiveDAO.updateSalesCheckListOwner(paramMap);
			}
			
			if(paramMap.get("WINPLAN_ID") != null && !"".equals(paramMap.get("WINPLAN_ID"))){
				cnt = clientSalesActiveDAO.updateSalesCycleWinPlan(paramMap);
			}else{
				cnt = clientSalesActiveDAO.insertSalesCycleWinPlan(paramMap);
			}
		}
		return cnt;
	}
	
	
	
	public List<Map<String, Object>> gridSalesCheckList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.gridSalesCheckList(map);
	}
	
	
	public List<Map<String, Object>> gridOpportunityCheckList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.gridOpportunityCheckList(map);
	}

	
	public int deleteSalesCycleActionPlan(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.deleteSalesCycleActionPlan(map);
	}

	
	public int deleteSalesCycleWinPlan(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.deleteSalesCycleWinPlan(map);
	}

	
	public List<Map<String, Object>> gridSalesCycleWinPlan(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.gridSalesCycleWinPlan(map);
	}

	
	public int completeSaleCycle(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.completeSaleCycle(map);
	}

	
	public int updateSaleCycleClose(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.updateSaleCycleClose(map);
	}
	
	
	public int updateSalesCheckList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		int cnt = 0;
		ObjectMapper mapper = new ObjectMapper();
		ArrayList<HashMap<String, Object>> paramList = new ArrayList<HashMap<String,Object>>(); 
		String jsonData = (map.get("salesCheckListData")).toString();		 
		paramList = mapper.readValue(jsonData, new TypeReference<ArrayList<HashMap<String, String>>>() {});        
		
		for(Map<String, Object> paramMap : paramList){
			paramMap.put("hiddenModalPK", map.get("hiddenModalPK"));
			cnt = clientSalesActiveDAO.updateSalesCheckList(paramMap);
		}
		return cnt;
	}
	
	
	public int updateSalesCycleStep(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.updateSalesCycleStep(map);
	}

	/**
	 * (모바일) 고객컨택 대시보드 오른쪽 기간별 추이 selectbox option(팀장 권한)
	 */
	public List<Map<String, Object>> lineGraphSelectTEAMOption(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.lineGraphSelectTEAMOption(map); 
	}
	
	/**
	 * @explain : 모바일 고객영업활동 -> 영업기회 -> 팀이름 셀렉트박스 옵션
	 */
	public  List<HashMap<String, Object>> selectTeamNameList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.selectTeamNameList(map);		
	}
	
	/**
	 * 모바일 고객컨택 대시보드 오른쪽 기간별 추이 selectbox option
	 */
	public List<Map<String, Object>> lineGraphSelectOption(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.lineGraphSelectOption(map); 
	}
	
	/**
	 * @explain : 모바일 고객영업활동 -> 영업기회 -> 영업기회 현황 (전체등록, 진행중)
	 */
	public  Map<String, Object> selectOpportunityCountM(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSalesActiveDAO.selectOpportunityCountM(map);
	}
	
	/**
	 * @explain : 모바일 고객영업활동 -> 고객영업활동 -> 금주 컨택수
	 */
	public int selectWeekContactCnt(Map<String, Object> map) throws Exception {
		return clientSalesActiveDAO.selectWeekContactCnt(map);
	}
	
	/**
	 * @explain : 모바일 고객영업활동 -> 고객컨택 -> 컨택방법별 현황
	 */
	public  List<HashMap<String, Object>> clientContactMethod(Map<String, Object> map) throws Exception {
		return clientSalesActiveDAO.clientContactMethod(map);
	}
	
	/**
	 * @explain : 모바일 고객영업활동 -> 고객컨택-> 연관이슈 ㆍ연관잠재영업기회 현황
	 */
	public  List<HashMap<String, Object>> issueOppStatusCnt(Map<String, Object> map) throws Exception {
		return clientSalesActiveDAO.issueOppStatusCnt(map);
	}
	
	/**
	 * @explain : 모바일 고객영업활동 -> 고객컨택내용 -> 컨택현황_전체컨택수
	 */
	public  Map<String, Object> clientContactIndividualMethod(Map<String, Object> map) throws Exception {
		return clientSalesActiveDAO.clientContactIndividualMethod(map);
	}
	
	/**
	 * @explain : 모바일 고객영업활동 -> 고객컨택내용 -> 컨택현황_전체컨택수
	 */
	public  Map<String, Object> issueOppStatusIndividualCnt(Map<String, Object> map) throws Exception {
		return clientSalesActiveDAO.issueOppStatusIndividualCnt(map);
	}
	
	/**
	 * @explain : 모바일 대시보드 BarChart
	 */
	public Map<String, Object> quarterContactBarchart(Map<String, Object> map) throws Exception {
		return clientSalesActiveDAO.quarterContactBarchart(map); 
	}
	
	/**
	 * @explain : 모바일 대시보드 PieChart
	 */
	public Map<String, Object> quarterPieChart(Map<String, Object> map) throws Exception {
		return clientSalesActiveDAO.quarterPieChart(map);
	}
	
	/**
	 * @explain : 모바일 대시보드 c3차트 데이터
	 */
	public List<Map<String, Object>> ContactStatusData(Map<String, Object> map) throws Exception {
		return clientSalesActiveDAO.ContactStatusData(map);
	}
	
	/**
	 * @explain : 모바일 고객컨택 대시보드 오른쪽 기간별 추이 그래프 데이터
	 */
	public List<Map<String, Object>> ContactTransitionData(Map<String, Object> map) throws Exception {
		return clientSalesActiveDAO.ContactTransitionData(map); 
	}
	
	/**
	 * @explain : 모바일 고객영업활동 -> 잠재영업기회 -> 잠재영업기회 현황(전체잠재기회, 진행중기회)
	 */
	public  Map<String, Object> ConversionRateCount(Map<String, Object> map) throws Exception {
		return clientSalesActiveDAO.ConversionRateCount(map);
	}
	
	/**
	 * @explain : 모바일 고객영업활동 -> 잠재영업기회 -> 영업기회전환
	 */
	public  Map<String, Object> ConversionRate(Map<String, Object> map) throws Exception {
		return clientSalesActiveDAO.ConversionRate(map);
	}
	
	/**
	 * @explain : 모바일 고객영업활동 -> 잠재영업기회 -> 전환계획 status
	 */
	public  List<HashMap<String, Object>> changePlanStatus(Map<String, Object> map) throws Exception {
		return clientSalesActiveDAO.changePlanStatus(map);
	}
	
	/**
	 * @explain : 모바일 고객영업활동 -> 잠재영업기회 -> 전환계획 status(개인)
	 */
	public  Map<String, Object> changePlanStatusMember(Map<String, Object> map) throws Exception {
		return clientSalesActiveDAO.changePlanStatusMember(map);
	}
	
}
