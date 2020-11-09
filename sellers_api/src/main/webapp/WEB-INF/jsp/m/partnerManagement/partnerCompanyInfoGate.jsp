<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/jsp/m/common/top.jsp"/>
<%@ include file="/WEB-INF/jsp/m/common/functions.jsp" %>
<%@ include file="/WEB-INF/jsp/m/common/cache.jsp" %>
<%
String req_params = getReqParams(request, "mode");
request.setAttribute("req_params", req_params);
%>
<head>
<link href="${pageContext.request.contextPath}/css/m/style.css" rel="stylesheet" type="text/css">
</head>

    <article class="gate_pg">

        <div class="ta_c">
            <img src="../../../images/m/img_search.svg" />
            <p class="fs18">파트너사 <span class="fc_blue">검색</span></p>
        </div>
        
			<div class="cont_list_gray_bg">
        <div class="topFunc_search_new mg_b10">
            <div class="search_pgin">
					<div class="searchArea">
                <input type="text" placeholder="파트너사명 입력" id="textListSearchDetail" value="${map.serchInfo}" />
                <a href="#" id="btn_search_keyword"><span class="icon_search"></span></a>
                <input type="hidden" id=hiddenNone" />
            	</div>
            </div>
             <a href="/partnerManagement/formPartnerCompanyInfoDetail.do<c:if test="${req_params ne ''}">?${req_params}</c:if>" class="btn btn-primary r3">신규 등록</a>
        </div>
        
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
        
        <!-- 접근권한이 없을 떄 -->
        <div class="result_blank off">
		            해당 파트너사 정보에 접근 권한이 없습니다.<br/>
		            접근권한 부여는 관리자에게 문의해주세요.<br/>
            <!-- 문의처 : <a href="mailto:admin@gmailcom">admin@gmailcom</a> / <a href="tel:02-0938-1254">02-0938-1254</a> -->
        </div>
        <!--// 접근권한이 없을 떄 -->
<%-- <c:if test="${map.search_result eq 'Y'}">
    <c:choose>
    <c:when test="${fn:length(rows) > 0}">
    
        <!-- 검색결과가 있을 경우 -->
        <div class="result_on ">
            <div class="pd_l20 pd_r20">검색결과 (총 ${fn:length(rows)}개)</div>

            <ul class="list_type4 mg_b20">
					</div>
				<ul class="company_list mg_b20" id="result_list"></ul>
			</div>
        <c:forEach items="${rows}" var="item" varStatus="status">
                <li>
                    <a href="/partnerManagement/viewPartnerCompanyInfoDetail.do?companyId=${item.PARTNER_ID}">
                    <a href="#" onclick="searchDetailClick.goDetail('${item.PARTNER_ID}');return false;">
                        <span class="subject ">${item.COMPANY_NAME}</span>
                        <span class="name">대표 : ${item.CEO_NAME}</span>
                        <span class="custom_info">대표전화 : ${item.COMPANY_TELNO}</span>
                    </a>
            <c:if test="${fn:length(item.COMPANY_TELNO) > 6}">
                    <a href="tel:${item.COMPANY_TELNO}" class="btn_phone_go"><img src="../../../images/m/icon_phone.png" alt="전화걸기"/></a>
                    <!-- 전화번호 클릭시 전화걸기 실행 됨  -->
            </c:if>
            	</li>
        </c:forEach>
        
                
            </ul>
        </div>
        <!--// 검색결과가 있을 경우 -->
        
    </c:when>
    <c:otherwise>
        <!-- 등록된 파트너사정보가 없을 떄 -->
        <div class="result_blank on">
            등록된 파트너사 정보가 없습니다.<br/>
            신규등록 해주세요</a>
        </div>
        <!--// 등록된 파트너사정보가 없을 떄 -->
    </c:otherwise>
    </c:choose>
</c:if> --%>
     </div>

    </article>
<%--
  <form id="formSearch" name="formSearch">
  	<input type="hidden" id="hiddenSearchType" />
  	<input type="hidden" id="hiddenSearchTypeDetailCategory" name="detailCategory"/> 
  	<input type="hidden" id="hiddenSearchTypeDetailCompanyName" name="companyName"/> 
  	<input type="hidden" id="hiddenSearchTypeSysUpdateDate" name="SysUpdateDate"/>
  	<input type="hidden" id="hiddenSearchTypePKArray" name="searchPKArray"/>
  	<input type="hidden" id="hiddenSearchTypeResultInSearch" name="resultInSearch"/>
  	<input type="hidden" id="hiddenFilePK" name="filePKArray" value=""/>
  </form>
--%>
  <form id="formDetail">
	<input type="hidden" id="customer_id" name="customer_id">
	<input type="hidden" id="company_id" name="company_id">
	<input type="hidden" id="searchDetail" name="searchDetail">
	<input type="hidden" id="opportunity_id" name="opportunity_id">
	<input type="hidden" id="issue_id" name="issue_id">
	<input type="hidden" id="returnProjectMGMTId" name="returnProjectMGMTId">
	<input type="hidden" id="returnPK" name="returnPK">
	
	<input type="hidden" id="search_result" name="search_result" value="Y" />
	<input type="hidden" id="pageStart" name="pageStart" value="1" />
	<input type="hidden" id="pageEnd" name="pageEnd" value="10000" />
	<input type="hidden" id="serchInfo" name="serchInfo" value="" />
  </form>


<jsp:include page="/WEB-INF/jsp/m/common/bottom.jsp"/>

<script src="${pageContext.request.contextPath}/js/m/view/partnerManagement/partnerCompanyInfoGate.js"></script>