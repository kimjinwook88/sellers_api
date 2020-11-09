<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<nav class="navbar-default navbar-static-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav metismenu" id="side-menu">
                <li class="nav-header ta-c">
                    <div class="dropdown profile-element">
                        <div class="site-logo"><a href="/main/index.do"><img src="<%=request.getContextPath() %>/img/pc/logo/logo.png" alt=""/></a></div>
                        <%-- <span><img alt="image" class="img-circle" src="<%=request.getContextPath() %>/img/unipoint/profile_small/${userInfo.PROFILE_PHOTO}.jpg" /></span> --%>
                        <a href="#">
                            <span class="clear"> <span class="block m-t-xs"> <strong class="font-bold">${userInfo.HAN_NAME}님, 반갑습니다.</strong></span> </span>
                        </a>
                    </div>
                    <div class="logo-element"><!-- 왼쪽영역이 좁혀졌을 때 보여지는 로고 영역 -->
                    </div>
                </li>
                
                <li class=""><!-- <li class="special_link"> -->
                    <a href="#" onclick="return false;" target="_blank"><i class="fa fa-database"></i> <span class="nav-label">seller's Plaza Site</span></a>
                </li>
            </ul>
            <div class="product-logo text-center">
                <img src="<%=request.getContextPath() %>/images/pc/logo.png" alt=""/>
                <span>Copyright Seller’s Company © 2016</span>
            </div>
        </div>
        
        <!-- 메인 메뉴 -->
	    <jsp:include page="/WEB-INF/jsp/pc/main/mainMenuSetup.jsp"/>
</nav>

<script type="text/javascript">
var authArr = '${auth}';

$(document).ready(function(){
	//메뉴 select
	$.ajax({
		url : '/main/selectMemberMenu.do',
		async : false,
		datatype : 'json',
		method: 'POST',
		data : {
			datatype : 'json',
			use_yn : "Y"
		},
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
		},
		success : function(data){
			
			var adminFlag = false;
			
			if(authArr.indexOf('ROLE_ADMIN') != -1){
				adminFlag = true;
			}
			
			//메뉴 level1, level2 구분해서 메뉴 뿌리기
			if(!isEmpty(data.rows)){
				var list = data.rows;
				var menuHtml = "";
				for(var i=0; i<list.length; i++){
					if(list[i].MENU_LEVEL == 1){
						
						//관리자 페이지 admin 권한이 있는 사용자만 노출
						if(list[i].MENU_TITLE == "관리자페이지"){
								if(adminFlag){
									menuHtml += '<li>';
									menuHtml += "<a href=\""+list[i].MENU_URL+"\" onClick=\"movePage('',"+list[i].MENU_ID+');" menu-id="'+list[i].MENU_ID+'" menu-title="'+list[i].MENU_TITLE+'" target="'+list[i].MENU_ID+'"><i class="fa '+list[i].MENU_ICON+'"></i> <span class="nav-label">'+list[i].MENU_TITLE+'</span> <span class="fa arrow"></span></a>';
									menuHtml += '<ul class="nav nav-second-level collapse">';
									for(var j=0; j<list.length; j++){
										if(list[i].MENU_ID == list[j].MENU_PARENT){
											menuHtml += "<li><a href=\""+list[j].MENU_URL+"\" onClick=\"movePage('',"+list[j].MENU_ID+",'"+list[j].MENU_TITLE+"','"+list[i].MENU_TITLE+"');"+'" menu-id="'+list[j].MENU_ID+'" menu-title="'+list[j].MENU_TITLE+'" menu-parent="'+list[i].MENU_TITLE+'" target="'+list[j].MENU_ID+'">'+list[j].MENU_TITLE+'</a></li>';
										}
									}
									menuHtml += '</ul>';
									menuHtml += '</li>';			
								}
						}else{
							menuHtml += '<li>';
							menuHtml += "<a href=\""+list[i].MENU_URL+"\" onClick=\"movePage('',"+list[i].MENU_ID+",'"+list[i].MENU_TITLE+"');"+'" menu-id="'+list[i].MENU_ID+'" target="'+list[i].MENU_ID+'" menu-title="'+list[i].MENU_TITLE+'"><i class="fa '+list[i].MENU_ICON+'"></i> <span class="nav-label">'+list[i].MENU_TITLE+'</span> <span class="fa arrow"></span></a>';
							menuHtml += '<ul class="nav nav-second-level collapse">';
							if(list[i].MENU_TITLE == "설정"){
								menuHtml += "<li><a href=\"#\" onClick=\"openMainMenuSetup();\" data-toggle=\"modal\" data-target=\"#mainMenuSetup\">메뉴설정</a></li>";
							}
							for(var j=0; j<list.length; j++){
								if(list[i].MENU_ID == list[j].MENU_PARENT){
									
									var menuTitle = list[j].MENU_TITLE
									
									// 파트너사협업관리<br>(발굴,교육,협업) 때문에
									if((list[j].MENU_TITLE).indexOf('<br>') != -1){
										menuTitle = (list[j].MENU_TITLE).replace('<br>', ' ');
									}
									
									if(authArr.indexOf('ROLE_DIVISION') != -1){
										menuHtml += "<li><a href=\""+list[j].MENU_URL+"\"  onClick=\"movePage('',"+list[j].MENU_ID+",'"+menuTitle+"','"+list[i].MENU_TITLE+"');"+'" menu-id="'+list[j].MENU_ID+'" menu-title="'+menuTitle+'" menu-parent="'+list[i].MENU_TITLE+'" target="'+list[j].MENU_ID+'">'+list[j].MENU_TITLE+'</a></li>';
									}else{
										if(menuTitle != '트래킹설정'){
											menuHtml += "<li><a href=\""+list[j].MENU_URL+"\"  onClick=\"movePage('',"+list[j].MENU_ID+",'"+menuTitle+"','"+list[i].MENU_TITLE+"');"+'" menu-id="'+list[j].MENU_ID+'" menu-title="'+menuTitle+'" menu-parent="'+list[i].MENU_TITLE+'" target="'+list[j].MENU_ID+'">'+list[j].MENU_TITLE+'</a></li>';
										}
									}
								}
							}
							menuHtml += '</ul>';
							menuHtml += '</li>';
						}
						
					}
				}
				
				$('li.nav-header').after(menuHtml);
			}
			//하위 메뉴가 없는것 < 삭제
			$('ul.nav-second-level').each(function(){
				if($(this).find('li').length == 0){
					$(this).prev().find('span.fa.arrow').remove();
				}
			});
			
			// 메뉴 활성화 함수 호출
			setActiveMenu();
		},
		complete : function(){
		}
	});
	
	
	//메뉴 외 영역 클릭 시 menu 닫힘
	/* $(document).on('click',function(e){
		if(!$(e.target).hasClass("navbar-static-side") && !$(e.target).hasClass("navbar-minimalize") && !$(e.target).hasClass("minimalize-styl-2")) {
			 $("body").addClass("mini-navbar");
		} 
	}); */
	
});

