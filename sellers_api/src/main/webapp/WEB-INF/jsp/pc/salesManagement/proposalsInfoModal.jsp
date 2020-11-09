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
				<h4 class="modal-title"></h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-lg-12">
						<div class="ibox ">
							<div class="ibox-content border_n">
								<form class="form-horizontal" id="formModalData"
									name="formModalData" method="post"
									enctype="multipart/form-data">

									<div class="form-group">
										<div class="col-sm-12 ag_r" name="divModalNameAndCreateDate"
											id="divModalNameAndCreateDate">작성자 : 홍길동 / 작성일 :
											2016-05-10</div>
									</div>
									<div class="hr-line-dashed"></div>

									<div class="form-group">
										<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 제목</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="textModalSubject"
												name="textModalSubject" />
										</div>
									</div>

									<!-- <div class="hr-line-dashed"></div> -->
									<div class="form-group" style="display: none;">
										<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객사</label>
										<div class="col-sm-4 pos-rel">
											<input type="text" class="form-control"
												id="textCommonSearchCompany" name="textCommonSearchCompany"
												placeholder="고객사를 검색해 주세요." />
										</div>
										<label class="col-sm-2 control-label">고객사ID</label>
										<div class="col-sm-4">
											<input type="text" class="form-control"
												id="textCommonSearchCompanyId"
												name="textCommonSearchCompanyId" readOnly />
										</div>
									</div>

									<!-- <div class="hr-line-dashed"></div> -->
									<div class="form-group" style="display: none;">
										<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객명</label>
										<div class="col-sm-4 pos-rel">
											<input type="text" class="form-control"
												id="textModalCustomerName" name="textModalCustomerName"
												placeholder="고객명를 검색해 주세요." />
										</div>
										<label class="col-sm-2 control-label">고객직급</label>
										<div class="col-sm-4">
											<input type="text" class="form-control"
												id="textModalCustomerRank" name="textModalCustomerRank" />
										</div>
									</div>
									
									<div class="hr-line-dashed"></div>
                                    <div class="form-group pos-rel">
                                        <label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 고객명</label>
                                        <!-- <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalCustomerName2" name="textModalCustomerName2" placeholder="고객명를 검색해 주세요." autocomplete="off"/></div> -->
                                    	<div class="col-md-9 col-lg-4">
                                              <ul id="ulModalSingleClient" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                                  <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleClient" name="liModalSingleClient">
                                                      <input type="text" class="form-control" id="textModalSingleClient" name="textModalSingleClient" placeholder="고객명을 검색해 주세요." autocomplete="off">
                                                  <div class="autocomplete-suggestions "></div></li>
                                              </ul>                                                            
                                          </div>
                                    </div>

									<!--   <div class="form-group"><label class="col-sm-2 control-label">사업본부</label>
                                    <div class="col-sm-10">
                                        <div class="select-com"><label>항목선택</label> 
                                            <select class="form-control" name="account" id="selectModalBizOffice" name="selectModalBizOffice">
                                            <option>전체</option>
                                            <option>사업분부1</option>
                                            <option>사업분부2</option>
                                        </select></div>
                                    </div>
                                </div> -->

									<!-- <div class="hr-line-dashed"></div>
                               <div class="form-group"><label class="col-sm-2 control-label">영업대표</label>
                                       <div class="col-sm-10"><input type="text" class="form-control" id="textModalBizOwner" name="textModalBizOwner"/></div>
                                </div> -->

									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label">제안영역</label>
										<div class="col-sm-4">
											<div class="select-com">
												<!-- <label>항목선택</label> -->
												<select class="form-control"
													id="selectModalSuggestCategoryBiz"
													name="selectModalSuggestCategoryBiz">
													<option value="cloud">cloud</option>
													<option value="H/W">H/W</option>
													<option value="S/W">S/W</option>
												</select>
											</div>
										</div>
										<label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 제품</label>
										<div class="col-sm-4">
											<div class="select-com">
												<!-- <label>항목선택</label> -->
												<select class="form-control"
													id="selectModalSuggestCategoryProduct"
													name="selectModalSuggestCategoryProduct" multiple>
													<option value="Oracle">Oracle</option>
													<option value="DB2">DB2</option>
													<option value="Sellers">Sellers</option>
												</select>
											</div>
										</div>
									</div>


									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label">제안내용</label>
										<div class="col-sm-10">
											<textarea class="pop-textarea-input" rows="3"
												id="textareaModalDetailContents"
												name="textareaModalDetailContents"
												 onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea>
										</div>
									</div>

									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label">제안책임자</label>
										<div class="col-sm-4 pos-rel">
											<input type="text" class="form-control"
												id="textModalSuggestLeader" name="textModalSuggestLeader"
												placeholder="제안책임자를 검색해 주세요." />
										</div>
										<!-- <label class="col-sm-2 control-label">제안점검단계</label>
                                    <div class="col-sm-4">
                                        <label class=""><input type="radio" value="제안시작" id="radioSuggestProgress1" name="radioSuggestProgress"> 제안시작</label>
                                        <label class=""> <input type="radio" value="중간점검" id="radioSuggestProgress2" name="radioSuggestProgress">중간점검</label>
                                        <label class=""> <input type="radio" value="최종점검" id="radioSuggestProgress3" name="radioSuggestProgress">최종점검</label>
                                    </div> -->
									</div>

									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="date_modified">제안일정</label>
										<div class="col-sm-5">
											<label>제안시작일</label>
											<div id="data_1" class="mg-b10">
												<div class="input-group date">
													<span class="input-group-addon"><i
														class="fa fa-calendar"></i></span><input type="text"
														class="form-control" id="textModalSuggestStartDate"
														name="textModalSuggestStartDate">
												</div>
											</div>
										</div>
										<div class="col-sm-5">
											<label>제안제출일</label>
											<div id="data_1" class="mg-b10">
												<div class="input-group date">
													<span class="input-group-addon"><i
														class="fa fa-calendar"></i></span><input type="text"
														class="form-control" id="textModalSuggestEndDate"
														name="textModalSuggestEndDate">
												</div>
											</div>
										</div>
										<div class="col-sm-2"></div>
										<div class="col-sm-5">
											<label>제안발표일</label>
											<div id="data_1" class="mg-b10">
												<div class="input-group date">
													<span class="input-group-addon"><i
														class="fa fa-calendar"></i></span><input type="text"
														class="form-control" id="textModalSuggestPtDate"
														name="textModalSuggestPtDate">
												</div>
											</div>
										</div>
										<div class="col-sm-5">
											<label>결과발표일</label>
											<div id="data_1" class="mg-b10">
												<div class="input-group date">
													<span class="input-group-addon"><i
														class="fa fa-calendar"></i></span><input type="text"
														class="form-control" id="textModalSuggestResultDate"
														name="textModalSuggestResultDate">
												</div>
											</div>
										</div>
									</div>
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label">제안금액</label>
										<div class="col-sm-4">
											<input type="text" OnKeyUp="comma(this)" class="form-control"
												id="textModalSuggestAmount" name="textModalSuggestAmount" />
										</div>
										<label class="col-sm-2 control-label">제안금액<br />상세내역
										</label>
										<div class="col-sm-4">
											<textarea class="pop-textarea-input" rows="3"
												id="textareaModalAmountDetail"
												name="textareaModalAmountDetail"
												 onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea>
										</div>
									</div>

									<div class="form-group">
										<label class="col-sm-2 control-label">제안COST</label>
										<div class="col-sm-4">
											<input type="text" OnKeyUp="comma(this)" class="form-control"
												id="textModalSuggestCost" name="textModalSuggestCost" />
										</div>
										<label class="col-sm-2 control-label">제안COST<br />상세내역
										</label>
										<div class="col-sm-4">
											<textarea class="pop-textarea-input" rows="3"
												id="textareaModalCostDetail" name="textareaModalCostDetail"
												 onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea>
										</div>
									</div>

									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label">제안결과</label>
										<div class="col-sm-10">
											<label class=""><input type="radio" value="Win"
												id="radioSuggestResult1" name="radioSuggestResult">
												Win</label> <label class=""> <input type="radio"
												value="Loss" id="radioSuggestResult2"
												name="radioSuggestResult"> Loss
											</label>
										</div>
									</div>
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label">제안결과<br />상세내역
										</label>
										<div class="col-sm-10">
											<textarea class="pop-textarea-input" rows="5"
												id="textareaResultDetail" name="textareaResultDetail"
												 onclick="textAreaResize(this)" onkeydown="textAreaResize(this)" onkeyup="textAreaResize(this)"></textarea>
										</div>
									</div>
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label">파일첨부</label>
										<div class="col-sm-10">
											<div class="input-default pop-file">
												<div class="file-dragdrap-area">
													<!-- <button id="buttonSearchFile" type="button" class="btn btn-gray btn-file">파일찾기</button> -->
													<div class="fileUpload btn btn-gray">
														<span>파일찾기</span> <input type="file"
															name="fileModalUploadFile[]"
															onchange="commonFile.upload(this);" class="upload" />
													</div>
													<div class="file-in-list" id="divFileUploadList">
														<!-- id="divModalFile" -->
														<!-- 선택된 파일이 없는 경우 아래 멘트 노출 -->
														<span class="blank-ment" style="display: none;">선택된
															파일이 없습니다</span>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="hr-line-dashed"></div>
									<p class="text-center">
										<!-- <button type="button" class="btn btn-outline btn-primary btn-gray-outline">삭제하기</button> -->
										<button type="submit" class="btn btn-w-m btn-primary btn-gray"
											onclick="modal.submit();" id="buttonModalSubmit">저장하기</button>
									</p>
									<input type="hidden" name="hiddenModalPK" id="hiddenModalPK"
										value="" /> <input type="hidden" name="hiddenModalCreatorId"
										id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}" />
									<input type="hidden" name="hiddenModalCompanyId"
										id="hiddenModalCompanyId" /> <input type="hidden"
										name="hiddenModalCustomerId" id="hiddenModalCustomerId" /> <input
										type="hidden" name="hiddenModalSuggestLeaderId"
										id="hiddenModalSuggestLeaderId" /> <input type="hidden"
										name="hiddenModalSuggestCategoryProduct"
										id="hiddenModalSuggestCategoryProduct" /> <input type="hidden"
										name="hiddenModalAmount" id="hiddenModalAmount" /> <input
										type="hidden" name="hiddenModalCost" id="hiddenModalCost" />
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
var returnPK;

