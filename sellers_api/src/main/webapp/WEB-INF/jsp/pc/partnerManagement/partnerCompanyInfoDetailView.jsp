<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top_clientIndividualInfoListDetail.jsp"%>


<script type="text/javascript">
$(document).ready(function(){
	clientList.get();
	
	//".full-height-scroll"
	$("#leftList").scroll(function() {
		console.log(page.start);
		console.log(this.scrollTop);
		console.log(this.clientHeight);
		console.log(this.scrollHeight);
		if (Math.ceil(this.scrollTop+this.clientHeight) >= this.scrollHeight) {
	        console.log("end scroll");
	        page.start = page.start + 20;
	        page.end = page.end + 20;
	        page.status = 2;
	        clientList.get();
	    }
	});
	
	//모달 hidden event
	$('#myModal1').on('hide.bs.modal', function () {
		compare_after = $("#formModalData").serialize();
		if(modalFlag == "upd"){
			if(compare_before != compare_after){
				if(confirm("내용이 수정되었습니다.\n저장하시겠습니까?")) {
					compareFlag = true;
					$("#buttonModalSubmit").trigger("click");
				}
			}
		}else{ //신규등록이면
			if(compare_before != compare_after){
				if(confirm("창을 닫으면 입력한 정보가 지워집니다.\n창을 닫으시겠습니까?")) {
					$("#divModalFile p").hide();
				}else{
					return false;
				}
			}
		}
	});
	
	/* $("div.slimScrollDiv").scroll(function() {
		if ((this.scrollTop+this.clientHeight) == this.scrollHeight) {
	        console.log("end scroll");
	        page.start = page.winStart + 12;
	        page.end = page.winEnd + 12;
	        clientList.get();
	    }
	}); */
	
	/*
		검색창에서 엔터 눌렀을 때 이벤트 발생.
	*/
	$(".left-custom-search input[type=text]").keypress(function(e) { 
	    if (e.keyCode == 13){
	    	$('#textModalCompanyId').val('');
	    	clientSearchList.get();
	    }    
	});
	
});

var modalFlag = "upd"; //업데이트
var searchSerialize;
var reloadFlag = true;

var compare_before;
var compare_after;
var compareFlag = false;

var serchDetail = "${param.serchDetail}";
var search_chk = true;
var partnerCategory = "";
var partnerCompanyId = "";


/**
 * 파트너사 정보 상세 페이지에서 파트너사 리스트 가져오기.
 */
