var comparePerSonalProfile = "";
var comparePerSonalActs = "";
var comparePerSonalFamily = "";
var comparePerSonalInclination = "";
var comparePerSonalFamiliars = "";
var comparePerSonalSNS = "";
var comparePerSonalETC = "";
    
function insertClientIndividual() {
	var browser = getIEVersionCheck();
    var url = "/clientManagement/insertClientIndividualInfo.do";
    if(mode == 'upd'){
    	url = "/clientManagement/updateClientIndividualInfo.do";
    }
    
    $('#formModalData').ajaxForm({
        url : url,
        type: "POST", 
        async : false,
        data : {
            datatype : 'json',
            browser : browser
        },
        beforeSubmit: function (data,form,option) {
            if(!confirm("저장하시겠습니까?"))  {
                return false;
            }
        },
        beforeSend : function(xhr){
            xhr.setRequestHeader("AJAX", true);
        },
        success: function(data){
            //성공후 서버에서 받은 데이터 처리
            if(data.cnt > 0){
                compareFlag = false;
                alert("저장하였습니다.");
                window.history.back();
                //window.location.href ="/clientManagement/viewClientIndividualInfoGate.do";
            }else if(data.error == 'sequence'){
                alert("시퀀스에러.\n관리자에게 문의하세요.");
            }else{
                alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
            }
        },
        complete: function() {
        } 
    });   
     
    $('#formModalData').submit();
}
    
    
    // 수정하기 위한 고객사 데이터 셋팅
function updateDetail(_pkNo) {
    var params = $.param({
        datatype : 'json',
        jsp : '/clientManagement/clientCompanyInfoTabAjax'
    });
    
    $.ajax({
        url : "/clientManagement/selectCustomerInfo.do",
        datatype : 'json',
        data : {
            "customerId" : _pkNo,
            "datatype" : "json"
        },
        cache : false,
        method : 'POST',
        beforeSend : function(xhr){
            xhr.setRequestHeader("AJAX", true);
        },
        success : function(data){
            var clientInfo = data.defaultInfo[0];
            
            $("#updateTitle").html(clientInfo.CUSTOMER_NAME + " <span class='fs12'>" + clientInfo.POSITION + "</span>");
            //$("#updateAuthor").html(clientInfo.HAN_NAME + " / " + clientInfo.SYS_UPDATE_DATE); 
            $("#updateAuthor").html(clientInfo.HAN_NAME);
            
            $("#textModalClientName").val(clientInfo.CUSTOMER_NAME);
            $("#textModalPosition").val(clientInfo.POSITION);
            $("#textModalCellPhone").val(clientInfo.CELL_PHONE);
            $("#textModalPhone").val(clientInfo.PHONE);
            $("#textModalEmail").val(clientInfo.EMAIL);
            $('input:radio[name=radioModalUseYN]:input[value=' + clientInfo.USE_YN + ']').attr("checked", true);
            $("#textCommonSearchCompany").val(clientInfo.COMPANY_NAME);
            $("#textCommonSearchCompany").css("background-color","#eee");
            $("#textCommonSearchCompanyId").val(clientInfo.COMPANY_ID);
            $("#textModalDivision").val(clientInfo.DIVISION);
            $("#textModalPost").val(clientInfo.POST);
            $("#textModalTeam").val(clientInfo.TEAM);
            $("#textModalPositionDuty").val(clientInfo.POSITION_DUTY);
            $("#textModalReportingLineTeamName").val(clientInfo.DIVISION_NAME);
            $("#textModalReportingTeamResult").val(clientInfo.DIVISION_ID);
            $("#textModalReportingLinePostName").val(clientInfo.POST_NAME);
            $("#textModalReportingPostResult").val(clientInfo.POST_ID);
            $("#textModalReportingLineDivisionName").val(clientInfo.TEAM_NAME);
            $("#textModalReportingDivisionResult").val(clientInfo.TEAM_ID);
            $("#textModalDuty").val(clientInfo.DUTY);
            $("#textModalAddress").val(clientInfo.ADDRESS);
            $("#textModalRelationshipInfo").val(clientInfo.PINFO_RELATIONSHIP);
            $("#selectModalRelation").val(clientInfo.RELATION).attr("selected", "selected");
            $("#selectModalLikeAbility").val(clientInfo.LIKEABILITY).attr("selected", "selected");
            $("#textModalFriendshipInfo").val(clientInfo.FRIENDSHIP_INFO);
            $("#textModalDirectorName").val(clientInfo.DIRECTOR_NAME);
            
            $("#textModalPerSonalInfoSource").val(clientInfo.INFO_SOURCE);
            $("#textModalPerSonalPrevSales").val(clientInfo.PREV_SALES_HAN_NAME);
            $("#textModalPerSonalEducation").val(clientInfo.PINFO_EDUCATION);
            $("#textModalPerSonalEducationPerson").val(clientInfo.PINFO_EDUCATION_PERSON);
            $("#textModalPerSonalCareer").val(clientInfo.PINFO_CAREER);
            $("#textModalPerSonalCareerPerson").val(clientInfo.PINFO_CAREER_PERSON);
            $("#textModalPerSonalActs").val(clientInfo.PINFO_SOCIAL_ACTS);
            $("#textModalPerSonalFamily").val(clientInfo.PINFO_FAMILY);
            $("#textModalPerSonalInclination").val(clientInfo.PINFO_INCLINATION);
            $("#textModalPerSonalFamiliars").val(clientInfo.PINFO_FAMILIARS);
            $("#textModalPerSonalSNS").val(clientInfo.PINFO_SNS);
            $("#textModalPerSonalETC").text(clientInfo.PINFO_ETC);
            
            $("#hiddenModalPK").val(clientInfo.CUSTOMER_ID);
            $("#hiddenModalCompanyId").val(clientInfo.COMPANY_ID);
            $("#hiddenModalPrevSalesMemberId").val(clientInfo.PREV_SALES_MEMBER_ID);
            $("#hiddenERPClientCode").val(clientInfo.ERP_CLIENT_CODE);
            
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

		    $("#textCommonSearchCompany").on("propertychange change keyup paste input", function() {
			  	var oldVal;
			    var currentVal = $(this).val();
			    if(currentVal == oldVal) {
			        return;
			    }
			    oldVal = currentVal;
		          $("#textCommonSearchCompany").css("background-color","#fff");

			});

			
        },
        complete : function(){
        }
    });
}    
    
