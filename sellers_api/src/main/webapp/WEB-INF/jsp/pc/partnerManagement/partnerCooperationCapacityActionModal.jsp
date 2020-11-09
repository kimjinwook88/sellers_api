<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- Action popup -->
 <div class="action-pop action off" style="z-index:99999999;">
     <div class="pop-header">
         <button type="button" class="close" onClick="$('div.action-pop.action').addClass('off');"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
         <strong class="pop-title">IBM H/W부문(삼성)</strong>
     </div>
     <div class="col-sm-12 cont">
         <div class="col-sm-12 m-b">
             <label class="control-l" for="date_modified">필요 Action</label>
             <select class="form-control" name="selectModalCondition" id="selectModalCondition">
             	 <option value="">== Action 선택==</option>
                 <option value="Unstacking">Unstacking</option>
				 <option value="Recruitment">Recruitment</option>
             </select>
         </div>
         <div class="col-sm-12 m-b">
             <label class="control-label" for="date_modified">분석 결과 및 계획</label>
             <div class="input-group" style="width:100%;" >
             	<textarea class="pop-textarea-input" rows="3" id="textareaModalGap" name="textareaModalGap"
             	 onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea>
             </div>
         </div>
         <div class="col-sm-6 m-b">
             <label class="control-label" for="date_modified">책임 담당자</label>
             <div class="input-group pos-rel" style="width:100%;" >
             	<input type="text" class="form-control" id="textModalSolveManager" name="textModalSolveManager" placeholder="책임 담당자 검색" autocomplete="off"/>
             </div>
         </div>
         <div class="col-sm-6 m-b">
             <label class="control-label" for="date_modified">해결목표일</label>
             <div class="input-group" style="width:100%;" >
             	<div class="data_1">
                   <div class="input-group date">
                       <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textModalSolveDate" name="textModalSolveDate" />
                   </div>
               </div>
             </div>
         </div>
         <div class="col-sm-12 m-b">
             <label class="control-l" for="date_modified">해결상황</label>
             <select class="form-control" name="selectModalSolveStatus" id="selectModalSolveStatus">
				 <option value="미완료">미완료</option>
                 <option value="완료">완료</option>
             </select>
         </div>
         <div class="col-sm-12 m-b ta-c">
             <button type="button" class="btn btn-w-m btn-primary btn-gray" onClick="modalAction.submit();">저장하기</button>
         </div>
     </div>
 </div>
 <input type="hidden" id="hiddenModalSolveManagerId" name="hiddenModalSolveManagerId"/>
                                        
<script type="text/javascript">
$(document).ready(function() { 
		modalAction.init();
});		
 
var modalAction = {
		init : function(){
			commonSearch.memberPartner($("#textModalSolveManager"), $('#hiddenModalSolveManagerId'));
		},
		
		alignment_id : null,
		
		reset : function() { 
		},
		
		submit : function(){
			$.ajax({
				url : "/partnerManagement/insertCapacityAction.do",
				datatype : 'json',
				type : "POST",
				async : false,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("저장하시겠습니까?")){
						return false;	
					}
				},
				data : {
					selectViewList:$("#selectViewList").val(),
					alignment_id : modalAction.alignment_id,
					textareaModalGap : $("#textareaModalGap").val(),
					selectModalCondition : $("#selectModalCondition").val(),
					selectModalSolveStatus : $("#selectModalSolveStatus").val(),
					hiddenModalSolveManagerId : $("#hiddenModalSolveManagerId").val(),
					textModalSolveDate : $("#textModalSolveDate").val(),
					datatype : 'json'
				},
				success : function(data){
					if(data.cnt > 0){
						alert("저장하였습니다.");
						//$("#buttonSaveCapacity").trigger("click");
						setTimeout(function(){jqGrid.reload();},300); //ajax Loading
						$('div.action-pop.action').addClass('off');
					}else{
						alert("저장를 실패했습니다.\n관리자에게 문의하세요.");
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		}
		
} 
</script>
