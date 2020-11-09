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

	<form id="formLogin" name="formLogin"  method="post" action="http://thesellers.unipoint.co.kr:30200/api/key" >
		<article class="login_input ta_c">
			<form class="m-t" role="form" action="">
				<input type="text"     class="form-control" placeholder="회사코드" class="mg_b10" name="companyCode" id="companyCode" value="" />
				<input type="text"     class="form-control" placeholder="아이디" class="mg_b10" name="userId" id="userId" value="" />
				<input type="password" class="form-control" placeholder="비밀번호" name="userPw" id="userPw" />
				<input type="hidden" class="form-control" name="userDi" id="userDi" value="${param.device_token}" />
				<input type="hidden" class="form-control" name="pushUrl" id="pushUrl" value="" />
				<input type="hidden" class="form-control" name="autoLogin" id="autoLogin" value="" />
				<input type="hidden" class="form-control" name="logout" id="logout" value="${param.logout}" />
				<br><br>
				<div class="save_check_area">
					<label class="">
						<a class="btn_check" id="checkActiveId">
							<img src="" id="chk_off" />
							<img src="${pageContext.request.contextPath}/images/m/icon_check.svg" id="chk_on" style="display:none;" />
							<input type="checkbox" id="idSaveCheck" name="idSaveCheck" style="display: none;"/> <span>아이디 저장</span>
						</a>
						
					</label>
					
					<label class=" ">
						<a class="btn_check" id="checkActiveLogin">
							<img src="" id="auto_chk_off" />
							<img src="${pageContext.request.contextPath}/images/m/icon_check.svg" id="auto_chk_on" style="display:none;" />
							<input type="checkbox" id="autoLoginCheck" name="autoLoginCheck" style="display: none;"/><span>자동로그인</span>
						</a>
					</label>
				</div>
				<br><br>
				
				<div class="ta_c mg_b10">
					<button type="button" class="btn_login r5" id="loginCheck" >로그인</button>
				</div>
				<!-- 
				<a href="findId.do" class="fc_white">아이디/</a><a href="findPw.do" class="fc_white">비밀번호 찾기</a>
				-->
			</form>
		</article>
	</form>
	
	<footer class="fc_white ta_c">
		<div class="mg_b10">Copyright (c) 2016, THE Seller's</div>
	</footer>
	
</div>


<div class="modal_screen"></div>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/m/jquery-1.11.0.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/m/common.js?v=1"></script>


