<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>
<%  
response.setHeader("Cache-Control","no-store");  
response.setHeader("Pragma","no-cache");  
response.setDateHeader("Expires",0);  
if (request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache");
%>
<!doctype html>
<html lang="ko">

<body class="gray_bg">

<div class="container_pg_list">
	<c:set var="now" value="<%=new java.util.Date()%>" />
	<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set> 
	<c:set var="sysMM"><fmt:formatDate value="${now}" pattern="MM" /></c:set>
	
	<c:choose>
		<c:when test="${sysMM == '01' || sysMM == '02' || sysMM == '03' }">
			<c:set var="sysQuarter" value="1" />
		</c:when>
		<c:when test="${sysMM == '04' || sysMM == '05' || sysMM == '06' }">
			<c:set var="sysQuarter" value="2" />
		</c:when>
		<c:when test="${sysMM == '07' || sysMM == '08' || sysMM == '09' }">
			<c:set var="sysQuarter" value="3" />
		</c:when>
		<c:otherwise>
			<c:set var="sysQuarter" value="4" />
		</c:otherwise>
	</c:choose>

	<article class="list_pg">
		<!-- 현황 영역 -->
		<div class="top_statusarea_white_bg">
			<h4>컨택 현황</h4>
			<div class="status_box mg_b20">
				<div class="row">
					<ul>
						<li>
							<span class="ti fl_l">전체 컨택수</span>
							<span class="count fl_r">
								<!-- <span class="icon_dash icon_dash_build"></span>  -->
								<span class="va_m">${contactTotalCnt.CONTACT_CNT}</span>
								<span class="fs12">건</span>
							</span>
						</li>
						<li>
							<span class="ti fl_l">금주 컨택수</span>
							<span class="count fl_r">
							<!-- <span class="icon_dash icon_dash_build"></span>  -->
								<span class="va_m">${selectWeekContactCnt}</span>
								<span class="fs12">건</span>
							</span>
						</li>
					</ul>
				</div>
			</div>
						
			<h4>${sysYear}년${sysQuarter}분기 컨택방법별 현황</h4>
			<table id="contactMethodTable" class="status_table mg_b20" summary="">
				<caption></caption>
				<colgroup>
					<col width="" />
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
						<th scope="col">방문</th>
						<th scope="col">E-mail</th>
						<th scope="col">SNS</th>
						<th scope="col">마케팅</th>
						<th scope="col">전화</th>
					</tr>
				</thead>
				<tbody>
			
				</tbody>
			</table>
			
			<h4>${sysYear}년 연관 이슈 · 잠재영업기회 현황</h4>
			<table id="issueOppStatusTable" class="status_table mg_b20" summary="">
				<caption></caption>
				<colgroup>
					<col width=""/>
					<col width="15%"/>
					<col width="15%"/>
					<col width="30%"/>
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
						<th scope="col">이슈</th>
						<th scope="col">잠재영업기회</th>
					</tr>
				</thead>
				<tbody>				
				</tbody>
			</table>
			
			<!-- data_info 테이블이 없어 임시로 주석처리 2020. 01. 14. -->
			<div class="overflow_h off">
				<div class="fl_l">
					<h4>고객컨택 기간별 추이</h4>
				</div>
				<div class="fl_r">
					<%-- <c:if test="${fn:contains(auth, 'ROLE_TEAM')}">
						<select class="form-control" id="lineGraphSelectbox2" onchange="changeLineGraphSelectbox2('team', this.value);">
								<option value="all" id="optionValue_ALL">회사전체보기</option>
							<c:forEach items="${lineGraphSelectTEAMOption}" var="lineGraphSelectTEAMOption" varStatus="status">
								<option value="${lineGraphSelectTEAMOption.NUMS}" id="optionValueTeam${status.index}">${lineGraphSelectTEAMOption.NAMES}</option>
							</c:forEach>
						</select>
					</c:if> --%>
					<c:if test="${!fn:contains(auth, 'ROLE_MEMBER')}">
						<select class="form-control" id="lineGraphSelectbox" onchange="changeLineGraphSelectbox('ceo', this.value);">
							
							<%-- <c:forEach items="${lineGraphSelectOption}" var="lineGraphSelectOption" varStatus="status">
								<option value="${lineGraphSelectOption.NUMS}" id="optionValue${status.index}">${lineGraphSelectOption.NAMES2}</option>
							</c:forEach> --%>
							
							<c:choose>
								<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
									<c:choose>
										<c:when test="${fn:contains(userInfo[18],'Y')}">
											<option value="all" id="optionValue_ALL">회사전체</option>
											<c:forEach items="${selectTeamNameList}" var="selectTeamNameList" varStatus="status">
												<option value="${selectTeamNameList.TARGET_NO}" id="optionValue${status.index}">${selectTeamNameList.TARGET_NAME}</option>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<option value="all" id="optionValue_ALL">회사전체</option>
											<c:forEach items="${selectTeamNameList}" var="selectTeamNameList" varStatus="status">
												<option value="${selectTeamNameList.TARGET_NO}" id="optionValue${status.index}">${selectTeamNameList.TARGET_NAME}</option>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
									<option value="all" id="optionValue_ALL">본부전체</option>
									<c:forEach items="${selectTeamNameList}" var="selectTeamNameList" varStatus="status">
										<option value="${selectTeamNameList.TARGET_NO}" id="optionValue${status.index}">${selectTeamNameList.TARGET_NAME}</option>
									</c:forEach>
								</c:when>
								<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
									<option value="all" id="optionValue_ALL">팀전체</option>
									<c:forEach items="${selectTeamNameList}" var="selectTeamNameList" varStatus="status">
										<option value="${selectTeamNameList.TARGET_NO}" id="optionValue${status.index}">${selectTeamNameList.TARGET_NAME}</option>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${fn:contains(userInfo[18],'Y')}">
											<option value="all" id="optionValue_ALL">회사전체</option>
											<c:forEach items="${selectTeamNameList}" var="selectTeamNameList" varStatus="status">
												<option value="${selectTeamNameList.TARGET_NO}" id="optionValue${status.index}">${selectTeamNameList.TARGET_NAME}</option>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<option value="all" id="optionValue_ALL">회사전체</option>
											<c:forEach items="${selectTeamNameList}" var="selectTeamNameList" varStatus="status">
												<option value="${selectTeamNameList.TARGET_NO}" id="optionValue${status.index}">${selectTeamNameList.TARGET_NAME}</option>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</select>
					</c:if>
				</div>
			</div>
			<div id="LineGraph"></div>
			
		</div>
				
		<%-- <c:choose>
			<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
				컨택 방법별 현황<br>
				<c:forEach items="${clientContactmethod}" var="cnt">
					<P>${cnt.TARGET_NAME} / ${cnt.TOTAL_CNT} / ${cnt.VISIT_CNT} / ${cnt.MARKETING_CNT} / ${cnt.SNS_CNT} / ${cnt.EMAIL_CNT} / ${cnt.PHONE_CNT}</P>
				</c:forEach>
				
				<br><br>
				
				연관이슈 / 연관잠재영업기회 현황<br>
				<c:forEach items="${issueOppStatusCnt}" var="cnt">
					<p>${cnt.TARGET_NAME} / ${cnt.TOTAL_CNT} / ${cnt.ISSUE_CNT} / ${cnt.HIDDENOPP_CNT}</p>
				</c:forEach>
			</c:when>
			<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
				
				컨택 방법별 현황<br>
				<c:forEach items="${clientContactmethod}" var="cnt">
					<P>${cnt.TARGET_NAME} / ${cnt.TOTAL_CNT} / ${cnt.VISIT_CNT} / ${cnt.MARKETING_CNT} / ${cnt.SNS_CNT} / ${cnt.EMAIL_CNT} / ${cnt.PHONE_CNT}</P>
				</c:forEach>
				
				연관이슈 / 연관잠재영업기회 현황<br>
				<c:forEach items="${issueOppStatusCnt}" var="cnt">
					<p>${cnt.TARGET_NAME} / ${cnt.TOTAL_CNT} / ${cnt.ISSUE_CNT} / ${cnt.HIDDENOPP_CNT}</p>
				</c:forEach>
			</c:when>
		</c:choose> --%>
		
		<!-- 검색 및 리스트 -->
		<div class="cont_list_gray_bg">
			<c:choose>
				<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">				
						<input type="hidden" id="contactSelectbox" value="${global_member_id}"/>
				</c:when>
				
				<c:otherwise>
<%--
				<div class="fl_l">
					<h4>최근 1주일간 컨택 목록<span class="fs12">(총25건)</span></h4>
				</div>
				<div class="fl_r">
					<c:if test="${fn:contains(auth, 'ROLE_CEO')}">
					<select class="form-control" id="contactSelectboxCeo" onchange="contactSelectboxCEO(this.value, 'ceo');">
					</c:if>
					<c:if test="${fn:contains(auth, 'ROLE_TEAM')}">
					<select class="form-control" id="contactSelectboxTeam" onchange="contactSelectboxTEAM(this.value, 'team');">
					</c:if>
						<option value="all" id="optionValue_ALL">전체보기</option>
						<c:forEach items="${lineGraphSelectOption}" var="lineGraphSelectOption" varStatus="status">
							<option value="${lineGraphSelectOption.NUMS}" id="optionValue${status.index}">${lineGraphSelectOption.NAMES2}</option>
						</c:forEach>
					</select>
				</div>
 --%>
 
 <%-- 더보기 버튼이 있으면 제거
				<div class="fl_l">
					<h4>최근 1주일간 컨택 목록<span class="fs12">(총25건)</span></h4>
				</div>
--%>
			<div class="topFunc mg_b10">
				<div class="sortArea fl_r">
					
						<c:choose>
							<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
								<select class="form-control" id="contactSelectbox" onchange="selectData(this.value);" style="background: white;">
									<option value="">회사전체</option>
								</select>
							</c:when>
						
							<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
								<select class="form-control" id="contactSelectbox" onchange="selectData(this.value);" style="background: white;">
									<option value="">본부전체</option>
								</select>
							</c:when>
						
							<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
								<select class="form-control" id="contactSelectbox" onchange="selectData(this.value);" style="background: white;">
									<option value="">팀전체</option>
								</select>
							</c:when>
						
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					
				</div>
			</div>
	</c:otherwise>
</c:choose>

			<div class="topFunc_search_new mg_b10">
				<div class="search_pgin">
					<div class="searchArea">
						<input type="text" id="textSearchKeyword" placeholder="고객명, 고객사 또는 제목 입력" />
						<a href="#" onClick="fncSearch(); return false;"><span class="icon_search"></span></a>
					</div>
				</div>
				<a href="#" class="btn btn-primary r5" id="clientContactInsertForm"><span class="">신규 등록</span></a>
			</div>
		
			<!-- 
			<div class="topFunc mg_b10">
				<div class="sortArea fl_l">
					<div class="dropdown">
						<button class="dropdown-toggle r5 " type="button">
							<span id="select_text">컨텍 분류선택</span>
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu w_120 r5 off">
							<li><a href="#" onclick="fncSelectGroup('컨텍 분류선택'); return false;">== 선택 ==</a></li>
							<li><a href="#" onclick="fncSelectGroup('방문'); return false;">방문</a></li>
							<li><a href="#" onclick="fncSelectGroup('마케팅'); return false;">마케팅</a></li>
							<li><a href="#" onclick="fncSelectGroup('SNS'); return false;">SNS</a></li>
							<li><a href="#" onclick="fncSelectGroup('E-mail'); return false;">E-mail</a></li>
							<li><a href="#" onclick="fncSelectGroup('전화'); return false;">전화</a></li>
						</ul>
					</div>
				</div>
	
				<div class="fl_r">
					<a href="#" class="btn btn-primary r5" onclick="fncRegister(); return false;"> <span class="icon lg icon_pencil_white va_tb"></span> 컨텍등록</a>
				</div>
			</div>
			 -->

			<ul class="list_type1" id="result_list2">
			<!-- 내용이 입력됩니다. -->
				<div id="list_type_coop">
				</div>
				<div id="blank_html" class="off">
				</div>
				<!-- 
				<div id="list_type_coop2">
				</div>
				 -->
			</ul>
<%--
			<a href="#" onclick="fncShowMore('','','add'); return false;" class="btn_pg_more r2" id="btn_more">
				<span class="va_m" id="span_more">더보기 6 of 6</span>
			</a>
 --%>
			<a href="#" onclick="showMore(); return false;" class="btn_pg_more r2" id="btn_more">
				<span class="va_m" id="span_more">더보기 10 of 10</span>
			</a>

		</div>
		<!--// 검색 및 리스트 -->

	</article>   
	<jsp:include page="../templates/footer.jsp" flush="true"/>
	
	<form id="frm" name="frm">
	</form>

  <form method="post" id="moveForm" action="">
      <input type="hidden" id="mode" name="mode" value="ins" />
      <input type="hidden" id="pkNo" name="pkNo" value="" />
  </form>    

</div>
<div class="modal_screen"></div>

<!-- c3 chart -->
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.css"/>
<script src="https://d3js.org/d3.v3.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> -->

<script>
var totalCnt = '${totalCnt}';
var auth = '${auth}';
</script>
<script src="${pageContext.request.contextPath}/js/m/view/clientSalesActive/clientContactList.js"></script>
</body>
</html>