<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ page language="java" pageEncoding="UTF-8" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ include file="/WEB-INF/jsp/m/common/functions.jsp" %>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
<title>THE Seller's</title>
<link href="${pageContext.request.contextPath}/css/m/style.css" rel="stylesheet" type="text/css">
<style>
.nv-legend {
	transform: translate(0px, 490px);
}

svg.nvd3-svg {
	height: 600px;
}
</style>
</head>
<body class="gray_bg">

<div class="container">
	<jsp:include page="../templates/header.jsp" flush="false"/>

	<jsp:include page="/WEB-INF/jsp/m/common/calendar_footer.jsp"/>
	
	<article class="topControl primary_bg">

		<div class="func_right fl_r">
			<a href="" onClick="fncAddSchedule('${curDate}'); return false;"><span class="va_t icon_add">일정추가</span></a>
		</div>
		
		
	</article>
	
	<article class="schedule_cont" >
		<!-- 생산성 현황 영역 -->
		<div class="top_statusarea_white_bg">

			<!-- 기간 및 부서선택 -->
			<div class="productivity_select_box r3 ta_c mg_b10">
				<select id="categoryChange" onchange="categoryChange(this.value);">
					<option value="m" <c:if test="${viewType eq 'm'  or viewType eq ''}"> selected </c:if> >월</option>
					<option value="q" <c:if test="${viewType eq 'q'}"> selected </c:if> >분기</option>
				</select>
				<select class="form-control m-b" name="selectFaceQuarter" id="selectFaceQuarter">
					<option value="1">1분기</option>
					<option value="2">2분기</option>
					<option value="3">3분기</option>
					<option value="4">4분기</option>
				</select>
				<select class="form-control m-b" name="selectFaceMonth" id="selectFaceMonth">
					<option value="01">01월</option>
					<option value="02">02월</option>
					<option value="03">03월</option>
					<option value="04">04월</option>
					<option value="05">05월</option>
					<option value="06">06월</option>
					<option value="07">07월</option>
					<option value="08">08월</option>
					<option value="09">09월</option>
					<option value="10">10월</option>
					<option value="11">11월</option>
					<option value="12">12월</option>
				</select>
				<select class="form-control m-b" name="selectFaceTeam" id="selectFaceTeam" readonly="readonly" disabled style="display: none;">
					<c:choose>
						<c:when test="${fn:length(searchDetailGroup.facePost) > 0}">
							<!-- <option value="" selected='selected'>팀</option> -->
							<c:forEach items="${searchDetailGroup.facePost}"
								var="searchDetailGroup">
								<option value="${searchDetailGroup.TEAM_NAME}" selected="selected">${searchDetailGroup.TEAM_NAME}</option>
							</c:forEach>
						</c:when>
					</c:choose>
				</select>
				
				<select class="form-control m-b" name="selectFaceMember" id="selectFaceMember" ">
					<c:choose>
						<c:when test="${fn:length(searchDetailGroup.faceMember) > 0}">
						<option value='' selected='selected'>팀전체</option>
							<c:forEach items="${searchDetailGroup.faceMember}" var="searchDetailGroup">
								<option value="${searchDetailGroup.HAN_NAME}" <c:if test="${param.selectFaceMember == searchDetailGroup.HAN_NAME}" >selected="selected" </c:if>>${searchDetailGroup.HAN_NAME}</option>
							</c:forEach>
						</c:when>
					</c:choose>
				</select>

			</div>
			<div id="DivisionGraph"></div>
		</div>
		<!--// 생산성 현황 영역 -->

		<div id="calendar"></div>
		<input type="hidden" id="textCalendarName" name="textCalendarName"></input>
		
	</article>
</div>
<jsp:include page="/WEB-INF/jsp/m/common/bottom.jsp"/>
</body>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
/*
 *  전역변수
 */
var gridWidth;
var listRow = 10;
var hearderTitle;
var gridStatus=true;

