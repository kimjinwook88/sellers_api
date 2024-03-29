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
    <div class="col-sm-4">
        <h2>고도리</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>고객만족</a>
            </li>
            <li class="active">
                <strong>고도리</strong>
            </li>
        </ol>
    </div>
</div>

<div class="wrapper wrapper-content  animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox">
                <div class="ibox-content border_n">
                    <div class="clear">
                    
                    
                    		 <!-- 탭 -->
                    		<%--  
                    		<div class="mg-b20">
	               				<ul class="nav nav-tabs">
	                				<li <c:if test="${param.tabFlag eq 'individual' or param.tabFlag == null}">class="active"</c:if>><a href="javascript:void(0);" onclick="dashboard.tabClick('individual')">영업대표별</a></li>
	              	        		<li <c:if test="${param.tabFlag eq 'clientCompany'}">class="active"</c:if>><a href="javascript:void(0);" onclick="dashboard.tabClick('clientCompany')">고객사별</a></li>
	             	        	</ul>
	                 		</div>
	                 		 --%>
                   			<!-- 탭end -->
                    
                    
                    		<div class="func-top-left fl_l">                                            
                                 <button class="btn btn-white btn-sm" id="buttonPrevQuarter" onclick="dashboard.prevQuarter();"><i class="fa fa-arrow-left"></i></button>
                                 <strong id="strongThisQuart"></strong>
                                 <button class="btn btn-white btn-sm" id="buttonNextQuarter" onclick="dashboard.nextQuarter();"><i class="fa fa-arrow-right"></i></button>
                             </div>
                             
                            <div class="fl_r pd-b20">
								<div class="fl_l mg-r10">
									<a href="/etc/viewGodoryList.do" class="btn btn-outline btn-seller-outline">리스트</a>
								</div>
								<div class="fl_l">
					   				<button type="button" class="btn btn-w-m btn-seller" onclick="dashboard.goReset();">신규등록</button>
								</div> 
				 			</div>
				 			
                            <!-- I. ClientIssue Summary  table -->
                            <table class="dashboard_type1 mg-b50">
                                <colgroup>
                                    <col width=""/>
                                    <col width="10%"/>
                                    <col width="10%"/>
                                    <col width="10%"/>
                                    <col width="10%"/>
                                    <col width="10%"/>
                                    <col width="10%"/>
                                    <col width="10%"/>
                                    <col width="10%"/>
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th rowspan="2">구분</th>
                                        <th rowspan="2">전체</th>
                                        <th colspan="3">고도리구분</th>
                                        <th colspan="3" class="end">진행경과</th>
                                    </tr>
                                    <tr>
                                        <th>고쳐주세요</th>
                                        <th>도와주세요</th>
                                        <th>이런건어때요</th>
                                        <th>진행중</th>
                                        <th>지연</th>
                                        <th class="end">완료</th>
                                    </tr>
                                </thead>
                                <tbody id="row">
                                    

                                </tbody>
                            </table>
                            <!--// I. ClientIssue Summary  table -->
                        </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>

<form id="formGoList" name="formGoList" method="post">
	<input type="hidden" id="hiddenDashBoardYear" name="hiddenDashBoardYear"/>
	<input type="hidden" id="hiddenDashBoardQuarter" name="hiddenDashBoardQuarter"/>
	<input type="hidden" id="hiddenDashBoardDivision" name="hiddenDashBoardDivision"/>
	<input type="hidden" id="hiddenDashBoardTeam" name="hiddenDashBoardTeam"/>
	<input type="hidden" id="hiddenDashBoardMember" name="hiddenDashBoardMember"/>
	<input type="hidden" id="hiddenDashBoardCategory" name="hiddenDashBoardCategory"/>
	<input type="hidden" id="hiddenDashBoardStatus" name="hiddenDashBoardStatus"/>
	<input type="hidden" id="hiddenModalReset" name="hiddenModalReset"/>
	<input type="hidden" id="tabFlag" name="tabFlag"/>
</form>


<script type="text/javascript">

var quarter = "";
var quarterDate = "";
var quarterYear = moment().year();

$(document).ready(function(){
	dashboard.init();
});

