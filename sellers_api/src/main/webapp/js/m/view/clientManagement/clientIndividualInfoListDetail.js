function fnDetail() {
    var params = $.param({
        datatype : 'json',
        jsp : '/clientManagement/clientCompanyInfoTabAjax'
    });
    
    $.ajax({
        url : "/clientManagement/selectCustomerInfo.do",
        datatype : 'json',
        data : {
            "customerId" : customerId,
            "datatype" : "json"
        },
        cache : false,
        method : 'POST',
        beforeSend : function(xhr){
            xhr.setRequestHeader("AJAX", true);
        },
        success : function(data){
			var clientInfo = data.defaultInfo[0];
			
			var use_yn = "재직"; // 재직(Y) / 퇴직(N) 여부
			$("#textModalClientBusinessCard").html("<a href'#' class='fc_orange' onClick='showCard();'>[명함보기]</a>");
			$("#textModalClientBusinessCardBox").html("<img src='../../../images/m/namecard3.png'>");
			$("#textModalClientName").html(clientInfo.CUSTOMER_NAME + " <span class='fs12'>" + clientInfo.POSITION + "</span>");
			
			var cellPhone =  clientInfo.CELL_PHONE;
			cellPhone = cellPhone.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
			$("#textModalCellPhone").html("<a href='tel:" + clientInfo.CELL_PHONE + "' class='phone ds_in'>" + cellPhone + "</a>");
			
			var phone =  clientInfo.PHONE;
			phone = phone.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
			$("#textModalPhone").html("<a href='tel:" + clientInfo.PHONE + "' class='phone ds_in'>" + phone + "</a>");
			
			$("#textModalEmail").html("<a href='mailto:" + clientInfo.EMAIL + "' class='phone ds_in'>" + clientInfo.EMAIL + "</a>");
			if (clientInfo.USE_YN == "N") {
			    use_yn = "퇴직";
			}
			$("#radioModalUseYN").html(use_yn);
			$("#textCommonSearchCompany").html(clientInfo.COMPANY_NAME);
			$("#textCommonSearchCompanyId").html(clientInfo.COMPANY_ID);
			$("#textCommonSearchCustomerId").html(clientInfo.CUSTOMER_ID);
			$("#textModalDivision").html(clientInfo.DIVISION);
			$("#textModalPost").html(clientInfo.POST);
			$("#textModalTeam").html(clientInfo.TEAM);
			$("#textModalPositionDuty").html(clientInfo.POSITION_DUTY);
			$("#textModalReportingLineTeamName").html("1단계 : " + undefinedCheck(clientInfo.TEAM_POSITION_DUTY) + "<a href='' class='fc_orange'> " + undefinedCheck(clientInfo.TEAM_NAME) + "</a>" + undefinedCheck(clientInfo.TEAM_POSITION));// +
																																																												// "("
																																																												// +
																																																												// undefinedCheck(clientInfo.DIVISION_ID)
																																																												// +
																																																												// ")"
			$("#textModalReportingLinePostName").html("2단계 : " + undefinedCheck(clientInfo.POST_POSITION_DUTY) + "<a href='' class='fc_orange'> " + undefinedCheck(clientInfo.POST_NAME) + "</a>" + undefinedCheck(clientInfo.POST_POSITION));// +
																																																												// "("
																																																												// +
																																																												// undefinedCheck(clientInfo.POST_ID)
																																																												// +
																																																												// ")"
			$("#textModalReportingLineDivisionName").html("3단계 : " + undefinedCheck(clientInfo.DIVISION_POSITION_DUTY) + "<a href='' class='fc_orange'> " + undefinedCheck(clientInfo.DIVISION_NAME) + "</a>" + undefinedCheck(clientInfo.DIVISION_POSITION));// +
																																																																// "("
																																																																// +
																																																																// undefinedCheck(clientInfo.TEAM_ID)
																																																																// +
																																																																// ")"
			$("#textModalDuty").html(clientInfo.DUTY);
			$("#textModalAddress").html(clientInfo.ADDRESS);
			$("#textModalRelationshipInfo").html(clientInfo.PINFO_RELATIONSHIP);
			$("#selectModalRelation").html("<span class='status_lec statusColor_" + clientInfo.RELATION + "'></span>");
			$("#selectModalLikeAbility").html("<span class='status_lec statusColor_" + clientInfo.LIKEABILITY + "'></span>");
			$("#textModalFriendshipInfo").html(clientInfo.FRIENDSHIP_INFO);
			$("#textModalDirectorName").html(undefinedCheck(clientInfo.DIRECTOR_NAME) + " " + undefinedCheck(clientInfo.DIRECTOR_POSITION));
			$("#textModalPerSonalInfoSource").html(clientInfo.INFO_SOURCE);
			$("#textModalPerSonalPrevSales").html(undefinedCheck(clientInfo.PREV_SALES_HAN_NAME) + " " + undefinedCheck(clientInfo.PREV_SALES_POSITION));
			$("#textModalPerSonalEducation").html(clientInfo.PINFO_EDUCATION);
			$("#textModalPerSonalEducationPerson").html(clientInfo.PINFO_EDUCATION_PERSON);
			$("#textModalPerSonalCareer").html(clientInfo.PINFO_CAREER);
			$("#textModalPerSonalCareerPerson").html(clientInfo.PINFO_CAREER_PERSON);
			$("#textModalPerSonalActs").html(clientInfo.PINFO_SOCIAL_ACTS);
			$("#textModalPerSonalFamily").html(clientInfo.PINFO_FAMILY);
			$("#textModalPerSonalInclination").html(clientInfo.PINFO_INCLINATION);
			
			$("#hiddenModalPerSonalInclination").html(clientInfo.PINFO_INCLINATION);
			$("#textModalPerSonalFamiliars").html(clientInfo.PINFO_FAMILIARS);
			$("#textModalPerSonalSNS").html(clientInfo.PINFO_SNS);
			$("#textModalPerSonalETC").html(clientInfo.PINFO_ETC);
			
            $("#hiddenERPClientCode").val(clientInfo.ERP_CLIENT_CODE);
            
            // 작성일자
            var updateDate = moment(clientInfo.SYS_UPDATE_DATE);
			updateDate = updateDate.format("YYYY-MM-DD");
            $("#textModalCreatorId").html("<span>" + clientInfo.CUSTOMER_NAME +"(" + updateDate + ")</span");
            
            $("#").html("");            
			
            // 수정폼 데이터 입력
            $("#pkNo").val(clientInfo.CUSTOMER_ID);
            
			//erp연동 관련
			if(!isEmpty($("#hiddenERPClientCode").val())){
				$("#spanERPClientCodeCheck > i.fa.fa-check").show();
				$("#spanERPClientCodeCheck > i.fa.fa-close").hide();
				$("#textModalERPClientCode").val($("#hiddenERPClientCode").val());
			}else{
				$("#spanERPClientCodeCheck > i.fa.fa-check").hide();
				$("#spanERPClientCodeCheck > i.fa.fa-close").show();
				$("#textModalERPClientCode").val('');
			}
        },
        complete : function(){
        }
    });
}    

