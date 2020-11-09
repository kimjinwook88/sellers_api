<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="tab-content">
   <div id="tab-1" class="tab-pane active">
       <div class="pull-right">
           <!-- <button class="btn btn-white btn-sm"> 목록보기 <i class="fa fa-list"></i></button> -->
           <!-- <button class="btn btn-white btn-sm" onClick="modal.reset();"><i class="fa fa-plus"></i> 파트너추가 </button> -->
       </div>

       <%-- <div class="small text-muted">
           <i class="fa fa-clock-o">최근 업데이트 :</i> ${defaultInfo[0].SYS_UPDATE_DATE}
       </div> --%>

       <h1 style="margin-top: 0px;">
        	${defaultInfo[0].PARTNER_PERSONAL_NAME} ${defaultInfo[0].POSITION} <c:if test="${defaultInfo[0].USE_YN ne 'Y'}"><span style="color: #8C8C8C;">(퇴사자)</span></c:if>
       </h1>

       <div class="tabs-container mg-b30">

           <ul class="nav nav-tabs">
               <li class="active"><a data-toggle="tab" href="#tab2-1" onclick="$('#buttonUpdatePartnerIndividual').show()">기본정보</a></li>
               <li class=""><a data-toggle="tab" href="#tab2-2" onclick="$('#buttonUpdatePartnerIndividual').show()">스킬정보</a></li>
               <li class=""><a data-toggle="tab" href="#tab2-3" onclick="$('#buttonUpdatePartnerIndividual').show()">교육이력</a></li>
           </ul>

           <div class="tab-content">
               <div id="tab2-1" class="tab-pane active">
               <div class="pull-right pos_t10m">
               <c:if test="${defaultInfo[0].PARTNER_PERSONAL_NAME ne '' && defaultInfo[0].PARTNER_PERSONAL_NAME ne null}">
               		<!-- CRUD 권한 가진 사람만 수정가능 -->
	               	<%-- <c:if test="${fn:contains(auth, 'ROLE_CRUD')}"> --%>
           			<button class="btn btn-white btn-sm" id="buttonUpdatePartnerIndividual" onClick="detail.update();"> 정보수정 </button>
           			<%-- </c:if> --%>
           		</c:if>
           		</div>
                <h2>기본정보</h2>

				<div class="custom-basic">
					 <div class="view_pg_type1">
					
                       <div class="col-lg-12 ag_c pos-rel custom-photo" style="display: none;">
                       <c:forEach items="${defaultPhoto}" var="defaultPhoto" varStatus="status">
                       		<c:choose>
		                       <c:when test="${defaultPhoto.FILE_PATH ne '' && defaultPhoto.FILE_PATH ne null}">
		                       	<div class="col-sm-6">
		                           <span class="mg-b20" style="background:url('/${defaultPhoto.FILE_PATH}${defaultPhoto.FILE_NAME}') no-repeat center center; background-size:cover;"></span>
		                       	</div>
		                       </c:when>
		                       <c:otherwise>
		                       	<div class="col-sm-6">
		                       	<c:choose>
		                       		<c:when test="${status.first}">
		                       		<span class="mg-b20" style="background:url('../images/pc/namecard_default.png') no-repeat center center; background-size:cover;"></span>
		                       		</c:when>
		                       		<c:otherwise>
		                       		<span class="mg-b20" style="background:url('../images/pc/photo_default.png') no-repeat center center; background-size:cover;"></span>
		                       		</c:otherwise>
		                       	</c:choose>
		                       	</div>
		                       </c:otherwise>
                       		</c:choose>
                       </c:forEach>
                       </div>
                           
                           <div class="form-group topline pd-t10">
                               <label class="col-sm-2 control-label ag_r"><span>파트너사 직원명</span></label>
                               <div class="col-sm-2">${defaultInfo[0].PARTNER_PERSONAL_NAME}</div>
                               <label class="col-sm-2 control-label ag_r"><span>파트너사 직원ID</span></label>
                               <div class="col-sm-2">${defaultInfo[0].PARTNER_INDIVIDUAL_ID}</div>
                           </div>
                           
                           <div class="form-group pd-t10">
                           		<label class="col-sm-2 control-label ag_r"><span>직급</span></label>
                              	<div class="col-sm-2">${defaultInfo[0].POSITION}</div>
								<label class="col-sm-2 control-label ag_r"><span>직책</span></label>
                             	<div class="col-sm-2">${defaultInfo[0].POSITION_DUTY}</div>
                               	<label class="col-sm-2 control-label ag_r"><span>명함/사진</span></label>
                               	<div class="col-sm-2"><a onclick="detail.businessCard(this);" style="color: blue">명함/사진 보기</a></div>
                           </div>
                           
                           <div class="form-group pd-t10">
                           		<label class="col-sm-2 control-label ag_r"><span>소속팀</span></label>
                              	<div class="col-sm-2">${defaultInfo[0].TEAM}</div>
								<label class="col-sm-2 control-label ag_r"><span>소속부서</span></label>
                             	<div class="col-sm-2">${defaultInfo[0].POST}</div>
                               	<label class="col-sm-2 control-label ag_r"><span>소속본부</span></label>
                               	<div class="col-sm-2">${defaultInfo[0].DIVISION}</div>
                           </div>
                           
                           <div class="form-group pd-t10">
                              	<label class="col-sm-2 control-label ag_r"><span>담당업무</span></label>
                               	<div class="col-sm-10">${defaultInfo[0].DUTY}</div>
                           </div>
                           
                           <div class="form-group pd-t10">
                          	   <label class="col-sm-2 control-label ag_r"><span>파트너사명</span></label>
                               <div class="col-sm-2"><a onclick="clientInfo.goDetail('${defaultInfo[0].PARTNER_ID}');" style="color: blue">${defaultInfo[0].COMPANY_NAME}</a></div>
                               <label class="col-sm-2 control-label ag_r"><span>파트너사ID</span></label>
                               <div class="col-sm-2">${defaultInfo[0].PARTNER_ID}</div>
                           </div>
                           
                           <div class="pd-t30">
                   				<h3>연락처</h3>
                   			</div>
                           
                           <div class="form-group topline pd-t10">
                               <label class="col-sm-2 control-label ag_r"><span>휴대전화</span></label>
                               <div class="col-sm-2">${defaultInfo[0].CELL_PHONE}</div>
                               <label class="col-sm-2 control-label ag_r"><span>이메일</span></label>
                               <div class="col-sm-2">${defaultInfo[0].EMAIL}</div>  
                               <label class="col-sm-2 control-label ag_r"><span>직장전화</span></label>
                               <div class="col-sm-2">${defaultInfo[0].PHONE}</div>
                           </div>
                           
                           <div class="pd-t30">
                   				<h3>기타</h3>
                   			</div>
                           
                           <div class="form-group topline pd-t10">
                           	   <label class="col-sm-2 control-label ag_r"><span>친한고객사</span></label>
                               <div class="col-sm-10">${defaultInfo[0].FRIENDSHIP_COMPANY}</div>
                           </div>
                           <div class="form-group pd-t10">
                               <label class="col-sm-2 control-label ag_r"><span>친한고객</span></label>
                               <div class="col-sm-10">${defaultInfo[0].FRIENDSHIP_CUSTOMER}</div>
                           </div>
                           <div class="form-group pd-t10">
                               <label class="col-sm-2 control-label ag_r"><span>개인정보</span></label>
                               <div class="col-sm-10">${defaultInfo[0].PERSONAL_INFO}</div> 
                           </div>
                           
                       </div>
                   </div>
               </div>
               
                  <div id="tab2-2" class="tab-pane ">
                      <h2>스킬정보</h2>
               
                      <table id="tech-companies" class="table table-bordered">
                          <thead>
                          <tr>
                              <!-- <th>No</th> -->
                              <th>스킬영역</th>
                              <th>제조사</th>
                              <th>제품그룹</th>
                              <th width="30%">솔루션영역</th>
                              <th>스킬레벨</th>
                              <th>수정일</th>
                          </tr>
                          </thead>
                          <tbody>
				              <c:choose>
							  <c:when test="${fn:length(defaultSkillMap) > 0}">
							   	<c:forEach items="${defaultSkillMap}" var="defaultSkillMap">
			                          <tr class="tr_list">
			                              <%-- <td>${defaultSkillMap.ROWNUM}</td> --%>
			                              <c:choose>
			                              <c:when test="${defaultSkillMap.SKILL_CATEGORY == 1}">
			                              	<td>영업</td>
			                              </c:when>
			                              <c:when test="${defaultSkillMap.SKILL_CATEGORY == 2}">
			                              	<td>기술</td>
			                              </c:when>
			                              <c:when test="${defaultSkillMap.SKILL_CATEGORY == 3}">
			                             	 <td>기타</td>
			                              </c:when>
			                              </c:choose>
			                              <td>${defaultSkillMap.PRODUCT_VENDOR}</td>
			                              <td class="ag_l">${defaultSkillMap.PRODUCT_GROUP}</td>
			                              <td class="ag_l">${defaultSkillMap.SOLUTION_AREA}</td>
			                              <c:choose>
			                              <c:when test="${defaultSkillMap.SKILL_LEVEL == 1}">
			                              	<td>상</td>
			                              </c:when>
			                              <c:when test="${defaultSkillMap.SKILL_LEVEL == 2}">
			                              	<td>중</td>
			                              </c:when>
			                              <c:when test="${defaultSkillMap.SKILL_LEVEL == 3}">
			                             	 <td>하</td>
			                              </c:when>
			                              </c:choose>
			                              <td>${defaultSkillMap.SYS_UPDATE_DATE}</td>
			                          </tr>
				                  </c:forEach>
							   </c:when>
							   <c:otherwise>
							   <tr class="tr_list">
							   	<td colspan="7">No Data</td>
							   </tr>
							   </c:otherwise>
							   </c:choose>
                          </tbody>
                      </table>
                  </div>
                  
               <div id="tab2-3" class="tab-pane ">
                   <h2>교육이력</h2>


                   <table id="tech-companies" class="table table-bordered">
                       <thead>
                       <tr>
                           <th>No</th>
                           <th>교육제목</th>
                           <th>교육영역</th>
                           <th>교육목표</th>
                           <th>시작일</th>
                           <th>종료일</th>
                           <th>참석시간/교육시간</th>
                           <th>수료여부</th>
                           <th>만족도</th>
                           <th>작성자</th>
                       </tr>
                       </thead>
                       <tbody>
                       <c:choose>
						  <c:when test="${fn:length(defaultEnableLog) > 0}">
					   		<c:forEach items="${defaultEnableLog}" var="defaultEnableLog">
		                      <tr class="tr_list" onclick="partnerEnable.goDetail('${defaultEnableLog.EDU_PLAN_ID}')">
		                          <td>${defaultEnableLog.ROWNUM}</td>
		                          <td class="ag_l">${defaultEnableLog.EDU_SUBJECT}</td>
		                          <td>${defaultEnableLog.SOLUTION_AREA}</td>
		                          <td class="ag_l">${defaultEnableLog.EDU_TARGET}</td>
		                          <td>${defaultEnableLog.START_DATE}</td>
		                          <td>${defaultEnableLog.END_DATE}</td>
		                          <td>${defaultEnableLog.ATTENDED_HOURS}/${defaultEnableLog.TOTAL_HOURS}</td>
		                          <td>${defaultEnableLog.CERTIFICATION_YN}</td>
		                          <td>${defaultEnableLog.SAT_VALUE}</td>
		                          <td>${defaultEnableLog.HAN_NAME}</td>
		                      </tr>
	                      	</c:forEach>
						   </c:when>
						   <c:otherwise>
						   <tr class="tr_list">
						   	<td colspan="10">No Data</td>
						   </tr>
						   </c:otherwise>
					   </c:choose>
                       </tbody>
                   </table>

               </div>

           </div>

       </div>

   </div>
   
    <form id="formDetail">
    	<input type="hidden" id="returnPK" name="returnPK">
    	<input type="hidden" id="searchDetail" name="searchDetail">
    	<input type="hidden" id="company_id" name="company_id">
    </form>
    <input type="hidden" name="hiddenPartnerIndividualId" id="hiddenPartnerIndividualId" value="${defaultInfo[0].PARTNER_INDIVIDUAL_ID}" />
    <input type="hidden" name="hiddenPartnerName" id="hiddenPartnerName" value="${defaultInfo[0].PARTNER_PERSONAL_NAME}" />
    <input type="hidden" name="hiddenCreatorId" id="hiddenCreatorId" value="${defaultInfo[0].HAN_NAME}" />
    <input type="hidden" name="hiddenSysUpdateDate" id="hiddenSysUpdateDate" value="${defaultInfo[0].SYS_UPDATE_DATE}" />
    <input type="hidden" name="hiddenDivision" id="hiddenDivision" value="${defaultInfo[0].DIVISION}" />
    <input type="hidden" name="hiddenPost" id="hiddenPost" value="${defaultInfo[0].POST}" />
    <input type="hidden" name="hiddenTeam" id="hiddenTeam" value="${defaultInfo[0].TEAM}" />
    <input type="hidden" name="hiddenPosition" id="hiddenPosition" value="${defaultInfo[0].POSITION}" />
    <input type="hidden" name="hiddenSkillType" id="hiddenSkillType" value="${defaultInfo[0].SKILL_TYPE}" />
    <input type="hidden" name="hiddenDuty" id="hiddenDuty" value="${defaultInfo[0].DUTY}" />
    <input type="hidden" name="hiddenCellPhone" id="hiddenCellPhone" value="${defaultInfo[0].CELL_PHONE}" />
    <input type="hidden" name="hiddenPhone" id="hiddenPhone" value="${defaultInfo[0].PHONE}" />
    <input type="hidden" name="hiddenEmail" id="hiddenEmail" value="${defaultInfo[0].EMAIL}" />
    <input type="hidden" name="hiddenFriendShipCompany" id="hiddenFriendShipCompany" value="${defaultInfo[0].FRIENDSHIP_COMPANY}" />
    <input type="hidden" name="hiddenFriendShipCustomer" id="hiddenFriendShipCustomer" value="${defaultInfo[0].FRIENDSHIP_CUSTOMER}" />
    <input type="hidden" name="hiddenPersonalNameCard" id="hiddenPersonalNameCard" value="${defaultPhoto[0].FILE_PATH}${defaultPhoto[0].FILE_NAME}" />
    <input type="hidden" name="hiddenPersonalPhoto" id="hiddenPersonalPhoto" value="${defaultPhoto[0].FILE_PATH}${defaultPhoto[0].FILE_NAME}" />
    <input type="hidden" name="hiddenPersonalInfo" id="hiddenPersonalInfo" value="${defaultInfo[0].PERSONAL_INFO}" />
    <input type="hidden" name="hiddenFriendshipInfo" id="hiddenFriendshipInfo" value="${defaultInfo[0].FRIENDSHIP_INFO}" />
    <input type="hidden" name="hiddenCompanyName" id="hiddenCompanyName" value="${defaultInfo[0].COMPANY_NAME}" />
    <input type="hidden" name="hiddenCompanyId" id="hiddenCompanyId" value="${defaultInfo[0].PARTNER_ID}" />
    <input type="hidden" name="hiddenUseYn" id="hiddenUseYn" value="${defaultInfo[0].USE_YN}" />
    <input type="hidden" name="hiddenPositionDuty" id="hiddenPositionDuty" value="${defaultInfo[0].POSITION_DUTY}" />
    
