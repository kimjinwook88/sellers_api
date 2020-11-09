<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>

				<div id="tab2-4" class="tab-pane active">
						<div class="pull-right pos_t10m">
			               <!--  검색 -->
							<form id="formSearchCommon">
							<div class="search-common">
								<div class="input-default  fl_l" style="margin: 0;">
									<span class="input-group-btn"> 
										<a href="javascript:$('div.search-detail').toggle();void(0);"class="btn btn-search-option" style="width: 120px;"><i class="fa fa-search"></i> 고객개인 검색</a>
									</span>
						
									<div class="search-detail" style="top:65px;right:0px;display:none;">
						
										<div class="col-sm-12 m-b">
											<label class="control-label" for="date_modified">고객명</label>
											<div class="input-group" style="width: 100%;">
												<input type="text" placeholder="고객명을 입력해주세요" class="input form-control" id="textSearchClient" name="textSearchClient" value="${textSearchClient}" onkeydown="if(event.keyCode == 13){customerDetail.getCustomerCompanyList(1,1);}">
											</div>
										</div>
										 <input type="text" style="display: none;" />
						
										<div class="col-sm-12 ag_r">
											<button type="button" class="btn btn-w-m btn-primary btn-seller" onclick="customerDetail.getCustomerCompanyList(1,1);"><i class="fa fa-search"></i> 검색</button>
										</div>
									</div>
								</div>
							</div>
							</form>
							<!--  검색 -->
			           </div>
                      <h2>${clientCompanyList[0].COMPANY_NAME} 소속 고객정보</h2>
               
                      <table id="tech-companies" class="table table-bordered">
                          <thead>
                          <tr>
                              <!-- <th>No</th> -->
                              <th>고객개인ID</th>
                              <th>본부</th>
                              <th>직급</th>
                              <th>고객개인명</th>
                              <th>담당업무</th>
                              <th width="7%">관계수립</th>
                              <th width="7%">호감도</th>
                              <th>책임자</th>
                              <th>휴대전화</th>
                              <th>메일주소</th>
                          </tr>
                          </thead>
                          <tbody>
				              <c:choose>
							  <c:when test="${fn:length(clientCompanyList) > 0}">
							   	<c:forEach items="${clientCompanyList}" var="clientCompanyList">
							   		<c:if test="${clientCompanyList.USE_YN eq 'Y'}">
			                          <tr class="tr_list" onclick="goDetail.individualInfo('${clientCompanyList.CUSTOMER_ID}', '${clientCompanyList.COMPANY_ID}', '${clientCompanyList.CUSTOMER_NAME}')">
			                              <%-- <td>${clientCompanyList.ROWNUM}</td> --%>
			                              <td>${clientCompanyList.CUSTOMER_ID}</td>
			                              <td>${clientCompanyList.DIVISION}</td>
			                              <td>${clientCompanyList.POSITION}</td>
			                              <td>${clientCompanyList.CUSTOMER_NAME}</td>
			                              <td>${clientCompanyList.DUTY}</td>
			                              <td style="background-color: ${clientCompanyList.RELATION}"></td>
			                              <td style="background-color: ${clientCompanyList.LIKEABILITY}"></td>
			                              <td>${clientCompanyList.DIRECTOR_NAME}</td>
			                              <td>${clientCompanyList.CELL_PHONE}</td>
			                              <td>${clientCompanyList.EMAIL}</td>
			                          </tr>
			                          </c:if>
				                  </c:forEach>
							   </c:when>
							   <c:otherwise>
							   <tr>
						   		<td colspan="10" style="text-align:center;">No Data</td>
							   </tr>
							   </c:otherwise>
							   </c:choose>
                          </tbody>
                      </table>
                  </div>
                  
                   <div class="btn-group pull-right pd-t10">
					    <button type="button" class="btn btn-white" onClick="customerDetail.getCustomerCompanyList(${listPaging.startPage - listPaging.pagingSize},${listPaging.toEndPage});"><i class="fa fa-chevron-left"></i></button>
					    <c:forEach begin="${listPaging.startPage}" end="${listPaging.endPage}" var="paginNo">
						    <button class="btn btn-white <c:if test="${paginNo == listPaging.currentPage}">active</c:if>" onClick="customerDetail.getCustomerCompanyList(${paginNo},${listPaging.toEndPage});">${paginNo}</button>
					    </c:forEach>
					    <button type="button" class="btn btn-white" onClick="customerDetail.getCustomerCompanyList(${listPaging.startPage + listPaging.pagingSize},${listPaging.toEndPage});"><i class="fa fa-chevron-right"></i> </button>
					</div>
					
					<div style="height:300px;"></div>