/**
 * 초대 > 직원선택 > 삭제버튼 클릭
 * @param member_id_num
 * @returns
 */
function fncRemoveMember(member_id_num, index){
	invite_members.splice(index, 1);
	$('#member_'+member_id_num).remove();
	$("#hiddenModalMemberList").val(invite_members);
}	
	
/**
 * 초대 > 직원선택 시 직원이름 셋팅
 * @param member_id_num
 * @param han_name
 * @param email
 * @returns
 */
function fncAddMember(member_id_num, han_name, email){
	if($.inArray(member_id_num+"/"+email+"/"+han_name, invite_members) == -1) {
		invite_members.push(member_id_num+"/"+email+"/"+han_name);
		var _html = '<li class="value custom" id="member_'+member_id_num+'"><span class="txt">'+han_name+'</span>';
		_html += '<a href="#" onClick="fncRemoveMember(\''+member_id_num+'\',$(this).parent().index()); return false;" class="remove custom"><img src="/images/m/icon_close.svg" /></a></li>';
		$('#invite_member_list').append(_html);
		
		$("#hiddenModalMemberList").val(invite_members);
	}
}

/**
 * 초대할 직원 검색
 * @returns
 */
function fncSearchMember(){
	var search_member_txt = $('#search_member_txt').val();
	if (search_member_txt.length < 2){
		alert('2 글자 이상 입력해주세요.');
		$('#search_member_txt').focus();
	} else {

		$.ajax({
			url: "/common/searchMemberInfo.do",
			async : false,
			dataType: "json",
            data: {
            	memberName: search_member_txt
            },
			success : function(data) {
				var memberList = data.list;
				$("#search_member_list").html("");
				if (memberList.length > 0) {
					for (var i = 0; i < memberList.length; i++) {
						$("#search_member_list").append(
							'<li><span>'+memberList[i].HAN_NAME+'</span>&nbsp;<a href="javascript:fncAddMember(\''+memberList[i].MEMBER_ID_NUM+'\',\''+memberList[i].HAN_NAME+'\',\''+memberList[i].EMAIL+'\');void(0);"><img src="/images/m/icon_plus.svg" /></a></li>'
						);
					}
				} else {
					$("#search_member_list").append(
							"<li><span>데이터가 없습니다.</span></li>");
				}
			},
			complete : function() {

			},
			error : function() {
				alert("직원 검색을 실패했습니다.\n관리자에게 문의하세요.");
			}
		});
	}
}

/**
 * 초대직원 리스트 출력
 * @param event_id
 * @returns
 */
function selectInviteMemberList(event_id) {
	var params = $.param({
		hiddenModalEventId : event_id,
		datatype : 'json'
	});
	
	$.ajax({
		url : "/calendar/getInviteMemberList.do",
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
			//$.ajaxLoadingShow();
		},
		data :params,
		success : function(data){
			/* $("#checkboxModalInviteList").val("Y");
			$("#checkboxModalInviteList").prop("checked", true);
			$("#divModalConviteOption").css("display", ""); */
			//$("#formModalData .invite-area-list").html('');
			$("#formModalData .invite-area-list").html('<h3 class="ag_c">참석자 리스트</h3>' 
							+ '<table class="basic3">'
							+ '<colgroup>'
							+ '<col width=""/>'
							+ '<col width=""/>'
							+ '<col width=""/>'
							//+ '<col width=""/>'
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
				$("#tbodyModalInviteList").append('<td style="text-align:center;"><a onClick="inviteMemberDel(this,'+event_id+','+data.InviteMemberList[i].INVITE_ID+','+data.InviteMemberList[i].CALENDAR_ID+');"><img src="/images/m/icon_close.svg" alt="삭제" /></a></td>');
				$("#tbodyModalInviteList").append('</tr>');
				
				/* $("#formModalData .invite-area-list").append('<div class="col-sm-4">'+data.InviteMemberList[i].EMAIL+'</div>'); */
				/* $("#formModalData .invite-area-list").append('<div class="col-sm-4">'+moment(data.InviteMemberList[i].SYS_UPDATE_DATE).format('YYYY[-]MM[-]DD HH:mm:ss')+'</div>'); */
				/* $("#formModalData .invite-area-list").append('</div>'); */
			}
			//초대 체크박스 
			if(data.InviteMemberList.length > 0){
				$("#checkboxModalInvite").val("Y");
				$("#checkboxModalInvite").prop("checked", true);
				
				//$("#divModalConviteOption").css("display", "");
				//$("#buttonModalMailSubmit").css("display", "");
				
				//초대 영역 보이기
				//$('.pop_search_area').show();
				$('#div_invite_area').show();
			}else{
				$("#checkboxModalInvite").val("N");
				$("#checkboxModalInvite").prop("checked", false);
				
				//$("#divModalConviteOption").css("display", "none");
				//$("#buttonModalMailSubmit").css("display", "none");
				
				//초대 영역 숨기기
				//$('.pop_search_area').hide();
				$('#div_invite_area').hide();
			}
			//compare_before = $("#formModalData").serialize();
		},
		complete : function(){
			//$.ajaxLoadingHide();
		}
	});
}

/**
 * 초대직원 삭제
 * @param obj
 * @param event_id
 * @param invite_id
 * @param calendar_id
 * @returns
 */
function inviteMemberDel(obj, event_id, invite_id, calendar_id) {
	
	var params = $.param({
		event_id : event_id,
		invite_id : invite_id,
		calendar_id : calendar_id,
		datatype : 'json'
	});
	
	$.ajax({
		url : "/calendar/deleteInviteMemberList.do",
		data :params,
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
			//if(!compareFlag) {
				if(!confirm("참석자를 삭제하시겠습니까?")) return false;
           	//}
			//$.ajaxLoadingShow();
		},
		success : function(data){
			alert("참석자를 삭제하였습니다.");
			//$('tbody#tbodyModalInviteList tr').remove();
			var tr = $(obj).parent().parent();
			//라인 삭제
			tr.remove();

			compare_before = $("#formModalData").serialize();
		},
		complete : function(){
			
		}
	});
}