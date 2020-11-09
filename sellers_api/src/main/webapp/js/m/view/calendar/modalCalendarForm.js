$(document).ready(function() {
	
	// validate 설정
	modal.validate();
	
	// 직원검색 클릭 시 검색팝업 초기화
	$('.invite-area .btn-search').on('click', function(e){
		e.preventDefault();
		$('#search_member_txt').val('');
		$('#search_member_list').html('');
	});
	
	//초대옵션 검색, 리스트 영역
	$('#div_invite_area').hide();
	
	if (mode == 'M'){
		modal.getDetail();
	}
	else if (mode == 'I'){
		modal.reset(curDate);
	}	
});

/*//반복일정 수정일정인지 아닌지 체크
function fncSaveSchedule(val) {
	compare_after = $("#formModalData").serialize();
	
	//if(val == 'submit' && compare_before != compare_after){
	if(val == 'submit'){
		if(mode == 'M' && ($('#hiddenModalRruleString').val() != null && $('#hiddenModalRruleString').val() != '')){
			//$(".repeat_upd_msg_pop").show();
			layer_open('layer_submit');
		}
		else{
			rruleSubmit(0, "submit");
		}
	}
	else if(val == 'delete'){
		if(mode == 'M' && ($('#hiddenModalRruleString').val() != null && $('#hiddenModalRruleString').val() != '')){
			layer_open('layer_delete');
		}
		else{
			deleteModal();
		}
	}

	
	if(val == 'submit' && compare_before != compare_after){
		if(modalFlag == 'upd' && ($('#hiddenModalRruleString').val()!=null && $('#hiddenModalRruleString').val()!='')){
			$(".repeat_upd_msg_pop").show();
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
	
}*/