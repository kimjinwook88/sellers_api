<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<style>
ul.adminAuth > li:hover{
	background-color: yellow;
}
</style>

<div class="row wrapper border-bottom white-bg page-heading">
   <!--  <div class="col-sm-6">
        <h2>직원 Target 입력</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>관리자페이지</a>
            </li>
            <li class="active">
                <strong>직원 Target 입력</strong>
            </li>
        </ol>
    </div> -->
</div>

<div class="wrapper wrapper-content  animated fadeInRight">
	<div class="row">
	   	<div class="ibox">
      		<div class="ibox-content border_n pd-no">
           		<div class="clear">
           		
           		<div>
           			<form id="formData" name="formData" method="post" enctype="multipart/form-data">
					    <div class="form-group pd-b10">
					    	<div class="fl_l file-dragdrap-area col-sm-7">
					    	</div>
					    	
					    	<div class="fl_l file-dragdrap-area col-sm-4">
						        <div class="fileUpload btn btn-seller">
						            <span>파일찾기</span>
						             <input type="file" name="filePOI" id="filePOI" onchange="if(this.value!=''){poiManage.selectExcelSheet();poiManage.fileCheck(this);}" class="upload"/>
						             <!-- <input type="file" name="filePOI" id="filePOI" onchange="if(this.value!='')poiManage.fileCheck();"> -->
						        </div>
						        <div class="file-in-list" id="divFileUploadList">
						            <span class="blank-ment">
								  		업로드할 파일을 등록해 주세요.
						            </span>
						        </div>
						        
						    </div>
						    
						    <div class="fl_r col-sm-1">
							    <div class="template-doc">
								    <button type="button" class="fileUpload btn btn-gray" onClick="memberTarget.downExcel();">양식다운로드</button>
							    </div>
						    </div>
						    
						</div>
						<div class="form-group pd-b10">
					    	<div class="fl_l template-doc" style="display: none;">
							    <select class="form-control" id="selectExcelForm" name="selectExcelForm" onchange="poiManage.selectExcelSheet();">
							    	<!-- <option value="1">고객사정보</option>
							    	<option value="0">고객개인정보</option>
							    	<option value="2">자사직원정보</option> -->
							    	<!-- <option value="3">자사부서정보</option> -->
							    	<!-- <option value="4">자사팀정보</option>
							    	<option value="5">협력사정보</option>
							    	<option value="6">협력사직원정보</option> -->
							    	<!-- <option value="7">산업코드</option> -->
							    	<!-- <option value="7">협력사코드</option> -->
							    	<option value="0">직원 Target</option>
							    	
							    	
							    	<!-- 
							    	<option value="8">협력사솔루션영역</option>
							    	<option value="9">거래처신용평가</option>
							    	<option value="10">프로젝트수주현황</option>
							    	<option value="11">거래처미수금현황</option>
							    	 -->
							    </select>
						    </div>
						    
						    <div class="fl_r template-doc col-sm-1">
								<button type="button" class="btn btn-outline btn-seller-outline" id="selectSampleFile">결과 다운로드</button>
									<ul class="template-list off">
										<li><a href="javascript:void(0);" onclick="selectSampleFile(this);">셀러스_직원_Target데이터_양식_v1.41.xlsx</a></li>
									</ul>
							</div>
							
						    <div class="fl_r template-doc col-sm-1">
							    <button type="submit" class="btn btn-w-m btn-seller" onClick="poiManage.getFileName();">엑셀 업로드</button>
						    </div>
						</div>
							
					    <!-- 
					    <button type="button" onClick="poiManage.insert();">신규등록</button>
					    <button type="button" onClick="poiManage.update();">저장하기</button>
					     -->
					    <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
				    </form>
           		
           		</div>
	
					<div class="selgrid selgrid1 mg-r5" style="padding-top: 20px;">
						<select class="form-control m-b" name="selectTargetYear" id="selectTargetYear" onChange="memberTarget.reload();">
						</select>
					</div>

	    			<table id="memberTarget"></table>
				    <c:if test="${fn:contains(auth, 'ROLE_CEO') or fn:contains(auth, 'ROLE_ADMIN') or fn:contains(auth, 'ROLE_CRUD')}"> 
				    <div class="func-top-right fl_r pd-b10">
				    	<button type="button" class="btn btn-outline btn-gray-outline" onClick="memberTarget.update();">전체 저장하기</button>
				    </div>
				    <!-- <button type="button" onClick="memberTarget.update();">저장하기</button> -->
					</c:if>
				</div>
			</div>
		</div>

	</div>
</div>
</body>
<form id="formSampleFile" name="formSampleFile" method="post">
 	<input type="hidden" name="sampleFileName" value="셀러스_필요데이터_양식.xlsx"/>
</form>


<script type="text/javascript">
$(document).ready(function(){
	memberTarget.init();
});

