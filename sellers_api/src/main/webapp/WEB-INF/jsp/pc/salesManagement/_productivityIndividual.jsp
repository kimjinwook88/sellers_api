<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/jsp/pc/common/top_shareCalendar.jsp"%>
<%-- 
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
 --%>
<!-- 
 * @author 	: 욱이
 * @Date		: 2016. 07 - 07
 * @explain	: 영업관리 -> Face Time
 -->

<div class="mem-calendar-title">
	<span>나의 생산성</span> <a href="javascript:window.close();"
		class="btn-close"><i class="fa fa-times"></i></a>
</div>
<!-- 
		 <div class="row wrapper border-bottom white-bg page-heading">
		     <div class="col-sm-4">
		         <h2>나의 생산성</h2>
		         
		         <ol class="breadcrumb">
		             <li>
		                 <a href="/main/index.do">Home</a>
		             </li>
		             <li>
		                 <a>성과관리</a>
		             </li>
		             <li class="active">
		                 <strong>생산성</strong>
		             </li>
		         </ol>
		         
		     </div>
		 </div>
         -->
<div class="wrapper wrapper-content  animated fadeInRight">
	<div class="row">
		<div class="col-sm-12">
			<div class="ibox">
				<!-- <div class="ibox-content"> -->
				<div class="clear">
					<div class="pos-rel">
						<div class="func-top-left fl_l">

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
												<c:forEach items="${searchDetailGroup.faceQuarter}"
													var="searchDetailGroup">
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
									<input type="radio" name="radioViewType" value="m"
										<c:if test="${viewType eq 'm' or viewType eq null}">checked</c:if>>월
									<input type="radio" name="radioViewType" value="q"
										<c:if test="${viewType eq 'q'}">checked</c:if>>분기 <input
										type="radio" name="radioViewType" value="y"
										<c:if test="${viewType eq 'y'}">checked</c:if>>년도
								</div>

								<!-- 상위 부서 이동 영역 -->
								<!-- 
			                                <div class="selgrid selgrid1 mg-r5">
			                                    <a href="#" class="btn-movup" onclick="backDivision.conn();">본부 전체보기</a>
			                                </div>
			                                <div class="selgrid selgrid1 mg-r5">
			                                    <a href="#" class="btn-movup mg-l10" onclick="backTeam.conn();">팀 전체보기</a>
			                                </div>
			                                 -->
							</div>
						</div>
						
						<div class="tabs-container mg-b20" id="memberList">
							<br />
							<br />
							<br />
							<ul class="nav nav-tabs mg-b20" id="memberListTab">
							</ul>
						</div>
						<!-- 테이블 -->
						<div id="memberTable"></div>

						<div style="display: none">
							<div class="func-top-right fl_r pd-b20"></div>
							<br /> <br /> <br />
							<table id="sellersGrid"></table>
						</div>

						<!-- 왼쪽영역 -->
						<div ng-app="myApp">
							<!-- <div class="col-sm-6"> -->
							<div ng-controller="MainCtrl">
								<nvd3 options="options" data="data" config="config"
									interactive="true"></nvd3>
							</div>
							<!-- </div> -->

							<!-- 오른쪽 영역 -->
							<!-- 
										<div class="col-sm-6">
											<div ng-controller="MainCtrl">
										        <nvd3 options="options2" data="data2" config="config" interactive="true"></nvd3>
										    </div>
										</div>
										 -->
						</div>
					</div>
				</div>

				<!-- tab 데이터 -->

				<!-- <div class="func-top-right fl_r pd-b20"></div> -->
				<!-- <table id="sellersGridMember"></table> -->


			</div>
			<!-- </div> -->
		</div>
	</div>
</div>

</div>
</div>

<input type="hidden" id="hiddenUserId" name="hiddenUserId"></input>
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

//Title 설정
$("title").html($("div.mem-calendar-title span").html());

