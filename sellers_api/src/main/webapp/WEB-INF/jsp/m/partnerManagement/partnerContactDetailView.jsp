<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
<title>고객컨텍관리 상세보기</title>

<link href="${pageContext.request.contextPath}/css/m/style.css" rel="stylesheet">

</head>

<body class="gray_bg" onload="tabmenuLiWidth();">
<jsp:include page="../templates/header.jsp" flush="true"/>

	<!-- location -->
	<div class="breadcrumb">
		<a href="#" class="home"><img src="../../../images/m/icon_home.svg" /></a>
		<div class="breadcrumb_depth1">
			<a class="active_menu">&nbsp;파트너사 협업관리</a>
		</div>
		<%-- <jsp:include page="../common/nav.jsp" flush="true"/> --%>
	</div>
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
		</ul>

		<div class="pg_cont">
			<div class="cont1"><!-- 기본정보 -->


				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 컨텍방법
					</div>
					<div class="cont fl_l">${detail.EVENT_CATEGORY}</div>
				</div>
	
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 컨텍일자
					</div>
					<div class="cont fl_l">${detail.EVENT_DATE}</div>
				</div>
	
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 파트너사
					</div>
					<div class="cont fl_l">${detail.COMPANY_NAME}</div>
				</div>
	
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 파트너사ID
					</div>
					<div class="cont fl_l">${detail.PARTNER_ID}</div>
				</div>
	
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 파트너명
					</div>
					<!-- 외 ~명 처리 -->
					<input type="hidden" id="${detail.PARTNER_PERSONAL_NAME}" name="${detail.PARTNER_PERSONAL_NAME}">
					<c:set var="CLIENT_COUNT" value="${fn:split(detail.PARTNER_PERSONAL_NAME,',')}" />
					<c:set var="POSITION_COUNT" value="${fn:split(detail.POSITION,',')}" />
					<div class="cont fl_l">
						${CLIENT_COUNT[0]} ${POSITION[0]}
						<c:if test="${fn:length(CLIENT_COUNT) > 1}">
						외 ${fn:length(CLIENT_COUNT)-1}명
						</c:if>
					</div>
				</div>
				
				<div>
					<c:set var="CUSTOMER_NAME" value="${fn:split(rows.PARTNER_PERSONAL_NAME,',')}" />
					${CUSTOMER_NAME[0]}
				</div>
				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 상세내용
					</div>
					<%-- <div class="cboth cont_box">${detail.EVENT_CONTENTS}</div> --%>
					<textarea rows="" cols="cboth cont_box" readonly="readonly" style="height:200px;">${detail.EVENT_CONTENTS}</textarea>
				</div>
				
				<%-- <c:if test="${!empty detail.OPPORTUNITY_HIDDEN_ID}">
				<div class="view_cata_full">
					<div class="ti">
						<span class="bullet dot"></span> 연관 파트너이슈
					</div>
					<div class="cboth cont_list">
						<a href="/partnerManagement/selectPartnerIssueDetail.do?pkNo=${detail.OPPORTUNITY_HIDDEN_ID}" class="btn_quick">바로가기</a>
					</div>
				</div>
				</c:if> --%>
				
				<c:if test="${!empty detail.ISSUE_ID}">
				<div class="view_cata_full">
					<div class="ti">
						<span class="bullet dot"></span> 연관 파트너이슈
					</div>
					<div class="cboth cont_list">
						<a href="/partnerManagement/selectPartnerIssueDetail.do?pkNo=${detail.ISSUE_ID}" class="btn_quick">바로가기</a>
					</div>
				</div>
				</c:if>

				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 메일공유
					</div>
					<div class="cont fl_l"></div>
				</div>

			
				
				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 첨부파일
					</div>
					<div class="cboth cont_box">
						<ul class="file_list">
							<c:if test="${!empty fileList}">
								<c:forEach items="${fileList}" var="file">
								<li><a href="/common/downloadFile.do?fileId=${file.FILE_ID}&fileTableName=3">${file.FILE_NAME}</a></li>
								</c:forEach>
							</c:if>
						</ul>
					</div>
				</div>
				

			</div>


			<div class="cont2 off">
				<!-- Follow-Up-Action -->
				<div class="view_cata_full">
					<div class="ti mg_b5 fl_l">
					</div>
						
					<div class="cboth keymilestones_list">
						<ul>
							<c:forEach items="${action}" var="action">
							<li>
								<div class="top top2">
									<span class="title">${action.CONTENTS}</span>
									<span class="status_lec statusColor_${action.STATUS}"></span>
								</div>
								<div class="cont">
									<span class="fc_gray_light">책임자 : </span> <span class="fc_black">${action.SOLVE_OWNER}</span><br/>
									<span class="fc_gray_light">목표일 : </span> <span class="fc_black">${action.SOLVE_DUE_DATE}</span> / 
									<span class="fc_gray_light">완료일 : </span> <span class="fc_black">${action.SOLVE_CLOSE_DATE}</span>
								</div>
							</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<!-- // Follow-Up-Action -->
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


<!-- Mainly scripts -->
<script src="${pageContext.request.contextPath}/js/m/jquery-1.11.0.js"></script>
<script src="${pageContext.request.contextPath}/js/m/common.js"></script>

<script type="text/javascript">
	
	function fncList(){
		location.href= '/partnerManagement/viewPartnerContactList.do';
	}
	
	// 바로가기 파라미터 있는 경우에는 탭이동 함수 실행
	var tabNum = null;
	tabNum= '${param.tabNo}';
	
	if(tabNum != ''){
	
		fncSelectTab(tabNum);
	}else{
	
	}
	
	function fncSelectTab(_no){
		
		// 탭 이동
		$('#tab_1').removeClass('active');
		$('#tab_2').removeClass('active');
		$('#tab_'+_no).addClass('active');
		
		// 탭에 해당하는 컨테이너 보여주기
		$('.cont1').addClass('off');
		$('.cont2').addClass('off');
		$('.cont'+_no).removeClass('off');
	}
	
	function fncModify(){
		$("#updateForm").attr("action", "/partnerManagement/formPartnerContactInsertDetail.do");
		$('#updateForm').submit();
	}
	
    
    
    
</script>
</body>
</html>