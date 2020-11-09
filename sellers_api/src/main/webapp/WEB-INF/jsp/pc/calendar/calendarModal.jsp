<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="modal inmodal fade" id="myModal1" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title"></h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-lg-12">
						<div class="ibox ">
							<div class="ibox-content border_n">
								<form class="form-horizontal" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">
									<div class="form-group">
										<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 제목</label>
										<div class="col-sm-10">
											<input type="text" class="form-control"
												name="textModalEventSubject" id="textModalEventSubject" autocomplete="off"/>
										</div>
									</div>
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 일정 구분</label>
										<div class="col-sm-2">
											<div class="select-com">
												<!-- <label>항목선택</label> -->
												<select class="form-control" name="selectModalEventCode"
													id="selectModalEventCode" onclick="modal.checkEventCode();">
													<!-- properties에서 셀렉트 목록 가져오기 -->
													<spring:eval expression="@config['code.calModalEventList']" />
												</select>
											</div>
										</div>



										<div style="display: none">
											<label class="col-sm-1 control-label">달력</label>
											<div class="col-sm-3">
												<select class="form-control" name="selectModalCalendarID"
													id="selectModalCalendarID">
													<c:choose>
														<c:when test="${fn:length(calendarList) > 0}">
															<c:forEach items="${calendarList}" var="calendarList">
																<c:choose>
																	<c:when
																		test="${(calendarList.MEMBER_ID_NUM eq userInfo.MEMBER_ID_NUM) && (calendarList.CALENDAR_NAME eq '나의 캘린더')}">
																		<option id="${calendarList.SYNC_YN}"
																			value="${calendarList.CALENDAR_ID}">${calendarList.CALENDAR_NAME}</option>
																	</c:when>
																</c:choose>
															</c:forEach>
														</c:when>
													</c:choose>
												</select>
											</div>
										</div>

										<label class="col-sm-1 control-label">장소</label>
										<div class="col-sm-7">
											<input type="text" class="form-control"
												name="textModalEventLocation" id="textModalEventLocation" autocomplete="off"/>
										</div>

									</div>
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label">상세 내용</label>
										<div class="col-sm-10">
											<textarea class="pop-textarea-input" rows="3" name="textareaModalEventDetail" id="textareaModalEventDetail"
												 onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea>
										</div>
									</div>


									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="date_modified">일정 시작</label>
										<div class="col-sm-10">
											<div class="col-xs-12 col-sm-4 pd-b10">
												<div class="data_1">
													<div class="input-group date">
														<span class="input-group-addon"><i
															class="fa fa-calendar"></i></span><input type="text"
															onclick="modal.startDateTmp(this);"
															onchange="rrule.nthOfMonth();if(startDateTmp != $(this).val())modal.chkDate(this);"
															class="form-control" name="textModalStartDate"
															id="textModalStartDate" value="">
													</div>
												</div>
											</div>
											<div class="col-xs-12 col-sm-3 pd-b10">
												<div class="select-com">
													<select class="form-control"
														name="selectModalStartDateTime"
														id="selectModalStartDateTime" onclick=""
														onchange="modal.changeEndDate();">
														<option value="">선택</option>
														<option value="06:00">오전 06:00</option>
														<option value="06:30">오전 06:30</option>
														<option value="07:00">오전 07:00</option>
														<option value="07:30">오전 07:30</option>
														<option value="08:00">오전 08:00</option>
														<option value="08:30">오전 08:30</option>
														<option value="09:00">오전 09:00</option>
														<option value="09:30">오전 09:30</option>
														<option value="10:00">오전 10:00</option>
														<option value="10:30">오전 10:30</option>
														<option value="11:00">오전 11:00</option>
														<option value="11:30">오전 11:30</option>
														<option value="12:00">오후 12:00</option>
														<option value="12:30">오후 12:30</option>
														<option value="13:00">오후 01:00</option>
														<option value="13:30">오후 01:30</option>
														<option value="14:00">오후 02:00</option>
														<option value="14:30">오후 02:30</option>
														<option value="15:00">오후 03:00</option>
														<option value="15:30">오후 03:30</option>
														<option value="16:00">오후 04:00</option>
														<option value="16:30">오후 04:30</option>
														<option value="17:00">오후 05:00</option>
														<option value="17:30">오후 05:30</option>
														<option value="18:00">오후 06:00</option>
														<option value="18:30">오후 06:30</option>
														<option value="19:00">오후 07:00</option>
														<option value="19:30">오후 07:30</option>
														<option value="20:00">오후 08:00</option>
														<option value="20:30">오후 08:30</option>
														<option value="21:00">오후 09:00</option>
														<option value="21:30">오후 09:30</option>
														<option value="22:00">오후 10:00</option>
														<option value="22:30">오후 10:30</option>
														<option value="23:00">오후 11:00</option>
														<option value="23:30">오후 11:30</option>
													</select>
												</div>
											</div>

											<div id="divModalEventCode">
												<div class="form-group">
													<label class="col-sm-2 control-label">전 이동시간</label>
													<div class="col-sm-3">
														<div class="select-com">
															<select class="form-control"
																name="selectModalBeforeMoveTimeMin"
																id="selectModalBeforeMoveTimeMin">
																<option value="0" selected="selected">선택</option>
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
												</div>
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="date_modified">일정 종료</label>
										<div class="col-sm-10">
											<div class="col-xs-12 col-sm-4">
												<div class="data_1">
													<div class="input-group date">
														<span class="input-group-addon"><i
															class="fa fa-calendar"></i></span><input type="text"
															onchange="rrule.nthOfMonth();modal.chkDate(this);" class="form-control"
															name="textModalEndDate" id="textModalEndDate" value=""
															onchange='if($("#checkboxModalEndRuleDate").prop("checked")) $("#spanMoalEndRuleDate").html("일정 종료일 "+$("#textModalEndDate").val());'>
													</div>
												</div>
											</div>
											<div class="col-xs-12 col-sm-3">
												<div class="select-com">
													<select class="form-control" name="selectModalEndDateTime"
														id="selectModalEndDateTime">
														<option value="">선택</option>
														<option value="07:00">오전 06:00</option>
														<option value="07:00">오전 06:30</option>
														<option value="07:00">오전 07:00</option>
														<option value="07:30">오전 07:30</option>
														<option value="08:00">오전 08:00</option>
														<option value="08:30">오전 08:30</option>
														<option value="09:00">오전 09:00</option>
														<option value="09:30">오전 09:30</option>
														<option value="10:00">오전 10:00</option>
														<option value="10:30">오전 10:30</option>
														<option value="11:00">오전 11:00</option>
														<option value="11:30">오전 11:30</option>
														<option value="12:00">오후 12:00</option>
														<option value="12:30">오후 12:30</option>
														<option value="13:00">오후 01:00</option>
														<option value="13:30">오후 01:30</option>
														<option value="14:00">오후 02:00</option>
														<option value="14:30">오후 02:30</option>
														<option value="15:00">오후 03:00</option>
														<option value="15:30">오후 03:30</option>
														<option value="16:00">오후 04:00</option>
														<option value="16:30">오후 04:30</option>
														<option value="17:00">오후 05:00</option>
														<option value="17:30">오후 05:30</option>
														<option value="18:00">오후 06:00</option>
														<option value="18:30">오후 06:30</option>
														<option value="19:00">오후 07:00</option>
														<option value="19:30">오후 07:30</option>
														<option value="20:00">오후 08:00</option>
														<option value="20:30">오후 08:30</option>
														<option value="21:00">오후 09:00</option>
														<option value="21:30">오후 09:30</option>
														<option value="22:00">오후 10:00</option>
														<option value="22:30">오후 10:30</option>
														<option value="23:00">오후 11:00</option>
														<option value="23:30">오후 11:30</option>
														<option value="24:00" style="display: none;">선택</option>
													</select>
												</div>
											</div>

											<div id="divModalEventCode2" style="display: none">
												<div class="form-group">
													<label class="col-sm-2 control-label">후 이동시간</label>
													<div class="col-sm-3">
														<div class="select-com">
															<select class="form-control"
																name="selectModalAfterMoveTimeMin"
																id="selectModalAfterMoveTimeMin">
																<option value="0" selected="selected">선택</option>
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
												</div>
											</div>
										</div>
									</div>

									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label">시간 옵션</label>
										<div class="col-sm-10">
											<label class="btn-allday" style="margin-right: 30px">
												<input type="checkbox" value="N" class=""
												onclick="modal.chkBox(this)" name="checkboxModalAllday"
												id="checkboxModalAllday" /> <span class="v-m">종일</span>
											</label> <label class="btn-repeat" style="margin-right: 30px">
												<input type="checkbox" value="N" class=""
												onclick="modal.chkBox(this)" name="checkboxModalRepeat"
												id="checkboxModalRepeat" /> <span class="v-m">반복</span>
											</label>
											<label class="btn-repeat" id="labelModalRepeat">
											<span class="v-m"><a onclick="if($('#divModalRepeatOption').css('display') == 'none'){$('#divModalRepeatOption').show();}else{$('#divModalRepeatOption').hide();}">반복 설정</a></span>
											</label>

											<div class="repeat-option" id="divModalRepeatOption">
												<!-- 반복설정 선택시 노출되는 영역 -->
												<div class="title">반복 설정</div>

												<div class="form-group">
													<label class="col-sm-2 control-label">반복 빈도</label>
													<div class="col-sm-10">
														<div class="select-com">
															<!-- <label>항목선택</label> -->
															<select class="form-control m-b" name="selectModalFreq"
																id="selectModalFreq" onchange="rrule.selectFreq(this);">
																<option value="2" selected="selected">매주</option>
																<option value="1">매월</option>
																<option value="3">분기</option>
																<option value="4">반기</option>
															</select>
														</div>
													</div>
												</div>
												<div class="form-group" name="divModalInterval"
													id="divModalInterval">
													<label class="col-sm-2 control-label">반복 간격</label>
													<div class="col-sm-10">
														<div class="select-com">
															<!-- <label>항목선택</label> -->
															<select class="form-control m-b"
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
													</div>
												</div>
												<div class="form-group" name="divModalInterval"
													id="divModalMonthlyByweekday">
													<label class="col-sm-2 control-label">반복 마감일 </label>
													<div class="col-sm-10">
														<label class="select-com"> <input type="radio"
															name="divModalMonthlyRule" value="BYMONTHDAY"
															checked="checked"><label class="mg-r10"
															id="divModalMonthlyRuleDate">매월 **일</label> <input
															type="radio" name="divModalMonthlyRule" value="BYDAY"><label
															class="mg-r10" id="divModalMonthlyRuleTh">매월 *번째
																*요일</label>
														</label>
													</div>
												</div>
												<div class="form-group" id="divModalElseByweekday">
													<label class="col-sm-2 control-label">반복일</label>
													<div class="col-sm-10">
														<label class="mg-r10"> <input type="checkbox"
															name="RRulecheckboxModalByweekday"
															id="checkboxModalRRuleMO" value="0" class="" /> <span
															class="v-m">월</span></label> <label class="mg-r10"> <input
															type="checkbox" name="RRulecheckboxModalByweekday"
															id="checkboxModalRRuleTU" value="1" class="" /> <span
															class="v-m">화</span></label> <label class="mg-r10"> <input
															type="checkbox" name="RRulecheckboxModalByweekday"
															id="checkboxModalRRuleWE" value="2" class="" /> <span
															class="v-m">수</span></label> <label class="mg-r10"> <input
															type="checkbox" name="RRulecheckboxModalByweekday"
															id="checkboxModalRRuleTH" value="3" class="" /> <span
															class="v-m">목</span></label> <label class="mg-r10"> <input
															type="checkbox" name="RRulecheckboxModalByweekday"
															id="checkboxModalRRuleFR" value="4" class="" /> <span
															class="v-m">금</span></label> <label class="mg-r10"> <input
															type="checkbox" name="RRulecheckboxModalByweekday"
															id="checkboxModalRRuleSA" value="5" class="" /> <span
															class="v-m">토</span></label> <label class="mg-r10"> <input
															type="checkbox" name="RRulecheckboxModalByweekday"
															id="checkboxModalRRuleSU" value="6" class="" /> <span
															class="v-m">일</span></label>
													</div>
												</div>
												
												<div class="form-group">
													<label class="col-sm-2 control-label">종료일</label>
													<div class="col-sm-10">
														<label class="mg-r10"> 
															<input type="radio" checked="checked" name="radioModalEndRule" id="radioModalCountNull" value="" class="" onclick="rrule.endRuleRadio();"/>
															<span class="v-m">계속 반복</span>
														</label>
														<div class="mg-r10">
															<input type="radio" name="radioModalEndRule" id="radioModalCountNum" value="count" class=""	onclick="rrule.endRuleRadio();"/>
															<span>
																<input type="text" disabled="" name="textModalCountNum" id="textModalCountNum" value="" style="width: 40px;" maxlength="4">
																번 반복 후 종료
															</span>
														</div>
														<label class="mg-r10">
															<input type="radio" name="radioModalEndRule" id="checkboxModalEndRuleDate" value="until" class="" onclick="rrule.endRuleRadio();" />
															<span class="v-m">종료일:
																<div style="display:inline-block; vertical-align: middle;" class="data_1 rrule">
	                                  <div class="input-group date">
	                                      <input type="text" style="width:120px;" class="form-control add-on" id="textModalEndRuleDate" name="textModalEndRuleDate" value="" onchange="rrule.chkEndDate();">
	                                  </div>
	                              </div>
															</span>
														</label>														
													</div>
												</div>
												
											</div>
										</div>
									</div>
									
									<!-- 알림 팝업 추가 -->
									<div class="repeat_upd_msg_pop2">
                                        <div class="row top"><strong>반복일정 수정</strong></div>
									<!-- 
                                        <div class="row mg-b10">이번 일정만 변경하시겠습니까 혹은 반복되는 일정 모두를 변경하시겠습니까?<br/>
                                        	아니면 이번 일정과 향후의 반복되는 일정 모두를 변경하시겠습니까?</div>
									 -->
 										<br/>
 
                                        <div class="row mg-b10">
                                            <a href="#" onclick="modal.rruleSubmit(1,'submit');">이번 일정만</a>
                                            <span>반복일정의 다른 모든 일정을 그대로 유지합니다.</span>
                                        </div>
                                        <div class="row mg-b10">
                                            <a href="#" onclick="modal.rruleSubmit(2,'submit');">향후 모든 일정</a>
                                            <span>이 일정 및 향후 모든 일정이 모두 변경됩니다. 미래 일정에 대한 변경사항이 손실됩니다.</span>
                                        </div>
                                        <div class="bottom">
                                            <a href="#" class="" onclick="$('.repeat_upd_msg_pop2').hide();">변경 취소</a>
                                        </div>
                                    </div>
									
									<!-- 반복일정 삭제시 알림 팝업 : 2017-06-02 -->
									<div class="repeat_upd_msg_pop">
                                        <div class="row top"><strong>반복일정 수정</strong></div>

                                        <div class="row mg-b10">이번 일정만 변경하시겠습니까 혹은 반복되는 일정 모두를 변경하시겠습니까?<br/>
                                        	아니면 이번 일정과 향후의 반복되는 일정 모두를 변경하시겠습니까?</div>

                                        <div class="row mg-b10">
                                            <a href="#" onclick="modal.rruleSubmit(1,'submit');">이번 일정만</a>
                                            <span>반복일정의 다른 모든 일정을 그대로 유지합니다.</span>
                                        </div>
                                        <div class="row mg-b10">
                                            <a href="#" onclick="modal.rruleSubmit(2,'submit');">향후 모든 일정</a>
                                            <span>이 일정 및 향후 모든 일정이 모두 변경됩니다. 미래 일정에 대한 변경사항이 손실됩니다.</span>
                                        </div>
                                        <div class="row">
                                            <a href="#" onclick="modal.rruleSubmit(3,'submit');">모든 일정</a>
                                            <span>반복되는 모든 일정을 변경합니다. 다른 일정에 대한 변경사항이 유지됩니다.</span>
                                        </div>
                                        <div class="bottom">
                                            <a href="#" class="" onclick="$('.repeat_upd_msg_pop').hide();">변경 취소</a>
                                        </div>
                                    </div>
									
                                    <div class="repeat_del_msg_pop">
                                        <div class="row top"><strong>반복일정 삭제</strong></div>

                                        <div class="row mg-b10">반복되는 일정에서 이번 일정만 삭제, 전체 일정 삭제, 이번 일정과 향후 일정 삭제 중에서 선택하세요.</div>

                                        <div class="row mg-b10">
                                            <a href="#" onclick="modal.rruleSubmit(1,'delete');">이번 일정만</a>
                                            <span>반복되는 다른 모든 일정은 그대로 유지됩니다.</span>
                                        </div>
                                        <div class="row mg-b10">
                                            <a href="#" onclick="modal.rruleSubmit(2,'delete');">향후 일정 모두</a>
                                            <span>해당 일정 및 향후 모든 일정이 삭제됩니다.</span>
                                        </div>
                                        <div class="row">
                                            <a href="#" onclick="modal.rruleSubmit(3,'delete');">반복 일정 모두</a>
                                            <span>반복되는 모든 일정을 삭제합니다.</span>
                                        </div>
                                        <div class="bottom">
                                            <a href="#" class="" onclick="$('.repeat_del_msg_pop').hide();">삭제 취소</a>
                                        </div>
                                    </div>
                                    <!--// 반복일정 삭제시 알림 팝업 : 2017-06-02 -->
									
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label">초대 옵션</label>
										<div class="col-sm-10">
											<label class="btn-invite" style="margin-right: 30px">
												<input type="checkbox" value="N" class=""
												onclick="modal.inviteChkBox(this)"
												name="checkboxModalInvite" id="checkboxModalInvite" /> <span
												class="v-m">초대</span>
											</label>

											<!-- =========================================================================== -->


											<div class="repeat-option" id="divModalConviteOption">
												<!-- 초대옵션 선택시 노출되는 영역 -->

												<div class="form-group pos-rel">
													<label class="col-md-3 col-lg-2 control-label">참석자
														초대</label>
													<div class="col-sm-10">
														<div class="company-search mg-b5">
															<div class="company-current"></div>
															<button type="button" class="btn btn-gray btn-file"
																onClick="modal.showCustomPop();">검색</button>
														</div>
													</div>

													<div class="custom-company-pop off">
														<div class="pop-header">
															<button type="button" class="close">
																<span aria-hidden="true">&times;</span><span
																	class="sr-only">Close</span>
															</button>
															<strong class="pop-title">참석자 선택</strong>
														</div>
														<div class="col-sm-12 cont">
															<div class="form-group">
																<div class="col-sm-12">
																	<div class="company-search mg-b5">
																		<!-- 검색 -->
																		<button type="button" class="btn btn-gray btn-file" onClick="commonSearch.multipleMemberPop();">검색</button>
																		<input type="text" placeholder="참석자 검색" class="form-control fl_l mg-r5" id="textCommonSearchMember">
																	</div>
																</div>
																<div class="col-sm-12 company-result mg-b10 ">
																	<!-- 검색 결과 노출시 "off" 삭제 -->
																	<strong>[참석자 검색 결과]</strong>
																	<ul class="company-list">
																	</ul>
																</div>
															</div>
														</div>
													</div>


													<!-- 캘린더 모달창 참석자 리스트 뿌려지는곳 -->
													<div class="invite-area-list "></div>
												</div>
											</div>



											<!-- ================================================================================ -->
										</div>
									</div>

									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label">공개 상태</label>
										<div class="col-sm-10">
											<label style="margin-right: 30px"> <input
												type="radio" name="radioModalShareYN" id="radioModalShareY"
												value="Y" /> <span class="v-m">공개</span></label> <label
												style="margin-right: 30px"> <input type="radio"
												name="radioModalShareYN" id="radioModalShareN" value="N" />
												<span class="v-m">비공개</span></label>
										</div>
									</div>

									<!-- 알림 방식이 정의되지않아, 일단은 셀렉박스 display none -->
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label">일정 알림</label>
										<div class="col-sm-2" style="display: none">
											<select class="form-control m-b" name="selectModalAlam"
												id="selectModalAlam">
												<option value="mainNotice">알림쪽지</option>
												<option value="dbEmail">이메일</option>
											</select>

										</div>

										<div class="col-sm-8">
											<label style="margin-right: 30px"> <input
												type="radio" name="radioModalAlam" id="radioModalAlam0"
												value="notNotice" /> <span class="v-m">안함</span></label> <label
												style="margin-right: 30px"> <input type="radio"
												name="radioModalAlam" id="radioModalAlam1" value="oneHour" />
												<span class="v-m">한시간 전</span></label> <label
												style="margin-right: 30px"> <input type="radio"
												name="radioModalAlam" id="radioModalAlam2" value="oneDay" />
												<span class="v-m">하루 전</span></label> <label
												style="margin-right: 30px"> <input type="radio"
												name="radioModalAlam" id="radioModalAlam3" value="oneWeek" />
												<span class="v-m">일주일 전</span></label>
										</div>
									</div>

									<div class="hr-line-dashed"></div>
									<br /> <br />
									<p class="text-center">
										<button type="button"
											class="btn btn-outline btn-primary btn-gray-outline"
											name="buttonModalDelete" id="buttonModalDelete"
											onClick="modal.bfModal('delete');">삭제하기</button>
											<!-- onClick="modal.deleteModal();">삭제하기</button> -->
										<button type="button" class="btn btn-w-m btn-primary btn-gray"
											name="buttonModalSubmit" id="buttonModalSubmit"
											onClick="modal.bfModal('submit');">저장하기</button>
											<!-- onClick="modal.submit();">저장하기</button> -->
										<!-- <div class="repeat-option" id="divModalConviteButton"> -->

										<!-- <button type="submit" class="btn btn-w-m btn-primary btn-gray"
											name="buttonModalMailSubmit" id="buttonModalMailSubmit"
											onClick="modal.mailSubmit();">저장하고 메일보내기</button> -->
										<!-- </div> -->

									</p>
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
									<input type="hidden" name="hiddenModalSync_YN" id="hiddenModalSync_YN" value="" /> 
									<input type="hidden" name="hiddenModalEndDate" id="hiddenModalEndDate" value="" />
									<input type="hidden" name="hiddenModalEXDate_YN" id="hiddenModalEXDate_YN" value="" />
									<input type="hidden" name="hiddenModalOrgStartDate" id="hiddenModalOrgStartDate" value="" />
									<input type="hidden" name="hiddenModalRruleDateOrder" id="hiddenModalRruleDateOrder" value="" />
									<input type="hidden" name="hiddenModalRruleSyncId" id="hiddenModalRruleSyncId" value="" />
									<input type="hidden" name="hiddenModalFollowingStartDate" id="hiddenModalFollowingStartDate" value="" />
									<input type="hidden" name="hiddenModalChangeCheckRuleByweekday" id="hiddenModalChangeCheckRuleByweekday" value="" /> 
									<input type="hidden" name="hiddenModalAllEventsStartDate" id="hiddenModalAllEventsStartDate" value="" />
									<input type="hidden" name="hiddenModalAllEventsEndDate" id="hiddenModalAllEventsEndDate" value="" />
									<input type="hidden" name="hiddenModalGoogleId" id="hiddenModalGoogleId" value="" />
									<input type="hidden" name="hiddenModalGoogleCalendarId" id="hiddenModalGoogleCalendarId" value="" />
									
									<input type="hidden" name="hiddenModalRRuleStartDateFlag" id="hiddenModalRRuleStartDateFlag" value="" />
									<input type="hidden" name="hiddenModalRRuleSettingCompareFlag" id="hiddenModalRRuleSettingCompareFlag" value="" />
									<input type="hidden" name="hiddenModalRRuleSettingAllEventFlag" id="hiddenModalRRuleSettingAllEventFlag" value="" />

									<input type="hidden" name="hiddenModalHanName" id="hiddenModalHanName" value="${userInfo.HAN_NAME}" /> 
									<input type="hidden" name="hiddenModalEmail" id="hiddenModalEmail" value="${userInfo.EMAIL}" />
									
									<input type="hidden" name="hiddenModalOutlookId" id="hiddenModalOutlookId" value="" />
									<input type="hidden" name="hiddenModalSyncFlag" id="hiddenModalSyncFlag" value="" />
									<input type="hidden" name="hiddenModalRruleId" id="hiddenModalRruleId" value="" />
									<input type="hidden" name="hiddenModalExEventYn" id="hiddenModalExEventYn" value="" />
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
</div>