$(document).ready(function() {
	$("div.viewType").hide();
	
	if("${hiddenUserId}" !=null && "${hiddenUserId}" != ""){
		$("#hiddenUserId").val("${hiddenUserId}");
	}
	
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
	
	jqGrid.draw();
});
/* 
//본부별로 돌아가기 _ 나의생산성 _사용안함
var backDivision = {
	conn : function() {
		location.href="/salesManagement/listFaceTime.do?"
	}
}
//팀별로 돌아가기 _ 나의생산성 _사용안함
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
//==========================angluar Graph Start===================================
var app = angular.module('myApp', ['nvd3']);
app.controller('MainCtrl', function ($scope) {
    
//===========================좌측 그래프==========================================
	$scope.options = {
        chart: {
//            type: 'multiBarHorizontalChart',
            type: 'multiBarChart',
			margin:{
				left:250,
				right:250
			},
            height: 300,
//            width : 700,
            x: function (d) { return d.label; },
            y: function (d) { return d.value; },
            showControls: false,
            stacked: false,
            showValues: true,
            duration: 700,
            reduceXTicks:false,
            groupSpacing:0.5,
            legend: {
                //vers: 'furious'
            	position :'right' //안먹힘
            },
            xAxis: {
                showMaxMin: false
            },
            yAxis: {
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
//			myProducStatus:"Y",
			gridTabFlag : "Y",
			hiddenUserID : function(){
				if("${hiddenUserId}" !=null && "${hiddenUserId}" != ""){
					return "${hiddenUserId}";
				}
			},
			viewType : $("input:radio[name='radioViewType']:checked").val(),
		},
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
			$.ajaxLoading();
		},
		success : function(data){
			var viewType = $("input:radio[name='radioViewType']:checked").val();
			var thisLabel;
			var lastLabel;
			
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
			
			if(viewType == null || viewType == "" || viewType == 'm'){
				
				if(commonDate.month == $("#selectFaceMonth").val()){
					lastLabel = "지난달";
					thisLabel = "이번달";
				}else {
					lastLabel = $("#selectFaceMonth").val()-1 +"월";
					thisLabel = $("#selectFaceMonth").val()*1 +"월";
				}
			}else if(viewType == 'y'){
				
				if(commonDate.year == $("#selectFaceYear").val()){
					lastLabel = "전년";
					thisLabel = "올해";
				}else {
					lastLabel = $("#selectFaceYear").val()-1 +"년";
					thisLabel = $("#selectFaceYear").val() + "년";
				}
			}else{
				
				if(commonDate.quarter(commonDate.month) == $("#selectFaceQuarter").val()){
					lastLabel = "전분기";
					thisLabel = "이번분기";
				}else {
					lastLabel = $("#selectFaceQuarter").val()-1 +"분기";
					thisLabel = $("#selectFaceQuarter").val() +"분기";
				}
			}
			
			//Graph 그리기
			var thisScheduleArr1 = new Array();		//이번달
          	var thisSchedule1 = new Object();

			var thisScheduleArr2 = new Array();		//지난달
          	var thisSchedule2 = new Object();


			for(var i=0; i<data.rows.length; i++){
				
				//*1 : 문자-> 숫자 (형변환)
				
				//이번달
   				thisSchedule1 = new Object();
   				thisSchedule1.label = "고객컨택";
   				thisSchedule1.value = data.rows[i].THIS_EVENT_PERCENT_1*1;
   				thisScheduleArr1.push(thisSchedule1);
   				
   				thisSchedule1 = new Object();
   				thisSchedule1.label = "컨택준비";
   				thisSchedule1.value = data.rows[i].THIS_EVENT_PERCENT_2*1;
   				thisScheduleArr1.push(thisSchedule1);
   				
   				thisSchedule1 = new Object();
   				thisSchedule1.label = "내부회의";
   				thisSchedule1.value = data.rows[i].THIS_EVENT_PERCENT_3*1;
   				thisScheduleArr1.push(thisSchedule1);
   				
   				thisSchedule1 = new Object();
   				thisSchedule1.label = "교육";
   				thisSchedule1.value = data.rows[i].THIS_EVENT_PERCENT_4*1;
   				thisScheduleArr1.push(thisSchedule1);
   				
   				thisSchedule1 = new Object();
   				thisSchedule1.label = "기타";
   				thisSchedule1.value = data.rows[i].THIS_EVENT_PERCENT_6*1;
   				thisScheduleArr1.push(thisSchedule1);

   				thisSchedule1 = new Object();
   				thisSchedule1.label = "휴가";
   				thisSchedule1.value = data.rows[i].THIS_EVENT_PERCENT_7*1;
   				thisScheduleArr1.push(thisSchedule1);
   				
   				thisSchedule1 = new Object();
   				thisSchedule1.label = "이동시간";
   				thisSchedule1.value = data.rows[i].THIS_EVENT_PERCENT_5*1;
   				thisScheduleArr1.push(thisSchedule1);
   				
   				thisSchedule1 = new Object();
   				thisSchedule1.label = "미입력";
   				thisSchedule1.value = data.rows[i].THISOTHER*1;
   				thisScheduleArr1.push(thisSchedule1);
   				
   				//지난달
   				thisSchedule2 = new Object();
   				thisSchedule2.label = "고객컨택";
	   			thisSchedule2.value = data.rows[i].LAST_EVENT_PERCENT_1*1;
   				thisScheduleArr2.push(thisSchedule2);
   				
   				thisSchedule2 = new Object();
   				thisSchedule2.label = "컨택준비";
   				thisSchedule2.value = data.rows[i].LAST_EVENT_PERCENT_2*1;
   				thisScheduleArr2.push(thisSchedule2);

   				thisSchedule2 = new Object();
   				thisSchedule2.label = "내부회의";
   				thisSchedule2.value = data.rows[i].LAST_EVENT_PERCENT_3*1;
   				thisScheduleArr2.push(thisSchedule2);
   				
   				thisSchedule2 = new Object();
   				thisSchedule2.label = "교육";
   				thisSchedule2.value = data.rows[i].LAST_EVENT_PERCENT_4*1;
   				thisScheduleArr2.push(thisSchedule2);

   				thisSchedule2 = new Object();
   				thisSchedule2.label = "기타";
   				thisSchedule2.value = data.rows[i].LAST_EVENT_PERCENT_6*1;
   				thisScheduleArr2.push(thisSchedule2);
   				
   				thisSchedule2 = new Object();
   				thisSchedule2.label = "휴가";
   				thisSchedule2.value = data.rows[i].LAST_EVENT_PERCENT_7*1;
   				//thisSchedule2.value = "4";
   				thisScheduleArr2.push(thisSchedule2);

   				thisSchedule2 = new Object();
   				thisSchedule2.label = "이동시간";
   				thisSchedule2.value = data.rows[i].LAST_EVENT_PERCENT_5*1;
   				thisScheduleArr2.push(thisSchedule2);
   				
   				thisSchedule2 = new Object();
   				thisSchedule2.label = "미입력";
   				thisSchedule2.value = data.rows[i].LASTOTHER*1;
   				thisScheduleArr2.push(thisSchedule2);
   				
   				/* 
   				//미입력
   				thisNoSchedule = new Object();
   				//thisNoSchedule.label = data.rows[i].HAN_NAME;
   				thisNoSchedule.label = "이번달";
   				thisNoSchedule.value = data.rows[i].otherPer;
   				thisNoScheduleArr.push(thisNoSchedule);

   				thisNoSchedule = new Object();
   				//thisNoSchedule.label = data.rows[i].HAN_NAME;
   				thisNoSchedule.label = "지난달";
   				thisNoSchedule.value = data.rows[i].otherPer;
   				thisNoScheduleArr.push(thisNoSchedule);
				 */
			}
			
			var lastData = new Object();
			lastData.key= lastLabel;
			lastData.color="#a8a5f7";
			lastData.values = thisScheduleArr2;

			var thisData = new Object();
			thisData.key= thisLabel;
			thisData.color="#d62728";
			thisData.values = thisScheduleArr1;
			//var jsonInfo = JSON.stringify(totalInfo1);
			//Graph Data
			$scope.data = [ lastData,thisData 
			                /* 
			               {
			                   "key": "이번달",
			                   "color": "#1f77b4",
			                   "values": [
			                       { "label": "고객컨택","value": 12.5 },
			                       { "label": "컨택준비", "value": "11" },
			                       { "label": "내부회의","value": 0.57072943117674 },
			                       { "label": "교육","value": 2.4174010336624 },
			                       { "label": "기타","value": 0.72009071426284 },
			                       { "label": "휴가","value": 0.77154485523777 },
			                       { "label": "이동시간","value": 0.90152097798131 },
			                   ]
			               },
			               {
			                   "key": "지난달",
			                   "color": "#d62728",
			                   "values": [
			                       { "label": "고객컨택", "value": "9.307646510375" },
			                       { "label": "컨택준비", "value": 9.756779544553 },
			                       { "label": "내부회의","value": 8.451534877007 },
			                       { "label": "교육","value": 8.6142352811805 },
			                       { "label": "기타","value": 7.8082472075876 },
			                       { "label": "휴가","value": 5.259101026956 },
			                       { "label": "이동시간", "value": 0.30947953487127 },
			                   ]
			               } 
			                */
			           ]
		},
		complete : function(){
			$.ajaxLoadingHide();
		}
	});
    /* 
    $scope.data = [
        {
            "key": "Series1",
            "color": "#d62728",
            "values": [
                { "label": "Group A","value": -1.8746444827653 },
                { "label": "Group B", "value": -8.0961543492239 },
                { "label": "Group C","value": -0.57072943117674 },
                { "label": "Group D","value": -2.4174010336624 },
                { "label": "Group E","value": -0.72009071426284 },
                { "label": "Group F","value": -0.77154485523777 },
                { "label": "Group G","value": -0.90152097798131 },
                { "label": "Group H","value": -0.91445417330854 },
                { "label": "Group I","value": -0.055746319141851 }
            ]
        },
        {
            "key": "Series2",
            "color": "#1f77b4",
            "values": [
                { "label": "Group A", "value": 25.307646510375 },
                { "label": "Group B", "value": 16.756779544553 },
                { "label": "Group C","value": 18.451534877007 },
                { "label": "Group D","value": 8.6142352811805 },
                { "label": "Group E","value": 7.8082472075876 },
                { "label": "Group F","value": 5.259101026956 },
                { "label": "Group G", "value": 0.30947953487127 },
                { "label": "Group H", "value": 0 },
                { "label": "Group I", "value": 0 }
            ]
        }
    ]
     */
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
//				myProducYN: "Y",
				selectFaceYear:$("#selectFaceYear").val(), 
				selectFaceMonth:$("#selectFaceMonth").val(), 
				selectFaceQuarter:$("#selectFaceQuarter").val(), 
				selectFacePost:$("#selectFacePost").val(),
				selectFaceTeam:$("#selectFaceTeam").val(),
				hiddenUserID:$("#hiddenUserId").val(),
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
//				jqGrid.getMemberList(data.rows[0].MEMBER_ID_NUM);
				jqGrid.getMemberTable(data.rows[0].MEMBER_ID_NUM);
				
				for(i=0; i<data.rows.length; i++){
					if(i==0){
//						$("#memberListTab").append('<li class="active"><a data-toggle="tab" onClick="jqGrid.clearNreload('+"'"+data.rows[i].MEMBER_ID_NUM+"'"+');">' + data.rows[i].TEAM_NAME+'</a></li>');
						$("#memberListTab").append('<li class="active"><a data-toggle="tab">' + data.rows[i].HAN_NAME+'</a></li>');
					}
				}
				
				//$.ajaxLoadingHide();
			},
			loadError : function(xhr, status, err) {
				$.error(xhr, status, err);
			}
		});
	},
	
	getMemberTable : function (hiddenUserID){
		$.ajax({
			url : "/salesManagement/gridFaceTimeAjax.do",
 			datatype : 'html',
			mtype: 'POST',
			data : {
				individualData : "Y",
				gridTabFlag : "Y",
				selectFaceYear:$("#selectFaceYear").val(), 
				selectFaceMonth:$("#selectFaceMonth").val(), 
				selectFaceQuarter:$("#selectFaceQuarter").val(), 
				selectFacePost:$("#selectFacePost").val(),
				selectFaceTeam:$("#selectFaceTeam").val(),
				hiddenUserID: hiddenUserID,
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
	$("#selectFaceYear,#selectFaceMonth,#selectFaceQuarter").trigger("change");
});

/* 
//검색
$("#selectFacePost,#selectFaceYear,#selectFaceMonth,#selectFaceQuarter").change(function(){
	var params = $.param({
		viewType : $("input:radio[name='radioViewType']:checked").val(),
		selectFacePost : $("#selectFacePost").val(),
		selectFaceYear : $("#selectFaceYear").val(),
		selectFaceMonth : $("#selectFaceMonth").val(),
		selectFaceQuarter : $("#selectFaceQuarter").val()
	});
	//var param = "?selectFacePost="+$("#selectFacePost").val()+"&selectFaceYear="+$("#selectFaceYear").val()+"&selectFaceMonth="+$("#selectFaceMonth").val();
	 location.href="/salesManagement/listFaceTime.do?"+params;
});
 */
 
 // 조건 검색
 $("#selectFaceMonth,#selectFaceQuarter").change(function(){
		var params = $.param({
			viewType : $("input:radio[name='radioViewType']:checked").val(),
			selectFaceYear : $("#selectFaceYear").val(),
			selectFaceMonth : $("#selectFaceMonth").val(),
			selectFaceQuarter : $("#selectFaceQuarter").val(),
			//divisionNteamType : "myProduc",
			hiddenUserId : $("#hiddenUserId").val()
		});
		//var param = "?selectFacePost="+$("#selectFacePost").val()+"&selectFaceYear="+$("#selectFaceYear").val()+"&selectFaceMonth="+$("#selectFaceMonth").val();
		 location.href="/calendar/myProductivity.do?"+params;
	});
 
 $("#selectFaceYear").change(function(){
	 var params = $.param({
		 viewType : $("input:radio[name='radioViewType']:checked").val(),
		 selectFaceYear : $("#selectFaceYear").val(),
//		 selectFaceQuarter : $("#selectFaceQuarter").val(),
		 hiddenUserId : $("#hiddenUserId").val()
	 });
	 location.href="/calendar/myProductivity.do?"+params;
 });


</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>