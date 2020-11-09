<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
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
	height: 600px;
}
</style>

<div class="row wrapper border-bottom white-bg page-heading">
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
				<!-- <div class="ibox-content"> -->
				<div class="clear">
					<div class="pos-rel">
						<div class="func-top-left fl_l">
							<div class="table-menu-wrapper2 fl_l mg-r10 mg-t7 m-b"
								style="display: none">
								<a href="#" class="table-menu-btn" id="table-menu-btn"><i
									class="fa fa-th-list"></i> 항목보기 설정</a>
							</div>
							<div class="table-sel-view fl_l">
								<div class="selgrid selgrid1 mg-r5 viewType"
									name="divSerachYear">
									<select class="form-control m-b" name="selectFaceYear"
										id="selectFaceYear">
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
								<!-- 
								<div class="selgrid selgrid1 mg-r5 viewType"
									name="divSerachMonth">
									<select class="form-control m-b" name="selectFaceMonth"
										id="selectFaceMonth">
										<option value="1">1월</option>
										<option value="2">2월</option>
										<option value="3">3월</option>
										<option value="4">4월</option>
										<option value="5">5월</option>
										<option value="6">6월</option>
										<option value="7">7월</option>
										<option value="8">8월</option>
										<option value="9">9월</option>
										<option value="10">10월</option>
										<option value="11">11월</option>
										<option value="12">12월</option>
									</select>
								</div>
								 -->
								<div class="selgrid selgrid1 mg-r5 viewType"
									name="divSerachMonth">
									<select class="form-control m-b" name="selectFaceMonth"
										id="selectFaceMonth">

										<%-- 
										<c:choose>
											<c:when test="${fn:length(searchDetailGroup.faceMonth) > 0}">
												<c:forEach items="${searchDetailGroup.faceMonth}" var="searchDetailGroup">
													<option value="${searchDetailGroup.FACE_MONTH}">${searchDetailGroup.FACE_MONTH}월</option>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<option value="">== 월 ==</option>
											</c:otherwise>
										</c:choose>
										 --%>
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
									<select class="form-control m-b" name="selectFaceQuarter"
										id="selectFaceQuarter">
										<%-- 
										<c:choose>
											<c:when
												test="${fn:length(searchDetailGroup.faceQuarter) > 0}">
												<c:forEach items="${searchDetailGroup.faceQuarter}" var="searchDetailGroup">
													<option value="${searchDetailGroup.FACE_QUARTER}">${searchDetailGroup.FACE_QUARTER}분기</option>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<option value="">== 분기 ==</option>
											</c:otherwise>
										</c:choose>
										 --%>
										<option value="1">1분기</option>
										<option value="2">2분기</option>
										<option value="3">3분기</option>
										<option value="4">4분기</option>
									</select>
								</div>
								<div class="selgrid selgrid1 mg-r5">
									<select class="form-control m-b" name="selectFacePost"
										id="selectFacePost">
										<c:choose>
											<c:when test="${fn:length(searchDetailGroup.facePost) > 0}">
												<option value="">전체 본부</option>
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
									<input type="radio" name="radioViewType" value="m"
										<c:if test="${viewType eq 'm' or viewType eq null}">checked</c:if>>월
									<input type="radio" name="radioViewType" value="q"
										<c:if test="${viewType eq 'q'}">checked</c:if>>분기 <input
										type="radio" name="radioViewType" value="y"
										<c:if test="${viewType eq 'y'}">checked</c:if>>년도
								</div>
							</div>
						</div>

						<div class="func-top-right fl_r pd-b20"></div>
						<br /> <br /> <br />
						<table id="sellersGrid"></table>
					</div>
					<!-- pos-rel end -->


					<!-- 왼쪽영역 -->
					<div ng-app="myApp">
						<div class="col-sm-6">
							<div ng-controller="MainCtrl">
								<nvd3 options="options" data="data" config="config"
									interactive="true"></nvd3>
							</div>
						</div>

						<!-- 오른쪽 영역 -->
						<div class="col-sm-6">
							<div ng-controller="MainCtrl">
								<nvd3 options="options2" data="data2" config="config"
									interactive="true"></nvd3>
							</div>
						</div>
					</div>

				</div>
				<!-- clear  end -->
			</div>
			<!-- ibox end -->
		</div>
	</div>
</div>

<!-- <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.3.9/angular.min.js"></script> -->

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/nvD3/nvd3/nv.d3.min.css" />
<script src="<%=request.getContextPath()%>/nvD3/d3.min.js"
	charset="utf-8"></script>
