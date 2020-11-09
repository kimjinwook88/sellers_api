<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="modal inmodal fade" id="modalProjectMg" tabindex="-1" role="dialog"  aria-hidden="true">
   <div class="modal-dialog modal-lg">
       <div class="modal-content">
           <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
               <h4 class="modal-title">프로젝트이력 관리</h4>
               <!-- <small class="font-bold">고객사정보 세부정보입니다. </small> -->
           </div>
           <div class="modal-body" >
               <div class="row">
                   <div class="col-lg-12">
                       <div class="ibox float-e-margins">
                           <div class="ibox-content border_n">
                       		 <form class="form-horizontal" id="formProjectMg" name="formProjectMg" method="post" enctype="multipart/form-data">
                       		
                                <div class="form-group">
                                    <div class="col-sm-12 ag_r" name="divModalProjectMgCreateDate" id="divModalProjectMgCreateDate">작성자 : 홍길동 / 작성일 : 2016-05-10</div>
                                </div>
								
									<div id="divProjectMg">
									    <div class="col-sm-12 ibox float-e-margins">
									        <div class="ibox-content" id="divSalesCycleToggle">
									            <table id="tableProjectMg"></table>
									            <p class="text-center pd-t10">
									               <a href="javascript:void(0);" class="btn-row-add" name="buttonSaleAddRow" onclick="modalProjectMg.addRow();">+ 리스트 추가</a>
									           	</p>
								           		<div class="hr-line-dashed"></div>
									        </div>                                                                            
									    </div>
									    <input type="hidden" name="hiddenModalProjectMgClientId" id="hiddenModalProjectMgClientId" />
									</div>
                                   
                                   <div class="hr-line-dashed"></div>
                                   
                                   <%-- <c:if test="${fn:contains(auth, 'ROLE_CRUD')}"> --%>
                                   <p class="text-center">
									<!-- <button type="button" class="btn btn-outline btn-gray-outline" id="buttonModalDelete" onClick="modalProjectMg.deleteModal();">삭제하기</button> -->
									<button type="button" class="btn btn-w-m btn-seller" onclick="modalProjectMg.submit();" id="buttonModalProjectMgSubmit">저장하기</button>
		                           </p>
		                           <%-- </c:if> --%>
                                   
							</form>    
						</div>        
					  </div>
                    </div>
                  </div>
               </div>
               
               <div class="modal-footer">
                <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
            </div>
		</div>
	</div>
</div>
                        
<!-- <form id="formDetail" name="formDetail" method="post">
	<input type="hidden" id="customer_id" name="customer_id">
	<input type="hidden" id="customer_name" name="customer_name">
	<input type="hidden" id="company_id" name="company_id">
</form> -->
         
<script type="text/javascript">
var modalProjectMgFlag = "upd";
var compareProjectMgFlag = false;
var compare_pm_after;
var compare_pm_before;
var lastEditProjectMage;

var saleCycleQualiFlag = true;
var lastEditRow;

$(document).ready(function() { 
	modalProjectMg.init();
});

