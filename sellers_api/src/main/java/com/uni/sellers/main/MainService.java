package com.uni.sellers.main;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.uni.sellers.calendar.CalendarService;
import com.uni.sellers.common.CommonDAO;
import com.uni.sellers.restful.RestfulDAO;
import com.uni.sellers.util.CommonFileUtils;
import com.uni.sellers.util.CommonUtils;

@Service("mainService")
public class MainService{
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name="commonFileUtils")
	private CommonFileUtils commonFileUtils;

	@Resource(name="mainDAO")
	private MainDAO mainDAO;

	@Resource(name="restfulDAO")
	private RestfulDAO restfulDAO;
	
	@Resource(name="commonDAO")
	private CommonDAO commonDAO;
	
	@Resource(name="CalendarService")
	private CalendarService calendarService;
	
	/**
	 * 모바일버전 메인 세팅
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMainSetUp(Map<String, Object> map) throws Exception {
		return mainDAO.selectMainSetUp(map);
	}
	
	/**
	 * 모바일 랜딩페이지 -> 실적현황 그래프 (누적) selextBox option (TEAM)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectResultGraphOptionTeam(Map<String, Object> map) throws Exception {
		return mainDAO.selectResultGraphOptionTeam(map);
	}
	
	/**
	 * 모바일 랜딩페이지 -> 실적현황 그래프 (누적) selextBox option (MEMBER)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectResultGraphOptionMember(Map<String, Object> map) throws Exception {
		return mainDAO.selectResultGraphOptionMember(map);
	}

	/**
	 * 모바일 랜딩페이지(셀러) -> 영업기회 그래프 DATA
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectOpportunityGraphData(Map<String, Object> map) throws Exception {
		return mainDAO.selectOpportunityGraphData(map);
	}
	
	public List<Map<String, Object>> selectTimeLine(Map<String, Object> map) throws Exception {
		//나의 캘린더 일정 조회
		List<Map<String, Object>> list = mainDAO.selectTimeLine(map);
		
		//office365 캘린더 일정 조회
		List<Map<String, Object>> office365CalendarList = new ArrayList<Map<String, Object>>();
		Map<String, Object> office365CalendarMap = null;
		SimpleDateFormat dateFormatter1 = new SimpleDateFormat("HH:mm");
		SimpleDateFormat dateFormatter2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		SimpleDateFormat dateFormatter3 = new SimpleDateFormat("yyyy-MM-dd");
		
		String searchDate = map.get("searchDate").toString();
		Date date = dateFormatter3.parse(searchDate);
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, 1);
		
		map.put("hiddenModalCreatorId", map.get("global_member_id"));
		map.put("selectYear", searchDate.substring(0,4));
		map.put("selectMonth", searchDate.substring(5,7));
		map.put("textSearchStartDate", searchDate);
		map.put("textSearchEndDate", dateFormatter3.format(cal.getTime()));
		office365CalendarList = calendarService.office365Calendar(map);
		for(int i=0; i < office365CalendarList.size(); i++){
			office365CalendarMap = new HashMap<String, Object>();
			
			if((office365CalendarList.get(i).get("errStatus") != null && office365CalendarList.get(i).get("errStatus").equals("1"))){
				office365CalendarMap.put("EVENT_SUBJECT", office365CalendarList.get(i).get("SUMMARY"));
				office365CalendarMap.put("START_DATETIME", dateFormatter1.format(office365CalendarList.get(i).get("DTSTART")));
				office365CalendarMap.put("START_DATE", dateFormatter2.format(office365CalendarList.get(i).get("DTSTART")));
				office365CalendarMap.put("END_DATE", dateFormatter2.format(office365CalendarList.get(i).get("DTEND")));
				office365CalendarMap.put("EVENT_DETAIL", office365CalendarList.get(i).get("DESCRIPTION"));
				office365CalendarMap.put("LOCATION", office365CalendarList.get(i).get("LOCATION"));
				office365CalendarMap.put("EVENT_CODE", "10");
				
				list.add(office365CalendarMap);
			}else{
				log.debug("office365Calendar select Fail");
				log.debug(office365CalendarList.get(i).get("errStatus").toString());
				if(office365CalendarList.get(i).get("errMsg") != null){
					log.debug(office365CalendarList.get(i).get("errMsg").toString());
				}
				
			}
		}
		
		//일정 시간순 정렬
		Collections.sort(list, new DateCompare());
		
		return list;
	}

	public List<Map<String, Object>> selectSalesAct(Map<String, Object> map) throws Exception {
		return mainDAO.selectSalesAct(map);
	}
	
	public List<Map<String, Object>> selectSalesAct2(Map<String, Object> map) throws Exception {
		return mainDAO.selectSalesAct2(map);
	}

	public List<Map<String, Object>> selectHiddenSalesAct(Map<String, Object> map) throws Exception {
		return mainDAO.selectHiddenSalesAct(map);
	}
	
	public List<Map<String, Object>> selectClientIssue(Map<String, Object> map) throws Exception {
		return mainDAO.selectClientIssue(map);
	}
	
	public List<Map<String, Object>> selectNewUpdate(Map<String, Object> map) throws Exception {
		return mainDAO.selectNewUpdate(map);
	}
	
	public List<Map<String, Object>> selectTrackingList(Map<String, Object> map) throws Exception {
		return mainDAO.selectTrackingList(map);
	}

	public Map<String, Object> selectResult(Map<String, Object> map) throws Exception {
		return mainDAO.selectResult(map);
	}

	public Map<String, Object> selectCompanyResult(Map<String, Object> map) throws Exception {
		return mainDAO.selectCompanyResult(map);
	}

	public List<Map<String, Object>> selectResultGraph(Map<String, Object> map) throws Exception {
		return mainDAO.selectResultGraph(map);
	}

	public List<Map<String, Object>> selectMyCompanyList(Map<String, Object> map) throws Exception {
		return mainDAO.selectMyCompanyList(map);
	}

	public List<Map<String, Object>> selectContactList(Map<String, Object> map) throws Exception {
		return mainDAO.selectContactList(map);
	}
	
	public List<Map<String, Object>> selectMainModuleSetUp(Map<String, Object> map) throws Exception {
		
		List<String> global_role_list = new ArrayList<String>(); 
		String[] splitGrc = ((String)map.get("global_role_code")).split(",");
		for(String grc : splitGrc){
			grc = grc.replace("[", "");
			grc = grc.replace("]", "");
			grc = grc.trim();
			global_role_list.add(grc);
		}
		map.put("global_role_list", global_role_list);
		return mainDAO.selectMainModuleSetUp(map);
	}
	
	public List<Map<String, Object>> selectMainMenuSetUp(Map<String, Object> map) throws Exception {
		/*List<String> global_role_list = new ArrayList<String>(); 
		String[] splitGrc = ((String)map.get("global_role_code")).split(",");
		for(String grc : splitGrc){
			grc = grc.replace("[", "");
			grc = grc.replace("]", "");
			grc = grc.trim();
			global_role_list.add(grc);
		}
		map.put("global_role_list", global_role_list);*/
		return mainDAO.selectMainMenuSetUp(map);
	}
	
	public int insertMainModule(Map<String, Object> map) throws Exception {
		ArrayList<HashMap<String, Object>> mainMenuList = CommonUtils.jsonList((map.get("mainMenuList")).toString());
		map.put("mainMenuList", mainMenuList);
		return mainDAO.insertMainModule(map);
	}
	
	public int insertMainMenu(Map<String, Object> map) throws Exception {
		ArrayList<HashMap<String, Object>> mainMenuList = CommonUtils.jsonList((map.get("mainMenuList")).toString());
		map.put("mainMenuList", mainMenuList);
		return mainDAO.insertMainMenu(map);
	}
	
	public List<Map<String,Object>> selectNewCpnList(Map<String, Object> map) throws Exception {
		map.put("BY", "GROUP");
		int cnt = 0;
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String,Object> etcCpnMap = new HashMap<String, Object>();
		List<Map<String,Object>> selectNewCpnList = mainDAO.selectNewCstmList(map);
		
		if(selectNewCpnList.size() <= 3){
			list = selectNewCpnList;
		}else{ //고객사4개 이상(A사, B사, 그 외 고객사)
			list.add(selectNewCpnList.get(0));
			list.add(selectNewCpnList.get(1));
			
			for(int i=2; i < selectNewCpnList.size(); i++){
				cnt += Integer.parseInt(selectNewCpnList.get(i).get("COUNT").toString());
			}
			etcCpnMap.put("COMPANY_NAME", "기타 고객사");
			etcCpnMap.put("COUNT", cnt);
			etcCpnMap.put("TOTAL", Integer.parseInt(selectNewCpnList.get(0).get("COUNT").toString()) + Integer.parseInt(selectNewCpnList.get(1).get("COUNT").toString()) + cnt);
			
			list.add(etcCpnMap);
		}
		
		return list;
	}
	
	public List<Map<String,Object>> selectNewCstmList(Map<String, Object> map) throws Exception {
		List<Map<String,Object>> selectNewCstmList = new ArrayList<Map<String,Object>>();
		
		map.put("BY", "ORDER");
		selectNewCstmList = mainDAO.selectNewCstmList(map);
		
		return selectNewCstmList;
	}
	
	//일정 날짜비교하여 정렬
	public class DateCompare implements Comparator {
		public int compare(Object o1, Object o2){
			SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
			Map<String,Object> map1 = (Map<String, Object>) o1;
			Map<String,Object> map2 = (Map<String, Object>) o2;
			
			Date event1_start_time = null;
			Date event2_start_time = null;
			
			try {
				event1_start_time = formatTime.parse(map1.get("START_DATETIME").toString());
				event2_start_time = formatTime.parse(map2.get("START_DATETIME").toString());
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			int compare = event1_start_time.compareTo(event2_start_time);
			if(compare>0){
				log.debug("event1 > event2");
				return 1;
			}else if(compare<0){
				log.debug("event1 < event2");
				return -1;
			}else{
				log.debug("event1 = event2");
				return 0;
			}
		}
	}
	
	
	public List<Map<String,Object>> selectMemberMenu(Map<String, Object> map) throws Exception {
		return mainDAO.selectMemberMenu(map);
	}
	
	public List<Map<String,Object>> selectMemberMobileMenu(Map<String, Object> map) throws Exception {
		return mainDAO.selectMemberMobileMenu(map);
	}
	
	public int insertUserMobileLandingPageMenu(Map<String, Object> map) throws Exception {
		ArrayList<String> list = new ArrayList<String>();
		if(map.get("list") instanceof String){
			list.add((String) map.get("list"));
		}else{
			Collections.addAll(list, (String[]) map.get("list"));
		}
		map.put("list", list);
		
		return mainDAO.insertUserMobileLandingPageMenu(map);
	}
	
	
	public List<List<Map<String, Object>>> selectSalesActBubbleChart(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> list = mainDAO.selectSalesActBubbleChart(map);
		List<Map<String, Object>> monthList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> nullList = new ArrayList<Map<String, Object>>();
		List<List<Map<String, Object>>> returnList = new ArrayList<>();
		
		for(int i=0; i<list.size(); i++){
			monthList.add(list.get(i));
			if(returnList.size() == 0 && 1 < Integer.parseInt(list.get(i).get("CONTRACT_MONTH").toString())){
				returnList.add(nullList);
			}
			if(returnList.size() == 1 && 2 < Integer.parseInt(list.get(i).get("CONTRACT_MONTH").toString())){
				returnList.add(nullList);
			}
			if(returnList.size() == 2 && 3 < Integer.parseInt(list.get(i).get("CONTRACT_MONTH").toString())){
				returnList.add(nullList);
			}
			if(returnList.size() == 3 && 4 < Integer.parseInt(list.get(i).get("CONTRACT_MONTH").toString())){
				returnList.add(nullList);
			}
			if(returnList.size() == 4 && 5 < Integer.parseInt(list.get(i).get("CONTRACT_MONTH").toString())){
				returnList.add(nullList);
			}
			if(returnList.size() == 5 && 6 < Integer.parseInt(list.get(i).get("CONTRACT_MONTH").toString())){
				returnList.add(nullList);
			}
			if(returnList.size() == 6 && 7 < Integer.parseInt(list.get(i).get("CONTRACT_MONTH").toString())){
				returnList.add(nullList);
			}
			if(returnList.size() == 7 && 8 < Integer.parseInt(list.get(i).get("CONTRACT_MONTH").toString())){
				returnList.add(nullList);
			}
			if(returnList.size() == 8 && 9 < Integer.parseInt(list.get(i).get("CONTRACT_MONTH").toString())){
				returnList.add(nullList);
			}
			if(returnList.size() == 9 && 10 < Integer.parseInt(list.get(i).get("CONTRACT_MONTH").toString())){
				returnList.add(nullList);
			}
			if(returnList.size() == 10 && 11 < Integer.parseInt(list.get(i).get("CONTRACT_MONTH").toString())){
				returnList.add(nullList);
			}
			
			//마지막체크
			if(i+1 < list.size()){
				if(!list.get(i).get("CONTRACT_MONTH").equals(list.get(i+1).get("CONTRACT_MONTH"))){
					returnList.add(monthList);
					monthList = new ArrayList<Map<String, Object>>();
				}
			}else{
				returnList.add(monthList);
			}
		}
		
		return returnList;
	}
	
	
	/**
	 * 도넛 차트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> selectSalesActDonutChart(Map<String, Object> map1) throws Exception {
		
		Map<String, Object> map2 = new HashMap<String, Object>();
		
		// 권한에 따라 리스트 불러옴
		if(map1.get("global_role_code").toString().contains("ROLE_CEO")){ //ceo권한이면
			map2.put("selectList", mainDAO.selectSalesDivision(map1));
		}else if(map1.get("global_role_code").toString().contains("ROLE_DIVISION")){ //본부장 권한이면
			map2.put("selectList", mainDAO.selectSalesTeam(map1));
		}else{
		}
		
		// 년도/분기 별 구분
		if(map1.get("selectQuarter").equals("q")){
			map2.put("salesActList", mainDAO.selectSalesActDonutChart2(map1));
			map2.put("forecastList", mainDAO.selectForecastDonutChart(map1)); //REV,GP
			map2.put("forecastList2", mainDAO.selectForecastDonutChart2(map1)); //TCV, P.GP
		}else if(map1.get("selectQuarter").equals("y2y")){
			Map<String, Object> y2y = mainDAO.selectSalesActDonutChartY2Y(map1);
			Map<String, Object> y2y_last = mainDAO.selectSalesActDonutChartY2Y_last(map1);
			if(y2y == null){ // 0 처리
				y2y = new HashMap<String, Object>();
				y2y.put("TCV", 0);
				y2y.put("REV", 0);
				y2y.put("AGP", 0);
				y2y.put("PGP", 0);
			}
			if(y2y_last == null){ // 0 처리
				y2y_last = new HashMap<String, Object>();
				y2y_last.put("TCV", 0);
				y2y_last.put("REV", 0);
				y2y_last.put("AGP", 0);
				y2y_last.put("PGP", 0);
			}
			List<Map<String,Object>> y2yList = new ArrayList<Map<String, Object>>();
			y2yList.add(y2y);
			y2yList.add(y2y_last);
			map2.put("y2yList",y2yList);
		}else {
			map2.put("salesActList", mainDAO.selectSalesActDonutChart(map1));
			map2.put("forecastList", mainDAO.selectForecastDonutChart(map1)); //REV,GP
			map2.put("forecastList2", mainDAO.selectForecastDonutChart2(map1)); //TCV, P.GP
		}
		
		return map2;
	}
	
	public int insertUserMobileToken(Map<String, Object> map) throws Exception {
		//사용자 디바이스 키  업데이트 순으로 조회
		List<Map<String, Object>> list = restfulDAO.selectUserDeviceKey(map);
		String deviceKey = map.get("userDi").toString();
		int cnt = 0;
		boolean diCheck = false;
		
		for(int i=0; i<list.size(); i++){
			if(deviceKey.equals("123") || deviceKey.equals(list.get(i).get("DEVICE_KEY"))) {
				cnt = 1;
				diCheck = true;
			}
		}
		
		if(!diCheck){
			//사용자 디바이스키 3개 까지 관리
			if(list != null) {
				if(3 <= list.size() ) { //세개이상일 경우 제일 이전것 변경
					map.put("device_key_id", list.get(0).get("DEVICE_KEY_ID"));
					cnt = restfulDAO.updateUserDeviceKey(map);
				}else{ //2개 이하일 경우 추가
					cnt = restfulDAO.insertUserDeviceKey(map);
				}
			}else { //하나도없으면 추가
				cnt = restfulDAO.insertUserDeviceKey(map);
			}
		}
		
		return cnt;
	}
	
}
