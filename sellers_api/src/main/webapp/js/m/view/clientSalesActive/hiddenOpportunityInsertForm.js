   
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
 * validate
 * @returns
 */
function validate () {
    $("#formModalData").validate({ // joinForm에 validate를 적용
        ignore: "", 
        rules : {
            textModalSubject : {
                required : true,
                maxlength : 100
            },
            /* selectModalCategory : {
                required : true
            }, */
            hiddenModalSalesId : {
                required : true
            },
            // required는 필수, rangelength는 글자 개수(1~10개 사이)
            hiddenModalCompanyId : {
                required : true
            },
            hiddenModalCustomerId : {
                required : true
            },
            textModalAmount : {
                required : true
            }
        },
        messages : { // rules에 해당하는 메시지를 지정하는 속성
            textModalSubject : {
                required : "제목을 입력하세요.",
                maxlength:"100글자 이하여야 합니다" 
            },
            /* selectModalCategory : {
                required : "잠재기회 영역을 선택하세요." 
                // 이와 같이 규칙이름과 메시지를 작성
                //rangelength:"1글자 이상, 10글자 이하여야 합니다.",
                //digits:"숫자만 입력해 주세요."
            }, */
            hiddenModalSalesId : {
                required : "영업대표를 입력하세요."
            },
            hiddenModalCompanyId : {
                required : "매출처를 선택하세요."
            //rangelength:"1글자 이상, 30글자 이하여야 합니다"
            },
            hiddenModalCustomerId : {
                required : "End User를 입력해 주세요."
            },
            textModalAmount : {
                required : "예상규모를 입력해 주세요."
            }
        },
        errorPlacement : function(error, element) {
        	
        	fncSelectTab(1);
        	
            if($(element).prop("id") == "hiddenModalCompanyId") {
                $("#ulModalCompanyName").after(error);
                location.href = "#ulModalCompanyName";
            } else if($(element).prop("id") == "hiddenModalCustomerId") {
                $("#ulModalCustomerName").after(error);
                location.href = "#ulModalCustomerName";
            } else if($(element).prop("id") == "hiddenModalSalesId") {
                $("#ulModalOppOwner").after(error);
                location.href = "#ulModalOppOwner";
            }else {
                error.insertAfter(element); // default error placement.
            }
        }
    });       
}

/**
 * 초기 페이지 구성에 필요한 정보를 세팅한다.
 * @returns
 */
function pageInit() {
    //유효성 체크
    validate();
}

/**
 * insert
 * @param shareFlag
 * @param contactPK
 * @returns
 */
function insertHiddenOpportunity(shareFlag,contactPK) {
    var url = "/clientSalesActive/insertHiddenOpportunity.do";
    
    if(mode == 'upd'){
    	url = "/clientSalesActive/updateHiddenOpportunity.do";
    }  
    
    $("#hiddenModalAmount").val(uncomma($("#textModalAmount").val()));
    $('#formModalData').ajaxForm({
        url : url,
        async : true,
        data : {
        	hiddenActionPlan : JSON.stringify(action.actSubmitList()),
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
        	
            //if(!list.compareFlag){
                if(!confirm("저장하시겠습니까?")){
                    return false;
                }
            //}
        },
        success: function(data){
             if(data.cnt > 0){
                alert("저장하였습니다.");
               	//alert(data.returnPK);
                $('#hiddenModalContactId').val(data.returnPK);
				//console.log($('#hiddenModalContactId').val());
                
                if(mode == 'upd'){
                	$('#hiddenModalContactId').val($('#hiddenModalPK').val());
                }
                
            }else{
                alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
            }
        },
        complete: function() {
        	var issueFlag1 = $("input[name=issueFlag]").val();
        	var oppFlag1 = $("input[name=oppFlag]").val();
        	var returnPkValue = $('#hiddenModalContactId').val();
        	        	
        	if (issueFlag1 != "true" && oppFlag1 == "true") { // 고객컨택 -> 잠재영업 종료        		
				location.href = '/clientSalesActive/selectHiddenOpportunityDetail.do?pkNo='+returnPkValue;	
			}else if (issueFlag1 == "true" && oppFlag1 =="true") { //둘다 체크
				alert("고객이슈 입력으로 이동합니다.");
				returnFollowUpAction(issueFlag, '/clientSatisfaction/clientIssueInsertForm.do');
			}else{
				//재영업기회 단일 등록
				location.href = '/clientSalesActive/selectHiddenOpportunityDetail.do?pkNo='+returnPkValue;
			}
        },
        error: function(){
            //에러발생을 위한 code페이지
            alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
        }   
    });      
    $('#formModalData').submit();
}

/**
 * 수정
 * @param _pkNo
 * @returns
 */
