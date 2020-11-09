<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/jsp/m/common/cache.jsp" %>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>
<%@ include file="/WEB-INF/jsp/m/common/functions.jsp" %>
<%
String req_params = getReqParams(request, "mode");
request.setAttribute("req_params", req_params);
%>

    <article class="">
        <div class="title_pg ta_c">
        <h2 class="" id="COMPANY_NAME">
        	<c:choose>
        		<c:when test="${map.mode eq 'update'}">
        			  <h2 class="">${selectPartnerCompanyInfo[0].COMPANY_NAME}</h2>
        		</c:when>
        		<c:otherwise>
        			<h2>파트너사 신규등록</h2>
        		</c:otherwise>
        	</c:choose>
        </h2>
            <a href="#" class="btn_back" onclick="window.history.back();">back</a>
        </div>
<%--
        <div class="author">
            <span>이기섭(2016-08-10)</span>
        </div>
 --%>
        <div class="pg_cont pd_t10">

            <form class="form-horizontal" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">

                <div class="form_input mg_b20">
                    <label class="">파트너사명 <span style="color:red;">*</span></label>
                    <input type="text" id="textModalCompanyName" name="textModalCompanyName" value="${selectPartnerCompanyInfo[0].COMPANY_NAME}" class="form_control" />
                </div>

                <div class="form_input mg_b20">
                    <label class="">파트너사 ID</label>
                    <input type="text" id="textModalCompanyId" name="textModalCompanyId" value="${selectPartnerCompanyInfo[0].PARTNER_ID}" disabled placeholder="자동 발급됩니다." class="form_control" />
                </div>

				<div class="form_input mg_b20">
                    <label class="">CEO</label>
                    <input type="text" id="textModalCeoName" name="textModalCeoName" value="${selectPartnerCompanyInfo[0].CEO_NAME}" class="form_control" />
                </div>
                
                <div class="form_input mg_b20">
                    <label class="">파트너사 코드 <span style="color:red;">*</span></label>
                    <select id="selectModalpartnerSegmentCode" name="selectModalpartnerSegmentCode" class="form_control">
                        <option></option>
                    </select>
                </div>
