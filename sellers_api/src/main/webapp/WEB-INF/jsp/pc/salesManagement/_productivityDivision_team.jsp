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
	height: 1000px;
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
				<div class="clear">
					<div class="pos-rel">
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
				                                    			<option value="">== 년도 ==</option>
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
														<c:when test="${fn:length(searchDetailGroup.faceQuarter) > 0}">
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
										id="selectFacePost" readonly="readonly" disabled>
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
									<select class="form-control m-b" name="selectFaceTeam"
										id="selectFaceTeam">
										<c:choose>
											<c:when test="${fn:length(searchDetailGroup.faceTeam) > 0}">
												<!-- <option value="" selected='selected'>팀</option> -->
												<c:forEach items="${searchDetailGroup.faceTeam}"
													var="searchDetailGroup">
													<option value="${searchDetailGroup.TEAM_NAME}"
														<c:if test="${selectFaceTeam eq searchDetailGroup.TEAM_NAME}">selected="selected"</c:if>>${searchDetailGroup.TEAM_NAME}</option>
												</c:forEach>
											</c:when>
										</c:choose>
									</select>
								</div>


								<%-- 
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
                                             --%>

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
						
						<!-- 그리드 데이터 -->
						<div class="tabs-container mg-b20" id="memberList">
							<ul class="nav nav-tabs mg-b20" id="memberListTab">
							</ul>
						</div>
						<div id="memberTable"></div>

						<div style="display: none">
							<div class="func-top-right fl_r pd-b20"></div>
							<br /> <br /> <br />
							<table id="sellersGrid"></table>
						</div>

						<!-- 상위 부서 이동 영역 -->
						<div class="fc-clear col-sm-12 pd-no mg-b20">
							<div class="btn-product-group">
								<a href="#" class="btn-movup first" onclick="backTeam.conn();">본부
									전체보기</a>
							</div>
						</div>

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
				</div>

				<!-- <div class="func-top-right fl_r pd-b20"></div> -->
				<!--  <table id="sellersGridMember"></table>     -->


			</div>
		</div>
	</div>
</div>
</body>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/nvD3/nvd3/nv.d3.min.css" />
<script src="<%=request.getContextPath()%>/nvD3/d3.min.js"
	charset="utf-8"></script>
<script src="<%=request.getContextPath()%>/nvD3/angular/angular.js"></script>
<script src="<%=request.getContextPath()%>/nvD3/nvd3/nv.d3.min.js"></script>
<script
	src="<%=request.getContextPath()%>/nvD3/angular-nvd3/angular-nvd3.min.js"></script>
<script type="text/javascript">
/*
 *  전역변수
 */
var gridWidth;
var listRow = 10;
var hearderTitle;
var gridStatus=true;

$(document).ready(function() {
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
	jqGrid.draw();
});
/* 
//본부별로 돌아가기
var backDivision = {
	conn : function() {
		location.href="/salesManagement/listFaceTime.do?"
	}
}
 */
//본부 전체보기
var backTeam = {
	conn : function() {
		var params = $.param({
			//divisionNteamType : 'division',
			role : "roleDivision",
			viewType : $("input:radio[name='radioViewType']:checked").val(),
			selectFacePost : $("#selectFacePost").val()
		});
		
		location.href="/salesManagement/viewProductivity.do?" + params;
	}
}

