<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="modal inmodal fade" id="myModal1" tabindex="-1"
	role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title">파트너사개인정보 관리</h4>
				<!-- <small class="font-bold">파트너개인정보 관리 세부정보입니다. </small> -->
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-lg-12">
						<div class="ibox float-e-margins">

							<div class="ibox-content border_n" id="divModalToggle">
								<form class="form-horizontal" id="formModalData"
									name="formModalData" method="post"
									enctype="multipart/form-data">
									<div class="form-group">
										<div class="col-sm-12 ag_r" name="divModalNameAndCreateDate"
											id="divModalNameAndCreateDate">작성자 : 홍길동 / 작성일 :
											2016-05-10</div>
									</div>

									<div class="hr-line-bottom"></div>

									<div class="form-group">
										<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 파트너사직원명</label>
										<div class="col-sm-4">
											<input type="text" class="form-control"
												id="textModalPartnerName" name="textModalPartnerName" />
										</div>
										<label class="col-sm-2 control-label">직급</label>
										<div class="col-sm-4">
											<input type="text" class="form-control"
												id="textModalPosition" name="textModalPosition" />
										</div>
									</div>

									<div class="hr-line-dashed"></div>

									<div class="form-group">
										<label class="col-sm-2 control-label">휴대전화</label>
										<div class="col-sm-4">
											<input type="text" class="form-control"
												placeholder="예) 01012345678" id="textModalCellPhone"
												name="textModalCellPhone" />
										</div>
										<label class="col-sm-2 control-label">직장전화</label>
										<div class="col-sm-4">
											<input type="text" class="form-control"
												placeholder="예) 01012345678" id="textModalPhone"
												name="textModalPhone" />
										</div>
									</div>

									<div class="hr-line-dashed"></div>

									<div class="form-group">
										<label class="col-sm-2 control-label">전자메일</label>
										<div class="col-sm-4">
											<input type="text" class="form-control" id="textModalEmail"
												name="textModalEmail" />
										</div>
										<label class="col-sm-2 control-label">재직여부</label>
										<div class="col-sm-4">
											<label class="" style="margin-right: 30px"> <input
												type="radio" value="Y" name="radioModalUseYN" checked>
												<span class="va-m">재직</span></label> <label> <input
												type="radio" value="N" id="radioModalUseYN"
												name="radioModalUseYN"> <span class="va-m">퇴사</span></label>
										</div>
									</div>

									<div class="hr-line-bottom"></div>

									<div class="tab-area">

										<!-- tab-menu -->
										<ul class="tabmenu-type">
											<li><a class="sel" onclick="modal.gotoDetail('1');">소속회사</a></li>
											<li><a class="" onclick="modal.gotoDetail('2');">스킬정보</a></li>
										</ul>
										<!--// tab-menu -->

										<!-- tab-cont -->

										<!-- 소속회사 -->
										<div class="sub_cont scont1 modaltabmenu">
										<!-- <div class="scont1 modaltabmenu"> -->
											<div class="form-group pos-rel">
												<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 파트너사</label>
												<div class="col-sm-4 pos-rel">
													<input type="text" class="form-control"
														id="textCommonSearchCompany"
														name="textCommonSearchCompany"
														placeholder="파트너사를 검색해 주세요." autocomplete="off" />
												</div>
												<label class="col-sm-2 control-label">파트너사ID</label>
												<div class="col-sm-4 pos-rel">
													<input type="text" class="form-control"
														id="textCommonSearchCompanyId"
														name="textCommonSearchCompanyId" readOnly />
												</div>
											</div>

											<div class="hr-line-dashed"></div>

											<div class="form-group pos-rel">
												<label class="col-sm-2 control-label">소속본부</label>
												<div class="col-sm-4">
													<input type="text" class="form-control"
														id="textModalDivision" name="textModalDivision" />
												</div>
												<label class="col-sm-2 control-label">소속부서</label>
												<div class="col-sm-4">
													<input type="text" class="form-control" id="textModalPost"
														name="textModalPost" />
												</div>
											</div>

											<div class="hr-line-dashed"></div>

											<div class="form-group pos-rel">
												<label class="col-sm-2 control-label">소속팀</label>
												<div class="col-sm-4">
													<input type="text" class="form-control" id="textModalTeam"
														name="textModalTeam" />
												</div>
												<label class="col-sm-2 control-label">직책</label>
												<div class="col-sm-4">
													<input type="text" class="form-control"
														id="textModalPositionDuty" name="textModalPositionDuty" />
												</div>
											</div>

											<div class="hr-line-dashed"></div>

											<div class="form-group" style="display: none;">
												<label class="col-sm-2 control-label">역할구분</label>
												<div class="col-sm-10">
													<input type="text" class="form-control"
														id="textModalSkillType" name="textModalSkillType" />
												</div>
											</div>

											<!-- <div class="hr-line-dashed"></div> -->

											<div class="form-group">
												<label class="col-sm-2 control-label">담당업무</label>
												<div class="col-sm-10">
													<input type="text" class="form-control" id="textModalDuty"
														name="textModalDuty" />
												</div>
											</div>

											<div class="hr-line-dashed"></div>

											<div class="form-group">
												<label class="col-sm-2 control-label">친한고객사</label>
												<div class="col-sm-10">
													<input type="text" class="form-control"
														id="textModalFriendShipCompany"
														name="textModalFriendShipCompany" />
												</div>
											</div>

											<div class="hr-line-dashed"></div>

											<div class="form-group">
												<label class="col-sm-2 control-label">친한고객</label>
												<div class="col-sm-10">
													<input type="text" class="form-control"
														id="textModalFriendShipCustomer"
														name="textModalFriendShipCustomer" />
												</div>
											</div>

											<div class="hr-line-dashed"></div>

											<div class="form-group">
												<label class="col-sm-2 control-label">개인정보</label>
												<div class="col-sm-10">
													<input type="text" class="form-control"
														id="textModalPerSonalInfo" name="textModalPerSonalInfo" />
												</div>
											</div>

											<div class="hr-line-dashed"></div>

											<div class="form-group"><label class="col-sm-2 control-label">명함/사진</label>
												<div class="col-sm-5 custom-photo">
				                                   		<label for="fileModalUploadNameCard"><a class="fileUpload btn btn-gray" onclick="modal.browserCheck('fileModalUploadNameCard');" style="color: white">명함첨부</a>
				                                   		</label>
				                                   		<div id="divModalNameCardUploadArea">
					        								<div class="filebox photo">
					        							
							                               		<!-- <label for="fileModalUploadPhoto" style="background-color: #2dbae7;border-color:#2dbae7;color: #fff;">명함 첨부</label> -->
							                               		<input type="file" name="fileModalUploadNameCard" id="fileModalUploadNameCard" accept="image/*" capture="camera" onchange="getThumbnailPrivew(this,$('#divModalUploadNameCard'))" />
							        							<div id="divModalUploadNameCard">
							        								<span class="blank-ment"><img style="background:url('../images/pc/namecard_default.png') no-repeat center center; background-size:cover;" class="photo" alt=""/></span>
							        							</div>
					        							
					        								</div>
					                               		</div>
				                                   	</div>
				                                   	<div class="col-sm-5 custom-photo">
				                                   		<label for="fileModalUploadPhoto"><a class="fileUpload btn btn-gray" onclick="modal.browserCheck('fileModalUploadPhoto');" style="color: white">사진첨부</a>
				                                   		</label>
				                                   		<div id="divModalPhotoUploadArea">
					        								<div class="filebox photo">
					        							
							                               		<!-- <label for="fileModalUploadPhoto" style="background-color: #2dbae7;border-color:#2dbae7;color: #fff;">명함 첨부</label> -->
							                               		<input type="file" name="fileModalUploadPhoto" id="fileModalUploadPhoto" accept="image/*" capture="camera" onchange="getThumbnailPrivew(this,$('#divModalUploadPhoto'))" />
							        							<div id="divModalUploadPhoto">
							        								<span class="blank-ment"><img style="background:url('../images/pc/photo_default.png') no-repeat center center; background-size:cover;" class="photo" alt=""/></span>
							        							</div>
					        							
					        								</div>
					                               		</div>
				                                   	</div>
												<!-- <div class="col-sm-10 custom-photo">
													<label for="fileModalUploadPhoto"><a class="fileUpload btn btn-gray" onclick="modal.browserCheck();" style="color: white">사진첨부</a>
													</label>
												</div>
												<div class="col-sm-12 m-b text-center custom-photo">
													<div id="divModalPhotoUploadArea">
														<div class="filebox photo">

															<label for="fileModalUploadPhoto" style="background-color: #2dbae7;border-color:#2dbae7;color: #fff;">명함 첨부</label>
															<input type="file" name="fileModalUploadPhoto"
																id="fileModalUploadPhoto" accept="image/*"
																capture="camera"
																onchange="getThumbnailPrivew(this,$('#divModalUploadPhoto'))" />
															<div id="divModalUploadPhoto">
																<span class="blank-ment"><img
																	style="background: url('../images/pc/namecard_default.png') no-repeat center center; background-size: cover;"
																	class="photo" alt="" /></span>
															</div>

														</div>
													</div>
												</div> -->
											</div>

											<%-- <select>
                                   				<option>===선택===</option>
                                   				<c:choose>
                                   				
												  <c:when test="${fn:length(VendorSolutionArea) > 0}">
												   	<c:forEach items="${VendorSolutionArea}" var="VendorSolutionAreaList" varStatus="i">
												   	<c:if test="${VendorSolutionAreaList.PRODUCT_VENDOR != VendorSolutionArea[i.index + 1].PRODUCT_VENDOR}">
												   		<option>${VendorSolutionAreaList.PRODUCT_VENDOR}</option>
												   		</c:if>
									                  </c:forEach>
												   </c:when>
											   </c:choose>
                                   				</select> --%>
										</div>
										<!--// 소속회사 -->

										<!-- 스킬정보 -->
										<div class="sub_cont scont2 modaltabmenu off">
											<div class="form-group">
												<jsp:include
													page="/WEB-INF/jsp/pc/partnerManagement/partnerIndividualInfoSkill.jsp" />
											</div>
										</div>
										<!--// 비즈니스이력 -->

										<!--// tab-cont -->

									</div>
									<!--// TabMenu -->

									<div class="hr-line-bottom"></div>

									<!-- <p class="text-center pt-t20">
                                            <button type="button" class="btn btn-w-m btn-primary btn-gray">등록</button>
                                        </p> -->

									<p class="text-center">
										<!-- <button type="button" class="btn btn-outline btn-gray-outline" id="buttonModalDelete" onClick="modal.deleteModal();">삭제하기</button> -->
										<button type="button " class="btn btn-w-m btn-seller"
											onclick="modal.submit();" id="buttonModalSubmit">저장하기</button>
									</p>
									<input type="hidden" name="hiddenModalPK" id="hiddenModalPK"
										value="" /> <input type="hidden" name="hiddenModalCreatorId"
										id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}" />
									<input type="hidden" name="hiddenModalCompanyId"
										id="hiddenModalCompanyId" /> <input type="hidden"
										name="hiddenModalPrevSalesMemberId"
										id="hiddenModalPrevSalesMemberId" />
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



