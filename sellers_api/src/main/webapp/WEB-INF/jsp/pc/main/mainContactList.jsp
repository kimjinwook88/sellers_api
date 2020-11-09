<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="ibox float-e-margins">
	<div class="ibox-title landing-header">
	    <h5>최근 고객컨택내용(1달 이내)</h5>
	</div>
	<div class="ibox-content pd-no">
		<div class="module_height_base">
			<ul class="list-group">
				<c:choose>
					<c:when test="${fn:length(list) > 0}">
						<c:forEach items="${list}" var="list">
						<li class="list-group-item" style="cursor:pointer;" onclick="main.goContactList(${list.EVENT_ID})">
		                    <p><strong>${list.EVENT_SUBJECT}
		                    <c:if test="${list.COACHING_TALK_COUNT > 0}">
			              		<span style="color: orange;">(${list.COACHING_TALK_COUNT})</span> 
			              	</c:if></strong>
		                    </p>
		                    <c:set var="CUSTOMER_NAME" value="${fn:split(list.CUSTOMER_NAME,',')}" />
		                    <small class="block text-muted">
		                    <span>
		                    	영업대표 : ${list.HAN_NAME} / 고객: ${CUSTOMER_NAME[0]}
								<c:if test="${fn:length(CUSTOMER_NAME) > 1}">
									외 ${fn:length(CUSTOMER_NAME)-1}명
								</c:if> 
							</span> / <i class="fa fa-clock-o"></i> ${list.EVENT_DATE}</small>
		                </li>
		                </c:forEach>
					</c:when>
					<c:otherwise>
						<li style="border:none; padding-top:10px; text-align: center;">최근 고객컨택내용이 없습니다.</li>
					</c:otherwise>
				</c:choose>
            </ul>
		</div>
	</div>
</div>



<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<h4>최근 고객컨택내용(1달 이내)</h4>
<c:choose>
	<c:when test="${fn:length(list) > 0}">
		<div class="custom_contact_list2 full-height-scroll">
		<!-- <div class="custom_contact_list full-height-scroll"> -->
		 <ul>
		<c:forEach items="${list}" var="list">
            <li>
                <a href="javascript:void(0);" onClick="main.goContactList(${list.EVENT_ID});">${list.EVENT_SUBJECT}</a>
                <a>
                <div style="cursor:pointer;" onClick="main.goContactList(${list.EVENT_ID})">
                	<c:choose>
                    	<c:when test="${list.EVENT_CATEGORY eq '방문' }">
                    	<span class="cata cata_newcustom">${list.EVENT_CATEGORY}</span>
                    	</c:when>
                    	<c:when test="${list.EVENT_CATEGORY eq '마케팅' }">
                    	<span class="cata cata_visit">${list.EVENT_CATEGORY}</span>
                    	</c:when>
                    	<c:when test="${list.EVENT_CATEGORY eq 'SNS' }">
                    	<span class="cata cata_opp">${list.EVENT_CATEGORY}</span>
                    	</c:when>
                    	<c:when test="${list.EVENT_CATEGORY eq 'E-MAIL' }">
                    	<span class="cata cata_issue">${list.EVENT_CATEGORY}</span>
                    	</c:when>
                    	<c:when test="${list.EVENT_CATEGORY eq '전화' }">
                    	<span class="cata cata_etc">${list.EVENT_CATEGORY}</span>
                    	</c:when>
                    </c:choose>
                    <span class="subject">${list.EVENT_SUBJECT}</span>
                    <small class="block text-muted">고객 : ${list.CUSTOMER_NAME } / <i class="fa fa-clock-o"></i> ${list.EVENT_DATE}</small>
                </div>
                </a>
            </li>
		</c:forEach>
		 </ul>
	    </div>
	</c:when>
	<c:otherwise>
	<div class="custom_contact_list" style="text-align: center;padding-top: 10px;">
		최근 고객컨택내용이 없습니다.
	</div>
	</c:otherwise>
</c:choose>

 --%>