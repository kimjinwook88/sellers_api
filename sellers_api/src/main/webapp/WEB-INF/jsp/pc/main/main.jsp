<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="<%=request.getContextPath()%>/js/pc/google-chart.js"></script> 

<style>
.nv-legend{ transform: translate(-175px, 325px); }
tbody#tbodyMainModule tr:not(.lastTr):hover{cursor: pointer;}
</style>	

		<div class="wrapper wrapper-content animated fadeInRight">
            	
            	<div class="col-lg-12 pd-no">
                    <div class="pull-right m-b">
                        <button class="btn btn-white " data-toggle="modal" data-target="#mainModuleSetup" onclick="openMainModuleSetup();"><i class="fa fa-gear"></i> 모듈설정</button>
                    </div>
                    
                    <!-- <div class="pull-right m-r-sm">
                        <button class="btn btn-white " data-toggle="modal" data-target="#mainMenuSetup" onclick="openMainMenuSetup();"><i class="fa fa-gear"></i> 메뉴설정</button>
                    </div> -->
                </div>
                 
		     <!-- 메인 신규 -->
		     <div class="row">
		     		
                    <c:choose>
						<c:when test="${fn:length(selectMainModuleSetUp) > 0}">
							<c:forEach items="${selectMainModuleSetUp}" var="selectMainModuleSetUp" varStatus="status">
								<div class="col-lg-4" id="divMain_${status.index+1}"></div>
							</c:forEach>
								<div class="col-lg-4" id="divMain_${fn:length(selectMainModuleSetUp)+1}"></div>
						</c:when>
					</c:choose>
					
					
												
					<div class="col-sm-12" id="divGraph" style="width:99.99%; display:none">
                       <div class="ibox">
                            <div class="ibox-title landing-header">
                                <h5>실적현황</h5>
                            </div>
                           <div class="ibox-content border_n">
                            	<div class="clear">
	                               <!--  <ul class="nav nav-tabs">
				                         <li name="resultTabGraph" class=""><a data-toggle="tab" href="#tab-1" >1분기</a></li>
				                         <li name="resultTabGraph" class=""><a data-toggle="tab" href="#tab-2" >2분기</a></li>
				                         <li name="resultTabGraph" class=""><a data-toggle="tab" href="#tab-3" >3분기</a></li>
				                         <li name="resultTabGraph" class=""><a data-toggle="tab" href="#tab-4" >4분기</a></li>
				                         <li name="resultTab" class=""><a data-toggle="tab" href="#tab-5"><span name="spanYear"></span>년</a></li>
				                    </ul> -->
									<div id="chartAchieve"></div>
			                    	<%-- <table class="dashboard_type1 mg-b50">
										<colgroup>
										</colgroup>
										<thead name="dashboard_p">
											<tr>
												<th rowspan="3">구분</th>
												<th colspan="12" class="end">Achievement</th>
											</tr>
											<tr>
												<th colspan="3">TCV</th>
												<th colspan="3">REV</th>
												<th colspan="3">P.GP</th>
												<th colspan="3" class="end">A.GP</th>
											<tr>
												<th>Amount</th>
												<th>FY(%)</th>
												<th>Q(%)</th>
			
												<th>Amount</th>
												<th>FY(%)</th>
												<th>Q(%)</th>
			
												<th>Amount</th>
												<th>FY(%)</th>
												<th>Q(%)</th>
			
												<th>Amount</th>
												<th>FY(%)</th>
												<th class="end">Q(%)</th>
											</tr>
										</thead>
										<tbody id="rowAchieve">
										</tbody>
									</table> --%>
							    </div>
                            </div>
                        </div>
                    </div>
			</div>
		    <!-- //메인 신규 -->
		     
		     
		    <!-- 모듈 설정 -->
		    <jsp:include page="/WEB-INF/jsp/pc/main/mainModuleSetup.jsp"/>
		    
		</div>
 	</div>
 </div>
</body>

<!-- o365메일 팝업용 -->
<form name="o365_frmData" id="o365_frmData" method="post">
    <input type="hidden" name="o365_subject" id="o365_subject" value="" />
    <input type="hidden" name="o365_start" id="o365_start" value="" />
    <input type="hidden" name="o365_end" id="o365_end" value="" />
    <input type="hidden" name="o365_detail" id="o365_detail" value="" />
    <input type="hidden" name="o365_location" id="o365_location" value="" />