$(document).ready(function() { 
		modal.init();
});		

var modal = {
		init : function(){
			//유효성 체크
			modal.validate();
			
			//자동완성 검색
			commonSearch.company($('#formModalData #textCommonSearchCompany'), $('#formModalData #hiddenModalCompanyId'), $('#formModalData #textCommonSearchCompanyId'));
			//commonSearch.customer($('#formModalData #textModalCustomerName'), $('#formModalData #hiddenModalCustomerId'), $('#formModalData #textModalCustomerRank'), $('#formModalData #hiddenModalCompanyId'));
			commonSearch.singleClientIndividual($("#formModalData #textModalSingleClient"), $("#formModalData #liModalSingleClient"), $("#formModalData #textCommonSearchCompany"), $("#formModalData #hiddenModalCompanyId"), 
					$("#formModalData #textModalCustomerName"), $("#formModalData #hiddenModalCustomerId"), $("#formModalData #textModalCustomerRank"));
			commonSearch.member($('#formModalData #textModalSuggestLeader'), $('#formModalData #hiddenModalSuggestLeaderId'));
			
			$("#formModalData .followUpCheck").click(function(){
				if($(this).prop("checked")){
					$(this).val("Y");
				}else{
					$(this).val(null);
				}
			});
			
			//유효성 검사
			$("#textModalSubject, #textCommonSearchCompany, #textModalCustomerName").on("blur",function(e){
				switch (e.target.id) {
					case "textCommonSearchCompany":
						$("#formModalData").find("#hiddenModalCompanyId").valid();
						break;
					case "textModalCustomerName":
						$("#formModalData").find("#hiddenModalCustomerId").valid();
						break;
					default:
						$("#formModalData").find(e.target).valid();
						break;
				}
			});
		},
		
		deleteFile : function(fileId) {
			 $.ajax({
				url : "/common/deleteFile.do?fileId="+fileId+"&fileTableName=8&datatype=json",
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
					suggestList.completeReload();
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
			$("ul.flexdatalist-multiple li.value").remove();
			
			//모달 초기화
			$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;${userInfo.HAN_NAME}'+
					'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+commonDate.year+"\/"+commonDate.month+"\/"+commonDate.day+"</span>");
			//$("#divModalNameAndCreateDate").html("작성자 : ${userInfo.HAN_NAME} / 작성일 : "+commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			
			$("#formModalData input[type='text']").val("");
			$("#formModalData input[type='hidden']").val("");
			$("#formModalData select option").prop("selected",false);
			$("#formModalData select option:first").prop("selected",true);
			$("#formModalData textarea").val("");
			$("#formModalData textarea").height(1).height(33);
			
			$("#formModalData #hiddenModalCreatorId").val("${userInfo.MEMBER_ID_NUM}");
			
			$("#buttonModalDelete").hide();
			
			$("#formModalData #textModalSingleClient").show();
			
			commonFile.reset();
			$("#divFileUploadList span").remove();
			$("#divFileUploadList").append('<span class="blank-ment">선택된 파일이 없습니다</span>');
			
			//모달 오늘 날짜 입력
			$("h4.modal-title").html("제안서정보 신규 등록");
			$("#buttonModalSubmit").html("신규등록");
			$("small.font-bold").css('display','none');
			
			$("#myModal1").modal();
			
			//신규등록창도 수정사항 확인.
			compare_before = $("#formModalData").serialize();
		},
		
		validate : function(){
				$("#formModalData").validate({ // joinForm에 validate를 적용
					ignore: "", 
					rules : {
						textModalSubject : {
							required : true,
							maxlength : 100
						},
						/* hiddenModalCompanyId : {
							required : true
						}, */
						hiddenModalCustomerId : {
							required : true
						},
						selectModalSuggestCategoryProduct : {
							required : true
						}
					},
					messages : { // rules에 해당하는 메시지를 지정하는 속성
						textModalSubject : {
							required : "제목을 입력하세요.",
							maxlength:"100글자 이하여야 합니다" 
						},
						/* hiddenModalCompanyId : {
							required : "고객사를 선택하세요."
						//rangelength:"1글자 이상, 30글자 이하여야 합니다"
						}, */
						hiddenModalCustomerId : {
							required : "고객명을 선택하세요."
						//rangelength:"1글자 이상, 30글자 이하여야 합니다"
						},
						selectModalSuggestCategoryProduct : {
							required : "제안제품을 선택해 주세요."
						}
					},
					errorPlacement : function(error, element) {
						/* if($(element).prop("id") == "hiddenModalCompanyId") {
					        $("#textCommonSearchCompany").after(error);
					        location.href = "#textCommonSearchCompany";
					    }else  */if($(element).prop("id") == "hiddenModalCustomerId") {
					        //$("#textModalCustomerName").after(error);
					        //location.href = "#textModalCustomerName";
					        $("#ulModalSingleClient").after(error);
					        location.href = "#textModalSingleClient";
					    }else{
					        error.insertAfter(element); // default error placement.
					    }
					}
				});
		}, 
		
		submit : function(){
				 var url;
				(modalFlag == "ins") ? url = "/salesManagement/insertProposalsInfo.do" : url = "/salesManagement/updateProposalsInfo.do";
				$("#hiddenModalAmount").val(uncomma($("#textModalSuggestAmount").val()));
				$("#hiddenModalCost").val(uncomma($("#textModalSuggestCost").val()));
				$("#hiddenModalSuggestCategoryProduct").val(($("#selectModalSuggestCategoryProduct").val()).toString());
				$('#formModalData').ajaxForm({
		    		url : url,
		    		async : false,
		    		dataType: "json",
		    		data : {
		    			fileData : JSON.stringify(commonFile.fileArray)
		    		},
		    		beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            beforeSubmit: function (data,form,option) {
		            	if(!compareFlag){
							if(!confirm("저장하시겠습니까?")) return false;
		            	}
		            	$.ajaxLoadingShow();
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function(data){
		                //성공후 서버에서 받은 데이터 처리
		                if(data.cnt > 0){
		                	alert("저장하였습니다.");
		                }else{
		                	alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
		                }
		                
		                compare_before = $("#formModalData").serialize();
		                
		                //모달 닫을때 변경 값 체크
		            	if(modalFlag=="upd"){
		                	compareFlag = false;
		                	suggestList.completeReload();
						}else{
							suggestList.searchReset(); //등록/수정 시 검색 초기화
							
							suggestList.reset();
							suggestList.get(1);
							$('#myModal1').modal("hide");
						}
		            },
		            complete : function(){
						$.ajaxLoadingHide();
					}
		        });
		},
		
		deleteModal : function(){
			$.ajax({
				url : "/clientSalesActive/deleteClientContact.do",
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("삭제하시겠습니까?")) return false;
					$.ajaxLoadingShow();
				},
				data :{
					hiddenModalPK : $("#hiddenModalPK").val()
				},
				success : function(data){
					alert("삭제하였습니다."); $('#myModal1').modal("hide");
					jqGrid.reload();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		}
}
</script>