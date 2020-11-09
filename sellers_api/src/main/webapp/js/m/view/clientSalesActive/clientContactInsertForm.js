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
	commonSearch.member($('#formModalData #textModalFollowUpManager'), $('#formModalData #hiddenModalFollowManagerId'));
	commonSearch.multipleMailShareMember($("#formModalData #textMultipleMailShareMember"), $('#hiddenModalMemberList'), $('#formModalData #ulMultipleMailShareMember'));
	
	if(mode == 'ins'){
		$("#textModalEventDate").val(commonDate.year+"-"+commonDate.month+"-"+commonDate.day.trim());
		
		//컨택시간
		var date = new Date();
		var hour = date.getHours()>9 ? ''+date.getHours() : '0'+date.getHours();
		var min = date.getMinutes()>9 ? ''+date.getMinutes() : '0'+date.getMinutes();
		if(parseInt(min)==0) {
			$("#selectModalStartDateTime").val(hour+":00");
			hour = (date.getHours()+1)>9 ? ''+(date.getHours()+1) : '0'+(date.getHours()+1);
			$("#selectModalEndDateTime").val(hour+":00");
		}else if(parseInt(min)>0 && parseInt(min)<=30) {
			$("#selectModalStartDateTime").val(hour+":30");
			hour = (date.getHours()+1)>9 ? ''+(date.getHours()+1) : '0'+(date.getHours()+1);
			$("#selectModalEndDateTime").val(hour+":30");
		}else if(parseInt(min)>30) {
			hour = (date.getHours()+1)>9 ? ''+(date.getHours()+1) : '0'+(date.getHours()+1);
			$("#selectModalStartDateTime").val(hour+":00");
			hour = (date.getHours()+2)>9 ? ''+(date.getHours()+2) : '0'+(date.getHours()+2);
			$("#selectModalEndDateTime").val(hour+":00");
		}
	}
	
	//직원 검색
	/*
	$('#textMultipleMailShareMember').on('keydown', function(key) {
		if (key.keyCode == 13) {//키가 13이면 실행 (엔터는 13)
			commonSearch.multipleMemberPop();
		}
	});	*/
}


function changeEndDate () {
	var startDateTime = $("#selectModalStartDateTime").val();
	
	var split = startDateTime.split(":");
	var endHour = "";
	(parseInt(split[0],"10")+1) > 9 ? endHour = parseInt(split[0],"10")+1 : endHour = "0"+(parseInt(split[0],"10")+1);
	$("#selectModalEndDateTime").val(endHour+":"+split[1]);
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
 * 잠재영업기회 체크 확인
 * @returns
 */
function selectSalesOpp() {
	var checkFlag = $("input[name='checkSalesOpp']").prop("checked");
	if (checkFlag) {
		$("input[name='checkSalesOpp']").prop("checked", false);
	} else {
		$("input[name='checkSalesOpp']").prop("checked", true);
	}
}

/**
 * 이슈 체크 확인
 * @returns
 */
function selectIssue() {
	var checkFlag = $("input[name='checkIssue']").prop("checked");
	if (checkFlag) {
		$("input[name='checkIssue']").prop("checked", false);
	} else {
		$("input[name='checkIssue']").prop("checked", true);
	}
}

// 고객사 체크
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
		ignore : "",
		rules : {
			textModalSubject : {
				required : true,
				maxlength : 100
			},
			textModalEventDate : {
				required : true,
				maxlength : 10
			},
			selectModalCategory : {
				required : true
			},
			selectModalStartDateTime : {
				required : true
			},
			selectModalEndDateTime : {
				required : true
			},
			hiddenModalCustomerIdList : {
				required : true
			}
		},
		messages : { // rules에 해당하는 메시지를 지정하는 속성
			textModalSubject : {
				required : "컨택목적을 입력하세요.",
				maxlength : "100글자 이하여야 합니다"
			},
			textModalEventDate : {
				required : "컨택일를 선택해 주세요.",
				maxlength : 10
			},
			selectModalCategory : {
				required : "컨택방법을 선택하세요." // 이와 같이 규칙이름과 메시지를 작성
			},
			selectModalStartDateTime : {
				required : "컨택시간을 선택해 주세요."
			},
			selectModalEndDateTime : {
				required : "컨택시간을 선택해 주세요."
			},
			hiddenModalCustomerIdList : {
				required : "고객명을 검색해 주세요."
			}
		},
		errorPlacement : function(error, element) {
			fncSelectTab(1);
			console.log($(element).prop("id") +"dd");
			if($(element).prop("id") == "hiddenModalCustomerIdList") {
		        $("#ulMultipleClient").after(error);
		        location.href = "#ulMultipleClient";
		    }else{
		        error.insertAfter(element); // default error placement.
		    }
		}
	})
}

