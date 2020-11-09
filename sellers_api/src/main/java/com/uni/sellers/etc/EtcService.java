package com.uni.sellers.etc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.uni.sellers.common.CommonDAO;
import com.uni.sellers.common.CommonMailService;
import com.uni.sellers.util.CommonDateUtils;
import com.uni.sellers.util.CommonFileUtils;
import com.uni.sellers.util.CommonUtils;


@Service("etcService")
public class EtcService{
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="etcDAO")
	private EtcDAO etcDAO;
	
	@Resource(name="commonMailService")
	private CommonMailService commonMailService;
	
	@Resource(name="commonDAO")
	private CommonDAO commonDAO;
	
	@Resource(name="commonFileUtils")
	private CommonFileUtils commonFileUtils;
	
	/**
	 * 고도뤼 ~
	 * @param map
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public int insertClientGodory(Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		
		if(map.get("selectModalIssueCategory").equals("1")){
			map.put("hiddenModalSolveOwnerId", "0007");
		}else if(map.get("selectModalIssueCategory").equals("2")){
			map.put("hiddenModalSolveOwnerId", "0007");
		}else if(map.get("selectModalIssueCategory").equals("3")){
			map.put("hiddenModalSolveOwnerId", "0007");
		}
		
		if(null == map.get("textModalIssueDate") || "".equals("textModalIssueDate"))
		{
			map.put("textModalIssueDate", CommonDateUtils.getToday().toString());
		}
		
		
		int cnt = etcDAO.insertClientGodory(map);
		String fileTableName = "CLIENT_GODORY_FILE_STORE";
		String fileColumnName = "ISSUE_ID";
		
		if(Boolean.valueOf((String)map.get("shareFlag"))){
			//고객이슈 공유
			//if(!map.get("hiddenModalMemberList").toString().isEmpty()){
				String[] arrayList;
				ArrayList<Object> toAddr = new ArrayList<>();
				ArrayList<Object> toMember = new ArrayList<>();

				String memberInfo = (String) map.get("hiddenModalMemberList");
				arrayList = memberInfo.split(",");

				String shareMemberIdNum = "";
				String sharedMemberEmail = "";
				
				if(null != map.get("shareFlagDetail"))
				{
					for(int i=0; i<arrayList.length; i++){
						String[] individualInfo;
						memberInfo = arrayList[i];
						individualInfo = memberInfo.split("/");
						shareMemberIdNum 	= individualInfo[0];	//공유 받는자 ID
						sharedMemberEmail 	= individualInfo[1];	//공유 받는자 이메일
						toAddr.add(sharedMemberEmail);
						toMember.add(shareMemberIdNum);
					}
					
					commonMailService.shareClientGodorySendMailDetail(map,toAddr);
				}
				else 
				{
					//경농(고도리) 제기자(홍길동0489)-> 담당자(황팀장0007)
					shareMemberIdNum = "0007";
					sharedMemberEmail = "jangsh@unipoint.co.kr";
					toAddr.add(sharedMemberEmail);
					toMember.add(shareMemberIdNum);
					
					//메일 보내기
					commonMailService.shareClientGodorySendMail(map,toAddr);
				}
				
				//메일 로그
				for(Object toMemberId : toMember){
					commonDAO.insertEmailShareLog("client_issue_log", (int)map.get("filePK"), toMemberId.toString(), map.get("hiddenModalCreatorId").toString());
				}
			//}
			
			/*
			//알림 공유(MEMBER_ID_NUM,NOTICE_DETAIL,NOTICE_CATEGORY,NOTICE_REDIRECT_URL,EVENT_ID,NOTICE_CODE)
			Map<String, Object> noticeMap = new HashMap<String,Object>();
//			noticeMap.put("MEMBER_ID_NUM", (String)map.get("hiddenModalSolveOwnerId")); //해결책임자
			noticeMap.put("MEMBER_ID_NUM", "admin"); //영업대표
			noticeMap.put("NOTICE_DETAIL", ""+((Map<String,Object>)RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION)).get("HAN_NAME")+"님이 '"+(String)map.get("textModalSubject")+"' 제안하였습니다.");
			noticeMap.put("NOTICE_CATEGORY", "고도리");
			noticeMap.put("NOTICE_REDIRECT_URL", "/clientSatisfaction/viewClientIssueList.do?issue_id="+map.get("filePK"));
			noticeMap.put("EVENT_ID", null);
			noticeMap.put("NOTICE_CODE", null);

			commonDAO.insertNotice(noticeMap);
			*/
		}

		//map, request, 파일테이블명, Foreign Key
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request, fileTableName,fileColumnName);
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}
		return cnt;
	}
	
	public int updateClientGodory(Map<String, Object> map, HttpServletRequest request) throws Exception {
		String fileTableName = "";
		String fileColumnName = "";
		
		if("".equals(map.get("textModalDueDate1"))){
			map.put("textModalDueDate1", null);
		}
		
		int cnt = etcDAO.updateClientGodory(map);
		fileTableName = "CLIENT_GODORY_FILE_STORE";
		fileColumnName = "ISSUE_ID";


		ArrayList<HashMap<String, Object>> actionPlanList = CommonUtils.jsonList((map.get("issueSolvePlanGrid")).toString());
		//이슈 계획
		for(Map<String,Object> getMap : actionPlanList){
			getMap.put("pkNo",map.get("hiddenModalPK1"));
			getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
			
			
			if(null == getMap.get("SOLVE_OWNER") || getMap.get("SOLVE_OWNER").equals(""))
			{
				getMap.put("SOLVE_OWNER_ID", "");
			}
			
			if(getMap.get("ACTION_ID") != null && !"".equals(getMap.get("ACTION_ID"))){
				cnt = etcDAO.updateClientGodorySolvePlan(getMap);
			}else{
				cnt = etcDAO.insertClientGodorySolvePlan(getMap);
			}
			
		}
		
		if(Boolean.valueOf((String)map.get("shareFlag"))){
			//고객이슈 공유
			if(!map.get("hiddenModalMemberList").toString().isEmpty()){
				String[] arrayList;
				ArrayList<Object> toAddr = new ArrayList<>();
				ArrayList<Object> toMember = new ArrayList<>();

				String memberInfo = (String) map.get("hiddenModalMemberList");
				arrayList = memberInfo.split(",");

				
				String shareMemberIdNum = "";
				String sharedMemberEmail = "";
				
				if(null != map.get("shareFlagDetail"))
				{
					for(int i=0; i<arrayList.length; i++){
						String[] individualInfo;
						memberInfo = arrayList[i];
						individualInfo = memberInfo.split("/");
						shareMemberIdNum 	= individualInfo[0];	//공유 받는자 ID
						sharedMemberEmail 	= individualInfo[1];	//공유 받는자 이메일
						toAddr.add(sharedMemberEmail);
						toMember.add(shareMemberIdNum);
					}
					
					commonMailService.shareClientGodorySendMailDetail(map,toAddr);
				}
				else 
				{
					//경농(고도리) 제기자(홍길동0489)-> 담당자(황팀장0007)
					shareMemberIdNum = "0007";
					sharedMemberEmail = "jangsh@unipoint.co.kr";
					toAddr.add(sharedMemberEmail);
					toMember.add(shareMemberIdNum);
					
					//메일 보내기
					commonMailService.shareClientGodorySendMail(map,toAddr);
				}
				/*
				//메일 로그
				for(Object toMemberId : toMember){
					commonDAO.insertEmailShareLog("client_issue_log", (int)map.get("filePK"), toMemberId.toString(), map.get("hiddenModalCreatorId").toString());
				}
				*/
			}
			
			/*
			//알림 공유(MEMBER_ID_NUM,NOTICE_DETAIL,NOTICE_CATEGORY,NOTICE_REDIRECT_URL,EVENT_ID,NOTICE_CODE)
			Map<String, Object> noticeMap = new HashMap<String,Object>();
//			noticeMap.put("MEMBER_ID_NUM", (String)map.get("hiddenModalSolveOwnerId")); //해결책임자
			noticeMap.put("MEMBER_ID_NUM", "admin"); //영업대표
			noticeMap.put("NOTICE_DETAIL", ""+((Map<String,Object>)RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION)).get("HAN_NAME")+"님이 '"+(String)map.get("textModalSubject")+"' 제안하였습니다.");
			noticeMap.put("NOTICE_CATEGORY", "고도리");
			noticeMap.put("NOTICE_REDIRECT_URL", "/clientSatisfaction/viewClientIssueList.do?issue_id="+map.get("filePK"));
			noticeMap.put("EVENT_ID", null);
			noticeMap.put("NOTICE_CODE", null);

			commonDAO.insertNotice(noticeMap);
			*/
		}
		/*

		if(Boolean.valueOf((String)map.get("shareFlag"))){
			map.put("filePK", Integer.parseInt((String) map.get("hiddenModalPK")));

			//이슈 공유
			shareIssue(map);

			//알림
			alramShare(map);
		}
		*/
		
		
		map.put("filePK", map.get("hiddenModalPK1"));
		map.put("filePKArray", map.get("hiddenModalPK1"));
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request, fileTableName, fileColumnName);
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}
		return cnt;
	}
	
	public List<Map<String, Object>> gridCeoOnHand(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		List<Map<String, Object>> list = etcDAO.gridCeoOnHand(map);
		
		String compareStatus ="";
		for(int i=0; i<list.size(); i++)
		{
			compareStatus = "G";
			
			if(null != list.get(i).get("STATUS_PREV") && list.get(i).get("STATUS_PREV").toString().equals("G"))
			{
				if(null != list.get(i).get("STATUS_ING") && list.get(i).get("STATUS_ING").toString().equals("G"))
				{
					if(null != list.get(i).get("STATUS_NEXT") && !list.get(i).get("STATUS_NEXT").toString().equals("G"))
					{
						compareStatus = list.get(i).get("STATUS_NEXT").toString();
					}
				}
				else if(null != list.get(i).get("STATUS_ING") && list.get(i).get("STATUS_ING").toString().equals("Y"))
				{
					
					if(null != list.get(i).get("STATUS_NEXT") && list.get(i).get("STATUS_NEXT").toString().equals("R"))
					{
						compareStatus = "R";
					}
					else
					{
						compareStatus = "Y";
					}
				}
				else if(null != list.get(i).get("STATUS_ING") && list.get(i).get("STATUS_ING").toString().equals("R")) 
				{
					compareStatus = "R";
				}
				else
				{
					compareStatus = "G";
				}
			}
			else if(null != list.get(i).get("STATUS_PREV") && list.get(i).get("STATUS_PREV").toString().equals("Y"))
			{
				if(null != list.get(i).get("STATUS_ING") && list.get(i).get("STATUS_ING").toString().equals("G"))
				{
					if(null != list.get(i).get("STATUS_NEXT") && list.get(i).get("STATUS_NEXT").toString().equals("R"))
					{
						compareStatus = "R";
					}
					else
					{
						compareStatus = "Y";
					}
				}
				else if(null != list.get(i).get("STATUS_ING") && list.get(i).get("STATUS_ING").toString().equals("R"))
				{
					compareStatus = "R";
				}
				else
				{
					compareStatus = "Y";
				}
			}
			else
			{//STATUS_PREV !=G, !=Y
				compareStatus = "R";

				if(null == list.get(i).get("STATUS_PREV") || "".equals(list.get(i).get("STATUS_PREV")))
				{
					if(null == list.get(i).get("STATUS_ING") || "".equals(list.get(i).get("STATUS_ING")))
					{
						if(null == list.get(i).get("STATUS_NEXT") || "".equals(list.get(i).get("STATUS_NEXT")))
						{
							compareStatus = "-";
						}
						else
						{
							compareStatus = list.get(i).get("STATUS_NEXT").toString();
						}
					}
					else
					{
						compareStatus = list.get(i).get("STATUS_ING").toString();
					}
				}
				else
				{
					compareStatus = "R";
				}
			}
			
			list.get(i).put("statusColor", compareStatus);
		}
		return list;
	}
	
	public int insertCeoOnHand(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = etcDAO.insertCeoOnHand(map);
		
		//마일스톤
		ArrayList<HashMap<String, Object>> mileStoneList = CommonUtils.jsonList((map.get("mileStoneData")).toString());    
		for(Map<String,Object> getMap : mileStoneList){
			getMap.put("pkNo",map.get("filePK"));
			getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
			if(getMap.get("MILESTONE_ID") != null && !"".equals(getMap.get("MILESTONE_ID"))){
				cnt = etcDAO.updateCeoOnHandMilestone(getMap);
			}else{
				cnt = etcDAO.insertCeoOnHandMilestone(getMap);
			}
		}
		
		return cnt;
	}
	
	public int updateCeoOnHand(Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		int cnt = etcDAO.updateCeoOnHand(map);
		
		//마일스톤
		ArrayList<HashMap<String, Object>> mileStoneList = CommonUtils.jsonList((map.get("mileStoneData")).toString());    
		for(Map<String,Object> getMap : mileStoneList){
			getMap.put("hiddenModalPK",map.get("hiddenModalPK"));
			getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));

			if(getMap.get("MILESTONE_ID") != null && !"".equals(getMap.get("MILESTONE_ID"))){
				cnt = etcDAO.updateCeoOnHandMilestone(getMap);
			}else{
				cnt = etcDAO.insertCeoOnHandMilestone(getMap);
			}
		}
		
		return cnt;
	}
	
}
