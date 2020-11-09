<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="modal inmodal fade" id="myModal1" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="ibox ">
                            <div class="ibox-content border_n">
                                <form class="form-horizontal" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">
                                    <div class="form-group">
                                    	<div class="col-sm-12 ag_r">
	                                    	<span name="divModalNameAndCreateDate" id="divModalNameAndCreateDate">작성자 : 홍길동 / 작성일 : 2016-05-10</span>
	                                    	<!-- <button type="button" class="btn btn-gray mg-b10" name="buttonModalCoachingTalkView" id="buttonModalCoachingTalkView" onclick="coachingTalk.view('opp');">Coaching Talk</button> -->
	                                    </div>
                                        <!-- <div class="col-sm-2 ag_r mg-b10"><a href="#" class="btn_comment_view">Comment 보기</a></div> -->
                                         
                                        <div id="divModalCoachingTalk" style="display: none;">
                                			<jsp:include page="/WEB-INF/jsp/pc/common/coachingTalkModal.jsp"/>
                                		</div>
                                        
                                    </div>
                                    <div class="form-group"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 제목</label>
                                        <div class="col-sm-10"><input type="text" class="form-control" id="textModalSubject" name="textModalSubject"/></div>
                                    </div>
                                    
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group pos-rel"><label class="col-sm-2 control-label"><i class="fa fa-check" style="color: green;"></i> 담당자</label>
                                        <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textCommonSearchCompany" name="textCommonSearchCompany" placeholder="담당자를 검색해 주세요." autocomplete="off"/></div>
                                        <label class="col-sm-2 control-label"> 직급</label>
                                        <div class="col-sm-4 pos-rel"><input type="text" class="form-control" id="textModalCustomerName" name="textModalCustomerName"/></div>
                                    </div>
                                    
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group">
                                       <label class="col-sm-2 control-label"> 부서</label>
                                        <div class="col-sm-4"><input type="text" class="form-control" id="textModalErpProjectCode" name="textModalErpProjectCode"/></div>                                                                                
                                    </div>
                                    
                                    
                                    <div class="hr-line-dashed"></div>
                                    <div class="form-group">
                                       <label class="col-sm-2 control-label" for="date_modified"><i class="fa fa-check" style="color: green;"></i> 예상완료일</label>
                                        <div class="col-sm-4">
                                            <div class="data_1">
                                                <div class="input-group date">
                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textModalContractDate" name="textModalContractDate" value="">
                                                </div>
                                            </div>
                                        </div>                                                                                
                                    </div>

                                    <!-- <div class="hr-line-bottom"></div> -->
                                    
									
                                    <!-- TabMenu -->
                                    <div class="tab-area">

                                        <!-- tab-menu -->
                                        <!-- 
                                        <ul class="tabmenu-type">
                                            <li><a href="#" class="">마일스톤</a></li>
                                        </ul>
                                         -->
                                        <!--// tab-menu -->
                                        
                                        <!-- 마일스톤 -->
                                         <div class="hr-line-dashed"></div>
                                        <div class="sub_cont scont3 modaltabmenu">	
											<jsp:include page="/WEB-INF/jsp/pc/etc/ceoOnHandMilestones.jsp"/>
                                        </div>
                                        <!--// 마일스톤 -->
                                    </div>
                                    
                                     
                                    <!-- 마일스톤 -->
									<%-- 
									<div class="sub_cont scont3 modaltabmenu off">	
										<jsp:include page="/WEB-INF/jsp/pc/etc/ceoOnHandMilestones.jsp"/>
									</div>
									 --%>
									<!--// 마일스톤 -->
                                    
                                    
                                    <!--// TabMenu -->                                            
                                    
                                    <p class="text-center pd-t20">
                                        <!-- <button type="button" class="btn btn-outline btn-primary btn-gray-outline">삭제하기</button> -->                                        
                                        <button type="submit " class="btn btn-w-m btn-seller" onclick="modal.submit();" id="buttonModalSubmit">저장하기</button>
                                    </p>
                                    
                                    <input type="hidden"name="hiddenModalPK" id="hiddenModalPK"/>
 	                                <input type="hidden"name="hiddenModalOpportunityhiddenId" id="hiddenModalOpportunityhiddenId"/>
	                                <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
	                                <input type="hidden" name="hiddenModalSalesCycle" id="hiddenModalSalesCycle" value="1" />
	                                
	                                <!-- <input type="hidden" name="hiddenModalSalesPartner" id="hiddenModalSalesPartner"/> -->
	                                <input type="hidden" name="hiddenModalContractAmount" id="hiddenModalContractAmount"/>
	                                <input type="hidden" name="hiddenModalGPAmount" id="hiddenModalGPAmount"/>
	                               
	                                <input type="hidden" name="hiddenModalSalesREVArr" id="hiddenModalSalesREVArr"/>
	                                <input type="hidden" name="hiddenModalSalesGPArr" id="hiddenModalSalesGPArr"/>
	                                <input type="hidden" name="hiddenModalSalesDateArr" id="hiddenModalSalesDateArr"/>
	                               
	                                <input type="hidden" name="hiddenModalCompanyId" id="hiddenModalCompanyId"/>
	                                <input type="hidden" name="hiddenModalPartnerId" id="hiddenModalPartnerId"/>
	                               
	                                <input type="hidden" name="hiddenModalExecId" id="hiddenModalExecId"/>
	                                <input type="hidden" name="hiddenModalOwnerId" id="hiddenModalOwnerId"/>
	                                <input type="hidden" name="hiddenModalIdentifierId" id="hiddenModalIdentifierId"/>
	                                <input type="hidden" name="hiddenModalCustomerId" id="hiddenModalCustomerId"/>
	                                
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
$(document).ready(function() { 
		modal.init();
});		

