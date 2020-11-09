<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<title>영업기회관리</title>

<link href="${pageContext.request.contextPath}/css/m/style.css" rel="stylesheet" type="text/css">

</head>

<body class="gray_bg" onload="tabmenuLiWidth();">
<jsp:include page="../templates/header.jsp" flush="true"/>

<jsp:include page="../common/nav.jsp" flush="true"/>

<div class="container_pg">

	

	<article class="">
		<div class="title_pg">
			<h2 class="">${detail.SUBJECT}</h2>
			<a href="#" class="btn_back" onclick="fncGoBack(); return false;">back</a>
		</div>

		<div class="author">
			<span>${detail.HAN_NAME} (${detail.SYS_UPDATE_DATE})</span>
		</div>

		<ul class="tabmenu tabmenu_type2 mg_b20">
			<li><a href="#" id="tab_1" onclick="fncSelectTab('1'); return false;" class="active">기본정보</a></li>
			<li><a href="#" id="tab_2" onclick="fncSelectTab('2'); return false;">영업단계</a></li>
			<li><a href="#" id="tab_3" onclick="fncSelectTab('3'); return false;">승리계획</a></li>
			<li><a href="#" id="tab_4" onclick="fncSelectTab('4'); return false;">마일스톤</a></li>
			<li><a href="#" id="tab_5" onclick="fncSelectTab('5'); return false;">매출/매입</a></li>
			<li><a href="#" id="tab_6" onclick="fncSelectTab('6'); return false;">매출/수금</a></li>
			<li><a href="#" id="tab_7" onclick="fncSelectTab('7'); return false;">Coaching Talk</a></li>
		</ul>
		
		<div class="pg_cont">
			<!-- 위의 탭 클릭시 아래의 cont1, cont2, cont3 가  하나씩 보여지도록 해주세요 -->

			<div class="cont1 "><!-- 기본정보 -->
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 매출처
					</div>
					<div class="cont fl_l">${detail.COMPANY_NAME}</div>
				</div>

				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> End User
					</div>
					<div class="cont fl_l">${detail.CUSTOMER_NAME}</div>
				</div>

				<div class="view_cata b_line">
					<div class="ti fl_l w_120">
						<span class="bullet dot"></span> 예상계약금액
					</div>
					<div class="cont fl_l">
                        <fmt:formatNumber value="${detail.CONTRACT_AMOUNT}" pattern="#,###"/>
                    </div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l w_120">
						<span class="bullet dot"></span> 예상계약일자
					</div>
					<div class="cont fl_l">${detail.CONTRACT_DATE}</div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l w_120">
						<span class="bullet dot"></span> 계약기간
					</div>
					<div class="cont fl_l">${detail.CONTRACT_ST_DATE} ~ ${detail.CONTRACT_ED_DATE}</div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l w_120">
						<span class="bullet dot"></span> 영업기회코드(ERP)
					</div>
					<div class="cont fl_l">${detail.ERP_OPP_CD}</div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l w_120">
						<span class="bullet dot"></span> Forecast
					</div>
					<div class="cont fl_l">${detail.FORECAST_YN}</div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l w_120">
						<span class="bullet dot"></span> 프로젝트코드(ERP)
					</div>
					<div class="cont fl_l">${detail.ERP_PROJECT_CODE}</div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span>EO
					</div>
					<div class="cont fl_l">${detail.EXEC_NAME}</div>
				</div>

				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span>OO
					</div>
					<div class="cont fl_l">${detail.OWNER_NAME}</div>
				</div>

				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 영업대표
					</div>
					<div class="cont fl_l">${detail.IDENTIFIER_NAME}</div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 영업구분
					</div>
					<div class="cont fl_l">${detail.CATEGORY_CD_NAME}</div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 영업유형
					</div>
					<div class="cont fl_l">
					<c:choose>
						<c:when test="${detail.TYPE_CD eq '0001'}">Direct</c:when>
						<c:when test="${detail.TYPE_CD eq '0002'}">InDirect</c:when>
					</c:choose>
					</div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 프로젝트형태
					</div>
					<div class="cont fl_l">${detail.PROJECT_FORM_CD_NAME}</div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 고객구분
					</div>
					<div class="cont fl_l">
					<c:choose>
						<c:when test="${detail.ERP_CLIENT_CATEGORY_CD eq '1'}">매출처</c:when>
						<c:when test="${detail.ERP_CLIENT_CATEGORY_CD eq '2'}">End User</c:when>
						<c:when test="${detail.ERP_CLIENT_CATEGORY_CD eq '3'}">매입처</c:when>
					</c:choose>
					</div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 고객담당자
					</div>
					<div class="cont fl_l">
						${detail.ERP_CLIENT_NAME}
					</div>
				</div>
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 구매방법
					</div>
					<div class="cont fl_l">
						<c:choose>
							<c:when test="${detail.BUY_CD eq '1'}">기술가격평가</c:when>
							<c:when test="${detail.BUY_CD eq '2'}">계약갱신</c:when>
							<c:when test="${detail.BUY_CD eq '3'}">수의계약</c:when>
							<c:when test="${detail.BUY_CD eq '4'}">가격입찰</c:when>
						</c:choose>
					</div>
				</div>
				
                <div class="view_cata_full">
                    <div class="ti mg_b5">
                        <span class="bullet dot"></span> 사업내용
                    </div>
                    <div class="cboth cont_box">
                        ${detail.DETAIL_CONENTS}
                    </div>
                </div>
                
                <div class="view_cata_full">
                    <div class="ti mg_b5">
                        <span class="bullet dot"></span> 차별화 가치
                    </div>
                    <div class="cboth cont_box">
                        ${detail.DISCRIMINATE_VALUE}
                    </div>
                </div>                
                
				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> ROUTE
					</div>
					<div class="cboth cont_box">
						${detail.ROUTE}
					</div>
				</div>

                <div class="view_cata_full">
                    <div class="ti mg_b5">
                        <span class="bullet dot"></span> 파트너사
                    </div>
                    <div class="cboth cont_box" id="partner_sales">
                    </div>
                </div>

                <div class="view_cata_full">
                    <div class="ti mg_b5">
                        <span class="bullet dot"></span> 파트너사 역할
                    </div>
                    <div class="cboth cont_box">
                        ${detail.PARTNER_ROLE}
                    </div>
                </div>


				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 첨부파일
					</div>
					<div class="cboth cont_box">
						<ul class="file_list">
							<c:forEach items="${fileList}" var="file">
							<li><a href="/common/downloadFile.do?fileId=${file.FILE_ID}&fileTableName=6">${file.FILE_NAME}</a></li>
							</c:forEach>
						</ul>
					</div>
				</div>

			</div>
			
			
			<!-- 영업단계 -->
			<div class="cont2 off">
					<div class="view_cata b_line">
						<div class="ti fl_l">
							<span class="bullet dot"></span> 영업단계
						</div>
						<div class="cont fl_l fs16">
							<strong>
								<c:choose>
								<c:when test="${detail.SALES_CYCLE eq '1'}">Identify/Validation</c:when>
								<c:when test="${detail.SALES_CYCLE eq '2'}">Qualification</c:when>
								<c:when test="${detail.SALES_CYCLE eq '3'}">Negotition</c:when>
								<c:when test="${detail.SALES_CYCLE eq '4' || detail.SALES_CYCLE eq '5'}">Close</c:when>
								</c:choose>
							</strong>
						</div>
					</div>
				
					<div class="cont fl_l fs16">
							<c:forEach items="${scCheckList}" var="scCheckList">
								<c:if test="${scCheckList.CHECK_YN eq 'Y' && scCheckList.CHECK_SEQ == 1}">
									<li><label><input type="checkbox" name="checkSalesCycle" checked disabled> 고객 예산과 일정은 계획되어 있습니까 ?</label></li>
								</c:if>
								<c:if test="${scCheckList.CHECK_YN eq 'Y' && scCheckList.CHECK_SEQ == 2}">
									<li><label><input type="checkbox" name="checkSalesCycle" checked disabled> 고객의 구매의사를 확인하였습니까 ?</label></li>
								</c:if>
								<c:if test="${scCheckList.CHECK_YN eq 'Y' && scCheckList.CHECK_SEQ == 3}">
									<li><label><input type="checkbox" name="checkSalesCycle" checked disabled> 고객의 요구 사항에 적합한 우리의 솔루션이 있습니까 ?</label></li>
								</c:if>
								<c:if test="${scCheckList.CHECK_YN eq 'Y' && scCheckList.CHECK_SEQ == 4}">
									<li><label><input type="checkbox" name="checkSalesCycle" checked disabled> 수익과 위험요소 분석을 충분히 하였습니까 ?</label></li>
								</c:if>
								<c:if test="${scCheckList.CHECK_YN eq 'Y' && scCheckList.CHECK_SEQ == 5}">
									<li><label><input type="checkbox" name="checkSalesCycle" checked disabled> 사업 수행을 위한 인력과 지원 서비스는 가능합니까 ?</label></li>
								</c:if>
								<c:if test="${scCheckList.CHECK_YN eq 'Y' && scCheckList.CHECK_SEQ == 6}">
									<li><label><input type="checkbox" name="checkSalesCycle" checked disabled> 제안서 작성과 제출을 했습니까 ?</label></li>
								</c:if>
								<c:if test="${scCheckList.CHECK_YN eq 'Y' && scCheckList.CHECK_SEQ == 7}">
									<li><label><input type="checkbox" name="checkSalesCycle" checked disabled> 우선협상대상자에 대한 고객 동의를 받았습니까 ?</label></li>
								</c:if>
								<c:if test="${scCheckList.CHECK_YN eq 'Y' && scCheckList.CHECK_SEQ == 8}">
									<li><label><input type="checkbox" name="checkSalesCycle" checked disabled> 계약 범위와 조건에 대해 협의를 완료하였습니까 ?</label></li>
								</c:if>
								<c:if test="${scCheckList.CHECK_YN eq 'Y' && scCheckList.CHECK_SEQ == 9}">
									<li><label><input type="checkbox" name="checkSalesCycle" checked disabled> 계약을 성공적으로 체결했습니까 ?</label></li>
								</c:if>
							</c:forEach>
					</div>
					
			</div>
			
			
			<!-- 승리계획 -->
			<div class="cont3 off">
				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 승리계획
					</div>
					<div class="cboth keymilestones_list" id="oppWinPlan">
					</div>
				</div>
			</div>
			
			<!-- 매출계획 -->
			<!-- <div class="cont10 off">
                <div class="mg_b10">
					<select name="basis_year" id="basis_year">
                        <option value="2017">2017년</option>
                        <option value="2018">2018년</option>
                        <option value="2019">2019년</option>
                        <option value="2020">2020년</option>
					</select>
					<select name="basis_quarter" id="basis_quarter">
						<option value="00">선택</option>
						<option value="01">1분기</option>
						<option value="04">2분기</option>
						<option value="07">3분기</option>
						<option value="10">4분기</option>
					</select>
				</div>
                <div id="salesplan_result">
                </div>
			</div> -->
			<!--// 매출현황 -->
			
			<!-- 체크리스트 -->
			<!-- <div class="cont3 off">
				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span>체크리스트
					</div>
					<div class="cboth keymilestones_list" id="oppCheckList">
					</div>
				</div>
			</div> -->
			
			<!--  마일스톤  -->
			<div class="cont4 off">
				<div class="cboth keymilestones_list" id="oppMilestone">
				</div>
			</div>
			
			
			
			<!-- 매출/매입품목 -->
			<div class="cont5 off">
				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 매출 품목
					</div>
					<div class="cboth keymilestones_list" id="oppProduct">
							<ul>
								<c:forEach items="${productSalesList}" var="productSalesList">
								<li>    
								<div class="top" style="border-bottom-style: ridge;">        
									<span class="fc_gray_light">품목 : </span> ${productSalesList.PRODUCT_NAME} <br />
									<span class="fc_gray_light">규격 : </span> ${productSalesList.PRODUCT_STANDARD} <br />
									<span class="fc_gray_light">수량 : </span> ${productSalesList.PRODUCT_COUNT} /      
									<span class="fc_gray_light">단가 : </span> <fmt:formatNumber value="${productSalesList.PRODUCT_PRICE}" pattern="#,###" />원 / 
									<span class="fc_gray_light">금액 : </span> <fmt:formatNumber value="${productSalesList.PRODUCT_COUNT * productSalesList.PRODUCT_PRICE}" pattern="#,###" />원
								</div>    
								</li>
								</c:forEach>
							</ul>
					</div>
				</div>
				

				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 매입 품목
					</div>
					<div class="cboth keymilestones_list" id="oppProduct">
							<ul>
								<c:forEach items="${productPsList}" var="productPsList">
								<li>    
								<div class="top" style="border-bottom-style: ridge;">        
									<span class="fc_gray_light">품목 : </span> ${productPsList.PRODUCT_NAME} <br />
									<span class="fc_gray_light">규격 : </span> ${productPsList.PRODUCT_STANDARD} <br />
									<span class="fc_gray_light">수량 : </span> ${productPsList.PRODUCT_COUNT} /      
									<span class="fc_gray_light">단가 : </span> <fmt:formatNumber value="${productPsList.PRODUCT_PRICE}" pattern="#,###" />원 / 
									<span class="fc_gray_light">금액 : </span> <fmt:formatNumber value="${productPsList.PRODUCT_COUNT * productPsList.PRODUCT_PRICE}" pattern="#,###" />원
								</div>    
								</li>
								</c:forEach>
							</ul>
					</div>
				</div>
				
			</div>
			
			
			
			<!-- 매출/수금 계획 -->
			<div class="cont6 off">
				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 매출/수금 계획
					</div>
					<div class="cboth keymilestones_list" id="oppSalesPlan">
							<ul>
								<c:forEach items="${salesPlanList}" var="salesPlanList">
								<li>    
								<div class="top" style="border-bottom-style: ridge;">        
									<span class="fc_gray_light">매출계획일 : </span> ${salesPlanList.BASIS_MONTH} <br />
									<span class="fc_gray_light">수금계획일 : </span> ${salesPlanList.BASIS_MONTH_C} <br />
									<span class="fc_gray_light">P.REV (예상매출) : </span> <fmt:formatNumber value="${salesPlanList.BASIS_PLAN_REVENUE_AMOUNT}" pattern="#,###" />원 <br /> 
									<span class="fc_gray_light">A.REV (실제매출) : </span> <fmt:formatNumber value="${salesPlanList.BASIS_PLAN_GP_AMOUNT}" pattern="#,###" />원 <br />
									<span class="fc_gray_light">P.GP (예상이익) : </span> <fmt:formatNumber value="${salesPlanList.ERP_REV}" pattern="#,###" />원  <br />
									<span class="fc_gray_light">A.GP (실제이익) : </span> <fmt:formatNumber value="${salesPlanList.ERP_GP}" pattern="#,###" />원
								</div>    
								</li>
								</c:forEach>
							</ul>
					</div>
				</div>
				

				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 스플릿
					</div>
					<div class="cboth keymilestones_list" id="oppProduct">
							<ul>
								<c:forEach items="${salesSplitList}" var="salesSplitList">
								<li>    
								<div class="top" style="border-bottom-style: ridge;">        
									<span class="fc_gray_light">영업대표 : </span> ${salesSplitList.HAN_NAME} <br />
									<span class="fc_gray_light">매출계획일 : </span> ${salesSplitList.SPLIT_DATE} <br />
									<span class="fc_gray_light">REV : </span> <fmt:formatNumber value="${salesSplitList.SPLIT_REV}" pattern="#,###" />원 <br /> 
									<span class="fc_gray_light">GP : </span> <fmt:formatNumber value="${salesSplitList.SPLIT_GP}" pattern="#,###" />원 <br />
								</div>    
								</li>
								</c:forEach>
							</ul>
					</div>
				</div>
				
			</div>
			
			<!-- 매출/수금 계획 -->
			<div class="cont7 off">
				<div class="view_cata_full">
		     		<jsp:include page="/WEB-INF/jsp/m/common/coachingTalkTab.jsp"/>
		     	</div>
			</div>
			
		</div>

		<!-- 
        <div class="pg_bottom">
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
                <li><a href="#" class="" onclick="fncList(); return false;"> <img src="${pageContext.request.contextPath}/images/m//icon_list.png" /> <span>목록</span></a></li>
                <li><a href="#" class="" onclick="fncModify(); return false;"> <img src="${pageContext.request.contextPath}/images/m//icon_edit.png" /> <span>수정</span></a></li>
            </ul>
        </div>
