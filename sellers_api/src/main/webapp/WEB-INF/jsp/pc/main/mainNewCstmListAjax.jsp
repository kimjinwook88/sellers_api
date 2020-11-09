<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
                                   
<c:forEach items="${CstRows}" var="CstRows">
<li>
	<a href="#" onclick="main.goCustomerList('${CstRows.CUSTOMER_NAME}',${CstRows.CUSTOMER_ID},${CstRows.COMPANY_ID})">
		<span class="name">${CstRows.CUSTOMER_NAME}</span>
		<small class="block text-muted">
		${CstRows.COMPANY_NAME} / ${CstRows.SYS_REGISTER_DATE}
       </small>
       </a>
</li>
</c:forEach>
