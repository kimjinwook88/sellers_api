var fua = {
	fuaValid : true,
	fuaList : new Array(),
		
	/**
	 * Follow-Up Action 입력란 추가
	 */
	fuaAdd : function(map){
		$.get('/ajaxHtml/mobileFollowUpAction.html', function(data){
		    $('.cont2 ul').append(data);
		}).done(function(){
			if(map){
				var idx = $('.cont ul li').length-1;
				$("textarea[name='textareaFuaContents']").eq(idx).text(map.CONTENTS);
				$("input[name='textModalFuaPlanDate']").eq(idx).val(map.SOLVE_DUE_DATE);
				$("input[name='textModalFuaActualDate']").eq(idx).val(map.SOLVE_CLOSE_DATE);
				$("input[name='hiddenFuaId']").eq(idx).val(map.ACTION_ID);
				$("input[name='textModalFuaPlanDate']").eq(idx).trigger("change");
				$("input[name='textModalFuaActualDate']").eq(idx).trigger("change");	
				
				$("input[name='textFuaMember']").eq(idx).val(map.SOLVE_OWNER);
				$("input[name='hiddenFuaMemberId']").eq(idx).val(map.SOLVE_OWNER_ID);
				$("input[name='hiddenFuaMemberName']").eq(idx).val(map.SOLVE_OWNER + (map.SOLVE_OWNER_POSITION != null ? ' '+ map.SOLVE_OWNER_POSITION : ''));
				/*$("li[name='liFuaMemberSeach']").eq(idx).before(
						'<li class="value">'+
						'<span class="txt" id="'+ map.SOLVE_OWNER_ID +'">'+ map.SOLVE_OWNER +' ['+ map.SOLVE_OWNER_POSITION +']</span>'+
						'<a href="#" class="remove" onclick="commonSearch.removeSingleMember2(this,null);">'+
						'<i class="fa fa-times-circle"></i></a>'+
						'</li>'
				);*/
			}
		});			
	},
	
	/**
	 * delete
	 */
	fuaDel : function(obj, url){			
		var fuaId = $(obj).next('input[name="hiddenFuaId"]').val();
		if(fuaId){
			$.ajax({
				url : '/clientSalesActive/deleteContactActionItem.do',
				datatype : 'json',
				async : false,
				data : {
					action_id : fuaId,
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
	 * 목표/실제 완료일에 따른 상태색상 변경
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
	 * validate
	 */
	fuaValidate : function(){
		
	},
	
	/**
	 * submit
	 */
	fuaSubmitList : function(){
		fua.fuaValid = true;
		
		$('label[name=fuaError]').remove();
		
		$('.cont2 li').each(function(idx,val){
			var fuaMap = new Object();
			
			//validation			
			if(($('textarea[name="textareaFuaContents"]').eq(idx).val()).trim()){ //내용을 작성한것만 담는다.
				fuaMap.CONTENTS = $('textarea[name="textareaFuaContents"]').eq(idx).val();
				fuaMap.SOLVE_OWNER_ID = $('input[name="hiddenFuaMemberId"]').eq(idx).val();
				fuaMap.SOLVE_OWNER_NAME = $('input[name="hiddenFuaMemberName"]').eq(idx).val();
				fuaMap.SOLVE_DUE_DATE = $('input[name="textModalFuaPlanDate"]').eq(idx).val();
				if(isEmpty(fuaMap.SOLVE_DUE_DATE)){
					fncSelectTab(2);
					$('input[name="textModalFuaPlanDate"]').eq(idx).after('<label name="fuaError" class="error-custom" for="fuaTable">완료목표일을 입력해 주세요.</label>'	);
					$('input[name="textModalFuaPlanDate"]').eq(idx).focus();
					fua.fuaValid = false;
				}
				if(isEmpty(fuaMap.SOLVE_OWNER_ID)){
					fncSelectTab(2);
					$('input[name="textFuaMember"]').eq(idx).after('<label name="fuaError" class="error-custom" for="fuaTable">책임자를 입력해 주세요.</label>');
					$('input[name="textFuaMember"]').eq(idx).focus();
					fua.fuaValid = false;
					return false; 
				}
				fuaMap.SOLVE_CLOSE_DATE = $('input[name="textModalFuaActualDate"]').eq(idx).val();
				fuaMap.ACTION_ID = $('input[name="hiddenFuaId"]').eq(idx).val();
				fua.fuaList.push(fuaMap);
			}
		});
		return fua.fuaList;
	},
	
	/**
	 * follow-Up Action 리스트 조회
	 */
	fuaGetList : function(url, pkNo){
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
						fua.fuaAdd(map);
					}
				}else{
					fua.fuaAdd();
				}
			},
			complete: function(data){
			},
			error: function(xhr, status, err) {
			}
		});
	}
}

$(document).ready(function(){
	
	//책임자 자동 완성
	$('.cont2 ul').on('focus', 'input[name="textFuaMember"]', function(e){
		if($(this).attr('auto-bind') == '0'){
			commonSearch.member($(this), $(this).next($('input[name="hiddenFuaMemberId"]')));
			$(this).attr('auto-bind','1');
		}
	});
	
	//완료목표일 설정 시 라인 색상 변경
	$('.cont2 ul').on('change', 'input[name="textModalFuaPlanDate"]', function(e){
		var plan_idx = $('.cont2 li input[name="textModalFuaPlanDate"]').index(this);
		var plan_date = $('.cont2 li input[name="textModalFuaPlanDate"]').eq(plan_idx).val();
		var actual_date = $('.cont2 li input[name="textModalFuaActualDate"]').eq(plan_idx).val();
		var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
		$('.cont2 li:eq('+plan_idx+') .h_line').css('border', fua.statusColor(plan_date, actual_date, nowDate));
		
		// 유효성 검사 메세지 리셋
		if($(this).val()){
			$(this).next('label.error-custom').remove();
		}
	});
	
	//실제완료일 설정 시 라인 색상 변경
	$('.cont2 ul').on('change', 'input[name="textModalFuaActualDate"]', function(e){
		var actual_idx = $('.cont2 li input[name="textModalFuaActualDate"]').index(this);
		var plan_date = $('.cont2 li input[name="textModalFuaPlanDate"]').eq(actual_idx).val();
		var actual_date = $('.cont2 li input[name="textModalFuaActualDate"]').eq(actual_idx).val();
		var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
		$('.cont2 li:eq('+actual_idx+') .h_line').css('border', fua.statusColor(plan_date, actual_date, nowDate));
	});
	
	//유효성 검사 메세지 리셋
	$('.cont2 ul').on('change', 'input[name="textFuaMember"]', function(e){
		if($(this).val()){
			$(this).next('label.error-custom').remove();
		}
	});
});