var memberTarget = {
		//변수		
		lastEdit : 0,
		
		init: function(){
			var nowYear = parseInt(moment().format('YYYY'));
			$('#selectTargetYear').html("");
			for(var i=(nowYear+1); i>=(nowYear-5); i--){
				$('#selectTargetYear').append('<option value='+i+'>'+i+'년</option>');
			}
			$('#selectTargetYear').val(nowYear);
			$memberTarget = $("#memberTarget");
			memberTarget.lastEdit = 0;
			memberTarget.draw();
		},
		
		//저장
		update : function(){
			memberTarget.saveRow();
			$.ajax({
				url : '/admin/updateMemberTarget.do',
				async : true,
	 			datatype : 'json',
	 			method: 'POST',
	 			data : {
	 				memberTargetList : JSON.stringify($memberTarget.getRowData())	,
	 				searchTargetYear : $('#selectTargetYear').val()
	 			},
	 			beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm($('#selectTargetYear').val()+'년'+' Target을 저장하시겠습니까?')) return false;
					$.ajaxLoadingShow();
				},
				success : function(data){
					var cnt = data.cnt;
					if(cnt > 0){
						alert("저장하였습니다.");
						memberTarget.reload();
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		//개별저장
		updateOne : function(rowId){
			memberTarget.saveRow();
			$.ajax({
				url : '/admin/updateMemberTarget.do',
				async : true,
	 			datatype : 'json',
	 			method: 'POST',
	 			data : {
	 				memberTargetList : "["+JSON.stringify($memberTarget.getRowData(rowId))+"]",
	 				searchTargetYear : $('#selectTargetYear').val()
	 			},
	 			beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm($('#selectTargetYear').val()+'년'+' Target을 저장하시겠습니까?')) return false;
					$.ajaxLoadingShow();
				},
				success : function(data){
					var cnt = data.cnt;
					if(cnt > 0){
						alert("저장하였습니다.");
						memberTarget.reload();
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		//그리드 그리기
		draw : function() {
			$memberTarget.jqGrid({
				url : '/admin/selectMemberTarget.do',
	 			mtype: 'POST',
	 			datatype : 'json',
	 			postData : {
	 				searchTargetYear : $('#selectTargetYear').val()
	 			},
				 jsonReader : { 
				    root: "rows",
				},  
				colModel : [ {
					label : '사번',
					name : 'MEMBER_ID_NUM',
					align : "center",
					width : 55
				}, {
					label : '이름',
					name : 'HAN_NAME',
					align : "center",
					width : 55
				},{
					label : '저장',
					name : 'SAVE',
					align : "center",
					width : 55,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						return "<button type='button' class='btn btn-outline btn-gray-outline' onClick='memberTarget.updateOne("+cellval.rowId+");'>저장</button>"; 
					}
				},{
					label : 'REV',
					name : 'TARGET_REV_1',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'GP',
					name : 'TARGET_GP_1',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'REV',
					name : 'TARGET_REV_2',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'GP',
					name : 'TARGET_GP_2',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'REV',
					name : 'TARGET_REV_3',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'GP',
					name : 'TARGET_GP_3',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'REV',
					name : 'TARGET_REV_4',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'GP',
					name : 'TARGET_GP_4',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'REV',
					name : 'TARGET_REV_5',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'GP',
					name : 'TARGET_GP_5',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'REV',
					name : 'TARGET_REV_6',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'GP',
					name : 'TARGET_GP_6',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'REV',
					name : 'TARGET_REV_7',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'GP',
					name : 'TARGET_GP_7',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'REV',
					name : 'TARGET_REV_8',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'GP',
					name : 'TARGET_GP_8',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'REV',
					name : 'TARGET_REV_9',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'GP',
					name : 'TARGET_GP_9',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'REV',
					name : 'TARGET_REV_10',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'GP',
					name : 'TARGET_GP_10',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'REV',
					name : 'TARGET_REV_11',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'GP',
					name : 'TARGET_GP_11',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'REV',
					name : 'TARGET_REV_12',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : 'GP',
					name : 'TARGET_GP_12',
					align : "right",
					width : 80,
					formatter: 'integer',
					formatoptions:{thousandsSeparator:","},
					editable: true
				},{
					label : '저장',
					name : 'SAVE',
					align : "center",
					width : 55,
					formatter: function (rowId, cellval , colpos, rwdat, _act){
						return "<button type='button' class='btn btn-outline btn-gray-outline' onClick='memberTarget.updateOne("+cellval.rowId+");'>저장</button>"; 
					}
				}
				],
				rowNum : 200,
				autowidth : true,
				height : "100%",
				shrinkToFit: false,
				onCellSelect : function(id, icol) { //row 선택시 처리. id는 선택한 row
					if(icol != 2 && icol != 27){
						$(this).jqGrid('saveRow',memberTarget.lastEdit,true);
						$(this).jqGrid('editRow',id,true);
						memberTarget.lastEdit = id;
					}
				},
				loadBeforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				loadComplete : function(data){
				},
				loadError : function(xhr, status, err) {
					$.error(xhr, status, err);
				}
			}).jqGrid('setGroupHeaders', {
				  useColSpanStyle: true, 
				  groupHeaders:[
					          	{startColumnName: 'TARGET_REV_1', numberOfColumns: 2, titleText: '1월'},
					          	{startColumnName: 'TARGET_REV_2', numberOfColumns: 2, titleText: '2월'},
					          	{startColumnName: 'TARGET_REV_3', numberOfColumns: 2, titleText: '3월'},
					          	{startColumnName: 'TARGET_REV_4', numberOfColumns: 2, titleText: '4월'},
					          	{startColumnName: 'TARGET_REV_5', numberOfColumns: 2, titleText: '5월'},
					          	{startColumnName: 'TARGET_REV_6', numberOfColumns: 2, titleText: '6월'},
					          	{startColumnName: 'TARGET_REV_7', numberOfColumns: 2, titleText: '7월'},
					          	{startColumnName: 'TARGET_REV_8', numberOfColumns: 2, titleText: '8월'},
					          	{startColumnName: 'TARGET_REV_9', numberOfColumns: 2, titleText: '9월'},
					          	{startColumnName: 'TARGET_REV_10', numberOfColumns: 2, titleText: '10월'},
					          	{startColumnName: 'TARGET_REV_11', numberOfColumns: 2, titleText: '11월'},
					          	{startColumnName: 'TARGET_REV_12', numberOfColumns: 2, titleText: '12월'}
				  ]
			});
		},
		
		clear : function(){
			$memberTarget.jqGrid('clearGridData');
		},
		
		reload : function(){
			$memberTarget.jqGrid(
				'setGridParam', 
				{
					url : '/admin/selectMemberTarget.do',
		 			mtype: 'POST',
		 			datatype : 'json',
		 			postData : {
		 				searchTargetYear : $('#selectTargetYear').val()
		 			},
					 jsonReader : { 
					    root: "rows",
					}
	 			}
			).trigger('reloadGrid');
		},
		
		saveRow : function(){
			var gridLength = $memberTarget.jqGrid('getGridParam', 'records');
			for(var i=1; i <=gridLength; i++){
				$memberTarget.jqGrid('saveRow', i);
			}
			$memberTarget.jqGrid('saveRow', memberTarget.lastEdit);
		},
		
		
		downExcel : function(){
			$.ajax({
				url : "/poi/xlsxDownloadExcelFile.do",
				datatype : 'json',
				data : {
					flag : "Target"
				},
				async : false,
				method : 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					if(data.rows == 0){
						var fileName = "셀러스_직원_Target데이터_양식_v1.41.xlsx";
						downExcel(fileName);
						alert("양식을 다운로드 하였습니다.");
					}else if(data.rows == -1){
						alert("해당 디렉토리에 샘플파일이 존재하지 않습니다. \n 관리자에게 문의하세요.")
					}
					
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		}
			
		
}

var poiManage = {
		//변수		
		lastEdit : 0,
		url : '',
		form : 'ErpSalesPlan',
		
		init: function(){
			$poiManage = $("#poiManage");
			poiManage.lastEdit = 0;
			//poiManage.draw();
		},
		
		selectExcelSheet : function() {
			poiManage.form = "";
			switch($('#selectExcelForm option:selected').val()){
        	case '0' :
        		poiManage.form = "ErpSalesPlan";
				break;
			case '1' :
				poiManage.form = "ClientCompanyInfo";
				break;
			case '2' :
				poiManage.form = "OurMembersInfo";
				break;
			case '3' :
				poiManage.form = "OurDivisionInfo";
				break;
			case '4' :
				poiManage.form = "OurTeamInfo";
				break;
			case '5' :
				poiManage.form = "PartnerCompanyInfo";
				break;
			case '6' :
				poiManage.form = "PartnerIndividualInfo";
				break;
			/* case '7' :
				poiManage.form = "CodeIndustrySegment";
				break; */
			case '7' :
				poiManage.form = "CodePartnerSegment";
				break;
			case '8' :
				poiManage.form = "ClientIndividualInfo";
			/* 
			case '8' :
				poiManage.form = "VendorSolutionArea";
				break;
			case '9' :
				poiManage.form = "ErpCompanyCredit";
				break;
			case '10' :
				poiManage.form = "ErpSalesProject";
				break;
			case '11' :
				poiManage.form = "ErpCompanyAr";
				break;
			 */	
        	}
		},
		
		fileCheck : function(path) {
			var ext = $('#filePOI').val().split('.').pop().toLowerCase();

			if(ext == 'xls'){
				poiManage.url = '/poi/xlsRead'+ poiManage.form +'.do';
				poiManage.upload(path);
			}else if(ext == 'xlsx'){
				poiManage.url = '/poi/xlsxRead'+ poiManage.form +'.do';
				poiManage.upload(path);
			}else if(ext != ''){
				alert("엑셀파일을 선택하세요.");
				$("#filePOI").val("");
				poiManage.url = '';
				return false;
			}else{
				alert("엑셀파일을 선택하세요.");
				return false;
			}
		},
		
		upload : function(obj){
			var file = $(obj)[0].files[0];
			var fileFlag = true;
			
			$("#divFileUploadList span:visible").each(function(idx){
				if(file.name.trim() == $(this).text().trim()){
					//$(obj).remove();
					//$("div.fileUpload.btn.btn-seller").append('<input type="file" name="filePOI" id="filePOI" onchange="if(this.value!=\'\')poiManage.fileCheck(this);" class="upload"/>');
					fileFlag = false;
					return false;
				}
			});
			if(fileFlag){
				commonFile.checkExtension(file.name);
				//if(commonFile.returnIcon != false){
					$("#divFileUploadList span.blank-ment").hide();
					//$(obj).hide();
					//$("div.fileUpload.btn.btn-seller").append('<input type="file" name="filePOI" id="filePOI" onchange="if(this.value!=\'\')poiManage.fileCheck(this);" class="upload"/>');
					$("#divFileUploadList").html('<span name="spanUploadFile" style="padding-left:5px;"><i class="fa fa-file-'+commonFile.returnIcon+'-o fa-lg"></i> '+file.name+' <a href="javascript:void(0);" onClick="poiManage.removeFileElement(this,\''+file.name+'\');"><i class="fa fa-times-circle"></i></a></span>');
					//$("#divFileUploadList").append('<span name="spanUploadFile" style="padding-left:5px;"><i class="fa fa-file-'+commonFile.returnIcon+'-o fa-lg"></i> '+file.name+' <a href="javascript:void(0);" onClick="poiManage.removeFileElement(this,\''+file.name+'\');"><i class="fa fa-times-circle"></i></a></span>');
				//}
			}
		},
		
		removeFileElement : function(obj,fileName){
			$("input[name='filePOI']").each(function(i,v){
				if($(this)[0].files[0]){
					if(($(this)[0].files[0].name == fileName) && $(this).css("display") == "none"){
						$(this).remove();
					}
				}
			});
			$(obj).parent("span[name='spanUploadFile']").remove();
			if($("#divFileUploadList span:visible").not(".blank-ment").length == 0){
				$("#filePOI").val("");
				//$("#divFileUploadList span.blank-ment").show();
				$("#divFileUploadList").html('<span class="blank-ment">업로드할 파일을 등록해 주세요.</span>');
			}
		},
		
		getFileName : function(){
			poiManage.fileCheck($("#filePOI"));
			if(!isEmpty(poiManage.url)){
				$('#formData').ajaxForm({
		    		url : poiManage.url,
		    		async : true,
		    		method: 'POST',
		    		dataType: "json",
		 			data : {
		 				form : $('#selectExcelForm option:selected').val(),
		 				creatorId : $('#hiddenModalCreatorId').val()
		 			},
		            beforeSubmit: function (data,form,option) {
		            	$.ajaxLoadingShow();
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function(data){
		            	alert("Excel 업로드 성공");
		            	//poiManage.insert(data.rows);
		                //성공후 서버에서 받은 데이터 처리
		            },
		            complete: function() {
		            	$.ajaxLoadingHide();
					}
		        });
			}else{
				//alert("파일을 선택하세요.");
			}
			
		},
		
		downExcel : function(){
			$.ajax({
				url : "/poi/xlsxDownloadExcelFile.do",
				datatype : 'json',
				data : {
					flag : "noTarget"
				},
				async : false,
				method : 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					var fileName = "셀러스_필요데이터_양식_v1.41.xlsx";
					downExcel(fileName);
					alert("양식을 다운로드 하였습니다.");
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		}
}

var downExcel = function(fileName) {
	
	$("#formSampleFile input[name='sampleFileName']").val('');
	$("#formSampleFile input[name='sampleFileName']").val(fileName);
	$("#formSampleFile").attr("action","/common/sampleExcelDownloadFile.do");
	$("#formSampleFile").submit();
}

//결과
var selectSampleFile = function(file) {
	$("#formSampleFile input[name='sampleFileName']").val('');
	$("#formSampleFile input[name='sampleFileName']").val(file.innerHTML);
	$("#formSampleFile").attr("action","/common/sampleDownloadFile.do");
	$("#formSampleFile").submit();
}

function moveCodePage(url){
	location.href = url;
}
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>
