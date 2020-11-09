<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="fc-right">
	<!-- <a href="#" data-toggle="modal" data-target="#myModal1">일정추가 띄우기 테스트</a> -->
	<div class="modal inmodal fade" id="myModal2" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title">캘린더 공유 멤버 추가</h4>
					<!-- <small class="font-bold">일정 세부 정보입니다.</small> -->
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
									<form class="form-horizontal" id="formModalData2"
										name="formModalData2" method="post"
										enctype="multipart/form-data">
										<!-- ====================================================================== -->

										<div class="form-group pos-rel">
											<label class="col-md-3 col-lg-2 control-label">캘린더 공유
												동료</label>
											<div class="col-sm-10">
												<div class="company-search mg-b5">
													<div class="company-current"></div>
													<button type="button" class="btn btn-gray btn-file"
														onClick="calendarShare.showCustomPop();">검색</button>
												</div>
											</div>

											<div class="custom-company-pop off">
												<div class="pop-header">
													<button type="button" class="close">
														<span aria-hidden="true">&times;</span><span
															class="sr-only">Close</span>
													</button>
													<strong class="pop-title">동료 선택</strong>
												</div>
												<div class="col-sm-12 cont">
													<div class="form-group">
														<div class="col-sm-12">
															<div class="company-search mg-b5">
																<!-- 검색 -->
																<button type="button" class="btn btn-gray btn-file" onClick="commonSearch.multipleMemberPop2();">검색</button>
																<input type="text" placeholder="동료 검색" class="form-control fl_l mg-r5" id="textCommonSearchMember2" autocomplete="off">
															</div>
														</div>
														<div class="col-sm-12 company-result mg-b10 ">
															<!-- 검색 결과 노출시 "off" 삭제 -->
															<strong>[동료 검색 결과]</strong>
															<ul class="company-list">
															</ul>
														</div>
													</div>
													<!-- <div class="ta-c">
	                                               <button type="button" class="btn btn-gray btn-file">추가하기</button>
	                                           </div> -->
												</div>
											</div>

											<div class="share-area-list"></div>
										</div>

										<!-- ====================================================================== -->




										<div class="hr-line-dashed"></div>
										<p class="text-center">
											<button type="button" class="btn btn-w-m btn-primary btn-gray" name="buttonModalShareCalendarSubmit" id="buttonModalShareCalendarSubmit" onClick="calendarShare.submit();">저장하기</button>
										</p>
										
										<input type="hidden" name="hiddenModalShareCalendarId" id="hiddenModalShareCalendarId" /> 
										<input type="hidden" name="hiddenModalShareCreatorId" id="hiddenModalShareCreatorId" /> 
										<!-- <input type="hidden" name="hiddenModalMemberList" id="hiddenModalMemberList" /> --> 
										<input type="hidden" name="hiddenModalMemberCalendarName"	id="hiddenModalMemberCalendarName" />
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
		calendarShare.init();
	});

	var calendarShare = {
		init : function() {

			//자동완성 검색
			//commonSearch.calendarMember($("#formModalData #textModalInviteName"), $("#textModalInviteId"), $("#textModalInviteMail"), $("#textModalInviteCalendarId"));

			$("#textCommonSearchMember2").keydown(function(key) {
				if (key.keyCode == 13) {//키가 13이면 실행 (엔터는 13)
					commonSearch.multipleMemberPop2();
				}
			});

		},
		reset : function(creatorId, calendarId, calendarName) {
			// 폼 초기화
			$("div.company-current").html("");
			$("#hiddenModalMemberList").val("");
			commonSearch.multipleMemberArray = [];
			$("#myModal2 > div > div > div.modal-header > h4").html("\'" + calendarName + "\' 동료에게 공유");
			$("#hiddenModalShareCalendarId").val(calendarId);
			$("#hiddenModalShareCreatorId").val(creatorId);
			$("#hiddenModalMemberCalendarName").val(calendarName);
			//commonSearch.multipleMemberSelect(calendarId);
			$("#myModal2").modal();
			 
			// 캘린더 공유 리스트 가져오기
			$.ajax({
					url : "/calendar/selectShareCalendar.do",
					datatype : 'json',
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoadingShow();
					},
					data : {
						datatype : 'json',
						calendarId : $("#hiddenShareCalendId").val()
					},
					success : function(data) {
						
						commonSearch.multipleMemberSelect(data);
						
						/* $("#checkboxModalInviteList").val("Y");
						$("#checkboxModalInviteList").prop("checked", true);
						$("#divModalConviteOption").css("display", ""); */
						$("#formModalData2 .share-area-list").html('');
						$("#formModalData2 .share-area-list")
								.html(
										'<h3 class="ag_c">공유한 동료 리스트</h3>'
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
												/*  + '         <th>수락시간</th> ' */
												+ '         <th>삭제</th> '
												+ '     </tr> '
												+ ' </thead>'
												+ ' <tbody id="tbodyModalShareList">'
												+ ' </tbody>' + ' </table>');

						for (i = 0; i < data.selectShareCalendar.length; i++) {
							/* $("#formModalData .invite-area-list").append('<div class="form-group">'); */
							/*
							$("#formModalData .invite-area-list").append('<div class=""><input type="hidden" class="form-control" value="'+ data.InviteMemberList[i].MEMBER_ID_NUM +'"/></div>');
							$("#formModalData .invite-area-list").append('<div class=""><input type="hidden" class="form-control" value="'+data.InviteMemberList[i].BASIC_CALENDAR_ID+'"/></div>');
							 */
							$("#tbodyModalShareList")
									.append(
											'<tr id='+data.selectShareCalendar[i].SHARE_MEMBER_ID+'>'
													+'<td style="text-align:center;">'
													+ data.selectShareCalendar[i].HAN_NAME
													+ '</td>'
													+'<td style="text-align:center;"><a onclick="calendarShare.deleteShareMember('
													+ "'"
													+ data.selectShareCalendar[i].SHARE_MEMBER_ID
													+ "'"
													+ ');"><i class="fa fa-times-circle fc_gray"></i></a></td></tr>');

							/* $("#formModalData .invite-area-list").append('<div class="col-sm-4">'+data.InviteMemberList[i].EMAIL+'</div>'); */
							/* $("#formModalData .invite-area-list").append('<div class="col-sm-4">'+moment(data.InviteMemberList[i].SYS_UPDATE_DATE).format('YYYY[-]MM[-]DD HH:mm:ss')+'</div>'); */
							/* $("#formModalData .invite-area-list").append('</div>'); */
						}
						/* 
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
						 */
					},
					complete : function() {
						$.ajaxLoadingHide();
					}
				});
		},
		
		submit : function() {
			if(!calendarShare.validation()){
				return;
			}
			
			var url = "";
			var params = $.param({
				datatype : 'json',
				calendarId : $("#hiddenModalShareCalendarId").val(),
				MemberList : $("#hiddenModalMemberList").val(),
				creatorId : $("#hiddenModalShareCreatorId").val(),
				calendarName : $("#hiddenModalMemberCalendarName").val()
			});
			
			//(modalFlag == "ins") ? url = "/calendar/insertShareCalendar.do" : url = "/calendar/updateShareCalendar.do";
			$.ajax({
				url : "/calendar/insertShareCalendar.do", //url,
				datatype : 'html',
				mtype : 'POST',
				data : params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data) {
					alert("나의 캘린더를 공유하였습니다.");
					$("#myModal2").modal("hide");
				},
				complete : function() {
					$.ajaxLoadingHide();
				}
			});
		},
		
		deleteShareMember : function(SHARE_MEMBER_ID) {
			var params = $.param({
				calendarId : $("#hiddenShareCalendId").val(),
				creatorId : $("#hiddenModalCreatorId").val(),
				SHARE_MEMBER_ID : SHARE_MEMBER_ID,
				datatype : 'json'
			});
			
			$.ajax({
				url : "/calendar/deleteShareMember.do",
				datatype : 'json',
				data : params,
				async : false,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data) {
					alert('삭제 되었습니다.');
										
					var index = commonSearch.multipleMemberArray.indexOf(SHARE_MEMBER_ID);
					commonSearch.multipleMemberArray.splice(index, 1);
					$('#'+SHARE_MEMBER_ID).empty();
					$('#'+SHARE_MEMBER_ID).remove();
					
					//window.location.reload();
				},
				complete : function(){
					
				}
			});
		},
		
		// 동료 검색 창 show
		showCustomPop : function(){
			$('#formModalData2 .custom-company-pop .company-list').html('');
			$('#textCommonSearchMember2').val('');
	  	$('#formModalData2 .custom-company-pop').show();
		},
		
		// 유효한 공유인지 체크
		validation : function() {			
			// 선택한 동료가 없을 경우
			var creatorId = $("#hiddenModalShareCreatorId").val();
			var memberArr = commonSearch.multipleMemberArray;
			var shareNum = $('#tbodyModalShareList tr').length;
			
			if(memberArr.length <= shareNum){
				alert('공유할 동료를 선택해주세요.');
				return false;
			}
			
			// 자기 자신의 캘린더는 공유할 수 없게			
			for(var i=shareNum; i<memberArr.length; i++){
				
				var memberId = memberArr[i].split('/')[0];
				var memberNm = memberArr[i].split('/')[2];
				
				if(creatorId == memberId){
					alert('자기 자신에게는 공유할 수 없습니다.');
					return false;
				}
				
				// 이미 공유하고 있는 동료인지 확인
				if(memberArr.indexOf(memberId) != -1){
					alert(memberNm+'은(는) 이미 공유하고 있는 동료입니다.');
					return false;					
				}
			}
			
			return true;
		}
	}
</script>