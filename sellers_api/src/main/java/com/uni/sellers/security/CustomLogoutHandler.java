package com.uni.sellers.security;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.uni.sellers.common.CommonService;

public class CustomLogoutHandler extends SimpleUrlLogoutSuccessHandler {
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Value("#{config['url.mobileAppLogin']}")
	private String mobileAppLoginUrl;
	
    
    @Override
    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
    	Map<String,Object> map = new HashMap<String,Object>();
    	HttpSession session = request.getSession();
    	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
    	CommonService commonService = (CommonService) ctx.getBean("commonService");
    	
    	if((Map<String,Object>)request.getSession().getAttribute("userInfo") != null){
			log.info("MEMBER_ID_NUM" + ((Map<String,Object>)request.getSession().getAttribute("userInfo")).get("MEMBER_ID_NUM"));
			map.put("member_id_num",((Map<String,Object>)request.getSession().getAttribute("userInfo")).get("MEMBER_ID_NUM"));
			commonService.updateLogoutHistory(map);
		}
		
		if(((Map<String,Object>)session.getAttribute("userInfo")) != null && ((Map<String,Object>)session.getAttribute("userInfo")).get("DEVICE_KEY") != null){
			log.info("redirect:" + mobileAppLoginUrl + "device_token="+ ((Map<String,Object>)session.getAttribute("userInfo")).get("DEVICE_KEY").toString() +"&logout=1");
			setDefaultTargetUrl(mobileAppLoginUrl + "device_token="+ ((Map<String,Object>)session.getAttribute("userInfo")).get("DEVICE_KEY").toString() +"&logout=1");
		}else{
			setDefaultTargetUrl("/logout.do");
		}
		super.onLogoutSuccess(request, response, authentication);
    	
		//세션 종료
    	//request.getSession().invalidate();
    }
 
}