<script type="text/javascript">
$(document).ready(function() { 
	modal.init();
});		
//월반복 변수 (매월 **일, 매월 *번째 *요일)
var monthRruleDate = "";
var monthRruleTh = "";
var monthRruleDayEn = "";
var monthRruleThKo = "";
var monthRruleDay = "";
var monthRruleDayKo = "";

var ruleToString;
var rruleStartList;
var rruleEndList;

var rruleCase = 0;
var compareStartDate = 0;
var startDateTmp = "";

var modal = {
		init : function(){
			
			//유효성 체크
			modal.validate();

			//자동완성 검색
			/* commonSearch.calendarMember($("#formModalData #textModalInviteName"), $("#textModalInviteId"), $("#textModalInviteMail"), $("#textModalInviteCalendarId")); */
			$("#textCommonSearchMember").keydown(function (key) {
		   		if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
		   			commonSearch.multipleMemberPop();
			     }
			 });
			
			$("#textCommonSearchMultipleMember").keydown(function (key) {
		   		if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
		   			commonSearch.inviteMemberSerch();
			     }
			 });
			
			modal.checkCalendarSync();
		},
		
		// 동료 검색 창 show
		showCustomPop : function(){
			$('#formModalData .custom-company-pop .company-list').html('');
			$('#textCommonSearchMember').val('');
	  	$('#formModalData .custom-company-pop').show();
		},
		
		changeEndDate : function() {
			var startDateTime = $("#selectModalStartDateTime").val();
			
			var split = startDateTime.split(":");
			var endHour = "";
			(parseInt(split[0],"10")+1) > 9 ? endHour = parseInt(split[0],"10")+1 : endHour = "0"+(parseInt(split[0],"10")+1);
			$("#selectModalEndDateTime").val(endHour+":"+split[1]);
		},
		
		startDateTmp : function(sDate) {
			startDateTmp = $(sDate).val();
		},
		
		//신규등록
		reset : function(date) {
			modalFlag = "ins";
			$('#formModalData').validate().resetForm();	
			
			/* $("#divInviteMemberList").html('');
        	$("#divInviteMemberList").html('<div class="form-group"><label class="col-sm-2 control-label" style="text-align: center;">이름</label>'+
              		   '<label class="col-sm-4 control-label" style="text-align: center;">메일</label>'+
              		   '<label class="col-sm-2 control-label" style="text-align: center;">수락여부</label>'+
              		   '<label class="col-sm-4 control-label" style="text-align: center;">수락시간</label></div>'); */
              		   
	
			$("small.font-bold").html("");
			$("#formModalData input:text").val("");
			$("#formModalData select > option:first").prop("selected",true);
			$("#formModalData textarea").val("");
			$("#formModalData textarea").height(1).height(33);
			$("#formModalData .invite-area-list").html("");
			$("#checkboxModalInvite").val("N");
     	$("#checkboxModalInvite").prop("checked", false);
     	$("#divModalConviteOption").css("display", "none");
			
			
			//$('select[name^="selectModal"]').val("");
			//$('select[name^="selectModal"]').attr("disabled", false);
			$('input[name^="checkboxModal"]').val("N");
			$('input[name^="checkboxModal"]').prop("checked", false);
			
			//$('select[id^="selectModalSyncId"] > option:nth-child(2)').attr("selected", "selected");
			$("#radioModalCountNull").prop("checked", true);
			$("#selectModalBeforeMoveTimeMin").val("0");
			$("#selectModalAfterMoveTimeMin").val("0");
			$("#selectModalFreq").val("2");
			$("#selectModalInterval").val("1");
			//$("#divModalInterval").hide();
			rrule.selectFreq($("#selectModalFreq")[0]);
			
			$("#hiddenModalAllday_YN").val("N");
			$("#hiddenModalRepeat_YN").val("N");
			
			$("h4.modal-title").html("일정관리 신규 등록");
			$("#buttonModalSubmit").html("저장하기");
			$("#buttonModalMailSubmit").html("저장하고 메일보내기");
			$("#buttonModalDelete").css('display','none');
			/* 
			if($("#checkboxModalInvite").val()=='N'){
				alert("asfasf");
				$("#buttonModalMailSubmit").css('display', 'none');
			}else{
				alert("aaa");
				$("#buttonModalMailSubmit").css('display', '');
			} 
			 */
			 
			$("#buttonModalMailSubmit").css("display", "none");
			$("input:checkbox[name=RRulecheckboxModalByweekday]").each(function (index) {  
				this.checked=false;
		    }); 
			$("#textModalCountNum").attr("disabled", true); 
     	$("#textModalEndRuleDate").attr("disabled", true);
     	
     	$("div.company-current").html("");
     	$("#hiddenModalMemberList").val("");
     	commonSearch.multipleMemberArray=[];
        	
			if(date && date != moment().format("YYYY-MM-DD")) {
				$("#textModalStartDate").val(moment(date).format("YYYY-MM-DD"));
				$("#textModalEndDate").val(moment(date).format("YYYY-MM-DD"));
				$("#selectModalStartDateTime").val("09:00");
				$("#selectModalEndDateTime").val("10:00");
			}else {
				var hour = new Date().getHours()>9 ? ''+new Date().getHours() : '0'+new Date().getHours();
				var min = new Date().getMinutes()>9 ? ''+new Date().getMinutes() : '0'+new Date().getMinutes();

				if(parseInt(min)==0) {
					$("#selectModalStartDateTime").val(hour+":00");
					hour = (new Date().getHours()+1)>9 ? ''+(new Date().getHours()+1) : '0'+(new Date().getHours()+1);
					$("#selectModalEndDateTime").val(hour+":00");
				}else if(parseInt(min)>0 && parseInt(min)<=30) {
					$("#selectModalStartDateTime").val(hour+":30");
					hour = (new Date().getHours()+1)>9 ? ''+(new Date().getHours()+1) : '0'+(new Date().getHours()+1);
					$("#selectModalEndDateTime").val(hour+":30");
				}else if(parseInt(min)>30) {
					hour = (new Date().getHours()+1)>9 ? ''+(new Date().getHours()+1) : '0'+(new Date().getHours()+1);
					$("#selectModalStartDateTime").val(hour+":00");
					hour = (new Date().getHours()+2)>9 ? ''+(new Date().getHours()+2) : '0'+(new Date().getHours()+2);
					$("#selectModalEndDateTime").val(hour+":00");
				}
				$("#textModalStartDate").val(commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
				$("#textModalEndDate").val(commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			}
			
			// 여기부터
			var $officeCalendars = $("#calendar-other-office365").children();
			if($officeCalendars.size() == 0){
				
			}else{
				
			}
			
			//이동시간
			if($("#selectModalEventCode option:selected").attr('id')=='meeting') {
				$("#divModalEventCode").show();
				$("#divModalEventCode2").show();
			}else {
				$("#divModalEventCode").hide();
				$("#divModalEventCode2").hide();
			}
			
			$("input:radio[name='radioModalShareYN']:radio[value='Y']").prop("checked", true)
			$("input:radio[name='radioModalAlam']:radio[value='notNotice']").prop("checked", true)
			 
			$("#divModalRepeatOption").hide();
			$("#divModalMoveOption").hide();
			$("#divModalConviteOption").hide();
			
			rrule.nthOfMonth();
			
			$("#labelModalRepeat").hide();
			$(".repeat_upd_msg_pop").hide();
			$(".repeat_upd_msg_pop2").hide();
			$(".repeat_del_msg_pop").hide();
			$("#checkboxModalRepeat").parent().show();
			$("#selectModalStartDateTime").css("display", "");
			$("#selectModalEndDateTime").css("display", "");
			$("#myModal1").modal();
			
			//신규등록창도 수정사항 확인.
			compare_before = $("#formModalData").serialize();
		},
		
		validate : function(){
			$("#formModalData").validate({ // joinForm에 validate를 적용
				ignore: "", 
				rules : {
					textModalEventSubject : {
						required : true,
						maxlength : 100
					},
					selectModalEventCode : {
						required : true
					},
					/* selectModalCalendarID : {
						required : true,
						maxlength : 10
					}, */
					selectModalSyncId : {
						required : true,
					}
				//pwdConfirm:{required:true, equalTo:"#pwd"}, 
				// equalTo : id가 pwd인 값과 같아야함
				//name:"required", // 검증값이 하나일 경우 이와 같이도 가능
				//personalNo1:{required:true, minlength:6, digits:true},
				// minlength : 최소 입력 개수, digits: 정수만 입력 가능
				//personalNo2:{required:true, minlength:7, digits:true},
				//email:{required:true, email:true},
				// email 형식 검증
				//blog:{required:true, url:true}
				// url 형식 검증
				},
				messages : { // rules에 해당하는 메시지를 지정하는 속성
					textModalEventSubject : {
						required : "제목을 입력하세요.",
						maxlength:"100글자 이하여야 합니다" 
					},
					selectModalEventCode : {
						required : "일정을 선택하세요."
					},
				/* 	selectModalCalendarID : {
						required : "일정을 저장할 달력을 선택하세요."
					}, */
					selectModalSyncId: {
						required : "Sync 여부를 선택하세요."
					}
				}
				/* errorPlacement : function(error, element) {
				    if($(element).prop("id") === "hiddenModalCompanyId") {
				        $("div.company-current").append(error);
				        location.href = "#textCommonSearchCompany";
				    }
				    else {
				        error.insertAfter(element); // default error placement.
				    }
				} */
			})
		}, 
		
		//외부캘린더 공유여부 확인
		/* 
		checkCalendarSync : function() {
			if($("#selectModalSyncId option:selected").attr('id')=='Y') {
				$("#divModalSyncCalendar").show();
			}else {
				$("#divModalSyncCalendar").hide();
			}
		},
		 */
		//외부캘린더 공유여부 확인
		checkCalendarSync : function() {
			//alert($("#calendarSyncYN").val());
			if($("#calendarSyncYN").val() == 'N'){
				$("#divModalSyncCalendar").hide();
			}else{
				$("#divModalSyncCalendar").show();
			}
			/* 
			if($("#hiddenModalSync_YN option:selected").attr('id')=='Y') {
				$("#divModalSyncCalendar").show();
			}else {
				$("#divModalSyncCalendar").hide();
			}
			 */
		},
		
		//일정구분
		checkEventCode : function() {
			if($("#selectModalEventCode option:selected").attr('id')=='meeting') {
				$("#divModalEventCode").show();
				$("#divModalEventCode2").show();
			}else {
				$("#divModalEventCode").hide();
				$("#divModalEventCode2").hide();
			}
		},
		
		//반복일정 수정일정인지 아닌지 체크
		bfModal : function(val) {
			compare_after = $("#formModalData").serialize();
			if(val == 'submit' && compare_before != compare_after){
				if(modalFlag == 'upd' && ($('#hiddenModalRruleString').val()!=null && $('#hiddenModalRruleString').val()!='')){
					//$(".repeat_upd_msg_pop").show();
					 
					if($("#textModalStartDate").val() == startDateCmp)
					{
						compareStartDate = 0;
						$(".repeat_upd_msg_pop").show();
					}
					else
					{
						compareStartDate = 1;
						$(".repeat_upd_msg_pop2").show();
					}
					
				}else{
					modal.submit();
				}
			}else if(val == 'submit' && compare_before == compare_after){
				$('#myModal1').modal("hide");
			}else if(val == 'delete'){
				if(modalFlag == 'upd' && ($('#hiddenModalRruleString').val()!=null && $('#hiddenModalRruleString').val()!='')){
					$(".repeat_del_msg_pop").show();
					}else{
						modal.deleteModal();
				}
			}
		},
		
		// 반복일정삭제시 deleteModal()전에 태움 팝업창 버튼3개 
		// rruleCase 1:선택한일정만 삭제, 2:선택한 일정부터 반복일정 삭제, 3:반복일정 전체삭제
		rruleSubmit : function(num, type) {
			compareFlag = true;
			rruleCase = num;
			
			if(rruleCase == 1){
				//$("#checkboxModalRepeat").val("N");
				//$("#hiddenModalRepeat_YN").val("N");
			}else if(rruleCase == 2){
				
				// 향후모든일정 수정은 outlook에서는 불가
				if($('#calendar-other-office365 li').length > 0 && type == 'submit'){
					if(!confirm('사내캘린더에는 향후모든일정 수정이 적용되지 않습니다. \n 계속 진행하시겠습니까?')){
						return;
					}
				}				
				
				// 반복횟수 체크
				if($("#textModalCountNum").val() != '' && $("#textModalCountNum").val() != null){
					$("#textModalCountNum").val($("#textModalCountNum").val()-$("#hiddenModalRruleDateOrder").val());
				}
				
				//날짜가 다를때 ( 날짜 변경시 )
				//서비스 단에서 사용
				if(compareStartDate == 1){
					$("#hiddenModalRRuleStartDateFlag").val("difStartDate");
					
					rrule.selectFreq($("#selectModalFreq")[0]);
					$("input:checkbox[name=RRulecheckboxModalByweekday]").each(function (index) {  
						this.checked=false;
				    });
					modal.chkBox($("#checkboxModalRepeat")[0]);
				}
				/* 
				else{
					$("#hiddenModalRRuleSettingCompareFlag").val("changeRruleSetting");
				}
				 */
				 
				//향후 모든 일정 선택시 선택한 날짜기준으로 하여 반복요일 체크된 것 중 가장 가까운 날짜계산
				rrule.rruleSubmitStartDate(2);
			}else if(rruleCase == 3){
				if(compareStartDate == 1){
				}else{
					$("#hiddenModalRRuleSettingAllEventFlag").val("changeRruleSettingAllEvent");
				}
				rrule.rruleSubmitStartDate(3);
			}
			
			
			if(type == 'submit'){
				modal.submit();
			}else if(type == 'delete'){
				modal.deleteModal();
			}
		},
		
		//일정 추가
		submit_old : function() {
			//일정 추가 전에 반복일정 날짜와 겹치는지 체크
			/* $.ajax({
				url : "/calendar/listRruleCheckDate.do",
				async : false,
				data : {
					datatype : 'json',
					calendarId : $("#selectModalCalendarID").val()
				},
				datatype : 'json',
				method : 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					var list = data.rows;
					rruleStartList = new Array();
					rruleEndList = new Array();
					
					for(var i=0; i<list.length; i++){
						
						var test = RRule.fromString(list[i].RECURRENCE_RULE);
						//console.log(test.all().length);
						for(var j=0; j<test.all().length; j++){
							var startObj = new Object();
							var endObj = new Object();
						
							//console.log(moment(test.all()[j]).format("YYYY-MM-DD hh:mm"));
							//rruleList.push(moment(test.all()[j]).format("YYYY-MM-DD hh:mm"));
							
							startObj.rruleStartData = moment(test.all()[j]).format("YYYY-MM-DD HH:mm");
							endObj.rruleEndData = moment(moment(test.all()[j]).add(list[i].TIMEDIFF, 'minutes').toDate()).format("YYYY-MM-DD HH:mm");
							rruleStartList.push(startObj);
							rruleEndList.push(endObj);
						}
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			}); */
			//////////////////////////////일정추가
			$("#hiddenModalSync_YN").val($("#selectModalCalendarID > option:selected").attr("id"));
			$("#hiddenModalCalendarId").val($("#selectModalCalendarID").val());
			
			//종일일정 설정
			if($("#hiddenModalAllday_YN").val() == "Y") {
				var addDate = new Date($("#textModalEndDate").val());
				$("#hiddenModalEndDate").val(moment(addDate.setDate(addDate.getDate() + 1)).format("YYYY-MM-DD"));
        	}else {
        		$("#hiddenModalEndDate").val($("#textModalEndDate").val());
        	}
			
			/* if($(compare_before != compare_after && "#checkboxModalRepeat").prop("checked") && modalFlag == "upd"){
		
				$.ajax({
					url : "/calendar/selectCalendarEvent.do",
					async : false,
					data : {
						hiddenModalEventId : $("#hiddenModalEventId").val()
					},
					datatype : 'json',
					method : 'POST',
					beforeSend : function(){
						$.ajaxLoadingShow();
					},
					success : function(data){
						var list = data.rows;
						var startDateTimeArray = moment(list.START_DATETIME).format("YYYY-MM-DD HH:mm").split(' ');
						var endDateTimeArray = moment(list.END_DATETIME).format("YYYY-MM-DD HH:mm").split(' ');
						if($("#textModalStartDate").val() != startDateTimeArray[0] || $("#selectModalStartDateTime").val() != startDateTimeArray[1] || $("#textModalEndDate").val() != endDateTimeArray[0] || $("#selectModalEndDateTime").val() != endDateTimeArray[1]){
							if(!confirm("확인 : 기존 시작날짜를 유지하고 전체일정을 반복수정, \n취소 : 선택 날짜를 시작날짜로 변경하고 반복수정 ")){ 
								//alert("현재일정부터 반복수정");
		
							}else{
								//alert("전체일정 반복수정.");
								$("#textModalStartDate").val(startDateTimeArray[0]);
								$("#selectModalStartDateTime").val(startDateTimeArray[1]);
								//$("#hiddenModalEndDate").val(endDateTimeArray[0]);
								$("#textModalEndDate").val(endDateTimeArray[0]);
								$("#selectModalEndDateTime").val(endDateTimeArray[1]);
					
									console.log("textModalStartDate : "+startDateTimeArray[0]);
									console.log("selectModalStartDateTime : "+startDateTimeArray[1]);
									console.log("textModalEndDate : "+endDateTimeArray[0]);
									console.log("selectModalEndDateTime : "+endDateTimeArray[1]);
					
									console.log("textModalStartDate : "+$("#textModalStartDate").val());
									console.log("selectModalStartDateTime : "+$("#selectModalStartDateTime").val());
									console.log("textModalEndDate : "+$("#textModalEndDate").val());
									console.log("selectModalEndDateTime : "+$("#selectModalEndDateTime").val());
								$("#hiddenModalEndDate").val($("#textModalEndDate").val());
							}
						}
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			} */
			
        	//반복룰 설정
        	if($("#checkboxModalRepeat").val()=="Y") {
        		rrule.setRepeat();
        	}
        	
			var url;	
			(modalFlag == "ins") ? url = "/calendar/insertCalendarEvent.do" : url = "/calendar/updateCalendarEvent.do";
			$('#formModalData').ajaxForm({	
	    		url : url,
	    		async : false,
	    		dataType: "json",
	            beforeSubmit: function (data,form,option) {
	            	if(!compareFlag) {
						if(!confirm("저장하시겠습니까?")){ 
							return false;
						}
	            	}
	            	$.ajaxLoadingShow();
	            },
	            beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
	            data :{
	            	datatype : 'json',
					sendMailFlag : 'N',
					rruleStartList : JSON.stringify(rruleStartList),
					rruleEndList : JSON.stringify(rruleEndList),
					rruleCase : rruleCase,
					EVENT_ID : $("#hiddenModalEventId").val(),
					hiddenModalMemberList : $("#hiddenModalMemberList").val()
				},
	            success: function(data){
	            	
	            	//rruleCase 초기화
	                rruleCase = 0;
	            	$("#hiddenModalRRuleStartDateFlag").val("");
	            	
	                //성공후 서버에서 받은 데이터 처리
	                if(data.cnt >= 0){
	                	if(data.map.insertDupEvent == 'Y'){
	                		alert("해당 시간에 중복되는 일정이 있습니다.");
	                	}
	                	compare_before = $("#formModalData").serialize();
	                	compareFlag = false;
	                	alert("일정을 저장하였습니다.");
	                	$('#myModal1').modal("hide");
	                	$('#calendar').fullCalendar('refetchEvents');
	                }
	                /* 
	                else if(data.cnt < 0){
// 	                	alert("일정을 등록하였습니다. \n\n사내캘린더 일정에 연동하려면\n사내캘린더 로그인한 후 일정을 등록하십시오.");
	                	if(data.map.insertDupEvent == 'Y'){ 
	                		alert("해당 시간에 중복되는 일정이 있습니다.");
	                	}
	                	compare_before = $("#formModalData").serialize();
	                	compareFlag = false;
	                	alert("일정을 등록하였습니다.");
	                	$('#myModal1').modal("hide");
	                	$('#calendar').fullCalendar('refetchEvents');
	                }
	                 */
	                else if(data.cnt == -9){
	                	if(data.map.insertDupEvent == 'Y'){
	                		alert("해당 시간에 중복되는 일정이 있습니다.");
	                	}
	                	compare_before = $("#formModalData").serialize();
	                	compareFlag = false;
	                	alert("일정을 등록하였습니다. \n\n사내캘린더에 등록하시려면 사내캘린더 로그인하십시오.");
	                	$('#myModal1').modal("hide");
	                	$('#calendar').fullCalendar('refetchEvents');
	                }
                	else {
	                	alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
	                }
	            },
	            complete: function() {
	            	$.ajaxLoadingHide();
				}
	        }).submit();
		},
		
		//메일 보내기
		submit : function() {
			var url;
			var sendMailFlag = 'N';
			var hiddenModalMemberList = $("#hiddenModalMemberList").val();

			$("#hiddenModalSync_YN").val($("#selectModalCalendarID > option:selected").attr("id"));
			$("#hiddenModalCalendarId").val($("#selectModalCalendarID").val());
			
			//종일일정 설정
			if($("#hiddenModalAllday_YN").val() == "Y") {
				var addDate = new Date($("#textModalEndDate").val());
				$("#hiddenModalEndDate").val(moment(addDate.setDate(addDate.getDate() + 1)).format("YYYY-MM-DD"));
        	}else {
        		$("#hiddenModalEndDate").val($("#textModalEndDate").val());
        	}

			// 반복룰 설정
			if($("#checkboxModalRepeat").val()=="Y") {
         var validation = rrule.setRepeat();
         if(!validation){
        	 return;
         }
			}
			
			// 메일 발송여부 설정
			if(hiddenModalMemberList.length > 0){
				sendMailFlag = 'Y';
			}
			
			// outlook 연동여부
			var outlookLoginYn = '';
			if($('#calendar-other-office365 li').length > 0){
				outlookLoginYn = 'Y';
			}
			
			(modalFlag == "ins") ? url = "/calendar/insertCalendarEvent.do" : url = "/calendar/updateCalendarEvent.do";
			$('#formModalData').ajaxForm({	
				url : url,
	    		async : false,
	    		dataType: "json",
	        beforeSubmit: function (data,form,option) {
		          if(!compareFlag) {
							if(!confirm("저장하시겠습니까?")){
								return false;
							}
		        }
           	$.ajaxLoadingShow();
          },
          beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
	      data :{
	        datatype : 'json',
					sendMailFlag : sendMailFlag,
					rruleCase : rruleCase,
					EVENT_ID : $("#hiddenModalEventId").val(),
					hiddenModalMemberList : hiddenModalMemberList,
					outlookLoginYn : outlookLoginYn,
					calendarGoogleCheck_id : function(){
       					var calendarGoogleCheck_id = [];
       					$("input[name='checkboxCalendarGoogleId']:checked").each(function(i,v){
       							calendarGoogleCheck_id.push($(this).val());
       					});
       					return calendarGoogleCheck_id.toString();
       				}
				},
	      success: function(data){
	            	
	            	//rruleCase 초기화
	                rruleCase = 0;
	            	
	                //성공후 서버에서 받은 데이터 처리
	            	if(data.cnt >= 0){
	                	if(data.map.insertDupEvent == 'Y'){
	                		alert("해당 시간에 중복되는 일정이 있습니다.");
	                	}
	                	compare_before = $("#formModalData").serialize();
	                	compareFlag = false;
	                	alert("일정을 저장하였습니다.");
	                	$('#myModal1').modal("hide");
	                	$('#calendar').fullCalendar('refetchEvents');
	                }
	                /* 
	                else if(data.cnt < 0){
// 	                	alert("일정을 등록하였습니다. \n\n사내캘린더 일정에 연동하려면\n사내캘린더 로그인한 후 일정을 등록하십시오.");
	                	if(data.map.insertDupEvent == 'Y'){ 
	                		alert("해당 시간에 중복되는 일정이 있습니다.");
	                	}
	                	compare_before = $("#formModalData").serialize();
	                	compareFlag = false;
	                	alert("일정을 등록하였습니다.");
	                	$('#myModal1').modal("hide");
	                	$('#calendar').fullCalendar('refetchEvents');
	                }
	                 */
	                else if(data.cnt == -9){
	                	if(data.map.insertDupEvent == 'Y'){
	                		alert("해당 시간에 중복되는 일정이 있습니다.");
	                	}
	                	compare_before = $("#formModalData").serialize();
	                	compareFlag = false;
	                	alert("일정을 등록하였습니다. \n\n사내캘린더에 등록하시려면 사내캘린더 로그인하십시오.");
	                	$('#myModal1').modal("hide");
	                	$('#calendar').fullCalendar('refetchEvents');
	                }
                	else {
	                	alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
	                }
	                
	            	//반복룰 설정	            	
	            	$('#calendar').fullCalendar('refetchEvents');
	            },
	            complete: function() {
	            	$.ajaxLoadingHide();
				}
	        }).submit();
		},
		
		deleteModal : function(){
			
			// outlook 연동여부
			var outlookLoginYn = '';
			if($('#calendar-other-office365 li').length > 0){
				outlookLoginYn = 'Y';
			}
			
			$.ajax({
				url : "/calendar/deleteCalendarEvent.do",
				datatype : 'json',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!compareFlag) {
						if(!confirm("삭제하시겠습니까?")) return false;
					}
					$.ajaxLoadingShow();
				},
				data :{
					datatype : 'json',
					hiddenModalEventId : $("#hiddenModalEventId").val(),
					textModalEventSubject : $("#textModalEventSubject").val(),
					textareaModalEventDetail : $("#textareaModalEventDetail").val(),
					selectModalStartDateTime : $("#selectModalStartDateTime").val(),
					selectModalEndDateTime : $("#selectModalEndDateTime").val(),
					textModalStartDate : $("#textModalStartDate").val(),
					textModalEventLocation : $("#textModalEventLocation").val(),
					rruleCase : rruleCase,
					hiddenModalOrgStartDate : $("#hiddenModalOrgStartDate").val(),
					hiddenModalEXDate_YN : $("#hiddenModalEXDate_YN").val(),
					hiddenModalOutlookId : $("#hiddenModalOutlookId").val(),
					hiddenModalCreatorId : $("#hiddenModalCreatorId").val(),
					outlookLoginYn : outlookLoginYn,
					checkboxModalRepeat : $("#checkboxModalRepeat").val(),
					hiddenModalRruleDateOrder : $("#hiddenModalRruleDateOrder").val(),
					hiddenModalRruleSyncId : $("#hiddenModalRruleSyncId").val(),
					hiddenModalSyncFlag : $("#hiddenModalSyncFlag").val(),
					hiddenModalGoogleId : $("#hiddenModalGoogleId").val(),
					hiddenModalRepeat_YN : $("#hiddenModalRepeat_YN").val(),
					hiddenModalGoogleCalendarId : $("#hiddenModalGoogleCalendarId").val(),
					hiddenModalRruleString : $("#hiddenModalRruleString").val(),
					hiddenModalRruleSyncId : $("#hiddenModalRruleSyncId").val(),
					hiddenModalExEventYn : $("#hiddenModalExEventYn").val()
				},
				success : function(data){
					//rruleCase 초기화
	                rruleCase = 0;
					
					if(data.cnt > 0) {/* alert("삭제하였습니다."); */ 
						compareFlag = false;
						compare_before = $("#formModalData").serialize();
						$('#myModal1').modal("hide");
					}else if(data.cnt == -9){
						compareFlag = false;
						compare_before = $("#formModalData").serialize();
						alert("일정을 등록하였습니다. \n\n사내캘린더에 등록하시려면 사내캘린더 로그인하십시오.");
	          $('#myModal1').modal("hide");
					}					
					
					$('#calendar').fullCalendar('refetchEvents');
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		chkBox : function(data) {
			if(!$("#"+data.id).prop("checked")) {
				$("#"+data.id).val("N");
				switch(data.id) {
					case "checkboxModalAllday" : $("#hiddenModalAllday_YN").val("N");
												 /* $("#selectModalStartDateTime").attr("disabled", false);  */
												 /* $("#selectModalEndDateTime").attr("disabled", false); break; */
												 $("#selectModalStartDateTime").css("display", "");
												 $("#selectModalEndDateTime").css("display", ""); break;
					case "checkboxModalRepeat" : $("#hiddenModalRepeat_YN").val("N"); 
													$("#divModalRepeatOption").css("display", "none"); break;
					//case "checkboxModalMove"   : $("#divModalMoveOption").css("display", "none"); break;
				}
			}else {
				$("#"+data.id).val("Y");
				switch(data.id) {
					case "checkboxModalAllday" : $("#hiddenModalAllday_YN").val("Y");
												 /* $("#selectModalStartDateTime").val(""); $("#selectModalStartDateTime").attr("disabled", true); */ 
												 /* $("#selectModalEndDateTime").val(""); $("#selectModalEndDateTime").attr("disabled", true); break; */
												 $("#selectModalStartDateTime").val(""); $("#selectModalStartDateTime").css("display", "none");
												 $("#selectModalEndDateTime").val(""); $("#selectModalEndDateTime").css("display", "none"); break;
					case "checkboxModalRepeat" : $("#hiddenModalRepeat_YN").val("Y");
													if($("#labelModalRepeat").css('display') == 'none')$("#divModalRepeatOption").css("display", ""); break;
					//case "checkboxModalMove"   : $("#divModalMoveOption").css("display", ""); break;
				}
				rrule.selectFreq($("#selectModalFreq")[0]);
			}
		},
		inviteChkBox : function(data) {
			if(!$("#"+data.id).prop("checked")) {
				$("#"+data.id).val("N");
				switch(data.id) {
					case "checkboxModalInvite"   	: $("#divModalConviteOption").css("display", "none");
					case "checkboxModalInvite"   	: $("#buttonModalMailSubmit").css("display", "none"); break;
				}
			}else {
				$("#"+data.id).val("Y");
				switch(data.id) {
					case "checkboxModalInvite"   	: $("#divModalConviteOption").css("display", "");
					case "checkboxModalInvite"   	: $("#buttonModalMailSubmit").css("display", ""); break;
				}
			}
		},
		chkDate : function(click) {
			if($("#textModalStartDate").val()!="" && $("#textModalEndDate").val()=="") {
				$("#textModalEndDate").val($("#textModalStartDate").val());
			}else if($("#textModalStartDate").val()=="" && $("#textModalEndDate").val()!="") {
				$("#textModalStartDate").val($("#textModalEndDate").val());
			}else if($("#textModalStartDate").val()!="" && $("#textModalEndDate").val()!="") {
				var startDate = $("#textModalStartDate").val().split('-');
				startDate = parseInt(startDate[0]+startDate[1]+startDate[2]);
				var endDate = $("#textModalEndDate").val().split('-');
				endDate = parseInt(endDate[0]+endDate[1]+endDate[2]);
				if(startDate > endDate) {
					if(click.id == "textModalStartDate")
						$("#textModalEndDate").val($("#textModalStartDate").val());
					else
						$("#textModalStartDate").val($("#textModalEndDate").val());
				}
			}
			$("#hiddenModalEndDate").val($("#textModalEndDate").val());
			
			var rruleChked = 0;
			$("input:checkbox:checked[name=RRulecheckboxModalByweekday]").each(function (index) {
				rruleChked += 1;
			});
			if($("#checkboxModalRepeat").val() == 'Y' && (modalFlag != "upd" || rruleChked < 2)){
				rrule.selectFreq($("#selectModalFreq")[0]);
				$("input:checkbox[name=RRulecheckboxModalByweekday]").each(function (index) {  
					this.checked=false;
			    });
				modal.chkBox($("#checkboxModalRepeat")[0]);
			}
			
		}
}

var rrule = {
	//월 몇주차?
	nthOfMonth : function() {
		/* var monthRruleDate = "";
		var monthRruleTh = "";
		var monthRruleDay = ""; */
		var mntDate = moment($("#textModalStartDate").val());
		//다음주 확인
		var nextMntDate = Math.ceil(moment($("#textModalStartDate").val()).add(7, 'day').date()/7); 
		monthRruleDate = mntDate.toString().slice(8,10);
		monthRruleTh = Math.ceil(mntDate.date() / 7);
		
		if(nextMntDate == 1){
			monthRruleTh = 0;
		}
		switch (monthRruleTh) {
			case 1: monthRruleThKo = '첫째'; 
				break;
			case 2: monthRruleThKo = '둘쩨'; 
				break;
			case 3: monthRruleThKo = '셋째'; 
				break;
			case 4: monthRruleThKo = '넷째'; 
				break;
			case 5: monthRruleThKo = '다섯째'; 
				break;
			default : monthRruleThKo = '마지막'; 
				break;
		}
		switch (moment(mntDate).format("E")) {
			case '1': monthRruleDay = '0'; monthRruleDayEn = 'MO'; monthRruleDayKo = '월';
				break;
			case '2': monthRruleDay = '1'; monthRruleDayEn = 'TU'; monthRruleDayKo = '화';
				break;
			case '3': monthRruleDay = '2'; monthRruleDayEn = 'WE'; monthRruleDayKo = '수';
				break;
			case '4': monthRruleDay = '3'; monthRruleDayEn = 'TH'; monthRruleDayKo = '목';
				break;
			case '5': monthRruleDay = '4'; monthRruleDayEn = 'FR'; monthRruleDayKo = '금';
				break;
			case '6': monthRruleDay = '5'; monthRruleDayEn = 'SA'; monthRruleDayKo = '토';
				break;
			case '7': monthRruleDay = '6'; monthRruleDayEn = 'SU'; monthRruleDayKo = '일';
				break;
		}
		$("#divModalMonthlyRuleDate").html(monthRruleDate+"일");
		$("#divModalMonthlyRuleTh").html(monthRruleThKo+"주 "+monthRruleDayKo+"요일");
	},
	
	//빈도선택
	selectFreq : function(rule) {
		//console.log("selectFreq");
		//console.log(rule);
		var num="";
		var cnt="";
		var txt="";
		if(rule.value=="1"){
			$("#divModalMonthlyByweekday").show();
			$("#divModalElseByweekday").hide();
			cnt=12;
			$("#divModalInterval").css("display", "");
			$("#selectModalInterval").val("1");
			num=['한달','두달','세달','네달','다섯달','여섯달','일곱달','여덟달','아홉달','열달','열한달','일년'];
		}else if(rule.value=="2"){
			$("#divModalMonthlyByweekday").hide();
			$("#divModalElseByweekday").show();
			cnt=9;
			$("#divModalInterval").css("display", "");
			$("#selectModalInterval").val("1");
			num=['1주','2주','3주','4주','5주','6주','7주','8주','9주'];
			var wkDate = moment($("#textModalStartDate").val());
			
			$("#checkboxModalRRule"+monthRruleDayEn).prop("checked",true);
		}else if(rule.value=="3"){
			$("#divModalMonthlyByweekday").show();
			$("#divModalElseByweekday").hide();
			$("#divModalInterval").css("display", "none");
			$("#selectModalInterval").val("3");
		}else if(rule.value=="4"){
			$("#divModalMonthlyByweekday").show();
			$("#divModalElseByweekday").hide();
			$("#divModalInterval").css("display", "none");
			$("#selectModalInterval").val("6");
		}
		if(rule.value=="1" || rule.value=="2"){
			for(var i=1; i<=cnt; i++) {
				txt+="<option value='"+i+"'>"+num[i-1]+"에 한번</option>";
			}
			$("#selectModalInterval").html(txt);
		}
	},
	
	//반복룰 설정
	setRepeat : function() {
		
		var validation = true;
		
		$("#hiddenModalStartRuleDate").val($("#textModalStartDate").val());
		
		switch ($("#selectModalFreq").val()) {
		case "2":
			var byWeekdayCheck = "BYDAY=";
			$("input:checkbox:checked[name=RRulecheckboxModalByweekday]").each(function (index) {
				switch ($(this).val()) {
				case "0":
					if(byWeekdayCheck.length == 6){
						byWeekdayCheck += "MO";
					}else{
						byWeekdayCheck += ",MO";
					}
					break;
				case "1":
					if(byWeekdayCheck.length == 6){
						byWeekdayCheck += "TU";
					}else{
						byWeekdayCheck += ",TU";
					}
					break;
				case "2":
					if(byWeekdayCheck.length == 6){
						byWeekdayCheck += "WE";
					}else{
						byWeekdayCheck += ",WE";
					}
					break;
				case "3":
					if(byWeekdayCheck.length == 6){
						byWeekdayCheck += "TH";
					}else{
						byWeekdayCheck += ",TH";
					}
					break;
				case "4":
					if(byWeekdayCheck.length == 6){
						byWeekdayCheck += "FR";
					}else{
						byWeekdayCheck += ",FR";
					}
					break;
				case "5":
					if(byWeekdayCheck.length == 6){
						byWeekdayCheck += "SA";
					}else{
						byWeekdayCheck += ",SA";
					}
					break;
				case "6":
					if(byWeekdayCheck.length == 6){
						byWeekdayCheck += "SU";
					}else{
						byWeekdayCheck += ",SU";
					}
					break;
				default:
					break;
				}
		    });
			if(byWeekdayCheck.length < 7){ //주간반복 요일체크가 null일 경우 선택한 요일로 자동 세팅.
				byWeekdayCheck = byWeekdayCheck + monthRruleDayEn;
			}
			if(modalFlag == 'upd'){ //반복일정 수정일때 주간반복 요일 체크박스 변동 유무.
				$("#hiddenModalChangeCheckRuleByweekday").val($("#hiddenModalRuleByweekday").val() != byWeekdayCheck);
			}
			$("#hiddenModalRuleByweekday").val(byWeekdayCheck);
			break;
		default:
			var byMonthCheck = "";
			if($("input[name=divModalMonthlyRule]:checked").val() == 'BYMONTHDAY'){
				$("#hiddenModalRuleBy").val('BYMONTHDAY=');
				byMonthCheck = $("#divModalMonthlyRuleDate").html().substring(0,2);
			}else if($("input[name=divModalMonthlyRule]:checked").val() == 'BYDAY'){
				$("#hiddenModalRuleBy").val('BYDAY=');
				if(monthRruleTh == 0){
					byMonthCheck = "-1" + monthRruleDayEn;
				}else{
					byMonthCheck = "+" + monthRruleTh + monthRruleDayEn;
				}
			}
			$("#hiddenModalRuleBymonthday").val(byMonthCheck);
			break;
		}
		
		if($("input[name=radioModalEndRule]:checked").val() == ''){ //계속반복 == 4년동안
			$("#hiddenModalEndCondition").val('loop');
			$("#hiddenModalLoopNum").val('4');
			$("#hiddenModalEndRuleDate").val('');
			$("#hiddenModalCountNum").val('');
		}else if($("input[name=radioModalEndRule]:checked").val() == 'count'){ //횟수 반복
			$("#hiddenModalEndCondition").val('count');
			$("#hiddenModalCountNum").val($("#textModalCountNum").val());
			
			if(!$("#textModalCountNum").val()){
				alert('반복 횟수를 입력해주세요.');
				validation = false;
			}
			
		}else if($("input[name=radioModalEndRule]:checked").val() == 'until'){ //종료일 설정
			$("#hiddenModalEndCondition").val('until');
			$("#hiddenModalEndRuleDate").val($("#textModalEndRuleDate").val());
		}
		
		return validation;
	},
	
	//불러온 반복룰 문자열 나누기
	getRepeat : function(data) {
		rule = RRule.fromString(data).origOptions;
	},
	
	//반복종료일 2년이내 확인
	chkEndDate : function() {
		if($("#textModalEndRuleDate").val()!="") {
			var startEventRuleDate = new Date($("#textModalStartDate").val());
			var endEventRuleDate = new Date($("#textModalEndRuleDate").val());
			var result = ((endEventRuleDate-startEventRuleDate)/86400000);
			if(result>729) {
				alert("2년 이내로 선택해 주세요.");
				$("#textModalEndRuleDate").val("");
			}else if(result<1) {
				alert("반복 종료일이 시작일보다 이전입니다.");
				$("#textModalEndRuleDate").val("");
			}
		}
	},
	
	inputRrule : function(freqCheck, dtstart, until, count, interval, byweekday, bymonthday) {
		//alert(freqCheck+" "+dtstart+" "+until+" "+interval+" "+byweekday+" "+bymonthday);ruleToString
		if(until != "" && until != null){
			if(byweekday != "" && byweekday != null){
				ruleToString = new RRule({
					freq: freqCheck, //빈도
					dtstart: dtstart, //시작일
					until: until, //종료조건 횟수
					interval: interval, //주기
					byweekday: byweekday //요일 선택 복수일경우 대괄호 or 월별선택 > 요일 체크
				});
			}else if(bymonthday != "" && bymonthday != null){
				ruleToString = new RRule({
					freq: freqCheck, //빈도
					dtstart: dtstart, //시작일
					until: until, //종료조건 횟수
					interval: interval, //주기
					bymonthday : bymonthday //월별선택 > 일자 체크	
				});
			}else{
				ruleToString = new RRule({
					freq: freqCheck, //빈도
					dtstart: dtstart, //시작일
					until: until, //종료조건 횟수
					interval: interval //주기
				});
			}
		}else if(count != "" && count != null){
			if(byweekday != "" && byweekday != null){
				ruleToString = new RRule({
					freq: freqCheck, //빈도
					dtstart: dtstart, //시작일
					count: count, //종료조건 횟수
					interval: interval, //주기
					byweekday : byweekday //요일 선택 복수일경우 대괄호 or 월별선택 > 요일 체크
				});
			}else if(bymonthday != "" && bymonthday != null){
				ruleToString = new RRule({
					freq: freqCheck, //빈도
					dtstart: dtstart, //시작일
					count: count, //종료조건 횟수
					interval: interval, //주기
					bymonthday : bymonthday //월별선택 > 일자 체크	
				});
			}else{
				ruleToString = new RRule({
					freq: freqCheck, //빈도
					dtstart: dtstart, //시작일
					count: count, //종료조건 횟수
					interval: interval //주기
				});
			}
		}
	},
	
	//반복일정 수정 중 향후 모든 일정(rruleSubmit = 2),모든 일정(rruleSubmit = 3) 선택시 선택한 날짜기준으로  반복요일 체크된 것 중 가장 가까운 날짜계산
	rruleSubmitStartDate : function(rruleSubmit) {
		var id = "";
		var sdCnt = 0;
		var wdCnt = 99;
		if(rruleSubmit == 2){ //향후 모든 일정
			id = "FollowingStartDate";
			$("#hiddenModal" + id).val($("#textModalStartDate").val());
		}else if(rruleSubmit == 3){ //모든 일정
			id = "AllEventsStartDate";
		}
		sdCnt = moment($("#hiddenModal" + id).val()).format('E')-1;
		$('input:checkbox:checked[name="RRulecheckboxModalByweekday"]').each(function (index) {
			if(sdCnt - $(this).val() == 0){
				wdCnt = 0;
			}else if(sdCnt - $(this).val() > 0 && 7 - (sdCnt - $(this).val()) < wdCnt ){
				wdCnt = 7 - (sdCnt - $(this).val());
			}else if(sdCnt - $(this).val() < 0 && Math.abs(sdCnt - $(this).val()) < wdCnt ){
				wdCnt = Math.abs(sdCnt - $(this).val());
			}
		});
		$("#hiddenModal" + id).val(moment($("#hiddenModal" + id).val()).add(wdCnt, 'd').format("YYYY-MM-DD"));
		if(rruleSubmit == 3){ //모든 일정
			var thisStart = $("#textModalStartDate").val().split("-");
			var thisEnd = $("#textModalEndDate").val().split("-");
			var tSDate = new Date(thisStart[0], thisStart[1], thisStart[2]);
			var tEDate = new Date(thisEnd[0], thisEnd[1], thisEnd[2]);
			
			$("#hiddenModalAllEventsEndDate").val(moment($("#hiddenModal" + id).val()).add((tEDate.getTime() - tSDate.getTime())/1000/60/60/24, 'd').format("YYYY-MM-DD"));
			//alert("수정된 첫번째 종료일 : "+moment($("#hiddenModal" + id).val()).add((tEDate.getTime() - tSDate.getTime())/1000/60/60/24, 'd').format("YYYY-MM-DD"));
			
		}
	},
	
	// 반복 종료일 Radio 버튼 클릭
	// 선택한 Radio 버튼에 속하는 input 을 활성화 시켜준다.
	// 
	// el : 클릭한 element
	endRuleRadio : function() {
		
		// Radio 버튼 리스트
		var radioEls = $('input[name=radioModalEndRule]');		
		
		for(var i=0; i<radioEls.length; i++){
			
			var radioEl = $(radioEls[i]);
			var inputEl = radioEl.next().find('input[type=text]');
			
			if(inputEl.length < 1){
				continue;
			}
			
			if(radioEl.prop('checked')){
				inputEl.attr('disabled', false);
				continue;
			}
						
			inputEl.attr('disabled', true);
			inputEl.val('');
		}
	}
}
//
</script>