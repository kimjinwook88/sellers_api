package com.uni.sellers.restful;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.uni.sellers.datasource.AbstractDAO;

@Repository("restfulDAO")
public class RestfulDAO extends AbstractDAO{
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectUserDeviceKey(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("restfulApi.selectUserDeviceKey", map);
	}
	
	@SuppressWarnings("unchecked")
	public int updateUserDeviceKey(Map<String, Object> map) throws Exception{
		return (int)update("restfulApi.updateUserDeviceKey", map);
	}
	
	@SuppressWarnings("unchecked")
	public int insertUserDeviceKey(Map<String, Object> map) {
		return (int)insert("restfulApi.insertUserDeviceKey", map);
	}

}
