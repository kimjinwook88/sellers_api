$(document).ready(function() {	
	// 사이드메뉴 출력
	fncGetSideMenu();	
	fncNoticeCount();	
});

function upper_right(){
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
}

/**
 * 사이드메뉴 호출
 * @returns
 */
function fncGetSideMenu(){	
	var params = $.param({
		datatype : 'html',
		jsp : '/templates/headerAjax'
	});

	//사용자 메뉴 리스트
	$.ajax({
		url : "/main/selectMemberMobileMenu.do",
		async : false,
		method: 'POST',
		data : params,
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
		},
		success : function(data){
			$('.side_gnb').html(data);
		},
		complete : function(){
		}
	});
}

/**
 * 알림 카운트
 * @returns
 */
function fncNoticeCount(){
	//알림 count
	$.ajax({
		url : "/common/selectNoticeCount.do",
		type : "get",
		data : {
			member_id_num : member_id_num
		},
		beforeSend : function() {
		},
		success : function(data) {
			var notice_cnt = data.noticeCount;
			
			if (notice_cnt > 0){
				$("#mainNoticeCount").html(notice_cnt);
				$('span.alarm_count').html(notice_cnt);
				$('span.alarm_count').show();
			}else{
				$("#mainNoticeCount").html(0);
			}
		},
		complete : function() {
		},
		error : function() {
			console.log("Notice Error!");
		}
	});
}

/**
 * 알림 확인한 것으로 업데이트
 * @param noticeId
 * @returns
 */
function fncUpdateNotice(noticeId){
	$.ajax({
		url : "/common/updateNoticeDetail.do",
		type : "get",
		data : {
			noticeId : noticeId
		},
		beforeSend : function(){
		},
		success : function(data){
			fncNoticeDetail();
		},
		complete: function(){
			
		},
		error : function(){
			//console.log("Notice Error!");
		}
	});
}

/**
 * 캘린더 공유 알림 클릭
 * @returns
 */
function linkBlockingButton(){
	alert("캘린더공유 확인은 PC에서 확인해주세요.");
	return false;
}

/**
 * 캘린더 일정 초대 알림 클릭
 * @param noticeId
 * @returns
 */
function fncConvite(noticeId){
	alert("메일에서 확인하세요");
	fncUpdateNotice(noticeId);
}

/**
 * 일정 알림 클릭 (디테일 이동)
 * @param eventId
 * @param noticeId
 * @param calendarStartDate_2
 * @returns
 */
