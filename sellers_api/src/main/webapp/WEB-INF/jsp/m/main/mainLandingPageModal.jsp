<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<div class="modalpop_menuset off" id="modal">
    <div class="pop_header">        
        <h3 >바로가기 메뉴 설정</h3>
    </div>
    <div class="pop_cont">

        <div class="tabmenu_outline">

            <ul class="tabMenu_inner">
                <li>
                    <a href="#" class="title active">메뉴선택</a>
                    <div class="tab_cont">
                        <ol class="setmenulist mg_b10">
                        <!-- 메뉴선택 -->
                        </ol>
                        <div class="ment">
                            <span class="mg_r10">- <strong>6개</strong>까지 설정 가능합니다.</span>
                            <a href="#" class="btn_reset" onclick="modal.reset();">선택 초기화</a>
                        </div>
                    </div>
                </li>
                <li>
                    <a href="#" class="title">순서설정</a>
                    <div class="tab_cont" style="display:none;">
                        <!-- 순서설정 메뉴 리스트 : 최대 6개 -->
                        <ol class="setindexlist">
                        <!-- 순서설정 메뉴 리스트 -->
                        </ol>
                        <div class="ment">
                            <a href="#" class="btn_reset" onclick="modal.reset();">선택 초기화</a>
                        </div>

                    </div>
                </li>
            </ul>

        </div>
        
    </div>
    <div class="pop_footer">
        <a href="#" class="btn_modalpop_menuset_close">취소</a>
        <a href="#" class="btn_setsave" onclick="modal.submit();">설정 저장</a>        
    </div>

    <!-- <a href="#" class="btn_modalpop_menuset_close">설정창 닫기</a> -->
</div>

<script type="text/javascript">
//설정 초기 값
var beforeMenuValue;
var beforeMenuData;

//설정 변경 값
var userMenuValue;
var userMenuData;
var menuId;

$(document).ready(function(){
	/* modal.init(); */
	var filter = "win16|win32|win64|mac";
	if(navigator.platform){
		if(0 > filter.indexOf(navigator.platform.toLowerCase())){
			//최영완 - 안드로이드와 통신 (FirebaseDatabase에 유저 ID, Token 저장)
			window.Token.TokenPut("${userInfo.MEMBER_ID_NUM}");
		}
	}
});

//최영완 - Android에서 호출
function insertUserMobileToken(token){
	var params = $.param({
		datatype : 'json',
		userDi : token,
		member_id_num : "${userInfo.MEMBER_ID_NUM}"
	});
	//DB에 사용자 모바일 토큰값 저장
	$.ajax({
		url : "/main/insertUserMobileToken.do",
		async : false,
			datatype : 'json',
			method: 'POST',
			data : params,
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
		},
		success : function(data){
			//$('article.landing_quickmenu').before(data);
		},
		complete : function(){
		}
	});
}


