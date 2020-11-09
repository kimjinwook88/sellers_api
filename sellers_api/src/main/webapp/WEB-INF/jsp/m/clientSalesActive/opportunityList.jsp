<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>

<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>

<!doctype html>
<html lang="ko">
<body class="gray_bg">
	
<div class="container_pg_list">
	
	<!-- 날짜 선택 navi -->
	<article style="background-color: #BDBDBD;">
		<div style="text-align:center; padding:10px 0 10px 0;">
			<a href="javascript:void(0);" id="month_prev_btn" class="btn_prev va_m" onclick="top_year_btn(-1);">이전</a> <%-- fncMoveToDate('${prevMonth}'); --%>
			<span class="current_date va_m"><span name="sysYear" id="sysYear"></span>년</span>
			<a href="javascript:void(0);" id="month_next_btn" class="btn_next va_m" onclick="top_year_btn(1);">다음</a>
		</div>
	</article>
		
	<article class="list_pg">
		                              
		<!-- 현황 영역 -->
		<div class="top_statusarea_white_bg">
			<h4><span name="sysYear"></span>년 영업기회 현황</h4>
			<div class="status_box mg_b20">
				<div class="row">
					<ul>
						<li>
							<span class="ti fl_l">전체 등록</span>
							<span class="count fl_r">
							<!-- <span class="icon_dash icon_dash_build"></span>  -->
							<span class="va_m">${selectOpportunityCount.TOTAL_COUNT}</span>
							<span class="fs12">건</span>
							</span>
						</li>
						<li>
							<span class="ti fl_l">진행중</span>
							<span class="count fl_r">
							<!-- <span class="icon_dash icon_dash_build"></span>  -->
							<span class="va_m">${selectOpportunityCount.ING_COUNT}</span>
							<span class="fs12">건</span>
							</span>
						</li>
					</ul>
				</div>
			</div>
			
			<%-- <div class="overflow_h">
				<div class="fl_l">
					<h4>Forecast 추이</h4>
				</div>
				<div class="fl_r">
					<c:if test="${!fn:contains(auth, 'ROLE_MEMBER')}">
						<select class="form-control" id="lineGraphSelectbox" onchange="changeLineGraphSelectbox(this.value);">
							<c:choose>
								<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
									<option value="all" id="optionValue_ALL">회사전체</option>
									<c:forEach var="rows" items="${selectTeamNameList}" varStatus="status">
										<option value="${rows.TARGET_NO}" id="optionValue${status.index}">${rows.TARGET_NAME}</option>
									</c:forEach>
								</c:when>
								
								<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
									<option value="all" id="optionValue_ALL">본부전체</option>
									<c:forEach var="rows" items="${selectTeamNameList}" varStatus="status">
										<option value="${rows.TARGET_NO}" id="optionValue${status.index}">${rows.TARGET_NAME}</option>
									</c:forEach>
								</c:when>
								
								<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
									<option value="all" id="optionValue_ALL">팀전체</option>
									<c:forEach var="rows" items="${selectTeamNameList}">
										<option value="${rows.TARGET_NO}" id="optionValue${status.index}">${rows.TARGET_NAME}</option>
									</c:forEach>
								</c:when>
								
								<c:otherwise>
									<option value="all" id="optionValue_ALL">회사전체</option>
									<c:forEach var="rows" items="${selectTeamNameList}" varStatus="status">
										<option value="${rows.TARGET_NO}" id="optionValue${status.index}">${rows.TARGET_NAME}</option>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</select>
					</c:if>
				</div>
			</div> --%>
			
			<div class="mg_b20" id="rightGraph">
			</div>
				<h4><span name="sysYear"></span>년 영업 현황<span class="fs12 fc_gray"> (단위:백만원)</span></h4>			
			<table class="status_table mg_b20" summary="">
				<caption></caption>
				<colgroup>
					<col width="24%"/>
					<col width="19%"/>
					<col width="19%"/>
					<col width="19%"/>
					<col width="19%"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">부서</th>
						<th scope="col">목표</th>
						<th scope="col">성과</th>
						<th scope="col">In</th>
						<th scope="col">Out</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(selectOpportunityDashBoardOpp) > 0 or !empty selectOpportunityDashBoardOpp}">
							<c:forEach items="${selectOpportunityDashBoardOpp}" var="status">
								<tr>
									<th scope="row" class="ta_l">${status.TARGET_NAME}</th>
									<td><fmt:formatNumber value="${status.TAGET_AMOUNT/1000000}" pattern="#,###" /></td>
									<td class="fc_blue"><fmt:formatNumber value="${status.RESULT_AMOUNT/1000000}" pattern="#,###" /></td>
									<td><fmt:formatNumber value="${status.IN_AMOUNT/1000000}" pattern="#,###" /></td>
									<td><fmt:formatNumber value="${status.OUT_AMOUNT/1000000}" pattern="#,###" /></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<th colspan="5">등록된 데이터가 없습니다</th>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			
			
			<c:if test="${!fn:contains(auth, 'ROLE_MEMBER')}">
				<c:choose>
					<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
						<h4><span name="sysYear"></span>년 영업단계 현황<span class="fs12 fc_gray"> (단위:건)</span></h4>
					</c:when>
					<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
						<h4><span name="sysYear"></span>년 본부 영업단계 현황<span class="fs12 fc_gray"> (단위:건)</span></h4>
					</c:when>
					<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
						<h4><span name="sysYear"></span>년 팀 영업단계 현황<span class="fs12 fc_gray"> (단위:건)</span></h4>
					</c:when>
					<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
						<h4><span name="sysYear"></span>년 나의 영업단계 현황<span class="fs12 fc_gray"> (단위:건)</span></h4>
					</c:when>
					<c:otherwise>
						<h4><span name="sysYear"></span>년 영업단계 현황<span class="fs12 fc_gray"> (단위:건)</span></h4>
					</c:otherwise>
				</c:choose>
				<table class="status_table" summary="">
					<caption></caption>
					<colgroup>
						<col width=""/>
						<col width=""/>
						<col width=""/>
						<col width=""/>
					</colgroup>
					<thead>
						<tr>
							<th scope="col">부서</th>
							<th scope="col">전체</th>
							<th scope="col">Identify/<br>Validation</th>
							<th scope="col">Qualification</th>
							<th scope="col">Negotiation</th>
							<th scope="col">Close</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${fn:length(selectSalesCycle) > 0 }">
								<c:forEach items="${selectSalesCycle}" var="salesCycle">
										<tr>
											<th scope="row" class="ta_l">${salesCycle.TARGET}</th>
											<td>${salesCycle.TOTAL}</td>
											<td class="fc_blue">${salesCycle.IV}</td>
											<td class="fc_blue">${salesCycle.QUALIFICATION}</td>
											<td class="fc_blue">${salesCycle.NEGOTIATION}</td>
											<td>${salesCycle.CLOSE}</td>
										</tr>
									</c:forEach>
							</c:when>
							<c:otherwise>
									<tr>
											<th colspan="6">No Data.</th>
									</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</c:if>
			
		</div>
		
		<%-- <!-- 현재년도 구하기 -->
		
		<c:choose>
			<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
				${sysYear}년 영업현황(단위:백만원)
					<c:forEach items="${selectOpportunityDashBoardOpp}" var="status">
						<p>${status.TEAM_NAME} / ${status.TAGET_AMOUNT} / ${status.RESULT_AMOUNT} / ${status.IN_AMOUNT} / ${status.OUT_AMOUNT}</p>
					</c:forEach>
					
				<br><br>
				영업단계 현황
				<c:forEach items="${selectSalesCycle}" var="salesCycle">
					<p>${salesCycle.TARGET_NAME} / ${salesCycle.IV} / ${salesCycle.QUALIFICATION} / ${salesCycle.CLOSE}</p>
				</c:forEach>
			</c:when>
			<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
				${sysYear}년 영업현황(단위:백만원)
					<c:forEach items="${selectOpportunityDashBoardOpp}" var="status">
						<p>${status.HAN_NAME} / ${status.TAGET_AMOUNT} / ${status.RESULT_AMOUNT} / ${status.IN_AMOUNT} / ${status.OUT_AMOUNT}</p>
					</c:forEach>
					
				<br><br>
				영업단계 현황
				<c:forEach items="${selectSalesCycle}" var="salesCycle">
					<p>${salesCycle.TARGET_NAME} / ${salesCycle.IV} / ${salesCycle.QUALIFICATION} / ${salesCycle.CLOSE}</p>
				</c:forEach>
			</c:when>
		</c:choose>
		 --%>
		
		<!-- 검색 및 리스트 -->
		<div class="cont_list_gray_bg">
			
			<div class="overflow_h mg_b10">
				<div class="fl_r">
					<select id="textTeamNameList" onChange="getList('Y');" style="background: white;">
						<c:forEach var="rows" items="${selectTeamNameList}">
							<option value="${rows.TARGET_NO}">${rows.TARGET_NAME}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
				
			<div class="topFunc_search_new mg_b10">
				<div class="search_pgin">
					<div class="searchArea">
						<input type="text" id="textSearchKeyword" placeholder="제목 또는 영업대표 입력 " />
						<a href="javascript:getList('Y');"><span class="icon_search"></span></a>
					</div>
				</div>
				<a href="#" class="btn btn-primary r5" id="opportunityInsertForm">
					<span class="">신규 등록</span>
				</a>
			</div>
			
			<ul class="list_type1" id="result_list2">
			
			</ul>
	 		<div id="blank_list" class="off"></div>
			<a href="#" onclick="fncShowMore(); return false;" class="btn_pg_more r2" id="btn_more">
				<span class="va_m"></span> <span id="span_more">더보기 6 of 6</span>
			</a>
		</div>
	</article>   

	<jsp:include page="../templates/footer.jsp" flush="true"/>

    <form method="post" id="detailForm" action="">
        <input type="hidden" id="pkNo" name="pkNo" value="" />
    </form>
    
    <form method="post" id="inserForm" action="">
        <input type="hidden" id="mode" name="mode" value="ins" />
    </form>  

