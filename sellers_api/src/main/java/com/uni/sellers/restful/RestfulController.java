package com.uni.sellers.restful;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.uni.sellers.common.CommonDAO;
import com.uni.sellers.common.CommonService;
import com.uni.sellers.datasource.CommandMap;
import com.uni.sellers.main.MainService;
import com.uni.sellers.security.CustomAuthenticationSuccessHandler;
import com.uni.sellers.security.jwt.JwtTokenProvider;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

@Api(value = "HomeControllerTest", description = "HomeController 테스트입니다.") // Controller에 대한 Swagger 설명
@RestController
public class RestfulController {
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="customAuthenticationSuccessHandler")
	private CustomAuthenticationSuccessHandler customAuthenticationSuccessHandler;
	
	@Resource(name="commonDAO")
    private CommonDAO commonDAO;
	
	@Resource(name="commonService")
	private CommonService commonService;
	
	@Resource(name="mainService")
	private MainService mainService;
	
	@Resource(name="applicationCustomAuthenticationProvider")
	private ApplicationCustomAuthenticationProvider applicationCustomAuthenticationProvider;
	
	@Resource(name="restfulDAO")
	private RestfulDAO restfulDAO;
	
	@Resource(name="restfulService")
	private RestfulService restfulService;
	
	@Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Resource(name="JwtTokenProvider")
	private JwtTokenProvider jwtTokenProvider;
	
	@ResponseBody
	@RequestMapping(value = "/api/user", method = {RequestMethod.POST, RequestMethod.OPTIONS})
	public ModelAndView loginUser(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");
		
		//POST Body에  담긴 데이터 값 map에 담기
		//Map<String, Object> loginMap = Dispatcher.getBodyNonAjax(request);
		Map<String, Object> loginMap = Dispatcher.getBodyAjax(request);
		loginMap.put("member_id_num", loginMap.get("userId"));
		Map<String, Object> userInfo = commonDAO.selectLoginProccess(loginMap);
		
		//모바일 앱 로그인 로직
		Map<String, Object> rtMap = restfulService.mobileAppUser(loginMap, userInfo, request, response);
		mv.addObject("result", rtMap.get("result"));
		mv.addObject("moveUrl", rtMap.get("moveUrl"));
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/api/login", method = {RequestMethod.POST, RequestMethod.OPTIONS})
	public void ApiLogin(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//POST Body에  담긴 데이터 값 map에 담기
		Map<String, Object> loginMap = Dispatcher.getBodyNonAjax(request);
		//Map<String, Object> loginMap = Dispatcher.getBodyAjax(request);
		loginMap.put("member_id_num", loginMap.get("userId"));
		Map<String, Object> userInfo = commonDAO.selectLoginProccess(loginMap);
		
		//모바일 앱 로그인 로직
		restfulService.mobileAppLogin(loginMap, userInfo, request, response);
	 }
	
	//토큰 생성 테스트
	@ResponseBody
	@RequestMapping(value = "/api/token", method = {RequestMethod.POST, RequestMethod.OPTIONS})
	public void receiveToken(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//POST Body에  담긴 데이터 값 map에 담기
		Map<String, Object> map = Dispatcher.getBodyNonAjax(request);
		
		log.info(map.get("Token").toString());
	 }
	
	
	
	@ResponseBody
	@ApiOperation(value = "로그인", notes = "로그인 체크 후 세션, 회원정보 리턴")
	@RequestMapping(value = "/api/logintest", method = {RequestMethod.POST, RequestMethod.OPTIONS})
	public ModelAndView restfulApiLogin(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");
   	 	String accessToken = null;
   	 	String refreshToken = null;
		
		//POST Body에  담긴 데이터 값 map에 담기
		Map<String, Object> loginMap = Dispatcher.getBodyNonAjax(request);
		
		Map<String, Object> userInfo = commonDAO.selectLoginProccess(loginMap);
		
		//암호 복호화 로직
		String password_enc = loginMap.get("password_enc").toString();
		//String kkkk = commonAppSecurity.Encryption("uni123", KEY_SCURITY);
		
		//로그인 로직
		Authentication requestAuthentication = new UsernamePasswordAuthenticationToken(loginMap.get("member_id_num"), password_enc);
		Authentication result = applicationCustomAuthenticationProvider.appAutoAuthenticate(requestAuthentication, loginMap);
		SecurityContextHolder.getContext().setAuthentication(result);
		
		int rslt = result.isAuthenticated() ? 1:-1;
		
		if(rslt == 1) {
			//로그인 아이디로 권한 가져오기
	   	 	List<Map<String, Object>> authorityList = null;
	   	 	List<String> roles = new ArrayList<>();
	   	 	
	   	 	authorityList = commonDAO.selectAuthority(userInfo);
	   	 	
	   	 	//권한이 있는지 체크 후 redirect
			if(authorityList.size() > 0){
	    		for(int i=0; i<authorityList.size(); i++){
	    			roles.add(String.valueOf(authorityList.get(i).get("AUTHORITY_NAME")));
	    		}
	    		
	    		Map<String, Object> tokenInfoMap = new HashMap<>();
	    		tokenInfoMap.put("MEMBER_DIVISION", String.valueOf(userInfo.get("MEMBER_DIVISION")));
	    		tokenInfoMap.put("MEMBER_TEAM", String.valueOf(userInfo.get("MEMBER_TEAM")));
	    		tokenInfoMap.put("MEMBER_ID_NUM", String.valueOf(userInfo.get("MEMBER_ID_NUM")));
	    		//tokenInfoMap.put("COMPANY_CD", String.valueOf(userInfo.get("COMPANY_CD")));
	    		
	    		// Access token 발급
	    		accessToken = jwtTokenProvider.createToken(String.valueOf(userInfo.get("HAN_NAME")), roles, tokenInfoMap, 1);
	    		// Refresh token 발급
	    		refreshToken = jwtTokenProvider.createToken(String.valueOf(userInfo.get("HAN_NAME")), roles, tokenInfoMap, 2);
	    			    		
			}else{
				log.info("접근 권한이 없습니다.");
				throw new AccessDeniedException("접근 권한이 없습니다.");
			}
		}
		
		mv.addObject("result", rslt);
		mv.addObject("userInfo",userInfo);
		mv.addObject("accessToken", accessToken);
		mv.addObject("refreshToken", refreshToken);
		
		return mv;
	}
	
	/**
	 * Access token이 만료되었으나, Refresh Token이 유효한 경우 Access Token만 재발급
	 * @param request
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@ApiOperation(value = "해당 게시판 조회")
    @ApiImplicitParams({
            @ApiImplicitParam(
            			name = "id", 
            			value = "게시판 고유키", 
            			required = true, 
            			dataType = "string", 
            			paramType = "path", 
            			defaultValue = ""
            ),
    })
	@RequestMapping(value = "/api/createToken", method = {RequestMethod.POST, RequestMethod.OPTIONS})
	public ModelAndView restfulApiCreateToken(HttpServletRequest request, CommandMap map) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");   	 	
	 	String refreshToken = jwtTokenProvider.resolveToken(request, 2);
	 	
	 	// Refresh Token 에 들어있는 사용자정보를 새로 발급할 Access Token 에 담는다
	 	String userName = jwtTokenProvider.getUserPk(refreshToken);
	 	Map<String, Object> userInfo = jwtTokenProvider.getUserInfo(refreshToken, "userInfo");
	 	
	 	String rolesStr = jwtTokenProvider.getUserInfo(refreshToken, "authMap").get("auth").toString();
	 	// [a,b,c,...] 형태로 되어 있으므로 맨 앞과 맨 뒤의 '[', ']' 를 제거한다.
	 	rolesStr = rolesStr.substring(1,rolesStr.length()-2);
	 	// 스트링을 리스트형식으로 변환
	 	List<String> roles = Arrays.asList(rolesStr.split(","));	 	
	 		 	
   	 	// Access token 발급
		String accessToken = jwtTokenProvider.createToken(userName, roles, userInfo, 1);
						
		mv.addObject("accessToken", accessToken);
		mv.addObject("refreshToken", refreshToken);
		
		return mv;
	}
}