/**
 * insert
 * @param shareFlag
 * @returns
 */
function insertClientContact(shareFlag) {
	var url = "/clientSalesActive/insertClientContact.do";
	
	if(mode == 'upd'){
		url = "/clientSalesActive/updateClientContact.do";
	}
	
	// 잠재영업기회 or 이슈 체크여부
	var oppFlag = $("input[name='checkSalesOpp']").prop("checked");
	var issueFlag = $("input[name='checkIssue']").prop("checked");
	
	// 고객명 리스트
	if(!isEmpty($("#hiddenModalCustomerIdList").val())){
		var ccList = '';
		$('ul#ulMultipleClient li').each(function(idx, val){
			if(idx>0 && idx<$('ul#ulMultipleClient li').length-1) ccList = ccList + ', ';
			if(idx<$('ul#ulMultipleClient li').length-1 && !isEmpty($('ul#ulMultipleClient li').eq(idx)["0"].innerText)) ccList += $('ul#ulMultipleClient li').eq(idx)["0"].innerText;
		});
		$("#hiddenModalCcList").val(ccList);
	}
	
	$('#formModalData').ajaxForm({
		url : url,
		async : true,
		data : {
			contactFollowUpAction : JSON.stringify(fua.fuaSubmitList()),
			shareFlag : function() {
				if (shareFlag == 1) {
					return false;
				} else {
					return true;
				}
			}
		},
		beforeSubmit : function(data, form, option) {
			if(!fua.fuaValid) return false;
			
			if (!oppFlag && !issueFlag) { // 셋다 노 체크
				if (!confirm("추가 입력사항이 선택되지 않았습니다.\n그래도 저장하시겠습니까?")) {
					return false;
				}
			} else {
				//if(!list.compareFlag){
				if (!confirm("저장하시겠습니까?")) {
					return false;
				}
				//}
			}
		},
		success : function(data) {
			if (data.cnt > 0) {
				alert("저장하였습니다.");
				$('#contactPK').val(data.returnPK);
				
				var returnPkValue = $("input[name=contactPK]").val();
				
				if(mode == 'upd'){
					returnPkValue = $('#hiddenModalPK').val();
				}
				
				if (!oppFlag && !issueFlag) { // 둘다 노 체크s
					if(returnPkValue == ''){
						window.location.href = '/clientSalesActive/viewClientContactList.do';
						return false;
					}
					location.href = '/clientSalesActive/selectContactDetail.do?pkNo='+returnPkValue;
				} else if (oppFlag && issueFlag) { //둘다 체크
					alert("잠재영업기회 입력으로 이동합니다.");
					returnFollowUpAction(oppFlag, issueFlag, '/clientSalesActive/hiddenOpportunityInsertForm.do');
				} else if (oppFlag && !issueFlag) { //잠재영업기회만 체크
					alert("잠재영업기회 입력으로 이동합니다.");
					returnFollowUpAction(oppFlag, issueFlag, '/clientSalesActive/hiddenOpportunityInsertForm.do');
				} else if (!oppFlag && issueFlag) { //이슈만 체크 체크
					alert("이슈 입력으로 이동합니다.");
					returnFollowUpAction(oppFlag, issueFlag, '/clientSatisfaction/clientIssueInsertForm.do');
				}
			} else {
				alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
			}
		},
		complete : function() {
		},
		error : function() {
			//에러발생을 위한 code페이지
			alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
		}
	});
	$('#formModalData').submit();
}

/**
 * return followUpAction
 * @param oppFlag
 * @param issueFlag
 * @param url
 * @returns
 */
