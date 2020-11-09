<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<!-- 
 * @author 	: 장성훈
 * @Date		: 2016. 06 - 02
 * @explain	: 영업활동 -> 고객개인정보
 -->
 
<div class="row wrapper border-bottom white-bg page-heading">
	     <!-- <div class="col-sm-6">
	         <h2>고객사 정보</h2>
	         <ol class="breadcrumb">
	             <li>
	                 <a href="/main/index.do">Home</a>
	             </li>
	             <li>
	                 <a>고객사 및 고객개인정보</a>
	             </li>
	             <li class="active">
	                 <strong>고객사정보</strong>
	             </li>
	         </ol>
	     </div> -->
	<div class="col-sm-6">
        <div class="time-update">
            <!-- <span class="text-muted small pull-right">최근 업데이트: <i class="fa fa-clock-o"></i><span id="LATELY_UPDATE_DATE"></span></span> -->
        </div>
		<div class="search-common" style="display: none;">
			<div class="input-default" style="margin:0;">
				<span onclick="modal.reset();">
					<a href="#" class="btn" style="color:#666; border:solid 1px #e6eaed; margin-left:5px !important;">고객사 추가</a>
				</span>
			</div>
			<div class="input-default" style="margin:0;">
                  	<span class="input-group-btn">
              			<a href="#" class="btn btn-search-option"><i class="fa fa-search"></i> 검색</a>
              		</span>
                            
              		<div class="search-detail collapse">
                    <div class="singleSearch">
                  		<input type="text" placeholder="고객사명 또는 고객명을 입력하십시오" class="input form-control" id="serchDetail" value="">
                  		<button type="button" class="btn btn-w-s btn-seller" onclick="searchDetailClick.getList()"><i class="fa fa-search"></i></button>
               		</div>
			   	</div>
                    	
			</div>
		</div>
	</div>
</div>
   
<div class="wrapper wrapper-content animated fadeInRight">
           	<div class="row" id="row">
	 			<!-- <div style="margin:0; position: relative;">
	                <div>
	                    <div>
	                        <input type="text" placeholder="고객사명을 입력하십시오" id="textListSearchDetail" value="" 
	                        style="background-color: #FFFFFF; background-image: none; border: 1px solid #e5e6e7; border-radius: 1px; color: inherit; 
	                        padding: 6px 12px; transition: border-color 0.15s ease-in-out 0s, box-shadow 0.15s ease-in-out 0s; font-size: 14px; width: 26%;">
	                        <button type="button" onclick="$('#serchDetail').val($('#textListSearchDetail').val()); searchDetailClick.getList()" class="btn" style="margin-right: -50px; background-color: #2dbae7; border-color: #2dbae7; color: #fff;">
	                        	<i class="fa fa-search"></i>
	                        </button>
	                    </div>
	                </div>
	            </div> -->
	            
	            <div class="gateArea">
	            		<!-- CRUD 권한만 신규등록 가능 -->
	            		<%-- <c:choose>
							<c:when test="${fn:contains(auth, 'ROLE_CRUD')}"> --%>
		                        <div class="newArea ag_c">
		                            <img src="../images/pc/gate_img1.png" class="thum mg-b10" />
		                            <p class="mg-b10">신규 고객사를 등록하세요.</p>
		
		                            <button type="button" onclick="modal.reset();" class="btn btn-green r3">고객사 등록</button>
		                        </div>
		                     <%-- </c:when>
		                </c:choose> --%>
                        <div class="searchArea  ag_c" <%-- <c:if test="${!fn:contains(auth, 'ROLE_CRUD')}">style="width:100%;"</c:if> --%>>
                            <img src="../images/pc/gate_img2.png" class="thum mg-b10" />
                            <p class="mg-b10">고객사명을 입력하세요.</p>

                            <!-- <div class="pgsearch pos-rel"> -->
                            <div class="pgsearch">
                                <input type="text" id="textListSearchDetail" onkeydown="if(event.keyCode == 13){$('#serchDetail').val($('#textListSearchDetail').val()); searchDetailClick.getList();}"/>
                                <button type="button" onclick="$('#serchDetail').val($('#textListSearchDetail').val()); searchDetailClick.getList();" class="btn"><i class="fa fa-search"></i> 검색</button>
                            	<input type="hidden" id=hiddenNone" />
                            </div>
                            <!-- <button type="button" onclick="searchDetailClick.getList();" class="btn">나의 영업영역 전체보기</button> -->
                        </div>
                    </div>
			</div>
			<jsp:include page="/WEB-INF/jsp/pc/clientManagement/clientCompanyInfoModal.jsp"/>
			
