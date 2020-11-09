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
								<div class="selgrid selgrid1 auto mg-r5">
									<select class="form-control m-b" name="selectFacePost"
										id="selectFacePost">
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

								<div class="selgrid selgrid1 auto mg-r5">
									<select class="form-control m-b" name="selectFaceTeam"
										id="selectFaceTeam">
										<c:choose>
											<c:when test="${fn:length(searchDetailGroup.faceTeam) > 0}">
												<option value="" selected='selected'>전체 팀</option>
												<c:forEach items="${searchDetailGroup.faceTeam}"
													var="searchDetailGroup">
													<option value="${searchDetailGroup.TEAM_NAME}">${searchDetailGroup.TEAM_NAME}</option>
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

								<!-- 상위 부서 이동 영역 -->
								<!-- <div class="selgrid selgrid1 mg-r5">
			                                    <a href="#" class="btn-movup" onclick="back.conn();">회사 전체보기</a>
			                                </div>
			                                 -->


							</div>
						</div>

						<!-- 상위 부서 이동 영역 -->
						<div class="fc-clear col-sm-12 pd-no mg-b20">
							<div class="btn-product-group">
								<a href="#" class="btn-movup first" onclick="back.conn();">회사
									전체보기</a>
							</div>
						</div>
						
						<!-- 그리드 데이터 -->
						<div class="tabs-container mg-b20" id="memberList">
							<br />
							<ul class="nav nav-tabs mg-b20" id="memberListTab">
							</ul>
						</div>
						<!-- 테이블  -->
						<div id="memberTable"></div>

						<!-- 왼쪽영역 -->
						<div class="col-sm-6">
							<div id="leftChart"></div>
						</div>
	
						<!-- 오른쪽 영역 -->
						<div class="col-sm-6">
							<div id="rightChart"></div>
						</div>

					</div>
					<!-- pos-rel end -->
				</div>
				<!-- clear end-->

				<!-- <div class="func-top-right fl_r pd-b20"></div> -->
				<!-- <table id="sellersGridMember"></table> -->
			</div>
			<!-- ibox end-->

			<div style="display: none">
				<div class="func-top-right fl_r pd-b20"></div>
				<br /> <br /> <br />
				<table id="sellersGrid"></table>
			</div>
		</div>
	</div>
</div>
</body>

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
	
	jqGrid.draw();
});


var back = {
	conn : function() {
		location.href="/salesManagement/viewProductivity.do?role=roleCeo"
	}
}


var rotateLabels = 0;
//==========================angluar Graph Start===================================
googleChart.load(drawChart);

