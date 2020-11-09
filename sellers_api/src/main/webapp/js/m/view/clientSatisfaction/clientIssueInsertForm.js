/**
 * 초기 페이지 구성에 필요한 정보를 세팅한다.
 * @returns
 */
function pageInit() {
    //유효성 체크
    validate();

    //자동완성 검색
    commonSearch.company($('#formModalData #textCommonSearchCompany'), $('#formModalData #hiddenModalCompanyId'), $('#formModalData #textCommonSearchCompanyId'));
    commonSearch.contactClients($('#formModalData #textModalCustomerName'), $('#hiddenModalCustomerId'), $('#formModalData #textModalClientRank'), $('#formModalData #hiddenModalCompanyId'), null, $('#formModalData #ulModalMarketMembersName'));
    // 영업대표
    commonSearch.singleMember($("#formModalData #textModalSalesRepresentive"), $('#formModalData #liModalSingleSalesRepresentive'), $('#formModalData #hiddenModalSalesId')); 
    commonSearch.singleMember($("#formModalData #textModalSolveOwner"), $('#formModalData #liModalSingleSolveOwner'), $('#formModalData #hiddenModalSolveOwnerId')); 
    commonSearch.singleMember($("#formModalData #textModalIssueConfirmId"), $('#formModalData #liModalSingleIssueConfirmId'), $('#formModalData #hiddenModalIssueConfirmId')); 
        
    commonSearch.multipleMailShareMember($("#formModalData #textCommonSearchMember"), $('#formModalData #hiddenModalMemberList'), $('#formModalData #ulMultipleMailShareMember'));
    //직원 검색
    /*
    $('#textCommonSearchMember').on('keydown',function(key){
        if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
            commonSearch.multipleMemberPop();
         }
    });
    */
}

//고객사 체크
/* function companyIdCheck(){
	var tuns = $('#textCommonSearchCompanyId').val(); 
	if(tuns != "" && tuns != null){
	}else{
		alert("해당 고객사를 먼저 입력해주세요.");
		$('input[name="textCommonSearchCompany"]').focus();
	}
}  */

/**
 * validate
 * @returns
 */
function validate() {
    $("#formModalData").validate({ // joinForm에 validate를 적용
        ignore: "", 
        rules : {
            textModalSubject : {
                required : true,
                maxlength : 100
            },
            textModalIssueCreator : {
                required : true,
                maxlength : 10
            },
            selectModalIssueCategory : {
                required : true
            },
            // required는 필수, rangelength는 글자 개수(1~10개 사이)
            textModalIssueDate : {
                required : true
            },
            textModalDueDate : {
                required : true
            },
            textareaModalIssueDetail : {
                minlength : 1,
                maxlength : 2000
            },
            hiddenModalSolveOwnerId : {
                required : true,
                maxlength : 10
            },
            /* textModalIssueCloseDate : {
                required : true
            }, */
            textareaModalSolvePlan : {
                minlength : 1,
                maxlength : 2000
            },
            selectModalSolveEvidenceYN : {
                required : true
            },
            hiddenModalSalesId : {
                required : true
            },
            textareaSolveEvidenceDetail : {
                minlength : 1,
                maxlength : 2000
            },
            hiddenModalCustomerIdList : {
            	required : true
            }
        //pwdConfirm:{required:true, equalTo:"#pwd"}, 
        // equalTo : id가 pwd인 값과 같아야함
        //name:"required", // 검증값이 하나일 경우 이와 같이도 가능
        //personalNo1:{required:true, minlength:6, digits:true},
        // minlength : 최소 입력 개수, digits: 정수만 입력 가능
        //personalNo2:{required:true, minlength:7, digits:true},
        //email:{required:true, email:true},
        // email 형식 검증
        //blog:{required:true, url:true}
        // url 형식 검증
        },
        messages : { // rules에 해당하는 메시지를 지정하는 속성
            textModalSubject : {
                required : "제목을 입력하세요.",
                maxlength:"100글자 이하여야 합니다" 
            },
            textModalIssueCreator : {
                required : "이슈제기자를 입력하세요.",
                maxlength:"10글자 이하여야 합니다"
            },
            selectModalIssueCategory : {
                required : "이슈영역를 선택하세요."
            },
            // required는 필수, rangelength는 글자 개수(1~10개 사이)
            textModalIssueDate : {
                required : "이슈발생일를 선택하세요."
            },
            textModalDueDate : {
                required : "해결목표일을 선택하세요."
            },
            textareaModalIssueDetail : {
                minlength : 1,
                maxlength : 2000
            },
            hiddenModalSolveOwnerId : {
                required : "이슈해결책임자를 입력하세요.",
                maxlength:"10글자 이하여야 합니다"
            },
            /* textModalIssueCloseDate : {
                required : "이슈해결일를 선택하세요."
            }, */
            textareaModalSolvePlan : {
                minlength : 1,
                maxlength : 2000
            },
            selectModalSolveEvidenceYN : {
                required : "이슈해결 증빙여부를 선택하세요."
            },
            hiddenModalSalesId : {
                required : "영업대표를 입력하세요."
            },
            textareaSolveEvidenceDetail : {
                minlength : 1,
                maxlength : 2000
            },
            hiddenModalCustomerIdList : {
            	required : "고객명을 입력하세요."
            }
        },
        errorPlacement : function(error, element) {
        	
        	fncSelectTab(1);
        	
            if($(element).prop("id") == "hiddenModalCompanyId") {
                $("#textCommonSearchCompany").after(error);
                location.href = "#textCommonSearchCompany";
            }else if($(element).prop("id") == "hiddenModalCustomerId") {
                $("#textModalCustomerName").after(error);
                location.href = "#textModalCustomerName";
            }else if($(element).prop("id") == "hiddenModalSalesId") {
                $("#ulModalSingleSalesRepresentive").after(error);
                location.href = "#liModalSingleSalesRepresentive";
            }else if($(element).prop("id") == "hiddenModalSolveOwnerId") {
                $("#ulModalSingleSolveOwner").after(error);
                location.href = "#ulModalSingleSolveOwner";
            }else if($(element).prop("id") == "hiddenModalCustomerIdList") {
                $("#ulModalMarketMembersName").parent().after(error);
                location.href = "#ulModalMarketMembersName";
            }else {
                error.insertAfter(element); // default error placement.
            }
        }
    });               
}

