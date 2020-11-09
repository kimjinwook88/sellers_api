package com.uni.sellers.common;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mobile.device.Device;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.uni.sellers.datasource.CommandMap;
import com.uni.sellers.security.CustomAuthenticationSuccessHandler;
import com.uni.sellers.util.CommonFileUtils;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@Api(value = "CommonController", description = "Common") // Controller에 대한 Swagger 설명
@Controller
public class CommonController {
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name="commonService")
	private CommonService commonService;

	@Resource(name="commonMailService")
	private CommonMailService commonMailService;

	@Resource(name="commonDAO")
	private CommonDAO commonDAO;

	@Resource(name="commonFileUtils")
	private CommonFileUtils commonFileUtils;

	@Resource(name="customAuthenticationSuccessHandler")
	private CustomAuthenticationSuccessHandler customAuthenticationSuccessHandler;
	
	@Value("#{config['url.mobileAppLogin']}")
	private String mobileAppLoginUrl;
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 5. 21.
	 * @explain	: 파일 다운로드 (DB 조회정보로 다운로드)
	 */
	@RequestMapping(value="/common/downloadFile.do")
	public void downloadFile(CommandMap commandMap,HttpServletResponse response, HttpServletRequest request) throws Exception{
		Map<String,Object> map = commonService.selectFileInfo(commandMap.getMap());

		String errMsg = commonFileUtils.downloadFile(map, response, request);
		if(errMsg =="-1"){
			response.sendRedirect("/common/fileDownFailMsg.do");
		}
	}

	@RequestMapping(value="/common/fileDownFailMsg.do")
	public ModelAndView fileDownFailMsg(CommandMap commandMap,HttpServletResponse response, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("/common/fileDownFail");

		return mv;
	}
	
	/**
	 * @author 	: 장성훈남
	 * @Date		: 2017. 04. 13.
	 * @explain	: 버그, 문의
	 */
	@RequestMapping(value="/common/sendQ.do")
	public ModelAndView sendQ(CommandMap commandMap,HttpServletResponse response, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		commonDAO.insertSendQ(commandMap.getMap());
		
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 5. 21.
	 * @explain	: 샘플파일 다운로드 (DB 조회없이 바로 다운로드)
	 */
	@RequestMapping(value="/common/sampleDownloadFile.do")
	public void sampleDownloadFile(CommandMap commandMap, HttpServletResponse response, HttpServletRequest request) throws Exception{
		int result = commonFileUtils.sampleDownloadFile(commandMap.getMap(), response, request);
		if(result == -1){
			response.sendRedirect("/common/fileNameIncorrect.do");
		}
	}

	@RequestMapping(value="/common/fileNameIncorrect.do")
	public ModelAndView fileNameIncorrect(CommandMap commandMap,HttpServletResponse response, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("/common/fileNameIncorrect");

		return mv;
	}

	@RequestMapping(value="/common/sampleExcelDownloadFile.do")
	public void sampleExcelDownloadFile(CommandMap commandMap, HttpServletResponse response, HttpServletRequest request) throws Exception{
		commonFileUtils.sampleExcelDownloadFile(commandMap.getMap(), response, request);
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 6. 7.
	 * @explain	: 파일 select, insert, update
	 */
	@RequestMapping(value="/common/selectFileInfo.do")
	public void selectFileInfo(CommandMap commandMap, HttpServletResponse response, HttpServletRequest request) throws Exception{
	}

	@RequestMapping(value="/common/insertFile.do")
	public void insertFile(CommandMap commandMap, HttpServletResponse response, HttpServletRequest request) throws Exception{
	}

	@RequestMapping(value="/common/deleteFile.do")
	public ModelAndView deleteFile(CommandMap commandMap, HttpServletResponse response, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(commandMap.get("datatype").equals("html")){
			log.info((String)commandMap.get("jsp"));
			mv.setViewName((String)commandMap.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		int cnt = commonService.deleteFile(commandMap.getMap(),request);
		mv.addObject("cnt", cnt);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 7. 8.
	 * @explain	: 고객사 검색
	 */
	@RequestMapping(value="/common/searchCompanyInfo.do")
	public ModelAndView searchCompanyInfo(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> list = commonService.searchCompanyInfo(commandMap.getMap());
		mv.addObject("list", list);
		return mv;
	}
	
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2018. 3. 28.
	 * @explain	: 품목 검색
	 */
	@RequestMapping(value="/common/searchProductInfo.do")
	public ModelAndView searchProductInfo(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> list = commonDAO.searchProductInfo(commandMap.getMap());
		mv.addObject("list", list);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 08. 19.
	 * @explain	: 고객명 검색
	 */
	@RequestMapping(value="/common/searchCustomerInfo.do")
	public ModelAndView searchCustomerInfo(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> list = commonDAO.searchCustomerInfo(commandMap.getMap());
		mv.addObject("list", list);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2017. 12. 06.
	 * @explain	: 고객명 검색 (복수)
	 */
	@RequestMapping(value="/common/searchClientInfo.do")
	public ModelAndView searchClientInfo(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> list = commonDAO.searchClientInfo(commandMap.getMap());
		mv.addObject("list", list);
		return mv;
	}
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2018. 04. 02.
	 * @explain	: ERP 고객 담당자 검색
	 */
	@RequestMapping(value="/common/searchClientMaster.do")
	public ModelAndView searchClientMaster(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> list = commonDAO.searchClientMaster(commandMap.getMap());
		mv.addObject("list", list);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 08. 22.
	 * @explain	: 직원 검색
	 */
	@RequestMapping(value="/common/searchMemberInfo.do")
	public ModelAndView searchMemberInfo(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> list = commonDAO.searchMemberInfo(commandMap.getMap());
		mv.addObject("list", list);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 08. 22.
	 * @explain	: 캘린더 초대 직원 검색
	 */
	@RequestMapping(value="/common/searchCalendarMemberInfo.do")
	public ModelAndView searchCalendarMemberInfo(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> list = commonDAO.searchCalendarMemberInfo(commandMap.getMap());
		mv.addObject("list", list);
		return mv;
	}

	@RequestMapping(value="/common/selectInviteMemberInfo.do")
	public ModelAndView selectInviteMemberInfo(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> list = commonDAO.selectInviteMemberInfo(commandMap.getMap());
		mv.addObject("list", list);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 7. 8.
	 * @explain	: 파트너사 검색
	 */
	@RequestMapping(value="/common/searchPartnerInfo.do")
	public ModelAndView searchPartnerInfo(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> list = commonService.searchPartnerInfo(commandMap.getMap());
		mv.addObject("list", list);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 7. 8.
	 * @explain	: 파트너사 검색
	 */
	@RequestMapping(value="/common/searchPartnerMemberInfo.do")
	public ModelAndView searchPartnerMemberInfo(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> list = commonService.searchPartnerMemberInfo(commandMap.getMap());
		mv.addObject("list", list);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 7. 8.
	 * @explain	: 파트너사 조회
	 */
	@RequestMapping(value="/common/selectPartnerInfo.do")
	public ModelAndView selectPartnerInfo(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> list = commonService.selectPartnerInfo(commandMap.getMap());
		mv.addObject("list", list);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 7. 8.
	 * @explain	: 권한 조회
	 */
	@RequestMapping(value="/common/selectAuthority.do")
	public ModelAndView selectAuthority(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> list = commonDAO.selectAuthority(commandMap.getMap());
		mv.addObject("list", list);
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 5. 17.
	 * @explain	: 로그인 메인 화면
	 */
	@RequestMapping(value="/login.do")
	public ModelAndView login(CommandMap map, Device device) throws Exception{
		if (device.isNormal()) {
			log.info("접속 기기 : PC");
		} else if (device.isTablet()) {
			log.info("접속 기기 : Tablet");
		} else if (device.isMobile()) {
			log.info("접속 기기 : Mobile");
		}
		ModelAndView mv = new ModelAndView("/login/login");    	
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 5. 25.
	 * @explain	: 로그아웃 처리     
	 * */
	@RequestMapping(value="/logout.do") //김동용
	   public ModelAndView logout(CommandMap map, SessionStatus sessionStatus, Device device, HttpServletRequest request) throws Exception{
		  HttpSession session = request.getSession(); 
	      ModelAndView mv = new ModelAndView("/login/login");
	      if(device.isMobile() || device.isTablet()){ 
	    	  
	    	  String userToken = (String)session.getAttribute("userToken");	  
	    	  String MEMBER_ID_NUM = (String)session.getAttribute("member_id_num");
	    	 	    	 	  
	    	  map.put("userToken", userToken);
	    	  map.put("MEMBER_ID_NUM", MEMBER_ID_NUM);
	    	  
	    	  commonDAO.deleteLogOutToken(map.getMap());
	          session.removeAttribute("userToken");
	         
	          //세션 종료 최영완
	          request.getSession().invalidate();
	      }
	      return mv;
	   }

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 5. 18.
	 * @explain	: 로그인 실패시 loginFail.jsp로 이동후 다시 로그인 페이지로
	 */
	@RequestMapping(value="/loginFail.do")
	public ModelAndView loginFail(CommandMap map, HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView("/login/loginFail");
		Exception error = (Exception) session.getAttribute("SPRING_SECURITY_LAST_EXCEPTION");
		if (error != null) {
			mv.addObject("err_msg", error.getMessage());
		}
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 5. 18.
	 * @explain	: 로그인 성공시
	 */
	@RequestMapping(value="/loginSuccess.do")
	public ModelAndView loginSuccess(CommandMap map,Device device) throws Exception{
		ModelAndView mv = new ModelAndView("/login/login");
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 5. 18.
	 * @explain	: 로그인 세션 중복 관리
	 */
	@RequestMapping(value="/loginDuplicate.do")
	public ModelAndView loginDuplicate(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("redirect:/loginSuccess.do");    	
		return mv;
	}

	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 10. 20.
	 * @explain	: Access Denied 처리 페이지 이동
	 */
	@RequestMapping(value="/common/accessDenied.do")
	public ModelAndView accessDenied(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/common/accessDenied");    	
		return mv;
	}


	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 7. 29.
	 * @explain	: 알림 카운트 가져오기
	 */
	@ApiOperation(value = "알림 카운트")
	@RequestMapping(value="/common/selectNoticeCount.do", method = {RequestMethod.GET})
	public ModelAndView selectNoticeCount(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int noticeCount = commonService.selectNoticeCount(map.getMap());
		mv.addObject("noticeCount",noticeCount);
		return mv;
	}


	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 7. 29.
	 * @explain	: 알림 상세 가져오기
	 */
	@ApiOperation(value = "알림 상세 가져오기")
	@RequestMapping(value="/common/selectNoticeDetail.do", method = {RequestMethod.POST})
	public ModelAndView selectNoticeDetail(CommandMap map) throws Exception{
		//ModelAndView mv = new ModelAndView("/common/notice");
		ModelAndView mv = new ModelAndView("jsonView");
		List<Map<String,Object>> selectNoticeDetail = commonService.selectNoticeDetail(map.getMap());
		mv.addObject("selectNoticeDetail",selectNoticeDetail);

		return mv;
	}

	/** 알림창 확인 여부
	 * @author 	: 욱이
	 * @Date		: 2016. 7. 29.
	 * @explain	: 알림 상세 가져오기
	 */
	@RequestMapping(value="/common/updateNoticeDetail.do", method = {RequestMethod.GET})
	public ModelAndView updateNoticeDetail(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		int updateCnt = commonService.updateNoticeDetail(map.getMap());
		mv.addObject("updateCnt",updateCnt);

		return mv;
	}
	
	//모바일 패스워드 변경 
	@RequestMapping(value="/common/changePW.do")
	public ModelAndView changePW() throws Exception{
		ModelAndView mv = new ModelAndView("/common/changePW");

		return mv;
	}
	
	/**
	 * @author 	: H
	 * @Date	: 2016. 11. 03.
	 * @explain	: Password 변경 클릭 view
	 */
	@RequestMapping(value="/common/updatePassword.do")
	public ModelAndView updatePassword(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");

		int updateStatus = commonService.updatePassword(map.getMap());
		mv.addObject("updateStatus",updateStatus);

		return mv;
	}

	/**
	 * @author 	: H
	 * @Date	: 2016. 11. 03.
	 * @explain	: 미리알림_캘린더 일정 관련
	 */
	@RequestMapping(value="/common/selectCalendarAlarmInfo.do")
	public ModelAndView selectCalendarAlarmInfo(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");

		int cnt = commonService.selectCalendarAlarmInfo(map.getMap());

		mv.addObject("cnt",cnt);

		return mv;
	}
	
	/**
	 * @author 	: 준이
	 * @Date	: 2017. 04. 04.
	 * @explain	: 코칭톡 등록
	 */
	@RequestMapping(value="/common/insertCoachingTalk.do")
	public ModelAndView insertCoachingTalk(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}

		int cnt = commonService.insertCoachingTalk(map.getMap());

		mv.addObject("cnt",cnt);

		return mv;
	}
	
	/**
	 * @author 	: 준이
	 * @Date	: 2017. 04. 04.
	 * @explain	: 코칭톡 조회
	 */
	@RequestMapping(value="/common/selectCoachingTalk.do")
	public ModelAndView selectCoachingTalk(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		
		List<Map<String,Object>> selectCoachingTalk = commonDAO.selectCoachingTalk(map.getMap());
		mv.addObject("selectCoachingTalk",selectCoachingTalk);

		return mv;
	}
	
	
	/**
	 * @author 	:  욱
	 * @Date	: 2017. 05. 02.
	 * @explain	: 페이지 접근 기록// 왜하는거지..?
	 */
	@RequestMapping(value="/common/insertPageContatct.do")
	public ModelAndView insertPageContatct(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		commonService.insertPageContatct(map.getMap());
		return mv;
	}
	
	/*@RequestMapping(value="/loginHistory.do")
	public void insertLoginHistory(CommandMap map,Device device) throws Exception{
		commonService.insertLoginHistory(map.getMap(), device);
	}*/
	
	
	/**
	 * @author 	: 준이
	 * @Date	: 2017. 07. 27.
	 * @explain	: 첨부파일 삭제 후 리로드
	 */
	@RequestMapping(value="/common/reloadFile.do")
	public ModelAndView reloadFile(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(map.get("datatype").equals("html")){
			log.info((String)map.get("jsp"));
			mv.setViewName((String)map.get("jsp"));
		}else{
			mv.setViewName("jsonView");
		}
		List<Map<String,Object>> list = commonService.reloadFile(map.getMap());
		mv.addObject("fileList", list);
		
		return mv;
	}
	
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 5. 21.
	 * @explain	: 빈 connection
	 */
	@RequestMapping(value="/common/connection.do")
	public void connection(CommandMap commandMap,HttpServletResponse response, HttpServletRequest request) throws Exception{
		commonDAO.select1();
	}
	
	
	/**
	 * @author 	: 봉준
	 * @Date		: 2018. 10. 2.
	 * @explain	: 리스트페이지 사용자 별 rowCount 조회
	 */
	@RequestMapping(value="/common/selectUserPageRowCount.do")
	public ModelAndView selectUserPageRowCount(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		mv.addObject("rowCount" , commonDAO.selectUserPageRowCount(map.getMap()));
		return mv;
	}
	
	/**
	 * 메뉴 sub url 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/common/selectMenuSub.do")
	public ModelAndView selectMenuSub(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		mv.addObject("menuInfo" , commonDAO.selectMenuSub(map.getMap()));
		return mv;
	}
}
