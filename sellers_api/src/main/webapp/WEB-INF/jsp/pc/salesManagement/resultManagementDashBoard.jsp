<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<style>
.btn_bottom_dep {
	cursor: pointer;
}
</style>
<div class="row wrapper border-bottom white-bg page-heading">
	<!-- <div class="col-sm-4">
		<h2>성과관리</h2>
		<ol class="breadcrumb">
			<li><a href="/main/index.do">Home</a></li>
			<li><a>성과관리</a></li>
			<li class="active"><strong>성과관리</strong></li>
		</ol>
	</div> -->
</div>

<div class="wrapper wrapper-content  animated fadeInRight">
	<div class="row">
		<div class="col-sm-12">
			<div class="ibox">
				<div class="ibox-content border_n">
					<div class="clear">
						<!-- 탭 -->
						<!-- <div class="mg-b20">
	               				<ul class="nav nav-tabs">
	                				<li class="active"><a href="javascript:void(0);" onclick="dashboard.tab(this,'p');">개인별</a></li>
	              	        		<li><a href="javascript:void(0);" onclick="dashboard.tab(this,'c');">고객사별</a></li>
	             	        	</ul>
	                 		</div> -->
						<!-- 탭end -->
						
						<div class="func-top-left fl_l">
            					<div class="selgrid">
                                     <div class="fl_l mg-r10">
                                         <button class="btn btn-white btn-move" onclick="dashboard.prevDate();"><i class="fa fa-arrow-left"></i></button>
                                         <strong class="term-txt" id="strongDate">2018년 4분기</strong>
                                         <button class="btn btn-white btn-move" onclick="dashboard.nextDate();"><i class="fa fa-arrow-right"></i></button>
                                     </div>
                                     
                                   <!--   <div class="fl_l pd-t3">
                                         <label for="term1" class="mg-r10">
                                             <input type="radio" id="term1" name="radioViewType" value="m"  class=""> <span class="">월</span>
                                         </label>
                                         <label for="term2" class="mg-r10">
                                             <input type="radio" id="term2" name="radioViewType" value="q"  checked="true" class=""> <span class="">분기</span>
                                         </label>
                                         <label for="term3">
                                             <input type="radio" id="term3" name="radioViewType" value="y"  class=""> <span class="">년도</span>
                                         </label>
                                     </div> -->
                                 </div>
                            </div>
                           
						<p class="cboth ag_r" >금액단위 : 백만원</p>
						<table class="dashboard_type1 mg-b50">
							<colgroup>
							</colgroup>
							<thead name="dashboard_p">
								<tr>
									<th rowspan="3">구분</th>
									<th colspan="4"><span id="spanThisYear"></span> Target<br />(목표)</th>
									<th colspan="12">Achievement<br />(분기 누적 현황)
									</th>
									<!-- <th colspan="8">Y2Y</th> -->
									<th colspan="4" class="end" name="thEnd">Q2Q<br />(전 분기 대비)
									</th>
								</tr>
								<tr>
									<th colspan="2">FY<br />(연간)
									</th>
									<th colspan="2"  name="tbThisQuarter">by <span></span>Q<br />(분기 누적)
									</th>
									<th colspan="3">TCV<br />(계약)
									</th>
									<th colspan="3">REV<br />(매출)
									</th>
									<th colspan="3">P.GP<br />(예상 이익)
									</th>
									<th colspan="3">A.GP<br />(실제 이익)
									</th>
									<th>TCV<br />(계약)
									</th>
									<th>REV<br />(매출)
									</th>
									<th>P.GP<br />(예상 이익)
									</th>
									<th class="end">A.GP<br />(실제 이익)
									</th>
								</tr>
								<tr>
									<th>REV<br />(매출)
									</th>
									<th>GP<br />(실제 이익)
									</th>
									<th>REV<br />(매출)
									</th>
									<th>GP<br />(실제 이익)
									</th>

									<th>Amount<br />(총 합계)
									</th>
									<th>FY(%)<br />(연간 달성률)
									</th>
									<th>Q(%)<br />(분기 달성률)
									</th>

									<th>Amount<br />(총 합계)
									</th>
									<th>FY(%)<br />(연간 달성률)
									</th>
									<th>Q(%)<br />(분기 달성률)
									</th>

									<th>Amount<br />(총 합계)
									</th>
									<th>FY(%)<br />(연간 달성률)
									</th>
									<th>Q(%)<br />(분기 달성률)
									</th>

									<th>Amount<br />(총 합계)
									</th>
									<th>FY(%)<br />(연간 달성률)
									</th>
									<th>Q(%)<br />(분기 달성률)
									</th>

									<!--  <th>+-</th>
                                        <th>%</th>
                                        <th>+-</th>
                                        <th>%</th>
                                        <th>+-</th>
                                        <th>%</th>
                                        <th>+-</th>
                                        <th>%</th> -->
									<!-- 
                                        <th>+-</th>
                                        <th>+-</th>
                                         -->

									<th>+-</th>
									<th>+-</th>
									<th>+-</th>
									<th class="end">+-</th>
								</tr>
							</thead>

							<tbody id="row">

							</tbody>
						</table>
						<!--// I. Opportunity Summary  table -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</body>

