<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>

<table id="tech-companies" class="basic4_list mg-b30">
	<thead>
		<tr>
			<!-- <th>No</th> -->
			<th>고객개인ID</th>
			<th>본부</th>
			<th>직급</th>
			<th>직책</th>
			<th>담당업무</th>
			<th>고객개인명</th>
			<th width="7%">관계수립</th>
			<th width="7%">호감도</th>
			<th>책임자</th>
			<th>휴대전화</th>
			<th>메일주소</th>
		</tr>
	</thead>
	<tbody>
	
		<%-- <c:set value="1" var="positionCnt"/> --%>
		<fmt:parseNumber value="0" var="positionCnt" />
		<c:set var="doneLoop" value="false" />
		<c:choose>
			<c:when test="${fn:length(clientCompanyList) > 0}">
				<c:forEach items="${clientCompanyList}" var="clientCompanyList"	varStatus="status">
					<c:choose>
						<c:when	test="${textSearchClient eq '' || textSearchClient eq null}">
							<c:if test="${not doneLoop}">
								<c:choose>
									<c:when	test="${fn:toUpperCase(clientCompanyList.POSITION_DUTY) eq 'CEO' && clientCompanyList.USE_YN eq 'Y'}">
										<tr class="tr_list" onclick="goDetail.client('${clientCompanyList.CUSTOMER_ID}', '${clientCompanyList.COMPANY_ID}', '${clientCompanyList.CUSTOMER_NAME}')">
											<%-- <td>${clientCompanyList.ROWNUM}</td> --%>
											<td>${clientCompanyList.CUSTOMER_ID}</td>
											<td>${clientCompanyList.DIVISION}</td>
											<td>${clientCompanyList.POSITION}</td>
											<td>${fn:toUpperCase(clientCompanyList.POSITION_DUTY)}</td>
											<td>${clientCompanyList.DUTY}</td>
											<td>${clientCompanyList.CUSTOMER_NAME}</td>
											<td style="background-color: ${clientCompanyList.RELATION}"></td>
											<td	style="background-color: ${clientCompanyList.LIKEABILITY}"></td>
											<td>${clientCompanyList.DIRECTOR_NAME}</td>
											<td>${clientCompanyList.CELL_PHONE}</td>
											<td>${clientCompanyList.EMAIL}</td>
										</tr>

										<c:if test="${status.last}">
											<tr>
												<td></td>
												<td></td>
												<td></td>
												<td>COO</td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<td></td>
												<td></td>
												<td></td>
												<td>CFO</td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
										</c:if>

										<fmt:parseNumber value="1" var="positionCnt" />
										<c:set var="doneLoop" value="true" />
									</c:when>
									<c:when	test="${positionCnt < 1 && listPaging.currentPage == 1}">
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td>CEO</td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<fmt:parseNumber value="1" var="positionCnt" />
									</c:when>
								</c:choose>
							</c:if>

							<c:if test="${not doneLoop}">
								<c:choose>
									<c:when	test="${fn:toUpperCase(clientCompanyList.POSITION_DUTY) eq 'COO' && clientCompanyList.USE_YN eq 'Y'}">
										<tr class="tr_list" onclick="goDetail.client('${clientCompanyList.CUSTOMER_ID}', '${clientCompanyList.COMPANY_ID}', '${clientCompanyList.CUSTOMER_NAME}')">
											<%-- <td>${clientCompanyList.ROWNUM}</td> --%>
											<td>${clientCompanyList.CUSTOMER_ID}</td>
											<td>${clientCompanyList.DIVISION}</td>
											<td>${clientCompanyList.POSITION}</td>
											<td>${fn:toUpperCase(clientCompanyList.POSITION_DUTY)}</td>
											<td>${clientCompanyList.DUTY}</td>
											<td>${clientCompanyList.CUSTOMER_NAME}</td>
											<td style="background-color: ${clientCompanyList.RELATION}"></td>
											<td	style="background-color: ${clientCompanyList.LIKEABILITY}"></td>
											<td>${clientCompanyList.DIRECTOR_NAME}</td>
											<td>${clientCompanyList.CELL_PHONE}</td>
											<td>${clientCompanyList.EMAIL}</td>
										</tr>

										<c:if test="${status.last}">
											<tr>
												<td></td>
												<td></td>
												<td></td>
												<td>CFO</td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
										</c:if>

										<fmt:parseNumber value="2" var="positionCnt" />
										<c:set var="doneLoop" value="true" />
									</c:when>
									<c:when	test="${positionCnt < 2 && listPaging.currentPage == 1}">
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td>COO</td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<fmt:parseNumber value="2" var="positionCnt" />
									</c:when>
								</c:choose>
							</c:if>

							<c:if test="${not doneLoop}">
								<c:choose>
									<c:when	test="${fn:toUpperCase(clientCompanyList.POSITION_DUTY) eq 'CFO' && clientCompanyList.USE_YN eq 'Y'}">
										<tr class="tr_list"	onclick="goDetail.client('${clientCompanyList.CUSTOMER_ID}', '${clientCompanyList.COMPANY_ID}', '${clientCompanyList.CUSTOMER_NAME}')">
											<%-- <td>${clientCompanyList.ROWNUM}</td> --%>
											<td>${clientCompanyList.CUSTOMER_ID}</td>
											<td>${clientCompanyList.DIVISION}</td>
											<td>${clientCompanyList.POSITION}</td>
											<td>${fn:toUpperCase(clientCompanyList.POSITION_DUTY)}</td>
											<td>${clientCompanyList.DUTY}</td>
											<td>${clientCompanyList.CUSTOMER_NAME}</td>
											<td style="background-color: ${clientCompanyList.RELATION}"></td>
											<td	style="background-color: ${clientCompanyList.LIKEABILITY}"></td>
											<td>${clientCompanyList.DIRECTOR_NAME}</td>
											<td>${clientCompanyList.CELL_PHONE}</td>
											<td>${clientCompanyList.EMAIL}</td>
										</tr>
										
										<fmt:parseNumber value="8" var="positionCnt" />
										<c:set var="doneLoop" value="true" />
									</c:when>
									<c:when	test="${positionCnt < 8 && listPaging.currentPage == 1}">
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td>CFO</td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<fmt:parseNumber value="8" var="positionCnt" />
									</c:when>
									<c:otherwise>
										<fmt:parseNumber value="8" var="positionCnt" />
									</c:otherwise>
								</c:choose>
							</c:if>

							<c:if test="${not doneLoop}">
								<c:if test="${positionCnt >= 8 && clientCompanyList.USE_YN eq 'Y'}">
									<tr class="tr_list"	onclick="goDetail.client('${clientCompanyList.CUSTOMER_ID}', '${clientCompanyList.COMPANY_ID}', '${clientCompanyList.CUSTOMER_NAME}')">
										<%-- <td>${clientCompanyList.ROWNUM}</td> --%>
										<td>${clientCompanyList.CUSTOMER_ID}</td>
										<td>${clientCompanyList.DIVISION}</td>
										<td>${clientCompanyList.POSITION}</td>
										<td>${clientCompanyList.POSITION_DUTY}</td>
										<td>${clientCompanyList.DUTY}</td>
										<td>${clientCompanyList.CUSTOMER_NAME}</td>
										<td style="background-color: ${clientCompanyList.RELATION}"></td>
										<td style="background-color: ${clientCompanyList.LIKEABILITY}"></td>
										<td>${clientCompanyList.DIRECTOR_NAME}</td>
										<td>${clientCompanyList.CELL_PHONE}</td>
										<td>${clientCompanyList.EMAIL}</td>
									</tr>
									<c:set var="doneLoop" value="true" />
								</c:if>
							</c:if>
							<c:set var="doneLoop" value="false" />
						</c:when>
						<c:otherwise>
							<tr class="tr_list" onclick="goDetail.client('${clientCompanyList.CUSTOMER_ID}', '${clientCompanyList.COMPANY_ID}', '${clientCompanyList.CUSTOMER_NAME}')">
								<%-- <td>${clientCompanyList.ROWNUM}</td> --%>
								<td>${clientCompanyList.CUSTOMER_ID}</td>
								<td>${clientCompanyList.DIVISION}</td>
								<td>${clientCompanyList.POSITION}</td>
								<td>${clientCompanyList.POSITION_DUTY}</td>
								<td>${clientCompanyList.DUTY}</td>
								<td>${clientCompanyList.CUSTOMER_NAME}</td>
								<td style="background-color: ${clientCompanyList.RELATION}"></td>
								<td style="background-color: ${clientCompanyList.LIKEABILITY}"></td>
								<td>${clientCompanyList.DIRECTOR_NAME}</td>
								<td>${clientCompanyList.CELL_PHONE}</td>
								<td>${clientCompanyList.EMAIL}</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<c:if test="${listPaging.currentPage == 1}">
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td>CEO</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td>COO</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td>CFO</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</c:if>
				<!-- <tr>
							<td colspan="10" style="text-align:center;">No Data</td>
						</tr> -->
			</c:otherwise>
		</c:choose>
	</tbody>
</table>