<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% 
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>
<meta http-equiv="Cache-Control" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>
<meta http-equiv="Pragma" content="no-cache"/>
<script type="text/javascript">
//리스트 총 갯수
page.totalCount = "${listCount}";

var leftList = {
		active : function(at) {
			$('li.list-group-item').removeClass("active");
			$(at).addClass("active");
		}
}

<c:choose>
<c:when test="${fn:length(rows) > 0}">
	<c:forEach items="${rows}" var="rows" varStatus="status">
		<c:choose>
			<c:when test="${status.count == 1}">
				 clientList.goDetail(${rows.PARTNER_ID}, '${rows.COMPANY_NAME}');
			</c:when>
		</c:choose>
	</c:forEach>
</c:when>
</c:choose>

</script>

<!-- 
	데이터 맞춰주세요~
-->
<c:choose>
<c:when test="${fn:length(rows) > 0}">
	<c:forEach items="${rows}" var="rows" varStatus="status">
		<c:choose>
			<c:when test="${status.count > 1}">
				 <li class="list-group-item" onclick="leftList.active(this); clientList.goDetail(${rows.PARTNER_ID}, '${rows.COMPANY_NAME}')" style="cursor: pointer;">
			</c:when>
			<c:otherwise>
				<li class="list-group-item active" onclick="leftList.active(this); clientList.goDetail(${rows.PARTNER_ID}, '${rows.COMPANY_NAME}')" style="cursor: pointer;">
			</c:otherwise>
		</c:choose>
					<a href="javascript:void(0);" data-toggle="tab">
					
						<strong class="custom-name">${rows.COMPANY_NAME}</strong><br/>
	        			<small class="text-muted">ID : ${rows.PARTNER_ID}</small>
					
					</a>
				</li>
	</c:forEach>
</c:when>
<c:otherwise>
				<!-- 데이터 없을경우 -->
				<li class="list-group-item">현재 등록된 정보가 없습니다.</li>
</c:otherwise>
</c:choose>