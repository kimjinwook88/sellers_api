package com.uni.sellers.salesmanagement;

import java.math.BigDecimal;
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
import com.uni.sellers.util.CommonFileUtils;

@Service("salesManagementService")
public class SalesManagementService{
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="commonFileUtils")
	private CommonFileUtils commonFileUtils;
	
	@Resource(name="salesManagementDAO")
	private SalesManagementDAO salesManagementDAO;
	
	@Resource(name="commonDAO")
	private CommonDAO commonDAO;

	//제안관리
	
	public int updateProposalsInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		int cnt = salesManagementDAO.updateProposalsInfo(map);
		map.put("filePK", map.get("hiddenModalPK"));
		map.put("filePKArray", map.get("hiddenModalPK"));
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request, "PROPOSAL_FILE_STORE","PROPOSAL_ID");
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}
		return cnt;
	}

	
	public int insertProposalsInfo(Map<String, Object> map, HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		int cnt = salesManagementDAO.insertProposalsInfo(map);
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request, "PROPOSAL_FILE_STORE","PROPOSAL_ID");
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}
		return cnt;
	}

	
	
	public List<Map<String, Object>> selectProposalsInfotList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return salesManagementDAO.selectProposalsInfotList(map);
	}
	
	
	public Map<String, Object> selectProposalsInfoDetail(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return salesManagementDAO.selectProposalsInfoDetail(map);
	}

	public List<Map<String, Object>> selectProposalsInfoFileList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return salesManagementDAO.selectProposalsInfoFileList(map);
	}
	
	
	public Map<String, Object> suggestSearchDetailGroup(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return salesManagementDAO.suggestSearchDetailGroup(map);
	} 

	
	
	
	
	//성과관리
	
	public List<Map<String, Object>> selectResultDashBoardDivision(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return salesManagementDAO.selectResultDashBoardDivision(map);
	}
	
	public List<Map<String, Object>> selectResultDashBoardTeam(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return salesManagementDAO.selectResultDashBoardTeam(map);
	}
	
	public List<Map<String, Object>> selectResultDashBoardMember(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return salesManagementDAO.selectResultDashBoardMember(map);
	}
	
	public List<Map<String, Object>> selectResultDashBoardCompany(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return salesManagementDAO.selectResultDashBoardCompany(map);
	}
	
	public List<Map<String, Object>> selectResultDashBoardCompanyGroup(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return salesManagementDAO.selectResultDashBoardCompanyGroup(map);
	}

	
	
	//productivity
	public List<Map<String, Object>> gridFaceTime(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> list = null;
		List<Map<String, Object>> companyAvgList = null;
		//그리드 표 
		if(map.get("gridTabFlag") != null)
		{
			list = salesManagementDAO.gridFaceTime(map);
			for(int i=0; i<list.size(); i++)
			{
				
				if(list.get(i).get("THIS_BASIS_TIME") != null)
				{
					int thisBasisTime = Integer.parseInt(list.get(i).get("THIS_BASIS_TIME").toString());
					int dayCount = thisBasisTime / 8;
					list.get(i).put("dayCount", dayCount+"일");
					
					/*
					if(map.get("roleChildDivision") != null && map.get("skipAvgTab") != null)
					{
						if(i == list.size()-1){
								list.get(i).put("DIVISION_NAME", "본부평균");
								list.get(i).put("TEAM_NAME", "본부평균");
								list.get(i).put("HAN_NAME", "본부평균");
						}
					}
					
					else if (map.get("roleChildTeam") != null && map.get("skipAvgTab") != null){
						if(i == list.size()-1)
						{
							list.get(i).put("DIVISION_NAME", "팀평균");
							list.get(i).put("TEAM_NAME", "팀평균");
							list.get(i).put("HAN_NAME", "팀평균");
						}
					}
					else{
					}
					 */
				}
			}
			/* test
			for(int i=0; i<list.size(); i++)
			{
				if(list.get(i).get("TEAM_NAME") == null)
				{
					list.remove(i);
					i--;
				}else if(list.get(i).get("HAN_NAME")==null)
				{
					list.remove(i);
					i--;
				}
			}
			*/
		}
		
		//회사 전체 평균 list에 담기/**
		/**
		 * [회사평균] list에 담기
		 * CEO 권한에서 첫 페이지(회사전체) 볼 때만 타지 않게 하고, 그 외(CEO권한_본부별_팀별, 본부장권한_본부별_팀별, 팀장권한_팀별)은 list에 [회사전체] 데이터를 list에 담아준다.
		 */
		//if(map.containsValue("ROLE_CEO"))
		/*
		if(map.get("skipAvgTab") != null)
		{  //그리드 탭 명칭 불러올때 타지 않게하기 위해. stipAvgTab
			companyAvgList = salesManagementDAO.companyAvgMap(map);
			int cs = companyAvgList.size()-1;
			for(int i=0; i<companyAvgList.size(); i++){
				
				if(cs == i){
					
					companyAvgList.get(i).put("DIVISION_NAME", "회사평균");
					companyAvgList.get(i).put("TEAM_NAME", "회사평균");
					companyAvgList.get(i).put("HAN_NAME", "회사평균");
					
					list.add(companyAvgList.get(i));
				}
			}
		}
		*/
		return list;
//		return salesManagementDAO.gridFaceTime(map);
	}
	

	
	
	public Map<String, Object> faceTimeSearchDetailGroup(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return salesManagementDAO.faceTimeSearchDetailGroup(map);
	}
	
	
	
	/*//고객컨택
	
	public List<Map<String, Object>> gridClientContact(Map<String, Object> map) throws Exception {
		return salesActiveDAO.gridClientContact(map);
	}

	
	public Map<String, Object> clientContactSearchDetailGroup(Map<String, Object> map) throws Exception {
		return salesActiveDAO.clientContactSearchDetailGroup(map);
	}

	
	public List<Map<String, Object>> clientContactFileList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return salesActiveDAO.clientContactFileList(map);
	}

	
	public int insertClientContact(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = salesActiveDAO.insertClientContact(map);
		//map, request, 파일테이블명, Foreign Key
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request, "CLIENT_EVENT_FILE_STORE","EVENT_ID");
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}
		return cnt;
	}
	
	
	public int updateClientContact(Map<String, Object> map, HttpServletRequest request) throws Exception {
		int cnt = salesActiveDAO.updateClientContact(map);
		map.put("filePK", map.get("hiddenModalPK"));
		map.put("filePKArray", map.get("hiddenModalPK"));
		List<Map<String,Object>> list = commonFileUtils.insertFile(map, request,"CLIENT_EVENT_FILE_STORE","EVENT_ID");
		for(int i=0, size=list.size(); i < size; i++){
			commonDAO.insertFile(list.get(i));
			cnt ++;
		}
		return cnt;
	}

	
	public int deleteClientContact(Map<String, Object> map, HttpServletRequest request) throws Exception {
		map.put("filePK", map.get("hiddenModalPK"));
		map.put("filePKArray", map.get("hiddenModalPK"));
		
		List<Map<String, Object>> fileList = salesActiveDAO.clientContactFileList(map);
		int cnt = salesActiveDAO.deleteClientContact(map);		
		commonFileUtils.deleteFileAll(fileList,request);
		return cnt;
	}*/
	
	
	
	
	
	//Anal_individual_time 데이터 입력문
	
	public int insertTestData(Map<String, Object> map) throws Exception {
		
		int cnt =0;
		int count =0;
		List<Map<String, Object>> listTestUser = salesManagementDAO.listTestUser(map);

//		map.put("ANAL_DATE", "2016-09-");
//		map.put("ANAL_DATE", "2016-10-04");
//		map.put("ANAL_DATE", "2016-10-05");
//		map.put("ANAL_DATE", "2016-10-06");
		map.put("ANAL_DATE", "2017-01-02");
		map.put("ANAL_BASIS_TIME", "8");
		map.put("ACTIVITY_CODE_1_TIME", "2");
		map.put("ACTIVITY_CODE_2_TIME", "2");
		map.put("ACTIVITY_CODE_3_TIME", "1");
		map.put("ACTIVITY_CODE_4_TIME", "1");
		map.put("ACTIVITY_CODE_5_TIME", "1");
		map.put("ACTIVITY_CODE_6_TIME", "1");
		map.put("ACTIVITY_CODE_7_TIME", "0");
		
		for(int i=0; i<listTestUser.size(); i++){
			count++;
			map.put("MEMBER_ID_NUM", listTestUser.get(i).get("MEMBER_ID_NUM"));
			/*
			for(int j=1; j<32; j++){
				map.put("ANAL_DATE", "2016-11-"+j);
				cnt = salesManagementDAO.insertTestData(map);
			}
			*/
			cnt = salesManagementDAO.insertTestData(map);
		}
		
		
		return count;
	}
	
	//////////////////////////////////////// 주간보고 start ////////////////////////////////////////////////
	/**
	 * @author : 최현경
	 * @Date : 2018. 10. 24.
	 * @explain : 성과관리 -> 주간보고 (전체부서 데이터 조회)
	 */
	public List<Map<String, Object>> selectDivisionList(Map<String, Object> map) throws Exception {
		return salesManagementDAO.selectDivisionList(map);
	}

	/**
	 * @author : 최현경
	 * @Date : 2018. 10. 24.
	 * @explain : 성과관리 -> 주간보고 (년도별 그리드 데이터 가공)
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectWeeklyReportYear(Map<String, Object> map) throws Exception {

		HashMap<String, Object> groupMap = salesManagementDAO.selectWeeklyReportYear(map);

		Map<String, Object> yearTarget = (Map<String, Object>) groupMap.get("yearTarget");
		Map<String, Object> quarterTarget = (Map<String, Object>) groupMap.get("quarterTarget");
		Map<String, Object> siReport = (Map<String, Object>) groupMap.get("siReport");
		Map<String, Object> maReport = (Map<String, Object>) groupMap.get("maReport");
		Map<String, Object> etcReport = (Map<String, Object>) groupMap.get("etcReport");

		Map<String, Object> weeklyReportHashMap = new HashMap<String, Object>();
		List<Map<String, Object>> weeklyReportList = new ArrayList<Map<String, Object>>();

		// 누적 분기 현황
		BigDecimal totalRev = new BigDecimal("0");
		BigDecimal totalGp = new BigDecimal("0");
		BigDecimal totalTcv = new BigDecimal("0");
		BigDecimal totalQTargetRev = new BigDecimal("0");
		BigDecimal totalQTargetGp = new BigDecimal("0");

		// 분기 순서대로 리스트에 담기
		for (int i = 1; i < 5; i++) {
			Map<String, Object> qMap = new HashMap<String, Object>();

			String Q_TCV = i + "Q_TCV";
			String Q_REV = i + "Q_REV";
			String Q_GP = i + "Q_GP";
			
			BigDecimal siTcv = ((BigDecimal) siReport.get(Q_TCV));
			BigDecimal siRev = ((BigDecimal) siReport.get(Q_REV));
			BigDecimal siGp = ((BigDecimal) siReport.get(Q_GP));
			BigDecimal maTcv = ((BigDecimal) maReport.get(Q_TCV));
			BigDecimal maRev = ((BigDecimal) maReport.get(Q_REV));
			BigDecimal maGp = ((BigDecimal) maReport.get(Q_GP));
			BigDecimal etcTcv = ((BigDecimal) etcReport.get(Q_TCV));
			BigDecimal etcRev = ((BigDecimal) etcReport.get(Q_REV));
			BigDecimal etcGp = ((BigDecimal) etcReport.get(Q_GP));

			// TCV 누적값
			BigDecimal sumTcv = new BigDecimal("0");
			sumTcv = sumTcv.add(siTcv);
			sumTcv = sumTcv.add(maTcv);
			sumTcv = sumTcv.add(etcTcv);
			totalTcv = totalTcv.add(sumTcv);
			// int sumTcv = siTcv + maTcv + etcTcv;
			// totalTcv += sumTcv;

			// REV 누적값
			BigDecimal sumRev = new BigDecimal("0");
			sumRev = sumRev.add(siRev);
			sumRev = sumRev.add(maRev);
			sumRev = sumRev.add(etcRev);
			totalRev = totalRev.add(sumRev);
			// int sumRev = siRev + maRev + etcRev;
			// totalRev += sumRev;

			// GP 누적값
			BigDecimal sumGp = new BigDecimal("0");
			sumGp = sumGp.add(siGp);
			sumGp = sumGp.add(maGp);
			sumGp = sumGp.add(etcGp);
			totalGp = totalGp.add(sumGp);
			// int sumGp = siGp + maGp + etcGp;
			// totalGp += sumGp;

			qMap.put("TCV_SI", siTcv);
			qMap.put("REV_SI", siRev);
			qMap.put("GP_SI", siGp);
			qMap.put("TCV_MA", maTcv);
			qMap.put("REV_MA", maRev);
			qMap.put("GP_MA", maGp);
			qMap.put("TCV_ETC", etcTcv);
			qMap.put("REV_ETC", etcRev);
			qMap.put("GP_ETC", etcGp);

			qMap.put("SUM_TCV", sumTcv);
			qMap.put("SUM_REV", sumRev);
			qMap.put("SUM_GP", sumGp);

			// 1년목표 대비 달성율 계산 (누적값으로 계산)
			qMap.put("ACHIEVE_REV_Y", this.divide(totalRev, (BigDecimal) yearTarget.get("TARGET_REV")));
			qMap.put("ACHIEVE_GP_Y", this.divide(totalGp, (BigDecimal) yearTarget.get("TARGET_GP")));

			// 분기목표
			BigDecimal qTargetRev = new BigDecimal("0");
			BigDecimal qTargetGp = new BigDecimal("0");
			
			String Q_TARGET_REV = i + "Q_TARGET_REV";
			String Q_TARGET_GP = i + "Q_TARGET_GP";
			
			qTargetRev = (BigDecimal) quarterTarget.get(Q_TARGET_REV);
			qTargetGp = (BigDecimal) quarterTarget.get(Q_TARGET_GP);

			qMap.put("TARGET_REV_Q", qTargetRev);
			qMap.put("TARGET_GP_Q", qTargetGp);		
			
			// 분기목표 누적값
			totalQTargetRev = totalQTargetRev.add(qTargetRev);
			totalQTargetGp = totalQTargetGp.add(qTargetGp);
			
			// 분기 달성율
			// 각 항목 합 / 분기목표
			qMap.put("ACHIEVE_REV_Q", this.divide(sumRev, qTargetRev));
			qMap.put("ACHIEVE_GP_Q", this.divide(sumGp, qTargetGp));

			weeklyReportList.add(qMap);
		}

		weeklyReportHashMap.put("weeklyReportYear", weeklyReportList);

		// 합계 리스트
		Map<String, Object> totalMap = new HashMap<String, Object>();
		totalMap.put("TOTAL_TCV", totalTcv);
		totalMap.put("TOTAL_REV", totalRev);
		totalMap.put("TOTAL_GP", totalGp);
		totalMap.put("TOTAL_TARGET_REV_Q", totalQTargetRev);
		totalMap.put("TOTAL_TARGET_GP_Q", totalQTargetGp);
		totalMap.put("TOTAL_ACHIEVE_REV_Q", this.divide(totalRev, totalQTargetRev));
		totalMap.put("TOTAL_ACHIEVE_GP_Q", this.divide(totalGp, totalQTargetGp));

		weeklyReportHashMap.put("weeklyReportTotalYear", totalMap);

		return weeklyReportHashMap;
	}

	public BigDecimal divide(BigDecimal a, BigDecimal b) {

		BigDecimal result = new BigDecimal("0");

		try {
			result = a.divide(b, 4, BigDecimal.ROUND_DOWN);
			return result;
		} catch (ArithmeticException e) {
			return result;
		}
	}

	/**
	 * @author : 최현경
	 * @Date : 2018. 10. 24.
	 * @explain : 성과관리 -> 주간보고 (년도별 그리드 데이터 가공)
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectWeeklyReportQuarter(Map<String, Object> map) throws Exception {
		return salesManagementDAO.selectWeeklyReportQuarter(map);
	}
}