var modal = {
		init : function(){
			//유효성 체크
			modal.validate();
			
			//자동완성 검색
			commonSearch.member($("#formModalData #textCommonSearchCompany"), $('#formModalData #hiddenModalCompanyId')); //실행임원
			
			
			commonSearch.member($("#formModalData #textModalOpportunityOwner"), $('#formModalData #hiddenModalOwnerId')); //OO
			commonSearch.member($("#formModalData #textModalOpportunityIdentifier"), $('#formModalData #hiddenModalIdentifierId')); //OI
			
			
			//commonSearch.company($('#formModalData #textCommonSearchCompany'), $('#formModalData #hiddenModalCompanyId'), $('#formModalData #textCommonSearchCompanyId'));
			//commonSearch.customer($('#formModalData #textModalCustomerName'), $('#formModalData #hiddenModalCustomerId'), $('#formModalData #textModalCustomerRank'), $('#formModalData #hiddenModalCompanyId'));
			
			$("#textCommonSearchPartner").keydown(function (key) {
		   		if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
		   			commonSearch.partnerInfo();
			     }
			 });
			
			$('#textModalContractAmount').keyup(function(){
				//$('tr[name="revTr"]').eq(0).find('input[name="amount_r"]').eq(0).val($(this).val());
				//oppSalesPlan.quarterSum();
				//oppSalesPlan.divisionSum();
			});
			
			//tab menu
			$("ul.tabmenu-type").on({
				'click.modalTab' : function(e){
					e.preventDefault();
					var idx = $("ul.tabmenu-type li a").index($(this));
					$("ul.tabmenu-type li a").removeClass("sel");
					$(this).addClass("sel");
					//$("div.modaltabmenu").addClass("off");
					//$("div.modaltabmenu").eq(idx).removeClass("off");
				}
			},'li a');
			/* 
			$("ul.tabmenu-type li a").click(function(e){
				e.preventDefault();
				var idx = $("ul.tabmenu-type li a").index($(this));
				$("ul.tabmenu-type li a").removeClass("sel");
				$(this).addClass("sel");
				$("div.modaltabmenu").addClass("off");
				$("div.modaltabmenu").eq(idx).removeClass("off");
			}); */
			
			//매출계획 예상계약일에 따른 분기 계산
			$('#textModalContractDate').change(function(){
				//oppSalesPlan.quarter();
			});
			
			//유효성 검사
			$("#textModalSubject, #textCommonSearchCompany, #textModalCustomerName, #textModalContractAmount, #textModalGPAmount,  #textModalContractDate, #textModalOpportunityOwner, #textModalOpportunityIdentifier").on("blur",function(e){
				switch (e.target.id) {
					case "textModalOpportunityOwner":
						$("#formModalData").find("#hiddenModalOwnerId").valid();
						break;
					case "textModalOpportunityIdentifier":
						$("#formModalData").find("#hiddenModalIdentifierId").valid();
						break;
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
				url : "/common/deleteFile.do?fileId="+fileId+"&fileTableName=6&datatype=json",
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
					oppList.completeReload();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		//신규등록
		reset : function() { 
			modalFlag = "ins"; //신규등록
			
			//모달 초기화
			$("#divModalNameAndCreateDate").html("작성자 : ${userInfo.HAN_NAME} / 작성일 : "+commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			
			//코칭톡 버튼 숨김
			//$("#buttonModalCoachingTalkView").hide();
			
			//validate 초기화 및 text,selectbox,radio.. 등 초기화
			$("#formModalData").validate().resetForm();
			$("#formModalData textarea").height(1).height(33);
			
			//히든값 초기화
			$("#formModalData #hiddenModalPK").val("");
			$("#formModalData #hiddenModalContractAmount").val("");
			$("#formModalData #hiddenModalGPAmount").val("");
			$("#formModalData #hiddenModalCompanyId").val("");
			$("#formModalData #hiddenModalPartnerId").val("");
			$("#formModalData #hiddenModalExecId").val("");
			$("#formModalData #hiddenModalOwnerId").val("");
			$("#formModalData #hiddenModalIdentifierId").val("");
			$("#formModalData #hiddenModalCustomerId").val("");
			$("#formModalData #hiddenModalSalesREVArr").val("");
			$("#formModalData #hiddenModalSalesGPArr").val("");
			$("#formModalData #hiddenModalSalesDateArr").val("");
			$("#formModalData #hiddenModalSalesCycle").val("1");
			
			$("div.company-current").html("");
			$("ul.company-list").html("");
			commonSearch.partnerArray = [];
			
			$("div.partner-current").html("");
			$("ul.partner-list").html("");
			
			$("#buttonModalDelete").hide();
			
			commonFile.reset();
			$("#divFileUploadList span").remove();
			$("#divFileUploadList").append('<span class="blank-ment">선택된 파일이 없습니다</span>');
			
			//tabl 초기화
			$("ul.tabmenu-type li a").removeClass("sel");
			$("ul.tabmenu-type li a:first").addClass("sel");
			//$("div.modaltabmenu").addClass("off");
			//$("div.modaltabmenu:first").removeClass("off");
			
			//oppSalesPlan.quarter(); //매출계획
			//oppSalesPlan.reset();
			
			oppMilestone.draw(); //마일스톤
			oppMilestone.reload(); //마일스톤
			
			$("#divSalesCycleClose").hide(); //Sales Cycle
			$("div.salescycle-step ul li").removeClass("active");
			$("div.salescycle-step ul li:first").addClass("active");
			
			$('div[name="insertAfterMsg"]').show();
			//oppCheckList.clear();
			//oppWinPlan.clear();
			
			//모달 오늘 날짜 입력
			$("h4.modal-title").html("신규 등록");
			$("#buttonModalSubmit").html("신규등록");
			$("small.font-bold").css('display','none');
			
			//매출 계획 금액  초기화
			$("#divModalSalesPlan").html("");
			$("#textModalContractAmountRemainder").val('0');
			
			//slaes cycle 초기화
			$('#buttonModalSubmit').show();
			$('#selectSalesCloseCategory, #textareaSalesCloseDetail').prop("disabled",false);
			//Sales Cycle
			$("div.salescycle-step").on({
				'click.salesCycle' : function(e){
					e.preventDefault();
					var idx = $("div.salescycle-step ul li a").index($(this));
					$("div.salescycle-step ul li").removeClass("active");
					
					if(idx == 2){ //close
						$("#divSalesCycleClose").show();	
					}else{
						$("#divSalesCycleClose").hide();
					}
					
					for(var i=0; i<=idx; i++){ //on 
						$("#hiddenModalSalesCycle").val(i+1);
						$("div.salescycle-step ul li").eq(i).addClass("active");	
					}
				}
			},'ul li a');
			
			$("#myModal1").modal();
			
			//신규등록창도 수정사항 확인.
			compare_before = $("#formModalData").serialize();
		},
		
		validate : function(){
				$("#formModalData").validate({ // joinForm에 validate를 적용
					ignore: '', 
					rules : {
						textModalSubject : {
							required : true,
							maxlength : 100
						},
						hiddenModalCompanyId : {
							required : true,
						},
						/* 
						hiddenModalCustomerId : {
							required : true
						},
						 */
						textModalContractDate : {
							required : true
						}
					/* 	textModalContractDate : {
							required : true
						},
						// required는 필수, rangelength는 글자 개수(1~10개 사이)
						textModalContractAmount : {
							required : true,
							digits:true
						} */
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
						textModalSubject : {
							required : "제목을 입력하세요.",
							maxlength:"100글자 이하여야 합니다." 
						},
						hiddenModalCompanyId : {
							required : "담당자를 입력하세요."
						},
						/* 
						hiddenModalCustomerId : {
							required : "고객명을 입력하세요."
						},
						 */
						textModalContractDate : {
					 		required : "예상완료일을 선택하세요."
						}
					},
					/* 
					invalidHandler : function(error, element) {
						$('div.modaltabmenu').each(function(idx,obj){
							$("ul.tabmenu-type li a").eq(idx).trigger('click.modalTab');
							return false;
						});
					},
					 */
					errorPlacement : function(error, element) {
						if($(element).prop("id") == "hiddenModalExecId") {
					        $("#textModalExecOwner").after(error);
					        location.href = "#textModalExecOwner";
					    }else if($(element).prop("id") == "hiddenModalOwnerId") {
					    	$("#textModalOpportunityOwner").after(error);
					        location.href = "#textModalOpportunityOwner";
					    }else if($(element).prop("id") == "hiddenModalIdentifierId") {
					    	$("#textModalOpportunityIdentifier").after(error);
					        location.href = "#textModalOpportunityIdentifier";
					    }else if($(element).prop("id") == "hiddenModalCompanyId") {
					    	$("#textCommonSearchCompany").after(error);
					        location.href = "#textCommonSearchCompany";
					    }else if($(element).prop("id") == "hiddenModalCustomerId") {
					    	$("#textModalCustomerName").after(error);
					        location.href = "#textModalCustomerName";
					    }else{
					        error.insertAfter(element); // default error placement.
					    }
					}
				})
		}, 
		
		submit : function(){
				var url;
				
				//예상계약금액, 예상GP금액
				$("#hiddenModalContractAmount").val(uncomma($("#textModalContractAmount").val()));
				$("#hiddenModalGPAmount").val(uncomma($("#textModalGPAmount").val()));
				
				if(modalFlag == "ins"){
					url = "/etc/insertCeoOnHand.do";
					/* 
					//신규등록일 때 opportunity owner가 입력되면 매출계획 영업대표 자동 입력
					if(isEmpty($("input[name='splitMember']").eq(0).val())){
						$("input[name='splitMember']").eq(0).val($('#formModalData #textModalOpportunityOwner').val());
						$("input[name='splitMemberId']").eq(0).val($('#formModalData #hiddenModalOwnerId').val());
					}
					 */
				}else{
					//체크리스트
					//oppCheckList.saveRow();
					//윈플랜
					//oppWinPlan.saveRow();	
					url = "/etc/updateCeoOnHand.do";
				}
				//매출계획
				//oppSalesPlan.calSalesPlan();
				//마일스톤
				oppMilestone.saveRow();			
				
				 $('#formModalData').ajaxForm({
		    		url : url,
		    		async : true,
		    		dataType: "json",
		    		data : {
		    			mileStoneData : JSON.stringify($("#oppMilestone").getRowData()),
		    			//checkListData : JSON.stringify($("#oppCheckList").getRowData()),
		    			//winPlanData : JSON.stringify($("#oppWinPlan").getRowData()),
		    			//salesPlanData : JSON.stringify(oppSalesPlan.salesPlanList)
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
		                	
		                	compareFlag = false;
		                	compare_before = $("#formModalData").serialize();
		                	
		                	//oppSalesPlan.quarter(); //매출계획
							oppMilestone.draw(); //마일스톤
							oppMilestone.reload(); //마일스톤
							
							//oppCheckList.clear();
							//oppCheckList.draw(); //체크리스트
							//oppCheckList.reload(); //체크리스트
							
							//oppWinPlan.clear();
							//oppWinPlan.draw(); //Win Plan
							//oppWinPlan.reload(); //Win Plan
							
		                	oppList.reset();
		                	oppList.get();
		                	
		                	/* if(compareFlag){ //변경 내용 저장
			            		compareFlag = false;
			            		compare_before = null;
			            		compare_after = null;
			            	}else  */if(modalFlag == "ins"){ //신규등록
			            		$('#myModal1').modal("hide");
			            	}else if(modalFlag == "upd"){ //업데이트
			            		compare_before = $("#formModalData").serialize();
			            		oppList.completeReload();
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
		
		
		
		deleteModal : function(){
			$.ajax({
				url : "/clientSalesActive/deleteOpportunity.do",
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
					alert("삭제하였습니다."); $('#myModal1').modal("hide");
					oppList.completeReload();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		}
		
}
</script>






<script type="text/javascript">
var modalAmount = {
		setting : function() {
			if(!isEmpty($("#selectModalContractTerm").val()) && !isEmpty($("#textModalContractDate").val())){
				var today = moment(new Date());
				var startDate = $("#textModalContractDate").val();
				var mStart = moment(startDate);
				var monthDiff = $("#selectModalContractTerm").val() * 12;
				var monthView = mStart;
				for(var i=0; i<=monthDiff; i++){
				 	$("#divModalSalesPlan").append(
				 	'<div class="progress-step" name="'+monthView.format('YYYY')+"년"+monthView.format('MM')+"월"+'"><span class="ti">'
				 	+monthView.format('YYYY')+"년"+monthView.format('MM')+"월"+'</span><div class="paybox">'
				 	+'<div class="hgrid plan"><span class="dt">REV</span><input type="text" class="pay" name="textModalREVAmount" amount-data="'+monthView.format('YYYY')+'-'+monthView.format('MM')+'-'+'01" onClick="modalAmount.zero(this);" OnKeyUp="comma(this);modalAmount.calculation();" onblur="modalAmount.onblur(this);" value="0"/></div>'
				 	+'<div class="hgrid plan"><span class="dt">GP</span><input type="text" class="pay" name="textModalGPAmount" amount-data="'+monthView.format('YYYY')+'-'+monthView.format('MM')+'-'+'01" onClick="modalAmount.zero(this);" OnKeyUp="comma(this);" onblur="modalAmount.onblur(this);" value="0"/></div>'
				 	+'</div>'
					);
				 	monthView = monthView.add('months', 1);
				}
			}else{
				$("#divModalSalesPlan").html("");
			}
		},
		
		calculation : function(){
			var contractAmount = uncomma($("#textModalContractAmount").val());
			$("input[name='textModalREVAmount']").each(function(){
				contractAmount -= uncomma($(this).val());
			});
			$("#textModalContractAmountRemainder").val(add_comma(contractAmount.toString()));
		},
		
		zero : function(pay) {
			if(pay.value=="0") pay.value="";
		},
		
		onblur : function(obj){
			if(isEmpty($(obj).val())){
				$(obj).val(0);
			}
		},
		
		//month차이 
		monthDiff : function(d1,d2){
		    var monthsDiff;
		    monthsDiff = (d2.getFullYear() - d1.getFullYear()) * 12;
		    monthsDiff -= d1.getMonth() + 1;
		    monthsDiff += d2.getMonth();
		    monthsDiff ++;
		    return monthsDiff <= 0 ? 0 : monthsDiff;
		}
}
</script>
