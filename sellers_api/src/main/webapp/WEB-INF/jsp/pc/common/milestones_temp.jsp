<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(document).ready(function(){
	});
	
	var milestonesEvent = {
			on : function(){
				//목표일 완료일 status
				$("tbody#tbodyMs").on("change", "input[name='textMsDueDate']", milestonesEvent.changeMsDueDate);
				
				$("tbody#tbodyMs").on("change", "input[name='textMsCloseDate']", milestonesEvent.changeMsCloseDate); 
				//책임자 자동 완성
				$("tbody#tbodyMs").on("focus", "input[name='textMsMember']", milestonesEvent.focusMsMember);
				//enter key
				$("tbody#tbodyMs").on("keydown", "input[name='textMsDueDate'], input[name='textMsCloseDate'], input[name='textMsMember']", milestonesEvent.keydownEnterReturn);
			},
			
			off : function(){
				//목표일 완료일 status
				$("tbody#tbodyMs").off("change", "input[name='textMsDueDate']", milestonesEvent.changeMsDueDate);
				
				$("tbody#tbodyMs").off("change", "input[name='textMsCloseDate']", milestonesEvent.changeMsCloseDate); 
				//책임자 자동 완성
				$("tbody#tbodyMs").off("focus", "input[name='textMsMember']", milestonesEvent.focusMsMember);
				//enter key
				$("tbody#tbodyMs").off("keydown", "input[name='textMsDueDate'], input[name='textMsCloseDate'], input[name='textMsMember']", milestonesEvent.keydownEnterReturn);
			},
			
			changeMsDueDate : function(e){
				var due_idx = $("tbody#tbodyMs input[name='textMsDueDate']").index(this);
				var due_date = $("tbody#tbodyMs input[name='textMsDueDate']").eq(due_idx).val();
				var close_date = $("tbody#tbodyMs input[name='textMsCloseDate']").eq(due_idx).val();
				var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
				$("td[name='tdMsStatus']").eq(due_idx).css("background-color",fnStatusColor(due_date,close_date, nowDate));
			},
			
			changeMsCloseDate : function(e){
				var close_idx = $("tbody#tbodyMs input[name='textMsCloseDate']").index(this);
				var due_date = $("tbody#tbodyMs input[name='textMsDueDate']").eq(close_idx).val();
				var close_date = $("tbody#tbodyMs input[name='textMsCloseDate']").eq(close_idx).val();
				var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
				$("td[name='tdMsStatus']").eq(close_idx).css("background-color",fnStatusColor(due_date,close_date, nowDate));
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
				$("tbody#tbodyMs td[name='tdNo']").each(function(idx, val){
					var msMap = new Object();
					msMap.MILESTONE_ID = $("tbody#tbodyMs input[name='hiddenMsId']").eq(idx).val();
					msMap.KEY_MILESTONE = $("tbody#tbodyMs textarea[name='textareaKeyMilestones']").eq(idx).val();
					msMap.DUE_DATE = $("tbody#tbodyMs input[name='textMsDueDate']").eq(idx).val();
					msMap.CLOSE_DATE = $("tbody#tbodyMs input[name='textMsCloseDate']").eq(idx).val();
					msMap.ACT_ID = $("tbody#tbodyMs input[name='hiddenMsMemberId']").eq(idx).val();
					msMap.ACT_NAME = $("tbody#tbodyMs input[name='hiddenMsMemberName']").eq(idx).val()
					//msMap.HIDDEN_STATUS = $("textarea[name='textareaKeyMilestones']").eq(idx).parent("td").parent("tr").find("input[name='hiddenOckSeq']").val();
					milestones.msList.push(msMap);
				});
			},
			
			reset : function(){
				$("tbody#tbodyMs input").val("");
				$("tbody#tbodyMs textarea").val("");
				$("tbody#tbodyMs td[name='tdMsStatus']").css("background-color","white");
				$("tbody#tbodyMs input[name='textMsMember']").show();
			},
			
			draw : function(list){
				var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
				for(var i=0; i<list.length; i++){
					var msGetMap = list[i];
					$("tbody#tbodyMs input[name='hiddenMsId']").eq(i).val(msGetMap.MILESTONE_ID);
					$("tbody#tbodyMs textarea[name='textareaKeyMilestones']").eq(i).val(msGetMap.KEY_MILESTONE);
					$("tbody#tbodyMs input[name='textMsDueDate']").eq(i).val(msGetMap.DUE_DATE);
					$("tbody#tbodyMs input[name='textMsCloseDate']").eq(i).val(msGetMap.CLOSE_DATE);
					if(msGetMap.ACT_NAME){
						$("tbody#tbodyMs input[name='textMsMember']").eq(i).hide();
						$("tbody#tbodyMs input[name='hiddenMsMemberId']").eq(i).val(msGetMap.ACT_ID);
						$("tbody#tbodyMs input[name='hiddenMsMemberName']").eq(i).val(msGetMap.ACT_NAME);
		             	$('tbody#tbodyMs li[name="liMsMemberSeach"]').eq(i).before(
		             			'<li class="value">' +
								'<span class="txt" id="'+msGetMap.ACT_ID+'">'+msGetMap.ACT_NAME+' ['+ msGetMap.ACT_POSITION +']</span>' +
								'<a href="#" class="remove" onclick="commonSearch.removeSingleMember2(this,null);"><i class="fa fa-times-circle"></i></a></li>'
						);
	             	}else{
	             		$("tbody#tbodyMs input[name='textMsMember']").eq(i).show();
	             		$("tbody#tbodyMs input[name='hiddenMsMemberId']").eq(i).val("");
	             		$("tbody#tbodyMs input[name='hiddenMsMemberName']").eq(i).val("");
	             	}
					
					if(msGetMap.DUE_DATE == "" && msGetMap.CLOSE_DATE == ""){
						$("tbody#tbodyMs td[name='tdMsStatus']").eq(i).css("background-color","white");
					}else{
						$("tbody#tbodyMs td[name='tdMsStatus']").eq(i).css("background-color",fnStatusColor(msGetMap.DUE_DATE,msGetMap.CLOSE_DATE, nowDate));
					}
				}
			}
	}
