<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<%
	String selectCRBseq = request.getParameter("selectCRBseq");
%>
<!-- 
 * @author 	: 욱이
 * @Date		: 2016. 07 - 17
 * @explain	: 영업활동 ->파트너 영업 -> Recruitment
 -->	
		 <div class="row wrapper border-bottom white-bg page-heading">
			  <!-- <div class="col-sm-6">
                  <h2>Recruitment</h2>
                  <ol class="breadcrumb">
                      <li>
                          <a href="/main/index.do">Home</a>
                      </li>
                      <li>
                          <a>파트너사협업관리</a>
                      </li>
                      <li class="active">
                          <strong>Recruitment</strong>
                      </li>
                  </ol>
              </div> -->
		 </div>

		<div class="wrapper wrapper-content  animated fadeInRight">
            <div class="row">
                <div class="col-sm-12">
                    <div class="ibox">
                        <div class="ibox-content border_n">
                            <div class="clear">    
                            	<div class="mg-b20">
                                	<ul class="nav nav-tabs">
                              	     	<li class=""><a href="/partnerManagement/viewPartnerSales.do">1.파트너 현황</a></li>
                            	        <li class="active"><a href="/partnerManagement/viewPartnerRecruitment.do">2.Recruitment</a></li>
                         	            <li class=""><a href="/partnerManagement/viewPartnerEnablement.do">3.파트너 교육</a></li>
                         	            <li class=""><a href="/partnerManagement/viewPartnerSalesLinkage.do">4.파트너 협업</a></li>
                         	            <li class=""><a href="/partnerManagement/viewPartnerFullfillment.do">5.파트너사 비지니스 현황</a></li>
                      	            </ul>
                           		</div>                            

                                <!-- <h3>Recruitment</h3> -->
                                <form class="form-horizontal" id="formRecruitmentData" name="formRecruitmentData" method="post" enctype="multipart/form-data">
                                <div class="pos-rel">
                                    <div class="func-top-left fl_l">
                                        <div class="table-sel-view fl_l">
                                            <div class="selgrid selgrid1 mg-r5">
                                                <select class="form-control m-b" name="account" id="selectAccountYear">
                                                    <c:choose>
														<c:when test="${fn:length(searchDetailGroup.account_year) > 0}">
															<c:forEach items="${searchDetailGroup.account_year}" var="searchDetailGroup">
							                                    <option value="${searchDetailGroup.FISCAL_YEAR}" <c:if test="${selectAccountYear eq searchDetailGroup.FISCAL_YEAR}">selected="selected"</c:if>>${searchDetailGroup.FISCAL_YEAR}년</option>
				                                    		</c:forEach>
				                                    	</c:when>
				                                    	<c:otherwise>
				                                    			<option value="">== 회계년도 ==</option>
				                                    	</c:otherwise>
				                                    </c:choose>
                                                </select>
                                            </div>
                                            <div class="selgrid selgrid1 mg-r5">
                                                <select class="form-control m-b" name="account" id="selectViewList">
			                                    	<option value="in" <c:if test="${selectViewList eq 'in'}">selected="selected"</c:if>>산업</option>
			                                    	<option value="bp" <c:if test="${selectViewList eq 'bp'}">selected="selected"</c:if>>고객사</option>
		                                   		</select>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="func-top-right fl_r pd-b20">
                                   		<div class="fl_l template-doc" style="z-index: 1000;">
                                        </div>
                                        <div class="fl_l"></div>
                                    </div>
                                    <table id="sellersGrid" ></table>
                                </div>
                               <p class="text-center">
                                    <a href="javascript:void(0);" class="btn btn-crb" id="aCRBView">CRB 보기 <i class="fa fa-chevron-down"></i><i class="fa fa-chevron-up" style="display:none;"></i></a>
                                </p>
                                
                                <c:set var="searchCRBGroup" value="${searchCRBGroup}" scope="request" />
                                <c:set var="selectCRBseq" value="<%=selectCRBseq%>" scope="request" />
                                <jsp:include page="/WEB-INF/jsp/pc/partnerManagement/partnerCooperationRecruitmentCRB.jsp" />
								</form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
	</div>
	</div>
        
		<form id="formList" name="formList">
		  <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
		</form>  
  
</body>

<script type="text/javascript">
/*
 *  전역변수
 */
