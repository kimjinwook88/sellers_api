package com.uni.sellers.security;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.uni.sellers.common.CommonDAO;
import com.uni.sellers.datasource.CommandMap;

/**
 * @author 	: 욱이
 * @Date		: 2016. 5. 18.
 * @explain	: spring security를 사용한 로그인 처리 클래스
 */
public class CustomAuthenticationProvider implements AuthenticationProvider{
     Logger log = LoggerFactory.getLogger(this.getClass());
     
     @Resource(name="commonDAO")
     private CommonDAO commonDAO;
     
     @Autowired
     private BCryptPasswordEncoder bcryptPasswordEncoder;
     
     @Autowired(required = false)
     private HttpServletRequest request;
     
     @Override
     public boolean supports(Class<?> authentication) {
         return authentication.equals(UsernamePasswordAuthenticationToken.class);
     }
   
     @Override
     public Authentication authenticate(Authentication authentication) throws AuthenticationException,AccessDeniedException{
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> userInfo = new HashMap<String, Object>();
        
        /*String company_cd = (String) request.getSession().getAttribute("company_cd");*/
        String user_id = (String) request.getSession().getAttribute("member_id_num");
        String user_pw = (String) request.getSession().getAttribute("password_enc");
        
        /*map.put("company_cd", company_cd);*/
        map.put("member_id_num", user_id);
        map.put("password_enc", user_pw);
        
         try {
        	 userInfo = commonDAO.selectLoginProccess(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
         
         log.info("==입력정보==");
         log.info("MEMBER_ID_NUM : " +user_id);
         //log.info("PASSWORD_ENC : " +user_pw);
         log.info("==입력정보==");
         
	     if(userInfo != null && bcryptPasswordEncoder.matches((CharSequence) user_pw, (String) userInfo.get("PASSWORD_ENC")) && "Y".equals(userInfo.get("USE_YN"))){
	    	 log.info(userInfo.get("MEMBER_ID_NUM")+"님이 로그인 했습니다.");
	    	
	    	 //로그인 아이디로 권한 가져오기
	    	 List<Map<String, Object>> authorityList = null;
	    	 List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
			try {
				authorityList = commonDAO.selectAuthority(userInfo);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			//권한이 있는지 체크 후 redirect
			if(authorityList.size() > 0){
	    		for(int i=0; i<authorityList.size(); i++){
	    			roles.add(new SimpleGrantedAuthority(authorityList.get(i).get("AUTHORITY_NAME").toString()));
	    		}
			}else{
				log.info("접근 권한이 없습니다.");
				throw new AccessDeniedException("접근 권한이 없습니다.");
			}
	    	log.info("권한 : " + roles);
	        UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(userInfo.get("MEMBER_ID_NUM"), user_pw, roles);
	        result.setDetails(userInfo);
	        return result; 
	     }else if(userInfo != null && "N".equals(userInfo.get("USE_YN"))){
	    	 log.info("퇴사자 입니다.");
	         throw new BadCredentialsException("퇴사자 입니다.");
	     }else{
         	log.info("사용자 크리덴셜 정보가 틀립니다.");
         	throw new BadCredentialsException("아이디 또는 비밀번호를 확인하세요.");
	     }
     }
     
}