function showCard(){
	if($("#nameCardBox").css("display") == "none"){   
        jQuery('#nameCardBox').show();
        jQuery('#nameCardURL').show();
        jQuery('#nameCardDeafult').show();
        
    } else {  
        jQuery('#nameCardBox').hide();
        jQuery('#nameCardURL').hide();
        jQuery('#nameCardDeafult').hide();
    }
}

/***********************************************************************
 * 고객 컨택의 경우 PC버전에서 요구하는 파라미터가 너무 많아서 모바일에서 구현 불가능. 2017.06.14 향후 고객 컨택
 * 조회에 대한 파라미터 분석이 필요함. 해당 쿼리아이디 : clientSalesAtive_SQL.XML =>
 * selectClientContactList
 **********************************************************************/
function getCustomerContact() {
    var params = $.param({
        datatype : 'json',
        jsp : '/clientManagement/clientIndividualInfoListDetail'
    });

    $.ajax({
        url : "/clientManagement/selectCustomerContact.do",
        datatype : 'json',
        data : {
            customerId : customerId, 
            searchCustomerId : customerId,
            datatype : "json"
        },
        cache : false,
        method : 'POST',
        beforeSend : function(xhr){
            xhr.setRequestHeader("AJAX", true);
        },
        success : function(data){
        	var contactInfo = data.clientContact;
        	if(contactInfo.length > 0){
            	for(var i= 0 ; i < contactInfo.length; i++) {
            		$(".contact_history_list").html("");
            		for(var i= 0 ; i < contactInfo.length; i++) {
            			$(".contact_history_list").append("<li><a href='/clientSalesActive/selectContactDetail.do?pkNo=" + contactInfo[i].EVENT_ID + "'><div class='top'>"
            				+ "<span class='title'><span class='contact_type r2 va_m'>" + contactInfo[i].EVENT_CATEGORY + "</span>"
            				+ "<span class='va_m'> " + contactInfo[i].EVENT_SUBJECT + "</span></span>"
            				+ "<span class='custom_name'>소속본부 : " + contactInfo[i].DIVISION_NAME + "/ 보고자 : " + contactInfo[i].HAN_NAME + "</span>"
            				+ "<span class='date'>컨택일 : " + contactInfo[i].EVENT_DATE + "</span></div></a></li>"
            			);
            		}
            	}
        	}else{
        		$(".contact_history_list").html("<li><div class='top'>"
        			+ "<span class='title'>"
        			+ "<span class='contact_type r2 va_m'> - </span>"
        			+ "<span class='va_m'> 현재 등록된 데이터가 없습니다.</span>"
        			+ "<span class='custom_name'>소속본부 : -"
        			+ "<span class='date'>컨택일 : -"
        			+ "<span>"
        			+ "</div></li>");
        	}
        	// $("#textModalEventSubject").html(contactInfo.EVENT_SUBJECT);
        	/*
			 * $("div#customerAjax").html(data); console.log(data);
			 */
        },
        complete : function(){
        }
    });        
}

