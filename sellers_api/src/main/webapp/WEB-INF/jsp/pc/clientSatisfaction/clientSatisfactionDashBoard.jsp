<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<!-- 
 * @author 	: 장성훈
 * @Date		: 2016. 06 - 02
 * @explain	: 영업활동 -> 고객개인정보
 -->
 
<div class="row wrapper border-bottom white-bg page-heading">
	     <!-- <div class="col-sm-6">
	         <h2>고객만족도</h2>
	         <ol class="breadcrumb">
	             <li>
	                 <a href="/main/index.do">Home</a>
	             </li>
	             <li>
	                 <a>고객만족</a>
	             </li>
	             <li class="active">
	                 <strong>고객만족도 대시보드</strong>
	             </li>
	         </ol>
	     </div> -->
	<div class="col-sm-6">
        <div class="time-update">
            <!-- <span class="text-muted small pull-right">최근 업데이트: <i class="fa fa-clock-o"></i><span id="LATELY_UPDATE_DATE"></span></span> -->
        </div>
		<div class="search-common" style="display: none;">
			<div class="input-default" style="margin:0;">
				<span onclick="modal.reset();">
					<a href="#" class="btn" style="color:#666; border:solid 1px #e6eaed; margin-left:5px !important;">고객사 추가</a>
				</span>
			</div>
			<div class="input-default" style="margin:0;">
                  	<span class="input-group-btn">
              			<a href="#" class="btn btn-search-option"><i class="fa fa-search"></i> 검색</a>
              		</span>
                            
              		<div class="search-detail collapse">
                    <div class="singleSearch">
                  		<input type="text" placeholder="고객사명 또는 고객명을 입력하십시오" class="input form-control" id="serchDetail" value="">
                  		<button type="button" class="btn btn-w-s btn-seller" onclick="serchDetailClick.getList()"><i class="fa fa-search"></i></button>
               		</div>
			   	</div>
                    	
			</div>
		</div>
	</div>
</div>
   
<div class="white-bg">
	<div class="wrapper wrapper-content  animated fadeInRight">
	<div class="row">
	   <div class="col-sm-12">
	       	<div class="ibox">
		       	<div class="ibox-content border_n">
					<div class="clear">
						<!-- 탭 -->
                   		<div class="mg-b20">
               				<ul class="nav nav-tabs">
                				<li><a href="javascript:void(0);" onclick="dashboard.divisionGet('clientCompany')">고객만족</a></li>
              	        		<li><a href="javascript:void(0);" onclick="dashboard.divisionGet('partnerCompany')">파트너만족</a></li>
             	        	</ul>
                 		</div>
               			<!-- 탭end -->
						
						<div class="func-top-left fl_l">                                            
                            <button class="btn btn-white btn-sm" id="buttonPrevQuarter" onclick="dashboard.prevQuarter();"><i class="fa fa-arrow-left"></i></button>
                            <strong id="strongThisQuart"></strong>
                            <button class="btn btn-white btn-sm" id="buttonNextQuarter" onclick="dashboard.nextQuarter();"><i class="fa fa-arrow-right"></i></button>
                        </div>
						
						<div class="fl_r pd-b20">
							<div class="fl_l mg-r10">
								<a href="/clientSatisfaction/viewClientSatisfactionList.do" class="btn btn-outline btn-seller-outline">리스트</a>
							</div>
							<div class="fl_l">
				   				<button type="button" class="btn btn-w-m btn-seller" onclick="dashboard.goReset();">신규등록</button>
							</div> 
						</div>
		          		<!-- <div class="element-detail-box" style="overflow: hidden; width: auto; height: auto;"></div> -->
		          		<div id="row"></div>
		          	</div>
		         </div>
	       	</div>
	     </div>
	</div>
	</div>
</div>
   
   
   
  <!-- form 영역 -->
  <form id="formDetail" name="formDetail" method="post">
	<input type="hidden" id="csat_id" name="csat_id">
	<input type="hidden" id="issue_status" name="issue_status">
	<input type="hidden" id="hiddenModalReset" name="hiddenModalReset"/>
