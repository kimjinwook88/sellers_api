<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" pageEncoding="UTF-8" %>



<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
<title>THE Seller's</title>
<link href="${pageContext.request.contextPath}/css/m/style.css" rel="stylesheet" type="text/css">
</head>

<body class="gray_bg">

<div class="container">
	<jsp:include page="../templates/header.jsp" flush="false"/>

	<article class="landing">
		<!-- 실적 -->
		<div class="total_year_result">
             <c:choose>
                <c:when test="${fn:contains(auth, 'ROLE_CEO')}">
    				<p class="lang_ti border_no">${userInfo.MEMBER_POST}</p>
    				<!-- 부서,개인 실적 Progress -->
    				<ul class="tabmenu tabmenu_type3 mg_b10">
    					<li><a href="#" id="tab_result_1" class="result_tab active" onClick="fncSelectResult(1); return false;">1분기</a></li>
    					<li><a href="#" id="tab_result_2" class="result_tab" onClick="fncSelectResult(2); return false;">2분기</a></li>
    					<li><a href="#" id="tab_result_3" class="result_tab" onClick="fncSelectResult(3); return false;">3분기</a></li>
    					<li><a href="#" id="tab_result_4" class="result_tab" onClick="fncSelectResult(4); return false;">4분기</a></li>
    					<li><a href="#" id="tab_result_5" class="result_tab" onClick="fncSelectResult(5); return false;"><span name="spanYear"></span>년</a></li>
    				</ul>
    				<div class="result_div" id="result_div"><!-- 1분기 --></div>

                    <p class="lang_ti">회사전체</p>
                    <ul class="tabmenu_type4 mg_b10">
                        <li><a href="#" id="tab_resultCompany_1" class="resultCompany_tab active" onClick="fncSelectCompanyResult(1); return false;">1분기</a></li>
                        <li><a href="#" id="tab_resultCompany_2" class="resultCompany_tab" onClick="fncSelectCompanyResult(2); return false;">2분기</a></li>
                        <li><a href="#" id="tab_resultCompany_3" class="resultCompany_tab" onClick="fncSelectCompanyResult(3); return false;">3분기</a></li>
                        <li><a href="#" id="tab_resultCompany_4" class="resultCompany_tab" onClick="fncSelectCompanyResult(4); return false;">4분기</a></li>
                        <li><a href="#" id="tab_resultCompany_5" class="resultCompany_tab" onClick="fncSelectCompanyResult(5); return false;"><span name="spanYear"></span>년</a></li>
                    </ul>
                    <div class="resultCompany_div"><!-- 1분기 --></div>
			    </c:when>
			
                <c:otherwise>
    			    <p class="lang_ti border_no">${userInfo.HAN_NAME}</p>
        			<!-- 부서,개인 실적 Progress -->
        			<ul class="tabmenu tabmenu_type3 mg_b10">
        				<li><a href="#" id="tab_result_1" class="result_tab active" onClick="fncSelectResult(1); return false;">1분기</a></li>
        				<li><a href="#" id="tab_result_2" class="result_tab" onClick="fncSelectResult(2); return false;">2분기</a></li>
        				<li><a href="#" id="tab_result_3" class="result_tab" onClick="fncSelectResult(3); return false;">3분기</a></li>
        				<li><a href="#" id="tab_result_4" class="result_tab" onClick="fncSelectResult(4); return false;">4분기</a></li>
        				<li class="year"><a href="#" id="tab_result_5" class="result_tab" onClick="fncSelectResult(5); return false;"><span name="spanYear"></span>년</a></li>
        			</ul>
        			<div class="result_div" id="result_div"><!-- 1분기 --></div>
        			
        			<p class="lang_ti">회사전체</p>
        			<ul class="tabmenu_type4 mg_b10">
        				<li><a href="#" id="tab_resultCompany_1" class="resultCompany_tab active" onClick="fncSelectCompanyResult(1); return false;">1분기</a></li>
        				<li><a href="#" id="tab_resultCompany_2" class="resultCompany_tab" onClick="fncSelectCompanyResult(2); return false;">2분기</a></li>
        				<li><a href="#" id="tab_resultCompany_3" class="resultCompany_tab" onClick="fncSelectCompanyResult(3); return false;">3분기</a></li>
        				<li><a href="#" id="tab_resultCompany_4" class="resultCompany_tab" onClick="fncSelectCompanyResult(4); return false;">4분기</a></li>
        				<li><a href="#" id="tab_resultCompany_5" class="resultCompany_tab" onClick="fncSelectCompanyResult(5); return false;"><span name="spanYear"></span>년</a></li>
        			</ul>
        			<div class="resultCompany_div"><!-- 1분기 --></div>
                </c:otherwise>
			</c:choose>
		</div>
		<!--// 실적 -->

		<!-- 오늘의 일정 -->
		<div class="todayList">
			<div class="box_head">
				<h3 class="ta_c" id="timelineDate">2016년 11월 24일</h3>
				<a href="#" class="btn_sch btn_sch_prev" onClick="fncMoveDate('m'); return false;">이전일정</a>
				<a href="#" class="btn_sch btn_sch_next" onClick="fncMoveDate('p'); return false;">다음일정</a>
			</div>
			<span id="curDate" class="off"></span>
			<ul class="schedule_list">
			</ul>
		</div>
		<!--// 오늘의 일정 -->

		<!-- 나의 영업기회/잠재영업기회 -->
		<div class="my_act" id="div_result">
		</div>
		<!--// 나의 영업기회/잠재영업기회 -->

		<!-- 고객이슈 -->
		<div class="my_act" id="div_new_result">
		</div>
		<!--// 고객이슈 -->


	</article>   

