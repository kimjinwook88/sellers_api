<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>
<%@ include file="/WEB-INF/jsp/m/common/cache.jsp" %>
<%@ include file="/WEB-INF/jsp/m/common/functions.jsp" %>
<%
	String req_params = getReqParams(request, "mode", "companyId", "customerId", "hiddenModalPK", "salesStatus");
	request.setAttribute("req_params", req_params);
	
	//오늘 날짜 저장.
	Calendar todayCal = Calendar.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd");
	//int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));
	String todayDate = sdf.format(todayCal.getTime());
%>
    
<article class="">
	<div class="title_pg ta_c">
		<h2 class="" id="COMPANY_NAME">
			<c:choose>
				<c:when test="${map.mode eq 'upd'}">
					<h2>${defaultInfo[0].PARTNER_PERSONAL_NAME} <span class="fs12">${defaultInfo[0].POSITION}</span></h2>
				</c:when>
				<c:otherwise>
					<h2>파트너사개인 신규 등록</h2>
				</c:otherwise>
			</c:choose>
		</h2>
		<a href="javascript:void(0);" class="btn_back" onclick="window.history.back(); return false;">back</a>
	</div>

  <div class="author">
      <span>${userInfo.HAN_NAME}(<%=todayDate%>)</span>
  </div>
        
  <ul class="tabmenu tabmenu_type2 mg_b20">
      <li><a href="#" id="tab_1" onclick="fncSelectTab('1'); return false;" class="active">기본정보</a></li>
      <li><a href="#" id="tab_2" onclick="fncSelectTab('2'); return false;">소속사정보</a></li>
  </ul>

  <form id="formModalData" name="formModalData" method="post" enctype="multipart/form-data" class="form-horizontal">
		<div class="pg_cont pd_t10">
			<div class="cont1" id="formTab1"><!-- 기본정보 -->

	      <div class="form_input mg_b20">
	          <label class="">파트너사직원명 <span style="color:red;">*</span></label>
	          <input type="text" name="textModalPartnerName" id="textModalPartnerName" value="${defaultInfo[0].PARTNER_PERSONAL_NAME}" placeholder="" class="form_control" />
	      </div>
	
	      <div class="form_input mg_b20">
	          <label class="">직급</label>
	          <input type="text" name="textModalPosition" id="textModalPosition" value="${defaultInfo[0].POSITION}" placeholder="" class="form_control" />
	      </div>
	
	      <div class="form_input mg_b20">
	          <label class="">휴대전화 (ex:01012345678)</label>
	          <input type="text" name="textModalCellPhone" id="textModalCellPhone" value="${defaultInfo[0].CELL_PHONE}" placeholder="" class="form_control" />
	      </div>
	
	      <div class="form_input mg_b20">
	          <label class="">직장전화 (ex:0212345678)</label>
	          <input type="text" name="textModalPhone" id="textModalPhone" value="${defaultInfo[0].PHONE}" placeholder="" class="form_control" />
	      </div>
	
	      <div class="form_input mg_b20">
	          <label class="">이메일</label>
	          <input type="text" name="textModalEmail" id="textModalEmail" value="${defaultInfo[0].EMAIL}" placeholder="" class="form_control" />
	      </div>

