<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%  
response.setHeader("Cache-Control","no-store");  
response.setHeader("Pragma","no-cache");  
response.setDateHeader("Expires",0);  
if (request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache");
%>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>


<!doctype html>
<html lang="ko">
<body class="gray_bg" onload="tabmenuLiWidth();">
	
<div class="container_pg">
	<article class="">
		<div class="title_pg">
			<h2>${detail.ISSUE_SUBJECT}</h2>
			<a href="#" class="btn_back" onclick="fncGoBack(); return false;">back</a>
		</div>

		<div class="author">
			<span>${detail.HAN_NAME}(${detail.ISSUE_DATE})</span>
		</div>

		<ul class="tabmenu tabmenu_type2 mg_b20">
			<li><a href="#" id="tab_1" onclick="fncSelectTab('1');return false;" class="active">기본정보</a></li>
			<li><a href="#" id="tab_2" onclick="fncSelectTab('2');return false;" class="">이슈해결계획</a></li>
			<li><a href="#" id="tab_3" onclick="fncSelectTab('3');return false;">Coaching Talk</a></li>
		</ul>

		<div class="pg_cont">
			<!-- 위의 탭 클릭시 아래의 cont1, cont2, cont3 가  하나씩 보여지도록 해주세요 -->
	
			<div class="cont1 "><!-- 기본정보 -->
	
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 고객사
					</div>
					<div class="cont fl_l">${detail.COMPANY_NAME}</div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 고객사 ID
					</div>
					<div class="cont fl_l">${detail.COMPANY_ID}</div>
				</div>
	
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 고객명
					</div>
					<c:set var="COMPANY_NAME" value="${fn:split(detail.COMPANY_NAME,',')}" />
					<c:forEach items="${detail.CUSTOMER_NAME}" var="custom" varStatus="status">
						<div class="cont fl_l">
							<c:if test="${status.index > 0}">
								,&nbsp;
							</c:if>
							${custom}  /  ${COMPANY_NAME[status.index]}
						</div>
					</c:forEach>
				</div>
	
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 영업대표
					</div>
					<div class="cont fl_l">${detail.SALES_REPRESENTIVE_NAME} <c:if test="${detail.SALES_REPRESENTIVE_RANK != ''}"> / ${detail.SALES_REPRESENTIVE_RANK}</c:if></div>
				</div>
				
				<%-- <div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 해결책임자
					</div>
					<div class="cont fl_l">${detail.CONFIRM_NAME}</div>
				</div>
				 --%>
				 
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span>해결책임자 
					</div>
					<div class="cont fl_l">${detail.SOLVE_OWNER_NAME} <c:if test="${detail.SOLVE_OWNER_RANK != ''}"> / ${detail.SOLVE_OWNER_RANK}</c:if></div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 이슈영역
					</div>
					<div class="cont fl_l">${detail.ISSUE_CATEGORY}</div>
				</div>
								
				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 이슈내용
					</div>
					<div class="cboth cont_box">${detail.ISSUE_DETAIL}</div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l w_120">
						<span class="bullet dot"></span> 이슈발생일
					</div>
					<div class="cont fl_l">${detail.ISSUE_DATE}</div>
				</div>
				
				
				<div class="view_cata b_line">
					<div class="ti fl_l w_120">
						<span class="bullet dot"></span> 이슈해결일
					</div>
					<div class="cont fl_l">${detail.ISSUE_CLOSE_DATE}</div>
				</div> 
				
				<div class="view_cata b_line">
					<div class="ti fl_l w_120">
						<span class="bullet dot"></span> 해결목표일
					</div>
					<div class="cont fl_l">${detail.DUE_DATE}</div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l w_120">
						<span class="bullet dot"></span> 이슈해결확인자
					</div>
					<div class="cont fl_l">${detail.CONFIRM_NAME} <c:if test="${detail.CONFIRM_RANK != ''}"> / ${detail.CONFIRM_RANK}</c:if></div>
				</div>
				
				<c:if test="${!empty detail.EVENT_ID}">
					<div class="view_cata b_line">
						<div class="ti fl_l w_120">
							<span class="bullet dot"></span> 연관 고객컨택
						</div>
						<div class="cont fl_l">
							<a href="/clientSalesActive/selectContactDetail.do?pkNo=${detail.EVENT_ID}" class="btn_quick">바로가기</a>
						</div>
					</div>
				</c:if>
			
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 메일공유
					</div>
					<div class="cont fl_l">
						<c:forEach items="${shareMail}" var="mail" varStatus="status">
							<c:choose>
								<c:when test="${status.index == 0}">
									${mail.HAN_NAME}
								</c:when>
								<c:otherwise>
									,${mail.HAN_NAME}
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>
				</div>

				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 첨부파일
					</div>
					<div class="cboth cont_box">
						<ul class="file_list"></ul>
					</div>
				</div>
			</div>
			
			<div class="cont2 off"><!-- 이슈해결계획 -->
				<div class="view_cata_full">
					<!-- <div class="ti mg_b5">
						<span class="bullet dot"></span>이슈해결계획
					</div> -->
					
					<%-- <c:forEach var="rows" items="${rows}">
						<div class="cboth cont_box">${rows.SOLVE_PLAN}</div>
					</c:forEach> --%>
					<div class="cboth keymilestones_list">
                <ul class="list_type1" id="result_list">
                    <!-- 내용이 입력됩니다. -->
                </ul>
            </div>
				</div>
	
		<%-- 		<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 이슈해결(증빙내용)
					</div>
					<div class="cboth cont_box">${detail.SOLVE_EVIDENCE_DETAIL}</div>
				</div> --%>
	
			</div>
			
			<div class="cont3 off"><!-- Coaching Talk -->
				<div class="view_cata_full">
       		<jsp:include page="/WEB-INF/jsp/m/common/coachingTalkTab.jsp"/>
       	</div>
			</div>
		</div>
	</article>
	</div>
	<jsp:include page="../templates/footer.jsp" flush="true"/>

<div class="pg_bottom_func">
	<ul>
		<li><a href="#" class="" onclick="fncList(); return false;"> <img src="${pageContext.request.contextPath}/images/m//icon_list.png" /> <span>목록</span></a></li>
		<li><a href="#" class="" onclick="fncModify(); return false;"> <img src="${pageContext.request.contextPath}/images/m//icon_edit.png" /> <span>수정</span></a></li>
	</ul>
</div>

<form method="post" id="updateForm" action="">
	<input type="hidden" id="mode" name="mode" value="upd" />
	<input type="hidden" id="pkNo" name="pkNo" value="${detail.ISSUE_ID}" />
</form>  

<script>
var tabNo = '${param.tabNo}';
var coachingTalkParam = '${param.coaching_talk}';
</script>

<script src="${pageContext.request.contextPath}/js/m/view/clientSatisfaction/clientIssueDetail.js"></script>

</body>
</html>