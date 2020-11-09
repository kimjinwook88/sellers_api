package com.uni.sellers.clientsatisfaction;

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
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.uni.sellers.clientsalesactive.ClientSalesActiveDAO;
import com.uni.sellers.common.CommonDAO;
import com.uni.sellers.common.CommonMailService;
import com.uni.sellers.common.CommonService;
import com.uni.sellers.util.CommonFileUtils;
import com.uni.sellers.util.CommonUtils;

@Service("clientSatisfactionService")
public class ClientSatisfactionService{
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name="commonFileUtils")
	private CommonFileUtils commonFileUtils;

	@Resource(name="clientSatisfactionDAO")
	private ClientSatisfactionDAO clientSatisfactionDAO;

	@Resource(name="commonDAO")
	private CommonDAO commonDAO;

	@Resource(name="commonService")
	private CommonService commonService;

	@Resource(name="commonMailService")
	private CommonMailService commonMailService;
	
	@Resource(name="clientSalesActiveDAO")
	private ClientSalesActiveDAO clientSalesActiveDAO;
	
	protected static SimpleDateFormat mFmtDate = new SimpleDateFormat( "yyyy-MM-dd", java.util.Locale.ENGLISH ) ;


	//셀러스 standard 작업//////////////////////////////////

	//고객이슈리스트
	public Map<String, Object> selectClientIssue(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSatisfactionDAO.selectClientIssue(map);
	}
	
	/**
	 * 모바일 고객만족도 -> 고객이슈 -> 접수 및 처리현황 권한별 접근 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectClientIssueStatus(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		List<Map<String, Object>> list = null;
		
		// 본부권한 접근
		if(map.get("global_role_code").toString().contains("ROLE_DIVISION")){
			map.put("rank", "Y");
			list = (List<Map<String, Object>>) clientSatisfactionDAO.selectClientIssueStatus(map);
			map.put("rank", "N");
			map.put("ranksub", "Y");
			list.addAll((List<Map<String, Object>>) clientSatisfactionDAO.selectClientIssueStatus(map));
		}else{
			list = (List<Map<String, Object>>) clientSatisfactionDAO.selectClientIssueStatus(map);
		}
		
		return list;
	}
	
	/**
	 * @explain : 모바일 고객만족도 -> 고객이슈 -> 이슈종류 권한별 접근
	 */
	public List<Map<String, Object>> selectClientIssueTypeStatus(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		List<Map<String, Object>> list = null;
		
		// 본부권한 접근
		if(map.get("global_role_code").toString().contains("ROLE_DIVISION")){
			map.put("rank", "Y");
			list = (List<Map<String, Object>>) clientSatisfactionDAO.selectClientIssueTypeStatus(map);
			map.put("rank", "N");
			map.put("ranksub", "Y");
			list.addAll((List<Map<String, Object>>) clientSatisfactionDAO.selectClientIssueTypeStatus(map));
		}else{
			list = (List<Map<String, Object>>) clientSatisfactionDAO.selectClientIssueTypeStatus(map);
		}
		
		return list;
	}
	
	/**
	 * @explain : 모바일 고객만족도 -> 만족도 -> 팀이름 셀렉트박스 옵션
	 */
	public  List<HashMap<String, Object>> selectTeamNameList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSatisfactionDAO.selectTeamNameList(map);
	}

	public List<Map<String, Object>> selectClientIssueList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSatisfactionDAO.selectClientIssueList(map);
	}

	public Map<String, Object> insertClientIssue(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = clientSatisfactionDAO.insertClientIssue(map);
		String fileTableName = "CLIENT_ISSUE_FILE_STORE";
		String fileColumnName = "ISSUE_ID";
		
		//고객명 입력
		String[] clientArray = ((String) map.get("hiddenModalCustomerId")).split(",");
		map.put("clientArray", clientArray);
		map.put("clientListCategory", "2");
		cnt = clientSalesActiveDAO.insertClientList(map);
				
		ArrayList<HashMap<String, Object>> actionPlanList = CommonUtils.jsonList((map.get("issueSolvePlan")).toString());    

		for(Map<String,Object> getMap : actionPlanList){
			getMap.put("pkNo",map.get("filePK"));
			getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
			cnt = clientSatisfactionDAO.insertClientIssueSolvePlan(getMap);
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
				commonMailService.shareClientIssueSendMail(map,toAddr);
				//메일 로그
				for(Object toMemberId : toMember){
					commonDAO.insertEmailShareLog("client_issue_log", (int)map.get("filePK"), toMemberId.toString(), map.get("hiddenModalCreatorId").toString());
				}
			}

			//알림 공유(MEMBER_ID_NUM,NOTICE_DETAIL,NOTICE_CATEGORY,NOTICE_REDIRECT_URL,EVENT_ID,NOTICE_CODE)
			Map<String, Object> noticeMap = new HashMap<String,Object>();
//			noticeMap.put("MEMBER_ID_NUM", (String)map.get("hiddenModalSolveOwnerId")); //해결책임자
			noticeMap.put("MEMBER_ID_NUM", (String)map.get("hiddenModalSalesId")); //영업대표
			noticeMap.put("NOTICE_DETAIL", ""+((Map<String,Object>)RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION)).get("HAN_NAME")+"님이 '"+(String)map.get("textModalSubject")+"' 공유하였습니다.");
			noticeMap.put("NOTICE_CATEGORY", "고객이슈");
			noticeMap.put("NOTICE_REDIRECT_URL", "/clientSatisfaction/viewClientIssueList.do?issue_id="+map.get("filePK"));
			noticeMap.put("EVENT_ID", null);
			noticeMap.put("NOTICE_CODE", null);

			commonDAO.insertNotice(noticeMap);
		}

		if(map.get("fileData") != null && !"".equals(map.get("fileData"))){
			List<Map<String,Object>> list = commonFileUtils.insertFile(map, request, fileTableName,fileColumnName);
			for(int i=0, size=list.size(); i < size; i++){
				commonDAO.insertFile(list.get(i));
				cnt ++;
			}
		}
		map.put("cnt", cnt);
		
		return map;
	}

	public Map<String, Object> selectClientIssueDetail(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSatisfactionDAO.selectClientIssueDetail(map);
	}


	//이슈 update
	public int updateClientIssue(Map<String, Object> map, HttpServletRequest request) throws Exception {
		String fileTableName = "";
		String fileColumnName = "";
		
		int cnt = clientSatisfactionDAO.updateClientIssue(map);
		fileTableName = "CLIENT_ISSUE_FILE_STORE";
		fileColumnName = "ISSUE_ID";

		//고객명 입력
		String[] clientArray = ((String) map.get("hiddenModalCustomerId")).split(",");
		map.put("clientArray", clientArray);
		map.put("clientListCategory", "2");
		cnt = clientSalesActiveDAO.insertClientList(map);
				
		ArrayList<HashMap<String, Object>> actionPlanList = CommonUtils.jsonList((map.get("issueSolvePlan")).toString());

		//이슈 계획
		for(Map<String,Object> getMap : actionPlanList){
			getMap.put("pkNo",map.get("hiddenModalPK"));
			getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
			
			
			if(null == getMap.get("SOLVE_OWNER") || getMap.get("SOLVE_OWNER").equals(""))
			{
				getMap.put("SOLVE_OWNER_ID", "");
			}
			
			if(getMap.get("ACTION_ID") != null && !"".equals(getMap.get("ACTION_ID"))){
				cnt = clientSatisfactionDAO.updateClientIssueSolvePlan(getMap);
			}else{
				cnt = clientSatisfactionDAO.insertClientIssueSolvePlan(getMap);
			}
		}

		if(Boolean.valueOf((String)map.get("shareFlag"))){
			map.put("filePK", Integer.parseInt((String) map.get("hiddenModalPK")));

			//이슈 공유
			shareIssue(map);

			//알림
			alramShare(map);
		}

		map.put("filePK", map.get("hiddenModalPK"));
		map.put("filePKArray", map.get("hiddenModalPK"));
		
		if(map.get("fileData") != null && !"".equals(map.get("fileData"))){
			List<Map<String,Object>> list = commonFileUtils.insertFile(map, request, fileTableName, fileColumnName);
			for(int i=0, size=list.size(); i < size; i++){
				commonDAO.insertFile(list.get(i));
				cnt ++;
			}
		}
		return cnt;
	}

	//셀러스 standard END ////////////////////////////////












	public List<Map<String, Object>> clientIssueFileList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSatisfactionDAO.clientIssueFileList(map);
	}


	//고객이슈 공유 메일
	public void shareIssue(Map<String, Object> map) throws Exception{

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
			commonMailService.shareClientIssueSendMail(map,toAddr);
			//메일 로그
			for(Object toMemberId : toMember){
				commonDAO.insertEmailShareLog("client_issue_log", (int) map.get("filePK"), toMemberId.toString(), map.get("hiddenModalCreatorId").toString());
			}
		}
	}

	//알림
	public void alramShare(Map<String, Object> map)throws Exception{
		//알림 공유(MEMBER_ID_NUM,NOTICE_DETAIL,NOTICE_CATEGORY,NOTICE_REDIRECT_URL,EVENT_ID,NOTICE_CODE)
		Map<String, Object> noticeMap = new HashMap<String,Object>();
		noticeMap.put("NOTICE_DETAIL", ""+((Map<String,Object>)RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION)).get("HAN_NAME")+"님이 '"+(String)map.get("textModalSubject")+"' 메일로 공유하였습니다.");
		noticeMap.put("NOTICE_CATEGORY", "고객이슈");

		noticeMap.put("NOTICE_REDIRECT_URL", "/clientSatisfaction/clientIssueList.do?issue_id="+map.get("filePK"));
		
		noticeMap.put("EVENT_ID", null);
		noticeMap.put("NOTICE_CODE", null);