function returnFollowUpAction(oppFlag, issueFlag, url) {
	//$("#formFollow #contactPK").val(modal.contactPK);
	$("#formFollow #issueFlag").val(issueFlag);
	$("#formFollow #oppFlag").val(oppFlag);

	$("#formFollow #returnCompanyId").val($("#formModalData #hiddenModalCompanyId").val());
	$("#formFollow #returnCompanyName").val($("#formModalData #textCommonSearchCompany").val());
	$("#formFollow #returnCustomerName").val($("#formModalData #hiddenModalCustomerNameList").val());
	$("#formFollow #returnCustomerId").val($("#formModalData #hiddenModalCustomerIdList").val());
	$("#formFollow #returnCustomerRank").val($("#formModalData #hiddenModalCustomerRList").val());

	$("#formFollow").attr("action", url);
	$("#formFollow").submit();
}

/**
 * 상세정보 셋팅
 * @param _object
 * @returns
 */
function fncSetData(rowData){
	$("#formModalData #hiddenModalMemberList").val("");
	$("#hiddenModalPK").val(rowData.EVENT_ID);

	$("#textModalSubject").val(rowData.EVENT_SUBJECT);
	$("#divModalNameAndCreateDate").html("보고자 : " + rowData.HAN_NAME + "/ 작성일 : "+ rowData.SYS_REGISTER_DATE);
	$("#textModalEventDate").val(rowData.EVENT_DATE);
	$("#selectModalStartDateTime").val(rowData.EVENT_START_TIME);
	$("#selectModalEndDateTime").val(rowData.EVENT_END_TIME);
	$("#selectModalCategory").val(rowData.EVENT_CATEGORY);
	
//	$("#hiddenModalCustomerIdList").val(rowData.CUSTOMER_ID);
//	$("#textModalCustomerName").val(rowData.CUSTOMER_NAME);
//	$("#textModalClientRank").val(rowData.CUSTOMER_RANK);
	
	if(!isEmpty(rowData.CUSTOMER_ID)){
		var customerIdArr = rowData.CUSTOMER_ID.split(",");
		var customerNameArr = rowData.CUSTOMER_NAME.split(",");
		var customerCompanyArr = rowData.COMPANY_NAME.split(",");
		 
		$("#hiddenModalCustomerIdList").val(customerIdArr);
		for(var i=0; i<customerNameArr.length; i++){
			commonSearch.addCustomerId($('#formModalData #ulModalMarketMembersName'),  customerIdArr[i], customerNameArr[i], customerCompanyArr[i]);
		}
	}	
	
	$("#hiddenModalPK").val(rowData.EVENT_ID);
	$("#textareaModalEventContents").val(rowData.EVENT_CONTENTS);
	$("#hiddenModalCompanyId").val(rowData.COMPANY_ID);
	$("#textCommonSearchCompanyId").val(rowData.COMPANY_ID);
	$("#textCommonSearchCompany").val(rowData.COMPANY_NAME);
	$("[name='divRelation']").show();
	$("[name='checkOppIssue']").hide();
		
	if (rowData.CHECK_INFORMATION == "Y") {
		$("input[name='checkInformation']").prop("checked", true);
		$("input[name='checkInformation']").val("Y");
	} else {
		$("input[name='checkInformation']").prop("checked", false);
		$("input[name='checkInformation']").val("");
	}
	
	if (rowData.CHECK_SALESOPP == "Y") {
		$("input[name='checkSalesOpp']").prop("checked", true);
		$("input[name='checkSalesOpp']").val("Y");
	} else {
		$("input[name='checkSalesOpp']").prop("checked", false);
		$("input[name='checkSalesOpp']").val("N");
	}
	
	if (rowData.CHECK_ISSUE == "Y") {
		$("input[name='checkIssue']").prop("checked", true);
		$("input[name='checkIssue']").val("Y");
	} else {
		$("input[name='checkIssue']").prop("checked", false);
		$("input[name='checkIssue']").val("N");
	}

	//잠재영업기회 연동
	$("#relationHiddenOpp").html("");
	if (!isEmpty(rowData.OPPORTUNITY_HIDDEN_ID)) {
		//$("#relationHiddenOpp").html('<a href="/clientSalesActive/viewHiddenOpportunityList.do?opportunity_hidden_id='+rowData.OPPORTUNITY_HIDDEN_ID+'" target="_new" class="oppStatusColor oppStatusColor-complete">바로가기</a>');
		$("#relationHiddenOpp")
				.html(
						'<a href="/clientSalesActive/viewHiddenOpportunityList.do?opportunity_hidden_id='
								+ rowData.OPPORTUNITY_HIDDEN_ID
								+ '" target="_new" class="oppStatusColor oppStatusColor-complete btn_quick">바로가기</a>');
	} else {
		$("#relationHiddenOpp").html('-');
	}

	//이슈 연동
	$('#relationClientIssue').html('');
	if (!isEmpty(rowData.ISSUE_ID)) {
		//$("#relationClientIssue").html('<a href="/clientSatisfaction/viewClientIssueList.do?issue_id='+rowData.ISSUE_ID+'" target="_new" class="oppStatusColor oppStatusColor-complete">바로가기</a>');
		$("#relationClientIssue")
				.html(
						'<a href="/clientSatisfaction/viewClientIssueList.do?issue_id='
								+ rowData.ISSUE_ID
								+ '" target="_new" class="oppStatusColor oppStatusColor-complete btn_quick">바로가기</a>');
	} else {
		$('#relationClientIssue').html('-');
	}
}

