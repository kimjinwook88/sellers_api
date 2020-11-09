<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 모듈설정 modal -->
<div class="modal inmodal fade" id="userTrackingOptionSetup" tabindex="-1" role="dialog"  aria-hidden="true">
   <div class="modal-dialog modal-lg">
       <div class="modal-content">
           <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
               <h4 class="modal-title">알림 주기 설정</h4>
           </div>
           <div class="modal-body">
               <div class="row">
                   <div class="col-lg-12">
                       <div class="ibox float-e-margins">
                           <div class="ibox-content border_n">
                           
                           		<div class="hr-line-dashed"></div>
                           		<div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 알림주기</label>
                                     <div class="col-sm-4">
                                           <div class="select-com"><!-- <label>항목선택</label> -->
                                           		<select class="form-control" name="selectModalTrackingOptionCategory" id="selectModalTrackingOptionCategory" aria-required="true" onchange="setUpModal.restFrqnc();setUpModal.changeOption();setUpModal.setDocument();">
													<option value="N">매일 알림</option>
													<option value="Y">주기 설정</option>
                                        		</select> 
                                            </div>
                                       </div>
                                       
                                       <div id="divModalTrackingOptionFrqncN">
                                       <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 알림 시작/종료일</label>
	                           			<div class="col-sm-4">
	                           				<input type="text" class="form-control" id="textModalTrackingOptionDueDate" name="textModalTrackingOptionDueDate" onkeyup="setUpModal.setDocument();">
	                           			</div>
	                           			</div>
                                 </div>
                           		
                                  <div class="form-group">
                                      <div class="">
                                     	 <div id="divModalTrackingOptionFrqncY">
                                     	 <div class="hr-line-dashed"></div>
                                          <table id="" class="module-set">
                                              <colgroup>
                                                  <col width="20%"/>
                                                  <col width="60%"/>
                                                  <col width="20%"/>
                                              </colgroup>
                                              <thead>
                                                  <tr>
                                                      <th>번호</th>
                                                      <th>빈도</th>
                                                      <th>삭제</th>
                                                  </tr>
                                              </thead>
                                              
                                              <tbody id="tbodyFrqncDate">
                                              </tbody>
                                          </table>
                                          
                                          <p class="text-center pd-t10">
                                              <button class="btn btn-white" onclick="setUpModal.addFrqnc();"><i class="fa fa-plus"></i> 빈도 추가</button>
                                          </p>
                                        </div>  
                                        
                                        <div class="hr-line-dashed"></div>
                                          <p class="text-center pd-t10">
                                              <label class="btn-row-add" id="pModalUserTrackingOptionSetupText"></label>
                                          </p>
                                          
                                          <input type="hidden" id="hiddenModalTrackingOptionCategory" name="hiddenModalTrackingOptionCategory">
                                          <input type="hidden" id="hiddenModalTrackingOptionFrqnc" name="hiddenModalTrackingOptionFrqnc">
                                          
                                          <div class="pd10 ta-c">
                                              <button type="button" class="btn btn-gray" onclick="setUpModal.applyFrqnc();">수정</button>
                                               <button type="button" class="btn btn-gray" data-dismiss="modal">취소</button>
                                           </div>
                                       </div>
                                   </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function(){
	$("#userTrackingOptionSetup #textModalTrackingOptionDueDate").bind("keypress","button",function(e){
		if(e.keyCode == 8 || e.keyCode == 46 || e.keyCode == 37 || e.keyCode == 39){
			return;
		}else if(e.keyCode >=48 && e.keyCode <= 57){
			if($("#userTrackingOptionSetup #textModalTrackingOptionDueDate").val().length >= 3){
				return false;
			}else{
				return;
			}
		}else{
			return false;
		}
	});

});