</form>
	
</body>

<script type="text/javascript">
$(document).ready(function(){
	dashboard.init();
});

var dashboard = {
		category : "clientCompany",
		quarter : "",
		quarterDate : "",
		quarterYear : moment().year(),

		init : function(){
			if(dashboard.quarter == "" || dashboard.quarter == null) dashboard.quarter = moment().quarter();
			
			dashboard.checkQuarter();
		},
		
		checkQuarter : function() {
			switch(dashboard.quarter) {
				case 1 : dashboard.quarterDate = dashboard.quarterYear + '-01-01'; break;
				case 2 : dashboard.quarterDate = dashboard.quarterYear + '-04-01'; break;
				case 3 : dashboard.quarterDate = dashboard.quarterYear + '-07-01'; break;
				case 4 : dashboard.quarterDate = dashboard.quarterYear + '-10-01'; break;
				default : alert("에러"); ;
			} 
			$("strong#strongThisQuart").html(dashboard.quarterYear + "년 " + dashboard.quarter +"분기");
			
			dashboard.divisionGet();
		},
		
		prevQuarter : function() {
			if(dashboard.quarter == 1){
				dashboard.quarter = 4;
				dashboard.quarterYear = dashboard.quarterYear - 1;
			}else {
				dashboard.quarter = dashboard.quarter - 1;
			}
			dashboard.checkQuarter();
		},
		
		nextQuarter : function() {
			if(dashboard.quarter == 4){
				dashboard.quarter = 1;
				dashboard.quarterYear = dashboard.quarterYear + 1;
			}else {
				dashboard.quarter = dashboard.quarter + 1;
			}
			dashboard.checkQuarter();
		},
		
		divisionGet : function(category){
			if(!isEmpty(category)){
				dashboard.category = category;
			}
			var params = $.param({
				searchDate : dashboard.quarterDate,
				datatype : 'html',
				jsp : '/clientSatisfaction/clientSatisfactionDashBoardAjax',
				tabFlag : dashboard.category
			});
			
			if(dashboard.category == 'clientCompany' || dashboard.category == '' || dashboard.category == null ){
				$("div.mg-b20 > ul > li").removeClass("active");
				$("div.mg-b20 > ul > li:nth-child(1)").addClass("active");
			}else if(dashboard.category == 'partnerCompany'){
				$("div.mg-b20 > ul > li").removeClass("active");
				$("div.mg-b20 > ul > li:nth-child(2)").addClass("active");
			}
			
			$.ajax({
				url : "/clientSatisfaction/selectClientSatisfactionDashBoard.do",
				datatype : 'html',
				/* data : {
					tabFlag : dashboard.category
				}, */
				data : params,
				mtype: 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					//var list = data.rows;
					//defaultInfo.view(list);
					//$("div.element-detail-box").html(data);
					$("div#row").html('');
					$("div#row").html(data);
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		goDetail : function(csat_id) {
			$("#formDetail").attr("target", '');
			$("#formDetail #csat_id").val(csat_id);
			$("#formDetail").attr({action:"/clientSatisfaction/viewClientSatisfactionList.do", method:"post"}).submit();
		},
		
		goIssue : function(issue_status, csat_id) {
			$("#formDetail").attr("target", "formDetail");
			$("#formDetail #csat_id").val(csat_id);
			$("#formDetail #issue_status").val(issue_status);
			
			var form =  $("#formDetail")[0];
			var url = "/clientSatisfaction/viewClientIssueList.do";
			window.open("" ,"formDetail"); 
			form.action = url; 
			form.submit();
		},
		
		goReset : function(){
			$('#formDetail input').val(null);
			$('#formDetail #hiddenModalReset').val(true);
			$('#formDetail').attr('action','/clientSatisfaction/viewClientSatisfactionList.do').submit();
		},
}


</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>