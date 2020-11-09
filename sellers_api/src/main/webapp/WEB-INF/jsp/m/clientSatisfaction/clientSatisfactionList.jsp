<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>

<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>

<!doctype html>
<html lang="ko">

<body class="gray_bg">
	
<div class="container_pg">
	<article class="list_pg">

		<!-- 현황 영역 -->
		<div class="top_statusarea_white_bg">
			
			<h4>컨택 방법</h4>
			<select class="mg_b20" id="selectSatisfactionCategory" name="selectSatisfactionCategory" style="width:100%;">
				<c:if test="${fn:length(searchDetailGroup) > 0}">
					<c:forEach items="${searchDetailGroup}" var="category">
						<option value="${category.CSAT_CATEGORY}">${category.CSAT_CATEGORY}</option>
					</c:forEach>
				</c:if>
			</select>
		
			<h4><span id="csatTotalYear"></span>년 <span id="csatTotalQuarter"></span>분기 만족도 현황</h4>
			<div class="status_box mg_b20">
				<div class="row" id="row">
					
				</div>
			</div>
			
			<div class="overflow_h mg_b5">
				<div class="fl_l">
					<h4><span id="csatMasterYear"></span>년 <span id="csatMasterQuarter"></span>분기 조사 현황</h4>
				</div>
				<div class="fl_r">
					<c:if test="${fn:contains(auth, 'ROLE_MEMBER')}">
						<input type="hidden" id="textTeamNameList" value="${global_member_id}"/>
					</c:if>
					<c:if test="${!fn:contains(auth, 'ROLE_MEMBER')}">						
						<select id="textTeamNameList" onChange="getMaster();">
							<c:choose>
								<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
									<option value="">회사전체</option>
								</c:when>
								<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
									<option value="">본부전체</option>
								</c:when>
								<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
									<option value="">팀전체</option>
								</c:when>
								<c:otherwise>
									<option value="">회사전체</option>
								</c:otherwise>
							</c:choose>
						</select>
					</c:if>
				
					<select class="form-control m-b" name="selectSortCategory" id="selectSortCategory" onChange="getMaster();">
						<option value="">최근 업데이트</option>
						<option value="CSAT_SUBJECT">제목</option>
						<!-- <option value="CSAT_SURVEY_TEAM">주관부서</option>
						<option value="CSAT_SURVEY_NAME">책임자</option>
						<option value="CSAT_SURVEY_DATE">조사일</option> -->
						<option value="TOTAL_COUNT">설문건수</option>
						<option value="AVG_CSAT_VALUE">평가</option>
					</select>
				</div>
			</div>
						
			<!-- 조사현황: 반응형 table -->
			<div id="row2">
			</div>
			<!--// 조사현황: 반응형 table -->

		</div>
		<!--// 현황 영역 -->
	
		<!-- 검색 및 리스트 -->
		<div class="cont_list_gray_bg ">
			<div class="topFunc mg_b10 fl_r">
				<div class="sortArea">
					<c:if test="${!fn:contains(auth, 'ROLE_MEMBER')}">
						<select id="selectSatisfactionTeamList">
							<c:choose>
								<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
									<option value="">회사전체</option>
								</c:when>
								<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
									<option value="">본부전체</option>
								</c:when>
								<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
									<option value="">팀전체</option>
								</c:when>
								<c:otherwise>
									<option value="">회사전체</option>
								</c:otherwise>
							</c:choose>
							
							<c:forEach var="rows" items="${selectTeamNameList}">
								<option value="${rows.TARGET_NO}">${rows.TARGET_NAME}</option>
							</c:forEach>
						</select>
					</c:if>
				</div>
			</div>

			<div class="topFunc_search_new mg_b10" style="width:100%;">
				<div class="search_pgin">
					<div class="searchArea">
						<input type="text" id="textSearchKeyword" placeholder="고객명, 고객사 또는 제목 입력" />
						<a href="#" onClick="fncSearch(); return false;"><span class="icon_search"></span></a>
					</div>
				</div>
			</div>
				

			<ul class="list_type1" id="result_list2">
			</ul>
			<div id="blank_list" class="off"></div>
			
			<!-- 
			<a href="#" class="btn_pg_more primary_bg r2 fc_white">
				<span class="icon icon_arrow_down md va_m"></span> <span class="va_m">더보기 6 of 6</span>
			</a>
			-->

			<a href="#" onclick="fncShowMore(); return false;" class="btn_pg_more r2" id="btn_more">
				<span class="icon icon_arrow_down md va_m"></span> <span class="va_m" id="span_more">더보기 6 of 6</span>
			</a>
		</div>
	</article>

	<form method="post" id="detailForm" action="">
		<input type="hidden" id="pkNo" name="pkNo" value="" />
	</form>

	<form method="post" id="inserForm" action="">
		<input type="hidden" id="mode" name="mode" value="ins" />
	</form>

</div>

<div class="modal_screen"></div>

<!-- c3 chart -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.css"/>
<script src="https://d3js.org/d3.v3.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<script>
	var auth = '${auth}';
</script>

<script src="${pageContext.request.contextPath}/js/m/view/clientSatisfaction/clientSatisfactionList.js"></script>

</body>
</html>