<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<%  
response.setHeader("Cache-Control","no-store");  
response.setHeader("Pragma","no-cache");  
response.setDateHeader("Expires",0);  
if (request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache");
%>


<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
<title>영업기회</title>

    <link href="${pageContext.request.contextPath}/css/m/bootstrap/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/font-awesome/m/css/font-awesome.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/m/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/m/jqueryui/jquery-ui.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/js/m/plugins/autocomplete/jquery.auto-complete.css" rel="stylesheet">


</head>

<body class="gray_bg" onload="tabmenuLiWidth();">
<jsp:include page="../templates/header.jsp" flush="true"/> 

	<!-- location -->
	<jsp:include page="../common/nav.jsp" flush="true"/>
	
<div class="container_pg">

    

    <article class="">
        <div class="title_pg ta_c">
            <c:choose>
                <c:when test="${mode eq 'ins'}">
                    <h2 class="modal-title">영업기회 신규등록</h2>
                </c:when>
                <c:otherwise>
                    <h2 class="modal-title">영업기회 수정</h2>
                </c:otherwise>
            </c:choose>
            <a href="javascript:void(0);" class="btn_back" onclick="window.history.back(); return false;">back</a>
        </div>
		
		<ul class="tabmenu tabmenu_type2">
			<li><a href="#" id="tab_1" onclick="fncSelectTab('1'); return false;" class="active">기본정보</a></li>
			<li><a href="#" id="tab_2" onclick="fncSelectTab('2'); return false;">영업단계</a></li>
			<li><a href="#" id="tab_3" onclick="fncSelectTab('3'); return false;">승리계획</a></li>
			<li><a href="#" id="tab_4" onclick="fncSelectTab('4'); return false;">마일스톤</a></li>
			<li><a href="#" id="tab_5" onclick="fncSelectTab('5'); return false;">매출/매입 품목</a></li>
			<li><a href="#" id="tab_6" onclick="fncSelectTab('6'); return false;">매출/수금 계획</a></li>
		</ul>
		
        <div class="pg_cont pd_t20">
            <form class="form-horizontal" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">
                <!-- <div class="guideBox">모바일에서는 기본정보만 입력이 가능하며, 세부정보는 PC에서 입력해주세요.</div> -->
    
                <!-- 기본정보 -->
                <div class="cont1 pd_t10">
    
                    <div class="form_input mg_b20">
                        <label class="">사업명 <span style="color:red;">*</span></label>
                        <input type="text" placeholder="" class="form_control" id="textModalSubject" name="textModalSubject"/>
                    </div>
    				
    				<!-- <div class="form_input mg_b20">
                        <div class="pos-rel">
                            <label class="">매출처<span style="color:red;">*</span></label>
                            <input type="text" class="form_control" id="textCommonSearchCompany" name="textCommonSearchCompany" placeholder="고객사를 검색해 주세요." autocomplete="off"/>
                        </div>
                    </div> -->
                    
                   <div class="form_input mg_b20">
                        <label class="">매출처<span style="color:red;">*</span></label>
                        <div class="">
	                        <ul id="ulModalSingleCompany" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
	                             <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleCompany" name="liModalSingleCompany">
	                                 <input type="text" class="form-control" id="textModalSingleCompany" name="textModalSingleCompany" placeholder="매출처를 검색해 주세요." autocomplete="off" autoFlag="y">
	                                 <input type="hidden" name="hiddenModalCompanyId" id="hiddenModalCompanyId"/>
	                            </li>
	                         </ul> 
                         </div>
                    </div>
    				
                    <div class="form_input mg_b20">
						<label class="">End User <span style="color:red;">*</span></label>
                        <div class="">
                            <ul id="ulModalSingleClient" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                   <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleClient" name="liModalSingleClient">
                                       <input type="text" class="form-control" id="textModalSingleClient" name="textModalSingleClient" placeholder="End User를 검색해 주세요." autocomplete="off" autoFlag="y">
                                       <input type="hidden" name="hiddenModalCustomerId" id="hiddenModalCustomerId"/>
                                   </li>
                               </ul>
                        </div>
                    </div>
    
                    <div class="form_input mg_b20">
                        <label class="">예상계약금액 <span style="color:red;"></span></label>
                        <input type="text" onkeyup="comma(this);" class="form_control" id="textModalContractAmount" name="textModalContractAmount"/>
                    </div>
    
                    <div class="form_input mg_b20">
                        <label class="">예상계약일자 <span style="color:red;">*</span></label>
                        <input type="date" class="form_control" id="textModalContractDate" name="textModalContractDate" value=""/>
                    </div>
    				
    				<div class="form_input mg_b20">
                        <label class="">계약기간 <span style="color:red;">*</span></label>
                        <input type="date" class="form_control" id="textModalContractStDate" name="textModalContractStDate" value=""/>
                        ~
                        <input type="date" class="form_control" id="textModalContractEdDate" name="textModalContractEdDate" value=""/>
                    </div>
                    
                    <div class="form_input mg_b20">
                        <label class="">영업기회코드(ERP) </label>
                        <input type="text" class="form_control" id="textModalErpOppCode" name="textModalErpOppCode" readonly/>
                    </div>
                    
                    <div class="form_input mg_b20">
                        <label class="">Forecast </label><!-- <span style="color:red;">*</span> -->
                        <div> <!-- 아래의 항목 체크시 상단 Tab에 해당 메뉴 생성 -->
                            <label for="f_action1" class="mg_r30"><input type="radio" value="In" id="radioModalForecastYN" name="radioModalForecastYN" class="va_m"/><span class="va_m">in</span></label>
                            <label for="f_action2" class=""><input type="radio" value="Out" id="radioModalForecastYN" name="radioModalForecastYN" class="va_m"/><span class="va_m">out</span></label>
                        </div>
                    </div>
    				
    				<div class="form_input mg_b20">
                        <label class="">프로젝트코드(ERP) </label>
                        <input type="text" class="form_control" id="textModalErpProjectCode" name="textModalErpProjectCode" readonly/>
                    </div>
                    
                    <div class="form_input mg_b20">
                        <label class="">EO</label>
                        <div class="">
                            <ul id="ulModalSingleExecOwner" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                             <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleExecOwner" name="liModalSingleExecOwner">
                                 <input type="text" class="form-control" id="textModalExecOwner" name="textModalExecOwner" placeholder="Exec Owner를 검색해 주세요." autocomplete="off" autoFlag="y">
                             </li>
                         </ul>
                        </div>
                    </div>
    
                    <div class="form_input mg_b20">
						<label class="">OO<span style="color:red;">*</span></label>
                        <div class="">
                            <ul id="ulModalSingleOwner" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleOwner" name="liModalSingleOwner">
                                      <input type="text" class="form-control" id="textModalOpportunityOwner" name="textModalOpportunityOwner" placeholder="Owner를 검색해 주세요." autocomplete="off" autoFlag="y">
                                  </li>
                              </ul>
                        </div>
                    </div>
    
                    <div class="form_input mg_b20">
                       <label class="">영업대표 <span style="color:red;">*</span></label>
                        <div class="">
                            <ul id="ulModalSingleIdentifier" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleIdentifier" name="liModalSingleIdentifier">
                                    <input type="text" class="form-control" id="textModalOpportunityIdentifier" name="textModalOpportunityIdentifier" placeholder="영업대표를 검색해 주세요." autocomplete="off" autoFlag="y">
                                </li>
                            </ul>
                        </div>
                    </div>
                    
                    <div class="form_input mg_b20">
                           <label class="">영업구분 <span style="color:red;">*</span></label>
                           <select name="selectModalCategoryCd" id="selectModalCategoryCd" class="form_control">
	                       			<c:choose>
										<c:when test="${fn:length(searchDetailGroup.code_tpso) > 0}">
											<c:forEach items="${searchDetailGroup.code_tpso}" var="searchDetailGroup">
			                                    <option value="${searchDetailGroup.CODE_ID}">${searchDetailGroup.CODE_NAME}</option>
                                    		</c:forEach>
                                    	</c:when>
                                   	</c:choose>
						</select>
                    </div>
                    
                    <div class="form_input mg_b20">
                           <label class="">영업유형 <span style="color:red;">*</span></label>
                           <select class="form-control" name="selectModalTypeCd" id="selectModalTypeCd">
                        		<option value="0001">Direct</option>
                        		<option value="0002">InDirect</option>
                     		</select> 
                    </div>
                    
                    <div class="form_input mg_b20">
                   	 <label class="">프로젝트형태 <span style="color:red;">*</span></label>
                    	<select class="form-control" name="selectModalProjectForm" id="selectModalProjectForm">
                             <c:choose>
							<c:when test="${fn:length(searchDetailGroup.code_project) > 0}">
								<c:forEach items="${searchDetailGroup.code_project}" var="searchDetailGroup">
					                    <option value="${searchDetailGroup.CODE_ID}">${searchDetailGroup.CODE_NAME}</option>
		                    		</c:forEach>
		                    	</c:when>
	                        </c:choose>
                            </select> 
                    </div>
                   							
					<div class="form_input mg_b20">
                           <label class="">고객구분 <span style="color:red;">*</span></label>
                           <select class="form-control" name="selectModalClientCategoryCd" id="selectModalClientCategoryCd">
                        			<option value="1">매출처</option>
                        			<option value="2">End User</option>
                        			<option value="3">매입처</option>
                     		</select>
                    </div>
                    
                    <div class="form_input mg_b20">
                    	<label class="">고객담당자 <span style="color:red;">*</span></label>
                    	<div class="">
                            <ul id="ulModalSingleClientMaster" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleClientMaster" name="liModalSingleClientMaster">
                                    <input type="text" class="form-control" id="textModalSingleClientMaster" name="textModalSingleClientMaster" placeholder="고객담당자를 검색해 주세요." autocomplete="off" autoFlag="y">
                                </li>
                            </ul>
                    	</div>
                    	
                    		<div id="divSingleClientMasterErr" style="display:none;">
								  <label id="singleClientMaster-error" class="error-custom" for="singleClientMaster">ERP 코드가 있는 담당자만<br />ERP로 전환 가능합니다.<br />'연동하기' 버튼을 클릭하여 연동해주세요.</label>
								  <button type="button" class="btn btn-gray btn-file" style="line-height:0.7" onClick="$('div.custom-company-pop').show();">연동하기</button>
							  </div>
							  <div class="custom-company-pop off">
                                <div class="pop-header" style="height: 70px;line-height: 35px;">
                                      <button type="button" class="close"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                      <strong class="pop-title">거래처 대표 검색</strong>
                                      <span style="font-size: 14px; color: red;"><br>*ERP거래처대표로 등록된 고객만 검색됩니다.</span>
                                  </div>
                                  <div class="col-sm-12 cont">
                                      <div class="form-group">
                                          <div class="col-sm-12">
                                              <div class="company-search-after mg-b5">검색
                                                  <input type="text" placeholder="거래처 대표 검색" class="form-control fl_l mg-r5" id="textDuzonSearchSalesMan">
                                                  <button type="button" class="btn btn-gray btn-file" onClick="selectClientSalesmanInfo();">검색</button>
                                              </div>
                                          </div>
                                          <div class="col-sm-12 company-result mg-b10 ">검색 결과 노출시 "off" 삭제
                                              <strong>[검색 결과]</strong>
                                              <ul class="company-list">
                                              </ul>
                                          </div>
                                      </div>
                                  </div>
                       		 </div>
                       		 
                    </div>
                     
                     <div class="form_input mg_b20">
                           <label class="">구매방법 <span style="color:red;">*</span></label>
                          <select class="form-control" name="selectModalBuyCd" id="selectModalBuyCd">
                      			<option value="1">기술가격평가</option>
                      			<option value="2">계약갱신</option>
                      			<option value="3">수의계약</option>
                      			<option value="4">가격입찰</option>
                   		</select> 
                    </div>
                      
                    <div class="form_input mg_b20">
                        <label class="">상세내용</label>
                        <textarea class="form_control ta_l" row="3" id="textareaModalDetailConents" name="textareaModalDetailConents"></textarea>
                    </div>
    
                    <div class="form_input mg_b20">
                        <label class="">차별화 가치</label>
                        <textarea class="form_control" row="3" id="textareaModalDiscriminateValue" name="textareaModalDiscriminateValue"></textarea>
                    </div>
    
                    <div class="form_input mg_b20">
                        <label class="">ROUTE</label>
                        <input type="text" class="form_control" id="textModalRoute" name="textModalRoute"/>
                    </div>
    
                    <div class="form_input mg_b20">
	                        <label class="">파트너사</label>
	                        <div class="search_input_after">
	                        
							<ul class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
								<li class="input-container flexdatalist-multiple-value pos-rel" id="ulMultiplePartner" name="ulMultiplePartner">
									<div class="pos-rel">
										<input type="text" class="form-control" id="textMultiplePartner" name="textMultiplePartner" placeholder="파트너사를 검색해 주세요." autocomplete="off"/>
									</div>
								</li>
							</ul>
                        </div>
                    </div>
    
                    <div class="form_input mg_b20">
                        <label class="">파트너사 역할</label>
                        <textarea class="form_control ta_l" row="3" id="textModalPartnerRole" name="textModalPartnerRole"></textarea>
                    </div>
                    
                    <div class="form_input">
                        <label class="">첨부파일</label>
                        <div class="guideBox">
                            파일 첨부는 PC에서만 가능합니다.
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
                    <input type="hidden" name="hiddenModalPartnerId" id="hiddenModalPartnerId"/>
                   
                    <input type="hidden" name="hiddenModalExecId" id="hiddenModalExecId"/>
                    <input type="hidden" name="hiddenModalOwnerId" id="hiddenModalOwnerId"/>
                    <input type="hidden" name="hiddenModalIdentifierId" id="hiddenModalIdentifierId"/>
                    
                    <input type="hidden" name="hiddenModalClientMaster" id="hiddenModalClientMaster"/>
					<input type="hidden" name="hiddenModalClientMasterErpCode" id="hiddenModalClientMasterErpCode"/>
					<input type="hidden" name="hiddenModalTempFlag" id="hiddenModalTempFlag" value="N"/>
                    
                </div>
            <!--// 기본정보 -->
            
	            <div class="cont2 off pd_t10">
	            	
	            	<div class="form_input mg_b20">
                        <label class="">영업단계</label>
                        <select class="form-control" name="selectModalSalesCycle" id="selectModalSalesCycle">
                      			<option value="1">Identify/Validation</option>
                      			<option value="2">Qualification</option>
                      			<option value="3">Negotiation</option>
                      			<option value="4">Close</option>
                   		</select>
                   		<select class="form-control valid" name="selectSalesCloseCategory" id="selectSalesCloseCategory" aria-invalid="false" style="display: none;">
	                        <option value="1">Win</option>
	                        <option value="2">Loss</option>
	                        <option value="3">No-Bid</option>
	                    </select>
                    </div>
                    
					<div class="cont fl_l fs16 pd_l10" style="line-height: 25px;" id="divSalesCycleCheck">
							<!-- Identify/Validation -->
                           	<li data-category="1"><label><input type="checkbox" value="N" name="checkSalesCycle"> 고객 예산과 일정은 계획되어 있습니까 ?</label></li>
                           	<li data-category="1"><label><input type="checkbox" value="N" name="checkSalesCycle"> 고객의 구매의사를 확인하였습니까 ?</label></li>
                           	<li data-category="1"><label><input type="checkbox" value="N" name="checkSalesCycle"> 고객의 요구 사항에 적합한 우리의 솔루션이 있습니까 ?</label></li>
                           	
                           	<!-- Qualification -->
                           	<li data-category="2" style="display:none;"><label><input type="checkbox" value="N" name="checkSalesCycle"> 수익과 위험요소 분석을 충분히 하였습니까 ?</label></li>
                           	<li data-category="2" style="display:none;"><label><input type="checkbox" value="N" name="checkSalesCycle"> 사업 수행을 위한 인력과 지원 서비스는 가능합니까 ?</label></li>
                           	<li data-category="2" style="display:none;"><label><input type="checkbox" value="N" name="checkSalesCycle"> 제안서 작성과 제출을 했습니까 ?</label></li>
                           	
                           	<!-- Negotiation -->
                           	<li data-category="3" style="display:none;"><label><input type="checkbox" value="N" name="checkSalesCycle"> 우선협상대상자에 대한 고객 동의를 받았습니까 ?</label></li>
                           	<li data-category="3" style="display:none;"><label><input type="checkbox" value="N" name="checkSalesCycle"> 계약 범위와 조건에 대해 협의를 완료하였습니까 ?</label></li>
                           	
                           	<!-- Closed -->
                           	<li data-category="4" style="display:none;"><label><input type="checkbox" value="N" name="checkSalesCycle"> 계약을 성공적으로 체결했습니까 ?</label></li>
					</div>
	            </div>
            	
            	<div class="cont3 off pd_t10">
                    <div class="guideBox">
                         승리계획 입력은 PC에서만 가능합니다.
                    </div>
	            </div>
	            
            	<div class="cont4 off pd_t10">
            		<jsp:include page="/WEB-INF/jsp/m/common/milestones.jsp"/>
	            </div>
	            
            	<div class="cont5 off pd_t10">
	            	<jsp:include page="/WEB-INF/jsp/m/clientSalesActive/opportunityModalProduct.jsp"/>
	            	<div class="ta_c">
						<a href="#" class="btn btn-primary r5" id="salesProductBtn" onclick="oppProduct.salesAdd();">
							<span>+ 매출품목 추가</span>
						</a>
						<a href="#" class="btn btn-primary r5" id="psProductBtn" onclick="oppProduct.psAdd();">
							<span>+ 매입품목 추가</span>
						</a>
					</div>
	            </div>
	            
	            <div class="cont6 off pd_t10">
	            	<jsp:include page="/WEB-INF/jsp/m/clientSalesActive/opportunityModalSalesPlan.jsp"/>
	            	<div class="ta_c">
		            	<a href="#" class="btn btn-primary r5" id="salesPlanBtn" onclick="oppSalesPlan.add();">
							<span>+ 매출/수금 계획 추가</span>
						</a>
					</div>
	            </div>
	            
             </form>
 
        </div>

        

    </article>   

</div>
		<div class="pg_bottom_func">
            <ul>
                <li style="width:33.3%"><a href="javascript:void(0);" class="" id="viewopportunityList"> <img src="${pageContext.request.contextPath}/images/m/icon_list.png" /> <span>목록</span></a></li>
                <li style="width:33.3%"><a href="javascript:void(0);" class="" id="insertOpportunity"> <img src="${pageContext.request.contextPath}/images/m/icon_edit.png" /> <span>저장</span></a></li>
                <li style="width:33.3%"><a href="javascript:void(0);" class="" id="erpInsertOpportunity"> <img src="${pageContext.request.contextPath}/images/m/icon_edit.png" /> <span>ERP 연동</span></a></li>
            </ul>
        </div>
<div class="modal_screen"></div>

<!-- Mainly scripts -->
<script src="${pageContext.request.contextPath}/js/m/jquery-1.11.0.js"></script>
<script src="${pageContext.request.contextPath}/js/m/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/jquery.form.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/plugins/validate/jquery.validate.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/plugins/autocomplete/jquery.auto-complete.js?v=1.1"></script>
<script src="${pageContext.request.contextPath}/js/m/common.js?v=1.1"></script>

<script type="text/javascript">
    $(document).ready(function() {
        // 고객컨택내용 목록
        $("#viewopportunityList").on("click", function(e) {
            location.href = '/clientSalesActive/viewOpportunityList.do';
            e.preventDefault();
        });    
        
        // 저장 
        $("#insertOpportunity").on("click", function(e) {
            insertOpportunity(false);
            e.preventDefault();
        });    
        
        // 저장 
        $("#erpInsertOpportunity").on("click", function(e) {
            insertOpportunity(true);
            e.preventDefault();
        });    
        
      	//거래처영업대표 검색
		$("#formModalData #textDuzonSearchSalesMan").keydown(function(e) { 
		    if (e.keyCode == 13){
		    	//duzonSearch.salesManPopOpp();
		    	selectClientSalesmanInfo();
		    }    
		});
      
        pageInit();
        
        <c:choose>
	        <c:when test="${mode eq 'upd'}">
	        updateDetail('${pkNo}');
	        </c:when>
	        <c:otherwise>
	        </c:otherwise>
	    </c:choose>
		
		function check_device(){ 
			var mobileKeyWords = new Array('iPhone', 'iPod', 'BlackBerry', 'Android', 'Windows CE', 'LG', 'MOT', 'SAMSUNG', 'SonyEricsson'); 
			var device_name = ''; 
			for (var word in mobileKeyWords){ 
				if (navigator.userAgent.match(mobileKeyWords[word]) != null){ 
					device_name = mobileKeyWords[word];
					break; 
				}
			} 
			return device_name;
		}

		// device check 
		var device = check_device(); 
		if(device !=''){
			 //$('#textModalContractDate').css('width', 390); // '100%'
		}
		
		//sales cycle 영업단계
		$("select#selectModalSalesCycle").on("change",function(){
			if($(this).val() == "4"){
        		$("#selectSalesCloseCategory").show();
        	}else{
        		$("#selectSalesCloseCategory").hide();
        	}
			$("#hiddenModalSalesCycle").val($(this).val());
			$("input[name='checkSalesCycle']").parent().parent("li").hide();
			$("input[name='checkSalesCycle']").parent().parent("li[data-category='"+$(this).val()+"']").show();
        });
		
	});
	
	//고객담당자 ERP 연동 하기~		
    function updateClientMasterErpCd(clientErpCd){
		$.post("/clientSalesActive/updateClientMasterErpCd.do", { customer_id: $("#hiddenModalClientMaster").val(), clientErpCd: clientErpCd }).done(function( data ) {
		    alert("연동되었습니다.");
		    $("#hiddenModalClientMasterErpCode").val(clientErpCd);
		    $("#divSingleClientMasterErr").hide();
		});
    }
    
    //고객담당자 ERP 연동 체크~
    function checkClientMaster(callback){
    	var flag = true;
		$.post("/clientSalesActive/selectClientMasterErpCd.do", { customer_id: $("#hiddenModalClientMaster").val()}).done(function( data ) {
			callback(data.ERP_CLIENT_CODE);
		});
    }
    
    function selectClientSalesmanInfo(){
    	//고객담당자 ERP에서 가져옴..ㅋㅋㅋ
		$.post("/duzon/selectClientSalesmanInfo2.do",function(){});
		setTimeout(function(){
			duzonSearch.salesManPopOpp();
		},3500);
    }
    
    //영업단계~
    function fnScCheckList(){
		var list = new Array();
		$('input[name="checkSalesCycle"]').each(function(idx, val){
			var map = new Object();
			map.check_seq = (idx+1);
			map.check_yn = ($(this).prop("checked") == true) ? "Y" : "N";
			list.push(map);
		});		
		return list;
	}
	
	
    function fncSelectTab(_no){
		// 탭 이동
		$('#tab_1').removeClass('active');
		$('#tab_2').removeClass('active');
		$('#tab_3').removeClass('active');
		$('#tab_4').removeClass('active');
		$('#tab_5').removeClass('active');
		$('#tab_6').removeClass('active');
		$('#tab_'+_no).addClass('active');
		
		// 탭에 해당하는 컨테이너 보여주기
		$('.cont1').addClass('off');
		$('.cont2').addClass('off');
		$('.cont3').addClass('off');
		$('.cont4').addClass('off');
		$('.cont5').addClass('off');
		$('.cont6').addClass('off');
		$('.cont'+_no).removeClass('off');
	}
    

    
    // 초기 페이지 구성에 필요한 정보를 세팅한다.
    function pageInit() {
    	validate();
    	
    	
		commonSearch.singleMember($("#formModalData #textModalExecOwner"), $('#formModalData #liModalSingleExecOwner'), $('#formModalData #hiddenModalExecId')); //실행임원
		commonSearch.singleMember($("#formModalData #textModalOpportunityOwner"), $('#formModalData #liModalSingleOwner'), $('#formModalData #hiddenModalOwnerId')); //OO
		commonSearch.singleMember($("#formModalData #textModalOpportunityIdentifier"), $('#formModalData #liModalSingleIdentifier'), $('#formModalData #hiddenModalIdentifierId')); //OI
		commonSearch.singleClientMaster($("#formModalData #textModalSingleClientMaster"), $('#formModalData #liModalSingleClientMaster'), $('#formModalData #hiddenModalClientMaster'), $('#formModalData #hiddenModalClientMasterErpCode')); //고객 담당자
		commonSearch.singleCompany($("#formModalData #textModalSingleCompany"), $('#formModalData #liModalSingleCompany'), $('#formModalData #hiddenModalCompanyId')); //고객사
		commonSearch.singleCompany($("#formModalData #textModalSingleClient"), $('#formModalData #liModalSingleClient'), $('#formModalData #hiddenModalCustomerId')); //고객명
		commonSearch.multiplePartner($("#formModalData #textMultiplePartner"), $('#formModalData #hiddenModalPartnerId'), $('#formModalData #ulMultiplePartner')); //파트너
		
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
        
    function validate () {
        $("#formModalData").validate({ // joinForm에 validate를 적용
            ignore: '', 
            rules : {
                textModalSubject : {
                    required : true,
                    maxlength : 100
                },
                hiddenModalOwnerId : {
                    required : true
                },
                hiddenModalIdentifierId : {
                    required : true
                },
                hiddenModalCompanyId : {
                    required : true,
                },
                hiddenModalCustomerId : {
                    required : true
                },
                textModalContractAmount : {
                    required : true
                },
                textModalGPAmount : {
                    required : true
                },
                textModalContractDate : {
                    required : true
                },
                textModalContractStDate : {
					required : true
				},
				textModalContractEdDate : {
					required : true
				},
				selectModalCategoryCd : {
					required : true
				},
				selectModalTypeCd : {
					required : true
				},
				selectModalProjectForm : {
					required : true
				},
				selectModalClientCategoryCd : {
					required : true
				},
				selectModalBuyCd : {
					required : true
				},
				hiddenModalClientMaster : {
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
                hiddenModalOwnerId : {
                    required : "Owner을 입력하세요.",
                },
                hiddenModalIdentifierId : {
                    required : "영업대표를 입력하세요.",
                },
                hiddenModalCompanyId : {
                    required : "매출처를 입력하세요."
                },
                hiddenModalCustomerId : {
                    required : "End User를 입력하세요."
                },
                textModalContractAmount : {
                    required : "예상계약금액을 입력하세요."
                },
                textModalContractDate : {
                    required : "예상계약일를 선택하세요."
                },
                textModalContractStDate : {
					required : "계약 시작일을 선택하세요."
				},
				textModalContractEdDate : {
					required : "계약 종료일을 선택하세요."
				},
				selectModalCategoryCd : {
					required : "영업구분을 선택해 주세요."
				},
				selectModalTypeCd : {
					required : "영업유형을 선택해 주세요."
				},
				selectModalProjectForm : {
					required : "프로젝트형태를 선택해 주세요."
				},
				selectModalClientCategoryCd : {
					required : "고객구분을 선택해 주세요."
				},
				selectModalBuyCd : {
					required : "구매방법을 선택해 주세요."
				},
				hiddenModalClientMaster : {
					required : "고객담당자를 입력하세요."
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
                	$("#ulModalSingleOwner").after(error);
                    location.href = "#textModalOpportunityOwner";
                }else if($(element).prop("id") == "hiddenModalIdentifierId") {
                    $("#ulModalSingleIdentifier").after(error);
                    location.href = "#textModalOpportunityIdentifier";
                }else if($(element).prop("id") == "hiddenModalCompanyId") {
                	$("#ulModalSingleCompany").after(error);
                    location.href = "#textCommonSearchCompany";
                }else if($(element).prop("id") == "hiddenModalCustomerId") {
                	$("#ulModalSingleClient").after(error);
                    location.href = "#textModalCustomerName";
                }else if($(element).prop("id") == "hiddenModalClientMaster") {
			        $("#ulModalSingleClientMaster").after(error);
			        location.href = "#textModalSingleClientMaster";
			    }else{
                    error.insertAfter(element); // default error placement.
                    location.href = "#"+$(element).prop("id");
                    
                }
                fncSelectTab('1');
            }
        });        
    }    
    
    
    
    function insertOpportunity(erpSubmitFlag) {
        var url = "/clientSalesActive/insertOpportunity.do";
        <c:if test="${mode eq 'upd'}">
            url = "/clientSalesActive/updateOpportunity.do";
        </c:if>
        
        var scCheckList = fnScCheckList(); //영업단계
        milestones.msAddListMaster(); //마일스톤
        var productFlag = oppProduct.setList(false); //매출/매입 품목
        oppSalesPlan.calSalesPlan(); // 매출계획
        
      	//고객담당자 체크
		checkClientMaster(function(client_code){
			$("#hiddenModalClientMasterErpCode").val(client_code);
		});
        
        //예상계약금액, 예상GP금액
        $("#hiddenModalContractAmount").val($("#textModalContractAmount").val());
        $("#hiddenModalGPAmount").val($("#textModalGPAmount").val());
        $("#hiddenModalContractAmount").val(uncomma($("#textModalContractAmount").val()));
        
        $('#formModalData').ajaxForm({
            url : url,
            async : true,
            data : {
            	scCheckList :JSON.stringify(scCheckList),
            	productSalesData : JSON.stringify(oppProduct.salesList),
    			productPsData : JSON.stringify(oppProduct.psList),
            	salesSplitData : '[]',
                mileStoneData :JSON.stringify(milestones.msList),
                checkListData :'[]', //PC버전과의 호환성을 위해 셋팅.  JSON파싱 오류로 인해 셋팅한 후 넘김. 
                winMasterList   :'[]', //PC버전과의 호환성을 위해 셋팅.  JSON파싱 오류로 인해 셋팅한 후 넘김. 
                winSubList   :'[]', //PC버전과의 호환성을 위해 셋팅.  JSON파싱 오류로 인해 셋팅한 후 넘김. 
                salesPlanData : JSON.stringify(oppSalesPlan.salesPlanList)
            },
            beforeSubmit: function (data,form,option) {
            	//고객담당자 체크
            	if(erpSubmitFlag & isEmpty($("#hiddenModalClientMasterErpCode").val())){
            		$("#divSingleClientMasterErr").show();
            		document.getElementById("divSingleClientMasterErr").scrollIntoView(); 
            		fncSelectTab('1');
            		return false;
            	}
            	
            	if(!productFlag){
            		fncSelectTab('5'); 
            		return false;
            	} 
            	
            	if(!erpSubmitFlag){
    				if(!confirm("저장하시겠습니까?")) return false;
    			}else{
    				if(!confirm("전환하시겠습니까?")) return false;
    			}
            },
            beforeSend : function(xhr){
                xhr.setRequestHeader("AJAX", true);
            },
            success: function(data){
            	if(!erpSubmitFlag){
	                if(data.cnt > 0){
	                    alert("저장하였습니다.");
	                    //$('#contactPK').val(data.returnPK);
	                    //console.log($('#contactPK').val());
	                    window.location.href = "/clientSalesActive/selectOpportunityDetail.do?pkNo="+data.pkNo;
	                } else {
	                    alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
	                }
            	} else{
            		submitErp(data.pkNo); //ERP 연동
            	}
            },
            complete: function() {
            },
            error: function(){
                //에러발생을 위한 code페이지
                alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
            }   
        });
        $('#formModalData').submit();
    }
    
    function submitErp(pkNo){
    	$.ajax({
			url : "/duzon/updateOppToErp.do",
			datatype : 'json',
			beforeSend : function(xhr){
			},
			data :{
				pkNo: pkNo
			},
			success : function(data){
				alert("ERP 영업기회에 등록하였습니다.");
				window.location.href = "/clientSalesActive/selectOpportunityDetail.do?pkNo="+pkNo;
			},
			complete : function(){
			}
		});
    }
	
    function updateDetail(_pkNo) {

        //상세정보를 가져와서 수정정보에 셋팅
        $.ajax({
            url : "/clientSalesActive/selectOpportunityDetail.do",
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
                // gridClientIndividualInfo << 이거랑 같이 쓰고 있는거 같아서 일단 안바꾸고 위의 URL로 가져왔습니다.
                var rowData = data.detail;
                var fileList = data.fileList;
    			var scCheckList = data.scCheckList;
    			var winPlanList = data.winPlanList;
    			var milestonesList = data.milestonesList;
    			var productSalesList = data.productSalesList;
    			var productPsList = data.productPsList;
    			var salesPlanList = data.salesPlanList;
    			
                
                //초기화
                $("#formModalData").validate().resetForm();
                
             
                /*********** 기본정보 start  ***************/
                //기본정보
                $("#hiddenModalPK").val(rowData.OPPORTUNITY_ID);
                $("#textModalSubject").val(rowData.SUBJECT);
                
              	//매출처	
    			if(rowData.COMPANY_ID){
    	         	$("a[name='aMoveSingleCompany']").remove();
    	         	$("#textModalSingleCompany").hide();
    	         	$("#hiddenModalCompanyId").val(rowData.COMPANY_ID);
    	         	$('#liModalSingleCompany').before(
    	         			'<li class="value">' +
    						'<span class="txt" id="'+rowData.COMPANY_ID+'">'+rowData.COMPANY_NAME+'</span>' +
    						'<a href="javascript:void(0);" class="remove" onclick="commonSearch.removeSingleCompany(this);"><i class="fa fa-times-circle"></i></a></li>'
    				);
    			}else{
    				$("#textModalSingleCompany").show();				
    			}
              
    			//End User
            	if(rowData.CUSTOMER_ID){
    	        	$("#textModalSingleClient").hide();
    	         	$("#hiddenModalCustomerId").val(rowData.CUSTOMER_ID);
    	         	$('#liModalSingleClient').before(
    	         			'<li class="value">' +
    						'<span class="txt" id="'+rowData.CUSTOMER_ID+'">'+rowData.CUSTOMER_NAME+'</span>' +
    						'<a href="javascript:void(0);" class="remove" onclick="commonSearch.removeSingleCompany(this);"><i class="fa fa-times-circle"></i></a></li>'
    				);
            	}else{
            		$("#textModalSingleClient").show();
            	}
    			
            	//예상계약금액
                if(!isEmpty(rowData.CONTRACT_AMOUNT)){
                    $("#textModalContractAmount").val(add_comma((rowData.CONTRACT_AMOUNT).toString()));
                }else{
                    $("#textModalContractAmount").val(0);
                }
                $("#textModalContractDate").val(rowData.CONTRACT_DATE); //계약일
    			$("#textModalContractStDate").val(rowData.CONTRACT_ST_DATE); //계약 시작일
    			$("#textModalContractEdDate").val(rowData.CONTRACT_ED_DATE); //계약 종료일
    			$("#textModalErpOppCode").val(rowData.ERP_OPP_CD); //ERP 영업기회 코드
    			$("#textModalErpProjectCode").val(rowData.ERP_PROJECT_CODE); //ERP 프로젝트 코드
                
    			//Forecast YN
    			if(isEmpty(rowData.FORECAST_YN)){
                    $("input:radio[name='radioModalForecastYN']").prop("checked",false);
                }else{
                    $("input:radio[name='radioModalForecastYN']:radio[value='"+rowData.FORECAST_YN+"']").prop("checked",true);  
                }
    			
    			
               //ERP 전환
    			if(isEmpty(rowData.ERP_OPP_CD) && rowData.SALES_CYCLE == "5"){
    				$("#insertOpportunity").unbind("click");
    				$("#erpInsertOpportunity").unbind("click");
    			}else if(!isEmpty(rowData.ERP_OPP_CD)){
    				$("#erpInsertOpportunity").unbind("click");
    			}
                
    			//실행임원
    			if(rowData.EXEC_ID){
    				$("#textModalExecOwner").hide();
    				$("#hiddenModalExecId").val(rowData.EXEC_ID);
                 	$('#liModalSingleExecOwner').before(
                 			'<li class="value">' +
    						'<span class="txt" id="'+rowData.EXEC_ID+'">'+rowData.EXEC_NAME+' ['+ rowData.EXEC_POSITION +']</span>' +
    						'<a href="javascript:void(0);" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalExecOwner\',\'liModalSingleExecOwner\',\'hiddenModalExecId\');"><i class="fa fa-times-circle"></i></a></li>'
    				);	
    			}else{
    				$("#textModalExecOwner").show();
    			}
    			
    			//Owner
    			$("#textModalOpportunityOwner").hide();
    			$("#hiddenModalOwnerId").val(rowData.OWNER_ID);
             	$('#liModalSingleOwner').before(
             			'<li class="value">' +
    					'<span class="txt" id="'+rowData.OWNER_ID+'">'+rowData.OWNER_NAME+' ['+ rowData.OWNER_POSITION +']</span>' +
    					'<a href="javascript:void(0);" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalOpportunityOwner\',\'liModalSingleOwner\',\'hiddenModalOwnerId\');"><i class="fa fa-times-circle"></i></a>'
    			);
             	
    			//영업대표
    			$("#textModalOpportunityIdentifier").hide();
    			$("#hiddenModalIdentifierId").val(rowData.IDENTIFIER_ID);
             	$('#liModalSingleIdentifier').before(
             			'<li class="value">' +
    					'<span class="txt" id="'+rowData.IDENTIFIER_ID+'">'+rowData.IDENTIFIER_NAME+' ['+ rowData.IDENTIFIER_POSITION +']</span>' +
    					'<a href="javascript:void(0);" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\'textModalOpportunityIdentifier\',\'liModalSingleIdentifier\',\'hiddenModalIdentifierId\');"><i class="fa fa-times-circle"></i></a>'
    			);
                
             	$("#selectModalCategoryCd").val(rowData.CATEGORY_CD); //영업구분
             	$("#selectModalTypeCd").val(rowData.TYPE_CD); //영업유형
             	$("#selectModalProjectForm").val(rowData.PROJECT_FORM_CD); //프로젝트 형태
             	$("#selectModalClientCategoryCd").val(rowData.ERP_CLIENT_CATEGORY_CD); //고객구분
    			
             	//고객담당자
             	$("#hiddenModalClientMasterErpCode").val("");
             	$("#divSingleClientMasterErr").hide();
             	$("#aMoveSingleClientMaster").remove();
             	if(rowData.ERP_CLIENT_CD){
    				$("#textModalSingleClientMaster").hide();
    				$("#hiddenModalClientMaster").val(rowData.ERP_CLIENT_CD);
    				$("#hiddenModalClientMasterErpCode").val(rowData.ERP_CLIENT_CODE);
                 	$('#liModalSingleClientMaster').before(
                 			'<li class="value">' +
    						'<span class="txt" id="'+rowData.ERP_CLIENT_CD+'">'+rowData.ERP_CLIENT_NAME+' ['+ rowData.ERP_CLIENT_COMPANY_NAME +']</span>' +
    						'<a href="javascript:void(0);" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleClientMaster(\'textModalSingleClientMaster\',\'liModalSingleClientMaster\',\'hiddenModalClientMaster\',\'hiddenModalClientMasterErpCode\');"><i class="fa fa-times-circle"></i></a></li>'
    				);
             	}else{
             		$("#textModalSingleClientMaster").show();
    				$("#hiddenModalClientMaster").val("");
    				$("#hiddenModalClientMasterErpCode").val("");
             	}
                
             	$("#selectModalBuyCd").val(rowData.BUY_CD); //구매방법
             	$("#textareaModalDetailConents").val(rowData.DETAIL_CONENTS); //사업내용
             	$("#textareaModalDiscriminateValue").val(rowData.DISCRIMINATE_VALUE); //차별화가치
             	$("#textModalRoute").val(rowData.ROUTE); //ROUTE
             	
             	
             	//파트너사
             	commonSearch.multiplePartnerArray = [];
    			commonSearch.selectMultiplePartner(rowData.SALES_PARTNER, $("#formModalData #hiddenModalPartnerId"), $('#formModalData #ulMultiplePartner'));
             	$("#textModalPartnerRole").val(rowData.PARTNER_ROLE); //파트너사 역할
             	
                
                $("h2.modal-title").html(rowData.SUBJECT);
             	
                /*********** 기본정보 end  ***************/
                
             	
             	/*********** 영업단계 start ***************/
             	
            	//영업단계 체크 항목
            	$("#hiddenModalSalesCycle").val(rowData.SALES_CYCLE);
            	$('div#divSalesCycleCheck li').hide();
          		for(var i=0; i<scCheckList.length; i++){
          			var scCheckMap = scCheckList[i];
          			if(scCheckMap.CHECK_YN == "Y"){
          				$('div#divSalesCycleCheck input[name="checkSalesCycle"]').eq(i).prop("checked",true);	
          				$('div#divSalesCycleCheck input[name="checkSalesCycle"]').eq(i).val("Y");	
          			}else{
          				$('div#divSalesCycleCheck input[name="checkSalesCycle"]').eq(i).prop("checked",false);
          				$('div#divSalesCycleCheck input[name="checkSalesCycle"]').eq(i).val("N");
          			}
            	}
          		
          		//클로즈된 영업기회는 salesCycle 막고 저장하기 막는다.
    			if(rowData.SALES_CYCLE == "5"){
    				$("#selectModalSalesCycle").val("4");
    				$("#selectSalesCloseCategory").show();
    				$("#selectSalesCloseCategory").val(rowData.CLOSE_CATEGORY);
    				
    				$('div#divSalesCycleCheck input[name="checkSalesCycle"]').prop("disabled",true);
    				$('div#divSalesCycleCheck li[data-category="4"]').show();
    				//insertOpportunity
    				//erpInsertOpportunity
    				
    				$("#insertOpportunity").unbind("click");
    				$("#erpInsertOpportunity").unbind("click");
    				$("#hiddenModalSalesCycleSave").val("5");
    			}else{
    				$("#selectModalSalesCycle").val(rowData.SALES_CYCLE);
    				$("#selectSalesCloseCategory").hide();
    				$("#selectSalesCloseCategory option:first").prop("selected",true);
    				
    				$('div#divSalesCycleCheck input[name="checkSalesCycle"]').prop("disabled",false);
    				$('div#divSalesCycleCheck li[data-category="'+(rowData.SALES_CYCLE)+'"]').show();
    				
    				if(rowData.SALES_CYCLE == "4"){ //close일경우
    					$("#selectSalesCloseCategory").show();
    					$("#selectSalesCloseCategory").val(rowData.CLOSE_CATEGORY);
    				}
    				
    			}
          		/*********** 영업단계 end ***************/
          		
          		
          		/*********** 마일스톤 start ***************/
          		
    			milestones.reset();
    			milestones.draw(milestonesList);
    			
    			
    			/*********** 마일스톤 end ***************/
    			
    			
    			/*********** 매출/매입 품목 start ***************/
    			//매출품목
    			setTimeout(function(){
	             	if(productSalesList.length > 0){
	             		$("div#divSales").find("div[name='divSales_sub']").remove();
	             		for(var i=0; i<productSalesList.length; i++){
	             			var salesMap = productSalesList[i];
	             			oppProduct.setSalesAdd(oppProduct.salesSetData, salesMap);
	            		}
	             	}
    			}, 500);
    			
    			//매입품목
    			setTimeout(function(){
    				if(productPsList.length > 0){
    					$("div#divPs").find("div[name='divPs_sub']").remove();
                 		for(var i=0; i<productPsList.length; i++){
                 			var psMap = productPsList[i];
                 			oppProduct.setPsAdd(oppProduct.psSetData, psMap);
                 		}
                 	}
    			}, 500);
    			
    			/*********** 매출/매입 품목 end ***************/
    			
    			/*********** 매출/수금 계획 start ***************/
             	//매출계획
             	setTimeout(function(){
	             	if(salesPlanList.length > 0){
	             		oppSalesPlan.reset();
	             		for(var i=0; i<salesPlanList.length; i++){
	             			var salePlanMap = salesPlanList[i];
	             			oppSalesPlan.add();
	             			oppSalesPlan.setData(salePlanMap);
	             		}
	             	}else{
	             		oppSalesPlan.add();
	             	}
             	}, 600);
             	/*********** 매출/수금 계획 end ***************/
    			
            },
            complete : function(){
            }
        });
        
    }    
    
    
</script>
</body>
</html>