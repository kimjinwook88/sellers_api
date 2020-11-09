<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<ul class="gnb">
	<c:if test="${fn:length(list) > 0}">
		<c:forEach items="${list}" var="list_1">
			 <c:if test="${list_1.MENU_LEVEL == 1}">
			 	<li>
			 		<!-- 메인메뉴 출력 -->
	    		<c:choose>
		    		<c:when test="${list_1.MOBILE_URL eq null}">
	    				<a href="#" class="btn_one" menu-id="${list_1.MENU_ID}" menu-url="${list_1.MOBILE_URL}" >
				        <span class="${list_1.MOBILE_ICON}"></span> 
				        	${list_1.MENU_TITLE} 
				        <img src="${pageContext.request.contextPath}/images/m/icon_gnb_arrow_left.svg"/> 
				        <img src="${pageContext.request.contextPath}/images/m/icon_gnb_arrow_down.svg" class="off"/>
			        </a>
		    		</c:when>
		    		<c:otherwise>
		    			<a href="${list_1.MOBILE_URL}" class="" menu-id="${list_1.MENU_ID}" menu-url="${list_1.MOBILE_URL}">
		    				<span class="${list_1.MOBILE_ICON}"></span> 
		    				${list_1.MENU_TITLE} 
	    				</a>
		    		</c:otherwise>
	    		</c:choose>    
	    		
	    		<!-- 서브메뉴 출력 -->
	        <c:if test="${list_1.CHILDREN_COUNT > 0}">
	        	<div class="sub off">
		        	<c:forEach items="${list}" var="list_2">
			        	<c:if test="${list_1.MENU_ID == list_2.MENU_PARENT}">
			        		<!-- 이름이 긴 메뉴명 변경 -->
			        		<c:choose>
				        		<c:when test="${fn:contains(list_2.MENU_TITLE, '<br>')}">
				        			<c:set var="longTitle" value="${fn:split(list_2.MENU_TITLE,'<br>')[0]}" />
				        			<a href="${list_2.MOBILE_URL}" menu-id="${list_2.MENU_ID}" menu-url="${list_2.MOBILE_URL}" menu-parent="${list_2.MENU_PARENT}">${longTitle}</a>
				        		</c:when>
				        		<c:otherwise>
				        			<a href="${list_2.MOBILE_URL}" menu-id="${list_2.MENU_ID}" menu-url="${list_2.MOBILE_URL}" menu-parent="${list_2.MENU_PARENT}">${list_2.MENU_TITLE}</a>
				        		</c:otherwise>
			        		</c:choose>
			        	</c:if>	        
			        </c:forEach>
	        	</div>
	        </c:if>	
			 	</li>
			 </c:if>
		</c:forEach>
	</c:if>
	<li class="func_menu">
		<a href="/logout" id="logout_butn" onclick="logout();"><span class="icon md icon_key va_m"></span>  로그아웃</a>
	</li>
	<li class="func_menu">
		<a href="/common/changePW.do" class=""><span class="icon md icon_setting va_m"></span> 비밀번호변경</a>
	</li>
</ul>

<script>

$('.btn_one').click(function(){
	$(this).next().toggle();
	$(this).find('img').toggle();
	return false;
});

//김동용
function logout(logout){
   var logout = document.getElementById('logout_butn').value = 'logout';
   Android.logout(logout);
}

</script>