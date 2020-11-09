<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
			<div class="title_pg mg_b20 ta_c">
				<c:choose>
					<c:when test="${mode eq 'ins'}">
						<h2>고객컨택내용 등록</h2>
					</c:when>
					<c:otherwise>
						<h2>고객컨택내용 수정</h2>
					</c:otherwise>
				</c:choose>
				<a href="javascript:void(0);" class="btn_back" onClick="window.history.back(); return false;">back</a>
			</div>		
			
			<ul class="tabmenu tabmenu_type2 mg_b20">
				<li><a href="#" id="tab_1" onclick="fncSelectTab('1'); return false;" class="active">기본정보</a></li>
				<li><a href="#" id="tab_2" onclick="fncSelectTab('2'); return false;">Follow-Up Action</a></li>
			</ul>

			<div class="pg_cont pd_t20">
				<form class="form-horizontal" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">
					<div class="cont1 pd_b20 ">
					
						<!-- 고객기본정보  -->
						<div class="form_input mg_b20">
							<label class="">컨택목적 <span style="color:red;">*</span></label> <input type="text" placeholder="" class="form_control" id="textModalSubject" name="textModalSubject" />
						</div>
						<div class="form_input mg_b20">
							<label>컨택 방법 <span style="color:red;">*</span></label>
							<select class="form_control" name="selectModalCategory" id="selectModalCategory">
								<spring:eval expression="@config['code.contactMethod']" />
							</select>
						</div>

						<div class="form_input mg_b20">
							<label>컨택 일자 <span style="color:red;">*</span></label>
							<input type="date" placeholder="1988-11-18" class="form_control" id="textModalEventDate" name="textModalEventDate" style="text-indent:5px;"/>
						</div>
						
						<div class="form_input">
						<label>컨택 시간 <span style="color:red;">*</span></label>
						<div class="daytime">
							<select name="selectModalStartDateTime" id="selectModalStartDateTime"  onchange="changeEndDate();" style="width:100%;">
                              	 <option value="">선택</option>
								<option value="08:00">오전 08:00</option>
								<option value="08:30">오전 08:30</option>
								<option value="09:00">오전 09:00</option>
								<option value="09:30">오전 09:30</option>
								<option value="10:00">오전 10:00</option>
								<option value="10:30">오전 10:30</option>
								<option value="11:00">오전 11:00</option>
								<option value="11:30">오전 11:30</option>
								<option value="12:00">오후 12:00</option>
								<option value="12:30">오후 12:30</option>
								<option value="13:00">오후 01:00</option>
								<option value="13:30">오후 01:30</option>
								<option value="14:00">오후 02:00</option>
								<option value="14:30">오후 02:30</option>
								<option value="15:00">오후 03:00</option>
								<option value="15:30">오후 03:30</option>
								<option value="16:00">오후 04:00</option>
								<option value="16:30">오후 04:30</option>
								<option value="17:00">오후 05:00</option>
								<option value="17:30">오후 05:30</option>
								<option value="18:00">오후 06:00</option>
								<option value="18:30">오후 06:30</option>
								<option value="19:00">오후 07:00</option>
								<option value="19:30">오후 07:30</option>
								<option value="20:00">오후 08:00</option>
								<option value="20:30">오후 08:30</option>
								<option value="21:00">오후 09:00</option>
								<option value="21:30">오후 09:30</option>
								<option value="22:00">오후 10:00</option>
								<option value="22:30">오후 10:30</option>
								<option value="23:00">오후 11:00</option>
								<option value="23:30">오후 11:30</option>
							</select>
							<select class="form-control"  name="selectModalEndDateTime" id="selectModalEndDateTime" style="width:100%;">
								<option value="">선택</option>
								<option value="08:00">오전 08:00</option>
								<option value="08:30">오전 08:30</option>
								<option value="09:00">오전 09:00</option>
								<option value="09:30">오전 09:30</option>
								<option value="10:00">오전 10:00</option>
								<option value="10:30">오전 10:30</option>
								<option value="11:00">오전 11:00</option>
								<option value="11:30">오전 11:30</option>
								<option value="12:00">오후 12:00</option>
								<option value="12:30">오후 12:30</option>
								<option value="13:00">오후 01:00</option>
								<option value="13:30">오후 01:30</option>
								<option value="14:00">오후 02:00</option>
								<option value="14:30">오후 02:30</option>
								<option value="15:00">오후 03:00</option>
								<option value="15:30">오후 03:30</option>
								<option value="16:00">오후 04:00</option>
								<option value="16:30">오후 04:30</option>
								<option value="17:00">오후 05:00</option>
								<option value="17:30">오후 05:30</option>
								<option value="18:00">오후 06:00</option>
								<option value="18:30">오후 06:30</option>
								<option value="19:00">오후 07:00</option>
								<option value="19:30">오후 07:30</option>
								<option value="20:00">오후 08:00</option>
								<option value="20:30">오후 08:30</option>
								<option value="21:00">오후 09:00</option>
								<option value="21:30">오후 09:30</option>
								<option value="22:00">오후 10:00</option>
								<option value="22:30">오후 10:30</option>
								<option value="23:00">오후 11:00</option>
								<option value="23:30">오후 11:30</option>
                             </select>
						</div>
					</div>
					

						<div class="form_input mg_b20">
             	<label class="" id="label_name">고객명 <span style="color:red;">*</span></label>
							<ul class="flexdatalist-multiple" id="ulMultipleClient" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: #fcfcfc;">
	              <li class="input-container flexdatalist-multiple-value pos-rel" id="ulModalMarketMembersName" name="ulModalMarketMembersName">
	                  <div class="pos-rel">
	                      <input type="text" class="form_control" id="textModalCustomerName" name="textModalCustomerName" placeholder="이름 입력" autocomplete="off"/>
	                  </div>
	              </li>
	            </ul>
					</div>

						<!-- <div class="form_input mg_b20">
							<label>고객사ID</label>
							<input type="text" class="form_control" id="textCommonSearchCompanyId" name="textCommonSearchCompanyId" readOnly />
						</div> -->
						
						<!-- <div class="form_input mg_b20">
             	<label class="" id="label_name">소속직원명</label>
							<ul class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);">
                  <li class="input-container flexdatalist-multiple-value pos-rel" id="ulModalMarketMembersName" name="ulModalMarketMembersName">
                      <div class="pos-rel">
                          <input type="text" class="form_control" onclick="companyIdCheck();" id="textModalCustomerName" name="textModalCustomerName" placeholder="이름 입력" autocomplete="off"/>
                      </div>
                  </li>
              </ul>
						</div> -->
						
						<!-- <div class="form_input mg_b20">
							<div class="pos-rel">
								<label class="">고객명</label>
								<input type="text" placeholder="고객명을 검색해 주세요." class="form_control" id="textModalCustomerName" name="textModalCustomerName" />
							</div>
						</div> -->                        

						<!-- <div class="form_input mg_b20">
							<label>고객직급</label> <input type="text" placeholder="직급" class="form_control" id="hiddenModalCustomerRankList" name="hiddenModalCustomerRankList" />
						</div> -->

						<div class="form_input mg_b10">
							<label class="">상세내용</label>
							<textarea class="form_control" row="3" id="textareaModalEventContents" name="textareaModalEventContents"></textarea>
						</div>

						<div class="view_cata_full mg_b20">
							<!-- <div class="mg_b10 ta_c">
								추가로 입력할 부분을 선택해주세요.<br /> 저장 후 해당 페이지로 자동 전환됩니다.
							</div> -->
							<c:choose>
								<c:when test="${mode eq 'ins'}">
									<div class="ta_c">
										<a href="#" class="btn_contact_sel" id="selectSalesOpp">잠재영업기회</a>
										<input type="checkbox" name="checkSalesOpp" style="display: none;" />
										<a href="#" class="btn_contact_sel" id="selectIssue">이슈</a>
										<input type="checkbox" name="checkIssue" style="display: none;" />
										<!-- <a href="#" class="btn_contact_sel active">이슈</a> -->
									</div>
								</c:when>
								<c:otherwise>
									<div class="view_cata_full">
										<div class="ti">
											<span class="bullet dot"></span> 연관 잠재영업기회
										</div>
										<div class="cboth cont_list" id="relationHiddenOpp">
											<%
												//<a href="#" class="btn_quick">바로가기</a>
											%>
										</div>
									</div>
									<div class="view_cata_full">
										<div class="ti">
											<span class="bullet dot"></span> 연관 고객이슈
										</div>
										<div class="cboth cont_list" id="relationClientIssue">
											<%
												//<a href="#" class="btn_quick">바로가기</a>
											%>
										</div>
									</div>
								</c:otherwise>
							</c:choose>
						</div>

						<div class="form_input mg_b20">
							<label class="">메일공유</label>
							<div class="search_input_after">
								<ul class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255);"><!--  -->
									<li class="input-container flexdatalist-multiple-value pos-rel" id="ulMultipleMailShareMember" name="ulMultipleMailShareMember">
										<div class="pos-rel">
										<input type="text" class="form-control" id="textMultipleMailShareMember" name="textMultipleMailShareMember" placeholder="공유할 직원명을 검색해 주세요." autocomplete="off" style="width:200px;"/>
										</div>
									</li>
								</ul>
							
								<!-- <a href="#" class="btn_search_pop">직원선택</a> -->
								<%
									//<div class="result_search" id="result_search_emp">
								%>
								<!-- <div class="company-current" id="result_search_emp"> -->
									<!-- 
	                <ul>
	                    <li><span>김진욱</span> <a href="#" class="icon_delete">삭제</a></li>
	                    <li><span>이상현</span> <a href="#" class="icon_delete">삭제</a></li>
	                </ul>
	                -->
								</div>
							</div>
							
							<div class="form_input">
								<label class="">기타</label>
								<div class="guideBox">파일첨부는 PC에서만 가능합니다.
								</div>
							</div>
						</div>
						
						<!-- Follow-Up Action -->
						<div class="cont2 off">
							<ul>
							</ul>
							<div class="ta_c">
								<a href="#" class="btn btn-primary r5" id="followUpAddBtn" onClick="fua.fuaAdd()">
									<span>+ Follow-Up Action 추가</span>
								</a>
							</div>
						</div>							
						
						<input type="hidden" name="hiddenModalPK" id="hiddenModalPK" value="" />
						<input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}" />
						<input type="hidden" name="hiddenModalCompanyId" id="hiddenModalCompanyId" />
						<input type="hidden" name="hiddenModalCustomerId" id="hiddenModalCustomerId" />					
						<input type="hidden" name="hiddenModalFollowManagerId" id="hiddenModalFollowManagerId" />					
						<input type="hidden" name="hiddenModalHanName" id="hiddenModalHanName" value="${userInfo.HAN_NAME}" />
						<input type="hidden" name="hiddenModalEmail" id="hiddenModalEmail" value="${userInfo.EMAIL}" />
						<input type="hidden" name="mode" id="mode" value="${mode}" />
						<input type="hidden" name="hiddenModalMemberList" id="hiddenModalMemberList" />
						<input type="hidden" name="hiddenModalCustomerIdList"	id="hiddenModalCustomerIdList" value=""/>
						<input type="hidden" name="hiddenModalCustomerNameList"	id="hiddenModalCustomerNameList"/>		
						<input type="hidden" 	name="hiddenModalCcList"	id="hiddenModalCcList"/>			
					
					</div>
					
				</form>

			</div>
		</article>
	</div>
	<div class="pg_bottom_func len2">
		<ul>
			<li><a href="javascript:void(0)" class="" id="viewClientContactList"> <img
					src="${pageContext.request.contextPath}/images/m/icon_list.png" />
					<span>목록</span></a></li>
			<li><a href="javascript:void(0)" class="" id="insertClientContact"> <img
					src="${pageContext.request.contextPath}/images/m/icon_edit.png" />
					<span>저장</span></a></li>
			<%-- <li><a href="javascript:void(0)" class="" id="sharedClientContact"> <img
					src="${pageContext.request.contextPath}/images/m/icon_edit.png" />
					<span>저장 및 공유</span></a></li> --%>
		</ul>
	</div>
	<div class="modal_screen"></div>

	<form name="formFollow" id="formFollow" method="post" action="">
		<input type="hidden" name="contactPK" id="contactPK" />
		<input type="hidden" name="issueFlag" id="issueFlag" />
		<input type="hidden" name="oppFlag" id="oppFlag" />
		<input type="hidden" name="returnCompanyId" id="returnCompanyId" />
		<input type="hidden" name="returnCompanyName" id="returnCompanyName" />
		<input type="hidden" name="returnCustomerName" id="returnCustomerName" />
		<input type="hidden" name="returnCustomerId" id="returnCustomerId" />
		<input type="hidden" name="returnCustomerRank" id="returnCustomerRank" />
	</form>	

	<script>
		var mode = '${mode}';
		var pkNo = '${pkNo}';
		var tabNo = '${param.tabNo}';
	</script>

	<script src="${pageContext.request.contextPath}/js/m/view/clientSalesActive/clientContactInsertForm.js?v=1.0"></script>
	<script src="${pageContext.request.contextPath}/js/m/view/clientSalesActive/clientContactInsertFollowUp.js"></script>
</body>
</html>