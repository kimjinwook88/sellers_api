package com.uni.sellers.restful;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONArray;
import org.json.simple.parser.ParseException;
import org.json.simple.parser.JSONParser; 

public class Dispatcher extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
			process(req, resp);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
			process(req, resp);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    protected void process(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, ParseException {
    }
    
    public static Map<String, Object> getBodyAjax(HttpServletRequest request) throws IOException, ParseException {
    	
        String body = null;
        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader bufferedReader = null;
        
        try {
            InputStream inputStream = request.getInputStream();
            if (inputStream != null) {
                bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
                char[] charBuffer = new char[128];
                int bytesRead = -1;
                while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
                    stringBuilder.append(charBuffer, 0, bytesRead);
                }
            } else {
                stringBuilder.append("");
            }
        } catch (IOException ex) {
            throw ex;
        } finally {
            if (bufferedReader != null) {
                try {
                    bufferedReader.close();
                } catch (IOException ex) {
                    throw ex;
                }
            }
        }
        
        body = stringBuilder.toString();
        JSONParser parser = new JSONParser();
        System.out.println("body:"+body);
        
		JSONObject jObject = (JSONObject) parser.parse(body);
		Map<String,Object> map = new ObjectMapper().readValue(jObject.toJSONString(), Map.class);
        
        return map;
    }
    
public static Map<String, Object> getBodyNonAjax(HttpServletRequest request) throws IOException, ParseException {
    	
        Map<String,Object> map = new HashMap<String,Object>();
        Enumeration enums = request.getParameterNames();
        while(enums.hasMoreElements()){
        	String paramName = (String)enums.nextElement();
        	String[] parameters = request.getParameterValues(paramName);

        	// Parameter가 배열일 경우
        	if(parameters.length > 1){
        		map.put(paramName, parameters);
				// Parameter가 배열이 아닌 경우
        	}else{
        		map.put(paramName, parameters[0]);
        	}
        }
        
        return map;
    }
}