// 메뉴 활성화
function setActiveMenu(){
	
	$('.metismenu li').removeClass('active');
	
	//쿠키값으로 클릭 메뉴 활성화 (메인 페이지 제외)
	var url = $(location).attr('pathname');
	if(url.indexOf("main/index.do") == -1){
		$('*[menu-id="'+getCookie('clickMenu')+'"]').parents('li').addClass('active');
	}
	
	// 활성화된 메뉴
	var activeMenu = $('#side-menu > li.active > ul > li.active > a');
	
	// 일정관리, 생산성, 고객컨택내용은 레벨 1 단계 메뉴
	if(url.indexOf('/calendar/viewCalendar.do') != -1 || url.indexOf('/salesManagement/viewProductivity.do') != -1 || url.indexOf('/clientSalesActive/viewClientContactDashboard.do') != -1){
		activeMenu = $('#side-menu > li.active > a');
	}
	
	// 활성화되어 있는 메뉴가 없을 때
	if(!activeMenu.length){
		if(url.indexOf("main/index.do") == -1){
			$('*[menu-id="'+sessionStorage.getItem('activeId')+'"]').parents('li').addClass('active');
		}
		menuCookieSet(sessionStorage.getItem('activeTitle'));
		return;
	}
	
	// 세션 스토리지에 저장
	sessionStorage.setItem('activeId', activeMenu.attr('menu-id'));
	sessionStorage.setItem('activeTitle', activeMenu.attr('menu-title'));
	sessionStorage.setItem('activeParent', activeMenu.attr('menu-parent'));
}

//쿠키만 생성~
function _menuCookieSet(menu_id, menu_title, menu_parent){
	setCookie('clickMenu', '', -1); //쿠키 삭제
	setCookie('clickMenu',menu_id,1); //쿠키 생성
	setCookie('clickMenuTitle', '', -1); //쿠키 삭제
	setCookie('clickMenuTitle',menu_title,1); //쿠키 생성
	setCookie('clickMenuParent', '', -1); //쿠키 삭제
	setCookie('clickMenuParent',menu_parent,1); //쿠키 생성
}

function menuCookieSet(menuTitle){
	var mn = $('#side-menu .nav-second-level a[menu-title='+menuTitle+']');
	// 하위 메뉴에서 찾지 못했을 때
	if(mn.length < 1){
		mn = $('#side-menu a:contains("'+menuTitle+'")');
	}
	_menuCookieSet(mn.attr('menu-id'), mn.attr('menu-title'), mn.attr('menu-parent')); //메뉴 활성화
}

//쿠키생성 후 페이지 이동 (메뉴 활성화를 쿠키 사용)
function movePage(url, menu_id, menu_title, menu_parent){

	_menuCookieSet(menu_id, menu_title, menu_parent);
	
	//현재창에서 페이지 이동
	//location.href = url;
	
	//새창에서 페이지 이동
	/* if(url != '#' && url != null && url != ''){
		window.open(url,menu_id);
		return false;
	} */
	
	//일정관리 페이지이동
	if(menu_id == 10000030) window.open('/calendar/viewCalendar.do',menu_id);
	if(menu_id == 10000022) window.open('/salesManagement/viewProductivity.do',menu_id);
	if(menu_id == 10000009) window.open('/clientSalesActive/viewClientContactDashboard.do',menu_id);
	
}

//새로고침 시 확인 값
var menuValue = {
		isCtrl : false, //컨트롤키 체크
		activeId : null //최초 활성화된 메뉴 id
}

$(document).keyup(function (key) { 
    if(key.keyCode == 17) menuValue.isCtrl=false;  
});
//새로 고침시 현재 페이지 메뉴id 쿠키에 담아줌
$(document).keydown(function (key) {
	if(key.keyCode == 17) menuValue.isCtrl=true; 
	if(key.keyCode == 116 || (menuValue.isCtrl == true && key.keyCode == 82)){ //키가 116이면 실행 (F5는 116) or Ctrl + R (Ctrl은 17, R은 82)
		menuCookieSet(sessionStorage.getItem('activeTitle'));
     }
});

//새로 고침시 현재 페이지 메뉴id 쿠키에 담아줌
window.onbeforeunload = function() {
	var activeMenu = $('#side-menu > li.active > ul > li.active > a');
	if(activeMenu.attr('menu-title')){
		menuCookieSet(activeMenu.attr('menu-title'));
	}
};
</script>