//==========================angluar Graph Start===================================
var app = angular.module('myApp', ['nvd3']);
app.controller('MainCtrl', function ($scope) {
    
//===========================좌측 그래프==========================================
	$scope.options = {
        chart: {
            type: 'multiBarHorizontalChart',
			margin:{
				right:50,
				left:140,
				botoom:100
			},
            height: 500,
//            width : 700,
            x: function (d) { return d.label; },
            y: function (d) { return d.value; },
            showControls: false,
            showValues: true,
            duration: 700,
            stacked: true,
            groupSpacing:0.7,
            legend: {
                //vers: 'furious'
            },
            legendPosition: 'right',
            xAxis: {
                showMaxMin: false,
            },
            yAxis: {
                //axisLabel: 'Values',
                tickFormat: function (d) {
                    return d3.format(',f')(d) + "%";
                }
            }
        }
    };
    
    $scope.config = {
    		visible : true,	//그래프 보이기 안보이기  true/false
    }
    
    $scope.grid = $.ajax({
		url : "/salesManagement/gridFaceTime.do",
		async : false,
			datatype : 'json',
			method: 'POST',
		data : {
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
			viewType : $("input:radio[name='radioViewType']:checked").val(),
			roleChild : "Y",
			selectFacePost:$("#selectFacePost").val(),
			selectFaceTeam:$("#selectFaceTeam").val(),
			gridTabFlag : "Y",
			skipAvgTab : "Y",
			roleChildTeam :"Y"
		},
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
			$.ajaxLoading();
		},
		success : function(data){
			//좌측 Graph 그리기
			
			var scheduleArr1 = new Array();		//고객컨택
          	var schedule1 = new Object();

			var scheduleArr2 = new Array();		//컨택준비
          	var schedule2 = new Object();

			var scheduleArr3 = new Array();		//내부회의
          	var schedule3 = new Object();

			var scheduleArr4 = new Array();		//교육
          	var schedule4 = new Object();

			var scheduleArr6 = new Array();		//기타
          	var schedule6 = new Object();

			var scheduleArr7 = new Array();		//휴가
          	var schedule7 = new Object();

			var scheduleArr5 = new Array();		//이동시간
          	var schedule5 = new Object();
			
			var noScheduleArr = new Array();	//미입력
			var noSchedule	= new Object();

			for(var i=0; i<data.rows.length; i++){
				
				if(data.rows[i].HAN_NAME ==  null) {
					
					data.rows[i].HAN_NAME = '팀 평균';
				}
					//고객컨택
   				schedule1 = new Object();
   				schedule1.label = data.rows[i].HAN_NAME;
   				schedule1.value = data.rows[i].THIS_EVENT_PERCENT_1*1;
   				  
   				scheduleArr1.push(schedule1);
   				
   				//컨택준비
   				schedule2 = new Object();
   				schedule2.label = data.rows[i].HAN_NAME;
   				schedule2.value = data.rows[i].THIS_EVENT_PERCENT_2*1;
   				  
   				scheduleArr2.push(schedule2);
   				
   				//내부회의
   				schedule3 = new Object();
   				schedule3.label = data.rows[i].HAN_NAME;
   				schedule3.value = data.rows[i].THIS_EVENT_PERCENT_3*1;
   				  
   				scheduleArr3.push(schedule3);
   				
   				//교육
   				schedule4 = new Object();
   				schedule4.label = data.rows[i].HAN_NAME;
   				schedule4.value = data.rows[i].THIS_EVENT_PERCENT_4*1;
   				  
   				scheduleArr4.push(schedule4);
   				
   				//기타
   				schedule6 = new Object();
   				schedule6.label = data.rows[i].HAN_NAME;
   				schedule6.value = data.rows[i].THIS_EVENT_PERCENT_6*1;
   				  
   				scheduleArr6.push(schedule6);
   				
   				//휴가
   				schedule7 = new Object();
   				schedule7.label = data.rows[i].HAN_NAME;
   				schedule7.value = data.rows[i].THIS_EVENT_PERCENT_7*1;
   				  
   				scheduleArr7.push(schedule7);
   				
   				//이동시간
   				schedule5 = new Object();
   				schedule5.label = data.rows[i].HAN_NAME;
   				schedule5.value = data.rows[i].THIS_EVENT_PERCENT_5*1;
   				  
   				scheduleArr5.push(schedule5);
   				
   				
   				//미입력
   				noSchedule = new Object();
   				noSchedule.label = data.rows[i].HAN_NAME;
   				noSchedule.value = data.rows[i].THISOTHER*1;
   				
   				noScheduleArr.push(noSchedule);
				
			}
			
			var totalInfo1 = new Object();
			totalInfo1.key="고객컨택";
			totalInfo1.color="#019fd5";
			totalInfo1.values = scheduleArr1;

			var totalInfo2 = new Object();
			totalInfo2.key="컨택준비";
			totalInfo2.color="#51cbd5";
			totalInfo2.values = scheduleArr2;
			
			var totalInfo3 = new Object();
			totalInfo3.key="내부회의";
			totalInfo3.color="#f352b0";
			totalInfo3.values = scheduleArr3;
			
			var totalInfo4 = new Object();
			totalInfo4.key="교육";
			totalInfo4.color="#6a66cc";
			totalInfo4.values = scheduleArr4;
			
			var totalInfo6 = new Object();
			totalInfo6.key="기타";
			totalInfo6.color="#b9b9ba";
			totalInfo6.values = scheduleArr6;
			
			var totalInfo7 = new Object();
			totalInfo7.key="휴가";
			totalInfo7.color="#abce01";
			totalInfo7.values = scheduleArr7;
			
			var totalInfo5 = new Object();
			totalInfo5.key="이동시간";
			totalInfo5.color="#ffcc01";
			totalInfo5.values = scheduleArr5;
			
			
			var totalNoSchedule = new Object();
			//totalNoSchedule.key="미입력";
			totalNoSchedule.color = "#ffffff";
			//totalNoSchedule.color="#fc0505";
			totalNoSchedule.values = noScheduleArr;
			
			//var jsonInfo = JSON.stringify(totalInfo1);
			
			//Graph Data
			$scope.data = [
							totalInfo1, totalInfo2, totalInfo3, totalInfo4, totalInfo6, totalInfo7, totalInfo5, totalNoSchedule
			           ]
			
			
			
			///////////////////////////////
			// 우측 그래프 데이터
			var dataObj = new Object();
			var dataObjArray = new Array();
			
			for(var i=0; i<data.rows.length; i++){
				
				if(data.rows[i].HAN_NAME !=null)
				{
					if(data.rows[i].HAN_NAME == "회사평균")
					{
						//data.rows[i].HAN_NAME = '회사평균';
						
						dataObj = new Object();
						dataObj.label = data.rows[i].HAN_NAME;
						dataObj.value = data.rows[i].avr;
						dataObj.color = "#f1b9f1";
					}
					else
					{
						dataObj = new Object();
	    				dataObj.label = data.rows[i].HAN_NAME;
	    				dataObj.value = data.rows[i].avr;
	    				dataObj.color = "#bcbaf2";
					}
    				  
    				dataObjArray.push(dataObj);
				}
			}
			
			var totalDataObj = new Object();
			totalDataObj.key="누적 평균시간";
			totalDataObj.color= "#bcbaf2";
			totalDataObj.values = dataObjArray;
			
			//Graph Data2
			$scope.data2 = [totalDataObj]
			
		},
		complete : function(){
			$.ajaxLoadingHide();
		}
	});
    
    
    ////////////////////////// 우측 그래프 옵션 ///////////////////////////////////
    
    $scope.options2 = {
        chart: {
            type: 'multiBarChart',
            margin:{
				//left:100,
				//right:100,
				botoom:100
			},
            height: 500,
//            width : 700,
            x: function (d) { return d.label; },
            y: function (d) { return d.value; },
            showControls: false,
            showValues: true,
            reduceXTicks:false,
            groupSpacing:0.7,
            duration: 1000,
            legendPosition: 'right',
            xAxis: {
                showMaxMin: false,
                barWidth: 20,
                rotateLabels: -20,  // x축 기울기
                rangeBand: 5
            },
            yAxis: {
                //axisLabel: 'Values',
                max : 100,
                tickFormat: function (d) {
                    return d3.format(',.1f')(d) + "시간";
                }
            },
            
            //차크 click 할 때, Action
            callback:function(chart){
            	d3.selectAll(".nv-bar").on('click', function(){
                //alert("Hi, I'm Hoon");
              });
            }
            
        }
    };
});