var modalProjectMg = {
		init : function(){
			lastEditRow = 0;
			
			//모달 hidden event
			$('#modalProjectMg').on('hide.bs.modal', function () {
				compare_pm_after = $("#formProjectMg").serialize();
				if(modalProjectMgFlag == "upd"){
					if(compare_pm_before != compare_pm_after){
						if(confirm("내용이 수정되었습니다.\n저장하시겠습니까?")) {
							compareProjectMgFlag = true;
							$("#buttonModalProjectMgSubmit").trigger("click");
						}
					}
				}
				$("#divModalFile p").hide();
			});
		},
		
		//프로젝트 관리 신규등록 팝업
		//고객사정보에서 모달이 2개이므로 네이밍 주의!
		update : function() { 
			//$("#modalProjectMg #divModalProjectMgCreateDate").text("작성자 : ${userInfo.HAN_NAME} / "+moment().format("YYYY-MM-DD"));
			$("#modalProjectMg h4.modal-title").text("프로젝트이력 관리");
			//$("#tableProjectMg").jqGrid('clearGridData');
			//$("#tableProjectMg").jqGrid('setGridParam', { datatype: 'json' , url : "/clientManagement/selectCustomerProjectMg.do?customerId="+$("#hiddenModalProjectMgClientId").val()}).trigger('reloadGrid');
			modalProjectMg.reload();
			modalProjectMg.drawProjectMg();
			compare_pm_before = $("#formProjectMg").serialize();
			$("#modalProjectMg").modal();
		},
		
		submit : function(){
			var gridLength = $("#tableProjectMg").jqGrid('getGridParam', 'records');
			for(var i=1; i<=gridLength; i++){
				$("#tableProjectMg").jqGrid('saveRow', i);
			}
			$.ajax({
				url : "/clientManagement/insertSalesStatus.do",
				async : false,
	 			datatype : 'json',
	 			method: 'POST',
				data : {
					projectMgData : JSON.stringify($("#tableProjectMg").getRowData()),
					customerId : $("#hiddenModalProjectMgClientId").val(),
					creatorId : "${userInfo.MEMBER_ID_NUM}",
					datatype : 'json'
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if (!confirm("저장하시겠습니까?")){
						lastEditRow = 0;
						return false;	
					}
                    $.ajaxLoading();
				},
				success : function(result){
					if(result.cnt > 0){
						//alert("저장하였습니다.");
						lastEditRow = 0;
						$("#tableProjectMg").jqGrid('setGridParam', { datatype: 'json' , url : "/clientManagement/gridSalesStatus.do?customerId="+$("#hiddenModalProjectMgClientId").val()}).trigger('reloadGrid');
						//$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/clientManagement/viewClientIndividualInfoDetail.do?"+searchSerialize}).trigger('reloadGrid');
					}else if(result.cnt == 0){
						console.log("Data empty");
					}else{
						alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
					}
					lastEditRow = 0;
					modalProjectMg.reload();
					customerDetail.getCustomerProjectMg();
					compare_pm_before = $("#formProjectMg").serialize();
					$("#modalProjectMg").modal('hide');
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		drawProjectMg : function(){
			$("#tableProjectMg").jqGrid({
	 			url : "/clientManagement/gridSalesStatus.do?customerId="+$("#hiddenModalProjectMgClientId").val(),
				datatype : 'json',
				 jsonReader : { 
				    root: "rows"
				},
				colModel : [ 
				{
					label : '프로젝트명',
					name : 'PROJECT_NAME',
					align : "center",
					width : 200,
					editable: true
				},{
					label : '역할',
					name : 'ROLE',
					align : "center",
					width : 80,
					editable: true,
					edittype:"select",
					formatter:'select',
					editoptions:{
						value:"1:정보제공자;2:실무자;3:의사결정자;4:influencer"
					}
				},{
					label : '포지션',
					name : 'POSITION',
					align : "center",
					width : 45,
					editable: true,
					edittype:"select",
					formatter:'select',
					editoptions:{
						value:"1:Pro;2:Anti;3:Neutral"
					}
				}, {
					label : '시작일',
					name : 'START_DATE',
					align : "center",
					width : 80,
					editable: true,
					editoptions: {
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
					label : '마감일',
					name : 'END_DATE',
					align : "center",
					width : 80,
					editable: true,
					editoptions: {
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
					label : '상세내용',
					name : 'DETAIL',
					align : "center",
					width : 270,
					editable: true
				},{
					label : 'SEQ_NUM',
					name : 'SEQ_NUM',
					hidden : true
				},{
					label : '',
					name : '',
					align : "center",
					width : 30,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						return "<a href='javascript:void(0);' onClick='modalProjectMg.delRow(\""+cellval.rowId+"\",\""+colpos.SEQ_NUM+"\");'><i class='fa fa-times-circle'></i></a>"; 
					}
				}
				],
				loadui: 'disable',
				loadonce : true,
				viewrecords : true,
				height : "100%",
				autowidth : true,
				//sortable:true, 컬럼 위치 마우스 드래그로 바꾸는건데 버그있는듯? 확인 필요
				onCellSelect : function(id) {
					if(id && lastEditRow != id){
						$(this).jqGrid('editRow',id,true);
						$(this).jqGrid('saveRow', lastEditRow);
						lastEditRow = id;
					}
				},
				onPaging : function(action) { //paging 부분의 버튼 액션 처리  first, prev, next, last, records
					/*  if(action == 'next'){
						currPage = getGridParam("page");
					} */
				},
				loadBeforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				loadComplete : function(data){
					//noDataFn(this);
					//$.ajaxLoading();
					
					/* 결과 내 검색을 위한 작업  */
					/* var pkArray = [];
				    for(var key in data.rows) {
				      if(data.rows[key].OPPORTUNITY_ID) {
				    	  pkArray.push(data.rows[key].OPPORTUNITY_ID);
				      } 
				    } */
				    
				},
				loadError : function(xhr, status, err) {
					$.error(xhr, status, err);
				}
			})
		},
		
		clear : function(){
			$("#tableProjectMg").jqGrid('clearGridData');
		},
		
		reload : function(){
			$("#tableProjectMg").jqGrid(
				'setGridParam', 
				{
					url : "/clientManagement/gridSalesStatus.do",
	 				mtype: 'POST',
	 				datatype : 'json',
	 				postData : {
	 					customerId : $("#hiddenModalProjectMgClientId").val()
	 				},
	 				jsonReader : { 
					    root: "rows",
					}
	 			}
			).trigger('reloadGrid');
		},
		
		addRow : function(){
			var gridLength = $("#tableProjectMg").jqGrid('getGridParam', 'records');
			for(var i=1; i<=gridLength; i++){
				$("#tableProjectMg").jqGrid('saveRow', i);
			}
 			$("#tableProjectMg").jqGrid('addRow', {
				rowID : gridLength+1, 
				id : gridLength+1,
		        position :"last"           //first, last
			}); 
 			$("#tableProjectMg").jqGrid('saveRow', gridLength+1);
		},
		
		delRow : function(rowId, ppId){
			if(!isEmpty(ppId) && ppId != "undefined"){
				$.ajax({
					url : "/clientManagement/deleteSalesStatus.do",
					async : false,
		 			datatype : 'json',
		 			method: 'POST',
					data : {
						SEQ_NUM : ppId,
						customerId : $("#hiddenModalProjectMgClientId").val(),
						datatype : 'json'
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
							$("#tableProjectMg").jqGrid('delRowData', rowId);
							alert("삭제되었습니다.");
						}else{
							alert("삭제를 실패했습니다.\n관리자에게 문의하세요.");
						}
						lastEditRow = 0;
						modalProjectMg.clear();
						modalProjectMg.drawProjectMg();
						modalProjectMg.reload();
						customerDetail.getCustomerProjectMg();
					},
					complete: function(){
						$.ajaxLoadingHide();
					}
				});
			}else{
				$("#tableProjectMg").jqGrid('delRowData', rowId);
			}
			
		},
		
		saveRow : function(){
			var gridLength = $("#tableProjectMg").jqGrid('getGridParam', 'records');
			for(var i=1; i<=gridLength; i++){
				$("#tableProjectMg").jqGrid('saveRow', i);
			}
			$("#tableProjectMg").jqGrid('saveRow', lastEditProjectMage);
		},
		
		//모달 삭제 추후 구현 예정
		deleteModal : function(){
			
		}
}
</script>
