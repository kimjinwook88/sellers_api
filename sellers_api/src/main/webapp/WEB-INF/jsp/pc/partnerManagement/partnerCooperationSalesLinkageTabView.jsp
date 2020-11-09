<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<!-- 
 * @author 	: 욱이
 * @Date		: 2016. 07 - 27
 * @explain	: 영업활동 -> 벤더사영업 -> 벤더사협업
 -->	
		 <div class="row wrapper border-bottom white-bg page-heading">
			  <!-- <div class="col-sm-6">
                  <h2>파트너사 협업</h2>
                  <ol class="breadcrumb">
                      <li>
                          <a href="/main/index.do">Home</a>
                      </li>
                      <li>
                          <a>파트너사협업관리</a>
                      </li>
                      <li class="active">
                          <strong>파트너사 협업</strong>
                      </li>
                  </ol>
              </div> -->
		     <div class="col-sm-6">
		         <!-- <div class="time-update">
		             <span class="text-muted small pull-right">최근 업데이트: <i class="fa fa-clock-o"></i><span id="LATELY_UPDATE_DATE"></span></span>
		         </div> -->
		     </div>
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
                            	        <li class=""><a href="/partnerManagement/viewPartnerRecruitment.do">2.Recruitment</a></li>
                         	            <li class=""><a href="/partnerManagement/viewPartnerEnablement.do">3.파트너 교육</a></li>
                         	            <li class="active"><a href="/partnerManagement/viewPartnerSalesLinkage.do">4.파트너사 협업</a></li>
                         	            <li class=""><a href="/partnerManagement/viewPartnerFullfillment.do">5.파트너사 비지니스 현황</a></li>
                      	            </ul>
                           		</div>
                            	
                            	<!-- <h3>파트너 협업</h3> -->
                            	
                               <div class="pos-rel">
                                    <div class="func-top-left fl_l">
                                        <!-- <div class="table-menu-wrapper2 fl_l mg-r10 mg-t7 m-b">
                                            <a href="#" class="table-menu-btn" id="table-menu-btn"><i class="fa fa-th-list"></i> 항목보기 설정</a>
	                                            <div class="table-menu" style="z-index:1000;display:none;">
												     <ul>
												         <li><input type="checkbox" name="toggle-cols" value="ISSUE_CATEGORY" checked="checked"> <label for="toggle-col-1">고객/산업</label></li>
												         <li><input type="checkbox" name="toggle-cols" value="COMPANY_NAME" checked="checked"> <label for="toggle-col-2">제품</label></li>
												         <li><input type="checkbox" name="toggle-cols" value="ISSUE_CREATOR" checked="checked"> <label for="toggle-col-3">파트너사</label></li>
												         <li><input type="checkbox" name="toggle-cols" value="ISSUE_SUBJECT"checked="checked"> <label for="toggle-col-4">영업직원</label></li>
												         <li><input type="checkbox" name="toggle-cols" value="SOLVE_OWNER"    checked="checked"> <label for="toggle-col-5">인력</label></li>
												         <li><input type="checkbox" name="toggle-cols" value="ISSUE_DATE" checked="checked"> <label for="toggle-col-6">스킬</label></li>
												         <li><input type="checkbox" name="toggle-cols" value="DUE_DATE" checked="checked"> <label for="toggle-col-7">재무역량</label></li>
												         <li><input type="checkbox" name="toggle-cols" value="ISSUE_CLOSE_DATE" checked="checked"> <label for="toggle-col-8">차별화가치</label></li>
												         <li><input type="checkbox" name="toggle-cols" value="ISSUE_STATUS" checked="checked"> <label for="toggle-col-9">평가결과</label></li>
												     </ul>
											 	</div>
                                        </div> -->
                                        <div class="table-sel-view fl_l">
                                            <div class="selgrid selgrid1 mg-r5">
                                                <select class="form-control m-b" name="account" id="selectAccountYear">
                                                      <c:choose>
														<c:when test="${fn:length(searchDetailGroup.linkage_year) > 0}">
															<c:forEach items="${searchDetailGroup.linkage_year}" var="searchDetailGroup">
							                                    <option value="${searchDetailGroup.FISCAL_YEAR}" <c:if test="${selectAccountYear eq searchDetailGroup.FISCAL_YEAR}">selected="selected"</c:if>>${searchDetailGroup.FISCAL_YEAR}년</option>
				                                    		</c:forEach>
				                                    	</c:when>
				                                    	<c:otherwise>
				                                    			<option value="">== 년도선택 ==</option>
				                                    	</c:otherwise>
				                                    </c:choose>
                                                </select>
                                            </div>
                                            <div class="selgrid selgrid1 mg-r5" style="width: 300px;">
                                                <input type="text" placeholder="파트너사를 검색해주세요" style="width: 150px;display: inline;" class="input form-control" id="textSearchVendor" onkeydown="if(event.keyCode == 13){jqGrid.reload();}">
                                                <button type="button" onclick="jqGrid.reload();">검색</button>
                                            </div>
                                            <%-- <div class="selgrid selgrid1 mg-r5">
                                                <select class="form-control m-b" name="account" id="selectViewList">
			                                    	<option value="in" <c:if test="${selectViewList eq 'in'}">selected="selected"</c:if>>산업</option>
			                                    	<option value="bp" <c:if test="${selectViewList eq 'bp'}">selected="selected"</c:if>>고객사</option>
		                                   		</select>
                                            </div> --%>
                                        </div>
                                    </div>
                                    <div class="func-top-right fl_r pd-b20">
                                        <div class="fl_l">
                                        	<button type="button" class="btn btn-w-m btn-seller" id="buttonOpenCreateModal">파트너사 협업 생성</button>
                                        </div>
                                    </div>
                                </div>
                                	<br /><br /><br />
                                    <!-- <table id="tech-companies" ></table> -->
                                    <table id="sellersGrid" ></table>
                                    <div id="jqGridPager"></div>
                                	<!-- <div id="pager"></div> -->
                                <!-- 
                                <p class="text-right">
                                    <button type="button" class="btn btn-outline btn-primary btn-seller-outline">선택 삭제</button>
                                    <button type="button" class="btn btn-w-m btn-primary btn-seller">신듀등록</button>
                                </p> -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        </div>
        </div>
        
		<jsp:include page="/WEB-INF/jsp/pc/partnerManagement/partnerCooperationSalesLinkageModal.jsp"/>
		
		 <!-- 분류생성 팝업 -->
        <div class="newCata-pop" style="display:none;">
            <div class="pop-header">
                <button type="button" class="close" data-dismiss="modal" onClick="$('div.newCata-pop').hide();"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <strong class="pop-title">파트너사 협업 생성</strong>
            </div>
            <div class="col-sm-12 cont">
                <div class="col-sm-12 m-b">
                    <label class="control-label" for="date_modified">생성년도</label>
                    <select class="form-control" name="account" id="selectCreateYear">
                    </select>
                </div>
                <div class="col-sm-12 m-b ta-c">
                    <button type="button" class="btn btn-w-m btn-primary btn-seller mg-r10" id="buttonCreateSalesLinkage">생성하기</button>
                </div>
            </div>
        </div>
