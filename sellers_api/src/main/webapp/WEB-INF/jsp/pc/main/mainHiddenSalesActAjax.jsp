<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="ibox float-e-margins">
   <div class="ibox-title landing-header">
       <h5>잠재영업기회</h5>
   </div>
   <div class="ibox-content pd-no">
       <div class="module_height_base">
           <ul class="list-group">
           	   <c:choose>
				   <c:when test="${fn:length(list) > 0}">
				   <c:forEach items="${list}" var="list">
					<li class="list-group-item" style="cursor:pointer;" onclick="main.goDetail(${list.PK},'2')">
					    <p>
							<strong>
								${list.SUBJECT}
					            <c:if test="${list.COACHING_TALK_COUNT > 0}">
			              			<span style="color: orange;">(${list.COACHING_TALK_COUNT})</span> 
						  		</c:if>
					  		</strong>
					    </p>
					    <small class="block text-muted"><span>영업대표 : ${list.SALESMAN_NAME} / 고객: ${list.CUSTOMER_NAME} </span> / <i class="fa fa-clock-o"></i> ${list.SYS_UPDATE_DATE}</small>
					</li>
					</c:forEach>
				   </c:when>
				   <c:otherwise>
					<li style="border:none; text-align: center; padding-top:10px;"><strong>잠재영업기회가 없습니다.</strong></li>
				   </c:otherwise>
			   </c:choose>
            </ul>
        </div>
    </div>
</div>