</form>

<link rel="stylesheet" href="<%=request.getContextPath()%>/nvD3/nvd3/nv.d3.min.css" />
<script src="<%=request.getContextPath()%>/nvD3/d3.min.js" charset="utf-8"></script>
<script src="<%=request.getContextPath()%>/nvD3/angular/angular.js"></script>
<script src="<%=request.getContextPath()%>/nvD3/nvd3/nv.d3.min.js"></script>
<script src="<%=request.getContextPath()%>/nvD3/angular-nvd3/angular-nvd3.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		//에러 & 버그 문의
// 		if("${userInfo.MEMBER_ID_NUM}" == "0489" || "${userInfo.MEMBER_ID_NUM}" == "0486"){
// 			alramErrNbug.get();
// 		}

		main.init();
	});
	
// 	var alramErrNbug = {
// 			get : function(){
// 				$.ajax({
// 					url : "/main/selectErrNbugList.do",
// 					async : false,
// 		 			datatype : 'html',
// 		 			method: 'POST',
// 		 			data : {
// 		 				member_id_num  : "${userInfo.MEMBER_ID_NUM}",
// 		 				flag : "alramErrNbug"
// 		 			},
// 					beforeSend : function(xhr){
//					xhr.setRequestHeader("AJAX", true);
// 						$.ajaxLoading();
// 					},
// 					success : function(data)
// 					{
//						
// 						if(data.list != null)
// 						{
//							
// 							var errDetail = "";
// 							for(var i=0; i<data.list.length; i++){
// 								errDetail += i+1+"."+"["+data.list[i].MENU_FLAG+"] "+ data.list[i].Q_DETAIL + " -- " +data.list[i].HAN_NAME+" 님 요청!\n";
// 							}
// 							alert(errDetail);
// 						}
// 					},
// 					complete : function(){
//						$.ajaxLoadingHide();
//					}
// 				});
// 			}
// 	}
	
	
	var main = {
			quarterStartDate : null,
			quarterEndDate : null,
			
			init : function(){
				/* //필수~
				<c:choose>
					<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
						main.selectResultGraph("영업실적 (누적)","1","Y", moment().format('Q'));	
					</c:when>
					<c:when test="${fn:contains(auth, 'ROLE_CFO')}">
						main.selectResultGraph("영업실적 (누적)","1","Y", moment().format('Q'));	
					</c:when>
					<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
						main.selectResultGraph("영업실적 (누적)","1","Y", moment().format('Q'));
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose> */
				
				//선택 DB MENU_ID와 맞춰야함~
				<c:forEach items="${selectMainModuleSetUp}" var="selectMainModuleSetUp" varStatus="status">
					switch("${selectMainModuleSetUp.MM_ID}"){
						case "1": //영업실적 표
							//main.selectResultGraph("${selectMainModuleSetUp.MM_NAME}","${status.index+1}","${selectMainModuleSetUp.USE_YN}", moment().format('Q'));
							break;
						case "2": //영업실적
							main.selectResult("${selectMainModuleSetUp.MM_NAME}","${status.index+1}","${selectMainModuleSetUp.USE_YN}", moment().format('Q'));
							break;
						case "3": //나의 관리고객
							main.selectMyCompanyList("${selectMainModuleSetUp.MM_NAME}","${status.index+1}","${selectMainModuleSetUp.USE_YN}");
							break;
						case "4": //고객컨택내용
							main.selectContactList("${selectMainModuleSetUp.MM_NAME}","${status.index+1}","${selectMainModuleSetUp.USE_YN}");
							break;
						//case "4": //최근 등록된 고객(최근 1개월내)
						//	main.selectNewCpnList("${status.index+1}","${selectMainModuleSetUp.USE_YN}");
						//	break;
						case "5": //나의 일정
							main.selectTimeLine("${selectMainModuleSetUp.MM_NAME}","${status.index+1}","${selectMainModuleSetUp.USE_YN}",null);
							break;
						case "6": //영업기회 (최근 7일)
							main.selectSalesAct("${selectMainModuleSetUp.MM_NAME}","${status.index+1}","${selectMainModuleSetUp.USE_YN}");
							break;
						case "7": //잠재영업기회
							main.selectHiddenSalesAct("${selectMainModuleSetUp.MM_NAME}","${status.index+1}","${selectMainModuleSetUp.USE_YN}");
							break;
						case "8": //고객이슈
							main.selectClientIssue("${selectMainModuleSetUp.MM_NAME}","${status.index+1}","${selectMainModuleSetUp.USE_YN}");
							break;
						case "9": //DUE-DATE TRACKING
							main.selectTrackingList("${selectMainModuleSetUp.MM_NAME}","${status.index+1}","${selectMainModuleSetUp.USE_YN}");
							break;
						case "10": //영업기회 (최근 2주간 활동없음)
							main.selectSalesAct2("${selectMainModuleSetUp.MM_NAME}","${status.index+1}","${selectMainModuleSetUp.USE_YN}");
							break;
						case "11": //영업기회 현황 - 점 차트
							main.selectSalesActBubbleChart("${selectMainModuleSetUp.MM_NAME}","${status.index+1}","${selectMainModuleSetUp.USE_YN}");
							break;
						case "12": //영업실적 차트 - 도넛 차트
							main.selectSalesActDonutChart("${selectMainModuleSetUp.MM_NAME}","${status.index+1}","${selectMainModuleSetUp.USE_YN}");
							break;
					}
				</c:forEach>	
			},
			
			//영업실적
			selectResult : function(mm_name, mm_seq, use_yn, q){
				if(use_yn == "Y" || isEmpty(use_yn)){
					var params = $.param({
						datatype : 'html',
						jsp : '/main/mainResult',
						searchMemberId : "${userInfo.MEMBER_ID_NUM}",
		 				searchQuarter : q
					});
					$.ajax({
						url : "/main/selectResult.do",
			 			datatype : 'html',
			 			method: 'POST',
			 			data : params,
						beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
							$.ajaxLoadingShow();
						},
						success : function(data){
							$('#divMain_'+mm_seq).html(data);
							$('#divMain_'+mm_seq).find("div.ibox-title h5").html(mm_name);
						},
						complete : function(){
							$('li[name="resultTab"]').removeClass('active');
							$('li[name="resultTab"]').eq(q-1).addClass('active');
							$('span[name="spanYear"]').html(moment().format('Y'));
							setTimeout(function(){
								$("li[name='resultTab'] a").each(function(idx,val){
									$(this).attr("onclick","main.selectResult('"+mm_name+"',"+mm_seq+",'"+use_yn+"',"+(idx+1)+");");
								});
								$.ajaxLoadingHide();
							},300);
						}
					});
				}else{
					$('#divMain_'+mm_seq).remove();
				}
			},
			
			//나의 관리고객
			selectMyCompanyList : function(mm_name, mm_seq, use_yn){
				if(use_yn == "Y" || isEmpty(use_yn)){
					var params = $.param({
						datatype : 'html',
						jsp : '/main/mainMyCompanyList'
					});
					$.ajax({
						url : "/main/selectMyCompanyList.do",
						async : false,
			 			datatype : 'html',
			 			method: 'POST',
			 			data : params,
			 			beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
							$.ajaxLoading();
						},
						success : function(data){
							$('#divMain_'+mm_seq).html(data);
							$('#divMain_'+mm_seq).find("div.ibox-title h5").html(mm_name);
						},
						complete : function(){
							$.ajaxLoadingHide();
						}
					});
				}else{
					$('#divMain_'+mm_seq).remove();
				}
			},
			
			//고객컨택리스트
			selectContactList : function(mm_name, mm_seq, use_yn){
				if(use_yn == "Y" || isEmpty(use_yn)){
					var params = $.param({
						datatype : 'html',
						jsp : '/main/mainContactList'
					});
					$.ajax({
						url : "/main/selectContactList.do",
						async : false,
			 			datatype : 'html',
			 			method: 'POST',
			 			data : params,
			 			beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
							$.ajaxLoading();
						},
						success : function(data){
							$('#divMain_'+mm_seq).html(data);
							$('#divMain_'+mm_seq).find("div.ibox-title h5").html(mm_name);
						},
						complete : function(){
							$.ajaxLoadingHide();
						}
					});
				}else{
					$('#divMain_'+mm_seq).remove();
				}
			},
			
			//최근 등록된 고객(최근 1개월내)
			selectNewCpnList : function(mm_name, mm_seq, use_yn){
				if(use_yn == "Y" || isEmpty(use_yn)){
					$("#divNewClientList").show();
					var params = $.param({
						datatype : 'html',
						jsp : '/main/mainNewCpnListAjax'
					});
					$.ajax({
						url : "/main/selectNewCpnList.do",
						async : false,
			 			datatype : 'html',
			 			method: 'POST',
			 			data : params,
			 			beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
							$.ajaxLoading();
						},
						success : function(data){
							$('#divMain_'+mm_seq).html(data);
							$('#divMain_'+mm_seq).find("div.ibox-title h5").html(mm_name);
						},
						complete : function(){
							$.ajaxLoadingHide();
						}
					});
				}else{
					$("#divNewClientList").hide();
					$('#divMain_'+mm_seq).remove();
				}
			},
			
			//최근 등록된 고객(최근 1개월내)
			selectNewCstmList : function(firstCompanyId, secondCompanyId, searchCompanyId, searchCompanyName, notFirstCompanyId, notSecondCompanyId) {
				$("#divNewCstmList > strong.title").html(searchCompanyName + ' 신규고객');
				var params = $.param({
					datatype : 'html',
					jsp : '/main/mainNewCstmListAjax',
					FIRST_COMPANY : firstCompanyId,
					SECOND_COMPANY : secondCompanyId,
					SEARCH_ID : searchCompanyId,
					NOT_FIRST_SEARCH_ID : notFirstCompanyId,
					NOT_SECOND_SEARCH_ID : notSecondCompanyId
				});
				$.ajax({
					url : "/main/selectNewCstmList.do",
					async : false,
		 			datatype : 'html',
		 			method: 'POST',
		 			data : params,
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoading();
					},
					success : function(data){
						$('#divNewCstmList > ul').html(data);
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			},
			
			//나의 일정
			timeLineDate : 	moment().format('YYYY-MM-DD'),
			selectTimeLine : function(mm_name,mm_seq,use_yn,s){
				if(use_yn == "Y" || isEmpty(use_yn)){
					if(s == 'p'){//더하기
						main.timeLineDate = moment(main.timeLineDate).add(1,'day').format('YYYY-MM-DD')
					}else if(s == 'm'){ //빼기
						main.timeLineDate = moment(main.timeLineDate).add(-1,'day').format('YYYY-MM-DD')
					}else{
					}
					var params = $.param({
						datatype : 'html',
						jsp : '/main/mainTimeLineAjax',
						searchDate : main.timeLineDate,
						searchMemberId : '${userInfo.MEMBER_ID_NUM}'
					});
					$.ajax({
						url : "/main/selectTimeLine.do",
						async : false,
			 			datatype : 'html',
			 			method: 'POST',
			 			data : params,
			 			beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
							$.ajaxLoading();
						},
						success : function(data){
							$('#divMain_'+mm_seq).html(data);
							$('#divMain_'+mm_seq).find("div.ibox-title h5").html(mm_name);
							$("#timeLineDate").html(main.timeLineDate);
							$("#timeLinePrev").attr("onclick","main.selectTimeLine('"+mm_name+"',"+mm_seq+",'"+use_yn+"','m');");
							$("#timeLineNext").attr("onclick","main.selectTimeLine('"+mm_name+"',"+mm_seq+",'"+use_yn+"','p');");
						},
						complete : function(){
							$.ajaxLoadingHide();
						}
					});
				}else{
					$('#divMain_'+mm_seq).remove();
				}
			},
			
			//영업기회 (최근 7일)
			selectSalesAct : function(mm_name, mm_seq, use_yn){
				if(use_yn == "Y" || isEmpty(use_yn)){
					var params = $.param({
						datatype : 'html',
						jsp : '/main/mainSalesActAjax',
						searchMemberId : '${userInfo.MEMBER_ID_NUM}'
					});
					$.ajax({
						url : "/main/selectSalesAct.do",
						async : false,
			 			datatype : 'html',
			 			method: 'POST',
			 			data : params,
			 			beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
							$.ajaxLoading();
						},
						success : function(data){
							$('#divMain_'+mm_seq).html(data);
							$('#divMain_'+mm_seq).find("div.ibox-title h5").html(mm_name);
						},
						complete : function(){
							$.ajaxLoadingHide();
						}
					});
				}else{
					$('#divMain_'+mm_seq).remove();	
				}
			},
			
			//영업기회 (최근 2주간 활동 없음)
			selectSalesAct2 : function(mm_name, mm_seq, use_yn){
				if(use_yn == "Y" || isEmpty(use_yn)){
					var params = $.param({
						datatype : 'html',
						jsp : '/main/mainSalesActAjax2',
						searchMemberId : '${userInfo.MEMBER_ID_NUM}'
					});
					$.ajax({
						url : "/main/selectSalesAct2.do",
						async : false,
			 			datatype : 'html',
			 			method: 'POST',
			 			data : params,
			 			beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
							$.ajaxLoading();
						},
						success : function(data){
							$('#divMain_'+mm_seq).html(data);
							$('#divMain_'+mm_seq).find("div.ibox-title h5").html(mm_name);
						},
						complete : function(){
							$.ajaxLoadingHide();
						}
					});
				}else{
					$('#divMain_'+mm_seq).remove();	
				}
			},
			
			//잠재영업기회 (진행중)
			selectHiddenSalesAct : function(mm_name, mm_seq, use_yn){
				if(use_yn == "Y" || isEmpty(use_yn)){
					var params = $.param({
						datatype : 'html',
						jsp : '/main/mainHiddenSalesActAjax',
						searchMemberId : '${userInfo.MEMBER_ID_NUM}'
					});
					$.ajax({
						url : "/main/selectHiddenSalesAct.do",
						async : false,
			 			datatype : 'html',
			 			method: 'POST',
			 			data : params,
			 			beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
							$.ajaxLoading();
						},
						success : function(data){
							$('#divMain_'+mm_seq).html(data);
							$('#divMain_'+mm_seq).find("div.ibox-title h5").html(mm_name);
						},
						complete : function(){
							$.ajaxLoadingHide();
						}
					});
				}else{
					$('#divMain_'+mm_seq).remove();	
				}
			},
			
			//고객이슈
			selectClientIssue : function(mm_name, mm_seq, use_yn){
				if(use_yn == "Y" || isEmpty(use_yn)){
					var params = $.param({
						datatype : 'html',
						jsp : '/main/mainClientIssueAjax',
						searchMemberId : '${userInfo.MEMBER_ID_NUM}'
					});
					$.ajax({
						url : "/main/selectClientIssue.do",
						async : false,
			 			datatype : 'html',
			 			method: 'POST',
			 			data : params,
			 			beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
							$.ajaxLoading();
						},
						success : function(data){
							$('#divMain_'+mm_seq).html(data);
							$('#divMain_'+mm_seq).find("div.ibox-title h5").html(mm_name);
						},
						complete : function(){
							$.ajaxLoadingHide();
						}
					});
				}else{
					$('#divMain_'+mm_seq).remove();	
				}
			},
			
			//실적현황 그래프 -> 표
			selectResultGraph : function(mm_name, mm_seq, use_yn,q){
				if(use_yn == "Y" || isEmpty(use_yn)){
					main.fnQuarter(q);
					var params = $.param({
						datatype : 'html',
						jsp : '/main/mainAchieveDivisionAjax',
						startDate : main.quarterStartDate,
						endDate : main.quarterEndDate
					});
					$.ajax({
						url : "/salesManagement/selectResultDashBoardDivision.do",
						data : params,
						datatype : 'html',
						method : 'POST',
						beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
							$.ajaxLoadingShow();
						},
						success : function(data){
							$("#divGraph").show();
							$('#divGraph').find("div.ibox-title h5").html(mm_name);
							$('#divMain_'+mm_seq).before($("#divGraph"));	
							$('#divMain_'+mm_seq).remove();
							$("#chartAchieve").html(data);
							
							$('li[name="resultTabGraph"]').removeClass('active');
							$('li[name="resultTabGraph"]').eq(q-1).addClass('active');
							$('span[name="spanYear"]').html(moment().format('Y'));
							setTimeout(function(){
								$("li[name='resultTabGraph'] a").each(function(idx,val){
									$(this).attr("onclick","main.selectResultGraph('"+mm_name+"',"+mm_seq+",'"+use_yn+"',"+(idx+1)+");");
								});
							},300);
						},
						complete : function(){
							$.ajaxLoadingHide();
						}
					});
				}else{
					$('#divMain_'+mm_seq).remove();	
				}
				/* $("#divGraph li").removeClass("active");
				if(use_yn == "Y" || isEmpty(use_yn)){
					$("#divGraph").show();
					$('#divMain_'+mm_seq).before($("#divGraph"));	
					$('#divMain_'+mm_seq).remove();
					var sel = 'div[ng-controller="MainCtrl"]';
				    var $scope = angular.element(sel).scope();
				    $scope.grid(moment().format('Q'));
				    $scope.$apply();
				    $("#divGraph li").eq(moment().format('Q')-1).addClass("active");
				    $('#divGraph').find("div.ibox-title h5").html(mm_name);
				}else{
					$('#divMain_'+mm_seq).remove();	
					$("#divGraph").remove();
				} */
			},
			
			//영업현황 도넛 차트
			selectSalesActDonutChart : function(mm_name, mm_seq, use_yn){
				if(use_yn == "Y" || isEmpty(use_yn)){
					var params = $.param({
						datatype : 'html',
						jsp : '/main/mainSalesActDonutChartAjax',
						startDate : (moment().format('YYYY') + '-01-01'),
						endDate : (moment().format('YYYY') + '-12-31'),
						selectQuarter : 'y'
					});
					$.ajax({
						url : "/main/selectSalesActDonutChart.do",
						data : params,
						datatype : 'html',
						method : 'POST',
						beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
							$.ajaxLoadingShow();
						},
						success : function(data){
							$('#divMain_'+mm_seq).before(data);	
							$('#divMain_'+mm_seq).remove();
							$('#divDonut').find("div.ibox-title h5").html(mm_name);
						},
						complete : function(){
							$.ajaxLoadingHide();
						}
					});
				}else{
					$('#divMain_'+mm_seq).remove();	
				}
			},
						
			//DUE-DATE-TRACKING
			selectTrackingList : function(mm_name, mm_seq, use_yn){
				if(use_yn == "Y" || isEmpty(use_yn)){
					var params = $.param({
						datatype : 'html',
						jsp : '/main/mainTrackingAjax',
						searchDate : $('#timeLineDate').html(),
		 				searchMemberId : '${userInfo.MEMBER_ID_NUM}'
					});
					$.ajax({
						url : "/main/selectTrackingList.do",
						async : false,
			 			datatype : 'html',
			 			method: 'POST',
			 			data : params,
			 			beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
							$.ajaxLoading();
						},
						success : function(data){
							$('#divMain_'+mm_seq).html(data);
							$('#divMain_'+mm_seq).find("div.ibox-title h5").html(mm_name);
						},
						complete : function(){
							$.ajaxLoadingHide();
						}
					});
				}else{
					$('#divMain_'+mm_seq).remove();	
				}
			},
			
			//영업기회 현황 - 거품 차트 
			selectSalesActBubbleChart : function(mm_name, mm_seq, use_yn){
				if(use_yn == "Y" || isEmpty(use_yn)){
					var params = $.param({
						datatype : 'html',
						jsp : '/main/mainSalesActBubbleChartAjax',
						searchDate : moment().format('YYYY-MM-DD'),
						searchType : null,//월 m 분기q 년y null이면 분기
		 				searchMemberId : '${userInfo.MEMBER_ID_NUM}'
					});
					
					$.ajax({
						url : "/main/selectSalesActBubbleChart.do",
						async : false,
			 			datatype : 'html',
			 			method: 'POST',
			 			data : params,
			 			beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
							$.ajaxLoading();
						},
						success : function(data){
							/* $("#divChart").show();
							$('#divChart').find("div.ibox-title h5").html(mm_name);
							$('#divMain_'+mm_seq).before($("#divChart"));	
							$('#divMain_'+mm_seq).remove();
							$("div#oppData").html(data); */
							
							$('#divMain_'+mm_seq).before(data);	
							$('#divMain_'+mm_seq).remove();
						},
						complete : function(){
							$.ajaxLoadingHide();
						}
					});
				}else{
					$('#divMain_'+mm_seq).remove();	
				}
			},
			
			goDetail : function(pk,code){
				var openNewWindow = window.open("about:blank");
				switch (code) {
				case "1":
					menuCookieSet("영업기회");
					openNewWindow.location.href = "/clientSalesActive/viewOpportunityList.do?opportunity_id="+pk;
					break;
				case "2":
					menuCookieSet("잠재영업기회");
					openNewWindow.location.href = "/clientSalesActive/viewHiddenOpportunityList.do?opportunity_hidden_id="+pk;
					break;
				case "3":
					menuCookieSet("고객이슈");
					openNewWindow.location.href = "/clientSatisfaction/viewClientIssueList.do?issue_id="+pk;
					break;
				case "4":
					menuCookieSet("일정관리");
					openNewWindow.location.href = "/calendar/viewCalendar.do?notice_event_id="+pk;
					break;
				}
			},
			
			goTacking : function(eventId, url){
				var openNewWindow = window.open("about:blank");
				menuCookieSet("TRACKING");
				//menuCookieSet($('#side-menu a:contains("TRACKING")').attr('menu-id')); //메뉴 활성화
				openNewWindow.location.href = url;
			},
			
			goCompanyList : function(company_id,search_detail){
				var openNewWindow = window.open("about:blank");
				openNewWindow.location.href = "/clientManagement/viewClientCompanyInfoDetail.do?company_id="+company_id+"&searchDetail="+search_detail;
			},
			
			goContactList : function(event_id){
				var openNewWindow = window.open("about:blank");
				openNewWindow.location.href = "/clientSalesActive/viewClientContactList.do?event_id="+event_id;	
			},
			
			//고객개인정보 바로가기.
			goCustomerList : function(customer_name,customer_id,company_id){
				var openNewWindow = window.open("about:blank");
				openNewWindow.location.href = "/clientManagement/viewClientIndividualInfoDetail.do?customer_name="+customer_name+"&customer_id="+customer_id+"&company_id="+company_id;
			},
			
			//경농 고도리
			selectGodoryList : function() {
				var params = $.param({
					datatype : 'html',
					jsp : '/main/mainGodoryListAjax'
				});
				$.ajax({
					url : "/etc/selectGodoryList.do",
					async : false,
		 			datatype : 'html',
		 			method: 'POST',
		 			data : params,
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoading();
					},
					success : function(data){
						$('#divGodorytList').html(data);
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			},
			
			//경농
			goGodory : function(pk){
				var openNewWindow = window.open("about:blank");
				menuCookieSet(고도리);
				openNewWindow.location.href = "/etc/viewGodoryList.do?issueId="+pk;
			},
			
			//office365연동 된 메일 내용 바로가기
			goTimeLineO365 : function(obj){
				$('#o365_frmData > input[name="o365_subject"]').val($(obj).children().eq(0)["0"].defaultValue);
				$('#o365_frmData > input[name="o365_start"]').val($(obj).children().eq(1)["0"].defaultValue);
				$('#o365_frmData > input[name="o365_end"]').val($(obj).children().eq(2)["0"].defaultValue);
				$('#o365_frmData > input[name="o365_detail"]').val($(obj).children().eq(3)["0"].defaultValue.replace(/(\r\n|\r|\n|\n\r)/g, "<br>"));
				$('#o365_frmData > input[name="o365_location"]').val($(obj).children().eq(4)["0"].defaultValue);
				
				var pop_title = "o365_frmData";
		        window.open("", pop_title);
		        var frmData = document.o365_frmData;
		        frmData.target = pop_title;
		        frmData.action = "/calendar/viewCalendar.do";
		        frmData.submit();
			},
			
			//Achieve
			divisionGet : function(q){
				main.fnQuarter(q);
				var params = $.param({
					datatype : 'html',
					jsp : '/main/mainAchieveDivisionAjax',
					startDate : main.quarterStartDate,
					endDate : main.quarterEndDate
				});
				$.ajax({
					url : "/salesManagement/selectResultDashBoardDivision.do",
					data : params,
					datatype : 'html',
					method : 'POST',
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoadingShow();
					},
					success : function(data){
						$("tbody#rowAchieve").html(data);
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			},
			
			teamGet : function(division, obj){
				var img = $(obj).attr('src');
				var params = $.param({
					datatype : 'html',
					jsp : '/main/mainAchieveTeamAjax',
					searchDivision : division,
					startDate : main.quarterStartDate,
					endDate : main.quarterEndDate
				});
				if(img.indexOf("plus") != -1){ //부서 펼치기
					$.ajax({
						url : "/salesManagement/selectResultDashBoardTeam.do",
						datatype : 'html',
						method : 'POST',
						data : params,
						beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
							$.ajaxLoadingShow();
						},
						success : function(data){
							$(obj).attr('src',img.replace('plus','minus'));
							$(obj).closest( "tr.tr_list" ).after(data);
							//마지막 line
							$('tr[name="sub_tr_'+division+'"]').removeClass('last');
							$('tr[name="sub_tr_'+division+'"]:last').addClass("last");
						},
						complete : function(){
							$.ajaxLoadingHide();
						}
					});
				}else{ //부서 닫기
					$(obj).attr('src',img.replace('minus','plus'));		
					$('tr[data-division="'+division+'"]').remove();
					//마지막 line
					$('tr[name="sub_tr_'+division+'"]').removeClass('last');
					$('tr[name="sub_tr_'+division+'"]:last').addClass("last");
				}
			},
			
			memberGet : function(division, team, obj){
				var img = $(obj).attr('src');
				var params = $.param({
					datatype : 'html',
					jsp : '/main/mainAchieveMemberAjax',
					searchDivision : division,
					searchTeam : team,
					startDate : main.quarterStartDate,
					endDate : main.quarterEndDate
				});
				if(img.indexOf("plus") != -1){ //팀 펼치기
					$.ajax({
						url : "/salesManagement/selectResultDashBoardMember.do",
						datatype : 'html',
						method : 'POST',
						data : params,
						beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
							$.ajaxLoadingShow();
						},
						success : function(data){
							$(obj).attr('src',img.replace('plus','minus'));
							$(obj).closest( "tr.tr_list" ).after(data);
							//마지막 line
							$('tr[name="sub_tr_'+division+'"]').removeClass('last');
							$('tr[name="sub_tr_'+division+'"]:last').addClass("last");
						},
						complete : function(){
							$.ajaxLoadingHide();
						}
					});
				}else{ //팀 닫기
					$(obj).attr('src',img.replace('minus','plus'));		
					$('tr[data-team="'+team+'"]').remove();
					//마지막 line
					$('tr[name="sub_tr_'+division+'"]').removeClass('last');
					$('tr[name="sub_tr_'+division+'"]:last').addClass("last");
				}
			},
			
			fnQuarter : function(q){
				if(q == "1"){
					main.quarterStartDate = moment().format('YYYY') + '-01-01'  
					main.quarterEndDate = moment().format('YYYY') + '-03-31'
				}else if(q == "2"){
					main.quarterStartDate = moment().format('YYYY') + '-04-01'  
					main.quarterEndDate = moment().format('YYYY') + '-06-30'
				}else if(q == "3"){
					main.quarterStartDate = moment().format('YYYY') + '-07-01'  
					main.quarterEndDate = moment().format('YYYY') + '-09-30'
				}else if(q == "4"){
					main.quarterStartDate = moment().format('YYYY') + '-10-01'  
					main.quarterEndDate = moment().format('YYYY') + '-12-31'
				}
			}
	}
	
	window.onload = function () {
		/* var color_arr = [
			['#2dbae7', '#e5f6fb'],
			['#00a1a3', '#dcf8f4'],
			['#499f45', '#e4f7e3'],
			['#fcbb0d', '#fbf6df'],
			['#ff7e00', '#fff1e0'],
			['#df3c1c', '#ffe4e0']
		];

		$("div.ibox-title").each(function(idx, val){
			$(this).css("border-color",color_arr[idx % color_arr.length][0]);
			$(this).css("background-color",color_arr[idx % color_arr.length][1]);
		}); */
    }
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>

