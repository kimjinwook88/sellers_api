<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<body>
		<table style="border : solid 1px black;">
			<tr>
				<td>No</td>
				<td>내용</td>
				<td>알림일</td>
			</tr>
			<c:choose>
				<c:when test="${fn:length(selectNoticeDetail) > 0}">
					<c:forEach items="${selectNoticeDetail}" var="row">
						<tr>
							<td>${row.ROWNUM}</td>
							<td>${row.NOTICE_DETAIL}</td>
							<td>${row.NOTICE_SEND_DATE}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="3">조회된 결과가 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
	</body>
</html>

<script src="<%=request.getContextPath()%>/js/jQuery/jquery-1.11.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(opener.document).find("span.label.label-primary").remove();
});
</script>