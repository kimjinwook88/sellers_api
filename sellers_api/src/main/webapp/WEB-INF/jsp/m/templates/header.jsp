<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" pageEncoding="UTF-8" %>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="org.springframework.web.util.UrlPathHelper"%>

<%

Calendar c = Calendar.getInstance();
SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
String todayDate = transFormat.format(c.getTime());
todayDate = transFormat.format(c.getTime());

String curDate = request.getParameter("curDate");

%>
<jsp:include page="/WEB-INF/jsp/m/common/common.jsp"/>
<header class="header primary_bg">
	<hgroup>
		<a href="/main/index.do" >
			<h1 class="logo">THE Seller's</h1>
		</a>	
	</hgroup>

	<!-- 사이드메뉴 -->
	
	<a href="#" class="btn_sideMenu">
		<span></span>
		<span></span>
		<span></span>
	</a>
	
	<!-- <span class="alarm_count pos_h r10" style="display:none;">0</span>  --><!-- 확인하지 않은 알림 개수 -->
	
	<!-- 기존 검색버튼 -->
	<!-- <a href="#" class="btn_todaycheck" style="float:right;">
		<span class="icon_search"></span>
	</a> -->
	
	<span class="alarm_count r10" id="mainNoticeCount" style="float: right">${noticeCount}</span>
	<a href="#" class="btn_todaycheck" onclick="upper_right();">
		오늘 체크할 일
	</a>	
	
	<!-- 사이드메뉴 시작 -->
	<div class="sidemenu off">
		<!-- 사용자 확인 -->
		<div class="top">
			<div class="user_photo r60 mg_b10">
				<img src="${pageContext.request.contextPath}/images/m/icon_character.svg" />
			</div>
			<p class="fc_white user_info">
				<span>${userInfo.HAN_NAME}님</span><br/>좋은하루 되세요.
			</p>

			<a href="#" class="btn_sidemenu_close">
				<img src="${pageContext.request.contextPath}/images/m/icon_sidemenu_close.svg" alt="사이드 메뉴 닫기"/>
			</a>
		</div>
		<div class="side_gnb">
		</div>
	</div>
	<!-- 사이드메뉴 종료 -->
	
	<div class="today_checklist off"> <!-- sidemenu2 -->
		<div class="today_checklist_tab"> <!-- top2 -->
			<ul>
				<li>
					<a href="#" class="sideTab tab1 active">알림 <span class="alarm_count r10">0</span></a>
					<div class="today_checklist_tab_cont">
						<ul class="news">
						</ul>
					</div>
				</li>
				<li>
					<a href="#" class="sideTab tab2">Coming up</a>
					<div class="today_checklist_tab_cont off">
						<div class="coming_area" id="monitoring">
							
						</div>
					</div>
				</li>
			</ul>
			
			<a href="#" class="btn_today_checklist_close">
				<img src="../../../images/m/icon_sidemenu_close.svg" alt="사이드 메뉴 닫기"/>
			</a>
		</div>
	</div>
</header>

<div class="modal_screen"></div>

<form id="formNoticeDetail" name="formNoticeDetail" method="post">
	<input type="hidden" id="notice_event_id" name="notice_event_id">
</form>  

<script>
var member_id_num = "${userInfo.MEMBER_ID_NUM}";
</script>
<script src="/js/m/view/templates/header.js"></script>

