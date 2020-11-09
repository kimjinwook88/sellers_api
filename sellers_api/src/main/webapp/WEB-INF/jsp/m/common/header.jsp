<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="org.springframework.web.util.UrlPathHelper"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="org.springframework.web.util.UrlPathHelper"%>

<%
UrlPathHelper urlPathHelper = new UrlPathHelper();
String originalURL = urlPathHelper.getOriginatingRequestUri(request);

Calendar c = Calendar.getInstance();
SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
String todayDate = transFormat.format(c.getTime());
todayDate = transFormat.format(c.getTime());

String curDate = request.getParameter("curDate");

%>
<%
if(originalURL.indexOf("/calendar/") == -1) {
%>
	<header class="header primary_bg">
		<hgroup>
			<a href="/main/index.do" >
				<h1 class="logo">THE Seller's</h1>
			</a>	
		</hgroup>
<%
}
else {
%>
    <header class="header primary_bg">
        <hgroup>
            <a href="/main/index.do" >
				<h1 class="logo">THE Seller's</h1>
			</a>	
        </hgroup>
<%
}
%>
		<a href="#" class="btn_sideMenu">
			<span></span>
			<span></span>
			<span></span>
		</a>
		
		<a href="#" class="btn_todaycheck" onclick="moing();">
		오늘 체크할 일
	</a>
		
		<span class="alarm_count pos_h r10" style="display:none;">0</span> <!-- 확인하지 않은 알림 개수 -->
		