//		noticeMap.put("MEMBER_ID_NUM", (String)map.get("hiddenModalSolveOwnerId")); //해결책임자
//		noticeMap.put("MEMBER_ID_NUM", (String)map.get("hiddenModalSalesId")); //영업대표
		
		//메일 공유를 한 사람들에게 미리알림으로 알려준다.
		String[] arr = map.get("hiddenModalMemberList").toString().split(",");
		for(int i=0; i<arr.length; i++)
		{
			String sharedMemberId = arr[i];
			String[] arrIdArray = sharedMemberId.split("/");
			String arrId = arrIdArray[0];
			noticeMap.put("MEMBER_ID_NUM", arrId);
			commonDAO.insertNotice(noticeMap);
		}
	}

	/*
		public int insertClientIssue(Map<String, Object> map, HttpServletRequest request) throws Exception {

			int cnt = clientSatisfactionDAO.insertClientIssue(map);

			ArrayList<HashMap<String, Object>> actionPlanList = CommonUtils.jsonList((map.get("issueSolvePlanGrid")).toString());    

			for(Map<String,Object> getMap : actionPlanList){
				getMap.put("pkNo",map.get("filePK"));
				getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
				cnt = clientSatisfactionDAO.insertClientIssueSolvePlan(getMap);
			}

			shareIssue(map);

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
					commonMailService.shareClientIssueSendMail(map,toAddr);
					//메일 로그
					for(Object toMemberId : toMember){
						commonDAO.insertEmailShareLog("client_issue_log", (int)map.get("filePK"), toMemberId.toString(), map.get("hiddenModalCreatorId").toString());
					}
				}

				//알림 공유(MEMBER_ID_NUM,NOTICE_DETAIL,NOTICE_CATEGORY,NOTICE_REDIRECT_URL,EVENT_ID,NOTICE_CODE)
				Map<String, Object> noticeMap = new HashMap<String,Object>();
				noticeMap.put("MEMBER_ID_NUM", (String)map.get("hiddenModalSolveOwnerId")); //해결책임자
				noticeMap.put("NOTICE_DETAIL", ""+((Map<String,Object>)RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION)).get("HAN_NAME")+"님이 '"+(String)map.get("textModalSubject")+"' 공유하였습니다.");
				noticeMap.put("NOTICE_CATEGORY", "고객이슈");
				noticeMap.put("NOTICE_REDIRECT_URL", "/clientSatisfaction/listClientIssue.do?issue_id="+map.get("filePK"));
				noticeMap.put("EVENT_ID", null);
				noticeMap.put("NOTICE_CODE", null);
				commonDAO.insertNotice(noticeMap);

				noticeMap.put("MEMBER_ID_NUM", (String)map.get("hiddenModalSalesId")); //영업대표
				commonDAO.insertNotice(noticeMap);
			}

			//map, request, 파일테이블명, Foreign Key
			List<Map<String,Object>> list = commonFileUtils.insertFile(map, request, "CLIENT_ISSUE_FILE_STORE","ISSUE_ID");
			for(int i=0, size=list.size(); i < size; i++){
				commonDAO.insertFile(list.get(i));
				cnt ++;
			}
			return cnt;
		}
	 */


	public int deleteClientIssue(Map<String, Object> map, HttpServletRequest request) throws Exception {
		map.put("filePK", map.get("hiddenModalPK"));
		map.put("filePKArray", map.get("hiddenModalPK"));

		List<Map<String, Object>> fileList = clientSatisfactionDAO.clientIssueFileList(map);
		commonFileUtils.deleteFileAll(fileList,request);

		int cnt = clientSatisfactionDAO.deleteClientIssue(map);

		return cnt;
	}


	public int deleteClientIssueActionPlan(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = clientSatisfactionDAO.deleteClientIssueActionPlan(map);

		return cnt;
	}

	//고객만족

	public List<Map<String, Object>> gridClientSatisfaction(Map<String, Object> map) throws Exception {
		return clientSatisfactionDAO.gridClientSatisfaction(map);
	}


	public List<Map<String, Object>> clientSatisfactionSearchDetailGroup(Map<String, Object> map) throws Exception {
		//public Map<String, Object> selectClientSatisfactionList(Map<String, Object> map) throws Exception {
		return clientSatisfactionDAO.clientSatisfactionSearchDetailGroup(map);
		//return clientSatisfactionDAO.selectClientSatisfactionList(map);
	}


	public List<Map<String, Object>> clientSatisfactionFileList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSatisfactionDAO.clientSatisfactionFileList(map);
	}

	//2016-10-10 심윤영 수정 start

	public int insertClientSatisfaction(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = clientSatisfactionDAO.insertClientSatisfaction(map);

		ArrayList<HashMap<String, Object>> actionPlanList = CommonUtils.jsonList((map.get("issueSolvePlanGrid")).toString());    

		for(Map<String,Object> getMap : actionPlanList){
			getMap.put("pkNo",map.get("filePK"));
			getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
			cnt = clientSatisfactionDAO.insertClientSatisfactionSolvePlan(getMap);
		}

		ArrayList<HashMap<String, Object>> satisfactionDetailList = CommonUtils.jsonList((map.get("clientSatisfactionDetail")).toString());

		for(Map<String,Object> getMap : satisfactionDetailList){
			getMap.put("hiddenModalPK", map.get("hiddenModalPK"));
			getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
			cnt = clientSatisfactionDAO.insertClientSatisfactionDetail(getMap);
		}

		if(map.get("textModalModifiedCompanyId") != null && !"".equals(map.get("textModalModifiedCompanyId"))) {
			insertClientSatisfactionDetail(map);
		}

		//map, request, 파일테이블명, Foreign Key
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request, "CLIENT_SAT_FILE_STORE","CSAT_ID");
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}
		return cnt;
	}


	public Map<String, Object> updateClientSatisfaction(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = clientSatisfactionDAO.updateClientSatisfaction(map);

		ArrayList<HashMap<String, Object>> actionPlanList = CommonUtils.jsonList((map.get("issueSolvePlanGrid")).toString());

		for(Map<String,Object> getMap : actionPlanList){
			getMap.put("pkNo",map.get("hiddenModalPK"));
			getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
			
			if(null == getMap.get("SOLVE_OWNER") || getMap.get("SOLVE_OWNER").equals(""))
			{
				getMap.put("SOLVE_OWNER_ID", "");
			}
			
			if(getMap.get("ACTION_ID") != null && !"".equals(getMap.get("ACTION_ID"))){
				cnt = clientSatisfactionDAO.updateClientSatisfactionSolvePlan(getMap);
			}else{
				cnt = clientSatisfactionDAO.insertClientSatisfactionSolvePlan(getMap);
			}
		}

		ArrayList<HashMap<String, Object>> satisfactionDetailList = CommonUtils.jsonList((map.get("clientSatisfactionDetail")).toString());

		for(Map<String,Object> getMap : satisfactionDetailList){
			getMap.put("hiddenModalPK", map.get("hiddenModalPK"));
			getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
			if(getMap.get("CSAT_DETAIL_ID") != null && !"".equals(getMap.get("CSAT_DETAIL_ID"))){
				cnt = clientSatisfactionDAO.updateClientSatisfactionDetail(getMap);
			}else if((getMap.get("COMPANY_ID") != null && !"".equals(getMap.get("COMPANY_ID"))) && (getMap.get("CSAT_SURVEY_DATE") != null && !"".equals(getMap.get("CSAT_SURVEY_DATE")))){
				cnt = clientSatisfactionDAO.insertClientSatisfactionDetail(getMap);
			}
		}

		if(map.get("textModalModifiedCompanyId") != null && !"".equals(map.get("textModalModifiedCompanyId"))) {
			updateClientSatisfactionDetail(map);
			map.put("returnPK", map.get("filePK"));
		}

		map.put("filePK", map.get("hiddenModalPK"));
		map.put("filePKArray", map.get("hiddenModalPK"));
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request,"CLIENT_SAT_FILE_STORE","CSAT_ID");
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}
		map.put("cnt", cnt);

		return map;
	}
	//2016-10-10 심윤영 수정 end


	public int deleteClientSatisfaction(Map<String, Object> map, HttpServletRequest request) throws Exception {
		map.put("filePK", map.get("hiddenModalPK"));
		map.put("filePKArray", map.get("hiddenModalPK"));
		List<Map<String, Object>> fileList = clientSatisfactionDAO.clientContactFileList(map);
		int cnt = clientSatisfactionDAO.deleteClientSatisfaction(map);		
		commonFileUtils.deleteFileAll(fileList,request);

		return cnt;
	}


	public int deleteClientSatisfactionDetailList(Map<String, Object> map) throws Exception {
		return clientSatisfactionDAO.deleteClientSatisfactionDetailList(map);		
	}


	public List<Map<String, Object>> gridClientSatisfactionDetailList(Map<String, Object> map) throws Exception {
		return clientSatisfactionDAO.gridClientSatisfactionDetailList(map);
	}


	public int insertClientSatisfactionDetailList(Map<String, Object> map) throws Exception {
		int cnt = 0;
		ObjectMapper mapper = new ObjectMapper();
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>(); 
		String jsonData = (map.get("detailsData")).toString();		 
		list = mapper.readValue(jsonData, new TypeReference<ArrayList<HashMap<String, String>>>() {});        

		for(Map<String,Object> getMap : list){
			getMap.put("hiddenModalPK",map.get("hiddenModalPK"));
			getMap.put("hiddenModalCreatorId",map.get("creator_id"));
			if(getMap.get("CSAT_DETAIL_ID") != null && !"".equals(getMap.get("CSAT_DETAIL_ID"))){
				cnt = clientSatisfactionDAO.updateClientSatisfactionDetailList(getMap);
			}else{
				cnt = clientSatisfactionDAO.insertClientSatisfactionDetailList(getMap);
			}
		}
		return cnt;
	}

	//2016-10-10 고객만족 심윤영

	public int insertClientSatisfactionDetail(Map<String, Object> map) throws Exception {
		int cnt = clientSatisfactionDAO.insertClientSatisfactionDetail(map);
		return cnt;
	}


	public int updateClientSatisfactionDetail(Map<String, Object> map) throws Exception {
		int cnt = 0;
		if(map.get("hiddenModalModifiedDetailId") != null && !"".equals(map.get("hiddenModalModifiedDetailId"))) {
			cnt = clientSatisfactionDAO.updateClientSatisfactionDetail(map);
		}else{
			map.put("filePK", map.get("hiddenModalPK"));
			cnt = clientSatisfactionDAO.insertClientSatisfactionDetail(map);
		}
		return cnt;
	}


	public List<Map<String, Object>> selectClientSatisfactionMasterList(Map<String, Object> map) throws Exception {
		return clientSatisfactionDAO.selectClientSatisfactionMasterList(map);
	}


	public List<Map<String, Object>> selectClientSatisfactionList(Map<String, Object> map) throws Exception {
		return clientSatisfactionDAO.selectClientSatisfactionList(map);
	}


	public Map<String, Object> selectClientSatisfactionDetail(Map<String, Object> map) throws Exception {
		return clientSatisfactionDAO.selectClientSatisfactionDetail(map);
	}


	//===============================================장기프로젝트 관리 START=============================================

	public Map<String, Object> projectMGMTDetailGroup(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSatisfactionDAO.projectMGMTDetailGroup(map);
	}


	public Map<String, Object> selectProjectMGMTDetail(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSatisfactionDAO.selectProjectMGMTDetail(map);
	}


	public List<Map<String, Object>> selectProjectMGMTList(Map<String, Object> map) throws Exception {
		return clientSatisfactionDAO.selectProjectMGMTList(map);
	}


	public List<Map<String, Object>> projectMGMTFileList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSatisfactionDAO.projectMGMTFileList(map);
	}


	public int insertProjectMGMT(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = clientSatisfactionDAO.insertProjectMGMT(map);
		map.put("hiddenModalPK",map.get("filePK"));
		
		//팀원 insert/update
		String[] teamMemberArray = ((String) map.get("hiddenModalTeamMemberIdList")).split(",");
		map.put("teamMemberArray", teamMemberArray);
		cnt = clientSatisfactionDAO.insertTeamMemberList(map);

		//amount insert
		if(!map.get("selectModalContractAmount").equals("") && map.get("selectModalContractAmount") != null) {
			String ContractDate = (String)map.get("hiddenModalContractDate");
			String ContractPlanAmount = (String)map.get("hiddenModalContractPlanAmount");
			String ContractActualAmount = (String)map.get("hiddenModalContractActualAmount");

			String arrContractDate[] = ContractDate.split(",");
			String arrContractPlanAmount[] = ContractPlanAmount.split(",");
			String arrContractActualAmount[] = ContractActualAmount.split(",");
			for(int i=0; i<arrContractDate.length; i++){
				/*log.debug("amountArrDate="+arrContractDate[i]);
					log.debug("amountArr111="+arrContractPlanAmount[i]);
					log.debug("amountArr222="+arrContractActualAmount[i]);*/
				map.put("filePK",map.get("filePK"));
				map.put("hiddenModalProjectId",map.get("filePK"));
				map.put("ContractDate", arrContractDate[i]+"-01");
				map.put("ContractPlanAmount", arrContractPlanAmount[i]);
				map.put("ContractActualAmount", arrContractActualAmount[i]);
				cnt += clientSatisfactionDAO.insertProjectMGMTContract(map);
			}
		}

		//마일스톤
		insertProjectMGMTMilestons(map,request);

		//이슈
		insertProjectIssue(map);

		//map, request, 파일테이블명, Foreign Key
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request, "PROJECT_MGMT_FILE_STORE","PROJECT_ID");
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}
		
		ArrayList<HashMap<String, Object>> projectIssueList = CommonUtils.jsonList((map.get("projectIssueData")).toString());
		
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
				commonMailService.shareProjectServiceSendMail(map,projectIssueList,toAddr);
				//메일 로그
				for(Object toMemberId : toMember){
					commonDAO.insertEmailShareLog("project_mgmt", (int)map.get("filePK"), toMemberId.toString(), map.get("hiddenModalCreatorId").toString());
				}
			}
		}
		return cnt;
	}


	public int updateProjectMGMT(Map<String, Object> map, HttpServletRequest request)  throws  Exception {
		int cnt = clientSatisfactionDAO.updateProjectMGMT(map);
		map.put("filePK", map.get("hiddenModalPK"));
		map.put("filePKArray", map.get("hiddenModalPK"));
		
		//팀원 insert/update
		String[] teamMemberArray = ((String) map.get("hiddenModalTeamMemberIdList")).split(",");
		map.put("teamMemberArray", teamMemberArray);
		cnt = clientSatisfactionDAO.insertTeamMemberList(map);
		
		cnt += clientSatisfactionDAO.deleteProjectMGMTContractAmount(map);
		if(!map.get("selectModalContractAmount").equals("") && map.get("selectModalContractAmount") != null) {
			String ContractDate = (String)map.get("hiddenModalContractDate");
			String ContractPlanAmount = (String)map.get("hiddenModalContractPlanAmount");
			String ContractActualAmount = (String)map.get("hiddenModalContractActualAmount");

			String arrContractDate[] = ContractDate.split(",");
			String arrContractPlanAmount[] = ContractPlanAmount.split(",");
			String arrContractActualAmount[] = ContractActualAmount.split(",");
			for(int i=0; i<arrContractDate.length; i++){
				log.debug("amountArrDate="+arrContractDate[i]);
				log.debug("amountArr111="+arrContractPlanAmount[i]);
				log.debug("amountArr222="+arrContractActualAmount[i]);
				map.put("ContractDate", arrContractDate[i]+"-01");
				map.put("ContractPlanAmount", arrContractPlanAmount[i]);
				map.put("ContractActualAmount", arrContractActualAmount[i]);
				cnt += clientSatisfactionDAO.insertProjectMGMTContract(map);
			}
		}

		//마일스톤
		updateProjectMGMTMilestons(map);

		//이슈
		insertProjectIssue(map);

		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request,"PROJECT_MGMT_FILE_STORE","PROJECT_ID");
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}
		
		ArrayList<HashMap<String, Object>> projectIssueList = CommonUtils.jsonList((map.get("projectIssueData")).toString());
		
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
				commonMailService.shareProjectServiceSendMail(map,projectIssueList,toAddr);
				//메일 로그
				for(Object toMemberId : toMember){
					commonDAO.insertEmailShareLog("project_mgmt", (int)map.get("filePK"), toMemberId.toString(), map.get("hiddenModalCreatorId").toString());
				}
			}
		}
		return cnt;
	}


	public int deleteProjectMGMT(Map<String, Object> map, HttpServletRequest request) throws Exception {
		map.put("filePK", map.get("hiddenModalPK"));
		map.put("filePKArray", map.get("hiddenModalPK"));

		List<Map<String, Object>> fileList = clientSatisfactionDAO.projectMGMTFileList(map);
		commonFileUtils.deleteFileAll(fileList,request);

		int cnt = clientSatisfactionDAO.deleteProjectMGMT(map);

		return cnt;
	}


	public int updateProjectMGMTMilestons(Map<String, Object> map) throws Exception {
		int cnt = 0;
		String[] milesontesDueDate =  (String[])map.get("milesontesDueDate");
		String[] milesontesEndDate =  (String[])map.get("milesontesEndDate");
		String[] hiddenEndDateCheck =  (String[]) map.get("hiddenEndDateCheck");
		String[] keyMilestoneName = {"분석","설계","구현","테스트","이행"};

		for(int i=0; i<milesontesDueDate.length; i++){
			map.put("milesontesDueDate", milesontesDueDate[i]);
			map.put("milesontesEndDate", milesontesEndDate[i]);
			map.put("hiddenEndDateCheck", hiddenEndDateCheck[i]);
			map.put("keyMilestoneName", keyMilestoneName[i]);
			map.put("keyMilestoneSeq", (i+1));
			clientSatisfactionDAO.updateProjectMGMTMilestons(map);
			cnt++;
		}
		return cnt;
	}



	public int insertProjectMGMTMilestons(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = 0;
		String[] milesontesDueDate =  (String[])map.get("milesontesDueDate");
		String[] milesontesEndDate =  (String[])map.get("milesontesEndDate");
		String[] hiddenEndDateCheck =  (String[]) map.get("hiddenEndDateCheck");
		String[] keyMilestoneName = {"분석","설계","구현","테스트","이행"};

		for(int i=0; i<milesontesDueDate.length; i++){
			map.put("milesontesDueDate", milesontesDueDate[i]);
			map.put("milesontesEndDate", milesontesEndDate[i]);
			map.put("hiddenEndDateCheck", hiddenEndDateCheck[i]);
			map.put("keyMilestoneName", keyMilestoneName[i]);
			map.put("keyMilestoneSeq", (i+1));
			clientSatisfactionDAO.insertProjectMGMTMilestons(map);
			cnt++;
		}
		return cnt;
	}


	public List<Map<String, Object>> selectProjectMGMTMilestons(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSatisfactionDAO.selectProjectMGMTMilestons(map);
	}


	public Map<String, Object> selectProjectMGMTInfo(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSatisfactionDAO.selectProjectMGMTInfo(map);
	}



	public List<Map<String, Object>> gridProjectIssue(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSatisfactionDAO.gridProjectIssue(map);
	}


	public int insertProjectIssue(Map<String, Object> map) throws Exception {
		int cnt 				= 0;
		Date date 				= new Date();
		String todayDate 		= mFmtDate.format( date ) ;	//오늘날짜
		String dueDate 			= "";						//해결목표기한일자
		String issueCloseDate 	= "";						//이슈해결일자

		ObjectMapper mapper = new ObjectMapper();
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>(); 
		String jsonData = (map.get("projectIssueData")).toString();		 
		list = mapper.readValue(jsonData, new TypeReference<ArrayList<HashMap<String, String>>>() {});        

		for(int i=0; i<list.size(); i++){

			list.get(i).put("hiddenModalPK", map.get("hiddenModalPK"));
			list.get(i).put("creator_id", map.get("creator_id"));

			dueDate = (String) list.get(i).get("DUE_DATE");
			issueCloseDate = (String) list.get(i).get("ISSUE_CLOSE_DATE");

			if ( (todayDate.compareTo(dueDate) < 0 || todayDate.compareTo(dueDate) ==0) && issueCloseDate.equals("") )
			{
				list.get(i).put("ISSUE_STATUS", "Y");
				list.get(i).put("ISSUE_CLOSE_DATE", null);
			} 
			else if ( todayDate.compareTo(dueDate) > 0 && issueCloseDate.equals("") )
			{
				list.get(i).put("ISSUE_STATUS", "R");
				list.get(i).put("ISSUE_CLOSE_DATE", null);
			}
			else if ( !issueCloseDate.equals("") && issueCloseDate != null	)
			{
				list.get(i).put("ISSUE_STATUS", "G");
			}


			/*switch ((String) list.get(i).get("CHECKLIST_SEQ")){
			case "1":
				list.get(i).put("CHECKLIST_NAME", "분석");
				list.get(i).put("CHECKLIST_SEQ", "1");
				break;
			case "2":
				list.get(i).put("CHECKLIST_NAME", "설계");
				list.get(i).put("CHECKLIST_SEQ", "2");
				break;
			case "3":
				list.get(i).put("CHECKLIST_NAME", "구현");
				list.get(i).put("CHECKLIST_SEQ", "3");
				break;
			case "4":
				list.get(i).put("CHECKLIST_NAME", "테스트");
				list.get(i).put("CHECKLIST_SEQ", "4");
				break;
			case "5":
				list.get(i).put("CHECKLIST_NAME", "이행");
				list.get(i).put("CHECKLIST_SEQ", "5");
				break;

			}*/

			if(list.get(i).get("ISSUE_ID") != null && !"".equals(list.get(i).get("ISSUE_ID"))){
				clientSatisfactionDAO.updateProjectIssue(list.get(i));
			}else if(list.get(i).get("ISSUE_DETAIL") != null && !"".equals(list.get(i).get("ISSUE_DETAIL").toString())){
				clientSatisfactionDAO.insertProjectIssue(list.get(i));
			}
			cnt ++;
		}
		return cnt;
	}


	public int deleteProjectIssue(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientSatisfactionDAO.deleteProjectIssue(map);
	}
	//===============================================장기프로젝트 관리 END=============================================


	//고객만족 대시보드
	public List<Map<String, Object>> selectClientSatisfactionDashBoard(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> list = clientSatisfactionDAO.selectClientSatisfactionDashBoard(map);

		return list;
	}
	
	/**
	 * @explain : 모바일 고객만족 -> 고객만족 -> 조사 현황 (년도/분기별)
	 */
	public List<Map<String, Object>> selectClientSatisfactionMasterListM(Map<String, Object> map) throws Exception {
		return clientSatisfactionDAO.selectClientSatisfactionMasterListM(map);
	}
}