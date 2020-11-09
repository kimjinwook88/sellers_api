<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 
 <jsp:useBean id="getDate" class="java.util.Date" />
<fmt:formatDate var="currentDate" value="${getDate}" pattern="yyyy-MM-dd" />
 
 <div class="step">
 		<c:choose>
			<c:when test="${param.CLOSE_DATE_5 ne null && param.CLOSE_DATE_5 != '' }">
				<span class="icon_status statusColor-green"></span>
			</c:when>
			<c:when test="${(param.DUE_DATE_5 ne null && param.DUE_DATE_5 != '') && param.DUE_DATE_5 >= currentDate }">
				<span class="icon_status statusColor-yellow"></span>
			</c:when>
			<c:when test="${(param.DUE_DATE_5 ne null && param.DUE_DATE_5 != '') && param.DUE_DATE_5 < currentDate}">
				<span class="icon_status statusColor-red"></span>
			</c:when>
		</c:choose>
   	<c:choose>
			<c:when test="${param.CLOSE_DATE_4 ne null && param.CLOSE_DATE_4 != '' }">
				<span class="icon_status statusColor-green"></span>
			</c:when>
			<c:when test="${(param.DUE_DATE_4 ne null && param.DUE_DATE_4 != '') &&  param.DUE_DATE_4 >= currentDate }">
				<span class="icon_status statusColor-yellow"></span>
			</c:when>
			<c:when test="${(param.DUE_DATE_4 ne null && param.DUE_DATE_4 != '') &&  param.DUE_DATE_4 < currentDate}">
				<span class="icon_status statusColor-red"></span>
			</c:when>
		</c:choose>
   	<c:choose>
			<c:when test="${param.CLOSE_DATE_3 ne null && param.CLOSE_DATE_3 != '' }">
				<span class="icon_status statusColor-green"></span>
			</c:when>
			<c:when test="${(param.DUE_DATE_3 ne null && param.DUE_DATE_3 != '') &&  param.DUE_DATE_3 >= currentDate }">
				<span class="icon_status statusColor-yellow"></span>
			</c:when>
			<c:when test="${(param.DUE_DATE_3 ne null && param.DUE_DATE_3 != '') &&  param.DUE_DATE_3 < currentDate}">
				<span class="icon_status statusColor-red"></span>
			</c:when>
		</c:choose>
    <c:choose>
			<c:when test="${param.CLOSE_DATE_2 ne null && param.CLOSE_DATE_2 != '' }">
				<span class="icon_status statusColor-green"></span>
			</c:when>
			<c:when test="${(param.DUE_DATE_2 ne null && param.DUE_DATE_2 != '') &&  param.DUE_DATE_2 >= currentDate }">
				<span class="icon_status statusColor-yellow"></span>
			</c:when>
			<c:when test="${(param.DUE_DATE_2 ne null && param.DUE_DATE_2 != '') &&  param.DUE_DATE_2 < currentDate}">
				<span class="icon_status statusColor-red"></span>
			</c:when>
		</c:choose>
   	<c:choose>
			<c:when test="${param.CLOSE_DATE_1 ne null && param.CLOSE_DATE_1 != '' }">
				<span class="icon_status statusColor-green"></span>
			</c:when>
			<c:when test="${(param.DUE_DATE_1 ne null && param.DUE_DATE_1 != '') &&  param.DUE_DATE_1 >= currentDate }">
				<span class="icon_status statusColor-yellow"></span>
			</c:when>
			<c:when test="${(param.DUE_DATE_1 ne null && param.DUE_DATE_1 != '') &&  param.DUE_DATE_1 < currentDate}">
				<span class="icon_status statusColor-red"></span>
			</c:when>
		</c:choose>
		
		 <c:choose>
  			<c:when test="${ 
  				(param.CONTENTS_1 eq null || param.CONTENTS_1 == '')
  				&& (param.CONTENTS_2 eq null || param.CONTENTS_2 == '')
  				&& (param.CONTENTS_3 eq null || param.CONTENTS_3 == '')
  				&& (param.CONTENTS_4 eq null || param.CONTENTS_4 == '')
  				&& (param.CONTENTS_5 eq null || param.CONTENTS_5 == '')
  				 }">-</c:when>
  		</c:choose>
  		
</div>