<!-- 		<a href="#" class="btn_search">
			<span class="icon_search"></span>
		</a> -->
		<!-- 사이드메뉴 시작 -->
		<div class="sidemenu off">
			<!-- 사용자 확인 -->
			<div class="top">
				<div class="user_photo r60 mg_b10">
					<img src="${pageContext.request.contextPath}/images/m/icon_character.svg" />
				</div>
				<p class="fc_white user_info">
					<span>${userInfo.HAN_NAME}님</span><br/>좋은하루 되세요.
				</p>
	
				<a href="#" class="btn_sidemenu_close">
					<img src="${pageContext.request.contextPath}/images/m/icon_sidemenu_close.svg" alt="사이드 메뉴 닫기"/>
				</a>
			</div>
			<div class="side_gnb">
				<!-- <span class="alarm_count pos_side r10" style="display:none;">0</span>  --><!-- 확인하지 않은 알림 개수 -->
			
				<!-- <a href="#" class="sideTab tab1 active">메뉴</a> -->
					<ul class="gnb">
						<li>
							<a href="#" class="btn_one">
	                            <span class="icon md icon_custominfo va_m"></span> 고객사 및 고객개인정보 
	                            <img src="${pageContext.request.contextPath}/images/m/icon_gnb_arrow_left.svg"/> 
	                            <img src="${pageContext.request.contextPath}/images/m/icon_gnb_arrow_down.svg" class="off"/>
	                        </a>
							<div class="sub off">
	                            <!-- 
	                            <a href="/clientManagement/listClientCompanyInfoView.do">고객사정보</a>
	                            <a href="/clientManagement/listClientIndividualInfoList.do">고객개인정보</a>
	                             -->
	                            <a href="/clientManagement/viewClientIndividualInfoGate.do">고객개인정보</a>
	                            <a href="/clientManagement/viewClientCompanyInfoGate.do">고객사정보</a>
							</div>
						</li>
						<li>
							<a href="#" class="btn_one">
	                            <span class="icon md icon_salesAct va_m"></span> 고객영업활동
	                            <img src="${pageContext.request.contextPath}/images/m/icon_gnb_arrow_left.svg"/> 
	                            <img src="${pageContext.request.contextPath}/images/m/icon_gnb_arrow_down.svg" class="off"/>
	                        </a>
							<div class="sub off">
	                            <!-- 
	                            <a href="/salesActive/listClientContact.do">고객컨텍내용</a>
	                            <a href="/salesActive/listOpportunity.do">영업기회</a>
	                            <a href="/salesActive/listHiddenOpportunity.do">잠재영업기회</a>
	                             -->
	                            <a href="/clientSalesActive/viewClientContactList.do">고객컨텍내용</a>
	                            <a href="/clientSalesActive/viewOpportunityList.do">영업기회</a>
	                            <a href="/clientSalesActive/viewHiddenOpportunityList.do">잠재영업기회</a>
							</div>
						</li>
						<li>
							<a href="#" class="btn_one">
	                            <span class="icon md icon_cutomgood va_m"></span> 고객만족
	                            <img src="${pageContext.request.contextPath}/images/m/icon_gnb_arrow_left.svg"/>
	                            <img src="${pageContext.request.contextPath}/images/m/icon_gnb_arrow_down.svg" class="off"/>
	                        </a>
							<div class="sub off">
	                            <!-- 
	                            <a href="/salesActive/listClientIssue.do">고객이슈</a>
	                            <a href="/salesActive/listClientSatisfaction.do">고객만족도</a>
	                             -->
	                            <a href="/clientSatisfaction/viewClientIssueList.do">고객이슈</a>
	                            <a href="/clientSatisfaction/viewClientSatisfactionList.do">고객만족도</a>
							</div>
						</li>
						<%-- <li>
							<a href="#" class="btn_one">
	                            <span class="icon md icon_partner va_m"></span> 파트너사 협업관리 
	                            <img src="${pageContext.request.contextPath}/images/m/icon_gnb_arrow_left.svg"/> 
	                            <img src="${pageContext.request.contextPath}/images/m/icon_gnb_arrow_down.svg" class="off"/>
	                        </a>
							<div class="sub off">
								<a href="/partnerManagement/viewPartnerSalesLinkage.do">파트너사 협업</a>
								<!-- 
								<a href="/partnerManagement/listPartnerCompanyInfo.do">파트너사정보</a>
								<a href="/partnerManagement/listPartnerIndividualInfo.do">파트너사개인정보</a>
								 -->
								<a href="/partnerManagement/viewPartnerCompanyInfoGate.do">파트너사정보</a>
								<a href="/partnerManagement/viewPartnerIndividualInfoGate.do">파트너사개인정보</a>
								<a href="/partnerManagement/viewPartnerContactList.do">파트너사컨택</a>
								<a href="/partnerManagement/viewPartnerIssueList.do">파트너사이슈</a>
							</div>
						</li>. --%>
						<li>
							<a href="#" class="btn_one"><span class="icon md icon_paper va_m"></span> 사업전략 
	                            <img src="${pageContext.request.contextPath}/images/m/icon_gnb_arrow_left.svg"/> 
	                            <img src="${pageContext.request.contextPath}/images/m/icon_gnb_arrow_down.svg" class="off"/>
	                        </a>
							<div class="sub off">
								<!-- 
								<a href="/bizStrategy/listBizStrategy.do?strategy=biz">회사/부문별전략</a>
								<a href="/bizStrategy/listBizStrategy.do?strategy=cs">고객별전략</a>
								<a href="/bizStrategy/listProjectPlan.do">전략프로젝트</a>
							 	-->
								<a href="/bizStrategy/viewBizStrategyCompany.do">회사/부문별전략</a>
								<a href="/bizStrategy/viewBizStrategyClient.do">고객별전략</a>
								<a href="/bizStrategy/viewBizStrategyProjectPlan.do">전략프로젝트</a>
							</div>
						</li>
						<li>
							<!-- 
							<a href="/calendar/calendar.do" class=""><span class="icon md icon_calendar va_m"></span> 일정관리</a>
							 -->
							<a href="/calendar/calendar.do?curDate=${param.curDate}" class=""><span class="icon md icon_calendar va_m"></span> 일정관리</a>
							<!-- <div class="sub off">
								<a href="/calendar/calendar.do">캘린더</a>
								<a href="#">나의 할 일</a>
							</div>
							 -->
						</li>
						<li class="func_menu">
							<a href="/j_spring_security_logout"><span class="icon md icon_key va_m"></span>  로그아웃</a>
						</li>
						<li class="func_menu">
							<a href="/common/changePW.do" class=""><span class="icon md icon_setting va_m"></span> 비밀번호변경</a>
						</li>
					<!-- 	<li class="func_menu">
							<a href="http://211.41.100.80:30000/" class=""><span class="icon md icon_desktop va_m"></span> PC화면보기</a>
						</li> -->
					</ul>
			</div>
		</div>
	
		<!-- 사이드메뉴 종료 -->
		
		<div class="today_checklist off"> <!-- sidemenu2 -->
			<div class="today_checklist_tab"> <!-- top2 -->
				<ul>
					<li>
						<a href="#" class="sideTab tab1 active">알림 <span class="alarm_count r10">0</span></a>
						<div class="today_checklist_tab_cont">
							<div class="today_checklist_tab_cont">
								<ul class="news">
								</ul>
							</div>
						</div>
					</li>
					<li>
						<a href="#" class="sideTab tab2">Coming up</a>
						<!-- <button type="button" onclick="quickTab(2);">모니터링</button> -->
						<div class="today_checklist_tab_cont off">
							<div class="coming_area" id="monitoring">
								
							</div>
						</div>
					</li>
				</ul>
				
				<a href="#" class="btn_today_checklist_close">
					<img src="../../../images/m/icon_sidemenu_close.svg" alt="사이드 메뉴 닫기"/>
				</a>
			</div>
		</div>
	</header>