function meetingNotice(eventId, noticeId, calendarStartDate_2 ){
	$.ajax({
		url : "/calendar/modalCalendarForm.do",
		type : "post",
		data : {
			member_id_num : member_id_num
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

/**
 * 알람 리스트 출력
 * @param list
 * @returns
 */
function fncNoticeDetailHtml(list){
	var news_html = '';
	
	var l = list.length;
	for(var i=0; i<l; i++){
		
		// 확인 여부
		if(list[i].NOTICE_CONFIRM_YN == 'N'){
			news_html += '<li>';
		}else{
			news_html += '<li class="visited">';
		}
		
		// 카테고리 구분
		var category = list[i].NOTICE_CATEGORY;
		var onClickCont = '';
		switch (category) {
			case '캘린더공유':
				onClickCont = 'linkBlockingButton(); return false;';
				break;
			case '캘린더 일정 초대':
				onClickCont = 'fncConvite(\''+ list[i].NOTICE_ID +'\'); return false;';
				break;
			case '일정초대수락여부':
				onClickCont = 'return false;';
				break;
			case '일정알림':
				var calStartDate = list[i].NOTICE_DETAIL;
				calStartDate = calStartDate.split(" ",1);
				
				onClickCont = 'meetingNotice(\''+list[i].EVENT_ID+'\', \''+ list[i].NOTICE_ID +'\', \''+ calStartDate +'\'); fncUpdateNotice(\''+ list[i].NOTICE_ID +'\'); return false;';
				break;
			default:
				var redirectUrl = list[i].NOTICE_REDIRECT_URL;
				if(redirectUrl){
					var mobileUrl = redirectUrl.replace("viewClientIssueList","selectClientIssueDetail");
					mobileUrl = mobileUrl.replace("issueId","pkNo");
				}				
				
				onClickCont = 'fncConvite(\''+ list[i].NOTICE_ID +'\');';
				break;
		}
		
		if(onClickCont){
			news_html += '<a onClick="'+onClickCont+'">';
		}
		
		// 확인여부
		if(list[i].NOTICE_CONFIRM_YN == 'N'){
			news_html += '<span class="icon_new">new</span>';
		}
		
		// 카테고리
		var className = '';				
		switch (category) {
			case '일정알림':
			case '캘린더 일정 초대':						
				if(category != '캘린더 일정 초대'){
					news_html += '<span class="icon lg icon_sch_'+list[i].NOTICE_CODE+'"></span>';	
				}
				className = 'sch';						
				break;
			case '고객이슈':
			case '고객만족':
			case '서비스프로젝트':
				className = 'issue';
				break;
			case '고객컨텍내용' :
			case '영업기회':
			case '잠재영업기획':
				className = 'action';
				break;
			case '회사부문별전략':
			case '고객별전략':
			case '전략프로젝트':
				className = 'stra';
				break;
			case '고객사/고객개인':
			case '파트너사/파트너사개인':
			case '성과관리':
				className = 'alarm';
				break;
			default:
				break;
		}
		
		if(className){
			news_html += '<span class="cata '+className+'">'+category+'</span>';
		}
		
		news_html += '<span class="ment">'+list[i].NOTICE_DETAIL+'</span>';
		
		var v_notice_send_date = moment(list[i].NOTICE_SEND_DATE);
		v_notice_send_date = v_notice_send_date.format("YYYY-MM-DD");
		
		news_html += '<br/><span class="date">'+v_notice_send_date+'</span></a>';
		news_html += '<a href="javascript:void(0);" class="btn_list_delete" onclick="fncNoticeDelete(' + list[i].NOTICE_ID + ');">'
				+'<img src="/images/m/btn_delete.svg"></a></li>';
		
	}
	
	$('ul.news').html(news_html);
}

/**
 * 알림 리스트 생성
 * @returns
 */
function fncNoticeDetail(){
	$.ajax({
		url : '/common/selectNoticeDetail.do',
		type : 'post',
		data : {
			member_id_num : member_id_num
		},
		beforeSend : function() {
		},
		success : function(data) {
			var list = data.selectNoticeDetail;
			fncNoticeDetailHtml(list);
		},
		complete : function() {
		},
		error : function() {
			console.log("Notice Error!");
		}		
	});
}

/**
 * NOTICE_DEL_YN 컬럼에서 'Y'로 변경
 * @param noticeId
 * @returns
 */
function fncNoticeDelete(noticeId){
	$.ajax({
		url : "/common/updateNoticeDetail.do",
		async : false,
		type : "post",
		data : {
			datatype:'json',
			noticeId : noticeId,
			noticeDel : 'Y'
		},
		beforeSend : function(){
		},
		success : function(data){
			if(data.updateCnt > 0){
				alert('삭제되었습니다.');
				fncNoticeDetail();
			}else{
				alert('알림이 정상적으로 삭제되지 않았습니다.');
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

 /*function fncVisitLink(linkURL, noticeId){
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

/**
 * Comming Up
 * @param mm_name
 * @param mm_seq
 * @param use_yn
 * @returns
 */
function contactMonitoring(mm_name, mm_seq, use_yn){
	if(use_yn == "Y" || isEmpty(use_yn)){
		var params = $.param({
			datatype : 'html',
			jsp : '/main/mainMonitoringAjax',
			searchDate : $('#timeLineDate').html(),
			searchMemberId : member_id_num
		});
		$.ajax({
			url : "/main/selectTrackingList.do",
			async : false,
 			datatype : 'html',
 			method: 'POST',
 			data : params,
 			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
				//$.ajaxLoading();
			},
			success : function(data){
				$('.today_checklist .coming_area').html(data);
				/*$('#divMain_'+mm_seq).html(data);
				$('#divMain_'+mm_seq).find("div.ibox-title h5").html(mm_name);*/
			},
			complete : function(){
				//$.ajaxLoadingHide();
			}
		});
	}else{
		$('#divMain_'+mm_seq).remove();	
	}
}

/*function contactMonitoring(){
	var params = $.param({
		datatype : 'html',
		searchMemberId : member_id_num,
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
}*/

// 캘리던 js
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
	 */
/* 
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
}
 */