</script>


			<table class="table table-bordered table-inner" style="width:815px; margin-bottom: 5px;">
				<colgroup>
					<col width="40px;">
					<col width="*">
					<col width="140px;">
					<col width="110px;">
					<col width="110px;">
					<col width="55px;">
				</colgroup>
	            <thead>
		                <tr>
		                    <th>No</th>
		                    <th>Key Milestones</th>
		                    <th>담당자</th>
		                    <th>목표일</th>
		                    <th>완료일</th>
		                    <th>Status</th>
		                </tr>
	            </thead>
              	<tbody id="tbodyMs">
              			<tr>
		                    <td name="tdNo">1</td>
                      	  	<td name="tdRowSpan"><textarea name="textareaKeyMilestones" rows="2" multiline="true" ></textarea></td>
                      		<td>
                      			<ul name="ulMsMultiple" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255); padding:none;">
	                                <li class="input-container flexdatalist-multiple-value pos-rel" name="liMsMemberSeach" style="width: 100%;">
	                                <input type="text" class="form-control" name="textMsMember" placeholder="검색해 주세요." autocomplete="off" style="width: 100%;" auto-bind="0">
	                                <input type="hidden" name="hiddenMsMemberId" value="" />
	                                <input type="hidden" name="hiddenMsMemberName" value="" />
	                                <div class="autocomplete-suggestions "></div></li>
	                            </ul>
                      		</td>
                      		<td>
	                      		<div class="data_1">
                                     <div class="input-group date">
                                         <span class="input-group-addon" style="display: none;"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" name="textMsDueDate" value="">
                                     </div>
                                 </div>
	                      	</td>
	                      	<td>
	                      		<div class="data_1">
                                     <div class="input-group date">
                                         <span class="input-group-addon" style="display: none;"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" name="textMsCloseDate" value="">
                                     </div>
                                 </div>
	                      	</td>
                      		<td name="tdMsStatus"></td>
                      		<input type="hidden" name="hiddenMsId" value="" />
                   		</tr>
                   		
                   		<tr>
		                    <td name="tdNo">2</td>
                      	  	<td name="tdRowSpan"><textarea name="textareaKeyMilestones" rows="2" multiline="true" ></textarea></td>
                      		<td>
                      			<ul name="ulMsMultiple" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255); padding:none;">
	                                <li class="input-container flexdatalist-multiple-value pos-rel" name="liMsMemberSeach" style="width: 100%;">
	                                <input type="text" class="form-control" name="textMsMember" placeholder="검색해 주세요." autocomplete="off" style="width: 100%;" auto-bind="0">
	                                <input type="hidden" name="hiddenMsMemberId" value="" />
	                                <input type="hidden" name="hiddenMsMemberName" value="" />
	                                <div class="autocomplete-suggestions "></div></li>
	                            </ul>
                      		</td>
                      		<td>
	                      		<div class="data_1">
                                     <div class="input-group date">
                                         <span class="input-group-addon" style="display: none;"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" name="textMsDueDate" value="">
                                     </div>
                                 </div>
	                      	</td>
	                      	<td>
	                      		<div class="data_1">
                                     <div class="input-group date">
                                         <span class="input-group-addon" style="display: none;"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" name="textMsCloseDate" value="">
                                     </div>
                                 </div>
	                      	</td>
                      		<td name="tdMsStatus"></td>
                      		<input type="hidden" name="hiddenMsId" value="" />
                   		</tr>
                   		
                   		<tr>
		                    <td name="tdNo">3</td>
                      	  	<td name="tdRowSpan"><textarea name="textareaKeyMilestones" rows="2" multiline="true" ></textarea></td>
                      		<td>
                      			<ul name="ulMsMultiple" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255); padding:none;">
	                                <li class="input-container flexdatalist-multiple-value pos-rel" name="liMsMemberSeach" style="width: 100%;">
	                                <input type="text" class="form-control" name="textMsMember" placeholder="검색해 주세요." autocomplete="off" style="width: 100%;" auto-bind="0">
	                                <input type="hidden" name="hiddenMsMemberId" value="" />
	                                <input type="hidden" name="hiddenMsMemberName" value="" />
	                                <div class="autocomplete-suggestions "></div></li>
	                            </ul>
                      		</td>
                      		<td>
	                      		<div class="data_1">
                                     <div class="input-group date">
                                         <span class="input-group-addon" style="display: none;"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" name="textMsDueDate" value="">
                                     </div>
                                 </div>
	                      	</td>
	                      	<td>
	                      		<div class="data_1">
                                     <div class="input-group date">
                                         <span class="input-group-addon" style="display: none;"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" name="textMsCloseDate" value="">
                                     </div>
                                 </div>
	                      	</td>
                      		<td name="tdMsStatus"></td>
                      		<input type="hidden" name="hiddenMsId" value="" />
                   		</tr>
                   		
                   		<tr>
		                    <td name="tdNo">4</td>
                      	  	<td name="tdRowSpan"><textarea name="textareaKeyMilestones" rows="2" multiline="true" ></textarea></td>
                      		<td>
                      			<ul name="ulMsMultiple" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255); padding:none;">
	                                <li class="input-container flexdatalist-multiple-value pos-rel" name="liMsMemberSeach" style="width: 100%;">
	                                <input type="text" class="form-control" name="textMsMember" placeholder="검색해 주세요." autocomplete="off" style="width: 100%;" auto-bind="0">
	                                <input type="hidden" name="hiddenMsMemberId" value="" />
	                                <input type="hidden" name="hiddenMsMemberName" value="" />
	                                <div class="autocomplete-suggestions "></div></li>
	                            </ul>
                      		</td>
                      		<td>
	                      		<div class="data_1">
                                     <div class="input-group date">
                                         <span class="input-group-addon" style="display: none;"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" name="textMsDueDate" value="">
                                     </div>
                                 </div>
	                      	</td>
	                      	<td>
	                      		<div class="data_1">
                                     <div class="input-group date">
                                         <span class="input-group-addon" style="display: none;"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" name="textMsCloseDate" value="">
                                     </div>
                                 </div>
	                      	</td>
                      		<td name="tdMsStatus"></td>
                      		<input type="hidden" name="hiddenMsId" value="" />
                   		</tr>
                   		
                   		<tr>
		                    <td name="tdNo">5</td>
                      	  	<td name="tdRowSpan"><textarea name="textareaKeyMilestones" rows="2" multiline="true" ></textarea></td>
                      		<td>
                      			<ul name="ulMsMultiple" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255); padding:none;">
	                                <li class="input-container flexdatalist-multiple-value pos-rel" name="liMsMemberSeach" style="width: 100%;">
	                                <input type="text" class="form-control" name="textMsMember" placeholder="검색해 주세요." autocomplete="off" style="width: 100%;" auto-bind="0">
	                                <input type="hidden" name="hiddenMsMemberId" value="" />
	                                <input type="hidden" name="hiddenMsMemberName" value="" />
	                                <div class="autocomplete-suggestions "></div></li>
	                            </ul>
                      		</td>
                      		<td>
	                      		<div class="data_1">
                                     <div class="input-group date">
                                         <span class="input-group-addon" style="display: none;"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" name="textMsDueDate" value="">
                                     </div>
                                 </div>
	                      	</td>
	                      	<td>
	                      		<div class="data_1">
                                     <div class="input-group date">
                                         <span class="input-group-addon" style="display: none;"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" name="textMsCloseDate" value="">
                                     </div>
                                 </div>
	                      	</td>
                      		<td name="tdMsStatus"></td>
                      		<input type="hidden" name="hiddenMsId" value="" />
                   		</tr>
				</tbody>
      		 </table>
      		 
      		 <div id="ajaxMsHtmlHidden" style="display:none;">
      		 </div>
      		 
      		 