</div>

<div class="modal_screen"></div>

<!-- c3 chart -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.css"/>
<script src="https://d3js.org/d3.v3.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<!-- Mainly scripts -->
<%-- <script src="${pageContext.request.contextPath}/js/m/bootstrap.min.js"></script> --%>

<script type="text/javascript">
	
	$(document).ready(function() {
		//foreCastRightGet();
		$("#textSearchKeyword").keydown(function (key) {
	   		if(key.keyCode == 13){
	   			getList('Y');
		     }
		 });
		
		<c:choose>
			<c:when test="${param.searchStartDate != '' and param.searchStartDate != null}">
			$("span[name='sysYear']").html(${param.searchStartDate});	
			</c:when>
			<c:otherwise>
			$("span[name='sysYear']").html(${sysYear});
			</c:otherwise>
		</c:choose>
		
		getList();
	});

	//var totalCnt = '${totalCnt}';
	//var curCnt = 0;
	var searchDivision = '';
	
	var totalCnt = 0;
	var rowCount = 10;
	var pkArray = '';
	var curCnt = 0;
	var curCategory = '';
	
	var v_page = 0;

	//var params;
	
	function fncDetail(_no){
		$('#pkNo').val(_no);
		$("#detailForm").attr("action", "/clientSalesActive/selectOpportunityDetail.do");
		$('#detailForm').submit();
	}
	
	
	function fncSelectGroup(_group){		
		$('#select_text').html(_group);
		$('.dropdown-toggle').next().toggle();
		$('.caret').toggleClass('caret_up');		
		
		//if (_group == '부서선택') _group = '';
		//searchDivision = _group;
		//curCnt = 0;
		//$('#result_list').html('');
		//fncShowMore();
	}
	
	function fncSelectBox(_group){
		$('#select_text').html(_group);
		$('.dropdown-toggle').next().toggle();
		$('.caret').toggleClass('caret_up');
		
		if(_group == '부서선택'){
			return;
		}else{
			$('#btn_more').hide();
			
			$('.sel_off').hide();
			$('.team_'+_group).show();
			
			
			if($('.team_'+_group)){
				$('#btn_more').show();
				fncGetTotalCount();
				fncShowMore();
			}
		}	
	}
	
	function top_year_btn(c){
		if(c == 1){
			$("span[name='sysYear']").html(parseInt($("span#sysYear").text())+1);
		}else{
			$("span[name='sysYear']").html(parseInt($("span#sysYear").text())-1);
		}
		location.href = "/clientSalesActive/viewOpportunityList.do?searchStartDate="+parseInt($("span#sysYear").text());
	};
	
	/**
	*	Sales Cycle 
	*/
	function getSalesCycleStatus(salesCycle, statusNum){		
		if(salesCycle < statusNum){
			return 'gray';
		}else{
			return 'purple';
		}
	}
	
	function fncGetItemHtml(_object){
		
		var obj_html = '';
		obj_html += '<li class="sel_off team_'+_object.TEAM_NAME +'"><a href="#" onclick="fncDetail('+_object.OPPORTUNITY_ID+');return false;">';
		obj_html += '<span class="top"><span class="subject">'+_object.SUBJECT+'</span></span>';
		obj_html += '<span class="bottom"><span class="name">'+_object.COMPANY_NAME+' / '+_object.CUSTOMER_NAME+'</span>';
		obj_html += '<span class="name">'+_object.OWNER_NAME+' / '+_object.IDENTIFIER_NAME+'</span>';
		obj_html += '<span class="date fs13 fc_gray_light">예상계약일자 : '+_object.CONTRACT_DATE+'</span>';
		obj_html += '<span class="amount fs13 ">예상계약금액 : '+_object.CONTRACT_AMOUNT_OR+'</span>';
		obj_html += '</span>';
		
		obj_html += '<span class="opportunity_status">';
		var salesCycle = _object.SALES_CYCLE;
		obj_html += '<span class="statusColor_'+getSalesCycleStatus(salesCycle, 1)+'_bg r3">Identify/Validation</span> ';
		obj_html += '<span class="statusColor_'+getSalesCycleStatus(salesCycle, 2)+'_bg r3">Qualification</span> '; 
		obj_html += '<span class="statusColor_'+getSalesCycleStatus(salesCycle, 3)+'_bg r3">Negotiation</span> ';
		obj_html += '<span class="statusColor_'+getSalesCycleStatus(salesCycle, 4)+'_bg r3">Close</span>';		
		obj_html += '</span></a>';
		
		/* obj_html += '<span class="opportunity_status">';
		obj_html += '<span class="statusColor_'+_object.STATUS1+'_outline r3">일정</span> ';
		obj_html += '<span class="statusColor_'+_object.STATUS2+'_outline r3">경쟁</span> '; 
		obj_html += '<span class="statusColor_'+_object.STATUS3+'_outline r3">솔루션</span> ';
		obj_html += '<span class="statusColor_'+_object.STATUS4+'_outline r3">계약</span>';
		obj_html += '</span></a>';
		obj_html += '<div class="quicklink ql_3ea">';
		obj_html += '<a onclick="shortCuts('+_object.OPPORTUNITY_ID+', 1)">정보</a> ';
		obj_html += '<a onclick="shortCuts('+_object.OPPORTUNITY_ID+', 2)">영업단계</a> ';
		obj_html += '<a onclick="shortCuts('+_object.OPPORTUNITY_ID+', 3)">승리계획</a>';
		obj_html += '<a onclick="shortCuts('+_object.OPPORTUNITY_ID+', 4)">마일스톤</a> ';
		obj_html += '<a onclick="shortCuts('+_object.OPPORTUNITY_ID+', 5)">매출/매입 품목</a>';
		obj_html += '<a onclick="shortCuts('+_object.OPPORTUNITY_ID+', 6)">매출/수금 계획</a>';
		obj_html += '</div>'; */
		
		obj_html += '</li>';
		
		return obj_html;
	}
	
	function shortCuts(pkNo, tabNo){
		location.href = "/clientSalesActive/selectOpportunityDetail.do?pkNo=" + pkNo + "&tabNo=" + tabNo;
	}
	
	$(document).ready(function() {
		
		// 컨택등록 이벤트 등록
		$("#opportunityInsertForm").on("click", function(e) {
			$('#mode').val("ins");
			$("#inserForm").attr("action", "/clientSalesActive/opportunityInsertForm.do");
			//console.log("mode[" +  $('#mode').val() + "]");
			$('#inserForm').submit();
			e.preventDefault();
		});
	});
	
	function getList(newSearch, classify){
		
		var ns;
		if(newSearch == 'Y'){
			totalCnt = 0;
			v_page = 0;
			curCnt = 0;
			ns = 'Y';
		}else{
			ns = 'N';
		}
		
		var params = $.param({
			pageStart : curCnt,
			rowCount : rowCount,
			datatype : 'json',
			latelyUpdateTable : "OPPORTUNITY_LOG",
			// 조건 검색
			<c:choose>
				<c:when test="${fn:contains(auth, 'ROLE_CEO') ||  fn:contains(auth, 'ROLE_ADMIN')}">
					searchDivision : $('#textTeamNameList').val(),
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
					searchTeam : $('#textTeamNameList').val(),
				</c:when>
				<c:otherwise>
					searchMember : $('#textTeamNameList').val(),
				</c:otherwise>
			</c:choose>
			textSearchKeyword : $('#textSearchKeyword').val(),
			searchStartDate : $("span#sysYear").text()+"-01-01", 
			searchEndDate : $("span#sysYear").text()+"-12-31", 
			jsp : '/clientSalesActive/opportunityListAjax',
			numberPagingUseYn : "Y"
		});
		
		var countParams = $.param({
			datatype : 'json'
		});
		
		var v_rowCount = 10;
		var v_pageStart = v_page * v_rowCount;
		
		//카운트, 최근업데이트,결과내 검색
		$.ajax({
			url : "/clientSalesActive/selectOpportunityCount.do",
			async : false,
			datatype : 'json',
			method: 'POST',
			data : params,
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			success : function(data){
				totalCnt = data.listCount;
				$('#total_cnt').html(data.listCount);
				
				//결과내 검색
				searchPKArray = data.searchPKArray;
			},
		});
		
		var listParams = $.param({
			datatype : 'json',
			jsp : '/clientSalesActive/opportunityListAjax'
		});
		
		$.ajax({
			url : "/clientSalesActive/selectOpportunity.do",
			async : false,
			datatype : 'json',
			method: 'POST',
			data : params,
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			success : function(data){
				var list = data.rows;
				var list_html = '';
				
				if(list.length > 0){
					for (var i = 0; i < list.length; i++){
						list_html += fncGetItemHtml(list[i]);
					}
					
					v_page++;
					v_pageStart = v_page * v_rowCount;
					
					$("#blank_list").hide();
					$('#result_list2').html(list_html);
					
					// 카운트
					if(ns == 'Y'){
						curCnt = list.length;
					}else{
						curCnt += list.length;
					}
					
					
					if (parseInt(v_pageStart) >= parseInt(totalCnt)){
						$('#btn_more').hide();
					} else {
						var cnt_html = '더보기 '+curCnt+' of ' + totalCnt;
						$('#span_more').html(cnt_html);
						$('#btn_more').show();
					}
				}else{
					$('#result_list2').html('');
					
					
					
					var blank_html ='';
					blank_html += '<div class="result_blank">';
					
					if(classify == 'all'){
						blank_html += '등록된 영업기회가 없습니다.<br/>신규등록 해주세요';
					}else if(classify == 'ing'){
						blank_html += '진행중인 영업기회가 없습니다.';
					}else if(classify == 'close'){
						blank_html += '종료된 영업기회가 없습니다.';
					}else{
						blank_html += '등록된 영업기회가 없습니다.<br/>신규등록 해주세요';
					}
					
					blank_html += '</div>';
					
					$("#blank_list").html(blank_html);
					$("#btn_more").hide();
					$("#blank_list").show();
				}
				
			},
			complete : function(){
			}
		});
	}
	
	function fncShowMore(){
		
		
		var v_rowCount = 10;
		var v_pageStart = v_page * v_rowCount;
		
		//v_page = 0; // 초기화
		var params = $.param({
			pageStart : v_pageStart,
			rowCount : v_rowCount,
			datatype : 'json',
			latelyUpdateTable : "OPPORTUNITY_LOG",
			// 조건 검색
			<c:choose>
				<c:when test="${fn:contains(auth, 'ROLE_CEO') ||  fn:contains(auth, 'ROLE_ADMIN')}">
					searchDivision : $('#textTeamNameList').val(),
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
					searchTeam : $('#textTeamNameList').val(),
				</c:when>
				<c:otherwise>
					searchMember : $('#textTeamNameList').val(),
				</c:otherwise>
			</c:choose>
			textSearchKeyword : $('#textSearchKeyword').val(),
			searchStartDate : $("span#sysYear").text()+"-01-01", 
			searchEndDate : $("span#sysYear").text()+"-12-31",
			//textSituationList : $('#textSituationList').val(),
			jsp : '/clientSalesActive/opportunityListAjax',
			numberPagingUseYn : "Y"
		});
		
		//카운트, 최근업데이트,결과내 검색
		$.ajax({
			url : "/clientSalesActive/selectOpportunityCount.do",
			async : false,
			datatype : 'json',
			method: 'POST',
			data : params,
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			success : function(data){
				totalCnt = data.listCount;
				
				$('#total_cnt').html(data.listCount);
				//결과내 검색
				searchPKArray = data.searchPKArray;
				//fncShowMore();
			},
		});
		
		
		//리스트
		$.ajax({
			url : "/clientSalesActive/selectOpportunity.do",
			async : false,
			datatype : 'json',
			method: 'POST',
			data : params,
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			success : function(data){
				$('#btn_more').show();
				var list = data.rows;
				var list_html = '';
				
				for (var i = 0; i < list.length; i++){
					list_html += fncGetItemHtml(list[i]);
				}
				
				v_page++;
				v_pageStart = v_page * v_rowCount;
				
				$('#result_list2').append(list_html);
		
				// 카운트
				curCnt += list.length;
				//fncGetTotalCount();
				if (parseInt(curCnt) >= parseInt(totalCnt)){
					$('#btn_more').hide();
				} else {
					var cnt_html = '더보기 '+curCnt+' of ' + totalCnt;
					$('#span_more').html(cnt_html);
				}
				
			},
			complete : function(){
			}
		});
	}
	
	//foreCast 그래프 
	function foreCastRightGet(value, typeValue, t_value){
		
		var typeValue = 'Number';
		
		
		if(t_value != null && t_value != ''){
			var TeamValue = t_value;
		}
		
		var params = $.param({
			datatype : 'html',
			jsp : '/clientSalesActive/opportunityDashBoardOpp2AjaxM',
			//searchDate : dashboard.quarterDate,
			selectValue : value,
			typeValue : typeValue,
			TeamValue :TeamValue
		});
		
		$.ajax({
			url : "/clientSalesActive/selectOpportunityDashBoardOpp2.do",
			datatype : 'html',
			type: 'GET',
			data : params,
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			success : function(data){
				$("#rightGraph").html('');
				$("#rightGraph").html(data);
			},
			complete : function(){
			}
		});
	}
	
	function changeLineGraphSelectbox(value){
		foreCastRightGet(value);
	}
	
</script>
</body>
</html>