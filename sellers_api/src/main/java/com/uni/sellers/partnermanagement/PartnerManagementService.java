package com.uni.sellers.partnermanagement;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.uni.sellers.common.CommonDAO;
import com.uni.sellers.util.CommonFileUtils;
import com.uni.sellers.util.CommonUtils;

@Service("partnerManagementService")
public class PartnerManagementService{
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "commonFileUtils")
	private CommonFileUtils commonFileUtils;

	@Resource(name = "partnerManagementDAO")
	private PartnerManagementDAO partnerManagementDAO;

	@Resource(name = "commonDAO")
	private CommonDAO commonDAO;

	protected static SimpleDateFormat mFmtDate = new SimpleDateFormat("yyyy-MM-dd", java.util.Locale.ENGLISH);


	//파트너 영업

	//capacity

	public List<Map<String, Object>> gridCapacity(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.gridCapacity(map);
	}


	public Map<String, Object> partnerSalesGroup(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return partnerManagementDAO.partnerSalesGroup(map);
	}


	public List<Map<String, Object>> selectCapacityPartnerList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return partnerManagementDAO.selectCapacityPartnerList(map);
	}



	public int  deleteCapacityParnter(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.deleteCapacityParnter(map);
	}


	public int  insertCapacityParnter(Map<String, Object> map) throws Exception {
		int cnt = 0;

		if(map.get("arrPartnerList") != null){
			partnerManagementDAO.deleteCapacityParnterAll(map);
			//partner
			String[] arrPartnerList =((String)map.get("arrPartnerList")).split(",");
			for(String partner_id : arrPartnerList){
				map.put("partner_id", partner_id);
				cnt = partnerManagementDAO.insertCapacityParnter(map);
			}
		}
		return cnt;
	}


	public int  insertCapacityAction(Map<String, Object> map) throws Exception {
		int cnt = 0;

		partnerManagementDAO.updateCondition(map);
		int gapCount = partnerManagementDAO.selectCapacityGapCount(map);
		//Gap
		if(gapCount > 0){
			cnt = partnerManagementDAO.updateCapacityAction(map);
		}else{
			cnt = partnerManagementDAO.insertCapacityAction(map);
		}

		return cnt;
	}


	public int  createCapacity(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.createCapacity(map);
	}


	public int  insertCapacity(Map<String, Object> map, HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		int cnt = 0;
		ObjectMapper mapper = new ObjectMapper();
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>(); 
		String jsonData = (map.get("capacityData")).toString();		 
		list = mapper.readValue(jsonData, new TypeReference<ArrayList<HashMap<String, String>>>() {});      

		if(map.get("selectViewList").equals("bp")){
			for(HashMap<String, Object> paramMap : list){
				paramMap.put("selectAccountYear", map.get("selectAccountYear"));
				partnerManagementDAO.insertCapacityBp(paramMap);
				cnt ++;
			}
		}else{
			for(HashMap<String, Object> paramMap : list){
				paramMap.put("selectAccountYear", map.get("selectAccountYear"));
				partnerManagementDAO.insertCapacityIn(paramMap);
				cnt ++;
			}
		}
		//partnerManagementDAO.insertCapacity(map);
		return cnt;
	}





	//recruitment

	public List<Map<String, Object>> gridRecruitment(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return partnerManagementDAO.gridRecruitment(map);
	}


	public List<Map<String, Object>> gridRecruitmentCRB(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.gridRecruitmentCRB(map); 
	}


	public int insertRecruitment(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		int cnt = 0;
		ObjectMapper mapper = new ObjectMapper();
		ArrayList<HashMap<String, Object>> paramList = new ArrayList<HashMap<String,Object>>(); 
		String jsonData = (map.get("recruitmentData")).toString();		 
		paramList = mapper.readValue(jsonData, new TypeReference<ArrayList<HashMap<String, String>>>() {});        

		for(Map<String, Object> paramMap : paramList){
			paramMap.put("selectViewList", map.get("selectViewList"));
			cnt = partnerManagementDAO.insertRecruitment(paramMap);
		}
		return cnt;
	}


	public int insertRecruitmentCRB(Map<String, Object> map, HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		int cnt = 0;
		ObjectMapper mapper = new ObjectMapper();
		ArrayList<HashMap<String, Object>> paramList = new ArrayList<HashMap<String,Object>>(); 
		String jsonData = (map.get("recruitmentCRBData")).toString();		 
		paramList = mapper.readValue(jsonData, new TypeReference<ArrayList<HashMap<String, String>>>() {});        

		int crb_id = partnerManagementDAO.selectCRBid(map);

		for(Map<String, Object> paramMap : paramList){
			paramMap.put("selectViewList", map.get("selectViewList"));
			paramMap.put("selectAccountYear", map.get("selectAccountYear"));
			paramMap.put("selectCRBseq", map.get("selectCRBseq"));
			paramMap.put("crb_id", crb_id);
			cnt = partnerManagementDAO.insertRecruitmentCRB(paramMap);
		}

		map.put("filePK", "0");
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request,"PARTNER_CRB_FILE_STORE","");
		for(int i=0, size=list.size(); i < size; i++){
			list.get(i).put("selectViewList", map.get("selectViewList"));
			list.get(i).put("selectAccountYear", map.get("selectAccountYear"));
			list.get(i).put("selectCRBseq", map.get("selectCRBseq"));
			list.get(i).put("crb_id", crb_id);
			partnerManagementDAO.insertRecruitmentFileCRB(list.get(i));
		}

		return cnt;
	}


	public List<Map<String, Object>> recruitmentCRBFileList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return partnerManagementDAO.recruitmentCRBFileList(map);
	}












	//Enablement

	public List<Map<String, Object>> gridEnablement(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return partnerManagementDAO.gridEnablement(map);
	}


	public List<Map<String, Object>> gridMileStonesEnablement(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return partnerManagementDAO.gridMileStonesEnablement(map);
	}


	public int insertEnablement(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = partnerManagementDAO.insertEnablement(map);
		map.put("hiddenModalPK", map.get("filePK"));
		insertMilestonesEnablement(map);
		//map, request, 파일테이블명, Foreign Key
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request, "PARTNER_ENABLE_FILE_STORE","EDU_PLAN_ID");
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}
		return cnt;
	}


	public int updateEnablement(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = partnerManagementDAO.updateEnablement(map);
		map.put("filePK", map.get("hiddenModalPK"));
		map.put("filePKArray", map.get("hiddenModalPK"));
		insertMilestonesEnablement(map);
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request,"PARTNER_ENABLE_FILE_STORE","EDU_PLAN_ID");
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}
		return cnt;
	}


	public Map<String, Object> selectEnablementDetail(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return partnerManagementDAO.selectEnablementDetail(map);
	}


	public List<Map<String, Object>> enablementFileList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return partnerManagementDAO.enablementFileList(map);
	}


	public int insertMilestonesEnablement(Map<String, Object> map) throws Exception {
		int cnt = 0;
		ObjectMapper mapper = new ObjectMapper();
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>(); 
		String jsonData = (map.get("mileStonesData")).toString();		 
		list = mapper.readValue(jsonData, new TypeReference<ArrayList<HashMap<String, String>>>() {});        

		for(Map<String,Object> getMap : list){
			getMap.put("hiddenModalPK",map.get("hiddenModalPK"));
			getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
			if(getMap.get("EDU_LOG_ID") != null && !"".equals(getMap.get("EDU_LOG_ID"))){
				cnt = partnerManagementDAO.updateMilestonesEnablement(getMap);
			}else{
				cnt = partnerManagementDAO.insertMilestonesEnablement(getMap);
			}
		}
		return cnt;
	}


	public Map<String, Object> enablementSearchDetailGroup(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.enablementSearchDetailGroup(map);
	}












	//SalesLInkage

	public int createSalesLinkage(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.createSalesLinkage(map);
	}


	public List<Map<String, Object>> gridSalesLinkage(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return partnerManagementDAO.gridSalesLinkage(map);
	}


	public Map<String, Object> salesLinkageDetailGroup(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return partnerManagementDAO.salesLinkageDetailGroup(map);
	}


	public int updateSalesLinkage(Map<String, Object> map, HttpServletRequest request) throws Exception {
		return partnerManagementDAO.updateSalesLinkage(map);
	}


	public int insertSalesLinkageHistory(Map<String, Object> map, HttpServletRequest request) throws Exception {

		int cnt = 0;
		//cnt = partnerManagementDAO.updateSalesLinkage(map);
		map.put("filePK",map.get("hiddenModalPK"));
		if(Boolean.valueOf((String)map.get("cadenceFlag"))){//Cadence 신규
			cnt = partnerManagementDAO.insertSalesLinkageHistory(map);
			List<Map<String,Object>> list = commonFileUtils.insertFile(map, request,"PARTNER_SALES_LINAKGE_FILE_STORE","LINKAGE_ID");
			for(int i=0, size=list.size(); i < size; i++){
				list.get(i).put("originalFileName", list.get(i).get("originalFileName"));
				list.get(i).put("cadence_id", map.get("cadence_id"));
				list.get(i).put("linkage_id", map.get("hiddenModalPK"));
				cnt = partnerManagementDAO.insertSalesLinkageHistoryFile(list.get(i));
			}
		}else{ //Cadence 수정		
			cnt = partnerManagementDAO.updateSalesLinkageHistory(map);
			List<Map<String,Object>> list = commonFileUtils.insertFile(map, request,"PARTNER_SALES_LINAKGE_FILE_STORE","LINKAGE_ID");
			for(int i=0, size=list.size(); i < size; i++){
				list.get(i).put("originalFileName", list.get(i).get("originalFileName"));
				list.get(i).put("cadence_id", map.get("cadence_id"));
				list.get(i).put("linkage_id", map.get("hiddenModalPK"));
				cnt = partnerManagementDAO.insertSalesLinkageHistoryFile(list.get(i));
			}
		}

		ObjectMapper mapper = new ObjectMapper();
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>(); 
		String jsonData = (map.get("cadenceActionPlanGrid")).toString();		 
		list = mapper.readValue(jsonData, new TypeReference<ArrayList<HashMap<String, String>>>() {});    

		for(Map<String,Object> getMap : list){
			getMap.put("returnPK",map.get("cadence_id"));
			getMap.put("hiddenModalCreatorId",map.get("hiddenModalCreatorId"));
			if(getMap.get("ACTION_ID") != null && !"".equals(getMap.get("ACTION_ID"))){
				cnt = partnerManagementDAO.updateCadenceActionPlan(getMap);
			}else{
				cnt = partnerManagementDAO.insertCadenceActionPlan(getMap);
			}
		}

		return cnt; 
	}


	public List<Map<String, Object>> salesLinkageFileList(Map<String, Object> map) throws Exception {
		map.put("filePK", map.get("hiddenModalPK"));
		map.put("filePKArray", map.get("hiddenModalPK"));
		return partnerManagementDAO.salesLinkageFileList(map);
	}


	public List<Map<String, Object>> selectCadenceDateList(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.selectCadenceDateList(map);
	}


	public Map<String, Object> selectCadenceDetail(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.selectCadenceDetail(map);
	}


	//Fullfillment - standard ver.
	public List<Map<String, Object>> selectFullfillment(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return partnerManagementDAO.selectFullfillment(map);
	}
	
	//Fullfillment - 더존 erp 연동 신용평가현황 테이블
	public List<Map<String, Object>> selectFullfillmentERP(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return partnerManagementDAO.selectFullfillmentERP(map);
	}


	//////////////////////////////////////////// 파트너개인정보 관리
	//////////////////////////////////////////// start///////////////////////////////////////////////////////

	public Map<String, Object> partnerIndividualInfoSearchDetailGroup(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.partnerIndividualInfoSearchDetailGroup(map);
	}


	public List<Map<String, Object>> gridPartnerIndividualInfo(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.gridPartnerIndividualInfo(map);
	}


	public List<Map<String, Object>> partnerIndividualPhotoList(Map<String, Object> map) throws Exception {
		List<Map<String,Object>> list = partnerManagementDAO.partnerIndividualPhotoList(map);
		List<Map<String,Object>> photoList = new ArrayList<Map<String,Object>>();
		Map<String,Object> photoMap = new HashMap<String,Object>();
		photoMap.put("FILE_PATH", "");
		
		if(list != null){
			if(list.size() == 1){
				if(list.get(0).get("FILE_PATH").toString().startsWith("nameCard/")){
					photoList.add(list.get(0));
					photoList.add(photoMap);
				}else{
					photoList.add(photoMap);
					photoList.add(list.get(0));
				}
			}else if(list.size() == 2){
				photoList.add(list.get(1));
				photoList.add(list.get(0));
			}else{
				photoList.add(photoMap);
				photoList.add(photoMap);
			}
		}
		
		return photoList;
	}


	public int insertPartnerIndividualInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		synchronized(map) {
			int cnt = partnerManagementDAO.insertPartnerIndividualInfo(map);
			
			boolean nameCardCheck = false;
			boolean photoCheck = false;
			if(map.get("browser").toString().equals("9.0")){ //ie9버전 파일유무 체크
				nameCardCheck = !((MultipartHttpServletRequest) request).getFile("fileModalUploadNameCard").isEmpty(); 
				photoCheck = !((MultipartHttpServletRequest) request).getFile("fileModalUploadPhoto").isEmpty(); 
			}else{ //그외 파일유무 체크
				nameCardCheck = !((MultipartHttpServletRequest) request).getFiles("fileModalUploadNameCard").isEmpty(); 
				photoCheck = !((MultipartHttpServletRequest) request).getFiles("fileModalUploadPhoto").isEmpty(); 
			}
			
			if(nameCardCheck) { // 명함 업로드 유무
				map.put("imageType", "nameCard");
				map.put("fileModalUploadType", "fileModalUploadNameCard");
				Map<String,Object> photo = commonFileUtils.insertPhoto(map, request, "PARTNER_INDIVIDUAL_PHOTO_STORE","PARTNER_INDIVIDUAL_ID");
				commonDAO.insertFile(photo);
				cnt++;
			}
			if(photoCheck) { // 사진 업로드 유무
				map.put("imageType", "photo");
				map.put("fileModalUploadType", "fileModalUploadPhoto");
				Map<String,Object> photo = commonFileUtils.insertPhoto(map, request, "PARTNER_INDIVIDUAL_PHOTO_STORE","PARTNER_INDIVIDUAL_ID");
				commonDAO.insertFile(photo);
				cnt++;
			}
			
			return cnt;
		}
	}


	public int updatePartnerIndividualInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = 0;
		// log.debug(photo.get("FILE_PATH").equals(map.get("hiddenModalPartnerId")));
		Map<String,Object> nameCard = partnerManagementDAO.selectPartnerIndividualNameCard(map); // 기존 명함 유무
		Map<String, Object> photo = partnerManagementDAO.selectPartnerIndividualPhoto(map); // 기존 사진 유무
		Map<String, Object> clinetInfo = partnerManagementDAO.selectPartnerIndividualInfo(map); // 기존 개인정보 
		
		map.put("filePK", map.get("hiddenModalPK"));
		
		boolean nameCardCheck = false;
		boolean photoCheck = false;
		if(map.get("browser").toString().equals("9.0")){
			nameCardCheck = !((MultipartHttpServletRequest) request).getFile("fileModalUploadNameCard").isEmpty(); //ie9버전 파일유무 체크
			photoCheck = !((MultipartHttpServletRequest) request).getFile("fileModalUploadPhoto").isEmpty(); //ie9버전 파일유무 체크
		}else{
			nameCardCheck = !((MultipartHttpServletRequest) request).getFiles("fileModalUploadNameCard").isEmpty(); //그외 파일유무 체크
			photoCheck = !((MultipartHttpServletRequest) request).getFiles("fileModalUploadPhoto").isEmpty(); //그외 파일유무 체크
		}
		
		cnt += updatePartnerIndividualInfo2(photoCheck, photo, map, clinetInfo, "photo", "fileModalUploadPhoto", request);
		cnt += updatePartnerIndividualInfo2(nameCardCheck, nameCard, map, clinetInfo, "nameCard", "fileModalUploadNameCard", request);

		log.debug("cnt" + cnt);
		return cnt;
	}
	
	
	public int updatePartnerIndividualInfo2(boolean ifNull, Map<String, Object> imageMap, Map<String, Object> map, Map<String, Object> clinetInfo, String imageType, String imageSelect, HttpServletRequest request) throws Exception {
		int cnt = 0;
		
		if(ifNull) { // 사진 업로드 유무
			
			if(imageMap == null) { // 기존 사진이 없고 사진 업로드 ㅇ
				// 회사 유지 : 인서트
				partnerManagementDAO.updatePartnerIndividualInfo(map);
				map.put("imageType", imageType);
				map.put("fileModalUploadType", imageSelect);
				imageMap = commonFileUtils.insertPhoto(map, request, "PARTNER_INDIVIDUAL_PHOTO_STORE","PARTNER_INDIVIDUAL_ID");
				commonDAO.insertFile(imageMap);
				
				cnt = 1;
			}else { // 기존 사진이 있고 사진 업로드 ㅇ
				imageMap.put("fileTableName", "PARTNER_INDIVIDUAL_PHOTO_STORE");
				imageMap.put("fileColumnName", "PARTNER_INDIVIDUAL_ID");
				imageMap.put("imageType", imageType);
				// 회사 유지 : 기존 사진 삭제 후 인서트
				partnerManagementDAO.updatePartnerIndividualInfo(map);
				commonFileUtils.deletePhoto(imageMap, request);
				commonDAO.deletePhoto(imageMap);
				map.put("imageType", imageType);
				map.put("fileModalUploadType", imageSelect);
				imageMap = commonFileUtils.insertPhoto(map, request, "PARTNER_INDIVIDUAL_PHOTO_STORE","PARTNER_INDIVIDUAL_ID");
				commonDAO.insertFile(imageMap);
				
				cnt = 2;
			}
			
		}else { 
			if(imageMap == null) { // 기존 사진이 없고 사진 업로드 ㄴ
				// 회사 유지 : 개인정보만 수정 
				partnerManagementDAO.updatePartnerIndividualInfo(map);
				
				cnt = 3;
			}else { // 기존 사진이 있고 업로드 ㄴ
				if(clinetInfo.get("PARTNER_ID").toString().equals(map.get("hiddenModalCompanyId").toString())) {
					// 회사 유지 : 개인정보만 수정
					partnerManagementDAO.updatePartnerIndividualInfo(map);
					
					cnt = 4;
				}else {
					// 회사 이동 : 기존 사진 이동
					partnerManagementDAO.updatePartnerIndividualInfo(map);
					map.put("imageType", imageType);
					map.put("fileModalUploadType", imageSelect);
					imageMap =  commonFileUtils.movePhoto(imageMap, map, request,  "PARTNER_INDIVIDUAL_PHOTO_STORE","PARTNER_INDIVIDUAL_ID");
					commonDAO.updateFile(imageMap);
					
					cnt = 5;
				}
			}
			
		}
		System.out.println("g2g2");
		System.out.println(cnt);
		return cnt;
	}


	public int deletePartnerIndividualInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {

		Map<String, Object> photo = partnerManagementDAO.selectPartnerIndividualPhoto(map);
		if (photo != null) {
			commonFileUtils.deletePhoto(photo, request);
		}

		int cnt = partnerManagementDAO.deletePartnerIndividualInfo(map);

		return cnt;
	}

	////카드view

	public List<Map<String, Object>> gridPartnerIndividualDetail(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return partnerManagementDAO.gridPartnerIndividualDetail(map);
	}


	public List<Map<String, Object>> gridPartnerIndividualInfoList(Map<String, Object> map) throws Exception {

		List<Map<String, Object>> list = null;

		/**
		 * serch : listClientIndividualInfoList.jsp에서 넘겨준 값
		 * 검색기능 사용하기 위해 분기처리.
		 * 쿼리 분기를 위하여 값을 받음.
		 * 1 : 전체 리스트 뿌리는 값
		 * 2 : 검색 리스트 뿌리는 값
		 */
		if( map.get("serch").equals("1") )
		{
			list = partnerManagementDAO.gridPartnerIndividualInfoList(map);
		}
		else  
		{	// serch : 2 -> 검색 버튼 클릭
			// 검색 내용 없이 검색 버튼 클릭하면, 다시 재로드 하기 위함. (pageStart, pageEnd 때문)
			if( ("".equals(map.get("serchInfo")) || map.get("serchInfo") == null) || (!"".equals(map.get("partnerIdvId")) && map.get("partnerIdvId") != null) )
			{
				list = partnerManagementDAO.gridPartnerIndividualInfoList(map);
			}
			else 
			{
				list = partnerManagementDAO.gridPartnerIndividualInfoList2(map);
			}
		}

		for(int i=0; i<list.size(); i++){
			if("".equals(list.get(i).get("POSITION")) || list.get(i).get("POSITION") == null){
				list.get(i).put("POSITION", "");
			}

			if("".equals(list.get(i).get("COMPANY_NAME")) || list.get(i).get("COMPANY_NAME") == null){
				list.get(i).put("COMPANY_NAME", "");
			}

			if("".equals(list.get(i).get("TEAM")) || list.get(i).get("TEAM") == null){
				list.get(i).put("TEAM", "");
			}

			if("".equals(list.get(i).get("PHONE")) || list.get(i).get("PHONE") == null){
				list.get(i).put("PHONE", "");
			}

			if("".equals(list.get(i).get("EMAIL")) || list.get(i).get("EMAIL") == null){
				list.get(i).put("EMAIL", "");
			}
		}

		return list;
	}

	///////////////////////////////////////////// 파트너사정보 관리
	///////////////////////////////////////////// start/////////////////////////////////////////////////////////

	public Map<String, Object> partnerCompanyInfoSearchDetailGroup(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.partnerCompanyInfoSearchDetailGroup(map);
	}


	public List<Map<String, Object>> selectPartnerInfoSearchPartnerCode(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.selectPartnerInfoSearchPartnerCode(map);
	}


	public List<Map<String, Object>> selectPartnerCompanyList(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.selectPartnerCompanyList(map);
	}


	public int updatePartnerCompanyInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = 0;
		Map<String,Object> organizationChart = partnerManagementDAO.selectPartnerCompanyOrganizationChart(map); // 기존 사진 유무
		Map<String,Object> companyInfo = partnerManagementDAO.selectAllPartnerCompanyInfo(map); // 기존 개인정보 

		map.put("filePK", map.get("hiddenModalPK"));

		cnt = partnerManagementDAO.updatePartnerCompanyInfo(map);
		
		boolean fileCheck = false;
		if(map.get("browser").toString().equals("9.0")){
			fileCheck = !((MultipartHttpServletRequest) request).getFile("fileModalUploadPhoto").isEmpty(); //ie9버전 파일유무 체크
		}else{
			fileCheck = !((MultipartHttpServletRequest) request).getFiles("fileModalUploadPhoto").isEmpty(); //그외 파일유무 체크
		}
		
		if(fileCheck) { // 사진 업로드 유무
			if(organizationChart == null) { // 기존 사진이 없고 사진 업로드 ㅇ
				// 회사 유지 : 인서트
				partnerManagementDAO.updatePartnerCompanyInfo(map);
				organizationChart = commonFileUtils.insertPhoto(map, request, "PARTNER_COMPANY_INFO_FILE_STORE","PARTNER_ID");
				commonDAO.insertFile(organizationChart);

				cnt = 1;
			}else { // 기존 사진이 있고 사진 업로드 ㅇ
				organizationChart.put("fileTableName", "PARTNER_COMPANY_INFO_FILE_STORE");
				organizationChart.put("fileColumnName", "PARTNER_ID");
				// 회사 유지 : 기존 사진 삭제 후 인서트
				partnerManagementDAO.updatePartnerCompanyInfo(map);
				commonFileUtils.deletePhoto(organizationChart, request);
				commonDAO.deletePhoto(organizationChart);
				organizationChart = commonFileUtils.insertPhoto(map, request, "PARTNER_COMPANY_INFO_FILE_STORE","PARTNER_ID");
				commonDAO.insertFile(organizationChart);

				cnt = 2;
			}

		}else { 
			if(organizationChart == null) { // 기존 사진이 없고 사진 업로드 ㄴ
				// 회사 유지 : 개인정보만 수정 
				partnerManagementDAO.updatePartnerCompanyInfo(map);

				cnt = 3;
			}else { // 기존 사진이 있고 업로드 ㄴ
				if(companyInfo.get("PARTNER_ID").toString().equals(map.get("hiddenModalCompanyId").toString())) {
					// 회사 유지 : 개인정보만 수정
					partnerManagementDAO.updatePartnerCompanyInfo(map);

					cnt = 4;
				}else {
					// 회사 이동 : 기존 사진 이동
					partnerManagementDAO.updatePartnerCompanyInfo(map);
					organizationChart =  commonFileUtils.movePhoto(organizationChart, map, request,  "PARTNER_COMPANY_INFO_FILE_STORE","PARTNER_ID");
					commonDAO.updateFile(organizationChart);

					cnt = 5;
				}
			}

		}

		log.debug("cnt"+cnt);

		return cnt;
	}


	public Map<String, Object> insertPartnerCompanyInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = partnerManagementDAO.insertPartnerCompanyInfo(map);

		boolean fileCheck = false;
		if(map.get("browser").toString().equals("9.0")){
			fileCheck = !((MultipartHttpServletRequest) request).getFile("fileModalUploadPhoto").isEmpty(); //ie9버전 파일유무 체크
		}else{
			fileCheck = !((MultipartHttpServletRequest) request).getFiles("fileModalUploadPhoto").isEmpty(); //그외 파일유무 체크
		}
		
		if(fileCheck) { // 사진 업로드 유무
			Map<String,Object> organizationChart = commonFileUtils.insertPhoto(map, request, "PARTNER_COMPANY_INFO_FILE_STORE","PARTNER_ID");
			commonDAO.insertFile(organizationChart);
			cnt ++;
		}
		map.put("cnt", cnt);

		//파트너 등록 후 파트너사 협업에 추가
		map.put("partner_id", map.get("filePK"));
		map.put("create_id", map.get("global_member_id"));
		partnerManagementDAO.createSalesLinkage(map);

		return map;
	}
	public int updatePartnerCompanyFile(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = 0;

		map.put("filePK", map.get("hiddenModalPK"));
		map.put("filePKArray", map.get("hiddenModalPK"));
		List<Map<String,Object>> fileList = commonFileUtils.insertFile(map, request,"PARTNER_COMPANY_INFO_FILE_STORE","PARTNER_ID");
		for(int i=0, size=fileList.size(); i < size; i++){
			commonDAO.insertFile(fileList.get(i));
			cnt ++;
		}

		return cnt;
	}

	////////////////////////////////////////////////// 파트너개인정보
	////////////////////////////////////////////////// View////////////////////////////////////////////

	public List<Map<String, Object>> gridPartnerCompany(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return partnerManagementDAO.gridPartnerCompany(map);
	}

	/////////////////////////////////////////////// 파트너사정보
	/////////////////////////////////////////////// view/////////////////////////////////////////////////

	public Map<String, Object> partnerCompanyInfoViewSearchDetailGroup(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.partnerCompanyInfoViewSearchDetailGroup(map);
	}




	public List<Map<String, Object>> selectPartnerCompanyIndividualList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return partnerManagementDAO.selectPartnerCompanyIndividualList(map);
	}







	public List<Map<String, Object>> listPartnerCompanyInfoLeftList(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> list = null;

		if( ("".equals(map.get("serchInfo")) || map.get("serchInfo") == null) || (!"".equals(map.get("partnerId")) && map.get("partnerId") != null) )
		{
			list = partnerManagementDAO.listPartnerCompanyInfoLeftList2(map);
		}
		else 
		{
			list = partnerManagementDAO.listPartnerCompanyInfoLeftList(map);
		}
		return list;
	}


	public List<Map<String, Object>> selectPartnerCompanyInfo(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.selectPartnerCompanyInfo(map);
	}


	public List<Map<String, Object>> selectPartnerClient(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.selectPartnerClient(map);
	}


	public List<Map<String, Object>> companyOrganizationChart(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.companyOrganizationChart(map);
	}


	public List<Map<String, Object>> companyIndividualSkillMap(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.companyIndividualSkillMap(map);
	}

	public List<Map<String, Object>> selectPartnerCompanyOrderStatus(Map<String, Object> map) throws Exception {
		map.put("searchYear1prev", Integer.parseInt(map.get("searchYear").toString())-1);
		map.put("searchYear2prev", Integer.parseInt(map.get("searchYear").toString())-2);

		List<Map<String, Object>> bfStatusList = partnerManagementDAO.selectPartnerCompanyOrderStatus(map);
		return bfStatusList;
	}

	public List<Map<String, Object>> selectPartnerCompanyOrderList(Map<String, Object> map) throws Exception {

		map.put("searchYear-1", Integer.parseInt(map.get("searchYear").toString())-1);
		map.put("searchYear-2", Integer.parseInt(map.get("searchYear").toString())-2);

		Map<String,Object> statusQuarterLength = partnerManagementDAO.selectPartnerCompanyOrderQuarterLength(map);
		List<Map<String,Object>> statusList1 = partnerManagementDAO.selectPartnerCompanyOrderList1(map);
		List<Map<String,Object>> statusList2 = partnerManagementDAO.selectPartnerCompanyOrderList2(map);
		List<Map<String,Object>> statusList3 = partnerManagementDAO.selectPartnerCompanyOrderList3(map);

		List<Map<String, Object>> sList1Q1 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> sList1Q2 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> sList1Q3 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> sList1Q4 = new ArrayList<Map<String, Object>>();

		List<Map<String, Object>> sList2Q1 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> sList2Q2 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> sList2Q3 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> sList2Q4 = new ArrayList<Map<String, Object>>();

		List<Map<String, Object>> sList3Q1 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> sList3Q2 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> sList3Q3 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> sList3Q4 = new ArrayList<Map<String, Object>>();

		for(int i=0; i<statusList1.size(); i++){
			if(statusList1.get(i).get("STATUS_Q").toString().equals("1")){
				sList1Q1.add(statusList1.get(i));
			}else if(statusList1.get(i).get("STATUS_Q").toString().equals("2")){
				sList1Q2.add(statusList1.get(i));
			}else if(statusList1.get(i).get("STATUS_Q").toString().equals("3")){
				sList1Q3.add(statusList1.get(i));
			}else if(statusList1.get(i).get("STATUS_Q").toString().equals("4")){
				sList1Q4.add(statusList1.get(i));
			}
		}

		for(int i=0; i<statusList2.size(); i++){
			if(statusList2.get(i).get("STATUS_Q").toString().equals("1")){
				sList2Q1.add(statusList2.get(i));
			}else if(statusList2.get(i).get("STATUS_Q").toString().equals("2")){
				sList2Q2.add(statusList2.get(i));
			}else if(statusList2.get(i).get("STATUS_Q").toString().equals("3")){
				sList2Q3.add(statusList2.get(i));
			}else if(statusList2.get(i).get("STATUS_Q").toString().equals("4")){
				sList2Q4.add(statusList2.get(i));
			}
		}

		for(int i=0; i<statusList3.size(); i++){
			if(statusList3.get(i).get("STATUS_Q").toString().equals("1")){
				sList3Q1.add(statusList3.get(i));
			}else if(statusList3.get(i).get("STATUS_Q").toString().equals("2")){
				sList3Q2.add(statusList3.get(i));
			}else if(statusList3.get(i).get("STATUS_Q").toString().equals("3")){
				sList3Q3.add(statusList3.get(i));
			}else if(statusList3.get(i).get("STATUS_Q").toString().equals("4")){
				sList3Q4.add(statusList3.get(i));
			}
		}

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> statusmap = new HashMap<String, Object>();

		int q1 = Integer.parseInt(statusQuarterLength.get("Q1").toString());
		int q2 = Integer.parseInt(statusQuarterLength.get("Q2").toString());
		int q3 = Integer.parseInt(statusQuarterLength.get("Q3").toString());
		int q4 = Integer.parseInt(statusQuarterLength.get("Q4").toString());

		for(int i=0; i<q1; i++){
			statusmap = new HashMap<String, Object>();
			if(i<sList1Q1.size()){
				statusmap.put("ORDER_NAME1", sList1Q1.get(i).get("ORDER_NAME"));
				statusmap.put("MATERIAL_NAME1", sList1Q1.get(i).get("MATERIAL_NAME"));
				statusmap.put("STATUS_DATE1", sList1Q1.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT1", sList1Q1.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE1", sList1Q1.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT1", sList1Q1.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q1", sList1Q1.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("ORDER_NAME1", null);
				statusmap.put("MATERIAL_NAME1", null);
				statusmap.put("STATUS_DATE1", null);
				statusmap.put("STATUS_AMOUNT1", null);
				statusmap.put("PRICE1", null);
				statusmap.put("TOTAL_AMOUNT1", null);
				statusmap.put("STATUS_Q1", null);
			}

			if(i<sList2Q1.size()){
				statusmap.put("ORDER_NAME2", sList2Q1.get(i).get("ORDER_NAME"));
				statusmap.put("MATERIAL_NAME2", sList2Q1.get(i).get("MATERIAL_NAME"));
				statusmap.put("STATUS_DATE2", sList2Q1.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT2", sList2Q1.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE2", sList2Q1.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT2", sList2Q1.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q2", sList2Q1.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("ORDER_NAME2", null);
				statusmap.put("MATERIAL_NAME2", null);
				statusmap.put("STATUS_DATE2", null);
				statusmap.put("STATUS_AMOUNT2", null);
				statusmap.put("PRICE2", null);
				statusmap.put("TOTAL_AMOUNT2", null);
				statusmap.put("STATUS_Q2", null);
			}

			if(i<sList3Q1.size()){
				statusmap.put("ORDER_NAME3", sList3Q1.get(i).get("ORDER_NAME"));
				statusmap.put("MATERIAL_NAME3", sList3Q1.get(i).get("MATERIAL_NAME"));
				statusmap.put("STATUS_DATE3", sList3Q1.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT3", sList3Q1.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE3", sList3Q1.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT3", sList3Q1.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q3", sList3Q1.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("ORDER_NAME3", null);
				statusmap.put("MATERIAL_NAME3", null);
				statusmap.put("STATUS_DATE3", null);
				statusmap.put("STATUS_AMOUNT3", null);
				statusmap.put("PRICE3", null);
				statusmap.put("TOTAL_AMOUNT3", null);
				statusmap.put("STATUS_Q3", null);
			}
			statusmap.put("STATUS_Q", "1");
			list.add(statusmap);
		}

		for(int i=0; i<q2; i++){
			statusmap = new HashMap<String, Object>();
			if(i<sList1Q2.size()){
				statusmap.put("ORDER_NAME1", sList1Q2.get(i).get("ORDER_NAME"));
				statusmap.put("MATERIAL_NAME1", sList1Q2.get(i).get("MATERIAL_NAME"));
				statusmap.put("STATUS_DATE1", sList1Q2.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT1", sList1Q2.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE1", sList1Q2.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT1", sList1Q2.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q1", sList1Q2.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("ORDER_NAME1", null);
				statusmap.put("MATERIAL_NAME1", null);
				statusmap.put("STATUS_DATE1", null);
				statusmap.put("STATUS_AMOUNT1", null);
				statusmap.put("PRICE1", null);
				statusmap.put("TOTAL_AMOUNT1", null);
				statusmap.put("STATUS_Q1", null);
			}

			if(i<sList2Q2.size()){
				statusmap.put("ORDER_NAME2", sList2Q2.get(i).get("ORDER_NAME"));
				statusmap.put("MATERIAL_NAME2", sList2Q2.get(i).get("MATERIAL_NAME"));
				statusmap.put("STATUS_DATE2", sList2Q2.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT2", sList2Q2.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE2", sList2Q2.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT2", sList2Q2.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q2", sList2Q2.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("ORDER_NAME2", null);
				statusmap.put("MATERIAL_NAME2", null);
				statusmap.put("STATUS_DATE2", null);
				statusmap.put("STATUS_AMOUNT2", null);
				statusmap.put("PRICE2", null);
				statusmap.put("TOTAL_AMOUNT2", null);
				statusmap.put("STATUS_Q2", null);
			}

			if(i<sList3Q2.size()){
				statusmap.put("ORDER_NAME3", sList3Q2.get(i).get("ORDER_NAME"));
				statusmap.put("MATERIAL_NAME3", sList3Q2.get(i).get("MATERIAL_NAME"));
				statusmap.put("STATUS_DATE3", sList3Q2.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT3", sList3Q2.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE3", sList3Q2.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT3", sList3Q2.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q3", sList3Q2.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("ORDER_NAME3", null);
				statusmap.put("MATERIAL_NAME3", null);
				statusmap.put("STATUS_DATE3", null);
				statusmap.put("STATUS_AMOUNT3", null);
				statusmap.put("PRICE3", null);
				statusmap.put("TOTAL_AMOUNT3", null);
				statusmap.put("STATUS_Q3", null);
			}
			statusmap.put("STATUS_Q", "2");
			list.add(statusmap);
		}

		for(int i=0; i<q3; i++){
			statusmap = new HashMap<String, Object>();
			if(i<sList1Q3.size()){
				statusmap.put("ORDER_NAME1", sList1Q3.get(i).get("ORDER_NAME"));
				statusmap.put("MATERIAL_NAME1", sList1Q3.get(i).get("MATERIAL_NAME"));
				statusmap.put("STATUS_DATE1", sList1Q3.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT1", sList1Q3.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE1", sList1Q3.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT1", sList1Q3.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q1", sList1Q3.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("ORDER_NAME1", null);
				statusmap.put("MATERIAL_NAME1", null);
				statusmap.put("STATUS_DATE1", null);
				statusmap.put("STATUS_AMOUNT1", null);
				statusmap.put("PRICE1", null);
				statusmap.put("TOTAL_AMOUNT1", null);
				statusmap.put("STATUS_Q1", null);
			}

			if(i<sList2Q3.size()){
				statusmap.put("ORDER_NAME2", sList2Q3.get(i).get("ORDER_NAME"));
				statusmap.put("MATERIAL_NAME2", sList2Q3.get(i).get("MATERIAL_NAME"));
				statusmap.put("STATUS_DATE2", sList2Q3.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT2", sList2Q3.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE2", sList2Q3.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT2", sList2Q3.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q2", sList2Q3.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("ORDER_NAME2", null);
				statusmap.put("MATERIAL_NAME2", null);
				statusmap.put("STATUS_DATE2", null);
				statusmap.put("STATUS_AMOUNT2", null);
				statusmap.put("PRICE2", null);
				statusmap.put("TOTAL_AMOUNT2", null);
				statusmap.put("STATUS_Q2", null);
			}

			if(i<sList3Q3.size()){
				statusmap.put("ORDER_NAME3", sList3Q3.get(i).get("ORDER_NAME"));
				statusmap.put("MATERIAL_NAME3", sList3Q3.get(i).get("MATERIAL_NAME"));
				statusmap.put("STATUS_DATE3", sList3Q3.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT3", sList3Q3.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE3", sList3Q3.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT3", sList3Q3.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q3", sList3Q3.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("ORDER_NAME3", null);
				statusmap.put("MATERIAL_NAME3", null);
				statusmap.put("STATUS_DATE3", null);
				statusmap.put("STATUS_AMOUNT3", null);
				statusmap.put("PRICE3", null);
				statusmap.put("TOTAL_AMOUNT3", null);
				statusmap.put("STATUS_Q3", null);
			}
			statusmap.put("STATUS_Q", "3");
			list.add(statusmap);
		}

		for(int i=0; i<q4; i++){
			statusmap = new HashMap<String, Object>();
			if(i<sList1Q4.size()){
				statusmap.put("ORDER_NAME1", sList1Q4.get(i).get("ORDER_NAME"));
				statusmap.put("MATERIAL_NAME1", sList1Q4.get(i).get("MATERIAL_NAME"));
				statusmap.put("STATUS_DATE1", sList1Q4.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT1", sList1Q4.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE1", sList1Q4.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT1", sList1Q4.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q1", sList1Q4.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("ORDER_NAME1", null);
				statusmap.put("MATERIAL_NAME1", null);
				statusmap.put("STATUS_DATE1", null);
				statusmap.put("STATUS_AMOUNT1", null);
				statusmap.put("PRICE1", null);
				statusmap.put("TOTAL_AMOUNT1", null);
				statusmap.put("STATUS_Q1", null);
			}

			if(i<sList2Q4.size()){
				statusmap.put("ORDER_NAME2", sList2Q4.get(i).get("ORDER_NAME"));
				statusmap.put("MATERIAL_NAME2", sList2Q4.get(i).get("MATERIAL_NAME"));
				statusmap.put("STATUS_DATE2", sList2Q4.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT2", sList2Q4.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE2", sList2Q4.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT2", sList2Q4.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q2", sList2Q4.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("ORDER_NAME2", null);
				statusmap.put("MATERIAL_NAME2", null);
				statusmap.put("STATUS_DATE2", null);
				statusmap.put("STATUS_AMOUNT2", null);
				statusmap.put("PRICE2", null);
				statusmap.put("TOTAL_AMOUNT2", null);
				statusmap.put("STATUS_Q2", null);
			}

			if(i<sList3Q4.size()){
				statusmap.put("ORDER_NAME3", sList3Q4.get(i).get("ORDER_NAME"));
				statusmap.put("MATERIAL_NAME3", sList3Q4.get(i).get("MATERIAL_NAME"));
				statusmap.put("STATUS_DATE3", sList3Q4.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT3", sList3Q4.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE3", sList3Q4.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT3", sList3Q4.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q3", sList3Q4.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("ORDER_NAME3", null);
				statusmap.put("MATERIAL_NAME3", null);
				statusmap.put("STATUS_DATE3", null);
				statusmap.put("STATUS_AMOUNT3", null);
				statusmap.put("PRICE3", null);
				statusmap.put("TOTAL_AMOUNT3", null);
				statusmap.put("STATUS_Q3", null);
			}
			statusmap.put("STATUS_Q", "4");
			list.add(statusmap);
		}

		return list;
	}

	public List<Map<String, Object>> selectPartnerCompanyOrderList1(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.selectPartnerCompanyOrderList1(map);
	}


	public List<Map<String, Object>> selectPartnerCompanyOrderList2(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.selectPartnerCompanyOrderList2(map);
	}


	public List<Map<String, Object>> selectPartnerCompanyOrderList3(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.selectPartnerCompanyOrderList3(map);
	}


	public List<Map<String, Object>> selectPartnerCompanyOrder(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.selectPartnerCompanyOrder(map);
	}


	public int updatePartnerCompanyInfoOrder(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = 0;

		ArrayList<HashMap<String, Object>> statusList = CommonUtils.jsonList((map.get("partnerCompanyStatusGrid")).toString());
		for(Map<String,Object> getMap : statusList)
		{
			getMap.put("companyId",map.get("companyId"));
			getMap.put("creatorId",map.get("creatorId"));

			if(getMap.get("STATUS_ID") != null && !"".equals(getMap.get("STATUS_ID"))){
				partnerManagementDAO.updatePartnerCompanyInfoOrder(getMap);
			}else if(!"".equals(getMap.get("ORDER_NAME")) && !"".equals(getMap.get("MATERIAL_NAME")) && !"".equals(getMap.get("STATUS_DATE"))){
				//}else{
				partnerManagementDAO.insertPartnerCompanyInfoOrder(getMap);
			}
			cnt++;
		}

		return cnt; 
	}


	public int deletePartnerCompanyOrder(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = partnerManagementDAO.deletePartnerCompanyOrder(map);
		return cnt;
	}


	public List<Map<String, Object>> selectPartnerCompanySaleList(Map<String, Object> map) throws Exception {

		map.put("searchYear-1", Integer.parseInt(map.get("searchYear").toString())-1);
		map.put("searchYear-2", Integer.parseInt(map.get("searchYear").toString())-2);

		Map<String,Object> statusQuarterLength = partnerManagementDAO.selectPartnerCompanySaleQuarterLength(map);
		List<Map<String,Object>> statusList1 = partnerManagementDAO.selectPartnerCompanySaleList1(map);
		List<Map<String,Object>> statusList2 = partnerManagementDAO.selectPartnerCompanySaleList2(map);
		List<Map<String,Object>> statusList3 = partnerManagementDAO.selectPartnerCompanySaleList3(map);

		List<Map<String, Object>> sList1Q1 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> sList1Q2 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> sList1Q3 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> sList1Q4 = new ArrayList<Map<String, Object>>();

		List<Map<String, Object>> sList2Q1 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> sList2Q2 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> sList2Q3 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> sList2Q4 = new ArrayList<Map<String, Object>>();

		List<Map<String, Object>> sList3Q1 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> sList3Q2 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> sList3Q3 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> sList3Q4 = new ArrayList<Map<String, Object>>();

		for(int i=0; i<statusList1.size(); i++){
			if(statusList1.get(i).get("STATUS_Q").toString().equals("1")){
				sList1Q1.add(statusList1.get(i));
			}else if(statusList1.get(i).get("STATUS_Q").toString().equals("2")){
				sList1Q2.add(statusList1.get(i));
			}else if(statusList1.get(i).get("STATUS_Q").toString().equals("3")){
				sList1Q3.add(statusList1.get(i));
			}else if(statusList1.get(i).get("STATUS_Q").toString().equals("4")){
				sList1Q4.add(statusList1.get(i));
			}
		}

		for(int i=0; i<statusList2.size(); i++){
			if(statusList2.get(i).get("STATUS_Q").toString().equals("1")){
				sList2Q1.add(statusList2.get(i));
			}else if(statusList2.get(i).get("STATUS_Q").toString().equals("2")){
				sList2Q2.add(statusList2.get(i));
			}else if(statusList2.get(i).get("STATUS_Q").toString().equals("3")){
				sList2Q3.add(statusList2.get(i));
			}else if(statusList2.get(i).get("STATUS_Q").toString().equals("4")){
				sList2Q4.add(statusList2.get(i));
			}
		}

		for(int i=0; i<statusList3.size(); i++){
			if(statusList3.get(i).get("STATUS_Q").toString().equals("1")){
				sList3Q1.add(statusList3.get(i));
			}else if(statusList3.get(i).get("STATUS_Q").toString().equals("2")){
				sList3Q2.add(statusList3.get(i));
			}else if(statusList3.get(i).get("STATUS_Q").toString().equals("3")){
				sList3Q3.add(statusList3.get(i));
			}else if(statusList3.get(i).get("STATUS_Q").toString().equals("4")){
				sList3Q4.add(statusList3.get(i));
			}
		}

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> statusmap = new HashMap<String, Object>();

		int q1 = Integer.parseInt(statusQuarterLength.get("Q1").toString());
		int q2 = Integer.parseInt(statusQuarterLength.get("Q2").toString());
		int q3 = Integer.parseInt(statusQuarterLength.get("Q3").toString());
		int q4 = Integer.parseInt(statusQuarterLength.get("Q4").toString());

		for(int i=0; i<q1; i++){
			statusmap = new HashMap<String, Object>();
			if(i<sList1Q1.size()){
				statusmap.put("SALE_NAME1", sList1Q1.get(i).get("SALE_NAME"));
				statusmap.put("PRODUCT_NAME1", sList1Q1.get(i).get("PRODUCT_NAME"));
				statusmap.put("STATUS_DATE1", sList1Q1.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT1", sList1Q1.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE1", sList1Q1.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT1", sList1Q1.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q1", sList1Q1.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("SALE_NAME1", null);
				statusmap.put("PRODUCT_NAME1", null);
				statusmap.put("STATUS_DATE1", null);
				statusmap.put("STATUS_AMOUNT1", null);
				statusmap.put("PRICE1", null);
				statusmap.put("TOTAL_AMOUNT1", null);
				statusmap.put("STATUS_Q1", null);
			}

			if(i<sList2Q1.size()){
				statusmap.put("SALE_NAME2", sList2Q1.get(i).get("SALE_NAME"));
				statusmap.put("PRODUCT_NAME2", sList2Q1.get(i).get("PRODUCT_NAME"));
				statusmap.put("STATUS_DATE2", sList2Q1.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT2", sList2Q1.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE2", sList2Q1.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT2", sList2Q1.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q2", sList2Q1.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("SALE_NAME2", null);
				statusmap.put("PRODUCT_NAME2", null);
				statusmap.put("STATUS_DATE2", null);
				statusmap.put("STATUS_AMOUNT2", null);
				statusmap.put("PRICE2", null);
				statusmap.put("TOTAL_AMOUNT2", null);
				statusmap.put("STATUS_Q2", null);
			}

			if(i<sList3Q1.size()){
				statusmap.put("SALE_NAME3", sList3Q1.get(i).get("SALE_NAME"));
				statusmap.put("PRODUCT_NAME3", sList3Q1.get(i).get("PRODUCT_NAME"));
				statusmap.put("STATUS_DATE3", sList3Q1.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT3", sList3Q1.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE3", sList3Q1.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT3", sList3Q1.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q3", sList3Q1.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("SALE_NAME3", null);
				statusmap.put("PRODUCT_NAME3", null);
				statusmap.put("STATUS_DATE3", null);
				statusmap.put("STATUS_AMOUNT3", null);
				statusmap.put("PRICE3", null);
				statusmap.put("TOTAL_AMOUNT3", null);
				statusmap.put("STATUS_Q3", null);
			}
			statusmap.put("STATUS_Q", "1");
			list.add(statusmap);
		}

		for(int i=0; i<q2; i++){
			statusmap = new HashMap<String, Object>();
			if(i<sList1Q2.size()){
				statusmap.put("SALE_NAME1", sList1Q2.get(i).get("SALE_NAME"));
				statusmap.put("PRODUCT_NAME1", sList1Q2.get(i).get("PRODUCT_NAME"));
				statusmap.put("STATUS_DATE1", sList1Q2.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT1", sList1Q2.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE1", sList1Q2.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT1", sList1Q2.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q1", sList1Q2.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("SALE_NAME1", null);
				statusmap.put("PRODUCT_NAME1", null);
				statusmap.put("STATUS_DATE1", null);
				statusmap.put("STATUS_AMOUNT1", null);
				statusmap.put("PRICE1", null);
				statusmap.put("TOTAL_AMOUNT1", null);
				statusmap.put("STATUS_Q1", null);
			}

			if(i<sList2Q2.size()){
				statusmap.put("SALE_NAME2", sList2Q2.get(i).get("SALE_NAME"));
				statusmap.put("PRODUCT_NAME2", sList2Q2.get(i).get("PRODUCT_NAME"));
				statusmap.put("STATUS_DATE2", sList2Q2.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT2", sList2Q2.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE2", sList2Q2.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT2", sList2Q2.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q2", sList2Q2.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("SALE_NAME2", null);
				statusmap.put("PRODUCT_NAME2", null);
				statusmap.put("STATUS_DATE2", null);
				statusmap.put("STATUS_AMOUNT2", null);
				statusmap.put("PRICE2", null);
				statusmap.put("TOTAL_AMOUNT2", null);
				statusmap.put("STATUS_Q2", null);
			}

			if(i<sList3Q2.size()){
				statusmap.put("SALE_NAME3", sList3Q2.get(i).get("SALE_NAME"));
				statusmap.put("PRODUCT_NAME3", sList3Q2.get(i).get("PRODUCT_NAME"));
				statusmap.put("STATUS_DATE3", sList3Q2.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT3", sList3Q2.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE3", sList3Q2.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT3", sList3Q2.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q3", sList3Q2.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("SALE_NAME3", null);
				statusmap.put("PRODUCT_NAME3", null);
				statusmap.put("STATUS_DATE3", null);
				statusmap.put("STATUS_AMOUNT3", null);
				statusmap.put("PRICE3", null);
				statusmap.put("TOTAL_AMOUNT3", null);
				statusmap.put("STATUS_Q3", null);
			}
			statusmap.put("STATUS_Q", "2");
			list.add(statusmap);
		}

		for(int i=0; i<q3; i++){
			statusmap = new HashMap<String, Object>();
			if(i<sList1Q3.size()){
				statusmap.put("SALE_NAME1", sList1Q3.get(i).get("SALE_NAME"));
				statusmap.put("PRODUCT_NAME1", sList1Q3.get(i).get("PRODUCT_NAME"));
				statusmap.put("STATUS_DATE1", sList1Q3.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT1", sList1Q3.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE1", sList1Q3.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT1", sList1Q3.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q1", sList1Q3.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("SALE_NAME1", null);
				statusmap.put("PRODUCT_NAME1", null);
				statusmap.put("STATUS_DATE1", null);
				statusmap.put("STATUS_AMOUNT1", null);
				statusmap.put("PRICE1", null);
				statusmap.put("TOTAL_AMOUNT1", null);
				statusmap.put("STATUS_Q1", null);
			}

			if(i<sList2Q3.size()){
				statusmap.put("SALE_NAME2", sList2Q3.get(i).get("SALE_NAME"));
				statusmap.put("PRODUCT_NAME2", sList2Q3.get(i).get("PRODUCT_NAME"));
				statusmap.put("STATUS_DATE2", sList2Q3.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT2", sList2Q3.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE2", sList2Q3.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT2", sList2Q3.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q2", sList2Q3.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("SALE_NAME2", null);
				statusmap.put("PRODUCT_NAME2", null);
				statusmap.put("STATUS_DATE2", null);
				statusmap.put("STATUS_AMOUNT2", null);
				statusmap.put("PRICE2", null);
				statusmap.put("TOTAL_AMOUNT2", null);
				statusmap.put("STATUS_Q2", null);
			}

			if(i<sList3Q3.size()){
				statusmap.put("SALE_NAME3", sList3Q3.get(i).get("SALE_NAME"));
				statusmap.put("PRODUCT_NAME3", sList3Q3.get(i).get("PRODUCT_NAME"));
				statusmap.put("STATUS_DATE3", sList3Q3.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT3", sList3Q3.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE3", sList3Q3.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT3", sList3Q3.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q3", sList3Q3.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("SALE_NAME3", null);
				statusmap.put("PRODUCT_NAME3", null);
				statusmap.put("STATUS_DATE3", null);
				statusmap.put("STATUS_AMOUNT3", null);
				statusmap.put("PRICE3", null);
				statusmap.put("TOTAL_AMOUNT3", null);
				statusmap.put("STATUS_Q3", null);
			}
			statusmap.put("STATUS_Q", "3");
			list.add(statusmap);
		}

		for(int i=0; i<q4; i++){
			statusmap = new HashMap<String, Object>();
			if(i<sList1Q4.size()){
				statusmap.put("SALE_NAME1", sList1Q4.get(i).get("SALE_NAME"));
				statusmap.put("PRODUCT_NAME1", sList1Q4.get(i).get("PRODUCT_NAME"));
				statusmap.put("STATUS_DATE1", sList1Q4.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT1", sList1Q4.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE1", sList1Q4.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT1", sList1Q4.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q1", sList1Q4.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("SALE_NAME1", null);
				statusmap.put("PRODUCT_NAME1", null);
				statusmap.put("STATUS_DATE1", null);
				statusmap.put("STATUS_AMOUNT1", null);
				statusmap.put("PRICE1", null);
				statusmap.put("TOTAL_AMOUNT1", null);
				statusmap.put("STATUS_Q1", null);
			}

			if(i<sList2Q4.size()){
				statusmap.put("SALE_NAME2", sList2Q4.get(i).get("SALE_NAME"));
				statusmap.put("PRODUCT_NAME2", sList2Q4.get(i).get("PRODUCT_NAME"));
				statusmap.put("STATUS_DATE2", sList2Q4.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT2", sList2Q4.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE2", sList2Q4.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT2", sList2Q4.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q2", sList2Q4.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("SALE_NAME2", null);
				statusmap.put("PRODUCT_NAME2", null);
				statusmap.put("STATUS_DATE2", null);
				statusmap.put("STATUS_AMOUNT2", null);
				statusmap.put("PRICE2", null);
				statusmap.put("TOTAL_AMOUNT2", null);
				statusmap.put("STATUS_Q2", null);
			}

			if(i<sList3Q4.size()){
				statusmap.put("SALE_NAME3", sList3Q4.get(i).get("SALE_NAME"));
				statusmap.put("PRODUCT_NAME3", sList3Q4.get(i).get("PRODUCT_NAME"));
				statusmap.put("STATUS_DATE3", sList3Q4.get(i).get("STATUS_DATE"));
				statusmap.put("STATUS_AMOUNT3", sList3Q4.get(i).get("STATUS_AMOUNT"));
				statusmap.put("PRICE3", sList3Q4.get(i).get("PRICE"));
				statusmap.put("TOTAL_AMOUNT3", sList3Q4.get(i).get("TOTAL_AMOUNT"));
				statusmap.put("STATUS_Q3", sList3Q4.get(i).get("STATUS_Q"));
			}else{
				statusmap.put("SALE_NAME3", null);
				statusmap.put("PRODUCT_NAME3", null);
				statusmap.put("STATUS_DATE3", null);
				statusmap.put("STATUS_AMOUNT3", null);
				statusmap.put("PRICE3", null);
				statusmap.put("TOTAL_AMOUNT3", null);
				statusmap.put("STATUS_Q3", null);
			}
			statusmap.put("STATUS_Q", "4");
			list.add(statusmap);
		}

		return list;
	}


	public List<Map<String, Object>> selectPartnerCompanySaleList1(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.selectPartnerCompanySaleList1(map);
	}


	public List<Map<String, Object>> selectPartnerCompanySaleList2(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.selectPartnerCompanySaleList2(map);
	}


	public List<Map<String, Object>> selectPartnerCompanySaleList3(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.selectPartnerCompanySaleList3(map);
	}


	public List<Map<String, Object>> selectPartnerCompanySale(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.selectPartnerCompanySale(map);
	}


	public int updatePartnerCompanyInfoSale(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = 0;

		ArrayList<HashMap<String, Object>> statusList = CommonUtils.jsonList((map.get("partnerCompanyStatusGrid")).toString());
		for(Map<String,Object> getMap : statusList)
		{
			getMap.put("companyId",map.get("companyId"));
			getMap.put("creatorId",map.get("creatorId"));

			if(getMap.get("STATUS_ID") != null && !"".equals(getMap.get("STATUS_ID"))){
				partnerManagementDAO.updatePartnerCompanyInfoSale(getMap);
			}else if(!"".equals(getMap.get("SALE_NAME")) && !"".equals(getMap.get("PRODUCT_NAME")) && !"".equals(getMap.get("STATUS_DATE"))){
				//}else{
				partnerManagementDAO.insertPartnerCompanyInfoSale(getMap);
			}
			cnt++;
		}

		return cnt; 
	}


	public int deletePartnerCompanySale(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = partnerManagementDAO.deletePartnerCompanySale(map);
		return cnt;
	}


	public List<Map<String, Object>> selectPartnerCompanyFileList(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.selectPartnerCompanyFileList(map);
	}


	public List<Map<String, Object>> partnerIndividualSkillList(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.partnerIndividualSkillList(map);
	}


	public List<Map<String, Object>> partnerEnableLogList(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.partnerEnableLogList(map);
	}


	public List<Map<String, Object>> selectVendorSolutionAreaList(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.selectVendorSolutionAreaList(map);
	}


	public int insertSolutionArea(Map<String, Object> map) throws Exception {
		int cnt = 0;

		ObjectMapper mapper = new ObjectMapper();
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>(); 
		String jsonData = (map.get("salesDetailData")).toString();		 
		list = mapper.readValue(jsonData, new TypeReference<ArrayList<HashMap<String, String>>>() {});        

		for(int i=0; i<list.size(); i++){

			list.get(i).put("customerId", map.get("customerId"));
			list.get(i).put("creatorId", map.get("creatorId"));

			if(list.get(i).get("SKILL_MAP_ID") != null && !"".equals(list.get(i).get("SKILL_MAP_ID"))){
				partnerManagementDAO.updateSolutionArea(list.get(i));
			}else{
				partnerManagementDAO.insertSolutionArea(list.get(i));
			}
			cnt ++;
		}
		return cnt;
	}

	public int deleteSolutionArea(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.deleteSolutionArea(map);
	}
	
    public Map<String, Object> salesLinkageDetail(Map<String, Object> map) throws Exception {
        // TODO Auto-generated method stub
        return partnerManagementDAO.salesLinkageDetail(map);
    }
    
    /**
	 * @explain : 모바일 파트너사 협업관리-> 파트너 정보 -> 나의 전체 파트너
	 */
	public int totalPartnerIndividualCnt(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.totalPartnerIndividualCnt(map);
	}

    /**
	 * @explain : 모바일 파트너사 협업관리-> 파트너 정보 -> 금주 신규 고객
	 */
	public int partnerIndividualNewCnt(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.partnerIndividualNewCnt(map);
	}
	
	/**
	 * @explain : 모바일 파트너사 협업관리-> 파트너사 정보 -> 영역별 현황
	 */
	public  List<Map<String, Object>> selecetPartnerIndividualStatusByAreaList(Map<String, Object> map) throws Exception {
		return partnerManagementDAO.selecetPartnerIndividualStatusByAreaList(map);
	}
}
