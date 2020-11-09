package com.uni.sellers.datasource;
 
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.core.MethodParameter;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import com.uni.sellers.security.jwt.JwtTokenProvider;
import com.uni.sellers.util.CommonUtils;

@Component
public class CustomMapArgumentResolver implements HandlerMethodArgumentResolver{
		 
	@Resource(name="JwtTokenProvider")
	private JwtTokenProvider jwtTokenProvider;
	
    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        return CommandMap.class.isAssignableFrom(parameter.getParameterType());
    }
 
    @Override
    public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
        CommandMap commandMap = new CommandMap();
         
        HttpServletRequest request = (HttpServletRequest) webRequest.getNativeRequest();
        Enumeration<?> enumeration = request.getParameterNames();
        HttpSession session = ((HttpServletRequest)request).getSession();
        String token = jwtTokenProvider.resolveToken(request, 1);
        String refresh = jwtTokenProvider.resolveToken(request, 2);
        
        if(refresh != null && !refresh.isEmpty()) {
        	token = refresh;
        }
                
        String key = null;
        String[] values = null;
        while(enumeration.hasMoreElements()){
            key = (String) enumeration.nextElement();
            values = request.getParameterValues(key);
            if(values != null){
                commandMap.put(key, (values.length > 1) ? values:values[0] );
            }
        }
        if(!CommonUtils.isEmpty(session.getAttribute("auth"))){
        	commandMap.put("global_role_code",session.getAttribute("auth").toString());
        }else if(token != null && !token.isEmpty()) {
        	if(!CommonUtils.isEmpty(jwtTokenProvider.getUserInfo(token, "authMap"))){
            	commandMap.put("global_role_code", jwtTokenProvider.getUserInfo(token, "authMap").get("auth").toString());
        	}
        }
        
        boolean infoTf = false;
        Map<String, Object> userInfo = new HashMap<>();
        if(!CommonUtils.isEmpty(session.getAttribute("userInfo"))){
        	userInfo = (Map<String, Object>) session.getAttribute("userInfo");
        	infoTf = true;
        	
        }else if(token != null && !token.isEmpty()) {
        	if(!CommonUtils.isEmpty(jwtTokenProvider.getUserInfo(token, "userInfo"))){
        		userInfo = jwtTokenProvider.getUserInfo(token, "userInfo");
        		infoTf = true;
        	}
        }
        
        if(infoTf) {
        	commandMap.put("global_member_division",userInfo.get("MEMBER_DIVISION"));
        	commandMap.put("global_member_team",userInfo.get("MEMBER_TEAM"));
        	commandMap.put("global_member_id",userInfo.get("MEMBER_ID_NUM"));
        	//commandMap.put("global_company_cd",userInfo.get("COMPANY_CD"));
        	if(userInfo.get("DEVICE_KEY") != null){
        		commandMap.put("global_device_token",userInfo.get("DEVICE_KEY"));
        	}
        }
        
        return commandMap;
    }
}