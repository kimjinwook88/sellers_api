<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table id="milestonesEnablement" style="height: 100%"></table>
<p class="text-center pd-t10">
   <a href="javascript:void(0);" class="btn-row-add" name="buttonSaleAddRow" onClick="mileStones.addRow();">+ 리스트 추가</a>
</p>

<script type="text/javascript">
$(document).ready(function() {
	mileStones.init();
});
var mileStonesFlag = true;
var lastEditRow;			

var mileStones = {                                                  
			init : function(){
				$milestonesEnablement = $("#milestonesEnablement");
			},
			
			reset : function(){
				mileStones.reload();
			},
			
			draw : function() {
				$milestonesEnablement.jqGrid({
		 			url : "/partnerManagement/gridMileStonesEnablement.do?hiddenModalPK="+$("#hiddenModalPK").val(),
					datatype : 'json',
					 jsonReader : { 
					    root: "rows",
					},  
					colModel : [ {
						label : 'No',
						name : 'ROWNUM',
						align : "center",
						width : 50
					}, {
						label : '협력회사명',
						name : 'PARTNER_NAME',
						align : "center",
						editable: true,
						width : 230,
						classes : "pos-rel",
						editoptions: {
								dataInit: function (element,rwdat) {
									commonSearch.partnerGrid($(element), $(element).parent('td').siblings(".hidden_partner_id"));
	                            }
						}
					}, {
						label : '피교육자명',
						name : 'PARTNER_PERSONAL_NAME',
						align : "center",
						editable: true,
						width : 125,
						classes : "pos-rel",
						editoptions: {
								dataInit: function (element,rwdat) {
									commonSearch.partnerMemberGrid($(element), $(element).parent('td').siblings(".hidden_partner_individual_id"));
	                            }
						}
					}, {
						label : '총교육시간',
						name : 'TOTAL_HOURS',
						index : 'TOTAL_HOURS',
						align : "center",
						width : 105
					}, {
						label : '참석시간',
						name : 'ATTENDED_HOURS',
						index : 'ATTENDED_HOURS',
						align : "center",
						editable: true,
						width : 105,
						editoptions: { 
								dataInit: function (elem) {
									$(elem).attr("onkeyup","commonCheck.onlyNumber(this);mileStones.attendHoursChk(this);");
			               		}
						}
					},{
						label : '수료여부',
						name : 'CERTIFICATION_YN',
						align : "center",
						editable: true,
						width : 100,
						edittype:"select",
						formatter:'select',
						editoptions:{
							value:"Y:수료;N:미수료" //대소문자 유의!
						}
					}, {
						label : '만족도',
						name : 'SAT_VALUE',
						align : "center",
						width : 100,
						editable: true,
						edittype:"select",
						formatter:'select',
						editoptions:{
							value:"0:만족;1:보통;2:불만족" //대소문자 유의!
						}
					},{
						label : 'EDU_LOG_ID',
						name : 'EDU_LOG_ID',
						hidden : true
					}, {
						label : 'HIDDEN_PARTNER_ID',
						name : 'HIDDEN_PARTNER_ID',
						classes : "hidden_partner_id",
						hidden : true
					}, {
						label : 'HIDDEN_PARTNER_INDIVIDUAL_ID',
						name : 'HIDDEN_PARTNER_INDIVIDUAL_ID',
						classes : "hidden_partner_individual_id",
						hidden : true
					}
					//{name:'NO',index:'NO', sortable:true, hidden:false, formatter:'number'}
					],
					height : "100%",
					shrinkToFit: true,
					onSelectRow : function(id) { //row 선택시 처리. ids는 선택한 row
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
						
					},
					loadError : function(xhr, status, err) {
						$.error(xhr, status, err);
					}
				});
				
				if(mileStonesFlag){
					$milestonesEnablement.jqGrid('setGroupHeaders', {
						  useColSpanStyle: true, 
						  groupHeaders:[
							          	{startColumnName: 'TOTAL_HOURS', numberOfColumns: 3, titleText: '교육결과'},
						  ]
					});
					mileStonesFlag = false;
				}
			},
			
			clear : function(){
				$milestonesEnablement.jqGrid('clearGridData');
			},
			
			reload : function(){
				$milestonesEnablement.jqGrid('setGridParam', { url : "/partnerManagement/gridMileStonesEnablement.do?hiddenModalPK="+$("#hiddenModalPK").val()}).trigger('reloadGrid');
			},
			
			insert : function(){
				mileStones.saveRow();
				$.ajax({
						url : "/partnerManagement/insertMilestonesEnablement.do",
						datatype : 'json',
						async : false,
						contentType : "application/json; charset=UTF-8",
						beforeSend : function(xhr){
							xhr.setRequestHeader("AJAX", true);
							if(!confirm('저장하시겠습니까?')){
								lastEditRow = 0;
								return false;
							} 
							$.ajaxLoading();
						},
						data : {
							mileStonesData : JSON.stringify($milestonesEnablement.getRowData()),
							hiddenModalPK : $("#hiddenModalPK").val(),
							creator_id : $("#hiddenModalCreatorId").val(),
							datatype : 'json'
						},
						success : function(data){
							if(data.cnt > 0){
								alert("저장하였습니다.");	
							}else{
								alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
							}
							$("#divModalFile > p").remove();
							$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/partnerManagement/gridEnablement.do?"+searchSerialize, rowNum : listRow}).trigger('reloadGrid');
							mileStones.reload();
							setTimeout(function(){$("#divModalFile p[name='modalFile"+$("#hiddenModalPK").val()+"']").show();},1000); //ajax Loading
						},
						complete : function(){
							$.ajaxLoadingHide();
						}
				});
			},
			
			saveRow : function(){
				var gridLength = $milestonesEnablement.jqGrid('getGridParam', 'records');
				for(var i=1; i<=gridLength; i++){
					$milestonesEnablement.jqGrid('saveRow', i);
				}
				$milestonesEnablement.jqGrid('saveRow', lastEditRow);
			},
			
			addRow : function(){
				var idx = $milestonesEnablement.getDataIDs().length+1;
				var initData = {ROWNUM:idx, PARTNER_ID : "" , PARTNER_INDIVIDUAL_ID : "" , TOTAL_HOURS : $("#textModalTotalHours").val(), ATTENDED_HOURS : "", CERTIFICATION_YN : "Y", SAT_VALUE : "0"};
				$milestonesEnablement.jqGrid('addRowData',idx,initData);
			},
			
			attendHoursChk : function(obj){
				var totalHours = $("#textModalTotalHours").val(); 
				if(parseInt(obj.value) > parseInt(totalHours)){
					alert("참석 시간이 총 교육시간 보다 클 수 없습니다.");
					obj.value = "";
				}
			}
			
}
</script>