function drawChart() {
	
  $.ajax({
	 	url : "/salesManagement/gridFaceTime.do",
		async : false,
		datatype : 'json',
		method: 'POST',
		data : {
			roleChildDivision : "Y",
			selectFaceYear : $("#selectFaceYear").val(),
			selectFaceMonth : $("#selectFaceMonth").val(),
			selectFaceQuarter : $("#selectFaceQuarter").val(),
			selectFacePost:$("#selectFacePost").val(),
			selectFaceTeam:$("#selectFaceTeam").val(),
			viewType : $("input:radio[name='radioViewType']:checked").val(),
			gridTabFlag : "Y",
			skipAvgTab : "Y"
		},
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
			$.ajaxLoading();
		},
		success : function(data){
			if(data.rows[0].DIVISION_NAME == "보안 본부"){
				rotateLabels = -20;
			}else {
				rotateLabels = 0;
			}
			
			//===========================좌측 그래프 start======================================
			var LColumns = ['고객컨택', '컨택준비', '내부회의', '교육', '기타', '휴가', '이동시간', '미입력'];
			var LChartData = [];
			
			for(var i=0; i<data.rows.length; i++){
				/* 
				if(i ==  data.rows.length - 1) {
					data.rows[i].TEAM_NAME = '본부평균';
					
				}
				 */
				 
			 	var dataArr = [];
				
				//string 사업본부 제거
				var teamName_scheduleLabel= data.rows[i].TEAM_NAME.replace("사업본부", "");
				teamName_scheduleLabel = teamName_scheduleLabel.replace("사업부", "");
				teamName_scheduleLabel = teamName_scheduleLabel.replace("팀", "");
				
				dataArr.push(teamName_scheduleLabel); // 컬럼명
				dataArr.push(data.rows[i].THIS_EVENT_PERCENT_1 * 1); //고객컨택
				dataArr.push(data.rows[i].THIS_EVENT_PERCENT_2 * 1); //컨택준비
				dataArr.push(data.rows[i].THIS_EVENT_PERCENT_3 * 1); //내부회의
				dataArr.push(data.rows[i].THIS_EVENT_PERCENT_4 * 1); //교육
				dataArr.push(data.rows[i].THIS_EVENT_PERCENT_6 * 1); //기타
				dataArr.push(data.rows[i].THIS_EVENT_PERCENT_7 * 1); //휴가
				dataArr.push(data.rows[i].THIS_EVENT_PERCENT_5 * 1); //이동시간
				dataArr.push(data.rows[i].THISOTHER * 1); //미입력
				
				LChartData.push(dataArr);
			}
			
			var chart1 = new GoogleChart();
			chart1.columnChart.options.isStacked = 'percent';
			chart1.columnChart.draw(LColumns, LChartData, 'leftChart');
			//===========================좌측 그래프 end======================================
			
			//===========================우측 그래프 start======================================
			
			var RColumns = ['누적평균시간'];
			var RChartData = [];
			
			for(var i=0; i<data.rows.length; i++){
				
				var dataArr = [];
				
				if(data.rows[i].TEAM_NAME !=null) {
					
					//string 사업본부 제거
					var teamName_label= data.rows[i].TEAM_NAME.replace("사업본부", "");
					teamName_label = teamName_label.replace("사업부", "");
					teamName_label = teamName_label.replace("팀", "");
					
					if(data.rows[i].TEAM_NAME == "회사평균") {
						//data.rows[i].TEAM_NAME = '회사평균';
						
						dataArr.push(teamName_label, data.rows[i].avr);
					} else {
						dataArr.push(teamName_label, data.rows[i].avr);
					}
					RChartData.push(dataArr);
				}
				
			}//for
			
			var chart2 = new GoogleChart();
			chart2.columnChart.options.vAxis.format = '###.#시간';
			chart2.columnChart.draw(RColumns, RChartData, 'rightChart');
			//===========================우측 그래프 end======================================
		},//success
		complete : function(){
			$.ajaxLoadingHide();
		}
	});
}

/*
 *  jqGrid function()  Tab 정보 가져오기
 */
