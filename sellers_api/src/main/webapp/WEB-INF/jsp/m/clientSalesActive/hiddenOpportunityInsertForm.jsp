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
<head>
	<%-- <link href="${pageContext.request.contextPath}/css/m/bootstrap/bootstrap.min.css" rel="stylesheet"> --%>
</head>
<body class="gray_bg" onload="tabmenuLiWidth();">

<div class="container_pg">
    <article class="">
        <div class="title_pg ta_c">
            <c:choose>
                <c:when test="${mode eq 'ins'}">
                    <h2 class="modal-title">잠재영업기회 신규등록</h2>
                </c:when>
                <c:otherwise>
                    <h2 class="modal-title">잠재영업기회 수정등록</h2>
                </c:otherwise>
            </c:choose>
            <a href="javascript:void(0);" class="btn_back" onClick="window.history.back(); return false;">back</a>
        </div>
        
        <ul class="tabmenu tabmenu_type2 mg_b20">
					<li><a href="#" id="tab_1" onclick="fncSelectTab('1'); return false;" class="active">기본정보</a></li>
					<li><a href="#" id="tab_2" onclick="fncSelectTab('2'); return false;">Action Plan</a></li>
				</ul>

        <div class="pg_cont pd_t20">
            <form class="form-horizontal" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">
            <!-- 기본정보 -->
                <div class="cont1 pd_b20">
                    <div class="form_input mg_b20">
                        <label class="">제목 <span style="color:red;">*</span></label>
                        <input type="text" placeholder="" class="form_control" id="textModalSubject" name="textModalSubject" autocomplete="off"/>
                    </div>
    
                    <div class="form_input mg_b20">
                        <div class="pos-rel">
                          <label>매출처 <span style="color:red;">*</span></label>
                          <%-- <input type="text" placeholder="매출처를 검색해 주세요." class="form_control" id="textCommonSearchCompany" name="textCommonSearchCompany" value="${param.returnCompanyName}" autocomplete="off"/> --%>
                        
                        	<ul class="flexdatalist-multiple" id="ulModalCompanyName" name="ulModalCompanyName" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
							              <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalCompanyName" name="liModalCompanyName" >
							                  <div class="pos-rel">
							                      <input type="text" class="form_control" id="textCommonSearchCompany" name="textCommonSearchCompany" placeholder="매출처 입력" autocomplete="off"/>
							                  </div>
							              </li>
							          	</ul>
                        </div>
                    </div>  
    
                    <%-- <div class="form_input mg_b20">
                        <label>고객사ID</label>
                        <input type="text" class="form_control" id="textCommonSearchCompanyId" name="textCommonSearchCompanyId" value="${param.returnCompanyId}" readOnly/>
                    </div> --%>
    				
    				<!-- <div class="form_input mg_b20">
                        	<label class="" id="label_name">고객명</label>
							<ul class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                                <li class="input-container flexdatalist-multiple-value pos-rel" id="ulModalMarketMembersName" name="ulModalMarketMembersName">
                                    <div class="pos-rel">
                                        <input type="text" class="form_control" onclick="companyIdCheck();" id="textModalCustomerName" name="textModalCustomerName" placeholder="이름 입력" autocomplete="off"/>
                                    </div>
                                </li>
                            </ul>
						</div> -->
    				
                    <div class="form_input mg_b20">
                        <div class="pos-rel">
                          <label class="">End User <span style="color:red;">*</span></label>
                          <%-- <input type="text" placeholder="End User를 검색해 주세요." class="form_control" id="textModalCustomerName" name="textModalCustomerName" value="${param.returnCustomerName}" autocomplete="off" /> --%>
                        	<ul class="flexdatalist-multiple" id="ulModalCustomerName" name="ulModalCustomerName" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
							              <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalCustomerName" name="liModalCustomerName" >
							                  <div class="pos-rel">
							                      <input type="text" class="form_control" id="textModalCustomerName" name="textModalCustomerName" placeholder="End User 입력" autocomplete="off"/>
							                  </div>
							              </li>
							          	</ul>
                       	</div>
                    </div>
                    
                    <%-- <div class="form_input mg_b20">
                        <label>고객직급</label>
                        <input type="text" placeholder="부장" class="form_control" id="hiddenModalCustomerRankList" name="textModalCustomerRank" value="${param.returnCustomerRank}" />
                    </div> --%>
                    
                    <div class="form_input mg_b20">
                        <div class="pos-rel">
                          <label class="">영업대표 <span style="color:red;">*</span></label>
                          <!-- <input type="text" placeholder="영업대표를 검색해 주세요." class="form_control" id="textModalOppOwner" name="textModalOppOwner" placeholder="영업대표를 검색해 주세요." autocomplete="off"/> -->
                        	<ul class="flexdatalist-multiple" id="ulModalOppOwner" name="ulModalOppOwner" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
							              <li class="input-container flexdatalist-multiple-value pos-rel" id="liModalOppOwner" name="liModalOppOwner" >
							                  <div class="pos-rel">
							                      <input type="text" class="form_control" id="textModalOppOwner" name="textModalOppOwner" placeholder="영업대표 입력" autocomplete="off"/>
							                  </div>
							              </li>
							          	</ul>
                        </div>
                    </div>
    
                    <div class="form_input mg_b20">
                        <label class="">예상규모 <span style="color:red;">*</span></label>
                        <input type="text" placeholder="" class="form_control" name="textModalAmount" id="textModalAmount" autocomplete="off"/>
                    </div>
                    <% /***** 통합버전에는 항목이 없어서 삭제. 2017.04.26
                    <div class="form_input mg_b20">
                        <label class="">사업영역</label>
                        <select class="form_control">
                            <option>=== 선택 ===</option>
                            <option>H/W</option>
                            <option>S/W</option>
                        </select>
                    </div>
                    *****************************************************/
                    %>
    
                    <div class="form_input mg_b20">
                        <label class="">영업기회 전환시점</label>
                        <input type="date" placeholder="" class="form_control" id="textModalSalesChangeDate" name="textModalSalesChangeDate"/>
                    </div>

                    <!-- <div class="view_cata b_line">
                        <div class="ti fl_l w_120">
                            <span class="bullet dot"></span> 결과
                        </div>
                        <div class="cont fl_l" id="divModalResult">
                            <span>전환전</span> 
                        </div>
                    </div> -->
    
                    <div class="view_cata b_line">
                        <div class="ti fl_l w_120">
                            <span class="bullet dot"></span> 연관 고객컨택
                        </div>
                        <div class="cont fl_l" id="relationContact">
                            <!-- <a href="#" class="btn_quick">바로가기</a> -->
                        </div>
                    </div>                    
    
                    <div class="form_input mg_b20">
                        <label class="">내용</label>
                        <textarea class="form_control" row="3" id="textareaModalDetail" name="textareaModalDetail"></textarea>
                    </div>
    
                    <div class="form_input mg_b20">
                        <label class="">메일공유</label>
                        <div class="search_input_after">
													<ul class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
														<li class="input-container flexdatalist-multiple-value pos-rel" id="ulMultipleMailShareMember" name="ulMultipleMailShareMember">
															<div class="pos-rel">
															<input type="text" class="form-control" id="textCommonSearchMember" name="textCommonSearchMember" placeholder="공유할 직원명을 검색해 주세요." autocomplete="off" style="width: 200px;"/>
															</div>
														</li>
													</ul>
                        </div>
                    </div>
    
                    <!-- <div class="guideBox">모바일에서는 기본정보의 등록이 가능하며, Action Plan은 PC에서 등록해주세요.</div> -->
                </div>
                
                <!-- Action Plan -->
								<div class="cont2 off">
									<ul>
									</ul>
									<div class="ta_c">
										<a href="#" class="btn btn-primary r5" id="actionPlanAddBtn" onClick="action.actAdd();">
											<span>+ Action Plan 추가</span>
										</a>
									</div>
								</div>
                
                <input type="hidden" name="hiddenModalPK"               id="hiddenModalPK"          value=""/>
                <input type="hidden" name="hiddenModalCreatorId"        id="hiddenModalCreatorId"   value="${userInfo.MEMBER_ID_NUM}"/>
                <input type="hidden" name="hiddenModalCompanyId"        id="hiddenModalCompanyId" value="${param.returnCompanyId}"/>
                <input type="hidden" name="hiddenModalCustomerId"       id="hiddenModalCustomerId" value="${param.returnCustomerId}"/>
                <input type="hidden" name="hiddenModalSalesId"          id="hiddenModalSalesId"/>
                <input type="hidden" name="hiddenModalContactId"        id="hiddenModalContactId" value="${param.contactPK}"/>
                <input type="hidden" name="hiddenModalAmount"           id="hiddenModalAmount"/>
                <input type="hidden" name="hiddenModalMemberList"       id="hiddenModalMemberList"/>
                <input type="hidden" name="hiddenModalHanName"          id="hiddenModalHanName"     value="${userInfo.HAN_NAME}"/>
                <input type="hidden" name="hiddenModalEmail"            id="hiddenModalEmail"       value="${userInfo.EMAIL}"/>
                <input type="hidden" name="hiddenRelationOpportunityId" id="hiddenRelationOpportunityId"/>
                <input type="hidden" name="hiddenModalCustomerIdList" id="hiddenModalCustomerIdList"/>
            </form>
            <!--// 기본정보 -->
        </div>
    </article>   

	</div>
        <div class="pg_bottom_func len3">
            <ul>
                <li><a href="#" class="" id="goList"> <img src="${pageContext.request.contextPath}/images/m/icon_list.png" /> <span>목록</span></a></li>
                <li><a href="#" class="" id="goInsert"> <img src="${pageContext.request.contextPath}/images/m/icon_edit.png" /> <span>저장</span></a></li>
                <li><a href="#" class="" id="goShared"> <img src="${pageContext.request.contextPath}/images/m/icon_edit.png" /> <span>저장 및 공유</span></a></li>
            </ul>
        </div>
