<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top_clientIndividualInfoListDetail.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	
	console.log($("#menu_title_1").val());
	console.log(getCookie('clickMenuTitle'));
	
	$("#menu_title_1").val(getCookie('clickMenuTitle'));
	$("#menu_path").css('display', 'block');
	
	clientList.get();
	
	//".full-height-scroll"
	$("#leftList").scroll(function() {
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
				}else{
					attrChk = true;
				}
			}
		}else{ //신규등록이면
			if(compare_before != compare_after){
				if(confirm("창을 닫으면 입력한 정보가 지워집니다.\n창을 닫으시겠습니까?")) {
					$("#divModalFile p").hide();
				}else{
					return false;
					attrChk = true;
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
	    	$("#hiddenModalPK").val('');
	    	clientSerchList.get();
	    }    
	});
	
});


var modalFlag = "upd"; //업데이트
var globalCompanyId;
var searchSerialize;

var reloadFlag = true;
var compare_before;
var compare_after;
var compareFlag = false;

var serchDetail = "${param.serchDetail}";
var selectCompanyId = "${companyId}";
var search_chk = true;

var page = {
		status : 1,  // 왼쪽 고객 리스트 스크롤 시도시에, 기본정보가 처음으로 돌아오는 현상을 방지하기 위함.
		start : 1,
		end : 20,
		winStart : 1,
		winEnd : 12,
		serchStart : 1,
		serchEnd :20,
		salesStatus : 1
}


