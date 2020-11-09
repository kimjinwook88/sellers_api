<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<title>전략프로젝트</title>
<jsp:include page="/WEB-INF/jsp/m/common/top.jsp"/>
<%@ include file="/WEB-INF/jsp/m/common/functions.jsp" %> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
<title>전략프로젝트</title>

<link href="${pageContext.request.contextPath}/css/m/style.css" rel="stylesheet" type="text/css">

</head>

<body class="gray_bg">
<jsp:include page="../templates/header.jsp" flush="true"/>

<!-- location -->
<%-- <div class="location">
	<a href="/main/index.do" class="home"><img src="${pageContext.request.contextPath}/images/m/icon_home.svg"/></a>
	<img src="${pageContext.request.contextPath}/images/m/icon_arrow_gray.svg"/>
	<span>고객영업활동</span> 
	<img src="${pageContext.request.contextPath}/images/m/icon_arrow_gray.svg"/>
	<jsp:include page="../common/nav.jsp" flush="true"/>
</div> --%>
<!-- location -->
<jsp:include page="../common/nav.jsp" flush="true"/>

<div class="container_pg_list">
	<article class="list_pg">
	<!-- 리스트 -->
	<div class="cont_list_gray_bg">
		<div class="topFunc mg_b10">
			<div class="sortArea">
				<ul class="tabmenu tabmenu_type2 mg_b20">
			        <li style="width: 209.333px;"><a href="#" id="tab_1" onclick="fncChangeCategory('1',this);return false;" class="active">신규프로젝트</a></li>
			        <li style="width: 209.333px;"><a href="#" id="tab_2" onclick="fncChangeCategory('2',this);return false;">선투자프로젝트</a></li>
			        <li style="width: 209.333px;"><a href="#" id="tab_3" onclick="fncChangeCategory('3',this);return false;">전략프로젝트</a></li>
			    </ul>
			</div>
		</div>
		
		<!-- <div class="biz_str_sum">
			<ul>
				<li>
					<a href="#" class="r3 status_sum_box statusColor_red" id="R_count"></a>
				</li>
				<li>
					<a href="#" class="r3 status_sum_box statusColor_yellow" id="Y_count"></a>
				</li>
				<li>
					<a href="#" class="r3 status_sum_box statusColor_green" id="G_count"></a>
				</li>
			</ul>
		</div> -->
		
		<ul class="list_type1" id="result_list">
		<!-- 내용이 입력됩니다. -->	
		</ul>

		<a href="#" onclick="fncShowMore(); return false;" class="btn_pg_more r2" id="btn_more">
			<span class="icon icon_arrow_down md va_m"></span> <span class="va_m" id="span_more">더보기 6 of 6</span>
		</a>
	</div>
	</article>
