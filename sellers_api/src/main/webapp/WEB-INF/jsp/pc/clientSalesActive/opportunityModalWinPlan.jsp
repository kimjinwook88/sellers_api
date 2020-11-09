<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<script type="text/javascript">
	var winPlanMasterHtml = "";
	var winPlanSubHtml = "";
	
	$(document).ready(function(){
		$.get("/ajaxHtml/opportunityWinPlanMaster.html", function(data){
			winPlanMasterHtml = data;
		}).done(function(){
			winMainAdd();
		});
		
		$.get("/ajaxHtml/opportunityWinPlanSub.html", function(data){
			winPlanSubHtml = data;
		});
	});
	
	var winPlanEvent = {
			on : function(){
				//status change event
				$("tbody#tbodyWin").on("change", "select[name='selectWinStatus']", winPlanEvent.changeWinStatus);
				//담당자 자동 완성
				$("tbody#tbodyWin").on("focus", "input[name='textWinMember']", winPlanEvent.focusWinMember);
				//enter return				
				$("tbody#tbodyWin").on("keydown", "input[name='textWinDueDate'], input[name='textWinCloseDate'], input[name='textWinMember']", winPlanEvent.keydownEnterReturn);
			},
			
			off : function(){
				//status change event
				$("tbody#tbodyWin").off("change", "select[name='selectWinStatus']", winPlanEvent.changeWinStatus);
				//담당자 자동 완성
				$("tbody#tbodyWin").off("focus", "input[name='textWinMember']", winPlanEvent.focusWinMember);
				//enter return				
				$("tbody#tbodyWin").off("keydown", "input[name='textWinDueDate'], input[name='textWinCloseDate'], input[name='textWinMember']", winPlanEvent.keydownEnterReturn);
			},
			
			changeWinStatus : function(e){
				var winStatusVal = $(this).val();
				if(winStatusVal == "G"){
					$(this).parent("td").css("background-color","#1ab394");
				}else if(winStatusVal == "Y"){
					$(this).parent("td").css("background-color","#ffc000");
				}else if(winStatusVal == "R"){
					$(this).parent("td").css("background-color","#f20056");
				}else{
					$(this).parent("td").css("background-color","none");
				}
			},
			
			focusWinMember : function(e){
				if($(this).attr("auto-bind") == "0"){
					commonSearch.singleMember2($(this),null);
					$(this).attr("auto-bind","1");
				}
			},
			
			keydownEnterReturn : function(e){
				if(e.keyCode == 13){//키가 13이면 실행 (엔터는 13)
					return false;
				}
			}
	}
	
	//윈플랜 Main 추가
	function winMainAdd(){
		$('tbody#tbodyWin').append(winPlanMasterHtml);
	}
	
	//윈플랜 Sub 추가
	function winSubAdd(obj,seq,map){
		var rowCount = $(obj).attr("rowspan");
		$(obj).parent("tr").find("td[name='tdRowSpan']").attr("rowspan",++rowCount);
		
		var opportunitySub = $("div#ajaxWinHtmlHidden").html(winPlanSubHtml).find("tr#opportunitySub_"+seq);
		$(obj).parent("tr").after("<tr>"+$(opportunitySub).html()+"</tr>");
		
		/* $.get("/ajaxHtml/opportunityWinPlanSub.html", function(data){
		}).done(function(){
			if(map){
				//winSubAdd
			}
		}); */
	}
	
	//윈플랜 삭제
	function winDel(obj){
		var winplan_id = $(obj).parent("td").parent("tr").find("input[name='hiddenWinId']").val();
		var master_check = $(obj).parent("td").parent("tr").find("td.tdWinName").attr("rowspan");
		var action_seq = $(obj).parent("td").parent("tr").find("input[name='hiddenWinSeq']").val();
		var rowCount = $("td.tdWinName").eq(action_seq-1).attr("rowspan");
		
		if(rowCount > 1 && isEmpty(master_check)){ 
			$("td.tdWinName").eq(action_seq-1).parent("tr").find("td[name='tdRowSpan']").attr("rowspan",--rowCount);
			$(obj).parent("td").parent("tr").remove();
		}
		
		/* if(rowCount > 1 && isEmpty(master_check)){ //1보다 커야함
			if(winplan_id){
				$.ajax({
					url : "/clientSalesActive/deleteSalesCycleWinPlan.do?hiddenModalPK="+$("#hiddenModalPK").val()+"&winplan_id="+winplan_id,
					datatype : 'json',
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						if (!confirm("삭제하시겠습니까?")){
							return false;
						}
	                    $.ajaxLoading();
					},
					success : function(result){
						if(result.cnt > 0){
							alert("삭제되었습니다.");
							selectWinList($("#hiddenModalPK").val());
							setTimeout(function(){
		            		compare_before = $("#formModalData").serialize();
		            		},1000);
						}else{
							alert("삭제를 실패했습니다.\n관리자에게 문의하세요.");	
						}
						//oppList.completeReload();
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			}else{
				$("td.tdWinName").eq(action_seq-1).parent("tr").find("td[name='tdRowSpan']").attr("rowspan",--rowCount);
				$(obj).parent("td").parent("tr").remove();
			}
		} */
	}
	
	//윈플랜 메인 리스트 생성
	var winListMaster = null, winListSub = null;
	function winAddListMaster(temp_flag){
		var validFlag = false;
		var tab_no = $("tbody#tbodyWin").parents('div.modaltabmenu').attr("tab-seq")-1;
		winListMaster = new Array(); 
		$("label[name='oppWinTable-error']").remove();
		
		$("tbody#tbodyWin select[name='selectWinStatus']").each(function(idx, val){
			var winMapMaster = new Object();
			//1개 이상의 status, items & fixed, 해결계획, 담당자를 입력해야함
			if(!isEmpty($("select[name='selectWinStatus']").eq(idx).val())){
				validFlag = true;
			}
			winMapMaster.STATUS = $("select[name='selectWinStatus']").eq(idx).val();
			winMapMaster.SEQ = $("select[name='selectWinStatus']").eq(idx).parent("td").parent("tr").find("input[name='hiddenWinSeq']").val();
			winMapMaster.NAME = $("td.tdWinName").eq(idx).html();
			winListMaster.push(winMapMaster);
		});
		
		if(!validFlag && !temp_flag){
			$("#oppWinTable").after('<label name="oppWinTable-error" class="error-custom" for="oppWinTable">1개 이상의 승리계획을 작성해 주세요.<br />(Status, Items to be Fixed, 해결계획, 담당자, 목표일)</label>'	);
			$("ul.tabmenu-type li a").eq(tab_no).trigger('click.modalTab');
		}
		
		return validFlag;
	}
	
	//윈플랜 서브 리스트 생성
	function winAddListSub(temp_flag){
		var validFlag = false;
		var tab_no = $("tbody#tbodyWin").parents('div.modaltabmenu').attr("tab-seq")-1;
		winListSub = new Array();
		$("label[name='oppWinTable-error']").remove();
		
		$("tbody#tbodyWin textarea[name='textareaWinSolvePlan']").each(function(idx, val){
			var winMapSub = new Object();
			
			//1개 이상의 status, items & fixed, 해결계획, 담당자를 입력해야함
			if(!isEmpty($("textarea[name='textareaWinItem']").eq(idx).val()) && !isEmpty($("textarea[name='textareaWinSolvePlan']").eq(idx).val()) && !isEmpty($("input[name='hiddenWinMemberId']").eq(idx).val())  && !isEmpty($("input[name='textWinDueDate']").eq(idx).val())){
				validFlag = true;
			}
			
			winMapSub.ITEM_2BE_FIXED = $("textarea[name='textareaWinItem']").eq(idx).val();
			winMapSub.ACTION_PLAN_NAME = $("textarea[name='textareaWinSolvePlan']").eq(idx).val();
			winMapSub.ACTION_OWNER = $("input[name='hiddenWinMemberId']").eq(idx).val();
			winMapSub.DUE_DATE = $("input[name='textWinDueDate']").eq(idx).val();
			winMapSub.CLOSE_DATE = $("input[name='textWinCloseDate']").eq(idx).val();
			winMapSub.SEQ = $("textarea[name='textareaWinSolvePlan']").eq(idx).parent("td").parent("tr").find("input[name='hiddenWinSeq']").val();
			winListSub.push(winMapSub);
		});
		
		if(!validFlag && !temp_flag){
			$("#oppWinTable").after('<label name="oppWinTable-error" class="error-custom" for="oppCheckTable">1개 이상의 승리계획을 작성해 주세요.<br />(Status, Items to be Fixed, 해결계획, 담당자, 목표일)</label>'	);
			$("ul.tabmenu-type li a").eq(tab_no).trigger('click.modalTab');
		}
		
		return validFlag;
	}
	
	function winReset(){
		$("label[name='oppWinTable-error']").remove();
		$("tbody#tbodyWin tr").remove();
	}
	
	function selectWinList(list){
		winReset();
		winMainAdd();
		if(list.length > 0){
			for(var i=0; i<list.length; i++){
				var map = list[i];
				if(map.RANK == 1){ //main
					$("tbody#tbodyWin select[name='selectWinStatus']").eq(map.CHECKLIST_SEQ-1).val(map.STATUS);
					$("tbody#tbodyWin input[name='hiddenMainWinId']").eq(map.CHECKLIST_SEQ-1).val(map.CHECKLIST_ID);
					$("tbody#tbodyWin select[name='selectWinStatus']").eq(map.CHECKLIST_SEQ-1).trigger("change");
				}else{ 
					//sub 생성만..
					winSubAdd($("tbody#tbodyWin td.tdWinAddObj").eq(map.CHECKLIST_SEQ-1),map.CHECKLIST_SEQ,map);
				}
			}
				
			//sub 값 입력
			for(var i=0; i<list.length; i++){
				var map = list[i];
				$("tbody#tbodyWin textarea[name='textareaWinItem']").eq(i).val(map.ITEM_2BE_FIXED);
				$("tbody#tbodyWin textarea[name='textareaWinSolvePlan']").eq(i).val(map.ACTION_PLAN_NAME);
				$("tbody#tbodyWin input[name='textWinDueDate']").eq(i).val(map.DUE_DATE);
				$("tbody#tbodyWin input[name='textWinCloseDate']").eq(i).val(map.CLOSE_DATE);
				$("tbody#tbodyWin input[name='hiddenWinId']").eq(i).val(map.WINPLAN_ID);
				
				if(map.ACTION_OWNER_NAME){
					$("tbody#tbodyWin input[name='textWinMember']").eq(i).hide();
					$("tbody#tbodyWin input[name='hiddenWinMemberId']").eq(i).val(map.ACTION_OWNER);
					$("li[name='liWinMemberSeach']").eq(i).before(
							'<li class="value">'+
							'<span class="txt" id="'+ map.ACTION_OWNER +'">'+ map.ACTION_OWNER_NAME +' ['+ map.ACTION_OWNER_POSITION +']</span>'+
							'<a href="#" class="remove" onclick="commonSearch.removeSingleMember2(this,null);">'+
							'<i class="fa fa-times-circle"></i></a>'+
							'</li>'
					);
				}else{
					$("tbody#tbodyWin input[name='textWinMember']").eq(i).show();
					$("tbody#tbodyWin input[name='hiddenWinMemberId']").eq(i).val("");
				}
			}
		}
	}
	
	//윈플랜 가져와서 생성
	function ajaxtWinList(pkNo){
		winReset();
		winMainAdd();
		$.ajax({
			url : "/clientSalesActive/gridSalesCycleWinPlan.do",
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
					setTimeout(function(){
						for(var i=0; i<list.length; i++){
							var map = list[i];
							if(map.RANK == 1){ //main
								$("tbody#tbodyWin select[name='selectWinStatus']").eq(map.CHECKLIST_SEQ-1).val(map.STATUS);
								$("tbody#tbodyWin input[name='hiddenMainWinId']").eq(map.CHECKLIST_SEQ-1).val(map.CHECKLIST_ID);
								$("tbody#tbodyWin select[name='selectWinStatus']").eq(map.CHECKLIST_SEQ-1).trigger("change");
							}else{ 
								//sub 생성만..
								winSubAdd($("tbody#tbodyWin td.tdWinAddObj").eq(map.CHECKLIST_SEQ-1),map.CHECKLIST_SEQ,map);
							}
						}
						
						//sub 값 입력
						setTimeout(function(){
							for(var i=0; i<list.length; i++){
								var map = list[i];
								$("tbody#tbodyWin textarea[name='textareaWinItem']").eq(i).val(map.ITEM_2BE_FIXED);
								$("tbody#tbodyWin textarea[name='textareaWinSolvePlan']").eq(i).val(map.ACTION_PLAN_NAME);
								$("tbody#tbodyWin input[name='textWinDueDate']").eq(i).val(map.DUE_DATE);
								$("tbody#tbodyWin input[name='textWinCloseDate']").eq(i).val(map.CLOSE_DATE);
								$("tbody#tbodyWin input[name='hiddenWinId']").eq(i).val(map.WINPLAN_ID);
								
								if(map.ACTION_OWNER_NAME){
									$("tbody#tbodyWin input[name='textWinMember']").eq(i).hide();
									$("tbody#tbodyWin input[name='hiddenWinMemberId']").eq(i).val(map.ACTION_OWNER);
									$("li[name='liWinMemberSeach']").eq(i).before(
											'<li class="value">'+
											'<span class="txt" id="'+ map.ACTION_OWNER +'">'+ map.ACTION_OWNER_NAME +' ['+ map.ACTION_OWNER_POSITION +']</span>'+
											'<a href="#" class="remove" onclick="commonSearch.removeSingleMember2(this,null);">'+
											'<i class="fa fa-times-circle"></i></a>'+
											'</li>'
									);
								}else{
									$("tbody#tbodyWin input[name='textWinMember']").eq(i).show();
									$("tbody#tbodyWin input[name='hiddenWinMemberId']").eq(i).val("");
								}
							}
						},400);
						
					},500);
				}
			},
			complete: function(data){
			},
			error: function(xhr, status, err) {
			}
		});
	}
	
	