$(document).ready(function() {
	categoryChange();
	drawChart();
	
	$("div.viewType").hide();
	
	if("${selectFaceMonth}" != null && "${selectFaceMonth}" != ""){
		$("#selectFaceMonth").val("${selectFaceMonth}");
	}else{
		$("#selectFaceMonth").val(commonDate.month);
	}
	
	if("${selectFaceYear}" != null && "${selectFaceYear}" != ""){
		$("#selectFaceYear").val("${selectFaceYear}");
	}else{
		$("#selectFaceYear").val(commonDate.year);
	}
	
	if("${selectFaceQuarter}" != null && "${selectFaceQuarter}" != ""){
		$("#selectFaceQuarter").val("${selectFaceQuarter}");
	}else{
		$("#selectFaceQuarter").val(commonDate.quarter(commonDate.month));
	}
	
	if("${viewType}" == null || "${viewType}" == 'm' || "${viewType}" == ''){
		$("div[name='divSerachYear']").show();
		$("div[name='divSerachMonth']").show();
		
		hearderTitle = $("#selectFaceYear").val()+"년 "+$("#selectFaceMonth").val()+"월 (Hours, %)";
	}else if("${viewType}" == 'y'){
		$("div[name='divSerachYear']").show();
		hearderTitle = $("#selectFaceYear").val()+"년 (Hours, %)";
	}else{
		$("div[name='divSerachYear']").show();
		$("div[name='divSerachQuarter']").show();	
		hearderTitle = $("#selectFaceYear").val()+"년 "+$("#selectFaceQuarter").val()+"분기 (Hours, %)";
	}
	$('#page-wrapper > div.wrapper.wrapper-content.animated.fadeInRight > div > div > div.ibox > div.clear > div > div.ng-scope > div:nth-child(1) > div > nvd3 > svg').css('height', '550px');
	$('#page-wrapper > div.wrapper.wrapper-content.animated.fadeInRight > div > div > div.ibox > div.clear > div > div.ng-scope > div:nth-child(2) > div > nvd3 > svg').css('height', '550px');
	
	function drawChart(){
		var team_name = "${selectFaceTeam.TEAM_NAME}";
		
		var params = $.param({
			datatype : 'html',
			jsp : '/calendar/productivityTeamMainAjax',
			roleChildTeam : "Y",
			teamAuthority : team_name,
			selectFaceYear : function(){
				if("${selectFaceYear}" != null && "${selectFaceYear}" != ""){
					return "${selectFaceYear}";
				}else{
					return commonDate.year;
				}
			},
			selectFaceMonth : function(){
				if("${selectFaceMonth}" != null && "${selectFaceMonth}" != ""){
					return "${selectFaceMonth}";
				}else{
					return commonDate.month;
				}
			},
			selectFaceQuarter : function(){
				if("${selectFaceQuarter}" != null && "${selectFaceQuarter}" != ""){
					return "${selectFaceQuarter}";
				}else{
					commonDate.quarter(commonDate.month);
				}
			},
			selectFacePost:$("#selectFacePost").val(),
			selectFaceTeam:$("#selectFaceTeam").val(),
			selectFaceMember:$("#selectFaceMember").val(),
			viewType :$("#categoryChange").val(),
			//viewType : $("input:radio[name='radioViewType']:checked").val(),
			gridTabFlag : "Y",
			skipAvgTab : "Y",
			deviceCheck : "mobile"
		});
		
		$.ajax({
			url : "/salesManagement/gridFaceTime.do",
			data : params,
			datatype : 'html',
			method : 'POST',
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			success : function(data){
				$("#DivisionGraph").html(data);
			},
			complete : function(){
			}
		});
	}
	
});
/* 
//본부별로 돌아가기
var backDivision = {
	conn : function() {
		location.href="/salesManagement/listFaceTime.do?"
	}
}
//팀별로 돌아가기
var backTeam = {
	conn : function() {
		var params = $.param({
			divisionNteamType : 'division',
			viewType : $("input:radio[name='radioViewType']:checked").val(),
			selectFacePost : $("#selectFacePost").val()
		});
		
		location.href="/salesManagement/listFaceTime.do?" + params;
	}
}
 */



//뷰타입
$("#categoryChange").change(function(){
	//alert("분기,년도 쿼리 수정중에 있습니다.");
	$("#selectFacePost,#selectFaceYear,#selectFaceMonth,#selectFaceQuarter").trigger("change");
});

 
 $("#selectFaceMonth,#selectFaceQuarter").change(function(){
	 var params = $.param({
		 	viewType : $("#categoryChange").val(),
			selectFaceYear : $("#selectFaceYear").val(),
			selectFaceMonth : $("#selectFaceMonth").val(),
			selectFaceQuarter : $("#selectFaceQuarter").val(),
			role : "roleTeam",
			selectFacePost : $("#selectFacePost").val(),
			selectFaceTeam : $("#selectFaceTeam").val(),
			selectFaceMember : $("#selectFaceMember").val(),
		});
		//var param = "?selectFacePost="+$("#selectFacePost").val()+"&selectFaceYear="+$("#selectFaceYear").val()+"&selectFaceMonth="+$("#selectFaceMonth").val();
		 location.href="/calendar/viewProductivity.do?"+params;
});

$("#selectFaceYear").change(function(){
	
	var params = $.param({
			viewType : $("#categoryChange").val(),
			selectFaceYear : $("#selectFaceYear").val(),
//			selectFaceMonth : $("#selectFaceMonth").val(),
//			selectFaceQuarter : $("#selectFaceQuarter").val(),
			role : "roleTeam",
			selectFacePost : $("#selectFacePost").val(),
			selectFaceTeam : $("#selectFaceTeam").val(),
			selectFaceMember : $("#selectFaceMember").val(),
		});
		//var param = "?selectFacePost="+$("#selectFacePost").val()+"&selectFaceYear="+$("#selectFaceYear").val()+"&selectFaceMonth="+$("#selectFaceMonth").val();
		 location.href="/calendar/viewProductivity.do?"+params;
});

$("#selectFaceMember").change(function(){
	
	var params = $.param({
			viewType : $("#categoryChange").val(),
			selectFaceYear : $("#selectFaceYear").val(),
//			selectFaceMonth : $("#selectFaceMonth").val(),
//			selectFaceQuarter : $("#selectFaceQuarter").val(),
			role : "roleTeam",
			selectFacePost : $("#selectFacePost").val(),
			selectFaceTeam : $("#selectFaceTeam").val(),
			selectFaceMember : $("#selectFaceMember").val(),
		});
		//var param = "?selectFacePost="+$("#selectFacePost").val()+"&selectFaceYear="+$("#selectFaceYear").val()+"&selectFaceMonth="+$("#selectFaceMonth").val();
		 location.href="/calendar/viewProductivity.do?"+params;
});

function categoryChange(value){
	var cate_value = $("#categoryChange option:selected").val();
	if(value == '' || value == null){
		value = cate_value;
	}
	
	if(value == 'q'){
		$('#selectFaceMonth').hide();
		$('#selectFaceQuarter').show();
	}else{
		$('#selectFaceQuarter').hide();
		$('#selectFaceMonth').show();
	}
}
</script>




