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
        <h2>영업기회</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>고객영업활동</a>
            </li>
            <li class="active">
                <strong>영업기회</strong>
            </li>
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
	                				<li class="active"><a href="javascript:void(0);" onclick="dashboard.tab(this,'p');">개인별</a></li>
	              	        		<li><a href="javascript:void(0);" onclick="dashboard.tab(this,'c');">고객사별</a></li>
	             	        	</ul>
	                 		</div> -->
                 			
            				 <div class="func-top-left fl_l">
            					<div class="selgrid">
                                     <div class="fl_l mg-r10">
                                         <button class="btn btn-white btn-move" onclick="dashboard.prevDate();"><i class="fa fa-arrow-left"></i></button>
                                         <strong class="term-txt" id="strongDate">2018년 4분기</strong>
                                         <button class="btn btn-white btn-move" onclick="dashboard.nextDate();"><i class="fa fa-arrow-right"></i></button>
                                     </div>
                                     
                                     <div class="fl_l pd-t3">
                                         <label for="term1" class="mg-r10">
                                             <input type="radio" id="term1" name="radioViewType" value="m"  class=""> <span class="">월</span>
                                         </label>
                                         <label for="term2" class="mg-r10">
                                             <input type="radio" id="term2" name="radioViewType" value="q"  checked="true" class=""> <span class="">분기</span>
                                         </label>
                                         <label for="term3">
                                             <input type="radio" id="term3" name="radioViewType" value="y"  class=""> <span class="">년도</span>
                                         </label>
                                     </div>
                                 </div>
                            </div>
					    	
                            <div class="fl_r pd-b20">
								<div class="fl_l mg-r10">
									<a href="javascript:dashboard.goList();" class="btn btn-outline btn-seller-outline">리스트</a>
								</div>
								<div class="fl_l">
					   				<button type="button" class="btn btn-w-m btn-seller" onclick="dashboard.goReset();">신규등록</button>
								</div> 
				 			</div>
                            
                            <!-- I. Opportunity Summary  table -->
                            	<p class="cboth ag_r" >금액단위 : 백만원</p>
                           		<table class="dashboard_type1 mg-b50">
	                                <colgroup name="dashboard_p">
	                                    <col width=""/>
	                                    <col width="6%"/>
	                                    <col width="6%"/>
	                                    <col width="6%"/>
	                                    <col width="6%"/>
	                                    <col width="6%"/>
	                                    <col width="6%"/>
	                                    <col width="6%"/>
	                                    <col width="6%"/>
	                                    <col width="6%"/>
	                                    <col width="6%"/>
	                                    <col width="6%"/>
	                                    <col width="6%"/>
	                                    <col width="6%"/>
	                                    <col width="6%"/>
	                                    <col width="6%"/>
	                                </colgroup>
	                                <thead name="dashboard_p">
	                                    <tr>
	                                        <th rowspan="2">구분</th>
	                                        <!-- <th rowspan="2">GP<br/>(총 이익)</th> -->
	                                        <th colspan="5">TCV<br/>(예상계약금액)</th>
	                                        <th colspan="5">REV<br/>(매출)</th>
	                                        <th colspan="5" class="end">GP<br/>(총 이익)</th>
	                                        <!-- <th rowspan="2" class="end key-chang">Weekly<br/>KEY Changes</th> -->
	                                    </tr>
	                                    <tr>
	                                        <th name="thEnd">QTD<br/>(분기 마감현황)</th>
	                                        <th>In FCST<br/>(매출예측<br/>영업기회)</th>
	                                        <th>+/- Tgt<br/>(목표 대비)</th>
	                                        <th name="thLast">Q2Q<br/>(전 분기 대비)</th>
	                                        <th>Out FCST<br/>(추가 영업기회)</th>
	                                        <th name="thEnd">QTD<br/>(분기 마감현황)</th>
	                                        <th>In FCST<br/>(매출예측<br/>영업기회)</th>
	                                        <th>+/- Tgt<br/>(목표 대비)</th>
	                                        <th name="thLast">Q2Q<br/>(전 분기 대비)</th>
	                                        <th>Out FCST<br/>(추가 영업기회)</th>
	                                        <th name="thEnd">QTD<br/>(분기 마감현황)</th>
	                                        <th>In FCST<br/>(매출예측<br/>영업기회)</th>
	                                        <th>+/- Tgt<br/>(목표 대비)</th>
	                                        <th name="thLast">Q2Q<br/>(전 분기 대비)</th>
	                                        <th class="end">Out FCST<br/>(추가 영업기회)</th>
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
	<input type="hidden" id="hiddenDashBoardCompany" name="hiddenDashBoardCompany"/>
	<input type="hidden" id="hiddenDashBoardCompanyCateogry" name="hiddenDashBoardCompanyCateogry"/>
	<input type="hidden" id="hiddenDashBoardDate" name="hiddenDashBoardDate"/>
	<input type="hidden" id="hiddenDashBoardDivision" name="hiddenDashBoardDivision"/>
	<input type="hidden" id="hiddenDashBoardTeam" name="hiddenDashBoardTeam"/>
	<input type="hidden" id="hiddenDashBoardMember" name="hiddenDashBoardMember"/>
	<input type="hidden" id="hiddenDashBoardForecast" name="hiddenDashBoardForecast"/>
	<input type="hidden" id="hiddenModalReset" name="hiddenModalReset"/>
	<input type="hidden" id="hiddenDashBoardStartDate" name="hiddenDashBoardStartDate"/>
	<input type="hidden" id="hiddenDashBoardEndDate" name="hiddenDashBoardEndDate"/>
	<input type="hidden" id="hiddenDashBoardDateCategory" name="hiddenDashBoardDateCategory"/>
