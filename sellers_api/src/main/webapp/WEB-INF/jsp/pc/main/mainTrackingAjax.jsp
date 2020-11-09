<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

 <div class="ibox float-e-margins">
	<div class="ibox-title landing-header">
       <h5>DUE-DATE TRACKING</h5>
   </div>
   <div class="ibox-content pd-no">
   <div class="module_height_base">
   <div class="ta-c">
	<c:choose>
		<c:when test="${fn:length(list) > 0}">
		<ul class="list-group full-height-scroll">
			<c:forEach items="${list}" var="list">
				<li class="list-group-item" style="cursor:pointer;" onClick="main.goTacking(${list.EVENT_ID},'${list.NOTICE_REDIRECT_URL}')">
			        <p>
			        	
			        	<c:choose>
					     	<c:when test="${list.NOTICE_CATEGORY == 'TRACKING'}">
					         <span class="label statusColor-red">${list.NOTICE_CODE}</span> 
							</c:when>
						</c:choose>
						
						<strong <c:if test="${list.OVER_DUE_FLAG != '0'}">style="color:#FF6C6C;"</c:if>><br />${list.NOTICE_DETAIL}</strong>
						
			            <%-- <strong <c:if test="${list.OVER_DUE_FLAG == 1}">style="color:#FF6C6C;"</c:if>>${list.NOTICE_DETAIL}</strong> --%>
			            <%-- <strong style="color:#FF6C6C;">[${list.NOTICE_CODE}]<br />${list.NOTICE_DETAIL}</strong> --%>
			        </p>
			        <%-- <small class="block text-muted"><span>해결책임자 : ${list.SOLVE_OWNER_NAME} </span> / <span>고객 : ${list.CUSTOMER_NAME} </span> / <i class="fa fa-clock-o"></i> ${list.SYS_UPDATE_DATE}</small> --%>
			    </li>
			</c:forEach>
		</ul>
		</c:when>
		<c:otherwise>
			<div style="text-align:center;padding-top:10px;" >
			    <strong>TRACKING 목록이 없습니다.</strong>
			 </div>
		</c:otherwise>
	</c:choose>
	</div>
	</div>
	</div>
</div>



<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${fn:length(list) > 0}">
	<ul class="list-group full-height-scroll">
		<c:forEach items="${list}" var="list">
			<li class="list-group-item" style="cursor:pointer;" onClick="main.goTacking(${list.EVENT_ID},'${list.NOTICE_REDIRECT_URL}')">
		        <p>
		        	
		        	<c:choose>
				     	<c:when test="${list.NOTICE_CATEGORY == 'TRACKING'}">
				         <span class="label statusColor-red">${list.NOTICE_CODE}</span> 
						</c:when>
					</c:choose>
					
					<strong <c:if test="${list.OVER_DUE_FLAG != '0'}">style="color:#FF6C6C;"</c:if>><br />${list.NOTICE_DETAIL}</strong>
					
		            <strong <c:if test="${list.OVER_DUE_FLAG == 1}">style="color:#FF6C6C;"</c:if>>${list.NOTICE_DETAIL}</strong>
		            <strong style="color:#FF6C6C;">[${list.NOTICE_CODE}]<br />${list.NOTICE_DETAIL}</strong>
		        </p>
		        <small class="block text-muted"><span>해결책임자 : ${list.SOLVE_OWNER_NAME} </span> / <span>고객 : ${list.CUSTOMER_NAME} </span> / <i class="fa fa-clock-o"></i> ${list.SYS_UPDATE_DATE}</small>
		    </li>
		</c:forEach>
	</ul>
	</c:when>
	<c:otherwise>
		<div style="text-align: center;padding-top:15px;" >
		    <strong>TRACKING 목록이 없습니다.</strong>
		 </div>
	</c:otherwise>
</c:choose> --%>