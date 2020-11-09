<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(document).ready(function(){
		milestonesEvent.on();
	});
	
	var milestonesEvent = {
			on : function(){
				//목표일 완료일 status
				$("ul#milestones").on("change", "input[name='textMsDueDate']", milestonesEvent.changeMsDueDate);
				
				$("ul#milestones").on("change", "input[name='textMsCloseDate']", milestonesEvent.changeMsCloseDate); 
				//책임자 자동 완성
				$("ul#milestones").on("focus", "input[name='textMsMember']", milestonesEvent.focusMsMember);
				//enter key
				$("ul#milestones").on("keydown", "input[name='textMsDueDate'], input[name='textMsCloseDate'], input[name='textMsMember']", milestonesEvent.keydownEnterReturn);
			},
			
			off : function(){
				//목표일 완료일 status
				$("ul#milestones").off("change", "input[name='textMsDueDate']", milestonesEvent.changeMsDueDate);
				
				$("ul#milestones").off("change", "input[name='textMsCloseDate']", milestonesEvent.changeMsCloseDate); 
				//책임자 자동 완성
				$("ul#milestones").off("focus", "input[name='textMsMember']", milestonesEvent.focusMsMember);
				//enter key
				$("ul#milestones").off("keydown", "input[name='textMsDueDate'], input[name='textMsCloseDate'], input[name='textMsMember']", milestonesEvent.keydownEnterReturn);
			},
			
			changeMsDueDate : function(e){
				var due_idx = $("ul#milestones input[name='textMsDueDate']").index(this);
				var due_date = $("ul#milestones input[name='textMsDueDate']").eq(due_idx).val();
				var close_date = $("ul#milestones input[name='textMsCloseDate']").eq(due_idx).val();
				var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
				$("ul#milestones li[name='milestones_sub']").eq(due_idx).find("div.h_line").css("border",milestones.statusColor(due_date,close_date, nowDate));
			},
			
			changeMsCloseDate : function(e){
				var close_idx = $("ul#milestones input[name='textMsCloseDate']").index(this);
				var due_date = $("ul#milestones input[name='textMsDueDate']").eq(close_idx).val();
				var close_date = $("ul#milestones input[name='textMsCloseDate']").eq(close_idx).val();
				var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
				$("ul#milestones li[name='milestones_sub']").eq(close_idx).find("div.h_line").css("border",milestones.statusColor(due_date,close_date, nowDate));
			},
			
			focusMsMember : function(e){
				if($(this).attr("auto-bind") == "0"){
					commonSearch.singleMember2($(this),null);
					$(this).attr("auto-bind","1");
				}
			},
			
			keydownEnterReturn : function(e){
				//키가 13이면 실행 (엔터는 13)
				if(e.keyCode == 13){
					return false;
				}
			}
			
	}
	
	var milestones = {
			
			msList : null,
			
			msAddListMaster : function(){
				milestones.msList = new Array(); 
				$("ul#milestones li[name='milestones_sub']").each(function(idx, val){
					var msMap = new Object();
					msMap.MILESTONE_ID = $("ul#milestones input[name='hiddenMsId']").eq(idx).val();
					msMap.KEY_MILESTONE = $("ul#milestones textarea[name='textareaKeyMilestones']").eq(idx).val();
					msMap.DUE_DATE = $("ul#milestones input[name='textMsDueDate']").eq(idx).val();
					msMap.CLOSE_DATE = $("ul#milestones input[name='textMsCloseDate']").eq(idx).val();
					msMap.ACT_ID = $("ul#milestones input[name='hiddenMsMemberId']").eq(idx).val();
					msMap.ACT_NAME = $("ul#milestones input[name='hiddenMsMemberName']").eq(idx).val()
					//msMap.HIDDEN_STATUS = $("textarea[name='textareaKeyMilestones']").eq(idx).parent("td").parent("tr").find("input[name='hiddenOckSeq']").val();
					milestones.msList.push(msMap);
				});
			},
			
			reset : function(){
				$("ul#milestones input").val("");
				$("ul#milestones textarea").val("");
				$("ul#milestones td[name='tdMsStatus']").css("background-color","white");
				$("ul#milestones input[name='textMsMember']").show();
			},
			
			draw : function(list){
				var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
				for(var i=0; i<list.length; i++){
					var msGetMap = list[i];
					$("ul#milestones input[name='hiddenMsId']").eq(i).val(msGetMap.MILESTONE_ID);
					$("ul#milestones textarea[name='textareaKeyMilestones']").eq(i).val(msGetMap.KEY_MILESTONE);
					$("ul#milestones input[name='textMsDueDate']").eq(i).val(msGetMap.DUE_DATE);
					$("ul#milestones input[name='textMsCloseDate']").eq(i).val(msGetMap.CLOSE_DATE);
					if(msGetMap.ACT_NAME){
						$("ul#milestones input[name='textMsMember']").eq(i).hide();
						$("ul#milestones input[name='hiddenMsMemberId']").eq(i).val(msGetMap.ACT_ID);
						$("ul#milestones input[name='hiddenMsMemberName']").eq(i).val(msGetMap.ACT_NAME);
		             	$('ul#milestones li[name="liMsMemberSeach"]').eq(i).before(
		             			'<li class="value">' +
								'<span class="txt" id="'+msGetMap.ACT_ID+'">'+msGetMap.ACT_NAME+' ['+ msGetMap.ACT_POSITION +']</span>' +
								'<a href="#" class="remove" onclick="commonSearch.removeSingleMember2(this,null);"><i class="fa fa-times-circle"></i></a></li>'
						);
	             	}else{
	             		$("ul#milestones input[name='textMsMember']").eq(i).show();
	             		$("ul#milestones input[name='hiddenMsMemberId']").eq(i).val("");
	             		$("ul#milestones input[name='hiddenMsMemberName']").eq(i).val("");
	             	}
					
					if(msGetMap.DUE_DATE == "" && msGetMap.CLOSE_DATE == ""){
						$("ul#milestones li[name='milestones_sub']").eq(i).find("div.h_line").css("border","white");
					}else{
						$("ul#milestones li[name='milestones_sub']").eq(i).find("div.h_line").css("border",milestones.statusColor(msGetMap.DUE_DATE,msGetMap.CLOSE_DATE, nowDate));
					}
				}
			},
			
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
			}
	}
