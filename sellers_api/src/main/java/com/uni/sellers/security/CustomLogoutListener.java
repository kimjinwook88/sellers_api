package com.uni.sellers.security;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.uni.sellers.common.CommonService;

/**
 * @author  : 욱이
 * @date : 2017. 4. 28.
 * @explain : 세션 관리 (발생, 소멸)
 */
public class CustomLogoutListener implements HttpSessionListener{
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		// TODO Auto-generated method stub
	}

	
	@Override
	//로그아웃시 log 남김, session 만료시 log 남김
	public void sessionDestroyed(HttpSessionEvent se) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		HttpSession session = se.getSession();
        ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
        CommonService commonService = (CommonService) ctx.getBean("commonService");
		if((Map<String,Object>)se.getSession().getAttribute("userInfo") != null){
			log.info("MEMBER_ID_NUM" + ((Map<String,Object>)se.getSession().getAttribute("userInfo")).get("MEMBER_ID_NUM"));
			map.put("member_id_num",((Map<String,Object>)se.getSession().getAttribute("userInfo")).get("MEMBER_ID_NUM"));
			commonService.updateLogoutHistory(map);
		}
	}
	
}
