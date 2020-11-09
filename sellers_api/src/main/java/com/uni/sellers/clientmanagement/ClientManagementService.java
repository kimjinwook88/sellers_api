package com.uni.sellers.clientmanagement;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.ognl.MapElementsAccessor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.uni.sellers.common.CommonDAO;
import com.uni.sellers.util.CommonFileUtils;
import com.uni.sellers.util.CommonUtils;

import groovy.transform.Synchronized;

@Service("clientManagementService")
public class ClientManagementService{
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="commonFileUtils")
	private CommonFileUtils commonFileUtils;
	
	@Resource(name="clientManagementDAO")
	private ClientManagementDAO clientManagementDAO;
	
	@Resource(name="commonDAO")
	private CommonDAO commonDAO;
	
	@Value("#{config['path.image']}")
	private String PATH_IMAGE;
	
	protected static SimpleDateFormat mFmtDate = new SimpleDateFormat( "yyyy-MM-dd", java.util.Locale.ENGLISH ) ;
	

	
	
	public List<Map<String, Object>> gridSalesStatus(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		List<Map<String, Object>> list = clientManagementDAO.gridSalesStatus(map);
		
		if(map.get("salesStatus") == null) {
			map.put("salesStatus", "2");
		}
		
		if(map.get("salesStatus").equals("1"))
		{
			for(int i=0; i<list.size(); i++){
				
				if(list.get(i).get("ROLE").equals("1")){
					list.get(i).put("ROLE", "정보제공자");
				}
				else if(list.get(i).get("ROLE").equals("2")){
					list.get(i).put("ROLE", "실무자");
				}
				else if(list.get(i).get("ROLE").equals("3")){
					list.get(i).put("ROLE", "의사결정자");
				}
				else if(list.get(i).get("ROLE").equals("4")){
					list.get(i).put("ROLE", "influencer");
				}
				
				if(list.get(i).get("POSITION").equals("1")){
					list.get(i).put("POSITION", "Pro");
				}
				else if(list.get(i).get("POSITION").equals("2")){
					list.get(i).put("POSITION", "Anti");
				}
				else if(list.get(i).get("POSITION").equals("3")){
					list.get(i).put("POSITION", "Natural");
				}
			}
		}
		
//		return clientManagementDAO.gridSalesStatus(map);
		return list;
	}
	
	
	public int insertSalesStatus(Map<String, Object> map) throws Exception {
		int cnt = 0;
		
		ObjectMapper mapper = new ObjectMapper();
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>(); 
		String jsonData = "";
		if(map.get("projectMgData") != null){
			jsonData = (map.get("projectMgData")).toString();
			list = mapper.readValue(jsonData, new TypeReference<ArrayList<HashMap<String, String>>>() {});
			
			for(int i=0; i<list.size(); i++){
				
				list.get(i).put("customerId", map.get("customerId"));
				list.get(i).put("creatorId", map.get("creatorId"));
				
				if(list.get(i).get("SEQ_NUM") != null && !"".equals(list.get(i).get("SEQ_NUM"))){
					clientManagementDAO.updateSalesStatus(list.get(i));
				}else{
					clientManagementDAO.insertSalesStatus(list.get(i));
				}
				cnt ++;
			}
		}
		return cnt;
	}
	
	
	public int deleteSalesStatus(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientManagementDAO.deleteSalesStatus(map);
	}
	
	////////////////////////////////////////////고객개인정보 관리 start///////////////////////////////////////////////////////
	
	public Map<String, Object> clientIndividualInfoSearchDetailGroup(Map<String, Object> map) throws Exception {
		return clientManagementDAO.clientIndividualInfoSearchDetailGroup(map);
	}
	
	
	public List<Map<String, Object>> gridClientIndividualInfoManage(Map<String, Object> map) throws Exception {
		return clientManagementDAO.gridClientIndividualInfoManage(map);
	}
	
	
	public List<Map<String, Object>> gridClientIndividualInfo(Map<String, Object> map) throws Exception {
		return clientManagementDAO.gridClientIndividualInfo(map);
	}
	
	
	public List<Map<String, Object>> clientIndividualPhotoList(Map<String, Object> map) throws Exception {
		List<Map<String,Object>> list = clientManagementDAO.clientIndividualPhotoList(map);
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
				photoList.add(list.get(0));
				photoList.add(list.get(1));
			}else{
				photoList.add(photoMap);
				photoList.add(photoMap);
			}
		}
		
		return photoList;
	}
	
	
	public Map<String, Object> insertClientIndividualInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		synchronized(map) {
			//code
			int cnt = clientManagementDAO.insertClientIndividualInfo(map);	
			//map.put("selectModalClientCategory", ((String) map.get("textCommonSearchCompanyId")).charAt(0)); //태원 버전
			
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
				Map<String,Object> photo = commonFileUtils.insertPhoto(map, request, "CLIENT_INDIVIDUAL_PHOTO_STORE","CUSTOMER_ID");
				commonDAO.insertFile(photo);
				cnt++;
			}
			if(photoCheck) { // 사진 업로드 유무
				map.put("imageType", "photo");
				map.put("fileModalUploadType", "fileModalUploadPhoto");
				Map<String,Object> photo = commonFileUtils.insertPhoto(map, request, "CLIENT_INDIVIDUAL_PHOTO_STORE","CUSTOMER_ID");
				commonDAO.insertFile(photo);
				cnt++;
			}
			map.put("cnt", cnt);
			
			return map;
		}
		
		/*try{
		}catch(DuplicateKeyException e){
			log.debug(e.getMessage());
			for(int i=0; i < 5; i++){
				log.debug("시퀀스 수정");
				clientManagementDAO.updateClientIndividualSequenceInfo(map);
				map.put("CUSTOMER_ID", clientManagementDAO.slectClientIndividualSequenceInfo(map).get("CUSTOMER_ID"));
				
				int check = clientManagementDAO.selectClientIndividualCnt(map);
				if(check == 0){
					cnt = clientManagementDAO.insertClientIndividualInfo(map);
					cnt += clientManagementDAO.updateClientIndividualSequenceInfo(map);
					
					if(!((MultipartHttpServletRequest) request).getFiles("fileModalUploadPhoto").isEmpty()) { // 사진 업로드 유무
						Map<String,Object> photo = commonFileUtils.insertPhoto(map, request, "CLIENT_INDIVIDUAL_PHOTO_STORE","CUSTOMER_ID");
						commonDAO.insertFile(photo);
					}
					cnt ++;
				}
			}
			if(cnt == 0){
				map.put("error", "sequence");
				return map;
			}
		}catch(Exception f){
			log.debug(f.getMessage());
			//throw new Exception(f);
			throw f;
		}*/
	}
	
	
	public int updateClientIndividualInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = 0;
		//log.debug(photo.get("FILE_PATH").equals(map.get("hiddenModalCompanyId")));
		Map<String,Object> nameCard = clientManagementDAO.selectClientIndividualNameCard(map); // 기존 명함 유무
		Map<String,Object> photo = clientManagementDAO.selectClientIndividualPhoto(map); // 기존 사진 유무
		Map<String,Object> clinetInfo = clientManagementDAO.selectClientIndividualInfo(map); // 기존 개인정보 
		
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
		
		cnt += updateClientIndividualInfo2(photoCheck, photo, map, clinetInfo, "photo", "fileModalUploadPhoto", request);
		cnt += updateClientIndividualInfo2(nameCardCheck, nameCard, map, clinetInfo, "nameCard", "fileModalUploadNameCard", request);
		
		return cnt;
	}
	
	
	public int updateClientIndividualInfo2(boolean ifNull, Map<String, Object> imageMap, Map<String, Object> map, Map<String, Object> clinetInfo, String imageType, String imageSelect, HttpServletRequest request) throws Exception {
		int cnt = 0;
		
		if(ifNull) { // 사진 업로드 유무
			
			if(imageMap == null) { // 기존 사진이 없고 사진 업로드 ㅇ
				// 회사 유지 : 인서트
				clientManagementDAO.updateClientIndividualInfo(map);
				map.put("imageType", imageType);
				map.put("fileModalUploadType", imageSelect);
				imageMap = commonFileUtils.insertPhoto(map, request, "CLIENT_INDIVIDUAL_PHOTO_STORE","CUSTOMER_ID");
				commonDAO.insertFile(imageMap);
				
				cnt = 1;
			}else { // 기존 사진이 있고 사진 업로드 ㅇ
				imageMap.put("fileTableName", "CLIENT_INDIVIDUAL_PHOTO_STORE");
				imageMap.put("fileColumnName", "CUSTOMER_ID");
				imageMap.put("imageType", imageType);
				// 회사 유지 : 기존 사진 삭제 후 인서트
				clientManagementDAO.updateClientIndividualInfo(map);
				commonFileUtils.deletePhoto(imageMap, request);
				commonDAO.deletePhoto(imageMap);
				map.put("imageType", imageType);
				map.put("fileModalUploadType", imageSelect);
				imageMap = commonFileUtils.insertPhoto(map, request, "CLIENT_INDIVIDUAL_PHOTO_STORE","CUSTOMER_ID");
				commonDAO.insertFile(imageMap);
				
				cnt = 2;
			}
			
		}else { 
			if(imageMap == null) { // 기존 사진이 없고 사진 업로드 ㄴ
				// 회사 유지 : 개인정보만 수정 
				clientManagementDAO.updateClientIndividualInfo(map);
				
				cnt = 3;
			}else { // 기존 사진이 있고 업로드 ㄴ
				if(clinetInfo.get("COMPANY_ID").toString().equals(map.get("hiddenModalCompanyId").toString())) {
					// 회사 유지 : 개인정보만 수정
					clientManagementDAO.updateClientIndividualInfo(map);
					
					cnt = 4;
				}else {
					// 회사 이동 : 기존 사진 이동
					clientManagementDAO.updateClientIndividualInfo(map);
					map.put("imageType", imageType);
					map.put("fileModalUploadType", imageSelect);
					imageMap =  commonFileUtils.movePhoto(imageMap, map, request,  "CLIENT_INDIVIDUAL_PHOTO_STORE","CUSTOMER_ID");
					commonDAO.updateFile(imageMap);
					
					cnt = 5;
				}
			}
			
		}
		
		return cnt;
	}
	
	
	public int deleteClientIndividualInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		Map<String,Object> photo = clientManagementDAO.selectClientIndividualPhoto(map);
		if(photo!=null) {
			photo.put("fileColumnName", "CUSTOMER_ID");
			commonFileUtils.deletePhoto(photo, request);
		}
		
		int cnt = clientManagementDAO.deleteClientIndividualInfo(map);
		
		return cnt;
	}
	
	
	/////////////////////////////////////////////고객사정보 관리 start/////////////////////////////////////////////////////////
	
	public Map<String, Object> clientCompanyInfoSearchDetailGroup(Map<String, Object> map) throws Exception {
		return clientManagementDAO.clientCompanyInfoSearchDetailGroup(map);
	}
	
	
	public List<Map<String, Object>> gridClientCompanyInfo(Map<String, Object> map) throws Exception {
		return clientManagementDAO.gridClientCompanyInfo(map);
	}
	
	
	public Map<String, Object> updateClientCompanyInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = 0;
		Map<String,Object> organizationChart = clientManagementDAO.selectClientCompanyOrganizationChart(map); // 기존 조직도 사진 유무
		Map<String,Object> companyInfo = clientManagementDAO.selectClientCompanyInfo(map); // 기존 고객사 정보 
		
		map.put("filePK", map.get("hiddenModalPK"));
		
		cnt = clientManagementDAO.updateClientCompanyInfo(map);
		
		//it 정보 수정
		if(map.get("hiddenModalItInfoId") != null && !"".equals(map.get("hiddenModalItInfoId"))) {
			clientManagementDAO.updateClientCompanyITInfo(map);
		}else{
			clientManagementDAO.insertClientCompanyITInfo(map);
		}
		
		boolean fileCheck = false;
		if(map.get("browser").toString().equals("9.0")){
			fileCheck = !((MultipartHttpServletRequest) request).getFile("fileModalUploadPhoto").isEmpty(); //ie9버전 파일유무 체크
		}else{
			fileCheck = !((MultipartHttpServletRequest) request).getFiles("fileModalUploadPhoto").isEmpty(); //그외 파일유무 체크
		}
		
		if(fileCheck) { // 사진 업로드 유무
			if(organizationChart == null) { // 기존 사진이 없고 사진 업로드 ㅇ
				// 회사 유지 : 인서트
				clientManagementDAO.updateClientCompanyInfo(map);
				organizationChart = commonFileUtils.insertPhoto(map, request, "CLIENT_COMPANY_INFO_FILE_STORE","COMPANY_ID");
				commonDAO.insertFile(organizationChart);
				
				cnt = 1;
			}else { // 기존 사진이 있고 사진 업로드 ㅇ
				organizationChart.put("fileTableName", "CLIENT_COMPANY_INFO_FILE_STORE");
				organizationChart.put("fileColumnName", "COMPANY_ID");
				// 회사 유지 : 기존 사진 삭제 후 인서트
				clientManagementDAO.updateClientCompanyInfo(map);
				commonFileUtils.deletePhoto(organizationChart, request);
				commonDAO.deletePhoto(organizationChart);
				organizationChart = commonFileUtils.insertPhoto(map, request, "CLIENT_COMPANY_INFO_FILE_STORE","COMPANY_ID");
				commonDAO.insertFile(organizationChart);
				
				cnt = 2;
			}
			
		}else { 
			if(organizationChart == null) { // 기존 사진이 없고 사진 업로드 ㄴ
				// 회사 유지 : 개인정보만 수정 
				clientManagementDAO.updateClientCompanyInfo(map);
				
				cnt = 3;
			}else { // 기존 사진이 있고 업로드 ㄴ
				if(companyInfo.get("COMPANY_ID").toString().equals(map.get("hiddenModalCompanyId").toString())) {
					// 회사 유지 : 개인정보만 수정
					clientManagementDAO.updateClientCompanyInfo(map);
					
					cnt = 4;
				}else {
					// 회사 이동 : 기존 사진 이동
					clientManagementDAO.updateClientCompanyInfo(map);
					organizationChart =  commonFileUtils.movePhoto(organizationChart, map, request,  "CLIENT_COMPANY_INFO_FILE_STORE","COMPANY_ID");
					commonDAO.updateFile(organizationChart);
					
					cnt = 5;
				}
			}
			
		}
		
		/*log.debug("cnt"+cnt);
		
		map.put("filePK", map.get("hiddenModalPK"));
		map.put("filePKArray", map.get("hiddenModalPK"));
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request,"CLIENT_COMPANY_INFO_FILE_STORE","COMPANY_ID");
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}*/
		
		map.put("cnt", cnt);
		return map;
	}
	
	public Map<String, Object> insertClientCompanyInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		synchronized(map) {
			int cnt = 0;
			
			cnt = clientManagementDAO.insertClientCompanyInfo(map);
			//고객사등록한 직원에게 자동으로 테리토리권한 추가
			//테리토리 미사용 시 줄띄우기 전까지 주석처리
			//cnt += clientManagementDAO.insertSalesTerritoryAlignMap(map);
			
			//insert 고객사의  자사 전 직원  테리토리 권한 추가 : 태원 소스
			/*List<Map<String, Object>> memberList = clientManagementDAO.selectAllMemberIdNum();
			map.put("memberList", memberList);
			cnt += clientManagementDAO.insertSalesTerritoryAlignAllMap(map);*/
			
			//it 정보 추가
			clientManagementDAO.insertClientCompanyITInfo(map);
			
			boolean fileCheck = false;
			if(map.get("browser").toString().equals("9.0")){
				fileCheck = !((MultipartHttpServletRequest) request).getFile("fileModalUploadPhoto").isEmpty();
			}else{
				fileCheck = !((MultipartHttpServletRequest) request).getFiles("fileModalUploadPhoto").isEmpty();
			}
			
			if(fileCheck) { // 사진 업로드 유무
				Map<String,Object> organizationChart = commonFileUtils.insertPhoto(map, request, "CLIENT_COMPANY_INFO_FILE_STORE","COMPANY_ID");
				commonDAO.insertFile(organizationChart);
				cnt ++;
			}
			
			map.put("cnt", cnt);
			
			return map;
		}
	}
	
	/**
	 * @author  : 욱이
	 * @date : 2017. 2. 27.
	 * @explain : 고객사 정보 -> 프로젝트관리이력 insert
	 */
	public int insertClientCompanyProjectMg(Map<String, Object> map) throws Exception {
		int cnt = 0;
		cnt = clientManagementDAO.insertClientCompanyProjectMg(map);
		ArrayList<HashMap<String, Object>> gridProjectMgPerson = CommonUtils.jsonList((map.get("gridProjectMgPerson")).toString());
		for(HashMap<String,Object> gridProjectMgPersonMap : gridProjectMgPerson){
			gridProjectMgPersonMap.put("PROJECT_ID", map.get("filePK"));
			gridProjectMgPersonMap.put("CREATOR_ID", map.get("global_member_id"));
			cnt = clientManagementDAO.insertClientCompanyProjectMgPerson(gridProjectMgPersonMap);
		}
		return cnt;
	}
	
	/**
	 * @author  : 욱이
	 * @date : 2017. 2. 27.
	 * @explain : 고객사 정보 -> 프로젝트관리이력 update
	 */
	public int updateClientCompanyProjectMg(Map<String, Object> map) throws Exception {
		int cnt = 0;
		cnt = clientManagementDAO.updateClientCompanyProjectMg(map);
		ArrayList<HashMap<String, Object>> gridProjectMgPerson = CommonUtils.jsonList((map.get("gridProjectMgPerson")).toString());
		for(HashMap<String,Object> gridProjectMgPersonMap : gridProjectMgPerson){
			if(CommonUtils.isEmpty(gridProjectMgPersonMap.get("PROJECT_PERSON_ID"))){
				gridProjectMgPersonMap.put("PROJECT_ID", map.get("hiddenModalProjectMgPK"));
				gridProjectMgPersonMap.put("CREATOR_ID", map.get("global_member_id"));
				cnt = clientManagementDAO.insertClientCompanyProjectMgPerson(gridProjectMgPersonMap);
			}else{
				cnt = clientManagementDAO.updateClientCompanyProjectMgPerson(gridProjectMgPersonMap);
			}
		}
		return cnt;
	}
	
	/**
	 * @author  : 욱이
	 * @date : 2017. 2. 27.
	 * @explain : 고객사 정보 -> 프로젝트관리이력 상세보기
	 */
	public Map<String, Object> selectClientCompanyProjectMg(Map<String, Object> map) throws Exception {
		return clientManagementDAO.selectClientCompanyProjectMg(map);
	}
	
	/**
	 * @author  : 욱이
	 * @date : 2017. 2. 27.
	 * @explain : 고객사 정보 -> 프로젝트관리이력 상세보기 (프로젝트 인원)
	 */
	public List<Map<String, Object>> selectClientCompanyProjectMgPerson(Map<String, Object> map) throws Exception {
		return clientManagementDAO.selectClientCompanyProjectMgPerson(map);
	}
	
	public int deleteClientCompanyProject(Map<String, Object> map) throws Exception {
		int cnt = 0;
		
		clientManagementDAO.deleteClientCompanyProject(map);
		cnt++;
		
		List<Map<String, Object>> list = clientManagementDAO.selectClientCompanyProject(map);
		if(list.size() == 0){
			clientManagementDAO.deleteClientCompanySeqProject(map);
			cnt++;
		}
		
		return cnt;
	}
	
	/**
	 * @author  : 욱이
	 * @date : 2017. 3. 6.
	 * @explain : 고객사 정보 -> 프로젝트 관리이력 프로젝트 인원 삭제
	 */
	public int deleteClientCompanyProjectMgPerson(Map<String, Object> map) throws Exception{
		return clientManagementDAO.deleteClientCompanyProjectMgPerson(map);
	}
	
	public int updateClientCompanyFile(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = 0;
		
		map.put("filePK", map.get("hiddenModalPK"));
		map.put("filePKArray", map.get("hiddenModalPK"));
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request,"CLIENT_COMPANY_INFO_FILE_STORE","COMPANY_ID");
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}
		
		return cnt;
	}
	
	
	public List<Map<String, Object>> selectAllIndustrySegmentCode(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientManagementDAO.selectAllIndustrySegmentCode(map);
	}
	
	public List<Map<String, Object>> gridClientCompanyProjectList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientManagementDAO.gridClientCompanyProjectList(map);
	}
	
	
	
	//////////////////////////////////////////////////고객개인정보 View////////////////////////////////////////////
	
	public List<Map<String, Object>> gridClientIndividualDetail(Map<String, Object> map) throws Exception {
		return clientManagementDAO.gridClientIndividualDetail(map);
	}
	
	
	public List<Map<String, Object>> gridClientIndividualInfoList(Map<String, Object> map) throws Exception {
		
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
			list = clientManagementDAO.gridClientIndividualInfoList(map);
		}
		else  
		{	// serch : 2 -> 검색 버튼 클릭
			// 검색 내용 없이 검색 버튼 클릭하면, 다시 재로드 하기 위함. (pageStart, pageEnd 때문)
			if( "".equals(map.get("serchInfo")) || map.get("serchInfo") == null && (!"".equals(map.get("clientId")) && map.get("clientId") != null) )
			{
				list = clientManagementDAO.gridClientIndividualInfoList(map);
			}
			else 
			{
				list = clientManagementDAO.gridClientIndividualInfoList2(map);
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
		
//		return clientManagementDAO.gridClientIndividualInfoList(map);
		return list;
	}
	
	///////////////////////////////////////////////고객사정보 view/////////////////////////////////////////////////
	
	public Map<String, Object> clientCompanyInfoViewSearchDetailGroup(Map<String, Object> map) throws Exception {
		return clientManagementDAO.clientCompanyInfoViewSearchDetailGroup(map);
	}
	
	
	public List<Map<String, Object>> gridClientCompanyInfoView(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> list = null;
		
		if( "".equals(map.get("serchInfo")) || map.get("serchInfo") == null || (!"".equals(map.get("clientId")) && map.get("clientId") != null) )
		{
			list = clientManagementDAO.gridClientCompanyInfoView2(map);
		}
		else 
		{
			list = clientManagementDAO.gridClientCompanyInfoView(map);
		}
		
		return list;
	}
	
	
	public List<Map<String, Object>> gridClientCompanyInfoView2(Map<String, Object> map) throws Exception {
		return clientManagementDAO.gridClientCompanyInfoView2(map);
	}
	
	
	public List<Map<String, Object>> gridClientCompanyInfoView3(Map<String, Object> map) throws Exception {
		return clientManagementDAO.gridClientCompanyInfoView3(map);
	}
	
	
	public List<Map<String, Object>> gridCompanyClient(Map<String, Object> map) throws Exception {
		return clientManagementDAO.gridCompanyClient(map);
	}
	
	
	public List<Map<String, Object>> companyOrganizationChart(Map<String, Object> map) throws Exception {
		return clientManagementDAO.companyOrganizationChart(map);
	}
	
	
	public List<Map<String, Object>> gridCurrentOpportunity(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientManagementDAO.gridCurrentOpportunity(map);
	}
	
	public List<Map<String, Object>> gridServiceProject(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientManagementDAO.gridServiceProject(map);
	}
	
	
	public List<Map<String, Object>> selectClientCompanyFileList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientManagementDAO.selectClientCompanyFileList(map);
	}
	
	
	public List<Map<String, Object>> gridClientContactView(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientManagementDAO.gridClientContactView(map);
	}
	
	
	public List<Map<String, Object>> gridClientContactView2(Map<String, Object> map) throws Exception {

		String actionItem = "";
		List<Map<String, Object>> contact = clientManagementDAO.gridClientContactView2(map);
		
		for(int i=0; i<contact.size(); i++){
			
			actionItem = "";
		
			if("Y".equals(contact.get(i).get("CHECK_INFORMATION"))){
				actionItem += "정보	";
				
				if( "Y".equals(contact.get(i).get("CHECK_SALESOPP")) 
						|| "Y".equals(contact.get(i).get("CHECK_ISSUE")) ){
					actionItem += "/ ";
				}
			}
			
			if("Y".equals(contact.get(i).get("CHECK_SALESOPP"))){
				actionItem += "영업기회	";
				
				if("Y".equals(contact.get(i).get("CHECK_ISSUE"))){
					actionItem += "/ ";
				}
			}
			
			if("Y".equals(contact.get(i).get("CHECK_ISSUE"))){
				actionItem += "이슈	";
			}
			
			contact.get(i).put("actionItem", actionItem);
		}
		
//		return clientManagementDAO.gridClientContactView2(map);
		return contact;
	}
	
	
	public List<Map<String, Object>> selectClientIndividualHistoryList(Map<String, Object> map) throws Exception {
		return clientManagementDAO.selectClientIndividualHistoryList(map);
	}
	
	
	public List<Map<String, Object>> selectIndividualHistory(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		List<Map<String, Object>> list = clientManagementDAO.selectIndividualHistory(map);
		
		/*if(map.get("salesStatus") == null) {
			map.put("salesStatus", "2");
		}
		
		if(map.get("salesStatus").equals("1"))
		{
			for(int i=0; i<list.size(); i++){
				
				if(list.get(i).get("ROLE").equals("1")){
					list.get(i).put("ROLE", "정보제공자");
				}
				else if(list.get(i).get("ROLE").equals("2")){
					list.get(i).put("ROLE", "실무자");
				}
				else if(list.get(i).get("ROLE").equals("3")){
					list.get(i).put("ROLE", "의사결정자");
				}
				else if(list.get(i).get("ROLE").equals("4")){
					list.get(i).put("ROLE", "influencer");
				}
				
				if(list.get(i).get("POSITION").equals("1")){
					list.get(i).put("POSITION", "Pro");
				}
				else if(list.get(i).get("POSITION").equals("2")){
					list.get(i).put("POSITION", "Anti");
				}
			}
		}*/
		
//		return clientManagementDAO.gridSalesStatus(map);
		return list;
	}
	
	
	public List<Map<String, Object>> selectIndividualContactHistory(Map<String, Object> map) throws Exception {

		String actionItem = "";
		List<Map<String, Object>> contact = clientManagementDAO.selectIndividualContactHistory(map);
		
		for(int i=0; i<contact.size(); i++){
			
			actionItem = "";
		
			if("Y".equals(contact.get(i).get("CHECK_INFORMATION"))){
				actionItem += "정보	";
				
				if( "Y".equals(contact.get(i).get("CHECK_SALESOPP")) 
						|| "Y".equals(contact.get(i).get("CHECK_ISSUE")) ){
					actionItem += "/ ";
				}
			}
			
			if("Y".equals(contact.get(i).get("CHECK_SALESOPP"))){
				actionItem += "영업기회	";
				
				if("Y".equals(contact.get(i).get("CHECK_ISSUE"))){
					actionItem += "/ ";
				}
			}
			
			if("Y".equals(contact.get(i).get("CHECK_ISSUE"))){
				actionItem += "이슈	";
			}
			
			contact.get(i).put("actionItem", actionItem);
		}
		
//		return clientManagementDAO.gridClientContactView2(map);
		return contact;
	}
	
	
	public List<Map<String, Object>> searchIndividualHistory(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> contact = clientManagementDAO.searchIndividualHistory(map);
		return contact;
	}
	
	
	public List<Map<String, Object>> selectIndividualDetail(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> contact = clientManagementDAO.selectIndividualDetail(map);
		return contact;
	}
	
	
	public int insertIndividualHistory(Map<String, Object> map) throws Exception {
		int cnt = 0;
		
		ObjectMapper mapper = new ObjectMapper();
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>(); 
		String jsonData = (map.get("individualHistoryData")).toString();		 
		list = mapper.readValue(jsonData, new TypeReference<ArrayList<HashMap<String, String>>>() {});        
		
		//clientManagementDAO.updateIndividualHistory3(map);
		clientManagementDAO.deleteIndividualAllHistory(map);
		
		for(int i=0; i<list.size(); i++){
			
			list.get(i).put("customerId", map.get("customerId"));
			list.get(i).put("creatorId", map.get("creatorId"));
			
			int status = clientManagementDAO.insertIndividualHistory(list.get(i));
			
			if(status>0){
				clientManagementDAO.updateIndividualHistory2(list.get(i));
			}
			
			List<Map<String, Object>> beforeHistoryList = clientManagementDAO.selectBeforeIndividualHistory(list.get(i));
			for(int j=0; j<beforeHistoryList.size(); j++){
				
				beforeHistoryList.get(j).put("customerId", map.get("customerId"));
				beforeHistoryList.get(j).put("creatorId", map.get("creatorId"));
				
				clientManagementDAO.insertIndividualHistory(beforeHistoryList.get(j));
				cnt ++;
			}
			cnt ++;
		}
		return cnt;
	}
	
	
	public int deleteIndividualHistory(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientManagementDAO.deleteIndividualHistory(map);
	}
	
	public int updateClientIndividualUseYN(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientManagementDAO.updateClientIndividualUseYN(map);
	}

	public int selectRoleCheck(Map<String, Object> map) throws Exception {
		int cnt = 0; //0이면 권한없음, 1이면 권한있음
		
		if(map.get("global_role_code").toString().contains("ROLE_CEO")){
			cnt = 1;
		}else{
			List<Map<String, Object>> roleList = clientManagementDAO.selectRoleCheck(map);
			Map<String, Object> roleMap = null;
			
			String divisionNo = ""; 
			String divisionLeader = ""; 
			String teamNo = ""; 
			String teamLeader = ""; 
			String memberIdNum = "";
			String memberdivision = ""; 
			String memberteam = ""; 
			String memberId = ""; 
			
			for(int i=0; i<roleList.size(); i++){
				roleMap = roleList.get(i);
				
				if(roleMap.get("MEMBER_DIVISION") != null){
					divisionNo = roleMap.get("MEMBER_DIVISION").toString(); //해당 게시물의 영업대표 or 작성자 소속 본부id
				}
				if(roleMap.get("DIVISION_LEADER") != null){
					divisionLeader = roleMap.get("DIVISION_LEADER").toString(); //해당 게시물의 영업대표 or 작성자 소속 본부장id
				}
				if(roleMap.get("MEMBER_TEAM") != null){
					teamNo = roleMap.get("MEMBER_TEAM").toString(); //해당 게시물의 영업대표 or 작성자 소속 팀id
				}
				if(roleMap.get("TEAM_LEADER") != null){
					teamLeader = roleMap.get("TEAM_LEADER").toString(); //해당 게시물의 영업대표 or 작성자 소속 팀장id
				}
				if(roleMap.get("MEMBER_ID_NUM") != null){
					memberIdNum = roleMap.get("MEMBER_ID_NUM").toString(); //해당 게시물의 영업대표 or 작성자id
				}
				if(map.get("global_member_division") != null){
					memberdivision = map.get("global_member_division").toString(); //사용자 본부id
				}
				if(map.get("global_member_team") != null){
					memberteam = map.get("global_member_team").toString(); //사용자 팀id
				}
				if(map.get("global_member_id") != null){
					memberId = map.get("global_member_id").toString(); //사용자id
				}
				
			/*if(memberIdNum.equals(memberId)){ //사용자가 작성자와 같으면
			cnt = 1;
		}else*/ if(divisionNo.equals(memberdivision)){ //사용자가 작성자와 같은 부서면
					//if(divisionLeader.equals(memberId)){ //사용자가 작성자의 부서장이면 --> 리더컬럼 미사용..
					if(map.get("global_role_code").toString().contains("ROLE_DIVISION")){
						cnt = 1;
					//}else if(teamLeader.equals(memberId)){ //사용자가 작성자의 팀장이면
						//cnt = 1;
					}else if(teamNo.equals(memberteam)){ //사용자가 작성자와 같은 팀이면
						cnt = 1;
					}
				}else if(teamNo.equals(memberteam)){ //사용자가 작성자와 같은 팀이면
					//if(teamLeader.equals(memberId)){ //사용자가 작성자의 팀장이면
						cnt = 1;
					//}
				}
				
				if(cnt == 1){
					i = roleList.size();
				}
				
			}
			
			
		}
		
		return cnt;
	}
	
	//////////////////////////////////////// 디유넷 소스 병합 시 추가된 서비스 Start //////////////////////////////////////////////
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객사 게이트 -> 고개 호감도 현황(개인)
	 */
	public  List<HashMap<String, Object>> clientLikeabilityIndividualCnt(Map<String, Object> map) throws Exception {
		return clientManagementDAO.clientLikeabilityIndividualCnt(map);
	}
	
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객사 게이트 -> 고개 호감도 현황
	 */
	public  List<HashMap<String, Object>> clientLikeabilityCnt(Map<String, Object> map) throws Exception {
		return clientManagementDAO.clientLikeabilityCnt(map);
	}
	
	/**
	 * @explain : 모바일 고객사 및  고객개인정보-> 고객개인 게이트 -> 팀이름 셀렉트박스 옵션
	 */
	public  List<HashMap<String, Object>> selectTeamNameList(Map<String, Object> map) throws Exception {
		return clientManagementDAO.selectTeamNameList(map);
	}
	
	/**
	 * @explain : 모바일 고객개인 전체 게이트  : 나의 전체 고객
	 * 최영완20200122
	 */
	public int totalClientIndividualCnt(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		int cnt = 0;
		cnt = clientManagementDAO.totalClientIndividualCnt(map);
		
		return cnt;
		//return clientManagementDAO.totalClientIndividualCnt(map);
	}
	
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객개인정보 게이트 -> 팀정보
	 */
	public Map<String, Object> teamInfo(Map<String, Object> map) throws Exception {
		return clientManagementDAO.teamInfo(map);
	}
	
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객개인정보 게이트 -> selectbox option (CEO, TEAM, MEMBER)
	 */
	public List<HashMap<String, Object>> lineGraphSelectOption(Map<String, Object> map) throws Exception {
		return clientManagementDAO.lineGraphSelectOption(map);
	}
	
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객개인정보 게이트 -> 고객관계수립 그래프 데이터 (CEO, TEAM, MEMBER)
	 */
	public List<HashMap<String, Object>> relationCEOStatus(Map<String, Object> map) throws Exception {
		String memberCheck = (String)map.get("global_role_code");
		if(memberCheck.contains("ROLE_MEMBER")){
			map.put("memberCheck","Y");
		}else{
			map.put("memberCheck","N");
		}
		
		return clientManagementDAO.relationCEOStatus(map); //relationStatus(map);
	}
	
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객개인 게이트 -> 고객개인 전체 게이트  : 금주 신규 고객
	 * 최영완20200122
	 */
	public int clientIndividualNewCnt(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		int cnt = 0;
		cnt = clientManagementDAO.clientIndividualNewCnt(map);
		
		return cnt;
		//return clientManagementDAO.clientIndividualNewCnt(map);
	}
	
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객개인정보 게이트 -> 고객관계수립 추이 그래프(꺾은선) 데이터 (CEO, TEAM, MEMBER)
	 */
	public List<HashMap<String, Object>> lineGraphData(Map<String, Object> map) throws Exception {
		return clientManagementDAO.lineGraphData(map); //relationStatus(map);
	}
	
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객사 게이트 -> 주요 고객개인 리스트 top 10 리스트
	 */
	public List<HashMap<String, Object>> selectIndividualTopList(Map<String, Object> map) throws Exception {
		return clientManagementDAO.selectIndividualTopList(map); //relationStatus(map);
	}
	
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객사 게이트 -> 주요 신규고객개인 리스트
	 */
	public List<HashMap<String, Object>> selectIndividualTopNewList(Map<String, Object> map) throws Exception {
		return clientManagementDAO.selectIndividualTopNewList(map); //relationStatus(map);
	}
	
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객개인정보 게이트 -> 고객관계수립
	 */
	public Map<String, Object> quarterRelationStatus(Map<String, Object> map) throws Exception {
		return clientManagementDAO.quarterRelationStatus(map); //relationStatus(map);
	}
	
	/**
	 * @explain : 모바일 고객사 및 고객개인정보 -> 고객개인정보 게이트 -> 고객관계수립
	 */
	public List<HashMap<String, Object>> quarterRelationStatus2(Map<String, Object> map) throws Exception {
		return clientManagementDAO.quarterRelationStatus2(map); //relationStatus(map);
	}
	
	/**
	 * @explain : 모바일 고객사 및  고객개인정보-> 고객개인 게이트 -> 리스트 카운트
	 */
	public Map<String, Object> selectClientIndividualInfoMConut(Map<String, Object> map) throws Exception{
		return clientManagementDAO.selectClientIndividualInfoMConut(map);
	}
	
	
	// 	고객개인 전체 게이트  : 금주 신규 고객
	//최영완20200121
	public int clientCompanyNewCnt(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		int cnt = 0;
		cnt = clientManagementDAO.clientCompanyNewCnt(map);
		return cnt;
	}
	
	// 고객사 전체 게이트  : 나의 전체 고객
	public int totalClientCompanyCnt(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		int cnt = 0;
		cnt = clientManagementDAO.totalClientCompanyCnt(map);
		return cnt;
	}
	
	/**
	 * @author  : 최영완
	 * @date : 2020. 01. 21.
	 * @explain : 고객사 및  고객개인정보-> 고객사 게이트 -> 잠재고객수
	 */
	public int totalClientHiddenCompanyCnt(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		int cnt = 0;
		cnt = clientManagementDAO.clientHiddenCompanyCount(map); 
		return cnt;
	}
	
	public List<HashMap<String, Object>> lineGraphData3(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientManagementDAO.lineGraphData3(map); //relationStatus(map);
	}
	
	/**
	 * @author  : 최영완
	 * @date : 2020. 01. 21.
	 * @explain : 고객사 및 고객개인정보 -> 고객사 게이트 -> 주요 신규고객개인 리스트
	 */
	public List<HashMap<String, Object>> selectCompanyTopNewList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientManagementDAO.selectCompanyTopNewList(map); //relationStatus(map);
	}
	
	/**
	 * @author  : 최영완
	 * @date : 2020. 01. 21.
	 * @explain : 고객사 및 고객개인정보 -> 고객사 게이트 -> 최근 1주간 영업활동
	 */
	public  List<HashMap<String, Object>> clientWeekContact(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		return clientManagementDAO.clientWeekContact(map);
	}
	
	public List<HashMap<String, Object>> oppTableDate(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientManagementDAO.oppTableDate(map); //relationStatus(map);
	}
	
	public List<HashMap<String, Object>> oppGraphData(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientManagementDAO.oppGraphData(map); //relationStatus(map);
	}
	
	// 고객개인 전체 게이트  : 영업대표  영업현황
	public List<HashMap<String, Object>> clientOppCnt(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return clientManagementDAO.clientOppCnt(map); //relationStatus(map);
	}
	
	/**
	 * @author  : 최영완
	 * @date : 2020. 01. 29.
	 * @explain : 고객사 및  고객개인정보-> 고객사 게이트 -> 리스트 카운트
	 */
	public Map<String, Object> selectClientCompanyCount(Map<String, Object> map) throws Exception{
		return clientManagementDAO.selectClientCompanyCount(map);
	}
	//////////////////////////////////////// 디유넷 소스 병합 시 추가된 서비스 End //////////////////////////////////////////////
}