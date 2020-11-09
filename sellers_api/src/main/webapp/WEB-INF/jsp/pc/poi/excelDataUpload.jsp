<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<%@ include file="/WEB-INF/jsp/pc/poi/excelDataSampleFilePath.jsp"%>
<style>
ul.adminAuth > li:hover{
	background-color: yellow;
}
</style>
<div class="row wrapper border-bottom white-bg page-heading">
   <!--  <div class="col-sm-6">
        <h2>엑셀 Data Upload</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>엑셀 Data Upload</a>
            </li>
            <li class="active">
                <strong>엑셀 Data Upload</strong>
            </li>
        </ol>
    </div> -->
</div>

	<br /><br />
    <!-- <div class="fl_l template-doc">
    	<button type="button" class="btn btn-outline btn-seller-outline" id="selectSampleFile" onclick="selectSampleFile(this);">엑셀양식 다운로드</button>
    </div> -->
    
    <table id="poiManage"></table>
    <form id="formData" name="formData" method="post" enctype="multipart/form-data">
    <div class="form-group pd-b10">
    	<div class="file-dragdrap-area crb-file col-sm-11">
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
	    
	    <!--
	    성과관리랑 ERP 대시보드만 사용하기에 주석 
	    <div class="col-sm-1">
		    <div class="fl_l template-doc">
			    <button type="button" class="fileUpload btn btn-gray" onClick="poiManage.downExcel();">양식다운로드</button>
		    </div>
	    </div>
	     -->
	    
	</div>
    	<div class="fl_l template-doc">
		    <select class="form-control" id="selectExcelForm" name="selectExcelForm" onchange="poiManage.selectExcelSheet();">
		    	<!-- 
		    	성과관리랑 ERP 대시보드만 사용하기에 주석
		    	<option value="1">고객사정보</option>
		    	<option value="0">고객개인정보</option>
		    	<option value="2">자사직원정보</option>
		    	<option value="3">자사부서정보</option>
		    	<option value="4">자사팀정보</option>
		    	<option value="5">파트너사정보</option>
		    	<option value="6">파트너사직원정보</option>
		    	 -->
		    	<!-- <option value="7">산업코드</option> -->
		    	<!-- 
		    	<option value="7">파트너사코드</option>
		    	<option value="8">직원 Target</option>
		    	 -->
		    	<option value="9">성과관리</option>
		    	<option value="10">ERP대시보드</option>
		    	
		    	
		    	<!-- 
		    	<option value="8">협력사솔루션영역</option>
		    	<option value="9">거래처신용평가</option>
		    	<option value="10">프로젝트수주현황</option>
		    	<option value="11">거래처미수금현황</option>
		    	 -->
		    </select>
	    </div>
	    <div class="fl_l template-doc">
		    <button type="submit" class="btn btn-w-m btn-seller" onClick="poiManage.getFileName();">엑셀 업로드</button>
	    </div>
	    
	    <!-- 
	    성과관리랑 ERP 대시보드만 사용하기에 주석
	    <div class="fl_l template-doc">
			<button type="button" class="btn btn-outline btn-seller-outline" id="selectSampleFile">결과 다운로드</button>
				<ul class="template-list off">
					//<li><a href="javascript:void(0);" onclick="selectSampleFile(this);">셀러스_필요데이터_양식_v1.41.xlsx</a></li>
					<li><a href="javascript:void(0);" onclick="downFile.selectSampleFile(this, 'excelFile');">셀러스_필요데이터_양식_v1.41.xlsx</a></li>
				</ul>
		</div>
		 -->
		 
	    <!-- 
	    <button type="button" onClick="poiManage.insert();">신규등록</button>
	    <button type="button" onClick="poiManage.update();">저장하기</button>
	     -->
	    <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
    </form>
</div>
</div>

<!-- 
<form id="formSampleFile" name="formSampleFile" method="post">
 	<input type="hidden" name="sampleFileName" value="셀러스_필요데이터_양식_유니.xlsx"/>
</form>
 -->
 
</body>


<script type="text/javascript">
$(document).ready(function(){
	//poiManage.init();
});

var poiManage = {
		//변수		
		lastEdit : 0,
		url : '',
		form : 'ClientCompanyInfo',
		
		init: function(){
			$poiManage = $("#poiManage");
			poiManage.lastEdit = 0;
			//poiManage.draw();
		},
		
		selectExcelSheet : function() {
			poiManage.form = "";
			switch($('#selectExcelForm option:selected').val()){
        	
			case '0' :
        		poiManage.form = "ClientIndividualInfo";
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
				poiManage.form = "ErpSalesPlan";
				break;
				
			case '9' :
				poiManage.form = "ErpSalesActual";
				break;
			case '10' :
				poiManage.form = "ErpDashBoard";
				break;
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
				
				if(poiManage.url == "/poi/xlsReadErpDashBoard.do")
				{
					alert("Excel 2007(데이터가공용) 파일로 업로드 바랍니다.");
					return false;
				}
				else
				{
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
			            	alert("Excel 업로드 성공!\n'결과 다운로드'를 클릭하여 업로드 상태를 확인하십시오.");
			            	
			            	window.location.reload();
			            	//poiManage.insert(data.rows);
			                //성공후 서버에서 받은 데이터 처리
			            },
			            complete : function(){
							$.ajaxLoadingHide();
						}
			        });
				}
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
					if(data.rows == 0){
						var fileName = "셀러스_필요데이터_양식_v1.41.xlsx";
						downExcel(fileName);
						alert("양식을 다운로드 하였습니다.");
					}else if(data.rows == -1){
						alert("해당 디렉토리에 샘플파일이 존재하지 않습니다. \n관리자에게 문의하세요.")
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		}
}
/* 
//결과
var selectSampleFile = function(file) {
	$("#formSampleFile input[name='sampleFileName']").val('');
	$("#formSampleFile input[name='sampleFileName']").val(file.innerHTML);
	$("#formSampleFile").attr("action","/common/sampleDownloadFile.do?menuFlag=excelFile");
	$("#formSampleFile").submit();
}

 */
//양식
var downExcel = function(fileName) {
	
	$("#formSampleFile input[name='sampleFileName']").val('');
	$("#formSampleFile input[name='sampleFileName']").val(fileName);
	$("#formSampleFile").attr("action","/common/sampleExcelDownloadFile.do");
	$("#formSampleFile").submit();
}

/* function moveAuthPage(url){
	location.href = url;
} */
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>