<!-- <script type="text/javascript">
$(document).ready(function(){
	milestone.init();
});

var milestone = {
			//마일스톤 변수		
			lastEdit : 0,
			initData : [
				{ROWNUM : '1', KEY_MILESTONE : '', ACT_ID:'',ACT_DUE_DATE:null,ACT_CLOSE_DATE:null,STATUS:null},
                {ROWNUM : '2', KEY_MILESTONE : '', ACT_ID:'',ACT_DUE_DATE:null,ACT_CLOSE_DATE:null,STATUS:null},
                {ROWNUM : '3', KEY_MILESTONE : '', ACT_ID:'',ACT_DUE_DATE:null,ACT_CLOSE_DATE:null,STATUS:null},
                {ROWNUM : '4', KEY_MILESTONE : '', ACT_ID:'',ACT_DUE_DATE:null,ACT_CLOSE_DATE:null,STATUS:null},
                {ROWNUM : '5', KEY_MILESTONE : '', ACT_ID:'',ACT_DUE_DATE:null,ACT_CLOSE_DATE:null,STATUS:null}
			],
			
			//마일스톤 함수
			init : function(){
				$milestone = $("#milestone");
				milestone.draw();
			},
			
			draw : function() {
				$milestone.jqGrid({
					url : '${param.url}',
		 			mtype: 'POST',
		 			datatype : 'json',
		 			postData : {
		 				hiddenModalPK : $("#hiddenModalPK").val()
		 			},
					 jsonReader : { 
					    root: "rows",
					},  
					colModel : [ {
						label : 'No',
						name : 'ROWNUM',
						align : "center",
						width : 50
					}, {
						label : 'Key Ms',
						name : 'KEY_MILESTONE',
						align : "left",
						editable: true,
						width : 325
					}, {
						label : '책임 담당자',
						name : 'ACT_NAME',
						align : "center",
						width : 120,
						classes : "pos-rel",
						editable: true,
						editoptions: {
							  dataEvents: [
	             					{ 
	             						type: 'change', 
	             						fn: function() {
	             							milestone.changeStatus();
	             						} 
	             					}
								],
								dataInit: function (element,rwdat) {
									commonSearch.memberGrid($(element), $(element).parent('td').siblings(".hidden_act_id"));
	                            }
						}
					}, {
						label : '목표일',
						name : 'ACT_DUE_DATE',
						index : 'ACT_DUE_DATE',
						align : "center",
						editable: true,
						sorttype:"date",
						width : 135,
						editoptions: {
                            dataEvents: [
             					{ 
             						type: 'change', 
             						fn: function() {
             							milestone.changeStatus();
             						} 
             					}
							],
							
							// dataInit is the client-side event that fires upon initializing the toolbar search field for a column
                            // use it to place a third party control to customize the toolbar
                            dataInit: function (element) {
                               $(element).datepicker({
                            	   todayBtn: "linked",
                                   keyboardNavigation: false,
                                   forceParse: false,
                                   calendarWeeks: true,
                                   autoclose: true
                                }).on('hide.bs.modal', function(event) {
                            	    // prevent datepicker from firing bootstrap modal "show.bs.modal"
                            	    event.stopPropagation(); 
                            	});
                            }
                            
                      	},
					
					}, {
						label : '완료일',
						name : 'ACT_CLOSE_DATE',
						index : 'ACT_CLOSE_DATE',
						align : "center",
						editable: true,
						sorttype:"date",
						width : 135,
						editoptions: {
							  dataEvents: [
	             					{ 
	             						type: 'change', 
	             						fn: function() {
	             							milestone.changeStatus();
	             						} 
	             					}
								],
                            // dataInit is the client-side event that fires upon initializing the toolbar search field for a column
                            // use it to place a third party control to customize the toolbar
                            dataInit: function (element) {
                               $(element).datepicker({
                            	   todayBtn: "linked",
                                   keyboardNavigation: false,
                                   forceParse: false,
                                   calendarWeeks: true,
                                   autoclose: true
                               }).on('hide.bs.modal', function(event) {
                            	    // prevent datepicker from firing bootstrap modal "show.bs.modal"
                            	    event.stopPropagation(); 
                            	});
                            }
                      	}
					},{
						label : 'Status',
						name : 'STATUS',
						align : "center",
						width : 50,
						formatter: function (rowId, cellval , colpos, rwdat, _act){
							if(rwdat == "edit"){
								switch (rowId) {
								case "G":
									$milestone.setCell(cellval.rowId,"STATUS","",{"background-color": "#1ab394"});
									break;
								case "Y":
									$milestone.setCell(cellval.rowId,"STATUS","",{"background-color": "#ffc000"});
									break;
								case "R":
									$milestone.setCell(cellval.rowId,"STATUS","",{"background-color": "#f20056"});
									break;
								default:
									return "";
									break;
								}	
							}else{
								return "";
							}
						}
					}, {
						label : 'MILESTONE_ID',
						name : 'MILESTONE_ID',
						hidden : true
					}, {
						label : 'HIDDEN_STATUS',
						name : 'HIDDEN_STATUS',
						hidden : true
					}, {
						label : 'HIDDEN_ACT_ID',
						name : 'HIDDEN_ACT_ID',
						classes : "hidden_act_id",
						hidden : true
					}
					],
					height : "100%",
					shrinkToFit: true,
					onSelectRow : function(id) { //row 선택시 처리. id는 선택한 row
						$(this).jqGrid('saveRow',milestone.lastEdit,true);
						$(this).jqGrid('editRow',id,true);
						milestone.lastEdit = id;
					},
					loadBeforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
					loadComplete : function(data){
						var list = data.rows;
						if(list.length == 0){
							for(var i=0;i<=milestone.initData.length;i++){
				                //jqgrid의 addRowData를 이용하여 각각의 row에 gridData변수의 데이터를 add한다
				                $(this).jqGrid('addRowData',i+1,milestone.initData[i]);
				        	} 							
						}else{
							for(var i=0; i<list.length; i++ ){
								if(list[i].STATUS == 'G'){
									$milestone.setCell(i+1,"HIDDEN_STATUS","G");
									$milestone.setCell(i+1,"STATUS","",{"background-color": "#1ab394"});
								}else if(list[i].STATUS == 'Y'){
									$milestone.setCell(i+1,"HIDDEN_STATUS","Y");
									$milestone.setCell(i+1,"STATUS","",{"background-color": "#ffc000"});
								}else if(list[i].STATUS == 'R'){
									$milestone.setCell(i+1,"HIDDEN_STATUS","R");
									$milestone.setCell(i+1,"STATUS","",{"background-color": "#f20056"});
								}
							}
						}
					},
					loadError : function(xhr, status, err) {
						$.error(xhr, status, err);
					}
				});
			},
			
			clear : function(){
				$milestone.jqGrid('clearGridData');
			},
			
			reload : function(){
				$milestone.jqGrid(
					'setGridParam', 
					{
						url : '${param.url}',
		 				mtype: 'POST',
		 				postData : {
		 					hiddenModalPK : $("#hiddenModalPK").val()
		 				},
		 				datatype : 'json'
		 			}
				).trigger('reloadGrid');
			},
			
			saveRow : function(){
				for(var i=1; i <=5; i++){
					$milestone.jqGrid('saveRow', i);
				}
					$milestone.jqGrid('saveRow', milestone.lastEdit);
			},
			
			changeStatus : function(){
				$milestone.jqGrid('saveRow', milestone.lastEdit);
				var dueDate= ($milestone.jqGrid('getCell',milestone.lastEdit,'ACT_DUE_DATE').replaceAll("-","")).trim();
				var closeDate= ($milestone.jqGrid('getCell',milestone.lastEdit,'ACT_CLOSE_DATE').replaceAll("-","")).trim();
				var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
				
				if((dueDate >= nowDate) && closeDate == ""){
					$milestone.jqGrid('setCell', milestone.lastEdit, 'STATUS', 'Y');
					$milestone.jqGrid('setCell', milestone.lastEdit, 'HIDDEN_STATUS', 'Y');
				}else if(dueDate < nowDate && closeDate == ""){
					$milestone.jqGrid('setCell', milestone.lastEdit, 'STATUS', 'R');
					$milestone.jqGrid('setCell', milestone.lastEdit, 'HIDDEN_STATUS', 'R');
				}else if(closeDate != "" && closeDate != null){
					$milestone.jqGrid('setCell', milestone.lastEdit, 'STATUS', 'G');
					$milestone.jqGrid('setCell', milestone.lastEdit, 'HIDDEN_STATUS', 'G');
				}
				milestone.lastEdit = 0;
			}
			
}
</script> -->