<script src="<%=request.getContextPath()%>/nvD3/angular/angular.js"></script>
<script src="<%=request.getContextPath()%>/nvD3/nvd3/nv.d3.min.js"></script>
<script
	src="<%=request.getContextPath()%>/nvD3/angular-nvd3/angular-nvd3.min.js"></script>
<script type="text/javascript">
var gridWidth;
var listRow = 10;
var hearderTitle;
var loadStatus = 0;
$(document).ready(function() {
		$("div.viewType").hide();
	
		if ("${selectFaceMonth}" != null && "${selectFaceMonth}" != "") {
			$("#selectFaceMonth").val("${selectFaceMonth}");
		} else {
			$("#selectFaceMonth").val(commonDate.month);
		}
	
		if ("${selectFaceYear}" != null && "${selectFaceYear}" != "") {
			$("#selectFaceYear").val("${selectFaceYear}");
		} else {
			$("#selectFaceYear").val(commonDate.year);
		}
	
		if ("${selectFaceQuarter}" != null && "${selectFaceQuarter}" != "") {
			$("#selectFaceQuarter").val("${selectFaceQuarter}");
		} else {
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
	
	});
//==========================angluar Graph Start===================================
var app = angular.module('myApp', [ 'nvd3' ]);
app.controller('MainCtrl', function($scope) {
	
		//===========================좌측 그래프======================================
		$scope.options = {
			chart : {
				//multiBarChart
				type : 'multiBarHorizontalChart',
				margin : {
					left : 100,
					//top : 50,
					botoom : 100
				},
				height : 500,
				//                width : 700,
				x : function(d) {
					return d.label;
				},
				y : function(d) {
					return d.value;
				},
				showLegend : true,
				showControls : false,
				showValues : true,
				duration : 700,
				stacked : true,
				groupSpacing : 0.5,
				legendPosition: "right",
				xAxis : {
					showMaxMin : false
	
				},
				yAxis : {
					//axisLabel: 'Values',
					tickFormat : function(d) {
						return d3.format(',f')(d) + "%";
					}
				}
			}
		};
	
		$scope.config = {
			visible : true, //그래프 보이기 안보이기  true/false
		}
	
		$scope.grid = $
				.ajax({
					url : "/salesManagement/gridFaceTime.do",
					async : false,
					datatype : 'json',
					method : 'POST',
					data : {
						selectFaceYear : $("#selectFaceYear").val(),
						selectFaceMonth : $("#selectFaceMonth").val(),
						selectFaceQuarter : $("#selectFaceQuarter").val(),
						//selectFacePost:$("#selectFacePost").val(),
						viewType : $( "input:radio[name='radioViewType']:checked").val(),
						selectFaceYear : function() {
							if ("${selectFaceYear}" != null && "${selectFaceYear}" != "") {
								return "${selectFaceYear}";
							} else {
								return commonDate.year;
							}
						},
						selectFaceMonth : function() {
							if ("${selectFaceMonth}" != null && "${selectFaceMonth}" != "") {
								return "${selectFaceMonth}";
							} else {
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
						gridTabFlag : "Y",
						skipAvgTab : "Y",
					},
					beforeSend : function() {
						$.ajaxLoading();
					},
					success : function(data) {
	
						//좌측 Graph 그리기
	
						var scheduleArr1 = new Array(); //고객컨택
						var schedule1 = new Object();
	
						var scheduleArr2 = new Array(); //컨택준비
						var schedule2 = new Object();
	
						var scheduleArr3 = new Array(); //내부회의
						var schedule3 = new Object();
	
						var scheduleArr4 = new Array(); //교육
						var schedule4 = new Object();
	
						var scheduleArr6 = new Array(); //기타
						var schedule6 = new Object();
	
						var scheduleArr7 = new Array(); //휴가
						var schedule7 = new Object();
	
						var scheduleArr5 = new Array(); //이동시간
						var schedule5 = new Object();
	
						
						var noScheduleArr = new Array(); //미입력
						var noSchedule = new Object();
						
	
						for (var i = 0; i < data.rows.length; i++) {
							/* 
							if (i == data.rows.length - 1) {
								data.rows[i].DIVISION_NAME = '회사평균';
							}
							 */
							/* 
							if(data.rows[i].DIVISION_NAME == null){
							data.rows[i].DIVISION_NAME = '평균';
							}
							 */
							 
							//string 사업본부 제거
							var divisionName_scheduleLabel= data.rows[i].DIVISION_NAME.replace("사업본부", "");
							divisionName_scheduleLabel = divisionName_scheduleLabel.replace("사업부", "");
							
							//고객컨택
							schedule1 = new Object();
							schedule1.label = divisionName_scheduleLabel;
							schedule1.value = data.rows[i].THIS_EVENT_PERCENT_1 * 1;
	
							scheduleArr1.push(schedule1);
	
							//컨택준비
							schedule2 = new Object();
							schedule2.label = divisionName_scheduleLabel;
							schedule2.value = data.rows[i].THIS_EVENT_PERCENT_2 * 1;
	
							scheduleArr2.push(schedule2);
	
							//내부회의
							schedule3 = new Object();
							schedule3.label = divisionName_scheduleLabel;
							schedule3.value = data.rows[i].THIS_EVENT_PERCENT_3 * 1;
	
							scheduleArr3.push(schedule3);
	
							//교육
							schedule4 = new Object();
							schedule4.label = divisionName_scheduleLabel;
							schedule4.value = data.rows[i].THIS_EVENT_PERCENT_4 * 1;
	
							scheduleArr4.push(schedule4);
	
							//기타
							schedule6 = new Object();
							schedule6.label = divisionName_scheduleLabel;
							schedule6.value = data.rows[i].THIS_EVENT_PERCENT_6 * 1;
	
							scheduleArr6.push(schedule6);
	
							//휴가
							schedule7 = new Object();
							schedule7.label = divisionName_scheduleLabel;
							schedule7.value = data.rows[i].THIS_EVENT_PERCENT_7 * 1;
	
							scheduleArr7.push(schedule7);
	
							//이동시간
							schedule5 = new Object();
							schedule5.label = divisionName_scheduleLabel;
							schedule5.value = data.rows[i].THIS_EVENT_PERCENT_5 * 1;
	
							scheduleArr5.push(schedule5);
							
	
							//미입력
							noSchedule = new Object();
							noSchedule.label = divisionName_scheduleLabel;
							noSchedule.value = data.rows[i].THISOTHER * 1;
	
							noScheduleArr.push(noSchedule);
						}
	
						var totalInfo1 = new Object();
						totalInfo1.key = "고객컨택";
						totalInfo1.color = "#019fd5";
						totalInfo1.values = scheduleArr1;
	
						var totalInfo2 = new Object();
						totalInfo2.key = "컨택준비";
						totalInfo2.color = "#51cbd5";
						totalInfo2.values = scheduleArr2;
	
						var totalInfo3 = new Object();
						totalInfo3.key = "내부회의";
						totalInfo3.color = "#f352b0";
						totalInfo3.values = scheduleArr3;
	
						var totalInfo4 = new Object();
						totalInfo4.key = "교육";
						totalInfo4.color = "#6a66cc";
						totalInfo4.values = scheduleArr4;
	
						var totalInfo6 = new Object();
						totalInfo6.key = "기타";
						totalInfo6.color = "#b9b9ba";
						totalInfo6.values = scheduleArr6;
	
						var totalInfo7 = new Object();
						totalInfo7.key = "휴가";
						totalInfo7.color = "#abce01";
						totalInfo7.values = scheduleArr7;
	
						var totalInfo5 = new Object();
						totalInfo5.key = "이동시간";
						totalInfo5.color = "#ffcc01";
						totalInfo5.values = scheduleArr5;
						
	
						var totalNoSchedule = new Object();
						//totalNoSchedule.key = "미입력";
						totalNoSchedule.color = "#ffffff";
						//totalNoSchedule.color = "#fc0505";
						totalNoSchedule.values = noScheduleArr;
	
						//var jsonInfo = JSON.stringify(totalInfo1);
	
						//Graph Data
						$scope.data = [ totalInfo1, totalInfo2,
								totalInfo3, totalInfo4,
								totalInfo6, totalInfo7,
								totalInfo5, totalNoSchedule ]
	
						///////////////////////////////
						// 우측 그래프 데이터
						var dataObj = new Object();
						var dataObjArray = new Array();
						var color ="";
						for (var i = 0; i < data.rows.length; i++) 
						{
							//string 사업본부 제거
							var divisionName_dataObjLabel= data.rows[i].DIVISION_NAME.replace("사업본부", "");
							divisionName_dataObjLabel = divisionName_dataObjLabel.replace("사업부", "");
							
							if (i == data.rows.length - 1) 
							{
								//data.rows[i].DIVISION_NAME = '회사평균';
								
								dataObj = new Object();
								dataObj.label = divisionName_dataObjLabel;
								dataObj.value = data.rows[i].avr;
								dataObj.color = "#f1b9f1";
							}
							else
							{
								dataObj = new Object();
								dataObj.label = divisionName_dataObjLabel;
								dataObj.value = data.rows[i].avr;
								dataObj.color = "#bcbaf2";
							}
	
							dataObjArray.push(dataObj);
						}
	
						var totalDataObj = new Object();
						totalDataObj.key = "누적 평균시간";
						totalDataObj.color = "#bcbaf2";
						totalDataObj.values = dataObjArray;
	
						//Graph Data2
						$scope.data2 = [ totalDataObj ]
	
					},
					complete : function() {
						$.ajaxLoadingHide();
					}
				});
	
		////////////////////////// 우측 그래프 옵션 ///////////////////////////////////
	
		$scope.options2 = {
			chart : {
				//type: 'discreteBarChart',
				type : 'multiBarChart',
				margin : {
					//left : 100,
					//right : 100,
					botoom : 100
				},
				height : 500,
				//                width : 700,
				x : function(d) {
					return d.label;
				},
				y : function(d) {
					return d.value;
				},
				//              showLegend:false,
				//staggerLabels:true,
				showControls : false,
				showValues : "show",
				reduceXTicks : false,
				groupSpacing : 0.5,
				duration : 1200,
				legend:{
					position: 'right'
				},
				showXAxis: true,
				showYAxis: true,
				xAxis : {
					showMaxMin : false,
					rotateLabels : -20
				},
				yAxis : {
					//showValues : true,
					//axisLabel: 'Values',
					//max : 100,
				 	tickFormat : function(d) {
						return d3.format('.1f')(d) + "시간";
					}
				},
	
				//차크 click 할 때, Action
				callback : function(chart) {
					d3.selectAll(".nv-bar").on('click',
							function() {
								//alert("Hi, I'm Hoon");
							});
				}
	
			}
		};
	});


//뷰타입
 $("input:radio[name='radioViewType']").click(function(){
	// alert("분기,년도 쿼리 수정중에 있습니다.");
 	$("#selectFaceYear,#selectFaceMonth,#selectFaceQuarter").trigger("change");
 });
	 
//조건 검색 
$("#selectFaceMonth,#selectFaceQuarter").change(function(){
 var params = $.param({
		viewType : $("input:radio[name='radioViewType']:checked").val(),
		selectFaceYear : $("#selectFaceYear").val(),
		selectFaceMonth : $("#selectFaceMonth").val(),
		selectFaceQuarter : $("#selectFaceQuarter").val(),
		selectFacePost : $("#selectFacePost").val(),
		role : "roleCeo"
	});
	//var param = "?selectFacePost="+$("#selectFacePost").val()+"&selectFaceYear="+$("#selectFaceYear").val()+"&selectFaceMonth="+$("#selectFaceMonth").val();
	 location.href="/salesManagement/viewProductivity.do?"+params;
});


// 현재 2017년 1월이고, select 박스에서 2016년 선택하고 3월을 선택후, 다시 2017년을 선택하면 3월에 대한 데이터가 2017년에는 없기 때문에 에러
// 그래서 2016년 3월 선택후, 2017년으로 년도를 바꾸면 현재 달로 선택되게끔 
$("#selectFaceYear").change(function(){
	 var params = $.param({
			viewType : $("input:radio[name='radioViewType']:checked").val(),
			selectFaceYear : $("#selectFaceYear").val(),
//			selectFaceQuarter : $("#selectFaceQuarter").val(),
			selectFacePost : $("#selectFacePost").val(),
			role : "roleCeo"
		});
		//var param = "?selectFacePost="+$("#selectFacePost").val()+"&selectFaceYear="+$("#selectFaceYear").val()+"&selectFaceMonth="+$("#selectFaceMonth").val();
		 location.href="/salesManagement/viewProductivity.do?"+params;
	});

	 
$("#selectFacePost").change(function() {
	var params = $.param({
		//divisionNteamType : 'division',
		role : "roleCeo",
		roleChildDivision : "Y",
		viewType : $("input:radio[name='radioViewType']:checked").val(),
		selectFaceYear : $("#selectFaceYear").val(),
		selectFaceMonth : $("#selectFaceMonth").val(),
		selectFaceQuarter : $("#selectFaceQuarter").val(),
		selectFacePost : $("#selectFacePost").val(),
	});
	//var param = "?selectFacePost="+$("#selectFacePost").val()+"&selectFaceYear="+$("#selectFaceYear").val()+"&selectFaceMonth="+$("#selectFaceMonth").val();
	location.href = "/salesManagement/viewProductivity.do?" + params;
});
</script>



<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>