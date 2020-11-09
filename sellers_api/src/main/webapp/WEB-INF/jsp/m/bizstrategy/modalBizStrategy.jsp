<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>

<!doctype html>
<html lang="ko">

<body class="gray_bg">
<div class="container_pg_list">
<%-- 
<%
String req_params = getReqParams(request, "pkNo", "strategy");
request.setAttribute("req_params", req_params);
%> --%>
	<article class="">
		<div class="title_pg">
			<h2 class="mg_b5">${detail.SUBJECT}</h2>
			<!-- 
			<a href="#" class="btn_back" onclick="fncGoBack(); return false;">back</a>
			 -->
			<a href="#" class="btn_back" onclick="fncList(); return false;">back</a>
		</div>
		
		<div class="author">
			<span>${detail.HAN_NAME}(${detail.SYS_REGISTER_DATE})</span>
		</div>
		
		<div class="mg_l10 mg_r10">
			<ul class="tabmenu tabmenu_type2 mg_b20">
				<li><a href="#" id="tab_1" onclick="fncSelectTab('1'); return false;" class="active">기본정보</a></li>
				<li><a href="#" id="tab_2" onclick="fncSelectTab('2'); return false;">KeyMilestones</a></li>
				<li><a href="#" id="tab_3" onclick="fncSelectTab('3'); return false;">이슈</a></li>
			</ul>
			
			<div class="cont1 "><!-- 기본정보 -->
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 카테고리
					</div>
					<div class="cont fl_l">${detail.CATEGORY}</div>
				</div>
	
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 검토주기
					</div>
					<div class="cont fl_l">
						<c:choose>
						<c:when test="${detail.REVIEW_CYCLE eq '0'}">매월 1회</c:when>
						<c:when test="${detail.REVIEW_CYCLE eq '1'}">분기 1회</c:when>
						<c:when test="${detail.REVIEW_CYCLE eq '2'}">반기 1회</c:when>
						</c:choose>
					</div>
				</div>
	
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 책임리더
					</div>
					${detail.RL_NAME} ${detail.RL_POSITION}
<c:if test="${fn:length(detail.RL_PHONE) > 6}">
					<a href="tel:${detail.RL_PHONE}" class="btn_phone_go"><img src="/images/m/icon_phone.png"/></a>
</c:if>
				</div>	
	
				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 주요내용
					</div>
					<div class="cboth cont_box"><pre>${detail.KEY_CONTENTS}</pre></div>
				</div>
	
				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 첨부파일
					</div>
					<div class="cboth cont_box">
						<ul class="file_list">
							<c:forEach items="${fileList}" var="file">
								<li><a href="/common/downloadFile.do?fileId=${file.FILE_ID}&fileTableName=1">${file.FILE_NAME}</a></li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			
			<div class="cont2 off"><!-- Key Milestones -->
				<div class="view_cata_full">
					<!-- <div class="ti mg_b5">
						<span class="bullet dot"></span> Key Milestones
					</div> -->
					<div class="cboth keymilestones_list">
						<ul id="result_list">
						</ul>
					</div>
				</div>
			</div>
			
			
			<div class="cont3 off"> <!-- 이슈 -->
				<div class="view_cata_full">
					<!-- <div class="ti mg_b5">
						<span class="bullet dot"></span> 이슈
					</div> -->
					<div class="cboth issue_list">
					<ul class="list_type1">
					<c:forEach items="${issueList}" var="issue">
						<li>
							<div class="top top2">
								<%-- <span class="cata r2">${issue.ISSUE_NAME}</span> 
								<c:if test="${issue.ISSUE_ITEM ne null and issue.ISSUE_ITEM != ''}">
									<span class="cata2 r2">${issue.ISSUE_ITEM}</span>
								</c:if>		 --%>						
								
								<span class="title">${issue.ISSUE_NAME}</span>
								
								<c:choose>
									<c:when test="${issue.STATUS == 'Y'}">
										<span class="status_lec statusColor_yellow"></span>
									</c:when>
									<c:when test="${issue.STATUS == 'G'}">
										<span class="status_lec statusColor_green"></span>
									</c:when>
									<c:when test="${issue.STATUS == 'R'}">
										<span class="status_lec statusColor_red"></span>
									</c:when>
									<c:otherwise>
										<span class="status_lec"></span>
									</c:otherwise>
								</c:choose>
								
							</div>
							<div class="cont">
								<span class="fc_gray_light">책임 담당자 : </span> <span class="fc_black">${issue.ACTION_OWNER}</span>
								<c:if test="${fn:length(issue.ACTION_OWNER_PHONE) > 6}">
									<a href="tel:${issue.ACTION_OWNER_PHONE}" class="btn_phone_go"><img src="/images/m/icon_phone.png"/></a>
								</c:if>
								<br/>
								<span class="fc_gray_light">목표일 : </span> <span class="fc_black">${issue.DUE_DATE}</span> 
								<span class="fc_gray_light">/ 완료일 : </span> <span class="fc_black">
								<c:if test="${issue.CLOSE_DATE ne ''}">
									${issue.CLOSE_DATE}
								</c:if>
								</span>
 								<div class='pd_t5 mg_b30'>${issue.ACTION_PLAN_NAME}</div>
							</div>
						</li>
					</c:forEach>
					</ul>
					</div>
				</div>
			</div>
		</div>

		<!-- <div class="pg_bottom">
			<div class="ta_c">
				<button type="button" onClick="fncList(); return false;" class="btn lg btn-default pd_r15 pd_l15 r5">목록</button>
			</div>
		</div> -->

	</article>
	</div>
	
	<jsp:include page="/WEB-INF/jsp/m/common/bottom.jsp"/>
	
<script>
	var mapSearchCategory = '${map.searchCategory}';
	var reqParams = '${req_params}';
	var bizId = '${detail.BIZ_ID}';
	var searchKeyword = '${param.search_keyword}';
</script>	
<script src="${pageContext.request.contextPath}/js/m/view/bizStrategy/mobileBizstrategy.js"></script>

</body>
</html>