/**
 * 상세정보를 가져와서 수정정보에 셋팅
 * @param _pkNo
 * @returns
 */
function updateDetail(_pkNo) {
	$.ajax({
		url : '/clientSalesActive/selectContactDetail.do',
		async : false,
		datatype : 'json',
		mtype : 'post',
		data : {
			pkNo : _pkNo,
			datatype : 'jsonview'
		},
		beforeSend : function() {
		},
		success : function(data) {
			var rowData = data.detail;
			
			fncSetData(rowData);
			
			var fileList = data.fileList;
			var shareMail = data.shareMail;
						
			// 메일공유 자동완성 2018-08-31 공유된 사람 데이터에서 불러오는 거
			if(!isEmpty(shareMail)){
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
			}

			//파일
			/*
			commonFile.reset();
			if(!isEmpty(fileList)){
			    $("#divFileUploadList span").remove();
			    for(var i=0; i<fileList.length; i++){
			        $("#divFileUploadList").append('<span style="padding-left:5px;"><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=3"><i class="fa fa-file-'+commonCheckExtension(fileList[i].FILE_TYPE)+'-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="modal.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></span>');
			    }
			}else{
			    $("#divFileUploadList").html('<span class="blank-ment">선택된 파일이 없습니다</span>');
			}
			 */

			//$("h4.modal-title").html(rowData.EVENT_SUBJECT);
			//$("small.font-bold").css('display','');
			//$("#buttonModalSubmit").html("저장하기");
			//modal.drawContactActionPlan();
			//modal.actionPlanReload();
			//$("#myModal1").modal();
			//list.compare_before = $("#formModalData").serialize();
		},
		complete : function() {
			/* var pkValue = _pkNo;
			location.href = '/clientSalesActive/selectContactDetail.do?pkNo='+pkValue; */
			//$.ajaxLoadingHide();
		}
	});
}

$(document).ready(function() {	
	// 고객컨택내용 목록
	$("#viewClientContactList").on("click", function(e) {
		location.href = '/clientSalesActive/viewClientContactList.do';
		e.preventDefault();
	});

	// 잠재영업기회 선택체크
	$("#selectSalesOpp").on("click", function(e) {
		selectSalesOpp();
		e.preventDefault();
	});

	// 이슈 선택 체크 
	$("#selectIssue").on("click", function(e) {
		selectIssue();
		e.preventDefault();
	});

	// 저장 
	$("#insertClientContact").on("click", function(e) {
		
		// 메일공유 체크
		var shareFlag = 1;
		
		if($('#hiddenModalMemberList').val().length > 0){
			shareFlag = 2;
		}
		
		insertClientContact(shareFlag);
		e.preventDefault();
	});

	/*// 저장 및 공유
	$("#sharedClientContact").on("click", function(e) {
		insertClientContact(2);
		e.preventDefault();
	});*/

	pageInit(); // 페이지 초기화 구성

	if(mode == 'upd'){
		updateDetail(pkNo);
		fua.fuaGetList("/clientSalesActive/gridActionPlanContact.do", $("#hiddenModalPK").val());
		
		// 탭 설정
		fncSelectTab(tabNo);				
	}else{
		fua.fuaAdd();
	}
});