/**
 * 탭 이동
 * @param _no
 * @returns
 */
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

/**
 * insert
 * @param shareFlag
 * @returns
 */
function insertClientIssue(shareFlag) {
    var url = "/clientSatisfaction/insertClientIssue.do";
    if(mode == 'upd'){
    	url = "/clientSatisfaction/updateClientIssue.do";
    }
    
    // 고객명 hiddenModalCustomerId 에 담기
    if($('#hiddenModalCustomerIdList').val()){
    	$('#hiddenModalCustomerId').val($('#hiddenModalCustomerIdList').val());
    }
    
    $('#formModalData').ajaxForm({
        url : url,
        async : true,
        data : {
        	issueSolvePlan : JSON.stringify(action.actSubmitList()),
            shareFlag : function(){
                if(shareFlag == 1){
                    return false;
                }else{
                    return true;
                }
            }
        },
        beforeSubmit: function (data,form,option) {
        	if(!action.actValid) return false;
        	
            if($('#textModalIssueDate').val()>$('#textModalDueDate').val()) {
                alert("이슈발생일이 해결목표일보다 이전입니다."); 
                return false;
            }else if($('#textModalIssueDate').val()>$('#textModalIssueCloseDate').val() && $('#textModalIssueCloseDate').val()!=''){
                alert("이슈발생일이 이슈해결일보다 이전입니다."); 
                return false;
            }
            
            if(!confirm("저장하시겠습니까?")) {
                return false;
            }
        },
        beforeSend : function(xhr){
            xhr.setRequestHeader("AJAX", true);
        },
        success: function(data){
             if(data.cnt > 0){
                alert("저장하였습니다.");
                
                $('#hiddenModalContactId').val(data.returnPK);	                
                var returnPkValue = $("input[name=hiddenModalContactId]").val();
                
                if(!returnPkValue){                	
                	if(pkNo){
                		returnPkValue = pkNo;
                	}else{
                		location.href= '/clientSatisfaction/viewClientIssueList.do';
                		return;
                	}
                }                
                location.href= '/clientSatisfaction/selectClientIssueDetail.do?pkNo='+returnPkValue ;
            	            	
             }else{
                alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
            }
             
        },
        complete: function(_pkNo) {
//        	var returnPkValue = $("input[name=hiddenModalContactId]").val();
//        	var modifiePkValue = '';
//        	location.href= '/clientSatisfaction/selectClientIssueDetail.do?pkNo='+returnPkValue ;
        },
        error: function(){
            //에러발생을 위한 code페이지
            alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
        }   
    });
    $('#formModalData').submit();
}

