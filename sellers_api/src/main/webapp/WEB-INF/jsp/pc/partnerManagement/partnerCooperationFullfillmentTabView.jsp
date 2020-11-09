<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<!-- 
 * @author 	: 욱이
 * @Date		: 2016. 10. 27
 * @explain	: 파트너사 협업 -> 협력사 비지니스 현황
 -->	
		<div class="row wrapper border-bottom white-bg page-heading">
		    <!-- <div class="col-sm-6">
		        <h2>파트너사 비지니스 현황</h2>
		        <ol class="breadcrumb">
		            <li>
		                <a href="/main/index.do">Home</a>
		            </li>
		            <li>
		                <a>파트너사협업관리</a>
		            </li>
		            <li class="active">
		                <strong>파트너사 비지니스 현황</strong>
		            </li>
		        </ol>
		    </div> -->
		    <div class="col-sm-6">
		        
		  
		    </div>
		</div>

		 <div class="wrapper wrapper-content  animated fadeInRight">
		    <div class="row">
		        <div class="col-sm-12">
		            <div class="ibox">
		                <div class="ibox-content border_n">
		                    <div class="clear">
		                    	<div class="mg-b20">
                                	<ul class="nav nav-tabs">
                              	     	<li class=""><a href="/partnerManagement/viewPartnerSales.do">1.파트너 현황</a></li>
                            	        <li class=""><a href="/partnerManagement/viewPartnerRecruitment.do">2.Recruitment</a></li>
                         	            <li class=""><a href="/partnerManagement/viewPartnerEnablement.do">3.파트너 교육</a></li>
                         	            <li class=""><a href="/partnerManagement/viewPartnerSalesLinkage.do">4.파트너 협업</a></li>
                         	            <li class="active"><a href="/partnerManagement/viewPartnerFullfillment.do">5.파트너사 비지니스 현황</a></li>
                      	            </ul>
                           		</div> 
                           		
		                        <div class="pos-rel">
		                            <div class="func-top-right fl_r">
		                                <!--  검색 -->
										<div class="search-calendar">
											<div class="pgsearch">
												<input type="text" placeholder="검색할 거래처명을 입력해주세요." id="searchCompanyName" onkeydown="if(event.keyCode == 13)fullfill.get(null,1,1);" value="${searchCompanyName}">
												<button class="btn" onclick="fullfill.get(null,1,1);"><i class="fa fa-search"></i> 검색</button>
											</div>
										</div>
										<!--  검색 -->
		                            </div>
	                            	<p class="cboth ag_r fl_r" ><strong>금액단위 : 원</strong></p>
		                            <div id="row">
									</div>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
		
</body>


<script type="text/javascript">
$(document).ready(function(){
	
	//$("#menu_title_1").html('파트너사 비즈니스 현황');
	//$("#menu_title_2").html('파트너사 비즈니스 현황');
	
	fullfill.init();
	
	//모달 닫기 이벤트
	$('#myModal1').on('hide.bs.modal', function () {
		compare_after = $("#formModalData").serialize();
		if(modalFlag == "upd"){
			if(compare_before != compare_after){
				if(confirm("내용이 수정되었습니다.\n저장하시겠습니까?")) {
					compareFlag = true;
					$("#buttonModalSubmit").trigger("click");
				}
			}
		}
	});
	
});

var params;
var compareFlag = false;
var compare_after;
var compare_before;
var searchPKArray = "";
var modalFlag = "ins/upd";
var listYear;

var fullfill = {
		init : function(){
			listYear = commonDate.year;
			initPaing();
			fullfill.get();
		},
		
		reset : function(){
			$('tbody#row tr').remove();
			page.start=0;
			$('input[name="fileModalUploadFile[]"]:hidden').remove();
		},
		
		searchReset : function(){
			$("div.search-detail select, div.search-detail input").val("")
			$("#result-in-search").prop("checked",false);
		},
		
		completeReload : function(){
			$('tbody#row tr').remove();
			$("#divFileUploadList").html('');
			var tmpData = page.start;
			page.start=0;
			fullfill.goDetail($("#hiddenModalPK").val());
			fullfill.get();
        	page.start = tmpData;
        	$('input[name="fileModalUploadFile[]"]:hidden').remove();
		},
		
		//리스트 가져오기
		get : function(s, pn, ep){
			if(!isEmpty(pn) && !isEmpty(ep)) { 
				page.start = pn;
				page.end = ep;
			}
			params = $.param({
								searchYear : function(){
									if(!isEmpty(s)){
										if(s == "p"){ //다음분기
											listYear++;
										}else{ //이전분기
											listYear--;
										}
									}
									return listYear;
								},
								pageStart : page.start,
								pageEnd : page.end,
								searchCompanyName : $("#searchCompanyName").val(),
								//serchInfo : $("#serchDetail").val(),
								datatype : 'html',
								jsp : '/partnerManagement/partnerCoopertationFullfillmentAjax'
							});
			
			if(!pagingCalculation(pn,ep)) return false; //페이징 계산
			//리스트
			$.ajax({
				url : "/partnerManagement/selectFullfillment.do",
				cache : false,
	 			datatype : 'html',
	 			method: 'POST',
				data : $.param(pagingParams) + "&" + params + "&" + $.param(page),
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoading();
				},
				success : function(data){
					$('div#row').html(data);
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
}
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>