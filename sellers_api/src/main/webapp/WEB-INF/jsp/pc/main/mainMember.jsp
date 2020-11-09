<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>

<!-- 팀장 이상 권한 페이지 -->
<style>
.nv-legend{ transform: translate(-175px, 325px); }
</style>	

		<div class="wrapper wrapper-content animated fadeInRight" ng-app="myApp" ng-controller="MainCtrl">
              <div class="row">
                  <div class="ibox float-e-margins">
                      <div class="ibox-title">
                          <h5>영업실적</h5>
                      </div>
                      
						<div class="ibox-content">
                          <div class="row">
                              <div class="col-sm-4 col-lg-4">
                            		<div class="total_year_result">
                                      <ul class="stat-list">
                                          <li>
                                              <h2 class="no-margins">
                                                  <strong class="ti">회사전체</strong>
                                                  <span class="small">Target  
                                                  		<strong><fmt:formatNumber value="${selectCompanyResult.TARGET_REV/1000000}" type="currency" currencySymbol=""/></strong><span class="ft-s12">(REV)</span> /
                                                  		<strong><fmt:formatNumber value="${selectCompanyResult.TARGET_GP/1000000}" type="currency" currencySymbol=""/></strong><span class="ft-s12">(GP)</span>
                                                  </span>
                                              </h2>
                                          </li>
                                          
                                          <li>
                                                <h2 class="subtitle">
                                                    <span class="sub">REV</span>
                                                    <span class="count">
                                                    <fmt:formatNumber value="${selectCompanyResult.ACTUAL_REV_AMOUNT/1000000}" type="currency" currencySymbol=""/>
                                                    <fmt:parseNumber var="companyAra" integerOnly="true" value="${selectCompanyResult.ACTUAL_REV_AMOUNT/1000000}"/>
									              	<fmt:parseNumber var="companyTr" integerOnly="true" value="${selectCompanyResult.TARGET_REV/1000000}"/>
									              	<c:choose>
									              		<c:when test="${selectCompanyResult.TARGET_REV > 0}">
									              		<fmt:parseNumber var="companyRevPer" integerOnly="true" value="${(companyAra/companyTr)*100}"/>
									              		<span class="stat-percent">(${companyRevPer}%)</span>
									              		</c:when>
									              		<c:otherwise>
									              		<fmt:parseNumber var="companyRevPer" integerOnly="true" value="100"/>
									              		<span class="stat-percent">(${companyRevPer}%)</span>
									              		</c:otherwise>
									              </c:choose>
                                                    </span>
                                                </h2>
                                                <div class="result_total_track">
                                                    <div class="result_progress">
                                                        <div style="width:${companyRevPer}%;" class="bar rev_color"></div>                                                    
                                                        <div class="line_100">100%</div>
                                                    </div>
                                                </div>
                                            </li>
                                            
                                            
                                            <li>
                                                <h2 class="subtitle">
                                                    <span class="sub">GP</span>
                                                    <span class="count">
                                                    <fmt:formatNumber value="${selectCompanyResult.ACTUAL_GP_AMOUNT/1000000}" type="currency" currencySymbol=""/>
                                                    <fmt:parseNumber var="companyAga" integerOnly="true" value="${selectCompanyResult.ACTUAL_GP_AMOUNT/1000000}"/>
									              	<fmt:parseNumber var="companyTg" integerOnly="true" value="${selectCompanyResult.TARGET_GP/1000000}"/>
									              	<c:choose>
									              		<c:when test="${selectCompanyResult.TARGET_GP > 0}">
									              		<fmt:parseNumber var="companyGpPer" integerOnly="true" value="${(companyAga/companyTg)*100}"/>
									              		<span class="stat-percent">(${companyGpPer}%)</span>
									              		</c:when>
									              		<c:otherwise>
									              		<fmt:parseNumber var="companyRevPer" integerOnly="true" value="100"/>
									              		<span class="stat-percent">(${companyGpPer}%)</span>
									              		</c:otherwise>
									              </c:choose>
                                                    </span>
                                                </h2>
                                                <div class="result_total_track">
                                                    <div class="result_progress">
                                                        <div style="width:${companyGpPer}%;" class="bar gp_color"></div>                                                    
                                                        <div class="line_100">100%</div>
                                                    </div>
                                                </div>
                                            </li>
                                      </ul>
                                  </div>
                                  <div class="tabs-container landing-tab">
                                      <ul class="nav nav-tabs" id="angularTabDiv">
                                          <li name="resultTab" class="active"><a data-toggle="tab" href="#tab-1" onClick="main.selectResult(1);" ng-click='grid(1)'>1분기</a></li>
                                          <li name="resultTab" class=""><a data-toggle="tab" href="#tab-2" onClick="main.selectResult(2);" ng-click='grid(2)'>2분기</a></li>
                                          <li name="resultTab" class=""><a data-toggle="tab" href="#tab-3" onClick="main.selectResult(3);" ng-click='grid(3)'>3분기</a></li>
                                          <li name="resultTab" class=""><a data-toggle="tab" href="#tab-4" onClick="main.selectResult(4);" ng-click='grid(4)'>4분기</a></li>
                                          <c:choose>
											<c:when test="${fn:contains(auth, 'ROLE_CEO') or fn:contains(auth, 'ROLE_CFO')}">
											</c:when>
											<c:otherwise>
												<li name="resultTab" class=""><a data-toggle="tab" href="#tab-5" onClick="main.selectResult(5);" ng-click='grid(5)'><span name="spanYear"></span>년</a></li>
											</c:otherwise>
										  </c:choose>
                                      </ul>
                                      <div class="tab-content" id="divResult">
                                          
                                      </div>
                                  
                                  </div>
                              </div>
                              <div class="col-lg-8">
                                  	<div>
									    <nvd3 options="options" data="data" config="config" interactive="true"></nvd3>
									</div>
                              </div>
                          </div>
                      </div> 
                      
                  </div>
              </div>

              <div class="row">
                  <!-- 나의 오늘 일정 -->
                  <div class="col-lg-4 pd-no">
                      <div class="ibox float-e-margins">
                          <div class="ibox-title landing-header">
                              <h5>${userInfo.HAN_NAME}님의 일정</h5>

                              <div class="pull-right day-nav">
                                  <button class="btn btn-white btn-sm" onClick="main.timeLineAddDate('m');"><i class="fa fa-arrow-left"></i></button>
                                  <strong id="timeLineViewDate"></strong><strong id="timeLineDate" style="display: none;"></strong>
                                  <button class="btn btn-white btn-sm" onClick="main.timeLineAddDate('p');"><i class="fa fa-arrow-right"></i></button>
                              </div>
                          </div>
                          <div class="ibox-content inspinia-timeline landing-timeline" id="divTimeLine">
                          </div>
                      </div>
                  </div>
                  <!--// 나의 오늘 일정 -->

                  <!-- 영업활동 -->
                  <div class="col-lg-4">
                      <div class="ibox float-e-margins">
                          <div class="ibox-title landing-header"><h5>영업기회 / 잠재기회</h5></div>
                          <div class="ibox-content no-padding landing-act" id="divSalesAct">
                          </div>
                      </div>
                  </div>
                  <!--// 나의 영업활동 관리 -->

                  <!-- 신규 및 업데이트 알림 -->
                  <div class="col-lg-4 pd-no">
                      <div class="ibox float-e-margins">
                          <div class="ibox-title landing-header">
                              <h5>고객이슈</h5>
                          </div>
                          <div class="ibox-content no-padding landing-update" id="divNewUpdate">
                          </div>
                      </div>
                  </div>
                  <!--// 신규 및 업데이트 알림 -->
              </div>
          </div>
 </div>
 </div>
