<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>
<%@ include file="/WEB-INF/jsp/m/common/cache.jsp" %>
<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>


<!doctype html>	
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
	<title>고객사정보</title>

<link href="${pageContext.request.contextPath}/css/m/style.css" rel="stylesheet" type="text/css">

</head>

<body class="gray_bg">

<!-- location -->
<%-- 	<div class="location">
		<a href="/main/index.do" class="home"><img src="${pageContext.request.contextPath}/images/m/icon_home.svg" /></a>
		<img src="${pageContext.request.contextPath}/images/m/icon_arrow_gray.svg"/>
		<span>고객사 및 고객개인정보</span> 
		<img src="${pageContext.request.contextPath}/images/m/icon_arrow_gray.svg"/>
	</div>
 --%>
	
	
<div class="container_pg">

	

	

	<article class="gate_pg">
		<!-- <div id="CompanyGraph"></div> -->
		<!-- <div class="ta_c mg_b20"> -->
			
			<!-- <p class="fs22">고객사 <span class="fc_blue">검색</span></p> -->
		<!-- </div> -->
		
		<!-- 현재년도 구하기 -->
		
		<div class="top_statusarea_white_bg">
			<h4>고객사 현황</h4>
			<div class="status_box mg_b20">
				<div class="row">
					<ul>
						<li>
							<span class="ti fl_l">전체 고객</span>
							<span class="count fl_r">
								<span class="icon_dash icon_dash_build"></span> 
								<span class="va_m">	${totalClientComapnyCnt}</span>
									<%-- <c:choose>
										<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
										 ${totalClientCnt}
										</c:when>
										<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
										 ${totalClientCnt}
										</c:when>
										<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
										 ${totalClientCnt}
										</c:when>
										<c:otherwise>
										 ${totalClientCnt}
										</c:otherwise>
									</c:choose> --%>
								
							</span>
						</li>
						<li>
							<span class="ti fl_l">금주 신규고객</span>
							<span class="count fl_r">
								<span class="icon_dash icon_dash_build"></span> 
								<span class="va_m">${clientCompanyNewCnt}</span>
							</span>
						</li>
					</ul>
				</div>
			</div>
			
			<%-- <h4>${sysYear}년 영업현황<span class="fs12 fc_gray">(단위:백만원)</span></h4>
			<table class="status_table" summary="">
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
						<!-- <th scope="col">고객사수</th> -->
						<th scope="col">성과</th>
						<th scope="col">In</th>
						<th scope="col">Out</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
							<c:forEach items="${oppGraphData}" var="oppStatus">
								<c:set var = "totalSum" value = "0" />
								<c:set var = "totalSum" value = "${totalSum + oppStatus.TOTAL_CNT}" />
							</c:forEach>
								
							<c:choose>
								<c:when test="${oppGraphData[0].TOTAL_CNT > 0}">
									<c:forEach items="${oppGraphData}" var="oppStatus">
										<tr>
											<th scope="row" class="ta_l">${oppStatus.TARGET_NAME}</th>
											<td>${oppStatus.TOTAL_CNT }</td>
											<td class="fc_blue"><fmt:formatNumber value="${oppStatus.RESULT_AMOUNT}" pattern="#,###" /><span class="fs11">(${oppStatus.RESULT_COUNT})</span></td>
											<td><fmt:formatNumber value="${oppStatus.IN_AMOUNT}" pattern="#,###" /><span class="fs11">(${oppStatus.IN_COUNT})</span></td>
											<td><fmt:formatNumber value="${oppStatus.OUT_AMOUNT}" pattern="#,###" /><span class="fs11">(${oppStatus.OUT_COUNT})</span></td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<th colspan="5">현재 등록된 데이터가 없습니다.</th>
									</tr>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
							<c:forEach items="${oppGraphData}" var="oppStatus">
								<c:set var = "totalSum" value = "0" />
								<c:set var = "totalSum" value = "${totalSum + oppStatus.TOTAL_CNT}" />	
							</c:forEach>
							
							<c:choose>
								<c:when test="${totalSum > 0}">
									<c:forEach items="${oppGraphData}" var="oppStatus">
										<tr>
											<th scope="row" class="ta_l">${oppStatus.TARGET_NAME}</th>
											<td>${oppStatus.TOTAL_CNT }</td>
											<td class="fc_blue"><fmt:formatNumber value="${oppStatus.RESULT_AMOUNT}" pattern="#,###" /><span class="fs11">(${oppStatus.RESULT_COUNT})</span></td>
											<td><fmt:formatNumber value="${oppStatus.IN_AMOUNT}" pattern="#,###" /><span class="fs11">(${oppStatus.IN_COUNT})</span></td>
											<td><fmt:formatNumber value="${oppStatus.OUT_AMOUNT}" pattern="#,###" /><span class="fs11">(${oppStatus.OUT_COUNT})</span></td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<th colspan="5">현재 등록된 데이터가 없습니다.</th>
									</tr>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
							<c:forEach items="${clientOppCnt}" var="oppStatus">
								<tr>
									<th scope="row">${oppStatus.HAN_NAME}</th>
									<td>${oppStatus.TOTAL_CNT }</td>
									<td class="fc_blue"><fmt:formatNumber value="${oppStatus.RESULT_AMOUNT}" pattern="#,###" /><span class="fs11">(${oppStatus.RESULT_COUNT})</span></td>
									<td><fmt:formatNumber value="${oppStatus.IN_AMOUNT}" pattern="#,###" /><span class="fs11">(${oppStatus.IN_COUNT})</span></td>
									<td><fmt:formatNumber value="${oppStatus.OUT_AMOUNT}" pattern="#,###" /><span class="fs11">(${oppStatus.OUT_COUNT})</span></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach items="${oppGraphData}" var="oppStatus">
								<c:set var = "totalSum" value = "0" />
								<c:set var = "totalSum" value = "${totalSum + oppStatus.TOTAL_CNT}" />
							</c:forEach>
							
							<c:choose>
								<c:when test="${oppGraphData[0].TOTAL_CNT > 0}">
									<c:forEach items="${oppGraphData}" var="oppStatus">
										<tr>
											<th scope="row" class="ta_l">${oppStatus.TARGET_NAME}</th>
											<td>${oppStatus.TOTAL_CNT }</td>
											<td class="fc_blue"><fmt:formatNumber value="${oppStatus.RESULT_AMOUNT}" pattern="#,###" /><span class="fs11">(${oppStatus.RESULT_COUNT})</span></td>
											<td><fmt:formatNumber value="${oppStatus.IN_AMOUNT}" pattern="#,###" /><span class="fs11">(${oppStatus.IN_COUNT})</span></td>
											<td><fmt:formatNumber value="${oppStatus.OUT_AMOUNT}" pattern="#,###" /><span class="fs11">(${oppStatus.OUT_COUNT})</span></td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<th colspan="5">현재 등록된 데이터가 없습니다.</th>
									</tr>
								</c:otherwise>
							</c:choose>
							
						</c:otherwise>
					</c:choose>
				</tbody>
			</table> --%>
		</div>

		<div class="cont_list_gray_bg">
