package com.uni.sellers.common;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.uni.sellers.security.jwt.JwtTokenProvider;
import com.uni.sellers.security.jwt.UnauthorizedException;
import com.uni.sellers.util.CommonUtils;

public class CommonInterceptor extends HandlerInterceptorAdapter {
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="commonDAO")
	private CommonDAO commonDAO;
	
	@Resource(name="JwtTokenProvider")
	private JwtTokenProvider jwtTokenProvider;
	
	/**
	 * @author 	: 욱이
	 * @Date		: 2016. 5. 25.
	 * @explain	: 공통 인터셉터
	 */
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception, AccessDeniedException {
		log.info("======================================          START         ======================================");
		log.info(" Request URL \t:  " + request.getRequestURL());
		//세션 체크 후 로그인 페이지로 이동
		return checkSession(request,response);
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception, AccessDeniedException {
		log.info("======================================           END          ======================================\n");
	}

	public boolean checkSession(HttpServletRequest request, HttpServletResponse response) throws Exception, AccessDeniedException{
		HttpSession session = request.getSession();
		boolean result = true;
		
		//ajax 통신인지 판단
		if (isAjaxRequest(request)) {
        	if(CommonUtils.isEmpty(session.getAttribute("userInfo")))
        	{
        		//session이 끊기면 403에러
        		response.sendError(HttpServletResponse.SC_FORBIDDEN);
        		result = false;
        	}
		} else {
			if(CommonUtils.isEmpty(session.getAttribute("userInfo")))
			{
				
				// 네이티브 앱일때, 토큰으로 인증
				Device device = DeviceUtils.getCurrentDevice(request);
				if(!device.isNormal()) {
					String access = jwtTokenProvider.resolveToken(request, 1);
					String refresh = jwtTokenProvider.resolveToken(request, 2);
					
					if(refresh != null && !refresh.isEmpty()) {
						if(!jwtTokenProvider.validateToken(refresh, response)) {
							result = false;
						}
					}else if(access != null && !access.isEmpty()) {
						if(!jwtTokenProvider.validateToken(access, response)) {
							result = false;
						}
					}else {
						response.sendError(HttpServletResponse.SC_FORBIDDEN);
						result = false;
					}

					return result;
				}
				
//				response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
				result = false;
				try {
					response.sendRedirect("/logout");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
        }
		return result;
	}
	
	private boolean isAjaxRequest(HttpServletRequest req) {
//    	log.info("ajaxValue : " + req.getHeader(ajaxHeader));
        return req.getHeader("AJAX") != null
                && req.getHeader("AJAX").equals(Boolean.TRUE.toString());
    }
	
}