<!-- 
<div class="modal_screen"></div>
 -->


<form id="formNoticeDetail" name="formNoticeDetail" method="post">
	<input type="hidden" id="notice_event_id" name="notice_event_id">
</form>  
<script type="text/javascript">
function moing(){
	/*
	// 일정
	dataCode();
	fncShowCalendar();
	*/
	
	// coming up
	contactMonitoring();
	
	// 알림
	fncNoticeDetail();
	fncNoticeCount();
	countUpdate();
}
function fncNoticeCount(){

	//알림 count
	$.ajax({
		url : "/common/selectNoticeCount.do",
		type : "get",
		data : {
			member_id_num : "${userInfo.MEMBER_ID_NUM}"
		},
		beforeSend : function() {
		},
		success : function(data) {
			var notice_cnt = data.noticeCount;
			//notice_cnt = 5;
			if (notice_cnt > 0){
				$('span.alarm_count').html(notice_cnt);
				$('span.alarm_count').show();
			}
		},
		complete : function() {
		},
		error : function() {
			console.log("Notice Error!");
		}
	});
}


function fncNoticeDetail(){

	$.ajax({
		url : "/common/selectNoticeDetail.do",
		type : "get",
		data : {
			member_id_num : "${userInfo.MEMBER_ID_NUM}"
		},
		beforeSend : function() {
		},
		success : function(data) {
			
			var newsList = data.selectNoticeDetail;
			var news_html = '';
			
			var redirectUrl = null;
			var mobileUrl_1 = null;
			var mobileUrl_2 = null;
			var calendarStartDate_1 = null;
			var calendarStartDate_2 = null;
			
			for (var n = 0; n < newsList.length; n ++){
				if (newsList[n].NOTICE_CONFIRM_YN == 'N') news_html += '<li>';
				else news_html += '<li class="visited">';
				
				if (newsList[n].NOTICE_CATEGORY == '캘린더공유'){
					news_html += '<a href="javascript:void(0);" onClick="linkBlockingButton();  return false;">'; //(\''+newsList[n].NOTICE_REDIRECT_URL+'\', \''+ newsList[n].NOTICE_ID +'\'); return false;
				} else if(newsList[n].NOTICE_CATEGORY == '캘린더 일정 초대') {
					news_html += '<a href="#" onClick="fncConvite(\''+ newsList[n].NOTICE_ID +'\'); return false;">';
				} else if(newsList[n].NOTICE_CATEGORY == '일정초대수락여부') {
					news_html += '<a href="#" onClick="return false;">';
				} else if(newsList[n].NOTICE_CATEGORY == '일정알림') {
					calendarStartDate_1 = (newsList[n].NOTICE_DETAIL);
					calendarStartDate_2 = calendarStartDate_1.split(" ",1);
					
					news_html += '<a href="#" onClick="meetingNotice(\''+newsList[n].EVENT_ID+'\', \''+ newsList[n].NOTICE_ID +'\', \''+ calendarStartDate_2 +'\'); countUpdate(\''+ newsList[n].NOTICE_ID +'\'); return false;">';
				} else {
					redirectUrl = newsList[n].NOTICE_REDIRECT_URL;
					mobileUrl_1 = redirectUrl.replace("viewClientIssueList","selectClientIssueDetail");
					mobileUrl_2 = mobileUrl_1.replace("issueId","pkNo");
					fncConvite
					news_html += '<a onClick="fncConvite(\''+ newsList[n].NOTICE_ID +'\');">';
					/* news_html += '<a href="'+ mobileUrl_2  +'" onClick="fncUpdateNotice(\''+ newsList[n].NOTICE_ID +'\');">'; */
					//news_html += '<a href="'+newsList[n].NOTICE_REDIRECT_URL+'" onClick="fncUpdateNotice(\''+ newsList[n].NOTICE_ID +'\');">';
				}
				
				if (newsList[n].NOTICE_CONFIRM_YN == 'N') news_html += '<span class="icon_new">new</span>';
				if(newsList[n].NOTICE_CATEGORY == '일정알림' || '캘린더 일정 초대'){
					if(newsList[n].NOTICE_CATEGORY == '캘린더 일정 초대'){
					}else{
						news_html += '<span class="icon lg icon_sch_'+newsList[n].NOTICE_CODE+'"></span>';	
					}
					news_html += '<span class="cata sch">'+newsList[n].NOTICE_CATEGORY+'</span>';
				
				}else if(newsList[n].NOTICE_CATEGORY == '고객이슈' || '고객만족' || '서비스프로젝트'){
					alert(newsList[n].NOTICE_CATEGORY);
					//news_html += '<span class="icon lg icon_issue_'+newsList[n].NOTICE_CODE+'"></span>';
					news_html += '<span class="cata issue">'+newsList[n].NOTICE_CATEGORY+'</span>';
				}else if(newsList[n].NOTICE_CATEGORY == '고객컨텍내용' || '영업기회' || '잠재영업기획'){
					alert(newsList[n].NOTICE_CATEGORY);
					//news_html += '<span class="icon lg icon_action_'+newsList[n].NOTICE_CODE+'"></span>';
					news_html += '<span class="cata action">'+newsList[n].NOTICE_CATEGORY+'</span>';
				}else if(newsList[n].NOTICE_CATEGORY == '회사부문별전략' || '고객별전략' || '전략프로젝트'){
					alert(newsList[n].NOTICE_CATEGORY);
					//news_html += '<span class="icon lg icon_stra_'+newsList[n].NOTICE_CODE+'"></span>';
					news_html += '<span class="cata stra">'+newsList[n].NOTICE_CATEGORY+'</span>';
				}else if(newsList[n].NOTICE_CATEGORY == '고객사/고객개인' || '파트너사/파트너사개인' || '성과관리'){
					alert(newsList[n].NOTICE_CATEGORY);
					//news_html += '<span class="icon lg icon_alarm_'+newsList[n].NOTICE_CODE+'"></span>';
					news_html += '<span class="cata alarm">'+newsList[n].NOTICE_CATEGORY+'</span>';
				}
				//alert(newsList[n].NOTICE_CATEGORY);
				news_html += '<span class="ment">'+newsList[n].NOTICE_DETAIL+'</span>';
				
				var v_notice_send_date = moment(newsList[n].NOTICE_SEND_DATE);
				v_notice_send_date = v_notice_send_date.format("YYYY-MM-DD");
				console.log("v_notice_send_date : " + v_notice_send_date);
				
				news_html += '<br/><span class="date">'+v_notice_send_date+'</span></a>';
				news_html += '<a href="#" class="btn_list_delete"><img src="${pageContext.request.contextPath}/images/m/btn_delete.svg"></a></li>';
				
				//news_html += '<span class="ment">'+newsList[n].NOTICE_DETAIL+'</span>';
				//news_html += '<br/><span class="date">'+newsList[n].NOTICE_SEND_DATE_TXT+'</span></a>';
				//news_html += '<a href="#" class="btn_list_delete"><img src="${pageContext.request.contextPath}/images/m/btn_delete.svg"></a></li>';
				
				
			}
			$('ul.news').html(news_html);
		},
		complete : function() {
		},
		error : function() {
			console.log("Notice Error!");
		}		
	});
}