</div>

<div class="modal_screen"></div>


<script type="text/javascript" src="${pageContext.request.contextPath}/js/m/jquery-1.11.0.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/m/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/m/moment/moment.js"></script>
<script>


	$(document).ready(function(){
		
		/*
		var token = '${userInfo.SECRET_OUT_KEY}';
		setCookie("token", token, 7);
		alert(getCookie("token"));
		*/
		
		
		//alert(token);
		//console.log("@@@@@@@@@@@" + token);	
				
		
		$.ajax({
			url : "/main/selectSalesAct.do",
			async : false,
				datatype : 'html',
				method: 'POST',
				data : {
					searchMemberId : '${userInfo.MEMBER_ID_NUM}', 
					jsp : '/main/mainSalesActAjax',
					datatype : "html"
				},
			beforeSend : function(){
				//$.ajaxLoading();
			},
			success : function(data){
				$('#div_result').html(data);
			},
			complete : function(){
			}
		});
		
		$('span[name="spanYear"]').html(moment().format('Y'));
		
		var todayDate = moment().format('YYYY-MM-DD');
		$('#curDate').html(todayDate);
		$('#timelineDate').html(moment().format('YYYY년 MM월 DD일'));

		fncGetSchedule(todayDate);
		
        fncSelectResult(moment().quarter());
		fncSelectCompanyResult(moment().quarter());
		fncSelectNewUpdate();
	});
	
	function fncGetSchedule(_date){
		$.ajax({
			url : "/main/selectTimeLine.do",
			async : false,
 			datatype : 'html',
 			method: 'POST',
 			data : {
 				searchDate : _date,
 				searchMemberId : '${userInfo.MEMBER_ID_NUM}',
 				jsp : '/main/mainTimeLineAjax',
 				datatype : "html"
 			},
			beforeSend : function(){
				//$.ajaxLoading();
			},
			success : function(data){
				$('.schedule_list').html(data);
			},
			complete : function(){
			}
		});
	}
	
	function fncMoveDate(_vector){

		var curDate = moment($('#curDate').html());
		if(_vector == 'p'){//더하기
			var nextDate = curDate.add(1,'day');
			$('#curDate').html(nextDate.format('YYYY-MM-DD'));
			$('#timelineDate').html(nextDate.format('YYYY년 MM월 DD일'));
			fncGetSchedule(nextDate.format('YYYY-MM-DD'));
		}else{ //빼기
			var prevDate = curDate.add(-1,'day');
			$('#curDate').html(prevDate.format('YYYY-MM-DD'));
			$('#timelineDate').html(prevDate.format('YYYY년 MM월 DD일'));
			fncGetSchedule(prevDate.format('YYYY-MM-DD'));
		}
	}
	
	function fncSelectResult(_quarter){
		$('.result_tab').removeClass('active');
		$('#tab_result_'+_quarter).addClass('active');
		$.ajax({
			url : "/main/selectResult.do",
			async : false,
 			datatype : 'html',
 			method: 'POST',
 			data : {
 				searchMemberId : '${userInfo.MEMBER_ID_NUM}',
 				searchQuarter : _quarter,
 				//datatype : "json"
                datatype : 'html',
                jsp : '/main/mainResult'
 			},
			beforeSend : function(){
				//$.ajaxLoading();
			},
			success : function(data){
			    //console.log(data.list[0]);
				//$('.result_div').html(data);
				$('#result_div').html(data);
			},
			complete : function(){
			}
		});
	}
	
	function fncSelectCompanyResult(_quarter){
        $('.resultCompany_tab').removeClass('active');
		$('#tab_resultCompany_'+_quarter).addClass('active');
		$.ajax({
			url : "/main/selectCompanyResult.do",
			async : false,
 			datatype : 'html',
 			method: 'POST',
 			data : {
 				searchQuarter : _quarter,
                jsp : '/main/mainCompanyResult',
 				datatype : "html"
 			},
			beforeSend : function(){
				//$.ajaxLoading();
			},
			success : function(data){
				$('.resultCompany_div').html(data);
			},
			complete : function(){
			}
		});
	}

	function fncSelectNewUpdate(){
		$.ajax({
			url : "/main/selectNewUpdate.do",
			async : false,
 			datatype : 'html',
 			method: 'POST',
 			data : {
 				searchMemberId : '${userInfo.MEMBER_ID_NUM}',
 				jsp : "/main/mainNewUpdateAjax",
 				datatype : "html"
 			},
			beforeSend : function(){
				//$.ajaxLoading();
			},
			success : function(data){
			    console.log(data)
				$('#div_new_result').html(data);
			},
			complete : function(){
			}
		});
	}

</script>
</body>
</html>