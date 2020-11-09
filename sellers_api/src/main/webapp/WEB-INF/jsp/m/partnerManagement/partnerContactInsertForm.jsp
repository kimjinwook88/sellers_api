<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
<title>파트너컨택</title>

    <link href="${pageContext.request.contextPath}/css/m/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/font-awesome/m/css/font-awesome.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/m/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/m/jqueryui/jquery-ui.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/js/m/plugins/autocomplete/jquery.auto-complete.css" rel="stylesheet">


</head>

<body class="gray_bg" onload="tabmenuLiWidth();">

<div class="container_pg">

    

    <article class="">
        <div class="title_pg ta_c">
            <c:choose>
                <c:when test="${param.mode eq 'ins'}">
                    <h2 class="modal-title">파트너컨택 신규등록</h2>
                </c:when>
                <c:otherwise>
                    <h2 class="modal-title">파트너컨택 수정</h2>
                </c:otherwise>
            </c:choose>
            <a href="javascript:void(0);" class="btn_back" onclick="window.history.back(); return false;">back</a>
        </div>

        <div class="pg_cont pd_t20">
            <form class="form-horizontal" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">
                <!-- <div class="guideBox">모바일에서는 기본정보만 입력이 가능하며, 세부정보는 PC에서 입력해주세요.</div> -->
    
                <!-- 기본정보 -->
                <div class="cont1 pd_t10">
    
                    <div class="form_input mg_b20">
                        <label class="">제목 <span style="color:red;">*</span></label>
                        <input type="text" placeholder="" class="form_control" id="textModalSubject" name="textModalSubject"/>
                    </div>
    
                     <div class="form_input mg_b20">
                        <label class="">파트너사</label>
                        <div class="search_input_after">
						<ul class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
							<li class="input-container flexdatalist-multiple-value pos-rel" id="ulMultiplePartner" name="ulMultiplePartner">
								<div class="pos-rel">
									<input type="text" class="form-control" id="textCommonSearchPartner" name="textCommonSearchPartner" placeholder="파트너사를 검색해 주세요." autocomplete="off"/>
								</div>
							</li>
						</ul>

                        </div>
                    </div>
                    
                    <div class="form_input mg_b20">
                        <div class="pos-rel">
                            <label class="">파트너사 ID</label>
                            <input type="text" class="form_control" id="textCommonSearchCompanyId" name="textCommonSearchCompanyId" placeholder="고객사를 검색해 주세요." autocomplete="off" readonly="readonly"/>
                            
                        </div>
                    </div>
                    
                    
    
                    <div class="form_input mg_b20">
                        <div class="pos-rel">
                            <label class="">파트너명 <span style="color:red;">*</span></label>
                            <ul  class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
								<li class="input-container flexdatalist-multiple-value pos-rel" id="liMultiplePartner" name="liMultiplePartner">
									<div class="pos-rel">
									<input type="text" class="form-control" id="textModalCustomerName" name="textModalCustomerName" placeholder="파트너명을 검색해 주세요." autocomplete="off"/>
									</div>
								</li>
							</ul>
                            <!-- <input type="text" class="form_control" id="textModalCustomerName" name="textModalCustomerName" placeholder="고객명를 검색해 주세요." autocomplete="off"/> -->
                        </div>
                    </div>
    
    				<div class="form_input mg_b20">
                        <label>컨택 방법</label>
                        <select class="form_control" id="contactMethod" name="contactMethod" onchange="document.getElementById('selectModalCategory').value = this.options[this.selectedIndex].value">
                        	<option value="">카테고리를 선택해주세요</option>
                            <option value="방문">방문</option>
                            <option value="이메일">E-mail</option>
                            <option value="SNS">SNS</option>
                            <option value="마케팅">마케팅</option>
                            <option value="전화">전화</option>
                        </select>
                    </div>
                    
                    <input type="hidden" class="form_control" id="selectModalCategory" name="selectModalCategory" value="" />
                    
                    <div class="form_input mg_b20">
                        <div class="pos-rel">
                            <label class="">컨택 일자 <span style="color:red;">*</span></label>
                            <input type="date" class="form_control" id="textModalEventDate" name="textModalEventDate" placeholder="2018-00-00" autocomplete="off"/>
                        </div>
                    </div>
    
                    <div class="form_input mg_b20">
                        <label class="">상세내용</label>
                        <textarea class="form_control ta_l" row="3" id="textareaModalEventContents" name="textareaModalEventContents"></textarea>
                    </div>
    
                   
    				<div class="view_cata_full mg_b20">
							<!-- <div class="mg_b10 ta_c">
								추가로 입력할 부분을 선택해주세요.<br /> 저장 후 해당 페이지로 자동 전환됩니다.
							</div> -->
							<c:choose>
								<c:when test="${param.mode eq 'ins'}">
									<div class="ta_c">
										<!-- <a href="#" class="btn_contact_sel" id="selectSalesOpp">잠재영업기회</a>
										<input type="checkbox" name="checkSalesOpp" style="display: none;" /> -->
										<a href="#" class="btn_contact_sel" id="selectIssue">이슈</a>
										<input type="checkbox" name="checkIssue" style="display: none;" />
										<!-- <a href="#" class="btn_contact_sel active">이슈</a> -->
									</div>
								</c:when>
								<c:otherwise>
									<%-- <div class="view_cata_full">
										<div class="ti">
											<span class="bullet dot"></span> 연관 잠재영업기회
										</div>
										<div class="cboth cont_list" id="relationHiddenOpp">
											<%
												//<a href="#" class="btn_quick">바로가기</a>
											%>
										</div>
									</div> --%>
									<div class="view_cata_full">
										<div class="ti">
											<span class="bullet dot"></span> 연관 고객이슈
										</div>
										<div class="cboth cont_list" id="relationClientIssue">
											<%
												//<a href="#" class="btn_quick">바로가기</a>
											%>
										</div>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
                   
    
					<div class="form_input mg_b20">
                        <label class="">메일공유</label>
                        <div class="search_input_after">
                        <!-- id="ulMultipleMailShareMember" -->
							<ul  class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
								<li class="input-container flexdatalist-multiple-value pos-rel" id="ulMultipleMailShareMember" name="ulMultipleMailShareMember">
									<div class="pos-rel">
									<input type="text" class="form-control" id="textMultipleMailShareMember" name="textMultipleMailShareMember" placeholder="공유할 직원명을 검색해 주세요." autocomplete="off"/>
									</div>
								</li>
							</ul>
                        </div>
                    </div>
                    
                    <div class="form_input">
                        <label class="">기타</label>
                        <div class="guideBox">
                            Follow-Up-Action과 첨부파일 수정은 PC에서만 가능합니다.
                        </div>
                    </div>
                    
                    <input type="hidden"name="hiddenModalPK" id="hiddenModalPK"/>
                    <input type="hidden"name="hiddenModalOpportunityhiddenId" id="hiddenModalOpportunityhiddenId"/>
                    <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
                    <input type="hidden" name="hiddenModalSalesCycle" id="hiddenModalSalesCycle" value="1" />
                    
                    <!-- <input type="hidden" name="hiddenModalSalesPartner" id="hiddenModalSalesPartner"/> -->
                    <input type="hidden" name="hiddenModalContractAmount" id="hiddenModalContractAmount"/>
                    <input type="hidden" name="hiddenModalGPAmount" id="hiddenModalGPAmount"/>
                   
                    <input type="hidden" name="hiddenModalSalesREVArr" id="hiddenModalSalesREVArr"/>
                    <input type="hidden" name="hiddenModalSalesGPArr" id="hiddenModalSalesGPArr"/>
                    <input type="hidden" name="hiddenModalSalesDateArr" id="hiddenModalSalesDateArr"/>
                   
                    <input type="hidden" name="hiddenModalCompanyId" id="hiddenModalCompanyId"/>
                    <input type="hidden" name="hiddenModalPartnerId" id="hiddenModalPartnerId"/>
                   
                    <input type="hidden" name="hiddenModalExecId" id="hiddenModalExecId"/>
                    <input type="hidden" name="hiddenModalOwnerId" id="hiddenModalOwnerId"/>
                    <input type="hidden" name="hiddenModalIdentifierId" id="hiddenModalIdentifierId"/>
                    <input type="hidden" name="hiddenModalCustomerId" id="hiddenModalCustomerId"/>
                    
                    
                    <input type="hidden" name="textareaFollowUpAction" id="textareaFollowUpAction"/>
                    <input type="hidden" name="hiddenModalFollowManagerId" id="hiddenModalFollowManagerId"/>
                    <input type="hidden" name="textModalFollowUpDate" id="textModalFollowUpDate" value=""/>
                    
                    
                </div>
            <!--// 기본정보 -->
             </form>
 
        </div>

        

    </article>   