</div>
   
   
   
  <!-- form 영역 -->
  
  <form id="formSearch" name="formSearch">
  	<input type="hidden" id="hiddenSearchType" />
  	<input type="hidden" id="hiddenSearchTypeDetailCategory" name="detailCategory"/> 
  	<input type="hidden" id="hiddenSearchTypeDetailCompanyName" name="companyName"/> 
  	<input type="hidden" id="hiddenSearchTypeSysUpdateDate" name="SysUpdateDate"/>
  	<input type="hidden" id="hiddenSearchTypePKArray" name="searchPKArray"/>
  	<input type="hidden" id="hiddenSearchTypeResultInSearch" name="resultInSearch"/>
  	<input type="hidden" id="hiddenFilePK" name="filePKArray" value=""/>
  </form>
  
  <form id="formDetail">
	<input type="hidden" id="customer_id" name="customer_id">
	<input type="hidden" id="company_id" name="company_id">
	<input type="hidden" id="searchDetail" name="searchDetail">
	<input type="hidden" id="opportunity_id" name="opportunity_id">
	<input type="hidden" id="issue_id" name="issue_id">
	<input type="hidden" id="returnProjectMGMTId" name="returnProjectMGMTId">
	<input type="hidden" id="returnPK" name="returnPK">
</form>
	
</body>

<script type="text/javascript">
/*
 *  전역변수
 */
var modalReset = "${param.modalReset}";
 
var compare_before;
var compare_after;
var compareFlag = false;
 
$(document).ready(function() {
	commonSearch.company($("#textListSearchDetail"), $("#hiddenNone"), $("#hiddenNone"));
	
	if(modalReset) {
		// 타이틀 설정
		menuCookieSet("고객사정보");
		setTitle();
		setActiveMenu();
		modal.reset();
	}
	
	/*
		검색창에서 엔터 눌렀을 때 이벤트 발생.
	*/
	/* $("#textListSearchDetail").keypress(function(e) { 
	    if (e.keyCode == 13 && !isEmpty($("#textListSearchDetail").val())){
	    	$('#serchDetail').val($('#textListSearchDetail').val()); 
	    	searchDetailClick.getList();
	    }    
	}); */
	
	//모달 hidden event
	$('#myModal1').on('hide.bs.modal', function () {
		compare_after = $("#formModalData").serialize();
		if(modalFlag == "upd"){
			if(compare_before != compare_after){
				if(confirm("내용이 수정되었습니다.\n저장하시겠습니까?")) {
					compareFlag = true;
					$("#buttonModalSubmit").trigger("click");
				}else{
					attrChk = true;
				}
			}
		}else{ //신규등록이면
			if(compare_before != compare_after){
				if(confirm("창을 닫으면 입력한 정보가 지워집니다.\n창을 닫으시겠습니까?")) {
					$("#divModalFile p").hide();
				}else{
					return false;
					attrChk = true;
				}
			}
		}
	});
	
});

var page = {
		start : 1,
		end : 20,
		totalCount : null,
		serchStart : 1,
		serchEnd :20
}

 var searchDetailClick = {
		checkText : function() {
			//if($("#textListSearchDetail").val() != '' && $("#textListSearchDetail").val() != null) {
			if(!isEmpty($("#textListSearchDetail").val()))	{
				$('#serchDetail').val($('#textListSearchDetail').val());
				searchDetailClick.getList();
			}else {
				alert("검색어를 입력해 주세요.");
			}
		},
		
		getList : function(){
			var params = $.param({
				serchInfo : $("#serchDetail").val(),
				creatorId : $("#hiddenModalCreatorId").val(),
				pageStart : 1,
				pageEnd : 20,
				serch : 2,
				datatype : 'json'
			});
			$.ajax({
				//url : "/clientManagement/gridClientCompanyInfoView2.do",
				url : "/clientManagement/gridClientCompanyInfo.do",
				datatype : 'json',
				method: 'POST',
				data : params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoading();
				},
				success : function(data){
					//$("div#row").html(data);
					console.log(data);
					if(data.rows.length > 0) searchDetailClick.goDetail(data.rows["0"].COMPANY_ID);
					else alert('검색 결과가 없습니다.');
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		goDetail : function(companyId){
			/* $("#formDetail #customer_id").val(clientNo); */
			$("#formDetail #searchDetail").val($("#textListSearchDetail").val());
			//$("#formDetail #company_id").val(companyId);
			$("#formDetail").attr({action:"/clientManagement/viewClientCompanyInfoDetail.do", method:"post"}).submit();
		}
}
 
//============================================================
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>