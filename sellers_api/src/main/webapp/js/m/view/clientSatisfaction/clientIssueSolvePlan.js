var action = {
		
	actValid : true,
	actList : new Array(),
	
	/**
	 * Action Plan 입력란 추가
	 */
	actAdd : function(map){
		$.get('/ajaxHtml/mobileIssueSolvePlan.html', function(data){
		    $('.cont2 ul').append(data);
		}).done(function(){
			if(map){
				var idx = $('.cont ul li').length-1;
				$("input[name='hiddenActId']").eq(idx).val(map.ACTION_ID);
				$("textarea[name='textareaActContents']").eq(idx).text(map.SOLVE_PLAN);
				$("input[name='textActMember']").eq(idx).val(map.SOLVE_OWNER);
				$("input[name='hiddenActMemberId']").eq(idx).val(map.SOLVE_OWNER_ID);
				$("input[name='hiddenActMemberName']").eq(idx).val(map.SOLVE_OWNER + (map.SOLVE_OWNER_POSITION != null ? ' '+ map.SOLVE_OWNER_POSITION : ''));	
				
				$("input[name='textModalActPlanDate']").eq(idx).val(map.DUE_DATE);
				$("input[name='textModalActActualDate']").eq(idx).val(map.CLOSE_DATE);				
				$("input[name='textModalActPlanDate']").eq(idx).trigger("change");
				$("input[name='textModalActActualDate']").eq(idx).trigger("change");	
			}
		});
	},
	
	/**
	 * delete
	 */
	actDel : function(obj, url){
		var actId = $(obj).next('input[name="hiddenActId"]').val();
		if(actId){
			$.ajax({
				url : '/clientSalesActive/deleteClientIssueActionPlan.do',
				datatype : 'json',
				async : false,
				data : {
					issueActionId : actId,
					hiddenModalPK : $('#hiddenModalPK').val()
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader('ajax', true);
					if(!confirm('삭제하시겠습니까?')){
						return false;	
					}
				},
				success : function(data){
					if(data.cnt > 0){
						alert('삭제되었습니다.');
						$(obj).parent().remove();
					}else{
						alert('삭제를 실패했습니다.\n관리자에게 문의하세요.');
					}
				},
				complete: function(){
					$.ajaxLoadingHide();
				},
				error: function(xhr, status, err) {
					$.error(xhr, status, err);
				}
			});
		}else{
			$(obj).parent().remove();
		}
	},
	
	/**
	 * 해결/실제 목표일에 따른 상태색상 변경
	 */
	statusColor : function(dueDate, closeDate, nowDate){
		var statusColor = 'solid 1px ';
		dueDate = (dueDate.replaceAll('-','')).trim();
		closeDate = (closeDate.replaceAll('-','')).trim();
		if((dueDate >= nowDate) && closeDate == ''){
			statusColor += '#ffaa00';
		}else if(dueDate < nowDate && closeDate == ''){
			statusColor += '#f20056';
		}else if(closeDate != '' && closeDate != null){
			statusColor += '#1ab394';
		} 
		return statusColor; 
	},
	
	/**
	 * submit
	 */
	actSubmitList : function(){
		action.actValid = true;
		
		$('label[name=actError]').remove();
		
		$('.cont2 li').each(function(idx,val){
			var actMap = new Object();
			
			//validation			
			if(($('textarea[name="textareaActContents"]').eq(idx).val()).trim()){ //내용을 작성한것만 담는다.
				actMap.SOLVE_PLAN = $('textarea[name="textareaActContents"]').eq(idx).val();
				actMap.SOLVE_OWNER_ID = $('input[name="hiddenActMemberId"]').eq(idx).val();
				actMap.SOLVE_OWNER = $('input[name="hiddenActMemberName"]').eq(idx).val();
				actMap.DUE_DATE = $('input[name="textModalActPlanDate"]').eq(idx).val();
				if(isEmpty(actMap.DUE_DATE)){
					fncSelectTab(2);
					$('input[name="textModalActPlanDate"]').eq(idx).after('<label name="actError" class="error-custom" for="actTable">완료목표일을 입력해 주세요.</label>'	);
					$('input[name="textModalActPlanDate"]').eq(idx).focus();
					action.actValid = false;
				}
				if(isEmpty(actMap.SOLVE_OWNER_ID)){
					fncSelectTab(2);
					$('input[name="textActMember"]').eq(idx).after('<label name="actError" class="error-custom" for="actTable">책임자를 입력해 주세요.</label>');
					$('input[name="textActMember"]').eq(idx).focus();
					action.actValid = false;
					return false; 
				}				
				actMap.CLOSE_DATE = $('input[name="textModalActActualDate"]').eq(idx).val();
				actMap.ACTION_ID = $('input[name="hiddenActId"]').eq(idx).val();				
				action.actList.push(actMap);
			}
		});
		return action.actList;
	},
	
	/**
	 * Action Plan 불러오기
	 */
	actGetList : function(url, pkNo){
		$.ajax({
			url : url,
			datatype : 'json',
			async : false,
			data : {
				pkNo : pkNo
			},
			beforeSend : function(xhr){
			},
			success : function(data){
				var list = data.rows;
				if(list.length > 0){
					for(var i=0; i<list.length; i++){
						var map = list[i];
						action.actAdd(map);
					}
				}else{
					action.actAdd();
				}
			},
			complete: function(data){
			},
			error: function(xhr, status, err) {
			}
		});
	}
}


$(document).ready(function() {
	
	//담당자 자동 완성
	$('.cont2 ul').on('focus', 'input[name="textActMember"]', function(e){
		if($(this).attr('auto-bind') == '0'){
			commonSearch.member($(this), $(this).nextAll('input[name="hiddenActMemberId"]'));
			$(this).attr('auto-bind','1');
		}
	});
	
	//해결목표일 설정 시 라인 색상 변경
	$('.cont2 ul').on('change', 'input[name="textModalActPlanDate"]', function(e){
		var plan_idx = $('.cont2 li input[name="textModalActPlanDate"]').index(this);
		var plan_date = $('.cont2 li input[name="textModalActPlanDate"]').eq(plan_idx).val();
		var actual_date = $('.cont2 li input[name="textModalActActualDate"]').eq(plan_idx).val();
		var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
		$('.cont2 li:eq('+plan_idx+') .h_line').css('border', action.statusColor(plan_date, actual_date, nowDate));
		
		// 유효성 검사 메세지 리셋
		if($(this).val()){
			$(this).next('label.error-custom').remove();
		}
	});
	
	//실제완료일 설정 시 라인 색상 변경
	$('.cont2 ul').on('change', 'input[name="textModalActActualDate"]', function(e){
		var actual_idx = $('.cont2 li input[name="textModalActActualDate"]').index(this);
		var plan_date = $('.cont2 li input[name="textModalActPlanDate"]').eq(actual_idx).val();
		var actual_date = $('.cont2 li input[name="textModalActActualDate"]').eq(actual_idx).val();
		var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
		$('.cont2 li:eq('+actual_idx+') .h_line').css('border', action.statusColor(plan_date, actual_date, nowDate));
	});
	
	//유효성 검사 메세지 리셋
	$('.cont2 ul').on('change', 'input[name="textActMember"]', function(e){
		if($(this).val()){
			$(this).next('label.error-custom').remove();
		}
	});
});