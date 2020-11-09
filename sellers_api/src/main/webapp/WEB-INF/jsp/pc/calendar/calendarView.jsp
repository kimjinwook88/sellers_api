<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>

<div class="row wrapper border-bottom white-bg page-heading" style="display: none;">
	<div class="col-sm-4">
		<h2>캘린더</h2>
		<ol class="breadcrumb">
			<li><a href="/main/index.do">Home</a></li>
			<li class="active"><strong>캘린더</strong></li>
		</ol>
	</div>
	<div class="col-sm-8">
		<div class="time-update">
			<span class="text-muted small pull-right"> 최근 업데이트: <i class="fa fa-clock-o"></i>
			</span>
		</div>
	</div>
</div>

<div class="wrapper wrapper-content pd-tno pd-rno">
	<div class="row animated fadeInDown calendar-grid">
		<div class="calendar-grid-l">
			<div class="ibox">
				<div class="ibox-content border_n">
					<div id="calendar" class="fc fc-ltr fc-unthemed"></div>
					<div class="element-detail-box" style="display: none; overflow: hidden; width: auto; height: 100%;" id="productivityView"></div>
				</div>
			</div>
		</div>


		<div class="calendar-grid-r">
			<a href="" class="btn-calendar btn-calendar-off"> <img src="<%=request.getContextPath()%>/images/pc/icon_arrow_right.png" class="v-m" /> <span class="v-m">메뉴숨김</span>
			</a> <a href="" class="btn-calendar btn-calendar-on"> <img src="<%=request.getContextPath()%>/images/pc/icon_arrow_left.png" class="v-m" />
			</a>
			<div class="ibox float-e-margins">
				<div class="calendar-content">
					<h5 class="legend-title">
						<img src="../images/pc/calendar_icon_legend.png" /> 일정 구분
					</h5>
					<ul class="legend">
						<li><img src="<%=request.getContextPath()%>/images/pc/calendar_icon1.png" class="v-m">고객컨택</li>
						<li><img src="<%=request.getContextPath()%>/images/pc/calendar_icon2.png" class="v-m">컨택준비</li>
						<li><img src="<%=request.getContextPath()%>/images/pc/calendar_icon3.png" class="v-m">내부회의</li>
						<li><img src="<%=request.getContextPath()%>/images/pc/calendar_icon4.png" class="v-m">교육</li>
						<li><img src="<%=request.getContextPath()%>/images/pc/calendar_icon7.png" class="v-m">기타</li>
						<li><img src="<%=request.getContextPath()%>/images/pc/calendar_icon6.png" class="v-m">휴가</li>
						<li><img src="<%=request.getContextPath()%>/images/pc/calendar_icon5.png" class="v-m">이동시간</li>
					</ul>
				</div>

				<div class="ibox-title pos-rel">
					<c:choose>
						<c:when test="${fn:length(calendarList) > 0}">
							<c:forEach items="${calendarList}" var="calendarList">
								<c:choose>
									<c:when test="${(calendarList.CALENDAR_TYPE ne 3) && (calendarList.CALENDAR_NAME ne '아웃룩 캘린더') && (calendarList.CALENDAR_TYPE ne 2) && (calendarList.MEMBER_ID_NUM eq userInfo.MEMBER_ID_NUM)}">
										<a class="btn-calendar-add va-m mg-l10">
											<h5 class="title" onclick="calendarShare.reset('${calendarList.MEMBER_ID_NUM}', '${calendarList.CALENDAR_ID}', '${calendarList.CALENDAR_NAME}');">나의 캘린더 공유</h5>
										</a>
										<div style="display: none">
											<li style="display: none">
												<input type="checkbox" checked="checked" name="checkboxCalendarId" value="${calendarList.CALENDAR_ID}" onClick="$('#calendar').fullCalendar('refetchEvents');" />
												 ${calendarList.CALENDAR_NAME} 
												 <a href="#" class="btn-func-pop"><i class="fa fa-caret-square-o-down"></i> </a> 
												 <input type="hidden" id="syncYN" value="${calendarList.SYNC_YN}" /> 
												 <input type="hidden" id="userIdNum" value="${userInfo.MEMBER_ID_NUM}" /> 
												 <input type="hidden" id="hiddenShareCalendId" value="${calendarList.CALENDAR_ID}" />
												<div class="calendar-func-pop off"></div>
											</li>
										</div>
									</c:when>
								</c:choose>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<input type="hidden" id="noCalendarData" name="noCalendarData" value="Y"></input>
						</c:otherwise>
					</c:choose>
				</div>

				<!-- <div class="calendar-content">
					<ul class="calendar-add-list" id="calendar-add-list">
					</ul>
				</div> -->
				<div class="ibox-title pos-rel">
					<a href="#" class="btn-calendar-add va-m mg-l10"><h5 class="title">사내 캘린더 연동</h5></a>
					<!-- add-calendar popup -->
					<div class="addCalendar-pop off" id="divPopupOtherCalndar">
						<div class="pop-header">
							<button type="button" class="close" onclick="">
								<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
							</button>
							<strong class="pop-title">사내 캘린더 연동</strong>
						</div>
						<div class="col-sm-12 cont">
							<div class="ag_c m-b other-calendar off" id="divPopupOtherCalndar_General">
								<a href="#" class="mg-5 btn-office"><img src="../images/pc/calendar_office365.png" /></a> <a href="#" class="mg-10 btn-outlook"><img src="../images/pc/calendar_outlook.png" /></a> <a href="#" class="mg-10 btn-google"><img src="../images/pc/calendar_google.png" /></a>
								<div class="col-sm-12 border_t pd-t10 ta-c">
									<button type="button" class="btn btn-outline btn-seller-outline mg-r10" onclick="calendar.otherCalendarPopup('divPopupOtherCalndar_General');">취소</button>
									<button type="button" class="btn btn-seller">추가</button>
								</div>
							</div>

							<div class="form-group office-calendar" id="divPopupOtherCalndar_Office365">
								<div class="ag_c ft-s20 m-b">office365 로그인</div>
								<label class="col-lg-2 control-label pd-t5">ID</label>
								<div class="col-lg-10 m-b">
									<input type="text" class="form-control" id="textOffice365LoginId" placeholder="abcd@unipoint.co.kr" onclick="calendar.selectRange(this);" />
								</div>
								<label class="col-lg-2 control-label pd-t5">PW</label>
								<div class="col-lg-10 m-b">
									<input type="password" class="form-control" id="textOffice365LoginPw" placeholder="Office365 PassWord" onkeydown="if(event.keyCode == 13){calendar.office365Cal($('#textOffice365LoginId').val(), $('#textOffice365LoginPw').val());}" />
								</div>
								<div class="col-sm-12 border_t pd-t10 ta-c">
									<button type="button" class="btn btn-outline btn-seller-outline mg-r10 btn-cancle">취소</button>
									<button type="button" class="btn btn-seller" onclick="calendar.office365Cal($('#textOffice365LoginId').val(), $('#textOffice365LoginPw').val())">로그인</button>
								</div>
							</div>

							<div class="form-group outlook-calendar off" id="divPopupOtherCalndar_Outlook">
								<div class="ag_c ft-s20 m-b">Outlook 인증</div>
								<label class="col-lg-3 control-label pd-t5">ID</label>
								<div class="col-lg-9 m-b">
									<input type="text" class="form-control" id="textOutlookLoginId" placeholder="abcd@unipoint.co.kr" />
								</div>
								<label class="col-lg-3 control-label pd-t5">PW</label>
								<div class="col-lg-9 m-b">
									<input type="password" class="form-control" id="textOutlookLoginPw" placeholder="Outlook PassWord" />
								</div>
								<div class="col-sm-12 border_t pd-t10 ta-c">
									<button type="button" class="btn btn-outline btn-seller-outline mg-r10" onclick="">취소</button>
									<button type="button" class="btn btn-seller">추가</button>
									<button type="button" class="btn btn-seller" onclick="calendar.outlookCal($('#textOutlookLoginId').val(), $('#textOutlookLoginPw').val())">로그인</button>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="calendar-content">
					<ul id="calendar-other-outlook" class="calendar-add-list off">
						<c:forEach items="${calendarList}" var="calendarList">
							<c:choose>
								<c:when test="${calendarList.CALENDAR_NAME eq '아웃룩 캘린더'}">
									<li><input type="checkbox" checked="checked" name="checkboxCalendarId" value="outlook" onClick="$('#calendar').fullCalendar('refetchEvents');" />${calendarList.CALENDAR_NAME}<a href="#" class="btn-func-pop"><i class="fa fa-caret-square-o-down"></i></a>
										<div class="calendar-func-pop off">
											<ul>
												<li><a href="#" class="btn-calendar-rename">캘린더 이름 변경</a>
													<div class="rename-input off">
														<input type="text" style="width: 85px;" /><input type="submit" value="저장" onclick="calendar.reNameCalendar(${calendarList.CALENDAR_ID}, this);" />
													</div></li>
												<li><a href="#" class="btn-calendar-delete">캘린더 삭제</a>
													<div class="delete-input off">
														<input type="submit" value="삭제" onclick="alert('${calendarList.CALENDAR_NAME}'); calendar.deleteCalendar(${calendarList.CALENDAR_ID}, '${calendarList.CALENDAR_NAME}');" /><input type="submit" value="취소" onclick="$('.delete-input').hide();" />
													</div></li>
											</ul>
										</div></li>
								</c:when>
							</c:choose>
						</c:forEach>
					</ul>


					<ul id="calendar-other-office365" class="calendar-add-list">
						<c:forEach items="${calendarList}" var="calendarList">
							<c:choose>
								<c:when test="${calendarList.CALENDAR_TYPE eq 2}">
									<li><input type="checkbox" checked="checked" name="checkboxCalendarId" value="office365" onClick="$('#calendar').fullCalendar('refetchEvents');" />${calendarList.CALENDAR_NAME}
										<div class="calendar-func-pop off">
											<ul>
												<li><a href="#" class="btn-calendar-rename">캘린더 이름 변경</a>
													<div class="rename-input off">
														<input type="text" style="width: 85px;" /><input type="submit" value="저장" onclick="calendar.reNameCalendar(${calendarList.CALENDAR_ID}, this);" />
													</div></li>
												<li><a href="#" class="btn-calendar-delete">캘린더 삭제</a>
													<div class="delete-input off">
														<input type="submit" value="삭제" onclick="calendar.deleteCalendar('${calendarList.CALENDAR_ID}', '${calendarList.CALENDAR_NAME}', '${calendarList.CALENDAR_TYPE}');" /><input type="submit" value="취소" onclick="$('.delete-input').hide();" />
													</div></li>
											</ul>
										</div></li>
								</c:when>
							</c:choose>
						</c:forEach>
					</ul>
				</div>

				<!-- <div class="ibox-title pos-rel">
					<a href="#" class="btn-calendar-add va-m mg-l10"><h5
							class="title">구글 캘린더 연동</h5></a>
					<div class="addCalendar-pop off" id="divPopupOtherCalndar">
						<div class="pop-header">
							<button type="button" class="close"
								onclick="calendar.otherCalendarPopup();">
								<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
							</button>
							<strong class="pop-title">Google 캘린더 연동</strong>
						</div>
						<div class="col-sm-12 cont">
							<div class="form-group google-calendar"
								id="divPopupOtherCalndar_Google">
								<div class="ag_c ft-s20 m-b">Goolge 캘린더</div>
								<label class="col-lg-12 control-label pd-t5">ICS파일 URL을
									입력하세요</label>
								<div class="col-lg-12 m-b">
									<input type="text" class="form-control" id="textGoogleIcsURL"
										placeholder="구글ICS URL 입력" />
								</div>
								<span style="color: blue">불러오기는 가능하나 Sync기능은 제공 하지 않습니다.</span>
								<div class="col-sm-12 border_t pd-t10 ta-c">
									<button type="button"
										class="btn btn-outline btn-seller-outline mg-r10 btn-cancle">취소</button>
									<button type="button" class="btn btn-seller"
										onclick="calendar.downICS($('#textGoogleIcsURL').val(), 'google')">확인</button>
								</div>
							</div>
						</div>
					</div>
				</div> -->

				<%-- <div class="ibox-title pos-rel">
					<a href="#" class="btn-calendar-add va-m mg-l10"><h5 class="title">구글 캘린더 연동</h5></a>
					<div class="addCalendar-pop off" id="divPopupOtherCalndar">
						<div class="pop-header">
							<button type="button" class="close" onclick="calendar.otherCalendarPopup();">
								<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
							</button>
							<strong class="pop-title">Google 캘린더 연동</strong>
						</div>
						<div class="col-sm-12 cont">
							<div class="form-group google-calendar" id="divPopupOtherCalndar_Google">
								<div class="ag_c ft-s20 m-b">Goolge 캘린더</div>
								<div class="col-sm-12 pd-t10 ta-c">
									<c:choose>
										<c:when test="${(gcToken eq null || gcToken eq '')}">
											<button type="button" class="btn btn-seller" onclick="calendar.googleOAuth('1');">연동하기</button>
										</c:when>
										<c:otherwise>
											<button type="button" class="btn btn-seller" onclick="calendar.googleOAuth('2');">다른 아이디로 연동</button>
											<button type="button" class="btn btn-seller" onclick="calendar.googleOAuth('3');">연동끊기</button>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="calendar-content">
					<ul id="calendar-other-google" class="calendar-add-list">
						<c:forEach items="${calendarList}" var="calendarList">
							<c:choose>
								<c:when test="${calendarList.CALENDAR_TYPE eq 3}">
									<li>
										<input type="checkbox" checked="checked" name="checkboxCalendarGoogleId" value=" ${calendarList.CALENDAR_ID}" onClick="$('#calendar').fullCalendar('refetchEvents');" />${calendarList.CALENDAR_NAME}
									</li>
								</c:when>
							</c:choose>
						</c:forEach>
					</ul>
				</div> --%>




				<div class="ibox-title">
					<a><h5 class="title">
							<span id="more" style="CURSOR: hand" onclick="if(shareView.style.display=='none') {shareView.style.display='';more.innerText='동료 캘린더 접기'} else {shareView.style.display='none';more.innerText='동료 캘린더 보기'}">동료 캘린더 보기</span>
						</h5></a>
					<!--add-calendar popup  -->
				</div>
				<div class="calendar-content" id="shareView" style="display: none">
					<ul class="calendar-add-list" id="calendar-share-list">
						<c:choose>
							<c:when test="${fn:length(calendarList) > 0}">
								<c:forEach items="${calendarList}" var="calendarList">
									<c:choose>
										<c:when test="${calendarList.MEMBER_ID_NUM ne userInfo.MEMBER_ID_NUM}">
											<li><input type="checkbox" name="checkboxCalendarId" value="${calendarList.CALENDAR_ID}" onClick="$('#calendar').fullCalendar('refetchEvents');" style="display: none" /><a href="#" onclick="calendar.shareCalView('${calendarList.MEMBER_ID_NUM}');">${calendarList.MEMBER_NAME} ${calendarList.POSITION_STATUS}</a></li>
										</c:when>
									</c:choose>
								</c:forEach>
							</c:when>
						</c:choose>
					</ul>
				</div>
			</div>
			<input type="hidden" id="textCalendarName" name="textCalendarName"></input>
		</div>
	</div>
