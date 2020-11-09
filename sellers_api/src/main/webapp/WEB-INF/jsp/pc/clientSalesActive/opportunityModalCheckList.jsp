<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">

	$(document).ready(function(){
		//status change event
		$("tbody#tbodyOck").on("change", "select[name='selectOckStatus']", function(){
			var ockStatusVal = $(this).val();
			if(ockStatusVal == "G"){
				$(this).parent("td").css("background-color","#1ab394");
			}else if(ockStatusVal == "Y"){
				$(this).parent("td").css("background-color","#ffc000");
			}else if(ockStatusVal == "R"){
				$(this).parent("td").css("background-color","#f20056");
			}else{
				$(this).parent("td").css("background-color","none");
			}
		});
		
		//담당자 자동 완성
		$("tbody#tbodyOck").on("focus", "input[name='textOckMember']", function(e){
			if($(this).attr("auto-bind") == "0"){
				commonSearch.singleMember2($(this),null);
				$(this).attr("auto-bind","1");
			}
		});
		
		$("tbody#tbodyOck").on("keydown", "input[name='textOckDueDate'], input[name='textOckCloseDate'], input[name='textOckMember']", function(e){
			if(e.keyCode == 13){//키가 13이면 실행 (엔터는 13)
				return false;
	   	  	}
		});
		
	});
	
	
	//체크리스트 Main 추가
	function ockMainAdd(){
		$.get("/ajaxHtml/opportunityCheckListMaster.html", function(data){
		    $('tbody#tbodyOck').append(data);
		});
	}
	
	//체크리스트 Sub 추가
	function ockSubAdd(obj,seq,map){
		var rowCount = $(obj).attr("rowspan");
		$(obj).parent("tr").find("td[name='tdRowSpan']").attr("rowspan",++rowCount);
		$.get("/ajaxHtml/opportunityCheckListSub.html", function(data){
			var opportunitySub = $("div#ajaxOckHtmlHidden").html(data).find("tr#opportunitySub_"+seq);
			$(obj).parent("tr").after("<tr>"+$(opportunitySub).html()+"</tr>");
		}).done(function(){
			if(map){
				//ockSubAdd
			}
		});
	}
	
	//체크리스트 삭제
	function ockDel(obj){
		var action_id = $(obj).parent("td").parent("tr").find("input[name='hiddenOckId']").val();
		var master_check = $(obj).parent("td").parent("tr").find("td.tdOckName").attr("rowspan");
		var action_seq = $(obj).parent("td").parent("tr").find("input[name='hiddenOckSeq']").val();
		var rowCount = $("td.tdOckName").eq(action_seq-1).attr("rowspan");
		
		if(rowCount > 1 && isEmpty(master_check)){ //1보다 커야함
			if(action_id){
				$.ajax({
					url : "/clientSalesActive/deleteSalesCycleActionPlan.do?hiddenModalPK="+$("#hiddenModalPK").val()+"&actionId="+action_id,
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
							selectOckList($("#hiddenModalPK").val());
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
				$("td.tdOckName").eq(action_seq-1).parent("tr").find("td[name='tdRowSpan']").attr("rowspan",--rowCount);
				$(obj).parent("td").parent("tr").remove();
			}
			
		}
	}
	
	//체크리스트 메인 리스트 생성
	var ockListMaster = null, ockListSub = null;
	function ockAddListMaster(){
		var validFlag = false;
		ockListMaster = new Array(); 
		$("tbody#tbodyOck select[name='selectOckStatus']").each(function(idx, val){
			var ockMapMaster = new Object();
			//1개 이상의 status, 의견을 입력해야함			
			if(!isEmpty($("textarea[name='textareaOckMemo']").eq(idx).val()) && !isEmpty($("select[name='selectOckStatus']").eq(idx).val())){
				validFlag = true;
			}
			ockMapMaster.MEMO = $("textarea[name='textareaOckMemo']").eq(idx).val();
			ockMapMaster.STATUS = $("select[name='selectOckStatus']").eq(idx).val();
			ockMapMaster.SEQ = $("textarea[name='textareaOckMemo']").eq(idx).parent("td").parent("tr").find("input[name='hiddenOckSeq']").val();
			ockMapMaster.NAME = $("td.tdOckName").eq(idx).html();
			ockListMaster.push(ockMapMaster);
		});
		if(!validFlag){
			$("label#oppCheckTable-error").remove();
			$("#oppCheckTable").after('<label id="oppCheckTable-error" class="error-custom" for="oppCheckTable">1개 이상의 체크리스트를 작성해 주세요.<br />(Status, 의견, 해결계획, 담당자)</label>'	);
			$("ul.tabmenu-type li a").eq(3).trigger('click.modalTab');
		}
		return validFlag;
	}
	
	//체크리스트 서브 리스트 생성
	function ockAddListSub(){
		var validFlag = false;
		ockListSub = new Array(); 
		$("tbody#tbodyOck textarea[name='textareaOckSolvePlan']").each(function(idx, val){
			var ockMapSub = new Object();
			if(!isEmpty($("textarea[name='textareaOckSolvePlan']").eq(idx).val()) && !isEmpty($("input[name='hiddenOckMemberId']").eq(idx).val())){
				validFlag = true;
			}
			ockMapSub.ACTION_PLAN_NAME = $("textarea[name='textareaOckSolvePlan']").eq(idx).val();
			ockMapSub.ACTION_OWNER = $("input[name='hiddenOckMemberId']").eq(idx).val();
			ockMapSub.DUE_DATE = $("input[name='textOckDueDate']").eq(idx).val();
			ockMapSub.CLOSE_DATE = $("input[name='textOckCloseDate']").eq(idx).val();
			ockMapSub.SEQ = $("textarea[name='textareaOckSolvePlan']").eq(idx).parent("td").parent("tr").find("input[name='hiddenOckSeq']").val();
			ockListSub.push(ockMapSub);
		});
		if(!validFlag){
			$("label#oppCheckTable-error").remove();
			$("#oppCheckTable").after('<label id="oppCheckTable-error" class="error-custom" for="oppCheckTable">1개 이상의 체크리스트를 작성해 주세요.<br />(Status, 의견, 해결계획, 담당자)</label>'	);
			$("ul.tabmenu-type li a").eq(3).trigger('click.modalTab');
		}
		return validFlag;
	}
	
	function ockReset(){
		$("label#oppCheckTable-error").remove();
		$("tbody#tbodyOck tr").remove();
	}
	
	//체크리스트 가져와서 생성
	function selectOckList(pkNo){
		ockReset();
		ockMainAdd();
		$.ajax({
			url : "/clientSalesActive/gridOpportunityCheckList.do",
			datatype : 'json',
			async : false,
			data : {
				hiddenModalPK : pkNo
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
								$("tbody#tbodyOck select[name='selectOckStatus']").eq(map.CHECKLIST_SEQ-1).val(map.STATUS);
								$("tbody#tbodyOck textarea[name='textareaOckMemo']").eq(map.CHECKLIST_SEQ-1).val(map.MEMO);
								$("tbody#tbodyOck input[name='hiddenMainOckId']").eq(map.CHECKLIST_SEQ-1).val(map.CHECKLIST_ID);
								$("tbody#tbodyOck select[name='selectOckStatus']").eq(map.CHECKLIST_SEQ-1).trigger("change");
							}else{ 
								//sub 생성만..
								ockSubAdd($("tbody#tbodyOck td.tdOckAddObj").eq(map.CHECKLIST_SEQ-1),map.CHECKLIST_SEQ,map);
							}
						}
						
						//sub 값 입력
						setTimeout(function(){
							for(var i=0; i<list.length; i++){
								var map = list[i];
								$("tbody#tbodyOck textarea[name='textareaOckSolvePlan']").eq(i).val(map.ACTION_PLAN_NAME);
								$("tbody#tbodyOck input[name='textOckDueDate']").eq(i).val(map.DUE_DATE);
								$("tbody#tbodyOck input[name='textOckCloseDate']").eq(i).val(map.CLOSE_DATE);
								$("tbody#tbodyOck input[name='hiddenOckId']").eq(i).val(map.ACTION_ID);
								
								if(map.ACTION_OWNER_NAME){
									$("tbody#tbodyOck input[name='textOckMember']").eq(i).hide();
									$("tbody#tbodyOck input[name='hiddenOckMemberId']").eq(i).val(map.ACTION_OWNER);
									$("li[name='liOckMemberSeach']").eq(i).before(
											'<li class="value">'+
											'<span class="txt" id="'+ map.ACTION_OWNER +'">'+ map.ACTION_OWNER_NAME +' ['+ map.ACTION_OWNER_POSITION +']</span>'+
											'<a href="#" class="remove" onclick="commonSearch.removeSingleMember2(this,null);">'+
											'<i class="fa fa-times-circle"></i></a>'+
											'</li>'
									);
								}else{
									$("tbody#tbodyOck input[name='textOckMember']").eq(i).show();
									$("tbody#tbodyOck input[name='hiddenOckMemberId']").eq(i).val("");
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


			<table id="oppCheckTable" class="table table-bordered table-inner" style="width:815px; margin-bottom: 5px;">
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
		                    <th rowspan="2">체크리스트</th>
		                    <th rowspan="2">Status</th>
		                    <th rowspan="2">의견</th>
		                    <th colspan="5">액션플랜(Action Plan)</th>
		                </tr>
		                <tr>
		                    <th>해결계획(상세)</th>
		                    <th>담당자</th>
		                    <th>목표일</th>
		                    <th>완료일</th>
		                    <th>삭제</th>
		                </tr>
	            </thead>
              	<tbody id="tbodyOck">
				</tbody>
      		 </table>
      		 
      		 <div id="ajaxOckHtmlHidden" style="display:none;">
      		 </div>
      		 
<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<table id="oppCheckList"></table>
<!-- <div style="text-align: center;" name="insertAfterMsg"><strong>신규등록 후 입력 가능합니다.</strong></div> -->

<script type="text/javascript">
var checkListFlag = true;
var cl_rowspan_1 = 1;
var cl_rowspan_2 = 1;
var cl_rowspan_3 = 1;
var cl_rowspan_4 = 1;
var lastEditRowCheckList;

var oppCheckList = {
		initData :  [
			{ADD : null, CHECKLIST_SEQ : 1, CHECKLIST_ID : null, STATUS : "", MEMO : null, ACTION_PLAN_NAME : null, SOLVE_OWNER_ID : null, ACTION_OWNER : null, DUE_DATE : null, CLOSE_DATE : null, DEL : null},
			{ADD : null, CHECKLIST_SEQ : 2, CHECKLIST_ID : null, STATUS : "", MEMO : null, ACTION_PLAN_NAME : null, SOLVE_OWNER_ID : null, ACTION_OWNER : null, DUE_DATE : null, CLOSE_DATE : null, DEL : null},
			{ADD : null, CHECKLIST_SEQ : 3, CHECKLIST_ID : null, STATUS : "", MEMO : null, ACTION_PLAN_NAME : null, SOLVE_OWNER_ID : null, ACTION_OWNER : null, DUE_DATE : null, CLOSE_DATE : null, DEL : null},
			{ADD : null, CHECKLIST_SEQ : 4, CHECKLIST_ID : null, STATUS : "", MEMO : null, ACTION_PLAN_NAME : null, SOLVE_OWNER_ID : null, ACTION_OWNER : null, DUE_DATE : null, CLOSE_DATE : null, DEL : null}
		],
		draw : function(){
			$("#oppCheckList").jqGrid({
	 			url : "/clientSalesActive/gridOpportunityCheckList.do",
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
						return "<a href='javascript:void(0);' onClick='oppCheckList.addRow("+colpos.CHECKLIST_SEQ+",\""+colpos.STATUS+"\",\""+cellval.rowId+"\",\""+colpos.CHECKLIST_ID+"\",\""+colpos.MEMO+"\");'><i class='fa fa-plus-square-o fa-lg'></i></a>";
					},
					cellattr : checkListCellAttr
				},{
					label : '체크리스트',
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
					cellattr : checkListCellAttr
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
  		                    	var rowId = $("#oppCheckList")[0].p.selrow;
  		                    	jqGridCellStatus($("#oppCheckList"), $(this).val(), rowId);
  		                    },
  		                }]
  					},
  					formatter: function (rowId, cellval , colpos, rwdat, _act){
						var rowData = $(this).jqGrid("getRowData",cellval.rowId);
						switch (rowId) {
							case "Green":
								$("#oppCheckList").setCell(cellval.rowId,"HIDDEN_STATUS","G");
								$("#oppCheckList").setCell(cellval.rowId,"STATUS","",{"background-color": "#1ab394"});
								return "";
								break;
							case "Yellow":
								$("#oppCheckList").setCell(cellval.rowId,"HIDDEN_STATUS","Y");
								$("#oppCheckList").setCell(cellval.rowId,"STATUS","",{"background-color": "#ffc000"});
								return "";
								break;
							case "Red":
								$("#oppCheckList").setCell(cellval.rowId,"HIDDEN_STATUS","R");
								$("#oppCheckList").setCell(cellval.rowId,"STATUS","",{"background-color": "#f20056"});
								return "";
								break;
							default:
								$("#oppCheckList").setCell(cellval.rowId,"HIDDEN_STATUS",null);
								$("#oppCheckList").setCell(cellval.rowId,"STATUS","",{"background-color": ""});
								return "-";
								break;
						}	
					},
					cellattr : checkListCellAttr
				},{
					label : '의견',
					name : 'MEMO',
					align : "left",
					width : 130,
					editable: true,
					edittype:'textarea',
					cellattr : checkListCellAttr
				}/*,{
					label : 'Items to be Fixed',
					name : 'ITEMS_TO_BE_FIXED',
					align : "center",
					width : 160,
					editable: true
				}*/
				,{
					label : '해결계획(상세)',
					name : 'ACTION_PLAN_NAME',
					align : "left",
					width : 200,
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
					width : 100,
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
		             							//oppCheckList.changeStatusActionPlan();
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
		             							//oppCheckList.changeStatusActionPlan();
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
							return "<a href='javascript:void(0);' onClick='oppCheckList.deleteRow("+colpos.ACTION_ID+","+colpos.CHECKLIST_SEQ+",\""+colpos.STATUS+"\",\""+cellval.rowId+"\",\""+colpos.DELNO+"\",this);'><i class='fa fa-trash-o fa-lg'></i></a>";
					}
				},{
					label : 'ACTION_ID',
					name : 'ACTION_ID',
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
				},{
					label : 'ROWNUM',
					name : 'ROWNUM',
					hidden : true
				},{
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
					//if(id && lastEditRowCheckList != id){
						$(this).jqGrid('saveRow',lastEditRowCheckList,true);
						$(this).jqGrid('editRow',id,true);
						
						lastEditRowCheckList = id;
					//}
					if(rowData.HIDDEN_STATUS){
						$("select#"+id+"_STATUS").val(rowData.HIDDEN_STATUS);
					}
				},
				loadBeforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				loadComplete : function(data){
					//status
					var list = data.rows;
					if(list.length == 0){
						for(var i=0;i<=oppCheckList.initData.length;i++){
			                //jqgrid의 addRowData를 이용하여 각각의 row에 gridData변수의 데이터를 add한다
			                $("#oppCheckList").jqGrid('addRowData',i+1,oppCheckList.initData[i]);
			        	} 			
					}{
						for(var i=0; i<list.length; i++ ){
							if(list[i].HIDDEN_STATUS == 'G'){
								$("#oppCheckList").setCell(i+1,"STATUS","Green",{"background-color": "#1ab394"});
							}else if(list[i].HIDDEN_STATUS == 'Y'){
								$("#oppCheckList").setCell(i+1,"STATUS","Yellow",{"background-color": "#ffc000"});
							}else if(list[i].HIDDEN_STATUS == 'R'){
								$("#oppCheckList").setCell(i+1,"STATUS","Red",{"background-color": "#f20056"});
							}else{
								$("#oppCheckList").setCell(i+1,"STATUS","-");
							}
						}
					}
				},
				loadError : function(xhr, status, err) {
					$.error(xhr, status, err);
				}
			})
			
			if(checkListFlag){
				$("#oppCheckList").jqGrid('setGroupHeaders', {
					  useColSpanStyle: true, 
					  groupHeaders:[
						          	{startColumnName: 'ACTION_PLAN_NAME', numberOfColumns: 4, titleText: '액션플랜(Action Plan)'},
					  ]
				});
				checkListFlag = false;
			}
		},
		
		addRow : function(seq,status,rownum,checklist_id,memo){
			var rowspanCount;
			switch (seq) {
				case 1:
					cl_rowspan_1++;
					rowspanCount = cl_rowspan_1; 
					break;
				case 2:
					cl_rowspan_2++;
					rowspanCount = cl_rowspan_2;
					break;
				case 3:
					cl_rowspan_3++;
					rowspanCount = cl_rowspan_3;
					break;
				case 4:
					cl_rowspan_4++;
					rowspanCount = cl_rowspan_4;
					break;
			}
			
			oppCheckList.saveRow();
			
			$("#oppCheckList").jqGrid('addRowData',"",[{/* CHECKLIST_SEQ:seq, HIDDEN_STATUS:status, CHECKLIST_ID:checklist_id, */DELNO : rownum, CHECKLIST_SEQ:seq, CHECKLIST_ID:checklist_id, attr:{STATUS: {display: 'none'},MEMO :{display: 'none'}, ADD :{display: 'none'}}}],"after",rownum);
			$("#oppCheckList").jqGrid("setCell", rownum, "STATUS", "", "", {rowspan: rowspanCount});
			$("#oppCheckList").jqGrid("setCell", rownum, "MEMO", "", "", {rowspan: rowspanCount});
			$("#oppCheckList").jqGrid("setCell", rownum, "ADD", "", "", {rowspan: rowspanCount});
			$("#oppCheckList").jqGrid("setCell", rownum, "CHECKLIST_SEQ", "", "", {rowspan: rowspanCount});
			$("#oppCheckList").jqGrid("setCell", rownum, "CHECKLIST_ID", "", "", {rowspan: rowspanCount});
			$("#oppCheckList").jqGrid("setCell", rownum, "DELNO", "", "", {rowspan: rowspanCount});
			
			lastEditRowCheckList = 0;
		},
		
		deleteRow : function(actionId,seq,status,rownum,delno,obj){
			var title = $(obj).parent().siblings("td[aria-describedby='oppCheckList_CHECKLIST_SEQ']").attr("title");
			var t_len = $("td[aria-describedby='oppCheckList_CHECKLIST_SEQ'][title="+title+"]").length;
			//그리드로 추가한것은 그냥 삭제~			
			if(rownum.indexOf("jqg") != -1){
				oppCheckList.delRowCheckList(seq,status,rownum,delno);
				return;
			}
			//actionId가 있을경우 and 1개 이상일 경우 db삭제
			if(actionId && t_len > 1){
				$.ajax({
					url : "/clientSalesActive/deleteSalesCycleActionPlan.do?hiddenModalPK="+$("#hiddenModalPK").val()+"&actionId="+actionId,
					datatype : 'json',
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						if (!confirm("삭제하시겠습니까?")){
							lastEditRowCheckList = 0;
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
						astEditRowAction = 0;
						oppCheckList.reload();
						oppList.completeReload();
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			}
		},
		
		delRowCheckList : function(seq,status,rownum,delno){
			var rowspanCount;
			switch (seq) {
				case 1:
					cl_rowspan_1--;
					rowspanCount = cl_rowspan_1; 
					break;
				case 2:
					cl_rowspan_2--;
					rowspanCount = cl_rowspan_2;
					break;
				case 3:
					cl_rowspan_3--;
					rowspanCount = cl_rowspan_3;
					break;
				case 4:
					cl_rowspan_4--;
					rowspanCount = cl_rowspan_4;
					break;
			}
			
			$("#oppCheckList").jqGrid('delRowData', rownum);
			$("#oppCheckList").jqGrid("setCell", delno, "STATUS", "", "", {rowspan: rowspanCount});
			$("#oppCheckList").jqGrid("setCell", delno, "MEMO", "", "", {rowspan: rowspanCount});
			$("#oppCheckList").jqGrid("setCell", delno, "ADD", "", "", {rowspan: rowspanCount});
			$("#oppCheckList").jqGrid("setCell", delno, "CHECKLIST_SEQ", "", "", {rowspan: rowspanCount});
			$("#oppCheckList").jqGrid("setCell", delno, "CHECKLIST_ID", "", "", {rowspan: rowspanCount});
			$("#oppCheckList").jqGrid("setCell", delno, "DELNO", "", "", {rowspan: rowspanCount});
		},
		
		reload : function(){
			$("#oppCheckList").jqGrid(
				'setGridParam', 
				{
					url : "/clientSalesActive/gridOpportunityCheckList.do",
	 				mtype: 'POST',
	 				postData : {
	 					hiddenModalPK : $("#hiddenModalPK").val()
	 				},
	 				datatype : 'json'
	 			}
			).trigger('reloadGrid');
		},
		
		clear : function(){
			$("#oppCheckList").jqGrid('clearGridData');
			cl_rowspan_1 = 1;
			cl_rowspan_2 = 1;
			cl_rowspan_3 = 1;
			cl_rowspan_4 = 1;
			lastEditRowCheckList = 0;
		},
		
		saveRow : function(){
			var gridLength = $("#oppCheckList").jqGrid('getGridParam', 'records');
			for(var i=1; i<=gridLength; i++){
				$("#oppCheckList").jqGrid('saveRow', i);
			}
			$("#oppCheckList").jqGrid('saveRow', lastEditRowCheckList);
		}
}

function checkListCellAttr(rowId, val, rawObject, cm) {
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
				cl_rowspan_1 = attr;
				break;
			case 2:
				cl_rowspan_2 = attr;
				break;
			case 3:
				cl_rowspan_3 = attr;
				break;
			case 4:
				cl_rowspan_4 = attr;
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
</script> --%>