<%--
                <div class="form_input mg_b20">
                    <label>CEO</label>
                    <input type="text" placeholder="이상현" class="form_control" />
                </div>
 --%>
                <div class="form_input mg_b20">
                    <label class="">파트너사 Item</label>
                    <input type="text" id="textModalCompanyItem" name="textModalCompanyItem" value="${selectPartnerCompanyInfo[0].COMPANY_ITEM}" class="form_control" />
                </div>

                <div class="form_input mg_b20">
                    <label>사업자등록번호</label>
                    <input type="text" id="textModalBusinessNumber" name="textModalBusinessNumber" value="${selectPartnerCompanyInfo[0].BUSINESS_NUMBER}" class="form_control" />
                </div>
                
                <div class="form_input mg_b20">
                    <label>대표전화</label>
                    <input type="text" id="textModalCompanyTelno" name="textModalCompanyTelno" value="${selectPartnerCompanyInfo[0].COMPANY_TELNO}" class="form_control" />
                </div>

                <div class="form_input mg_b20">
                    <label>FAX번호</label>
                    <input type="text" id="textModalCompanyFaxno" name="textModalCompanyFaxno" value="${selectPartnerCompanyInfo[0].COMPANY_FAXNO}" class="form_control" />
                </div>

                <div class="form_input mg_b20">
                    <label class="">주소</label>
                    <input type="text" id="textModalPostalAddress" name="textModalPostalAddress" value="${selectPartnerCompanyInfo[0].POSTAL_ADDRESS}" class="form_control" />
                </div>
                
                <div class="form_input mg_b20">
                    <label class="">홈페이지</label>
                    <input type="text" id="textModalCompanyHomepage" name="textModalCompanyHomepage" value="${selectPartnerCompanyInfo[0].COMPANY_HOMEPAGE}" class="form_control" />
                </div>

                <div class="form_input mg_b20">
                    <label>업태</label>
                    <input type="text" id="textModalBusinessType" name="textModalBusinessType" value="${selectPartnerCompanyInfo[0].BUSINESS_TYPE}" class="form_control" />
                </div>

                <div class="form_input mg_b20">
                    <label>종목</label>
                    <input type="text" id="textModalBusinessSector" name="textModalBusinessSector" value="${selectPartnerCompanyInfo[0].BUSINESS_SECTOR}" class="form_control" />
                </div>

                <div class="h_line pd_t10"></div>

                <div class="guideBox">파트너사 로고 및 조직도 이미지 업로드는 pc에서 수정 가능합니다.</div>
				
				<input type="hidden" name="mode" id="mode" value="${map.mode}"/>
                <input type="hidden"name="hiddenModalPK" id="hiddenModalPK" value="${selectPartnerCompanyInfo[0].PARTNER_ID}" />
                <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}" />
                <input type="hidden" name="hiddenModalCompanyId" id="hiddenModalCompanyId" value="${selectPartnerCompanyInfo[0].PARTNER_ID}" />
                <input type="hidden" name="hiddenModalSegmentCode" id="hiddenModalSegmentCode" />
 				<input type="hidden" id="hiddenModalPostalCode" name="hiddenModalPostalCode" />
                <input type="hidden" name="fileModalUploadPhoto" id="fileModalUploadPhoto" >
                <input type="hidden" id="hiddenModalCeoName" name="hiddenModalCeoName" />
                <input type="hidden" id="hiddenModalCeoID" name="hiddenModalCeoID" />
                

            </form>

        </div>

        <div class="pg_bottom_func">
            <ul>
                <li><a href="/partnerManagement/viewPartnerCompanyInfoGate.do<c:if test="${req_params ne ''}">?${req_params}</c:if>" class=""> <img src="../../../images/m/icon_list.png" /> <span>목록</span></a></li>
                <li><a href="#" class="" id="btn_submit" > <img src="../../../images/m/icon_edit.png" /> <span>저장</span></a></li>
            </ul>
        </div>

    </article>

<script type="text/javascript">
var $jq = jQuery.noConflict();