</div>
</div>

<!-- calendarModal, calendarShareModal 에서 사용 -->
<input type="hidden" name="hiddenModalMemberList" id="hiddenModalMemberList" value="" />

<jsp:include page="/WEB-INF/jsp/pc/calendar/calendarModal.jsp" />
<jsp:include page="/WEB-INF/jsp/pc/calendar/calendarOfOfficeModal.jsp" />
<jsp:include page="/WEB-INF/jsp/pc/calendar/calendarShareModal.jsp" />

</body>

<link rel="stylesheet" href="/nvD3/nvd3/nv.d3.min.css" />
<script src="/nvD3/d3.min.js" charset="utf-8"></script>
<script src="/nvD3/angular/angular.js"></script>
<script src="/nvD3/nvd3/nv.d3.min.js"></script>
<script src=/nvD3/angular-nvd3/angular-nvd3.min.js></script>

<script>
/*
 *  전역변수
 */
var searchEventCnt = 0;
var searchEventTag = '<div class="search-calendar" id="searchCalendar" style="display: none;">'+
'<div class="form-group">'+
'<label class="control-label " for="date_modified">시작일</label>'+
	'<div class="date-sel">'+
		'<div class="data_1">'+
			'<div class="input-group date">'+
				'<span class="input-group-addon"><i class="fa fa-calendar"></i></span>'+
				'<input type="text" class="form-control" name="textSearchStartDate" id="textSearchStartDate" value="" onchange="calendar.searchDateCheck();">'+
			'</div>'+
		'</div>'+
	'</div>'+
	'<div class="gep">~</div>'+
	'<label class="control-label " for="date_modified">종료일</label>'+
	'<div class="date-sel">'+
		'<div class="data_1">'+
			'<div class="input-group date">'+
				'<span class="input-group-addon"><i class="fa fa-calendar"></i></span>'+
				'<input type="text" class="form-control" name="textSearchEndDate" id="textSearchEndDate" value="" onchange="calendar.searchDateCheck();">'+
			'</div>'+
		'</div>'+
	'</div>'+
'</div>'+
'<div class="pgsearch">'+
	'<input type="text" placeholder="검색할 일정을 입력해주세요." id="textSearch" onkeydown="if(event.keyCode == 13){calendar.search();}"/>'+
	'<button class="btn" onclick="calendar.search();"><i class="fa fa-search"></i> 검색</button>'+
'</div>'+
'</div>';

var gridWidth;
var searchSerialize;
var modalFlag = "ins/upd"; //추가 수정 변수
var listRow = 10;
var reloadFlag = true;

var compare_before;
var compare_after;
var compareFlag = false;

var startDateCmp;

var calendarTitle_before = ""; //moment().format('YYYY')+"년 "+moment().format('M')+"월";

var date = new Date();

var notice_event_id = "${param.notice_event_id}";
var myProductivityYN = "${param.myProductivity}";

//office365 모달팝업용
var o365_subject =  "${param.o365_subject}";
var o365_start =  "${param.o365_start}";
var o365_end =  "${param.o365_end}";
var o365_detail =  "${param.o365_detail}";
var o365_location =  "${param.o365_location}";

