<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<title>전략프로젝트</title>
<jsp:include page="/WEB-INF/jsp/m/common/top.jsp"/>
<%@ include file="/WEB-INF/jsp/m/common/functions.jsp" %>
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="sysNow"><fmt:formatDate value="${now}" pattern="yyyymmdd" /></c:set>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
<title>전략프로젝트</title>

<link href="${pageContext.request.contextPath}/css/m/style.css" rel="stylesheet" type="text/css">

</head>

<body class="gray_bg">
<jsp:include page="../templates/header.jsp" flush="true"/>
<!-- location -->
<%-- <div class="location">
	<a href="/main/index.do" class="home"><img src="${pageContext.request.contextPath}/images/m/icon_home.svg"/></a>
	<img src="${pageContext.request.contextPath}/images/m/icon_arrow_gray.svg"/>
	<span>고객영업활동</span> 
	<img src="${pageContext.request.contextPath}/images/m/icon_arrow_gray.svg"/>
	<jsp:include page="../common/nav.jsp" flush="true"/>
</div> --%>
<!-- location -->
<jsp:include page="../common/nav.jsp" flush="true"/>

<div class="container_pg_list">
	<article class="">
		<div class="title_pg  ">
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
				<li><a href="#" id="tab_1" class="active" onclick="fncSelectTab('1'); return false;">기본정보</a></li>
				<li><a href="#" id="tab_2" onclick="fncSelectTab('2'); return false;">매출현황</a></li>
				<li><a href="#" id="tab_3" onclick="fncSelectTab('3'); return false;">KeyMilestones</a></li>
				<li><a href="#" id="tab_4" onclick="fncSelectTab('4'); return false;">이슈</a></li>
			</ul>

			<!-- 위의 탭 클릭시 아래의 cont1, cont2, cont3 가  하나씩 보여지도록 해주세요 -->

			<div class="cont1 "><!-- 기본정보 -->
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 카테고리
					</div>
					<div class="cont fl_l">${detail.Category}</div>
				</div>

				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 사업부서
					</div>
					<div class="cont fl_l">${detail.MEMBER_TEAM}</div>
				</div>

				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 고객사
					</div>
					<div class="cont fl_l">${detail.COMPANY_NAME}</div>
				</div>

				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 고객사ID
					</div>
					<div class="cont fl_l">${detail.COMPANY_ID}</div>
				</div>

				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 책임리더
					</div>
					<div class="cont fl_l">${detail.EXEC_OWNER}</div>
				</div>

				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 영업대표
					</div>
					<div class="cont fl_l">${detail.CEO_NAME}</div>
				</div>

				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 기간
					</div>
					<div class="cont fl_l">${detail.START_DATE} ~ ${detail.END_DATE}</div>
				</div>

				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 프로젝트 개요
					</div>
					<div class="cboth cont_box"><pre>${detail.DETAIL_CONTENTS}</pre></div>
				</div>

				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 첨부파일
					</div>
					<div class="cboth cont_box">
						<ul class="file_list">
							<c:forEach items="${fileList}" var="file">
							<li><a href="/common/downloadFile.do?fileId=${file.FILE_ID}&fileTableName=2">${file.FILE_NAME}</a></li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>

			<div class="cont2 off"><!-- Plan / Actual -->
				<h3 class="mg_b5">계약금액 및 예상매출</h3>

				<div class="mg_b10">
					<select disabled>
						<option ${detail.CONTRACT_AMOUNT_UNIT eq 'm' ? 'selected' : ''}>월 단위</option>
						<option ${detail.CONTRACT_AMOUNT_UNIT eq 'q' ? 'selected' : ''}>분기 단위</option>
					</select>
