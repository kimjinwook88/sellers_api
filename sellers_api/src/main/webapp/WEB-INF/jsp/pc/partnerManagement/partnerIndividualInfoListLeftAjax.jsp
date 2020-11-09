<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
				 clientList.goDetail(${rows.PARTNER_INDIVIDUAL_ID});
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
				 <li class="list-group-item" onclick="leftList.active(this); clientList.goDetail(${rows.PARTNER_INDIVIDUAL_ID})" style="cursor: pointer;">
			</c:when>
			<c:otherwise>
				<li class="list-group-item active" onclick="leftList.active(this); clientList.goDetail(${rows.PARTNER_INDIVIDUAL_ID})" style="cursor: pointer;">
			</c:otherwise>
		</c:choose>
					<a href="javascript:void(0);" data-toggle="tab">
						<strong class="custom-name">${rows.PARTNER_PERSONAL_NAME}</strong> <span class="custom-level">${rows.POSITION}</span> <c:if test="${rows.USE_YN ne 'Y'}"><span style="color: #8C8C8C;">(퇴사자)</span></c:if>
					<div class="small m-t-xs">
						${rows.COMPANY_NAME} / ${rows.TEAM}
					</div>
					<small class="text-muted">ID : ${rows.PARTNER_INDIVIDUAL_ID}</small>
					</a>
				</li>
	</c:forEach>
</c:when>
<c:otherwise>
				<!-- 데이터 없을경우 -->
				<li class="list-group-item">현재 등록된 정보가 없습니다.</li>
</c:otherwise>
</c:choose>