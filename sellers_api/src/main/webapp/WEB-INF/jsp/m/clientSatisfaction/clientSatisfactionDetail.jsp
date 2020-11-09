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
		<div class="title_pg mg_b10 ">
			<h2 class="mg_b5">${detail.CSAT_SUBJECT}</h2>
			<a href="#" class="btn_back" onclick="fncGoBack(); return false;">back</a>
		</div>

		<div class="author" id="divModalNameAndCreateDate">
			<span>${detail.HAN_NAME} (${detail.SYS_UPDATE_DATE})</span>
		</div>

		<div class="mg_l10 mg_r10 mg_b20">

			<ul class="tabmenu tabmenu_type2 mg_b20">
				<li><a href="#" id="tab_1" onclick="fncSelectTab('1'); return false;" class="active">기본정보</a></li>
				<li><a href="#" id="tab_2" onclick="fncSelectTab('2'); return false;">조사결과</a></li>
				<li><a href="#" id="tab_3" onclick="fncSelectTab('3'); return false;">Follow-up</a></li>
			</ul>
	
			<div class="pg_cont">
				<!-- 위의 탭 클릭시 아래의 cont1, cont2가  하나씩 보여지도록 해주세요 -->
	
				<div class="cont1 "><!-- 기본정보 -->
	
					<div class="view_cata_full">
						<div class="ti mg_b5">
							<span class="bullet dot"></span> 상세내용
						</div>
						<div class="cboth cont_box">${detail.CSAT_DETAIL}</div>
					</div>
					
					<div class="view_cata b_line">
						<div class="ti fl_l">
							<span class="bullet dot"></span> 책임자
						</div>
						<div class="cont fl_l">${detail.CSAT_SURVEY_NAME}</div>
					</div>
					
					<div class="view_cata b_line">
						<div class="ti fl_l">
							<span class="bullet dot"></span> 책임자 ID
						</div>
						<div class="cont fl_l">${detail.CREATOR_ID}</div>
					</div>
					
					<div class="view_cata b_line">
						<div class="ti fl_l">
							<span class="bullet dot"></span> 조사일
						</div>
						<div class="cont fl_l">${detail.CSAT_SURVEY_DATE}</div>
					</div>
					
					<div class="view_cata b_line">
						<div class="ti fl_l">
							<span class="bullet dot"></span> 카테고리
						</div>
						<div class="cont fl_l">${detail.CSAT_CATEGORY}</div>
					</div>
	
					<!-- 
					<div class="view_cata_full">
						<div class="ti mg_b5">
							<span class="bullet dot"></span> 첨부파일
						</div>
						<div class="cboth cont_box">
							<ul class="file_list">
								<li><a href="">만족도조사.doc </a></li>
							</ul>
						</div>
					</div>
					 -->
	
				</div>
	
				<div class="cont2 off"><!-- 조사결과 -->
					<div class="view_cata">
						<span class="bullet dot va_m"></span> 
						<span class="va_m">평가평균 :</span> <strong class="fs18 va_m">${detail.CSAT_AVG_VALUE}</strong>
						/ <span class="va_m">조사건수 :</span> <strong class="fs18 va_m">${detail.CSAT_TOTAL_COUNT}</strong>
					</div>
	
					<div class="satisfaction_list" id="clientSatisfactionDetail"></div>
				</div>
	
				<div class="cont3 off"><!-- Follow up action -->
					<!-- Follow up action -->
					<div class="cboth keymilestones_list" id="followUpAction">
						<ul class="list_type1" id="result_list">
                <!-- 내용이 입력됩니다. -->
            </ul>
					</div>
					<!-- // 이슈해결계획 -->
				</div>
	
			</div>

		</div>



	</article>
	<jsp:include page="../templates/footer.jsp" flush="true"/>
</div>

<div class="pg_bottom_func">
	<ul>
		<li style="width=100%;"><a href="#" onclick="fncList(); return false;"> <img src="${pageContext.request.contextPath}/images/m//icon_list.png" /> <span>목록</span></a></li>
	<!-- <li><a href="#" class="" onclick="fncModify(); return false;"> <img src="${pageContext.request.contextPath}/images/m//icon_edit.png" /> <span>수정</span></a></li> -->
	</ul>
</div>

<div class="modal_screen"></div>

<script>
	var csatId = '${detail.CSAT_ID}';
	var tabNo = '${param.tabNo}';
</script>

<script src="${pageContext.request.contextPath}/js/m/view/clientSatisfaction/clientSatisfactionDetail.js"></script>

</body>
</html>