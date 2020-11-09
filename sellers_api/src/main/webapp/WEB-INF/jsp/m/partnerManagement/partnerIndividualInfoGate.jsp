<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/m/common/functions.jsp" %>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>
<%
String req_params = getReqParams(request, "mode");
request.setAttribute("req_params", req_params);
%>

<!doctype html>
<html lang="ko">

<body class="gray_bg">
<div class="container_pg_list">
	<article class="gate_pg">
		<!-- 현황 영역 -->
		
		<!--// 현황 영역 -->
		
		<div class="ta_c">
	    <img src="../../../images/m/img_search.svg" />
	    <p class="fs18">파트너사 개인정보<span class="fc_blue">검색</span></p>
    </div>
			
		<!-- 검색 및 리스트 -->
		<div class="cont_list_gray_bg">
			<div class="topFunc_search_new mg_b10">
				<div class="search_pgin">
					<div class="searchArea">
						<input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}" />
                <input type="text" placeholder="파트너명 입력" id="searchDetail" name="searchDetail" value="${map.search_detail}"/><a href="#" id="btn_search_keyword"><span class="icon_search"></span></a>
					</div>
				</div>
				<a href="/partnerManagement/formPartnerIndividualInfoDetail.do<c:if test="${req_params ne ''}">?${req_params}</c:if>" class="btn btn-primary r3">신규 등록</a>
			</div>
		

       <%--  <div class="ta_c mg_b20">
            <p class="fs22">파트너 <span class="fc_blue">검색</span></p>
        </div>

        <div class="search_pgin bg_white pd_b20">
            <div class="searchArea">
                <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}" />
                <input type="text" placeholder="파트너명 입력" id="searchDetail" name="searchDetail" value="${map.search_detail}" onkeydown="if(event.keyCode == 13){searchDetailClick.getList();}" /><a href="#" onclick="searchDetailClick.getList();"><span class="icon_search"></span></a>
            </div>
        </div>
 --%>
				<!-- 접근권한이 없을 떄 -->
				<div class="result_blank off">
					해당 고객정보에 접근 권한이 없습니다.<br/>
					접근권한 부여는 관리자에게 문의해주세요.<br/>
					<!-- 문의처 : <a href="mailto:admin@gmailcom">admin@gmailcom</a> / <a href="tel:02-0938-1254">02-0938-1254</a> -->
				</div>
				<!--// 접근권한이 없을 떄 -->
				
			 	<!-- 검색결과가 있을 경우 -->
				<div id="div_result" class="result_on">
					<div class="pd_l10 pd_r20">
						<strong>검색결과 (총 <span id="result_cnt">0</span>개)</strong>
					</div>
					<div id="result_list"></div>
				</div>
				
				<a href="#" onclick="searchDetailClick.getList(); return false;"
					class="btn_pg_more r2" id="btn_more" style="display: none;"> <span
					class="va_m" id="span_more">더보기 10 of 10</span>
				</a>
        <div class="guide_pg mg_b20">* 등록된 정보가 없을 경우에 신규등록 해 주세요.</div>

				<%-- <c:if test="${map.search_result eq 'Y'}">
					<c:choose>
					<c:when test="${fn:length(rows) > 0}">
						<!-- 검색결과가 있을 경우 -->
						<div class="result_on ">
							<div class="pd_l10 mg_b5">
								<strong>검색결과 (총 ${fn:length(rows)}개)</strong>
							</div>
				
							<ul class="company_member_list mg_b20">
								<c:forEach items="${rows}" var="item" varStatus="status">
									<li>
										<a href="#" class="info" onclick="searchDetailClick.goDetail('${item.PARTNER_INDIVIDUAL_ID}','${item.PARTNER_ID}','${map.search_detail}');return false;">
											<span class="top pd_b5">
												<span class="subject">${item.PARTNER_PERSONAL_NAME} <span class="fs12">${item.POSITION}</span></span>
												<span class="info_inner">${item.COMPANY_NAME} / ${item.TEAM}</span>
											</span>
										</a>
										<div class="func_box_man">
											<c:if test="${fn:length(item.PHONE) > 6}">
												<a href="tel:${item.PHONE}" class="btn_phone_go"><img src="../../../images/m/icon_phone.png" alt="전화걸기"/></a>
												<!-- 전화번호 클릭시 전화걸기 실행 됨  -->
											</c:if>
											<c:if test="${item.EMAIL != null }">
												<a href="mailto:${item.EMAIL}" class="btn_email_go"><img src="../../../images/m/icon_email.png" alt="메일보내기"/></a>
												<!-- 전화번호 클릭시 전화걸기 실행 됨  -->
											</c:if>
										</div>
									</li>
								</c:forEach>
							</ul>
						</div>
						<!--// 검색결과가 있을 경우 -->
					</c:when>
					<c:otherwise>
		        <!-- 등록된 파트너 정보가 없을 떄 -->
		        <div class="result_blank off">
				            등록된 파트너 정보가 없습니다.<br/>
				            신규등록 해주세요</a>
		        </div>
		        <!--// 등록된 파트너 정보가 없을 떄 -->
			    </c:otherwise>
			    </c:choose>
				</c:if> --%>
		</div>
        

        <!-- <div class="guide_pg mg_b20">* 등록된 정보가 없을 경우에 신규등록 해 주세요.</div> -->

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
</div>

<jsp:include page="/WEB-INF/jsp/m/common/bottom.jsp"/>

<script src="${pageContext.request.contextPath}/js/m/view/partnerManagement/partnerIndividualInfoGate.js"></script>

</body>
</html>