<div class="modal_screen"></div>

<form id="formSampleFile" name="formSampleFile" method="post">
    <input type="hidden" name="sampleFileName" value=""/>
</form>

<form id="formRedirectOpportunity" name="formRedirectOpportunity" method="post">
    <input type="hidden" name="returnOpportunityhiddenId" id="returnOpportunityhiddenId"/>
    <input type="hidden" name="opportunity_id" id="opportunity_id"/>
    <input type="hidden" name="returnCompanyId" id="returnCompanyId"/>
    <input type="hidden" name="returnCompanyName" id="returnCompanyName"/>
    <input type="hidden" name="returnCustomerName" id="returnCustomerName"/>
    <input type="hidden" name="returnCustomerId" id="returnCustomerId"/>
    <input type="hidden" name="returnCustomerRank" id="returnCustomerRank"/>
    <input type="hidden" name="returnSubject" id="returnSubject"/>
    <input type="hidden" name="returnOpportunityamount" id="returnOpportunityamount"/>
</form>

<form name="formFollow" id="formFollow" method="post" action="">
	<input type="hidden" name="contactPK" id="contactPK" value="${param.contactPK}"/>
	<input type="hidden" name="issueFlag" id="issueFlag" value="${param.issueFlag}"/>
	<input type="hidden" name="oppFlag" id="oppFlag" value="${param.oppFlag}"/>
	<input type="hidden" name="returnCompanyId" id="returnCompanyId"/>
	<input type="hidden" name="returnCompanyName" id="returnCompanyName"/>
	<input type="hidden" name="returnCustomerName" id="returnCustomerName"/>
	<input type="hidden" name="returnCustomerId" id="returnCustomerId"/>
	<input type="hidden" name="returnCustomerRank" id="returnCustomerRank"/>
	<input type="hidden" name="hiddenModalContactId" id="hiddenModalContactId" value="${param.contactPK}"/>
</form>

<script>
	var mode = '${mode}';
	var pkNo = '${pkNo}';
	var tabNo = '${param.tabNo}';
</script>

<script src="${pageContext.request.contextPath}/js/m/view/clientSalesActive/hiddenOpportunityInsertForm.js"></script>
<script src="${pageContext.request.contextPath}/js/m/view/clientSalesActive/hiddenOpportunityActionPlan.js"></script>

</body>
</html>