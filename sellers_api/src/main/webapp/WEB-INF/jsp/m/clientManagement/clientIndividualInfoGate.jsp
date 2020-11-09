<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp"%>

<!doctype html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi"	name="viewport">
	<title>고객개인정보</title>
</head>

<body class="gray_bg">
	<!-- location -->
	<!-- <div class="location"> -->
	<%-- <a href="/main/index.do" class="home"><img src="${pageContext.request.contextPath}/images/m/icon_home.svg" /></a>
		<img src="${pageContext.request.contextPath}/images/m/icon_arrow_gray.svg"/>
		<span>고객사 및 고객개인정보</span> 
		<img src="${pageContext.request.contextPath}/images/m/icon_arrow_gray.svg"/> --%>

	<!-- </div> -->
	<!-- <div class="breadcrumb">
		<a href="#" class="home"><img
			src="../../../images/m/icon_home.svg" /></a>
		<div class="breadcrumb_depth1">
			<a class="active_menu">&nbsp;고객사 및 고객개인정보</a>
		</div>
	</div> -->
	<div class="container_pg">
		<article class="gate_pg">
			<!-- 현황 영역 -->
			<div class="top_statusarea_white_bg">
				<h4>고객 현황</h4>
				<div class="status_box mg_b20">
					<div class="row">
						<ul>
							<li><span class="ti fl_l">전체 고객</span> <span
								class="count fl_r"> <span
									class="icon_dash icon_dash_human"></span> <span class="va_m">
										${totalClientCnt} </span> <span class="fs12">명</span>
							</span></li>
							<li><span class="ti fl_l">금주 신규고객</span> <span
								class="count fl_r"> <span
									class="icon_dash icon_dash_human"></span> <span class="va_m">${clientIndividualNewCnt}</span>
									<span class="fs12">명</span>
							</span></li>
						</ul>
					</div>
				</div>

				<%-- <div class="overflow_h">
					<div class="fl_l">
						<h4>관계수립/호감도 추이</h4>
					</div>
					<div class="fl_r">
						<c:if test="${!fn:contains(auth, 'ROLE_MEMBER')}">
							<select id="lineGraphSelectbox2"
								onchange="changeLineGraphSelectbox(this.value);">
								<c:choose>
									<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
										<c:choose>
											<c:when test="${fn:contains(userInfo[18],'Y')}">
												<option value="all" id="optionValue_ALL">본부전체</option>
											</c:when>
											<c:otherwise>
												<option value="all" id="optionValue_ALL">회사전체</option>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
										<option value="all" id="optionValue_ALL">본부전체</option>
									</c:when>
									<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
										<option value="all" id="optionValue_ALL">팀전체</option>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${fn:contains(userInfo[18],'Y')}">
												<option value="all" id="optionValue_ALL">본부전체</option>
											</c:when>
											<c:otherwise>
												<option value="all" id="optionValue_ALL">회사전체</option>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>

								<c:forEach items="${selectTeamNameList}"
									var="selectTeamNameList" varStatus="status">
									<option value="${selectTeamNameList.TARGET_NO}"
										id="optionValue${status.index}">${selectTeamNameList.TARGET_NAME}</option>
								</c:forEach>

								<c:forEach items="${lineGraphSelectOption}" var="option" varStatus="status">
						<option value="${option.NUMS}" id="optionValueTeam${status.index}">${option.NAMES}</option>
					</c:forEach>
							</select>
						</c:if>
					</div>
				</div> --%>
				<div class="mg_b20">
					<div id="asd"></div>
					<!-- <img src="../../../images/m/chart/chart_01.png" alt=""/> -->
				</div>


				<!-- *****************************CHART JS TEST HTML CODE 2018-11-05*********************************** -->

				<%-- <canvas id="myChart" width="400" height="400"></canvas>
		<canvas id="myChart2" width="400" height="400"></canvas> --%>

				<!-- *****************************CHART JS TEST HTML CODE 2018-11-05*********************************** -->


				<!-- *****************************JELLY-CHART TEST HTML CODE 2018-11-05*********************************** -->

				<!-- <div id="jelly_chart"></div> -->

				<!-- *****************************JELLY-CHART TEST HTML CODE 2018-11-05*********************************** -->


				<%-- <!-- 현재년도 -->
				<c:set var="now" value="<%=new java.util.Date()%>" />
				<c:set var="sysYear">
					<fmt:formatDate value="${now}" pattern="yyyy" />
				</c:set>
				<h4>고객 호감도 현황</h4>
				<table class="status_table" summary="회사전체 고객 호감도 현황 table">
					<caption></caption>
					<colgroup>
						<col width="" />
						<col width="" />
						<col width="" />
						<col width="" />
						<col width="" />
						<col width="" />
					</colgroup>
					<thead>
						<tr>
							<c:choose>
								<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
									<th scope="col">부서</th>
								</c:when>
								<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
									<th scope="col">부서</th>
								</c:when>
								<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
									<th scope="col">영업대표</th>
								</c:when>
								<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
									<th scope="col">영업대표</th>
								</c:when>
								<c:otherwise>
									<th scope="col">부서</th>
								</c:otherwise>
							</c:choose>
							<th scope="col">합계</th>
							<th scope="col">긍정적</th>
							<th scope="col">중립적</th>
							<th scope="col">부정적</th>
							<th scope="col">미등록</th>
						</tr>
					</thead>
					<tbody>						
						<c:choose>
							<c:when test="${!fn:contains(auth, 'ROLE_MEMBER')}">
								<c:forEach items="${clientLikeabilityCnt}" var="likeability">
									<tr>
										<c:choose>
											<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
												<th scope="row" class="ta_l">${likeability.TARGET_NAME}</th>
											</c:when>
											<c:otherwise>
												<th scope="row">${likeability.TARGET_NAME}</th>
											</c:otherwise>
										</c:choose>
										<td>${likeability.GREEN_CNT + likeability.YELLOW_CNT + likeability.RED_CNT + likeability.NONREGISTED_CNT}</td>
										<td class="fc_blue">${likeability.GREEN_CNT}</td>
										<td>${likeability.YELLOW_CNT}</td>
										<td class="fc_red">${likeability.RED_CNT}</td>
										<td>${likeability.NONREGISTED_CNT}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<c:forEach items="${clientLikeabilityCnt}" var="likeability">
									<tr>
										<c:choose>
											<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
												<th scope="row" class="ta_l">${likeability.TARGET_NAME}</th>
											</c:when>
											<c:otherwise>
												<th scope="row">${likeability.TARGET_NAME}</th>
											</c:otherwise>
										</c:choose>
										<td>${likeability.GREEN_CNT + likeability.YELLOW_CNT + likeability.RED_CNT + likeability.NONREGISTED_CNT}</td>
										<td class="fc_blue">${likeability.GREEN_CNT}</td>
										<td>${likeability.YELLOW_CNT}</td>
										<td class="fc_red">${likeability.RED_CNT}</td>
										<td>${likeability.NONREGISTED_CNT}</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table> --%>
			</div>

			<!-- 검색 및 리스트 -->
			<div class="cont_list_gray_bg">
				<c:choose>
					<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
					<div class="topFunc_search_new mg_b10">
						<div class="search_pgin">
							<div class="searchArea">
								<input id="searchDetail" type="text" placeholder="고객명 또는 고객사명 입력" />
								<a href="#" id="btn_search"><span class="icon_search"></span></a>
								<input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" />
							</div>
						</div>
						<a href="#" class="btn btn-primary r3" id="clientIndvidualInsert"><span>신규 등록</span></a>
					</div>
					</c:when>
					<c:otherwise>
						<div class="topFunc_search_new mg_b10">
							<div class="search_pgin">
								<div class="searchArea">
									<input id="searchDetail" type="text" placeholder="고객명 또는 고객사명 입력" />
									<a href="#" id="btn_search"><span class="icon_search"></span></a>
									<input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" />
								</div>
							</div>
							<a href="#" class="btn btn-primary r3" id="clientIndvidualInsert"><span>신규 등록</span></a>
						</div>
					</c:otherwise>
				</c:choose>



				<!-- 검색결과가 있을 경우 -->
				<div class="result_on off">
					<div id="tc" class="pd_l10 mg_b5" style="display: none">
						<strong>검색결과 (총 <span id="result_cnt">0</span>개)
						</strong>
					</div>
					<div id="result_list2"></div>
					<div id="result_list3"></div>
				</div>

				<a href="#" onclick="showMore(); return false;"
					class="btn_pg_more r2" id="btn_more" style="display: none;"> <span
					class="va_m" id="span_more">더보기 10 of 10</span>
				</a>
				<!--// 검색결과가 있을 경우 -->

				<c:if test="${!fn:contains(auth, 'ROLE_CEO')}">
					<!-- 주요고객 리스트 -->
					<div class="pd_l10 mg_b5" id="topList2">
						<strong>주요고객 TOP 10</strong>
					</div>
					<div id="topList"></div>
				</c:if>

				<!-- 등록된 고객정보가 없을 떄 -->
				<div class="result_blank off">
					등록된 고객 정보가 없습니다.<br /> 신규등록 해주세요</a>
				</div>
				<!--// 등록된 고객정보가 없을 떄 -->

				<!-- 접근권한이 없을 떄 -->
				<div class="result_blank off">
					해당 고객정보에 접근 권한이 없습니다.<br /> 접근권한 부여는 관리자에게 문의해주세요.<br /> 문의처 : <a
						href="mailto:admin@gmailcom">admin@gmailcom</a> / <a
						href="tel:02-0938-1254">02-0938-1254</a>
				</div>
				<!--// 접근권한이 없을 떄 -->
			</div>
		</article>

		<jsp:include page="../templates/footer.jsp" flush="true" />


	</div>

	<div class="modal_screen"></div>

	<form id="formSearch" name="formSearch">
		<input type="hidden" id="hiddenSearchType" />
	</form>

	<form id="formDetail">
		<input type="hidden" id="customer_id" name="customer_id"> <input
			type="hidden" id="company_id" name="company_id"> <input
			type="hidden" id="search_detail" name="search_detail">
	</form>

	<form method="post" id="inserForm" action="">
		<input type="hidden" id="mode" name="mode" value="ins" />
	</form>

	<!-- c3 chart -->
	<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.css"/>