$(document).ready(function() { 
	//ie 하단 클릭이벤트 인식을 위한 body 높이 조절
	$('html, body').css('overflowY', 'auto');
	
	calendar.init();
	calendar.chk(); 
	calendar.draw();
	
	// 사원이 [생산성] 페이지에서 나의 생산성을 보려고 할 때, [일정관리]-[나의생산성] 창을 띄어주기 위해.
	if(myProductivityYN == "Y"){
		menuCookieSet('일정관리');
		setActiveMenu();
		window.open("http://" + location.host + "/calendar/myProductivity.do?viewType=m&hiddenUserId="+$("#userIdNum").val(), "나의생산성", "width=1290, height=690, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );
	}

	//버튼 event
	/* $('button').click(function(){
	}); */
	//모달 hidden event
	$('#myModal1').on('hide.bs.modal', function () {
		compare_after = $("#formModalData").serialize();
		if(modalFlag == "upd"){
			if(compare_before != compare_after){
				if(confirm("내용이 수정되었습니다.\n저장하시겠습니까?")) {
					compareFlag = true;
					$("#buttonModalSubmit").trigger("click");
				}
			}
		}else{ //신규등록이면
			if(compare_before != compare_after){
				if(confirm("창을 닫으면 입력한 정보가 지워집니다.\n창을 닫으시겠습니까?")) {
					$("#divModalFile p").hide();
				}else{
					return false;
				}
			}
		}
	});
});	
var calendar = {
		init : function() {
			if(notice_event_id){
				calendar.goDetail(notice_event_id);
			}else if(o365_subject){
				$("h4.modal-title").html(o365_subject);
        		$('#textModalEventSubject2').val(o365_subject);
   				$('#selectModalStartDateTime2').val(o365_start);
        		$('#selectModalEndDateTime2').val(o365_end);
        		$('#textareaModalEventDetail2').val(o365_detail.replace("<br>", "\r\n"));
        		$('#textModalEventLocation2').val(o365_location);
        		
        		$("#myModalOutlook").modal();
			}
				
		},
		chk : function() {
			if($("#noCalendarData").val() == "Y"){
				$("#textCalendarName").val("나의 캘린더");
				calendar.addCalendar();
			}
		},
		
		searchDateCheck : function() {
			if($("#textSearchStartDate").val() == null || $("#textSearchStartDate").val() == ""){
				$("#textSearchStartDate").val(moment($("#textSearchEndDate").val()).add(-1, 'months').format("YYYY-MM-DD"));
			}else if($("#textSearchEndDate").val() == null || $("#textSearchEndDate").val() == ""){
				$("#textSearchEndDate").val(moment($("#textSearchStartDate").val()).add(1, 'months').format("YYYY-MM-DD"));
			}
		},
		
		search : function() {
			if(($('#textSearchStartDate').val() == null || $('#textSearchStartDate').val() == '') || ($('#textSearchEndDate').val() == null || $('#textSearchEndDate').val() == '')){
				$('#calendar').fullCalendar('gotoDate', date.getFullYear());
				$('#calendar').fullCalendar('refetchEvents');
			}else if($('#textSearchStartDate').val() > $('#textSearchEndDate').val()){
				alert('검색 날짜 조건을 잘못 입력하였습니다.');
				$('#textSearchEndDate').focus();
			}else{
				$('#calendar').fullCalendar('refetchEvents');
			}
			
			/* if($('#textSearchStartDate').val() > $('#textSearchEndDate').val()){ //검색 종료일이 시작일보다 이전일 경우.
				alert('검색 날짜 조건을 잘못 입력하였습니다.');
				$('#textSearchEndDate').focus();
			}else{
				$('#calendar').fullCalendar('gotoDate', $('#textSearchStartDate').val().substring(0,4));
				$('#calendar').fullCalendar('refetchEvents');
			} */
		},
		
		beforeAdd : function() {
			
		},
		
		goDetail : function(event_id){
			
			var params = $.param({
				eventId : event_id,
				datatype : 'json'
			});
			
			//상세보기로 gogo.
			$.ajax({
				url : "/calendar/selectEventDetail.do",
				async : false,
	 			datatype : 'json',
				mtype: 'POST',
				data : params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					var rowData = data.detail;
					if(!isEmpty(rowData)){
						calendar.setModal(rowData);
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		setModal : function(calEvent, display) {
			//$.ajaxLoadingShow();
			$('#formModalData').validate().resetForm();	
			
			$("#checkboxModalInviteList").val("N");
        	$("#checkboxModalInviteList").prop("checked", false);
        	$("#divModalConviteOption").css("display", "none");
        	$("#hiddenModalEndRuleDate").val("");
        	
        	if(calEvent.EVENT_CODE == 8 || calEvent.EVENT_CODE == 9 || calEvent.EVENT_CODE == 10)
        	{
        		//외부캘린더
        		
	        	modalFlag = "upd";

	        	$("#textModalCountNum").val("");
	        	$("#textModalEndRuleDate").val("");
	        	
	        	var starteventdate = new Date(calEvent.start);
	        	var startyear = starteventdate.getFullYear();
	        	var startmonth = (starteventdate.getMonth() <= 8) ? "0"+(starteventdate.getMonth()+1).toString() : starteventdate.getMonth()+1;
	        	var startdate = (starteventdate.getDate() <= 9) ? "0"+(starteventdate.getDate()).toString() : starteventdate.getDate();
	        	var starthour = (starteventdate.getHours() <= 9) ? "0"+(starteventdate.getHours()).toString() : starteventdate.getHours();
	        	var startmin = (starteventdate.getMinutes() <= 9) ? "0"+(starteventdate.getMinutes()).toString() : starteventdate.getMinutes();
	        	
	        	var endeventdate;
	        	var endyear;
	        	var endmonth;
	        	var enddate;
	        	var endhour;
	        	var endmin;
	        	
	        	if(calEvent.end==null && calEvent.TIME_GAP!=null) {
	        		endeventdate = new Date(calEvent.start);
	        		endeventdate = new Date(Date.parse(endeventdate) + calEvent.TIME_GAP * 1000 * 60);
	        		endyear = endeventdate.getFullYear();
		        	endmonth = (endeventdate.getMonth() <= 8) ? "0"+(endeventdate.getMonth()+1).toString() : endeventdate.getMonth()+1;
		        	enddate = (endeventdate.getDate() <= 9) ? "0"+(endeventdate.getDate()).toString() : endeventdate.getDate();
		        	endhour = (endeventdate.getHours() <= 9) ? "0"+(endeventdate.getHours()).toString() : endeventdate.getHours();
		        	endmin = (endeventdate.getMinutes() <= 9) ? "0"+(endeventdate.getMinutes()).toString() : endeventdate.getMinutes();
        		}else if(calEvent.end!=null) {
		        	endeventdate = new Date(calEvent.end);
		        	endyear = endeventdate.getFullYear();
		        	endmonth = (endeventdate.getMonth() <= 8) ? "0"+(endeventdate.getMonth()+1).toString() : endeventdate.getMonth()+1;
		        	enddate = (endeventdate.getDate() <= 9) ? "0"+(endeventdate.getDate()).toString() : endeventdate.getDate();
		        	endhour = (endeventdate.getHours() <= 9) ? "0"+(endeventdate.getHours()).toString() : endeventdate.getHours();
		        	endmin = (endeventdate.getMinutes() <= 9) ? "0"+(endeventdate.getMinutes()).toString() : endeventdate.getMinutes();
	        	}else {
	        		endeventdate = starteventdate;
		        	endyear = startyear;
		        	endmonth = startmonth;
		        	enddate = startdate;
		        	endhour = starthour;
		        	endmin = startmin;
	        	}
	        		        	
	        	$("h4.modal-title").html(calEvent.title);
	        	$("small.font-bold").html("일정 세부 정보입니다.");
	        	$("#textModalEventSubject2").val(calEvent.title);
	        	$("#selectModalEventCode2").val(calEvent.EVENT_CODE);
	        	$("#selectModalCalendarID2").val(calEvent.CALENDAR_ID);
	        	$("#textareaModalEventDetail2").val(calEvent.EVENT_DETAIL);	//상세내용
	        	
	        	//textarea 높이 계산
				textAreaAutoSize($("#textareaModalEventDetail2"));
	        	
	        	$("#selectModalStartDateTime2").val(startyear+"-"+startmonth+"-"+startdate+"  "+starthour+":"+startmin);
	        	$("#selectModalEndDateTime2").val(endyear+"-"+endmonth+"-"+enddate+"  "+endhour+":"+endmin);
	        	$("#textModalEventLocation2").val(calEvent.LOCATION);
						$("#buttonModalDelete").css('display','');
						rrule.nthOfMonth();
	        	$("#myModalOutlook").modal();
	        	compare_before = $("#formModalData").serialize();
				
        	}else if(calEvent.EVENT_CODE != 5) {
        		//일정초대
        		calendar.selectInviteMemberList(calEvent.EVENT_ID);
        		
	        	modalFlag = "upd";
	        	
	        	$("input:checkbox[name=RRulecheckboxModalByweekday]").each(function (index) {  
   					this.checked=false;
   			    }); 
	        	$("#textModalCountNum").val("");
	        	$("#textModalEndRuleDate").val("");
	        	
	        	if(calEvent.end==null && calEvent.TIME_GAP!=null) {
	        		endeventdate = new Date(calEvent.start);
	        		endeventdate = new Date(Date.parse(endeventdate) + calEvent.TIME_GAP * 1000 * 60);
	        		$("#hiddenModalEndDate").val(moment(endeventdate).format("YYYY-MM-DD"));
	        	}else{
	        		$("#hiddenModalEndDate").val(moment(calEvent.end).format("YYYY-MM-DD"));
	        	}
	        	
	        	var starteventdate = new Date(calEvent.start);
	        	var startyear = starteventdate.getFullYear();
	        	var startmonth = (starteventdate.getMonth() <= 8) ? "0"+(starteventdate.getMonth()+1).toString() : starteventdate.getMonth()+1;
	        	var startdate = (starteventdate.getDate() <= 9) ? "0"+(starteventdate.getDate()).toString() : starteventdate.getDate();
	        	var starthour = (starteventdate.getHours() <= 9) ? "0"+(starteventdate.getHours()).toString() : starteventdate.getHours();
	        	var startmin = (starteventdate.getMinutes() <= 9) ? "0"+(starteventdate.getMinutes()).toString() : starteventdate.getMinutes();
	        	
	        	var endeventdate;
	        	var endyear;
	        	var endmonth;
	        	var enddate;
	        	var endhour;
	        	var endmin;
	        	
	        	if(calEvent.end==null && calEvent.TIME_GAP!=null) {
		        	if(calEvent.allDay==false) {
		        		endeventdate = new Date(calEvent.start);
		        		endeventdate = new Date(Date.parse(endeventdate) + calEvent.TIME_GAP * 1000 * 60);
			        	endyear = endeventdate.getFullYear();
			        	endmonth = (endeventdate.getMonth() <= 8) ? "0"+(endeventdate.getMonth()+1).toString() : endeventdate.getMonth()+1;
			        	enddate = (endeventdate.getDate() <= 9) ? "0"+(endeventdate.getDate()).toString() : endeventdate.getDate();
			        	endhour = (endeventdate.getHours() <= 9) ? "0"+(endeventdate.getHours()).toString() : endeventdate.getHours();
			        	endmin = (endeventdate.getMinutes() <= 9) ? "0"+(endeventdate.getMinutes()).toString() : endeventdate.getMinutes();
	        		}else if(calEvent.allDay==true) {
	        			endeventdate = new Date(calEvent.start);
		        		endeventdate = new Date(Date.parse(endeventdate) + calEvent.TIME_GAP * 1000 * 60);
	        			endeventdate.setDate(endeventdate.getDate()-1);
			        	endyear = endeventdate.getFullYear();
			        	endmonth = (endeventdate.getMonth() <= 8) ? "0"+(endeventdate.getMonth()+1).toString() : endeventdate.getMonth()+1;
			        	enddate = (endeventdate.getDate() <= 9) ? "0"+(endeventdate.getDate()).toString() : endeventdate.getDate();
			        	endhour = (endeventdate.getHours() <= 9) ? "0"+(endeventdate.getHours()).toString() : endeventdate.getHours();
			        	endmin = (endeventdate.getMinutes() <= 9) ? "0"+(endeventdate.getMinutes()).toString() : endeventdate.getMinutes();
	        		}
        		}else if(calEvent.end!=null) {
	        		if(calEvent.allDay==false) {
			        	endeventdate = new Date(calEvent.end);
			        	endyear = endeventdate.getFullYear();
			        	endmonth = (endeventdate.getMonth() <= 8) ? "0"+(endeventdate.getMonth()+1).toString() : endeventdate.getMonth()+1;
			        	enddate = (endeventdate.getDate() <= 9) ? "0"+(endeventdate.getDate()).toString() : endeventdate.getDate();
			        	endhour = (endeventdate.getHours() <= 9) ? "0"+(endeventdate.getHours()).toString() : endeventdate.getHours();
			        	endmin = (endeventdate.getMinutes() <= 9) ? "0"+(endeventdate.getMinutes()).toString() : endeventdate.getMinutes();
	        		}else if(calEvent.allDay==true) {
	        			endeventdate = new Date(calEvent.end);
	        			endeventdate.setDate(endeventdate.getDate()-1);
			        	endyear = endeventdate.getFullYear();
			        	endmonth = (endeventdate.getMonth() <= 8) ? "0"+(endeventdate.getMonth()+1).toString() : endeventdate.getMonth()+1;
			        	enddate = (endeventdate.getDate() <= 9) ? "0"+(endeventdate.getDate()).toString() : endeventdate.getDate();
			        	endhour = (endeventdate.getHours() <= 9) ? "0"+(endeventdate.getHours()).toString() : endeventdate.getHours();
			        	endmin = (endeventdate.getMinutes() <= 9) ? "0"+(endeventdate.getMinutes()).toString() : endeventdate.getMinutes();
	        		}
	        	}else {
	        		endeventdate = starteventdate;
		        	endyear = startyear;
		        	endmonth = startmonth;
		        	enddate = startdate;
		        	endhour = starthour;
		        	endmin = startmin;
	        	}
	        	
	        	$("h4.modal-title").html(calEvent.title);
	        	$("small.font-bold").html("일정 세부 정보입니다.");
	        	
	        	$("#textModalEventLocation").val(calEvent.LOCATION);
	        	$("#textModalEventSubject").val(calEvent.title);
	        	$("#selectModalEventCode").val(calEvent.EVENT_CODE);
	        	$("#selectModalCalendarID").val(calEvent.CALENDAR_ID);
	        	$("#textareaModalEventDetail").val(calEvent.EVENT_DETAIL);	//상세내용
	        	
	        	// outlook ID 2019.10.11 추가
	        	$("#hiddenModalOutlookId").val(calEvent.OUTLOOK_ID);
	        	
	        	// SyncFlag 추가
	        	$("#hiddenModalSyncFlag").val(calEvent.SYNC_FLAG);
	        	
	        	// Recurrence Id (rrule id) 추가
	        	$("#hiddenModalRruleId").val(calEvent.RECURRENCE_ID );
	        	
	        	// 단일일정(반복일정 중 단일로 수정한 일정)/반복일정 구분 추가
	        	$("#hiddenModalExEventYn").val(calEvent.EX_EVENT_YN);
	        	
	        	//textarea 높이 계산
						textAreaAutoSize($("#textareaModalEventDetail"));
	        	
	        	$("#textModalStartDate").val(startyear+"-"+startmonth+"-"+startdate);
	        	startDateCmp = startyear+"-"+startmonth+"-"+startdate;
	        	$("#hiddenModalOrgStartDate").val(startyear+"-"+startmonth+"-"+startdate);
	        	$("#selectModalStartDateTime").val(starthour+":"+startmin);
	        	$("#textModalEndDate").val(endyear+"-"+endmonth+"-"+enddate);
	        	$("#selectModalEndDateTime").val(endhour+":"+endmin);
	        	$("#hiddenModalRruleString").val('');
	        	
	        	$("#textModalEventLocation").val(calEvent.LOCATION);
	        	$("#selectModalSyncId").val(calEvent.SYNC_YN);
	        	
	        	if(calEvent.allDay==false) {
	        		$("#checkboxModalAllday").val("N");
	        		$("#hiddenModalAllday_YN").val("N");
	        		$("#checkboxModalAllday").prop("checked", false);
	        		$("#selectModalStartDateTime").css("display", "");
					$("#selectModalEndDateTime").css("display", "");
	        		//$("#selectModalStartDateTime").attr("disabled", false); 
	        		//$("#selectModalEndDateTime").attr("disabled", false);
	        	}else if(calEvent.allDay==true){
	        		$("#checkboxModalAllday").val("Y");
	        		$("#hiddenModalAllday_YN").val("Y");
	        		$("#checkboxModalAllday").prop("checked", true);
	        		$("#selectModalStartDateTime").val(""); $("#selectModalStartDateTime").css("display", "none");
					$("#selectModalEndDateTime").val(""); $("#selectModalEndDateTime").css("display", "none");
	        		//$("#selectModalStartDateTime").val(""); $("#selectModalStartDateTime").attr("disabled", true); 
	        		//$("#selectModalEndDateTime").val(""); $("#selectModalEndDateTime").attr("disabled", true);
	        	}
	        	
	        	$("#hiddenModalFollowingStartDate").val("");
	        	$("#hiddenModalAllEventsStartDate").val("");
	        	
	        	//REPEAT_YN 값 어디감?, REPEAT_Y는 위에 반복 설정에서 세팅
	        	if(calEvent.REPEAT_YN=="Y" || calEvent.REPEAT_Y=="Y") {
	        		$("#checkboxModalRepeat").val("Y");
	        		$("#hiddenModalRepeat_YN").val("Y");
	        		$("#checkboxModalRepeat").prop("checked", true);
	        		$("#selectModalFreq").val(calEvent.RECURRENCE_FREQ);
	        		$("#hiddenModalAllEventsStartDate").val(calEvent.FIRST_EVENT_START_DATE);
	        		
	        		if(calEvent.RECURRENCE_FREQ=='1'){
	        			rrule.selectFreq($("#selectModalFreq")["0"]);
	        			$("#divModalMonthlyByweekday").show();
	        			$("#divModalElseByweekday").hide();
	        			if(isEmpty(calEvent.RECURRENCE_BYWEEKDAY)){
	        				$('input:radio[name=divModalMonthlyRule]')["0"].checked=true;
	        			}else{
	        				$('input:radio[name=divModalMonthlyRule]')["1"].checked=true;
	        			}
	        		}else if(calEvent.RECURRENCE_FREQ=='2'){
	        			rrule.selectFreq($("#selectModalFreq")["0"]);
	        			$("#divModalMonthlyByweekday").hide();
	        			$("#divModalElseByweekday").show();
	        		}else if(calEvent.RECURRENCE_FREQ=='3'){
	        			rrule.selectFreq($("#selectModalFreq")["0"]);
	        			$("#divModalMonthlyByweekday").show();
	        			$("#divModalElseByweekday").hide();
	        			if(isEmpty(calEvent.RECURRENCE_BYWEEKDAY)){
	        				$('input:radio[name=divModalMonthlyRule]')["0"].checked=true;
	        			}else{
	        				$('input:radio[name=divModalMonthlyRule]')["1"].checked=true;
	        			}
	        		}
	        		$("#selectModalInterval").val(calEvent.RECURRENCE_INTERVAL);
	        		if(calEvent.RECURRENCE_BYWEEKDAY!=undefined) {
	        			var byWeekDay = calEvent.RECURRENCE_BYWEEKDAY.substring(6, calEvent.RECURRENCE_BYWEEKDAY.length).split(',');
	        			$('input:checkbox[name="RRulecheckboxModalByweekday"]').prop("checked", false);
	        			for(var i=0; i<byWeekDay.length; i++) {
	        				$("#checkboxModalRRule" + byWeekDay[i]).prop("checked", true);
	        			}
	        		}
	        		if(calEvent.RECURRENCE_BYMONTHDAY!=undefined) {
	        			var byMonthDay = calEvent.RECURRENCE_BYMONTHDAY.charAt(0);
	        			if(byMonthDay != '+' && byMonthDay != '-'){
	        				$('input:radio[name="divModalMonthlyRule"]:input[value="BYMONTHDAY"]').prop("checked", true);
	        			}else{
	        				$('input:radio[name="divModalMonthlyRule"]:input[value="BYDAY"]').prop("checked", true);
	        			}
	        		}
	        		if(calEvent.RECURRENCE_END_DATE!=undefined) {
	        			$("#checkboxModalEndRuleDate").prop("checked", true);
	        			$("#textModalEndRuleDate").val(calEvent.RECURRENCE_END_DATE);
	        			$("#textModalEndRuleDate").attr("disabled", false);
	        			$("#textModalCountNum").attr("disabled", true);
	        		}else if(calEvent.RECURRENCE_COUNT==500) {
	        			$("#radioModalCountNull").prop("checked", true);
	        			$("#textModalEndRuleDate").attr("disabled", true);
	        			$("#textModalCountNum").attr("disabled", true);
	        		}else if(calEvent.RECURRENCE_COUNT<500 || calEvent.RECURRENCE_COUNT>500) {
	        			$("#radioModalCountNum").prop("checked", true);
	        			$("#textModalCountNum").val(calEvent.RECURRENCE_COUNT);
	        			$("#textModalEndRuleDate").attr("disabled", true);
	        			$("#textModalCountNum").attr("disabled", false);
	        		}else {
	        			$("#radioModalCountNull").prop("checked", true);
	        			$("#textModalCountNum").val("");
	        			$("#textModalCountNum").attr("disabled", true);
	        			$("#textModalEndRuleDate").val("");
	        			$("#textModalEndRuleDate").attr("disabled", true);
	        		}
	        		$("#hiddenModalRruleString").val(calEvent.RECURRENCE_RULE);
	        		rrule.getRepeat($("#hiddenModalRruleString").val());
	        		$("#divModalRepeatOption").css("display", "none");
	        		$("#labelModalRepeat").show();
	        	}else if(calEvent.REPEAT_YN=="N" || calEvent.REPEAT_YN==null) {
	        		$("#checkboxModalRepeat").val("N");
	        		$("#hiddenModalRepeat_YN").val("N");
	        		$("#checkboxModalRepeat").prop("checked", false);
	        		$("#divModalRepeatOption").css("display", "none");
	        		$("#labelModalRepeat").hide();
	        	}
	        	
	        	if(calEvent.SHARE_YN=="Y"){
	        		$("#radioModalShareY").prop("checked", true);
	        		//$("input:radio[name='radioModalShareYN']:radio[value='Y']").prop("checked", true);
	        	}else if (calEvent.SHARE_YN=="N"){
	        		$("#radioModalShareN").prop("checked", true);
	        		//$("input:radio[name='radioModalShareYN']:radio[value='N']").prop("checked", true);
	        	}
	        	
	        	$("#selectModalAlam").val(calEvent.ALARM_TARGET);
	        	if(calEvent.ALARM_FLAG=="H"){
	        		//한시간전
	        		$("#radioModalAlam1").prop("checked", true);
	        	}else if(calEvent.ALARM_FLAG=="D"){
	        		//하루전
	        		$("#radioModalAlam2").prop("checked", true);
	        	}else if(calEvent.ALARM_FLAG=="W"){
	        		//일주일전
	        		$("#radioModalAlam3").prop("checked", true);
	        	}else {
	        		$("#radioModalAlam0").prop("checked", true);
	        	}
	        	/* 
	        	if(calEvent.MOVE_TIME_MIN=="" || calEvent.MOVE_TIME_MIN==null) {
	        		$("#checkboxModalMove").val("N");
	        		$("#checkboxModalMove").prop("checked", false);
	        		$("#divModalMoveOption").css("display", "none");
	        	}else {
	        		$("#checkboxModalMove").val("Y");
	        		$("#checkboxModalMove").prop("checked", true);
	        		$("#divModalMoveOption").css("display", "");
	        		$("#selectModalBeforeMoveTimeMin").val(calEvent.BEFORE_MOVE_TIME);
	        		$("#selectModalAfterMoveTimeMin").val(calEvent.AFTER_MOVE_TIME);
	        	}
	        	 */
	        	if(calEvent.BEFORE_MOVE_TIME =="" || calEvent.BEFORE_MOVE_TIME==null){
	        		$("#divModalEventCode").css("display", "none");
	        	}else{
	        		$("#divModalEventCode").css("display", "");
	        		$("#selectModalBeforeMoveTimeMin").val(calEvent.BEFORE_MOVE_TIME);
	        	}
	        	if(calEvent.AFTER_MOVE_TIME =="" || calEvent.AFTER_MOVE_TIME==null){
	        		$("#divModalEventCode2").css("display", "none");
	        	}else{
	        		$("#divModalEventCode2").css("display", "");
	        		$("#selectModalAfterMoveTimeMin").val(calEvent.AFTER_MOVE_TIME);
	        	}

	        	$("div.company-current").html("");
	        	$("#hiddenModalMemberList").val("");
	        	 
        	 	if($("#selectModalEventCode option:selected").attr('id')=='meeting') {
					$("#divModalEventCode").show();
					$("#divModalEventCode2").show();
				}else {
					$("#divModalEventCode").hide();
					$("#divModalEventCode2").hide();
				}
	        	 
	        	//일단 무조건 체크 해제
	        	$("#checkboxModalInvite").val("N");
        		$("#checkboxModalInvite").prop("checked", false);
        		$("#divModalConviteOption").css("display", "none");
	        	
	        	$("#textModalInviteName").val(calEvent.INVITE_NAME);
	        	$("#textModalInviteId").val(calEvent.INVITE_MEMBER_ID);
	        	$("#textModalInviteMail").val(calEvent.INVITE_EMAIL);
	        	$("#textModalInviteCalendarId").val(calEvent.INVITE_CALENDAR_ID);
	        	$("#hiddenModalEventId").val(calEvent.EVENT_ID);
	        	$("#hiddenModalEXDate_YN").val(calEvent.EX_DATE_YN);
	        	$("#hiddenModalRruleDateOrder").val(calEvent.RECURRENCE_DateOrder);
	        	$("#hiddenModalRruleSyncId").val(calEvent.RRULE_SYNC_ID);
	        	$("#hiddenModalRuleByweekday").val(calEvent.RECURRENCE_BYWEEKDAY);
	        	$("#hiddenModalGoogleId").val(calEvent.GOOGLE_ID);
	        	$("#hiddenModalGoogleCalendarId").val(calEvent.GOOGLE_CALENDAR_ID);
	        	/* if($("#hiddenModalRruleSyncId").val() != null && $("#hiddenModalRruleSyncId").val() != ""){
	        		$("#checkboxModalRepeat").parent().hide();
	        	}else{
	        		$("#checkboxModalRepeat").parent().show();
	        	} */
	        	
	        	
	        	$("#hiddenModalMemberList").val("");
	        	commonSearch.multipleMemberArray=[];
	        	
				$("#buttonModalSubmit").html("저장하기");
				$("#buttonModalMailSubmit").html("저장하고 메일보내기");
				$("#buttonModalDelete").css('display','');
				rrule.nthOfMonth();
				
				$(".repeat_upd_msg_pop").hide();
				$(".repeat_upd_msg_pop2").hide();
				$(".repeat_del_msg_pop").hide();
				
				$.ajaxLoadingHide();
				if(!display){
	        		$("#myModal1").modal();
				}
	        	
	        	compare_before = $("#formModalData").serialize();
        	}
		},
		
		inviteMemberDel : function(event_id, invite_id, calendar_id) {
			
			var params = $.param({
				event_id : event_id,
				invite_id : invite_id,
				calendar_id : calendar_id,
				datatype : 'json'
			});
			
			$.ajax({
				url : "/calendar/deleteInviteMemberList.do",
				datatype : 'json',
				data :params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!compareFlag) {
						if(!confirm("참석자를 삭제하시겠습니까?")) return false;
	            	}
					//$.ajaxLoadingShow();
				},
				success : function(data){
					alert("참석자를 삭제하였습니다.");
					calendar.completeReload(event_id);
					compare_before = $("#formModalData").serialize();
				},
				complete : function(){
					
				}
			});
		},
		
		completeReload : function(event_id){
			$('tbody#tbodyModalInviteList tr').remove();
			$("#tbodyModalInviteList").html('');
			calendar.selectInviteMemberList(event_id);
		},
		
		selectInviteMemberList : function(event_id) {
			var params = $.param({
				hiddenModalEventId : event_id,
				datatype : 'json'
			});
			
			$.ajax({
				url : "/calendar/getInviteMemberList.do",
				datatype : 'json',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				data :params,
				success : function(data){
					/* $("#checkboxModalInviteList").val("Y");
		        	$("#checkboxModalInviteList").prop("checked", true);
		        	$("#divModalConviteOption").css("display", ""); */
					$("#formModalData .invite-area-list").html('');
		        	$("#formModalData .invite-area-list").html('<h3 class="ag_c">참석자 리스트</h3>' 
                            + '<table class="basic2">'
                            + '<colgroup>'
                               + '<col width=""/>'
                               + '<col width=""/>'
                               + '<col width=""/>'
                               + '<col width=""/>'
                               + '<col width=""/>'
                           + ' </colgroup>'
                           + ' <thead> '
                           + '     <tr> '
                           + '         <th>이름</th> '
                           + '         <th>발신상태</th> '
                           + '         <th>수락여부</th> '
                          /*  + '         <th>수락시간</th> ' */
                           + '         <th>삭제</th> ' 
                           + '     </tr> '
                           + ' </thead>'
                           + ' <tbody id="tbodyModalInviteList">'
                           + ' </tbody>'
                           + ' </table>');  
		        	
					for(i=0; i<data.InviteMemberList.length; i++){
						$("#tbodyModalInviteList").append('<tr>');
						$("#tbodyModalInviteList").append('<td style="text-align:center;">'+data.InviteMemberList[i].HAN_NAME+'</td>');
						$("#tbodyModalInviteList").append('<td style="text-align:center;">'+data.InviteMemberList[i].SEND_STATUS_YN+'</td>');
						$("#tbodyModalInviteList").append('<td style="text-align:center;">'+data.InviteMemberList[i].INVITE_YN+'</td>');
						$("#tbodyModalInviteList").append('<td style="text-align:center;"><a onClick=calendar.inviteMemberDel('+event_id+','+data.InviteMemberList[i].INVITE_ID+','+data.InviteMemberList[i].CALENDAR_ID+')><i class="fa fa-times-circle fc_gray"></i></a></td>');
						$("#tbodyModalInviteList").append('</tr>');
						
						/* $("#formModalData .invite-area-list").append('<div class="col-sm-4">'+data.InviteMemberList[i].EMAIL+'</div>'); */
						/* $("#formModalData .invite-area-list").append('<div class="col-sm-4">'+moment(data.InviteMemberList[i].SYS_UPDATE_DATE).format('YYYY[-]MM[-]DD HH:mm:ss')+'</div>'); */
						/* $("#formModalData .invite-area-list").append('</div>'); */
					}
					if(data.InviteMemberList.length > 0){
						$("#checkboxModalInvite").val("Y");
		        		$("#checkboxModalInvite").prop("checked", true);
		        		$("#divModalConviteOption").css("display", "");
		        		$("#buttonModalMailSubmit").css("display", "");
					}else{
						$("#checkboxModalInvite").val("N");
		        		$("#checkboxModalInvite").prop("checked", false);
		        		$("#divModalConviteOption").css("display", "none");
		        		$("#buttonModalMailSubmit").css("display", "none");
					}
					compare_before = $("#formModalData").serialize();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		/* companyCalendarPopup : function() {
			$('#divPopupOtherCalndar_Office365').show();
			$('#divPopupOtherCalndar_Outlook').hide();
			$('#divPopupOtherCalndar_Google').hide();
			$('#divPopupOtherCalndar_General').hide();
		},
		otherCalendarPopup : function() {
				$('#divPopupOtherCalndar_Office365').hide();
				$('#divPopupOtherCalndar_Outlook').hide();
				$('#divPopupOtherCalndar_Google').show();
				$('#divPopupOtherCalndar_General').hide();
		}, */
		/* 
		outCalendarSync : function(calendarId, syncYN) {
			$.ajax({
				url : "/calendar/outCalendarSync.do",
				data :{
					calendarId : calendarId,
					syncYN : syncYN
				},
				async : false,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					if(data.syncYN=='Y') {
						alert("Office365 일정에 Sync 됩니다.");
					}else {
						alert("Office365 일정에 Sync 되지 않습니다.");
						}
					window.location.reload();
				},
				complete : function(){
					
				}
			});
		},
		 */
		addCalendar : function(){
			if($("#textCalendarName").val() != '' && $("#textCalendarName").val() != null){
				
				var params = $.param({
					hiddenModalCreatorId : $("#hiddenModalCreatorId").val(),
//					textCalendarName : '나의 캘린더'
					textCalendarName : $("#textCalendarName").val(),
					datatype : 'json'
				});
				
				$.ajax({
					url : "/calendar/addCalendar.do",
					datatype : 'json',
					data :params,
					async : false,
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
					success : function(data){
						//if($("#textCalendarName").val() != '나의 캘린더') alert($("#textCalendarName").val()+"를 생성했습니다.");
						window.location.reload();
						alert("나의 캘린더가 생성되었습니다.");
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			}
		},
		addOtherCalendar : function(){
			if($("#textCalendarName").val() != '' && $("#textCalendarName").val() != null){
				var params = $.param({
					hiddenModalCreatorId : $("#hiddenModalCreatorId").val(),
					textCalendarName : $("#textCalendarName").val(),
					datatype : 'json'
				});
				
				$.ajax({
					url : "/calendar/addCalendar.do",
					datatype : 'json',
					data :params,
					async : false,
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
					success : function(data){
						alert($("#textCalendarName").val()+"를 생성했습니다.");
						window.location.reload();
					},
					complete: function(){
						
					}
				});
			}
		},
		deleteCalendar : function(calendarId, calendarName, calendarType) {
			if(calendarId != '' && calendarId != null) {
				$.ajax({
					url : "/calendar/deleteCalendar.do",
					data :{
						hiddenModalCreatorId : $("#hiddenModalCreatorId").val(),
						calendarId : calendarId,
						calendarName : calendarName,
						calendarType : calendarType
					},
					async : false,
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
					success : function(data){
						//alert("캘린더를 삭제했습니다.");
						window.location.reload();
					},
					complete : function(){
						
					}
				});
			}
		},
		reNameCalendar : function(calendarId, select) {
			if(calendarId != '' && calendarId != null) {
				
				var params = $.param({
					calendarId : calendarId,
					calendarName : $(select).prev().val(),
					datatype : 'json'
				});
				
				$.ajax({
					url : "/calendar/reNameCalendar.do",
					datatype : 'json',
					data :params,
					async : false,
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
					success : function(data){
						alert("캘린더 이름을 수정했습니다.");
						window.location.reload();
					},
					complete : function(){
						
					}
				});
			}
		},
		outlookCal : function(id, password){
			var flag = "outlook";
			var $other=$("#calendar-other-outlook").children();
			if($other.size()==0) {
				$("#textCalendarName").val("아웃룩 캘린더");
				calendar.addOtherCalendar();
			}
			
			var params = $.param({
				outlookId : id,
				outlookPassword : password,
				creatorId : $("#hiddenModalCreatorId").val(),
				flag : flag,
				datatype : 'html',
				jsp : '/calendar/calendarView'
			});
			
			$.ajax({
				url : "/calendar/outlookCalendar.do",
				datatype : 'json',
				data :params,
				async : false,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					alert("로그인 접속을 시도합니다.");
					window.location.reload();
				},
				complete : function(){
					
				}
			});
		},
		
		selectRange : function(id) {
			if($(id).val() == '' || $(id).val() == null){
				$(id).val('@unipoint.co.kr');
			}
			
			var start = $(id).val().indexOf('@');
			
			return $(id).each(function() {
		         if(id.setSelectionRange) {
		        	 id.focus();
		        	 id.setSelectionRange(start, start);
		         } else if(id.createTextRange) {
		             var range = id.createTextRange();
		             range.collapse(true);
		             range.moveEnd('character', start);
		             range.moveStart('character', start);
		             range.select();
		         }
		     });
		},
		
		office365Cal : function(id, password){
			var flag = "office365";
			var $other=$("#calendar-other-office365").children();
			
			var params = $.param({
				outlookId : id,
				outlookPassword : password,
				creatorId : $("#hiddenModalCreatorId").val(),
				textCalendarName : "Office365 캘린더",
				flag : flag,
				datatype : 'html',
				jsp : '/calendar/calendarView'
			});
			
			if((id != null && id != '') && (password != null && password != '')){
				$.ajax({
					url : "/calendar/outlookCalendar.do",
					datatype : 'json',
					data :params,
					async : false,
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
					success : function(data){
						//alert("로그인 접속을 시도합니다.");
						window.location.reload();
					},
					complete : function(){
						
					}
				});
			}
		},
		makeICS : function() { //사용안함
			$.ajax({
				url : "/calendar/makeICS.do",
				datatype : 'json',
				data :{
					creatorId : $("#hiddenModalCreatorId").val(),
				},
				async : false,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					alert("ICS 파일을 생성하였습니다.");
					window.location.reload();
				},
				complete : function(){
					
				}
			});
		},
		//구글 인증
		googleOAuth : function(c){
			var params = $.param({
				category : c
			});
			$.ajax({
				url : "/calendar/googleOAuth.do",
				datatype : 'json',
				data :params,
				async : false,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					window.location.reload();
				},
				complete : function(){
					
				}
			});
		},
		/* downICS : function(downURL, calendarId) {
			//alert($("#hiddenModalCreatorId").val());
			var $other=$("#calendar-other-google").children();
			if($other.size()==0) {
				$("#textCalendarName").val("구글 캘린더");
				calendar.addOtherCalendar();
			}
			 var params = $.param({
				 	downURL : downURL,
					calendar : calendarId,
					creatorId : $("#hiddenModalCreatorId").val(),
					datatype : 'json'
				});
			 
			$.ajax({
				url : "/calendar/downICS.do",
				datatype : 'json',
				data :params,
				async : false,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					//alert("ICS URL을 등록하였습니다.");
					window.location.reload();
				},
				complete : function(){
					
				}
			});
		}, */
		scheduleCheck : function() {
			$('#calendar').fullCalendar({
				eventRender: function(event, element){
					($("#checkboxCalendarSchedule").is(":checked")) ? element.css("display", "none") : ("");
				}
			});
		},
		shareCalView : function(shareMemberId){
			 /* window.open("http://sellers.unipoint.co.kr:30000:8080/calendar/calendarOfColleagueView.do?&shareMemberId="+shareMemberId, "동료캘린더창", "width=1300px, height=800px, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); */   
			 /* window.open("http://sellers.unipoint.co.kr:30000/calendar/calendarOfColleagueView.do?&shareMemberId="+shareMemberId, "동료캘린더창", "width=1000, height=750, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); */
			 window.open("http://" + location.host + "/calendar/calendarOfColleagueView.do?&shareMemberId="+shareMemberId, "동료캘린더창", "width=1000, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );
		},
		draw : function(year, month) {
// 			if(!isEmpty(year))alert(year+'-'+month);

			var d = date.getDate();
		    var m = date.getMonth();
		    var y = date.getFullYear();
		    var intiData = [];
		    var events;
			$('#calendar').fullCalendar({
				scrollTime: moment().format('HH:mm:ss'), //주간, 일간 자동 스크롤
				dayClick: function(date, jsEvent, view) {
			        modal.reset(date.format());
			       /*  alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);
			        alert('Current view: ' + view.name);
			        // change the day's background color just for fun
			        $(this).css('background-color', 'red'); */
			    },
				
				events: function(start, end, timexone, callback, event) {
					var nowDate = $('#calendar').fullCalendar('getDate');
					
	        		var selectYear = nowDate.format('YYYY');
	        		var selectMonth = nowDate.format('MM');
					
					$.ajax({
						url: '/calendar/calendarEventList.do',
                  		datatype : 'json',
                  		beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
                  			$.ajaxLoadingShow();
                  		},
              			data : {
              				datatype : 'json',
               				hiddenUserId : $("#userIdNum").val(),
               				hiddenModalCreatorId : $("#hiddenModalCreatorId").val(),
               				textSearchStartDate : $("#textSearchStartDate").val(),
               				textSearchEndDate : $("#textSearchEndDate").val(),
               				textSearch : $("#textSearch").val(),
               				
               				selectYear : selectYear,
               				selectMonth : selectMonth,
               				
               				startDate : start._d.toISOString().slice(0, 10),
               				endDate : end._d.toISOString().slice(0, 10),
               				
               				//hiddenMemberIdNum : $("#hiddenMemberIdNum").val(),
               				outlook : function(){
               					var outlook = '';
               					$("input[name='checkboxCalendarId']:checked").each(function(i,v){
               						if($(this).val() == 'outlook') {
               							outlook = 'outlook';
               						}else {
               							outlook='N';
               						}
               					});
               					return outlook.toString();
               				},
               				office365 : function(){
                   				var office365 = '';
               					$("input[name='checkboxCalendarId']:checked").each(function(i,v){
               						if($(this).val() == 'office365') {
               							office365='office365';
               						}else {
               							office365='N';
               						}
               					});
               					return office365.toString();
               				},
               				google : function(){
                   				var google = '';
               					$("input[name='checkboxCalendarGoogleId']:checked").each(function(i,v){
               							google='google';
               					});
               					return google.toString();
               				},
               				calendarGoogleCheck_id : function(){
               					var calendarGoogleCheck_id = [];
               					$("input[name='checkboxCalendarGoogleId']:checked").each(function(i,v){
               							calendarGoogleCheck_id.push($(this).val());
               					});
               					return calendarGoogleCheck_id.toString();
               				},
               				calendarCheck_id : function(){
               					var outlook = '';
                   				var office365 = '';
                   				var google = '';
               					var calendarCheck_id = [];
               					$("input[name='checkboxCalendarId']:checked").each(function(i,v){
               						if($(this).val() != 'outlook' && $(this).val() != 'office365' && $(this).val() != 'google') {
               							calendarCheck_id.push($(this).val());
               						}
               					});
               					return calendarCheck_id.toString();
               				},
               				thisMonthHoliday_id : function (view, element) {
               					var b = $('#calendar').fullCalendar('getDate');
    							return b._i[0]+'%';
               				}
               			},
               			success: function(data) {
               				if(data.googleCalendar != null) {
               					var seconds = 1000;
               					var minutes = seconds*60;
               					var mEnd = "";
               					var mStart = "";
               					var ynChk = "";
               					var ruleChk = "";
               					for(var i=0; i<data.googleCalendar.length; i++) {
               						mEnd = new Date(moment(data.googleCalendar[i].start).format('YYYY[-]MM[-]DD HH:mm:ss'));
               						mStart = new Date(moment(data.googleCalendar[i].end).format('YYYY[-]MM[-]DD HH:mm:ss'));
               						diff = (mEnd - mStart);
               						if(data.googleCalendar[i].RECURRENCE_RULE != undefined) {
               							ynChk = "Y";
               							ruleChk = data.googleCalendar[i].RECURRENCE_RULE;
               						}
               						data.events.push({
	       								start: moment(data.googleCalendar[i].start).format('YYYY[-]MM[-]DD HH:mm:ss'),
	       								end: moment(data.googleCalendar[i].end).format('YYYY[-]MM[-]DD HH:mm:ss'),
	       								EVENT_DETAIL: data.googleCalendar[i].EVENT_DETAIL,
	       								LOCATION: data.googleCalendar[i].LOCATION,
	               						title: data.googleCalendar[i].title,
	               						EVENT_CODE: '10',
	               						textColor: 'black',
	               					 	backgroundColor: data.googleCalendar[i].color,
	               						TIME_GAP: diff/minutes,
	               						CALENDAR_TYPE: 'google',
	               						REPEAT_YN: ynChk,
	               						RECURRENCE_RULE: ruleChk,
	               						allDay: data.googleCalendar[i].allDay,
	               						RECURRENCE_RULE_EVENT_ID: data.googleCalendar[i].RECURRENCE_RULE_EVENT_ID
	               					});
               						ynChk = "";
               						ruleChk = "";
               						
	               				}
               				}
               				
        					for(var i=0; i<data.events.length; i++) {
                   				if(typeof(data.events[i].allDay)=="string"){
                   					data.events[i].allDay = parseInt(data.events[i].allDay);
                   				}
               				}
               				
               				for(var i=0; i<data.holidays.length; i++) {
               					data.events.push({
               						title: data.holidays[i].title,
       								start: data.holidays[i].start,
     					            allDay: data.holidays[i].allDay,
     					            rendering: data.holidays[i].rendering,
     					            HOLIDAY_TYPE: data.holidays[i].HOLIDAY_TYPE
               					});
               				}
               				
               				//이거 뭐냐
               				/* if(data.googleCalendar != null) {
	               				 for(var i=0; i<data.googleCalendar.length; i++) {
	           						//alert(diff+"_"+diff/seconds+"_"+diff/minutes);
	               					data.events.push({
	       								start: data.googleCalendar[i].start,
	       								end: data.googleCalendar[i].end,
	       								EVENT_DETAIL: data.googleCalendar[i].DESCRIPTION +"_"+data.googleCalendar[i].LOCATION,
	               						title: data.googleCalendar[i].SUMMARY
	               					});
	               				}
               				} */
               				
               				if(data.outlookCalList != undefined) {
	               				if(data.outlookCalList[0].errStatus == 0){
	               					alert(data.outlookCalList[0].errMsg);
	               				}else if(data.outlookCalList[0].errStatus == 1){
		               				if(data.outlookCalList !=null){
		               					 for(var i=0; i<data.outlookCalList.length; i++){
		               						data.events.push({
		               							start : data.outlookCalList[i].DTSTART,
		               							end : data.outlookCalList[i].DTEND,
		               							title: data.outlookCalList[i].SUMMARY,
		               							EVENT_DETAIL: data.outlookCalList[i].DESCRIPTION,
		               							CALENDAR_ID: data.outlookCalList[i].CALENDAR_ID,
		               							EVENT_CODE: '9',
			               						textColor: 'black',
			               					 	backgroundColor: 'white'
		               						});
		               					}
		               				} 
	               				}else{
	               				}
               				}
               				if(data.office365Calendar != undefined) {
	               				if(data.office365Calendar[0].errStatus == 0){
	               					alert(data.office365Calendar[0].errMsg);
	               					window.location.reload();
	               				}else if(data.office365Calendar[0].errStatus == 1){
		               				if(data.office365Calendar !=null){
		               					 for(var i=0; i<data.office365Calendar.length; i++){
		               						data.events.push({
		               							start : data.office365Calendar[i].DTSTART,
		               							end : data.office365Calendar[i].DTEND,
		               							title: data.office365Calendar[i].SUMMARY,
		               							EVENT_DETAIL: data.office365Calendar[i].DESCRIPTION,
		               							CALENDAR_ID: data.office365Calendar[i].CALENDAR_ID,
		               							LOCATION: data.office365Calendar[i].LOCATION,
		               							EVENT_CODE: '8',
			               						textColor: 'black',
			               					 	backgroundColor: 'white'
		               						});
		               					}
		               				} 
	               				}else if(data.office365Calendar[0].errStatus == 9){
	               					//alert(data.office365Calendar[0].errMsg);
	               				}else{
	               					alert(data.office365Calendar[0].errMsg);
	               				}
               				}
               				
               				textColor: 'black' // a non-ajax option 
               				callback(data.events);
               				//callback(events);
               				
               				var calendarEvents = $('input[name="checkboxCalendarId"]');
               			},
               			complete: function() {
        					$.ajaxLoadingHide();
    					}
                  		
              });
					// any other sources...
			}, //end events
			eventRender: function(event, element){
				if(event.rendering == 'background') {
   					element.append(event.title);
   					element.css({opacity: "inherit", float: "left", background: "none", color: "red"});
				}/* else if(event.CALENDAR_TYPE == 'google') {
					element.append('G');
				} */
				switch(event.EVENT_CODE) {
					case '1': //고객컨택
						element.css({"color":"#2c2f30", "border":"none", "background-color":"#d0edfc"});
						element.find("div.fc-content").prepend("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon1.png\" class=\"v-m\">"); 
						element.find("td.fc-list-item-marker.fc-widget-content").html("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon1.png\" class=\"v-m\">");
						if(element[0].className=="fc-time-grid-event fc-v-event fc-event fc-start fc-end") {
							//element.find("div .fc-time").contents().unwrap().wrap('<span class="fc-time"></span>');
							element.find("div .fc-time").remove();
							element.find("div .fc-title").contents().unwrap().wrap('<span class="fc-title"></span>');
						};
					break;
					case '2': //컨택준비
						element.css({"color":"#2c2f30", "border":"none", "background-color":"#d4edef"});
						element.find("div.fc-content").prepend("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon2.png\" class=\"v-m\">"); 
						element.find("td.fc-list-item-marker.fc-widget-content").html("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon2.png\" class=\"v-m\">"); 
						if(element[0].className=="fc-time-grid-event fc-v-event fc-event fc-start fc-end") {
							//element.find("div .fc-time").contents().unwrap().wrap('<span class="fc-time"></span>');
							element.find("div .fc-time").remove();
							element.find("div .fc-title").contents().unwrap().wrap('<span class="fc-title"></span>');
						};
					break;
					case '3': //내부회의
						element.css({"color":"#2c2f30", "border":"none", "background-color":"#fdebf5"});
						element.find("div.fc-content").prepend("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon3.png\" class=\"v-m\">"); 
						element.find("td.fc-list-item-marker.fc-widget-content").html("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon3.png\" class=\"v-m\">"); 
						if(element[0].className=="fc-time-grid-event fc-v-event fc-event fc-start fc-end") {
							//element.find("div .fc-time").contents().unwrap().wrap('<span class="fc-time"></span>');
							element.find("div .fc-time").remove();
							element.find("div .fc-title").contents().unwrap().wrap('<span class="fc-title"></span>');
						};
					break;
					case '4': //교육
						element.css({"color":"#2c2f30", "border":"none", "background-color":"#e1e1f7"});
						element.find("div.fc-content").prepend("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon4.png\" class=\"v-m\">"); 
						element.find("td.fc-list-item-marker.fc-widget-content").html("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon4.png\" class=\"v-m\">"); 
						if(element[0].className=="fc-time-grid-event fc-v-event fc-event fc-start fc-end") {
							//element.find("div .fc-time").contents().unwrap().wrap('<span class="fc-time"></span>');
							element.find("div .fc-time").remove();
							element.find("div .fc-title").contents().unwrap().wrap('<span class="fc-title"></span>');
						};
					break;
					case '5': //이동시간
						element.css({"color":"#2c2f30", "border":"none", "background-color":"#fdf6da"});
						element.find("div.fc-content").prepend("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon5.png\" class=\"v-m\">"); 
						element.find("td.fc-list-item-marker.fc-widget-content").html("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon5.png\" class=\"v-m\">"); 
						$(element).find("a.fc-day-grid-event.fc-h-event.fc-event.fc-start.fc-end").hide();
						if(element[0].className=="fc-day-grid-event fc-h-event fc-event fc-start fc-end") {
							//element.hide();
						}else if(element[0].className=="fc-time-grid-event fc-v-event fc-event fc-start fc-end") {
							element.find("div .fc-time").html("");
							element.find("div .fc-title").html("");
						};
					break;
					case '6': //기타
						element.css({"color":"#2c2f30", "border":"none", "background-color":"#e8f1c8"});
						element.find("div.fc-content").prepend("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon7.png\" class=\"v-m\">"); 
						element.find("td.fc-list-item-marker.fc-widget-content").html("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon7.png\" class=\"v-m\">"); 
						if(element[0].className=="fc-time-grid-event fc-v-event fc-event fc-start fc-end") {
							//element.find("div .fc-time").contents().unwrap().wrap('<span class="fc-time"></span>');
							element.find("div .fc-time").remove();
							element.find("div .fc-title").contents().unwrap().wrap('<span class="fc-title"></span>');
						};
					break;
					case '7': //휴가
						element.css({"color":"#2c2f30", "border":"none", "background-color":"#e8e9ea"});
						element.find("div.fc-content").prepend("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon6.png\" class=\"v-m\">"); 
						element.find("td.fc-list-item-marker.fc-widget-content").html("<img src=\"<%=request.getContextPath()%>/images/pc/calendar_icon6.png\" class=\"v-m\">"); 
						if(element[0].className=="fc-time-grid-event fc-v-event fc-event fc-start fc-end") {
							//element.find("div .fc-time").contents().unwrap().wrap('<span class="fc-time"></span>');
							element.find("div .fc-time").remove();
							element.find("div .fc-title").contents().unwrap().wrap('<span class="fc-title"></span>');
						};
					break;
					case '8': //오피스365
						element.css("border", "1px solid #fe8360");
						//element.find("div.fc-content").prepend("<span class=\"legend-lec legend-lec-other\" style=\"height: 9px;\"><span class=\"fc_icon_trans fc_icon_trans_office\"></span></span>"); 
						//element.find("td.fc-list-item-marker.fc-widget-content").html("<span class=\"legend-lec legend-lec-other\" style=\"height: 9px;\"><span class=\"fc_icon_trans fc_icon_trans_office\"></span></span>"); 
						if(element[0].className=="fc-time-grid-event fc-v-event fc-event fc-start fc-end") {
							//element.find("div .fc-time").contents().unwrap().wrap('<span class="fc-time"></span>');
							element.find("div .fc-time").remove();
							element.find("div .fc-title").contents().unwrap().wrap('<span class="fc-title"></span>');
						};
					break;
					case '9': //아웃룩
						element.css("border", "1px solid #7963d5");
						//element.find("div.fc-content").prepend("<span class=\"legend-lec legend-lec-other\" style=\"height: 9px;\"><span class=\"fc_icon_trans fc_icon_trans_outlook\"></span></span>"); 
						//element.find("td.fc-list-item-marker.fc-widget-content").html("<span class=\"legend-lec legend-lec-other\" style=\"height: 9px;\"><span class=\"fc_icon_trans fc_icon_trans_outlook\"></span></span>"); 
						if(element[0].className=="fc-time-grid-event fc-v-event fc-event fc-start fc-end") {
							//element.find("div .fc-time").contents().unwrap().wrap('<span class="fc-time"></span>');
							element.find("div .fc-time").remove();
							element.find("div .fc-title").contents().unwrap().wrap('<span class="fc-title"></span>');
						};
					break;
					case '10': //구글 
						element.css("border", "1px solid #666560");
						//element.find("div.fc-content").prepend("<span class=\"legend-lec legend-lec-other\" style=\"height: 9px;\"><span class=\"fc_icon_trans fc_icon_trans_google\"></span></span>"); 
						//element.find("td.fc-list-item-marker.fc-widget-content").html("<span class=\"legend-lec legend-lec-other\" style=\"height: 9px;\"><span class=\"fc_icon_trans fc_icon_trans_google\"></span></span>");
						if(element[0].className=="fc-time-grid-event fc-v-event fc-event fc-start fc-end") {
							//element.find("div .fc-time").contents().unwrap().wrap('<span class="fc-time"></span>');
							element.find("div .fc-time").remove();
							element.find("div .fc-title").contents().unwrap().wrap('<span class="fc-title"></span>');
						};
					break;
					 default : //그 외
						element.css("border", "1px solid #b8aea2");
						element.find("div.fc-content").prepend("<span class=\"legend-lec legend-lec-other\" style=\"height: 9px;\"><span class=\"fc_icon_trans fc_icon_trans_comment\"></span></span>"); 
						element.find("td.fc-list-item-marker.fc-widget-content").html("<span class=\"legend-lec legend-lec-other\" style=\"height: 9px;\"><span class=\"fc_icon_trans fc_icon_trans_comment\"></span></span>"); 
						if(element[0].className=="fc-time-grid-event fc-v-event fc-event fc-start fc-end") {
							//element.find("div .fc-time").contents().unwrap().wrap('<span class="fc-time"></span>');
							element.find("div .fc-time").remove();
							element.find("div .fc-title").contents().unwrap().wrap('<span class="fc-title"></span>');
						};
					 break;
				}
					
			},
			
			eventLimit: true,
			views: {
				month: {
					titleFormat: 'YYYY년 M월',
					columnFormat: 'ddd'
				},
				agendaWeek: {
					titleFormat: 'YYYY년 M월 D일',
					columnFormat: 'M/D [(]ddd[)]'
				},
				agendaDay: {
					titleFormat: 'YYYY년 M월 D일',
					columnFormat: 'dddd'
				},
				dayList: {
		            type: 'listYear',
		            //duration: { days: 365 },
					titleFormat: 'YYYY년',
					listDayFormat: 'YYYY년 M월 D일 dddd',
					listDayAltFormat : '',
					allDayText: '종일'
			    }
		    },
			height: 850,
	    	customButtons: {
	    		today: {
	    			text: '오늘',
	    			click: function() {
	    				$('#calendar').fullCalendar('today');
	    			}
	    		},
	    		month: {
	    			text: '월간',
	    			click: function() {
	    				calendarTitle_before = $("#calendar > div.fc-toolbar > div.fc-center > h2").html();
	    				$("#calendar > div.fc-toolbar > div.fc-center > h2").html(calendarTitle_before);
	            		$('#calendar > div.fc-view-container').show();
	            		$("div.fc-left").show();
	            		$("#calendar > div.fc-toolbar > div.fc-right > button.fc-insertSchedule-button.fc-button.fc-state-default.fc-corner-left.fc-corner-right").show();
	            		$("#calendar > div.fc-toolbar > div.fc-right > button.fc-productivity-button.fc-button.fc-state-default.fc-corner-left.fc-corner-right").css({"background-color":"#ffffff", "border-color":"#e7eaec", "color":"#676a6c"});
	            		/* $("#calendar > div.fc-toolbar > div.fc-right > button.fc-dayList-button.fc-button.fc-state-default.fc-corner-left.fc-corner-right").css({"background-color":"#ffffff", "border-color":"#e7eaec", "color":"#676a6c"}); */
	            		//$("#productivityView").css("display", "none");
	            		//$("#myProductivity").css("display", "none");
	            		
	            		$("#textSearchStartDate").val("");
           				$("#textSearchEndDate").val("");
           				$("#textSearch").val("");
	            		$("#searchCalendar").css("display","none");
	            		$('#calendar').fullCalendar('refetchEvents');
	            		$('#calendar').fullCalendar('changeView', 'month');
					}
	    		},
	    		agendaWeek: {
	    			text: '주간',
	    			click: function() {
	    				calendarTitle_before = $("#calendar > div.fc-toolbar > div.fc-center > h2").html();
	    				$("#calendar > div.fc-toolbar > div.fc-center > h2").html(calendarTitle_before);
	            		$('#calendar > div.fc-view-container').show();
	            		$("div.fc-left").show();
	            		$("#calendar > div.fc-toolbar > div.fc-right > button.fc-insertSchedule-button.fc-button.fc-state-default.fc-corner-left.fc-corner-right").show();
	            		$("#calendar > div.fc-toolbar > div.fc-right > button.fc-productivity-button.fc-button.fc-state-default.fc-corner-left.fc-corner-right").css({"background-color":"#ffffff", "border-color":"#e7eaec", "color":"#676a6c"});
	            		/* $("#calendar > div.fc-toolbar > div.fc-right > button.fc-dayList-button.fc-button.fc-state-default.fc-corner-left.fc-corner-right").css({"background-color":"#ffffff", "border-color":"#e7eaec", "color":"#676a6c"}); */
	            		//$("#productivityView").css("display", "none");
	            		//l$("#myProductivity").css("display", "none");
	            		
	            		$("#textSearchStartDate").val("");
           				$("#textSearchEndDate").val("");
           				$("#textSearch").val("");
	            		$("#searchCalendar").css("display","none");
	            		$('#calendar').fullCalendar('refetchEvents');
	            		$('#calendar').fullCalendar('changeView', 'agendaWeek');
					}
				},
				agendaDay: {
					text: '일간',
	    			click: function() {
	    				calendarTitle_before = $("#calendar > div.fc-toolbar > div.fc-center > h2").html();
	    				$("#calendar > div.fc-toolbar > div.fc-center > h2").html(calendarTitle_before);
	            		$('#calendar > div.fc-view-container').show();
	            		$("div.fc-left").show();
	            		$("#calendar > div.fc-toolbar > div.fc-right > button.fc-insertSchedule-button.fc-button.fc-state-default.fc-corner-left.fc-corner-right").show();
	            		$("#calendar > div.fc-toolbar > div.fc-right > button.fc-productivity-button.fc-button.fc-state-default.fc-corner-left.fc-corner-right").css({"background-color":"#ffffff", "border-color":"#e7eaec", "color":"#676a6c"});
	            		$("#calendar > div.fc-toolbar > div.fc-right > button.fc-dayList-button.fc-button.fc-state-default.fc-corner-left.fc-corner-right").css({"background-color":"#ffffff", "border-color":"#e7eaec", "color":"#676a6c"});
	            		//$("#productivityView").css("display", "none");
	            		//$("#myProductivity").css("display", "none");
	            		
	            		$("#textSearchStartDate").val("");
           				$("#textSearchEndDate").val("");
           				$("#textSearch").val("");
	            		$("#searchCalendar").css("display","none");
	            		$('#calendar').fullCalendar('refetchEvents');
	            		$('#calendar').fullCalendar('changeView', 'agendaDay');
					}
				},
				dayList: {
					text: '일정검색',
	    			click: function() {
	    				calendarTitle_before = $("#calendar > div.fc-toolbar > div.fc-center > h2").html();
	    				if(searchEventCnt == 0) {
	    					searchEventCnt = 1;
	    					$("#calendar > div.fc-toolbar").append(searchEventTag);
	    					$("#calendar > div.fc-view-container").addClass("fc-clear");
	    				}
	    				$("#textSearchStartDate").val(commonDate.year+'-'+commonDate.month+'-'+commonDate.day);
	    				$("#textSearchEndDate").val(commonDate.year+'-'+commonDate.month+'-'+(new Date(commonDate.year,commonDate.month,0)).getDate());
	    				$("#calendar > div.fc-toolbar > div.fc-center > h2").html(calendarTitle_before);
	            		$('#calendar > div.fc-view-container').show();
	            		$("div.fc-left").show();
	            		$("#calendar > div.fc-toolbar > div.fc-right > button.fc-insertSchedule-button.fc-button.fc-state-default.fc-corner-left.fc-corner-right").show();
	            		$("#calendar > div.fc-toolbar > div.fc-right > button.fc-productivity-button.fc-button.fc-state-default.fc-corner-left.fc-corner-right").css({"background-color":"#ffffff", "border-color":"#e7eaec", "color":"#676a6c"});
	            		$(this).css("color","#000000");
	            		$("#productivityView").css("display", "none");
						
	            		//일점검색 버튼 누르면 최초 오늘날짜를 시작일로 검색
	            		$('#calendar').fullCalendar('today');
	            		
	            		$("#searchCalendar").css("display","");
	            		$('#calendar').fullCalendar('changeView', 'dayList');
					}
			    },
	            insertSchedule: {
	                text: '일정추가',
	                click: function() {
	                    modal.reset();
	                }
	            },
	            productivity : {
	            	text: '나의 생산성',
	            	click: function() {
	            		
	            		//window.open("http://" + location.host + "/calendar/myProductivity.do?&divisionNteamType=myProduc&hiddenUserId="+$("#userIdNum").val(), "나의생산성", "width=1200, height=750, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );
	            		window.open("http://" + location.host + "/calendar/myProductivity.do?viewType=m&hiddenUserId="+$("#userIdNum").val(), "나의생산성", "width=1470, height=690, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );
					}
	            },
	            rightMenu: {
	                text: '메뉴숨김',
	                click: function() {
	                    if($(this).html()=='메뉴숨김') {
	                    	$(this).html("메뉴보기");
	                    	$(this).css({"background-color":"#1ab394", "border-color":"#1ab394", "color":"#ffffff"});
	                    	$("#page-wrapper > div.wrapper.wrapper-content.pd-tno.pd-rno > div").addClass("row animated fadeInDown calendar-grid calendar-grid-close");
	                    	$(".btn-calendar.btn-calendar-off").css("display", "none");
	                    	$(".btn-calendar.btn-calendar-on").css("display", "");
	                    }else {
	                    	$(this).html("메뉴숨김");
	                    	$(this).css({"background-color":"#ffffff", "border-color":"#e7eaec", "color":"#676a6c"});
	                    	$("#page-wrapper > div.wrapper.wrapper-content.pd-tno.pd-rno > div").removeClass("calendar-grid-close");
	                    	$(".btn-calendar.btn-calendar-on").css("display", "none");
	                    	$(".btn-calendar.btn-calendar-off").css("display", "");
	                    }
	                }
	            },
	            nextCenter: {
	            	text: '▶',
	            	click: function() {
	            		var moment;
	            		$('#calendar').fullCalendar('next');
	            		moment = $('#calendar').fullCalendar('getDate');
	            		calendar.draw(moment.format('YYYY'), moment.format('MM'));
	            		//$('#calendar').fullCalendar('refetchEvents');
	            	}
	            },
	            prevCenter: {
	            	text: '◀',
	            	click: function() {
	            		var moment;
	            		$('#calendar').fullCalendar('prev');
	            		moment = $('#calendar').fullCalendar('getDate');
	            		calendar.draw(moment.format('YYYY'), moment.format('MM'));
	            		//$('#calendar').fullCalendar('refetchEvents');
	            	}
	            }
	            /* checkSchedule: {
	            	text: '빈 일정',
	            	click: function() {
	            		($("#checkboxCalendarSchedule").is(":checked")) ? 
	            				($("#checkboxCalendarSchedule").prop("checked", false), $(this).css({background: "", border: "", color: ""})) : ($("#checkboxCalendarSchedule").prop("checked", true), $(this).css({background: "#1ab394", border: "#1ab394", color: "#ffffff"}));
	            		$("input:checkbox[name=checkboxCalendarId]").prop("checked", true);
	            		$('#calendar').fullCalendar('refetchEvents');
	            	}
	            } */
	        },
	        defaultView: 'month',
	        header: {
	            left: 'today prev,next checkSchedule', //좌측버튼
	            center: 'prevCenter title nextCenter', //가운데 타이틀
	            right: 'insertSchedule month,agendaWeek,agendaDay dayList productivity' //우측버튼
	        },
	        //time formats
	        /* titleFormat: {
	            month: 'YYYY년 MM월',
	            week: 'YYYY년 MM월 D일',
	            day: 'YYYY년 MM월 D일 dddd'
	        }, */
	        /* columnFormat: {
	            month: 'ddd',
	            week: 'M/D ddd',
	            day: 'M월D일 dddd'
	        }, */
	        timezone: 'local',
	        timeFormat: 'HH:mm', //주간,일간
	        allDayText: '', //주간,일간
	        axisFormat: 'Thh', //주간,일간
	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	        dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
	        dayNamesShort: ['일','월','화','수','목','금','토'],
	        buttonText: {
	            prev: '이전',
	            next: '다음',
	            today: '오늘',
	            month: '월간',
	            week: '주간',
	            day: '일간',
	            dayList: '일정검색'
	        },
	        //defaultDate: '2016-01-12',
	        /* selectable: true,
	        selectHelper: true,
	        select: function(start, end, allDay) { //빈곳 클릭(일정 추가 폼으로 이동)
	            var sta_dt = moment().format('YYYY-MM-D');
	            var end_dt = moment().format('YYYY-MM-D');
	            var sta_tm = moment().format('HH:mm');
	            var end_tm = moment().format('HH:mm'); */
	            /* alert(sta_dt);
	            location.href='/rnd/scheduleinsert.do'; */
	            /* var title = prompt('일정 제목을 입력하세요.:');
	            var eventData;
	            if (title) {
	                eventData = {
	                    title: title,
	                    start: start,
	                    end: end,
	                    allDay: allDay
	                };
	                $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
	            }
	            $('#calendar').fullCalendar('unselect');
	        }, */
	        editable: false,
	        eventDrop: function(event, delta, revertFunc) {
	        	var confrimComment;
	        	if(event.REPEAT_YN == 'Y'){
	        		confrimComment = "'" + event.title + "' 일정은 반복일정 입니다.\n반복일정은 선택한 일정만 변경됩니다.\n 선택한 일정을 " + moment(event.start).format("YYYY-MM-DD") + "로 수정 하시겠습니까?";
	        	}else{
	        		confrimComment = "'" + event.title + "' 일정을 " + moment(event.start).format("YYYY-MM-DD") + "로 수정 하시겠습니까?";
	        	}
	        	
	            if(!confirm(confrimComment)) {
	            	revertFunc();
	            }else{
	            	if(event.REPEAT_YN == 'Y'){
	            		calendar.setModal(event, true);
	            		$("#hiddenModalOrgStartDate").val(moment($("#hiddenModalOrgStartDate").val()).add(-1 * delta._data.days, 'days').format("YYYY-MM-DD"));
	            		$("#selectModalStartDateTime").val(moment($("#selectModalStartDateTime").val()).add(-1 * delta._data.hours, 'hours').format("hh:mm"));
	            		$("#selectModalStartDateTime").val(moment($("#selectModalStartDateTime").val()).add(-1 * delta._data.minutes, 'minutes').format("hh:mm"));
	            		modal.rruleSubmit(1, 'submit');
	            	}else{
	            		compareFlag = true;
		            	calendar.setModal(event, true);
		            	modal.submit();
	            	}
	            }
	        },
	        eventResize : function(event, delta, revertFunc) {
	        	var confrimComment;
	        	if(event.REPEAT_YN == 'Y'){
	        		confrimComment = "'" + event.title + "' 일정은 반복일정 입니다.\n반복일정은 선택한 일정만 변경됩니다.\n 선택한 일정을 수정 하시겠습니까?";
	        	}else{
	        		confrimComment = "'" + event.title + "' 일정을 " + moment(event.start).format("YYYY-MM-DD") + "로 수정 하시겠습니까?";
	        	}
	        	
	        	if(!confirm(confrimComment)) {
	            	revertFunc();
	            }else{
	            	if(event.REPEAT_YN == 'Y'){
	            		calendar.setModal(event, true);
	            		$("#hiddenModalOrgStartDate").val(moment($("#hiddenModalOrgStartDate").val()).add(-1 * delta._data.days, 'days').format("YYYY-MM-DD"));
	            		modal.rruleSubmit(1, 'submit');
	            	}else{
	            		compareFlag = true;
		            	calendar.setModal(event, true);
		            	modal.submit();
	            	}
	            }
			},
	        eventLimit: true, // allow "more" link when too many events
	        nowIndicator: true,
	        /*
	        
	            id : 아이디
	            title : 일정 제목
	            allDay : 시간 상관없이 시작일부터 끝일까지  true/false
	            start : 시작 일
	            end : 끝 일
	            url : 클릭시 해당 페이지로 이동
	            className : 특정 class의 css를 참조하는듯? String/배열
	            editable : 마우스 수정옵션 true/false, default false
	            startEditable : true/false, default true
	            durationEditable : true/false, default true
	            rendering : 특정일정을 배경에 표시함 'background'/'inverse-background'
	            overlap : eventOverlap선언되어있는  이벤트를 참고하는듯? true/false, default true
	                
	        */
	        googleCalendarApiKey: 'AIzaSyCKE8qrncJjPcV5T3uk2ZAi49l2yI7C1sg',
	        
	        //events: monthData,
	        //events: 'youn9412@gmail.com',
	        
	        /* viewRender: function(view, element){
				var b = $('#calendar').fullCalendar('getDate');
			}, */
			/* viewDisplay: function(view) {
		        alert('The new title of the view is ' + view.title);
		    }, */
			
	        eventClick: function(calEvent, jsEvent, view) {
	        	calendar.setModal(calEvent);
	        	
	        }
	        
	    });
	}//draw
}
</script>
<style>
#calendar>div.fc-toolbar>div.fc-center>h2 {
	margin-top: 0px;
}
</style>
<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>