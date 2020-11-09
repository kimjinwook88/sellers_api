<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:choose>
	<c:when test="${fn:length(selectMainModuleSetUp) > 0}">
		<c:forEach items="${selectMainModuleSetUp}" var="selectMainModuleSetUp" varStatus="status">
		<tr <c:if test="${selectMainModuleSetUp.USE_YN eq 'N'}">class="unuse"</c:if> >
			<td class="first">${status.index+1}</td>
			<td><input type="checkbox" name="checkMainModule"/></td>
			<td>${selectMainModuleSetUp.MM_NAME}</td>
			<td>
			    <select class="mg-r10">
			        <option value="Y" <c:if test="${selectMainModuleSetUp.USE_YN eq 'Y'}">selected</c:if> >사용</option>
			 		<option value="N" <c:if test="${selectMainModuleSetUp.USE_YN eq 'N'}">selected</c:if> >미사용</option>
			    </select>
			</td>
			<input type="hidden" name="hiddenMainMenuId" value="${selectMainModuleSetUp.MM_ID}" />
		</tr>
		</c:forEach>
	</c:when>
</c:choose>