/**
 * 상세정보 입력란에 셋팅
 * @param rowData
 * @returns
 */
function fncSetData(rowData){
    
    $("#hiddenModalPK").val(rowData.ISSUE_ID);    
    $("#textModalSubject").val(rowData.ISSUE_SUBJECT);
    $("#textModalUpdateDate").val(rowData.SYS_UPDATE_DATE);
    $("#textModalIssueCreator").val(rowData.ISSUE_CREATOR);
    $("#selectModalIssueCategory").val(rowData.ISSUE_CATEGORY);
    
    // 고객명 셋팅
    //$("#textModalCustomerName").val(rowData.CUSTOMER_NAME);
    $("#hiddenModalCustomerId").val(rowData.CUSTOMER_ID);
    
    if(!isEmpty(rowData.CUSTOMER_ID)){
		var customerIdArr = rowData.CUSTOMER_ID.split(",");
		var customerNameArr = rowData.CUSTOMER_NAME.split(",");
		var customerCompanyArr = rowData.COMPANY_NAME.split(",");
		 
		$("#hiddenModalCustomerIdList").val(customerIdArr);
		for(var i=0; i<customerNameArr.length; i++){
			commonSearch.addCustomerId($('#formModalData #ulModalMarketMembersName'),  customerIdArr[i], customerNameArr[i], customerCompanyArr[i]);
		}
	}	
    
    // 영업대표 셋팅
//    $("#textModalSalesRepresentive").val(rowData.SALES_REPRESENTIVE_NAME);
    $("#textModalSalesRepresentive").hide();
    $("#hiddenModalSalesId").val(rowData.SALES_REPRESENTIVE_ID);
    $('#liModalSingleSalesRepresentive').before(
    		'<li class="value">'+
			'<span class="txt" id="'+ rowData.SALES_REPRESENTIVE_ID +'">'+ rowData.SALES_REPRESENTIVE_NAME+ ' '+ rowData.SALES_REPRESENTIVE_RANK + '</span>'+
			'<a href="javascript:void(0);" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalSalesRepresentive\',\'liModalSingleSalesRepresentive\',\'hiddenModalSalesId\');">'+
			'<i class="fa fa-times-circle"></i></a>'+
			'</li>'
    );
    
    // 이슈해결책임자 셋팅
//    $("#textModalSolveOwner").val(rowData.SOLVE_OWNER_NAME);
    $("#textModalSolveOwner").hide();
    $("#hiddenModalSolveOwnerId").val(rowData.SOLVE_OWNER);
    $('#liModalSingleSolveOwner').before(
    		'<li class="value">'+
			'<span class="txt" id="'+ rowData.SOLVE_OWNER +'">'+ rowData.SOLVE_OWNER_NAME+ ' '+ rowData.SOLVE_OWNER_RANK +'</span>'+
			'<a href="javascript:void(0);" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalSalesRepresentive\',\'liModalSingleSalesRepresentive\',\'hiddenModalSalesId\');">'+
			'<i class="fa fa-times-circle"></i></a>'+
			'</li>'
    );
    
    
    $("#textCommonSearchCompany").val(rowData.COMPANY_NAME);
    $("#textCommonSearchCompanyId, #hiddenModalCompanyId").val(rowData.COMPANY_ID);
    $("#textModalIssueDate").val(rowData.ISSUE_DATE);
    $("#textModalDueDate").val(rowData.DUE_DATE);
    $("#textareaModalIssueDetail").text(rowData.ISSUE_DETAIL);
    
    $("#textModalIssueCloseDate").val(rowData.ISSUE_CLOSE_DATE);
    $("#textareaModalSolvePlan").text(rowData.SOLVE_PLAN);
    $("#selectModalIssueStatus").val(rowData.ISSUE_STATUS);
    $("#selectModalSolveEvidenceYN").val(rowData.SOLVE_EVIDENCE_YN);
    $("#textareaSolveEvidenceDetail").text(rowData.SOLVE_EVIDENCE_DETAIL);
    
    // 이슈해결확인자 셋팅
//    $("#textModalIssueConfirmId").val(rowData.CONFIRM_NAME);
    $("#hiddenModalIssueConfirmId").val(rowData.ISSUE_CONFIRM_ID);	
    if(rowData.CONFIRM_NAME){
    	$('#liModalSingleIssueConfirmId').before(
        		'<li class="value">'+
    			'<span class="txt" id="'+ rowData.ISSUE_CONFIRM_ID +'">'+ rowData.CONFIRM_NAME +' '+ rowData.CONFIRM_RANK +'</span>'+
    			'<a href="javascript:void(0);" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalIssueConfirmId\',\'liModalSingleIssueConfirmId\',\'textModalIssueConfirmId\');">'+
    			'<i class="fa fa-times-circle"></i></a>'+
    			'</li>'
        );
    }    
    
}

