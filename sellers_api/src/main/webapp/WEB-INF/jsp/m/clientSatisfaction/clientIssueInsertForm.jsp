<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%  
response.setHeader("Cache-Control","no-store");  
response.setHeader("Pragma","no-cache");  
response.setDateHeader("Expires",0);  
if (request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache");
%>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>

<!doctype html>
<html lang="ko">

<body class="gray_bg" onload="tabmenuLiWidth();">

	<div class="container_pg">
    <article class="">
        <div class="title_pg ta_c">
            <h2>이슈등록</h2>
            <a href="javascript:void(0);" class="btn_back" onClick="window.history.back(); return false;">back</a>
        </div>
        
        <ul class="tabmenu tabmenu_type2 mg_b20">
					<li><a href="#" id="tab_1" onclick="fncSelectTab('1'); return false;" class="active">기본정보</a></li>
					<li><a href="#" id="tab_2" onclick="fncSelectTab('2'); return false;">이슈해결계획</a></li>
				</ul>

        <div class="pg_cont pd_t20">

            <form method="post" class="form-horizontal" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">

                <div class="cont1 pd_b20 "><!-- 이슈기본정보  -->

                    <div class="form_input mg_b20">
                        <label class="">이슈제목 <span style="color:red;">*</span></label>
                        <input type="text" class="form_control" id="textModalSubject" name="textModalSubject"/>
                    </div>

<%--                     <div class="form_input mg_b20">
                        <div class="pos-rel">
                            <label>고객사</label>
                            <input type="text" class="form_control" id="textCommonSearchCompany" name="textCommonSearchCompany" placeholder="고객사를 검색해 주세요." value="${param.returnCompanyName}" autocomplete="off"/>
                        </div>
                    </div>                

						
                    <div class="form_input mg_b20">
                        <label class="">고객사ID</label>
                        <input type="text" class="form_control" id="textCommonSearchCompanyId" name="textCommonSearchCompanyId" value="${param.returnCompanyId}" readOnly/>
                    </div> --%>
					
										<div class="form_input mg_b20">
					            <label class="" id="label_name">고객명 <span style="color:red;">*</span></label>
											<ul class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
					                 <li class="input-container flexdatalist-multiple-value pos-rel" id="ulModalMarketMembersName" name="ulModalMarketMembersName">
					                     <div class="pos-rel">
					                         <input type="text" class="form_control" id="textModalCustomerName" name="textModalCustomerName" placeholder="이름 입력" autocomplete="off"/>
					                     </div>
					                 </li>
					             </ul>
										</div>
										
					          <%-- <div class="form_input mg_b20">
					              <div class="pos-rel">
					                  <label class="">고객명</label>
					                  <input type="text" class="form_control" id="textModalCustomerName" name="textModalCustomerName" placeholder="고객명을 검색해 주세요." value="${param.returnCustomerName}" autocomplete="off"/>
					              </div>
					          </div> --%>

			          <div class="form_input mg_b20">
			              <div class="pos-rel">
			                  <label>영업대표 <span style="color:red;">*</span></label>
			                  <ul id="ulModalSingleSalesRepresentive" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
		                        <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleSalesRepresentive" name="liModalSingleSalesRepresentive">
		                            <input type="text" class="form-control" id="textModalSalesRepresentive" name="textModalSalesRepresentive" placeholder="영업대표를 검색해 주세요." autocomplete="off" autoFlag="y" style="width:200px;">
		                        </li>
		                    </ul>
			              </div>
			          </div>
			
			          <div class="form_input mg_b20">
			              <div class="pos-rel">
			                  <label>이슈해결책임자 <span style="color:red;">*</span></label>
			                  <ul id="ulModalSingleSolveOwner" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
		                        <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleSolveOwner" name="liModalSingleSolveOwner">
		                            <input type="text" class="form-control" id="textModalSolveOwner" name="textModalSolveOwner" placeholder="이슈해결책임자를 검색해 주세요." autocomplete="off" autoFlag="y" style="width:200px;">
		                        </li>
		                    </ul>
			              </div>
			          </div>
			
			          <div class="form_input mg_b20">
			              <label>이슈영역 <span style="color:red;">*</span></label>
			              <select class="form_control" id="selectModalIssueCategory" name="selectModalIssueCategory">
			                  <option value="">== 선택 ==</option>
			                  <option value="제품">제품</option>
			                  <option value="서비스">서비스</option>
			                  <option value="지원">지원</option>
			              </select>
			          </div>
			
			          <div class="form_input mg_b20">
			              <label class="">이슈내용</label>
			              <textarea class="form_control" row="3" id="textareaModalIssueDetail" name="textareaModalIssueDetail"></textarea>
			          </div>                   
			
			          <div class="form_input mg_b20">
			              <label>이슈발생일 <span style="color:red;">*</span></label>
			              <input type="date" class="form_control" id="textModalIssueDate" name="textModalIssueDate"/>
			          </div>
			
			          <div class="form_input mg_b20">
			              <label>해결목표일 <span style="color:red;">*</span></label>
			              <input type="date" class="form_control" id="textModalDueDate" name="textModalDueDate"/>
			          </div>
			
			          <div class="form_input mg_b20">
			              <label>이슈해결일</label>
			              <input type="date" class="form_control" id="textModalIssueCloseDate" name="textModalIssueCloseDate"/>
			          </div>
			
			          <div class="form_input mg_b20">
			              <div class="pos-rel">
			                  <label>이슈해결확인자</label>
			                  <ul id="ulModalSingleIssueConfirmId" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
		                        <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalSingleIssueConfirmId" name="liModalSingleSolveOwner">
		                            <input type="text" class="form-control" id="textModalIssueConfirmId" name="textModalIssueConfirmId" placeholder="이슈해결책임자를 검색해 주세요." autocomplete="off" autoFlag="y" style="width:200px;">
		                        </li>
		                    </ul>
			              </div>
			          </div>


				     		<div class="form_input mg_b20">
					         <label class="">메일공유</label>
					         <div class="search_input_after">
											<ul class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
												<li class="input-container flexdatalist-multiple-value pos-rel" id="ulMultipleMailShareMember" name="ulMultipleMailShareMember">
													<div class="pos-rel">
														<input type="text" class="form-control" id="textCommonSearchMember" name="textCommonSearchMember" placeholder="공유할 직원명을 검색해 주세요." autocomplete="off" style="width:200px;"/>
													</div>
												</li>
											</ul>
				            </div>
				           </div>
				
				           <div class="form_input">
				               <label class="">기타</label>
				               <div class="guideBox">
				                 	 파일첨부는 PC에서만 가능합니다.
				               </div>
				           </div>
				
								</div>
								
								<!-- 이슈해결계획 -->
								<div class="cont2 off">
									<ul>
									</ul>
									<div class="ta_c">
										<a href="#" class="btn btn-primary r5" id="actionPlanAddBtn" onClick="action.actAdd();">
											<span>+ 이슈해결계획 추가</span>
										</a>
									</div>
								</div>	

							<input type="hidden"name="hiddenModalPK"            id="hiddenModalPK"      value=""/>
							<input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
							<input type="hidden" name="hiddenModalCompanyId" id="hiddenModalCompanyId" value="${param.returnCompanyId}"/>
							<input type="hidden" name="hiddenModalCustomerId" id="hiddenModalCustomerId" value="${param.returnCustomerId}"/>
							<input type="hidden" name="hiddenModalSalesId" id="hiddenModalSalesId"/>
							<input type="hidden" name="hiddenModalSolveOwnerId" id="hiddenModalSolveOwnerId"/>
							<input type="hidden" name="hiddenModalIssueConfirmId" id="hiddenModalIssueConfirmId"/>
							
							<c:choose>
								<c:when test="${param.oppFlag == 'false'}">
									<input type="hidden" name="hiddenModalContactId" id="hiddenModalContactId" value="${param.contactPK}" />
								</c:when>
								<c:otherwise>
									<input type="hidden" name="hiddenModalContactId" id="hiddenModalContactId" value="${param.hiddenModalContactId}" />
								</c:otherwise>
							</c:choose>
							
							<input type="hidden" name="hiddenModalMemberList" id="hiddenModalMemberList"/>
							<input type="hidden" name="hiddenModalHanName" id="hiddenModalHanName" value="${userInfo.HAN_NAME}"/>
							<input type="hidden" name="hiddenModalEmail" id="hiddenModalEmail" value="${userInfo.EMAIL}"/>
							
							<!-- 고객 만족도 -->
							<input type="hidden" name="hiddenCsatDetailId" id="hiddenCsatDetailId" value="${param.hiddenCsatDetailId}"/> 
							<input type="hidden" name="hiddenCsatDetailCompanyName" id="hiddenCsatDetailCompanyName" value="${param.hiddenCsatDetailCompanyName}"/> 
							<input type="hidden" name="hiddenCsatDetailCompanyId" id="hiddenCsatDetailCompanyId" value="${param.hiddenCsatDetailCompanyId}"/> 
							<input type="hidden" name="hiddenCsatDetailSubject" id="hiddenCsatDetailSubject" value="${param.hiddenCsatDetailSubject}"/> 
							<input type="hidden" name="hiddenCsatDetailCustomerName" id="hiddenCsatDetailCustomerName" value="${param.hiddenCsatDetailCustomerName}"/>
							<input type="hidden" name="hiddenCsatDetailCustomerRank" id="hiddenCsatDetailCustomerRank" value="${param.hiddenCsatDetailCustomerRank}"/> 
							<input type="hidden" name="hiddenCsatDetailCustomerId" id="hiddenCsatDetailCustomerId" value="${param.hiddenCsatDetailCustomerId}"/>
							<input type="hidden" name="hiddenSelectIssueId" id="hiddenSelectIssueId" value="${param.csat_id}"/> 
							<input type="hidden" name="hiddenSelectIssueStatus" id="hiddenSelectIssueStatus" value="${param.issue_status}"/>
							
							<input type="hidden" name="hiddenModalCustomerIdList" id="hiddenModalCustomerIdList" />
					</form>
				</div>
			</article>
				
		</div>

<div class="pg_bottom_func len3">
    <ul>
        <li><a href="#" class="" id="viewClientIssueList"> <img src="${pageContext.request.contextPath}/images/m/icon_list.png" /> <span>목록</span></a></li>
        <li><a href="#" class="" id="insertClientIssue"> <img src="${pageContext.request.contextPath}/images/m/icon_edit.png" /> <span>저장</span></a></li>
        <li><a href="#" class="" id="sharedClientIssue"> <img src="${pageContext.request.contextPath}/images/m/icon_edit.png" /> <span>저장 및 공유</span></a></li>
    </ul>
</div>

<script>
	var mode = '${mode}';
	var pkNo = '${pkNo}';
	var tabNo = '${param.tabNo}';
</script>

<script src="${pageContext.request.contextPath}/js/m/view/clientSatisfaction/clientIssueInsertForm.js"></script>
<script src="${pageContext.request.contextPath}/js/m/view/clientSatisfaction/clientIssueSolvePlan.js"></script>

</body>
</html>