<script src="https://d3js.org/d3.v3.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script> -->



	<!-- *****************************CHART JS TEST SCRITP CODE 2018-11-05*********************************** -->

	<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script> -->
	<!-- <script src="https://cdn.jsdelivr.net/npm/chart.js@2.7.3/src/chart.min.js"></script> -->

	<!-- 실제사용 -->
	<!-- <script src="https://cdn.jsdelivr.net/npm/chart.js@2.7.3/dist/Chart.bundle.min.js"></script> -->

	<!-- <script src="https://cdn.jsdelivr.net/npm/chart.js@2.7.3/src/chart.min.js" type="text/javascript"></script> -->
	<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script> -->

	<!-- *****************************CHART JS TEST SCRITP CODE 2018-11-05*********************************** -->


	<!-- *****************************JELLY-CHART TEST SCRITP CODE 2018-11-05*********************************** -->
	<!-- <script src="//d3js.org/d3.v4.min.js"></script>    
jsDelivr
<script src="//cdn.jsdelivr.net/npm/jelly-chart/dist/jelly.min.js"></script> 
unpkg
<script src="//unpkg.com/jelly-chart/dist/jelly.min.js"></script> 
 -->
	<!-- *****************************JELLY-CHART TEST SCRITP CODE 2018-11-05*********************************** -->


	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.6.8/c3.min.css" />
	<script src="${pageContext.request.contextPath}/js/m/c3/c3.min.js"></script>
	<script	src="${pageContext.request.contextPath}/js/m/d3/d3-5.4.0.min.js"></script>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	
	<script type="text/javascript">
		var memberId = '${userInfo.MEMBER_ID_NUM}';	
	</script>
	
	<script src="${pageContext.request.contextPath}/js/m/view/clientManagement/clientIndividualInfoGate.js"></script>

</body>
</html>