<%--
					<select id="select_contract">
						<c:forEach items="${selectProjectPlanContractInfo}" var="contract">
						<c:choose>
						<c:when test="${detail.CONTRACT_AMOUNT_UNIT eq 'q'}">
							<option value="${contract.BASIS_MONTH}">${contract.PLAN_YEAR}년 ${contract.PLAN_QUARTER}분기</option>
						</c:when>
						<c:otherwise>
							<option value="${contract.BASIS_MONTH}">${contract.PLAN_YEAR}년 ${contract.PLAN_MONTH}월</option>
						</c:otherwise>
						</c:choose>
						</c:forEach>
					</select>
 --%>
				</div>
				
				<table class="basic mg_b30"><!-- 예상매출 -->
					<c:forEach items="${selectProjectPlanContractInfo}" var="contract" varStatus="status">
					<tr class="tr_contract tr_contract_${contract.BASIS_MONTH}">
						<th style="color:#999; width:15%">${contract.BASIS_MONTH}</th>
						<th style="color:#999; width:15%">Plan / Actual</th>
						<td>
							<fmt:formatNumber value="${contract.BASIS_PLAN_REVENUE_AMOUNT}" pattern="#,###" />
							/
							<fmt:formatNumber value="${contract.BASIS_ACTUAL_REVENUE_AMOUNT}" pattern="#,###" />
						</td>
					</tr>
					</c:forEach>
					<tr class="total">
						<th colspan="2" class="ta_c">전체계약금액</th>
						<td colspan="1" ><fmt:formatNumber value="${detail.CONTRACT_AMOUNT_TOTAL}" pattern="#,###" /></td>
					</tr>
				</table>

				<h3 class="mg_b5">투자비용 산정</h3>

				<div class="mg_b10">
					<select disabled>
						<option ${detail.INVEST_AMOUNT_UNIT eq 'm' ? 'selected' : ''}>월 단위</option>
						<option ${detail.INVEST_AMOUNT_UNIT eq 'q' ? 'selected' : ''}>분기 단위</option>
					</select>
<%--
					<select id="select_invest">
						<c:forEach items="${selectProjectPlanInvestInfo}" var="invest">
						<c:choose>
						<c:when test="${detail.CONTRACT_AMOUNT_UNIT eq 'q'}">
							<option value="${invest.BASIS_MONTH}">${invest.PLAN_YEAR}년 ${invest.PLAN_QUARTER}분기</option>
						</c:when>
						<c:otherwise>
							<option value="${invest.BASIS_MONTH}">${invest.PLAN_YEAR}년 ${invest.PLAN_MONTH}월</option>
						</c:otherwise>
						</c:choose>
						</c:forEach>
					</select>
 --%>
				</div>

				<table class="basic mg_b30">
					<c:forEach items="${selectProjectPlanInvestInfo}" var="invest" varStatus="status">
					<tr class="tr_invest tr_invest_${invest.BASIS_MONTH}">
						<th style="color:#999; width:15%">${invest.BASIS_MONTH}</th>
						<th style="color:#999; width:15%">Plan / Actual</th>
						<td>
							<fmt:formatNumber value="${invest.BASIS_PLAN_INVEST_AMOUNT}" pattern="#,###" />
							/
							<fmt:formatNumber value="${invest.BASIS_ACTUAL_INVEST_AMOUNT}" pattern="#,###" />
						</td>
					</tr>
					</c:forEach>
					<tr class="total">
						<th colspan="2"  class="ta_c">전체투자금액</th>
						<td><fmt:formatNumber value="${detail.INVEST_AMOUNT}" pattern="#,###" /></td>
					</tr>
				</table>
				
			</div>

			<div class="cont3 off"><!-- keymilestones -->
				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> Key Milestones
					</div>
					<div class="cboth keymilestones_list">
						<ul>
							<c:forEach items="${rows}" var="kms">
							<c:if test="${!empty kms.KEY_MILESTONE}">
							<li>
								<div class="top">
									<span class="title">${kms.KEY_MILESTONE}</span>
									<fmt:parseNumber var="sysNowInt" type = "number" value = "${sysNow}" />
									<fmt:parseNumber var="RE_ACT_DUE_DATE" type = "number" value = "${fn:replace(kms.ACT_DUE_DATE, '-', '')}" />
									<c:choose>
										<c:when test="${(RE_ACT_DUE_DATE >= sysNowInt) && kms.ACT_CLOSE_DATE == null}"><span class="status_lec statusColor_yellow"></span></c:when>
										<c:when test="${RE_ACT_DUE_DATE < sysNowInt && kms.ACT_CLOSE_DATE == null}"><span class="status_lec statusColor_red"></span></c:when>
										<c:when test="${kms.ACT_CLOSE_DATE != '' && kms.ACT_CLOSE_DATE != null}"><span class="status_lec statusColor_green"></span></c:when>
									</c:choose>
								</div>
								<div class="cont">
									<span class="fc_gray_light">책임 담당자 : </span> <span class="fc_black">${kms.ACT_ID}</span><br/>
									<span class="fc_gray_light">목표일 : </span> <span class="fc_black">${kms.ACT_DUE_DATE}</span>
									<c:if test="${!empty kms.ACT_CLOSE_DATE}">
									 / <span class="fc_gray_light">완료일 : </span> <span class="fc_black">${kms.ACT_CLOSE_DATE}</span>
									 </c:if>
								</div>
							</li>
							</c:if>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			
			
			<!-- 이슈 -->
			<div class="cont4 off">
				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 이슈
					</div>
					<div class="cboth issue_list">
						<ul>
						<c:forEach items="${issueList}" var="issue">
							<li>
								<div class="top top2">
									<span class="title">이슈내용 : ${issue.ISSUE_NAME}</span>
									<span class="title">해결계획 : ${issue.ACTION_PLAN_NAME}</span>
									<c:choose>
										<c:when test="${issue.STATUS eq 'G'}"><span class="status_lec statusColor_green"></span></c:when>
										<c:when test="${issue.STATUS eq 'Y'}"><span class="status_lec statusColor_yellow"></span></c:when>
										<c:when test="${issue.STATUS eq 'R'}"><span class="status_lec statusColor_red"></span></c:when>
										<c:otherwise></c:otherwise>
									</c:choose>
								</div>
								<div class="cont">
									<span class="fc_gray_light">책임 담당자 : </span> <span class="fc_black">${issue.ACTION_OWNER }</span><br/>
									<span class="fc_gray_light">목표일 : </span> <span class="fc_black">${issue.DUE_DATE}</span> / 
									<span class="fc_gray_light">완료일 : </span> <span class="fc_black">${issue.CLOSE_DATE}</span>
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
				<button type="button" class="btn lg btn-default pd_r15 pd_l15 r5" onclick="fncList(); return false;">목록</button>
			</div>
		</div> -->

	</article>
