<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp"%>

<!doctype html>
<html lang="ko">
<head>
<style>
.ellipsis {
	display: block;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	width: 320px;
	height: 20px;
	}
</style>
</head>

<body class="gray_bg">
<div class="container_pg_list">

	<article class="list_pg">
		<!-- 리스트 -->
		<div class="cont_list_gray_bg">
	
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
		<!-- <a href="#" onclick="fncShowMore(); return false;" class="btn_pg_more primary_bg r2 fc_white" id="btn_more"> -->
		<a href="#" onclick="fncShowMore(); return false;" class="btn_pg_more primary_bg r2" id="btn_more">
			<span class="icon icon_arrow_down md va_m"></span> <span class="va_m" id="span_more">더보기 6 of 6</span>
		</a>
 --%>
 <!-- 
		<a href="#" onclick="fncShowMore(); return false;" class="btn_pg_more r2" id="btn_more">
			<span class="va_m" id="span_more">더보기 6 of 6</span>
		</a>
		 -->
			</div>
		</article>
	</div>
<jsp:include page="/WEB-INF/jsp/m/common/bottom.jsp"/>

<script type="text/javascript">
	var detailCategory = '${map.detailCategory}';
	var strategy = '${param.strategy}';
	var searchKeyword = '${param.searchKeyword}';	
</script>

<script src="${pageContext.request.contextPath}/js/m/view/bizStrategy/bizStrategyClientCompanyList.js"></script>
<script src="${pageContext.request.contextPath}/js/m/view/bizStrategy/bizStrategyCompanyList.js"></script>

</body>
</html>