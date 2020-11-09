<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
			
			<div id="tab2-1" class="tab-pane active">
               <div class="pull-right pos_t10m">
               	 <c:if test="${defaultInfo[0].CUSTOMER_NAME ne '' && defaultInfo[0].CUSTOMER_NAME ne null}">
               		<!-- CRUD 권한 가진 사람만 수정가능 -->
	               	<%-- <c:if test="${fn:contains(auth, 'ROLE_CRUD')}"> --%>
	               	<button class="btn btn-white btn-sm" id="buttonUpdateClientIndividual" onClick="detail.update();"> 정보수정 </button>
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
                               <label class="col-sm-2 control-label ag_r"><span>고객명</span></label>
                               <div class="col-sm-2">${defaultInfo[0].CUSTOMER_NAME}</div>
                               <label class="col-sm-2 control-label ag_r"><span>고객ID</span></label>
                               <div class="col-sm-2">${defaultInfo[0].CUSTOMER_ID}</div>
                           </div>
                           
                           <div class="form-group pd-t10">
                           		<label class="col-sm-2 control-label ag_r"><span>직급</span></label>
                              	<div class="col-sm-2">${defaultInfo[0].POSITION}</div>
								<%-- <label class="col-sm-2 control-label ag_r"><span>직책</span></label>
                             	<div class="col-sm-2">${defaultInfo[0].POSITION_DUTY}</div> --%>
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
                           		<label class="col-sm-2 control-label ag_r"><span>직책</span></label>
                             	<div class="col-sm-2">${defaultInfo[0].POSITION_DUTY}</div>
                              	<label class="col-sm-2 control-label ag_r"><span>담당업무</span></label>
                               	<div class="col-sm-6">${defaultInfo[0].DUTY}</div>
                           </div>
                           
                           <div class="form-group pd-t10">
                          	   <label class="col-sm-2 control-label ag_r"><span>고객사명</span></label>
                               <div class="col-sm-2"><a onclick="goDetail.clientInfo('${defaultInfo[0].COMPANY_ID}');" style="color: blue">${defaultInfo[0].COMPANY_NAME}</a></div>
                               <label class="col-sm-2 control-label ag_r"><span>고객사ID</span></label>
                               <div class="col-sm-2">${defaultInfo[0].COMPANY_ID}</div>
                           </div>
                           
                           <div class="pd-t30">
                   				<h3>연락처</h3>
                   			</div>
                           
                           <div class="form-group topline pd-t10">
                               <label class="col-sm-2 control-label ag_r"><span>휴대전화</span></label>
                               <div class="col-sm-2">${defaultInfo[0].CELL_PHONE}</div>
                               <label class="col-sm-2 control-label ag_r"><span>전자메일</span></label>
                               <div class="col-sm-6">${defaultInfo[0].EMAIL}</div>  
                           </div>
                           
                           <div class="form-group pd-t10">
                               <label class="col-sm-2 control-label ag_r"><span>직장전화</span></label>
                               <div class="col-sm-2">${defaultInfo[0].PHONE}</div>
                               <label class="col-sm-2 control-label ag_r"><span>집주소</span></label>
                               <div class="col-sm-6">${defaultInfo[0].ADDRESS}</div>
                           </div>
                           
                           <div class="pd-t30">
                   				<h3>보고라인</h3>
                   			</div>
                           
                           <div class="form-group topline pd-t10">
                          		<label class="col-sm-2 control-label ag_r"><span>소속팀</span></label>
                               <div class="col-sm-2">${defaultInfo[0].TEAM_TEAM}</div> 
                               <label class="col-sm-2 control-label ag_r"><span>소속부서</span></label>
                               <div class="col-sm-2">${defaultInfo[0].POST_POST}</div>
                           	   <label class="col-sm-2 control-label ag_r"><span>소속본부</span></label>
                               <div class="col-sm-2">${defaultInfo[0].DIVISION_DIVISION}</div>
                           </div>
                           
                           <div class="form-group pd-t10">
                            	<label class="col-sm-2 control-label ag_r"><span>${defaultInfo[0].TEAM_POSITION_DUTY}</span></label>
                               <div class="col-sm-2"><a onclick="clientList.goDetail(${defaultInfo[0].TEAM_ID},'','${defaultInfo[0].TEAM_NAME}','${defaultInfo[0].TEAM_POSITION}')" style="color: blue">${defaultInfo[0].TEAM_NAME}</a> ${defaultInfo[0].TEAM_POSITION}</div>  
                               <label class="col-sm-2 control-label ag_r"><span>${defaultInfo[0].POST_POSITION_DUTY}</span></label>
                               <div class="col-sm-2"><a onclick="clientList.goDetail(${defaultInfo[0].POST_ID},'','${defaultInfo[0].POST_NAME}','${defaultInfo[0].POST_POSITION}')" style="color: blue">${defaultInfo[0].POST_NAME}</a> ${defaultInfo[0].POST_POSITION}</div>
                           		<label class="col-sm-2 control-label ag_r"><span>${defaultInfo[0].DIVISION_POSITION_DUTY}</span></label>
                               <div class="col-sm-2"><a onclick="clientList.goDetail(${defaultInfo[0].DIVISION_ID},'','${defaultInfo[0].DIVISION_NAME}','${defaultInfo[0].DIVISION_POSITION}')" style="color: blue">${defaultInfo[0].DIVISION_NAME}</a> ${defaultInfo[0].DIVISION_POSITION}</div>                                  
                           </div>
                           
                           <div class="pd-t30">
                   				<h3>기타</h3>
                   			</div>
                           
                           <div class="form-group topline pd-t10">
                               <label class="col-sm-2 control-label ag_r"><span>관계수립</span></label>
                               <div class="col-sm-2" id="divPersonalInfoProfile" style="color: ${defaultInfo[0].RELATION}">
                               	<c:if test="${defaultInfo[0].RELATION ne '' && defaultInfo[0].RELATION ne null}">
                               	■
                               	</c:if>
                               </div>
                               <label class="col-sm-2 control-label ag_r"><span>호감도</span></label>
                               <div class="col-sm-2" id="divPersonalInfoProfile" style="color: ${defaultInfo[0].LIKEABILITY}">
                               	<c:if test="${defaultInfo[0].LIKEABILITY ne '' && defaultInfo[0].LIKEABILITY ne null}">
                               	■
                               	</c:if>
                               </div>
                               <label class="col-sm-2 control-label ag_r"><span>책임자</span></label>
                               <div class="col-sm-2" id="divPersonalInfoProfile">${defaultInfo[0].DIRECTOR_NAME} ${defaultInfo[0].DIRECTOR_POSITION}</div>
                           </div>
                           <div class="form-group pd-t10">
                               <label class="col-sm-2 control-label ag_r"><span>자사와의 관계</span></label>
                               <div class="col-sm-10" id="divPersonalInfoProfile">${defaultInfo[0].PINFO_RELATIONSHIP}</div>
                           </div>
                           <div class="form-group pd-t10">
                           		<label class="col-sm-2 control-label ag_r"><span>사내친한직원</span></label>
                               <div class="col-sm-6">${defaultInfo[0].FRIENDSHIP_INFO}</div> 
                               <label class="col-sm-2 control-label ag_r"><span>이전영업사원</span></label>
                               <div class="col-sm-2">${defaultInfo[0].PREV_SALES_POST} ${defaultInfo[0].PREV_SALES_HAN_NAME} ${defaultInfo[0].PREV_SALES_POSITION}</div> 
                           </div>
                           
                       </div>
                   </div>
               </div>
               
               
               <input type="hidden" name="hiddenClientId" id="hiddenClientId" value="${defaultInfo[0].CUSTOMER_ID}" />
			    <input type="hidden" name="hiddenCreatorId" id="hiddenCreatorId" value="${defaultInfo[0].CREATOR_NAME}" />
			    <input type="hidden" name="hiddenSysUpdateDate" id="hiddenSysUpdateDate" value="${defaultInfo[0].SYS_UPDATE_DATE}" />
			    <input type="hidden" name="hiddenDivision" id="hiddenDivision" value="${defaultInfo[0].DIVISION}" />
			    <input type="hidden" name="hiddenPost" id="hiddenPost" value="${defaultInfo[0].POST}" />
			    <input type="hidden" name="hiddenTeam" id="hiddenTeam" value="${defaultInfo[0].TEAM}" />
			    <input type="hidden" name="hiddenReportingDivisionId" id="hiddenReportingDivisionId" value="${defaultInfo[0].REPORTING_LINE_DIVISION_ID}" />
			    <input type="hidden" name="hiddenReportingPostId" id="hiddenReportingPostId" value="${defaultInfo[0].REPORTING_LINE_POST_ID}" />
			    <input type="hidden" name="hiddenReportingTeamId" id="hiddenReportingTeamId" value="${defaultInfo[0].REPORTING_LINE_TEAM_ID}" />
			    <input type="hidden" name="hiddenReportingDivisionName" id="hiddenReportingDivisionName" value="${defaultInfo[0].DIVISION_NAME}" />
			    <input type="hidden" name="hiddenReportingPostName" id="hiddenReportingPostName" value="${defaultInfo[0].POST_NAME}" />
			    <input type="hidden" name="hiddenReportingTeamName" id="hiddenReportingTeamName" value="${defaultInfo[0].TEAM_NAME}" />
			    <input type="hidden" name="hiddenReportingDivisionPosition" id="hiddenReportingDivisionPosition" value="${defaultInfo[0].DIVISION_POSITION}" />
			    <input type="hidden" name="hiddenReportingPostPosition" id="hiddenReportingPostPosition" value="${defaultInfo[0].POST_POSITION}" />
			    <input type="hidden" name="hiddenReportingTeamPosition" id="hiddenReportingTeamPosition" value="${defaultInfo[0].TEAM_POSITION}" />
			    <input type="hidden" name="hiddenDuty" id="hiddenDuty" value="${defaultInfo[0].DUTY}" />
			    <input type="hidden" name="hiddenEmail" id="hiddenEmail" value="${defaultInfo[0].EMAIL}" />
			    <input type="hidden" name="hiddenAddress" id="hiddenAddress" value="${defaultInfo[0].ADDRESS}" />
			    <input type="hidden" name="hiddenCustomerName" id="hiddenCustomerName" value="${defaultInfo[0].CUSTOMER_NAME}" />
			    <input type="hidden" name="hiddenPosition" id="hiddenPosition" value="${defaultInfo[0].POSITION}" />
			    <input type="hidden" name="hiddenPositionDuty" id="hiddenPositionDuty" value="${defaultInfo[0].POSITION_DUTY}" />
			    <input type="hidden" name="hiddenCellPhone" id="hiddenCellPhone" value="${defaultInfo[0].CELL_PHONE}" />
			    <input type="hidden" name="hiddenPhone" id="hiddenPhone" value="${defaultInfo[0].PHONE}" />
			    <input type="hidden" name="hiddenPersonalNameCard" id="hiddenPersonalNameCard" value="${defaultPhoto[0].FILE_PATH}${defaultPhoto[0].FILE_NAME}" />
			    <input type="hidden" name="hiddenPersonalPhoto" id="hiddenPersonalPhoto" value="${defaultPhoto[1].FILE_PATH}${defaultPhoto[1].FILE_NAME}" />
			    <input type="hidden" name="hiddenRelationship" id="hiddenRelationship" value="${defaultInfo[0].PINFO_RELATIONSHIP}" />
			    <input type="hidden" name="hiddenRelation" id="hiddenRelation" value="${defaultInfo[0].RELATION}" />
			    <input type="hidden" name="hiddenLikebility" id="hiddenLikebility" value="${defaultInfo[0].LIKEABILITY}" />
			    <input type="hidden" name="hiddenFriendshipInfo" id="hiddenFriendshipInfo" value="${defaultInfo[0].FRIENDSHIP_INFO}" />
			    <input type="hidden" name="hiddenInfoSource" id="hiddenInfoSource" value="${defaultInfo[0].INFO_SOURCE}" />
			    <input type="hidden" name="hiddenDirectorId" id="hiddenDirectorId" value="${defaultInfo[0].DIRECTOR_ID}"/>
			    <input type="hidden" name="hiddenDirectorName" id="hiddenDirectorName" value="${defaultInfo[0].DIRECTOR_NAME}"/>
			    <input type="hidden" name="hiddenDirectorPosition" id="hiddenDirectorPosition" value="${defaultInfo[0].DIRECTOR_POSITION}"/>
			    <input type="hidden" name="hiddenPrevSalesMemberId" id="hiddenPrevSalesMemberId" value="${defaultInfo[0].PREV_SALES_MEMBER_ID}"/>
			    <input type="hidden" name="hiddenPrevSalesHanName" id="hiddenPrevSalesHanName" value="${defaultInfo[0].PREV_SALES_HAN_NAME}"/>
			    <input type="hidden" name="hiddenPrevSalesPosition" id="hiddenPrevSalesPosition" value="${defaultInfo[0].PREV_SALES_POSITION}"/>
			    <input type="hidden" name="hiddenPersonalInfoProfile" id="hiddenPersonalInfoEducation" value="${defaultInfo[0].MODAL_PINFO_EDUCATION}" />
			    <input type="hidden" name="hiddenPersonalInfoProfile" id="hiddenPersonalInfoEducationPerson" value="${defaultInfo[0].MODAL_PINFO_EDUCATION_PERSON}" />
			    <input type="hidden" name="hiddenPersonalInfoProfile" id="hiddenPersonalInfoCareer" value="${defaultInfo[0].MODAL_PINFO_CAREER}" />
			    <input type="hidden" name="hiddenPersonalInfoProfile" id="hiddenPersonalInfoCareerPerson" value="${defaultInfo[0].MODAL_PINFO_CAREER_PERSON}" />
			    <input type="hidden" name="hiddenPersonalInfoSocialActs" id="hiddenPersonalInfoSocialActs" value="${defaultInfo[0].MODAL_PINFO_SOCIAL_ACTS}" />
			    <input type="hidden" name="hiddenPersonalInfoFamily" id="hiddenPersonalInfoFamily" value="${defaultInfo[0].MODAL_PINFO_FAMILY}" />
			    <input type="hidden" name="hiddenPersonalInfoInclination" id="hiddenPersonalInfoInclination" value="${defaultInfo[0].MODAL_PINFO_INCLINATION}" />
			    <input type="hidden" name="hiddenPersonalInfoFamilars" id="hiddenPersonalInfoFamilars" value="${defaultInfo[0].MODAL_PINFO_FAMILIARS}" />
			    <input type="hidden" name="hiddenPersonalInfoSNS" id="hiddenPersonalInfoSNS" value="${defaultInfo[0].MODAL_PINFO_SNS}" />
			    <input type="hidden" name="hiddenPersonalInfoETC" id="hiddenPersonalInfoETC" value="${defaultInfo[0].MODAL_PINFO_ETC}" />
			    <input type="hidden" name="hiddenCompanyName" id="hiddenCompanyName" value="${defaultInfo[0].COMPANY_NAME}" />
			    <input type="hidden" name="hiddenCompanyId" id="hiddenCompanyId" value="${defaultInfo[0].COMPANY_ID}" />
			    <input type="hidden" name="hiddenUseYn" id="hiddenUseYn" value="${defaultInfo[0].USE_YN}" />
			    <input type="hidden" name="hiddenERPCompanyCode" id="hiddenERPCompanyCode" value="${defaultInfo[0].ERP_REG_CODE}" />
			    <input type="hidden" name="hiddenERPClientCode" id="hiddenERPClientCode" value="${defaultInfo[0].ERP_CLIENT_CODE}" />
			    