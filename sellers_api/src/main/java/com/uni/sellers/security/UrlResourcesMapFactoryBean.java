package com.uni.sellers.security;

import java.util.LinkedHashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.web.util.matcher.RequestMatcher;

public class UrlResourcesMapFactoryBean implements FactoryBean<LinkedHashMap<RequestMatcher, List<ConfigAttribute>>> {
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	private SecuredObjectService securedObjectService;
	
	private LinkedHashMap<RequestMatcher, List<ConfigAttribute>> requestMap;
	
	public void setSecuredObjectService(SecuredObjectService securedObjectService) {
	this.securedObjectService = securedObjectService;
	}
	
	public void init() throws Exception {
		requestMap = securedObjectService.getRolesAndUrl();
	}
	
	@Override
	public LinkedHashMap<RequestMatcher, List<ConfigAttribute>> getObject() throws Exception {
		// TODO Auto-generated method stub
		if(requestMap == null){
		    requestMap = securedObjectService.getRolesAndUrl();
		}
		
		log.debug("UrlResourcesMapFactoryBean" + requestMap);
		return requestMap;
	}
	
	@Override
	public Class<?> getObjectType() {
		// TODO Auto-generated method stub
		return LinkedHashMap.class;
	}
	
	@Override
	public boolean isSingleton() {
		// TODO Auto-generated method stub
		return true;
	}
	
}
