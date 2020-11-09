<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="modal inmodal fade" id="myModal1" tabindex="-1" role="dialog"  aria-hidden="true">
   <div class="modal-dialog modal-lg">
       <div class="modal-content">
           <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
               <h4 class="modal-title">고객사정보 보기</h4>
               <!-- <small class="font-bold">고객사정보 세부정보입니다. </small> -->
           </div>
           <div class="modal-body" >
               <div class="row">
                   <div class="col-lg-12">
                       <div class="ibox float-e-margins">
                           <!-- <div class="ibox-title">
                               <h5>고객사정보 상세보기</h5>
                               <div class="ibox-tools">
                                   <a class="collapse-link">
                                       <i class="fa fa-chevron-up" id="iModalArrow"></i>
                                   </a>
                               </div>
                           </div> -->
                           <form class="form-horizontal" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">
                           <!-- 아래것 주석 걸려있어서 IE작동 안함 -->
                           <!-- onsubmit="return false" -->
                           <div class="ibox-content border_n" id="divModalToggle">
                               <div class="form-group">
                                    <div class="col-sm-12 ag_r" name="divModalNameAndCreateDate" id="divModalNameAndCreateDate">작성자 : 홍길동 / 작성일 : 2016-05-10</div>
                                </div>
                                <div class="hr-line-dashed"></div>
                               		<div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객사명</label>
                                        <div class="col-sm-4"><input type="text" class="form-control" id="textModalCompanyName" name="textModalCompanyName" autocomplete="off"/></div>
                                    	<label class="col-sm-2 control-label">고객사 아이디</label>
                                        <div class="col-sm-4"><input type="text" class="form-control" id="textModalCompanyId" name="textModalCompanyId" readonly="readonly" /></div>
                                    </div>
                               <%--  <div class="hr-line-dashed"></div>
                                    <div class="form-group">
										<label class="col-sm-2 control-label">고객분류</label>
                                    	<div class="col-sm-4">
                                    		<select class="form-control" name="selectModalClientCategory" id="selectModalClientCategory">
                                    			<spring:eval expression="@config['code.clientCompanyCategory']" />
                                    		</select>
                                    	</div>
                                    </div> --%>
									
									<!-- <div id="divModalCompanyLeader">
	                                    <div class="form-group"><label class="col-sm-2 control-label">CEO</label>
	                                        <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalCeoName" name="textModalCeoName" autocomplete="off"/></div>
	                                        <input type="hidden" class="form-control" id="hiddenModalCeoID" name="hiddenModalCeoID" />
	                                    </div>
                               			<div class="hr-line-dashed"></div>
	                                   <div class="form-group">
	                                        <label class="col-sm-2 control-label">COO</label>
	                                        <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalCioName" name="textModalCioName" autocomplete="off"/></div>
	                                        <input type="hidden" class="form-control" id="hiddenModalCioID" name="hiddenModalCioID" />
	                                        <label class="col-sm-2 control-label">CFO</label>
	                                        <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalCtoName" name="textModalCtoName" autocomplete="off"/></div>
	                                        <input type="hidden" class="form-control" id="hiddenModalCtoID" name="hiddenModalCtoID" />
	                                   </div>
                               		</div> -->	
                               		
                               		<div class="hr-line-dashed"></div>
		                                   <div class="form-group">
		                                        <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 산업분류</label>
		                                        <div class="col-sm-4"><select class="form-control" id="selectModalSegmentCode" name="selectModalSegmentCode"></select></div>
		                                        <label class="col-sm-2 control-label">사업자등록번호</label>
		                                        <div class="col-sm-4"><input type="text" class="form-control" id="textModalBusinessNumber" name="textModalBusinessNumber" autocomplete="off"/></div>
		                                   </div>
		                           	   		<div class="hr-line-dashed"></div>
		                                       <div class="form-group"><label class="col-sm-2 control-label">대표전화</label>
		                                        <div class="col-sm-4"><input type="text" class="form-control" placeholder="예) 0212345678" id="textModalCompanyTelno" name="textModalCompanyTelno" onblur="autoHypen(this);" onkeyup="commonCheck.onlyNumber(this);" autocomplete="off"/></div>
		                                        <!-- <label class="col-sm-2 control-label">우편번호</label>
		                                       <div class="col-sm-4"><input type="text" class="form-control" id="textModalPostalCode" name="textModalPostalCode" /></div> -->
		                                   		</div>      
		                               		<div class="hr-line-dashed"></div>
		                                   	<div class="form-group"><label class="col-sm-2 control-label">주소</label>
		                                       <div class="col-sm-10"><input type="text" class="form-control" id="textModalPostalAddress" name="textModalPostalAddress" autocomplete="off"/></div>
		                                   	</div>
		                                   	
		                                   	<!-- 아래부터는 탭으로 변경 -->
		                                   	<div class="hr-line-bottom"></div>
		                                   	
		                                   	<div class="tab-area">
		                                   		<!-- tab-menu -->
	                                            <ul class="tabmenu-type">
	                                                <li><a class="sel" onclick="modal.goTab('1');">기본정보</a></li>
	                                                <li><a class=""  onclick="modal.goTab('2');">IT정보</a></li>
	                                            </ul>
	                                            <!--// tab-menu -->
	                                            
	                                            <!-- tab-cont -->

	                                            <!-- 기본정보 -->
	                                            <div class="sub_cont scont1 modaltabmenu">
	                                            	<jsp:include page="/WEB-INF/jsp/pc/clientManagement/clientCompanyInfoBasicModal.jsp"/>
	                                            </div>
	                                            
	                                            <!-- 상세정보 -->
	                                            <div class="sub_cont scont2 modaltabmenu off">
	                                            	<jsp:include page="/WEB-INF/jsp/pc/clientManagement/clientCompanyInfoDetailModal.jsp"/>
	                                            </div>
		                                   	</div>
		                                   	
		                                   	
		                                   	<!-- <div class="hr-line-dashed"></div>
		                                   	<div class="form-group"><label class="col-sm-2 control-label">업태</label>
		                                        <div class="col-sm-4"><input type="text" class="form-control" id="textModalBusinessType" name="textModalBusinessType" /></div>
		                                       	<label class="col-sm-2 control-label">종목</label>
		                                        <div class="col-sm-4"><input type="text" class="form-control" id="textModalBusinessSector" name="textModalBusinessSector" /></div>
		                                   	</div>
		                          	   		
		                          	   		<div class="hr-line-dashed"></div>
		                                   	<div class="form-group"><label class="col-sm-2 control-label">ERP등록번호</label>
		                                    <div class="col-sm-4"><input type="text" class="form-control" id="textModalErpRegCode" name="textModalErpRegCode" /></div>
		                                    </div>
											   
											<div class="hr-line-dashed"></div>
		                                   	<div class="form-group"><label class="col-sm-2 control-label">조직도</label>
		                                       <div class="col-sm-10 custom-photo">
		                                       		<label for="fileModalUploadPhoto"><a class="fileUpload btn btn-gray" onclick="modal.browserCheck();" style="color: white">사진첨부</a></label>
		                                       	</div>
		                                       	<div class="col-sm-12 m-b text-center custom-photo">
				                                       <div id="divModalPhotoUploadArea">
				        									<div class="filebox photo">
				        							
				                               				<label for="fileModalUploadPhoto" style="background-color: #2dbae7;border-color:#2dbae7;color: #fff;">명함 첨부</label>
				                               					<input type="file" name="fileModalUploadPhoto" id="fileModalUploadPhoto" accept="image/*" capture="camera" onchange="getThumbnailPrivew(this,$('#divModalUploadPhoto'))" />
				        										<div id="divModalUploadPhoto">
				        											<span class="blank-ment"><img src="../images/pc/icon_org.gif" style="" class="photo" alt=""/></span>
				        										</div>
				        							
						        							</div>
						                               	</div>
				                               	</div>
											</div> -->
											
									
                                   </div>                                                                             
                                    <div class="hr-line-bottom">
	                                    
                                    </div>
                                    
                                    <%-- <c:if test="${fn:contains(auth, 'ROLE_CRUD')}"> --%>
                                    <p class="text-center">
	                                        <!-- <button type="button" class="btn btn-outline btn-gray-outline" id="buttonModalDelete" onClick="modal.deleteModal();">삭제하기</button> -->
	                                        <button type="submit" class="btn btn-w-m btn-seller" onclick="modal.submit();" id="buttonModalSubmit">저장하기</button>
	                                </p>
	                                <%-- </c:if> --%>
	                                
                                    <input type="hidden"name="hiddenModalPK" 			id="hiddenModalPK" 		value=""/>
                                    <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
                                    <input type="hidden" name="hiddenModalCompanyId" id="hiddenModalCompanyId"/>
                                    <input type="hidden" name="hiddenModalSegmentCode" id="hiddenModalSegmentCode"/>
                                    <input type="hidden" name="hiddenModalItInfoId" id="hiddenModalItInfoId"/>
                                </form>
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
</div>
                                                
                                                
                                                