</body>

<script type="text/javascript">
/*
 *  전역변수
 */
var gridWidth;
var chkcell = {cellId:undefined, chkval:undefined};
var maxYear = "${searchDetailGroup.max_linkage_year[0].FISCAL_YEAR}";
var oneCheck = 0 ; //데이터 갯수가 1개일때 제대로 동작 안해서 처리 해주는 부분

//var modalFlag = 
//$("#buttonModalSubmit").trigger("click");

$(document).ready(function() {
	
	//$("#menu_title_1").html('파트너사 협업');
	//$("#menu_title_2").html('파트너사 협업');
	
	//그리드 생성
	jqGrid.draw();
	$sellersGrid.css("cursor","pointer");
	
	//그리드 크기를 가져올 변수
	gridWidth = $sellersGrid.jqGrid('getGridParam', 'width');
	
	//모달 hidden event
	$('#myModal1').on('hide.bs.modal', function () {
		/* compare_after = $("#formModalData").serialize();
		if(compare_before != compare_after){
			if(confirm("내용이 수정되었습니다.\n저장하시겠습니까?")) {
				compareFlag = true;
				$("#buttonModalSubmit").trigger("click");
			}
		}
		$("#divModalFile p").hide(); */
	});
	
	if(maxYear == commonDate.year){
		$("#buttonOpenCreateModal").hide();
	}else{
		$("#buttonOpenCreateModal").show();
	}
	
});

/*
 *  jqGrid function()
 */
