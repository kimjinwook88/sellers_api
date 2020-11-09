package com.uni.sellers.security;

import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;

import com.uni.sellers.common.CommonDAO;

public class SecuredObjectService {
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="commonDAO")
	private CommonDAO commonDAO;
	
	//권한별 접근 URL 관리
	public LinkedHashMap<RequestMatcher, List<ConfigAttribute>> getRolesAndUrl() throws Exception{
		 // TODO Auto-generated method stub
		
		//db에서 권한별 접근 가능 메뉴 조회
        List<Map<String, Object>> data = commonDAO.selectRolesAndUrl();
        
        //spring security 형식에 맞게 데이터 변경
        LinkedHashMap<RequestMatcher, List<ConfigAttribute>> requestMap = new LinkedHashMap<RequestMatcher, List<ConfigAttribute>>();
        RequestMatcher preResource = null;
        RequestMatcher presentResource = null;
        
       for(int i=0; i<data.size(); i++){
    	   presentResource = new AntPathRequestMatcher((String) data.get(i).get("MENU_URL"));   
    	   List<ConfigAttribute> configList = new LinkedList<ConfigAttribute>();
    	   
    	   if (preResource != null && presentResource.equals(preResource)) {
               List<ConfigAttribute> preAuthList = requestMap.get(presentResource);
               Iterator<ConfigAttribute> preAuthItr = preAuthList.iterator();
               while (preAuthItr.hasNext()) {
                   SecurityConfig tempConfig = (SecurityConfig) preAuthItr.next();
                   configList.add(tempConfig);
               }
           }

           configList.add(new SecurityConfig((String)data.get(i).get("AUTHORITY_NAME")));
            
           // 만약 동일한 Resource 에 대해 한개 이상의 Role 맵핑 추가인 경우
           // 이전 resourceKey 에 현재 새로 계산된 Role 맵핑 리스트로 덮어쓰게 됨.
           requestMap.put(presentResource, configList);

           // 이전 resource 비교위해 저장
           preResource = presentResource;
        }
        
        log.debug("SecuredObjectService"+requestMap);
		return requestMap;
	}
	
	
}
