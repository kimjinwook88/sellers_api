<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	session.invalidate();
	/* Map<String, Object> userInfo =  ((Map<String, Object>) SecurityContextHolder.getContext().getAuthentication().getDetails()); */
%>
<script type="text/javascript">
		alert("${err_msg}");	
		document.location.href = "/login.do";
</script>