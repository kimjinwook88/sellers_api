<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<style>
.btn_bottom_dep{
	cursor: pointer;
}
</style>
<div class="row wrapper border-bottom white-bg page-heading">
	<!-- <div class="col-sm-4">
		<h2>보고서</h2>
		<ol class="breadcrumb">
			<li><a href="/main/index.do">Home</a></li>
			<li><a>성과관리</a></li>
			<li class="active"><strong>보고서</strong></li>
		</ol>
	</div> -->
</div>

<div class="wrapper wrapper-content  animated fadeInRight">
	<div class="row">
		<div class="col-sm-12">
			<div class="ibox">
				<div class="ibox-content border_n">
					<div class="clear">
					
						<!-- <div class="mg-b20">
       				<ul class="nav nav-tabs">
         				<li><a href="/salesManagement/viewWeeklyReportSummaryTabAjax.do">summary</a></li>
   	        		<li><a href="javascript:void(0);" onclick="dashboard.tab('w');">주간보고</a></li>
   	        		<li class="active"><a href="/salesManagement/viewWeeklyReportTabAjax.do">주간보고</a></li>
   	        	</ul>
         		</div> -->

						<!-- 기간 선택 영역 -->
						<!-- <div class="func-top-left fl_l">  
							<div class="col-sm-5 date-area">
								<div class="data_1">
	                 <div class="input-group date">
	                     <input type="text" class="form-control add-on" id="inputStartDate" style="text-align: center;" name="" value="">
	                 </div>
	             	</div>
             	</div>
             	<div class="col-sm-1 tilde">~</div>
             	<div class="col-sm-5 date-area">
								<div class="data_1">
	                 <div class="input-group date">
	                     <input type="text" class="form-control add-on" id="inputEndDate" style="text-align: center;" name="" value="">
	                 </div>
	             	</div>
             	</div>
						</div> -->
						
						<div class="func-top-left fl_l" >                                          
			              <button class="btn btn-white btn-sm" id="buttonPrevYear" onclick="dashboard.prevDate();"><i class="fa fa-arrow-left"></i></button>
			              <strong id="strongYear"></strong>
			              <button class="btn btn-white btn-sm" id="buttonNextYear" onclick="dashboard.nextDate();"><i class="fa fa-arrow-right"></i></button>
			          </div>
						
						<div class="fl_r pd-b20">
							<div class="fl_l">
			   				<button type="button" class="btn btn-w-m btn-seller" onclick="dashboard.download();">다운로드</button>
							</div> 
						</div>
						
						<div class="selgrid selgrid1 mg-l20">
							<c:if test="${fn:contains(auth, 'ROLE_CEO')}">
								<select class="form-control" style="height:34px;width:110%;" name="selectDivision" id="selectDivision">
									<c:choose>
										<c:when test="${fn:length(divisionList) > 0}">
											<c:forEach items="${divisionList}" var="division">
												<option value="${division.DIVISION_NO}">${division.DIVISION_NAME}</option>
											</c:forEach>
										</c:when>
									</c:choose>
								</select>
							</c:if>	
						</div>
					
						<table class="dashboard_type1 mg-b50">
							<colgroup name="dashboard_p">
								<col width="7%"/>
								<col width="12%"/>
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />
								<col width="8%" />
								<col width="8%" />
								<col width="10%" />
								<col width="10%" />
								<col width="8%" />
								<col width="8%" />
							</colgroup>
							<thead name="dashboard_p">
								<tr>
									<th>구분</th>
									<th>분기별</th>
									<th>TCV</th>
									<th>Revenue</th>
									<th>GP</th>
									<th>Rev<br />달성율(Y)</th>
									<th>GP<br />달성율(Y)</th>
									<th>Rev<br />분기목표</th>
									<th>GP<br />분기목표</th>
									<th>Rev<br />달성율(Q)</th>
									<th class="end">GP<br />달성율(Q)</th>
								</tr>
							</thead>
							<tbody id="row1">
							</tbody>
						</table>
						
						<div class="func-top-left fl_l" style="padding-bottom:15px;">    
							  <strong id="strongQuarter"></strong>                  
	              <button class="btn btn-white btn-sm" name="buttonPjList" ><strong>1Q</strong></button>
	              <button class="btn btn-white btn-sm" name="buttonPjList" ><strong>2Q</strong></button>
	              <button class="btn btn-white btn-sm" name="buttonPjList" ><strong>3Q</strong></button>
	              <button class="btn btn-white btn-sm" name="buttonPjList" ><strong>4Q</strong></button>
	          </div>
						
						<table class="dashboard_type1 mg-b50">
							<colgroup name="dashboard_p">
								<col width="8%"/>
								<col width="7%"/>
								<col width="*" />
								<col width="*" />
								<col width="7%" />
								<col width="7%" />
								<col width="7%" />
								<col width="8%" />
								<col width="8%" />
							</colgroup>
							<thead name="dashboard_p">
								<tr>
									<th rowspan="2">구분</th>
									<th rowspan="2">영업대표</th>
									<th rowspan="2">고객명</th>
									<th rowspan="2">프로젝트명</th>
									<th rowspan="2">TCV</th>
									<th rowspan="2">Revenue
									</th>
									<th rowspan="2">GP
									</th>
									<th rowspan="2">계약일
									</th>
									<th rowspan="2" class="end">계산서발행일
									</th>
									<!-- <th rowspan="2">수금예정일
									</th>
									<th rowspan="2">수금일
									</th> -->
									<!-- <th rowspan="2" class="end">비고<br /> -->
								</tr>
							</thead>
							<tbody id="row2">
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(document).ready(function(){
	dashboard.init();
});

