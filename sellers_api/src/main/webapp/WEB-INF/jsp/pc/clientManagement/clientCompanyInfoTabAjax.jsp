<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>

<div id="tab2-1" class="tab-pane active">
	<div class="pull-right pos_t10m">
	 <c:if test="${gridClientCompanyInfo[0].COMPANY_NAME ne '' && gridClientCompanyInfo[0].COMPANY_NAME ne null}">
	 		<!-- CRUD 권한 가진 사람만 수정가능 -->
	 		<%-- <c:if test="${fn:contains(auth, 'ROLE_CRUD')}"> --%>
	 		<button class="btn btn-white btn-sm" id="buttonUpdateClientCompany" onClick="detail.update();"> 정보수정 </button>
			<%-- </c:if> --%>
		</c:if>
	</div>
	
		<h2>고객사 정보</h2>

	<div class="custom-basic">
<%-- <div class="col-lg-4 ag_c pos-rel custom-photo">
       <c:if test="${defaultPhoto[0].FILE_PATH ne '' && defaultPhoto[0].FILE_PATH ne null}">
           <span class="" style="background:url('../photo/${defaultPhoto[0].FILE_PATH}${defaultPhoto[0].FILE_NAME}') no-repeat center center; background-size:cover;"></span>
       </c:if>
 			</div> --%>
		<div class="view_pg_type1">
			<div class="form-group topline pd-t10">
				<label class="col-sm-2 control-label ag_r"><span>고객사명</span></label>
				<div class="col-sm-2">${gridClientCompanyInfo[0].COMPANY_NAME}</div>
				<label class="col-sm-2 control-label ag_r"><span>고객사ID</span></label>
				<div class="col-sm-2">${gridClientCompanyInfo[0].COMPANY_ID}</div>
			</div>
			<div class="form-group pd-t10" style="display: none;">
				<label class="col-sm-2 control-label ag_r"><span>CEO</span></label>
				<div class="col-sm-2">
					<a onclick="goDetail.client('${gridClientCompanyInfo[0].CEO_ID}', '${gridClientCompanyInfo[0].COMPANY_ID}', '${gridClientCompanyInfo[0].CEO_NAME}')">
						${gridClientCompanyInfo[0].CEO_NAME} ${gridClientCompanyInfo[0].CEO_POSITION}</a>
				</div>
				<label class="col-sm-2 control-label ag_r"><span>COO</span></label>
				<div class="col-sm-2">
					<a onclick="goDetail.client('${gridClientCompanyInfo[0].COO_ID}', '${gridClientCompanyInfo[0].COMPANY_ID}', '${gridClientCompanyInfo[0].COO_NAME}')">
						${gridClientCompanyInfo[0].COO_NAME} ${gridClientCompanyInfo[0].COO_POSITION}</a>
				</div>
				<label class="col-sm-2 control-label ag_r"><span>CFO</span></label>
				<div class="col-sm-2">
					<a onclick="goDetail.client('${gridClientCompanyInfo[0].CFO_ID}', '${gridClientCompanyInfo[0].COMPANY_ID}', '${gridClientCompanyInfo[0].CFO_NAME}')">
						${gridClientCompanyInfo[0].CFO_NAME} ${gridClientCompanyInfo[0].CFO_POSITION}</a>
				</div>
			</div>
<%-- 	<div class="form-group pd-t10">
		 	   <label class="col-sm-2 control-label ag_r"><span>CIO</span></label>
		     <div class="col-sm-4">${gridClientCompanyInfo[0].CIO_NAME}</div>
		     <label class="col-sm-2 control-label ag_r"><span>CTO</span></label>
		     <div class="col-sm-4">${gridClientCompanyInfo[0].CTO_NAME}</div>
     	</div> --%>
			<div class="form-group pd-t10">
				<label class="col-sm-2 control-label ag_r"><span>대표전화</span></label>
				<div class="col-sm-2">${gridClientCompanyInfo[0].COMPANY_TELNO}</div>
				<%-- <label class="col-sm-2 control-label ag_r"><span>우편번호</span></label>
             <div class="col-sm-4">${gridClientCompanyInfo[0].POSTAL_CODE}</div> --%>
				<label class="col-sm-2 control-label ag_r"><span>주소</span></label>
				<div class="col-sm-6">${gridClientCompanyInfo[0].POSTAL_ADDRESS}</div>
			</div>