<%-- 
		<c:choose>
			<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
				<div class="topFunc_search_new mg_b10">
					<div class="search_pgin">
						<div class="searchArea">
							<input id="textListSearchDetail" type="text" placeholder="고객사명 입력" /><a href="#" id="btn_search"><span class="icon_search"></span></a>
							<input type="hidden" id=hiddenNone" />
						</div>
					</div>
					<a href="#" class="btn btn-primary r3" id="clientCompanyInsert"><span class="">신규 등록</span></a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="search_pgin mg_b10">
	                <div class="searchArea">
	                  	<input id="textListSearchDetail" type="text" placeholder="고객사명 입력" /><a href="#" id="btn_search"><span class="icon_search"></span></a>
						<input type="hidden" id=hiddenNone" />
	                </div>
	            </div>
					
			</c:otherwise>
		</c:choose>
 --%>
			<div class="topFunc_search_new mg_b10">
				<div class="search_pgin">
					<div class="searchArea">
						<input id="textListSearchDetail" type="text" placeholder="고객사명 입력" /><a href="#" id="btn_search"><span class="icon_search"></span></a>
						<input type="hidden" id=hiddenNone" />
					</div>
				</div>
				<a href="#" class="btn btn-primary r3" id="clientCompanyInsert"><span class="">신규 등록</span></a>
			</div>
			
			<%-- <sec:authorize ifAnyGranted="ROLE_CEO,ROLE_DIVISION,ROLE_TEAM,ROLE_MEMBER ">
				<!-- 등록된 고객정보가 없을 떄 -->
					<div class="result_blank off" id="div_no_result">
						등록된 고객 정보가 없습니다.<br/>
						신규등록 해주세요</a>
					</div>
				<!--// 등록된 고객정보가 없을 떄 -->
				
				<!-- 검색결과가 있을 경우 -->
					<div id="div_result" class="result_on" style="display:none">
						<div class="pd_l10 mg_b5" ">
							<strong>검색결과 (총 <span id="result_cnt">0</span>개)</strong>
						</div>
						<ul class="company_list mg_b20" id="result_list2"></ul>
					</div>
				<!--// 검색결과가 있을 경우 -->
				
				<a href="#" onclick="showMore(); return false;"
					class="btn_pg_more r2" id="btn_more" style="display: none;"> <span
					class="va_m" id="span_more">더보기 10 of 10</span>
				</a>
			</sec:authorize> --%>
			
			<%-- <c:if test="${fn:contains(auth, 'ROLE_CEO') and fn:contains(auth, 'ROLE_DIVISION') and fn:contains(auth, 'ROLE_MEMBER') and fn:contains(auth, 'ROLE_TEAM')}"> --%>
				<!-- 등록된 고객정보가 없을 떄 -->
					<div class="result_blank off" id="div_no_result">
						등록된 고객 정보가 없습니다.<br/>
						신규등록 해주세요</a>
					</div>
				<!--// 등록된 고객정보가 없을 떄 -->
				
				<!-- 검색결과가 있을 경우 -->
					<div id="div_result" class="result_on" style="display:none">
						<div class="pd_l10 mg_b5" ">
							<strong>검색결과 (총 <span id="result_cnt">0</span>개)</strong>
						</div>
						<ul class="company_list mg_b20" id="result_list2"></ul>
					</div>
				<!--// 검색결과가 있을 경우 -->
				<a href="#" onclick="showMore(); return false;"
					class="btn_pg_more r2" id="btn_more" style="display: none;"> <span
					class="va_m" id="span_more">더보기 10 of 10</span>
				</a>
			<%-- </c:if> --%>
			
			<!-- 주요고객 리스트 -->
			<!-- <br>
			<div class="pd_l10 mg_b5" id="topList2">
				<h4>주요 고객사 TOP 10</h4>
			</div>
			<div id="topList" >
				
			</div> -->
			
			
			
			<%--  <sec:authorize ifAnyGranted="ROLE_MEMBER"> --%>
					<!-- 접근권한이 없을 떄 -->
					<div class="result_blank off" id="div_no_permission">
						해당 고객정보에 접근 권한이 없습니다.<br/>
						접근권한 부여는 관리자에게 문의해주세요.<br/>
						문의처 : <a href="mailto:admin@gmailcom">admin@gmailcom</a> / <a href="tel:02-0938-1254">02-0938-1254</a>
					</div>
					<!--// 접근권한이 없을 떄 --> 		 	
		<%-- 	</sec:authorize>   --%>
			
			
			
			
			
			
			
			<!-- 
			<a href="#" onclick="fncShowMore(); return false;" class="btn_pg_more primary_bg r2 fc_white" id="btn_more">
				<span class="icon icon_arrow_down md va_m"></span> <span class="va_m" id="span_more">더보기 6 of 6</span>
			</a>
			 -->
			<div id="calendar"></div>
		</div>
	</article>   

	<jsp:include page="../templates/footer.jsp" flush="true"/>