function updateDetail(_pkNo) {

    //상세정보를 가져와서 수정정보에 셋팅
    $.ajax({
        url : "/clientSalesActive/selectHiddenOpportunityDetail.do",
        async : false,
        datatype : 'json',
        mtype: 'POST',
        data : {
            pkNo : _pkNo,
            datatype : "jsonview"
        },
        beforeSend : function(){
        },
        success : function(data){
            var rowData = data.detail;
            var fileList = data.fileList;
            var shareMail = data.shareMail;
            
            $("#hiddenModalPK").val(rowData.OPPORTUNITY_HIDDEN_ID);
            
            $("#textModalSubject").val(rowData.SUBJECT);
            //$("#divModalNameAndCreateDate").html("작성자 : "+rowData.HAN_NAME+"/ 작성일 : "+rowData.SYS_REGISTER_DATE);
            
            // 매출처 셋팅
            if(rowData.COMPANY_NAME){
            	$("#textCommonSearchCompany").hide();
            	$('#liModalCompanyName').before(
		    		'<li class="value">'+
					'<span class="txt" id="'+ rowData.COMPANY_ID +'">'+ rowData.COMPANY_NAME + '</span>'+
					'<a href="javascript:void(0);" class="remove" onclick="commonSearch.removeSingleCompany(this,'+'hiddenModalCompanyId'+');">'+
					'<i class="fa fa-times-circle"></i></a>'+
					'</li>'
        	    );
            	$("#textCommonSearchCompanyId").val(rowData.COMPANY_ID);
                $("#hiddenModalCompanyId").val(rowData.COMPANY_ID);
            }            
            
            // End User
            if(rowData.CUSTOMER_NAME){            	
            	$("#textModalCustomerName").hide();
            	$('#liModalCustomerName').before(
		    		'<li class="value">'+
					'<span class="txt" id="'+ rowData.CUSTOMER_ID +'">'+ rowData.CUSTOMER_NAME+ '</span>'+
					'<a href="javascript:void(0);" class="remove" onclick="commonSearch.removeSingleCompany(this,'+'hiddenModalCustomerId'+');">'+
					'<i class="fa fa-times-circle"></i></a>'+
					'</li>'
        	    );
            	$("#hiddenModalCustomerId").val(rowData.CUSTOMER_ID);
            }
            
            // 영업대표
            var position = rowData.SALESMAN_POSITION;
            if(!position){
            	position = '';
            }else{
            	position = ' / '+position;
            }
            
            $("#textModalOppOwner").hide();
            $("#hiddenModalSalesId").val(rowData.SALESMAN_ID);
            $('#liModalOppOwner').before(
            		'<li class="value">'+
        			'<span class="txt" id="'+ rowData.SALESMAN_ID +'">'+ rowData.SALESMAN_NAME + position + '</span>'+
        			'<a href="javascript:void(0);" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalOppOwner\',\'liModalOppOwner\',\'hiddenModalSalesId\');">'+
        			'<i class="fa fa-times-circle"></i></a>'+
        			'</li>'
            );
            
            $("#textModalCustomerRank").val(rowData.CUSTOMER_POSITION);
            $("#selectModalCategory").val(rowData.CATEGORY);
            $("#textModalDivision").val(rowData.SALESMAN_DIVISION);
            $("#hiddenModalContactId").val(rowData.EVENT_ID);
            //$("#textModalAmount").val(String(rowData.OPPORTUNITY_AMOUNT).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
            /*$("#textModalAmount").val(rowData.OPPORTUNITY_AMOUNT / 1000000);*/
            $("#textModalAmount").val(rowData.OPPORTUNITY_AMOUNT.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
            $("#textModalSalesChangeDate").val(rowData.SALES_CHANGE_DATE);
            $('[name="divRelation"]').show();
            //$('#divModalResult').html('');
            
            if(!isEmpty(rowData.OPPORTUNITY_ID)){
//                $('#divModalResult').append('<a href="javascript:void(0);" class="oppStatusColor oppStatusColor-complete" onClick="goOpportunity('+rowData.OPPORTUNITY_HIDDEN_ID+','+rowData.OPPORTUNITY_ID+');">전환완료</a>');
                $('#hiddenRelationOpportunityId').val(rowData.OPPORTUNITY_ID);
            }else{
//                $('#divModalResult').append('<a href="javascript:void(0);" class="oppStatusColor oppStatusColor" onClick="goOpportunity('+rowData.OPPORTUNITY_HIDDEN_ID+',\'\');">전환하기</a>');
                $('#hiddenRelationOpportunityId').val(null);
            }
            
            //고객컨택 연동
            $("#relationContact").html("");
            if(!isEmpty(rowData.EVENT_ID)){
                $("#relationContact").html('<a href="/clientSalesActive/viewClientContactList.do?event_id='+rowData.EVENT_ID+'" target="_new" class="oppStatusColor oppStatusColor-complete">바로가기</a>');
            }else{
                $("#relationContact").html('-');
            }
            
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
            
            $("#textareaModalDetail").val(rowData.DETAIL_CONENTS);
            
            //$("#buttonModalDelete").show();
            
            $("h2.modal-title").html(rowData.SUBJECT);
            //$("small.font-bold").css('display','');
            //$("#buttonModalSubmit").html("저장하기");
            
            //modal.drawHiddenActionPlan();
            //modal.actionPlanReload();
            
            //$("#divModalCoachingTalk").hide(); //코톡 숨기기
            
            //$("#myModal1").modal();
            
            //list.compare_before = $("#formModalData").serialize();
            
            //코톡알림 바로가기시 코톡창 바로 보이게 설정.
            //if(list.coaching_talk == 'Y'){
            //    $("#buttonModalCoachingTalkView").click();
            //}
            //location.href = '/clientSalesActive/selectHiddenOpportunityDetail.do?pkNo='+_pkNo;
        },
        complete : function(){
        	//var pkValue = _pkNo;
			//location.href = '/clientSalesActive/selectHiddenOpportunityDetail.do?pkNo='+_pkNo;
            //$.ajaxLoadingHide();
        }
    });       
}    

/**
 * 디테일
 * @param pkNo
 * @param opportunity_id
 * @returns
 */
function goOpportunity(pkNo, opportunity_id){
    if(!isEmpty(opportunity_id)){
        $("#formRedirectOpportunity #opportunity_id").val(opportunity_id);
    }else{
        //상세보기로 gogo.
        $.ajax({
            url : "/clientSalesActive/selectHiddenOpportunityDetail.do",
            async : false,
            datatype : 'json',
            mtype: 'POST',
            data : {
                pkNo : pkNo,
                datatype : "jsonView"
            },
            beforeSend : function(){
                //$.ajaxLoadingShow();
            },
            success : function(data){
                var rowData = data.detail;
                
                $("#formRedirectOpportunity #returnOpportunityhiddenId").val(rowData.OPPORTUNITY_HIDDEN_ID);
                $("#formRedirectOpportunity #returnCompanyId").val(rowData.COMPANY_ID);
                $("#formRedirectOpportunity #returnCompanyName").val(rowData.COMPANY_NAME);
                $("#formRedirectOpportunity #returnCustomerName").val(rowData.CUSTOMER_NAME);
                $("#formRedirectOpportunity #returnCustomerId").val(rowData.CUSTOMER_ID);
                $("#formRedirectOpportunity #returnCustomerRank").val(rowData.CUSTOMER_POSITION);
                $("#formRedirectOpportunity #returnSubject").val(rowData.SUBJECT);
                $("#formRedirectOpportunity #returnOpportunityamount").val(String(rowData.OPPORTUNITY_AMOUNT).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
            },
            complete : function(){
                //$.ajaxLoadingHide();
            }
        });
    }
    var frm = document.formRedirectOpportunity; 
    frm.target  = "_new"; 
    frm.action  = "/clientSalesActive/hiddenOpportunityInsertForm.do";
    frm.submit();   
}

/**
 * @param contactPK
 * @param url
 * @returns
 */
function returnFollowUpAction(contactPK, url) {
	$("#formFollow #contactPK").val(contactPK);
	
	$("#formFollow #returnContactId").val($("#formModalData #hiddenModalContactId").val());
    $("#formFollow #returnCompanyId").val($("#formModalData #hiddenModalCompanyId").val());
    $("#formFollow #returnCompanyName").val($("#formModalData #textCommonSearchCompany").val());
    $("#formFollow #returnCustomerName").val($("#formModalData #textModalCustomerName").val());
    $("#formFollow #returnCustomerId").val($("#formModalData #hiddenModalCustomerId").val());
    $("#formFollow #returnCustomerRank").val($("#formModalData #textModalCustomerRank").val());
    
    $("#formFollow").attr("action",url);
    $("#formFollow").submit();
}
    
$(document).ready(function() {
    pageInit(); // 페이지 초기화 구성

    // 메일공유 직원 검색
    $("#member_search").on("click", function(e) {
        commonSearch.multipleMemberPop();
        e.preventDefault();
    });  
    
    // 고객컨택내용 목록
    $("#goList").on("click", function(e) {
        location.href = '/clientSalesActive/viewHiddenOpportunityList.do';
        e.preventDefault();
    });
    
    // 저장 
    $("#goInsert").on("click", function(e) {
    	insertHiddenOpportunity(1);
            e.preventDefault();
        });          
 
    // 저장 및 공유
    $("#goShared").on("click", function(e) {
    	insertHiddenOpportunity(2);
        e.preventDefault();
    });

    commonSearch.singleCompany($('#formModalData #textCommonSearchCompany'), $('#formModalData #liModalCompanyName'), $('#formModalData #hiddenModalCompanyId'), $('#formModalData #textCommonSearchCompanyId'));
    commonSearch.singleCompany($('#formModalData #textModalCustomerName'), $('#formModalData #liModalCustomerName'), $('#formModalData #hiddenModalCustomerId'));
    commonSearch.singleMember($('#formModalData #textModalOppOwner'), $('#formModalData #liModalOppOwner'), $('#formModalData #hiddenModalSalesId'));
    commonSearch.multipleMailShareMember($("#formModalData #textCommonSearchMember"), $('#formModalData #hiddenModalMemberList'), $('#formModalData #ulMultipleMailShareMember'));
        
    if(mode == 'upd'){
    	updateDetail(pkNo);
    	
    	action.actGetList("/clientSalesActive/gridActionPlanHiddenOpportunity.do", $("#hiddenModalPK").val());
    	
    	// 탭 설정
		fncSelectTab(tabNo);	
    }else{
    	action.actAdd();
    }    
});
    