var clientList = {
		//게이트 페이지에서 고객사 검색할 때 사용 - 리스트 가져오기
		get : function(sp, ep){
			/* if(!isEmpty(sp) && !isEmpty(ep)) { 
				page.start = sp;
				page.end = ep;
			} */
			var params = $.param({
				pageStart : page.start,
				pageEnd : page.end,
				serchInfo : $("#serchDetail").val(),
				clientId : $("#hiddenDetailCompanyId").val(),
				companyId : selectCompanyId,
				creatorId : $("#hiddenModalCreatorId").val(),
				serch : 1,
				datatype : 'html',
				jsp : '/clientManagement/clientCompanyInfoSearchAjax'
			});
			
			$.ajax({
				url : "/clientManagement/selectClientCompanySearchList.do",
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
		
		goDetail : function(companyId, companyName, use_yn){
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
			
			if(use_yn == "003"){
				$("#clientUseYn").show();
			}else{
				$("#clientUseYn").hide();
			}
			
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

var clientSerchList = {
		//상세페이지에서 고객사 검색할 때 사용 - 검색 고객 리스트 가져오기
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
				clientId : $("#hiddenModalPK").val(),
				serch : 2,
				datatype : 'html',
				jsp : '/clientManagement/clientCompanyInfoSearchAjax'
			});
			
			$.ajax({
				url : "/clientManagement/selectClientCompanySearchList.do",
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
		
		goDetail : function(clientNo, companyId){
			defaultInfo.goClickUserDetail(companyId);
		}
}



var defaultInfo = {
		//안쓰는 소스
		/* get : function(){
			var params = $.param({
				pageStart : page.winStart,
				pageEnd : page.winEnd,
				companyId : $("#hiddenDetailCompanyId").val(),
				hiddenModalPK : $("#hiddenDetailCompanyId").val(),
				customerId : $("#hiddenDetailCustomerId").val(),
				salesStatus : page.salesStatus,
				datatype : 'html',
				jsp : ''
			});
			
			$.ajax({
				url : "/clientManagement/gridClientCompanyDetail.do",
				datatype : 'html',
				data : params,
				cache : false,
				method : 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					//var list = data.rows;
					//defaultInfo.view(list);
					//$("div.element-detail-box").html(data);
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		}, */
		
		goClickUserDetail : function(companyId){
			var params = $.param({
				pageStart : page.winStart,
				pageEnd : page.winEnd,
				companyId : companyId,
				//customerId : clientNo,
				hiddenModalPK : companyId,
				salesStatus : page.salesStatus
			});
			//console.log(params);
			/* $("#formDetail #customer_id").val(clientNo); */
			
		}
}

//각 탭별 ajax
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
			var params = $.param({
				datatype : 'html',
				jsp : '/clientManagement/clientCompanyInfoTabAjax'
			});
			
			if(!pagingCalculation(pn,ep)) return false; //페이징 계산
			companyDetail.tab(0);
			$.ajax({
				url : "/clientManagement/selectCompanyInfo.do",
				datatype : 'html',
				data : companyDetail.params + "&" + $.param(pagingParams) + "&" + $("#formSearchCommon").serialize() + "&" + params + "&" + $.param(page),
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
		
		//고객사 IT정보
		getCompanyItInfo : function(){
			var params = $.param({
				datatype : 'html',
				jsp : '/clientManagement/clientCompanyItInfoTabAjax'
			});
			
			companyDetail.tab(1);
			$.ajax({
				url : "/clientManagement/selectClientItInfo.do",
				datatype : 'html',
				data : companyDetail.params + "&" + params+ "&" + $.param(pagingParams) + "&" + $.param(page),
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
		
		//영업기회
		getCompanyOpp : function(pn,ep){
			var params = $.param({
				datatype : 'html',
				jsp : '/clientManagement/clientCompanyOppTabAjax'
			});
			
			if(!pagingCalculation(pn,ep)) return false; //페이징 계산
			companyDetail.tab(2);
			$.ajax({
				url : "/clientManagement/selectCompanyOpp.do",
				datatype : 'html',
				data : companyDetail.params + "&" + $.param(pagingParams) + "&" + $("#formSearchCommon").serialize() + "&companyInfoOpp=true" + "&" + params + "&" + $.param(page),
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
		
		//고객이슈
		getCompanyIssue : function(pn,ep){
			var params = $.param({
				datatype : 'html',
				jsp : '/clientManagement/clientCompanyIssueTabAjax'
			});
			
			if(!pagingCalculation(pn,ep)) return false; //페이징 계산
			companyDetail.tab(3);
			$.ajax({
				url : "/clientManagement/selectCompanyIssue.do",
				datatype : 'html',
				data : companyDetail.params + "&" + $.param(pagingParams) + "&" + $("#formSearchCommon").serialize() + "&companyInfoIssue=true" + "&" + params + "&" + $.param(page),
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
		
		//컨택이력
		getCompanyContact : function(pn, ep){
			var params = $.param({
				datatype : 'html',
				jsp : '/clientManagement/clientCompanyContactTabAjax'
			});
			
			if(!pagingCalculation(pn,ep)) return false; //페이징 계산
			companyDetail.tab(4);
			$.ajax({
				url : "/clientManagement/selectCompanyContact.do",
				datatype : 'html',
				data : companyDetail.params + "&" + $.param(pagingParams) + "&" + $("#formSearchCommon").serialize() + "&companyInfoContact=true" + "&" + params + "&" + $.param(page),
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
		
		//첨부파일
		getCompanyFile : function(){
			var params = $.param({
				datatype : 'html',
				jsp : '/clientManagement/clientCompanyFileTabAjax'
			});
			
			companyDetail.tab(5);
			$.ajax({
				url : "/clientManagement/selectCompanyFile.do",
				datatype : 'html',
				data : companyDetail.params + "&" + params,
				cache : false,
				method : 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					commonFile.reset();
					$("div#companyAjax").html(data);
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		}
		
}

var goDetail = {
		//권한확인변수 0이면 false, 1이면 true
		role : "0",
		
		//권한 체크
		roleCheck : function(tableName, id){
			var params = $.param({
				datatype : 'json'
			});
			
			$.ajax({
				url : "/clientManagement/selectRoleCheck.do",
				datatype : 'json',
				data : "tableName=" + tableName + "&DataId=" + id + "&" + params,
				cache : false,
				async : false,
				method : 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					//console.log(data.cnt);
					goDetail.role = data.cnt;
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		client : function(customer_id, company_id, customer_name){
			$("#formDetail #customer_name").val(customer_name);
			$("#formDetail #customer_id").val(customer_id);
			$("#formDetail #company_id").val(company_id);
			menuCookieSet("고객개인정보"); //메뉴 활성화
			var form =  $("#formDetail")[0];
			var url = "/clientManagement/viewClientIndividualInfoDetail.do";
			window.open("" ,"companyToClientIndividualInfo"); 
			form.target = "companyToClientIndividualInfo";
			form.action = url; 
			form.submit();
		},
		opportunity : function(opportunity_id, sales_cycle){
			goDetail.roleCheck("opportunity", opportunity_id);
			if(goDetail.role == "0"){
				alert("해당 정보를 열람할 권한이 없습니다.");
			}else if(goDetail.role == "1"){
				$("#formDetail #opportunity_id").val(opportunity_id);
				$("#formDetail #sales_cycle").val(sales_cycle);
				//$("#formDetail").attr({action:"/clientSalesActive/viewOpportunityList.do", method:"post"}).submit();
				menuCookieSet("영업기회"); //메뉴 활성화
				var form =  $("#formDetail")[0];
				var url = "/clientSalesActive/viewOpportunityList.do";
				window.open("" ,"companyToOpportunity"); 
				form.target = "companyToOpportunity";
				form.action = url; 
				form.submit();
			}else{
				alert("에러가 발생했습니다.\n관리자에게 문의하세요.");
			}
			goDetail.role = "0";
		},
		clientIssue : function(issue_id){
			goDetail.roleCheck("clientIssue", issue_id);
			if(goDetail.role == "0"){
				alert("해당 정보를 열람할 권한이 없습니다.");
			}else if(goDetail.role == "1"){
				$("#formDetail #issue_id").val(issue_id);
				//$("#formDetail").attr({action:"/clientSalesActive/listClientIssue.do", method:"post"}).submit();
				menuCookieSet("고객이슈"); //메뉴 활성화
				var form =  $("#formDetail")[0];
				var url = "/clientSatisfaction/viewClientIssueList.do";
				window.open("" ,"companyToIssue"); 
				form.target = "companyToIssue";
				form.action = url; 
				form.submit();
			}else{
				alert("에러가 발생했습니다.\n관리자에게 문의하세요.");
			}
			goDetail.role = "0";
		},
		serviceProject : function(project_id){
			$("#formDetail #returnProjectMGMTId").val(project_id);
			menuCookieSet("서비스 프로젝트"); //메뉴 활성화
			var form =  $("#formDetail")[0];
			var url = "/clientSalesActive/listProjectMGMT.do";
			window.open("" ,"companyToProjectMGM"); 
			form.target = "companyToProjectMGM";
			form.action = url; 
			form.submit();
		},
		clientContact : function(event_id, customer_name){
			goDetail.roleCheck("clientContact", event_id);
			if(goDetail.role == "0"){
				alert("정보를 열람할 권한이 없습니다.");
			}else if(goDetail.role == "1"){
				$("#formDetail #event_id").val(event_id);
				$("#formDetail #customer_name").val(customer_name);
				//$("#formDetail").attr({action:"/clientSalesActive/listClientContact.do", method:"post"}).submit();
				menuCookieSet("고객컨택"); //메뉴 활성화
				var form =  $("#formDetail")[0];
				var url = "/clientSalesActive/viewClientContactList.do";
				window.open("" ,"companyToClientContact"); 
				form.target = "companyToClientContact";
				form.action = url; 
				form.submit();
			}else{
				alert("에러가 발생했습니다.\n관리자에게 문의하세요.");
			}
			goDetail.role = "0";
		},
		projectMg : function(project_id){ //프로젝트 관리 이력 상세보기
			var params = $.param({
				datatype : 'json'
			});
			
			$.ajax({
				url : "/clientManagement/selectClientCompanyProjectMg.do",
				async : false,
				datatype : 'json',
				method : 'POST',
				data : "project_id=" + project_id + "&" + params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					var projectMg = data.selectClientCompanyProjectMg;

					modalProjectMgFlag = "upd";
					$("#formProjectMg input").val("");
					$("#formProjectMg textarea").val("");
					
					$("#modalProjectMg h4.modal-title").text(projectMg.PROJECT_NAME);
					$("#modalProjectMg #textModalProjectName").val(projectMg.PROJECT_NAME);
					$("#modalProjectMg #textModalProjectNation").val(projectMg.NATION);
					$("#modalProjectMg #textModalProjectLocation").val(projectMg.LOCATION);
					$("#modalProjectMg #textModalProjectOwner").val(projectMg.OWNER);
					$("#modalProjectMg #textModalProjectCustomer").val(projectMg.CUSTOMER);
					$("#modalProjectMg #textModalProjectPlant").val(projectMg.PLANT);
					$("#modalProjectMg #textModalProjectScope").val(projectMg.SCOPE);
					$("#modalProjectMg #textareaModalProjectPlantType").val(projectMg.PLANT_TYPE);
					if(!isEmpty(projectMg.PROJECT_AMOUNT)){
						$("#modalProjectMg #textModalProjectSize").val(add_comma((projectMg.PROJECT_AMOUNT).toString()));
					}else{
						$("#modalProjectMg #textModalProjectSize").val();
					}
					$("#modalProjectMg #textModalProjectStartDate").val(projectMg.PROJECT_START_DATE);
					$("#modalProjectMg #textModalProjectEndDate").val(projectMg.PROJECT_END_DATE);
					$("#modalProjectMg #hiddenModalProjectMgPK").val(projectMg.PROJECT_ID);
					
					modalProjectMg.reload();
					$("#modalProjectMg").modal();
				},
				complete: function(){
					$.ajaxLoadingHide();
				}
			});
		}
}

var detail = {
		update : function(){
			var params = $.param({
				datatype : 'json'
			});
			
			$.ajax({ //산업분류코드
				url : "/clientManagement/selectAllIndustrySegmentCode.do",
				async : false,
				datatype : 'json',
				method : 'POST',
				data : params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					$("#selectModalSegmentCode").html('<option value="">===선택===</option>');
					$("#selectModalSegmentCode option:eq(0)").attr("selected", "selected");
					if(data.rows.length > 0){
						for(var i=0; data.rows.length>i; i++){
							$("#selectModalSegmentCode").append('<option value="'+ data.rows[i].SEGMENT_CODE +'">'+ data.rows[i].SEGMENT_HAN_NAME +'</option>');
						}
					}else{
						alert("산업분류코드를 추가해 주세요.");
					}
				},
				complete: function(){
					$.ajaxLoadingHide();
				}
			});
			
			params = $.param({
				datatype : 'json',
			});
			
			$.ajax({
				url : "/clientManagement/selectClientCompanyFileList.do",
				async : false,
	 			datatype : 'json',
	 			method: 'POST',
	 			data : "hiddenModalPK=" + $("#hiddenCompanyId").val() + "&" + params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					var fileList = data.fileList;
					
					modalFlag = "upd";
					
					comparePerSonalProfile = "";
					comparePerSonalActs = ""
					comparePerSonalFamily = "";
					comparePerSonalInclination = "";
					comparePerSonalFamiliars = "";
					comparePerSonalSNS = "";
					comparePerSonalETC = "";
					
					modal.gotoDetail('1');
					$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;'+$("#hiddenCreatorId").val()+
							'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+$("#hiddenSysUpdateDate").val().replace(/-/gi, "/").substring(0,10)+"</span>");
					//$("#divModalNameAndCreateDate").html("작성일 : "+$("#hiddenSysUpdateDate").val());
					$("#textModalCompanyName").val($("#hiddenCompanyName").val());			//고객사명
					$("#textModalCompanyId").val($("#hiddenCompanyId").val());			//고객사ID
					
					$("#hiddenModalPK").val($("#hiddenCompanyId").val());
					$("#hiddenModalCeoID").val($("#hiddenCEOId").val());
					$("#textModalCeoName").val($("#hiddenCEOName").val());						//
					$("#hiddenModalCioID").val($("#hiddenCIOId").val());
					$("#textModalCioName").val($("#hiddenCIOName").val());								//
					$("#hiddenModalCtoID").val($("#hiddenCTOId").val());
					$("#textModalCtoName").val($("#hiddenCTOName").val());						//
					
					$("#selectModalSegmentCode").val($("#hiddenSegmentCode").val()).attr("selected", "selected");
					$("#textModalBusinessNumber").val($("#hiddenBusinessNum").val());
					$("#textModalBusinessSector").val($("#hiddenBusinessSector").val());
					$("#textModalPostalCode").val($("#hiddenPostalCode").val());
					$("#textModalPostalAddress").val($("#hiddenPostalAddress").val());
					$("#textModalBusinessType").val($("#hiddenBusinessType").val());
					$("#hiddenBusinessSector").val($("#hiddenBusinessSector").val());
					$("#textModalErpRegCode").val($("#hiddenERPCode").val());
					$("#textModalCompanyTelno").val($("#hiddenCompanyTelNo").val());
					$("#selectModalClientCategory").val($("#hiddenClientCategory").val());
					$("#selectModalClientCategory").attr("disabled","disabled");
					
					if($("#hiddenCompanyOrganizationChart").val()!='' && $("#hiddenCompanyOrganizationChart").val()!=null) {
						$("#divModalUploadPhoto").html('<span name="modalFile'+$("#hiddenCreatorId").val()+'" style="display:none;"> <img class="photo" border="0" alt="" style="background:url(\'/'+$("#hiddenCompanyOrganizationChart").val()+'\') no-repeat center center; background-size:cover;">');			//개인사진
					}else{
						$("#divModalUploadPhoto").html('<span class="mg-b20"><img src="../images/pc/icon_org.gif" class="m-b" alt=""><br/>등록된 조직도가 없습니다.<br/>고객사의 조직도를 등록하세요.</span>');
					}
					
					//상제정보(it 정보)
					$("#textModalHWServer").val($("#hiddenHWServer").val());
					$("#textModalHWStorage").val($("#hiddenHWStorage").val());
					$("#textModalHWBackup").val($("#hiddenHWBackup").val());
					$("#textModalHWNetwork").val($("#hiddenHWNetwork").val());
					$("#textModalHWSecurity").val($("#hiddenHWSecurity").val());
					$("#textModalSWDb").val($("#hiddenSWDb").val());
					$("#textModalSWMiddleware").val($("#hiddenSWMiddleware").val());
					$("#textModalSWBackup").val($("#hiddenSWBackup").val());
					$("#textModalSWApm").val($("#hiddenSWApm").val());
					$("#textModalSWDpm").val($("#hiddenSWDpm").val());
					$("#textModalEtc").val($("#hiddenEtc").val());
					
					// 탭 초기화
					modal.goTab('1');
					
					//파일
					if(!isEmpty(fileList)){
						$("#divFileUploadList span").remove();
						for(var i=0; i<fileList.length; i++){
							$("#divFileUploadList").append('<span><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=12"><i class="fa fa-file-'+commonCheckExtension(fileList[i].FILE_TYPE)+'-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="modal.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></span>');
						}
					}else{
						$("#divFileUploadList").html('<span class="blank-ment">선택된 파일이 없습니다</span>');
					}
					
					$("#hiddenModalItInfoId").val($("#hiddenItInfoId").val());
					$("#hiddenModalCompanyId").val($("#hiddenCompanyId").val());
					$("#hiddenModalSegmentCode").val($("#hiddenSegmentCode").val());
					
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
					
					//고객사관련 프로젝트관리이력
					$('div[name="insertAfterMsg"]').hide();
					$('a[name="buttonSaleAddRow"]').show();
					/* projectDetail.reset();
					projectDetail.drawQualification(); */
					
					$("#myModal1").modal();
					//신규등록, 상세보기 div 접기 펴기
					//toggleDiv(modalFlag);
					compare_before = $("#formModalData").serialize();
					//값 비교를 위한.
					
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		organizationChart : function(chk) {
			if($(chk).html() == '조직도 보기') {
				$(chk).html('조직도 숨기기');
				$("div#organizationChart").show();
			}else {
				$(chk).html('조직도 보기');
				$("div#organizationChart").hide();
			}
		},
		
		uploadFile : function() {
			$('#formDetailFileData').ajaxForm({ 
	    		url : "/clientManagement/updateClientCompanyFile.do",
	    		dataType: "json",
	    		data : {
	    			datatype : 'json',
	    			hiddenModalCreatorId : "${userInfo.MEMBER_ID_NUM}",
	    			hiddenModalPK : globalCompanyId,
	    			fileData : JSON.stringify(commonFile.fileArray)
	    		},
	            beforeSubmit: function (data,form,option) {
	            },
	            beforeSend : function(xhr){
	            	xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
	            success: function(data){
	            	//성공후 서버에서 받은 데이터 처리
	                if(data.cnt > 0){
	                	alert("저장하였습니다.");
	                }else{
	                	alert("파일 업로드을 실패했습니다.\n관리자에게 문의하세요.");
	                }
	                companyDetail.getCompanyFile();
	            },
	            complete: function() {
	            	$.ajaxLoadingHide();
				}  
	        });
		}
}

</script>
		
	    
		<form id="formDetail" name="formDetail" method="post">
	    	<input type="hidden" id="customer_id" name="customer_id">
	    	<input type="hidden" id="customer_name" name="customer_name">
			<input type="hidden" id="company_id" name="company_id">
			<input type="hidden" id="opportunity_id" name="opportunity_id">
			<input type="hidden" id="sales_cycle" name="sales_cycle">
			<input type="hidden" id="issue_id" name="issue_id">
			<input type="hidden" id="returnProjectMGMTId" name="returnProjectMGMTId">
			<input type="hidden" id="event_id" name="event_id">
	    </form>
    
		<div class="row wrapper border-bottom white-bg page-heading">
			<!-- <div class="col-sm-6">
		        <h2>고객사 정보</h2>
		        <ol class="breadcrumb">
		            <li>
		                <a href="/main/index.do">Home</a>
		            </li>
		            <li>
		                <a>고객사 및 고객개인정보</a>
		            </li>
		            <li>
		                <a href="/clientManagement/viewClientCompanyInfoGate.do">고객사정보</a>
		            </li>
		            <li class="active">
		                <strong>고객사정보 상세보기</strong>
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
                       <input type="text" placeholder="고객사를 입력해주세요" class="input form-control fl_l" id="serchDetail" value="${searchDetail}" />
                       <button type="button" class="btn btn-w-s btn-seller" onclick="$('#hiddenModalPK').val('');clientSerchList.get(1, 20)"><i class="fa fa-search"></i></button>
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
					        	<strong id="companyName"></strong>&nbsp;<span style="color: #8C8C8C;display:none;" id="clientUseYn">(폐업)</span>
					       </h2>
                   			<div class="tabs-container mg-b30">
                       			<ul class="nav nav-tabs">
					               <li class="active"><a data-toggle="tab" href="#tab2-1" onclick="initPaing();companyDetail.getCompanyInfo();">고객사정보</a></li>
					               <li class=""><a data-toggle="tab" href="#tab2-8" onclick="initPaing();companyDetail.getCompanyItInfo();">IT정보</a></li>
					               <li class=""><a data-toggle="tab" href="#tab2-2" onclick="initPaing();companyDetail.getCompanyOpp();">영업기회</a></li>
					               <li class=""><a data-toggle="tab" href="#tab2-3" onclick="initPaing();companyDetail.getCompanyIssue();">고객이슈</a></li>
					               <li class=""><a data-toggle="tab" href="#tab2-5" onclick="initPaing();companyDetail.getCompanyContact();">컨택이력</a></li>
					               <li class=""><a data-toggle="tab" href="#tab2-7" onclick="initPaing();companyDetail.getCompanyFile();">첨부파일</a></li>
					           </ul>
					        </div>

							<!-- ajax data -->
							<div id="companyAjax" class="tab-content"></div>
                       
						</div>
                   </div>
			</div>
		</div>
	<jsp:include page="/WEB-INF/jsp/pc/clientManagement/clientCompanyInfoModal.jsp"/>
	<%-- <jsp:include page="/WEB-INF/jsp/pc/clientManagement/clientCompanyProjectMgModal.jsp"/> --%>
    </div>
    <!-- 상세보기 영역:end -->
<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>