</div>


<script type="text/javascript">
var modalFlag = "upd"; //업데이트
var searchSerialize;
var reloadFlag = true;

var compare_before;
var compare_after;
var compareFlag = false;

$(document).ready(function() {
	$("#LATELY_UPDATE_DATE").html($("#hiddenSysUpdateDate").val());
});


/*
 * 파트너사개인정보 상세 페이지에서 정보수정 눌렀을때, Modal 창
 */
var detail = {
		update : function(){
			comparePerSonalProfile = "";
			comparePerSonalActs = ""
			comparePerSonalFamily = "";
			comparePerSonalInclination = "";
			comparePerSonalFamiliars = "";
			comparePerSonalSNS = "";
			comparePerSonalETC = "";
			
			$("#divModalNameAndCreateDate").html('<span class=\"label black_count_bg\"><i class=\"fa fa-pencil\"></i>&nbsp;&nbsp;'+$("#hiddenCreatorId").val()+
					'&nbsp;&nbsp;|&nbsp;&nbsp;<i class=\"fa fa-clock-o\"></i>&nbsp;&nbsp;'+$("#hiddenSysUpdateDate").val().replace(/-/gi, "/")+"</span>");
			//$("#divModalNameAndCreateDate").html("작성자 : "+$("#hiddenCreatorId").val()+"/ 작성일 : "+$("#hiddenSysUpdateDate").val());
			$("#textCommonSearchCompany").val($("#hiddenCompanyName").val());			//고객사명
			$("#textCommonSearchCompanyId").val($("#hiddenCompanyId").val());			//고객사ID
			$("#textModalDivision").val($("#hiddenDivision").val());						//소속본부
			$("#textModalPost").val($("#hiddenPost").val());								//소속부서
			$("#textModalTeam").val($("#hiddenTeam").val());								//소속팀명
			
			$("#textModalReportingLineDivision").val($("#hiddenDivision").val());
			$("#textModalReportingLinePost").val($("#hiddenPost").val());
			$("#textModalReportingLineTeam").val($("#hiddenTeam").val());
			
			$("#textModalReportingDivisionResult").val($("#hiddenReportingDivisionId").val());
			$("#textModalReportingPostResult").val($("#hiddenReportingPostId").val());
			$("#textModalReportingTeamResult").val($("#hiddenReportingTeamId").val());
			
			$("#textModalReportingLineDivisionName").val($("#hiddenReportingDivisionName").val());
			$("#textModalReportingLinePostName").val($("#hiddenReportingPostName").val());
			$("#textModalReportingLineTeamName").val($("#hiddenReportingTeamName").val());
			
			$("#textModalReportingDivisionPosition").val($("#hiddenReportingDivisionPosition").val());
			$("#textModalReportingPostPosition").val($("#hiddenReportingPostPosition").val());
			$("#textModalReportingTeamPosition").val($("#hiddenReportingTeamPosition").val());
			
			$("input:radio[name='radioModalUseYN']:radio[value='"+$("#hiddenUseYn").val()+"']").prop("checked",true); //재직여부
			
			$("#textModalDuty").val($("#hiddenDuty").val());								//담당업무
			$("#textModalEmail").val($("#hiddenEmail").val());							//전자메일
			$("#textModalAddress").val($("#hiddenAddress").val());										//주소
			$("#textModalPartnerName").val($("#hiddenPartnerName").val());				//고객명
			$("#textModalPosition").val($("#hiddenPosition").val());					//직급
			//$("#textModalSkillType").val($("#hiddenSkillType").val());					//역할구분
			$("#textModalPositionDuty").val($("#hiddenPositionDuty").val());			//직책
			$("#textModalCellPhone").val($("#hiddenCellPhone").val());					//휴대전화
			$("#textModalPhone").val($("#hiddenPhone").val());							//일반전화
			
			if($("#hiddenPersonalNameCard").val()!='' && $("#hiddenPersonalNameCard").val()!=null) {
				$("#divModalUploadNameCard").html('<span name="modalFile'+$("#hiddenCreatorId").val()+'" style="display:none;"> <img class="photo" border="0" alt="" style="background:url(\'/'+$("#hiddenPersonalNameCard").val()+'\') no-repeat center center; background-size:cover;">');			//개인사진
			}else{
				$("#divModalUploadNameCard").html('<span class="blank-ment"><img style="background:url(\'../images/pc/namecard_default.png\') no-repeat center center; background-size:cover;" class="photo" alt=""/></span>');
			}
			if($("#hiddenPersonalPhoto").val()!='' && $("#hiddenPersonalPhoto").val()!=null) {
				$("#divModalUploadPhoto").html('<span name="modalFile'+$("#hiddenCreatorId").val()+'" style="display:none;"> <img class="photo" border="0" alt="" style="background:url(\'/'+$("#hiddenPersonalPhoto").val()+'\') no-repeat center center; background-size:cover;">');			//개인사진
			}else{
				$("#divModalUploadPhoto").html('<span class="blank-ment"><img style="background:url(\'../images/pc/namecard_default.png\') no-repeat center center; background-size:cover;" class="photo" alt=""/></span>');
			}
			$("#textModalRelationshipInfo").val($("#hiddenRelationship").val()); 			//자사와의 관계
			$("#textModalFriendshipInfo").val($("#hiddenFriendshipInfo").val());			//친한직원
			$("#textModalFriendShipCompany").val($("#hiddenFriendShipCompany").val());
			$("#textModalFriendShipCustomer").val($("#hiddenFriendShipCustomer").val());
			$("#textModalPerSonalInfo").val($("#hiddenPersonalInfo").val());			//개인정보
			$("#textModalPerSonalPrevSales").val($("#hiddenPrevSalesHanName").val());			//이전_고객담당영업직원이름
			$("#textModalPerSonalEducation").val($("#hiddenPersonalInfoEducation").val());			//개인정보_학력경력
			$("#textModalPerSonalEducationPerson").val($("#hiddenPersonalInfoEducationPerson").val());			//개인정보_학력경력
			$("#textModalPerSonalCareer").val($("#hiddenPersonalInfoCareer").val());			//개인정보_학력경력
			$("#textModalPerSonalCareerPerson").val($("#hiddenPersonalInfoCareerPerson").val());			//개인정보_학력경력
			$("#textModalPerSonalActs").val($("#hiddenPersonalInfoSocialActs").val());			//개인정보_사회활동
			$("#textModalPerSonalFamily").val($("#hiddenPersonalInfoFamily").val());			//개인정보_가족
			$("#textModalPerSonalInclination").val($("#hiddenPersonalInfoInclination").val());	//개인정보_성향
			$("#textModalPerSonalFamiliars").val($("#hiddenPersonalInfoFamilars").val());		//개인정보_친한사람
			$("#textModalPerSonalSNS").val($("#hiddenPersonalInfoSNS").val());					//개인정보_SNS
			$("#textModalPerSonalETC").val($("#hiddenPersonalInfoETC").val());					//개인정보_기타
			$("#textModalPositionDuty").val($("#hiddenPositionDuty").val());					//직책
			/* commonSearch.companyHtml($("#hiddenCompanyName").val(), $("#hiddenCompanyId").val());
			$("ul.company-list").html("");
			$("#textCommonSearchCompany").val(""); */
			
			$("#hiddenModalCompanyId").val($("#hiddenCompanyId").val());					//고객사아이디
			$("#hiddenModalPK").val($("#hiddenPartnerIndividualId").val());					//고객아이디
			
			// 아래 필요없는거 삭제 
			$("#buttonModalDelete").show();
			
			$("#divModalUploadNameCard").show();
			$("#divModalNameCardUploadArea .fileModalUploadNameCard").remove();
			$("#divModalUploadPhoto").show();
			$("#divModalPhotoUploadArea .fileModalUploadPhoto").remove();
			//$('#divFileUploadList').html('<span>파일을 선택해 주세요.</span>');
			
			//$("#divModalUploadPhoto span").hide();
			$("#divModalUploadNameCard span[name='modalFile"+$("#hiddenCreatorId").val()+"']").show();
			$("#divModalUploadNameCard #imgModalInsertNameCard").remove();
			$("#divModalUploadPhoto span[name='modalFile"+$("#hiddenCreatorId").val()+"']").show();
			$("#divModalUploadPhoto #imgModalInsertPhoto").remove();
			
			
			$("h4.modal-title").html($("#hiddenPartnerName").val()+" "+$("#hiddenPosition").val());
			$("small.font-bold").css('display','');
			$("#buttonModalSubmit").html("저장하기");
			
			salesDetail.reset();
			salesDetail.drawQualification();
			$("#myModal1").modal();
			//신규등록, 상세보기 div 접기 펴기
			//toggleDiv(modalFlag);
			compare_before = $("#formModalData").serialize();
			//값 비교를 위한.
		},
		
		businessCard : function(chk) {
			if($(chk).html() == '명함/사진 보기') {
				$(chk).html('명함/사진 숨기기');
				$("div.col-lg-12.ag_c.pos-rel.custom-photo").show();
			}else {
				$(chk).html('명함/사진 보기');
				$("div.col-lg-12.ag_c.pos-rel.custom-photo").hide();
			}
		}
}

