<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${fn:length(list) > 0}">
<ul class="list-group full-height-scroll">
		<c:forEach items="${list}" var="list">
			<li class="list-group-item" style="cursor:pointer;" onClick="main.goSalesAct(${list.PK},'${list.CODE}')">
		        <p>
					<span class="label statusColor-green">고객이슈</span>
		            <strong <c:if test="${list.OVER_DUE == 1}">style="color:#FF6C6C;"</c:if>>${list.SUBJECT}
		            <c:if test="${list.COACHING_TALK_COUNT > 0}">
              			<span style="color: orange;">(${list.COACHING_TALK_COUNT})</span> 
			  		</c:if>
		            </strong>
		        </p>
		        <c:set var="CUSTOMER_NAME" value="${fn:split(list.CUSTOMER_NAME,',')}" />
		        <small class="block text-muted"><span>해결책임자 : ${list.SOLVE_OWNER_NAME} </span> / <span>고객 : ${CUSTOMER_NAME[0]}
              		<c:if test="${fn:length(CUSTOMER_NAME) > 1}">
              			외 ${fn:length(CUSTOMER_NAME)-1}명
              		</c:if> </span> / <i class="fa fa-clock-o"></i> ${list.SYS_UPDATE_DATE}</small>
		    </li>
		</c:forEach>
	</ul>
	</c:when>
	<c:otherwise>
		<div style="text-align: center;padding-top:15px;" >
		    <strong>신규 및 업데이트 고객이슈가 없습니다.</strong>
		 </div>
	</c:otherwise>
</c:choose>