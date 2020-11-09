<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8" %>


<header class="header_schedule primary_bg ">

    <hgroup>
        <h1 class="sev_ti">캘린더</h1>
    </hgroup>

	<a href="#" class="btn_sideMenu">
		<span></span>
		<span></span>
		<span></span>
	</a>
	
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
			<span class="alarm_count pos_side r10" style="display:none;">0</span> <!-- 확인하지 않은 알림 개수 -->
		
			<a href="#" class="sideTab tab1 active">메뉴</a>
			<div class="side_cont">
				<ul class="gnb">
					<li>
						<a href="#" class="btn_one"><span class="icon md icon_custominfo va_m"></span> 고객사 및 고객개인정보 <img src="/images/icon_gnb_arrow_left.svg"/> <img src="/images/icon_gnb_arrow_down.svg" class="off"/></a>
						<div class="sub off">
							<a href="/clientManagement/listClientCompanyInfoView.do">고객사정보</a>
							<a href="/clientManagement/listClientIndividualInfoList.do">고객개인정보</a>
						</div>
					</li>
					<li>
						<a href="#" class="btn_one"><span class="icon md icon_salesAct va_m"></span> 고객영업활동 <img src="/images/icon_gnb_arrow_left.svg"/> <img src="/images/icon_gnb_arrow_down.svg" class="off"/></a>
						<div class="sub off">
							<!--<a href="/salesActive/listClientContact.do">고객컨텍내용</a>-->
                            <a href="/clientSalesActive/viewClientContactList.do">고객컨텍내용</a>
							<a href="/salesActive/listOpportunity.do">영업기회</a>
							<a href="">잠재영업기회</a>
						</div>
					</li>
					<li>
						<a href="#" class="btn_one"><span class="icon md icon_cutomgood va_m"></span> 고객만족 <img src="/images/icon_gnb_arrow_left.svg"/> <img src="/images/icon_gnb_arrow_down.svg" class="off"/></a>
						<div class="sub off">
							<a href="/salesActive/listClientIssue.do">고객이슈</a>
							<a href="/salesActive/listClientSatisfaction.do">고객만족도</a>
						</div>
					</li>
					<li>
						<a href="#" class="btn_one"><span class="icon md icon_partner va_m"></span> 파트너사 협업관리 <img src="/images/icon_gnb_arrow_left.svg"/> <img src="/images/icon_gnb_arrow_down.svg" class="off"/></a>
						<div class="sub off">
							<a href="/salesActive/listSalesLinkage.do">파트너사 협업</a>
							<a href="/partnerManagement/listPartnerCompanyInfo.do">파트너사정보</a>
							<a href="/partnerManagement/listPartnerIndividualInfo.do">파트너사개인정보</a>
						</div>
					</li>
					<li>
						<a href="#" class="btn_one"><span class="icon md icon_paper va_m"></span> 사업전략 <img src="/images/icon_gnb_arrow_left.svg"/> <img src="/images/icon_gnb_arrow_down.svg" class="off"/></a>
						<div class="sub off">
							<a href="/bizStrategy/listBizStrategy.do?strategy=biz">회사/부문별전략</a>
							<a href="/bizStrategy/listBizStrategy.do?strategy=cs">고객별전략</a>
							<a href="/bizStrategy/listProjectPlan.do">전략프로젝트</a>
						</div>
					</li>
					<li>
						<a href="/calendar/calendar.do" class=""><span class="icon md icon_calendar va_m"></span> 일정관리</a>
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
						<a href="#" class=""><span class="icon md icon_setting va_m"></span> 비밀번호변경</a>
					</li>
					<li class="func_menu">
						<a href="http://211.41.100.80:30000/" class=""><span class="icon md icon_desktop va_m"></span> PC화면보기</a>
					</li>
				</ul>					
			</div>

			<a href="#" class="sideTab tab2">알림</a>
			<div class="side_cont off">
				<ul class="news">
				</ul>					
			</div>
		</div>
	</div>
	<!-- 사이드메뉴 종료 -->

</header>

<div class="modal_screen"></div>


<form id="formNoticeDetail" name="formNoticeDetail" method="post">
	<input type="hidden" id="notice_event_id" name="notice_event_id">
</form>  


<script type="text/javascript">

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
			
			for (var n = 0; n < newsList.length; n ++){
				if (newsList[n].NOTICE_CONFIRM_YN == 'N') news_html += '<li>';
				else news_html += '<li class="visited">';
				/* if (newsList[n].NOTICE_CATEGORY == '캘린더공유'){
					news_html += '<a href="#" onClick="fncVisitLink(\''+newsList[n].NOTICE_REDIRECT_URL+'\', \''+ newsList[n].NOTICE_ID +'\'); return false;">';
				} else  */if(newsList[n].NOTICE_CATEGORY == '캘린더 일정 초대') {
					news_html += '<a href="#" onClick="fncConvite(\''+ newsList[n].NOTICE_ID +'\'); return false;">';
				} else if(newsList[n].NOTICE_CATEGORY == '일정초대수락여부') {
					news_html += '<a href="#" onClick="return false;">';
				} else if(newsList[n].NOTICE_CATEGORY == '일정알림') {
					//onclick='"notice.meetingNotice(\''+newsList[n].EVENT_ID+'\', \''+newsList[n].NOTICE_ID+'\')">'+"바로가기"+'</span>');
					news_html += '<a href="#" onClick="meetingNotice(\''+newsList[n].EVENT_ID+'\', \''+ newsList[n].NOTICE_ID +'\'); return false;">';
					//news_html += '<a href="#" onClick="fncUpdateNotice(\''+ newsList[n].NOTICE_ID +'\'); return false;">';
					//news_html += '<a href="'+newsList[n].NOTICE_REDIRECT_URL+'" target="_new" onClick="notice.countUpdate(\''+newsList[n].NOTICE_ID+'\');"><span class="icon_link">'+"바로가기"+'</span></a>'
				} else {
					
					//news_html += '<a href="#" onClick="alert(\''+newsList[n].NOTICE_CATEGORY+'\'); return false;">';
					//news_html += '<a href="#" onClick="fncUpdateNotice(\''+ newsList[n].NOTICE_ID +'\'); return false;">';
					news_html += '<a href="'+newsList[n].NOTICE_REDIRECT_URL+'" onClick="fncUpdateNotice(\''+ newsList[n].NOTICE_ID +'\');">';
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
				news_html += '<br/><span class="date">'+newsList[n].NOTICE_SEND_DATE_TXT+'</span></a>';
				news_html += '<a href="#" class="btn_list_delete"><img src="/images/btn_delete.svg"></a></li>';
				
				
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

function meetingNotice(eventId, noticeId){ 
	countUpdate(noticeId);
	$("#formNoticeDetail").attr("target", "formNoticeDetail");
	$("#formNoticeDetail #notice_event_id").val(eventId);
	
	var form =  $("#formNoticeDetail")[0];
	var url = "/calendar/calendarMonth.do";
	//window.open("" ,"formNoticeDetail"); 
	form.action = url; 
	form.submit();
}


function fncVisitLink(linkURL, noticeId){
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
}

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
</script>