<script type="text/javascript">


	
	$(document).ready(function(){
		
		/*
			obj.companyCode = $("#companyCode").val();
			obj.userId = $("#userId").val();
			obj.userPw = pwSecurity;
			obj.userDi = $("#userDi").val();	
			obj.pushUrl = $("#pushUrl").val();
			obj.autoLogin = $("#autoLogin").val();
		*/
		
		//alert("push_url = " + getCookie("push_url"));
		
		/*
			alert(
				"companyCode = " + getCookie("autoLogin_companyCode") + 
				" / id = " + getCookie("autoLogin_Id") +
				" / pw = " + getCookie("autoLogin_Pw") + 
				" / autoLoginValue = " + getCookie("autoLoginValue")
			);
		*/
		
		
		//alert( "저장된 오토로그인 쿠키 " + getCookie("autoLoginValue"));
		//alert("로그아웃 받은 값" + $("#logout").val());
		
		/*
			var login;
			login = '${param.login}'; 
		*/
		
		var logout;
		logout = $("#logout").val();
		
		if(logout == null || logout == ''){
			logout = '0';
		}
		var saveIdValue;
		saveIdValue = getCookie("saveIdValue");
		
		var autoLogin_cookie = getCookie("autoLoginValue");
		
		
		// 로그아웃이 아닌 경우,
		if(logout == '0'){
			
			// 자동로그인 체크한 경우
			if(autoLogin_cookie != null && autoLogin_cookie == '1'){
				$("#checkActiveLogin").addClass("active");
				$("#userId").val(getCookie("autoLogin_Id"));
				$("#userPw").val(getCookie("autoLogin_Pw"));
				$("#companyCode").val(getCookie("autoLogin_companyCode"));
				$("#autoLogin").val(getCookie("autoLogin"));
				
				$('#loginCheck').trigger('click');
				
				$('input:checkbox[id="autoLoginCheck"]').attr("checked", true);
				$("#autoLogin").val(autoLogin_cookie);
				$('#auto_chk_on').css('display', 'inline');
				$('#auto_chk_off').css('display', 'none');
			}else{
				$("#checkActiveLogin").removeClass("active");
				$("#companyCode").val(getCookie("autoLogin_companyCode"));
				// 아이디 저장 체크한 경우
				if(getCookie("saveIdValue") != null){
					$("#checkActiveId").addClass("active");
					$("#userId").val(getCookie("autoLogin_Id"));
					$('#chk_on').css('display', 'inline');
					$('#chk_off').css('display', 'none');
				}else{ // 아이디 저장 체크하지 않는 경우
					$("#checkActiveId").removeClass("active");
					$('#chk_off').css('display', 'inline');
					$('#chk_on').css('display', 'none');
				}
			}
			
		}else if(logout == '1'){
			//alert("로그아웃인 경우");
			$("#checkActiveLogin").removeClass("active");
			setCookie("autoLoginValue", 1, -1);
			
			if(getCookie("saveIdValue") != null){
				//alert("아이디 저장한 경우");
				$("#checkActiveId").addClass("active");
				$("#userId").val(getCookie("autoLogin_Id"));
				$('#chk_on').css('display', 'inline');
				$('#chk_off').css('display', 'none');
			}else{ // 아이디 저장 체크하지 않는 경우
				//alert("아이디 저장하지 않는 경우");
				$("#checkActiveId").removeClass("active");
				$('#chk_off').css('display', 'inline');
				$('#chk_on').css('display', 'none');
			}
			
			
			$("#companyCode").val(getCookie("autoLogin_companyCode"));
			
			//$("#autoLogin").val(getCookie(autoLoginValue));
			$('input:checkbox[id="autoLoginCheck"]').attr("checked", false);
			$('#auto_chk_off').css('display', 'inline');
			$('#auto_chk_on').css('display', 'none');
			
			// 아이디 저장 체크한 경우
			//if(getCookie("saveIdValue") == '1'){
			//var test = getCookie("saveIdValue");
		}
		
		$("#idSaveCheck").change(function(){ // 체크박스에 변화가 있다면,
			if($("#idSaveCheck").is(":checked")){ // ID 저장하기 체크했을 때,
				$("#checkActiveId").addClass("active");
				setCookie("saveIdValue", 1, 365);
				$('#chk_on').css('display', 'inline');
				$('#chk_off').css('display', 'none');
			}else{ // ID 저장하기 체크 해제 시,
				$("#checkActiveId").removeClass("active");
				setCookie("saveIdValue", 1, -1);
				$('#chk_off').css('display', 'inline');
				$('#chk_on').css('display', 'none');
			}
		});
		
		$("#autoLoginCheck").change(function(){ // 체크박스에 변화가 있다면,
			if($("#autoLoginCheck").is(":checked")){ // ID 저장하기 체크했을 때,
				$("#checkActiveLogin").addClass("active");
				setCookie("autoLoginValue", 1, 365);
				//alert("저장된 쿠키" + getCookie("autoLoginValue"));
				$('#auto_chk_on').css('display', 'inline');
				$('#auto_chk_off').css('display', 'none');
			}else{ // ID 저장하기 체크 해제 시,
				$("#checkActiveLogin").removeClass("active");
				setCookie("autoLoginValue", 1, -1);									// 자동로그인 해제 쿠키삭제
				//alert("오토로그인 해제 = " + getCookie("autoLogin"));			// 자동 로그인
				$("#autoLogin").val(autoLogin_cookie);
				$('#auto_chk_off').css('display', 'inline');
				$('#auto_chk_on').css('display', 'none');
			}
		});
	});
	
	
	// 회사코드 ajax 요청으로 정상인 경우에 loginUrl을 받음.
	//function companyCode(){
	$("#loginCheck").click(function (){
		
		if($("#companyCode").val() == ''){
			alert("회사코드를 입력해주세요");
			  $('#companyCode').focus();
			return;
		}
		
		if($("#userId").val() == ''){
			alert("아이디를 입력해주세요");
			  $('#userId').focus();
			return;
		}
		
		if($("#userPw").val() == ''){
			alert("패스워드를 입력해주세요");
			  $('#userId').focus();
			return;
		}
		
		if($("#userDi").val() == ''){
			alert("디바이스정보가 누락되었습니다.\n관리자에게 문의바랍니다.");
			  $('#userDi').focus();
			return;
		}
		
		if($("#idSaveCheck").is(":checked") && getCookie("userid") != null){
			setCookie("userid", $("input[name='member_id_num']").val(), 7);
			
		}else{
			setCookie("userid", $("input[name='member_id_num']").val(), -1);
			//alert("저장한 아이디" + getCookie("userid"));
		}
		
		var obj = new Object();
		obj.companyCode = $("#companyCode").val();						// 게이트 페이지로 넘겨주는 파라미터(로그인 화면에서 입력된 회사코드)
		
		var jsonData = JSON.stringify(obj);
		
		$.ajax({
			url : "http://thesellers.unipoint.co.kr:30200/api/key",			// 게이트 페이지
			//crossOrigin: true,														// ajax 크로스도메인 문제
			async : true,
			datatype : 'json',
			method: 'POST',
			data : jsonData,
			beforeSend : function(){
				//
			},
			success : function(data){
				var resultData = JSON.parse(data);
				if(resultData.result == 1){											// 회사 코드가 일치하는 경우
					encryption(resultData.loginUrl);								// 요청이 성공하면 응답받은 loginUrl값
				}else{																	// 회사코드가 일치하지 않는 경우 (http://sellers.dunet.co.kr/login.do?login=fail 이동)
					alert("회사코드가 다릅니다.");
				}
			},
			complete : function(){
				//
			}
		});
	});
	

	// 비밀번호 암호화
	function encryption(url){
		$.ajax({	
			url : "/loginGate.do",
			async : true,
			datatype : 'json',
			method: 'POST',
			data : {
				password_enc : $("#userPw").val() 
			},
			beforeSend : function(){
				//
			},
			success : function(data){
				//console.log(data);
				//console.log("encryption 데이터 = " + JSON.stringify(data));
				var pwSecurity = data.pwSecurity;
				setCookie("autoLogin_Pw", pwSecurity , 365);
				$("#userPw").val(pwSecurity);
				logion(url, pwSecurity);
				
			},
			complete : function(){
				//
			}
		});
	}


	function logion(url, pwSecurity){
	
		var obj = new Object();
		obj.companyCode = $("#companyCode").val();
		obj.userId = $("#userId").val();
		obj.userPw = pwSecurity;
		obj.userDi = $("#userDi").val();	
		obj.pushUrl = $("#pushUrl").val();
		obj.autoLogin = $("#autoLogin").val();
		
		var jsonData = JSON.stringify(obj);
		
		//console.log("로그인 url = " + url);
		
		$.ajax({
			url : url,
			//crossOrigin: true,
			async : true,
			datatype : 'json',
			method: 'POST',
			data : jsonData,
			beforeSend : function(){
				//console.log("전송하는 jsonData = " + jsonData);
				
			},
			success : function(data){
				//alert("url" + data.moveUrl);
				var result = data.result;
				//alert("@@@");
				//alert("push_url = " + data.push_url);
				setCookie("push_url", data.push_url, 365);
				//alert("@@@");
				if(result == 1){
					if($("#autoLoginCheck").is(":checked")){
						setCookie("autoLogin", 1, 365);									// 자동로그인을 위한 쿠키생성, 쿠키 최대 보존 365일
					}
					
					setCookie("autoLogin_Id", $("#userId").val(), 365);
					setCookie("autoLogin_Pw", $("#userPw").val(), 365);
					setCookie("autoLogin_companyCode", $("#companyCode").val(), 365);
					
					$("#formLogin").attr("action", data.moveUrl);
					$("#userPw").val(pwSecurity);
					
					$("#formLogin").submit();
					
				}else{
					alert("아이디 또는 패워스드가 다릅니다.");
					//console.log("@@@@@@@@@@" + url);
					//console.log("마지막" + JSON.stringify(data));
					/*
					
					*/
				}
			},
			complete : function(){
				//
			}
		});
	}
	
	
	var login_check = 1;
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
		var expireDate = new Date();q	
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
</script>

</body>
</html>