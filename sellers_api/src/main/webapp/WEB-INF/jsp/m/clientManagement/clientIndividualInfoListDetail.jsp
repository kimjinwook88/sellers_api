<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%  
response.setHeader("Cache-Control","no-store");  
response.setHeader("Pragma","no-cache");  
response.setDateHeader("Expires",0);  
if (request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache");
%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
<title>고객사개인정보 상세보기</title>

<link href="${pageContext.request.contextPath}/css/m/style.css" rel="stylesheet">

</head>

<body class="gray_bg" onload="tabmenuLiWidth();">
<jsp:include page="../templates/header.jsp" flush="true"/>
<!-- location -->
	<div class="">
		<!-- <a href="#" class="home"><img src="../../../images/m/icon_home.svg" /></a>
		<div class="breadcrumb_depth1">
			<a class="active_menu">&nbsp;고객사 및 고객개인정보</a>
		</div> -->
		<jsp:include page="../common/nav.jsp" flush="true"/>
	</div>
<div class="container_pg">

	

	

	<article class="">
		<div class="title_pg ta_c ">
			<h2 class="" id="textModalClientName"></h2>
			<a href="#" class="btn_back" onclick="fncGoBack(); return false;">back</a>
		</div>

        <div class="author">
            <%-- <span>${detail.HAN_NAME}(${detail.SYS_REGISTER_DATE})</span> --%>
            <div id="textModalCreatorId"></div>
        </div>

		<ul class="tabmenu tabmenu_type2 mg_b20">
			<li><a href="#" id="tab_1" class="active" onclick="fncSelectTab('1'); return false;">기본정보</a></li>
			<li><a href="#" id="tab_2" onclick="fncSelectTab('2'); return false;">개인정보</a></li>
			<li><a href="#" id="tab_3" onclick="fncSelectTab('3'); getCustomerContact(); return false;">컨택이력</a></li>
			<li><a href="#" id="tab_4" onclick="fncSelectTab('4'); getCustomerCompany(); return false;">소속고객정보</a></li>
            <% /*****************************************
             * 고객 컨택의 경우 PC버전에서 요구하는 파라미터가 너무 많아서 모바일에서 구현 불가능. 2017.06.14
             * 향후 고객 컨택 조회에 대한 파라미터 분석이 필요함. 
             * 해당 쿼리아이디 : clientSalesAtive_SQL.XML => selectClientContactList
			<li><a href="#" id="tab_3" onclick="fncSelectTab('3'); return false;">컨텍이력</a></li>
            ********************************************/ %>
		</ul>
		
		<div class="pg_cont">
			<div class="cont1 "><!-- 기본정보 -->
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 고객개인 ID
					</div>
					<div class="cont fl_l" id="textCommonSearchCustomerId" name="textCommonSearchCustomerId"></div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 명함
					</div>					
					
					<div class="cont fl_l" id="textModalClientBusinessCard" name="textModalClientBusinessCard"></div>
					<div class="cboth pd_t10 photo off" id="nameCardBox">
						<div id="nameCardURL"></div>
						<div id="nameCardDeafult"></div>
					</div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 소속팀
					</div>
					<div class="cont fl_l" id="textModalTeam" name="textModalTeam"></div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 소속부서
					</div>
					<div class="cont fl_l" id="textModalPost" name="textModalPost"></div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 소속본부
					</div>
					<div class="cont fl_l" id="textModalDivision" name="textModalDivision"></div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 담당업무
					</div>
					<div class="cont fl_l"  id="textModalDuty" name="textModalDuty"></div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 고객사명
					</div>
					<div class="cont fl_l" id="textCommonSearchCompany" name="textCommonSearchCompany"></div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 고객사ID
					</div>
					<div class="cont fl_l" id="textCommonSearchCompanyId" name="textCommonSearchCompanyId"></div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> ERP연동 여부
					</div>
           			<div class="col-sm-4">
           				<span nmae="spanERPClientCodeCheck" id="spanERPClientCodeCheck" style="margin-right:20px">
           					<i class="fa fa-close" style="color: red;"></i>
           					<i class="fa fa-check" style="color: green;"></i>
           				</span>
           			</div>
           			<input type="hidden" name="hiddenERPClientCode" id="hiddenERPClientCode" value="${clientInfo.ERP_CLIENT_CODE}"/>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 휴대전화
					</div>
					<div class="cont fl_l" id="textModalCellPhone" name="textModalCellPhone"></div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 직장전화
					</div>
					<div class="cont fl_l" id="textModalPhone" name="textModalPhone"></div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 이메일
					</div>
					<div class="cont fl_l" id="textModalEmail" name="textModalEmail"><a href="mailto:adoro@dunet.co.kr" class="phone ds_in">${detail.EMAIL}</a></div>
				</div>
				
				<div class="view_cata b_line mg_b30">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 직장주소
					</div>
					<div class="cont fl_l"  id="textModalAddress" name="textModalAddress"></div>
				</div>
				
				<h3>보고라인</h3>
				<div class="view_cata_full b_line mg_b30">
                    <div id="textModalReportingLineTeamName" name="textModalReportingLineTeamName"></div>
                    <div id="textModalReportingLinePostName" name="textModalReportingLinePostName"></div>
                    <div id="textModalReportingLineDivisionName" name="textModalReportingLineDivisionName"></div>
                </div>
                
                <h3>기타</h3>
                <div class="view_cata b_line">
                    <div class="ti fl_l w_120">
                        <span class="bullet dot"></span> 관계수립
                    </div>
                    <div class="cont fl_l" id="selectModalRelation" name="selectModalRelation"></div>
                </div>

                <div class="view_cata b_line">
                    <div class="ti fl_l w_120">
                        <span class="bullet dot"></span> 호감도 
                    </div>
                    <div class="cont fl_l" id="selectModalLikeAbility" name="selectModalLikeAbility"></div>
                </div>

				<!-- 자사와의 관계 추가 -->
				<div class="view_cata b_line">
                    <div class="ti fl_l w_120">
                        <span class="bullet dot"></span> 책임자
                    </div>
                    <div class="cont fl_l" id="textModalDirectorName" name="textModalDirectorName"></div>
                </div>
                
				<div class="view_cata b_line">
					<div class="ti fl_l w_120">
						<span class="bullet dot"></span> 사내 친한 직원
					</div>
					<div class="cont fl_l" id="textModalFriendshipInfo" name="textModalFriendshipInfo"></div>
				</div>

                

                <!-- <div class="view_cata b_line">
                     -->

                <div class="view_cata b_line">
                    <div class="ti fl_l w_120">
                        <span class="bullet dot"></span> 이전영업사원
                    </div>
                    <div class="cont fl_l" id="textModalPerSonalPrevSales" name="textModalPerSonalPrevSales"></div>
                </div>
			</div>
				

			<div class="cont2 off"><!-- 개인정보 -->

				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 학력
					</div>
					<div class="cboth cont_box" id="textModalPerSonalEducation" name="textModalPerSonalEducation"></div>
				</div>

				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 학력관련인맥
					</div>
					<div class="cboth cont_box" id="textModalPerSonalEducationPerson" name="textModalPerSonalEducationPerson"></div>
				</div>

				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 경력
					</div>
					<div class="cboth cont_box" id="textModalPerSonalCareer" name="textModalPerSonalCareer"></div>
				</div>

				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 경력관련 인맥정보
					</div>
					<div class="cboth cont_box" id="textModalPerSonalCareerPerson" name="textModalPerSonalCareerPerson"></div>
				</div>

				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 가족관계 
					</div>
					<div class="cboth cont_box" id="textModalPerSonalFamily" name="textModalPerSonalFamily"></div>
				</div>

				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 친한 사람
					</div>
					<div class="cboth cont_box" id="textModalPerSonalFamiliars" name="textModalPerSonalFamiliars"></div>
				</div>

				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 사회활동
					</div>
					<div class="cboth cont_box" id="textModalPerSonalActs" name="textModalPerSonalActs"></div>
				</div>
				
				<!-- <div class="view_cata_full">
					<div class="ti mg_b5">
                        <span class="bullet dot"></span> 정보출처
                    </div>
                    <div class="cboth cont_box" id="textModalPerSonalInfoSource" name="textModalPerSonalInfoSource"></div>
                </div> -->

				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> SNS
					</div>
					<div class="cboth cont_box" id="textModalPerSonalSNS" name="textModalPerSonalSNS"></div>
				</div>

				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 성향
					</div>
					<div class="cboth cont_box" id="hiddenModalPerSonalInclination" name="textModalPerSonalInclination"></div>
					
				</div>

				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 기타
					</div>
					<div class="cboth cont_box" id="textModalPerSonalETC" name="textModalPerSonalETC"></div>
					<input type="hidden" name="hiddenModalPerSonalETC2" id="hiddenModalPerSonalETC2"/>
				</div>

			</div>
			
			<div class="cont3 off">
<ul class="contact_history_list">
	<li>
		<div class="top">
			<div id="contactInfo1"></div>
			<!-- <span class="title">
				<span class="contact_type r2 va_m">방문</span>
				<span class="va_m">대한상사 데이터베이스 기술지원 이슈</span>
			</span>
			<span class="custom_name">소속본부 : 기술연구소 / 보고자 : 김진선</span>
			<span class="date">컨택일 : 2016-09-06</span> -->
		</div>
	</li>
</ul>
			</div>
			
			<div class="cont4 off">
				<ul class="com_member_list">
					<li>
						<div class="form1"></div>
						<div class="form2"></div>
						<div class="form3"></div>
					</li>
				</ul>
			</div>
			
			
			
			
			<% /*****************************************
                * 고객 컨택의 경우 PC버전에서 요구하는 파라미터가 너무 많아서 모바일에서 구현 불가능. 2017.06.14
                * 향후 고객 컨택 조회에 대한 파라미터 분석이 필요함. 
                * 해당 쿼리아이디 : clientSalesAtive_SQL.XML => selectClientContactList
            <div class="cont3 off"><!-- 컨텍이력 -->
                <ul class="contact_history_list">
                    <li>
                        <div class="top">                            
                            <span class="title">
                                <span class="contact_type r2 va_m">방문</span>
                                <span class="va_m">BP사 고객의 DB2 이슈발생</span>
                            </span>
                            <span class="custom_name">소속본부 : 기술연구소 / 보고자 : 김진선</span>
                            <span class="date">컨택일 : 2016-09-06</span>
                        </div>
                    </li>
                    <li>
                        <div class="top">                            
                            <span class="title">
                                <span class="contact_type r2 va_m">E-mail</span>
                                <span class="va_m">BP사 고객의 DB2 이슈발생</span>
                            </span>
                            <span class="custom_name">소속본부 : 기술연구소 / 보고자 : 김진선</span>
                            <span class="date">컨택일 : 2016-09-06</span>
                        </div>
                    </li>
                </ul>
			</div>
			**********************************************/ %>
		</div>
		
        
				<input type="hidden" name="hiddenPersonalNameCard" id="hiddenPersonalNameCard" value="${defaultPhoto[0].FILE_PATH}${defaultPhoto[0].FILE_NAME}" />
			    <input type="hidden" name="hiddenPersonalPhoto" id="hiddenPersonalPhoto" value="${defaultPhoto[1].FILE_PATH}${defaultPhoto[1].FILE_NAME}" />
	</article>   

	<jsp:include page="../templates/footer.jsp" flush="true"/>


</div>
	<div class="pg_bottom_func">
        <ul>
            <li><a href="#" class="" id="clientIndividualList"><img src="${pageContext.request.contextPath}/images/m/icon_list.png" /><span>목록</span></a></li>
            <li><a href="#" class="" id="insertClientIndividual"><img src="${pageContext.request.contextPath}/images/m/icon_edit.png" /><span>수정</span></a></li>
        </ul>
    </div>

<div class="modal_screen"></div>

<input type="hidden" name="hiddenPersonalNameCard" id="hiddenPersonalNameCard" value="${defaultPhoto[0].FILE_PATH}${defaultPhoto[0].FILE_NAME}" />
<input type="hidden" name="hiddenPersonalPhoto" id="hiddenPersonalPhoto" value="${defaultPhoto[1].FILE_PATH}${defaultPhoto[1].FILE_NAME}" />

<form method="post" id="updateForm" action="">
    <input type="hidden" id="mode" name="mode" value="upd" />
    <input type="hidden" id="pkNo" name="pkNo" value="" />
</form>  

<!-- Mainly scripts -->
<script src="${pageContext.request.contextPath}/js/m/jquery-1.11.0.js"></script>
<script src="${pageContext.request.contextPath}/js/m/jquery.form.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/plugins/validate/jquery.validate.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/plugins/autocomplete/jquery.auto-complete.js"></script>
<link href="${pageContext.request.contextPath}/js/m/plugins/autocomplete/jquery.auto-complete.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/m/common.js"></script>
<script src="${pageContext.request.contextPath}/js/m/plugins/file/jQuery.MultiFile.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/view/clientManagement/clientIndividualInfoListDetail.js"></script>

<script type="text/javascript">
	var customerId = '${customerId}'; 
	var companyId = '${companyId}';
	
    // 상세 정보 가져오기
    fnDetail();
    //getCustomerContact();
    contactTab.fncInit();
    comMemberTab.fncShowMore();
    nameCard();
    
    <% /*****************************************
     * 고객 컨택의 경우 PC버전에서 요구하는 파라미터가 너무 많아서 모바일에서 구현 불가능. 2017.06.14
     * 향후 고객 컨택 조회에 대한 파라미터 분석이 필요함. 
     * 해당 쿼리아이디 : clientSalesAtive_SQL.XML => selectClientContactList
    // 컨택정보가져오기
    getCustomerContact();
     ***********************************/ %>
    
    // 고객 목록 조회 페이지 이동
    $("#clientIndividualList").on("click", function(e) {
        location.href = '/clientManagement/viewClientIndividualInfoGate.do';
        e.preventDefault();
    });


    // 고객 수정 페이지 이동
    $("#insertClientIndividual").on("click", function(e) {
        $("#updateForm").attr("action", "/clientManagement/clientIndividualInsertForm.do");
        $('#updateForm').submit();       
        e.preventDefault();
    });
</script>
</body>
</html>