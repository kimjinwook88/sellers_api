<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="add_length" value="${6 - fn:length(list)}"/>
<ul class="quickmenu_display">
	<!-- <li>
        <a href="#">
            <span class="menu_icon menu_icon_custom"></span>
            <span class="menu_name">고객개인정보</span>
        </a>
    </li>
    <li>
        <a href="#">
            <span class="menu_icon menu_icon_company"></span>
            <span class="menu_name">고객사정보</span>
        </a>
    </li>
    <li>
        <a href="#">
            <span class="menu_icon menu_icon_contact"></span>
            <span class="menu_name">고객컨택내용</span>
        </a>
    </li>
    <li>
        <a href="#">
            <span class="menu_icon menu_icon_opp"></span>
            <span class="menu_name">영업기회</span>
        </a>
    </li>
    <li>
        <a href="#">
            <span class="menu_icon menu_icon_opphidden"></span>
            <span class="menu_name">잠재영업기회</span>
        </a>
    </li>
    <li>
        <a href="#">
            <span class="menu_icon menu_icon_rate"></span>
            <span class="menu_name">고객만족도</span>
        </a>
    </li>
    <li>
        <a href="#">
            <span class="menu_icon menu_icon_issue"></span>
            <span class="menu_name">고객이슈</span>
        </a>
    </li>
    <li>
        <a href="#">
            <span class="menu_icon menu_icon_cadence"></span>
            <span class="menu_name">파트너사 협업</span>
        </a>
    </li>
    <li>
        <a href="#">
            <span class="menu_icon menu_icon_partner"></span>
            <span class="menu_name">파트너사개인정보</span>
        </a>
    </li>
    <li>
        <a href="#">
            <span class="menu_icon menu_icon_company"></span>
            <span class="menu_name">파트너사정보</span>
        </a>
    </li>
    <li>
        <a href="#">
            <span class="menu_icon menu_icon_strategy"></span>
            <span class="menu_name">회사/부문별전략</span>
        </a>
    </li>
    <li>
        <a href="#">
            <span class="menu_icon menu_icon_strategy"></span>
            <span class="menu_name">고객별전략</span>
        </a>
    </li>
    <li>
        <a href="#">
            <span class="menu_icon menu_icon_strategy"></span>
            <span class="menu_name">전략프로젝트</span>
        </a>
    </li>            
    <li>
        <a href="#">
            <span class="menu_icon menu_icon_calendar"></span>
            <span class="menu_name">일정관리</span>
        </a>
    </li>
    <li>
        <a href="#">
            <span class="menu_icon menu_icon_mypage"></span>
            <span class="menu_name">마이페이지</span>
        </a>
    </li>
    <li class="blank">
        <a href="#">
            <span class="menu_icon_add"></span>
        </a>
    </li> -->
	<c:if test="${fn:length(list) > 0}">
		<c:forEach items="${list}" var="list">
			<li>
		        <a href="${list.MENU_URL}">
		        	<span class="${list.MENU_ICON}"></span>
		            <span class="menu_name">${list.MENU_TITLE}</span>
		        </a>
		    </li>
		</c:forEach>
	</c:if>
	<%-- <c:if test="${add_length > 0}">
		<c:forEach begin="1" end="${add_length}" step="1">
			<li class="blank">
		        <a href="#" onclick="modal.set();">
		            <span class="menu_icon_add"></span>
		        </a>
		    </li>
		</c:forEach>
	</c:if> --%>
</ul>

<script type="text/javascript">
$("ol.setindexlist").html("");
userMenuValue = "${fn:length(list)}";
userMenuData = new Array();
beforeMenuValue = "${fn:length(list)}";
beforeMenuData = new Array();

<c:if test="${fn:length(list) > 0}">
	<c:forEach items="${list}" var="list" varStatus="status">
	
	//사용자 메뉴 리스트 배열 세팅
	menuId = "${list.MENU_ID}";
	userMenuData.push(menuId); 
	beforeMenuData.push(menuId); 
	
	$("ol.setindexlist").append(
		'<li>' +
			'<div class="left">' +
				'<a href="#" class="btn_list_delete" onclick="modal.activeMenu(this, 2);">삭제</a>' +
				'<span class="title_txt">${list.MENU_TITLE}</span>' +
		    '</div>' +
		    '<div class="right">' +
	    	<c:choose>
	    		<c:when test="${!status.first}">
	    		'<a href="#" class="btn_move_up" onclick="modal.activeMenu(this, 2);">▲</a>' +
	    		</c:when>
	    		<c:otherwise>
	    		'<a href="#" class="btn_move_up gray">▲</a>' +
	    		</c:otherwise>
	    	</c:choose>
		    	
	    	<c:choose>
	    		<c:when test="${!status.last}">
	    		'<a href="#" class="btn_move_down" onclick="modal.activeMenu(this, 2);">▼</a>' +
	    		</c:when>
	    		<c:otherwise>
	    		'<a href="#" class="btn_move_down gray">▼</a>' +
	    		</c:otherwise>
	    	</c:choose>
		    '</div>' +
		    '<input type="hidden" name="hiddenModalSetUserList" id="hiddenModalSetUserList${list.MENU_ID}" value="${list.MENU_ID}" />' +
		'</li>'
	);
	</c:forEach>
</c:if>
</script>