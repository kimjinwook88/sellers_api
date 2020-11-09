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
        <h2>고객컨택내용</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>고객영업활동</a>
            </li>
            <li class="active">
                <strong>고객컨택내용</strong>
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
                                 <button class="btn btn-white btn-sm" id="buttonPrevQuarter" onclick="dashboard.prevQuarter();"><i class="fa fa-arrow-left"></i></button>
                                 <strong id="strongThisQuart"></strong>
                                 <button class="btn btn-white btn-sm" id="buttonNextQuarter" onclick="dashboard.nextQuarter();"><i class="fa fa-arrow-right"></i></button>
                             </div>
                             
                            <div class="fl_r pd-b20">
								<div class="fl_l mg-r10">
									<a href="/clientSalesActive/viewClientContactList.do" class="btn btn-outline btn-seller-outline">리스트</a>
								</div>
								<div class="fl_l">
					   				<button type="button" class="btn btn-w-m btn-seller" onclick="dashboard.goReset();">신규등록</button>
								</div> 
				 			</div>
				 			
                            <!-- I. ClientIssue Summary  table -->
                            <table class="dashboard_type1 mg-b50">
                                <colgroup>
                                    <col width="*"/>
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
                                        <th colspan="5">컨택방법</th>
                                        <th colspan="2" class="end">연관 컨텐츠</th>
                                    </tr>
                                    <tr>
                                        <th>방문</th>
                                        <th>마케팅</th>
                                        <th>SNS</th>
                                        <th>E-mail</th>
                                        <th>전화</th>
                                        <th>연관<br />이슈</th>
                                        <th class="end">연관<br />잠재영업기회</th>
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
	<input type="hidden" id="hiddenDashBoardRelate" name="hiddenDashBoardRelate"/>
	<input type="hidden" id="hiddenDashBoardCompany" name="hiddenDashBoardCompany"/>
	<input type="hidden" id="hiddenDashBoardCompanyCateogry" name="hiddenDashBoardCompanyCateogry"/>
	<input type="hidden" id="hiddenModalReset" name="hiddenModalReset"/>
</form>

<script src="<%=request.getContextPath()%>/js/pc/dashboard-depth.js"></script> 

<script type="text/javascript">
$(document).ready(function(){
	dashboard.init();
});