$jq(document).ready(function(){
	var opt_selected = "";
	
	params = $.param({
		datatype : 'json'
	});
	
	$jq.ajax({ //산업분류코드
		url : "/partnerManagement/selectCodePartnerSegmentAll.do",
		async : false,
		data : params,
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
			//$.ajaxLoadingShow();
		},
		success : function(data){
			$("#hiddenModalSegmentCode").val("");
			$("#selectModalpartnerSegmentCode").html("<option value=''>===선택===</option>");

			if("TESTCODE" == "${selectPartnerCompanyInfo[0].PARTNER_CODE}")
				opt_selected = 'selected="selected"';
			else
				opt_selected = '';
			
			//$("#selectModalpartnerSegmentCode").append('<option value="TESTCODE" '+opt_selected+'>테스트코드</option>');
			
			if(data.partnerSegmentCode.length > 0){
				for(var i=0; data.partnerSegmentCode.length>i; i++){
					if(data.partnerSegmentCode[i].PARTNER_CODE == "${selectPartnerCompanyInfo[0].PARTNER_CODE}")
						opt_selected = 'selected="selected"';
					else
						opt_selected = '';
					
					$("#selectModalpartnerSegmentCode").append('<option value="'+ data.partnerSegmentCode[i].PARTNER_CODE +'"'+opt_selected+'">'+data.partnerSegmentCode[i].PARTNER_CODE+'</option>');
				}
			}else{
				//$("#selectModalpartnerSegmentCode").append('<option>영업채널 코드를 추가해주세요.</option>');
			}
			/*
			if(modalFlag=="upd" && !isEmpty(chk)){
				$("#selectModalpartnerSegmentCode option").prop("selected",false)
				$.each(($("#hiddenPartnerCode").val()).split(";"),function(index, val){
					$("#selectModalpartnerSegmentCode option[value='"+val+"']").prop("selected",true);
				}); 
			}
			*/
		},
		complete : function(){
			//$.ajaxLoadingHide();
		}
	});
	
	$jq("#btn_submit").click(function(){
		var browser = getIEVersionCheck();
		var url;
		//(modalFlag == "ins") ? url = "/partnerManagement/insertPartnerCompanyInfo.do" : url = "/partnerManagement/updatePartnerCompanyInfo.do";
		var mode = "${map.mode}";
		url = (mode == "update") ?  "/partnerManagement/updatePartnerCompanyInfo.do" : "/partnerManagement/insertPartnerCompanyInfo.do";
		
		if(!$('#textModalCompanyName').val()) {
			alert("파트너사명을 입력하세요!");
			$('#textModalCompanyName').focus();
			return false;
		}
		
		var index = $('#selectModalpartnerSegmentCode option').index($('#selectModalpartnerSegmentCode option:selected'));
		if(index == 0) {
			alert("파트너사 코드를 선택하세요.");
			$('#selectModalpartnerSegmentCode').focus();
			return false;
		}
		
		//파트너 코드 다중화
		var codeArr = [], partnerCode; 
		$jq('#selectModalpartnerSegmentCode :selected').each(function(i, selected){ 
			//codeArr[i] = $(selected).text(); 
			codeArr[i] = $(selected).val();
		});
		partnerCode = codeArr.join(";");
		$jq("#hiddenModalSegmentCode").val(partnerCode);
		
		//var params = $("#formModalData").serialize() + "&datatype=json";
		//alert(params);
		$jq('#formModalData').ajaxForm({
		//$.ajax({
			url : url,
			async : true,
			//data : params,
			beforeSubmit: function (data,form,option) {
				//if(!compareFlag){
					if(!confirm("저장하시겠습니까?")) return false;
				//}
				//$jq.ajaxLoadingShow();
			},
			data :{
				datatype : 'json',
				browser : browser
			},
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			success: function(data){
				//성공후 서버에서 받은 데이터 처리
				if(data.cnt > 0){
					//compare_before = $("#formModalData").serialize();
					//compareFlag = false;
					alert("저장하였습니다.");
					if(mode == "update") {
						window.location.href = "/partnerManagement/viewPartnerCompanyInfoDetail.do<c:if test="${req_params ne ''}">?${req_params}</c:if>";
					}
					else {
						window.location.href = "/partnerManagement/viewPartnerCompanyInfoGate.do<c:if test="${req_params ne ''}">?${req_params}</c:if>";
					}
					
					//if(modalFlag=="ins") $('#myModal1').modal("hide");
					////$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/clientManagement/gridClientCompanyInfo.do?"+searchSerialize, rowNum : listRow}).trigger('reloadGrid');
					
					//if(modalFlag=="upd") {
						//$("#divFileUploadArea .fileModalUploadFile").remove();
						//$('#divFileUploadList').html('<span>파일을 선택해 주세요.</span>');
						//$("#divModalFile > p").remove();
						//clientSearchList.get(1, 20);
						//companyDetail.getCompanyInfo();
						//$("#serchDetail").val($("#textModalCompanyName").val());
						
						//clientSearchList.get();
						//clientList.goDetail($("#textModalCompanyId").val());
					//}else if(modalFlag=="ins"){
						//$("#textListSearchDetail").val($("#textModalCompanyName").val());
						//$("#serchDetail").val($("#textModalCompanyName").val());
						//searchDetailClick.goDetail($("#textModalCompanyId").val());
					//}
				}else{
					alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
				}
			},
			complete : function(){
				$jq.ajaxLoadingHide();
			}
		});
		
		$jq('#formModalData').submit();
		
	});
});
</script>

<jsp:include page="/WEB-INF/jsp/m/common/bottom.jsp"/>