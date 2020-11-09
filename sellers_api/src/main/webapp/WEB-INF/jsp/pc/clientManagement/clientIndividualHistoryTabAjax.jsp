<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>

				<div id="tab2-5" class="tab-pane active">
                   <h2>이전회사 정보</h2>
					<table id="tech-companies" class="table table-bordered">
                       <thead>
                       <tr>
                           <th>고객사ID</th>
                           <th>고객사명</th>
                           <th>부서</th>
                           <th>고객개인ID</th>
                           <th>고객개인명</th>
                           <th>입사일</th>
                           <th>퇴사일</th>
                       </tr>
                       </thead>
                       <tbody>
                       <c:choose>
						  <c:when test="${fn:length(individualHistory) > 0}">
					   		<c:forEach items="${individualHistory}" var="individualHistory">
	                       <tr>
	                           <td>${individualHistory.COMPANY_ID}</td>
	                           <td class="ag_l">${individualHistory.COMPANY_NAME}</td>
	                           <td>${individualHistory.DIVISION}</td>
	                           <td>${individualHistory.BEFORE_CUST_ID}</td>
	                           <td>${individualHistory.CUSTOMER_NAME}</td>
	                           <td>${individualHistory.HIRE_DATE}</td>
	                           <td>${individualHistory.LEAVE_DATE}</td>
	                       </tr>
	                       </c:forEach>
						   </c:when>
						   <c:otherwise>
						   <tr>
					   		<td colspan="7">No Data</td>
						   </tr>
						   </c:otherwise>
					   </c:choose>
                       </tbody>
                   </table>
                   <!-- <table id="saleseDetail"></table> -->
               </div>