</div>

<div class="modal_screen"></div>

  <!-- form 영역 -->
  
<form id="formSearch" name="formSearch">
	<input type="hidden" id="hiddenSearchType" />
	<input type="hidden" id="hiddenSearchTypeDetailCategory" name="detailCategory"/> 
	<input type="hidden" id="hiddenSearchTypeDetailCompanyName" name="companyName"/> 
	<input type="hidden" id="hiddenSearchTypeSysUpdateDate" name="SysUpdateDate"/>
	<input type="hidden" id="hiddenSearchTypePKArray" name="searchPKArray"/>
	<input type="hidden" id="hiddenSearchTypeResultInSearch" name="resultInSearch"/>
	<input type="hidden" id="hiddenFilePK" name="filePKArray" value=""/>
</form>
  
<form id="formDetail" method="post">
	<input type="hidden" id="customer_id" name="customer_id">
	<input type="hidden" id="company_id" name="company_id">
	<input type="hidden" id="searchDetail" name="searchDetail">
	<input type="hidden" id="opportunity_id" name="opportunity_id">
	<input type="hidden" id="issue_id" name="issue_id">
	<input type="hidden" id="returnProjectMGMTId" name="returnProjectMGMTId">
	<input type="hidden" id="returnPK" name="returnPK">
</form>