</script>


			<table id="oppWinTable" class="table table-bordered table-inner" style="width:815px; margin-bottom: 5px;">
				<colgroup>
					<col width="37px;">
					<col width="78px;">
					<col width="60px;">
					<col width="140px;">
					<col width="*">
					<col width="135px;">
					<col width="95px;">
					<col width="95px;">
					<col width="38px;">
				</colgroup>
	            <thead>
	            		<tr>
	            			<th rowspan="2">추가</th>
		                    <th rowspan="2">이슈영역</th>
		                    <th rowspan="2">Status</th>
		                    <th colspan="6">액션플랜(Action Plan)</th>
		                </tr>
		                <tr>
		                	<th>Items to be Fixed</th>
		                    <th>해결계획(상세)</th>
		                    <th>담당자</th>
		                    <th>목표일</th>
		                    <th>완료일</th>
		                    <th>삭제</th>
		                </tr>
	            </thead>
              	<tbody id="tbodyWin">
				</tbody>
      		 </table>
      		 
      		 <div id="ajaxWinHtmlHidden" style="display:none;">
      		 </div>
      		 


<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<table id="oppWinPlan"></table>
<!-- <div style="text-align: center;" name="insertAfterMsg"><strong>신규등록 후 입력 가능합니다.</strong></div> -->