var setUpModal = {
		trackingTr : null,
		
		chkKeyCode : function(k, e) {
			if(k.keyCode == 8 || k.keyCode == 46 || k.keyCode == 37 || k.keyCode == 39){
			}else if((k.keyCode >=48 && k.keyCode <= 57) || (k.keyCode >=96 && k.keyCode <= 105)){
				if($(e).val().length >= 3){
					k.preventDefault();
				}else{
					return;
				}
			}else{
				k.preventDefault();
			}
		},
		
		keyUp : function(e) {
			$(e).val($(e).val().replace(/[^0-9]/g, ""));
			setUpModal.changeDocument();
		},
		
		onBlur : function(e) {
			$(e).val($(e).val().replace(/[^0-9]/g, ""));
		},
		
		setDocument : function() {
			if($("#selectModalTrackingOptionCategory").val() == 'N'){
				if($("#hiddenModalTrackingOptionCategory").val() == 'bf'){
					if(!isEmpty($("#userTrackingOptionSetup #textModalTrackingOptionDueDate").val())){
						$("#pModalUserTrackingOptionSetupText").html($("#userTrackingOptionSetup #textModalTrackingOptionDueDate").val() +"일 전부터 매일 알림");
					}else{
						$("#pModalUserTrackingOptionSetupText").html("알림 없음");
					}
				}else{
					if(!isEmpty($("#userTrackingOptionSetup #textModalTrackingOptionDueDate").val())){
						$("#pModalUserTrackingOptionSetupText").html($("#userTrackingOptionSetup #textModalTrackingOptionDueDate").val() +"일 후까지 매일 알림");
					}else{
						$("#pModalUserTrackingOptionSetupText").html("알림 없음");
					}
				}
			}else{
				var frqncDates = $("#hiddenModalTrackingOptionFrqnc").val();
				var frqncDatesArray = frqncDates.split(',');
				
				if($("#hiddenModalTrackingOptionCategory").val() == 'bf'){
					if(!isEmpty(frqncDates)){
						$("#pModalUserTrackingOptionSetupText").html("각각" + frqncDates +"일 전마다 알림");
					}else{
						$("#pModalUserTrackingOptionSetupText").html("알림 없음");
					}
				}else{
					if(!isEmpty(frqncDates)){
						$("#pModalUserTrackingOptionSetupText").html("각각" + frqncDates +"일 후마다 알림");
					}else{
						$("#pModalUserTrackingOptionSetupText").html("알림 없음");
					}
				}
				
				for(var i=0; i<frqncDatesArray.length; i++){
					setUpModal.addFrqnc();
					$('tbody#tbodyFrqncDate').children().eq(i).children().eq(1).children("input").val(frqncDatesArray[i]);
				}
			}
		},
		
		changeDocument : function() {
			var rows = $('tbody#tbodyFrqncDate tr').length;
			var str = '';
			
			for(var i=0; i<rows; i++){
				var rStr = $('tbody#tbodyFrqncDate').children().eq(i).children().eq(1).children("input").val();
				
				if(isEmpty(rStr) && str.substr(str.length-1)==','){
					str = str.substr(0, str.length -1);
				}
				str += rStr;
				if(i<rows-1){
					str += ',';
				}
			}
			$("#hiddenModalTrackingOptionFrqnc").val(str);
			
			if($("#hiddenModalTrackingOptionCategory").val() == 'bf'){
				if(rows > 1){
					$("#pModalUserTrackingOptionSetupText").html("각각 " + str +"일 전 마다 알림");
				}else if(rows == 1){
					$("#pModalUserTrackingOptionSetupText").html(str +"일 전 한번만 알림");
				}else{
					$("#pModalUserTrackingOptionSetupText").html("알림 없음");
				}
			}else{
				if(rows > 1){
					$("#pModalUserTrackingOptionSetupText").html("각각 " + str +"일 후마다 알림");
				}else if(rows == 1){
					$("#pModalUserTrackingOptionSetupText").html(str +"일 후 한번만 알림");
				}else{
					$("#pModalUserTrackingOptionSetupText").html("알림 없음");
				}
			}
		},
		
		changeOption : function() {
			if($("#selectModalTrackingOptionCategory").val() == 'N'){
				$("#divModalTrackingOptionFrqncN").show();
				$("#divModalTrackingOptionFrqncY").hide();
			}else{
				$("#divModalTrackingOptionFrqncN").hide();
				$("#divModalTrackingOptionFrqncY").show();
			}
		},
		
		restFrqnc : function() {
			$('tbody#tbodyFrqncDate').html('');
		},
		
		addFrqnc : function() {
			var rows = $('tbody#tbodyFrqncDate tr').length;
			var data = '<tr>' + 
						'<td>' + (rows+1) + '</td>' +
						'<td><input type="text" class="" name="textModalTrackingFrqnc" onkeydown="setUpModal.chkKeyCode(event, this);" onkeyup="setUpModal.keyUp(this);" onblur="setUpModal.onBlur(this)";/></td>' +
						'<td><a href="javascript:void(0);" onclick="setUpModal.delFrqnc(this);"><i class="fa fa-trash-o fa-lg"></i></a></td>' +
						'</tr>';
			$('tbody#tbodyFrqncDate').append(data);
		},
		
		delFrqnc : function(e) {
			$(e).parents('tr').remove();
			
			setUpModal.rfFrqnc();
			setUpModal.changeDocument();
		},
		
		rfFrqnc : function() {
			var rows = $('tbody#tbodyFrqncDate tr').length;
			
			for(var i=0; i<rows; i++){
				$('tbody#tbodyFrqncDate tr')[i].children[0].innerHTML = i+1;
			}
		},
		
		applyFrqnc : function() {
			var slct = setUpModal.trackingTr;
			var option = $(slct).parents("tr").find('td[name="cols_USER_TRACKING_OPTION"]');
			var txt = '<span class="label black_count_bg" style="cursor: pointer;" data-toggle="modal" data-target="#userTrackingOptionSetup" onclick="list.goDetail(this, \''+ $("#hiddenModalTrackingOptionCategory").val() +'\');"><i class="fa fa-gear"></i></span>';
			
			if($("#hiddenModalTrackingOptionCategory").val() == 'bf'){
				option.children('input[name="hiddenTableBeforeDueDate"]').val($("#textModalTrackingOptionDueDate").val());
				option.children('input[name="hiddenTableFrqncBeforeUseYn"]').val($("#selectModalTrackingOptionCategory").val());
				option.children('input[name="hiddenTableFrqncBefore"]').val($("#hiddenModalTrackingOptionFrqnc").val());
				$(slct).parents("tr").find('td[name="cols_BEFORE_DUE_RULE"]').html($("#pModalUserTrackingOptionSetupText").html() + txt);
			}else{
				option.children('input[name="hiddenTableAfterDueDate"]').val($("#textModalTrackingOptionDueDate").val());
				option.children('input[name="hiddenTableFrqncAfterUseYn"]').val($("#selectModalTrackingOptionCategory").val());
				option.children('input[name="hiddenTableFrqncAfter"]').val($("#hiddenModalTrackingOptionFrqnc").val());
				$(slct).parents("tr").find('td[name="cols_AFTER_DUE_RULE"]').html($("#pModalUserTrackingOptionSetupText").html() + txt);
			}
			
			$('#userTrackingOptionSetup').modal("hide");
		}
}
</script>