<%-- 	<div class="form-group pd-t10">
	      <label class="col-sm-2 control-label ag_r"><span>주소</span></label>
	      <div class="col-sm-4">${gridClientCompanyInfo[0].POSTAL_ADDRESS}</div> 
      </div> --%>
<%-- 	<div class="form-group pd-t10">
	      <label class="col-sm-2 control-label">업태</label>
	      <div class="col-sm-4">${gridClientCompanyInfo[0].BUSINESS_TYPE}</div>
	      <label class="col-sm-2 control-label">종목</label>
	      <div class="col-sm-4">${gridClientCompanyInfo[0].BUSINESS_SECTOR}</div>  
	    </div> --%>
			<br />
		</div>
	</div>

	<div class="pd-t30">
  	<h3>기타</h3>
  </div>

	<div class="custom-basic">
		<div class="view_pg_type1">
			<div class="form-group topline pd-t10">
				<label class="col-sm-2 control-label ag_r"><span>산업분류</span></label>
				<div class="col-sm-2">${gridClientCompanyInfo[0].SEGMENT_HAN_NAME}</div>
				<label class="col-sm-2 control-label ag_r"><span>사업자등록번호</span></label>
				<div class="col-sm-2">${gridClientCompanyInfo[0].BUSINESS_NUMBER}</div>
				<label class="col-sm-2 control-label ag_r"><span>ERP등록번호</span></label>
				<div class="col-sm-2">${gridClientCompanyInfo[0].ERP_REG_CODE}</div>
			</div>
			<div class="form-group pd-t10">
				<label class="col-sm-2 control-label ag_r"><span>업태</span></label>
				<div class="col-sm-2">${gridClientCompanyInfo[0].BUSINESS_TYPE}</div>
				<label class="col-sm-2 control-label ag_r"><span>종목</span></label>
				<div class="col-sm-2">${gridClientCompanyInfo[0].BUSINESS_SECTOR}</div>
				<label class="col-sm-2 control-label ag_r"><span>조직도</span></label>
				<div class="col-sm-2">
					<a onclick="detail.organizationChart(this);" style="color: blue">조직도보기</a>
				</div>
			</div>
		</div>
	</div>

	<div id="organizationChart" style="display: none;">
		<div class="pd-t40">
			<h3>조직도</h3>
		</div>

		<div class="col-lg-12 ag_c pos-rel custom-photo">
			<c:choose>
				<c:when
					test="${companyOrganizationChart[0].FILE_PATH ne '' && companyOrganizationChart[0].FILE_PATH ne null}">
					<img class="mg-b20" src="/${companyOrganizationChart[0].FILE_PATH}${companyOrganizationChart[0].FILE_NAME}" style="background-size: cover;">
				</c:when>
				<c:otherwise>
					<!-- <span class="mg-b20" style="background:url('../images/icon_org2.gif') no-repeat center center; background-size:cover;"></span> -->
					<div class="org-area">
						<p class="mg-b20">
							<img class="mg" src="../images/pc/icon_org.gif" style="background-size: cover;"> 
							<br />등록된 조직도가 없습니다.<br />
							고객사의 조직도를 등록하세요.
						</p>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<div class="pull-right pos_t10m pd-t30">
		<!--  검색 -->
		<form id="formSearchCommon">
			<div class="search-common">
				<div class="input-default  fl_l" style="margin: 0;">
					<span class="input-group-btn"> 
						<a href="javascript:$('div.search-detail').toggle();void(0);"	class="btn btn-search-option" style="width: 120px;">
							<i class="fa fa-search"></i> 
							고객개인 검색
						</a>
					</span>

					<div class="search-detail" style="top: 71px; right: 6px; display: none; left: auto;">
						<div class="col-sm-12 m-b">
							<label class="control-label" for="date_modified">고객명</label>
							<div class="input-group" style="width: 100%;">
								<input type="text" placeholder="고객명을 입력해주세요" 	class="input form-control" 
									id="textSearchClient" name="textSearchClient" value="${textSearchClient}"
									onkeydown="if(event.keyCode == 13){companyDetail.getCompanyInfo(1,1);}">
							</div>
						</div>
						<input type="text" style="display: none;" />
						<!--
									<div class="col-sm-12 m-b">
										<label class="control-label" for="date_modified">Opportunity
											Owner</label>
										<div class="input-group" style="width: 100%;">
											<input type="text" placeholder="Owner를 입력해주세요"
												class="input form-control" id="textSearchOwner"
												onkeydown="if(event.keyCode == 13){oppList.reset();oppList.get();}">
										</div>
									</div>
					
									 <div class="col-sm-12 m-b">
										<label class="control-label" for="date_modified">예상계약금액 (입력
											금액 이상 검색)</label>
										<div class="input-group" style="width: 100%;">
											<input type="text" placeholder="예상계약금액을 입력해주세요."
												class="input form-control" id="textContractAmount"
												onkeydown="if(event.keyCode == 13){oppList.reset();oppList.get();}">
										</div>
									</div>
					
									<div class="col-sm-12 m-b">
										<div class="form-group">
											<label>Forecast</label> <select class="form-control"
												id="selectSearchForecast">
												<option value="">=== 선택 ===</option>
												<option value="In">In</option>
												<option value="Out">Out</option>
											</select>
										</div>
									</div>
					
									<div class="col-sm-12 m-b">
										<div class="form-group">
											<label>Sales Cycle</label> <select class="form-control"
												id="selectSearchSalesCycle">
					
					
												<option value="">=== 선택 ===</option>
												<option value="1">기회발견</option>
												<option value="2">벤더등록</option>
												<option value="3">영업활동</option>
												<option value="4">제안</option>
												<option value="5">의사결정</option>
												<option value="6">Close</option>
					
					
											</select>
										</div>
									</div>
					
									<div class="col-sm-12 m-b">
										<label class="control-label" for="date_modified">계약일</label>
										<div class="data_1">
					
											<div class="input-group date">
												<span class="input-group-addon"><i class="fa fa-calendar"></i></span><input
													type="text" class="form-control"
													id="textSearchContractStartDate">
											</div>
										</div>
										<div style="padding: 0px 5px; text-align: center; font-size: 18px;">~</div>
										<div class="data_1">
											<div class="input-group date">
												<span class="input-group-addon"><i class="fa fa-calendar"></i></span><input
													type="text" class="form-control" id="textSearchContractEndDate">
											</div>
										</div>
									</div> -->

						<div class="col-sm-12 ag_r">
							<button type="button" class="btn btn-w-m btn-primary btn-seller"
								onclick="companyDetail.getCompanyInfo(1,1);">
								<i class="fa fa-search"></i> 검색
							</button>
						</div>
					</div>
				</div>
			</div>
		</form>
		<!--  검색 -->
	</div>
	
	<h3 style="margin: 30px 0 0 0;">고객개인 리스트</h3>
	<jsp:include page="/WEB-INF/jsp/pc/clientManagement/clientCompanyCustomerAjax.jsp" flush="false">
		<jsp:param name="clientCompanyList" value="${clientCompanyList}"/>
	</jsp:include>
	
