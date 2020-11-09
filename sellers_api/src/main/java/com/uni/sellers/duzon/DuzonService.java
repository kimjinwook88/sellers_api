package com.uni.sellers.duzon;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.uni.sellers.admin.AdminDAO;
import com.uni.sellers.clientsalesactive.ClientSalesActiveDAO;
import com.uni.sellers.common.CommonMailService;
import com.uni.sellers.util.CommonDateUtils;
import com.uni.sellers.util.CommonFileUtils;

import groovy.transform.Synchronized;


@Service("duzonService")
public class DuzonService{
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="duzonDAO")
	private DuzonDAO duzonDAO;
	
	@Resource(name="clientSalesActiveDAO")
	private ClientSalesActiveDAO clientSalesActiveDAO;
	
	@Resource(name="commonMailService")
	private CommonMailService commonMailService;
	
	@Resource(name="adminDAO")
	private AdminDAO adminDAO;
	
	@Resource(name="commonFileUtils")
	private CommonFileUtils commonFileUtils;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	
	/**
	* @author 	: 욱이
	* @Date		: 2018. 03. 14.
	* @explain	: 사원명부
	*/
	public void selectOurMemberInfo(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> list = duzonDAO.selectOurMemberInfo(map);
		int cnt = duzonDAO.insertOurMemberInfo(list);
	}
	
	/**
	* @author 	: 봉준
	* @Date		: 2018. 04. 19.
	* @explain	: 사원명부2 - 부서,팀 설정 / 기본 권한 계정생성
	*/
	public void selectOurMemberInfo2(Map<String, Object> map) throws Exception {
		int cnt = duzonDAO.updateOurMemberInfoTeam(map); //팀 업데이트
		if(map == null){ map = new HashMap<String, Object>(); };
		map.put("default_user_pw", bcryptPasswordEncoder.encode("uni123"));//비밀번호 입력
		cnt = duzonDAO.insertOurMemberInfoLogin(map); 
		cnt = duzonDAO.insertOurMemberInfoAuth(map); //권한부여
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2018. 03. 16.
	 * @explain	: 부서
	 */
	public List<Map<String, Object>> selectOurDivisionInfo(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> list = duzonDAO.selectOurDivisionInfo(map);
		int cnt = duzonDAO.insertOurDivisionInfo(list);
		return list;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2018. 03. 16.
	 * @explain	: 부서2
	 */
	public void selectOurDivisionInfo2(Map<String, Object> map, List<Map<String, Object>> list) throws Exception {
		int cnt = duzonDAO.updateOurDivisionInfo(list); //사용하지 않는 부서 USE_YN = N 업데이트 
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2018. 03. 19.
	 * @explain	: 팀
	 */
	public List<Map<String, Object>> selectOurTeamInfo(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> list = duzonDAO.selectOurTeamInfo(map);
		int cnt = duzonDAO.insertOurTeamInfo(list);  
		return list;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2018. 03. 19.
	 * @explain	: 팀2
	 */
	public void selectOurTeamInfo2(Map<String, Object> map, List<Map<String, Object>> list) throws Exception {
		int cnt = duzonDAO.updateOurTeamInfoToDivision(list); //DVISION_NO 업데이트
		cnt = duzonDAO.updateOurTeamInfo(list); //사용하지 않는 팀 USE_YN = N 업데이트
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2018. 04. 03.
	 * @explain	: 사전손익 분석 연동 삭제
	 */
	public void deleteSfaPfls(Map<String, Object> map) throws Exception {
		int cnt = duzonDAO.deletefaPflsAll(null); //전체 삭제
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2018. 04. 03.
	 * @explain	: 사전손익 분석 연동
	 */
	public void selectSfaPfls(Map<String, Object> map) throws Exception {
		duzonDAO.deletefaPflsAll(null); 
		
		List<Map<String, Object>> listMaster = duzonDAO.selectSfaPflsMaster(map); //마스터
		int cnt = duzonDAO.insertSfaPflsMaster(listMaster);
		
		List<Map<String, Object>> listItem1 = duzonDAO.selectSfaPflsItem1(map); //매출품목
		cnt = duzonDAO.insertSfaPflsItem1(listItem1);
		
		List<Map<String, Object>> listItem2 = duzonDAO.selectSfaPflsItem2(map); //매입품목
		cnt = duzonDAO.insertSfaPflsItem2(listItem2);  
		
		List<Map<String, Object>> listBill = duzonDAO.selectSfaPflsBill(map); //수금계획
		cnt = duzonDAO.insertSfaPflsBill(listBill);
		
		List<Map<String, Object>> listPay = duzonDAO.selectSfaPflsPay(map); //지급계획
		cnt = duzonDAO.insertSfaPflsPay(listPay);
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2018. 04. 13.
	 * @explain	: 주간보고서 분석 연동
	 */
	public void selectDashBoardCheckList(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> selectDashBoardCheckList = duzonDAO.selectDashBoardCheckList(map);
		int cnt = duzonDAO.insertDashBoardCheckList(selectDashBoardCheckList);  
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2018. 04. 13.
	 * @explain	: 개인별달성현황 분석 연동
	 */
	public void selectErpSalesActual(Map<String, Object> map) throws Exception {
		//REV, GP
		List<Map<String, Object>> selectErpSalesActual = duzonDAO.selectErpSalesActual(map);
		int cnt = duzonDAO.insertErpSalesActual(selectErpSalesActual);
		
		//TCV는 수주관리에서 계산해서 Insert
		List<Map<String, Object>> selectErpSalesActualTcv = duzonDAO.selectErpSalesActualTcv(map);
		cnt = duzonDAO.updateErpSalesActualTcv(selectErpSalesActualTcv);
		
		//pgp는 따로 계산해서
		List<Map<String, Object>> selectErpSalesPgp = duzonDAO.selectErpSalesPgp(map);
		cnt = duzonDAO.updateErpSalesPgp(selectErpSalesPgp);
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2018. 04. 16.
	 * @explain	: 사전손익분석 -> 영업기회 업데이트
	 */
	public void updateOppToInst(Map<String, Object> map) throws Exception {
		int cnt = duzonDAO.updateOppToInst(map); //기본
		
		List<Map<String, Object>> salesProduct = duzonDAO.selectOppToSalesProduct(map); 
		if(salesProduct.size() > 0) cnt = duzonDAO.updateOppToSalesProduct(salesProduct); //매출품목
		
		List<Map<String, Object>> psProduct = duzonDAO.selectOppToPsProduct(map); 
		if(psProduct.size() > 0) cnt = duzonDAO.updateOppToPsProduct(psProduct); //매입품목
		
		List<Map<String, Object>> bill = duzonDAO.selectOppToBill(map); 
		if(bill.size() > 0) cnt = duzonDAO.updateOppToBill(bill); //수금계획
		
		//List<Map<String, Object>> pay = duzonDAO.selectOppToPay(map); 
		//if(pay.size() > 0) cnt = duzonDAO.updateOppToPay(pay); //지출계획
	}
	
	
	/**
	* @author 	: 봉준
	* @Date		: 2018. 03. 15.
	* @explain	: 신용평가현황 연동
	*/
	public void selectCreditRatingStatusInfo(Map<String, Object> map) throws Exception {
		int cnt = duzonDAO.insertCreditRatingStatusInfo(duzonDAO.selectCreditRatingStatusInfo(map));
	}
	
	/**
	* @author 	: 봉준
	* @Date		: 2018. 03. 16.
	* @explain	: 매출목표 연동
	*/
	public void selectSalesGoalInfo(Map<String, Object> map) throws Exception {
		int cnt = duzonDAO.insertSalesGoalInfo(duzonDAO.selectSalesGoalInfo(map));
	}
	
	/**
	* @author 	: 봉준
	* @Date		: 2018. 03. 21.
	* @explain	: 고객사 연동
	*/
	public void selectClientCompanyInfo(Map<String, Object> map) throws Exception {
		int cnt = duzonDAO.insertClientCompanyInfo(duzonDAO.selectClientCompanyInfo(map));
	}
	
	/**
	* @author 	: 봉준
	* @Date		: 2018. 06. 07.
	* @explain	: 휴폐업 고객사 고객개인정보 퇴사 처리
	*/
	public void updateCloseClientIndividualinfo(Map<String, Object> map) throws Exception {
		int cnt = duzonDAO.updateCloseClientIndividualinfo(map);
	}
	
	/**
	* @author 	: 봉준
	* @Date		: 2018. 03. 22.
	* @explain	: 거래처대표 연동
	*/
	public void selectClientSalesmanInfo(Map<String, Object> map) throws Exception {
		int cnt = duzonDAO.insertClientSalesmanInfo(duzonDAO.selectClientSalesmanInfo(map));
	}
	
	/**
	* @author 	: 봉준
	* @Date		: 2018. 03. 22.
	* @explain	: 품목정보 연동
	*/
	public void selectOurProductInfo(Map<String, Object> map) throws Exception {
		int cnt = duzonDAO.insertOurProductInfo(duzonDAO.selectOurProductInfo(map));
	}
	
	/**
	* @author 	: 봉준
	* @Date		: 2018. 03. 22.
	* @explain	: 공통코드 연동(프로젝트형태, 영업구분)
	*/
	public void selectComCode(Map<String, Object> map) throws Exception {
		int cnt  = 0;
		//프로젝트형태 코드 연동
		cnt += duzonDAO.insertProjectComCode(duzonDAO.selectProjectComCode(map));
		
		//영업구분 코드 연동
		cnt += duzonDAO.insertTPSOComCode(duzonDAO.selectTPSOComCode(map));
	}
	
	
	/**
	 * @author 	: 욱
	 * @Date		: 2018. 04. 18.
	 * @explain	: 더존 영업기회로 전환 1
	 */
	public void selectOppToErp(Map<String, Object> map) throws Exception {
		
		Map<String, Object> selectOpportunityDetail = clientSalesActiveDAO.selectOpportunityDetail(map);  //기본정보 연동
		List<Map<String,Object>> selectProductSalesList = clientSalesActiveDAO.selectOpportunityProductSalesList(map); //매출 품목
		List<Map<String,Object>> selectProductPsList = clientSalesActiveDAO.selectOpportunityProductPsList(map); //매입 품목
		
		map.put("selectOpportunityDetail", selectOpportunityDetail);
		map.put("selectProductSalesList", selectProductSalesList);
		map.put("selectProductPsList", selectProductPsList);
	}
	
	/**
	 * @author 	: 욱
	 * @Date		: 2018. 04. 18.
	 * @explain	: 더존 영업기회로 전환 2
	 */
	public void updateOppToErp(Map<String, Object> map) throws Exception {
		int cnt = 0;
		String msg = "";
		
		map.putAll((Map<String, Object>) map.get("selectOpportunityDetail")); //ERP_OPP_CD 겹처서 먼저 ~
		
		//더존 영업기회 코드 채번
		String erpOppCode = duzonDAO.selectErpOppCode(map);
		String erpOppActiveCode = duzonDAO.selectErpOppActiveCode(map);
		map.put("ERP_OPP_CD", erpOppCode);
		map.put("ERP_OPP_ACTIVE_CD", erpOppActiveCode);
		
		msg += duzonDAO.callErpOppMaster(map);
		
		for(Map<String,Object> salesMap : (List<Map<String,Object>>)map.get("selectProductSalesList")){
			salesMap.putAll(map);
			msg += duzonDAO.callErpOppProductSales(salesMap);
		}
		
		for(Map<String,Object> psMap : (List<Map<String,Object>>)map.get("selectProductPsList")){
			psMap.putAll(map);
			msg += duzonDAO.callErpOppProductPs(psMap);
		}
	}
	
	/**
	 * @author 	: 욱
	 * @Date		: 2018. 04. 18.
	 * @explain	: 더존 영업기회 연동
	 */
	public void selectErpSfaSoptyH(Map<String, Object> map) throws Exception {
		int cnt = 0;
		List<Map<String, Object>> selectErpSfaSoptyH = duzonDAO.selectErpSfaSoptyH(map); 
		if(selectErpSfaSoptyH.size() > 0)  cnt = duzonDAO.insertErpSfaSoptyH(selectErpSfaSoptyH);
	}
}