<div class="modal_screen"></div>

<form method="post" id="updateForm" action="">
    <input type="hidden" id="mode" name="mode" value="upd" />
    <input type="hidden" id="pkNo" name="pkNo" value="${detail.OPPORTUNITY_ID}" />
</form>  


<!-- Mainly scripts -->
<script src="${pageContext.request.contextPath}/js/m/jquery-1.11.0.js"></script>
<script src="${pageContext.request.contextPath}/js/m/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/common.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        $('#select_division').change(function(e){
            var select_val = $(this).val();
            var division_val = select_val.split('|');
            
        });
        
        // 매출 계획 조회
        $('#basis_year').change(function(e){
            fnSalesPlan();
        });
        
        // 매출 계획 조회
        $('#basis_quarter').change(function(e){
            fnSalesPlan();
        });
        
        // 마일스톤 조회
        fnOppMilestone();
        
        // 체크리스트
        //fncCheckList();
        
        // 승리계획
        fncWinPlan();
        
        //costAmount();
        
    	 // Coaching Talk 조회
    	coachingTalk.view('OPP');
	
    	 //파트너사
    	commonSearch.multiplePartnerArray = [];
		commonSearch.selectMultiplePartner2("${detail.SALES_PARTNER}", $("#partner_sales"));
    });
    
    
	function costAmount(value){
		/* var costAmount1 = $("#textModalCostAmount1").val();
		var costAmount2 = $("#textModalCostAmount2").val();
		var costAmount3 = $("#textModalCostAmount3").val();
		
		if(costAmount1 == ""){
		costAmount1 = "0";
    	}
    	
    	if(costAmount2 == ""){
    		costAmount2 = "0";
    	}
    	
    	if(costAmount3 == ""){
    		costAmount3 = "0";
    	}
    	
    	var ca1 = costAmount1.replaceAll(",", "");
    	var ca2 = costAmount2.replaceAll(",", "");
    	var ca3 = costAmount3.replaceAll(",", "");

    	var sum = parseInt(ca1)+parseInt(ca2)+ parseInt(ca3);
		
    	$("#textModalSumCost").html(sum.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1,')); */
    }
    
    function fncList(){
		location.href= '/clientSalesActive/viewOpportunityList.do';
	}
    
    function fncModify(){
        $("#updateForm").attr("action", "/clientSalesActive/opportunityInsertForm.do");
        $('#updateForm').submit();
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
		$('#tab_3').removeClass('active');
		$('#tab_4').removeClass('active');
		$('#tab_5').removeClass('active');
		$('#tab_6').removeClass('active');
		$('#tab_7').removeClass('active');
		$('#tab_'+_no).addClass('active');
		
		// 탭에 해당하는 컨테이너 보여주기
		$('.cont1').addClass('off');
		$('.cont2').addClass('off');
		$('.cont3').addClass('off');
		$('.cont4').addClass('off');
		$('.cont5').addClass('off');
		$('.cont6').addClass('off');
		$('.cont7').addClass('off');
		$('.cont'+_no).removeClass('off');
	}
	
	
	// 매출 계획
	function fnSalesPlan() {
        var basis_month;
        var basis_year = $('#basis_year').val();
        var basis_quarter = $('#basis_quarter').val();
        if (basis_quarter != '00') {
            basis_month = basis_year + '-' + basis_quarter; // '해당년도-분기(01, 04, 07, 10)'.  예) 2017년 3분기 => 2017-07
            //매출 계획 
            $.ajax({
                url : "/clientSalesActive/selectOpportunitySalesPlan.do",
                async : false,
                datatype : 'json',
                type : "POST",
                data : {
                    opportunity_id:'${detail.OPPORTUNITY_ID}',
                    basis_month:basis_month
                    
                },
                beforeSend : function(xhr){
                    xhr.setRequestHeader("AJAX", true);
                },
                success : function(data){
                    var salesAmount = data.salesAmount;
                    var salesListCount = data.salesListCount;
                    
                    // 목록 초기화
                    $('#salesplan_result').html('');
                    
                    var list_html = '';
                    var rev = 0;
                    var gp = 0;
                    //입력한 부서 만큼 html 생성
                    
                    for(var i=0; i<salesListCount.length; i++){
                        rev = 0;
                        gp = 0;
                        for (var j=0; j<salesAmount.length; j++) {
                            if (salesListCount[i].MEMBER_ID_NUM == salesAmount[j].MEMBER_ID_NUM) {
                                rev = salesAmount[j].REV;
                                gp = salesAmount[j].GP;
                            }
                        }
                        list_html += fnSalePlanHtml(salesListCount[i], rev, gp);
                    }
                    $('#salesplan_result').append(list_html);
                },
                complete : function(){
                }
            });
        }   
	}
	
	// 매출 계획 HTML 생성
	function fnSalePlanHtml(_userObject, _rev, _gp) {
	    var obj_html = '';
	    
	    obj_html += "<h3 class='mg_b5'>" + _userObject.HAN_NAME + "</h3>";
	    obj_html += "<table class='basic mg_b30'>";
	    obj_html += "    <colgroup><col width='30%''/><col/></colgroup>";
	    obj_html += "    <tr><th class='ta_r'>Rev</th><td>" + numberWithCommas(_rev) + "</td></tr>";
	    obj_html += "    <tr><th class='ta_r'>GP</th><td>" + numberWithCommas(_gp) + "</td></tr>";
        obj_html += "</table>";
        
        return obj_html; 
	}
	
    // 마일스톤
    function fnOppMilestone() {
        //매출 계획 
        $.ajax({
            url : "/clientSalesActive/selectOpportunityMilestons.do",
            async : false,
            datatype : 'json',
            type : "POST",
            data : {
            	pkNo : '${detail.OPPORTUNITY_ID}'
            },
            beforeSend : function(xhr){
                xhr.setRequestHeader("AJAX", true);
            },
            success : function(data){
                $('#oppMilestone').html('');
                var list_html = '<ul>';
                for(var i=0; i<data.rows.length; i++){
                    list_html += fnOppMilestoneHtml(data.rows[i]);
                }
                list_html += "</ul>";
                $('#oppMilestone').append(list_html);
            },
            complete : function(){
            }
        });
    }
	
    // 마일스톤  HTML 생성
    function fnOppMilestoneHtml(_object) {
        var obj_html = '';
        var statusColor = "";
        var due_date = "";
        var close_date = "";
        var act_name =  (_object.ACT_NAME === undefined)  ? "" : _object.ACT_NAME;
        
        // 목표일과 완료일 undefined 체크
        if (typeof _object.DUE_DATE != "undefined") {
            due_date = _object.DUE_DATE;
        }
        if (typeof _object.CLOSE_DATE != "undefined") {
            close_date = _object.CLOSE_DATE;
        }

		var dueDate = (due_date.replaceAll('-','')).trim();
		var closeDate = (close_date.replaceAll('-','')).trim();
		var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
		
        if((dueDate >= nowDate) && closeDate == ''){
			statusColor += 'yellow';
		}else if(dueDate < nowDate && closeDate == ''){
			statusColor += 'red';
		}else if(closeDate != '' && closeDate != null){
			statusColor += 'green';
		}
        
        if(isEmpty(dueDate) && isEmpty(closeDate)){
        	statusColor = "";
        }
        
        obj_html += "<li>";
        obj_html += "    <div class='top'>";
        obj_html += "        <span class='title'>" + _object.KEY_MILESTONE + "</span>";
        obj_html += "        <span class='status_lec statusColor_" + statusColor + "'></span>";
        obj_html += "    </div>";
        obj_html += "    <div class='cont'>";
        obj_html += "        <span class='fc_gray_light'>책임담당자 : </span> <span class='fc_black'>" + act_name + "</span><br/>";
        obj_html += "        <span class='fc_gray_light'>목표일 : </span> <span class='fc_black'>" + due_date + "</span> /";
        obj_html += "        <span class='fc_gray_light'>완료일 : </span> <span class='fc_black'>" + close_date + "</span>";
        obj_html += "    </div>";
        obj_html += "</li>";

        return obj_html; 
    }
    
    
	// 체크리스트
	function fncCheckList(){
        //매출 계획 
        $.ajax({
            url : "/clientSalesActive/gridOpportunityCheckList.do",
            async : false,
            datatype : 'json',
            type : "POST",
            data : {
                hiddenModalPK : '${detail.OPPORTUNITY_ID}'
            },
            beforeSend : function(xhr){
                xhr.setRequestHeader("AJAX", true);
            },
            success : function(data){
                $('#oppCheckList').html('');
                var list_html = '<ul>';
                for(var i=0; i<data.rows.length; i++){
                    list_html += fncCheckListHtml(data.rows[i]);
                }
                list_html += "</ul>";
                $('#oppCheckList').append(list_html);
            },
            complete : function(){
            }
        });		
	}


    // 체크리스트  HTML 생성
    function fncCheckListHtml(_object) {
        var obj_html = '';
        var statusColor = "";
        var due_date = "";
        var close_date = "";
        
        // 마일스톤 상태값에 따른 css 변경
        if (_object.HIDDEN_STATUS == "Y") {
            statusColor = "yellow";
        } else if (_object.HIDDEN_STATUS == "R") {
            statusColor = "red";
        } else if (_object.HIDDEN_STATUS == "G") {
            statusColor = "green";
        }
       
        // 목표일과 완료일 undefined 체크
        if (typeof _object.DUE_DATE != "undefined") {
            due_date = _object.DUE_DATE;
        }
        if (typeof _object.CLOSE_DATE != "undefined") {
            close_date = _object.CLOSE_DATE;
        }
        
        // 목표일과 완료일 undefined... 체크
        if (typeof _object.CHECKLIST_NAME != "undefined") {
            checkList_name = _object.CHECKLIST_NAME;
        }
        if (typeof _object.MEMO != "undefined") {
            memo = _object.MEMO;
        }
        if (typeof _object.ACTION_PLAN_NAME != "undefined") {
            action_plan_name = _object.ACTION_PLAN_NAME;
        }
        if (typeof _object.ACTION_OWNER != "undefined") {
            action_owner = _object.ACTION_OWNER;
        }
        
        obj_html += "<li>";
        obj_html += "    <div class='top top2'>";
        obj_html += "        <span class='cata r2'>" + checkList_name + "</span>";
        obj_html += "        <span class='title'>" + memo + "</span>";
        obj_html += "        <span class='s_ti'>";
        obj_html += "             <span class='fc_gray_light'>plan:</span>" + action_plan_name;
        obj_html += "        </span>";
        obj_html += "        <span class='status_lec statusColor_" + statusColor + "'></span>";
        obj_html += "    </div>";
      
        
        obj_html += "    <div class='cont'>";
        obj_html += "        <span class='fc_gray_light'>책임담당자 : </span> <span class='fc_black'>" + action_owner + "</span><br/>";
        obj_html += "        <span class='fc_gray_light'>목표일 : </span> <span class='fc_black'>" + due_date + "</span> /";
        obj_html += "        <span class='fc_gray_light'>완료일 : </span> <span class='fc_black'>" + close_date + "</span>";
        obj_html += "    </div>";
        obj_html += "</li>";

        return obj_html; 
    }
    	
	
    // 윈플랜
    function fncWinPlan(){
        $.ajax({
            url : "/clientSalesActive/gridSalesCycleWinPlan.do",
            async : false,
            datatype : 'json',
            type : "POST",
            data : {
            	pkNo : '${detail.OPPORTUNITY_ID}'
            },
            beforeSend : function(xhr){
                xhr.setRequestHeader("AJAX", true);
            },
            success : function(data){
                $('#oppWinPlan').html('');
                var list_html = '<ul>';
                for(var i=0; i<data.rows.length; i++){
                    list_html += fncWinPlanHtml(data.rows[i]);
                }
                list_html += "</ul>";
                $('#oppWinPlan').append(list_html);
            },
            complete : function(){
            }
        }); 		
	}

    // 윈플랜  HTML 생성
    function fncWinPlanHtml(_object) {
        var obj_html = '';
        var statusColor = "";
        var due_date = "";
        var close_date = "";
        var action_owner_name = "";
        
        // 마일스톤 상태값에 따른 css 변경
        if (_object.HIDDEN_STATUS == "Y") {
            statusColor = "yellow";
        } else if (_object.HIDDEN_STATUS == "R") {
            statusColor = "red";
        } else if (_object.HIDDEN_STATUS == "G") {
            statusColor = "green";
        }
       
        // 목표일과 완료일 undefined 체크
        if (typeof _object.DUE_DATE != "undefined") {
            due_date = _object.DUE_DATE;
        }
        if (typeof _object.CLOSE_DATE != "undefined") {
            close_date = _object.CLOSE_DATE;
        }
        if (typeof _object.ACTION_OWNER_NAME != "undefined") {
        	action_owner_name = _object.ACTION_OWNER_NAME;
        }
        
        obj_html += "<li>";
        obj_html += "    <div class='top top2'>";
        obj_html += "        <span class='cata r2'>" + _object.CHECKLIST_NAME + "</span>";
        obj_html += "        <span class='title'>" + _object.ITEM_2BE_FIXED + "</span>";
        obj_html += "        <span class='s_ti'>";
        obj_html += "             <span class='fc_gray_light'>해결계획(상세):</span>" + _object.ACTION_PLAN_NAME;
        obj_html += "        </span>";
        obj_html += "        <span class='status_lec statusColor_" + statusColor + "'></span>";
        obj_html += "    </div>";
      
        
        obj_html += "    <div class='cont'>";
        
        obj_html += "        <span class='fc_gray_light'>책임담당자 : </span> <span class='fc_black'>" + action_owner_name + "</span><br/>";
        
        obj_html += "        <span class='fc_gray_light'>목표일 : </span> <span class='fc_black'>" + due_date + "</span> /";
        obj_html += "        <span class='fc_gray_light'>완료일 : </span> <span class='fc_black'>" + close_date + "</span>";
        obj_html += "    </div>";
        obj_html += "</li>";

        return obj_html; 
    }	
	
</script>
</body>
</html>