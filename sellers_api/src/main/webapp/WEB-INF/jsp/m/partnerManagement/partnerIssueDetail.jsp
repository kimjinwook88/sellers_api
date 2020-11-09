<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8" %>


<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
<title>고객이슈관리</title>

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
		<jsp:include page="../common/nav.jsp" flush="true"/>
	</div>
	
<div class="container_pg">
	<article class="">
		<div class="title_pg mg_b10 ">
			<h2>${detail.ISSUE_SUBJECT}</h2>
			<a href="#" class="btn_back" onclick="fncGoBack(); return false;">back</a>
		</div>

		<div class="author">
			<span>${detail.HAN_NAME}(${detail.ISSUE_DATE})</span>
		</div>

		<ul class="tabmenu tabmenu_type2 mg_b20">
			<li><a href="#" id="tab_1" onclick="fncSelectTab('1');return false;" class="active">기본정보</a></li>
			<li><a href="#" id="tab_3" onclick="fncSelectTab('2');return false;">이슈해결계획</a></li>
		</ul>

		<div class="pg_cont">
			<!-- 위의 탭 클릭시 아래의 cont1, cont2, cont3 가  하나씩 보여지도록 해주세요 -->
	
			<div class="cont1 "><!-- 기본정보 -->
	
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 파트너사
					</div>
					<div class="cont fl_l">${detail.COMPANY_NAME}</div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 파트너사 ID
					</div>
					<div class="cont fl_l">${detail.COMPANY_ID}</div>
				</div>
	
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 파트너명
					</div>
					<div class="cont fl_l">${detail.CUSTOMER_NAME}</div>
				</div>
	
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 영업대표
					</div>
					<div class="cont fl_l">${detail.SALES_REPRESENTIVE_NAME}</div>
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
					<div class="cont fl_l">${detail.SOLVE_OWNER_NAME}</div>
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
					<!-- <div class="cboth cont_box"></div> -->
					<textarea rows="" cols="" class="cboth cont_box" style="height:200px;" readonly="readonly">${detail.ISSUE_DETAIL}</textarea>
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
				
				<c:if test="${!empty detail.EVENT_ID}">
					<div class="view_cata b_line">
						<div class="ti fl_l w_120">
							<span class="bullet dot"></span> 연관 파트너컨택
						</div>
						<div class="cont fl_l">
							<a href="/partnerManagement/selectContactDetail.do?pkNo=${detail.EVENT_ID}" class="btn_quick">바로가기</a>
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
					<div class="ti mg_b5">
						<span class="bullet dot"></span>이슈해결계획
					</div>
					<div class="cboth cont_box">${detail.SOLVE_PLAN}</div>
				</div>
	
		<%-- 		<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 이슈해결(증빙내용)
					</div>
					<div class="cboth cont_box">${detail.SOLVE_EVIDENCE_DETAIL}</div>
				</div> --%>
	
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

<!-- Mainly scripts -->
<script src="${pageContext.request.contextPath}/js/m/jquery-1.11.0.js"></script>
<script src="${pageContext.request.contextPath}/js/m/common.js"></script>

<script type="text/javascript">
	function fncList(){
		location.href= '/partnerManagement/viewPartnerIssueList.do';
	}
	
	function fncModify(){
		$("#updateForm").attr("action", "/partnerManagement/formPartnerIssueInsertDetail.do");
		$('#updateForm').submit();
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
		$('#tab_'+_no).addClass('active');
		
		// 탭에 해당하는 컨테이너 보여주기
		$('.cont1').addClass('off');
		$('.cont2').addClass('off');
		$('.cont'+_no).removeClass('off');
	}
</script>
</body>
</html>