var jqGrid = {
	draw : function() {
		$sellersGrid.jqGrid({
 			url : "/salesManagement/gridFaceTime.do?",
			datatype : 'json',
			mtype: 'POST',
			postData : { 
				roleChildDivision : "Y",
				gridTabFlag : "Y",
				selectFaceYear:$("#selectFaceYear").val(), 
				selectFaceMonth:$("#selectFaceMonth").val(), 
				selectFaceQuarter:$("#selectFaceQuarter").val(), 
				selectFacePost:$("#selectFacePost").val(),
				//selectFaceTeam:$("#selectFaceTeam").val(),
				viewType : $("input:radio[name='radioViewType']:checked").val(),
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
			loadBeforeSend : function(xhr){
				//$.ajaxLoadingShow();
				$sellersGrid.parents('div.ui-jqgrid-bdiv').css("max-height","450px");
				var colLabelCompare;
				var colLabel;
		    },
			loadComplete : function(data){
				//팀별 그리드
				//jqGrid.getMemberList(data.rows[0].TEAM_NAME);
				jqGrid.getMemberTable(data.rows[0].TEAM_NAME);
				
				var startTab = '1';
				for(var i=0; i<data.rows.length; i++)
				{
					if(data.rows[i].TEAM_NAME != null)
					{
						if(startTab==1)
						{
	//						$("#memberListTab").append('<li class="active"><a data-toggle="tab" onClick="jqGrid.getMemberList('+"'"+data.rows[i].TEAM_NAME+"'"+');">' + data.rows[i].TEAM_NAME+'</a></li>');
	//						$("#memberListTab").append('<li class="active"><a data-toggle="tab" onClick="jqGrid.reload('+"'"+data.rows[i].TEAM_NAME+"'"+');">' + data.rows[i].TEAM_NAME+'</a></li>');
							$("#memberListTab").append('<li class="active"><a data-toggle="tab" onClick="jqGrid.getMemberTable('+"'"+data.rows[i].TEAM_NAME+"'"+');">' + data.rows[i].TEAM_NAME+'</a></li>');
						}else
						{
							//그리드 안쓰고 테이블로 쓰기 위해 주석
	//						$("#memberListTab").append('<li class=""><a data-toggle="tab" onClick="jqGrid.reload('+"'"+data.rows[i].TEAM_NAME+"'"+');">' + data.rows[i].TEAM_NAME+'</a></li>');
							$("#memberListTab").append('<li class=""><a data-toggle="tab" onClick="jqGrid.getMemberTable('+"'"+data.rows[i].TEAM_NAME+"'"+');">' + data.rows[i].TEAM_NAME+'</a></li>');
						}
						startTab = '2';
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
			url : "/salesManagement/gridFaceTime.do?",
 			mtype: 'POST',
 			postData : { 
 				gridDataYN : "Y",
 				roleChildDivision : "Y", //분기 쿼리에서 사용
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
	$("#selectFacePost,#selectFaceYear,#selectFaceMonth,#selectFaceQuarter").trigger("change");
});

//조건 검색 
$("#selectFaceMonth,#selectFaceQuarter").change(function(){
 
 var params = $.param({
		viewType : $("input:radio[name='radioViewType']:checked").val(),
		selectFaceYear : $("#selectFaceYear").val(),
		selectFaceMonth : $("#selectFaceMonth").val(),
		selectFaceQuarter : $("#selectFaceQuarter").val(),
		role : "roleCeo",
		roleChildDivision : "Y",
		selectFacePost : $("#selectFacePost").val()
	});
	//var param = "?selectFacePost="+$("#selectFacePost").val()+"&selectFaceYear="+$("#selectFaceYear").val()+"&selectFaceMonth="+$("#selectFaceMonth").val();
	 location.href="/salesManagement/viewProductivity.do?"+params;
});

$("#selectFaceYear").change(function(){
	 
	 var params = $.param({
			viewType : $("input:radio[name='radioViewType']:checked").val(),
			selectFaceYear : $("#selectFaceYear").val(),
//			selectFaceMonth : $("#selectFaceMonth").val(),
//			selectFaceQuarter : $("#selectFaceQuarter").val(),
			role : "roleCeo",
			roleChildDivision : "Y",
			selectFacePost : $("#selectFacePost").val()
		});
		//var param = "?selectFacePost="+$("#selectFacePost").val()+"&selectFaceYear="+$("#selectFaceYear").val()+"&selectFaceMonth="+$("#selectFaceMonth").val();
		 location.href="/salesManagement/viewProductivity.do?"+params;
	});
 
$("#selectFacePost").change(function(){
	var params = $.param({
		//divisionNteamType : 'division',
		role : "roleCeo",
		roleChildDivision : "Y",
		viewType : $("input:radio[name='radioViewType']:checked").val(),
		selectFacePost : $("#selectFacePost").val(),
		selectFaceYear : $("#selectFaceYear").val(),
		selectFaceMonth : $("#selectFaceMonth").val(),
		selectFaceQuarter : $("#selectFaceQuarter").val()
	});
	//var param = "?selectFacePost="+$("#selectFacePost").val()+"&selectFaceYear="+$("#selectFaceYear").val()+"&selectFaceMonth="+$("#selectFaceMonth").val();
	 location.href="/salesManagement/viewProductivity.do?"+params;
});

$("#selectFaceTeam").change(function(){
	var params = $.param({
		//divisionNteamType : 'team',
		role : "roleCeo",
		roleChildTeam : "Y",
		viewType : $("input:radio[name='radioViewType']:checked").val(),
		selectFacePost : $("#selectFacePost").val(),
		selectFaceTeam : $("#selectFaceTeam").val(),
		selectFaceYear : $("#selectFaceYear").val(),
		selectFaceMonth : $("#selectFaceMonth").val(),
		selectFaceQuarter : $("#selectFaceQuarter").val()
	});
	//var param = "?selectFacePost="+$("#selectFacePost").val()+"&selectFaceYear="+$("#selectFaceYear").val()+"&selectFaceMonth="+$("#selectFaceMonth").val();
	 location.href="/salesManagement/viewProductivity.do?"+params;
});
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>