</script>

			<ul id="milestones">
				<li name="milestones_sub">
					<div class="h_line"></div>
					<div class="form_input mg_b10 mg_t10">
						<label>Key Milestones - 1</label>
						<textarea class="form_control" name="textareaKeyMilestones" rows="2" multiline="true" style="min-height:50px;"></textarea>
					</div>
					
					<div class="form_input mg_b10 mg_t10">     
						<label>담당자</label>
						<div class="">
								<ul name="ulMsMultiple" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255); padding:none;">
	                                <li class="input-container flexdatalist-multiple-value pos-rel" name="liMsMemberSeach" style="width: 100%;">
	                                <input type="text" class="form-control" name="textMsMember" placeholder="검색해 주세요." autocomplete="off" style="width: 100%;" auto-bind="0">
	                                <input type="hidden" name="hiddenMsMemberId" value="">
	                                <input type="hidden" name="hiddenMsMemberName" value="">
	                            </ul>
				    	</div>
				 	</div>
				 	
					
					<div class="form_input mg_b10">
						<label>목표일</label>
						<input type="date" placeholder="ex)1988-11-18" class="form_control" name="textMsDueDate" style="text-indent:5px;"/>
					</div>
					
					<div class="form_input mg_b10">
						<label>완료일</label>
						<input type="date" placeholder="ex)1988-11-18" class="form_control" name="textMsCloseDate" style="text-indent:5px;"/>
					</div>
							
					<div class="h_line mg_b10"></div>
					<input type="hidden" name="hiddenMsId" value="">
				</li>
				<li name="milestones_sub">
					<div class="h_line"></div>
					<div class="form_input mg_b10 mg_t10">
						<label>Key Milestones - 2</label>
						<textarea class="form_control" name="textareaKeyMilestones" rows="2" multiline="true" style="min-height:50px;"></textarea>
					</div>
					
					<div class="form_input mg_b10 mg_t10">     
						<label>담당자</label>
						<div class="">
								<ul name="ulMsMultiple" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255); padding:none;">
	                                <li class="input-container flexdatalist-multiple-value pos-rel" name="liMsMemberSeach" style="width: 100%;">
	                                <input type="text" class="form-control" name="textMsMember" placeholder="검색해 주세요." autocomplete="off" style="width: 100%;" auto-bind="0">
	                                <input type="hidden" name="hiddenMsMemberId" value="">
	                                <input type="hidden" name="hiddenMsMemberName" value="">
	                            </ul>
				    	</div>
				 	</div>
				 	
					
					<div class="form_input mg_b10">
						<label>목표일</label>
						<input type="date" placeholder="ex)1988-11-18" class="form_control" name="textMsDueDate" style="text-indent:5px;"/>
					</div>
					
					<div class="form_input mg_b10">
						<label>완료일</label>
						<input type="date" placeholder="ex)1988-11-18" class="form_control" name="textMsCloseDate" style="text-indent:5px;"/>
					</div>
							
					<div class="h_line mg_b10"></div>
					<input type="hidden" name="hiddenMsId" value="">
				</li>
				<li name="milestones_sub">
					<div class="h_line"></div>
					<div class="form_input mg_b10 mg_t10">
						<label>Key Milestones - 3</label>
						<textarea class="form_control" name="textareaKeyMilestones" rows="2" multiline="true" style="min-height:50px;"></textarea>
					</div>
					
					<div class="form_input mg_b10 mg_t10">     
						<label>담당자</label>
						<div class="">
								<ul name="ulMsMultiple" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255); padding:none;">
	                                <li class="input-container flexdatalist-multiple-value pos-rel" name="liMsMemberSeach" style="width: 100%;">
	                                <input type="text" class="form-control" name="textMsMember" placeholder="검색해 주세요." autocomplete="off" style="width: 100%;" auto-bind="0">
	                                <input type="hidden" name="hiddenMsMemberId" value="">
	                                <input type="hidden" name="hiddenMsMemberName" value="">
	                            </ul>
				    	</div>
				 	</div>
				 	
					
					<div class="form_input mg_b10">
						<label>목표일</label>
						<input type="date" placeholder="ex)1988-11-18" class="form_control" name="textMsDueDate" style="text-indent:5px;"/>
					</div>
					
					<div class="form_input mg_b10">
						<label>완료일</label>
						<input type="date" placeholder="ex)1988-11-18" class="form_control" name="textMsCloseDate" style="text-indent:5px;"/>
					</div>
							
					<div class="h_line mg_b10"></div>
					<input type="hidden" name="hiddenMsId" value="">
				</li>
				<li name="milestones_sub">
					<div class="h_line"></div>
					<div class="form_input mg_b10 mg_t10">
						<label>Key Milestones - 4</label>
						<textarea class="form_control" name="textareaKeyMilestones" rows="2" multiline="true" style="min-height:50px;"></textarea>
					</div>
					
					<div class="form_input mg_b10 mg_t10">     
						<label>담당자</label>
						<div class="">
								<ul name="ulMsMultiple" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255); padding:none;">
	                                <li class="input-container flexdatalist-multiple-value pos-rel" name="liMsMemberSeach" style="width: 100%;">
	                                <input type="text" class="form-control" name="textMsMember" placeholder="검색해 주세요." autocomplete="off" style="width: 100%;" auto-bind="0">
	                                <input type="hidden" name="hiddenMsMemberId" value="">
	                                <input type="hidden" name="hiddenMsMemberName" value="">
	                            </ul>
				    	</div>
				 	</div>
				 	
					
					<div class="form_input mg_b10">
						<label>목표일</label>
						<input type="date" placeholder="ex)1988-11-18" class="form_control" name="textMsDueDate" style="text-indent:5px;"/>
					</div>
					
					<div class="form_input mg_b10">
						<label>완료일</label>
						<input type="date" placeholder="ex)1988-11-18" class="form_control" name="textMsCloseDate" style="text-indent:5px;"/>
					</div>
							
					<div class="h_line mg_b10"></div>
					<input type="hidden" name="hiddenMsId" value="">
				</li>
				<li name="milestones_sub">
					<div class="h_line"></div>
					<div class="form_input mg_b10 mg_t10">
						<label>Key Milestones - 5</label>
						<textarea class="form_control" name="textareaKeyMilestones" rows="2" multiline="true" style="min-height:50px;"></textarea>
					</div>
					
					<div class="form_input mg_b10 mg_t10">     
						<label>담당자</label>
						<div class="">
								<ul name="ulMsMultiple" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255); padding:none;">
	                                <li class="input-container flexdatalist-multiple-value pos-rel" name="liMsMemberSeach" style="width: 100%;">
	                                <input type="text" class="form-control" name="textMsMember" placeholder="검색해 주세요." autocomplete="off" style="width: 100%;" auto-bind="0">
	                                <input type="hidden" name="hiddenMsMemberId" value="">
	                                <input type="hidden" name="hiddenMsMemberName" value="">
	                            </ul>
				    	</div>
				 	</div>
					
					<div class="form_input mg_b10">
						<label>목표일</label>
						<input type="date" placeholder="ex)1988-11-18" class="form_control" name="textMsDueDate" style="text-indent:5px;"/>
					</div>
					
					<div class="form_input mg_b10">
						<label>완료일</label>
						<input type="date" placeholder="ex)1988-11-18" class="form_control" name="textMsCloseDate" style="text-indent:5px;"/>
					</div>
							
					<div class="h_line mg_b10"></div>
					<input type="hidden" name="hiddenMsId" value="">
				</li>
			</ul>
