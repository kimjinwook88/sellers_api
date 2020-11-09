package com.uni.sellers.fcm;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.uni.sellers.datasource.CommandMap;
import com.uni.sellers.restful.Dispatcher;
import com.uni.sellers.restful.RestfulDAO;

@Controller
public class FirebaseCloudMessagingController {
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="firebaseCloudMessagingService")
	private FirebaseCloudMessagingService firebaseCloudMessagingService;
	
	@Resource(name="restfulDAO")
	private RestfulDAO restfulDAO;
	
	@RequestMapping(value="/api/sendFcmDevice")
	public void sendFcmDevice(HttpServletRequest request, HttpSession session, CommandMap map) throws Exception{
		Map<String, Object> userMap = Dispatcher.getBodyAjax(request);
		List<Map<String, Object>> tokenList = new ArrayList<Map<String, Object>>();
		System.out.println(userMap);
		
		tokenList = restfulDAO.selectUserDeviceKey(userMap);
		
		if(tokenList != null && tokenList.size() > 0){
			firebaseCloudMessagingService.sendToFcm(userMap, tokenList);
		}
		
	}
	
}