var clientList = {
		//리스트 가져오기
		get : function(sp, ep){
			/* if(!isEmpty(sp) && !isEmpty(ep)) { 
				page.start = sp;
				page.end = ep;
			} */
			var params = $.param({
				pageStart : page.start,
				pageEnd : page.end,
				serchInfo : $("#serchDetail").val(),
				creatorId : $("#hiddenModalCreatorId").val(),
				serch : 1,
				datatype : 'html',
				jsp : '/partnerManagement/partnerCompanyInfoLeftListAjax'
			});
			
			$.ajax({
				url : "/partnerManagement/selectPartnerCompanyInfoLeftList.do",
	 			datatype : 'html',
				data : params,
				cache : false,
				method : 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					if(search_chk) $('div .full-height-scroll .list-group.elements-list').append(data);
					if(data.indexOf('현재 등록된 정보가 없습니다.') != -1) search_chk = false;
					
					if(page.status == '1'){
						//defaultInfo.get();
					}else{
						// status == 2 일때는 상세페이지 왼쪽 고객리스트 스크롤을 내릴 경우이다.
						// 이 때에는 defaultInfo.get()을 호출하지 않고 고객리스트만 뿌려준다.
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		/* goDetail : function(companyId){
			
			defaultInfo.goClickUserDetail(companyId);
		} */
		
		goDetail : function(companyId, companyName){
			//페이징
			initPaing();
			//검색값 초기화 common.js
			filedReset($('#formSearchCommon'));
			$("strong#companyName").text(companyName);
			globalCompanyId = companyId;
			companyDetail.params = $.param({
				hiddenModalPK : companyId,
				companyId : companyId
			});
			companyDetail.getCompanyInfo();
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
			clientList.goDetail($("#hiddenModalPK").val());
			clientList.get();
        	page.start = tmpData;
        	$('input[name="fileModalUploadFile[]"]:hidden').remove();
		}
}


/**
 * 파트너사정보 상세페이지 각 텝 관련 Ajax
 */
var companyDetail = {
		//공통 파라미터		
		params : null,
		
		//tab
		tab : function(e){
			$("div.tab-pane").removeClass("active");
			$("div.tab-pane").eq(e).addClass("active");
			$("ul.nav.nav-tabs > li").removeClass("active");
			$("ul.nav.nav-tabs > li").eq(e).addClass("active");	
		},
		
		//고객사 정보
		getCompanyInfo : function(pn,ep){
			if(!pagingCalculation(pn,ep)) return false; //페이징 계산
			companyDetail.tab(0);
			
			params2 = $.param({
				datatype : 'html',
				jsp : '/partnerManagement/partnerCompanyInfoAjax'
			});
			
			$.ajax({
				url : "/partnerManagement/selectPartnerCompanyInfo.do",
				datatype : 'html',
				data : companyDetail.params + "&" + $.param(pagingParams) + "&" + $("#formSearchCommon").serialize() + "&" + params2 + "&" + $.param(page),
				cache : false,
				method : 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					$("div#companyAjax").html(data);
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},

		//소속 파트너사 개인 스킬목록 탭 클릭하였을 때,
		getPartnerSkill : function(pn,ep){
			companyDetail.tab(1);
			
			params2 = $.param({
				datatype : 'html',
				jsp : '/partnerManagement/partnerCompanyIndividualSkillAjax'
			});
			
			$.ajax({
				url : "/partnerManagement/selectPartnerSkill.do",
				datatype : 'html',
				cache : false,
				async : false,
				method : 'POST',
	 			data : companyDetail.params +"&"+ params2,
	 			beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
	 			},
	            beforeSubmit: function (data,form,option) {
	            	//$.ajaxLoadingShow();
	            },
	            success: function(data){
	            	$("div#companyAjax").html(data);
	            },
	            complete: function() {
					$.ajaxLoadingHide();
				}
	        });
		},
		
		//파트너사 조직도랑 첨부파일 리스트 가져옴.
		getCompanyFile : function(pn,ep) {
			companyDetail.tab(2);
			
			params2 = $.param({
				datatype : 'html',
				jsp : '/partnerManagement/partnerCompanyInfoDetailFileListAjax'
			});
			
			$.ajax({
				url : "/partnerManagement/selectPartnerCompanyFileList.do",
				datatype : 'html',
				cache : false,
				async : false,
				method : 'POST',
	 			data : companyDetail.params +"&"+params2,
	 			beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
	 			},
	            beforeSubmit: function (data,form,option) {
	            	//$.ajaxLoadingShow();
	            },
	            success: function(data){
	            	commonFile.reset();
	            	$("div#companyAjax").html(data);
	            },
	            complete: function() {
					$.ajaxLoadingHide();
				}
	        });
		}
}

/**
 * clientSearchList.get()
 * 파트나 정보 상세페이지에서 파트너사를 입력후 검색할때 타는 function
 */
var clientSearchList = {
		//검색 고객 리스트 가져오기
		get : function(sp, ep){
			if(!isEmpty(sp) && !isEmpty(ep)) { 
				page.start = sp;
				page.end = ep;
			}
			var params = $.param({
				pageStart : page.serchStart,
				pageEnd : page.serchEnd,
				serchInfo : $("#serchDetail").val(),
				creatorId : $("#hiddenModalCreatorId").val(),
				partnerId : $("#textModalCompanyId").val(),
				serch : 2,
				datatype : 'html',
				jsp : '/partnerManagement/partnerCompanyInfoLeftListAjax'
			});
			
			$.ajax({
				url : "/partnerManagement/selectPartnerCompanyInfoLeftList.do",
	 			datatype : 'html',
				data : params,
				cache : false,
				method : 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					$('div .full-height-scroll .list-group.elements-list').html(data);
					/* 
					if(page.status == '1') {
						defaultInfo.get();
					}else {
						// 검색 엔터 또는 버튼을 클릭했을 때,
						// 이 때에는 defaultInfo.get()을 호출하지 않고 고객리스트만 뿌려준다.
					}
					 */
					search_chk = true;
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
}


/**
 * datail.update()
 * 파트너사 정보 상세 페이지에서 종부수정 버튼을 클릭할 때 나타나는 modal 창
 */
var detail = {
		update : function(){
			comparePerSonalProfile = "";
			comparePerSonalActs = ""
			comparePerSonalFamily = "";
			comparePerSonalInclination = "";
			comparePerSonalFamiliars = "";
			comparePerSonalSNS = "";
			comparePerSonalETC = "";
			
			$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;'+$("#hiddenCreatorName").val()+
					'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+$("#hiddenSysUpdateDate").val().replace(/-/gi, "/")+"</span>");
			//$("#divModalNameAndCreateDate").html("작성일 : "+$("#hiddenSysUpdateDate").val());
			$("#selectModalPartnerCompanyCategory").val($("#hiddenPartnerCategory").val());
			
			//modal.searchPartnerCode(1);
			$("#selectModalpartnerSegmentCode").val($("#hiddenPartnerCode").val()).attr("selected", "true");
			
			$("#textModalCompanyName").val($("#hiddenCompanyName").val());			//고객사명
			$("#textModalCompanyId").val($("#hiddenCompanyId").val());			//고객사ID
			
			$("#hiddenModalPK").val($("#hiddenCompanyId").val());
			$("#hiddenModalCeoID").val($("#hiddenCEOId").val());
			$("#textModalCeoName").val($("#hiddenCEOName").val());						//
			
			$("#textModalBusinessNumber").val($("#hiddenBusinessNum").val());
			$("#textModalBusinessSector").val($("#hiddenBusinessSector").val());
			$("#textModalPostalCode").val($("#hiddenPostalCode").val());
			$("#textModalPostalAddress").val($("#hiddenPostalAddress").val());
			$("#textModalBusinessType").val($("#hiddenBusinessType").val());
			$("#hiddenBusinessSector").val($("#hiddenBusinessSector").val());
			$("#textModalCompanyTelno").val($("#hiddenCompanyTelNo").val());
			$("#textModalCompanyItem").val($("#hiddenCompanyItem").val());
			$("#textModalCompanyHomepage").val($("#hiddenCompanyHomepage").val());
			$("#textModalCompanyFaxno").val($("#hiddenCompanyFaxNo").val());
			
			if($("#hiddenCompanyOrganizationChart").val()!='' && $("#hiddenCompanyOrganizationChart").val()!=null) {
				$("#divModalUploadPhoto").html('<span name="modalFile'+$("#hiddenCreatorId").val()+'" style="display:none;"> <img class="photo" border="0" alt="" style="background:url(\'/'+$("#hiddenCompanyOrganizationChart").val()+'\') no-repeat center center; background-size:cover;">');			//개인사진
			}else{
				$("#divModalUploadPhoto").html('<span class="mg-b20"><img src="../images/pc/icon_org.gif" class="m-b" alt=""><br/>등록된 조직도가 없습니다.<br/>파트너사의 조직도를 등록하세요.</span>');
			}
			
			$("#hiddenModalCompanyId").val($("#hiddenCompanyId").val());
			
			// 아래 필요없는거 삭제 
			$("#buttonModalDelete").hide();
			$("#divModalCompanyLeader").hide();	
			
			$("#divModalUploadPhoto").show();
			$("#divModalPhotoUploadArea .fileModalUploadPhoto").remove();
			$("#divModalUploadPhoto span[name='modalFile"+$("#hiddenCreatorId").val()+"']").show();
			$("#divModalUploadPhoto #imgModalInsertPhoto").remove();
			
			$("h4.modal-title").html($("#hiddenCompanyName").val());
			$("small.font-bold").css('display','');
			$("#buttonModalSubmit").html("저장하기");
			
			$("#myModal1").modal();
			//신규등록, 상세보기 div 접기 펴기
			//toggleDiv(modalFlag);
			compare_before = $("#formModalData").serialize();
			//값 비교를 위한.
		},
		
		//파트너사 상세페이지에서 [파트너사정보] 탭 - 조직도보기 에서 사용되는 function
		organizationChart : function(chk) {
			if($(chk).html() == '조직도 보기') {
				$(chk).html('조직도 숨기기');
				$("div#organizationChart").show();
			}else {
				$(chk).html('조직도 보기');
				$("div#organizationChart").hide();
			}
		}
}

/**
 * 파트너사 정보 상세페이지 [파트너사정보]탭, [소속 파트너사개인 스킬목록]탭 에서 링크 클릭 하였을 때, 사용하는 function. 
 * 
 */
var goDetail = {
		client : function(partner_id, company_id, partner_name){
			$("#formDetail #customer_id").val(partner_id);
			$("#formDetail #company_id").val(company_id);
			$("#formDetail #customer_name").val(partner_name);
			//$("#formDetail").attr({action:"/partnerManagement/listPartnerIndividualInfoListDetail.do", method:"post"}).submit();
			menuCookieSet("파트너사개인정보"); //메뉴 활성화
			var form =  $("#formDetail")[0];
			var url = "/partnerManagement/viewPartnerIndividualInfoDetail.do";
			window.open("" ,"formDetail"); 
			form.action = url; 
			form.submit();
		}
}

</script>

		
		<form id="formDetail" name="formDetail" method="post" target="formDetail">
	    	<input type="hidden" id="customer_id" name="customer_id">
	    	<input type="hidden" id="customer_name" name="customer_name">
			<input type="hidden" id="company_id" name="company_id">
			<input type="hidden" id="opportunity_id" name="opportunity_id">
			<input type="hidden" id="issue_id" name="issue_id">
			<input type="hidden" id="returnProjectMGMTId" name="returnProjectMGMTId">
			<input type="hidden" id="returnPK" name="returnPK">
    	</form>
    
		<div class="row wrapper border-bottom white-bg page-heading">
		
			<!-- <div class="col-sm-6">
		        <h2>파트너사 정보</h2>
		        <ol class="breadcrumb">
		            <li>
		                <a href="/main/index.do">Home</a>
		            </li>
		            <li>
		                <a>파트너사협업관리</a>
		            </li>
		            <li>
		                <a href="/partnerManagement/listPartnerCompanyGate.do">파트너사 정보</a>
		            </li>
		            <li class="active">
		                <strong>파트너사정보 상세보기</strong>
		            </li>
		        </ol>
		    </div>
			<div class="col-sm-6">
				<div class="time-update">
            		<span class="text-muted small pull-right">최근 업데이트: <i class="fa fa-clock-o"></i> <span id="LATELY_UPDATE_DATE"></span></span>
     		    </div>
			</div> -->
		</div>
		
  		<!-- 상세보기 영역:start -->
  		<input type="hidden" id="hiddenDetailCustomerId" value="${coutomerId}"/>
  		<input type="hidden" id="hiddenDetailCompanyId" value="${companyId}"/>
       <div class="fh-breadcrumb">

           <div class="fh-column" id="fh-column">
               <div class="full-height-scroll" id="leftList" style="border-right: 1px solid #e7eaec;">
                   <div class="left-custom-search">
                       <input type="text" placeholder="파트너사를 입력해주세요" class="input form-control fl_l" id="serchDetail" value="${searchDetail}" />
                       <button type="button" class="btn btn-w-s btn-seller" onclick="$('#textModalCompanyId').val('');clientSearchList.get(1, 20)"><i class="fa fa-search"></i></button>
                   </div>
                   <ul class="list-group elements-list">
                       <!-- 
                       <li class="list-group-item active">
                           <a data-toggle="tab" href="#tab-1">
                               <small class="pull-right text-muted"> 2016-07-20</small>
                               <strong class="custom-name">황선홍</strong> <span class="custom-level">이사</span>
                               <div class="small m-t-xs">
                                   <p>SK텔레콤(주) / 영업1팀</p>
                               </div>
                           </a>
                       </li>
                       <li class="list-group-item">
                           <a data-toggle="tab" href="#tab-2">
                               <small class="pull-right text-muted"> 2016-07-20</small>
                               <strong class="custom-name">이상현</strong> <span class="custom-level">부장</span>
                               <div class="small m-t-xs">
                                   <p>(주)디유넷 / 디자인팀</p>
                               </div>
                           </a>
                       </li>
                        -->
                   </ul>
               </div>
           </div>

           <div class="full-height">
           		<!-- <div class="slimScrollDiv" style="position: relative; overflow: hidden; width: auto; height: 100%;">
               		<div class="full-height-scroll white-bg border-left"> -->
               		
               		<div class="white-bg border-left">

                   		<div class="element-detail-box" style="overflow: hidden; width: auto; height: 100%;">
                       		<h2 style="margin-top: 0px;">
					        	<strong id="companyName"></strong>
					       	</h2>
                   			<div class="tabs-container mg-b30">
                       			<ul class="nav nav-tabs">
					               <li class="active"><a data-toggle="tab" href="#tab2-1" onclick="initPaing();companyDetail.getCompanyInfo();">파트너사정보</a></li>
					               <li class=""><a data-toggle="tab" href="#tab2-2" onclick="initPaing();companyDetail.getPartnerSkill();">소속 파트너사개인 스킬목록</a></li>
					               <!-- <li class=""><a data-toggle="tab" href="#tab2-3" onclick="initPaing();companyDetail.getCompanyStatus();">파트너사현황</a></li> -->
					               <li class=""><a data-toggle="tab" href="#tab2-3" onclick="initPaing();companyDetail.getCompanyFile();">첨부파일</a></li>
					           </ul>
					        </div>

							<!-- ajax data -->
							<div id="companyAjax" class="tab-content"></div>

						</div>
                   </div>

               </div>
           </div>
			<jsp:include page="/WEB-INF/jsp/pc/partnerManagement/partnerCompanyInfoModal.jsp"/>
       </div>
       <!-- 상세보기 영역:end -->
<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>