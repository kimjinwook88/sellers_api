<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
<title>파트너컨텍관리</title>

<link href="${pageContext.request.contextPath}/css/m/style.css" rel="stylesheet" type="text/css">

</head>

<body class="gray_bg">
<jsp:include page="../templates/header.jsp" flush="true"/>
<!-- location -->
	<%-- <div class="breadcrumb">
		<a href="#" class="home"><img src="../../../images/m/icon_home.svg" /></a>
		<div class="breadcrumb_depth1">
			<a class="active_menu">&nbsp;파트너사 협업관리</a>
		</div>
		<jsp:include page="../common/nav.jsp" flush="true"/>
	</div> --%>
<div class="container_pg_list">

	

	

	<article class="list_pg">
	
		<!-- 현황 영역 -->
		<div class="top_statusarea_white_bg">
			<c:choose>
				<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
					<h4>파트너 컨택 현황</h4>
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
					<h4>팀 파트너 컨택 현황</h4>
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
					<h4>나의 파트너 컨택 현황</h4>
				</c:when>
			</c:choose>
			<div class="status_box mg_b20">
				<div class="row">
					<ul>
						<li>
							<span class="ti fl_l">전체 컨택수</span>
							<span class="count fl_r">
								<!-- <span class="icon_dash icon_dash_build"></span>  -->
								<span class="va_m">${totalPartnerContactCnt}</span>
								<span class="fs12">건</span>
							</span>
						</li>
						<li>
							<span class="ti fl_l">금주 컨택수</span>
							<span class="count fl_r">
								<!-- <span class="icon_dash icon_dash_build"></span>  -->
								<span class="va_m">${partnerContactNewCnt}</span>
								<span class="fs12">건</span>
							</span>
						</li>
					</ul>
				</div>
			</div>
			
			<h4>컨택방법별 현황</h4>
			<table class="status_table mg_b20" summary="">
				<caption></caption>
				<colgroup>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">부서</th>
						<th scope="col">합계</th>
						<th scope="col">방문</th>
						<th scope="col">E-mail</th>
						<th scope="col">SNS</th>
						<th scope="col">마케팅</th>
						<th scope="col">전화</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="rows" items="${StatusByMethodList}">
						<tr>
							<c:choose>
								<c:when test="${!fn:contains(auth, 'ROLE_CEO')}">
									<th scope="row" class="ta_l">${rows.TARGET_NAME}</th>
								</c:when>
								<c:when test="${!fn:contains(auth, 'ROLE_DIVISION')}">
									<th scope="row" class="ta_l">${rows.TARGET_NAME}</th>
								</c:when>
								<c:when test="${!fn:contains(auth, 'ROLE_TEAM')}">
									<th scope="row">${rows.TARGET_NAME}</th>
								</c:when>
								<c:when test="${!fn:contains(auth, 'ROLE_MEMBER')}">
									<th scope="row">${rows.TARGET_NAME}</th>
								</c:when>
								<c:otherwise>
									<th scope="row" class="ta_l">${rows.TARGET_NAME}</th>
								</c:otherwise>
							</c:choose>
							<td>${rows.TOTAL_CNT}</td>
							<td>${rows.VISIT_CNT}</td>
							<td>${rows.EMAIL_CNT}</td>
							<td>${rows.SNS_CNT}</td>
							<td>${rows.MARKETING_CNT}</td>
							<td>${rows.PHONE_CNT}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<h4>연관이슈 현황</h4>
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
						<th scope="col">부서</th>
						<th scope="col">합계</th>
						<th scope="col">진행중</th>
						<th scope="col">지연</th>
						<th scope="col">완료</th>   
					</tr>
				</thead>
				<tbody>
					<c:forEach var="rows" items="${selectPartnerRelationIssueList}">
						<tr>
							<c:choose>
								<c:when test="${!fn:contains(auth, 'ROLE_CEO')}">
									<th scope="row" class="ta_l">${rows.TARGET_NAME}</th>
								</c:when>
								<c:when test="${!fn:contains(auth, 'ROLE_DIVISION')}">
									<th scope="row" class="ta_l">${rows.TARGET_NAME}</th>
								</c:when>
								<c:when test="${!fn:contains(auth, 'ROLE_TEAM')}">
									<th scope="row">${rows.TARGET_NAME}</th>
								</c:when>
								<c:when test="${!fn:contains(auth, 'ROLE_MEMBER')}">
									<th scope="row">${rows.TARGET_NAME}</th>
								</c:when>
								<c:otherwise>
									<th scope="row" class="ta_l">${rows.TARGET_NAME}</th>
								</c:otherwise>
							</c:choose>
							<td>${rows.TOTAL_CNT}</td>
							<td>${rows.ISSUE_STATUS_1}</td>
							<td>${rows.ISSUE_STATUS_2}</td>
							<td>${rows.ISSUE_STATUS_3}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			
		</div>
		<!--// 현황 영역 -->
		
		<!-- 검색 및 리스트 -->
		<div class="cont_list_gray_bg">
		
			<div class="overflow_h mg_b10">
				<div class="fl_l">
					<h4>최근 1주일간 컨택 목록<span class="fs12">(총<span id="total_count"></span>건)</span></h4>
				</div>
				<div class="fl_r">
				<c:if test="${!fn:contains(auth, 'ROLE_MEMBER')}">
					<c:choose>
						<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
							<select id="selectTeamNameList" onchange="changeTeamNameList('Y');">
								<option value="all">회사전체</option>
								<c:forEach var="option" items="${selectTeamNameList}">
									<option value="${option.TARGET_NO}">${option.TARGET_NAME}</option>
								</c:forEach>
							</select>
						</c:when>
						<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
							<select id="selectTeamNameList" onchange="changeTeamNameList('Y');">
								<option value="all">본부전체</option>
								<c:forEach var="option" items="${selectTeamNameList}">
									<option value="${option.TARGET_NO}">${option.TARGET_NAME}</option>
								</c:forEach>
							</select>
						</c:when>
						<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
							<select id="selectTeamNameList" onchange="changeTeamNameList('Y');">
								<option value="all">팀전체</option>
								<c:forEach var="option" items="${selectTeamNameList}">
									<option value="${option.TARGET_NO}">${option.TARGET_NAME}</option>
								</c:forEach>
							</select>
						</c:when>
						<c:otherwise>
							<select id="selectTeamNameList" onchange="changeTeamNameList('Y');">
								<option value="all">회사전체</option>
								<c:forEach var="option" items="${selectTeamNameList}">
									<option value="${option.TARGET_NO}">${option.TARGET_NAME}</option>
								</c:forEach>
							</select>
						</c:otherwise>
					</c:choose>
				</c:if>
				
				
				</div>
			</div>
			
			<div class="topFunc_search_new mg_b10">
				<div class="search_pgin">
					<div class="searchArea">
						<input type="text" id="textSearchCompanyName" placeholder="제목 입력" />
						<a href="#" onClick="fncSearch(); return false;"><span class="icon_search"></span></a>
					</div>
				</div>
				<a href="#" class="btn btn-primary r3"  id="clientContactInsertForm"><span class="">컨택등록</span></a>
			</div>
			
		
		<!-- <div class="topFunc_search_new mg_b10">
			<div class="search_pgin">
				<div class="searchArea">
					<input type="text" id="textSearchCompanyName" placeholder="제목 입력" />
					<a href="#" onClick="fncSearch(); return false;"><span class="icon_search"></span></a>
				</div>
			</div>
			<a href="#" class="btn btn-primary r5" id="clientContactInsertForm"><span class="">컨택등록</span></a>
		</div> -->
	
		<!-- 
		<div class="topFunc mg_b10">
			<div class="sortArea fl_l">
				<div class="dropdown">
					<button class="dropdown-toggle r5 " type="button">
						<span id="select_text">컨텍 분류선택</span>
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu w_120 r5 off">
						<li><a href="#" onclick="fncSelectGroup('컨텍 분류선택'); return false;">== 선택 ==</a></li>
						<li><a href="#" onclick="fncSelectGroup('방문'); return false;">방문</a></li>
						<li><a href="#" onclick="fncSelectGroup('마케팅'); return false;">마케팅</a></li>
						<li><a href="#" onclick="fncSelectGroup('SNS'); return false;">SNS</a></li>
						<li><a href="#" onclick="fncSelectGroup('E-mail'); return false;">E-mail</a></li>
						<li><a href="#" onclick="fncSelectGroup('전화'); return false;">전화</a></li>
					</ul>
				</div>
			</div>

			<div class="fl_r">
				<a href="#" class="btn btn-primary r5" onclick="fncRegister(); return false;"> <span class="icon lg icon_pencil_white va_tb"></span> 컨텍등록</a>
			</div>
		</div>
		 -->

		<ul class="list_type1" id="result_list2">
		<!-- 내용이 입력됩니다. -->
			<div id="list_type_coop">
			</div>
			<div id="list_type_coop2">
			</div>
		</ul>

		<a href="#" onclick="fncShowMore(); return false;" class="btn_pg_more r2" id="btn_more">
			<span class="va_m" id="span_more">더보기 6 of 6</span>
		</a>

	</article>   
	<jsp:include page="../templates/footer.jsp" flush="true"/>
	
	<form id="frm" name="frm">
		
	</form>

    <form method="post" id="inserForm" action="">
        <input type="hidden" id="mode" name="mode" value="ins" />
    </form>    
    
    <form method="post" id="detailForm" action="">
        <input type="hidden" id="pkNo" name="pkNo" value="" />
    </form>