<form id="formGoList" name="formGoList" method="post">
	<input type="hidden" id="hiddenDashBoardDivision"
		name="hiddenDashBoardDivision" /> <input type="hidden"
		id="hiddenDashBoardTeam" name="hiddenDashBoardTeam" /> <input
		type="hidden" id="hiddenDashBoardMember" name="hiddenDashBoardMember" />
</form>

<script src="<%=request.getContextPath()%>/js/pc/dashboard-depth.js"></script> 

<script type="text/javascript">
$(document).ready(function(){
	dashboard.init();
});

var dashboard = {
		//변수
		tabFlag : 'p', //초기 개인별
		dateCategory : "q", //초기 분기별
		startDate : null,
		endDate : null,
		
		init : function() {
			var dateMap = commonDate.naviDate('q', moment().format('YYYY-MM-DD'), 0);
			dashboard.dateCategory = 'q';
			dashboard.setData(dateMap);
		},
		
		setData : function(dateMap){
			dashboard.startDate = dateMap.startDate; 
			dashboard.endDate = dateMap.endDate;
			$("strong#strongDate").html(dateMap.showDate);
			
			 //ajax호출
			<c:choose>
				<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
				//dashboard.divisionGet();
				dashboardDepth.checkDepth2();
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_CFO')}">
				//dashboard.divisionGet();
				dashboardDepth.checkDepth2();	
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
				//dashboard.divisionGet();
				dashboardDepth.checkDepth2();
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
				//dashboard.teamGetInit();
				dashboardDepth.checkDepth3();
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
				dashboard.memberGetInit();
				</c:when>
				<c:otherwise>
				dashboard.memberGetInit();
				</c:otherwise>
			</c:choose>
		},
		
		//분기 이전 버튼
		prevDate : function() {
			var dateMap = commonDate.naviDate(dashboard.dateCategory, dashboard.startDate, -1);
			dashboard.setData(dateMap);
		},
		
		//분기 다음 버튼
		nextDate : function() {
			var dateMap = commonDate.naviDate(dashboard.dateCategory, dashboard.startDate, 1);
			dashboard.setData(dateMap);
		},
		
		//본부장 화면
		divisionGet : function(callback){
			var params = $.param({
				datatype : 'html',
				jsp : '/salesManagement/resultManagementDashBoardDivisionAjax',
				dateCategory : dashboard.dateCategory,
				startDate: dashboard.startDate,
				endDate: dashboard.endDate
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
					$("tbody#row").html(data);
					if(typeof(callback) == 'function'){
						callback();
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		//팀장 초기화면
		teamGetInit : function(callback){
			var params = $.param({
				datatype : 'html',
				jsp : '/salesManagement/resultManagementDashboardTeamAjax',
				dateCategory : dashboard.dateCategory,
				startDate: dashboard.startDate,
				endDate: dashboard.endDate
			});
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
					$("tbody#row").html(data);
					if(typeof(callback) == 'function'){
						callback();
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		teamGet : function(division, obj, callback){
			var img = $(obj).attr('src');
			var params = $.param({
				datatype : 'html',
				jsp : '/salesManagement/resultManagementDashboardTeamAjax',
				searchDivision : division,
				dateCategory : dashboard.dateCategory,
				startDate: dashboard.startDate,
				endDate: dashboard.endDate
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
						
						if(typeof(callback) == 'function'){
							callback();
						}
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
		
		//직원 초기화면
		memberGetInit : function(){
			var params = $.param({
				datatype : 'html',
				jsp : '/salesManagement/resultManagementDashBoardMemberAjax',
				dateCategory : dashboard.dateCategory,
				startDate: dashboard.startDate,
				endDate: dashboard.endDate
			});
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
					$("tbody#row").html(data);
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		memberGet : function(division, team, obj){
			var img = $(obj).attr('src');
			var params = $.param({
				datatype : 'html',
				jsp : '/salesManagement/resultManagementDashBoardMemberAjax',
				searchDivision : division,
				searchTeam : team,
				dateCategory : dashboard.dateCategory,
				startDate: dashboard.startDate,
				endDate: dashboard.endDate
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
		
		///////////////////////////////////////////////////////////////////
		
		
		goList : function(division, team, member_id_num){
			$('#formGoList input').val(null);
			$('#formGoList #hiddenDashBoardDivision').val(division);
			$('#formGoList #hiddenDashBoardTeam').val(team);
			$('#formGoList #hiddenDashBoardMember').val(member_id_num);
			$('#formGoList').attr('action','/clientSalesActive/viewOpportunityList.do').submit();
		}

}

</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>