</div>

<div class="btn-group pull-right pd-t10">
	<button type="button" class="btn btn-white" onClick="companyDetail.getCompanyInfo(${listPaging.startPage - listPaging.pagingSize},${listPaging.toEndPage});"><i class="fa fa-chevron-left"></i></button>
	<c:forEach begin="${listPaging.startPage}" end="${listPaging.endPage}" var="paginNo">
	 <button class="btn btn-white <c:if test="${paginNo == listPaging.currentPage}">active</c:if>" onClick="companyDetail.getCompanyInfo(${paginNo},${listPaging.toEndPage});">${paginNo}</button>
	</c:forEach>
	<button type="button" class="btn btn-white" onClick="companyDetail.getCompanyInfo(${listPaging.startPage + listPaging.pagingSize},${listPaging.toEndPage});"><i class="fa fa-chevron-right"></i> </button>
</div>

<input type="hidden" name="hiddenCompanyId" id="hiddenCompanyId" value="${gridClientCompanyInfo[0].COMPANY_ID}" />
<input type="hidden" name="hiddenCompanyName" id="hiddenCompanyName" value="${gridClientCompanyInfo[0].COMPANY_NAME}" />
<input type="hidden" name="hiddenCEOId" id="hiddenCEOId" value="${gridClientCompanyInfo[0].CEO_ID}" />
<input type="hidden" name="hiddenCEOName" id="hiddenCEOName" value="${gridClientCompanyInfo[0].CEO_NAME}" />
<input type="hidden" name="hiddenCIOId" id="hiddenCIOId" value="${gridClientCompanyInfo[0].CIO_ID}" />
<input type="hidden" name="hiddenCIOName" id="hiddenCIOName" value="${gridClientCompanyInfo[0].CIO_NAME}" />
<input type="hidden" name="hiddenCTOId" id="hiddenCTOId" value="${gridClientCompanyInfo[0].CTO_ID}" />
<input type="hidden" name="hiddenCTOName" id="hiddenCTOName" value="${gridClientCompanyInfo[0].CTO_NAME}" />
<input type="hidden" name="hiddenSegmentCodeName" id="hiddenSegmentCodeName" value="${gridClientCompanyInfo[0].SEGMENT_HAN_NAME}" />
<input type="hidden" name="hiddenBusinessNum" id="hiddenBusinessNum" value="${gridClientCompanyInfo[0].BUSINESS_NUMBER}" />
<input type="hidden" name="hiddenCompanyTelNo" id="hiddenCompanyTelNo" value="${gridClientCompanyInfo[0].COMPANY_TELNO}" />
<input type="hidden" name="hiddenPostalCode" id="hiddenPostalCode" value="${gridClientCompanyInfo[0].POSTAL_CODE}" />
<input type="hidden" name="hiddenPostalAddress" id="hiddenPostalAddress" value="${gridClientCompanyInfo[0].POSTAL_ADDRESS}" />
<input type="hidden" name="hiddenBusinessType" id="hiddenBusinessType" value="${gridClientCompanyInfo[0].BUSINESS_TYPE}" />
<input type="hidden" name="hiddenBusinessSector" id="hiddenBusinessSector" value="${gridClientCompanyInfo[0].BUSINESS_SECTOR}" />
<input type="hidden" name="hiddenERPCode" id="hiddenERPCode" value="${gridClientCompanyInfo[0].ERP_REG_CODE}" />
<input type="hidden" name="hiddenSegmentCode" id="hiddenSegmentCode" value="${gridClientCompanyInfo[0].SEGMENT_CODE}" />
<input type="hidden" name="hiddenCompanyOrganizationChart" id="hiddenCompanyOrganizationChart" value="${companyOrganizationChart[0].FILE_PATH}${companyOrganizationChart[0].FILE_NAME}" />
<input type="hidden" name="hiddenCompanyFileList" id="hiddenCompanyFileList" value="${fileList}" />
<input type="hidden" name="hiddenSysUpdateDate" id="hiddenSysUpdateDate" value="${gridClientCompanyInfo[0].SYS_UPDATE_DATE}" />
<input type="hidden" name="hiddenClientCategory" id="hiddenClientCategory" value="${gridClientCompanyInfo[0].CLIENT_CATEGORY}">
<input type="hidden" name="hiddenCreatorId" id="hiddenCreatorId" value="${gridClientCompanyInfo[0].HAN_NAME}">