/**
 * 파트너사 개인정보 상세페이지에서 [기본정보]탭 파트너사면 클릭시 사용되는 function
 */
var clientInfo = {
		goDetail : function(company_id) {
			$("#formDetail #searchDetail").val($("#hiddenCompanyName").val());
			$("#formDetail #company_id").val(company_id);
			//$("#formDetail").attr({action:"/partnerManagement/listPartnerCompanyInfoListDetail.do", method:"post"}).submit();
			menuCookieSet("파트너사정보"); //메뉴 활성화
			var form =  $("#formDetail")[0];
			var url = "/partnerManagement/viewPartnerCompanyInfoDetail.do";
			window.open("" ,"toPartnerCompany"); 
			form.target = "toPartnerCompany";
			form.action = url; 
			form.submit();
		}
}

/**
 * 파트너사 개인정보 상세 페이지 [교육이력]탭 클릭 링크 function
 */
var partnerEnable = {
		goDetail : function(edu_plan_id){
			$("#formDetail #returnPK").val(edu_plan_id);
			//$("#formDetail").attr({action:"/partnerManagement/viewPartnerEnablement.do", method:"post"}).submit();
			menuCookieSet("파트너사협업관리"); //메뉴 활성화
			var form =  $("#formDetail")[0];
			var url = "/partnerManagement/viewPartnerEnablement.do";
			window.open("" ,"toEnablement"); 
			form.target = "toEnablement";
			form.action = url; 
			form.submit();
		}
}
</script>