</div>
<script src="${pageContext.request.contextPath}/js/m/jquery-1.11.0.min.js"></script>
<!-- 
<script src="${pageContext.request.contextPath}/js/common.js"></script>
 -->

<script type="text/javascript">
	function fncList(){
		//location.href= '/bizStrategy/viewBizStrategyProjectPlan.do?searchCategory=${param.searchCategory}';
		location.href= '/bizStrategy/viewBizStrategyProjectPlan.do';
	}
	
	// 바로가기 파라미터 있는 경우에는 탭이동 함수 실행
	var tabNum = null;
	tabNum= '${param.tabNo}';
	
	if(tabNum != ''){
		fncSelectTab(tabNum);
	}
	
	function fncSelectTab(_no){
		// 탭 이동
		$('#tab_1').removeClass('active');
		$('#tab_2').removeClass('active');
		$('#tab_3').removeClass('active');
		$('#tab_4').removeClass('active');
		$('#tab_'+_no).addClass('active');
		
		// 탭에 해당하는 컨테이너 보여주기
		$('.cont1').addClass('off');
		$('.cont2').addClass('off');
		$('.cont3').addClass('off');
		$('.cont4').addClass('off');
		$('.cont'+_no).removeClass('off');
		
	}
	
	$(document).ready(function() {
		$('#select_contract').change(function(){
			var basis_month = $(this).val();
			$('.tr_contract').hide();
			$('.tr_contract_'+basis_month).show();
		});

		$('#select_invest').change(function(){
			var basis_month = $(this).val();
			$('.tr_invest').hide();
			$('.tr_invest_'+basis_month).show();
		});
	});
</script>
</body>
</html>
<jsp:include page="/WEB-INF/jsp/m/common/bottom.jsp"/>