var dashboard = {
		//변수
		tabFlag : 'p', //초기 개인별
		quarter : null,
		quarterDate : null,
		quarterYear : moment().year(),
		
		//초기함수
		init : function(){
			if(dashboard.quarter == "" || dashboard.quarter == null) dashboard.quarter = moment().quarter();
			dashboard.checkQuarter();
		},
		
		//개인별, 고객사별 탭 클릭시
		tab : function(obj,val){
			$(obj).parent('li').siblings('li').removeClass('active');
			$(obj).parent('li').addClass('active');
			if(val=='p'){ //개인별
				dashboard.tabFlag = val;
				dashboard.quarterYear = moment().year(); //날짜 초기화
				dashboard.quarter = moment().quarter();
				dashboard.checkQuarter();
			}else{ //고객사
				dashboard.tabFlag = val;
				dashboard.quarterYear = moment().year(); //날짜 초기화
				dashboard.quarter = moment().quarter();
				dashboard.checkQuarter();
			}
		},
		
		//로딩 시 분기 계산
		checkQuarter : function() {
			switch(dashboard.quarter) {
				case 1 : dashboard.quarterDate = dashboard.quarterYear + '-01-01'; break;
				case 2 : dashboard.quarterDate = dashboard.quarterYear + '-04-01'; break;
				case 3 : dashboard.quarterDate = dashboard.quarterYear + '-07-01'; break;
				case 4 : dashboard.quarterDate = dashboard.quarterYear + '-10-01'; break;
				default : alert("에러");
			} 
			$("strong#strongThisQuart").html(dashboard.quarterYear + "년 " + dashboard.quarter +"분기");
			if(dashboard.tabFlag == 'p'){
			//권한별 함수 적용
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
			</c:choose>
			}else{
				dashboard.companyGroupGet();
			}
		},
		
		//분기 이전 버튼
		prevQuarter : function() {
			if(dashboard.quarter == 1){
				dashboard.quarter = 4;
				dashboard.quarterYear = dashboard.quarterYear - 1;
			}else {
				dashboard.quarter = dashboard.quarter - 1;
			}
			dashboard.checkQuarter();
		},
		
		//분기 다음 버튼
		nextQuarter : function() {
			if(dashboard.quarter == 4){
				dashboard.quarter = 1;
				dashboard.quarterYear = dashboard.quarterYear + 1;
			}else {
				dashboard.quarter = dashboard.quarter + 1;
			}
			dashboard.checkQuarter();
		},
		
		//부서별 대시보드
		divisionGet : function(callback){
			var params = $.param({
				datatype : 'html',
				jsp : '/clientSalesActive/clientContactDashBoardDivisionAjax',
				searchDate : dashboard.quarterDate
			});
			$.ajax({
				url : "/clientSalesActive/selectClientContactDashBoardDivision.do",
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
				jsp : '/clientSalesActive/clientContactDashBoardTeamAjax',
				searchDivision : division,
				searchDate : dashboard.quarterDate
			});
			if(img.indexOf("plus") != -1){ //부서 펼치기
				$.ajax({
					url : "/clientSalesActive/selectClientContactDashBoardTeam.do",
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
				jsp : '/clientSalesActive/clientContactDashBoardTeamAjax',
				searchDate : dashboard.quarterDate
			});
			$.ajax({
				url : "/clientSalesActive/selectClientContactDashBoardTeam.do",
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
				jsp : '/clientSalesActive/clientContactDashBoardMemberAjax',
				searchDivision : division,
				searchTeam : team,
				searchDate : dashboard.quarterDate
			});
			if(img.indexOf("plus") != -1){ //팀 펼치기
				$.ajax({
					url : "/clientSalesActive/selectClientContactDashBoardMember.do",
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
				datatype : 'html',
				jsp : '/clientSalesActive/clientContactDashBoardMemberAjax',
				searchDate : dashboard.quarterDate
			});
			$.ajax({
				url : "/clientSalesActive/selectClientContactDashBoardMember.do",
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
		
		//고객사별 그룹화
		companyGroupGet : function(obj){
			var params = $.param({
				datatype : 'html',
				jsp : '/clientSalesActive/clientContactDashBoardCompanyGroupAjax',
				searchDate : dashboard.quarterDate
			});
			$.ajax({
				url : "/clientSalesActive/selectClientContactDashBoardCompanyGroup.do",
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
		companyGet : function(category, obj){
			var img = $(obj).attr('src');
			var params = $.param({
				datatype : 'html',
				jsp : '/clientSalesActive/clientContactDashBoardCompanyAjax',
				searchCategory : category,
				searchDate : dashboard.quarterDate					
			});
			if(img.indexOf("plus") != -1){ //드릴다운 펼치기
				$.ajax({
					url : "/clientSalesActive/selectClientContactDashBoardComapny.do",
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
		
		//리스트 페이지 이동
		goList : function(division, team, member_id_num, category, relate){
			$('#formGoList input').val(null);
			$('#formGoList #hiddenDashBoardYear').val(dashboard.quarterYear);
			$('#formGoList #hiddenDashBoardQuarter').val(dashboard.quarter);
			$('#formGoList #hiddenDashBoardDivision').val(division);
			$('#formGoList #hiddenDashBoardTeam').val(team);
			$('#formGoList #hiddenDashBoardMember').val(member_id_num);
			$('#formGoList #hiddenDashBoardCategory').val(category);
			$('#formGoList #hiddenDashBoardRelate').val(relate);
			$('#formGoList').attr('action','/clientSalesActive/viewClientContactList.do').submit();
		},
		
		goListCompany : function(company_name,company_category,category,relate){
			$('#formGoList input').val(null);
			$('#formGoList #hiddenDashBoardYear').val(dashboard.quarterYear);
			$('#formGoList #hiddenDashBoardQuarter').val(dashboard.quarter);
			$('#formGoList #hiddenDashBoardCompany').val(company_name);
			$('#formGoList #hiddenDashBoardCompanyCateogry').val(company_category);
			$('#formGoList #hiddenDashBoardCategory').val(category);
			$('#formGoList #hiddenDashBoardRelate').val(relate);
			$('#formGoList').attr('action','/clientSalesActive/viewClientContactList.do').submit();
		},
		
		goReset : function(){
			$('#formGoList input').val(null);
			$('#formGoList #hiddenModalReset').val(true);
			$('#formGoList').attr('action','/clientSalesActive/viewClientContactList.do').submit();
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