function countUpdate (noticeId){
	$.ajax({
		url : "/common/updateNoticeDetail.do",
		async : false,
		type : "get",
		data : {
			member_id_num  : "${userInfo.MEMBER_ID_NUM}",
			noticeId : noticeId
		},
		beforeSend : function(){
		},
		success : function(data){
			
		},
		complete: function(){
			fncNoticeCount();
		},
		error : function(){
			console.log("Notice Error!");
		}
	});
	
}


function meetingNotice(eventId, noticeId, calendarStartDate_2 ){
	
	$.ajax({
		url : "/calendar/modalCalendarForm.do",
		type : "post",
		data : {
			member_id_num : "${userInfo.MEMBER_ID_NUM}"
		},
		beforeSend: function(){
		},
		success : function(data){
			var newsList = data.selectNoticeDetail;
			window.location.href = "/calendar/modalCalendarForm.do?mode=M&eventId="+eventId +"&pos=viewCalendar&start_date="+calendarStartDate_2;
			/* <a href="/calendar/modalCalendarForm.do?mode=M&eventId='+_item.EVENT_ID+'&pos=viewCalendar&start_date='+start_date+'"><span class="time">'+_item.START_TIME+'</span>';
			item_html += '<span class="icon lg icon_sch_'+_item.EVENT_CODE+'"></span><span class="subject">'+_item.title+'</span></a> */
		},
		complete : function(){
		
		},
		error : function(){
			console.log("meetingNotice Error!")
		}
	})
}

	function linkBlockingButton(){
		alert("캘린더공유 확인은 PC에서 확인해주세요.");
		return false;
	}
