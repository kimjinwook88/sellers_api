<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ include file="/WEB-INF/jsp/m/common/functions.jsp" %>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>

<head>
	<style type="text/css">
		.pop-layer {display:none; position: absolute; top: 50%; left: 50%; width: 310px; height:auto;  background-color:#fff; border: 5px solid #3571B5; z-index: 1000000;}
		.pop-layer .pop-container {padding: 20px 25px;}
		.pop-layer p.ctxt {color: #666; line-height: 25px;}
		.pop-layer .btn-r {width: 100%; margin:10px 0 20px; padding-top: 10px; border-top: 1px solid #DDD; text-align:right;}
	
		a.cbtn {display:inline-block; height:25px; padding:0 14px 0; border:1px solid #304a8a; background-color:#3f5a9d; font-size:13px; color:#fff; line-height:25px;}	
		a.cbtn:hover {border: 1px solid #091940; background-color:#1f326a; color:#fff;}
		
		/* 에러메세지 가운데 정렬 */
		#textModalEventSubject-error{display:table; margin-left:auto; margin-right:auto;}
		
		/* 반복일정 삭제 레이어 */
		#layer_delete {border : 0px;}
	</style>
</head>
<html lang="ko">

<body class="gray_bg">

<div class="container">
	<article class="schedule_cont mg_b0">
		<div class="title_pg mg_b20 ta_c">
			<h2>일정</h2>
			<a href="#" class="btn_back" onclick="window.history.back();">back</a>
		</div>

		<div class="mg_l10 mg_r10">
<%--
			<form method="post" class="form-horizontal mg_l10 mg_r10" id="frmSchedule">
 --%>
			<form class="form-horizontal" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">

				<div class="cont1 pd_b20 "><!-- 이슈기본정보  -->

					<div class="form_input mg_b20">
						<input type="text" id="textModalEventSubject" name="textModalEventSubject"  value="${detail.EVENT_SUBJECT}" placeholder="제목을 입력해주세요 (필수)" class="form_control schedule_subject" />
					</div>

					<div class="form_input mg_b20">
						<label class="fc_gray_light">일정구분 <span style="color:red">*</span></label>
						<select class="form_control" id="selectModalEventCode" name="selectModalEventCode" onClick="modal.checkEventCode();">
							<spring:eval expression="@config['code.calModalEventList']" />
<%--
							<option value="1" ${detail.EVENT_CODE eq '1' ? 'selected' : ''}>고객대면</option>
							<option value="2" ${detail.EVENT_CODE eq '2' ? 'selected' : ''}>대면준비</option>
							<option value="3" ${detail.EVENT_CODE eq '3' ? 'selected' : ''}>내부회의</option>
							<option value="4" ${detail.EVENT_CODE eq '4' ? 'selected' : ''}>교육</option>
							<option value="5" ${detail.EVENT_CODE eq '5' ? 'selected' : ''}>기타</option>
							<option value="6" ${detail.EVENT_CODE eq '6' ? 'selected' : ''}>휴가</option>
							<option value="7" ${detail.EVENT_CODE eq '7' ? 'selected' : ''}>이동시간</option>
--%>
						</select>
					</div>
					
					<%-- 사용안함 --%>
					<div class="form_input mg_b20" style="display:none">
						<label class="col-sm-1 control-label">달력</label>
						<div class="col-sm-3">
							<select class="form-control" name="selectModalCalendarID" id="selectModalCalendarID">
							<c:choose>
								<c:when test="${!empty calendarList}">
									<c:forEach items="${calendarList}" var="calendarList">
									<c:choose>
										<c:when test="${(calendarList.MEMBER_ID_NUM eq userInfo.MEMBER_ID_NUM) && (calendarList.CALENDAR_NAME eq '나의 캘린더')}">
											<option id="${calendarList.SYNC_YN}" value="${calendarList.CALENDAR_ID}">${calendarList.CALENDAR_NAME}</option>
										</c:when>
									</c:choose>
									</c:forEach>
								</c:when>
							</c:choose>
							</select>
						</div>
					</div>

					<div class="form_input mg_b20">
						<label class="fc_gray_light">장소</label>
						<input type="text" class="form_control" id="textModalEventLocation" name="textModalEventLocation" value="${detail.LOCATION}"/>
					</div>

					<div class="h_line pd_t10"></div>

					<div class="form_input mg_b20">
						<label class="fc_gray_light">상세내용</label>
						<textarea class="form_control" row="3" id="textareaModalEventDetail" name="textareaModalEventDetail">${detail.EVENT_DETAIL}</textarea>
					</div> 

					<div class="h_line pd_t10"></div>

					<div class="form_input">
						<label class="fc_gray_light">일정시작</label>
						<div class="daytime">
							<input type="date" value="${mode eq 'I' ? curDate : detail.START_DAY}" class="form_control" id="textModalStartDate" name="textModalStartDate" onchange="rrule.nthOfMonth();modal.chkDate(this);" /> <!-- 기본적으로 오늘 날짜 표시 -->
							<select class="form_control" id="selectModalStartDateTime" name="selectModalStartDateTime" onchange="modal.changeEndDate();">
								<option value="00:00"> 오전 12:00</option>
								<option value="00:30"> 오전 12:30</option>
								<option value="01:00"> 오전 01:00</option>
								<option value="01:30"> 오전 01:30</option>
								<option value="02:00"> 오전 02:00</option>
								<option value="02:30"> 오전 02:30</option>
								<option value="03:00"> 오전 03:00</option>
								<option value="03:30"> 오전 03:30</option>
								<option value="04:00"> 오전 04:00</option>
								<option value="04:30"> 오전 04:30</option>
								<option value="05:00"> 오전 05:00</option>
								<option value="05:30"> 오전 05:30</option>
								<option value="06:00"> 오전 06:00</option>
								<option value="06:30"> 오전 06:30</option>
								<option value="07:00"> 오전 07:00</option>
								<option value="07:30"> 오전 07:30</option>
								<option value="08:00"> 오전 08:00</option>
								<option value="08:30"> 오전 08:30</option>
								<option value="09:00"> 오전 09:00</option>
								<option value="09:30"> 오전 09:30</option>
								<option value="10:00"> 오전 10:00</option>
								<option value="10:30"> 오전 10:30</option>
								<option value="11:00"> 오전 11:00</option>
								<option value="11:30"> 오전 11:30</option>
								<option value="12:00"> 오후 12:00</option>
								<option value="12:30"> 오후 12:30</option>
								<option value="13:00"> 오후 01:00</option>
								<option value="13:30"> 오후 01:30</option>
								<option value="14:00"> 오후 02:00</option>
								<option value="14:30"> 오후 02:30</option>
								<option value="15:00"> 오후 03:00</option>
								<option value="15:30"> 오후 03:30</option>
								<option value="16:00"> 오후 04:00</option>
								<option value="16:30"> 오후 04:30</option>
								<option value="17:00"> 오후 05:00</option>
								<option value="17:30"> 오후 05:30</option>
								<option value="18:00"> 오후 06:00</option>
								<option value="18:30"> 오후 06:30</option>
								<option value="19:00"> 오후 07:00</option>
								<option value="19:30"> 오후 07:30</option>
								<option value="20:00"> 오후 08:00</option>
								<option value="20:30"> 오후 08:30</option>
								<option value="21:00"> 오후 09:00</option>
								<option value="21:30"> 오후 09:30</option>
								<option value="22:00"> 오후 10:00</option>
								<option value="22:30"> 오후 10:30</option>
								<option value="23:00"> 오후 11:00</option>
								<option value="23:30"> 오후 11:30</option>
							</select>
						</div>
					</div>

					<div class="form_input mg_b20">
						<label class="fc_gray_light">일정종료</label>
						<div class="daytime">
							<input type="date" value="${mode eq 'I' ? curDate : detail.END_DAY}" class="form_control" id="textModalEndDate" name="textModalEndDate" onchange="rrule.nthOfMonth();modal.chkDate(this);" /> <!-- 기본적으로 오늘 날짜 표시 -->
							<select class="form_control" id="selectModalEndDateTime" name="selectModalEndDateTime">
								<option value="00:00"> 오전 12:00</option>
								<option value="00:30"> 오전 12:30</option>
								<option value="01:00"> 오전 01:00</option>
								<option value="01:30"> 오전 01:30</option>
								<option value="02:00"> 오전 02:00</option>
								<option value="02:30"> 오전 02:30</option>
								<option value="03:00"> 오전 03:00</option>
								<option value="03:30"> 오전 03:30</option>
								<option value="04:00"> 오전 04:00</option>
								<option value="04:30"> 오전 04:30</option>
								<option value="05:00"> 오전 05:00</option>
								<option value="05:30"> 오전 05:30</option>
								<option value="06:00"> 오전 06:00</option>
								<option value="06:30"> 오전 06:30</option>
								<option value="07:00"> 오전 07:00</option>
								<option value="07:30"> 오전 07:30</option>
								<option value="08:00"> 오전 08:00</option>
								<option value="08:30"> 오전 08:30</option>
								<option value="09:00"> 오전 09:00</option>
								<option value="09:30"> 오전 09:30</option>
								<option value="10:00"> 오전 10:00</option>
								<option value="10:30"> 오전 10:30</option>
								<option value="11:00"> 오전 11:00</option>
								<option value="11:30"> 오전 11:30</option>
								<option value="12:00"> 오후 12:00</option>
								<option value="12:30"> 오후 12:30</option>
								<option value="13:00"> 오후 01:00</option>
								<option value="13:30"> 오후 01:30</option>
								<option value="14:00"> 오후 02:00</option>
								<option value="14:30"> 오후 02:30</option>
								<option value="15:00"> 오후 03:00</option>
								<option value="15:30"> 오후 03:30</option>
								<option value="16:00"> 오후 04:00</option>
								<option value="16:30"> 오후 04:30</option>
								<option value="17:00"> 오후 05:00</option>
								<option value="17:30"> 오후 05:30</option>
								<option value="18:00"> 오후 06:00</option>
								<option value="18:30"> 오후 06:30</option>
								<option value="19:00"> 오후 07:00</option>
								<option value="19:30"> 오후 07:30</option>
								<option value="20:00"> 오후 08:00</option>
								<option value="20:30"> 오후 08:30</option>
								<option value="21:00"> 오후 09:00</option>
								<option value="21:30"> 오후 09:30</option>
								<option value="22:00"> 오후 10:00</option>
								<option value="22:30"> 오후 10:30</option>
								<option value="23:00"> 오후 11:00</option>
								<option value="23:30"> 오후 11:30</option>
							</select>
						</div>
					</div>

					<div id="line_move" class="h_line pd_t10"></div>
					
					<div id="divModalEventCode" class="form_input" style="display:none">
						<label class="fc_gray_light">전 이동시간</label>
						<div>
							<select class="form_control" id="selectModalBeforeMoveTimeMin" name="selectModalBeforeMoveTimeMin">
								<option selected="selected" value="0">선택</option>
								<option value="30">30분</option>
								<option value="60">1시간</option>
								<option value="90">1시간 30분</option>
								<option value="120">2시간</option>
								<option value="150">2시간 30분</option>
								<option value="180">3시간</option>
								<option value="240">4시간</option>
								<option value="300">5시간</option>
								<option value="360">6시간</option>
								<option value="420">7시간</option>
								<option value="480">8시간</option>
							</select>
						</div>
					</div>

					<div id="divModalEventCode2" class="form_input mg_b20" style="display:none">
						<label class="fc_gray_light">후 이동시간</label>
						<div>
							<select class="form_control" id="selectModalAfterMoveTimeMin" name="selectModalAfterMoveTimeMin">
								<option selected="selected" value="0">선택</option>
								<option value="30">30분</option>
								<option value="60">1시간</option>
								<option value="90">1시간 30분</option>
								<option value="120">2시간</option>
								<option value="150">2시간 30분</option>
								<option value="180">3시간</option>
								<option value="240">4시간</option>
								<option value="300">5시간</option>
								<option value="360">6시간</option>
								<option value="420">7시간</option>
								<option value="480">8시간</option>
							</select>
						</div>
					</div>

					<div class="h_line pd_t10"></div>

					<div class="form_input mg_b20">
						<label class="fc_gray_light">옵션선택</label>
						<div class="mg_b10">
							<label for="f_action1" class="mg_r20"><input type="checkbox" class="option_dayfull va_m" id="checkboxModalAllday" name="checkboxModalAllday" value="N" onclick="modal.chkBox(this);" /><span class="va_m">종일</span></label>
							<!-- <label for="f_action2" class=""><input type="checkbox" class="option_repeat va_m" id="checkboxModalRepeat" name="checkboxModalRepeat" value="N" onclick="modal.chkBox(this);" /><span class="va_m">반복</span></label> -->
						</div>

						<!-- -------------------- 반복옵션 Start ------------------------>			
						
						<div class="form_input">
							<label for="f_action2" class=""><input type="checkbox" disabled="false" class="option_repeat va_m" id="checkboxModalRepeat" name="checkboxModalRepeat" value="N" onclick="modal.chkBox(this);" /><span class="va_m">반복</span></label>
							<div class="guideBox">반복일정 설정은 PC에서만 가능합니다.
							</div>
						</div>				
						<div id="divModalRepeatOption" class="repeat_option mg_b20 off">

							<div class="mg_b10 repeat_term repeat_week on"> <!-- "매주" 선택시 보여질 화면 -->
								<select class="form_control mg_r10" name="selectModalFreq" id="selectModalFreq" onchange="rrule.selectFreq(this);">
									<option value="2" selected="selected">매주</option>
									<option value="1">매월</option>
									<option value="3">분기</option>
									<option value="4">반기</option>
								</select>
								<div name="divModalInterval" id="divModalInterval">
									<select class="form-control mg_r10"
										name="selectModalInterval" id="selectModalInterval">
										<option value="1" selected="selected">1주에 한번</option>
										<option value="2">2주에 한번</option>
										<option value="3">3주에 한번</option>
										<option value="4">4주에 한번</option>
										<option value="5">5주에 한번</option>
										<option value="6">6주에 한번</option>
										<option value="7">7주에 한번</option>
										<option value="8">8주에 한번</option>
										<option value="9">9주에 한번</option>
									</select>
								</div>
								<!-- 
								<input type="text" value="1" size="2" class="form_control mg_r10" />
								<span>주마다</span>

								<div class="week_sel">
									<a href="#" class="active">일</a>
									<a href="#" class="">월</a>
									<a href="#" class="">화</a>
									<a href="#" class="">수</a>
									<a href="#" class="">목</a>
									<a href="#" class="">금</a>
									<a href="#" class="">토</a>
								</div>
								 -->
							</div>
							
							<div class="off" name="divModalInterval" id="divModalMonthlyByweekday">
								<label class="fc_gray_light">반복 마감일 </label>
								<div>
									<label class="select-com">
										<input type="radio" name="divModalMonthlyRule" value="BYMONTHDAY" checked="checked">
										<label class="mg-r10" id="divModalMonthlyRuleDate">매월 **일</label>
										<input type="radio" name="divModalMonthlyRule" value="BYDAY">
										<label class="mg-r10" id="divModalMonthlyRuleTh">매월 *번째 *요일</label>
									</label>
								</div>
							</div>
							<div id="divModalElseByweekday">
								<label class="fc_gray_light">반복일 </label>
								<div>
									<input type="checkbox" name="RRulecheckboxModalByweekday" id="checkboxModalRRuleMO" value="0" class="" />월
									<input type="checkbox" name="RRulecheckboxModalByweekday" id="checkboxModalRRuleTU" value="1" class="" />화
									<input type="checkbox" name="RRulecheckboxModalByweekday" id="checkboxModalRRuleWE" value="2" class="" />수
									<input type="checkbox" name="RRulecheckboxModalByweekday" id="checkboxModalRRuleTH" value="3" class="" />목
									<input type="checkbox" name="RRulecheckboxModalByweekday" id="checkboxModalRRuleFR" value="4" class="" />금
									<input type="checkbox" name="RRulecheckboxModalByweekday" id="checkboxModalRRuleSA" value="5" class="" />토
									<input type="checkbox" name="RRulecheckboxModalByweekday" id="checkboxModalRRuleSU" value="6" class="" />일
								</div>
							</div>


							<div class="mg_b10 repeat_term repeat_month off">
								<select class="form_control mg_r10"> <!-- "매월" 선택시 보여질 화면 -->
									<option>매일</option>
									<option>매주</option>
									<option selected>매월</option>
								</select>
								<div class="fl_l">
									<input type="text" value="1" size="2" class="form_control mg_r10" />
									<span>개월마다</span>
									<div class="cboth">
										<select class="form_control mg_r10">
											<option>1일</option>
											<option>2일</option>
											<option>3일</option>
											<option>4일</option>
											<option>5일</option>
											<option>6일</option>
											<option>7일</option>
											<option>8일</option>
											<option>9일</option>
											<option>10일</option>
											<option>11일</option>
											<option>12일</option>
											<option>13일</option>
											<option>14일</option>
											<option>15일</option>
											<option>16일</option>
											<option>17일</option>
											<option>18일</option>
											<option>19일</option>
											<option>20일</option>
											<option>21일</option>
											<option>22일</option>
											<option>23일</option>
											<option>24일</option>
											<option>25일</option>
											<option>26일</option>
											<option>27일</option>
											<option>28일</option>
											<option>29일</option>
											<option>30일</option>
											<option>31일</option>
										</select>
									</div>
								</div>
							</div>

 
							<div class="h_line pd_t10"></div>

							<div class="form_input">
								<label class="fc_gray_light">옵션 종료일</label>
								<input type="date" value="2016-08-10" class="form_control" /> <!-- 기본적으로 오늘 날짜 표시 -->
							</div>

							<div class="form-group">
								<label class="fc_gray_light">종료일</label>
								<div class="col-sm-10">
									<label class="mg-r10">
										<input type="radio"	name="radioModalEndRule" id="radioModalCountNull"
											value="" checked="checked" 
											onclick='if($(this).prop("checked")){$("#textModalCountNum").val(""); $("#textModalCountNum").attr("disabled", true); $("#textModalEndRuleDate").attr("disabled", true); $("#textModalEndRuleDate").val("");}' />
										<span class="v-m">계속 반복</span>
									</label>
									<div class="mg-r10">
										<input type="radio" name="radioModalEndRule" id="radioModalCountNum" value="count"
											onclick='if($(this).prop("checked")){$("#textModalCountNum").attr("disabled", false); $("#textModalCountNum").attr("disabled", false); $("#textModalEndRuleDate").attr("disabled", true); $("#textModalEndRuleDate").val("");}' />
										<span class="v-m">
											<input type="text" disabled="disabled" name="textModalCountNum" id="textModalCountNum"
												value="" style="width: 40px;" maxlength="4">번 반복 후 종료
										</span>
									</div>
									<div class="mg-r10">
										<input type="radio" name="radioModalEndRule" id="checkboxModalEndRuleDate" value="until"
											onclick='if($(this).prop("checked")){$("#textModalCountNum").val(""); $("#textModalCountNum").attr("disabled", true); $("#textModalEndRuleDate").attr("disabled", false);}' />
										<label id="data_1">
											<label class="input-group date" style="display: block;">
											<!-- 
												<span class="input-group-addon" style="display: none">
												<i class="fa fa-calendar"></i>
												</span>
											-->
												종료일:
												<input type="date" disabled="disabled" name="textModalEndRuleDate" id="textModalEndRuleDate" value="" onchange="rrule.chkEndDate();"  class="form_control" />
										</label>
										</label>
									</div>
								</div>
							</div>

						</div>
						
					<!-- -------------------- 반복옵션 End ------------------------>	
						
					</div>


					<div class="h_line pd_t10"></div>

					<div class="form_input mg_b20">
						<label class="fc_gray_light">초대옵션</label>
						<div class="mg_b10">
						<%--
							<label for="f_invite" class="f_invite"><input type="checkbox" id="f_invite" name="innner" class="va_m" value="N" /><span class="va_m">초대</span></label>
						 --%>
							<label for="checkboxModalInvite">
								<input type="checkbox" name="checkboxModalInvite" id="checkboxModalInvite" onclick="modal.inviteChkBox(this)" value="Y">
								<span class="va_m">초대</span>
							</label>
						</div>

						<div id="div_invite_area" class="pop_search invite_option mg_b20 "><!-- 초대옵션 설정 -->
							<!-- 직원검색영역 -->
							<div class="pop_search_area invite-area ">
								<a href="#" class="btn-search">직원검색</a>
								<div class="list mg_b10">
									<ul class="" id="invite_member_list">
									</ul>
								</div>
							</div>
							<!--// 직원검색영역 -->

							<!-- 직원선택 팝업 -->
							<div class="pop_search_pop invite-member-pop off">
								<div class="pop-header">
									<button type="button" class="close"><img src="/images/m/icon_close_gray.svg" /></button>
									<strong class="pop-title">직원 선택</strong>
								</div>
								<div class="col-sm-12 cont">
									<div class="form-group pop_search_input">
										<input type="text" name="search_member_txt" id="search_member_txt" class="form_control searchMemberText"/>
										<a href="#" onClick="fncSearchMember(); return false;">검색</a>
									</div>
									<div class="form-group">
										<div class="col-sm-12 mg-b10 "><!-- 검색 결과 노출시 "off" 삭제 -->
											<ul class="result_list" id="search_member_list">
											</ul>
										</div>
									</div>
								</div>
							</div>

							<!-- 참석자 리스트 : 초기에는 hidden 처리되면, 검색 후 등록하면 리스트가 display 됨. -->
<%--
							<div class="invite-area-list " style="display:none;">
								<h3 class="ag_c">참석자 리스트</h3>
								<table class="basic3">
									<colgroup>
										<col width=""/>
										<col width=""/>
										<col width=""/>
										<col width=""/>
									</colgroup>
									<thead>
										<tr>
											<th>이름</th>
											<th>발신상태</th>
											<th>수락여부</th>
											<th>삭제</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>이상현</td>
											<td>미발신</td>
											<td>수락</td>
											<td>
												<a href="#" class="remove"><img src="/images/m/icon_close.svg" /></a>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
--%>
							<!-- 캘린더 모달창 참석자 리스트 뿌려지는곳 -->
							<div class="invite-area-list"></div>
							
						</div>

						
					</div>

					<div class="h_line pd_t10"></div>

					<div class="form_input mg_b20">
						<label class="fc_gray_light">공개상태</label>
						<div class="mg_b10">
							<label for="radioModalShareN" class="mg_r20"><input type="radio" id="radioModalShareN" name="radioModalShareYN" class="va_m" value="N" ${detail.SHARE_YN eq 'N' ? 'checked' : ''}/><span class="va_m">비공개</span></label>
							<label for="radioModalShareY" class=""><input type="radio" id="radioModalShareY" name="radioModalShareYN" class="va_m" value="Y" ${empty detail || detail.SHARE_YN eq 'Y' ? 'checked' : ''}/><span class="va_m">공개</span></label>
						</div>
					</div>
					
					<!-- 알림 방식이 정의되지않아, 일단은 셀렉박스 display none -->
                    <div class="h_line pd_t10"></div>
                    
                    <div class="form_input mg_b20">
						<label class="fc_gray_light">일정 알림</label>
						<div class="" >
	                        	<select class="form_control" id="" name="radioModalAlam2" onchange="modal.changeNotice(this.value);">
									<option value="notNotice" ${detail.ALARM_FLAG eq null || detail.ALARM_FLAG eq '' || detail.ALARM_FLAG eq 'N' ? 'selected' : ''} >안함</option>
									<option value="oneHour" ${detail.ALARM_FLAG eq 'H' ? 'selected' : ''}>한시간 전</option>
									<option value="oneDay" ${detail.ALARM_FLAG eq 'D' ? 'selected' : ''}>하루 전</option>
									<option value="oneWeek" ${detail.ALARM_FLAG eq 'W' ? 'selected' : ''}>일주일 전</option>
								</select>
	                        </div>
							<div class="col-sm-8">
							
							
                 				<label style="display: none;"> <input type="radio" name="radioModalAlam" id="radioModalAlam0" value="notNotice" ${detail.ALARM_FLAG eq null || detail.ALARM_FLAG eq '' || detail.ALARM_FLAG eq 'N' ? 'checked' : ''} /> <span class="v-m">안함</span></label>
                 				<label style="display: none;"> <input type="radio" name="radioModalAlam" id="radioModalAlam1" value="oneHour" ${detail.ALARM_FLAG eq 'H' ? 'checked' : ''} /> <span class="v-m">한시간 전</span></label>
                 				<label style="display: none;"> <input type="radio" name="radioModalAlam" id="radioModalAlam2" value="oneDay" ${detail.ALARM_FLAG eq 'D' ? 'checked' : ''} /> <span class="v-m">하루 전</span></label>
                 				<label style="display: none;"> <input type="radio" name="radioModalAlam" id="radioModalAlam3" value="oneWeek" ${detail.ALARM_FLAG eq 'W' ? 'checked' : ''} /> <span class="v-m">일주일 전</span></label>
               				</div>
					</div>
                    
                        <!-- <div class="form-group"><label class="col-sm-2 control-label">일정 알림</label>
	                        <div class="col-sm-2" style="display:none">
		                        <select class="form-control m-b" name="selectModalAlam" id="selectModalAlam">
	                                   <option value="mainNotice"> 알림쪽지 </option>
	                                   <option value="dbEmail"> 이메일 </option>
                                </select>
                                
	                        </div>
	                        
                       </div> -->
                       

				</div>
				


				<!-- <input type="hidden" name="hiddenModalAlam" id="hiddenModalAlam" value=""/> -->
				
									<input type="hidden" name="hiddenModalCalendarId" id="hiddenModalCalendarId" value="" /> 
									<input type="hidden" name="hiddenModalEventId" id="hiddenModalEventId" value="" />
									<input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}" />
									<input type="hidden" name="hiddenModalStartRuleDate" id="hiddenModalStartRuleDate" value="" /> 
									<input type="hidden" name="hiddenModalEndRuleDate" id="hiddenModalEndRuleDate" value="" /> 
									<input type="hidden" name="hiddenModalCountNum" id="hiddenModalCountNum" value="" />
									<input type="hidden" name="hiddenModalLoopNum" id="hiddenModalLoopNum" value="" />
									<input type="hidden" name="hiddenModalEndCondition" id="hiddenModalEndCondition" value="" />
									<input type="hidden" name="hiddenModalRuleByweekday" id="hiddenModalRuleByweekday" value="" />
									<input type="hidden" name="hiddenModalRuleBy" id="hiddenModalRuleBy" value="" />
									<input type="hidden" name="hiddenModalRuleBymonthday" id="hiddenModalRuleBymonthday" value="" />
									<input type="hidden" name="hiddenModalRruleString" id="hiddenModalRruleString" value="" />
									<input type="hidden" name="hiddenModalAllday_YN" id="hiddenModalAllday_YN" value="" />
									<input type="hidden" name="hiddenModalRepeat_YN" id="hiddenModalRepeat_YN" value="" />
									<input type="hidden" name="hiddenModalMemberList" id="hiddenModalMemberList" value="" />
									<input type="hidden" name="hiddenModalSync_YN" id="hiddenModalSync_YN" value="" />
									<input type="hidden" name="hiddenModalEndDate" id="hiddenModalEndDate" value="" />
									<!-- deleteModal 만 사용 -->
									<input type="hidden" name="hiddenModalEXDate_YN" id="hiddenModalEXDate_YN" value="" />
									<input type="hidden" name="hiddenModalOrgStartDate" id="hiddenModalOrgStartDate" value="" />
									<input type="hidden" name="hiddenModalRruleDateOrder" id="hiddenModalRruleDateOrder" value="" />
									
									<input type="hidden" name="hiddenModalRruleSyncId" id="hiddenModalRruleSyncId" value="" />
									<input type="hidden" name="hiddenModalFollowingStartDate" id="hiddenModalFollowingStartDate" value="" />
									<input type="hidden" name="hiddenModalChangeCheckRuleByweekday" id="hiddenModalChangeCheckRuleByweekday" value="" /> 
									<input type="hidden" name="hiddenModalAllEventsStartDate" id="hiddenModalAllEventsStartDate" value="" />
									<input type="hidden" name="hiddenModalAllEventsEndDate" id="hiddenModalAllEventsEndDate" value="" />
									
									<input type="hidden" name="hiddenModalRRuleStartDateFlag" id="hiddenModalRRuleStartDateFlag" value="" />
									<input type="hidden" name="hiddenModalRRuleSettingCompareFlag" id="hiddenModalRRuleSettingCompareFlag" value="" />
									<input type="hidden" name="hiddenModalRRuleSettingAllEventFlag" id="hiddenModalRRuleSettingAllEventFlag" value="" />


									<input type="hidden" name="hiddenModalHanName" id="hiddenModalHanName" value="${userInfo.HAN_NAME}" /> 
									<input type="hidden" name="hiddenModalEmail" id="hiddenModalEmail" value="${userInfo.EMAIL}" />
			</form>

		</div>
<%--
		<div class="pg_bottom ta_c">
			<button type="button" class="btn lg btn-default pd_r15 pd_l15 r5" onClick="window.history.back();">취소</button>
			<button type="button" class="btn lg btn-primary pd_r15 pd_l15 r5" onClick="fncSaveSchedule(); return false;">저장</button>
			<!-- <button type="button" class="btn lg btn-primary pd_r15 pd_l15 r5">저장하고 메일보내기</button> -->
		</div>
 --%>
		<div class="pg_bottom ta_c">
<!-- 
			<button type="button" class="btn lg btn-default pd_r15 pd_l15 r3" onClick="fncSaveSchedule('delete'); return false;">삭제</button>
			<button type="button" class="btn lg btn-primary pd_r15 pd_l15 r3" onClick="fncSaveSchedule('submit'); return false;">저장</button>
 -->
			<button type="button" class="btn lg btn-default pd_r15 pd_l15 r3" onClick="modal.bfModal('delete'); return false;">삭제</button>
			<button type="button" class="btn lg btn-primary pd_r15 pd_l15 r3" onClick="modal.bfModal('submit'); return false;">저장</button>
			<button type="button" class="btn lg btn-primary pd_r15 pd_l15 r3" onclick="modal.mailSubmit(); return false;">저장하고 메일보내기</button>
		</div>


	</article>


	<article class="schedule_cont">

		<ul class="schedule_list" id="result_list">
		</ul>

	</article>

<jsp:include page="/WEB-INF/jsp/m/common/calendar_footer.jsp"/>
<!-- 
	<article class="fix_func">
		<ul>
			<li>
				<a href="" class="active">일</a>
			</li>
			<li>
				<a href="/calendar/viewCalendar.do">월</a>
			</li>
			<li>
				<a href="/calendar/calendarEvent.do">일정목록</a>
			</li>
			<li>
				<a href="">오늘</a>
			</li>
		</ul>
	</article>
 -->
 
 </div>

<div id="layer_submit" class="pop-layer">
	<div class="repeat_del_msg_pop">
		<div class="row top"><strong>반복일정 수정</strong></div>
		
		<div class="row mg_b10">
		이번 일정만 변경하시겠습니까 혹은 반복되는 일정 모두를 변경하시겠습니까?<br/>
		아니면 이번 일정과 향후의 반복되는 일정 모두를 변경하시겠습니까?<br /><br />
		</div>

		<div class="row mg_b10">
			<a href="#" onclick="modal.rruleSubmit(1,'submit'); return false;">이번 일정만</a>
			<span>반복일정의 다른 모든 일정을 그대로 유지합니다.</span>
		</div>
		<div class="row mg_b10">
			<a href="#" onclick="modal.rruleSubmit(2,'submit'); return false;">향후 모든 일정</a>
			<span>이 일정 및 향후 모든 일정이 모두 변경됩니다. 미래 일정에 대한 변경사항이 손실됩니다.</span>
		</div>
		<div class="row">
			<a href="#" onclick="modal.rruleSubmit(3,'submit'); return false;">모든 일정</a>
			<span>반복되는 모든 일정을 변경합니다. 다른 일정에 대한 변경사항이 손실됩니다.</span>
		</div>
		<div class="bottom">
		    <a href="#" class="cbtn">변경 취소</a>
		</div>
	</div>
</div>

<div id="layer_delete" class="pop-layer">
	<div class="repeat_del_msg_pop">
		<div class="row top"><strong>반복일정 삭제</strong></div>
		
		<div class="row mg_b10">반복되는 일정에서 이번 일정만 삭제, 전체 일정 삭제, 이번 일정과 향후 일정 삭제 중에서 선택하세요.</div>
		
		<div class="row mg_b10">
		    <a href="#" onclick="modal.rruleSubmit(1,'delete'); return false;">이번 일정만</a>
		    <span>반복일정의 다른 모든 일정을 그대로 유지합니다.</span>
		</div>
		<div class="row mg_b10">
		    <a href="#" onclick="modal.rruleSubmit(2,'delete'); return false;">향후 모든 일정</a>
		    <span>해당 일정 및 향후 모든 일정이 삭제됩니다.</span>
		</div>
		<div class="row">
		    <a href="#" onclick="modal.rruleSubmit(3,'delete'); return false;">모든 일정</a>
		    <span>반복되는 모든 일정을 삭제합니다.</span>
		</div>
		<div class="bottom">
		    <a href="#" class="cbtn">변경 취소</a>
		</div>
	</div>
</div>

<%--
<div id="layer_submit" class="pop-layer">
	<div class="pop-container">
		<div class="pop-conts">
			<!--content //-->
			<p class="ctxt mb20">
				<strong>반복일정 수정</strong><br />
				
				이번 일정만 변경하시겠습니까 혹은 반복되는 일정 모두를 변경하시겠습니까?<br/>
				아니면 이번 일정과 향후의 반복되는 일정 모두를 변경하시겠습니까?<br /><br />
				
				<!-- <a href="#" onclick="modal.rruleSubmit(1,'submit');">이번 일정만</a>
				<button type="button" onclick="modal.rruleSubmit(1,'submit');">이번 일정만</button> -->
				<input type="button" value="이번 일정만" onclick="modal.rruleSubmit(1,'submit');" />
				<span>반복일정의 다른 모든 일정을 그대로 유지합니다.</span><br />

				<!-- <a href="#" onclick="modal.rruleSubmit(2,'submit');">향후 모든 일정</a>
				<button type="button" onclick="modal.rruleSubmit(2,'submit');">향후 모든 일정</button> -->
				<input type="button" value="이번 일정만" onclick="modal.rruleSubmit(2,'submit');" />
				<span>이 일정 및 향후 모든 일정이 모두 변경됩니다. 미래 일정에 대한 변경사항이 손실됩니다.</span><br />
				
				<!-- <a href="#" onclick="modal.rruleSubmit(3,'submit');">모든 일정</a>
				<button type="button" onclick="modal.rruleSubmit(3,'submit');">모든 일정</button> -->
				<input type="button" value="이번 일정만" onclick="modal.rruleSubmit(3,'submit');" />
				<span>반복되는 모든 일정을 변경합니다. 다른 일정에 대한 변경사항이 손실됩니다.</span>
			</p>

			<div class="btn-r">
				<a href="#" class="cbtn">Close</a>
			</div>
			<!--// content-->
		</div>
	</div>
</div>

<div id="layer_delete" class="pop-layer">
	<div class="pop-container">
		<div class="pop-conts">
			<!--content //-->
			<p class="ctxt mb20">
				<strong>반복일정 삭제</strong><br />
				
				반복되는 일정에서 이번 일정만 삭제, 전체 일정 삭제, 이번 일정과 향후 일정 삭제 중에서 선택하세요.<br /><br />
				
				<!-- <a href="#" onclick="modal.rruleSubmit(1,'delete');">이번 일정만</a>
				<button type="button" onclick="modal.rruleSubmit(1,'delete');">이번 일정만</button> -->
				<input type="button" value="이번 일정만" onclick="modal.rruleSubmit(1,'delete');" />
				<span>반복되는 다른 모든 일정은 그대로 유지됩니다.</span><br />

				<!-- <a href="#" onclick="modal.rruleSubmit(2,'delete');">향후 모든 일정</a>
				<button type="button" onclick="modal.rruleSubmit(2,'delete');">향후 모든 일정</button> -->
				<input type="button" value="향후 모든 일정" onclick="modal.rruleSubmit(2,'delete');" />
				<span>해당 일정 및 향후 모든 일정이 삭제됩니다.</span><br />
				
				<!-- <a href="#" onclick="modal.rruleSubmit(3,'delete');">모든 일정</a>
				<button type="button" onclick="modal.rruleSubmit(3,'delete');">모든 일정</button> -->
				<input type="button" value="모든 일정" onclick="modal.rruleSubmit(3,'delete');" />
				<span>반복되는 모든 일정을 삭제합니다.</span>
			</p>

			<div class="btn-r">
				<a href="#" class="cbtn">Close</a>
			</div>
			<!--// content-->
		</div>
	</div>
</div>
 --%>

<div>
<jsp:include page="/WEB-INF/jsp/m/common/bottom.jsp"/>
 
<script src="${pageContext.request.contextPath}/js/m/moment/moment.js"></script>
<script src="${pageContext.request.contextPath}/js/m/rrule/rrule.js"></script>

<script type="text/javascript">
	var mode = '${mode}';
	var curDate = '${curDate}';
	//var v_start = "${detail.start}";
	//var v_end = "${detail.end}";
	var v_start_date = "${param.start_date}";
	var v_start_time = "${detail.START_TIME}";
	var v_start = v_start_date + ' ' + v_start_time;
	<c:choose>
		<c:when test="${detail.DAY_DIFF ne null && detail.DAY_DIFF ne ''}">
			var day_diff = Number("${detail.DAY_DIFF}");
		</c:when>
		<c:otherwise>
			var day_diff = 0;
		</c:otherwise>
	</c:choose>
	var v_end_date = moment(v_start).add(day_diff, 'days');
	v_end_date = moment(v_end_date).format("YYYY-MM-DD");
	v_end_time = "${detail.END_TIME}";
	v_end = v_end_date + ' ' + v_end_time;
	
	var v_event_code = "${detail.EVENT_CODE}";
	var v_time_gap = "${detail.TIME_GAP}";
	var v_title = "${detail.title}";
	var v_event_detail = "${detail.EVENT_DETAIL}";
	var v_location = "${detail.LOCATION}";
	var v_event_id = "${detail.EVENT_ID}";
	var v_calendar_id = "${detail.CALENDAR_ID}";
	var v_allDay = <c:choose><c:when test="${detail.allDay eq 1}">true</c:when><c:when test="${detail.allDay eq 0}">false</c:when><c:otherwise>""</c:otherwise></c:choose>;
	var v_sync_yn = "${detail.SYNC_YN}";
	var v_repeat_yn = "${detail.REPEAT_YN}";
	
	var v_recurrence_sync_id = "${detail.RRULE_SYNC_ID}";
	var v_recurrence_freq = "${detail.RECURRENCE_FREQ}";
	var v_recurrence_byweekday = "${detail.RECURRENCE_BYWEEKDAY}";
	var v_recurrence_interval = "${detail.RECURRENCE_INTERVAL}";
	var v_recurrence_bymonthday = "${detail.RECURRENCE_BYMONTHDAY}";
	var v_recurrence_end_date = "${detail.RECURRENCE_END_DATE}";
	var v_recurrence_count = Number("${detail.RECURRENCE_COUNT}");
	var v_recurrence_rule = "${detail.RECURRENCE_RULE}";
	var v_share_yn = "${detail.SHARE_YN}";
	var v_alarm_target = "${detail.ALARM_TARGET}";
	var v_alarm_flag = "${detail.ALARM_FLAG}";
	var v_before_move_time = "${detail.BEFORE_MOVE_TIME}";
	var v_after_move_time = "${detail.AFTER_MOVE_TIME}";
	
	var v_invite_name = "${detail.INVITE_NAME}";
	var v_invite_member_id = "${detail.INVITE_MEMBER_ID}";
	var v_invite_email = "${detail.INVITE_EMAIL}";
	var v_invite_calendar_id = "${detail.INVITE_CALENDAR_ID}";
	var v_ex_date_yn = "${detail.EX_DATE_YN}";
	var v_recurrence_dateorder = "${detail.RECURRENCE_DateOrder}";
</script>

<script src="${pageContext.request.contextPath}/js/m/view/calendar/modalCalendarInvite.js"></script>
<script src="${pageContext.request.contextPath}/js/m/view/calendar/modalCalendarFnc.js"></script>
<script src="${pageContext.request.contextPath}/js/m/view/calendar/modalCalendarRrule.js"></script>
<script src="${pageContext.request.contextPath}/js/m/view/calendar/modalCalendarForm.js"></script>

</body>
</html>