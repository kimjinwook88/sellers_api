<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script type="text/javascript">
	var fuaValid = true;
 	var fuaCategory = "${param.fuaCategory}"; 			
	var fuaList = null;
	$(document).ready(function(){
		//책임자 자동 완성
		$("tbody#tbodyFua").on("focus", "input[name='textFuaMember']", function(e){
			if($(this).attr("auto-bind") == "0"){
				commonSearch.singleMember2($(this),null);
				$(this).attr("auto-bind","1");
			}
		});
		
		$("tbody#tbodyFua").on("change", "input[name='textModalFuaPlanDate']", function(e){
			var plan_idx = $("tbody#tbodyFua input[name='textModalFuaPlanDate']").index(this);
			var plan_date = $("tbody#tbodyFua input[name='textModalFuaPlanDate']").eq(plan_idx).val();
			var actual_date = $("tbody#tbodyFua input[name='textModalFuaActualDate']").eq(plan_idx).val();
			var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
			$("td[name='tdFuaStatus']").eq(plan_idx).css("background-color",fnStatusColor2(plan_date,actual_date, nowDate));
		});
		
		$("tbody#tbodyFua").on("change", "input[name='textModalFuaActualDate']", function(e){
			var actual_idx = $("tbody#tbodyFua input[name='textModalFuaActualDate']").index(this);
			var plan_date = $("tbody#tbodyFua input[name='textModalFuaPlanDate']").eq(actual_idx).val();
			var actual_date = $("tbody#tbodyFua input[name='textModalFuaActualDate']").eq(actual_idx).val();
			var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
			$("td[name='tdFuaStatus']").eq(actual_idx).css("background-color",fnStatusColor2(plan_date,actual_date, nowDate));
		});
		
		$("tbody#tbodyFua").on("keydown", "input[name='textFuaMember'], input[name='textModalFuaActualDate'], input[name='textModalFuaPlanDate']", function(e){
			if(e.keyCode == 13){//키가 13이면 실행 (엔터는 13)
				return false;
	    	 }
		});
		
	});
	
	function fuaAdd(map){
		$.get("/ajaxHtml/followUpAction.html", function(data){
		    $('tbody#tbodyFua').append(data);
		}).done(function(){
			if(map){
				var idx = $('tbody#tbodyFua tr').length-1;
				$("textarea[name='textareaFuaContents']").eq(idx).text(map.CONTENTS);
				$("input[name='textModalFuaPlanDate']").eq(idx).val(map.SOLVE_DUE_DATE);
				$("input[name='textModalFuaActualDate']").eq(idx).val(map.SOLVE_CLOSE_DATE);
				$("input[name='hiddenFuaId']").eq(idx).val(map.ACTION_ID);
				$("input[name='textModalFuaPlanDate']").eq(idx).trigger("change");
				$("input[name='textModalFuaActualDate']").eq(idx).trigger("change");	
				
				$("input[name='textFuaMember']").eq(idx).hide();
				$("input[name='hiddenFuaMemberId']").eq(idx).val(map.SOLVE_OWNER_ID);
				$("input[name='hiddenFuaMemberName']").eq(idx).val(map.SOLVE_OWNER + (map.SOLVE_OWNER_POSITION != null ? ' '+ map.SOLVE_OWNER_POSITION : ''));
				$("li[name='liFuaMemberSeach']").eq(idx).before(
						'<li class="value">'+
						'<span class="txt" id="'+ map.SOLVE_OWNER_ID +'">'+ map.SOLVE_OWNER +' ['+ map.SOLVE_OWNER_POSITION +']</span>'+
						'<a href="#" class="remove" onclick="commonSearch.removeSingleMember2(this,null);">'+
						'<i class="fa fa-times-circle"></i></a>'+
						'</li>'
				);
			}
		});
	}
	
	function fuaDel(obj,url){
		var fuaId = $(obj).next("input[name='hiddenFuaId']").val();
		if(fuaId){
			$.ajax({
				url : "/clientSalesActive/deleteContactActionItem.do",
				datatype : 'json',
				async : false,
				data : {
					action_id : fuaId,
					hiddenModalPK : $("#hiddenModalPK").val()
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("삭제하시겠습니까?")){
						return false;	
					}
					$.ajaxLoadingShow();
				},
				success : function(data){
					if(data.cnt > 0){
						alert("삭제되었습니다.");
						$(obj).parent().parent().remove();
						//list.reset();
	                	//list.searchReset(); //등록/수정 시 검색 초기화
						list.get();
						list.compare_before = $("#formModalData").serialize();
					}else{
						alert("삭제를 실패했습니다.\n관리자에게 문의하세요.");
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
			$(obj).parent().parent().remove();
		} 
	}
	
	function fuaReset(){
		$('tbody#tbodyFua tr').remove();
	}
	
	function fuaSubmitList(){
		fuaValid = true;
		fuaList = new Array();
		$("label#fuaTable-error").remove();
		
		$('tbody#tbodyFua tr').each(function(idx,val){
			var fuaMap = new Object();
			//validation
			if(($("textarea[name='textareaFuaContents']").eq(idx).val()).trim()){ //내용을 작성한것만 담는다.
				fuaMap.CONTENTS = $("textarea[name='textareaFuaContents']").eq(idx).val();
				fuaMap.SOLVE_OWNER_ID = $("input[name='hiddenFuaMemberId']").eq(idx).val();
				fuaMap.SOLVE_OWNER_NAME = $("input[name='hiddenFuaMemberName']").eq(idx).val();
				fuaMap.SOLVE_DUE_DATE = $("input[name='textModalFuaPlanDate']").eq(idx).val();
				if(isEmpty(fuaMap.SOLVE_OWNER_ID)){
					$("#fuaTable").after('<label id="fuaTable-error" class="error-custom" for="fuaTable">책임자를 입력해 주세요.</label>'	);
					fuaValid = false;
					return false; 
				}
				if(isEmpty(fuaMap.SOLVE_DUE_DATE)){
					$("#fuaTable").after('<label id="fuaTable-error" class="error-custom" for="fuaTable">완료목표일을 입력해 주세요.</label>'	);
					fuaValid = false;
					return false; 
				}
				fuaMap.SOLVE_CLOSE_DATE = $("input[name='textModalFuaActualDate']").eq(idx).val();
				fuaMap.ACTION_ID = $("input[name='hiddenFuaId']").eq(idx).val();
				fuaList.push(fuaMap);
			}
		});
		return fuaList;
	}
	
	function fuaGetList(url, pkNo){
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
				fuaReset();
				var list = data.rows;
				if(list.length > 0){
					for(var i=0; i<list.length; i++){
						var map = list[i];
						fuaAdd(map);
					}
				}else{
					fuaAdd();
				}
			},
			complete: function(data){
			},
			error: function(xhr, status, err) {
			}
		});
	}
</script>					
		             	 
		             	 
		             	 <!-- <div class="table_container_fade"></div> -->
			                <table id="fuaTable" class="table table-bordered table-inner" style="width:680px; margin-bottom: 5px;">
								<colgroup>
									<col width="*">
									<col width="135px;">
									<col width="120px;">
									<col width="120px;">
									<col width="50px;">
									<col width="40px;">
								</colgroup>
					              <thead>
					                  <tr>
					                      <th>내용</th>
					                      <th>책임자</th>
					                      <th>완료목표일</th>
					                      <th>실제완료일</th>
					                      <th>status</th>
					                      <th>삭제</th>
					                  </tr>
					              </thead>
					              <tbody id="tbodyFua">
		                    	  </tbody>
				       		 </table>
					        
					        <p class="text-center pd-t10">
								<a href="javascript:void(0);" class="btn-row-add" name="buttonSaleAddRow" onclick="fuaAdd();">+ Follow-Up Action 추가</a>
				            </p>