/*
 *  jqGrid function()
 */
var jqGrid = {
	draw : function() {
		$sellersGrid.jqGrid({
 			url : "/salesManagement/gridFaceTime.do?",
			datatype : 'json',
			mtype: 'POST',
			postData : { 
				gridTabFlag : "Y",
				roleChild : "Y",
				selectFaceYear:$("#selectFaceYear").val(), 
				selectFaceMonth:$("#selectFaceMonth").val(), 
				selectFaceQuarter:$("#selectFaceQuarter").val(), 
				selectFacePost:$("#selectFacePost").val(),
				selectFaceTeam:$("#selectFaceTeam").val(),
				viewType : $("input:radio[name='radioViewType']:checked").val()
			},
			 jsonReader : { 
			    root: "rows"
			},
			loadui: 'disable',
			loadonce : true,
			viewrecords : true,
			gridview: true,	
			//rowList : [ 10, 20, 30 ],
			autowidth : true,
			height : "100%",
			rowNum : 1000,
			//sortable:true, 컬럼 위치 마우스 드래그로 바꾸는건데 버그있는듯? 확인 필요
			onCellSelect : function(ids, icol) {
			},
			onPaging : function(action) { //paging 부분의 버튼 액션 처리  first, prev, next, last, records
				/*  if(action == 'next'){
					currPage = getGridParam("page");
				} */
			},
			//sortname:'MEMBER_POST',
			loadBeforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
				//$.ajaxLoadingShow();
				$sellersGrid.parents('div.ui-jqgrid-bdiv').css("max-height","450px");
				var colLabelCompare;
				var colLabel;

			},
			loadComplete : function(data){
				
				//그리드
//				jqGrid.getMemberList(data.rows[0].TEAM_NAME);
				jqGrid.getMemberTable(data.rows[0].TEAM_NAME);
				
				for(i=0; i<data.rows.length; i++){
					if(i==0){
//						$("#memberListTab").append('<li class="active"><a data-toggle="tab" onClick="jqGrid.getMemberList('+"'"+data.rows[i].TEAM_NAME+"'"+');">' + data.rows[i].TEAM_NAME+'</a></li>');
						$("#memberListTab").append('<li class="active"><a data-toggle="tab">' + data.rows[i].TEAM_NAME+'</a></li>');
					}
				}
				
				//$.ajaxLoadingHide();
			},
			loadError : function(xhr, status, err) {
				$.error(xhr, status, err);
			}
		});
	},
	
	clearNreload : function(team){
		jqGrid.clear();
		jqGrid.reload(team);
		//jqGrid.getMemberList(team);
	},
	
	clear : function(){
		$("#sellersGridMember").jqGrid('clearGridData');
	},
	
	reload : function(team){
		$("#sellersGridMember").jqGrid('setGridParam', { 
			url : "/salesManagement/gridFaceTimeTeam.do?",
 			mtype: 'POST',
 			postData : { 
 				roleChild : "Y",
				teamFlag : "Y",
				gridTabFlag : "Y",
				selectFaceTeam : team,
				selectFaceYear:$("#selectFaceYear").val(), 
				selectFaceMonth:$("#selectFaceMonth").val(), 
				selectFaceQuarter:$("#selectFaceQuarter").val(), 
				selectFacePost:$("#selectFacePost").val(),
				viewType : $("input:radio[name='radioViewType']:checked").val()
			},
			datatype : 'json'
		}).trigger('reloadGrid');
	},
	
	getMemberTable : function (team){
		$.ajax({
			url : "/salesManagement/gridFaceTimeAjax.do",
 			datatype : 'html',
			mtype: 'POST',
			data : {
				gridDataYN : "Y",
				roleChildDivision : "Y",
				gridTabFlag : "Y",
				selectFaceYear:$("#selectFaceYear").val(), 
				selectFaceTeam : team,
				selectFaceMonth:$("#selectFaceMonth").val(), 
				selectFaceQuarter:$("#selectFaceQuarter").val(), 
				selectFacePost:$("#selectFacePost").val(),
				
				viewType : $("input:radio[name='radioViewType']:checked").val()
			
			},
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
				$.ajaxLoadingShow();
			},
			success : function(data){
				$("#memberTable").html(data);
			},
			complete : function(){
				$.ajaxLoadingHide();
			}
		});
		
	}
}

