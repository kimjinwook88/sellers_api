<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%!
public String getReqParams(HttpServletRequest request, String... exp_params) {
	String strName;
	String req_params = "";

	Enumeration enu = request.getParameterNames();
	
	while (enu.hasMoreElements()) {
		strName= (String) enu .nextElement();
		
		if(exp_params != null) {
			for(String s : exp_params) {
				if(strName.equals(s)) {
					strName = "";
					break;
				}
			}
		}

		if(!strName.isEmpty()) {
			req_params += strName + "=" + request.getParameter(strName) + "&";
		}
		
		//out.print(strName + ":");
		//out.print(request.getParameter(strName)+"<BR>");
	}
	
	if(!req_params.equals("")) {
		req_params = req_params.substring(0, req_params.length()-1);
	}
	
	return req_params;
}
%>