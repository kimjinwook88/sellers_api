<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script type="text/javascript">
	var bizPpOppEvent = {
			on : function(){
				//고객사 자동 완성
				$("tbody#tbodyBizPpOpp").on("focus", "input[name='textBizPpOppCompany']", bizPpOppEvent.focusCompany);
				//영업대표 자동 완성
				$("tbody#tbodyBizPpOpp").on("focus", "input[name='textBizPpOppMember']", bizPpOppEvent.focusMember);
				
				$("tbody#tbodyBizPpOpp").on("keydown", "input[name='textBizPpOppCompany'], input[name='textBizPpOppName'], input[name='textBizPpOppAmount'], input[name='textModalBizPpOppPlanDate'], input[name='textBizPpOppMember']", bizPpOppEvent.keydownSubmit);
			},
			
			off : function(){
				//고객사 자동 완성
				$("tbody#tbodyBizPpOpp").off("focus", "input[name='textBizPpOppCompany']", bizPpOppEvent.focusCompany);
				//영업대표 자동 완성
				$("tbody#tbodyBizPpOpp").off("focus", "input[name='textBizPpOppMember']", bizPpOppEvent.focusMember);
				
				$("tbody#tbodyBizPpOpp").off("keydown", "input[name='textBizPpOppCompany'], input[name='textBizPpOppName'], input[name='textBizPpOppAmount'], input[name='textModalBizPpOppPlanDate'], input[name='textBizPpOppMember']", bizPpOppEvent.keydownSubmit);
			},
			
			focusCompany : function(e){
				if($(this).attr("auto-bind") == "0"){
					commonSearch.singleCompany2($(this),null);
					$(this).attr("auto-bind","1");
				}
			},
			
			focusMember : function(e){
				if($(this).attr("auto-bind") == "0"){
					commonSearch.singleMember2($(this),null);
					$(this).attr("auto-bind","1");
				}
			},
			
			keydownSubmit : function(e){
				if(e.keyCode == 13){//키가 13이면 실행 (엔터는 13)
					return false;
		    	 }
			}
	}
	
	var bizPpOpp = {
			list : null,
			
			//추가
			add : function(map){
				$.get("/ajaxHtml/bizProjectPlanOpportunity.html", function(data){
				    $('tbody#tbodyBizPpOpp').append(data);
				}).done(function(){
					if(map){
						var idx = $('tbody#tbodyBizPpOpp tr').length-1;
						
						if(!isEmpty(map.OPP_COMPANY_ID)){
							commonSearchAdd.singleCompany2(
									$("tbody#tbodyBizPpOpp input[name='textBizPpOppCompany']").eq(idx),
									$("tbody#tbodyBizPpOpp input[name='hiddenBizPpOppCompanyId']").eq(idx),									
									$("tbody#tbodyBizPpOpp li[name='liBizPpOppCompanySeach']").eq(idx),
									map.OPP_COMPANY_ID,
									map.COMPANY_NAME
							);
						}
						else{
							$("tbody#tbodyBizPpOpp input[name='textBizPpOppCompany']").eq(idx).show();
						}
						
						$("tbody#tbodyBizPpOpp input[name='textBizPpOppName']").eq(idx).val(map.OPP_NAME);
						$("tbody#tbodyBizPpOpp input[name='textBizPpOppAmount']").eq(idx).val(add_comma(map.OPP_AMOUNT.toString()));
						$("tbody#tbodyBizPpOpp input[name='textModalBizPpOppPlanDate']").eq(idx).val(map.OPP_DATE);
						$("tbody#tbodyBizPpOpp input[name='hiddenBizPpOppId']").eq(idx).val(map.OPP_DATE);
						
						if(!isEmpty(map.OPP_SALES_MAN_ID)){
							commonSearchAdd.singleMember2(
									$("tbody#tbodyBizPpOpp input[name='textBizPpOppMember']").eq(idx),
									$("tbody#tbodyBizPpOpp input[name='hiddenBizPpOppMemberId']").eq(idx),
									$("tbody#tbodyBizPpOpp li[name='liBizPpOppMemberSeach']").eq(idx),		
									map.OPP_SALES_MAN_ID,
									map.HAN_NAME,
									map.POSITION_STATUS
							);
						}
						else{
							$("tbody#tbodyBizPpOpp input[name='textBizPpOppMember']").eq(idx).show();
						}
						
					}
				});
			},
			
			//삭제			
			del : function(obj){
				/* var bizPpOppId = $(obj).next("input[name='hiddenBizPpOppId']").val();
				if(bizPpOppId){
					$.ajax({
						url : "/clientSalesActive/deleteContactActionItem.do",
						datatype : 'json',
						async : false,
						data : {
							action_id : bizPpOppId,
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
				} */
				$(obj).parent().parent().remove();
			},
			
			reset : function(){
				$('tbody#tbodyBizPpOpp tr').remove();		
			},
			
			setList : function(){
				bizPpOpp.list = new Array();
				
				$('tbody#tbodyBizPpOpp tr').each(function(idx,val){
					var bizPpOppMap = new Object();
					if(($("input[name='textBizPpOppName']").eq(idx).val()).trim()){ //프로젝트 명을 작성한것만 담는다.
						bizPpOppMap.COMPANY_ID = $("input[name='hiddenBizPpOppCompanyId']").eq(idx).val();
						bizPpOppMap.NAME = $("input[name='textBizPpOppName']").eq(idx).val();
						bizPpOppMap.AMOUNT = uncomma($("input[name='textBizPpOppAmount']").eq(idx).val());
						bizPpOppMap.PLAN_DATE = $("input[name='textModalBizPpOppPlanDate']").eq(idx).val();
						bizPpOppMap.MEMBER_ID = $("input[name='hiddenBizPpOppMemberId']").eq(idx).val();
						bizPpOpp.list.push(bizPpOppMap);
					}
				});
				//return bizPpOpp.list;
			},
	
			zero : function(obj) {
				if(obj.value=="0") obj.value="";
			},
			
			blur : function(obj){
				var string = obj.value;
				var objName = $(obj).attr("name");
				
				if(isEmpty(string)) obj.value=0;
				
				//끝자리가 .이면 제거
				if(string.charAt(string.length-1) == "."){
					obj.value = string.slice(0,-1);
				}
			}
			
	}
</script>					
		             	 
		             	 
        	 <!-- <div class="table_container_fade"></div> -->
	<table id="bizPpOppTable" class="table table-bordered table-inner" style="width:800px; margin-bottom:5px;">
		  <colgroup>
			<col width="180px;">
			<col width="200px;">
			<col width="130px;">
			<col width="130px;">
			<col width="130px;">
			<col width="40px;">
		  </colgroup>
          <thead>
              <tr>
                  <th>고객사</th>
                  <th>프로젝트명</th>
                  <th>금액</th>
                  <th>일정</th>
                  <th>영업대표</th>
                  <th>삭제</th>
              </tr>
          </thead>
          <tbody id="tbodyBizPpOpp">
		  </tbody>
	</table>
      
    <p class="text-center pd-t10">
		<a href="javascript:void(0);" class="btn-row-add" name="buttonSaleAddRow" onclick="bizPpOpp.add();">+ 영업기회 추가</a>
    </p>