/**
 * 상세정보 조회
 * @param _pkNo
 * @returns
 */
function updateDetail(_pkNo) {
    $.ajax({
        url : "/clientSatisfaction/selectClientIssueDetail.do",
        async : false,
        datatype : 'json',
        mtype: 'POST',
        data : {
            pkNo : _pkNo,
            datatype : "jsonview"
        },
        beforeSend : function(xhr){
            xhr.setRequestHeader("AJAX", true);
        },
        success : function(data){            
            var rowData = data.detail;
            
            fncSetData(rowData);
            
            var fileList = data.fileList;
            
            // 메일공유 자동완성 2018-08-31 공유된 사람 데이터에서 불러오는 거
			/*if(!isEmpty(shareMail)){
				var smList = '';
				var shareMailMemberId;
				var shareMailToMember;
				var shareMailToMail;
				var shareMailToPosition;
				for(var i=0; i<shareMail.length; i++){
					
					shareMailMemberId = shareMail[i].FROM_MEMBER_ID;
					shareMailToMember = shareMail[i].HAN_NAME;
					shareMailToMail = shareMail[i].EMAIL;
					shareMailToPosition = shareMail[i].POSITION_TYPE;
					
					
					commonSearch.addMultipleMailShareMember( $('#formModalData #hiddenModalMemberList'), $('#formModalData #ulMultipleMailShareMember'), shareMailMemberId, shareMailToMember, shareMailToMail, shareMailToPosition );
					if(i>0) smList = smList + ', ';
					smList = smList + shareMailToMember;
				}
			}*/
            
            //고객컨택 연동
            /*
            $("#relationContact").html("");
            if(!isEmpty(rowData.EVENT_ID)){
                $("#relationContact").html('<a href="/clientSalesActive/viewClientContactList.do?event_id='+rowData.EVENT_ID+'" target="_new" class="oppStatusColor oppStatusColor-complete">바로가기</a>');
            }else{
                $("#relationContact").html('-');
            }
            */
            
            //파일
            /*
            if(!isEmpty(fileList)){
                $("#divFileUploadList span").remove();
                for(var i=0; i<fileList.length; i++){
                    $("#divFileUploadList").append('<span><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=4"><i class="fa fa-file-'+checkExtension(fileList[i].FILE_TYPE)+'-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="modal.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></span>');
                }
            }else{
                $("#divFileUploadList").html('<span class="blank-ment">선택된 파일이 없습니다</span>');
            }
            */
        },
        complete : function(){
        	//location.href= '/clientSatisfaction/selectClientIssueDetail.do?pkNo='+_pkNo;
        }
    });
    
}

$(document).ready(function() {
	
    // 고객이슈 목록
    $("#viewClientIssueList").on("click", function(e) {
        location.href = '/clientSatisfaction/viewClientIssueList.do';
        e.preventDefault();
    });        

    // 저장 
    $("#insertClientIssue").on("click", function(e) {
        insertClientIssue(1);
        e.preventDefault();
    });          
 
    // 저장 및 공유
    $("#sharedClientIssue").on("click", function(e) {
        insertClientIssue(2);
        e.preventDefault();
    });  
    
    // 메일공유 직원 검색
    $("#member_search").on("click", function(e) {
        commonSearch.multipleMemberPop();
        e.preventDefault();
    });  

    pageInit(); // 페이지 초기화 구성
    
    if(mode == 'upd'){
    	updateDetail(pkNo);
    	
    	// 이슈해결계획 불러오기
    	action.actGetList("/clientSatisfaction/selectSolvePlanIssue.do", $("#hiddenModalPK").val());
    	
    	// 탭 설정
		fncSelectTab(tabNo);	
    }else{
    	action.actAdd();
    }
});
    