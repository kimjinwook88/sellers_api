<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="fc-right">
	<!-- <a href="#" data-toggle="modal" data-target="#myModal1">일정추가 띄우기 테스트</a> -->
	<div class="modal inmodal fade" id="myModal3" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title">일정추가</h4>
					<small class="font-bold">일정 세부 정보입니다.</small>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-lg-12">
							<div class="ibox float-e-margins">
								<div class="ibox-title">
									<h5></h5>
									<div class="ibox-tools">
										<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
										</a>
									</div>
								</div>
								<div class="ibox-content">
									<form class="form-horizontal" id="formModalData3"
										name="formModalData3" method="post"
										enctype="multipart/form-data">
										<div class="form-group">
											<label class="col-sm-2 control-label">제목</label>
											<div class="col-sm-10">
												<input type="text" class="form-control"
													name="textModalEventSubject" id="textModalEventSubject"
													readonly="readonly" disabled />
											</div>
										</div>

										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label">일정구분</label>
											<div class="col-sm-2">
												<div class="select-com">
													<!-- <label>항목선택</label> -->
													<select class="form-control m-b"
														name="selectModalEventCode" id="selectModalEventCode"
														readonly="readonly" disabled
														onclick="modal.checkEventCode();">
														<option value="">선택</option>
														<option value="1" id="meeting">고객컨택</option>
														<option value="2">컨택준비</option>
														<option value="3">내부회의</option>
														<option value="4">교육</option>
														<option value="6">기타</option>
														<option value="7">휴가</option>
														<option value="00">개인일정</option>
														<!-- <option value="7">개인일정(공유안되는 일정)</option> -->
													</select>
												</div>
											</div>

											<label class="col-sm-1 control-label">장소</label>
											<div class="col-sm-7">
												<input type="text" class="form-control"
													name="textModalEventLocation" id="textModalEventLocation"
													readonly="readonly" disabled />
											</div>
										</div>

										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label">상세내용</label>
											<div class="col-sm-10">
												<textarea class="pop-textarea-input" rows="3"
													name="textareaModalEventDetail"
													id="textareaModalEventDetail" readonly="readonly" disabled
													 onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea>
											</div>
										</div>


										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="date_modified">일정
												시작</label>
											<div class="col-xs-12 col-sm-4 pd-b10">
												<input type="text" class="form-control m-b"
													name="textModalStartDateTime" id="textModalStartDateTime"
													readonly="readonly" disabled>
											</div>

											<div id="divModalEventCode" style="display: none">
												<label class="col-sm-2 control-label">전 이동시간</label>
												<div class="col-sm-4">
													<div class="select-com">
														<!-- <label>항목선택</label> -->
														<select class="form-control m-b"
															name="selectModalBeforeMoveTimeMin"
															id="selectModalBeforeMoveTimeMin" readonly="readonly"
															disabled>
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
										<!-- <div class="hr-line-dashed"></div> -->
										<div class="form-group">
											<label class="col-sm-2 control-label" for="date_modified">일정
												종료</label>
											<div class="col-xs-12 col-sm-4 pd-b10">
												<input type="text" class="form-control m-b"
													name="textModalEndDateTime" id="textModalEndDateTime"
													readonly="readonly" disabled>
											</div>

											<div id="divModalEventCode2" style="display: none">
												<label class="col-sm-2 control-label">후 이동시간</label>
												<div class="col-sm-4">
													<div class="select-com">
														<select class="form-control m-b"
															name="selectModalAfterMoveTimeMin"
															id="selectModalAfterMoveTimeMin" readonly="readonly"
															disabled>
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


										<input type="hidden" name="hiddenModalEventId" id="hiddenModalEventId" value="" /> 
										<input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}" />  
										<input type="hidden" name="hiddenModalStartRuleDate" id="hiddenModalStartRuleDate" value="" />  
										<input type="hidden" name="hiddenModalEndRuleDate" id="hiddenModalEndRuleDate" value="" />  
										<input type="hidden" name="hiddenModalCountNum" id="hiddenModalCountNum" value="" />  
										<input type="hidden" name="hiddenModalRuleByweekday" id="hiddenModalRuleByweekday" value="" />  
										<input type="hidden" name="hiddenModalRruleString" id="hiddenModalRruleString" value="" />  
										<input type="hidden" name="hiddenModalAllday_YN" id="hiddenModalAllday_YN" value="" />  
										<input type="hidden" name="hiddenModalRepeat_YN" id="hiddenModalRepeat_YN" value="" />  
										<input type="hidden" name="hiddenModalMemberList" id="hiddenModalMemberList" value="" />  
										<input type="hidden" name="hiddenModalSync_YN" id="hiddenModalSync_YN" value="" />
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
