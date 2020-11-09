var coachingTalk = {
		
		category : '',
		
		view : function(category) {
			if(isEmpty(coachingTalk.category)){
				coachingTalk.category = category;
			}
			coachingTalk.selectCoachingTalk();
		},
		
		selectCoachingTalk : function() {
			var params = $.param({
				datatype : 'html',
				jsp : '/common/coachingTalkTabAjax',
				category : coachingTalk.category,
				delete_yn : 'N',
				dataId : $("#pkNo").val()
			});
			
			$.ajax({
				url : "/common/selectCoachingTalk.do",
				async : false,
				datatype : 'html',
				cache : false,
				method : 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					//if(!confirm("삭제하시겠습니까?")) return false;
					//$.ajaxLoadingShow();
				},
				data : params,
				success : function(data){
					$("#divModalCoachingTalkView").html(data);
					//$("#divModalCoachingTalkView").scrollTop($("#divModalCoachingTalkView")[0].scrollHeight); //스크롤 하단으로 이동
				},
				complete : function(){
					//$.ajaxLoadingHide();
				}
			});
		},
		
		submit : function() {
			var str = '';
			str = $("textarea[name='textModalCoachingTalk']").val().replace(/\n/g,'');
			str = str.replace(/ /gi,'');
			
			if(isEmpty(str)){
				$("#textModalCoachingTalk").focus();
			}else{
				var params = '';
				var teamMemberIdArray = [];
				var uniqueIdArray = [];
				
				switch (coachingTalk.category) {
				case 'OPP':
					if(!isEmpty($("#hiddenModalCreatorId").val())) teamMemberIdArray.push($("#hiddenModalCreatorId").val());
					if(!isEmpty($("#hiddenModalExecId").val())) teamMemberIdArray.push($("#hiddenModalExecId").val());
					if(!isEmpty($("#hiddenModalOwnerId").val())) teamMemberIdArray.push($("#hiddenModalOwnerId").val());
					if(!isEmpty($("#hiddenModalIdentifierId").val())) teamMemberIdArray.push($("#hiddenModalIdentifierId").val());
					$.each(teamMemberIdArray, function(i, el){
						if($.inArray(el, uniqueIdArray) === -1) uniqueIdArray.push(el);
					});
					
					params = $.param({
						category : coachingTalk.category,
						coachingTalk : $("#textModalCoachingTalk").val(),
						dataId : $("#pkNo").val(),
						subject : '${detail.SUBJECT}',
						talkName : '${userInfo.HAN_NAME}',
						teamMemberIdArray : uniqueIdArray.join(","),
						datatype : 'json'
					});
					break;
				case 'HOPP':
					if(!isEmpty($("#hiddenModalCreatorId").val())) teamMemberIdArray.push($("#hiddenModalCreatorId").val());
					if(!isEmpty($("#hiddenModalSalesId").val())) teamMemberIdArray.push($("#hiddenModalSalesId").val());
					$.each(teamMemberIdArray, function(i, el){
						if($.inArray(el, uniqueIdArray) === -1) uniqueIdArray.push(el);
					});
					params = $.param({
						category : coachingTalk.category,
						coachingTalk : $("#textModalCoachingTalk").val(),
						dataId : $("#pkNo").val(),
						subject : '${detail.SUBJECT}',
						talkName : '${userInfo.HAN_NAME}',
						creatorId : $("#hiddenModalCreatorId").val(),
						teamMemberIdArray : uniqueIdArray.join(","),
						datatype : 'json'
					});
					break;
				case 'ISSUE':
					if(!isEmpty($("#hiddenModalCreatorId").val())) teamMemberIdArray.push($("#hiddenModalCreatorId").val());
					if(!isEmpty($("#hiddenModalSalesId").val())) teamMemberIdArray.push($("#hiddenModalSalesId").val());
					if(!isEmpty($("#hiddenModalSolveOwnerId").val())) teamMemberIdArray.push($("#hiddenModalSolveOwnerId").val());
					$.each(teamMemberIdArray, function(i, el){
						if($.inArray(el, uniqueIdArray) === -1) uniqueIdArray.push(el);
					});
					params = $.param({
						category : coachingTalk.category,
						coachingTalk : $("#textModalCoachingTalk").val(),
						dataId : $("#pkNo").val(),
						subject : '${detail.SUBJECT}',
						talkName : '${userInfo.HAN_NAME}',
						creatorId : $("#hiddenModalCreatorId").val(),
						teamMemberIdArray : uniqueIdArray.join(","),
						datatype : 'json'
					});
					break;
				case 'CONTACT':
					if(!isEmpty($("#hiddenModalCreatorId").val())) teamMemberIdArray.push($("#hiddenModalCreatorId").val());
					$.each(teamMemberIdArray, function(i, el){
						if($.inArray(el, uniqueIdArray) === -1) uniqueIdArray.push(el);
					});
					
					params = $.param({
						category : coachingTalk.category,
						coachingTalk : $("#textModalCoachingTalk").val(),
						dataId : $("#pkNo").val(),
						subject : '${detail.SUBJECT}',
						talkName : '${userInfo.HAN_NAME}',
						creatorId : $("#hiddenModalCreatorId").val(),
						teamMemberIdArray : uniqueIdArray.join(","),
						datatype : 'json'
					});
					break;
				case 'SVPJ':
					if(!isEmpty($("#hiddenModalCreatorId").val())) teamMemberIdArray.push($("#hiddenModalCreatorId").val());
					if(!isEmpty($("#hiddenModalOurPMId").val())) teamMemberIdArray.push($("#hiddenModalOurPMId").val());
					if(!isEmpty($("#hiddenModalOurEXPMId").val())) teamMemberIdArray.push($("#hiddenModalOurEXPMId").val());
					if(!isEmpty($("#hiddenModalSalesOwnerId").val())) teamMemberIdArray.push($("#hiddenModalSalesOwnerId").val());
					if(!isEmpty($("#hiddenModalTeamMemberIdList").val())) { //팀원들 전체 코칭톡 메세지 전달
						var teamArray = $("#hiddenModalTeamMemberIdList").val().split(',');
						for(var i=0; i<teamArray.length; i++) {
							teamMemberIdArray.push(teamArray[i]);
						}
					}
					
					$.each(teamMemberIdArray, function(i, el){
						if($.inArray(el, uniqueIdArray) === -1) uniqueIdArray.push(el);
					});
					
					params = $.param({
						category : coachingTalk.category,
						coachingTalk : $("#textModalCoachingTalk").val(),
						dataId : $("#hiddenModalPK").val(),
						subject : $('h4.modal-title').html(),
						talkName : '${userInfo.HAN_NAME}',
						creatorId : $("#hiddenModalCreatorId").val(),
						teamMemberIdArray : uniqueIdArray.join(","),
						datatype : 'json'
					});
					break;
				default:
					break;
				}
				
				$.ajax({
					url : "/common/insertCoachingTalk.do",
					async : false,
					method : 'POST',
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						//if(!confirm("하시겠습니까?")) return false;
						//$.ajaxLoadingShow();
					},
					data : params,
					success : function(data){
						//if(data.cnt==1){}
						$("#textModalCoachingTalk").val('');
						coachingTalk.selectCoachingTalk();
						
						/* switch (coachingTalk.category) {
						case 'OPP':
							oppList.get();
							break;
						case 'HOPP':
							$('tbody#row').html('');
				   			list.get();
							break;
						case 'ISSUE':
							$('tbody#row').html('');
							issueList.get();
							break;
						case 'CONTACT':
							$('tbody#row').html('');
							list.get();
							break;
						case 'SVPJ':
							$('tbody#row').html('');
							projectMGMTList.get();
							break;
						default:
							break;
						} */
						
						//신규 등록 시 스크롤 맨위로 애니메이트
						$("#divModalCoachingTalkView").animate({
							scrollTop: 0
						}, 500);
						
					},
					complete : function(){
						//$.ajaxLoadingHide();
					}
				});
			}
		}
}

$(document).ready(function(){
	$("textarea[name='textModalCoachingTalk']").keyup(function(e){
		var str = '';
		str = $("textarea[name='textModalCoachingTalk']").val().replace(/\n/g,'');
		str = str.replace(/ /gi,'');
		
		if($("textarea[name='textModalCoachingTalk']").val() == ''){
			$("#buttonCoachingTalkSave").attr('disabled',true);
		}else if(!isEmpty(str)){
			$("#buttonCoachingTalkSave").removeAttr('disabled');
		}else{
			$("#buttonCoachingTalkSave").attr('disabled',true);
		}
		
	});
	
	$("textarea[name='textModalCoachingTalk']").keypress(function(e){
		if(e.keyCode == 13 && e.shiftKey){
			if(!isEmpty($("textarea[name='textModalCoachingTalk']").val()) && $("textarea[name='textModalCoachingTalk']").val() != '\n'){
				coachingTalk.submit();
				return false;
			}else{
				$("textarea[name='textModalCoachingTalk']").val('');
				return false;
			}
		}else if(e.keyCode != 13 && e.keyCode != 32){
		}
	});
});