<!-- 풍선말 팝업: milestones 상세내용/2018-10-16 -->
 <div class="pop_milestones_detail r5" style="display:none;">
 
 	 <div class="step">
      <c:choose>
  			<c:when test="${param.CLOSE_DATE_5 ne null && param.CLOSE_DATE_5 != '' }">
				<span class="icon_status statusColor-green"></span>
			</c:when>
			<c:when test="${(param.DUE_DATE_5 ne null && param.DUE_DATE_5 != '') && param.DUE_DATE_5 >= currentDate }">
				<span class="icon_status statusColor-yellow"></span>
			</c:when>
			<c:when test="${(param.DUE_DATE_5 ne null && param.DUE_DATE_5 != '') && param.DUE_DATE_5 < currentDate}">
				<span class="icon_status statusColor-red"></span>
			</c:when>
  		</c:choose>
  			<c:if test="${param.OWNER_NAME_5 ne null && param.OWNER_NAME_5 != '' }">
					<span class="owner">[${param.OWNER_NAME_5}]</span>
				</c:if>
         <span class="subject">${param.CONTENTS_5}</span>
         <!-- <span class="term">(2016-07-18)</span> -->
     </div>
     
     <div class="step">
      <c:choose>
  			<c:when test="${param.CLOSE_DATE_4 ne null && param.CLOSE_DATE_4 != '' }">
				<span class="icon_status statusColor-green"></span>
			</c:when>
			<c:when test="${(param.DUE_DATE_4 ne null && param.DUE_DATE_4 != '') && param.DUE_DATE_4 >= currentDate }">
				<span class="icon_status statusColor-yellow"></span>
			</c:when>
			<c:when test="${(param.DUE_DATE_4 ne null && param.DUE_DATE_4 != '') && param.DUE_DATE_4 < currentDate}">
				<span class="icon_status statusColor-red"></span>
			</c:when>
  		</c:choose>
  			<c:if test="${param.OWNER_NAME_4 ne null && param.OWNER_NAME_4 != '' }">
					<span class="owner">[${param.OWNER_NAME_4}]</span>
				</c:if>
         <span class="subject">${param.CONTENTS_4}</span>
         <!-- <span class="term">(2016-07-18)</span> -->
     </div>
     
     <div class="step">
      <c:choose>
  			<c:when test="${param.CLOSE_DATE_3 ne null && param.CLOSE_DATE_3 != '' }">
				<span class="icon_status statusColor-green"></span>
			</c:when>
			<c:when test="${(param.DUE_DATE_3 ne null && param.DUE_DATE_3 != '') && param.DUE_DATE_3 >= currentDate }">
				<span class="icon_status statusColor-yellow"></span>
			</c:when>
			<c:when test="${(param.DUE_DATE_3 ne null && param.DUE_DATE_3 != '') && param.DUE_DATE_3 < currentDate}">
				<span class="icon_status statusColor-red"></span>
			</c:when>
  		</c:choose>
  			<c:if test="${param.OWNER_NAME_3 ne null && param.OWNER_NAME_3 != '' }">
					<span class="owner">[${param.OWNER_NAME_3}]</span>
				</c:if>
         <span class="subject">${param.CONTENTS_3}</span>
         <!-- <span class="term">(2016-07-18)</span> -->
     </div>
     
     <div class="step">
      <c:choose>
  			<c:when test="${param.CLOSE_DATE_2 ne null && param.CLOSE_DATE_2 != '' }">
				<span class="icon_status statusColor-green"></span>
			</c:when>
			<c:when test="${(param.DUE_DATE_2 ne null && param.DUE_DATE_2 != '') && param.DUE_DATE_2 >= currentDate }">
				<span class="icon_status statusColor-yellow"></span>
			</c:when>
			<c:when test="${(param.DUE_DATE_2 ne null && param.DUE_DATE_2 != '') && param.DUE_DATE_2 < currentDate}">
				<span class="icon_status statusColor-red"></span>
			</c:when>
  		</c:choose>
  			<c:if test="${param.OWNER_NAME_2 ne null && param.OWNER_NAME_2 != '' }">
					<span class="owner">[${param.OWNER_NAME_2}]</span>
				</c:if>
         <span class="subject">${param.CONTENTS_2}</span>
         <!-- <span class="term">(2016-07-18)</span> -->
     </div>
     
     <div class="step">
      <c:choose>
        <c:when test="${param.CLOSE_DATE_1 ne null && param.CLOSE_DATE_1 != '' }">
				<span class="icon_status statusColor-green"></span>
			</c:when>
			<c:when test="${(param.DUE_DATE_1 ne null && param.DUE_DATE_1 != '') && param.DUE_DATE_1 >= currentDate }">
				<span class="icon_status statusColor-yellow"></span>
			</c:when>
			<c:when test="${(param.DUE_DATE_1 ne null && param.DUE_DATE_1 != '') && param.DUE_DATE_1 < currentDate}">
				<span class="icon_status statusColor-red"></span>
			</c:when>
  		</c:choose>
  			<c:if test="${param.OWNER_NAME_1 ne null && param.OWNER_NAME_1 != '' }">
					<span class="owner">[${param.OWNER_NAME_1}]</span>
				</c:if>
         <span class="subject">${param.CONTENTS_1}</span>
         <!-- <span class="term">(2016-07-18)</span> -->
     </div>
     
 </div>
 <!--// 풍선말 팝업: milestones 상세내용 -->