<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>

<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>

<!doctype html>
<html lang="ko">

<body class="gray_bg">

<div class="container_pg_list">
	<article class="list_pg">
		<!-- 현황 영역 -->
		<div class="top_statusarea_white_bg">
			<h4>${sysYear}년 잠재영업기회 현황</h4>
			<div class="status_box mg_b20">
				<div class="row">
					<ul>
						<li>
							<span class="ti fl_l">전체잠재기회</span>
							<span class="count fl_r">
								<span class="va_m">${ConversionRateCount.TOTAL_CNT}</span>
								<span class="fs12">건</span>
							</span>
						</li>
						<li>
							<span class="ti fl_l">진행중 기회</span>
							<span class="count fl_r">
								<span class="va_m">${ConversionRateCount.ING_CNT}</span>
								<span class="fs12">건</span>
							</span>
						</li>
					</ul>
					<ul>
						<li>
							<span class="ti fl_l">전환률</span>
							<span class="count fl_r">
								<span class="va_m">${ConversionRate.CONVERSIONRATE}</span>
								<span class="fs12">%</span>
							</span>
						</li>
						<li>
							<span class="ti fl_l">전환금액</span>
							<span class="count fl_r">
								<span class="va_m"><fmt:formatNumber value="${ConversionRate.CONVERSIONAMOUNT}" pattern="#,###" /></span>
								<span class="fs12">백만원</span>
							</span>
						</li>
					</ul>
				</div>
			</div>
			
			<div class="overflow_h mg_b5">
				<div class="fl_l">
					<h4>${sysYear}년 전환계획 Status<span class="fs12 fc_gray">(단위:백만원)</span></h4>
				</div>
			</div>
			
			<!-- 전환계획 STATUS -->
			<table class="status_table" summary="">
				<caption></caption>
				<colgroup>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
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
						<th scope="col">전체</th>
						<th scope="col">전환</th>
						<th scope="col">Overdue</th>
						<th scope="col">월간신규</th>
					</tr>
				</thead>
				<tbody>
				<c:choose>
					<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
						<!-- 합계 구할 변수 초기값 -->
						<c:set var = "total_cnt" value = "0" />
						<c:set var = "total_amount" value = "0" />
						<c:set var = "green_cnt" value = "0" />
						<c:set var = "green_amount" value = "0" />
						<c:set var = "yellow_cnt" value = "0" />
						<c:set var = "yellow_amount" value = "0" />
						<c:set var = "red_cnt" value = "0" />
						<c:set var = "red_amount" value = "0" />
						
						<c:forEach items="${changePlanStatus}" var="status">
							<tr style="display: none;">
								<th scope="row">${status.TARGET_NAME}</th>
								<td>${status.M_TOTAL_AMOUNT}(${status.TOTAL_COUNT})</td>
								<td class="fc_blue">${status.GREEN_AMOUNT}(${status.GREEN_COUNT})</td>
								<td>${status.RED_AMOUNT}(${status.RED_COUNT})</td>
								<td>${status.M_MONTH_NEW_AMOUNT}"(${status.MONTH_NEW_COUNT})</td>								
							</tr>
							<c:set var = "total_cnt" value = "${total_cnt +status.TOTAL_COUNT}" />
							<c:set var = "total_amount" value = "${total_amount +status.M_TOTAL_AMOUNT}" />
							<c:set var = "green_cnt" value = "${green_cnt +status.GREEN_CNT}" />
							<c:set var = "green_amount" value = "${green_amount +status.GREEN_AMOUNT}" />
							<c:set var = "red_cnt" value = "${red_cnt +status.RED_CNT}" />
							<c:set var = "red_amount" value = "${red_amount +status.RED_AMOUNT}" />
							<c:set var = "yellow_cnt" value = "${yellow_cnt +status.MONTH_NEW_COUNT}" />
							<c:set var = "yellow_amount" value = "${yellow_amount +status.M_MONTH_NEW_AMOUNT}" />
						</c:forEach>
						
						<c:choose>
							<c:when test="${total_cnt > 0}">
								<%-- <tr>
									<th scope="row">회사전체</th>
									<td><fmt:formatNumber value="${total_amount}" pattern="#,###"/>(${total_cnt})</td>
									<td class="fc_blue"><fmt:formatNumber value="${green_amount}" pattern="#,###"/>(${green_cnt})</td>
									<td><fmt:formatNumber value="${yellow_amount}" pattern="#,###"/>(${yellow_cnt})</td>
									<td><fmt:formatNumber value="${red_amount}" pattern="#,###"/>(${red_cnt})</td>
								</tr> --%>
								<c:forEach items="${changePlanStatus}" var="status">
									<tr>
										<th scope="row">${status.TARGET_NAME}</th>
										<td><fmt:formatNumber value="${status.M_TOTAL_AMOUNT}" pattern="#,###"/>(${status.TOTAL_COUNT})</td>
										<td class="fc_blue"><fmt:formatNumber value="${status.GREEN_AMOUNT}" pattern="#,###"/>(${status.GREEN_CNT})</td>
										<td><fmt:formatNumber value="${status.RED_AMOUNT}" pattern="#,###"/>(${status.RED_CNT})</td>										
										<td><fmt:formatNumber value="${status.M_MONTH_NEW_AMOUNT}" pattern="#,###"/>(${status.MONTH_NEW_COUNT})</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<th colspan="5">현재 등록된 데이터가 없습니다.</th>
								</tr>
							</c:otherwise>
						</c:choose>
						
					</c:when>
					<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
						<!-- 합계 구할 변수 초기값 -->
						<c:set var = "total_cnt" value = "0" />
						<c:set var = "total_amount" value = "0" />
						<c:set var = "green_cnt" value = "0" />
						<c:set var = "green_amount" value = "0" />
						<c:set var = "yellow_cnt" value = "0" />
						<c:set var = "yellow_amount" value = "0" />
						<c:set var = "red_cnt" value = "0" />
						<c:set var = "red_amount" value = "0" />
						
						<c:forEach items="${changePlanStatus}" var="status">
							<tr style="display: none;">
								<th scope="row">${status.TARGET_NAME}</th>
								<td>${status.M_TOTAL_AMOUNT}(${status.TOTAL_COUNT})</td>
								<td class="fc_blue">${status.GREEN_AMOUNT}(${status.GREEN_COUNT})</td>
								<td>${status.RED_AMOUNT}(${status.RED_COUNT})</td>
								<td>${status.M_MONTH_NEW_AMOUNT}(${status.MONTH_NEW_COUNT})</td>
							</tr>
							<c:set var = "total_cnt" value = "${total_cnt +status.TOTAL_COUNT}" />
							<c:set var = "total_amount" value = "${total_amount +status.M_TOTAL_AMOUNT}" />
							<c:set var = "green_cnt" value = "${green_cnt +status.GREEN_CNT}" />
							<c:set var = "green_amount" value = "${green_amount +status.GREEN_AMOUNT}" />
							<c:set var = "red_cnt" value = "${red_cnt +status.RED_CNT}" />
							<c:set var = "red_amount" value = "${red_amount +status.RED_AMOUNT}" />
							<c:set var = "yellow_cnt" value = "${yellow_cnt +status.MONTH_NEW_COUNT}" />
							<c:set var = "yellow_amount" value = "${yellow_amount +status.M_MONTH_NEW_AMOUNT}" />							
						</c:forEach>
						
						<%-- <c:forEach items="${changePlanStatusDivision}" var="status">
							<c:set var = "total_cnt" value = "${total_cnt +status.TOTAL_COUNT}" />
							<c:set var = "total_amount" value = "${total_amount +status.TOTAL_AMOUNT}" />
							<c:set var = "green_cnt" value = "${green_cnt +status.GREEN_CNT}" />
							<c:set var = "green_amount" value = "${green_amount +status.GREEN_AMOUNT}" />
							<c:set var = "yellow_cnt" value = "${yellow_cnt +status.YELLOW_CNT}" />
							<c:set var = "yellow_amount" value = "${yellow_amount +status.YELLOW_AMOUNT}" />
							<c:set var = "red_cnt" value = "${red_cnt +status.RED_CNT}" />
							<c:set var = "red_amount" value = "${red_amount +status.RED_AMOUNT}" />
						</c:forEach> --%>
						
						<c:choose>
							<c:when test="${total_cnt > 0}">
								<%-- <tr>
									<th scope="row">본부전체</th>
									<td><fmt:formatNumber value="${total_amount}" pattern="#,###"/>(${total_cnt})</td>
									<td class="fc_blue"><fmt:formatNumber value="${green_amount}" pattern="#,###"/>(${green_cnt})</td>
									<td><fmt:formatNumber value="${yellow_amount}" pattern="#,###"/>(${yellow_cnt})</td>
									<td><fmt:formatNumber value="${red_amount}" pattern="#,###"/>(${red_cnt})</td>
								</tr> --%>
								
								<%-- <c:forEach items="${changePlanStatusDivision}" var="status">
									<tr>
										<th scope="row">${status.TARGET_NAME}</th>
										<td><fmt:formatNumber value="${status.TOTAL_AMOUNT}" pattern="#,###"/>(${status.TOTAL_COUNT})</td>
										<td class="fc_blue"><fmt:formatNumber value="${status.GREEN_AMOUNT}" pattern="#,###"/>(${status.GREEN_CNT})</td>
										<td><fmt:formatNumber value="${status.YELLOW_AMOUNT}" pattern="#,###"/>(${status.YELLOW_CNT})</td>
										<td><fmt:formatNumber value="${status.RED_AMOUNT}" pattern="#,###"/>(${status.RED_CNT})</td>
									</tr>
								</c:forEach> --%>
								
								<c:forEach items="${changePlanStatus}" var="status">
									<tr>
										<th scope="row">${status.TARGET_NAME}</th>
										<td><fmt:formatNumber value="${status.M_TOTAL_AMOUNT}" pattern="#,###"/>(${status.TOTAL_COUNT})</td>
										<td class="fc_blue"><fmt:formatNumber value="${status.GREEN_AMOUNT}" pattern="#,###"/>(${status.GREEN_CNT})</td>
										<td><fmt:formatNumber value="${status.RED_AMOUNT}" pattern="#,###"/>(${status.RED_CNT})</td>
										<td><fmt:formatNumber value="${status.M_MONTH_NEW_AMOUNT}" pattern="#,###"/>(${status.MONTH_NEW_COUNT})</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<th colspan="5">현재 등록된 데이터가 없습니다.</th>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
						<!-- 합계 구할 변수 초기값 -->
						<c:set var = "total_cnt" value = "0" />
						<c:set var = "total_amount" value = "0" />
						<c:set var = "green_cnt" value = "0" />
						<c:set var = "green_amount" value = "0" />
						<c:set var = "yellow_cnt" value = "0" />
						<c:set var = "yellow_amount" value = "0" />
						<c:set var = "red_cnt" value = "0" />
						<c:set var = "red_amount" value = "0" />
						
						<c:forEach items="${changePlanStatus}" var="status">
							<tr style="display: none;">
								<th scope="row">${status.TARGET_NAME}</th>
								<td>${status.M_TOTAL_AMOUNT}(${status.TOTAL_COUNT})</td>
								<td class="fc_blue">${status.GREEN_AMOUNT}(${status.GREEN_COUNT})</td>
								<td>${status.RED_AMOUNT}(${status.RED_COUNT})</td>
								<td>${status.M_MONTH_NEW_AMOUNT}(${status.MONTH_NEW_COUNT})</td>
							</tr>
							<c:set var = "total_cnt" value = "${total_cnt +status.TOTAL_COUNT}" />
							<c:set var = "total_amount" value = "${total_amount +status.M_TOTAL_AMOUNT}" />
							<c:set var = "green_cnt" value = "${green_cnt +status.GREEN_CNT}" />
							<c:set var = "green_amount" value = "${green_amount +status.GREEN_AMOUNT}" />
							<c:set var = "red_cnt" value = "${red_cnt +status.RED_CNT}" />
							<c:set var = "red_amount" value = "${red_amount +status.RED_AMOUNT}" />
							<c:set var = "yellow_cnt" value = "${yellow_cnt +status.MONTH_NEW_COUNT}" />
							<c:set var = "yellow_amount" value = "${yellow_amount +status.M_MONTH_NEW_AMOUNT}" />
						</c:forEach>
						
						<c:choose>
							<c:when test="${total_cnt > 0}">
								<%-- <tr>
									<th scope="row">팀전체</th>
									<td><fmt:formatNumber value="${total_amount}" pattern="#,###"/>(${total_cnt})</td>
									<td class="fc_blue"><fmt:formatNumber value="${green_amount}" pattern="#,###"/>(${green_cnt})</td>
									<td><fmt:formatNumber value="${yellow_amount}" pattern="#,###"/>(${yellow_cnt})</td>
									<td><fmt:formatNumber value="${red_amount}" pattern="#,###"/>(${red_cnt})</td>
								</tr> --%>
								<c:forEach items="${changePlanStatus}" var="status">
									<tr>
										<th scope="row">${status.TARGET_NAME}</th>
										<td><fmt:formatNumber value="${status.M_TOTAL_AMOUNT}" pattern="#,###"/>(${status.TOTAL_COUNT})</td>
										<td class="fc_blue"><fmt:formatNumber value="${status.GREEN_AMOUNT}" pattern="#,###"/>(${status.GREEN_CNT})</td>
										<td><fmt:formatNumber value="${status.RED_AMOUNT}" pattern="#,###"/>(${status.RED_CNT})</td>
										<td><fmt:formatNumber value="${status.M_MONTH_NEW_AMOUNT}" pattern="#,###"/>(${status.MONTH_NEW_COUNT})</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<th colspan="5">현재 등록된 데이터가 없습니다.</th>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
						<c:choose>
							<c:when test="${changePlanStatus[0].TOTAL_COUNT > 0}">
								<tr>
									<th scope="row">${changePlanStatus[0].TARGET_NAME}</th>
									<td><fmt:formatNumber value="${changePlanStatus[0].M_TOTAL_AMOUNT}" pattern="#,###"/>(${changePlanStatus[0].TOTAL_COUNT})</td>
									<td class="fc_blue"><fmt:formatNumber value="${changePlanStatus[0].GREEN_AMOUNT}" pattern="#,###"/>(${changePlanStatus[0].GREEN_CNT})</td>
									<td><fmt:formatNumber value="${changePlanStatus[0].RED_AMOUNT}" pattern="#,###"/>(${changePlanStatus[0].RED_CNT})</td>
									<td><fmt:formatNumber value="${changePlanStatus[0].M_MONTH_NEW_AMOUNT}" pattern="#,###"/>(${changePlanStatus[0].MONTH_NEW_COUNT})</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<th colspan="5">현재 등록된 데이터가 없습니다.</th>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<!-- 합계 구할 변수 초기값 -->
						<c:set var = "total_cnt" value = "0" />
						<c:set var = "total_amount" value = "0" />
						<c:set var = "green_cnt" value = "0" />
						<c:set var = "green_amount" value = "0" />
						<c:set var = "yellow_cnt" value = "0" />
						<c:set var = "yellow_amount" value = "0" />
						<c:set var = "red_cnt" value = "0" />
						<c:set var = "red_amount" value = "0" />
						
						<c:forEach items="${changePlanStatus}" var="status">
							<tr style="display: none;">
								<th scope="row">${status.TARGET_NAME}</th>
								<td>${status.M_TOTAL_AMOUNT}(${status.TOTAL_COUNT})</td>
								<td class="fc_blue">${status.GREEN_AMOUNT}(${status.GREEN_COUNT})</td>
								<td>${status.RED_AMOUNT}(${status.RED_COUNT})</td>
								<td>${status.M_MONTH_NEW_AMOUNT}(${status.MONTH_NEW_COUNT})</td>
							</tr>
							<c:set var = "total_cnt" value = "${total_cnt +status.TOTAL_COUNT}" />
							<c:set var = "total_amount" value = "${total_amount +status.M_TOTAL_AMOUNT}" />
							<c:set var = "green_cnt" value = "${green_cnt +status.GREEN_CNT}" />
							<c:set var = "green_amount" value = "${green_amount +status.GREEN_AMOUNT}" />
							<c:set var = "red_cnt" value = "${red_cnt +status.RED_CNT}" />
							<c:set var = "red_amount" value = "${red_amount +status.RED_AMOUNT}" />
							<c:set var = "yellow_cnt" value = "${yellow_cnt +status.MONTH_NEW_COUNT}" />
							<c:set var = "yellow_amount" value = "${yellow_amount +status.M_MONTH_NEW_AMOUNT}" />
						</c:forEach>
						
						<c:choose>
							<c:when test="${total_cnt > 0}">
								<%-- <tr>
									<th scope="row">회사전체</th>
									<td><fmt:formatNumber value="${total_amount}" pattern="#,###"/>(${total_cnt})</td>
									<td class="fc_blue"><fmt:formatNumber value="${green_amount}" pattern="#,###"/>(${green_cnt})</td>
									<td><fmt:formatNumber value="${red_amount}" pattern="#,###"/>(${red_cnt})</td>
									<td><fmt:formatNumber value="${yellow_amount}" pattern="#,###"/>(${yellow_cnt})</td>
								</tr> --%>
								<c:forEach items="${changePlanStatus}" var="status">
									<tr>
										<th scope="row">${status.TARGET_NAME}</th>
										<td><fmt:formatNumber value="${status.M_TOTAL_AMOUNT}" pattern="#,###"/>(${status.TOTAL_COUNT})</td>
										<td class="fc_blue"><fmt:formatNumber value="${status.GREEN_AMOUNT}" pattern="#,###"/>(${status.GREEN_CNT})</td>
										<td><fmt:formatNumber value="${status.RED_AMOUNT}" pattern="#,###"/>(${status.RED_CNT})</td>
										<td><fmt:formatNumber value="${status.M_MONTH_NEW_AMOUNT}" pattern="#,###"/>(${status.MONTH_NEW_COUNT})</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<th colspan="5">현재 등록된 데이터가 없습니다.</th>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
		</div>
		<!--// 현황 영역 -->
		
		<!-- 검색 및 리스트 -->
		<div class="cont_list_gray_bg">
			<div class="topFunc mg_b10">
				<div class="sortArea fl_r ">
									
					<c:choose>
						<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
						</c:when>
						<c:otherwise>
							<select id="textTeamNameList" onChange="getList('Y');" style="background: white;">
								<option value="">회사전체</option>
							</select>
						</c:otherwise>
					</c:choose>
					
					<select id="textSituationList" onChange="getList('Y');" style="background: white;">
						<option value="">전체</option>
						<option value="change">전환</option>
						<option value="ing">진행중</option>
						<option value="delay">지연</option>
					</select>
				</div>
				
       </div>
				
				<div class="topFunc_search_new mg_b10">
					<div class="search_pgin">
						<div class="searchArea">
							<input type="text" id="textSearchKeyword" placeholder="고객명, 고객사 또는 제목 입력" />
							<a href="#" onClick="fncSearch(); return false;"><span class="icon_search"></span></a>
						</div>
					</div>
					<a href="#" class="btn btn-primary r5" id="inserthiddenOpportunity"><span class="">신규 등록</span></a>
				</div>
		
		
			<ul class="list_type1" id="result_list2">
				<!-- 내용이 입력됩니다. -->
				<div id="list_type_coop">
				</div>
				<div id="blank_html" class="off"></div>
			</ul>
	<!--  -->
			<a href="#" onclick="getList(); return false;" class="btn_pg_more r2" id="btn_more">
				<span class="va_m"></span> <span id="span_more">더보기 6 of 6</span>
			</a>
		</div>
    </article>   

	<jsp:include page="../templates/footer.jsp" flush="true"/>

</div>

<div class="modal_screen"></div>

<form method="post" id="insertForm" action="">
    <input type="hidden" id="mode" name="mode" value="ins" />
</form>     

<form method="post" id="detailForm" action="">
    <input type="hidden" id="pkNo" name="pkNo" value="" />
</form>

<!-- c3 chart -->
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.css"/>
<script src="https://d3js.org/d3.v3.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> -->

<script>
var auth = '${auth}';
</script>
<script src="${pageContext.request.contextPath}/js/m/view/clientSalesActive/hiddenOpportunityList.js"></script>

</body>
</html>