var jqGrid = {
	draw : function() {
		$sellersGrid.jqGrid('clearGridData');
		$sellersGrid.jqGrid({
 			url : "/partnerManagement/gridSalesLinkage.do",
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
				label : '파트너사',
				name : 'COMPANY_NAME',
				align : "center",
				width : 150,
				cellattr : jsFormatterCell
			},{
				label : '유형',
				name : 'PARTNER_CODE',
				align : "center",
				width : 100
			},{
				label : '영업대표',
				name : 'SALES_NAME',
				align : "center",
				width : 90
			}, {
				label : 'BP직원',
				name : 'PARTNER_INDIVIDUAL_ID',
				align : "center",
				width : 90
			}/*,{
					label : '직책',
					name : 'ISSUE_SUBJECT',
					align : "center",
					width : 100
				},{
				label : '연락처',
				name : 'SOLVE_OWNER',
				align : "center",
				width : 100
			} ,{
				label : '자사 영업직원',
				name : 'ISSUE_DATE',
				align : "center",
				width : 120
			}, {
				label : '관련 지원직원',
				name : 'DUE_DATE',
				align : "center",
				width : 120
			} */, {
				label : '주기',
				name : 'CADENCE_CYCLE',
				width : 80
			}, {
				label : 'type',
				name : 'CADENCE_TYPE',
				width : 80
			}, {
				label : '1월',
				name : 'MONTH_1',
				align : "center",
				width : 80,
				formatter: function (rowId, cellval , colpos, rwdat, _act){
					if(rwdat == "add"){
						if(!isEmpty(colpos.MONTH_1)){
							var html = "";
							var arr = colpos.MONTH_1.split(" ");
							for(var i=0; i<arr.length; i++){
								if(arr[i] == "O"){
									html += '<img src="/images/pc/icon_check.png" alt="">';
								}else if(arr[i] == "X"){
									html += '<img src="/images/pc/icon_check_no.png" alt="">';
								}
								if(i == 2){
									html += '<br />'
								}
								if(i != 4){ //띄어쓰기
									html += ' ';
								}
							}
							return html;
						}else{
							return "";
						}
					}
				}
			}, {
				label : '2월',
				name : 'MONTH_2',
				align : "center",
				width : 80,
				formatter: function (rowId, cellval , colpos, rwdat, _act){
					if(rwdat == "add"){
						if(!isEmpty(colpos.MONTH_2)){
							var html = "";
							var arr = colpos.MONTH_2.split(" ");
							for(var i=0; i<arr.length; i++){
								if(arr[i] == "O"){
									html += '<img src="/images/pc/icon_check.png" alt="">';
								}else if(arr[i] == "X"){
									html += '<img src="/images/pc/icon_check_no.png" alt="">';
								}
								if(i == 2){
									html += '<br />'
								}
								if(i != 4){ //띄어쓰기
									html += ' ';
								}
							}
							return html;
						}else{
							return "";
						}
					}
				}
			}, {
				label : '3월',
				name : 'MONTH_3',
				width : 80,
				formatter: function (rowId, cellval , colpos, rwdat, _act){
					if(rwdat == "add"){
						if(!isEmpty(colpos.MONTH_3)){
							var html = "";
							var arr = colpos.MONTH_3.split(" ");
							for(var i=0; i<arr.length; i++){
								if(arr[i] == "O"){
									html += '<img src="/images/pc/icon_check.png" alt="">';
								}else if(arr[i] == "X"){
									html += '<img src="/images/pc/icon_check_no.png" alt="">';
								}
								if(i == 2){
									html += '<br />'
								}
								if(i != 4){ //띄어쓰기
									html += ' ';
								}
							}
							return html;
						}else{
							return "";
						}
					}
				}
			}, {
				label : '4월',
				name : 'MONTH_4',
				width : 80,
				formatter: function (rowId, cellval , colpos, rwdat, _act){
					if(rwdat == "add"){
						if(!isEmpty(colpos.MONTH_4)){
							var html = "";
							var arr = colpos.MONTH_4.split(" ");
							for(var i=0; i<arr.length; i++){
								if(arr[i] == "O"){
									html += '<img src="/images/pc/icon_check.png" alt="">';
								}else if(arr[i] == "X"){
									html += '<img src="/images/pc/icon_check_no.png" alt="">';
								}
								if(i == 2){
									html += '<br />'
								}
								if(i != 4){ //띄어쓰기
									html += ' ';
								}
							}
							return html;
						}else{
							return "";
						}
					}
				}
			},{
				label : '5월',
				name : 'MONTH_5',
				width : 80,
				formatter: function (rowId, cellval , colpos, rwdat, _act){
					if(rwdat == "add"){
						if(!isEmpty(colpos.MONTH_5)){
							var html = "";
							var arr = colpos.MONTH_5.split(" ");
							for(var i=0; i<arr.length; i++){
								if(arr[i] == "O"){
									html += '<img src="/images/pc/icon_check.png" alt="">';
								}else if(arr[i] == "X"){
									html += '<img src="/images/pc/icon_check_no.png" alt="">';
								}
								if(i == 2){
									html += '<br />'
								}
								if(i != 4){ //띄어쓰기
									html += ' ';
								}
							}
							return html;
						}else{
							return "";
						}
					}
				}
			},{
				label : '6월',
				name : 'MONTH_6',
				width : 80,
				formatter: function (rowId, cellval , colpos, rwdat, _act){
					if(rwdat == "add"){
						if(!isEmpty(colpos.MONTH_6)){
							var html = "";
							var arr = colpos.MONTH_6.split(" ");
							for(var i=0; i<arr.length; i++){
								if(arr[i] == "O"){
									html += '<img src="/images/pc/icon_check.png" alt="">';
								}else if(arr[i] == "X"){
									html += '<img src="/images/pc/icon_check_no.png" alt="">';
								}
								if(i == 2){
									html += '<br />'
								}
								if(i != 4){ //띄어쓰기
									html += ' ';
								}
							}
							return html;
						}else{
							return "";
						}
					}
				}
			},{
				label : '7월',
				name : 'MONTH_7',
				width : 80,
				formatter: function (rowId, cellval , colpos, rwdat, _act){
					if(rwdat == "add"){
						if(!isEmpty(colpos.MONTH_7)){
							var html = "";
							var arr = colpos.MONTH_7.split(" ");
							for(var i=0; i<arr.length; i++){
								if(arr[i] == "O"){
									html += '<img src="/images/pc/icon_check.png" alt="">';
								}else if(arr[i] == "X"){
									html += '<img src="/images/pc/icon_check_no.png" alt="">';
								}
								if(i == 2){
									html += '<br />'
								}
								if(i != 4){ //띄어쓰기
									html += ' ';
								}
							}
							return html;
						}else{
							return "";
						}
					}
				}
			},{
				label : '8월',
				name : 'MONTH_8',
				width : 80,
				formatter: function (rowId, cellval , colpos, rwdat, _act){
					if(rwdat == "add"){
						if(!isEmpty(colpos.MONTH_8)){
							var html = "";
							var arr = colpos.MONTH_8.split(" ");
							for(var i=0; i<arr.length; i++){
								if(arr[i] == "O"){
									html += '<img src="/images/pc/icon_check.png" alt="">';
								}else if(arr[i] == "X"){
									html += '<img src="/images/pc/icon_check_no.png" alt="">';
								}
								if(i == 2){
									html += '<br />'
								}
								if(i != 4){ //띄어쓰기
									html += ' ';
								}
							}
							return html;
						}else{
							return "";
						}
					}
				}
			},{
				label : '9월',
				name : 'MONTH_9',
				width : 80,
				formatter: function (rowId, cellval , colpos, rwdat, _act){
					if(rwdat == "add"){
						if(!isEmpty(colpos.MONTH_9)){
							var html = "";
							var arr = colpos.MONTH_9.split(" ");
							for(var i=0; i<arr.length; i++){
								if(arr[i] == "O"){
									html += '<img src="/images/pc/icon_check.png" alt="">';
								}else if(arr[i] == "X"){
									html += '<img src="/images/pc/icon_check_no.png" alt="">';
								}
								if(i == 2){
									html += '<br />'
								}
								if(i != 4){ //띄어쓰기
									html += ' ';
								}
							}
							return html;
						}else{
							return "";
						}
					}
				}
			},{
				label : '10월',
				name : 'MONTH_10',
				width : 80,
				formatter: function (rowId, cellval , colpos, rwdat, _act){
					if(rwdat == "add"){
						if(!isEmpty(colpos.MONTH_10)){
							var html = "";
							var arr = colpos.MONTH_10.split(" ");
							for(var i=0; i<arr.length; i++){
								if(arr[i] == "O"){
									html += '<img src="/images/pc/icon_check.png" alt="">';
								}else if(arr[i] == "X"){
									html += '<img src="/images/pc/icon_check_no.png" alt="">';
								}
								if(i == 2){
									html += '<br />'
								}
								if(i != 4){ //띄어쓰기
									html += ' ';
								}
							}
							return html;
						}else{
							return "";
						}
					}
				}
			},{
				label : '11월',
				name : 'MONTH_11',
				width : 80,
				formatter: function (rowId, cellval , colpos, rwdat, _act){
					if(rwdat == "add"){
						if(!isEmpty(colpos.MONTH_11)){
							var html = "";
							var arr = colpos.MONTH_11.split(" ");
							for(var i=0; i<arr.length; i++){
								if(arr[i] == "O"){
									html += '<img src="/images/pc/icon_check.png" alt="">';
								}else if(arr[i] == "X"){
									html += '<img src="/images/pc/icon_check_no.png" alt="">';
								}
								if(i == 2){
									html += '<br />'
								}
								if(i != 4){ //띄어쓰기
									html += ' ';
								}
							}
							return html;
						}else{
							return "";
						}
					}
				}
			},{
				label : '12월',
				name : 'MONTH_12',
				width : 85,
				formatter: function (rowId, cellval , colpos, rwdat, _act){
					if(rwdat == "add"){
						if(!isEmpty(colpos.MONTH_12)){
							var html = "";
							var arr = colpos.MONTH_12.split(" ");
							for(var i=0; i<arr.length; i++){
								if(arr[i] == "O"){
									html += '<img src="/images/pc/icon_check.png" alt="">';
								}else if(arr[i] == "X"){
									html += '<img src="/images/pc/icon_check_no.png" alt="">';
								}
								if(i == 2){
									html += '<br />'
								}
								if(i != 4){ //띄어쓰기
									html += ' ';
								}
							}
							return html;
						}else{
							return "";
						}
					}
				}
			},{
				label : 'LINKAGE_ID',
				name : 'LINKAGE_ID',
				hidden : true
			},{
				label : 'PARTNER_ID',
				name : 'PARTNER_ID',
				hidden : true
			}
			
			//{name:'NO',index:'NO', sortable:true, hidden:false, formatter:'number'}
			],
			loadui: 'disable',
			loadonce : true,
			rowNum : "${searchDetailGroup.category_count}"*3,
			gridview: true,	
			height : "100%",
			autowidth : true,
			pager: "#jqGridPager",
			onCellSelect : function(ids, icol) {
				var rowData = $(this).jqGrid("getRowData",ids);
				
				$("#hiddenModalPK").val(rowData.LINKAGE_ID);
				$("#textModalCompany").val(rowData.COMPANY_NAME);
				$("#textModalSegment").val(rowData.PARTNER_CODE);
				$("#textModalSalesMan").val(rowData.SALES_NAME);
				$("#textModalPartnerName").val(rowData.PARTNER_INDIVIDUAL_ID);
				
				//radioModalCadenceCycle
				//radioModalCadenceType
				$("input:radio[name='radioModalCadenceCycle'][value="+rowData.CADENCE_CYCLE+"]").prop("checked",true);
				$("input:radio[name='radioModalCadenceType'][value="+rowData.CADENCE_TYPE+"]").prop("checked",true);
				
				//Cadence 이력
				$.ajax({
					url : "/partnerManagement/selectCadenceDateList.do",
					datatype : 'json',
					type : "POST",
					data : {
						linkage_id : rowData.LINKAGE_ID,
						datatype : 'json'
					},
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$("#selectModalCadenceDate").html("");
					},
					success : function(data){
						var list = data.selectCadenceDateList
						if(!isEmpty(list)){
							for(var i=0; i<list.length; i++){
								$('#selectModalCadenceDate').append(
									'<option value='+list[i].CADENCE_ID+'>'+list[i].EXEC_DATE+'</option>'		
								)
							}
						}else{
							
						}
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
				
				//modal reset
				modal.resetCadence();
				modal.cadenceHistory();
				
				//Action Plan
				modal.actionPlanClear();
				modal.drawCadenceActionPlan(null);
				modal.actionPlanReload(null);
				
				$("h4.modal-title").html(rowData.COMPANY_NAME);
				$("small.font-bold").html(rowData.PARTNER_CODE);
				
				$("#myModal1").modal();
				compare_before = $("#formModalData").serialize(); //값 비교를 위한.
			},
			onPaging : function(action) { //paging 부분의 버튼 액션 처리  first, prev, next, last, records
				/*  if(action == 'next'){
					currPage = getGridParam("page");
				} */
			},
			loadBeforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
				$.ajaxLoadingShow();
			},
			loadComplete : function(data){
				var grid = this;
				
				//No Data 처리 bottom.jsp
				noDataFn(this);

			    /* 최근 업데이트 */
			    /* if(data.rows.length > 0){
			    	$("#LATELY_UPDATE_DATE").html(data.rows[0].LATELY_UPDATE_DATE);	
			    } */
			    $('td[name="cellRowspan"]', grid).each(function(){
			    	var spans = $('td[rowspanid="'+this.id+'"]', grid).length+1;
			    	if(spans > 1){
			    		$(this).attr('rowspan',spans);
			    	}
			    });
			    
			    $.ajaxLoadingHide();
			},
			loadError : function(xhr, status, err) {
				$.error(xhr, status, err);
			}
		});
	},
	
	reload : function(){
		$sellersGrid.jqGrid('clearGridData');
		$sellersGrid.jqGrid('setGridParam', { 
			url : "/partnerManagement/gridSalesLinkage.do",
 			datatype : 'json',
			mtype: 'POST',
			 jsonReader : { 
			    root: "rows"
			},
			postData : {
				selectAccountYear : $("#selectAccountYear").val(),
				selectViewList : $("#selectViewList").val(),
				searchvendor : $("#textSearchVendor").val()
			},
			loadui: 'disable',
			loadonce : true,
			viewrecords : true,
			rowNum : "${searchDetailGroup.category_count}"*3,
			gridview: true,	
			height : "100%",
			autowidth : true,
			pager: "#jqGridPager"
		}).trigger('reloadGrid');
	}
}