<%--
        <div class="h_line pd_t10"></div>

        <div class="form_input mg_b20">
            <label class="">개인정보</label>
            <textarea name="textModalPerSonalInfo" id="textModalPerSonalInfo" class="form_control" row="3">${defaultInfo[0].PERSONALINFO}</textarea>
        </div>

        <div class="form_input mg_b20">
            <label class="">명함첨부</label>

            <a href="#" id="photo_upload" class="btn lg btn-gray ds_b r5 ta_c">명함 첨부</a> <!-- 사진첨부 또는 촬영사진 첨부 -->

						<input type="file" name="fileModalUploadPhoto" id="fileModalUploadPhoto" accept="image/*"
						capture="camera" onchange="getThumbnailPrivew(this,$('#divModalUploadPhoto'))" style="display:none" />

                        <div class="photo_input" id="divModalUploadPhoto">
						<c:if test="${defaultPhoto[0].FILE_NAME ne null && defaultPhoto[0].FILE_NAME ne ''}"> 
						                            <img src="/uploads/${defaultPhoto[0].FILE_PATH}${defaultPhoto[0].FILE_NAME}" alt="명함 사진" />
						</c:if>
         </div>
       </div>
 --%>
 
			</div>

			<!-- 소속사정보 -->
			<div class="cont2 off" id="formTab2">
		
		    <div class="form_input mg_b20">
	        <label for="textCommonSearchCompany" class="">파트너사 <span style="color:red;">*</span></label>
	        <%-- <input type="text" name="textCommonSearchCompany" id="textCommonSearchCompany" value="${defaultInfo[0].COMPANY_NAME}" placeholder="" class="form_control" autocomplete="off" /> --%>
		    	<ul class="flexdatalist-multiple" id="ulModalCompanyName" name="ulModalCompanyName" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
              <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalCompanyName" name="liModalCompanyName" >
                  <div class="pos-rel">
                      <input type="text" class="form_control" id="textCommonSearchCompany" name="textCommonSearchCompany" placeholder="파트너사 입력" autocomplete="off"/>
                  </div>
              </li>
          </ul>
		    </div>
		
		    <div class="form_input mg_b20">
		        <label class="">파트너사ID</label>
		        <input type="number" name="textCommonSearchCompanyId" id="textCommonSearchCompanyId" value="${defaultInfo[0].PARTNER_ID}" placeholder="" class="form_control" readonly="true" style="background-color:#eee; opacity:1"/>
		    </div>
		
		    <div class="form_input mg_b20">
		        <label class="">소속본부</label>
		        <input type="text" name="textModalDivision" id="textModalDivision" value="${defaultInfo[0].DIVISION}" placeholder="" class="form_control" />
		    </div>
		
		    <div class="form_input mg_b20">
		        <label class="">소속부서</label>
		        <input type="text" name="textModalPost" id="textModalPost" value="${defaultInfo[0].POST}" placeholder="" class="form_control" />
		    </div>
		
		    <div class="form_input mg_b20">
		        <label class="">소속팀</label>
		        <input type="text" name="textModalTeam" id="textModalTeam" value="${defaultInfo[0].TEAM}" placeholder="" class="form_control" />
		    </div>
		    
		    <div class="form_input mg_b20">
		        <label class="">직책</label>
		        <input type="text" name="textModalPositionDuty" id="textModalPositionDuty" value="${defaultInfo[0].POSITION_DUTY}" placeholder="" class="form_control" />
		    </div>
		
		    <div class="form_input mg_b20">
		        <label class="">담당업무</label>
		        <input type="text" name="textModalDuty" id="textModalDuty" value="${defaultInfo[0].DUTY}" placeholder="" class="form_control" />
		    </div>
		
		    <div class="form_input mg_b20">
		        <label class="">친한고객사</label>
		        <input type="text" name="textModalFriendShipCompany" id="textModalFriendShipCompany" value="${defaultInfo[0].FRIENDSHIP_COMPANY}" placeholder="" class="form_control" />
		    </div>
		
		    <div class="form_input mg_b20">
		        <label class="">친한고객</label>
		        <input type="text" name="textModalFriendShipCustomer" id="textModalFriendShipCustomer" placeholder="${defaultInfo[0].FRIENDSHIP_CUSTOMER}" class="form_control" />
		    </div>
		
		    <div class="form_input mg_b20">
		        <label class="">개인정보</label>
		        <textarea name="textModalPerSonalInfo" id="textModalPerSonalInfo" class="form_control" row="3">${defaultInfo[0].PERSONAL_INFO}</textarea>
		    </div>
		    
		    <div class="form_input">
					<label class="">기타</label>
					<div class="guideBox">명함첨부는 PC에서만 가능합니다.
					</div>
				</div>
		
		    <%-- <div class="form_input mg_b20">
	        <label class="">명함첨부</label>
		
	        <a href="#" id="photo_upload" class="btn lg btn-gray ds_b r5 ta_c">명함 첨부</a> <!-- 사진첨부 또는 촬영사진 첨부 -->
		
					<input type="file" name="fileModalUploadPhoto" id="fileModalUploadPhoto" accept="image/*"
						capture="camera" onchange="getThumbnailPrivew(this,'divModalUploadPhoto');" style="display:none" />
		
	        <div class="photo_input" id="divModalUploadPhoto">
						<c:if test="${defaultPhoto[0].FILE_NAME ne null && defaultPhoto[0].FILE_NAME ne ''}"> 
							<img src="/uploads/${defaultPhoto[0].FILE_PATH}${defaultPhoto[0].FILE_NAME}" alt="명함 사진" />
						</c:if>
       		</div>
    		</div> --%>
		
			</div>

   	</div>
        
   	<input type="hidden" id="mode" name="mode" value="${map.mode}" />
		<input type="hidden" name="hiddenModalPK" id="hiddenModalPK" value="${defaultInfo[0].PARTNER_INDIVIDUAL_ID}" />
		<input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}" />
		<input type="hidden" name="hiddenModalCompanyId" id="hiddenModalCompanyId" value="${defaultInfo[0].PARTNER_ID}" />
		<input type="hidden" name="hiddenModalCompanyName" id="hiddenModalCompanyName" value="${defaultInfo[0].COMPANY_NAME}" />
		<input type="hidden" name="hiddenModalPrevSalesMemberId" id="hiddenModalPrevSalesMemberId" />
		<input type="hidden" name="textModalSkillType" id="textModalSkillType" value="none" />
		<input type="hidden" name="radioModalUseYN" id="radioModalUseYN" value="Y" />
		<input type="hidden" name="hiddenModalPartnerId" id="hiddenModalPartnerId" value="${defaultInfo[0].PARTNER_ID}" />
	</form>

	<div class="pg_bottom_func">
	    <ul>
	        <li><a href="/partnerManagement/viewPartnerIndividualInfoGate.do<c:if test="${req_params ne ''}">?${req_params}</c:if>" class=""> <img src="../../../images/m/icon_list.png" /> <span>목록</span></a></li>
	        <li><a href="#" id="btn_submit" class="" onclick="partnerSearch.submit();"> <img src="../../../images/m/icon_edit.png" /> <span>저장</span></a></li>
	    </ul>
	</div>
	
