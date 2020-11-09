<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/jsp/m/common/functions.jsp" %>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>

<!-- 현재년도 -->
<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set> 

<!doctype html>
<html lang="ko">

<body class="gray_bg">
	
	<article class="list_pg">
		<!-- 현황 영역 -->
		<div class="top_statusarea_white_bg">
			<h4><span id="issueCntYear"></span>년 <span id="issueCntQuarter"></span>분기 고객이슈 현황</h4>
			<div class="status_box mg_b20">
				<div class="row">
				</div>
			</div>
			
			<!-- 2020년 접수 및 처리현황 -->
			<h4><span id="issueSatusYear"></span>년 <span id="issueSatusQuarter"></span>분기 접수 및 처리현황</h4>
			<table class="status_table mg_b20" id="issueStatusTable" summary="">
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
						<th scope="col">접수</th>
						<th scope="col">진행중</th>
						<th scope="col">지연</th>
						<th scope="col">완료</th>
					</tr>
				</thead>
				<tbody>
					
				</tbody>
			</table>
			
			<!-- 이슈 종류별 현황 -->
			<h4><span id="issueTypeYear"></span>년 <span id="issueTypeQuarter"></span>분기 이슈 종류 현황</h4>
			<table class="status_table" id="issueStatusTypeTable" summary="">
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
						<th scope="col">접수</th>
						<th scope="col">제품</th>
						<th scope="col">서비스</th>
						<th scope="col">지원</th>
					</tr>
				</thead>
				<tbody>					
				</tbody>
			</table>
		</div>
		
		<!-- 검색 및 리스트 -->
		<div class="cont_list_gray_bg">
			<div class="sortArea fl_r">	
				<div class="topFunc mg_b10">
					<c:choose>
						<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
							<input type="hidden" id="contactSelectbox" value="${global_member_id}"/>
						</c:when>
					
						<c:otherwise>		
							<select class="form-control" id="contactSelectbox" onchange="selectData();" style="background: white;">
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
						</c:otherwise>
					</c:choose>	
				
					<select id="selectProgressCategory" onChange="selectData();" style="background: white;">
						<option value="" selected>전체</option>
						<option value="statusN">진행</option>
						<option value="statusX">지연</option>
						<option value="statusY">완료</option>
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
					<a href="#" class="btn btn-primary r5" id="clientIssueInsertForm"><span class="">신규 등록</span></a>
				</div>
				
				<!-- <div class="fl_r">
					<a href="#" class="btn md primary_bg fc_white r5" id="clientIssueInsertForm">
						<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> 이슈등록 
					</a>
				</div> -->
			
			<ul class="list_type1" id="result_list2">
				<!-- 내용이 입력됩니다. -->
				<div id="list_type_coop">
				</div>
				<div id="blank_html" class="off">
				</div>
			</ul>
	
			<a href="#" onclick="getList(); return false;" class="btn_pg_more r2" id="btn_more">
				<span class="icon icon_arrow_down md va_m"></span> <span class="va_m" id="span_more">더보기 6 of 6</span>
			</a>
		</div>
	</article>   
	<jsp:include page="../templates/footer.jsp" flush="true"/>
	
	<form id="frm" name="frm">
		
	</form>
		
	<form method="post" id="detailForm" action="">
		<input type="hidden" id="pkNo" name="pkNo" value="" />
	</form>
		
	<form method="post" id="inserForm" action="">
		<input type="hidden" id="mode" name="mode" value="ins" />
	</form>
		
</div>
<div class="modal_screen"></div>

<!-- c3 chart -->
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.css"/>
<script src="https://d3js.org/d3.v3.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> -->
		
<script>
var issueId = '${issue_id}';
</script>	
	
<script src="${pageContext.request.contextPath}/js/m/view/clientSatisfaction/clientIssueList.js"></script>
</body>
</html>