function init() {
    //$('#formModalData').validate().resetForm(); 
    $("#formModalData #hiddenModalPK").val("");
    
    
    // 개인정보 초기화
    $("#textModalPerSonalEducation").val("<학력>\r\n\t- 초등학교 : \r\n\t- 중학교 : \r\n\t- 고등학교 : \r\n\t- 대학교 : ");
    $("#textModalPerSonalEducationPerson").val("- ");
    $("#textModalPerSonalCareer").val("<경력>\r\n\t- ");
    $("#textModalPerSonalCareerPerson").val("- ");
    $("#textModalPerSonalActs").val("<취미>\r\n\t- \r\n\r\n<인맥>\r\n\t- \r\n\r\n<종교>\r\n\t- ");
    $("#textModalPerSonalFamily").val("<가족관계>\r\n\t- \r\n\r\n<기념일>\r\n\t- ");
    $("#textModalPerSonalInclination").val("<커뮤니케이션 스타일>\r\n\t- \r\n\r\n<좋아하는 것>\r\n\t- \r\n\r\n<싫어하는 것>\r\n\t- ");
    $("#textModalPerSonalFamiliars").val("<소속,이름>\r\n\t- ");
    $("#textModalPerSonalSNS").val("<활동중인 SNS>\r\n\t- LinkedIn ID : \r\n\t- FaceBook ID : \r\n\t- Twitter ID : ");
    $("#textModalPerSonalETC").val("<금지사항>\r\n\t- \r\n\r\n<습관>\r\n\t- \r\n\r\n<주량>\r\n\t- \r\n\r\n<흡연여부>\r\n\t- ");
    
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
	
}
    