</article>   

<form id="formDetail">
	<input type="hidden" id="customer_id" name="customer_id">
	<input type="hidden" id="company_id" name="company_id">
	<input type="hidden" id="search_detail" name="search_detail">
	
	<input type="hidden" id="serchInfo" name="serchInfo">
	<input type="hidden" id="search_result" name="search_result" value="Y" />
	<input type="hidden" id="pageStart" name="pageStart" value="1" />
	<input type="hidden" id="pageEnd" name="pageEnd" value="10000" />
	<input type="hidden" id="serch" name="serch" value="2" />
	
	<input type="hidden" id="companyId" name="companyId">
	<input type="hidden" id="customerId" name="customerId" value="">
	<input type="hidden" id="hiddenModalPK" name="hiddenModalPK" value="">
	<input type="hidden" id="salesStatus" name="salesStatus" value="1">
</form>
</form> 

<jsp:include page="/WEB-INF/jsp/m/common/bottom.jsp"/>

<STYLE TYPE="text/css" media="all">
.ui-autocomplete { 
    position: absolute; 
    cursor: default; 
    height: 200px; 
    overflow-y: scroll; 
    overflow-x: hidden;}
</STYLE>

<script type="text/javascript">
	var req_params ='${req_params}';
</script>

<script src="${pageContext.request.contextPath}/js/m/view/partnerManagement/formPartnerIndividualInfoDetailView.js"></script>