</div>
		<div class="pg_bottom_func">
            <ul>
                <li><a href="#" class="" id="viewopportunityList"> <img src="${pageContext.request.contextPath}/images/m/icon_list.png" /> <span>목록</span></a></li>
                <li><a href="#" class="" id="insertOpportunity"> <img src="${pageContext.request.contextPath}/images/m/icon_edit.png" /> <span>저장</span></a></li>
            </ul>
        </div>
<div class="modal_screen"></div>

<form name="formFollow" id="formFollow" method="post" action="">
	<input type="hidden" name="contactPK" id="contactPK" />
	<input type="hidden" name="issueFlag" id="issueFlag" />
	<input type="hidden" name="oppFlag" id="oppFlag" />
	<input type="hidden" name="returnCompanyId" id="returnCompanyId" />
	<input type="hidden" name="returnCompanyName" id="returnCompanyName" />
	<input type="hidden" name="returnCustomerName" id="returnCustomerName" />
	<input type="hidden" name="returnCustomerId" id="returnCustomerId" />
	<input type="hidden" name="returnCustomerRank" id="returnCustomerRank" />
</form>

<!-- Mainly scripts -->
<script src="${pageContext.request.contextPath}/js/m/jquery-1.11.0.js"></script>
<script src="${pageContext.request.contextPath}/js/m/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/jquery.form.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/plugins/validate/jquery.validate.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/plugins/autocomplete/jquery.auto-complete.js?ver=1.0"></script>
<script src="${pageContext.request.contextPath}/js/m/common.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        // 고객컨택내용 목록
        $("#viewopportunityList").on("click", function(e) {
            location.href = '/partnerManagement/viewPartnerContactList.do';
            e.preventDefault();
        });    
        
     // 이슈 선택 체크 
		$("#selectIssue").on("click", function(e) {
			selectIssue();
			e.preventDefault();
		});
        
        // 저장 
        $("#insertOpportunity").on("click", function(e) {
            insertOpportunity();
            e.preventDefault();
        });    
        
        pageInit();
        
        <c:if test="${param.mode eq 'upd'}">
            updateDetail('${param.pkNo}');
        </c:if>        
 
    });
    
    function changeCategory(value){
    	$("#hiddenModalCategory").value(value);
    }
    	
    
    
    // 초기 페이지 구성에 필요한 정보를 세팅한다.
    function pageInit() {
    	validate();
    	
        //자동완성 검색
        commonSearch.member($("#formModalData #textModalExecOwner"), $('#formModalData #hiddenModalExecId')); //실행임원
        commonSearch.member($("#formModalData #textModalOpportunityOwner"), $('#formModalData #hiddenModalOwnerId')); //OO
        commonSearch.member($("#formModalData #textModalOpportunityIdentifier"), $('#formModalData #hiddenModalIdentifierId')); //OI
        
        commonSearch.company($('#formModalData #textCommonSearchCompany'), $('#formModalData #hiddenModalCompanyId'), $('#formModalData #textCommonSearchCompanyId'));
        //commonSearch.partnerMember($('#formModalData #textModalCustomerName'), $('#formModalData #hiddenModalCustomerId'), $('#formModalData #textModalCustomerRank'), $('#formModalData #hiddenModalCompanyId'));
        commonSearch.partner($("#formModalData #textCommonSearchPartner"), $('#formModalData #textCommonSearchCompanyId'), $('#formModalData #ulMultiplePartner'));
        
        //commonSearch.multiplePartnerName($("#formModalData #textCommonSearchPartner"), $('#formModalData #textCommonSearchCompanyId'), $('#formModalData #ulMultiplePartner'));
        commonSearch.multiplePartnerName($("#formModalData #textModalCustomerName"), $('#formModalData #hiddenModalCustomerId'), $('#formModalData #liMultiplePartner'));
        // 메일공유 복수 검색
        commonSearch.multipleMailShareMember($("#formModalData #textMultipleMailShareMember"), $('#formModalData #hiddenModalMemberList'), $('#formModalData #ulMultipleMailShareMember'));
        /*
        $("#textCommonSearchPartner").keydown(function (key) {
            if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
                commonSearch.partnerInfo();
             }
         });
        */
        $('#textModalContractAmount').keyup(function(){
            //$('tr[name="revTr"]').eq(0).find('input[name="amount_r"]').eq(0).val($(this).val());
            //oppSalesPlan.quarterSum();
            //oppSalesPlan.divisionSum();
        });
        
        //tab menu
        $("ul.tabmenu-type").on({
            'click.modalTab' : function(e){
                e.preventDefault();
                var idx = $("ul.tabmenu-type li a").index($(this));
                $("ul.tabmenu-type li a").removeClass("sel");
                $(this).addClass("sel");
                $("div.modaltabmenu").addClass("off");
                $("div.modaltabmenu").eq(idx).removeClass("off");
            }
        },'li a');
        /* 
        $("ul.tabmenu-type li a").click(function(e){
            e.preventDefault();
            var idx = $("ul.tabmenu-type li a").index($(this));
            $("ul.tabmenu-type li a").removeClass("sel");
            $(this).addClass("sel");
            $("div.modaltabmenu").addClass("off");
            $("div.modaltabmenu").eq(idx).removeClass("off");
        }); */
        
        //유효성 검사
        $("#textModalSubject, #textCommonSearchCompany, #textModalCustomerName, #textModalContractAmount, #textModalGPAmount,  #textModalContractDate, #textModalOpportunityOwner, #textModalOpportunityIdentifier").on("blur",function(e){
            switch (e.target.id) {
                case "textModalOpportunityOwner":
                    $("#formModalData").find("#hiddenModalOwnerId").valid();
                    break;
                case "textModalOpportunityIdentifier":
                    $("#formModalData").find("#hiddenModalIdentifierId").valid();
                    break;
                case "textCommonSearchCompany":
                    $("#formModalData").find("#hiddenModalCompanyId").valid();
                    break;
                case "textModalCustomerName":
                    $("#formModalData").find("#hiddenModalCustomerId").valid();
                    break;
                default:
                    $("#formModalData").find(e.target).valid();
                    break;
            }
        });
    }
        /*
 // 잠재영업기회 체크 확인
	function selectSalesOpp() {
		var checkFlag = $("input[name='checkSalesOpp']").prop("checked");
		if (checkFlag) {
			$("input[name='checkSalesOpp']").prop("checked", false);
		} else {
			$("input[name='checkSalesOpp']").prop("checked", true);
		}
	}*/

	// 이슈 체크 확인
	function selectIssue() {
		var checkFlag = $("input[name='checkIssue']").prop("checked");
		if (checkFlag) {
			$("input[name='checkIssue']").prop("checked", false);
		} else {
			$("input[name='checkIssue']").prop("checked", true);
		}
	}
	// 여기여기
    function validate () {
        $("#formModalData").validate({ // joinForm에 validate를 적용
            ignore: '', 
            rules : {
                textModalSubject : {
                    required : true,
                    maxlength : 100
                },
                textCommonSearchPartner : {
                    required : true
                },
                hiddenModalCustomerId : {
                    required : true
                },
                contactMethod : {
                	required : true
                }
            /*  textModalContractDate : {
                    required : true
                },
                // required는 필수, rangelength는 글자 개수(1~10개 사이)
                textModalContractAmount : {
                    required : true,
                    digits:true
                } */
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
                    maxlength:"100글자 이하여야 합니다." 
                },
                textCommonSearchPartner : {
                    required : "파트너사를 입력하세요.",
                },
               
                
                hiddenModalCustomerId : {
                    required : "파트너명을 입력하세요."
                },
                
                contactMethod : {
                	required : "컨택방법을 선택하세요."
                }
                
            },
            invalidHandler : function(error, element) {
                $('div.modaltabmenu').each(function(idx,obj){
                    $("ul.tabmenu-type li a").eq(idx).trigger('click.modalTab');
                    return false;
                });
            },
            errorPlacement : function(error, element) {
                if($(element).prop("id") == "hiddenModalExecId") {
                    $("#textModalExecOwner").after(error);
                    location.href = "#textModalExecOwner";
                }else if($(element).prop("id") == "hiddenModalOwnerId") {
                    $("#textModalOpportunityOwner").after(error);
                    location.href = "#textModalOpportunityOwner";
                }else if($(element).prop("id") == "hiddenModalIdentifierId") {
                    $("#textModalOpportunityIdentifier").after(error);
                    location.href = "#textModalOpportunityIdentifier";
                }else if($(element).prop("id") == "hiddenModalCompanyId") {
                    $("#textCommonSearchCompany").after(error);
                    location.href = "#textCommonSearchCompany";
                }else if($(element).prop("id") == "hiddenModalCustomerId") {
                    $("#textModalCustomerName").after(error);
                    location.href = "#textModalCustomerName";
                }else{
                    error.insertAfter(element); // default error placement.
                }
            }
        });        
        
        
    }    
    
    
    
    
    function insertOpportunity(shareFlag) {
        var url = "/partnerManagement/insertClientContact.do";
        <c:if test="${param.mode eq 'upd'}">
            url = "/partnerManagement/updateClientContact.do";
        </c:if>
        
        //var oppFlag = $("input[name='checkSalesOpp']").prop("checked");
		var issueFlag = $("input[name='checkIssue']").prop("checked");
        
        //예상계약금액, 예상GP금액
        $("#hiddenModalContractAmount").val($("#textModalContractAmount").val());
        $("#hiddenModalGPAmount").val($("#textModalGPAmount").val());
        
        $('#formModalData').ajaxForm({
            url : url,
            async : true,
            data : {
                mileStoneData :'[]', //PC버전과의 호환성을 위해 셋팅.  JSON파싱 오류로 인해 셋팅한 후 넘김. 2017.06.07
                checkListData :'[]', //PC버전과의 호환성을 위해 셋팅.  JSON파싱 오류로 인해 셋팅한 후 넘김. 
                winPlanData   :'[]', //PC버전과의 호환성을 위해 셋팅.  JSON파싱 오류로 인해 셋팅한 후 넘김. 
                salesPlanData :'[]', //PC버전과의 호환성을 위해 셋팅.  JSON파싱 오류로 인해 셋팅한 후 넘김. 
                contactFollowUpAction : '[]'
            },
            beforeSubmit: function (data,form,option) {
                if(!confirm("저장하시겠습니까?")) return false;
            },
            beforeSend : function(xhr){
                xhr.setRequestHeader("AJAX", true);
            },
            success: function(data){
                //console.log(data);
                if(data.cnt > 0){
                	//console.log(data.returnPk);
                	$("input[name=contactPK]").val(data.returnPK);
                	//console.log($("input[name=contactPK]").val());
                    alert("저장하였습니다.");
                    //$('#contactPK').val(data.returnPK);
                    //console.log($('#contactPK').val());
                    window.location.href = "/partnerManagement/viewPartnerContactList.do";
                } else {
                    alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
                }
                 
            },
            complete: function() {
            	//alert("아무것도 체크 안했을 떄 필요값 체크 = 잠재" + oppFlag + " / 이슈 = " + issueFlag);
				var returnPkValue = $("input[name=contactPK]").val();
				
				if (!issueFlag) { // 둘다 노 체크s
					if(returnPkValue == ''){
						window.location.href = '/partnerManagement/viewPartnerContactList.do';
						return false;
					}
					location.href = '/partnerManagement/selectContactDetail.do?pkNo='+returnPkValue;
				}else if(issueFlag){
					alert("이슈 입력으로 이동합니다.");
					returnFollowUpAction(returnPkValue, '/partnerManagement	/formPartnerIssueInsertDetail.do');
				} 
				/*
				else if (oppFlag && issueFlag) { //둘다 체크
					alert("잠재영업기회 입력으로 이동합니다.");
					returnFollowUpAction(oppFlag, issueFlag, '/clientSalesActive/hiddenOpportunityInsertForm.do');
				} else if (oppFlag && !issueFlag) { //잠재영업기회만 체크
					alert("잠재영업기회 입력으로 이동합니다.");
					returnFollowUpAction(oppFlag, issueFlag, '/clientSalesActive/hiddenOpportunityInsertForm.do');
				} else if (!oppFlag && issueFlag) { //이슈만 체크 체크
					alert("이슈 입력으로 이동합니다.");
					returnFollowUpAction(oppFlag, issueFlag, '/clientSatisfaction/clientIssueInsertForm.do');
				}
				*/
            },
            error: function(){
                //에러발생을 위한 code페이지
                alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
            }   
        });
        $('#formModalData').submit();
    }
    
    function returnFollowUpAction(contactPK, url) {
    	$("#formFollow #contactPK").val(contactPK);
    	
    	//$("#formFollow #returnContactId").val($("#formModalData #hiddenModalContactId").val());
        $("#formFollow #returnCompanyId").val($("#formModalData #textCommonSearchCompanyId").val());
        $("#formFollow #returnCompanyName").val($("#formModalData #textCommonSearchPartner").val());
        $("#formFollow #returnCustomerName").val($("#formModalData #textModalCustomerName").val());
        $("#formFollow #returnCustomerId").val($("#formModalData #hiddenModalCustomerId").val());
        //$("#formFollow #returnCustomerRank").val($("#formModalData #textModalCustomerRank").val());
        
        $("#formFollow").attr("action",url);
        $("#formFollow").submit();
    }
    
    function updateDetail(_pkNo) {
        //console.log("this is update detail.");
        //console.log(_pkNo);

        //상세정보를 가져와서 수정정보에 셋팅
        $.ajax({
            url : "/partnerManagement/selectContactDetail.do",
            async : false,
            datatype : 'json',
            mtype: 'POST',
            data : {
                pkNo : _pkNo,
                contactFollowUpAction : '[]',
                datatype : "jsonview"
            },
            beforeSend : function(){
            },
            success : function(data){
                //console.log(data);
                
                // gridClientIndividualInfo << 이거랑 같이 쓰고 있는거 같아서 일단 안바꾸고 위의 URL로 가져왔습니다.
                var rowData = data.detail;
                var fileList = data.fileList;
                
                //초기화
                $("#formModalData").validate().resetForm();
                
                $("#hiddenModalPK").val(rowData.EVENT_ID);
                $("#textModalSubject").val(rowData.EVENT_SUBJECT);
                //$("#divModalNameAndCreateDate").html("작성자 : "+rowData.HAN_NAME+"/ 작성일 : "+rowData.SYS_REGISTER_DATE);
                
                //코칭톡 버튼 show
                $("#buttonModalCoachingTalkView").show();
                
                if(isEmpty(rowData.FORECAST_YN)){
                    $("input:radio[name='radioModalForecastYN']").prop("checked",false);
                }else{
                    $("input:radio[name='radioModalForecastYN']:radio[value='"+rowData.FORECAST_YN+"']").prop("checked",true);  
                }
                //여기여기
                //파트너사
                $("#textCommonSearchPartner").val(rowData.COMPANY_NAME);
                $("#textCommonSearchCompanyId").val(rowData.PARTNER_ID);
                
                
                //파트너명
                $("#textModalCustomerName").val(rowData.PARTNER_PERSONAL_NAME);
                $("#hiddenModalCustomerId").val(rowData.PARTNER_INDIVIDUAL_ID);
                
                // 컨택 방법
                $("#contactMethod").val(rowData.EVENT_CATEGORY);
                $("#selectModalCategory").val(rowData.EVENT_CATEGORY);
                
               // 컨택일자
                $("#textModalEventDate").val(rowData.EVENT_DATE);
                
                // 상세내용
                $("#textareaModalEventContents").val(rowData.EVENT_CONTENTS);
                
                $("ul.company-list").html("");
                
                //$("#textCommonSearchPartner").val("");
                //commonSearch.multiplePartnerArray = [];
                //commonSearch.multiplePartner(rowData.COMPANY_NAME);
                
                //파일
                /*
                commonFile.reset();
                if(!isEmpty(fileList)){
                    $("#divFileUploadList span").remove();
                    for(var i=0; i<fileList.length; i++){
                        $("#divFileUploadList").append('<span style="padding-left:5px;"><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=6"><i class="fa fa-file-'+commonCheckExtension(fileList[i].FILE_TYPE)+'-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="modal.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></span>');
                    }
                }else{
                    $("#divFileUploadList").html('<span class="blank-ment">선택된 파일이 없습니다</span>');
                }
                */
                
                $("h2.modal-title").html(rowData.EVENT_SUBJECT);
                
                
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
				$("#relationClientIssue").html("");
				if (!isEmpty(rowData.ISSUE_ID)) {
					//$("#relationClientIssue").html('<a href="/clientSatisfaction/viewClientIssueList.do?issue_id='+rowData.ISSUE_ID+'" target="_new" class="oppStatusColor oppStatusColor-complete">바로가기</a>');
					$("#relationClientIssue")
							.html(
									'<a href="/clientSatisfaction/viewClientIssueList.do?issue_id='
											+ rowData.ISSUE_ID
											+ '" target="_new" class="oppStatusColor oppStatusColor-complete btn_quick">바로가기</a>');
				} else {
					$("#relationClientIssue").html('-');
				}
            },
            complete : function(){
            }
        });
        
    }    
    
</script>
</body>
</html>