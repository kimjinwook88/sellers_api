<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>


					<h2>소속 파트너사개인 스킬목록</h2>

                   <table id="tech-companies" class="basic4_list mg-b30">
                       <thead>
                       <tr>
                           <th>파트너사개인명</th>
                           <th>직급</th>
                           <th>소속본부</th>
                           <th>스킬영역</th>
                           <th>제조사</th>
                           <th>솔루션영역</th>
                           <th>스킬레벨</th>
                       </tr>
                       </thead>
                       <tbody>
                       <c:choose>
						  <c:when test="${fn:length(companyIndividualSkillMap) > 0}">
					   		<c:forEach items="${companyIndividualSkillMap}" var="companyIndividualSkillMap" varStatus="status">
		                      <tr class="tr_list" onclick="goDetail.client('${companyIndividualSkillMap.PARTNER_INDIVIDUAL_ID}', '${companyIndividualSkillMap.PARTNER_ID}', '${companyIndividualSkillMap.PARTNER_PERSONAL_NAME}')">
		                          <td>${companyIndividualSkillMap.PARTNER_PERSONAL_NAME}</td>
		                          <td>${companyIndividualSkillMap.POSITION}</td>
		                          <td>${companyIndividualSkillMap.DIVISION}</td>
		                          <c:choose>
	                          		<c:when test="${companyIndividualSkillMap.SKILL_CATEGORY eq '1'}">
	                          			<td>영업</td>
	                          		</c:when>
	                          		<c:when test="${companyIndividualSkillMap.SKILL_CATEGORY eq '2'}">
	                          			<td>기술</td>
	                          		</c:when>
	                          		<c:when test="${companyIndividualSkillMap.SKILL_CATEGORY eq '3'}">
	                          			<td>기타</td>
	                          		</c:when>
	                          		<c:otherwise>
	                          			<td>-</td>
	                          		</c:otherwise>
	                          	</c:choose>
		                          <td>${companyIndividualSkillMap.PRODUCT_VENDOR}</td>
		                          <%-- <td>${companyIndividualSkillMap.PRODUCT_GROUP}</td> --%>
		                          <td class="ag_l">${companyIndividualSkillMap.SOLUTION_AREA}</td>
		                          <c:choose>
	                          		<c:when test="${companyIndividualSkillMap.SKILL_LEVEL eq '1'}">
	                          			<td>상</td>
	                          		</c:when>
	                          		<c:when test="${companyIndividualSkillMap.SKILL_LEVEL eq '2'}">
	                          			<td>중</td>
	                          		</c:when>
	                          		<c:when test="${companyIndividualSkillMap.SKILL_LEVEL eq '3'}">
	                          			<td>하</td>
	                          		</c:when>
	                          		<c:otherwise>
	                          			<td>-</td>
	                          		</c:otherwise>
	                          	</c:choose>
		                      </tr>
	                      	</c:forEach>
						   </c:when>
						   <c:otherwise>
							<tr>
								<td colspan="7" style="text-align:center;">No Data</td>
							</tr>
							</c:otherwise>
					   </c:choose>
                       </tbody>
                   </table>
