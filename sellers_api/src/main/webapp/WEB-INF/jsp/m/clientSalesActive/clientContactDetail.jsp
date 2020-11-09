<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>

<!doctype html>
<html lang="ko">

<body class="gray_bg" onload="tabmenuLiWidth();">

	<div class="container_pg">
		<article class="">
			<div class="title_pg">
				<h2 class="">${detail.EVENT_SUBJECT}</h2>
				<a href="#" class="btn_back" onclick="fncGoBack(); return false;">back</a>
			</div>

			<div class="author">
				<span>${detail.HAN_NAME}(${detail.LATELY_UPDATE_DATE})</span>
			</div>		
		
			<ul class="tabmenu tabmenu_type2 mg_b20">
				<li><a href="#" id="tab_1" onclick="fncSelectTab('1'); return false;" class="active">기본정보</a></li>
				<li><a href="#" id="tab_2" onclick="fncSelectTab('2'); return false;">Follow-Up Action</a></li>
				<li><a href="#" id="tab_3" onclick="fncSelectTab('3');return false;">Coaching Talk</a></li>
			</ul>

			<div class="pg_cont">
				<div class="cont1"><!-- 기본정보 -->

					<div class="view_cata b_line">
						<div class="ti fl_l">
							<span class="bullet dot"></span> 컨택방법
						</div>
						<div class="cont fl_l">${detail.EVENT_CATEGORY}</div>
					</div>
	
					<div class="view_cata b_line">
						<div class="ti fl_l">
							<span class="bullet dot"></span> 컨택일자
						</div>
						<div class="cont fl_l">${detail.EVENT_DATE} [${detail.EVENT_START_TIME}~${detail.EVENT_END_TIME}]</div>
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
							<span class="bullet dot"></span> 고객명
						</div>
						<!-- 외 ~명 처리 -->
						<input type="hidden" id="${detail.CLIENT_COUNT}" name="${detail.CLIENT_COUNT}">
						<c:set var="CLIENT_COUNT" value="${fn:split(detail.CLIENT_COUNT,',')}" />
						<c:set var="POSITION" value="${fn:split(detail.POSITION,',')}" />
						<c:forEach items="${detail.CUSTOMER_NAME}" var="custom" varStatus="status">
							<div class="cont fl_l">
								<c:if test="${status.index > 0}">
									,&nbsp;
								</c:if>
								${custom} / ${POSITION[status.index]}
							</div>
						</c:forEach>
						<c:if test="${fn:length(CLIENT_COUNT) > 1}">
							외 ${fn:length(CLIENT_COUNT)-1}명
						</c:if>
					</div>
				
					<div>
						<c:set var="CUSTOMER_NAME" value="${fn:split(rows.CUSTOMER_NAME,',')}" />
						${CUSTOMER_NAME[0]}
					</div>
					<div class="view_cata_full">
						<div class="ti mg_b5">
							<span class="bullet dot"></span> 상세내용
						</div>
						<%-- <div class="cboth cont_box">${detail.EVENT_CONTENTS}</div> --%>
						<textarea rows="" cols="cboth cont_box" readonly="readonly" style="height:200px;">${detail.EVENT_CONTENTS}</textarea>
					</div>
				
					<c:if test="${!empty detail.OPPORTUNITY_HIDDEN_ID}">
						<div class="view_cata_full">
							<div class="ti">
								<span class="bullet dot"></span> 연관 잠재영업기회
							</div>
							<div class="cboth cont_list">
								<a href="/clientSalesActive/selectHiddenOpportunityDetail.do?pkNo=${detail.OPPORTUNITY_HIDDEN_ID}" class="btn_quick">바로가기</a>
							</div>
						</div>
					</c:if>
				
					<c:if test="${!empty detail.ISSUE_ID}">
						<div class="view_cata_full">
							<div class="ti">
								<span class="bullet dot"></span> 연관 고객이슈
							</div>
							<div class="cboth cont_list">
								<a href="/clientSatisfaction/selectClientIssueDetail.do?pkNo=${detail.ISSUE_ID}" class="btn_quick">바로가기</a>
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
			
					<c:if test="${!empty fileList}">
						<div class="view_cata_full">
							<div class="ti mg_b5">
								<span class="bullet dot"></span> 첨부파일
							</div>
							<div class="cboth cont_box">
								<ul class="file_list">
									<c:forEach items="${fileList}" var="file">
									<li><a href="/common/downloadFile.do?fileId=${file.FILE_ID}&fileTableName=3">${file.FILE_NAME}</a></li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</c:if>

			</div>

			<div class="cont2 off">
				<!-- Follow-Up-Action -->
				<div class="view_cata_full">
					<div class="cboth keymilestones_list">
	            <ul class="list_type1" id="result_list">
	                <!-- 내용이 입력됩니다. -->
	            </ul>
	        </div>
	        
					<%-- <div class="ti mg_b5 fl_l">
					</div>
						
					<div class="cboth keymilestones_list">
						<ul>
							<c:forEach items="${actionList}" var="action">
							<li>
								<div class="top top2">
									<span class="title">${action.CONTENTS}</span>
									<c:choose>
										<c:when test="${action.STATUS_COLOR == 'green'}">
											<span class="status_lec statusColor_green"></span>
										</c:when>
										<c:when test="${action.STATUS_COLOR == 'yellow'}">
											<span class="status_lec statusColor_yellow"></span>
										</c:when>
										<c:when test="${action.STATUS_COLOR == 'red'}">
											<span class="status_lec statusColor_red"></span>
										</c:when>
										<c:otherwise>
											<span class="status_lec statusColor_gray"></span>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="cont">
									<span class="fc_gray_light">책임자 : </span> <span class="fc_black">&nbsp&nbsp ${action.SOLVE_OWNER}</span> <br/>
									<span class="fc_gray_light">목표일 : </span> <span class="fc_black">&nbsp&nbsp ${action.SOLVE_DUE_DATE}</span> &nbsp&nbsp
									<span class="fc_gray_light">완료일 : </span> <span class="fc_black">&nbsp&nbsp ${action.SOLVE_CLOSE_DATE}</span>
								</div>
							</li>
							</c:forEach>
						</ul>
					</div> --%>
					
				</div>
				<!-- // Follow-Up-Action -->
		</div>
		
		<div class="cont3 off"><!-- Coaching Talk -->
			<div class="view_cata_full">
     		<jsp:include page="/WEB-INF/jsp/m/common/coachingTalkTab.jsp"/>
     	</div>
		</div>

		<!-- 
		<div class="pg_bottom t_line">
			<div class="ta_c">
				<button type="button" class="btn lg btn-default pd_r15 pd_l15 r5" onclick="fncList(); return false;">목록</button>
			</div>
		</div>
 		-->
	</article>   

	<jsp:include page="../templates/footer.jsp" flush="true"/>

</div>
<div class="pg_bottom_func">
	<ul>
	  <li>
	    <a href="#" class="" onclick="fncList(); return false;">
	      <img src="${pageContext.request.contextPath}/images/m/icon_list.png" /> 
	      <span>목록</span>
	    </a>
	  </li>
	  <li>
	    <a href="#" class="" onclick="fncModify(); return false;"> 
	      <img src="${pageContext.request.contextPath}/images/m/icon_edit.png" /> 
	      <span>수정</span>
	    </a>
	  </li>
	</ul>
</div>

<div class="modal_screen"></div>

<form method="post" id="updateForm" action="">
	<input type="hidden" id="mode" name="mode" value="upd" />
	<input type="hidden" id="pkNo" name="pkNo" value="${detail.EVENT_ID}" />
</form>  

<script>
	// 바로가기 파라미터 있는 경우에는 탭이동 함수 실행
	var tabNo = '${param.tabNo}';
	var coachingTalkParam = '${param.coaching_talk}';
</script>

<script src="${pageContext.request.contextPath}/js/m/view/clientSalesActive/clientContactDetail.js"></script>

</body>
</html>