var modal = {
		init : function(){
		},
		
		//설정 초기화
		reset : function() {
			userMenuData.length = 0;
			userMenuData = beforeMenuData.slice();
			userMenuValue = beforeMenuValue;
			
			modal.clearMenu();
			modal.setMenuTab();
		},
		
		//사용자설정에 맞게 모달창 설정
		set : function() {
			var menuListparams = $.param({
				datatype : 'json'
			});
			
			//첫번째 탭으로 초기화
			$('ul.tabMenu_inner>li a.title').removeClass('active');
			$('ul.tabMenu_inner>li .tab_cont').hide();
			$('ul.tabMenu_inner > li:nth-child(1) > a').addClass('active');
			$('ul.tabMenu_inner > li:nth-child(1) > div').show();
			
			//사용가능한 메뉴 리스트 조회
			$.ajax({
				url : "/main/selectMobileLandingPageMenuList.do",
				async : false,
	 			datatype : 'json',
	 			method: 'POST',
	 			data : menuListparams,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					//$.ajaxLoading();
				},
				success : function(data){
					//$('ol.setmenulist.mg_b10').html(data);
					
					//바로가기 메뉴 설정 팝업창 탭 html제거
					$('ol.setmenulist.mg_b10').html('');
					$("ol.setindexlist").html('');
					var list = data.list;
					for(var i=0; i<list.length; i++){
						//tab1 값 세팅
						$('ol.setmenulist.mg_b10').append(
							'<li>'+
								'<a href="#" class="" onclick="modal.activeMenu(this, 1);">'+list[i].MENU_TITLE+'</a>'+
								'<input type="hidden" name="hiddenModalSetMenuList" id="hiddenModalSetMenu'+list[i].MENU_ID+'" value="'+list[i].MENU_ID+'" />'+
							'</li>'
						);
					}
				},
				complete : function(){
				}
			});
			modal.reset();
			
			$('.modalpop_menuset').show();
			$('.modalpop_screen').show();
		},
		
		submit : function() {
			jQuery.ajaxSettings.traditional = true;
			$.ajax({
				url : "/main/insertUserMobileLandingPageMenu.do",
				async : false,
	 			datatype : 'json',
	 			method: 'POST',
	 			data : {
	 				datatype : 'json',
	 				length : userMenuValue,
					list : userMenuData
	 			},
				beforeSend : function(xhr){
					if(isEmpty(userMenuData)){
						alert('하나 이상의 메뉴를 선택 해 주세요!');
						return false;
					}
					xhr.setRequestHeader("AJAX", true);
					//$.ajaxLoading();
				},
				success : function(data){
					//성공후 서버에서 받은 데이터 처리
	                if(data.cnt > 0){
	                	selectUserMobileLandingPage();
						alert("저장하였습니다.");
						
						$('.modalpop_menuset').hide();
						$('.modalpop_screen').hide();
	                }
				},
				complete : function(){
				}
			});
		},
		
		//설정 메뉴 선택or해제
		activeMenu : function(obj, cnt) {
			if(cnt == 1){ //tab1 설정
				if($(obj).hasClass('active') === true){
					var idx = modal.findArray($(obj).next().val());
					modal.dltArray(idx);
				}else if(6 > userMenuValue){
					modal.sltArray($(obj).next().val());
				}
			}else{ //tab2 설정
				var idx = modal.findArray($(obj).parent().last().val());
				if($(obj).hasClass('btn_list_delete') === true){
					modal.dltArray(idx);
				}else if($(obj).hasClass('btn_move_up') === true){
					var idx = modal.findArray($(obj).parent().next().val());
					modal.chgArray(idx-1, idx);
				}else if($(obj).hasClass('btn_move_down') === true){
					var idx = modal.findArray($(obj).parent().next().val());
					modal.chgArray(idx, idx+1);
				}
			}
			
			modal.clearMenu();
			modal.setMenuTab();
		},
		
		//배열 순서 찾기
		findArray : function(val) {
			var idx = -1;
			
			for(var i=0; i<userMenuValue; i++){
				if(val == userMenuData[i]){
					idx = i;
					break;
				}
			}
			return idx;
		},
		
		//메뉴 선택 배열 처리
		sltArray : function(idx) {
			userMenuData.push(idx);
			userMenuValue = userMenuData.length;
		},
		
		//메뉴 해제 배열 처리
		dltArray : function(idx) {
			userMenuData.splice(idx, 1);
			userMenuValue = userMenuData.length;
		},
		
		//메뉴 순서변경 배열 처리
		chgArray : function(t_idx, b_idx) {
			if (b_idx >= userMenuData.length) {
		        var k = b_idx - userMenuData.length + 1;
		        while (k--) {
		        	userMenuData.push(undefined);
		        }
		    }
			userMenuData.splice(b_idx, 0, userMenuData.splice(t_idx, 1)[0]);
		    //return arr;
		},
		
		//배열 처리 후 설정 팝업 css변경
		//1. 메뉴선택탭 순서아이콘, active 클래스 제거, 순서정렬텝 html 초기화
		clearMenu : function() {
			$("ol.setmenulist.mg_b10").find('span').detach();
			$("ol.setmenulist.mg_b10").find('a').removeClass('active');
			$("ol.setindexlist").html('');
		},
		
		//배열 처리 후 설정 팝업 css변경
		//2. 팝업 설정 디자인 수정
		setMenuTab : function() { 
			for(var i=0; i<userMenuValue; i++){
				menuId = userMenuData[i];
				var obj = $("#hiddenModalSetMenu"+menuId).prev();
				//2-1. 배열 순서대로 메뉴선택 순서아이콘, active 클래스 추가
				$(obj).before('<span class="modalpop_menucount pos_h r10">'+(i+1)+'</span>'); //input 데이터 값 세팅, 번호순서
				$(obj).addClass('active');
				
				//2-2. 순서정렬탭 새로 그리기
				var appendHtml = "";
				appendHtml += '<li>';
				appendHtml += '	<div class="left">';
				appendHtml += '		<a href="#" class="btn_list_delete" onclick="modal.activeMenu(this, 2);">삭제</a>';
				appendHtml += '			<span class="title_txt">'+$(obj).html()+'</span>';
				appendHtml += '	</div>';
				appendHtml += '	<div class="right">';
				if(i > 0){
					appendHtml += '<a href="#" class="btn_move_up" onclick="modal.activeMenu(this, 2);">▲</a>';
				}else{
					appendHtml += '<a href="#" class="btn_move_up gray">▲</a>';
				}
				if(i < userMenuValue-1){
					appendHtml += '<a href="#" class="btn_move_down" onclick="modal.activeMenu(this, 2);">▼</a>';
				}else{
					appendHtml += '<a href="#" class="btn_move_down gray">▼</a>';
				}
				appendHtml += '	</div>';
				appendHtml += '	<input type="hidden" name="hiddenModalSetUserList" id="hiddenModalSetUserList'+menuId+'" value="'+menuId+'" />';
				appendHtml += '</li>';
				
				$("ol.setindexlist").append(appendHtml);
		    }
		}
}
</script>