<script type="text/javascript">
$(document).ready(function() { 
		modal.init();
});		

var modal = {
		init : function(){
			//유효성 체크
			modal.validate();
			
			//자동완성 검색
			commonSearch.customer($("#formModalData #textModalCeoName"), $('#formModalData #hiddenModalCeoID'), '', $("#formModalData #textModalCompanyId"));
			commonSearch.customer($("#formModalData #textModalCioName"), $('#formModalData #hiddenModalCioID'), '', $("#formModalData #textModalCompanyId"));
			commonSearch.customer($("#formModalData #textModalCtoName"), $('#formModalData #hiddenModalCtoID'), '', $("#formModalData #textModalCompanyId"));
		},
		
		deleteFile : function(fileId) {
			 $.ajax({
				url : "/common/deleteFile.do?fileId="+fileId+"&fileTableName=12&datatype=json",
				async : false,
				datatype : 'json',
				method: 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("삭제하시겠습니까?")){
						return false;	
					}
					$.ajaxLoadingShow();
				},
				success : function(data){
					if(data.cnt > 0){
						alert("삭제되었습니다.");
					}else{
						alert("파일 삭제를 실패했습니다.\n관리자에게 문의하세요.");
					}
					companyDetail.getCompanyFile();
				},
				complete: function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		//신규등록
		reset : function() { 
			var params = $.param({
				datatype : 'json'
			});
			
			modalFlag = "ins"; //신규등록
			$('#formModalData').validate().resetForm();
			
			$.ajax({ //산업분류코드
				url : "/clientManagement/selectAllIndustrySegmentCode.do",
				async : false,
				datatype : 'json',
				method : 'POST',
				data : params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					$("#selectModalSegmentCode").html('<option value="">===선택===</option>');
					$("#selectModalSegmentCode option:eq(0)").attr("selected", "selected");
					if(data.rows.length > 0){
						for(var i=0; data.rows.length>i; i++){
							$("#selectModalSegmentCode").append('<option value="'+ data.rows[i].SEGMENT_CODE +'">'+ data.rows[i].SEGMENT_HAN_NAME +'</option>');
						}
					}else{
						alert("산업분류코드를 추가해 주세요.");
					}
				},
				complete: function(){
					$.ajaxLoadingHide();
				}
			});
			
			// 탭 초기화
			modal.goTab('1');
			
			//모달 초기화
			$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;${userInfo.HAN_NAME}'+
					'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+commonDate.year+"\/"+commonDate.month+"\/"+commonDate.day+"</span>");
			//$("#divModalNameAndCreateDate").html("작성일 : "+commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			$("#formModalData input:text").val("");
			$("#formModalData select").val("");
			$("#formModalData textarea").val("");
			$("#formModalData textarea").height(1).height(33);
			/* $("#textModalSatName").val("${userInfo.HAN_NAME}"); */
			$("#formModalData #hiddenModalCompanyId").val("");
			$("div.company-current").html("");
			$("ul.company-list").html("");
			$("#buttonModalDelete").hide();
			$("#divModalCompanyLeader").hide();		
			$("#selectModalClientCategory").removeAttr("disabled");
			
			//파일
			//$("#divFileUploadList span").remove();
			//$("#divFileUploadList").append('<span class="blank-ment">선택된 파일이 없습니다</span>');
			
			//$("#divModalFile").hide();
			//$("#divModalPhotoUploadArea .fileModalUploadPhoto").hide();
			$("#divModalUploadPhoto").html('<span class="blank-ment"><img src="../images/pc/icon_org.gif" class="m-b" alt=""><br/>등록된 조직도가 없습니다.<br/>고객사의 조직도를 등록하세요.</span>');
			$('#divModalUploadPhoto span').hide();
			$('#divModalUploadPhoto .blank-ment').show();
			
			$('div[name="insertAfterMsg"]').show();
			$('a[name="buttonSaleAddRow"]').hide();
			//projectDetail.clear();
			
			//모달 오늘 날짜 입력
			$("h4.modal-title").html("고객사 신규 등록");
			$("#buttonModalSubmit").html("등록하기");
			$("small.font-bold").css('display','none');
			
			$("#formModalData #hiddenModalPK").val("");
			
			$("#companyClientInfo").jqGrid('clearGridData');
			$("#currentOpportunity").jqGrid('clearGridData');
			$("#clientIssue").jqGrid('clearGridData');
			$("#serviceProject").jqGrid('clearGridData');
			$("#salesResult").jqGrid('clearGridData');
			$("#currentContactHistory").jqGrid('clearGridData');
			
			$("#myModal1").modal();
			
			//신규등록창도 수정사항 확인.
			compare_before = $("#formModalData").serialize();
			
			//신규등록, 상세보기 div 접기 펴기
			//toggleDiv(modalFlag);
		},
		
		validate : function(){
				$("#formModalData").validate({ // joinForm에 validate를 적용
					ignore: '',
					rules : {
						textModalCompanyName : {
							required : true,
							maxlength : 20
						},
						selectModalSegmentCode : {
							required : true
						},
						textModalCompanyTelno : {
							phone : true
						},
						textModalHWServer : {
							maxlength : 1000
						},
						textModalHWStorage : {
							maxlength : 1000
						},
						textModalHWBackup : {
							maxlength : 1000
						},
						textModalHWNetwork : {
							maxlength : 1000
						},
						textModalHWSecurity : {
							maxlength : 1000
						},
						textModalSWDb : {
							maxlength : 1000
						},
						textModalSWMiddleware : {
							maxlength : 1000
						},
						textModalSWBackup : {
							maxlength : 1000
						},
						textModalSWApm : {
							maxlength : 1000
						},
						textModalSWDpm : {
							maxlength : 1000
						}
						
/* 						textareaModalContents : {
							minlength : 1,
							maxlength : 2000
						},
 */						
					//pwdConfirm:{required:true, equalTo:"#pwd"}, 
					// equalTo : id가 pwd인 값과 같아야함
					//name:"required", // 검증값이 하나일 경우 이와 같이도 가능
					//personalNo1:{required:true, minlength:6, digits:true},
					// minlength : 최소 입력 개수, digits: 정수만 입력 가능
					//personalNo2:{required:true, minlength:7, digits:true},
					//email:{required:true, email:true},
					// email 형식 검증
					//blog:{required:true, url:true}
					// url 형식 검증
					},
					messages : { // rules에 해당하는 메시지를 지정하는 속성
						textModalCompanyName : {
							required : "고객사를 입력하세요.",
							maxlength: $.validator.format('{0}자 내로 입력하세요.')
						},
						selectModalSegmentCode : {
							required : "산업분류를 선택하세요."
						},
						textModalHWServer : {
							maxlength : "1000글자 이하여야 합니다"
						},
						textModalHWStorage : {
							maxlength : "1000글자 이하여야 합니다"
						},
						textModalHWBackup : {
							maxlength : "1000글자 이하여야 합니다"
						},
						textModalHWNetwork : {
							maxlength : "1000글자 이하여야 합니다"
						},
						textModalHWSecurity : {
							maxlength : "1000글자 이하여야 합니다"
						},
						textModalSWDb : {
							maxlength : "1000글자 이하여야 합니다"
						},
						textModalSWMiddleware : {
							maxlength : "1000글자 이하여야 합니다"
						},
						textModalSWBackup : {
							maxlength : "1000글자 이하여야 합니다"
						},
						textModalSWApm : {
							maxlength : "1000글자 이하여야 합니다"
						},
						textModalSWDpm : {
							maxlength : "1000글자 이하여야 합니다"
						}
						
					},
					errorPlacement : function(error, element) {
					    if($(element).prop("id") == "textModalCompanyName") {
					    	$("#textModalCompanyName").after(error);
					        location.href = "#textModalCompanyName";
					    }
					    else {
					        error.insertAfter(element); // default error placement.
					    }
					}
				});
		},  
		
		submit : function(){
				var browser = getIEVersionCheck();
				var url;
				(modalFlag == "ins") ? url = "/clientManagement/insertClientCompanyInfo.do" : url = "/clientManagement/updateClientCompanyInfo.do";
				 $('#formModalData').ajaxForm({
		    		url : url,
		    		type: "POST",  
		    		async : true,
		    		dataType: "json",
		    		data : {
		    			datatype : 'json',
		    			browser : browser
		    		},
		            beforeSubmit: function (data,form,option) {
		            	if(!compareFlag){
							if(!confirm("저장하시겠습니까?")){
								return false;
							}
		            	}
		            	$.ajaxLoadingShow();
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function(data){
		                //성공후 서버에서 받은 데이터 처리
		                if(data.cnt > 0){
	                		if(modalFlag=="upd"){
	                			/* $('#projectDetail').jqGrid('saveRow', lastEditRowQ);
	                			projectDetail.insertQualification(); */
	                		}
		                	compare_before = $("#formModalData").serialize();
		                	compareFlag = false;
		                	attrChk = true;
		                	alert("저장하였습니다.");
		                	if(modalFlag=="ins"){
		                		$("#textListSearchDetail").val($("#textModalCompanyName").val());
		                		$("#hiddenModalPK").val(data.filePK);
		                		compare_before = $("#formModalData").serialize();
		                		searchDetailClick.goDetail(data.filePK);
		                		//companyDetail.getCompanyInfo();
		                	}else if(modalFlag=="upd"){
		                		$("#divFileUploadArea .fileModalUploadFile").remove();
								$('#divFileUploadList').html('<span>파일을 선택해 주세요.</span>');
								$("#divModalFile > p").remove();
		                		clientSerchList.get(1, 20);
		                		companyDetail.getCompanyInfo();
		                		//clientList.goDetail($("#hiddenModalPK").val(), $("#hiddenModalCompanyId").val());
		                		//companyDetail.getCompanyInfo(1,1);
		                	}
		                	
		                	// 모달창 닫기
		                	$("#myModal1").modal('hide');
		                	
		                	//$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/clientManagement/gridClientCompanyInfo.do?"+searchSerialize, rowNum : listRow}).trigger('reloadGrid');
		                }else if(data.error == 'sequence'){
		                	alert("시퀀스에러.\n관리자에게 문의하세요.");
		                }else{
		                	alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
		                }
		                
		                /* if(modalFlag=="upd") {
							$("#divFileUploadArea .fileModalUploadFile").remove();
							$('#divFileUploadList').html('<span>파일을 선택해 주세요.</span>');
							$("#divModalFile > p").remove();
	                		clientSerchList.get(1, 20);
	                		companyDetail.getCompanyInfo();
							//clientList.goDetail($("#hiddenModalPK").val());
						} else{
							//searchDetailClick.goDetail($("#hiddenModalPK").val());
							$('#myModal1').modal("hide");
						} */
		            },
		            complete: function() {
		            	$.ajaxLoadingHide();
					}
		        });
		},
		
		removeFileElement : function(count,obj){
			$("input#inputUploadFile"+count).remove();
			$(obj).parent("p").remove();
			
			if($("#divModalUploadPhoto p.fileModalUploadPhoto").length == 0){
				$("#divModalUploadPhoto span").show();
			}
			
		},
		
		/* deleteModal : function(){ //사용안하는 fnc
			$.ajax({
				url : "/clientManagement/deleteClientIndividual.do",
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("삭제하시겠습니까?")) return false;
					$.ajaxLoadingShow();
				},
				data :{
					hiddenModalPK : $("#hiddenModalPK").val()
				},
				success : function(data){
					if(data.cnt > 0) alert("삭제하였습니다."); $('#myModal1').modal("hide");
				},
				complete : function(){
					//$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/clientManagement/gridClientIndividualInfo.do?"+searchSerialize, rowNum : listRow}).trigger('reloadGrid');
					$.ajaxLoadingHide();
				}
			});
		}, */
		
		gotoDetail : function(num) {
			var idx = $("ul.tabmenu-type li a").index($("#formModalData > div.tab-area > ul > li:nth-child("+num+") > a"));
			$("ul.tabmenu-type li a").removeClass("sel");
			$("#formModalData > div.tab-area > ul > li:nth-child("+num+") > a").addClass("sel");
			$("div.modaltabmenu").addClass("off");
			$("div.modaltabmenu").eq(idx).removeClass("off");
		},
		
		browserCheck : function() {
			var bv = getBrowserCheck();
			if(bv == "11.0"){
				$("#fileModalUploadPhoto").click();
			}
		},
		
		// 탭이동
		goTab : function(num) {
			var idx = $("ul.tabmenu-type li a").index($("#divModalToggle > div.tab-area > ul > li:nth-child("+num+") > a"));
			$("ul.tabmenu-type li a").removeClass("sel");
			$("#divModalToggle > div.tab-area > ul > li:nth-child("+num+") > a").addClass("sel");
			$("div.modaltabmenu").addClass("off");
			$("div.modaltabmenu").eq(idx).removeClass("off");
		}
}

function getThumbnailPrivew(html, $target) {
	var bv = getBrowserCheck();
	if(bv == "9.0" && (html.value != 'undefined' && html.value != '')){
		imgPath = html.value.replace(/\\/gi, "\/");
		$target.css('display', '');
		$('#divModalUploadPhoto span').hide();
		$target.html('<img class="photo" id="imgModalInsertPhoto" border="0" alt="" style="background:url(\''+ imgPath + '\') no-repeat center center; background-size:cover;" />');
	}else if (html.files && html.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $target.css('display', '');
            //$target.css('background-image', 'url(\"' + e.target.result + '\")'); // 배경으로 지정시
            $('#divModalUploadPhoto span').hide();
            $target.html('<img class="photo" id="imgModalInsertPhoto" border="0" alt="" style="background:url('+ e.target.result + ') no-repeat center center; background-size:cover;" />');
        }
        reader.readAsDataURL(html.files[0]);
    }
}
</script>
<style>
.filebox label {
    display: inline-block;
    padding: .5em .75em;
    color: #999;
    font-size: inherit;
    line-height: normal;
    vertical-align: middle;
    background-color: #fdfdfd;
    cursor: pointer;
    border: 1px solid #ebebeb;
    border-bottom-color: #e2e2e2;
    border-radius: .25em;
    width:50;
    max-width:100%;
}
 
.filebox input[type="file"] {  /* 파일 필드 숨기기 */
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip:rect(0,0,0,0);
    border: 0;
}

</style>