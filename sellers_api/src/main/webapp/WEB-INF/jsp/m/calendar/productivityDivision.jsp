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

<!-- 
 * @author 	: 욱이
 * @Date		: 2016. 07 - 07
 * @explain	: 영업관리 -> Face Time
 -->
<style>
.nv-legend {
	transform: translate(0px, 490px);
}

svg.nvd3-svg {
	height: 530px;
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
				<%-- <select class="form-control m-b" name="selectFaceTeam" id="selectFaceTeam" readonly="readonly" disabled style="display: none;">
					<c:choose>
						<c:when test="${fn:length(searchDetailGroup.facePost) > 0}">
							<!-- <option value="" selected='selected'>팀</option> -->
							<c:forEach items="${searchDetailGroup.facePost}"
								var="searchDetailGroup">
								<option value="${searchDetailGroup.TEAM_NAME}" selected="selected">${searchDetailGroup.TEAM_NAME}</option>
							</c:forEach>
						</c:when>
					</c:choose>
				</select> --%>
				
				<select class="form-control m-b" name="selectFacePost" id="selectFacePost" readonly="readonly" disabled>
					<c:choose>
						<c:when test="${fn:length(searchDetailGroup.facePost) > 0}">
							<!-- <option value="">== 본부 ==</option> -->
							<c:forEach items="${searchDetailGroup.facePost}"
								var="searchDetailGroup">
								<option value="${searchDetailGroup.DIVISION_NAME}"
									<c:if test="${selectFacePost eq searchDetailGroup.DIVISION_NAME}">selected="selected"</c:if>>${searchDetailGroup.DIVISION_NAME}</option>
							</c:forEach>
						</c:when>
					</c:choose>
				</select>
				
				<select class="form-control m-b" name="selectFaceTeam" id="selectFaceTeam">
					<c:choose>
						<c:when test="${fn:length(searchDetailGroup.faceTeam) > 0}">
							<option value="" selected='selected'>부서전체</option>
							<c:forEach items="${searchDetailGroup.faceTeam}" var="searchDetailGroup">
								<option value="${searchDetailGroup.TEAM_NAME}" <c:if test="${param.selectFaceMember == searchDetailGroup.TEAM_NAME}" >selected="selected" </c:if>>${searchDetailGroup.TEAM_NAME}</option>
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
		
<%-- <div class="row wrapper border-bottom white-bg page-heading">
	<div class="col-sm-4">
		<h2>생산성</h2>
		<ol class="breadcrumb">
			<li><a href="/main/index.do">Home</a></li>
			<li><a>성과관리</a></li>
			<li class="active"><strong>생산성</strong></li>
		</ol>
	</div>
</div>

<div class="wrapper wrapper-content  animated fadeInRight">
	<div class="row">
		<div class="col-sm-12">
			<div class="ibox">
				<div class="clear">
					<div class="pos-rel ofHidden">
						<div class="func-top-left fl_l">
							<div class="table-menu-wrapper2 fl_l mg-r10 mg-t7 m-b"
								style="display: none">
								<a href="#" class="table-menu-btn" id="table-menu-btn"><i
									class="fa fa-th-list"></i> 항목보기 설정</a>
								<div class="table-menu" style="z-index: 1000; display: none;">
									<ul>
										<li><input type="checkbox" name="toggle-cols"
											value="OPP_HW" checked="checked"> <label
											for="toggle-col-1">IBM H/W(기회)</label></li>
										<li><input type="checkbox" name="toggle-cols"
											value="SALES_HW" checked="checked"> <label
											for="toggle-col-2">IBM H/W(매출)</label></li>
										<li><input type="checkbox" name="toggle-cols"
											value="ALIGN_HW" checked="checked"> <label
											for="toggle-col-3">IBM H/W(Align)</label></li>
										<li><input type="checkbox" name="toggle-cols"
											value="STATUS_HW" checked="checked"> <label
											for="toggle-col-4">IBM H/W(Status)</label></li>

										<li><input type="checkbox" name="toggle-cols"
											value="OPP_SW" checked="checked"> <label
											for="toggle-col-5">IBM S/W(기회)</label></li>
										<li><input type="checkbox" name="toggle-cols"
											value="SALES_SW" checked="checked"> <label
											for="toggle-col-6">IBM S/W(매출)</label></li>
										<li><input type="checkbox" name="toggle-cols"
											value="ALIGN_SW" checked="checked"> <label
											for="toggle-col-7">IBM S/W(Align)</label></li>
										<li><input type="checkbox" name="toggle-cols"
											value="STATUS_SW" checked="checked"> <label
											for="toggle-col-8">IBM S/W(Status)</label></li>

										<li><input type="checkbox" name="toggle-cols"
											value="OPP_AH" checked="checked"> <label
											for="toggle-col-9">AHNLAB(기회)</label></li>
										<li><input type="checkbox" name="toggle-cols"
											value="SALES_AH" checked="checked"> <label
											for="toggle-col-10">AHNLAB(매출)</label></li>
										<li><input type="checkbox" name="toggle-cols"
											value="ALIGN_AH" checked="checked"> <label
											for="toggle-col-11">AHNLAB(Align)</label></li>
										<li><input type="checkbox" name="toggle-cols"
											value="STATUS_AH" checked="checked"> <label
											for="toggle-col-12">AHNLAB(Status)</label></li>
									</ul>
								</div>
							</div>
							<div class="table-sel-view fl_l">
								<div class="selgrid selgrid1 mg-r5 viewType"
									name="divSerachYear">
									<select class="form-control m-b" name="selectFaceYear" id="selectFaceYear">
										<c:choose>
											<c:when test="${fn:length(searchDetailGroup.faceYear) > 0}">
												<c:forEach items="${searchDetailGroup.faceYear}"
													var="searchDetailGroup">
													<option value="${searchDetailGroup.FACE_YEAR}">${searchDetailGroup.FACE_YEAR}년</option>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<option value="">== 년도 ==</option>
											</c:otherwise>
										</c:choose>
									</select>
								</div>
								<div class="selgrid selgrid1 mg-r5 viewType"
									name="divSerachMonth">
									<select class="form-control m-b" name="selectFaceMonth" id="selectFaceMonth">
										
                                                    <c:choose>
														<c:when test="${fn:length(searchDetailGroup.faceMonth) > 0}">
															<c:forEach items="${searchDetailGroup.faceMonth}" var="searchDetailGroup">
							                                    <option value="${searchDetailGroup.FACE_MONTH}">${searchDetailGroup.FACE_MONTH}월</option>
				                                    		</c:forEach>
				                                    	</c:when>
				                                    	<c:otherwise>
				                                    			<option value="">== 년도 ==</option>
				                                    	</c:otherwise>
				                                    </c:choose>
				                                    
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
								</div>
								<div class="selgrid selgrid1 mg-r5 viewType"
									name="divSerachQuarter">
									<select class="form-control m-b" name="selectFaceQuarter" id="selectFaceQuarter">
										
                                                    <c:choose>
														<c:when test="${fn:length(searchDetailGroup.faceQuarter) > 0}">
															<c:forEach items="${searchDetailGroup.faceQuarter}" var="searchDetailGroup">
							                                    <option value="${searchDetailGroup.FACE_QUARTER}">${searchDetailGroup.FACE_QUARTER}분기</option>
				                                    		</c:forEach>
				                                    	</c:when>
				                                    	<c:otherwise>
				                                    			<option value="">== 분기 ==</option>
				                                    	</c:otherwise>
				                                    </c:choose>
				                                    
										<option value="1">1분기</option>
										<option value="2">2분기</option>
										<option value="3">3분기</option>
										<option value="4">4분기</option>
									</select>
								</div>

								<div class="selgrid selgrid1 mg-r5">
									<select class="form-control m-b" name="selectFacePost" id="selectFacePost" readonly="readonly" disabled>
										<c:choose>
											<c:when test="${fn:length(searchDetailGroup.facePost) > 0}">
												<!-- <option value="">== 본부 ==</option> -->
												<c:forEach items="${searchDetailGroup.facePost}"
													var="searchDetailGroup">
													<option value="${searchDetailGroup.DIVISION_NAME}"
														<c:if test="${selectFacePost eq searchDetailGroup.DIVISION_NAME}">selected="selected"</c:if>>${searchDetailGroup.DIVISION_NAME}</option>
												</c:forEach>
											</c:when>
										</c:choose>
									</select>
								</div>

								<div class="selgrid selgrid1 mg-r5">
									<select class="form-control m-b" name="selectFaceTeam" id="selectFaceTeam">
										<c:choose>
											<c:when test="${fn:length(searchDetailGroup.faceTeam) > 0}">
												<option value="" selected='selected'>팀 전체</option>
												<c:forEach items="${searchDetailGroup.faceTeam}"
													var="searchDetailGroup">
													<option value="${searchDetailGroup.TEAM_NAME}">${searchDetailGroup.TEAM_NAME}</option>
												</c:forEach>
											</c:when>
										</c:choose>
									</select>
								</div>


								
                                            <div class="selgrid selgrid1 mg-r5">
                                                <select class="form-control m-b" name="selectFaceMember" id="selectFaceMember">
			                                    	<c:choose>
														<c:when test="${fn:length(searchDetailGroup.faceMember) > 0}">
																<option value="" selected='selected'>팀원</option>
															<c:forEach items="${searchDetailGroup.faceMember}" var="searchDetailGroup">
							                                    <option value="${searchDetailGroup.HAN_NAME}">${searchDetailGroup.HAN_NAME}</option>
				                                    		</c:forEach>
				                                    	</c:when>
				                                    </c:choose>
		                                   		</select>
                                            </div>
                                            

								<div class="selgrid selgrid1 mg-r5">
									<input type="radio" name="radioViewType" value="m"
										<c:if test="${viewType eq 'm' or viewType eq null}">checked</c:if>>월
									<input type="radio" name="radioViewType" value="q"
										<c:if test="${viewType eq 'q'}">checked</c:if>>분기 <input
										type="radio" name="radioViewType" value="y"
										<c:if test="${viewType eq 'y'}">checked</c:if>>년도
								</div>
							</div>
						</div>
					</div>
					<!-- pos-rel end -->


				<div id="DivisionGraph"></div>

				<!-- 그리드 탭  -->
				<div class="tabs-container mg-b20" id="memberList">
					<br />
						<ul class="nav nav-tabs mg-b20" id="memberListTab"></ul>
				</div>
			</div>
			<!-- ibox end -->
		</div>
	</div>
</div> --%>
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
	// 구글차트 로드
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
	
	$('#page-wrapper > div.wrapper.wrapper-content.animated.fadeInRight > div > div > div > div > div.ng-scope > div:nth-child(1) > div > nvd3 > svg').css('height', '550px');
	$('#page-wrapper > div.wrapper.wrapper-content.animated.fadeInRight > div > div > div > div > div.ng-scope > div:nth-child(2) > div > nvd3 > svg').css('height', '550px');
	
	
	//jqGrid.draw();
	
	function drawChart(){
		var divisionName = '${divisionName.DIVISION_NAME}';
		var teamName = '<c:out value = "${param.selectFaceTeam}" />';
		
		var params = $.param({
			datatype : 'html',
			jsp : '/calendar/selectDivisionMainGraphAjax',
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
					return commonDate.quarter(commonDate.month);
				}
			},
			
			//selectFacePost:$("#selectFacePost").val(),
			//selectFaceTeam:$("#selectFaceTeam").val(),
			selectFacePost:$("#selectFacePost").val(),
			selectFaceTeam:$("#selectFaceTeam").val(),
			selectFaceMember:$("#selectFaceMember").val(),
			viewType :$("#categoryChange").val(),
			gridTabFlag : "Y",
			skipAvgTab : "Y",
			roleChildDivision : "Y",
			divisionName : divisionName
		});
		console.log(params);
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
$("input:radio[name='radioViewType']").click(function(){
	//alert("분기,년도 쿼리 수정중에 있습니다.");
	$("#selectFaceYear,#selectFaceMonth,#selectFaceQuarter").trigger("change");
});