var gridWidth;
var listRow = 10;
var reloadFlag = true;
var lastEdit;
var maxYear = "${searchDetailGroup.max_account_year[0].FISCAL_YEAR}"; 

var compare_before;
var compare_after;
var compareFlag = false;
var selectCRBseq = "<%=selectCRBseq%>"

//$("#buttonModalSubmit").trigger("click");
$(document).ready(function() {
	
	//$("#menu_title_1").html('Recruitment');
	//$("#menu_title_2").html('Recruitment');
	
	//그리드 생성
	jqGrid.draw();
	
	//그리드 크기를 가져올 변수
	gridWidth = $sellersGrid.jqGrid('getGridParam', 'width');
	
	//모달 hidden event
	$('#myModal1').on('hide.bs.modal', function () {
	});
	
 	if(maxYear == commonDate.year){
		$("#buttonCreateModalView").hide();
	}else{
		$("#buttonCreateModalView").show();
		$("select#selectCreateYear").html("");
		$("select#selectCreateYear").append('<option value='+commonDate.year+'>'+commonDate.year+'년</option>');
		if($("#selectViewList").val() == "in"){
			$("select#selectCreateViewList").html("");
			$("select#selectCreateViewList").append('<option value='+$("#selectViewList").val()+'>'+$("#selectViewList option:checked").html()+'</option>');
		}else{
			$("select#selectCreateViewList").html("");
			$("select#selectCreateViewList").append('<option value='+$("#selectViewList").val()+'>'+$("#selectViewList option:checked").html()+'</option>');	
		}
	}
 	
 	$("a#aCRBView").click(function(){
 		CRB.draw();
 		CRB.reload();
 	});
 	
 	if(selectCRBseq != "null" && selectCRBseq != null && selectCRBseq != ""){
 		setTimeout(function(){
 			$("a#aCRBView").trigger("click");
 		},200)	
	}
 	
});

/*
 *  jqGrid function()
 */
