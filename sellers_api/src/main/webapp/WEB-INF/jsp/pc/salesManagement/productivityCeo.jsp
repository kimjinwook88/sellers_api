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
 
<div class="row wrapper border-bottom white-bg page-heading">
	<!-- <div class="col-sm-4">
		<h2>생산성</h2>
		<ol class="breadcrumb">
			<li><a href="/main/index.do">Home</a></li>
			<li><a>성과관리</a></li>
			<li class="active"><strong>생산성</strong></li>
		</ol>
	</div> -->
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
								<div class="selgrid selgrid1 auto mg-r5">
									<select class="form-control m-b" name="selectFacePost" id="selectFacePost">
										<c:choose>
											<c:when test="${fn:length(searchDetailGroup.facePost) > 0}">
												<option value="">전체 본부</option>
												<c:forEach items="${searchDetailGroup.facePost}" var="searchDetailGroup">
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
					<div class="col-sm-6">
						<div id="leftChart"></div>
					</div>

					<!-- 오른쪽 영역 -->
					<div class="col-sm-6">
						<div id="rightChart"></div>
					</div>

				</div>
				<!-- clear  end -->
			</div>
			<!-- ibox end -->
		</div>
	</div>
</div>

<script src="<%=request.getContextPath()%>/js/pc/set-date.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="<%=request.getContextPath()%>/js/pc/google-chart.js"></script>
<script type="text/javascript">
/*
 *  전역변수
 */
var gridWidth;
var listRow = 10;
var hearderTitle;
var gridStatus=true;

$(document).ready(function() {
		
		setDate.appendOption("${selectFaceYear}", "${selectFaceMonth}", "${selectFaceQuarter}", "${viewType}");
	
		// 그래프 영역 높이 설정
		$('#leftChart').css('height', '550px');
		$('#rightChart').css('height', '550px');
});

//==========================Google Chart Start===================================
googleChart.load(drawChart);
		
function drawChart() {
		$.ajax({
         url: "/salesManagement/gridFaceTime.do",
         async : false,
         dataType: "json",
         method : 'POST',
         data : {
        	  viewType : $( "input:radio[name='radioViewType']:checked").val(),
        	  selectFaceYear : $("#selectFaceYear").val(),
			  selectFaceMonth : $("#selectFaceMonth").val(),
			  selectFaceQuarter : $("#selectFaceQuarter").val(),
			  gridTabFlag : "Y",
			  skipAvgTab : "Y"
          },
				 	beforeSend : function() {
						$.ajaxLoading();
					},
					success : function(data) {
							
					//===========================좌측 그래프 start======================================
						var LColumns = ['고객컨택', '컨택준비', '내부회의', '교육', '기타', '휴가', '이동시간', '미입력'];
						var LChartData = [];
							
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
							
							var dataArr = [];
							
							//string 사업본부 제거
							var divisionName_scheduleLabel= data.rows[i].DIVISION_NAME.replace("사업본부", "");
							divisionName_scheduleLabel = divisionName_scheduleLabel.replace("사업부", "");
							
							dataArr.push(divisionName_scheduleLabel); // 컬럼명
							dataArr.push(data.rows[i].THIS_EVENT_PERCENT_1 * 1); //고객컨택
							dataArr.push(data.rows[i].THIS_EVENT_PERCENT_2 * 1); //컨택준비
							dataArr.push(data.rows[i].THIS_EVENT_PERCENT_3 * 1); //내부회의
							dataArr.push(data.rows[i].THIS_EVENT_PERCENT_4 * 1); //교육
							dataArr.push(data.rows[i].THIS_EVENT_PERCENT_6 * 1); //기타
							dataArr.push(data.rows[i].THIS_EVENT_PERCENT_7 * 1); //휴가
							dataArr.push(data.rows[i].THIS_EVENT_PERCENT_5 * 1); //이동시간
							dataArr.push(data.rows[i].THISOTHER * 1); //미입력

							LChartData.push(dataArr);
						}//for
							
						var chart1 = new GoogleChart();
						chart1.columnChart.options.isStacked = 'percent';
						chart1.columnChart.draw(LColumns, LChartData, 'leftChart');
					//===========================좌측 그래프 end======================================
					
					//===========================우측 그래프 start======================================
						var RColumns = ['누적평균시간'];
						var RChartData = [];
							
						for (var i = 0; i < data.rows.length; i++) {
							
							var dataArr = [];
							
							//string 사업본부 제거
							var divisionName_dataObjLabel= data.rows[i].DIVISION_NAME.replace("사업본부", "");
							divisionName_dataObjLabel = divisionName_dataObjLabel.replace("사업부", "");
								
							if (i == data.rows.length - 1)	{
									//data.rows[i].DIVISION_NAME = '회사평균';
									
								dataArr.push(divisionName_dataObjLabel, data.rows[i].avr);
							} else {
								dataArr.push(divisionName_dataObjLabel, data.rows[i].avr);
							}
							
							RChartData.push(dataArr);
					  }
						
						var chart2 = new GoogleChart();
						chart2.columnChart.options.vAxis.format = '###.#시간';
						chart2.columnChart.draw(RColumns, RChartData, 'rightChart');
						//===========================우측 그래프 end======================================
					}
			});
}//drawChart
		
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