var dashboard = {
		init : function(){
			if(quarter == "" || quarter == null) quarter = moment().quarter();
			
			dashboard.checkQuarter();
			
		},
		
		
		//개인별, 고객사별 탭 클릭시
		/* 
		tabClick : function(tabFlag) {
			$('#formGoList input').val(null);
			$('#formGoList #tabFlag').val(tabFlag);
			$('#formGoList').attr('action','/clientSatisfaction/viewClientIssueDashBoard.do').submit();
		},
		 */
		
		
		checkQuarter : function() {
			switch(quarter) {
				case 1 : quarterDate = quarterYear + '-01-01'; break;
				case 2 : quarterDate = quarterYear + '-04-01'; break;
				case 3 : quarterDate = quarterYear + '-07-01'; break;
				case 4 : quarterDate = quarterYear + '-10-01'; break;
				default : alert("에러"); ;
			} 
			$("strong#strongThisQuart").html(quarterYear + "년 " + quarter +"분기");
			
			<c:choose>
				<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
				dashboard.divisionGet();	
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_CFO')}">
				dashboard.divisionGet();	
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
				dashboard.divisionGet();
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
				dashboard.teamGetInit();
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
				dashboard.memberGetInit();
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_ADMIN')}">
				dashboard.divisionGet();	
				</c:when>
			</c:choose>
		},
		
		prevQuarter : function() {
			if(quarter == 1){
				quarter = 4;
				quarterYear = quarterYear - 1;
			}else {
				quarter = quarter - 1;
			}
			dashboard.checkQuarter();
		},
		
		nextQuarter : function() {
			if(quarter == 4){
				quarter = 1;
				quarterYear = quarterYear + 1;
			}else {
				quarter = quarter + 1;
			}
			dashboard.checkQuarter();
		},
		
		divisionGet : function(){
			var params = $.param({
				searchDate : quarterDate,
				datatype : 'html',
				jsp : '/etc/clientGodoryDashBoardDivisionAjax'
			});
			$.ajax({
				url : "/etc/selectGodoryDashBoardDivision.do",
				datatype : 'html',
				method: 'POST',
				data : params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					//var list = data.rows;
					//defaultInfo.view(list);
					$("tbody#row").html('');
					$("tbody#row").html(data);
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		teamGet : function(division, obj){
			var img = $(obj).attr('src');
			var params = $.param({
				searchDivision : division,
				searchDate : quarterDate,
				datatype : 'html',
				jsp : '/etc/clientGodoryDashBoardTeamAjax'
			});
			if(img.indexOf("plus") != -1){ //부서 펼치기
				$.ajax({
					url : "/etc/selectGodoryDashBoardTeam.do",
					datatype : 'html',
					method: 'POST',
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
		
		
		//팀장 초기화면
		teamGetInit : function(){
			var params = $.param({
				searchDate : quarterDate,
				datatype : 'html',
				jsp : '/etc/clientGodoryDashBoardTeamAjax'
			});
			$.ajax({
				url : "/etc/selectGodoryDashBoardTeam.do",
				datatype : 'html',
				method: 'POST',
				data : params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					$("tbody#row").html('');
					$("tbody#row").html(data);
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		
		employeeGet : function(division, team, obj){
			var img = $(obj).attr('src');
			var params = $.param({
				searchDivision : division,
				searchTeam : team,
				searchDate : quarterDate,
				datatype : 'html',
				jsp : '/etc/clientGodoryDashBoardMemberAjax'
			});
			if(img.indexOf("plus") != -1){ //팀 펼치기
				$.ajax({
					url : "/etc/selectGodoryDashBoardMember.do",
					datatype : 'html',
					method: 'POST',
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
				searchDate : quarterDate,
				datatype : 'html',
				jsp : '/etc/clientGodoryDashBoardMemberAjax'
			});
			$.ajax({
				url : "/etc/selectGodoryDashBoardMember.do",
				datatype : 'html',
				method: 'POST',
				data : params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					$("tbody#row").html('');
					$("tbody#row").html(data);
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		//대시보드에서 클릭했을때 링크
		goList : function(division, team, member_id_num, category, status){
			$('#formGoList input').val(null);
			$('#formGoList #hiddenDashBoardYear').val(quarterYear);
			$('#formGoList #hiddenDashBoardQuarter').val(quarter);
			$('#formGoList #hiddenDashBoardDivision').val(division);
			$('#formGoList #hiddenDashBoardTeam').val(team);
			$('#formGoList #hiddenDashBoardMember').val(member_id_num);
			$('#formGoList #hiddenDashBoardCategory').val(category);
			$('#formGoList #hiddenDashBoardStatus').val(status);
			$('#formGoList').attr('action','/etc/viewGodoryList.do').submit();
		},
		
		goReset : function(){
			$('#formGoList input').val(null);
			$('#formGoList #hiddenModalReset').val(true);
			$('#formGoList').attr('action','/etc/viewGodoryList.do').submit();
		},
		
		countCheck : function(count) {
			if($(count)[0].outerText == 0) {
				return false;
			}else{
				return true;
			}
			
		}

}

</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>