//뷰타입
$("input:radio[name='radioViewType']").click(function(){
	//alert("분기,년도 쿼리 수정중에 있습니다.");
	$("#selectFaceTeam #selectFacePost,#selectFaceYear,#selectFaceMonth,#selectFaceQuarter").trigger("change");
});

//조건 검색 
 $("#selectFaceTeam,#selectFaceMonth,#selectFaceQuarter").change(function(){
  
 	 var params = $.param({
 			viewType : $("input:radio[name='radioViewType']:checked").val(),
 			selectFaceYear : $("#selectFaceYear").val(),
 			selectFaceMonth : $("#selectFaceMonth").val(),
 			selectFaceQuarter : $("#selectFaceQuarter").val(),
 			role : "roleDivision",
 			roleChild : "Y",
 			selectFacePost : $("#selectFacePost").val(),
 			selectFaceTeam : $("#selectFaceTeam").val()
 		});
 		//var param = "?selectFacePost="+$("#selectFacePost").val()+"&selectFaceYear="+$("#selectFaceYear").val()+"&selectFaceMonth="+$("#selectFaceMonth").val();
 		 location.href="/salesManagement/viewProductivity.do?"+params;
 });
    
 $("#selectFaceYear").change(function(){
	  
 	 var params = $.param({
 			viewType : $("input:radio[name='radioViewType']:checked").val(),
 			selectFaceYear : $("#selectFaceYear").val(),
// 			selectFaceMonth : $("#selectFaceMonth").val(),
// 			selectFaceQuarter : $("#selectFaceQuarter").val(),
 			role : "roleDivision",
 			roleChild : "Y",
 			selectFacePost : $("#selectFacePost").val(),
 			selectFaceTeam : $("#selectFaceTeam").val()
 		});
 		//var param = "?selectFacePost="+$("#selectFacePost").val()+"&selectFaceYear="+$("#selectFaceYear").val()+"&selectFaceMonth="+$("#selectFaceMonth").val();
 		 location.href="/salesManagement/viewProductivity.do?"+params;
 });
    

</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>