<script type="text/javascript">
var comparePerSonalProfile = "";
var comparePerSonalActs = "";
var comparePerSonalFamily = "";
var comparePerSonalInclination = "";
var comparePerSonalFamiliars = "";
var comparePerSonalSNS = "";
var comparePerSonalETC = "";

$(document).ready(function() { 
	modal.init();
});		

var modal = {
		init : function(){
			//유효성 체크
			modal.validate();

			//자동완성 검색
			commonSearch.partner($("#formModalData #textCommonSearchCompany"), $('#formModalData #hiddenModalCompanyId'), $("#formModalData #textCommonSearchCompanyId"));
			commonSearch.customer($("#formModalData #textModalReportingLineDivisionName"), $('#formModalData #textModalReportingDivisionResult'), $("#formModalData #textModalReportingDivisionPosition"), $("#formModalData #textCommonSearchCompanyId"));
			commonSearch.customer($("#formModalData #textModalReportingLinePostName"), $('#formModalData #textModalReportingPostResult'), $("#formModalData #textModalReportingPostPosition"), $("#formModalData #textCommonSearchCompanyId"));
			commonSearch.customer($("#formModalData #textModalReportingLineTeamName"), $('#formModalData #textModalReportingTeamResult'), $("#formModalData #textModalReportingTeamPosition"), $("#formModalData #textCommonSearchCompanyId"));
			commonSearch.member($("#formModalData #textModalPerSonalPrevSales"), $("#hiddenModalPrevSalesMemberId"));
			
			//유효성 검사
			$("#textModalPartnerName, #textCommonSearchCompany").on("blur",function(e){
				switch (e.target.id) {
					case "textCommonSearchCompany":
						$("#formModalData").find("#hiddenModalCompanyId").valid();
						break;
					default:
						$("#formModalData").find(e.target).valid();
						break;
				}
			});
		},
		
		gotoDetail : function(num) {
			var idx = $("ul.tabmenu-type li a").index($("#formModalData > div.tab-area > ul > li:nth-child("+num+") > a"));
			$("ul.tabmenu-type li a").removeClass("sel");
			$("#formModalData > div.tab-area > ul > li:nth-child("+num+") > a").addClass("sel");
			$("div.modaltabmenu").addClass("off");
			$("div.modaltabmenu").eq(idx).removeClass("off");
		},
		
		deleteFile : function(fileId) {
			 $.ajax({
				url : "/common/deleteFile.do?fileId="+fileId+"&fileTableName=5&datatype=json",
				async : false,
				datatype : 'json',
				method: 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("삭제하시겠습니까?")){
						return false;	
					}
				},
				success : function(data){
					if(data.cnt > 0){
						alert("삭제되었습니다.");
					}else{
						alert("파일 삭제를 실패했습니다.\n관리자에게 문의하세요.");
					}
					$("#divModalFile > p").remove();
					//$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/clientManagement/gridClientSatisfaction.do?"+searchSerialize, rowNum : listRow}).trigger('reloadGrid');
					//setTimeout(function(){$("#divModalFile p[name='modalFile"+$("#hiddenModalPK").val()+"']").show();},300); //ajax Loading
					//$("#divModalFile p[name='modalFile"+$("#hiddenModalPK").val()+"']").show();
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
			
			//모달 초기화
			$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;${userInfo.HAN_NAME}'+
					'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+commonDate.year+"\/"+commonDate.month+"\/"+commonDate.day+"</span>");
			//$("#divModalNameAndCreateDate").html("작성자 : ${userInfo.HAN_NAME} / 작성일 : "+commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			$("#formModalData input:text").val("");
			$("#hiddenModalCompanyId").val("");
			$("#hiddenModalPrevSales").val("");
			$("#formModalData select").val("");
			$("#formModalData textarea").val("");
			/* $("#textModalSatName").val("${userInfo.HAN_NAME}"); */
			$("#formModalData input[name='radioModalUseYN']").eq(0).prop("checked",true);
			$("#formModalData #hiddenModalCompanyId").val("");
			$("div.company-current").html("");
			$("ul.company-list").html("");
			$("#buttonModalDelete").hide();
			$("#divModalFile").hide();
			//$("#divModalPhotoUploadArea .fileModalUploadPhoto").hide();
			$("#divModalUploadNameCard").html('<span class="blank-ment"><img style="background:url(\'../images/pc/namecard_default.png\') no-repeat center center; background-size:cover;" class="photo" alt=""/></span>');
			$('#divModalUploadNameCard span').hide();
			$('#divModalUploadNameCard .blank-ment').show();
			$("#divModalUploadPhoto").html('<span class="blank-ment"><img style="background:url(\'../images/pc/photo_default.png\') no-repeat center center; background-size:cover;" class="photo" alt=""/></span>');
			$('#divModalUploadPhoto span').hide();
			$('#divModalUploadPhoto .blank-ment').show();
			
			//모달 오늘 날짜 입력
			$("h4.modal-title").html("파트너사 개인 신규 등록");
			$("#buttonModalSubmit").html("등록하기");
			$("small.font-bold").css('display','none');
			
			$("#formModalData #hiddenModalPK").val("");
			
			comparePerSonalProfile = $("#textModalPerSonalProfile").val();
			comparePerSonalActs = $("#textModalPerSonalActs").val();
			comparePerSonalFamily = $("#textModalPerSonalFamily").val();
			comparePerSonalInclination = $("#textModalPerSonalInclination").val();
			comparePerSonalFamiliars = $("#textModalPerSonalFamiliars").val();
			comparePerSonalSNS = $("#textModalPerSonalSNS").val();
			comparePerSonalETC = $("#textModalPerSonalETC").val();
			
			salesDetail.reset();
			
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
						textModalPartnerName : {
							required : true,
							maxlength : 40
						},
						hiddenModalCompanyId : {
							required : true
						},
						textareaModalContents : {
							minlength : 1,
							maxlength : 2000
						},
					},
					messages : { // rules에 해당하는 메시지를 지정하는 속성
						textModalPartnerName : {
							required : "파트너사 개인명을 입력하세요.",
						},
						textareaModalContents : {
							maxlength : "2000글자 이하여야 합니다"
						},
						hiddenModalCompanyId : {
							required : "파트너사를 검색하세요."
						}
					},
					invalidHandler : function(error, element) {
						$('div.modaltabmenu').each(function(idx,obj){
							$("ul.tabmenu-type li a").eq(idx).trigger('click.modalTab');
							return false;
						});
					},
					errorPlacement : function(error, element) {
					    if($(element).prop("id") == "hiddenModalCompanyId") {
					        $("#textCommonSearchCompany").after(error);
					        location.href = "#textCommonSearchCompany";
					    }
					    else {
					        error.insertAfter(element); // default error placement.
					    }
					}
				})
		}, 
		
		submit : function(){
				var browser = getIEVersionCheck();
				var url;
				if(comparePerSonalProfile == $("#divPersonalInfoProfile").html())$("#textModalPerSonalProfile").val("");
				if(comparePerSonalActs == $("#divPersonalInfoSocialAtcs").html())$("#textModalPerSonalActs").val("");
				if(comparePerSonalFamily == $("#divPersonalInfoFamily").html())$("#textModalPerSonalFamily").val("");
				if(comparePerSonalInclination == $("#divPersonalInfoInclination").html())$("#textModalPerSonalInclination").val("");
				if(comparePerSonalFamiliars == $("#divPersonalInfoFamiliars").html())$("#textModalPerSonalFamiliars").val("");
				if(comparePerSonalSNS == $("#divPersonalInfoSNS").html())$("#textModalPerSonalSNS").val("");
				if(comparePerSonalETC == $("#divPersonalInfoETC").html())$("#textModalPerSonalETC").val("");
				
				(modalFlag == "ins") ? url = "/partnerManagement/insertPartnerIndividualInfo.do" : url = "/partnerManagement/updatePartnerIndividualInfo.do";
				 $('#formModalData').ajaxForm({
		    		url : url,
		    		async : false,
		    		dataType: "json",
		            beforeSubmit: function (data,form,option) {
		            	if(!compareFlag){
							if(!confirm("저장하시겠습니까?")) return false;
							salesDetail.selectVendor(lastEditRowQ);
		            	}
		            	$.ajaxLoadingShow();
		            },
		            data : {
		            	datatype : 'json',
		            	browser : browser
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function(data){
		                //성공후 서버에서 받은 데이터 처리
		                if(data.cnt > 0){
		                	if(modalFlag == "upd") {
	                			salesDetail.insertQualification();
		                	}
	                		compare_before = $("#formModalData").serialize();
		                	compareFlag = false;
		                	alert("저장하였습니다.");
		                	if(modalFlag == "upd") {
		                		clientSerchList.get(1, 20);
		                		clientList.goDetail($("#hiddenPartnerIndividualId").val(), $("#hiddenModalCompanyId").val());
		                	}else {
		                		searchDetailClick.goDetail(data.filePK, $("#hiddenModalCompanyId").val(), $("#textModalPartnerName").val());
		                	}
		                	
		                	if(modalFlag=="upd"){
		                		$("#divModalNameCardUploadArea .fileModalUploadNameCard").remove();
								$("#divModalPhotoUploadArea .fileModalUploadPhoto").remove();
								$('#divFileUploadList').html('<span>파일을 선택해 주세요.</span>');
								$("#divModalFile > span").remove();
							}else if(modalFlag=="ins"){
								$('#myModal1').modal("hide");
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
			
			if($("#divModalUploadNameCard .fileModalUploadNameCard").length == 0){
				$("#divModalUploadNameCard span").show();
			}
			
			if($("#divModalUploadPhoto .fileModalUploadPhoto").length == 0){
				$("#divModalUploadPhoto span").show();
			}
			
		},
		
		deleteModal : function(){
			$.ajax({
				url : "/partnerManagement/deletePartnerIndividualInfo.do",
				datatype : 'json',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("삭제하시겠습니까?")) return false;
					$.ajaxLoadingShow();
				},
				data :{
					hiddenModalPK : $("#hiddenModalPK").val(),
					datatype : 'json'
				},
				success : function(data){
					if(data.cnt > 0) alert("삭제하였습니다."); $('#myModal1').modal("hide");
					$("#formDetail").attr({action:"/partnerManagement/listPartnerIndividualInfoListDetail.do", method:"post"}).submit();
					//$sellersGrid.jqGrid('setGridParam', { datatype: 'json' , url : "/clientManagement/gridClientIndividualInfo.do?"+searchSerialize, rowNum : listRow}).trigger('reloadGrid');
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		browserCheck : function(val) {
			var bv = getBrowserCheck();
			if(bv == "11.0"){
				$("#"+val).click();
			}
		}
		
}
//getThumbnailPrivew(this,$('#divModalUploadPhoto'))
function getThumbnailPrivew(html, $target) {
	var bv = getBrowserCheck();
	if(bv == "9.0" && (html.value != 'undefined' && html.value != '')){
		imgPath = html.value.replace(/\\/gi, "\/");
		$target.css('display', '');
		$('#'+$target.attr('id')+' span').hide();
		$target.html('<img class="photo" id="imgModalInsertPhoto" border="0" alt="" style="background:url(\''+ imgPath + '\') no-repeat center center; background-size:cover;" />');
	}else if (html.files && html.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $target.css('display', '');
            //$target.css('background-image', 'url(\"' + e.target.result + '\")'); // 배경으로 지정시
            $('#'+$target.attr('id')+' span').hide();
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
	width: 50;
	max-width: 100%;
}

.filebox input[type="file"] { /* 파일 필드 숨기기 */
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}
</style>