var jqGrid = {
	draw : function() {
		$sellersGrid.jqGrid('clearGridData');
		$sellersGrid.jqGrid({
 			url : "/partnerManagement/gridRecruitment.do?",
 			datatype : 'json',
			mtype: 'POST',
			postData : { 
				selectAccountYear:$("#selectAccountYear").val(), 
				selectViewList:$("#selectViewList").val() 
			},
			 jsonReader : { 
			    root: "rows"
			},
			colModel : [ 
			   {
				label : 'No',
				name : 'ROWNUM',
				align : "center",
				width : 50
			}, {
				label : $("#selectViewList option:selected").text(),
				name : 'BP_NAME',
				align : "center",
				width : 150
			},{
				label : '기회',
				name : 'OPP_HW',
				align : "center",
				editable: true,
				width : 100,
				formatter: 'integer',
				formatoptions:{thousandsSeparator:","}
			    ,editoptions:{
		            /* size: 15, maxlengh: 10, */
		            dataInit: function(element) {
			             $(element).keyup(function(){
				              var val1 = element.value;
				              var num = new Number(val1);
				              if(isNaN(num)){
				               alert("숫자만 입력해 주세요.");
				               element.value = '';
				              }
			             });
		            }
		       } 
			},{
				label : '매출',
				name : 'SALES_HW',
				align : "center",
				editable: true,
				width : 100,
				formatter: 'integer', formatoptions:{thousandsSeparator:","}
				,editoptions:{
		            /* size: 15, maxlengh: 10, */
		            dataInit: function(element) {
			             $(element).keyup(function(){
				              var val1 = element.value;
				              var num = new Number(val1);
				              if(isNaN(num)){
				               alert("숫자만 입력해 주세요.");
				               element.value = '';
				              }
			             });
		            }
		       }
			},{
				label : 'Align',
				name : 'ALIGN_HW',
				align : "center",
				width : 80
			},{
				label : 'Status',
				name : 'STATUS_HW',
				align : "center",
				editable: true,
				edittype:"select",
				formatter:'select',
				width : 80,
				formatter: function (rowId, cellval , colpos, rwdat, _act){
					if(rwdat == "edit"){
						switch (rowId) {
						case "Green":
							$sellersGrid.jqGrid('setCell', cellval.rowId, 'HIDDEN_STATUS_HW', 'G');
							$sellersGrid.setCell(cellval.rowId,"STATUS_HW","",{"background-color": "#1ab394"});
							return "";
							break;
						case "Yellow":
							$sellersGrid.jqGrid('setCell', cellval.rowId, 'HIDDEN_STATUS_HW', 'Y');
							$sellersGrid.setCell(cellval.rowId,"STATUS_HW","",{"background-color": "#ffc000"});
							return "";
							break;
						case "Red":
							$sellersGrid.jqGrid('setCell', cellval.rowId, 'HIDDEN_STATUS_HW', 'R');
							$sellersGrid.setCell(cellval.rowId,"STATUS_HW","",{"background-color": "#f20056"});
							return "";
							break;
						default:
							$sellersGrid.setCell(cellval.rowId,"HIDDEN_STATUS_HW",null);
							$sellersGrid.setCell(cellval.rowId,"STATUS_HW","",{"background-color": ""});
							return "-";
							break;
						}	
					}
				}
			},{
				label : 'Action',
				name : 'CONDITIONS_HW',
				align : "center",
				width : 100
			},{
				label : '기회',
				name : 'OPP_SW',
				align : "center",
				editable: true,
				width : 100,
				formatter: 'integer', formatoptions:{thousandsSeparator:","}
				,editoptions:{
		            /* size: 15, maxlengh: 10, */
		            dataInit: function(element) {
			             $(element).keyup(function(){
				              var val1 = element.value;
				              var num = new Number(val1);
				              if(isNaN(num)){
				               alert("숫자만 입력해 주세요.");
				               element.value = '';
				              }
			             });
		            }
		       }
			},{
				label : '매출',
				name : 'SALES_SW',
				align : "center",
				editable: true,
				width : 100,
				formatter: 'integer', formatoptions:{thousandsSeparator:","}
				,editoptions:{
		            /* size: 15, maxlengh: 10, */
		            dataInit: function(element) {
			             $(element).keyup(function(){
				              var val1 = element.value;
				              var num = new Number(val1);
				              if(isNaN(num)){
				               alert("숫자만 입력해 주세요.");
				               element.value = '';
				              }
			             });
		            }
		       }
			},{
				label : 'Align',
				name : 'ALIGN_SW',
				align : "center",
				width : 80
			},{
				label : 'Status',
				name : 'STATUS_SW',
				align : "center",
				editable: true,
				edittype:"select",
				formatter:'select',
				width : 80,
				formatter: function (rowId, cellval , colpos, rwdat, _act){
					if(rwdat == "edit"){
						switch (rowId) {
						case "Green":
							$sellersGrid.jqGrid('setCell', cellval.rowId, 'HIDDEN_STATUS_SW', 'G');
							$sellersGrid.setCell(cellval.rowId,"STATUS_SW","",{"background-color": "#1ab394"});
							return "";
							break;
						case "Yellow":
							$sellersGrid.jqGrid('setCell', cellval.rowId, 'HIDDEN_STATUS_SW', 'Y');
							$sellersGrid.setCell(cellval.rowId,"STATUS_SW","",{"background-color": "#ffc000"});
							return "";
							break;
						case "Red":
							$sellersGrid.jqGrid('setCell', cellval.rowId, 'HIDDEN_STATUS_SW', 'R');
							$sellersGrid.setCell(cellval.rowId,"STATUS_SW","",{"background-color": "#f20056"});
							return "";
							break;
						default:
							$sellersGrid.setCell(cellval.rowId,"HIDDEN_STATUS_SW",null);
							$sellersGrid.setCell(cellval.rowId,"STATUS_SW","",{"background-color": ""});
							return "-";
							break;
						}	
					}
				}
			},{
				label : 'Action',
				name : 'CONDITIONS_SW',
				align : "center",
				width : 100
			},{
				label : '기회',
				name : 'OPP_AH',
				align : "center",
				editable: true,
				width : 100,
				formatter: 'integer', formatoptions:{thousandsSeparator:","}
				,editoptions:{
		            /* size: 15, maxlengh: 10, */
		            dataInit: function(element) {
			             $(element).keyup(function(){
				              var val1 = element.value;
				              var num = new Number(val1);
				              if(isNaN(num)){
				               alert("숫자만 입력해 주세요.");
				               element.value = '';
				              }
			             });
		            }
		       }
			},{
				label : '매출',
				name : 'SALES_AH',
				align : "center",
				editable: true,
				width : 100,
				formatter: 'integer', formatoptions:{thousandsSeparator:","}
				,editoptions:{
		            /* size: 15, maxlengh: 10, */
		            dataInit: function(element) {
			             $(element).keyup(function(){
				              var val1 = element.value;
				              var num = new Number(val1);
				              if(isNaN(num)){
				               alert("숫자만 입력해 주세요.");
				               element.value = '';
				              }
			             });
		            }
		       }
			},{
				label : 'Align',
				name : 'ALIGN_AH',
				align : "center",
				width : 80
			},{
				label : 'Status',
				name : 'STATUS_AH',
				align : "center",
				editable: true,
				edittype:"select",
				formatter:'select',
				width : 80,
				formatter: function (rowId, cellval , colpos, rwdat, _act){
					if(rwdat == "edit"){
						switch (rowId) {
						case "Green":
							$sellersGrid.jqGrid('setCell', cellval.rowId, 'HIDDEN_STATUS_AH', 'G');
							$sellersGrid.setCell(cellval.rowId,"STATUS_AH","",{"background-color": "#1ab394"});
							return "";
							break;
						case "Yellow":
							$sellersGrid.jqGrid('setCell', cellval.rowId, 'HIDDEN_STATUS_AH', 'Y');
							$sellersGrid.setCell(cellval.rowId,"STATUS_AH","",{"background-color": "#ffc000"});
							return "";
							break;
						case "Red":
							$sellersGrid.jqGrid('setCell', cellval.rowId, 'HIDDEN_STATUS_AH', 'R');
							$sellersGrid.setCell(cellval.rowId,"STATUS_AH","",{"background-color": "#f20056"});
							return "";
							break;
						default:
							$sellersGrid.setCell(cellval.rowId,"HIDDEN_STATUS_AH",null);
							$sellersGrid.setCell(cellval.rowId,"STATUS_AH","",{"background-color": ""});
							return "-";
							break;
						}	
					}
				}
			},{
				label : 'Action',
				name : 'CONDITIONS_AH',
				align : "center",
				width : 100
			},{
				label : 'ALIGNMENT_ID_HW',
				name : 'ALIGNMENT_ID_HW',
				hidden : true
			},{
				label : 'ALIGNMENT_ID_SW',
				name : 'ALIGNMENT_ID_SW',
				hidden : true
			},{
				label : 'ALIGNMENT_ID_AH',
				name : 'ALIGNMENT_ID_AH',
				hidden : true
			},{
				label : 'HIDDEN_STATUS_HW',
				name : 'HIDDEN_STATUS_HW',
				hidden : true
			},{
				label : 'HIDDEN_STATUS_SW',
				name : 'HIDDEN_STATUS_SW',
				hidden : true
			},{
				label : 'HIDDEN_STATUS_AH',
				name : 'HIDDEN_STATUS_AH',
				hidden : true
			}
			
			],
			loadui: 'disable',
			loadonce : true,
			viewrecords : true,
			gridview: true,	
			//rowList : [ 10, 20, 30 ],
			autowidth : true,
			height : "100%",
			//sortable:true, 컬럼 위치 마우스 드래그로 바꾸는건데 버그있는듯? 확인 필요
			onCellSelect : function(ids, icol) {
			},
			loadBeforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
				$.ajaxLoadingShow();
			},
			loadComplete : function(data){
				noDataFn(this);
				$.ajaxLoadingHide();
				
				var list = data.rows;
				for(var i=0; i<list.length; i++ ){
					if(list[i].STATUS_HW == 'G'){
						$sellersGrid.setCell(i+1,"STATUS_HW","Green",{"background-color": "#1ab394"});
					}else if(list[i].STATUS_HW == 'Y'){
						$sellersGrid.setCell(i+1,"STATUS_HW","Yellow",{"background-color": "#ffc000"});
					}else if(list[i].STATUS_HW == 'R'){
						$sellersGrid.setCell(i+1,"STATUS_HW","Red",{"background-color": "#f20056"});
					}else if(isEmpty(list[i].STATUS_HW)){
						$sellersGrid.setCell(i+1,"STATUS_HW","-");
					}
					
					if(list[i].STATUS_SW == 'G'){
						$sellersGrid.setCell(i+1,"STATUS_SW","Green",{"background-color": "#1ab394"});
					}else if(list[i].STATUS_SW == 'Y'){
						$sellersGrid.setCell(i+1,"STATUS_SW","Yellow",{"background-color": "#ffc000"});
					}else if(list[i].STATUS_SW == 'R'){
						$sellersGrid.setCell(i+1,"STATUS_SW","Red",{"background-color": "#f20056"});
					}else if(isEmpty(list[i].STATUS_SW)){
						$sellersGrid.setCell(i+1,"STATUS_SW","-");
					}
					
					if(list[i].STATUS_AH == 'G'){
						$sellersGrid.setCell(i+1,"STATUS_AH","Green",{"background-color": "#1ab394"});
					}else if(list[i].STATUS_AH == 'Y'){
						$sellersGrid.setCell(i+1,"STATUS_AH","Yellow",{"background-color": "#ffc000"});
					}else if(list[i].STATUS_AH == 'R'){
						$sellersGrid.setCell(i+1,"STATUS_AH","Red",{"background-color": "#f20056"});
					}else if(isEmpty(list[i].STATUS_AH)){
						$sellersGrid.setCell(i+1,"STATUS_AH","-");
					}
				}
				
			},
			loadError : function(xhr, status, err) {
				$.error(xhr, status, err);
			}
		}).jqGrid('setGroupHeaders', {
			  useColSpanStyle: true, 
			  groupHeaders:[
				          	{startColumnName: 'OPP_HW', numberOfColumns: 5, titleText: 'IBM H/W'},
				          	{startColumnName: 'OPP_SW', numberOfColumns: 5, titleText: 'IBM S/W'},
				          	{startColumnName: 'OPP_AH', numberOfColumns: 5, titleText: 'AHNLAB'}
			  ]
		});
	},
	
	reload : function(){
		$sellersGrid.jqGrid('setGridParam', { 
				url : "/partnerManagement/gridRecruitment.do?",
				datatype : 'json',
				mtype: 'POST',
				postData : { 
					selectAccountYear:$("#selectAccountYear").val(), 
					selectViewList:$("#selectViewList").val() 
				}
			}
		).trigger('reloadGrid');
	}
}

