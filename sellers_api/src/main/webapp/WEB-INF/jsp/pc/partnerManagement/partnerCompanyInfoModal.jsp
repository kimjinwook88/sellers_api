<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="modal inmodal fade" id="myModal1" tabindex="-1" role="dialog"  aria-hidden="true">
   <div class="modal-dialog modal-lg">
       <div class="modal-content">
           <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
               <h4 class="modal-title">파트너사정보 보기</h4>
               <!-- <small class="font-bold">파트너사정보 세부정보입니다. </small> -->
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
                           <div class="ibox-content border_n" id="divModalToggle">
                               <div class="form-group">
                                    <div class="col-sm-12 ag_r" name="divModalNameAndCreateDate" id="divModalNameAndCreateDate">작성자 : 홍길동 / 작성일 : 2016-05-10</div>
                                </div>
                                <div class="hr-line-dashed"></div>
                               		<div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 파트너사명</label>
                                        <div class="col-sm-4"><input type="text" class="form-control" id="textModalCompanyName" name="textModalCompanyName" /></div>
                                    	<label class="col-sm-2 control-label">파트너사 ID</label>
                                        <div class="col-sm-4"><input type="text" class="form-control" id="textModalCompanyId" name="textModalCompanyId" readonly="readonly" /></div>
                                    </div>
                                    <div id="divModalCompanyLeader">
                                <div class="hr-line-dashed"></div>
                                    <div class="form-group"><label class="col-sm-2 control-label">CEO</label>
                                        <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalCeoName" name="textModalCeoName" /></div>
                                        <input type="hidden" class="form-control" id="hiddenModalCeoID" name="hiddenModalCeoID" />
                                    </div>
                               <!-- <div class="hr-line-dashed"></div>
                                   <div class="form-group">
                                        <label class="col-sm-2 control-label">CIO</label>
                                        <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalCioName" name="textModalCioName" /></div>
                                        <input type="hidden" class="form-control" id="hiddenModalCioID" name="hiddenModalCioID" />
                                        <label class="col-sm-2 control-label">CTO</label>
                                        <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalCtoName" name="textModalCtoName" /></div>
                                        <input type="hidden" class="form-control" id="hiddenModalCtoID" name="hiddenModalCtoID" />
                                   </div> -->
                                   </div>
                               <div class="hr-line-dashed"></div>
                                   <div class="form-group">
                                   		<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 파트너사 코드</label>
                                        <div class="col-sm-4">
                                        	<select class="form-control" id="selectModalpartnerSegmentCode" name="selectModalpartnerSegmentCode">
                                        		<option value="">===선택===</option>
                                        		<c:choose>
                                        		<c:when test="${fn:length(partnerSegmentCode) > 0}">
                                        			<c:forEach items="${partnerSegmentCode}" var="partnerSegmentCode" varStatus="status">
                                        			<option value="${partnerSegmentCode.PARTNER_CODE}">${partnerSegmentCode.PARTNER_CODE}</option>
                                        			</c:forEach>
                                        		</c:when>
                                        		</c:choose>
                                        	</select>
                                        </div>
                                   </div>
                               <div class="hr-line-dashed"></div>
                               		<div class="form-group"><label class="col-sm-2 control-label">파트너사 Item</label>
                                        <div class="col-sm-4"><input type="text" class="form-control" id="textModalCompanyItem" name="textModalCompanyItem" /></div>
                                        <label class="col-sm-2 control-label">사업자등록번호</label>
                                        <div class="col-sm-4"><input type="text" class="form-control" id="textModalBusinessNumber" name="textModalBusinessNumber" /></div>
                                    </div>
                           	   <div class="hr-line-dashed"></div>
                                       <div class="form-group"><label class="col-sm-2 control-label">대표전화</label>
                                        <div class="col-sm-4"><input type="text" class="form-control" id="textModalCompanyTelno" name="textModalCompanyTelno" /></div>
                                        <label class="col-sm-2 control-label">FAX번호</label>
                                       <div class="col-sm-4"><input type="text" class="form-control" id="textModalCompanyFaxno" name="textModalCompanyFaxno" /></div>
                                        <!-- <label class="col-sm-2 control-label">우편번호</label>
                                       <div class="col-sm-4"><input type="text" class="form-control" id="textModalPostalCode" name="textModalPostalCode" /></div> -->
                                   </div>      
                               <div class="hr-line-dashed"></div>
                                   	<div class="form-group"><label class="col-sm-2 control-label">주소</label>
                                       <div class="col-sm-10"><input type="text" class="form-control" id="textModalPostalAddress" name="textModalPostalAddress" /></div>
                                   </div>
                                   <div class="hr-line-dashed"></div>
                                   <div class="form-group"><label class="col-sm-2 control-label">홈페이지</label>
                                       <div class="col-sm-10"><input type="text" class="form-control" id="textModalCompanyHomepage" name="textModalCompanyHomepage" /></div>
                                   </div>
                                   <div class="hr-line-dashed"></div>
                                   <div class="form-group"><label class="col-sm-2 control-label">업태</label>
                                        <div class="col-sm-4"><input type="text" class="form-control" id="textModalBusinessType" name="textModalBusinessType" /></div>
                                       	<label class="col-sm-2 control-label">종목</label>
                                        <div class="col-sm-4"><input type="text" class="form-control" id="textModalBusinessSector" name="textModalBusinessSector" /></div>
                                   </div>
									<div class="hr-line-dashed"></div>
                                   	<div class="form-group"><label class="col-sm-2 control-label">조직도</label>
                                       <div class="col-sm-10 custom-photo">
                                       		<label for="fileModalUploadPhoto"><a class="fileUpload btn btn-gray" onclick="modal.browserCheck();" style="color: white">사진첨부</a></label>
                                       	</div>
                                       	<div class="col-sm-12 m-b text-center custom-photo">
		                                       <div id="divModalPhotoUploadArea">
		        									<div class="filebox photo">
		        							
		                               				<!-- <label for="fileModalUploadPhoto" style="background-color: #2dbae7;border-color:#2dbae7;color: #fff;">명함 첨부</label> -->
		                               					<input type="file" name="fileModalUploadPhoto" id="fileModalUploadPhoto" accept="image/*" capture="camera" onchange="getThumbnailPrivew(this,$('#divModalUploadPhoto'))" />
		        										<div id="divModalUploadPhoto">
		        											<span class="blank-ment"><img src="../images/pc/icon_org.gif" style="" class="photo" alt=""/></span>
		        										</div>
		        							
				        							</div>
				                               	</div>
		                               	</div>
									</div>
                                   </div>                                                                             
                               <!--    
                           	   <div class="hr-line-dashed"></div>
                                   
                                   <div class="form-group"><label class="col-sm-2 control-label">파일첨부</label>
                                       <div class="col-sm-10">
                                            <div class="input-default pop-file">
                                                
                                                <div class="file-dragdrap-area" id="divFileUploadArea">
                                                    <input name="fileModalUploadFile[]" id="buttonSearchFile" type="file" title="파일찾기" onkeydown="event.returnValue=false;" multiple/>
                                                    <div class="dropzone-previews text-center" id="divFileUploadList">
                                                    	<span>파일을 선택해 주세요.</span>
                                                    </div>
                                                </div>
                                                
                                                <input type="file" id="test" />
                                                업로드 된 파일 리스트
                                                <div class="file-in-list" id="divModalFile">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                     -->
                                    <div class="hr-line-bottom"></div>
                                     
                                    <p class="text-center">
                                        <button type="button" class="btn btn-outline btn-gray-outline" id="buttonModalDelete" onClick="modal.deleteModal();">삭제하기</button>
                                        <button type="submit " class="btn btn-w-m btn-seller" onclick="modal.submit();" id="buttonModalSubmit">저장하기</button>
                                    </p>
                                    <input type="hidden"name="hiddenModalPK" 			id="hiddenModalPK" 		value=""/>
                                    <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
                                    <input type="hidden" name="hiddenModalCompanyId" id="hiddenModalCompanyId"/>
                                    <input type="hidden" name="hiddenModalSegmentCode" id="hiddenModalSegmentCode"/>
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
			//commonSearch.customer($("#formModalData #textModalCeoName"), $('#formModalData #hiddenModalCeoID'), '', $("#formModalData #textModalCompanyId"));
			
			//유효성 검사
			$("#textModalCompanyName, #selectModalpartnerSegmentCode").on("blur",function(e){
				$("#formModalData").find(e.target).valid();
			});
		},
		
		selectCodePartnerSegmentAll : function() {
			params = $.param({
				datatype : 'json'
			});
			$.ajax({ //산업분류코드
				url : "/partnerManagement/selectCodePartnerSegmentAll.do",
				async : false,
				datatype : 'json',
				data : params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					$("#hiddenModalSegmentCode").val("");
					$("#selectModalpartnerSegmentCode").html("<option value=''>===선택===</option>");
					if(data.partnerSegmentCode.length > 0){
						for(var i=0; data.partnerSegmentCode.length>i; i++){
							$("#selectModalpartnerSegmentCode").append('<option value="'+ data.partnerSegmentCode[i].PARTNER_CODE +'">'+data.partnerSegmentCode[i].PARTNER_CODE+'</option>');
						}
					}else{
						//$("#selectModalpartnerSegmentCode").append('<option>영업채널 코드를 추가해주세요.</option>');
					}
					if(modalFlag=="upd" && !isEmpty(chk)){
						$("#selectModalpartnerSegmentCode option").prop("selected",false)
						$.each(($("#hiddenPartnerCode").val()).split(";"),function(index, val){
							$("#selectModalpartnerSegmentCode option[value='"+val+"']").prop("selected",true);
						}); 
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		deleteFile : function(fileId) {
			 $.ajax({
				url : "/common/deleteFile.do?fileId="+fileId+"&fileTableName=15&datatype=json",
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
					//$("#divModalFile > p").remove();
					//$("#divModalFile p[name='modalFile"+$("#hiddenModalPK").val()+"']").show();
					companyDetail.getCompanyFile();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		
		//신규등록
		reset : function() { 
			modalFlag = "ins"; //신규등록
			$('#formModalData').validate().resetForm();	
			
			modal.selectCodePartnerSegmentAll();
			
			//모달 초기화
			$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;${userInfo.HAN_NAME}'+
					'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+commonDate.year+"\/"+commonDate.month+"\/"+commonDate.day+"</span>");
			//$("#divModalNameAndCreateDate").html("작성일 : "+commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			$("#formModalData input:text").val("");
			$("#formModalData select").val("");
			$("#formModalData textarea").val("");
			/* $("#textModalSatName").val("${userInfo.HAN_NAME}"); */
			$("#formModalData #hiddenModalCompanyId").val("");
			$("div.company-current").html("");
			$("ul.company-list").html("");
			$("#buttonModalDelete").hide();
			/* $("#divModalFile").hide();
			$("#divFileUploadArea .fileModalUploadFile").remove();
			$('#divFileUploadList').html('<span>파일을 선택해 주세요.</span>'); */
			$("#divModalCompanyLeader").hide();			
			
			$("#divModalFile").hide();
			//$("#divModalPhotoUploadArea .fileModalUploadPhoto").hide();
			$("#divModalUploadPhoto").html('<span class="blank-ment"><img src="../images/pc/icon_org.gif" class="m-b" alt=""><br/>등록된 조직도가 없습니다.<br/>파트너사의 조직도를 등록하세요.</span>');
			$('#divModalUploadPhoto span').hide();
			$('#divModalUploadPhoto .blank-ment').show();
			
			//모달 오늘 날짜 입력
			$("h4.modal-title").html("파트너사 신규 등록");
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
			
			//신규등록, 상세보기 div 접기 펴기
			//toggleDiv(modalFlag);
			
			//신규등록창도 수정사항 확인.
			compare_before = $("#formModalData").serialize();
		},
		
		validate : function(){
				$("#formModalData").validate({ // joinForm에 validate를 적용
					ignore: '', 
					rules : {
						textModalCompanyName : {
							required : true,
							maxlength : 100
						},
						selectModalPartnerCompanyCategory : {
							required : true
						},
						selectModalpartnerSegmentCode : {
							required : true
						}
					},
					messages : { // rules에 해당하는 메시지를 지정하는 속성
						textModalCompanyName : {
							required : "파트너사명을 입력하세요.",
							maxlength:"100글자 이하여야 합니다" 
						},
						textModalCompanyId : {
						//required : "파트너사명을 입력하세요.", // 이와 같이 규칙이름과 메시지를 작성
						//rangelength:"1글자 이상, 10글자 이하여야 합니다.",
						//digits:"숫자만 입력해 주세요."
						},
						selectModalPartnerCompanyCategory : {
							required : "파트너사 분류를 선택하세요."
						},
						selectModalpartnerSegmentCode : {
							required : "파트너사 코드를 선택하세요."
						},
						hiddenModalCompanyId : {
							required : "파트너사를 검색하세요."
						}
					}
				})
		},  
		submit : function(){
				var browser = getIEVersionCheck();
				var url;
				(modalFlag == "ins") ? url = "/partnerManagement/insertPartnerCompanyInfo.do" : url = "/partnerManagement/updatePartnerCompanyInfo.do";
				
				//파트너 코드 다중화
				var codeArr = [], partnerCode; 
				$('#selectModalpartnerSegmentCode :selected').each(function(i, selected){ 
					codeArr[i] = $(selected).text(); 
				});
				partnerCode = codeArr.join(";");
				$("#hiddenModalSegmentCode").val(partnerCode);
				
				 $('#formModalData').ajaxForm({
		    		url : url,
		    		async : true,
		    		dataType: "json",
		            beforeSubmit: function (data,form,option) {
		            	if(!compareFlag){
							if(!confirm("저장하시겠습니까?")) return false;
		            	}
		            	$.ajaxLoadingShow();
		            },
		            data :{
		            	datatype : 'json',
		            	browser : browser
					},
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function(data){
		                //성공후 서버에서 받은 데이터 처리
		                if(data.cnt > 0){
		                	compare_before = $("#formModalData").serialize();
		                	compareFlag = false;
		                	alert("저장하였습니다.");
		                	if(modalFlag=="ins") $('#myModal1').modal("hide");
		                	//$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/clientManagement/gridClientCompanyInfo.do?"+searchSerialize, rowNum : listRow}).trigger('reloadGrid');
		                	
		                	if(modalFlag=="upd") {
								$("#divFileUploadArea .fileModalUploadFile").remove();
								$('#divFileUploadList').html('<span>파일을 선택해 주세요.</span>');
								$("#divModalFile > p").remove();
								clientSearchList.get(1, 20);
								companyDetail.getCompanyInfo();
								//$("#serchDetail").val($("#textModalCompanyName").val());
								
								//clientSearchList.get();
								//clientList.goDetail($("#textModalCompanyId").val());
							}else if(modalFlag=="ins"){
								$("#textListSearchDetail").val($("#textModalCompanyName").val());
								$("#serchDetail").val($("#textModalCompanyName").val());
								searchDetailClick.goDetail($("#textModalCompanyId").val());
							}
		                }else{
		                	alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
		                }
		            },
		            complete : function(){
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
		deleteModal : function(){
			$.ajax({
				url : "",
				datatype : 'json',
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
		},
		
		browserCheck : function() {
			var bv = getBrowserCheck();
			if(bv == "11.0"){
				$("#fileModalUploadPhoto").click();
			}
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