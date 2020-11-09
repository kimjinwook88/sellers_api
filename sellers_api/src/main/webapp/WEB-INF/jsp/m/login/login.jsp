<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>

<%
Authentication auth = (Authentication)request.getUserPrincipal();

if(auth == null){
     
}else{
    //로그인한 상태라면 권한별 페이지 이동
    //String principal = auth.getAuthorities().toString();
    //response.sendRedirect(request.getContextPath() + "/salesActive/listClientContact.do");
}
%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
<title>THE Seller's</title>
<link href="${pageContext.request.contextPath}/css/m/style.css" rel="stylesheet" type="text/css">
</head>

<body class="primary_bg">

<div class="login_container">

    <header class="login ta_c">
        <hgroup>
            <h1 class="logo">THE Seller's</h1>
            <div class="slogan fc_white fs12">셀러들을 위한 소프트웨어입니다.</div>
        </hgroup>
    </header>

    <form id="formLogin" name="formLogin"  method="post"  action="/login"> 
        <article class="login_input ta_c">
            <form class="m-t" role="form" action="">
            		<!-- <input type="text"     class="form-control" placeholder="회사코드" class="mg_b10" name="company_cd" id="company_cd" value="" /> -->
                <input type="text"     class="form-control" placeholder="아이디" class="mg_b10" name="member_id_num" id="member_id_num" value="" />
                <input type="password" class="form-control" placeholder="비밀번호" name="password_enc" id="password_enc" />
                <div class="pd_t20 pd_b20 ta_c fc_white">
                    <%-- <a href="#" class="btn_check">
                        <img src="${pageContext.request.contextPath}/images/m/icon_check_outline.svg" id="chk_off" />
                        <img src="${pageContext.request.contextPath}/images/m/icon_check_white.svg" id="chk_on" style="display:none;" />
                    </a> --%>
                    
				<%-- <label class="btn_check">
					<img src="${pageContext.request.contextPath}/images/m/icon_check_outline.svg" id="chk_off" />
	                <img src="${pageContext.request.contextPath}/images/m/icon_check_white.svg" id="chk_on" style="display:none;" />
					<input type="checkbox" id="idSaveCheck" name="idSaveCheck" style="display: none;"/> <span>아이디 저장</span>
				</label> --%>
					<!-- 아이디 -->
                    
                </div>
                
                
                <div class="ta_c mg_b10">
                    <button type="submit" id="login_btn" class="btn_login r5" onclick="mobile();">로그인</button>
                </div>
                <!-- 
                <a href="findId.do" class="fc_white">아이디/</a><a href="findPw.do" class="fc_white">비밀번호 찾기</a>
                 -->
            </form>
        </article>   
    </form>

  <!--   <footer class="fc_white ta_c">
        <div class="mg_b10">© Seller's.</div>
    </footer> -->
    
</div>


<div class="modal_screen"></div>


<script type="text/javascript" src="${pageContext.request.contextPath}/js/m/jquery-1.11.0.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/m/common.js?v=1"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
<script type="text/javascript">

	
	
/* 	var login_check = 1;
	var userInputId = getCookie("userid");
	
	//저장된 쿠키가 존재 할 경우에 아이디 입력란에 아이디 생성
	if(getCookie("userid") != null){
		$("input[name='member_id_num']").val(getCookie("userid"));
	}
	
	//아이디 입력란에 아이디가 존재 시 체크박스 활성
	if($('input[name=member_id_num]').val() != ""){
		$('input:checkbox[id=idSaveCheck]').prop('checked', true) ;
		$('#chk_off').css('display', 'none');
		$('#chk_on').css('display', 'inline');
	}else{
		$('#chk_off').css('display', 'inline');
		$('#chk_on').css('display', 'none');
	}
	
	//validation
	function validation(){
		
		var result = true; */
		
		/* if(!$('#company_cd').val()){
			alert('회사코드를 입력하세요.');			//원래 주석처리 되어있었음.
			result = false;
		}else */
		
/* 		 if(!$('#member_id_num').val()){
			alert('아이디를 입력하세요.');
			result = false;
		}else if(!$('#password_enc').val()){
			alert('비밀번호를 입력하세요.');
			result = false;
		}
		
		return result;
	}
	
	//로그인을 하는 경우에 쿠키를 저장
	function mobile(){
		if($("#idSaveCheck").is(":checked") && getCookie("userid") != null){
			setCookie("userid", $("input[name='member_id_num']").val(), 7);
		}else{
			setCookie("userid", $("input[name='member_id_num']").val(), -1);
			//alert("저장한 아이디" + getCookie("userid"));
		}
	}
	//쿠키저장
	function setCookie(cName, cValue, cDay){
	    var expire = new Date();
	    expire.setDate(expire.getDate() + cDay);
	    cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
	    if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
	    document.cookie = cookies;
	}
	//쿠키삭제
	function deleteCookie(cookieName){
	    var expireDate = new Date();
	    expireDate.setDate(expireDate.getDate() - 1);
	    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}
	//쿠키로드
	function getCookie(key){
		var cook = document.cookie + ";";
		var idx =  cook.indexOf(key, 0);
		var val = "";
	 
		if(idx != -1){
			cook = cook.substring(idx, cook.length);
			begin = cook.indexOf("=", 0) + 1;
			end = cook.indexOf(";", begin);
			val = unescape( cook.substring(begin, end) );
		}
	
		return val;
	} 
	
	//체크박스 선택 시 이미지 변화
	$(document).ready(function(){
		$("#idSaveCheck").change(function(){ // 체크박스에 변화가 있다면,
	        if($("#idSaveCheck").is(":checked")){ // ID 저장하기 체크했을 때,
	        	$('#chk_on').css('display', 'inline');
	    		$('#chk_off').css('display', 'none');
	        }else{ // ID 저장하기 체크 해제 시,
	        	$('#chk_off').css('display', 'inline');
				$('#chk_on').css('display', 'none');
	        }
	    });
		
		// 로그인 버튼 클릭시
		$('#formLogin').submit(function () {
			if(!validation()){
				return false;
			}
			mobile();
		});
	}); */
	
	
	  function mobile(id,pw){
		   var id = document.getElementById('member_id_num').value;
		   var pw = document.getElementById('password_enc').value;
		   
		   Android.showToast(id,pw);
		}
		
		/*  function fnSettingCc(cc){
		  	document.getElementById('company_cd').value = cc;
		 } */
	  
		function fnSettingMemberId(memberIdNum){
	   		 document.getElementById('member_id_num').value = memberIdNum;
	    }

		function fnSettingPass(pass){
	    	document.getElementById('password_enc').value = pass;
	   }
		
		function click(){
		   login_btn.click();
		}
</script>

</body>
</html>