//조건 검색 
$("#selectFaceMonth,#selectFaceQuarter").change(function(){
 var params = $.param({
		viewType : $("#categoryChange").val(),
		selectFaceYear : $("#selectFaceYear").val(),
		selectFaceMonth : $("#selectFaceMonth").val(),
		selectFaceQuarter : $("#selectFaceQuarter").val(),
		selectFacePost : $("#selectFacePost").val(),
		role : "roleDivision",
		myProduction : '${param.myProduction}'
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
			selectFacePost : $("#selectFacePost").val(),
			role : "roleDivision",
			myProduction : '${param.myProduction}'
		});
		//var param = "?selectFacePost="+$("#selectFacePost").val()+"&selectFaceYear="+$("#selectFaceYear").val()+"&selectFaceMonth="+$("#selectFaceMonth").val();
		 location.href="/calendar/viewProductivity.do?"+params;
	});

//조건 검색 
$("#selectFaceTeam").change(function(){
	
	 var params = $.param({
			viewType : $("#categoryChange").val(),
			selectFaceYear : $("#selectFaceYear").val(),
			selectFaceMonth : $("#selectFaceMonth").val(),
			selectFaceQuarter : $("#selectFaceQuarter").val(),
			role : "roleDivision",
			roleChild : "Y",
			selectFacePost : $("#selectFacePost").val(),
			selectFaceTeam : $("#selectFaceTeam").val(),
			hiddenUserId : $("#hiddenUserId").val(),
			myProduction : '${param.myProduction}'
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

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>