<!-- it 정보 -->
<input type="hidden" name="hiddenItInfoId" id="hiddenItInfoId" value="${clientCompanyItInfo.IT_INFO_ID}" />
<input type="hidden" name="hiddenHWServer" id="hiddenHWServer" value="${clientCompanyItInfo.HW_SERVER}" />
<input type="hidden" name="hiddenHWStorage" id="hiddenHWStorage" value="${clientCompanyItInfo.HW_STORAGE}" />
<input type="hidden" name="hiddenHWBackup" id="hiddenHWBackup" value="${clientCompanyItInfo.HW_BACKUP}" />
<input type="hidden" name="hiddenHWNetwork" id="hiddenHWNetwork" value="${clientCompanyItInfo.HW_NETWORK}" />
<input type="hidden" name="hiddenHWSecurity" id="hiddenHWSecurity" value="${clientCompanyItInfo.HW_SECURITY}" />
<input type="hidden" name="hiddenSWDb" id="hiddenSWDb" value="${clientCompanyItInfo.SW_DB}" />
<input type="hidden" name="hiddenSWMiddleware" id="hiddenSWMiddleware" value="${clientCompanyItInfo.SW_MIDDLEWARE}" />
<input type="hidden" name="hiddenSWBackup" id="hiddenSWBackup" value="${clientCompanyItInfo.SW_BACKUP}" />
<input type="hidden" name="hiddenSWApm" id="hiddenSWApm" value="${clientCompanyItInfo.SW_APM}" />
<input type="hidden" name="hiddenSWDpm" id="hiddenSWDpm" value="${clientCompanyItInfo.SW_DPM}" />
<input type="hidden" name="hiddenEtc" id="hiddenEtc" value="${clientCompanyItInfo.ETC}" />

<script type="text/javascript">
$(document).ready(function() {
	$("#LATELY_UPDATE_DATE").html($("#hiddenSysUpdateDate").val());
});
</script>