<script type="text/javascript">
var winPlanFlag = true;
var win_rowspan_1 = 1;
var win_rowspan_2 = 1;
var win_rowspan_3 = 1;
var win_rowspan_4 = 1;
var lastEditRowWinPlan;

var oppWinPlan = {
		initData :  [
			{ADD : null, CHECKLIST_SEQ : 1, CHECKLIST_ID : null, STATUS : "", ITEM_2BE_FIXED : null, ACTION_PLAN_NAME : null, SOLVE_OWNER_ID : null, ACTION_OWNER : null, DUE_DATE : null, CLOSE_DATE : null, DEL : null},
			{ADD : null, CHECKLIST_SEQ : 2, CHECKLIST_ID : null, STATUS : "", ITEM_2BE_FIXED : null, ACTION_PLAN_NAME : null, SOLVE_OWNER_ID : null, ACTION_OWNER : null, DUE_DATE : null, CLOSE_DATE : null, DEL : null},
			{ADD : null, CHECKLIST_SEQ : 3, CHECKLIST_ID : null, STATUS : "", ITEM_2BE_FIXED : null, ACTION_PLAN_NAME : null, SOLVE_OWNER_ID : null, ACTION_OWNER : null, DUE_DATE : null, CLOSE_DATE : null, DEL : null},
			{ADD : null, CHECKLIST_SEQ : 4, CHECKLIST_ID : null, STATUS : "", ITEM_2BE_FIXED : null, ACTION_PLAN_NAME : null, SOLVE_OWNER_ID : null, ACTION_OWNER : null, DUE_DATE : null, CLOSE_DATE : null, DEL : null}
		],		
		draw : function(){
			$("#oppWinPlan").jqGrid({
	 			url : "/clientSalesActive/gridSalesCycleWinPlan.do",
	 			mtype: 'POST',
	 			postData : {
	 				hiddenModalPK : $("#hiddenModalPK").val()
	 			},
	 			datatype : 'json',
	 			 jsonReader : { 
					    root: "rows"
				},
				colModel : [ 
				{
					label : '추가',
					name : 'ADD',
					align : "center",
					width : 40,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						return "<a href='javascript:void(0);' onClick='oppWinPlan.addRowWinPlan("+colpos.CHECKLIST_SEQ+",\""+colpos.STATUS+"\",\""+cellval.rowId+"\",\""+colpos.CHECKLIST_ID+"\");'><i class='fa fa-plus-square-o fa-lg'></i></a>"; 
					},
					cellattr : winPlanCellAttr
				},{
					label : '이슈영역',
					name : 'CHECKLIST_SEQ',
					align : "center",
					width : 80,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						var returnValue;
						switch (colpos.CHECKLIST_SEQ) {
							case 1:
								returnValue = "일정";
								break;
							case 2:
								returnValue = "경쟁";
								break;
							case 3:
								returnValue = "솔루션";
								break;
							case 4:
								returnValue = "계약";
								break;
						}
						return returnValue;
					},
					cellattr : winPlanCellAttr
				},{
					label : 'Status',
					name : 'STATUS',
					align : "center",
					width : 70,
					editable: true, 
					edittype:"select", 
					formatter:'select',
					editoptions:{
  						value:":-;G:Green;Y:Yellow;R:Red", //대소문자 유의!
  						dataEvents:[{
  		                    type:'change',
  		                    fn:function(e) {
  		                    	var rowId = $("#oppWinPlan")[0].p.selrow;
  		                    	jqGridCellStatus($("#oppWinPlan"), $(this).val(), rowId);
  		                    },
  		                }]
  					},
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						var rowData = $(this).jqGrid("getRowData",cellval.rowId);
						switch (rowId) {
							case "Green":
								$("#oppWinPlan").setCell(cellval.rowId,"HIDDEN_STATUS","G");
								$("#oppWinPlan").setCell(cellval.rowId,"STATUS","",{"background-color": "#1ab394"});
								return "";
								break;
							case "Yellow":
								$("#oppWinPlan").setCell(cellval.rowId,"HIDDEN_STATUS","Y");
								$("#oppWinPlan").setCell(cellval.rowId,"STATUS","",{"background-color": "#ffc000"});
								return "";
								break;
							case "Red":
								$("#oppWinPlan").setCell(cellval.rowId,"HIDDEN_STATUS","R");
								$("#oppWinPlan").setCell(cellval.rowId,"STATUS","",{"background-color": "#f20056"});
								return "";
								break;
							default:
								$("#oppWinPlan").setCell(cellval.rowId,"HIDDEN_STATUS",null);
								$("#oppWinPlan").setCell(cellval.rowId,"STATUS","",{"background-color": ""});
								return "-";
								break;
						}	
					},
					cellattr : winPlanCellAttr
				}/* ,{
					label : 'OO 의견',
					name : 'MEMO',
					align : "center",
					width : 120,
					editable: true,
					edittype:'textarea',
					cellattr : winPlanCellAttr
				} */
				,{
					label : 'Items to be Fixed',
					name : 'ITEM_2BE_FIXED',
					align : "left",
					width : 145,
					edittype:'textarea',
					editable: true
				}, {
					label : '해결계획(상세)',
					name : 'ACTION_PLAN_NAME',
					align : "left",
					width : 175,
					edittype:'textarea',
					editable: true
				}, {
					label : 'SOLVE_OWNER_ID',
					name : 'SOLVE_OWNER_ID',
					classes : 'hidden_act_id',
					hidden : true
				}, {
					label : '담당자',
					name : 'ACTION_OWNER',
					align : "center",
					width : 90,
					classes : "grid pos-rel",
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
				},{
					label : '목표일',
					name : 'DUE_DATE',
					align : "center",
					width : 85,
					editable: true,
					editoptions: {
						dataEvents: [
		             					{ 
		             						type: 'change', 
		             						fn: function() {
		             							//oppWinPlan.changeStatusWinPlan();
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
                               autoclose: true,
                            }).on('hide.bs.modal', function(event) {
                        	    // prevent datepicker from firing bootstrap modal "show.bs.modal"
                        	    event.stopPropagation(); 
                        	});
                        	//.datepicker("setDate", new Date());
                        }
                  	}
				},{
					label : '완료일',
					name : 'CLOSE_DATE',
					align : "center",
					width : 85,
					editable: true,
					editoptions: {
						 dataEvents: [
		             					{ 
		             						type: 'change', 
		             						fn: function() {
		             							//oppWinPlan.changeStatusWinPlan();
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
					label : '삭제',
					name : 'DEL',
					align : "center",
					width : 40,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						return "<a href='javascript:void(0);' onClick='oppWinPlan.deleteWinPlan("+colpos.WINPLAN_ID+","+colpos.CHECKLIST_SEQ+",\""+colpos.STATUS+"\",\""+cellval.rowId+"\",\""+colpos.DELNO+"\",this);'><i class='fa fa-trash-o fa-lg'></i></a>";
					}
				},{
					label : 'WINPLAN_ID',
					name : 'WINPLAN_ID',
					hidden : true
				},{
					label : 'OPPORTUNITY_ID',
					name : 'OPPORTUNITY_ID',
					hidden : true
				}, {
					label : 'CHECKLIST_ID',
					name : 'CHECKLIST_ID',
					hidden : true
				}, {
					label : 'CHECKLIST_SEQ',
					name : 'CHECKLIST_SEQ',
					hidden : true
				}, {
					label : 'HIDDEN_STATUS',
					name : 'HIDDEN_STATUS',
					hidden : true
				}
				],
				height : "100%",
				editurl: 'clientArray',
				//sortable:true, 컬럼 위치 마우스 드래그로 바꾸는건데 버그있는듯? 확인 필요
				onCellSelect : function(id) {
					var rowData = $(this).jqGrid("getRowData",id);
					//if(id && lastEditRowWinPlan != id){
						$(this).jqGrid('saveRow',lastEditRowWinPlan,true);
						$(this).jqGrid('editRow',id,true);
						lastEditRowWinPlan = id;
					//}
					if(rowData.HIDDEN_STATUS){
						$("select#"+id+"_STATUS").val(rowData.HIDDEN_STATUS);
					} 
				},
				loadBeforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				loadComplete : function(data){
					var list = data.rows;
					if(list.length == 0){
						for(var i=0;i<=oppWinPlan.initData.length;i++){
			                //jqgrid의 addRowData를 이용하여 각각의 row에 gridData변수의 데이터를 add한다
			                $("#oppWinPlan").jqGrid('addRowData',i+1,oppWinPlan.initData[i]);
			        	} 			
					}else{
						for(var i=0; i<list.length; i++ ){
							if(list[i].STATUS == 'G'){
								$("#oppWinPlan").setCell(i+1,"STATUS","Green",{"background-color": "#1ab394"});
							}else if(list[i].STATUS == 'Y'){
								$("#oppWinPlan").setCell(i+1,"STATUS","Yellow",{"background-color": "#ffc000"});
							}else if(list[i].STATUS == 'R'){
								$("#oppWinPlan").setCell(i+1,"STATUS","Red",{"background-color": "#f20056"});
							}else{
								$("#oppWinPlan").setCell(i+1,"STATUS","-");
							}
						}
					}
				},
				loadError : function(xhr, status, err) {
					$.error(xhr, status, err);
				}
			})
			
			if(winPlanFlag){
				$("#oppWinPlan").jqGrid('setGroupHeaders', {
					  useColSpanStyle: true, 
					  groupHeaders:[
						          	{startColumnName: 'ITEM_2BE_FIXED', numberOfColumns: 5, titleText: '윈플랜(How to Fix)'},
					  ]
				});
				winPlanFlag = false;
			}
		},
		
		addRowWinPlan :  function(seq,status,rownum,checklist_id){
			var rowspanCount;
			switch (seq) {
				case 1:
					win_rowspan_1++;
					rowspanCount = win_rowspan_1; 
					break;
				case 2:
					win_rowspan_2++;
					rowspanCount = win_rowspan_2;
					break;
				case 3:
					win_rowspan_3++;
					rowspanCount = win_rowspan_3;
					break;
				case 4:
					win_rowspan_4++;
					rowspanCount = win_rowspan_4;
					break;
			}
			
			
			oppWinPlan.saveRow();
			
			$("#oppWinPlan").jqGrid('addRowData',"",[{/* CHECKLIST_SEQ:seq, HIDDEN_STATUS:status, CHECKLIST_ID:checklist_id, */DELNO : rownum, CHECKLIST_SEQ:seq, CHECKLIST_ID:checklist_id, attr:{STATUS: {display: 'none'}, ADD :{display: 'none'}}}],"after",rownum);
			$("#oppWinPlan").jqGrid("setCell", rownum, "STATUS", "", "", {rowspan: rowspanCount});
			//$("#oppWinPlan").jqGrid("setCell", rownum, "MEMO", "", "", {rowspan: rowspanCount});
			$("#oppWinPlan").jqGrid("setCell", rownum, "ADD", "", "", {rowspan: rowspanCount});
			$("#oppWinPlan").jqGrid("setCell", rownum, "CHECKLIST_SEQ", "", "", {rowspan: rowspanCount});
			$("#oppWinPlan").jqGrid("setCell", rownum, "CHECKLIST_ID", "", "", {rowspan: rowspanCount});
			$("#oppWinPlan").jqGrid("setCell", rownum, "DELNO", "", "", {rowspan: rowspanCount});
			
			lastEditRowWinPlan = 0;
		},
		
		delRowWinPlan :  function(seq,status,rownum,delno){
			var rowspanCount;
			switch (seq) {
				case 1:
					win_rowspan_1--;
					rowspanCount = win_rowspan_1; 
					break;
				case 2:
					win_rowspan_2--;
					rowspanCount = win_rowspan_2;
					break;
				case 3:
					win_rowspan_3--;
					rowspanCount = win_rowspan_3;
					break;
				case 4:
					win_rowspan_4--;
					rowspanCount = win_rowspan_4;
					break;
			}
			
			$("#oppWinPlan").jqGrid('delRowData', rownum);
			$("#oppWinPlan").jqGrid("setCell", delno, "STATUS", "", "", {rowspan: rowspanCount});
			//$("#oppWinPlan").jqGrid("setCell", delno, "MEMO", "", "", {rowspan: rowspanCount});
			$("#oppWinPlan").jqGrid("setCell", delno, "ADD", "", "", {rowspan: rowspanCount});
			$("#oppWinPlan").jqGrid("setCell", delno, "CHECKLIST_SEQ", "", "", {rowspan: rowspanCount});
			$("#oppWinPlan").jqGrid("setCell", delno, "CHECKLIST_ID", "", "", {rowspan: rowspanCount});
			$("#oppWinPlan").jqGrid("setCell", delno, "DELNO", "", "", {rowspan: rowspanCount});
		},
		
		deleteWinPlan : function(winplan_id,seq,status,rownum,delno,obj){
			var title = $(obj).parent().siblings("td[aria-describedby='oppWinPlan_CHECKLIST_SEQ']").attr("title");
			var t_len = $("td[aria-describedby='oppWinPlan_CHECKLIST_SEQ'][title="+title+"]").length;
			//그리드로 추가한것은 그냥 삭제~
			if(rownum.indexOf("jqg") != -1){
				oppWinPlan.delRowWinPlan(seq,status,rownum,delno);
				return;
			}
			//winplan_id가 있을경우만 and 1개 이상일경우에만 db삭제 
			if(winplan_id && t_len >  1){
				$.ajax({
					url : "/clientSalesActive/deleteSalesCycleWinPlan.do?hiddenModalPK="+$("#hiddenModalPK").val()+"&winplan_id="+winplan_id,
					datatype : 'json',
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						if (!confirm("삭제하시겠습니까?")){
							lastEditRowWinPlan = 0;
							return false;
						}
	                    $.ajaxLoading();
					},
					success : function(result){
						if(result.cnt > 0){
							alert("삭제되었습니다.");
						}else{
							alert("삭제를 실패했습니다.\n관리자에게 문의하세요.");	
						}
						lastEditRowWinPlan = 0;
						oppWinPlan.reload();
						oppList.completeReload();
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			}
		},
		
		reload : function(){
			$("#oppWinPlan").jqGrid(
				'setGridParam', 
				{
					url : "/clientSalesActive/gridSalesCycleWinPlan.do",
	 				mtype: 'POST',
	 				postData : {
	 					hiddenModalPK : $("#hiddenModalPK").val()
	 				},
	 				datatype : 'json'
	 			}
			).trigger('reloadGrid');
		},
		
		clear : function(){
			$("#oppWinPlan").jqGrid('clearGridData');
			win_rowspan_1 = 1;
			win_rowspan_2 = 1;
			win_rowspan_3 = 1;
			win_rowspan_4 = 1;
			lastEditRowWinPlan = 0;
		},
		
		saveRow : function(){
			var gridLength = $("#oppWinPlan").jqGrid('getGridParam', 'records');
			for(var i=1; i<=gridLength; i++){
				$("#oppWinPlan").jqGrid('saveRow', i);
			}
				$("#oppWinPlan").jqGrid('saveRow', lastEditRowWinPlan);
		}
}

function winPlanCellAttr(rowId, val, rawObject, cm) {
	if(!rawObject.CHECKLIST_ID){
		return false;	
	}
	var result;
	var attr = rawObject.attr;
	var seq = rawObject.CHECKLIST_SEQ;
	if(rawObject.attr[cm.name]){
		var attr = rawObject.attr[cm.name];
	    if (attr.rowspan) {
	        result = ' rowspan=' + '"' + attr.rowspan + '"';
	    } else if (attr.display) {
	        result = ' style="display:' + attr.display + '"';
	    }
	}else{
		if(attr > 0){
			switch (seq) {
			case 1:
				win_rowspan_1 = attr;
				break;
			case 2:
				win_rowspan_2 = attr;
				break;
			case 3:
				win_rowspan_3 = attr;
				break;
			case 4:
				win_rowspan_4 = attr;
				break;
			}
			result = ' rowspan=' + '"' + attr + '"';
		}else{
			result = 'style="display: none";';
		}
	}
    return result;
}

function jqGridCellStatus(g_obj, s_val, rowId){ //grid obj, stuats value, rowid
	switch(s_val){
		case "G":
			g_obj.setCell(rowId,"HIDDEN_STATUS","G");
			g_obj.setCell(rowId,"STATUS","",{"background-color": "#1ab394"});	
			break;
		case "Y":
			g_obj.setCell(rowId,"HIDDEN_STATUS","Y");
			g_obj.setCell(rowId,"STATUS","",{"background-color": "#ffc000"});
			break;
		case "R":
			g_obj.setCell(rowId,"HIDDEN_STATUS","R");
			g_obj.setCell(rowId,"STATUS","",{"background-color": "#f20056"});
			break;
		default:
			g_obj.setCell(rowId,"HIDDEN_STATUS",null);
			g_obj.setCell(rowId,"STATUS","",{"background-color": ""});
			break;
	}
}
</script>

 --%>