</form>

<script src="<%=request.getContextPath()%>/js/pc/dashboard-depth.js"></script> 

<script type="text/javascript">
$(document).ready(function(){
	dashboard.init();
	
	//기본 분기로 Go! ~
	$("input[name='radioViewType']").eq(1).prop("checked",true);
	$("input[name='radioViewType']").eq(1).trigger("change");
});

var dashboard = {
		//변수
		tabFlag : 'p', //초기 개인별
		dateCategory : "q", //초기 분기별
		startDate : null,
		endDate : null,
		
		init : function() {
			//년, 월, 분기
			$("input[name='radioViewType']").on('change',function(){
				dateMap = commonDate.naviDate($(this).val(), moment().format('YYYY-MM-DD'), 0);
				dashboard.dateCategory = $(this).val();
				if(dashboard.dateCategory == 'y'){
					$('th[name="thEnd"]').html('YTD<br/>(년 마감현황)');
					$('th[name="thLast"]').html('Y2Y<br/>(전 년 대비)');
				}else if(dashboard.dateCategory == 'q'){
					$('tth[name="thEnd"]').html('QTD<br/>(분기 마감현황)');
					$('th[name="thLast"]').html('Q2Q<br/>(전 분기 대비)');
				}else if(dashboard.dateCategory == 'm'){
					$('th[name="thEnd"]').html('MTD<br/>(월 마감현황)');
					$('th[name="thLast"]').html('M2M<br/>(전 월 대비)');
				}else{
					$('th[name="thEnd"]').html('QTD<br/>(분기 마감현황)');
					$('th[name="thLast"]').html('Q2Q<br/>(전 분기 대비)');
				}
				
				dashboard.setData(dateMap);
			});
		},
		
		setData : function(dateMap){
			dashboard.startDate = dateMap.startDate; 
			dashboard.endDate = dateMap.endDate;
			$("strong#strongDate").html(dateMap.showDate);
			
			 //ajax호출
			<c:choose>
				<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
				dashboardDepth.checkDepth2();
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_CFO')}">
				dashboardDepth.checkDepth2();	
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
				dashboardDepth.checkDepth2();
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
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
				jsp : '/clientSalesActive/opportunityDashBoardDivisionAjax',
				dateCategory : dashboard.dateCategory,
				startDate: dashboard.startDate,
				endDate: dashboard.endDate
			});
			$.ajax({
				url : "/clientSalesActive/selectOpportunityDashBoardDivision.do",
				datatype : 'html',
				mtype: 'POST',
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
		
		//팀별 대시보드
		teamGet : function(division, obj, callback){
			var img = $(obj).attr('src');
			var params = $.param({
				datatype : 'html',
				jsp : '/clientSalesActive/opportunityDashBoardTeamAjax',
				searchDivision : division,
				dateCategory : dashboard.dateCategory,
				startDate: dashboard.startDate,
				endDate: dashboard.endDate
			});
			if(img.indexOf("plus") != -1){ //부서 펼치기
				$.ajax({
					url : "/clientSalesActive/selectOpportunityDashBoardTeam.do",
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
		
		//팀장 초기화면
		teamGetInit : function(callback){
			var params = $.param({
				datatype : 'html',
				jsp : '/clientSalesActive/opportunityDashBoardTeamAjax',
				dateCategory : dashboard.dateCategory,
				startDate: dashboard.startDate,
				endDate: dashboard.endDate
			});
			$.ajax({
				url : "/clientSalesActive/selectOpportunityDashBoardTeam.do",
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
		
		//직원별 대시보드
		memberGet : function(division, team, obj){
			var img = $(obj).attr('src');
			var params = $.param({
				datatype : 'html',
				jsp : '/clientSalesActive/opportunityDashBoardMemberAjax',
				searchDivision : division,
				searchTeam : team,
				dateCategory : dashboard.dateCategory,
				startDate: dashboard.startDate,
				endDate: dashboard.endDate
			});
			if(img.indexOf("plus") != -1){ //팀 펼치기
				$.ajax({
					url : "/clientSalesActive/selectOpportunityDashBoardMember.do",
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
		
		//직원 초기화면
		memberGetInit : function(){
			var params = $.param({
				datatype : 'html',
				jsp : '/clientSalesActive/opportunityDashBoardMemberAjax',
				dateCategory : dashboard.dateCategory,
				startDate: dashboard.startDate,
				endDate: dashboard.endDate
			});
			$.ajax({
				url : "/clientSalesActive/selectOpportunityDashBoardMember.do",
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
		
		//고객사별 그룹화
		companyGroupGet : function(obj){
			var params = $.param({
				datatype : 'html',
				jsp : '/clientSalesActive/clientContactDashBoardCompanyGroupAjax',
				searchDate : dashboard.quarterDate,
				startDate: dashboard.startDate,
				endDate: dashboard.endDate
			});
			$.ajax({
				url : "/clientSalesActive/selectOpportunityDashBoardCompanyGroup.do",
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
		
		//고객사별 펼친것
		companyGet : function(category,obj){
			var img = $(obj).attr('src');
			var params = $.param({
				datatype : 'html',
				jsp : '/clientSalesActive/clientContactDashBoardCompanyAjax',
				searchCategory : category,
				searchDate : dashboard.quarterDate,
				startDate: dashboard.startDate,
				endDate: dashboard.endDate					
			});
			if(img.indexOf("plus") != -1){ //드릴다운 펼치기
				$.ajax({
					url : "/clientSalesActive/selectOpportunityDashBoardComapny.do",
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
						$('tr[name="sub_tr_'+category+'"]').removeClass('last');
						$('tr[name="sub_tr_'+category+'"]:last').addClass("last");
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			}else{ //드릴다운 닫기
				$(obj).attr('src',img.replace('minus','plus'));		
				$('tr[data-category="'+category+'"]').remove();
				//마지막 line
				$('tr[name="sub_tr_'+category+'"]').removeClass('last');
				$('tr[name="sub_tr_'+category+'"]:last').addClass("last");
			}
		},
		
		goList : function(division, team, member_id_num, forecast){
			$('#formGoList input').val(null);
			$('#formGoList #hiddenDashBoardDateCategory').val(dashboard.dateCategory);
			$('#formGoList #hiddenDashBoardStartDate').val(dashboard.startDate);
			$('#formGoList #hiddenDashBoardEndDate').val(dashboard.endDate);
			$('#formGoList #hiddenDashBoardDivision').val(division);
			$('#formGoList #hiddenDashBoardTeam').val(team);
			$('#formGoList #hiddenDashBoardMember').val(member_id_num);
			$('#formGoList #hiddenDashBoardForecast').val(forecast);
			$('#formGoList').attr('action','/clientSalesActive/viewOpportunityList.do').submit();
		},
		
		goListCompany : function(company_name,forecast,company_category){
			$('#formGoList input').val(null);
			$('#formGoList #hiddenDashBoardDate').val(dashboard.quarterDate);
			$('#formGoList #hiddenDashBoardCompany').val(company_name);
			$('#formGoList #hiddenDashBoardCompanyCateogry').val(company_category);
			$('#formGoList #hiddenDashBoardForecast').val(forecast);
			$('#formGoList').attr('action','/clientSalesActive/viewOpportunityList.do').submit();
		},
		
		goReset : function(){
			$('#formGoList input').val(null);
			$('#formGoList #hiddenModalReset').val('true');
			$('#formGoList').attr('action','/clientSalesActive/viewOpportunityList.do').submit();
		}
		
}

</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>
