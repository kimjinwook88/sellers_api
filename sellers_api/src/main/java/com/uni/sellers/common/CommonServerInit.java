package com.uni.sellers.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.ContextLoader;

public class CommonServerInit extends ContextLoader implements ServletContextListener{
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name="commonDAO")
	private CommonDAO commonDAO;

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		log.debug("이건 뭐하는 메소드냐");
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			List<Map<String,Object>> list = commonDAO.searchMemberInfo(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
	}
}