<form method="post" id="inserForm" action="">
    <input type="hidden" id="mode" name="mode" value="ins" />
</form>  

<!-- Mainly scripts -->
<script src="${pageContext.request.contextPath}/js/m/jquery-1.11.0.js"></script>
<script src="${pageContext.request.contextPath}/js/m/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/common.js"></script>


<script type="text/javascript">

	
    //var totalCnt = '${totalCnt}';
    var totalCnt = 0;
    var rowCount = 10;
	var pkArray = '';
	var curCnt = 0;
	var curCategory = '';
	
	var v_page = 0;


	var pageEnd = 10;
	function fncSearch(_keyword){
		
		v_page = 0; 															// 초기화
		var params = $.param({
			serchInfo : $("#textListSearchDetail").val(),
			creatorId : '${userInfo.MEMBER_ID_NUM}',
			pageStart : curCnt,
			pageEnd : pageEnd,
			rowCount : rowCount,
			serch : 2,
			datatype : 'json'
		});
		
		var v_rowCount = 10;
		var v_pageStart = (v_page * v_rowCount)+1;
		var v_pageEnd = (v_page+1) * 10;
		
		var countParams = $.param({
			datatype : 'json'
		});
		
		//카운트, 최근업데이트, 결과내 검색
		$.ajax({
			url : "/clientManagement/gridClientCompanyCount.do",
			async : false,
			datatype : 'json',
			method : 'POST',
			data : params + "&" + countParams,
			success : function(data) {
				//console.log(data);
				//page count
				var v_count = data.listCount;
				totalCnt = v_count.COUNT;
			},
			complete : function() {
			}
		});
		 
		
		$.ajax({
			url : "/clientManagement/gridClientCompanyInfo.do",
			datatype : 'json',
			method: 'POST',
			data : params,
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			success : function(data){
				$('#result_list2').html('');
				var list = data.rows;
				var list_html = '';
				
				if (list.length > 0){ 
					for (var i = 0; i < list.length; i++){
						list_html += fncGetItemHtml(list[i]);
					}
					
					v_page++;
					v_pageStart = (v_page * v_rowCount)+1;
					v_pageEnd = (v_page+1) * 10;
					
					if (parseInt(v_pageStart) >= parseInt(totalCnt)) {
						$('#btn_more').hide();
					} else {
						var cnt_html = '더보기 ' + (v_pageStart-1) + ' of '
								+ totalCnt;
						$('#span_more').html(cnt_html);
						$('#btn_more').show();
					}
					
					//console.log(list_html);
					
					/*
					if(list.length==0){
						$('#div_no_result').show();
						$('#div_result').show();
					}else{
						$('#div_result').show();
						$('#result_cnt').html(list.length);
						$('#result_list2').html(list_html);
						$('#div_no_result').hide();
						$('#topList').show();														// 탑 리스트
						$('#topList2').show();													// 탑 리스트 타이틀
					}*/
					$('#div_result').show();
					$('#result_cnt').html(totalCnt);
					$('#result_list2').html(list_html);
					$('#div_no_result').hide();
					$('#topList').show();														// 탑 리스트
					$('#topList2').show();													// 탑 리스트 타이틀
						/*
						$('#result_cnt').html(totalCnt);
						$('#result_list2').html(list_html);
						$('#tc').show();
						$('#topList').show();
						$('#topList2').show();*/
				}else {
					alert("검색 결과가 없습니다.");
				}
			},
			complete : function(){
			}
		});

	}
	
	function fncDetail(_no, tabNum){
		
		$("#formDetail #searchDetail").val($("#textListSearchDetail").val());
		$("#formDetail #company_id").val(_no);
		if(tabNum == null){
			$("#formDetail").attr("action", "/clientManagement/viewClientCompanyInfoDetail.do");
		}else{
			$("#formDetail").attr("action", "/clientManagement/viewClientCompanyInfoDetail.do?tabNo=" + tabNum);
		}
		
		$('#formDetail').submit();
		/*
		var params = $.param({
			companyId : _no,
			searchId : '${userInfo.MEMBER_ID_NUM}',
			count : 1,
			datatype : 'json'
		});

		$.ajax({
			url :"/clientManagement/insertSearchKeyword.do",
			datatype : 'json',
			method : 'POST',
			data : params,
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			success : function(data){
				
			},
			complate : function(){
				
			}
		});
		*/
	}


	function fncGetItemHtml(_object){
		var obj_html = '';
		obj_html += '<li>';
		obj_html += '<li><a href="#" onclick="fncDetail('+_object.COMPANY_ID+');return false;">';
		obj_html += '<div class="info">';
		obj_html += '<span class="subject">'+_object.COMPANY_NAME+'</span>';
		obj_html += '<span class="custom_info">'+_object.POSTAL_ADDRESS+'</span>';
		if(_object.COMPANY_TELNO != null && _object.COMPANY_TELNO != ''){
 			obj_html += '<span class="name">대표전화 : '+_object.COMPANY_TELNO+'</span>';
		}
		obj_html += '</div>';
		obj_html += '</a>';
		/* if (_object.CEO_NAME != undefined && _object.CEO_NAME != ''){
			
		}
		if (_object.COMPANY_TELNO != undefined && _object.COMPANY_TELNO != ''){
			obj_html += '<span class="custom_info">대표전화 : '+_object.COMPANY_TELNO+'</span>';
		}
		
		if (_object.COMPANY_TELNO != undefined && _object.COMPANY_TELNO != ''){
			obj_html += '<a href="tel:'+_object.COMPANY_TELNO+'" class="btn_phone_go"><img src="/images/m/icon_phone.png" alt="전화걸기"/></a>';
		} */
		obj_html += '<div class="quicklink ql_4ea">';
		obj_html += '<a type="button" onclick="fncDetail('+_object.COMPANY_ID+',1);">정보</a> ';
		obj_html += '<a type="button" onclick="fncDetail('+_object.COMPANY_ID+',3);">영업</a> ';
		obj_html += '<a type="button" onclick="fncDetail('+_object.COMPANY_ID+',4);">이슈</a> ';
		obj_html += '<a type="button" onclick="fncDetail('+_object.COMPANY_ID+',5);">컨택</a>';
		obj_html += '</div>';
		obj_html += '</li>';
		//obj_html += '</ul>';
		
		return obj_html;
	}
	
	$(document).ready(function() {
		$('#btn_search').click(function(e){
			
			e.preventDefault();
			var search_value = $('#textListSearchDetail').val();
			
			// 공백검색 제어
			if (search_value == " ") {
				alert("키워드 앞에 공백을 제거하고 검색해주세요.");
				return false;
			}
			
			fncSearch(search_value);
		});
		
        // 고객사  등록
        $("#clientCompanyInsert").on("click", function(e) {
            $('#mode').val("ins");
            $("#inserForm").attr("action", "/clientManagement/clientCompanyInsertForm.do");
            //console.log("mode[" +  $('#mode').val() + "]");
            $('#inserForm').submit();       
            e.preventDefault();
        }); 		
        toptenList();
	});
	
	// 주요 고객사 리스트 top10 
	// 2018-08-08 현재 기획의도 몰라서 order by COMPANY_NAME ASC 기준으로 뽑음 
	function toptenList(){
		/* var params = $.param({
			datatype : 'json'
		});
		
		$.ajax({
			url :"/clientManagement/selectCompanyTopList.do",
			data : params,
			datatype : 'json',
			method : 'POST',
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			success : function(data){
				var list = data.rows;
				var list_html = '';
				for (var i = 0; i < list.length; i++){
					list_html += fncGetTopListHtml(list[i]);
				}
				$("#topList").html(list_html);
			},
			complate : function(){
				
			}
		}); */
	}
	
	function fncGetTopListHtml(_object){
		var obj_html = '';
		obj_html += '<ul class="company_list mg_b20"><li>'; 
		//obj_html += '<li><a href="#" onclick="fncDetail('+_object.COMPANY_ID+');return false;">';
		obj_html += '<div class="info">';
		obj_html += '<span class="subject">'+_object.COMPANY_NAME+'</span>';
		
		// 대표주소가 없는 경우
		if(_object.POSTAL_ADDRESS == null || _object.POSTAL_ADDRESS == ''){
			obj_html += '<span class="custom_info">대표주소 : - </span>';
		}else{// 대표주소가 있는 경우
			obj_html += '<span class="custom_info">대표주소 : '+_object.POSTAL_ADDRESS+'</span>';
		}
		
		/* obj_html += '<span class="name"> 담당자 : ' + _object.HAN_NAME + '</span>'; */
		obj_html += '</div>';
		obj_html += '<div class="quicklink ql_4ea">';
		obj_html += '<a type="button" onclick="fncDetail('+_object.COMPANY_ID+',1);">정보</a> ';
		obj_html += '<a type="button" onclick="fncDetail('+_object.COMPANY_ID+',2);">영업</a> ';
		obj_html += '<a type="button" onclick="fncDetail('+_object.COMPANY_ID+',3);">이슈</a> ';
		obj_html += '<a type="button" onclick="fncDetail('+_object.COMPANY_ID+',4);">컨택</a>';
		obj_html += '</div>';
		obj_html += '</li></ul>';
		
		return obj_html;
	}
	
	
	function showMore() {

		var v_rowCount = 10;
		var v_pageStart = (v_page * v_rowCount)+1;
		var v_pageEnd = (v_page+1) * 10;
		
		var params = $.param({
			pageStart : v_pageStart,
			pageEnd : v_pageEnd,
			rowCount : v_rowCount,
			serchInfo : $("#textListSearchDetail").val(),
			creatorId : '${userInfo.MEMBER_ID_NUM}',
			serch : 2,
			datatype : 'json'
		});

		//카운트, 최근업데이트, 결과내 검색
		$.ajax({
			url : "/clientManagement/gridClientCompanyCount.do",
			async : false,
			datatype : 'json',
			method : 'POST',
			data : params,
			success : function(data) {
				//console.log(data);
				//page count
				var v_count = data.listCount;
				totalCnt = v_count.COUNT;
			},
			complete : function() {
			}
		});
		
		$.ajax({
			url : "/clientManagement/gridClientCompanyInfo.do",
			datatype : 'json',
			method: 'POST',
			data : params,
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			success : function(data){
				
				var list = data.rows;
				var list_html = '';
				
				if (list.length > 0){ 
					for (var i = 0; i < list.length; i++){
						list_html += fncGetItemHtml(list[i]);
					}
					
					v_page++;
					v_pageStart = (v_page * v_rowCount)+1;
					v_pageEnd = (v_page+1) * 10;
					
					if (parseInt(v_pageStart) >= parseInt(totalCnt)) {
						$('#btn_more').hide();
					} else {
						var cnt_html = '더보기 ' + (v_pageStart-1) + ' of ' + totalCnt;
						$('#span_more').html(cnt_html);
						$('#btn_more').show();
					}
					
					
						
					$('#result_cnt').html(totalCnt);
					$('#result_list2').append(list_html);
					$('#tc').show();
					$('#topList').show();
					$('#topList2').show();
					
				}else {
					alert("검색 결과가 없습니다.");
				}
			},
			complete : function(){
			}
		});
	}
</script>

</body>
</html>