//calendar공유 잠시 기능 x
/* function fncVisitLink(linkURL, noticeId){
	$.ajax({
		url : "/common/updateNoticeDetail.do",
		async : false,
		type : "get",
		data : {
			member_id_num  : "${userInfo.MEMBER_ID_NUM}",
			noticeId : noticeId
		},
		beforeSend : function(){
		},
		success : function(data){
			location.href = "http://" + location.host + linkURL;
		},
		complete: function(){
			fncNoticeCount();
		},
		error : function(){
			console.log("Notice Error!");
		}
	});
} */

function fncConvite(noticeId){
	alert("메일에서 확인하세요");
	fncUpdateNotice(noticeId);
}

function fncUpdateNotice(noticeId){
	$.ajax({
		url : "/common/updateNoticeDetail.do",
		async : false,
		type : "get",
		data : {
			member_id_num  : "${userInfo.MEMBER_ID_NUM}",
			noticeId : noticeId
		},
		beforeSend : function(){
		},
		success : function(data){
			
		},
		complete: function(){
			fncNoticeCount();
		},
		error : function(){
			//console.log("Notice Error!");
		}
	});
}

//알림 삭제, 실제로는 삭제 안하고 
//	NOTICE_DEL_YN 컬럼에서 'Y'로 변경
function fncNoticeDelete(noticeId){

$.ajax({
	url : "/common/deleteNoticeDetail.do",
	async : false,
	type : "post",
	data : {
		datatype:'json',
		noticeID : noticeId
	},
	beforeSend : function(){
	},
	success : function(data){
		if(data.cnt > 0){
			alert("정상적으로 삭제되었습니다.");
			fncNoticeDetail();
		}else{
			alert("Notice Error!");
		}
		
	},
	complete: function(){
		fncNoticeCount();
	},
	error : function(){
		console.log("Notice Error!");
	}
});
}

// coming up
function contactMonitoring(){
	var params = $.param({
		datatype : 'html',
		searchMemberId : '${userInfo.MEMBER_ID_NUM}',
		jsp:'/main/mainMonitoringAjax'
	});
	
	$.ajax({
		type : "POST",
		async: false,
		data: params,
		url: "/main/selectMonitoring.do",
		success:function(data){
			$("#monitoring").html(data);
		}
	});
}

function openNav2(){	
 	$('#nav2').toggle();
	return false;
}