</body>

<link rel="stylesheet" href="<%=request.getContextPath()%>/nvD3/nvd3/nv.d3.min.css" />
<script src="<%=request.getContextPath()%>/nvD3/d3.min.js" charset="utf-8"></script>
<script src="<%=request.getContextPath()%>/nvD3/angular/angular.js"></script>
<script src="<%=request.getContextPath()%>/nvD3/nvd3/nv.d3.min.js"></script>
<script src="<%=request.getContextPath()%>/nvD3/angular-nvd3/angular-nvd3.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		main.init();
	});
	
	var main = {
			init : function(){
				//나의 오늘 일정 날짜
				var currentDate = moment().format('YYYY-MM-DD');
				var currentViewDate = moment().format('MM월D일');
				$('#timeLineDate').html(currentDate);
				$('#timeLineViewDate').html(currentViewDate);
				//$('span[name="tabYear"]').html(moment().format('YYYY'));
				
				$('li[name="resultTab"]').removeClass('active');
				$('li[name="resultTab"]').eq(moment().format('Q')-1).addClass('active');
				$('li[name="resultTabCompany"]').removeClass('active');
				$('li[name="resultTabCompany"]').eq(moment().format('Q')-1).addClass('active');
				
				$('span[name="spanYear"]').html(moment().format('Y'));
				
				main.selectTimeLine(); //일정
				main.selectSalesAct(); //진행중인 영업활동
				main.selectNewUpdate(); //신규 및 업데이트
				main.selectResult(moment().format('Q')); //tab 성과
				main.selectCompanyResult(moment().format('Q')); //tab 성과
				//main.selectResultGraph(moment().format('Q')); //그래프
			},
			
			//나의 오늘 일정 좌우 버튼
			timeLineAddDate : function(s){
				var timeLineDatae = moment($('#timeLineDate').html());
				if(s == 'p'){//더하기
					$('#timeLineDate').html(timeLineDatae.add(1,'day').format('YYYY-MM-DD'));
					$('#timeLineViewDate').html(moment($('#timeLineDate').html()).format('MM월D일'));
				}else{ //빼기
					$('#timeLineDate').html(timeLineDatae.add(-1,'day').format('YYYY-MM-DD'));
					$('#timeLineViewDate').html(moment($('#timeLineDate').html()).format('MM월D일'));
				}
				main.selectTimeLine();
			},
			
			selectTimeLine : function(){
				$.ajax({
					url : "/main/selectTimeLine.do",
					async : false,
		 			datatype : 'html',
		 			method: 'POST',
		 			data : {
		 				searchDate : $('#timeLineDate').html(),
		 				searchMemberId : '${userInfo.MEMBER_ID_NUM}'
		 			},
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoading();
					},
					success : function(data){
						$('#divTimeLine').html(data);
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			},
			
			goTimeLine : function(EVENT_ID){
				var openNewWindow = window.open("about:blank");
				openNewWindow.location.href = "/calendar/viewCalendar.do?notice_event_id="+EVENT_ID;
			},
			
			selectSalesAct : function(){
				$.ajax({
					url : "/main/selectSalesAct.do",
					async : false,
		 			datatype : 'html',
		 			method: 'POST',
		 			data : {
		 				searchMemberId : '${userInfo.MEMBER_ID_NUM}'
		 			},
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoading();
					},
					success : function(data){
						$('#divSalesAct').html(data);
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			},
			
			goSalesAct : function(pk,code){
				var openNewWindow = window.open("about:blank");
				switch (code) {
				case "고객이슈":
					openNewWindow.location.href = "/clientSalesActive/viewClientIssueList.do?issue_id="+pk;
					break;
				case "영업기회":
					openNewWindow.location.href = "/clientSalesActive/viewOpportunityList.do?opportunity_id="+pk;
					break;
				case "잠재영업기회":
					openNewWindow.location.href = "/clientSalesActive/viewHiddenOpportunityList.do?opportunity_hidden_id="+pk;
					break;
				}
			},
			
			selectNewUpdate : function(){
				$.ajax({
					url : "/main/selectNewUpdate.do",
					async : false,
		 			datatype : 'html',
		 			method: 'POST',
		 			data : {
		 				searchMemberId : '${userInfo.MEMBER_ID_NUM}'
		 			},
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoading();
					},
					success : function(data){
						$('#divNewUpdate').html(data);
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			},
			
			selectResult : function(q){
				$.ajax({
					url : "/main/selectResult.do",
					async : false,
		 			datatype : 'html',
		 			method: 'POST',
		 			data : {
		 				searchMemberId : '${userInfo.MEMBER_ID_NUM}',
		 				searchQuarter : q,
		 			},
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoading();
					},
					success : function(data){
						$('#divResult').html(data);
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			},
			
			selectCompanyResult : function(q){
				$.ajax({
					url : "/main/selectCompanyResult.do",
					async : false,
		 			datatype : 'html',
		 			method: 'POST',
		 			data : {
		 				searchQuarter : q,
		 			},
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoading();
					},
					success : function(data){
						$('#divCompanyResult').html(data);
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			}
			
	}
	
	var app = angular.module('myApp', ['nvd3']);
	app.controller('MainCtrl', ['$scope', function ($scope){
		$scope.options = {
			chart: {
	           type: 'multiBarChart',
	           margin:{
					left:50,
					bottom:100
				},
	           height: 350,
				//width : 700,
	           x: function (d) { return d.label; },
	           y: function (d) { return d.value; },
	           showControls: false,
	           showValues: true,
	           reduceXTicks:false,
	           showYAxis:false,
	           duration: 1000,
	           groupSpacing:0.5,
	           xAxis: {
	               showMaxMin: false,
	               //barWidth: 20,
	               //rotateLabels: -20,  //x축 텍스트 기울기
	               //rangeBand: 5
	           },
	           yAxis: {
	               //axisLabel: 'Values',
	               max : 100,
	               tickFormat: function (d) {
	                   return d3.format(",")(d) + " 백만원";
	               }
	           },
	           
	           //차크 click 할 때, Action
	           callback:function(chart){
	           	d3.selectAll(".nv-bar").on('click', function(){
	             });
	           }
	       }
	   };
		
	   $scope.start = $.ajax({
			url : "/main/selectResultGraph.do",
			async : false,
			datatype : 'json',
			method: 'POST',
			data : {
				searchQuarter : moment().format('Q')
			},
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
				$.ajaxLoading();
			},
			success : function(data){
				//Graph 그리기
				var gpArr = new Array();		//GP
	          	var gp = new Object();

				var revArr = new Array();		//REV
	          	var rev = new Object();
				
				var targetRevArr = new Array();		//TARGET REV
	          	var targetRev = new Object();
				
				var targetGpArr = new Array();		//TARGET GP
	          	var targetGp = new Object();

				for(var i=0; i<data.list.length; i++){
					//GP
	  				gp = new Object();
  					gp.label = data.list[i].VIEW_NAME;
  					gp.value =Math.floor(data.list[i].ACTUAL_GP_AMOUNT/1000000);
	  				gpArr.push(gp);
	  				
	  				//REV
	  				rev = new Object();
  					rev.label = data.list[i].VIEW_NAME;
  					rev.value = Math.floor(data.list[i].ACTUAL_REV_AMOUNT/1000000);
	  				revArr.push(rev);
	  				
	  				//Target REV
	  				targetRev = new Object();
	  				targetRev.label = data.list[i].VIEW_NAME;
	  				targetRev.value = Math.floor(data.list[i].TARGET_REV/1000000);
	  				targetRevArr.push(targetRev);
	  				
	  				//Target GP
	  				targetGp = new Object();
	  				targetGp.label = data.list[i].VIEW_NAME;
	  				targetGp.value = Math.floor(data.list[i].TARGET_GP/1000000);
	  				targetGpArr.push(targetGp);
				}
				
				var gpObj = new Object();
				gpObj.key="Actual GP";
				gpObj.color="#499f45";
				gpObj.values = gpArr;
				
				var revObj = new Object();
				revObj.key="Actual REV";
				revObj.color="#fcca0d";
				revObj.values = revArr;
				
				var targetRevObj = new Object();
				targetRevObj.key="Target REV";
				targetRevObj.color="#0000cc";
				targetRevObj.values = targetRevArr;
				
				var targetGpObj = new Object();
				targetGpObj.key="Target GP";
				targetGpObj.color="#0000cc";
				targetGpObj.values = targetGpArr;
				
				$scope.data = [targetRevObj,revObj,targetGpObj,gpObj];
			},
			complete : function(){
				$.ajaxLoadingHide();
			}
	   });
	   
	   
	   $scope.grid = function(q){
		   $.ajax({
				url : "/main/selectResultGraph.do",
				async : false,
				datatype : 'json',
				method: 'POST',
				data : {
					searchQuarter : q
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoading();
				},
				success : function(data){
					//Graph 그리기
					var gpArr = new Array();		//GP
		          	var gp = new Object();

					var revArr = new Array();		//REV
		          	var rev = new Object();
					
					var targetRevArr = new Array();		//TARGET REV
		          	var targetRev = new Object();
					
					var targetGpArr = new Array();		//TARGET GP
		          	var targetGp = new Object();

					for(var i=0; i<data.list.length; i++){
						//GP
		  				gp = new Object();
	  					gp.label = data.list[i].VIEW_NAME;
	  					gp.value =Math.floor(data.list[i].ACTUAL_GP_AMOUNT/1000000);
		  				gpArr.push(gp);
		  				
		  				//REV
		  				rev = new Object();
	  					rev.label = data.list[i].VIEW_NAME;
	  					rev.value = Math.floor(data.list[i].ACTUAL_REV_AMOUNT/1000000);
		  				revArr.push(rev);
		  				
		  				//Target REV
		  				targetRev = new Object();
		  				targetRev.label = data.list[i].VIEW_NAME;
		  				targetRev.value = Math.floor(data.list[i].TARGET_REV/1000000);
		  				targetRevArr.push(targetRev);
		  				
		  				//Target GP
		  				targetGp = new Object();
		  				targetGp.label = data.list[i].VIEW_NAME;
		  				targetGp.value = Math.floor(data.list[i].TARGET_GP/1000000);
		  				targetGpArr.push(targetGp);
					}
					
					var gpObj = new Object();
					gpObj.key="Actual GP";
					gpObj.color="#499f45";
					gpObj.values = gpArr;
					
					var revObj = new Object();
					revObj.key="Actual REV";
					revObj.color="#fcca0d";
					revObj.values = revArr;
					
					var targetRevObj = new Object();
					targetRevObj.key="Target REV";
					targetRevObj.color="#0000cc";
					targetRevObj.values = targetRevArr;
					
					var targetGpObj = new Object();
					targetGpObj.key="Target GP";
					targetGpObj.color="#0000cc";
					targetGpObj.values = targetGpArr;
					
					$scope.data = [targetRevObj,revObj,targetGpObj,gpObj];
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
		   });
		 }
	}]);
	
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>