function getCustomerCompany() {
    var params = $.param({
        datatype : 'json',
        jsp : '/clientManagement/clientIndividualInfoListDetail'
    });
		
    $.ajax({
        url : "/clientManagement/selectCustomerCompanyList.do",
        datatype : 'json',
        data : {
            companyId : companyId, 
            // textSearchClient : "${searchDetail}",
            datatype : "json"
    			
        },
        cache : false,
        method : 'POST',
        beforeSend : function(xhr){
            xhr.setRequestHeader("AJAX", true);
        },
        success : function(data){
        	var companyInfo = data.clientCompany;
        	
        	if(companyInfo.length > 0){
            	for(var i= 0 ; i < companyInfo.length; i++) {
            		$(".com_member_list").html("");
            		
	            	for(var i= 0 ; i < companyInfo.length; i++) {
	            		var teamName = null;
	            		if(companyInfo[i].TEAM != null && companyInfo[i].TEAM != ""){
	            			teamName = companyInfo[i].TEAM;
	            		}else{
	            			teamName = " - ";
	            		}
	            		
	            		var phone = companyInfo[i].CELL_PHONE;
	            		//phone = phone.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
	            		
	            		$(".com_member_list").append("<li><a href='/clientManagement/viewClientIndividualInfoDetail.do?company_id=" + companyInfo[i].COMPANY_ID +  "&customer_id=" + companyInfo[i].CUSTOMER_ID + "';>"
	            		+ "<span class='custom_name'>" + companyInfo[i].CUSTOMER_NAME +" " +companyInfo[i].POSITION +"</span>"
	            		+ "<span class='org'>"+ teamName +"</span></a>"
	            		+ "<a href='tel:"+ companyInfo[i].CELL_PHONE + "' class='phone'>" + phone + "</a></li>");
	            		
            		}
        		}
    		}else{
    			$(".com_member_list").html("<li><span class='customer_name'>현재 등록된<br/>데이터가 없습니다.</span><span class='org'> - </span></li>");
    		}
			console.log(data);
        	
        },
        complete : function(){
        }
    });
}

function nameCard(){
	var params = $.param({
		datatype : 'json',
		jsp : '/clientManagement/clientIndividualInfoListDetail'
	});
	$.ajax({
		url : "/clientManagement/selectCustomerInfo.do",
		datatype : 'json',
		data : {
			customerId : customerId,
			companyId : companyId,
            datatype : "json"
		},
		cache : false,
		method : 'POST',
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
		},
		success : function(data){
			var nameCard = data.defaultPhoto;
			var path = data.imagePath; // properties-local.xml에서 경로 설정
										// 필요합니다.
			var nameCardURL =  nameCard[0].FILE_PATH + nameCard[0].FILE_NAME ;
			var imagePath = path + nameCardURL;
			
			if(nameCard[0].FILE_PATH.length > 0){
				$("#nameCardURL").html("<img src='../../../"+ nameCardURL  + "' />");
			}else{
				$("#nameCardDeafult").html("<img src='../../../images/m/namecard_default.png'/>");
			}
		},
		complate : function(){
			
		}
	})
}

function undefinedCheck(_param) {
    // 목표일과 완료일 undefined 체크
    if (typeof _param != "undefined") {
        return _param;
    } else {
        return "";
    }
}

function gogogo(companyInfo){
	alert(companyInfo);
}

function fncList(){
	location.href="/clientManagement/listClientIndividualInfoList.do";
}

function fncModify(){
    $("#updateForm").attr("action", "/clientManagement/clientIndividualInsertForm.do");
    $('#updateForm').submit();      

}

function fncSelectTab(_no){
	// 탭 이동
	$('#tab_1').removeClass('active');
	$('#tab_2').removeClass('active');
	$('#tab_3').removeClass('active');
	$('#tab_4').removeClass('active');
	$('#tab_'+_no).addClass('active');
	
	// 탭에 해당하는 컨테이너 보여주기
	$('.cont1').addClass('off');
	$('.cont2').addClass('off');
	$('.cont3').addClass('off');
	$('.cont4').addClass('off');
	$('.cont'+_no).removeClass('off');	
}

$(document).ready(function() {
    // 상세 정보 가져오기
    fnDetail();
    getCustomerContact();
    getCustomerCompany();
    nameCard();
    
    /*******************************************************************
	 * 고객 컨택의 경우 PC버전에서 요구하는 파라미터가 너무 많아서 모바일에서 구현 불가능. 2017.06.14 향후 고객
	 * 컨택 조회에 대한 파라미터 분석이 필요함. 해당 쿼리아이디 : clientSalesAtive_SQL.XML =>
	 * selectClientContactList // 컨택정보가져오기 getCustomerContact();
	 ******************************************************************/
    
    // 고객 목록 조회 페이지 이동
    $("#clientIndividualList").on("click", function(e) {
        location.href = '/clientManagement/viewClientIndividualInfoGate.do';
        e.preventDefault();
    });    

    // 고객 수정 페이지 이동
    $("#insertClientIndividual").on("click", function(e) {
        $("#updateForm").attr("action", "/clientManagement/clientIndividualInsertForm.do");
        $('#updateForm').submit();       
        e.preventDefault();
    });
});