</div>
<div class="modal_screen"></div>

<!-- Mainly scripts -->
<script src="${pageContext.request.contextPath}/js/m/jquery-1.11.0.js"></script>
<script src="${pageContext.request.contextPath}/js/m/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/common.js"></script>

<script type="text/javascript">
	var totalCnt = 0;
	var curCnt = 0;
	var eventCategory = '';
	var searchAll = '';
	
	function fncSearch(){
		var textSearchCompanyName = $('#textSearchCompanyName').val();
		if (textSearchCompanyName == '') {
			searchAll = textSearchCompanyName;
			curCnt = 0;
			$('#list_type_coop').html('');
			fncShowMore();
		} else if (textSearchCompanyName.length < 2){
			alert('검색어는 2자 이상 입력해주세요.');
			return;
		} else {
			searchAll = textSearchCompanyName;
			curCnt = 0;
			$('#list_type_coop').html('');
			fncShowMore();
		}
	}
	
	function fncDetail(_no){
		$('#pkNo').val(_no);
		$("#detailForm").attr("action", "/partnerManagement/selectContactDetail.do");
		$('#detailForm').submit();
	}
	
	function fncGetItemHtml(_object){
		var obj_html = '';
		obj_html += '<li><a href="#" onclick="fncDetail('+_object.EVENT_ID+');return false;">';
		obj_html += '<span class="top">';
		obj_html += '<span class="icon_cata r3">'+_object.EVENT_CATEGORY+'</span>';
		obj_html += ' <span class="subject">'+_object.EVENT_SUBJECT+'</span>';
		obj_html += '</span>';
		obj_html += '<span class="bottom">';
		obj_html += '<span class="name">'+_object.COMPANY_NAME+' / '+_object.CUSTOMER_NAME+'</span>';
		obj_html += '<span class="date">컨텍일자 : '+_object.EVENT_DATE+'</span>';
		obj_html += '</span></a>';
		obj_html += '<div class="quicklink_right">';
		obj_html += '<a onclick="shortCuts(' + _object.EVENT_ID + ', 1); return false;" >정보</a> ';
		obj_html += '<a onclick="shortCuts(' + _object.EVENT_ID + ', 2); return false;" >follow</a>';
		obj_html += '</div>';
		obj_html += '</li>';
		
		return obj_html;
	}
	
	function shortCuts(pkNo, tabNo){
		location.href = "/partnerManagement/selectContactDetail.do?pkNo=" + pkNo + "&tabNo=" + tabNo;
	}
	
	function fncSelectGroup(_group){
		$('#select_text').html(_group);
		$('.dropdown-toggle').next().toggle();
		$('.caret').toggleClass('caret_up');
		
		if (_group == '컨텍 분류선택') _group = '';
		eventCategory = _group;
		curCnt = 0;
		$('#list_type_coop').html('');
		fncShowMore();
	}
	
	$(document).ready(function() {
		// 컨택등록 이벤트 등록
		$("#clientContactInsertForm").on("click", function(e) {
			//location.href = 'formClientContact.do?mode=I';
			$('#mode').val("ins");
			$("#inserForm").attr("action", "/partnerManagement/formPartnerContactInsertDetail.do");
			//console.log("mode[" +  $('#mode').val() + "]");
			$('#inserForm').submit();
			e.preventDefault();
		});
		
		$('#list_type_coop').html('');
		fncShowMore();
	});

	function fncShowMore(flag){
		var listParams = $.param({
			datatype : 'json',
			jsp : '/partnerManagement/clientContactListAjax'
		});
		
		var countParams = $.param({
			datatype : 'json'
		});
		
		var params = $.param({
			pageStart : curCnt,
			rowCount : 10,
			latelyUpdateTable : "CLIENT_EVENT_LOG",
			//검색조건
			searchPartnerContactSubject : $("#textSearchCompanyName").val(),
			selectValue: $("#selectTeamNameList").val()
		});
		if(flag != 'Y'){
			//카운트, 최근업데이트, 결과내 검색
			$.ajax({
				url : "/partnerManagement/selectPartnerContactCount.do",
				async : false,
				datatype : 'json',
				method: 'POST',
				data : params + "&" + countParams,
				success : function(data){
					//console.log(data);
					//page count
					totalCnt = data.listCount;
					$('#total_count').html(totalCnt);
				},
				complete : function(){
				}
			});
			
		}
		
		//리스트
		$.ajax({
				type : "POST",
				data : params + "&" + listParams,
				async: false,
				datatype : 'json',
				method: 'POST',
				url: "/partnerManagement/selectClientContactList.do",
				success:function(data){
					var list = data.rows;
					var list_html = '';
					for (var i = 0; i < list.length; i++){
						list_html += fncGetItemHtml(list[i]);
					}
					//$('#result_list2').html(list_html);
					/*
					if(flag == 'Y'){
						$('#list_type_coop').html('');
						$('#list_type_coop2').html('');
					}*/
					
					if(curCnt == 0){
						$('#list_type_coop').html('');
						$('#list_type_coop2').html('');
						$('#list_type_coop').html(list_html);
					}else if(curCnt >= 10){
						$('#list_type_coop2').append(list_html);
					}else{
						$('#list_type_coop').html(list_html);
					}
					
					// 카운트
					curCnt += list.length;
					
					if (parseInt(curCnt) >= parseInt(totalCnt)){
						$('#btn_more').hide();
					} else {
						var cnt_html = '더보기 '+curCnt+' of ' + totalCnt;
						$('#span_more').html(cnt_html);
						$('#btn_more').show();
					}
				}
			});
		}
	
	function fncShowMore_20170405(){
		$.ajax({
			type : "POST",
			data : {
				"rows" : 10,
				"lastrow" : curCnt,
				"sord" : "asc",
				"event_category" : eventCategory,
				"searchAll" : searchAll
			},
			async: false,
			datatype : 'json',
			url: "/partnerManagement/gridClientContact.do",
			success:function(data){
				var list = data.rows;
				var list_html = '';
				for (var i = 0; i < list.length; i++){
					list_html += fncGetItemHtml(list[i]);
				} 
				
				$('#list_type_coop').append(list_html);
				
				// 카운트
				curCnt += list.length;
				
				
				if (parseInt(curCnt) >= parseInt(totalCnt)){
					$('#btn_more').hide();
				} else {
					var cnt_html = '더보기 '+curCnt+' of ' + totalCnt;
					$('#span_more').html(cnt_html);
				}
			}
		});
	}
	
	function pageCount(){
		
	}
	
	function changeTeamNameList(flag){
		curCnt = 0;
		var countParams = $.param({
			datatype : 'json'
		});
		
		var params = $.param({
			pageStart : curCnt,
			rowCount : 10,
			latelyUpdateTable : "CLIENT_EVENT_LOG",
			//검색조건
			searchPartnerContactSubject : $("#textSearchCompanyName").val(),
			selectValue: $("#selectTeamNameList").val()
		});
	
		//카운트, 최근업데이트, 결과내 검색
		$.ajax({
			url : "/partnerManagement/selectPartnerContactCount.do",
			async : false,
			datatype : 'json',
			method: 'POST',
			data : params + "&" + countParams,
			success : function(data){
				//console.log(data);
				//page count
				totalCnt = data.listCount;
				
				$('#total_count').html(totalCnt);
				
				fncShowMore(flag);
			},
			complete : function(){
			}
		});
	}
	
</script>
</body>
</html>