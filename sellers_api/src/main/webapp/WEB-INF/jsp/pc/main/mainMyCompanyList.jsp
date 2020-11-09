<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="ibox float-e-margins">
	<div class="ibox-title">
	    <h5>나의 관리고객 <small>( 총 ${count}개사 )</small></h5>                                
	</div>
	<div class="ibox-content pd-no">
         <div class="module_height_base custom_list">
             <ul>
				<c:choose>
	 		  		<c:when test="${fn:length(list) > 0}">
		                 <c:forEach items="${list}" var="list">
				            <li>
				                <a href="javascript:void(0);" onClick="main.goCompanyList(${list.COMPANY_ID},'${list.COMPANY_NAME}');">${list.COMPANY_NAME}</a>
				            </li>
						</c:forEach>
			  		</c:when>
			  		<c:otherwise>
			  			<li style="border:none; text-align: center; padding-top:10px;">고객리스트가 없습니다.</li>
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

<h4>고객 리스트 <small>( 총 ${count}개사 )</small></h4>

<c:choose>
	<c:when test="${fn:length(list) > 0}">
		<div class="custom_list full-height-scroll">
		 <ul>
		<c:forEach items="${list}" var="list">
            <li>
                <a href="javascript:void(0);" onClick="main.goCompanyList(${list.COMPANY_ID},'${list.COMPANY_NAME}');">${list.COMPANY_NAME}</a>
            </li>
		</c:forEach>
		 </ul>
	    </div>
	</c:when>
	<c:otherwise>
	<div class="custom_list" style="text-align: center;padding-top: 10px;">
		고객리스트가 없습니다.
	</div>
	</c:otherwise>
</c:choose>

    
 --%>