<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8" %>
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/WEB-INF/jsp/m/common/functions.jsp" %>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
<title>파트너 이슈</title>

<link href="${pageContext.request.contextPath}/css/m/style.css" rel="stylesheet" type="text/css">

</head>

<body class="gray_bg">
<jsp:include page="../templates/header.jsp" flush="true"/>
	<!-- location -->
	<div class="breadcrumb">
		<a href="#" class="home"><img src="../../../images/m/icon_home.svg" /></a>
		<div class="breadcrumb_depth1">
			<a class="active_menu">&nbsp;파트너사 협업관리</a>
		</div>
		<jsp:include page="../common/nav.jsp" flush="true"/>
	</div>

	



	<article class="list_pg">
	
		<!-- 현황 영역 -->
		<div class="top_statusarea_white_bg">
			<c:choose>
				<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
					<h4>파트너이슈 현황</h4>
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
					<h4>파트너이슈 현황</h4>
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
					<h4>팀 파트너이슈 현황</h4>
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
					<h4>나의 파트너이슈 현황</h4>
				</c:when>
				<c:otherwise>
					<h4>파트너이슈 현황</h4>
				</c:otherwise>
			</c:choose>
			<div class="status_box mg_b20">
				<div class="row">
					<ul>
						<li>
							<span class="ti fl_l">총 이슈건수</span>
							<span class="count fl_r">
								<span class="va_m fc_gray">${selectPartnerIssueStatus.TOTAL_CNT}</span>
								<span class="fs12 fc_gray">건</span>
							</span>
						</li>
						<li>
							<span class="ti fl_l">진행중</span>
							<span class="count fl_r">
								<span class="va_m">${selectPartnerIssueStatus.ISSUE_STATUS_1}</span>
								<span class="fs12">건</span>
							</span>
						</li>
					</ul>
					<ul>
						<li>
							<span class="ti fl_l">지연</span>
							<span class="count fl_r">
								<span class="va_m fc_red">${selectPartnerIssueStatus.ISSUE_STATUS_2}</span>
								<span class="fs12 fc_red">건</span>
							</span>
						</li>
						<li>
							<span class="ti fl_l">완료</span>
							<span class="count fl_r">
								<span class="va_m fc_gray">${selectPartnerIssueStatus.ISSUE_STATUS_3}</span>
								<span class="fs12 fc_gray">건</span>
							</span>
						</li>
					</ul>
				</div>
			</div>
			
			<c:if test="${!fn:contains(auth, 'ROLE_MEMBER')}">
			<c:choose>
				<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
					<h4>부서별 접수 및 처리현황</h4>
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
					<h4>부서별 접수 및 처리현황</h4>
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
					<h4>영업대표별 접수 및 처리현황</h4>
				</c:when>
				<c:otherwise>
					<h4>부서별 접수 및 처리현황</h4>
				</c:otherwise>
			</c:choose>
			<table class="status_table mg_b20" summary="">
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
							<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
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
						<th scope="col">접수</th>
						<th scope="col">진행중</th>
						<th scope="col">지연</th>
						<th scope="col">완료</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="rows" items="${selectPartnerRelationIssueList}">
						<tr>
							<c:choose>
								<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
									<th scope="row" class="ta_l">${rows.TARGET_NAME}</th>
								</c:when>
								<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
									<th scope="row" class="ta_l">${rows.TARGET_NAME}</th>
								</c:when>
								<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
									<th scope="row">${rows.TARGET_NAME}</th>
								</c:when>
								<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
									<th scope="row">${rows.TARGET_NAME}</th>
								</c:when>
								<c:otherwise>
									<th scope="row" class="ta_l">${rows.TARGET_NAME}</th>
								</c:otherwise>
							</c:choose>
							<td>${rows.TOTAL_CNT}</td>
							<td class="fc_blue">${rows.ISSUE_STATUS_1}</td>
							<td class="fc_red">${rows.ISSUE_STATUS_2}</td>
							<td>${rows.ISSUE_STATUS_3}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			</c:if>
			
			<c:choose>
				<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
					<h4>부서별 이슈 종류 현황</h4>
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
					<h4>부서별 이슈 종류 현황</h4>
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
					<h4>영업대표별 이슈 종류 현황</h4>
				</c:when>
				<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
					<h4>이슈 종류 현황</h4>
				</c:when>
				<c:otherwise>
					<h4>부서별 이슈 종류 현황</h4>
				</c:otherwise>
			</c:choose>
			<table class="status_table" summary="">
				<caption></caption>
				<colgroup>
					<col width=""/>
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
							<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
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
						<th scope="col">접수</th>
						<th scope="col">제품</th>
						<th scope="col">서비스</th>
						<th scope="col">지원</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="rows" items="${departmentStatus}">
						<tr>
						<c:choose>
							<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
								<th scope="row" class="ta_l">${rows.TARGET_NAME}</th>
							</c:when>
							<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
								<th scope="row" class="ta_l">${rows.TARGET_NAME}</th>
							</c:when>
							<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
								<th scope="row">${rows.TARGET_NAME}</th>
							</c:when>
							<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
								<th scope="row">${rows.TARGET_NAME}</th>
							</c:when>
							<c:otherwise>
								<th scope="row" class="ta_l">${rows.TARGET_NAME}</th>
							</c:otherwise>
						</c:choose>
							<td>${rows.TOTAL_CNT}</td>
							<td>${rows.PRODUCT_CNT}</td>
							<td>${rows.SERVICE_CNT}</td>
							<td>${rows.SUPPORT_CNT}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!--// 현황 영역 -->
		
		<!-- 검색 및 리스트 -->
		<div class="cont_list_gray_bg">
			<div class="topFunc mg_b10">
				<div class="sortArea fl_l">
					<c:if test="${!fn:contains(auth, 'ROLE_MEMBER')}">
						<c:choose>
							<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
								<select id="selectSatisfactionCategory" onChange="changeCategory(this.value);">
									<option value="all">회사전체</option>
									<c:forEach var="rows" items="${selectTeamNameList}">
										<option value="${rows.TARGET_NO}">${rows.TARGET_NAME}</option>
									</c:forEach>
								</select>
							</c:when>
							
							<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
								<select id="selectSatisfactionCategory" onChange="changeCategory(this.value);">
									<option value="all">본부전체</option>
									<c:forEach var="rows" items="${selectTeamNameList}">
										<option value="${rows.TARGET_NO}">${rows.TARGET_NAME}</option>
									</c:forEach>
								</select>
							</c:when>
							
							<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
								<select id="selectSatisfactionCategory" onChange="changeCategory(this.value);">
									<option value="all">팀전체</option>
									<c:forEach var="rows" items="${selectTeamNameList}">
										<option value="${rows.TARGET_NO}">${rows.TARGET_NAME}</option>
									</c:forEach>
								</select>
							</c:when>
							
							<c:otherwise>
								<select id="selectSatisfactionCategory" onChange="changeCategory(this.value);">
									<option value="all">회사전체</option>
									<c:forEach var="rows" items="${selectTeamNameList}">
										<option value="${rows.TARGET_NO}">${rows.TARGET_NAME}</option>
									</c:forEach>
								</select>
							</c:otherwise>
						</c:choose>
					</c:if>
					
					<c:if test="${!fn:contains(auth, 'ROLE_MEMBER')}">
					<select id="selectProgressCategory" onChange="cheageProgressCategory(this.value);">
						<option value="all" selected>전체</option>
						<option value="ing">진행</option>
						<option value="delay">지연</option>
						<option value="close">완료</option>
					</select>
					</c:if>
				</div>
				
				<div class="fl_r">
					<a href="#" class="btn btn-primary r3" id="clientIssueInsertForm"><span class="">이슈등록</span></a>
				</div>
			</div>
		
		

		<!-- <div class="topFunc mg_b10">
			<div class="sortArea fl_l">
				<div class="dropdown">
					<button class="dropdown-toggle r5 " type="button">
						<span id="select_group_text">이슈 종류 선택</span>
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu w_120 r5 off" id="changeIssue">
						<li><a href="javascript:void(0); return false;" onclick="changeDropDown('서비스'); return false;">서비스</a></li>
						<li><a href="javascript:void(0); return false;" onclick="changeDropDown('지원'); return false;">지원</a></li>
						<li><a href="javascript:void(0); return false;" onclick="changeDropDown('제품'); return false;">제품</a></li>
						<li href="javascript:void(0); return false;" onclick="fncChangeCategory('서비스'); return false;">서비스</a></li>
						<li href="javascript:void(0); return false;" onclick="fncChangeCategory('지원'); return false;">지원</a></li>
						<li href="javascript:void(0); return false;" onclick="fncChangeCategory('제품'); return false;">제품</a></li>
					</ul>
				</div>
			</div> 

			<div class="fl_r">
				<a href="#" class="btn md primary_bg fc_white r5" id="clientIssueInsertForm">
					<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> 이슈등록 
				</a>
			</div>
		</div>-->
		
		<!-- 적용할 드롭다운 -->
		
		<%-- <div class="topFunc mg_b10">
			<div class="sortArea">
				<div class="dropdown">
					<button class="dropdown-toggle r5 " type="button">
					    <span id="select_text">${map.detailCategory}</span>  
						<span class="caret"></span> 
					</button>
					<ul class="dropdown-menu w_100 r5 off">
					<c:choose>
						<c:when test="${fn:length(IssueSearchDetailGroup) > 0}">
							<c:forEach items="${issueSerachDetailGroup}" var="category">
								<li><a href="#" onclick="fncChangeCategory('${category.ISSUE_CATEGORY}'); return false;">${category.ISSUE_CATEGORY}</a></li>
							</c:forEach>
						</c:when>
					</c:choose>
					</ul>
				</div>
			</div>
		</div> --%>
		

		<ul class="list_type1" id="result_list2">
		<!-- 내용이 입력됩니다. -->
			<div id="list_type_coop">
			</div>
			<div id="list_type_coop2">
			</div>
			<div id="list_type_coop3">
			</div>
		</ul>

		<a href="#" onclick="fncShowMore(); return false;" class="btn_pg_more r2" id="btn_more">
			<span class="icon icon_arrow_down md va_m"></span> <span class="va_m" id="span_more">더보기 6 of 6</span>
		</a>
	
	</div>
	<!--// 검색 및 리스트 -->

	</article>   
	<jsp:include page="../templates/footer.jsp" flush="true"/>
	
	<form id="frm" name="frm">
		
	</form>

    <form method="post" id="detailForm" action="">
        <input type="hidden" id="pkNo" name="pkNo" value="" />
    </form>
    
    <form method="post" id="inserForm" action="">
        <input type="hidden" id="mode" name="mode" value="ins" />
    </form>     
    
