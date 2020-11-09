<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>

<!doctype html>
<html lang="ko">

<body class="gray_bg">
<div class="container_pg_list">

	<article class="list_pg">
	<!-- 리스트 -->
	<div class="cont_list_gray_bg">
		<div class="topFunc mg_b10">
			<div class="sortArea">
				<div class="dropdown">
					<button class="dropdown-toggle r5 " type="button">
					  <span id="select_text">${map.detailCategory}</span>  
						<span class="caret"></span> 
					</button>
					<ul class="dropdown-menu w_100 r5 off">
						<!-- <li><a href="#" onclick="fncSelectGroup('전체보기'); return false;">전체보기</a></li> -->
						<c:choose>
							<c:when test="${fn:length(bizStrategySearchDetailGroup) > 0}">
								<c:forEach items="${bizStrategySearchDetailGroup}" var="category">
									<li><a href="#" onclick="fncSelectGroup('${category.CATEGORY}');">${category.CATEGORY}</a></li>
								</c:forEach>
							</c:when>
						</c:choose>
					</ul>
				</div>
			</div>
		</div>	

<%--
		<c:choose>
		<c:when test="${param.strategy eq 'biz'}">
		<div class="topFunc mg_b10">
			<div class="sortArea">
				<div class="dropdown">
					<button class="dropdown-toggle r5 " type="button">
					    <span id="select_text">본부전략</span>  
						<span class="caret"></span> 
					</button>
					<ul class="dropdown-menu w_100 r5 off">
<!--
						<li><a href="#" onclick="fncSelectGroup('전략 선택'); return false;">전략 선택</a></li>
 -->
					<c:choose>
						<c:when test="${fn:length(bizStrategySearchDetailGroup) > 0}">
							<c:forEach items="${bizStrategySearchDetailGroup}" var="category">
								<li><a href="#" onclick="fncSelectGroup('${category.CATEGORY}'); return false;">${category.CATEGORY}</a></li>
							</c:forEach>
						</c:when>
					</c:choose>
					</ul>
				</div>
			</div>
		</div>
		</c:when>
		<c:otherwise>
		

		<div class="search_pgin pd_b20">
			<div class="searchArea">
				<input type="" placeholder="고객명 또는 제목 입력" /><a href="#"><span class="icon_search"></span></a>
			</div>
		</div>
		
		</c:otherwise>
		</c:choose>
 --%>
 		<div class="search_pgin pd_b20">
			<div class="searchArea">
				<input type="text" name="search_keyword" id="search_keyword" value="${param.search_keyword}" placeholder="제목 입력" /><a href="#" id="btn_search_keyword"><span class="icon_search"></span></a>
			</div>
		</div>
 
		<div class="biz_str_sum">
			<ul>
				<li>
					<a href="#" class="r3 status_sum_box statusColor_red" id="R_count"></a>
				</li>
				<li>
					<a href="#" class="r3 status_sum_box statusColor_yellow" id="Y_count"></a>
				</li>
				<li>
					<a href="#" class="r3 status_sum_box statusColor_green" id="G_count"></a>
				</li>
			</ul>
		</div>

		<ul class="list_type1" id="result_list">
			<!-- 내용이 입력됩니다. -->
		</ul>
<%--
		<a href="#" onclick="fncShowMore(); return false;" class="btn_pg_more primary_bg r2 fc_white" id="btn_more">
			<span class="icon icon_arrow_down md va_m"></span> <span class="va_m" id="span_more">더보기 6 of 6</span>
		</a>
 --%>
		<a href="#" onclick="fncShowMore(); return false;" class="btn_pg_more r2" id="btn_more">
			<span class="va_m" id="span_more">더보기 6 of 6</span>
		</a>
		
	</div>
	<!--// 리스트 -->
	</article>
	
	<form id="frm" name="frm">
	</form>
</div>

<jsp:include page="/WEB-INF/jsp/m/common/bottom.jsp"/>

<script type="text/javascript">
	var detailCategory = '${map.detailCategory}';
	var strategy = "${param.strategy}";
</script>

<script src="${pageContext.request.contextPath}/js/m/view/bizStrategy/bizStrategyOurCompanyList.js"></script>
<script src="${pageContext.request.contextPath}/js/m/view/bizStrategy/bizStrategyCompanyList.js"></script>

</body>
</html>