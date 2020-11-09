<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="org.springframework.web.util.UrlPathHelper"%>
<%@ page import="java.util.ArrayList"  %>
<%@ page import="java.util.HashMap" %>
<%
	//URL 파라메터 제거
	UrlPathHelper urlPathHelper = new UrlPathHelper();
	String originalURL = urlPathHelper.getOriginatingRequestUri(request);
%>

<%-- 
<%  
response.setHeader("Cache-Control","no-store");  
response.setHeader("Pragma","no-cache");  
response.setDateHeader("Expires",0);  
if (request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache");
%>
 --%>
 
<!doctype html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
	
	<jsp:include page="../templates/header.jsp" flush="true"/>
	<title>THE Seller's</title>

<script type="text/javascript">

$(document).ready(function(){
	
	//createLocation();
	$.ajaxLoading = function(){
		$("div.ajax-loader_sellers").show(); //ajax Loading
		setTimeout(function(){$("div.ajax-loader_sellers").hide();},300); //ajax Loading
	}
	 
	$.ajaxLoadingShow = function(){
		$("div.ajax-loader_sellers").show(); //ajax Loading
	}
	
	$.ajaxLoadingHide = function(){
		$("div.ajax-loader_sellers").hide(); //ajax Loading
	}		
	
});

</script>
</head>

<body class="gray_bg">

<%
	//일정관리를 제외한 메뉴는 현재 메뉴명 노출
	if(originalURL.indexOf("/main/") == -1 && originalURL.indexOf("/calendar/") == -1 && originalURL.indexOf("/common/") == -1) {
%>

	<jsp:include page="/WEB-INF/jsp/m/common/nav.jsp" flush="true"/>
<%
	}
%>
<div class="container_pg">