</div>
<div class="modal_screen"></div>
<!-- Mainly scripts -->
<script src="${pageContext.request.contextPath}/js/m/jquery-1.11.0.js"></script>
<script src="${pageContext.request.contextPath}/js/m/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/common.js"></script>

<script type="text/javascript">
	var totalCnt = 0;
	var rowCount = 10;
	var pkArray = '';
	var curCnt = 0;
	var curCategory = '';
	
	var params;
	
	function changeCategory(_cate){
		curCategory = _cate;
		//$('div.dropdown button').html(_cate);
		//$('.dropdown-menu').hide();
		fncGetTotalCount(curCategory);
	}
	
	function cheageProgressCategory(value){
		
		var departmentValue = $('#selectSatisfactionCategory').val();
		var ProgressValue = value;
		
		fncGetTotalCount(departmentValue, ProgressValue);
		
	}
	
	function fncDetail(_no){
        $('#pkNo').val(_no);
        $("#detailForm").attr("action", "/partnerManagement/selectPartnerIssueDetail.do");
        $('#detailForm').submit();
	}
	/*
    function fncDetail_20170414(_no){
        location.href = 'modalClientIssue.do?issueId='+_no;
    }
*/
    
    /*
    function fncRegister(){
		location.href = 'formClientIssue.do?mode=I';
	}
    */
	
	function fncChangeCategory(_cate){
		$('div.dropdown button').html(_cate);
		$('.dropdown-menu').hide();
		
		$.ajax({
			type : "POST",
			data : {
				"searchCategory" : _cate,
				"resultInSearch" : 'N',
				"menuFlag" : _cate,
				latelyUpdateTable : "PARTNER_ISSUE_LOG"
			},
			async: false,
			url : "/partnerManagement/partnerIssueListCount.do",
			success:function(data){
				//totalCnt = data.totalCnt;
				listCount = data.listCount;
				curCnt = 0;
				
				//pkArray = data.searchPKArray;

				$('#btn_more').hide();
				
				if(listCount > 0) {
					
					if(listCount > 10)
						$('#btn_more').show();
					
						$('#result_list2').html('');
						fncShowMore(_cate);
				}
				else {
					var obj_html = '';
					obj_html += '<li>';
					obj_html += '<span class="top"><span class="icon_cata r2"></span> ';
					obj_html += '<span class="subject">No Data</span></span>';
					obj_html += '<span class="bottom"><span class="name"></span>';
					obj_html += '<span class="date fs13 fc_gray_light"></span></span>';		
					obj_html += '</li>';
					
					$('#result_list2').html(obj_html);
				}
			}
		});
		
	}
	
	//obj_html += '<span class="issue_status">';
	//obj_html += '<span class="box_left"><span class="icon_cata r2">'+_object.ISSUE_CATEGORY+'</span></span>';
	//obj_html += '<span class="box_right"><span class="issue_status_current statusColor_'+_object.ISSUE_STATUS+' r2"> '+_object.ISSUE_STATUS_TEXT+'</span></span>';
	function fncGetItemHtml(_object){
		
		var obj_html = '';
			obj_html += '<li id="issue_'+_object.ISSUE_CATEGORY+'" class="issue_hide"><a href="#" onclick="fncDetail('+_object.ISSUE_ID+');return false;">';
			obj_html += '<span class="top">';
			obj_html += '<span class="cata_custom  r3">'+_object.COMPANY_NAME+'</span> ';
			obj_html += '<span class="subject">'+_object.ISSUE_SUBJECT+'</span>';
			obj_html += '</span>';
			obj_html += '<span class="bottom">';
			obj_html += '<span class="name">'+_object.CUSTOMER_NAME+'  외 1명 / '+_object.SALES_REPRESENTIVE_NAME+' </span>'; //커스터머 직급 : '+_object.POSITION+' // 책임자 직급 : '+_object.POSITION_STATUS+'
			obj_html += '<span class="date">발생일자 : '+_object.ISSUE_DATE+'</span>';
			obj_html += '</span>';
			obj_html += '</a>';
			
			obj_html += '<div class="quicklink_right">';
			obj_html += '<a onclick="shortCuts(' + _object.ISSUE_ID + ', 1); return false;" >정보</a> ';
			obj_html += '<a onclick="shortCuts(' + _object.ISSUE_ID + ', 2); return false;" >Plan</a>';
			obj_html += '</div>';
			
			//STATUS
			if(_object.ISSUE_STATUS_TEST == '#f20056'){ // 레드
				obj_html += '<div class="status_current statusColor_red"></div>';
			}else if(_object.ISSUE_STATUS_TEXT == '#ffc000'){ // 노랑
				obj_html += '<div class="status_current statusColor_yellow"></div>';
			}else if(_object.ISSUE_STATUS_TEXT == '#1ab394'){ // 그린
				obj_html += '<div class="status_current statusColor_green"></div>';
			}
			
			obj_html += '</li>';
		return obj_html;
	}
	
	
	function shortCuts(pkNo, tabNo){
		location.href = "/partnerManagement/selectPartnerIssueDetail.do?pkNo=" + pkNo + "&tabNo=" + tabNo;
	}
	
	$(document).ready(function() {
		//fncChangeCategory();
		if ('${issue_id}' != ''){
			location.href="/salesActive/modalClientIssue.do?issueId=${issue_id}";
		}
		
		fncGetTotalCount();
		fncShowMore();

		// 컨택등록 이벤트 등록
		$("#clientIssueInsertForm").on("click", function(e) {
			$('#mode').val("ins");
			$("#inserForm").attr("action", "/partnerManagement/formPartnerIssueInsertDetail.do");
			console.log("mode[" +  $('#mode').val() + "]");
			$('#inserForm').submit();
			e.preventDefault();
		});
	});
	
	function fncGetTotalCount(curCategory2, ProgressValue) {
		
		if(curCategory2 == null || curCategory2 == ""){
			curCategory = "all";
			curCnt = 0;
		}else{
			curCategory = curCategory2;
		}
		
        params = $.param({
            pageStart : curCnt,
            rowCount : rowCount,
            latelyUpdateTable : "PARTNER_ISSUE_LOG",
            curCategory : curCategory,
            ProgressValue : ProgressValue
        });
        
        /* selectIssueCount */
        
        //카운트, 최근업데이트, 결과내 검색
        $.ajax({
            url : "/partnerManagement/partnerIssueListCount.do",
            async : false,
            datatype : 'json',
            method: 'POST',
            data : params,
            success : function(data){
                //page count
                totalCnt = data.listCount;
                
                if(curCategory != null){
                	curCnt = 0;
                	if(ProgressValue != null){
                		curCnt = 0;
                		var statusValue = "Y";
                		fncShowMore(curCategory2, ProgressValue, statusValue);
                	}else{
                		curCnt = 0;
                		fncShowMore(curCategory2);
                	}
                	
                }
            },
        });	    
	}

	
	function fncShowMore(_cate, ProgressValue, statusValue){
		
		var category = _cate;
		var Progress = ProgressValue;
		
		if(category == '' || category == null){
			curCnt = 0;
			category = 'all';
		}
		
		if(Progress == '' || Progress == null){
			Progress = 'all';
		}
		
		params = $.param({
			pageStart : curCnt,
			rowCount : rowCount,
			numberPagingUseYn : "Y",
			latelyUpdateTable : "PARTNER_ISSUE_LOG",
			searchCategory : category,
			searchProgress : Progress
		});

        $.ajax({
            type : "POST",
            data : params,
            async: false,
            url: "/partnerManagement/selectPartnerIssueList.do",
            success:function(data){
                var list = data.rows;
                var list_html = '';
				for (var i = 0; i < list.length; i++){
					list_html += fncGetItemHtml(list[i]);
				}
				
                
              
                //$('#result_list2').append(list_html);
				// 카운트
                curCnt += list.length;
				
                
				if(statusValue == 'Y'){
					$('#list_type_coop').html('');
					$('#list_type_coop2').html('');
				}
				
				if(curCnt == 0){
					$('#list_type_coop').html('');
					$('#list_type_coop2').html('');
					$('#list_type_coop3').html(list_html);
				}else if(curCnt >= 10){
					$('#list_type_coop2').append(list_html);
				}else{
					$('#list_type_coop').html(list_html);
				}
				
                
                
                if (parseInt(curCnt) >= parseInt(totalCnt)){
                    $('#btn_more').hide();
                } else {
                    var cnt_html = '더보기 '+curCnt+' of ' + totalCnt;
                    $('#span_more').html(cnt_html);
                }
            }
        });
    }
	
	function changeDropDown(value){
		$('.issue_hide').hide();
		$('#issue_'+value).show();
		$('#changeIssue').hide();
	}
	
	function pageCount(){
		$('div.dropdown button').html(_cate);
		$('.dropdown-menu').hide();
		
		$.ajax({
			type : "POST",
			data : {
				"searchCategory" : _cate,
				"resultInSearch" : 'N',
				"menuFlag" : _cate,
				latelyUpdateTable : "PARTNER_ISSUE_LOG"
			},
			async: false,
			url: "/clientSatisfaction/selectIssueListCount.do",
			success:function(data){
				//totalCnt = data.totalCnt;
				listCount = data.listCount;
				curCnt = 0;
				
				//pkArray = data.searchPKArray;

				$('#btn_more').hide();
				
				if(listCount > 0) {
					
					if(listCount > 10)
						$('#btn_more').show();
					
					$('#result_list2').html('');
					fncShowMore(_cate);
				}
				else {
					var obj_html = '';
					obj_html += '<li>';
					obj_html += '<span class="top"><span class="icon_cata r2"></span> ';
					obj_html += '<span class="subject">No Data</span></span>';
					obj_html += '<span class="bottom"><span class="name"></span>';
					obj_html += '<span class="date fs13 fc_gray_light"></span></span>';		
					obj_html += '</li>';
					
					$('#result_list2').html(obj_html);
				}
			}
		});
	}

</script>
</body>
</html>