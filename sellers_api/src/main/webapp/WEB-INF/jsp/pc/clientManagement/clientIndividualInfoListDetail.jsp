<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top_clientIndividualInfoListDetail.jsp"%>


<script type="text/javascript">
$(document).ready(function(){
	clientList.init();
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
	    	$('#hiddenModalPK').val('');
	    	clientSerchList.get();
	    }    
	});
	
});


var globalCustomerId;

var customer_name = "${param.customer_name}";
var customer_id = "${param.customer_id}";
var company_id = "${param.company_id}";

var search_chk = true;

var returnValue = "";

var modalFlag = "upd"; //업데이트
var searchSerialize;
var reloadFlag = true;

var compare_before;
var compare_after;
var compareFlag = false;


var clientList = {
		init : function () {
			if(customer_name){
				$("#serchDetail").val(customer_name);
			}
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
							attrChk = true;
						}
					}
				}
			});
		},
		
		//게이트 페이지에서 검색할 떄 실행 - 왼쪽 리스트 가져오기
		get : function(){
			var params = $.param({
				pageStart : page.start,
				pageEnd : page.end,
				serchInfo : $("#serchDetail").val(),
				clientId : $("#hiddenDetailCustomerId").val(),
				customerId : customer_id,
				creatorId : $("#hiddenModalCreatorId").val(),
				serch : 2,
				datatype : 'html',
				jsp : '/clientManagement/clientIndividualInfoSearchListAjax'
			});
			
			$.ajax({
				url : "/clientManagement/selectClientIndividualInfoLeftList.do",
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
		
		goDetail : function(customerId, companyId, customerName, position, use_yn){
			//defaultInfo.goClickUserDetail(clientNo, companyId, clientName);
			//페이징
			initPaing();
			//검색값 초기화 common.js
			filedReset($('#formSearchCommon'));
			if(use_yn == "N"){
				$("strong#customerName").text(customerName +" "+ position);
				$("#customerUseYn").show();
			}else{
				$("strong#customerName").text(customerName +" "+position);
				$("#customerUseYn").hide();
			}
			globalCustomerId = customerId;
			customerDetail.params = $.param({
				hiddenModalPK : customerId,
				customerId : customerId,
				companyId : companyId,
				customerName : customerName
			});
			customerDetail.getCustomerInfo();
		}
}

var clientSerchList = {
		//상세페이지에서 고객검색할 때 실행 - 고객 리스트 가져오기
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
				jsp : '/clientManagement/clientIndividualInfoSearchListAjax'
			});
			
			$.ajax({
				url : "/clientManagement/selectClientIndividualInfoLeftList.do",
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
		
		goDetail : function(clientNo, companyId, clientName){
			defaultInfo.goClickUserDetail(clientNo, companyId, clientName);
		}
}


//안탐
var defaultInfo = {

}

var detail = {
		update : function(){
			//detail.selectIndividualDetail(); 
			modal.gotoDetail('1');
			
			comparePerSonalProfile = "";
			comparePerSonalActs = ""
			comparePerSonalFamily = "";
			comparePerSonalInclination = "";
			comparePerSonalFamiliars = "";
			comparePerSonalSNS = "";
			comparePerSonalETC = "";
						
			// 고객사
			$(".value").remove();
			
			var companyName = $("#hiddenCompanyName").val();
			var companyId = $("#hiddenCompanyId").val();
			
			if(companyId){
       	$("a[name='aMoveSingleCompany']").remove();
       	$("#textCommonSearchCompany").hide();
       	$("#hiddenModalCompanyId").val(companyId);
       	$('#liCommonSearchCompany').before(
     			'<li class="value">' +
					'<span class="txt" id="'+companyId+'">'+companyName+'</span>' +
					'<a href="#" class="remove" onclick="commonSearch.removeSingleCompany(this);"><i class="fa fa-times-circle"></i></a></li>'+
					'<a href="/clientManagement/viewClientCompanyInfoDetail.do?company_id='+companyId+'&searchDetail='+encodeURI(companyName)+'" target="_blank" name="aMoveSingleCompany" class="btn-group-sum" style="margin:6px 0 0 5px">바로가기</a>'
				); 				
			}else{
				$("#textCommonSearchCompany").show();				
			}
			
			// 책임자
			$("#liModalDirectorName .value").remove();
			var directorId = $("#hiddenDirectorId").val();
			var directorName = $("#hiddenDirectorName").val();
			
			if(directorId){
				$("#textModalDirectorName").hide();
				$("#hiddenModalDirectorId").val(directorId);
       	$('#liModalDirectorName').before(
          '<li class="value">' +
					'<span class="txt" id="'+directorId+'">'+directorName+' ['+ $('#hiddenDirectorPosition').val() +']</span>' +
					'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalDirectorName\',\'liModalDirectorName\',\'hiddenModalDirectorId\');"><i class="fa fa-times-circle"></i></a></li>'
				);					
			}else{
				$("#textModalDirectorName").show();				
			}
						
			// 이전영업사원
			$("#ulModalPerSonalPrevSales > a").remove();
			var prevSalesId = $("#hiddenPrevSalesMemberId").val();
			var prevSalesName = $("#hiddenPrevSalesHanName").val();
			
			if(prevSalesId){
				$("#textModalPerSonalPrevSales").hide();
				$("#hiddenModalPrevSalesMemberId").val(prevSalesId);
       	$('#liModalPerSonalPrevSales').before(
          '<li class="value">' +
					'<span class="txt" id="'+prevSalesId+'">'+prevSalesName+' ['+ $('#hiddenPrevSalesPosition').val() +']</span>' +
					'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalPerSonalPrevSales\',\'liModalPerSonalPrevSales\',\'hiddenModalPrevSalesMemberId\');"><i class="fa fa-times-circle"></i></a></li>'
				);					
			}else{
				$("#textModalPerSonalPrevSales").show();				
			}
			
			// 보고라인
			$("#ulModalReportingLineTeamName > a").remove();
			var reportingTeamId = $("#hiddenReportingTeamId").val();
			var reportingTeamName = $("#hiddenReportingTeamName").val();
			
			if(reportingTeamId){
				$("#textModalReportingLineTeamName").hide();
				$("#textModalReportingTeamResult").val(reportingTeamId);
       	$('#liModalReportingLineTeamName').before(
          '<li class="value">' +
					'<span class="txt" id="'+reportingTeamId+'">'+reportingTeamName+' ['+ $('#hiddenReportingTeamPosition').val() +']</span>' +
					'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleClientMaster(\'textModalReportingLineTeamName\',\'liModalReportingLineTeamName\',\'textModalReportingTeamResult\');"><i class="fa fa-times-circle"></i></a></li>'
				);					
			}else{
				$("#textModalReportingLineTeamName").show();				
			}
			
			$("#ulModalReportingLinePostName > a").remove();
			var reportingPostId = $("#hiddenReportingPostId").val();
			var reportingPostName = $("#hiddenReportingPostName").val();
			
			if(reportingPostId){
				$("#textModalReportingLinePostName").hide();
				$("#textModalReportingPostResult").val(reportingPostId);
       	$('#liModalReportingLinePostName').before(
          '<li class="value">' +
					'<span class="txt" id="'+reportingPostId+'">'+reportingPostName+' ['+ $('#hiddenReportingPostPosition').val() +']</span>' +
					'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleClientMaster(\'textModalReportingLinePostName\',\'liModalReportingLinePostName\',\'textModalReportingPostResult\');"><i class="fa fa-times-circle"></i></a></li>'
				);					
			}else{
				$("#textModalReportingLinePostName").show();				
			}
			
			$("#ulModalReportingLineDivisionName > a").remove();
			var reportingDivisionId = $("#hiddenReportingDivisionId").val();
			var reportingDivisionName = $("#hiddenReportingDivisionName").val();
			
			if(reportingDivisionId){
				$("#textModalReportingLineDivisionName").hide();
				$("#textModalReportingDivisionResult").val(reportingDivisionId);
       	$('#liModalReportingLineDivisionName').before(
          '<li class="value">' +
					'<span class="txt" id="'+reportingDivisionId+'">'+reportingDivisionName+' ['+ $('#hiddenReportingTeamPosition').val() +']</span>' +
					'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleClientMaster(\'textModalReportingLineDivisionName\',\'liModalReportingLineDivisionName\',\'textModalReportingDivisionResult\');"><i class="fa fa-times-circle"></i></a></li>'
				);					
			}else{
				$("#textModalReportingLineDivisionName").show();				
			}
			
			
			$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;'+$("#hiddenCreatorId").val()+
					'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+$("#hiddenSysUpdateDate").val().replace(/-/gi, "/").substring(0,10)+"</span>");
			/* $("#divModalNameAndCreateDate").html("작성자 : "+$("#hiddenCreatorId").val()+"/ 작성일 : "+$("#hiddenSysUpdateDate").val()); */
			
			$("#textModalDivision").val($("#hiddenDivision").val());						//소속본부
			$("#textModalPost").val($("#hiddenPost").val());								//소속부서
			$("#textModalTeam").val($("#hiddenTeam").val());								//소속팀명
			
			$("#textModalDuty").val($("#hiddenDuty").val());								//담당업무
			$("#textModalEmail").val($("#hiddenEmail").val());							//전자메일
			$("#textModalAddress").val($("#hiddenAddress").val());										//주소
			$("#textModalClientName").val($("#hiddenCustomerName").val());				//고객명
			$("#textModalPosition").val($("#hiddenPosition").val());						//직급
			$("#textModalPositionDuty").val($("#hiddenPositionDuty").val());			//직책
			$("#textModalCellPhone").val($("#hiddenCellPhone").val());					//휴대전화
			$("#textModalPhone").val($("#hiddenPhone").val());							//일반전화
			$("input:radio[name='radioModalUseYN']:radio[value='"+$("#hiddenUseYn").val()+"']").prop("checked",true); //재직여부
			
			if($("#hiddenPersonalNameCard").val()!='' && $("#hiddenPersonalNameCard").val()!=null) {
				$("#divModalUploadNameCard").html('<span name="modalFile'+$("#hiddenCreatorId").val()+'" style="display:none;"> <img class="photo" border="0" alt="" style="background:url(\'/'+$("#hiddenPersonalNameCard").val()+'\') no-repeat center center; background-size:cover;">');			//개인사진
			}else{
				$("#divModalUploadNameCard").html('<span class="blank-ment"><img style="background:url(\'../images/pc/namecard_default.png\') no-repeat center center; background-size:cover;" class="photo" alt=""/></span>');
			}
			if($("#hiddenPersonalPhoto").val()!='' && $("#hiddenPersonalPhoto").val()!=null) {
				$("#divModalUploadPhoto").html('<span name="modalFile'+$("#hiddenCreatorId").val()+'" style="display:none;"> <img class="photo" border="0" alt="" style="background:url(\'/'+$("#hiddenPersonalPhoto").val()+'\') no-repeat center center; background-size:cover;">');			//개인사진
			}else{
				$("#divModalUploadPhoto").html('<span class="blank-ment"><img style="background:url(\'../images/pc/photo_default.png\') no-repeat center center; background-size:cover;" class="photo" alt=""/></span>');
			}
			$("#textModalRelationshipInfo").val($("#hiddenRelationship").val()); 			//자사와의 관계
			
			if(isEmpty($("#hiddenRelation").val())){				 			//관계수립
				$("#selectModalRelation").val('green');	
				$("#selectModalRelation").css('background-color', 'green');
			}else{
				$("#selectModalRelation").val($("#hiddenRelation").val());
				$("#selectModalRelation").css('background-color', $("#selectModalRelation").val());
			}
			
			if(isEmpty($("#hiddenLikebility").val())){							//호감도
				$("#selectModalLikeAbility").val('green');//관계수립
				$("#selectModalLikeAbility").css('background-color', 'green');
			}else{
				$("#selectModalLikeAbility").val($("#hiddenLikebility").val());
				$("#selectModalLikeAbility").css('background-color', $("#selectModalLikeAbility").val());
			}
			
			$("#textModalFriendshipInfo").val($("#hiddenFriendshipInfo").val());			//친한직원
			$("#textModalPerSonalInfoSource").val($("#hiddenInfoSource").val());			//정보출처
			
			$("#textModalPerSonalEducation").val($("#hiddenPersonalInfoEducation").val());			//개인정보_학력경력
			$("#textModalPerSonalEducationPerson").val($("#hiddenPersonalInfoEducationPerson").val());			//개인정보_학력경력
			$("#textModalPerSonalCareer").val($("#hiddenPersonalInfoCareer").val());			//개인정보_학력경력
			$("#textModalPerSonalCareerPerson").val($("#hiddenPersonalInfoCareerPerson").val());			//개인정보_학력경력
			$("#textModalPerSonalActs").val($("#hiddenPersonalInfoSocialActs").val());			//개인정보_사회활동
			$("#textModalPerSonalFamily").val($("#hiddenPersonalInfoFamily").val());			//개인정보_가족
			$("#textModalPerSonalInclination").val($("#hiddenPersonalInfoInclination").val());	//개인정보_성향
			$("#textModalPerSonalFamiliars").val($("#hiddenPersonalInfoFamilars").val());		//개인정보_친한사람
			$("#textModalPerSonalSNS").val($("#hiddenPersonalInfoSNS").val());					//개인정보_SNS
			$("#textModalPerSonalETC").val($("#hiddenPersonalInfoETC").val());					//개인정보_기타
			/* commonSearch.companyHtml($("#hiddenCompanyName").val(), $("#hiddenCompanyId").val());
			$("ul.company-list").html("");
			$("#textCommonSearchCompany").val(""); */
			
			$("#hiddenModalCompanyId").val($("#hiddenCompanyId").val());					//고객사아이디
			$("#hiddenModalPK").val($("#hiddenClientId").val());					//고객아이디
					
			//erp연동 관련
			if(!isEmpty($("#hiddenERPClientCode").val())){
				$("#formModalData #spanERPClientCodeCheck > i.fa.fa-check").show();
				$("#formModalData #spanERPClientCodeCheck > i.fa.fa-close").hide();
				$("#textModalERPClientCode").val($("#hiddenERPClientCode").val());
			}else{
				$("#formModalData #spanERPClientCodeCheck > i.fa.fa-check").hide();
				$("#formModalData #spanERPClientCodeCheck > i.fa.fa-close").show();
				$("#textModalERPClientCode").val('');
			}
			
			// 아래 필요없는거 삭제 
			$("#buttonModalDelete").show();
			
			$("#divModalUploadNameCard").show();
			$("#divModalNameCardUploadArea .fileModalUploadNameCard").remove();
			$("#divModalUploadPhoto").show();
			$("#divModalPhotoUploadArea .fileModalUploadPhoto").remove();
			//$('#divFileUploadList').html('<span>파일을 선택해 주세요.</span>');
			//$("#divModalUploadPhoto span").hide();
			$("#divModalUploadNameCard span[name='modalFile"+$("#hiddenCreatorId").val()+"']").show();
			$("#divModalUploadNameCard #imgModalInsertNameCard").remove();
			$("#divModalUploadPhoto span[name='modalFile"+$("#hiddenCreatorId").val()+"']").show();
			$("#divModalUploadPhoto #imgModalInsertPhoto").remove();
			
			
			$("h4.modal-title").html($("#hiddenCustomerName").val()+" "+$("#hiddenPosition").val());
			$("small.font-bold").css('display','');
			$("#buttonModalSubmit").html("저장하기");

			//모달안에서 프로젝트 관련 마일스톤 없음
// 			salesDetail.reset();
// 			salesDetail.drawQualification();

			individualHistory.reset();
			individualHistory.drawQualification();
			$("#formModalData > div.tab-area > ul > li:nth-child(4)").hide();
			
			$("#myModal1").modal();
			//신규등록, 상세보기 div 접기 펴기
			//toggleDiv(modalFlag);
			compare_before = $("#formModalData").serialize();
			//값 비교를 위한.
		},
		
		/* selectIndividualDetail : function() {
			$.ajax({
				url : "/clientManagement/searchIndividualHistory.do",
				data : {
					customerName : $("#hiddenCustomerName").val(),
					customerId : $("#hiddenClientId").val()
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
	                $.ajaxLoading();
				},
				success : function(data){
					console.log(data.searchIndividualHistory);
					searchIndividualHistory = data.searchIndividualHistory;
					//$(rowData)[0].SOLUTION_AREA.innerHTML = data.rows;
					//$(rowData)[0].SOLUTION_AREA = data.rows;
					//console.log($(rowData)[0].SOLUTION_AREA);
				},
				complete: function() {
					$.ajaxLoadingHide();
				}
			});
		}, */
		
		businessCard : function(chk) {
			if($(chk).html() == '명함/사진 보기') {
				$(chk).html('명함/사진 숨기기');
				$("div.col-lg-12.ag_c.pos-rel.custom-photo").show();
			}else {
				$(chk).html('명함/사진 보기');
				$("div.col-lg-12.ag_c.pos-rel.custom-photo").hide();
			}
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
		
		clientInfo : function(company_id) {
			$("#formDetail #searchDetail").val($("#hiddenCompanyName").val());
			$("#formDetail #company_id").val(company_id);
			//$("#formDetail").attr({action:"/clientManagement/viewClientCompanyInfoDetail.do", method:"post"}).submit();
			menuCookieSet("고객사정보"); //메뉴 활성화
			var form =  $("#formDetail")[0];
			var url = "/clientManagement/viewClientCompanyInfoDetail.do";
			window.open("" ,"clientIndividualToCompanyInfo"); 
			form.target = "clientIndividualToCompanyInfo";
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
				window.open("" ,"clientIndividualToClientContact"); 
				form.target = "clientIndividualToClientContact";
				form.action = url; 
				form.submit();
			}else{
				alert("에러가 발생했습니다.\n관리자에게 문의하세요.");
			}
			goDetail.role = "0";
		},
		
		individualInfo : function(customerId, companyId, customerName){
			$("#formDetail #company_id").val(companyId);
			$("#formDetail #customer_id").val(customerId);
			$("#formDetail #customer_name").val(customerName);
			menuCookieSet("고객개인정보"); //메뉴 활성화
			var form = $("#formDetail")[0];
			var url = "/clientManagement/viewClientIndividualInfoDetail.do";
			window.open("" ,"clientIndividualToClientIndividualInfo");
			form.target = "clientIndividualToClientIndividualInfo";
			form.action = url; 
			form.submit();
		}
}


var customerDetail = {
		//공통 파라미터		
		params : null,
		
		//tab
		tab : function(e){
			$("div.tab-pane").removeClass("active");
			$("div.tab-pane").eq(e).addClass("active");
			$("ul.nav.nav-tabs > li").removeClass("active");
			$("ul.nav.nav-tabs > li").eq(e).addClass("active");	
		},
		
		getCustomerInfo : function(){
			var params = $.param({
				datatype : 'html',
				jsp : '/clientManagement/clientIndividualDefaulInfoTabAjax'
			});
			//if(!pagingCalculation(pn,ep)) return false; //페이징 계산
			customerDetail.tab(0);
			$.ajax({
				url : "/clientManagement/selectCustomerInfo.do",
				datatype : 'html',
				data : customerDetail.params + "&" + params,
				cache : false,
				method : 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					$("div#customerAjax").html(data);
					$("#hiddenModalProjectMgClientId").val($("#hiddenClientId").val());
					$("#LATELY_UPDATE_DATE").html($("#hiddenSysUpdateDate").val());
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
			
			params = $.param({
				datatype : 'json',
			});
			
			//이전회사정보
			$.ajax({
				url : "/clientManagement/selectClientIndividualHistoryList.do",
				datatype : 'json',
				data : customerDetail.params + "&" + params,
				cache : false,
				method : 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					returnValue = ":=====선택 =====";
					for(var i=0; i<data.ClientIndividualHistory.length; i++){
						returnValue += ";" + data.ClientIndividualHistory[i].CUSTOMER_ID + ":" + data.ClientIndividualHistory[i].COMPANY_NAME + " "
						+ data.ClientIndividualHistory[i].DIVISION + " " + data.ClientIndividualHistory[i].CUSTOMER_NAME + " " + data.ClientIndividualHistory[i].POSITION;
					}
				console.log(returnValue);
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		getIndividualInfo : function(pn,ep){
			var params = $.param({
				datatype : 'html',
				jsp : '/clientManagement/clientIndividualInfoTabAjax'
			});
			//if(!pagingCalculation(pn,ep)) return false; //페이징 계산
			customerDetail.tab(1);
			$.ajax({
				url : "/clientManagement/selectIndividualInfo.do",
				datatype : 'html',
				data : customerDetail.params + "&" + params,
				cache : false,
				method : 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					$("div#customerAjax").html(data);
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		getCustomerProjectMg : function(pn,ep){
			var params = $.param({
				datatype : 'html',
				jsp : '/clientManagement/clientIndividualProjectMgTabAjax'
			});
			//if(!pagingCalculation(pn,ep)) return false; //페이징 계산
			customerDetail.tab(2);
			$.ajax({
				url : "/clientManagement/selectCustomerProjectMg.do",
				datatype : 'html',
				data : customerDetail.params + "&" + params,
				cache : false,
				method : 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					//alert($("hiddenModalProjectMgClientId").val());
					$("div#customerAjax").html(data);
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		getCustomerContact : function(pn,ep){
			var params = $.param({
				datatype : 'html',
				jsp : '/clientManagement/clientIndividualContactTabAjax'
			});
			
			if(!pagingCalculation(pn,ep)) return false; //페이징 계산
			customerDetail.tab(3);
			$.ajax({
				url : "/clientManagement/selectCustomerContact.do",
				datatype : 'html',
				data : customerDetail.params + "&" + $.param(pagingParams) + "&" + $("#formSearchCommon").serialize() + "&" + params + "&" + $.param(page),
				cache : false,
				method : 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					$("div#customerAjax").html(data);
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		getCustomerCompanyList : function(pn,ep){
			var params = $.param({
				datatype : 'html',
				jsp : '/clientManagement/clientIndividualInCompanyListTabAjax'
			});
			
			if(!pagingCalculation(pn,ep)) return false; //페이징 계산
			customerDetail.tab(4);
			$.ajax({
				url : "/clientManagement/selectCustomerCompanyList.do",
				datatype : 'html',
				data : customerDetail.params + "&" + $.param(pagingParams) + "&" + $("#formSearchCommon").serialize() + "&" + params + "&" + $.param(page),
				cache : false,
				method : 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					$("div#customerAjax").html(data);
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		getCustomerHistory : function(pn,ep){
			var params = $.param({
				datatype : 'html',
				jsp : '/clientManagement/clientIndividualHistoryTabAjax'
			});
			//if(!pagingCalculation(pn,ep)) return false; //페이징 계산
			customerDetail.tab(5);
			$.ajax({
				url : "/clientManagement/selectCustomerHistory.do",
				datatype : 'html',
				data : customerDetail.params + "&" + params,
				cache : false,
				method : 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					$("div#customerAjax").html(data);
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		}
}

</script>

	<form id="formDetail" name="formDetail" method="post">
    	<input type="hidden" id="event_id" name="event_id">
    	<input type="hidden" id="searchDetail" name="searchDetail">
    	<input type="hidden" id="company_id" name="company_id">
    	<input type="hidden" id="customer_id" name="customer_id">
    	<input type="hidden" id="customer_name" name="customer_name">
    </form>
    
		<div class="row wrapper border-bottom white-bg page-heading">
		
			<!-- <div class="col-sm-6">
		        <h2>고객 개인정보 검색</h2>
		        <ol class="breadcrumb">
		            <li>
		                <a href="/main/index.do">Home</a>
		            </li>
		            <li>
		                <a>고객사 및 고객개인정보</a>
		            </li>
		            <li>
		                <a href="/clientManagement/viewClientIndividualInfoGate.do">고객개인정보</a>
		            </li>
		            <li class="active">
		                <strong>고객개인정보 상세보기</strong>
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
  		<input type="hidden" id="hiddenDetailCustomerId" value="${customerId}"/>
  		<input type="hidden" id="hiddenDetailCompanyId" value="${companyId}"/>
  		<input type="hidden" id="hiddenDetailSearchDetail" value="${searchDetail}"/>
       <div class="fh-breadcrumb">

           <div class="fh-column" id="fh-column">
               <div class="full-height-scroll" id="leftList" style="border-right: 1px solid #e7eaec;">
                   <div class="left-custom-search">
                       <input type="text" placeholder="고객명 또는 고객사 입력" class="input form-control fl_l" id="serchDetail" value="${searchDetail}" />
                       <button type="button" class="btn btn-w-s btn-seller" onclick="$('#hiddenModalPK').val(''); clientSerchList.get(1, 20)"><i class="fa fa-search"></i></button>
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
               <div class="white-bg border-left">
                   <div class="element-detail-box" style="overflow: hidden; width: auto; height: 100%;">
                      <h2 class="element-name">
								        	<strong id="customerName"></strong><span id="customerUseYn">(퇴사자)</span>&nbsp;
				           				<!-- <button class="btn btn-seller btn-sm" id="buttonUpdateClientIndividual" onClick="detail.update();"> 정보수정 </button> -->
								      </h2>
											<div class="tabs-container mg-b30">
                    	 		<ul class="nav nav-tabs">
							               <li class="active"><a data-toggle="tab" href="#tab2-1" onclick="initPaing();customerDetail.getCustomerInfo();">기본정보</a></li>
							               <li class=""><a data-toggle="tab" href="#tab2-2" onclick="initPaing();customerDetail.getIndividualInfo();">개인정보</a></li>
							               <li class=""><a data-toggle="tab" href="#tab2-3" onclick="initPaing();customerDetail.getCustomerProjectMg();">프로젝트이력</a></li>
							               <li class=""><a data-toggle="tab" href="#tab2-4" onclick="initPaing();customerDetail.getCustomerContact(1,1);">컨택이력</a></li>
							               <li class=""><a data-toggle="tab" href="#tab2-5" onclick="initPaing();customerDetail.getCustomerCompanyList();">소속 고객정보</a></li>
							               <li class=""><a data-toggle="tab" href="#tab2-6" onclick="initPaing();customerDetail.getCustomerHistory();">이전회사 정보</a></li>
				           				</ul>
				        			</div>
                      <!-- ajax data -->
											<div id="customerAjax" class="tab-content"></div>
                   </div>
               </div>
           </div>
			<jsp:include page="/WEB-INF/jsp/pc/clientManagement/clientIndividualInfoModal.jsp"/>
			<jsp:include page="/WEB-INF/jsp/pc/clientManagement/clientIndividualProjectMgTabModal.jsp"/>
       </div>
       <!-- 상세보기 영역:end -->
<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>