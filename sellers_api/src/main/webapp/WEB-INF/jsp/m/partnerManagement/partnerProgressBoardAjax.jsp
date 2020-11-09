<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

				<table class="rtable rtable--flip">
					<thead>
						<tr>
							<th scope="col" >파트너</th>
							<c:choose>
								<c:when test="${fn:length(pratnerRows) > 0 }">
									<c:forEach var="rows" items="${pratnerRows}">
										<th scope="col" class="ta_l">${rows.COMPANY_NAME}</th>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<th>-</th>
								</c:otherwise>
							</c:choose>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">부서</th>
							<c:choose>
								<c:when test="${fn:length(pratnerRows) > 0 }">
									<c:forEach var="rows" items="${pratnerRows}">
										<c:if test="${rows.TEAM_NAME == null}">
											<td>-</td>
										</c:if>
										<c:if test="${rows.TEAM_NAME != null}">
											<td>${rows.TEAM_NAME}</td>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<td>-</td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr>
							<th scope="row">영업대표</th>
							<c:choose>
								<c:when test="${fn:length(pratnerRows) > 0 }">
									<c:forEach var="rows" items="${pratnerRows}">
										<c:if test="${rows.SALES_NAME == null}">
											<td>-</td>
										</c:if>
										<c:if test="${rows.SALES_NAME != null}">
											<td>${rows.SALES_NAME}</td>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<td>-</td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr>
							<th scope="row">파트너직원</th>
							<c:choose>
								<c:when test="${fn:length(pratnerRows) > 0 }">
									<c:forEach var="rows" items="${pratnerRows}">
										<c:if test="${rows.PARTNER_INDIVIDUAL_ID == null}">
											<td>-</td>
										</c:if>
										<c:if test="${rows.PARTNER_INDIVIDUAL_ID != null}">
											<td>${rows.PARTNER_PERSONAL_NAME}</td>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<td>-</td>
								</c:otherwise>
							</c:choose>
						</tr>
						<!-- 일정 관련 변수 -->
						<c:set var="now" value="<%=new java.util.Date()%>" />
						<c:set var="sysMonth"><fmt:formatDate value="${now}" pattern="MM" /></c:set>
						<c:set var="myArray" value="${fn:split('1,2,3,4,5,6,7,8,9,10,11,12',',')}" />
						
						<c:choose>
							<c:when test="${sysMonth == '01' || sysMonth == '02' || sysMonth == '03'}">
								<c:set var="quarter" value="1" />
							</c:when>
							<c:when test="${sysMonth == '04' || sysMonth == '05' || sysMonth == '06'}">
								<c:set var="quarter" value="2" />
							</c:when>
							<c:when test="${sysMonth == '07' || sysMonth == '08' || sysMonth == '09'}">
								<c:set var="quarter" value="3" />
							</c:when>
							<c:otherwise>
								<c:set var="quarter" value="4" />
							</c:otherwise>
						</c:choose>

						<%-- <c:forEach var="rows" items="${pratnerRows}">
							<c:if test="${10 == sysMonth}">
								<c:set var = "monthValue" value="${rows.MONTH_10}" />
								${monthValue}
							</c:if>
						</c:forEach>
						 --%>
						
						<tr>
							<th scope="row">주기</th>
							<c:choose>
								<c:when test="${fn:length(pratnerRows) > 0 }">
									<c:forEach var="rows" items="${pratnerRows}">
										<c:if test="${rows.CADENCE_CYCLE == null}">
											<td>-</td>
											<c:set var="cycle" value="1" />
										</c:if>
										<c:if test="${rows.CADENCE_CYCLE != null}">
										<c:set var="cycle" value="${rows.CADENCE_CYCLE}" />
											<td>${rows.CADENCE_CYCLE}</td>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<td>-</td>
									<c:set var="cycle" value="2" />
								</c:otherwise>
							</c:choose>
						</tr>
						
						<tr>
							<th scope="row">${sysMonth}월/1주</th>
							<c:choose>
								<c:when test="${fn:length(pratnerRows) > 0 }">
									<c:forEach var="rows" items="${pratnerRows}">
										<c:if test="${rows.CADENCE_CYCLE != null}">	
											<c:forEach var="item" items="${myArray}" varStatus="idx">
												<c:if test="${idx.index == sysMonth}">
													<%-- ${idx.index} --%>
													<%-- <c:set var="real" >rows.MONTH_${idx.index}</c:set> --%>
													
													<%-- ${item[real]} --%>
													<%-- <c:set var = "monthValue" value="${real}" /> --%>
													<%-- ${monthValue}
													${requestScope[monthValue]} --%>
												</c:if>
											</c:forEach>
												<c:set var = "monthValue" value="${rows.MONTH}" />
												<c:set var = "string2" value="${fn:split(monthValue, ' ')}" />
											<c:choose>
												<c:when test="${monthValue != '' and monthValue != null}">
													<c:if test="${string2[0] == 'X'}">
														<td><img src="../../../images/m/icon_check_no.png" alt="미진행"/></td>
													</c:if>
													<c:if test="${string2[0] == 'O'}">
														<td><img src="../../../images/m/icon_check.png" alt="진행"/></td>
													</c:if>
												</c:when>
												<c:otherwise>
													<td><img src="../../../images/m/icon_check_no.png" alt="미진행"/></td>
												</c:otherwise>
											</c:choose>
										</c:if>
										<!-- 사이클이 없는 경우 -->
										<c:if test="${rows.CADENCE_CYCLE == null}">
											<td>-</td>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<td>-</td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr>
							<th scope="row">${sysMonth}월/2주</th>
							<c:choose>
								<c:when test="${fn:length(pratnerRows) > 0 }">
									<c:forEach var="rows" items="${pratnerRows}">
									
										<c:set var = "monthValue" value="${rows.MONTH}" />
										<c:set var = "string2" value="${fn:split(monthValue, ' ')}" />
										<c:if test="${rows.CADENCE_CYCLE == 'Weekly'}">
										<c:choose>
											<c:when test="${monthValue != ''  and monthValue != null}">
												<c:if test="${string2[1] == 'X'}">
													<td><img src="../../../images/m/icon_check_no.png" alt="미진행"/></td>
												</c:if>
												<c:if test="${string2[1] == 'O'}">
													<td><img src="../../../images/m/icon_check.png" alt="진행"/></td>
												</c:if>
											</c:when>
											<c:otherwise>
												<td><img src="../../../images/m/icon_check_no.png" alt="미진행"/></td>
											</c:otherwise>
										</c:choose>
										</c:if>
										<c:if test="${rows.CADENCE_CYCLE != 'Weekly'}">
											<td>-</td>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<td>-</td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr>
							<th scope="row">${sysMonth}월/3주</th>
							<c:choose>
								<c:when test="${fn:length(pratnerRows) > 0 }">
									<c:forEach var="rows" items="${pratnerRows}">
										<c:forEach var="item" items="${myArray}" varStatus="idx">
											<c:if test="${idx.index == sysMonth}">
												<%-- <c:set var = "monthValue" value="rows.MONTH_${item}" /> --%>
											</c:if>
										</c:forEach>
										<c:set var = "monthValue" value="${rows.MONTH}" />
										<c:set var = "string2" value="${fn:split(monthValue, ' ')}" />
										
										<c:if test="${rows.CADENCE_CYCLE == 'Weekly'}">
										<c:choose>
											<c:when test="${monthValue != ''  and monthValue != null}">
												<c:if test="${string2[2] == 'X'}">
													<td><img src="../../../images/m/icon_check_no.png" alt="미진행"/></td>
												</c:if>
												<c:if test="${string2[2] == 'O'}">
													<td><img src="../../../images/m/icon_check.png" alt="진행"/></td>
												</c:if>
											</c:when>
											<c:otherwise>
												<td><img src="../../../images/m/icon_check_no.png" alt="미진행"/></td>
											</c:otherwise>
										</c:choose>
										</c:if>
										<c:if test="${rows.CADENCE_CYCLE != 'Weekly'}">
											<td>-</td>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<td>-</td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr>
							<th scope="row">${sysMonth}월/4주</th>
							<c:choose>
								<c:when test="${fn:length(pratnerRows) > 0 }">
									<c:forEach var="rows" items="${pratnerRows}">
										<c:forEach var="item" items="${myArray}" varStatus="idx">
											<c:if test="${idx.index == sysMonth}">
												<%-- <c:set var = "monthValue" value="rows.MONTH_${item}" /> --%>
											</c:if>
										</c:forEach>
										<c:set var = "monthValue" value="${rows.MONTH}" />
										<c:set var = "string2" value="${fn:split(monthValue, ' ')}" />
										<c:if test="${rows.CADENCE_CYCLE == 'Weekly'}">
										<c:choose>
											<c:when test="${monthValue != '' and monthValue != null}">
												<c:if test="${string2[3] == 'X'}">
													<td><img src="../../../images/m/icon_check_no.png" alt="미진행"/></td>
												</c:if>
												<c:if test="${string2[3] == 'O'}">
													<td><img src="../../../images/m/icon_check.png" alt="진행"/></td>
												</c:if>
											</c:when>
											<c:otherwise>
												<td><img src="../../../images/m/icon_check_no.png" alt="미진행"/></td>
											</c:otherwise>
										</c:choose>
										</c:if>
										<c:if test="${rows.CADENCE_CYCLE != 'Weekly'}">
											<td>-</td>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<td>-</td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr>
							<th scope="row">${sysMonth}월/5주</th>
							<c:choose>
								<c:when test="${fn:length(pratnerRows) > 0 }">
									<c:forEach var="rows" items="${pratnerRows}">
										<c:forEach var="item" items="${myArray}" varStatus="idx">
											<c:if test="${idx.index == sysMonth}">
												<%-- <c:set var = "monthValue" value="rows.MONTH_${item}" /> --%>
											</c:if>
										</c:forEach>
										<c:set var = "monthValue" value="${rows.MONTH}" />
										<c:set var = "string2" value="${fn:split(monthValue, ' ')}" />
										<c:if test="${rows.CADENCE_CYCLE == 'Weekly'}">
										
										<c:choose>
											<c:when test="${monthValue != '' and monthValue != null}">
												<c:choose>
													<c:when test="${string2[4] == 'O'}"> 
														<td><img src="../../../images/m/icon_check.png" alt="진행"/></td>
													</c:when>
													<c:otherwise>
														<td><img src="../../../images/m/icon_check_no.png" alt="미진행"/></td>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												<td><img src="../../../images/m/icon_check_no.png" alt="미진행"/></td>
											</c:otherwise>
										</c:choose>
										</c:if>
										<c:if test="${rows.CADENCE_CYCLE != 'Weekly'}">
											<td>-</td>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<td>-</td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr class="sixWeek">
							<th scope="row">${sysMonth}월/6주</th>
							<c:choose>
								<c:when test="${fn:length(pratnerRows) > 0 }">
									<c:forEach var="rows" items="${pratnerRows}">
										<c:forEach var="item" items="${myArray}" varStatus="idx">
											<c:if test="${idx.index == sysMonth}">
												<%-- <c:set var = "monthValue" value="rows.MONTH_${item}" /> --%>
											</c:if>
										</c:forEach>
										<c:set var = "monthValue" value="${rows.MONTH}" />
										<c:set var = "string2" value="${fn:split(monthValue, ' ')}" />
										<c:if test="${rows.CADENCE_CYCLE == 'Weekly'}">
										
										<c:choose>
											<c:when test="${monthValue != '' and monthValue != null}">
												<c:choose>
													<c:when test="${string2[5] == 'O'}"> 
														<td><img src="../../../images/m/icon_check.png" alt="진행"/></td>
													</c:when>
													<c:otherwise>
														<td><img src="../../../images/m/icon_check_no.png" alt="미진행"/></td>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												<td><img src="../../../images/m/icon_check_no.png" alt="미진행"/></td>
											</c:otherwise>
										</c:choose>
										</c:if>
										<c:if test="${rows.CADENCE_CYCLE != 'Weekly'}">
											<td>-</td>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<td>-</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</tbody>
				</table>