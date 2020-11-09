<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
		<c:choose>
			<c:when test="${clientContactMethod.TOTAL_CNT > 0}">
				<tr>
					<th scope="row">${clientContactMethod.TARGET_NAME}</th>
					<td>${clientContactMethod.TOTAL_CNT}</td>
					<td>${clientContactMethod.VISIT_CNT}</td>
					<td>${clientContactMethod.EMAIL_CNT}</td>
					<td>${clientContactMethod.SNS_CNT}</td>
					<td>${clientContactMethod.MARKETING_CNT}</td>
					<td>${clientContactMethod.PHONE_CNT}</td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr>
					<th colspan="7">현재 등록된 데이터가 없습니다.</th>
				</tr>
			</c:otherwise>
		</c:choose>
	</c:when>

	<c:otherwise>
		<c:set var="totalSum" value="0" />
		<c:set var="visitSum" value="0" />
		<c:set var="marketingSum" value="0" />
		<c:set var="snsSum" value="0" />
		<c:set var="emailSum" value="0" />
		<c:set var="phoneSum" value="0" />

		<c:forEach items="${clientContactMethod}" var="cnt" varStatus="status">
			<tr style="display: none;">
				<th scope="row" class="ta_l">${cnt.TARGET_NAME}</th>
				<td>${cnt.TOTAL_COUNT}</td>
				<td>${cnt.VISIT_CNT}</td>
				<td>${cnt.EMAIL_CNT}</td>
				<td>${cnt.SNS_CNT}</td>
				<td>${cnt.MARKETING_CNT}</td>
				<td>${cnt.PHONE_CNT}</td>
			</tr>

			<c:set var="totalSum"
				value="${totalSum + cnt.VISIT_CNT + cnt.EMAIL_CNT +  cnt.SNS_CNT + cnt.MARKETING_CNT + cnt.PHONE_CNT}" />
			<c:set var="visitSum" value="${visitSum + cnt.VISIT_CNT}" />
			<c:set var="marketingSum" value="${marketingSum + cnt.MARKETING_CNT}" />
			<c:set var="snsSum" value="${snsSum + cnt.SNS_CNT}" />
			<c:set var="emailSum" value="${emailSum + cnt.EMAIL_CNT}" />
			<c:set var="phoneSum" value="${phoneSum + cnt.PHONE_CNT}" />
		</c:forEach>

		<c:choose>
			<c:when test="${totalSum > 0}">
				<tr>					
					<c:choose>
						<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
							<th scope="row" class="ta_l">회사전체</th>
						</c:when>
						<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
							<th scope="row" class="ta_l">본부전체</th>
						</c:when>
						<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
							<th scope="row" class="ta_l">팀전체</th>
						</c:when>
						<c:otherwise>
							<th scope="row" class="ta_l">회사전체</th>
						</c:otherwise>
					</c:choose>				
					
					<td>${totalSum}</td>
					<td>${visitSum}</td>
					<td>${emailSum}</td>
					<td>${snsSum}</td>
					<td>${marketingSum}</td>
					<td>${phoneSum}</td>
				</tr>
				<c:forEach items="${clientContactMethod}" var="cnt"
					varStatus="status">
					<tr>
						<th scope="row" class="ta_l">${cnt.TARGET_NAME}</th>
						<td>${cnt.VISIT_CNT + cnt.EMAIL_CNT +  cnt.SNS_CNT + cnt.MARKETING_CNT + cnt.PHONE_CNT}</td>
						<td>${cnt.VISIT_CNT}</td>
						<td>${cnt.EMAIL_CNT}</td>
						<td>${cnt.SNS_CNT}</td>
						<td>${cnt.MARKETING_CNT}</td>
						<td>${cnt.PHONE_CNT}</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<th colspan="7">현재 등록된 데이터가 없습니다.</th>
				</tr>
			</c:otherwise>
		</c:choose>
		
	</c:otherwise>
</c:choose>