//생성 팝업
$("#buttonOpenCreateModal").click(function(){
	$("div.newCata-pop").show();
	$("#selectCreateYear").html("");
	$("#selectCreateYear").append('<option value='+commonDate.year+'>'+commonDate.year+'년</option>');
});

//생성하기
$("#buttonCreateSalesLinkage").click(function(){
	var params = $.param({
		selectCreateYear:$("#selectCreateAccountYear").val(),
		create_id : "${userInfo.MEMBER_ID_NUM}",
		datatype : 'json'
	},true);
	
	$.ajax({
		url : "/partnerManagement/createSalesLinkage.do",
		datatype : 'json',
		type : "POST",
		data : params,
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
	    	$.ajaxLoadingShow();
		},
		success : function(data){
			if(data.cnt  > 0){
				alert("생성 하였습니다.");
				var param = "?selectAccountYear="+$("#selectCreateYear").val();
				location.href = "/partnerManagement/viewPartnerSalesLinkage.do"+param
			}else{
				alert("생성을 실패했습니다.\n관리자에게 문의하세요.");
			}
		},
		complete : function(){
			$.ajaxLoadingHide();
		}
	});
});
	
	
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
 *  항목보기
 */
 $("#table-menu-btn").click(function(){
	 $("div.table-menu-wrapper2 .table-menu").toggle();
 });
 
 //년도, view선택 변경 시
 $("#selectAccountYear, #selectViewList").change(function(){
	 var param = "?selectAccountYear="+$("#selectAccountYear").val()+"&selectViewList="+$("#selectViewList").val();
	 location.href="/partnerManagement/viewPartnerSalesLinkage.do"+param;
 });
 
 function jsFormatterCell(rowid, val, rowObject, cm, rdata){
	 var result = "";
	 if(chkcell.chkval != val){
		 var cellId = this.id + '_row_' + rowid + '-' +cm.name;
		 result = 'rowspan="1" id="'+cellId+'" name="cellRowspan"';
		 chkcell = {cellId:cellId, chkval:val};
		 oneCheck = 0;
	 }else{
		 oneCheck ++;
		 //데이터 갯수가 1개일때 rowspan 제대로 동작 안해서 처리 해주는 부분
		 if(oneCheck == "${searchDetailGroup.category_count}"){
			 var cellId = this.id + '_row_' + rowid + '-' +cm.name;
			 result = 'rowspan="'+"${searchDetailGroup.category_count}"+'" id="'+cellId+'" name="cellRowspan"';
			 chkcell = {cellId:cellId, chkval:val};		 
			 oneCheck = 0;
		 }else{
			 result = 'style="display:none" rowspanid="' + chkcell.cellId + '"';			 
		 }
	 }
	 return result;
 }
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>