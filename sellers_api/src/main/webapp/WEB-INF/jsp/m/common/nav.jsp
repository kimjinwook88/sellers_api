<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">

// 사업전략 디테일페이지 분기
var searchCategory = '${param.searchCategory}';

var nav = {
	menuId : '' // 메뉴 아이디
}

	function setTitle(){		
		var menuEl = $('*[menu-id="'+nav.menuId+'"]');
		
		if(menuEl.length < 1){
			return;
		}
		
		var menuTitle = menuEl.text();
		$('title').html(menuTitle);
		
		if(!searchCategory){
			return;
		}
	}
	
	function setNav(){		
		var menuEl = $('*[menu-id="'+nav.menuId+'"]');
		
		if(menuEl.length < 1){
			return;
		}
		
		var menuTitle = menuEl.text();
		
		// 상위 메뉴
		var parentMenu = menuEl.attr('menu-parent');
		var parentMenuEl = $('*[menu-id="'+parentMenu+'"]');
		var parentMenuTitle = parentMenuEl.text();
		$('.breadcrumb_depth1 .active_menu').append(parentMenuTitle);
		
		// 하위 메뉴 리스트
		var parentEl = menuEl.parent();
		var allMenuEl = parentEl.children();
		
		var size = allMenuEl.length;
		
		for(var i=0; i<size; i++){
			
			var selectedId = $(allMenuEl[i]).attr('menu-id');
			var selected = $(allMenuEl[i]).attr('menu-url');
			var selectedArray = selected.split('/');
			var selectedName = selectedArray[selectedArray.length - 1];
			var selectedUrlSplit = selectedName.split('.');
			var selectedUrl = selectedUrlSplit[0];
			var selectedTitle = $(allMenuEl[i]).text();
			
			$("#nav").append(
					"<li id='select_" + selectedUrl + "' class='menu_select select2' value='" + selected + "'><a href='"+ selected + "'>"
							+ selectedTitle + "</a></li>");
			
			// selected 설정
			if (nav.menuId == selectedId) {
				$("#navLink").append(
						"<a id='select_" + selectedUrl + "' value='" + selected + "'>"
								+ selectedTitle
								+ "</a>");
			}
		}		
	}

	function getMenuId(){				
		var self = this;
		
		$.ajax({
			 url : '/common/selectMenuSub.do',
			 async : false,
			 datatype : 'json',
			 method: 'post',
			 data : {
				 currentUrl : self.location.pathname
			 },
			 success : function(data){
				 var menuInfo = data.menuInfo;
				 
				 nav.menuId = menuInfo[0].MENU_ID;
				 				 
				 // 임시
				 if(searchCategory == '고객전략'){
					 nav.menuId = 10000026;
				 }else if(searchCategory == '회사전략'){
					 nav.menuId = 10000025;
				 }
				 
				 setTitle();
				 setNav();
			},
			complete : function(){
			}
		});
	}	

	//토글함수
	function openNav() {
		/*
		if($('#nav').is(":hidden")){
			alert("잠김");
			$('#nav').show();
			//$('#nav').show();
			//$('#nav').css("display", "block");
		}
		 */

		$('.dropdown-menu').hide();
		$('#nav').toggle();
		return false;
	}

	$(document).ready(function() {
		getMenuId();
	});
</script>
<div class="breadcrumb">
		<a href="#" class="home">&nbsp;<img src="../../../images/m/icon_home.svg" /></a>
		<div class="breadcrumb_depth1">
			<a class="active_menu">&nbsp;</a>
		</div>
		<div id="test1"></div>
		<div class="breadcrumb_depth2">
			<a href="javascript:void(0);" class="active_menu" onclick="openNav();">&nbsp;<span id="navLink"></span></a>
			<ol class="menu_select select2 dropdown-select2" id="nav" style="display: none;">
			</ol>
		</div>
	</div>