</div>
<script src="${pageContext.request.contextPath}/js/m/jquery-1.11.0.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$('.dropdown-toggle').on("click",function(e){
			$('.dropdown-toggle').next().toggle();
		});
		fncChangeCategory('${map.searchCategory}');
		//statusCount();
	});

	var totalCnt = '${totalCnt}';
	var pkArray = '';
	var curCnt = 0;
	var searchPKArray = "";
	var curCategory = '${map.searchCategory}';
	var v_page = 0;
	
	function fncDetail(_no, cate){
		location.href = 'modalProjectPlanInfo.do?searchCategory='+cate+'&project_id='+_no;
		//curCategory
	}
	
	function fncChangeCategory(_cate, obj){
		$(".tabmenu.tabmenu_type2.mg_b20 a").removeClass("active");
		
		if(typeof obj != "undefined"){
			$(obj).addClass("active");
		}else{
			$(".tabmenu.tabmenu_type2.mg_b20 a").eq(0).addClass("active");
		}
		
		v_page = 0;
		var v_rowCount = 10;
		var v_pageStart = v_page * v_rowCount;
		
		curCategory = _cate;
		var params = $.param({
			datatype : 'json',
			pageStart : curCnt,
			rowCount : v_rowCount,
			latelyUpdateTable : 'BIZ_PROJECT_PLAN',
			numberPagingUseYn : 'Y',
			listCount : "",
			searchPKArray : pkArray,
			searchCategory : _cate, 
		});
		$.ajax({
			type : "POST",
			data : params,
			async: false,
			url: "/bizStrategy/selectProjectPlanCount.do",
			success:function(data){
				totalCnt = data.listCount;
				curCnt = 0;
				pkArray = data.searchPKArray;
				$('#result_list').html('');
				$('#btn_more').show();
				fncShowMore();
				//statusCount();
			}
		});
	}

	function fncGetItemHtml(_object){
		var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
		var obj_html = '';
		
		obj_html += '<li id="st_'+_object.STATUS+'"><a href="#" onclick="fncDetail('+_object.PROJECT_ID+',\''+_object.Category+'\');return false;">';
		obj_html += '<span class="top">';
		obj_html += '<span class="subject">'+_object.SUBJECT+'</span> ';
		obj_html += '<span class="sales_man">/ '+_object.SALES_OWNER+'</span>';
		obj_html += '</span>';
		
		obj_html += '<span class="bottom">';
		obj_html += '<span class="keymilestones">';
		
		
		//마일스톤
		if (_object.KEY_MILESTONE_1 != null && _object.KEY_MILESTONE_1 != ''){
			obj_html += '<span class="step">';
			
			var dueDate = (_object.MS_DUE_DATE_1 .replaceAll('-','')).trim();
			var closeDate = (_object.MS_CLOSE_DATE_1.replaceAll('-','')).trim();
			
			if((dueDate >= nowDate) && closeDate == ''){
				obj_html +=  '<span class="status_circle statusColor_red"></span>';
			}else if(dueDate < nowDate && closeDate == ''){
				obj_html +=  '<span class="status_circle statusColor_yellow"></span>';
			}else if(closeDate != '' && closeDate != null){
				obj_html +=  '<span class="status_circle statusColor_green"></span>';
			}else{
				obj_html += "";
			} 
			
			var MS_DUE_DATE_1 = (typeof _object.MS_DUE_DATE_1 == 'undefined')?'':_object.MS_DUE_DATE_1;
			obj_html += '<span class="">['+MS_DUE_DATE_1+'] '+_object.KEY_MILESTONE_1+' </span>';
			obj_html += '</span>';
		}

		if (_object.KEY_MILESTONE_2 != null && _object.KEY_MILESTONE_2 != ''){
			obj_html += '<span class="step">';
			
			var dueDate = (_object.MS_DUE_DATE_2 .replaceAll('-','')).trim();
			var closeDate = (_object.MS_CLOSE_DATE_2.replaceAll('-','')).trim();
			
			if((dueDate >= nowDate) && closeDate == ''){
				obj_html +=  '<span class="status_circle statusColor_red"></span>';
			}else if(dueDate < nowDate && closeDate == ''){
				obj_html +=  '<span class="status_circle statusColor_yellow"></span>';
			}else if(closeDate != '' && closeDate != null){
				obj_html +=  '<span class="status_circle statusColor_green"></span>';
			}else{
				obj_html += "";
			} 
			
			var MS_DUE_DATE_2 = (typeof _object.MS_DUE_DATE_2 == 'undefined')?'':_object.MS_DUE_DATE_2;
			obj_html += '<span class="">['+MS_DUE_DATE_2+'] '+_object.KEY_MILESTONE_2+' </span>';
			obj_html += '</span>';
		}
		
		if (_object.KEY_MILESTONE_3 != null && _object.KEY_MILESTONE_3 != ''){
			obj_html += '<span class="step">';
			
			var dueDate = (_object.MS_DUE_DATE_3 .replaceAll('-','')).trim();
			var closeDate = (_object.MS_CLOSE_DATE_3.replaceAll('-','')).trim();
			
			if((dueDate >= nowDate) && closeDate == ''){
				obj_html +=  '<span class="status_circle statusColor_yellow"></span>';
			}else if(dueDate < nowDate && closeDate == ''){
				obj_html +=  '<span class="status_circle statusColor_red"></span>';
			}else if(closeDate != '' && closeDate != null){
				obj_html +=  '<span class="status_circle statusColor_green"></span>';
			}else{
				obj_html += "";
			} 
			
			var MS_DUE_DATE_3 = (typeof _object.MS_DUE_DATE_3 == 'undefined')?'':_object.MS_DUE_DATE_3;
			obj_html += '<span class="">['+MS_DUE_DATE_3+'] '+_object.KEY_MILESTONE_3+' </span>';
			obj_html += '</span>';
		}
		
		obj_html += '</span></span></a>';
		
		obj_html +='<div class="quicklink ql_4ea">';
		obj_html +='<a onclick="shortCuts(' + _object.PROJECT_ID + ', 1); return false;">정보</a> ';
		obj_html +='<a onclick="shortCuts(' + _object.PROJECT_ID + ', 2); return false;">매출</a> ';
		obj_html +='<a onclick="shortCuts(' + _object.PROJECT_ID + ', 3); return false;">마일스톤</a> ';
		obj_html +='<a onclick="shortCuts(' + _object.PROJECT_ID + ', 4); return false;">이슈</a>';
		obj_html +='</div>';
		
		//obj_html +=  '<div class="status_current statusColor_G"></div>';
		
		obj_html += '</li>';
		
		return obj_html;
	}
	
	function shortCuts(pkNo, tabNo){
		location.href = "/bizStrategy/modalProjectPlanInfo.do?project_id=" + pkNo + "&pkNo=" + pkNo + "&tabNo=" + tabNo;
	}

	function fncShowMore() {
		//공통 파라미터
		var v_rowCount = 10;
		var v_pageStart = v_page * v_rowCount;
		
		var params = $.param({
			datatype : 'json',
			pageStart : v_pageStart,
			rowCount : v_rowCount,
			latelyUpdateTable : 'BIZ_PROJECT_PLAN',
			numberPagingUseYn : 'Y',
			listCount : "",
			searchPKArray : searchPKArray,
			searchCategory :curCategory
		});
		
		//카운트, 최근업데이트, 결과내 검색
		$.ajax({
			url : "/bizStrategy/selectProjectPlanCount.do",
			async : false,
 			datatype : 'json',
 			method: 'POST',
			data : params,
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
				//$.ajaxLoading();
			},
			success : function(data){
				//page count
				//page.totalCount = data.listCount;
				//curCnt = data.listCount;
				//최근 업데이트
				/*
				if(!isEmpty(data.latelyUpdate)){
					$("#LATELY_UPDATE_DATE").html(data.latelyUpdate);
				}
				//결과내 검색
				searchPKArray = data.searchPKArray;
				*/
			},
			complete : function(){
				//$.ajaxLoadingHide();
			}
		});
		
		//리스트
		$.ajax({
			url : "/bizStrategy/selectProjectPlanList.do",
			async : false,
 			//datatype : 'html',
 			datatype : 'json',
 			method: 'POST',
			data : params,
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
				//$.ajaxLoading();
			},
			success : function(data){
				//$('tbody#row').append(data);
				
				var list = data.rows;
				var list_html = '';
				for (var i = 0; i < list.length; i++){
					list_html += fncGetItemHtml(list[i]);
				} 
				
				// 카운트
				curCnt += list.length;
				
				v_page++;
				v_pageStart = v_page * v_rowCount;
				
				if (parseInt(v_pageStart) >= parseInt(totalCnt)){
					$('#btn_more').hide();
				} else {
					var cnt_html = '더보기 '+curCnt+' of ' + totalCnt;
					$('#span_more').html(cnt_html);
					$('#btn_more').show();
				}
				
				$('#result_list').append(list_html);
				
			},
			complete : function(){
				//$.ajaxLoadingHide();
			}
		});
	}

	function statusCount(){
	
		var R_count = $('#st_red').length;
		if(R_count == null){
			R_count == '0';
		}
		var Y_count;
		Y_count = $('#st_yellow').length;
		if(Y_count == null){
			Y_count == '0';
		}
		var G_count = $('#st_green').length;
		if(G_count == null || G_count == ''){
			G_count == '0';
		}
		
		$("#G_count").html(G_count);
		$("#Y_count").html(Y_count);
		$("#R_count").html(R_count);
	
	}
	
</script>
</body>
</html>
<jsp:include page="/WEB-INF/jsp/m/common/bottom.jsp"/>