function validate() {
    $("#formModalData").validate({ // joinForm에 validate를 적용
        ignore: "",
        rules : {
            textModalClientName : {
                required : true,
                maxlength : 40
            },
            hiddenModalCompanyId : {
                required : true
            },
            textModalCellPhone : {
            	maxlength : 20
            },
            textModalPhone : {
            	maxlength : 20
            }
        },
        messages : { // rules에 해당하는 메시지를 지정하는 속성
            textModalClientName : {
                required : "고객개인명을 입력하세요."
            },
            hiddenModalCompanyId : {
                required : "고객사를 입력하세요." // 이와 같이 규칙이름과 메시지를 작성
            }
        },
        invalidHandler : function(error, element) {
            $('div.modaltabmenu').each(function(idx,obj){
                $("ul.tabmenu-type li a").eq(idx).trigger('click.modalTab');
                return false;
            });
        },
        errorPlacement : function(error, element) {
            if($(element).prop("id") == "hiddenModalCompanyId") {
                $("#textCommonSearchCompany").after(error);
                location.href = "#textCommonSearchCompany";
            }
            else {
                error.insertAfter(element); // default error placement.
            }
        }
    })        
}
    
// 파일 첨부시 해당 파일 썸네일을 보여주는 함수.
function getThumbnailPrivew(html, $target) {
    if (html.files && html.files[0]) {
        var reader = new FileReader();
        console.log(reader);
        console.log(html.files[0]);
        reader.onload = function (e) {
            //$target.html('<img id="imgModalInsertPhoto" border="0" alt="" src='+ e.target.result + ' no-repeat center center; background-size:cover;" />'); 
            $("#imgModalInsertPhoto").attr("src", e.target.result);
        }
        reader.readAsDataURL(html.files[0]);
    }
}
    
function fncSelectTab(_no){
    // 탭 이동
    $('#tab_1').removeClass('active');
    $('#tab_2').removeClass('active');
    $('#tab_'+_no).addClass('active');
    
    // 탭에 해당하는 컨테이너 보여주기
    $('.cont1').addClass('off');
    $('.cont2').addClass('off');
    $('.cont'+_no).removeClass('off');
}

$(document).ready(function(e){
    // 고객 조회 페이지 이동
    $("#clientIndividualList").on("click", function(e) {
        location.href = '/clientManagement/viewClientIndividualInfoGate.do';
        e.preventDefault();
    });    
    
    // 저장 
    $("#insertClientIndividual").on("click", function(e) {
        insertClientIndividual();
        e.preventDefault();
    }); 
    
    // 신규등록시  초기세팅
    if(mode != 'upd'){
    	init();
    }
    
    validate();
    
    //자동완성 검색
    commonSearch.company($("#formModalData #textCommonSearchCompany"), $('#formModalData #hiddenModalCompanyId'), $('#formModalData #textCommonSearchCompanyId'));
    commonSearch.customer($("#formModalData #textModalReportingLineDivisionName"), $('#formModalData #textModalReportingDivisionResult'), $("#formModalData #textModalReportingDivisionPosition"), $("#formModalData #textCommonSearchCompanyId"));
    commonSearch.customer($("#formModalData #textModalReportingLinePostName"), $('#formModalData #textModalReportingPostResult'), $("#formModalData #textModalReportingPostPosition"), $("#formModalData #textCommonSearchCompanyId"));
    commonSearch.customer($("#formModalData #textModalReportingLineTeamName"), $('#formModalData #textModalReportingTeamResult'), $("#formModalData #textModalReportingTeamPosition"), $("#formModalData #textCommonSearchCompanyId"));
    commonSearch.member($("#formModalData #textModalDirectorName"), $("#hiddenModalDirectorId"));
    commonSearch.member($("#formModalData #textModalPerSonalPrevSales"), $("#hiddenModalPrevSalesMemberId"));
    
    if(mode == 'upd'){
    	updateDetail(pkNo);
    }
});