/*
 * 항목보기 설정
 */
$(".table-menu-wrapper2 input[name='toggle-cols']").click(function(){
	if($(this).is(":checked")){
		$('#sellersGrid').showCol($(this).val());
		$sellersGrid.jqGrid('setGridWidth', gridWidth, true);
	}else{
		$sellersGrid.hideCol($(this).val());
		$sellersGrid.jqGrid('setGridWidth', gridWidth, true);
	}
});

/*
 *  sample 템플릿 다운로드
 */
 /* 
var selectSampleFile = function(file) {
	$("#formSampleFile input[name='sampleFileName']").val('');
	$("#formSampleFile input[name='sampleFileName']").val(file.innerHTML);
	$("#formSampleFile").attr("action","/common/sampleDownloadFile.do");
	$("#formSampleFile").submit();
}
 */
//항목보기
 $("#table-menu-btn").click(function(){
	 $("div.table-menu-wrapper2 .table-menu").toggle();
 });
 
//저장하기
 $("#buttonSaveCapacity").click(function(){
	 var gridLength = $sellersGrid.jqGrid('getGridParam', 'records');
	$sellersGrid.jqGrid('saveRow', lastEdit);
	for(var i=1; i<=gridLength; i++){
		$sellersGrid.jqGrid('saveRow', i);
	}
	$.ajax({
		url : "/partnerManagement/insertRecruitment.do",
		datatype : 'json',
		type : "POST",
		data : {
			recruitmentData : JSON.stringify($sellersGrid.getRowData()),
			creator_id : $("#hiddenModalCreatorId").val(),
			selectAccountYear : $("#selectAccountYear").val(),
			selectViewList : $("#selectViewList").val(),
			datatype : 'json'
		},
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
			if (!confirm("저장하시겠습니까?")){
				lastEdit = 0;
				return false;	
			}
            $.ajaxLoadingShow();
		},
		success : function(result){
			if(result.cnt > 0){
				alert("저장하였습니다.");
				lastEdit = 0;
			}else{
				alert("저장을 실패했습니다.\n관리자에게 문의하세요.");	
			}
		},
		complete : function(){
			$.ajaxLoadingHide();
		}
	});
 });
 
 //회계년도, view선택 변경 시
 $("#selectAccountYear, #selectViewList").change(function(){
	 var param = "?selectAccountYear="+$("#selectAccountYear").val()+"&selectViewList="+$("#selectViewList").val();
	 //location.href="/partnerManagement/listRecruitment.do"+param;
	 location.href="/partnerManagement/viewPartnerRecruitment.do"+param;
 });
 
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>