//캘리던 js
/* 
function fncList(){
	window.history.back();
}

function fncShowDetail(_event_id){
	location.href="/calendar/modalCalendarForm.do?mode=M&eventId="+_event_id+"&pos=calendar";
}

function fncRegister(){
	$('#frmPartner').attr('action', '');
	$('#frmPartner').submit();
}

function fncMoveToDate(_date){
	fncShowCalendar(_date);
	//location.href="/calendar/calendar.do?curDate="+_date;
}


function fncGetItemHtml2(_object, start_date){
	var obj_html = '';
	if (_object.PAST_YN == 'Y'){
		obj_html += '<li class="complete">';
	} else {
		obj_html += '<li>';
	}
	obj_html += '<a href="/calendar/modalCalendarForm.do?mode=M&eventId='+_object.EVENT_ID+'&pos=calendar&start_date='+start_date+'"><span class="time">';
	obj_html += '<span class="">'+_object.START_TIME+'~'+_object.END_TIME+'</span></span>';
	obj_html += '<span class="icon lg icon_sch_'+_object.EVENT_CODE+'"></span><span class="subject">'+_object.title+'</span>';
	obj_html += '</a>';
	obj_html += '</li>';
	return obj_html;
}

function fncAddSchedule() {
	location.href="/calendar/modalCalendarForm.do?mode=I&curDate=${curDate}&pos=calendar";
}

function dataCode(){
	$.ajax({
		type : "POST",
		data : {
			datatype : 'json'
		},
		async: false,
		url: "/main/headerDataCode.do",
		success:function(data){
			var cYear = data.cYear;
			var cMonth = data.cMonth;
			var cDay = data.cDay;
			
			console.log(cYear, cMonth, cDay);
			$("#cYear").html(cYear);
			$("#cMonth").html(cMonth);
			$("#cDay").html(cDay);
			
			$(".btn_prev").attr("onclick","fncMoveToDate('"+data.yesterdayDate+"'); return false;");
			$(".btn_next").attr("onclick","fncMoveToDate('"+data.tomorrowDate+"'); return false;");
		}
	});
}


// 캘린더 데이터 불러오기
function fncShowCalendar(_date) {
	var todayDate = moment().format('YYYYMMDD');
	if(_date != null){
		todayDate = _date;
	}
	setCookie("_data", todayDate, +1);
	
	if(todayDate != null){
		todayDate = getCookie("_data");
	}
	
	var calendarCheck_id = [];
	<c:forEach items="${calendarList}" var="calendar">
		calendarCheck_id.push('${calendar.CALENDAR_ID}');
	</c:forEach>
	
	var member_id_num = "${userInfo.MEMBER_ID_NUM}";
	var c_year = "${cYear}";
	var c_month = "${cMonth}";
	var c_day = "${cDay}";
	
	$.ajax({
		type : "POST",
		data : {
			"hiddenModalCreatorId" : member_id_num,
			"startRange" : '${startRange}',
			"endRange" : '${endRange}',
			"calendarCheck_id" : calendarCheck_id.toString(),
			"curDate" : todayDate,
			"datatype" : 'json',
			"hiddenUserId" : member_id_num,
			"selectYear" : c_year,
			"selectMonth" : c_month,
			"outlook" : 'N',
			"office365" : 'N',
			"google" : '',
			"thisMonthHoliday_id" : c_year+'%',
		},
		async: false,
		url: "/calendar/calendarEventListMobile.do",
		success:function(data){
			console.log(data);
			var list = data.events;
			var list_html = '';
			var start_date = '';
			
			for (var i = 0; i < list.length; i++){
				if(list[i].START_DAY == todayDate) {
					start_date = moment(list[i].START_DAY).format("YYYY-MM-DD");
					list_html += fncGetItemHtml2(list[i], start_date);
				}
			}
			console.log(list_html);
			$('#result_list3').html(list_html);
			
			if(_date != null){
				//여기
				$('#empty_result').hide();
				
				var cYear = data.up_cYear;
				var cMonth = data.up_cMonth;
				var cDay = data.up_cDay;
				
				$("#cYear").html(cYear);
				$("#cMonth").html(cMonth);
				$("#cDay").html(cDay);
				
				
				$(".btn_prev").attr("onclick","fncMoveToDate('"+data.yesterdayDate+"'); return false;");
				$(".btn_next").attr("onclick","fncMoveToDate('"+data.tomorrowDate+"'); return false;");
			}
			
			if(list_html == '') {
				$('#empty_result').show();
			}
			
			//if (list.length == 0) $('#empty_result').show();
			//else $('#empty_result').hide();
		}
	});
} */




</script>