var weekEvent = {
		on : function(){
			$('button[name="buttonPjList"]').on('click', weekEvent.clickPjList);
			$('button[name="buttonPjList"]').eq(moment().quarter()-1).trigger('click', weekEvent.clickPjList);
		},
		
		off : function(){
			
		},
		
		clickPjList : function(e){
			var idx = $('button[name="buttonPjList"]').index($(this));
			$('button[name="buttonPjList"]').css("background-color",'');
			$(this).css("background-color",'#e7eaec');
			dashboard.selectQuarter = idx+1;
			dashboard.quarterGet();
		}
		
}

var dashboard = {
		//변수
		tabFlag : 'w', //초기 주간보고
		selectDivision : $('#selectDivision').val(),
		selectYear : moment().year(),
		selectQuarter : moment().quarter(),
		
		init : function(){
			dashboard.setDivision();
			weekEvent.on();
		},
		
		setDivision : function(){
			if(!dashboard.selectDivision){
				dashboard.selectDivision = "${divisionList[0].DIVISION_NO}";
			}
			dashboard.setYear();
		},
		
		setYear : function(){
			$("strong#strongYear").html(dashboard.selectYear + "년");
			dashboard.yearGet();
			
			/* // 이번주 월요일부터 금요일까지 기간 선택
			$("#inputStartDate").val(moment().day(1).format("YYYY-MM-DD"));
			$("#inputEndDate").val(moment().day(5).format("YYYY-MM-DD")); */
		},
		
		//년도 이전 버튼
		prevDate : function() {
			dashboard.selectYear = dashboard.selectYear - 1;
			dashboard.setYear();
			
			dashboard.selectQuarter = 1;
			$('button[name="buttonPjList"]').eq(1).trigger('click');
		},
		
		//년도 다음 버튼
		nextDate : function() {
			dashboard.selectYear = dashboard.selectYear + 1;
			dashboard.setYear();

			dashboard.selectQuarter = 1;
			$('button[name="buttonPjList"]').eq(1).trigger('click');
		},
		
		//년도별 그리드
		yearGet : function(){
			var params = $.param({
				datatype : 'html',
				jsp : '/salesManagement/weeklyReportYearAjax',
				selectDivision : dashboard.selectDivision,
				selectYear : dashboard.selectYear
			});
			 
			$.ajax({
				url : "/salesManagement/selectWeeklyReportYear.do",
				datatype : 'html',
				mtype: 'POST',
				data : params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					$("tbody#row1").html(data);
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		//분기별 그리드
		quarterGet : function(){
			var params = $.param({
				datatype : 'html',
				jsp : '/salesManagement/weeklyReportQuarterAjax',
				selectDivision : dashboard.selectDivision,
				selectQuarter : dashboard.selectQuarter
			});
			
			$.ajax({
				url : "/salesManagement/selectWeeklyReportQuarter.do",
				datatype : 'html',
				mtype: 'POST',
				data : params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					$("tbody#row2").html(data);
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		//엑셀로 다운로드
		download : function() {
			
			var selectDivisionName = $("#selectDivision option:selected").text();
			
			var params = 'selectDivision='+dashboard.selectDivision;
			params += '&selectDivisionName='+selectDivisionName;
			params += '&selectYear='+dashboard.selectYear;
			params += '&selectQuarter='+dashboard.selectQuarter;
			
			window.location='/poi/weeklyReportXlsxDownload.do?' + params;
		}
}

// 본부 검색
// 년도와 분기를 현재 날짜로
$("#selectDivision").change(function(){
	dashboard.selectDivision = $("#selectDivision").val();
	dashboard.selectYear = moment().year(),
	dashboard.selectQuarter = moment().quarter(),
	
	dashboard.setYear();
	$('button[name="buttonPjList"]').eq(dashboard.selectQuarter-1).trigger('click');
});

</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>