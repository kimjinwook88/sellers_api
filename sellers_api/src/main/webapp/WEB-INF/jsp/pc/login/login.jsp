<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ taglib  uri="http://www.springframework.org/security/tags"  prefix="sec" %>

<%
Authentication auth = (Authentication)request.getUserPrincipal();
if(auth == null){
     
}else{
	//로그인한 상태라면 권한별 페이지 이동
	//String principal = auth.getAuthorities().toString();
    response.sendRedirect("/main/index.do");
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	
    <title>로그인 페이지</title>
	<jsp:include page="/WEB-INF/jsp/pc/common/common.jsp"/>
</head>

<body class="gray-bg">
	<form id="formLogin" name="formLogin" method="post" action="/login">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <div class="middle-box text-center loginscreen animated fadeInDown">
        <div>
            <div>
                <h1 class="logo-name"><img src="images/pc/logo_blue.png" alt=""/></h1>
            </div>
            <p>셀러들을 위한 소프트웨어 입니다.</p>
            
            <!-- <div class="form-group" id="divCompanyCd"></div> -->
            <div class="form-group" id="divMemberId"></div>
            <div class="form-group" id="divMemberPwd"></div>
            
            <h5>크롬이나 IE 9.0 이상의 버전을 이용하세요.</h5>
            
            <p id="id_pwd_save"></p>
            
            <p class="text-center"></p>
            
            <p class="m-t copy-index"> <small>Seller's &copy; 2016</small> </p>
        </div>
    </div>
    </form>
</body>

	<script type="text/javascript">
	//사용자 브라우저 체크
	loginView(getBrowserCheck());
		//쿠키 생성
		function setCookie(cName, cValue, cDay){
		    var expire = new Date();
		    expire.setDate(expire.getDate() + cDay);
		    cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
		    if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
		    document.cookie = cookies;
		}
		
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
		
		$(document).ready(function(){
			setCookie('clickMenu', '', -1); //쿠키 삭제
			$(function(){
				$("#formLogin").validate({ // joinForm에 validate를 적용
				    rules:{
				        id:{required:true, rangelength:[1,10], digits:true}, 
				        // required는 필수, rangelength는 글자 개수(1~10개 사이)
				        pwd:{required:true, rangelength:[1,35]},
				        //pwdConfirm:{required:true, equalTo:"#pwd"}, 
				        // equalTo : id가 pwd인 값과 같아야함
				        //name:"required", // 검증값이 하나일 경우 이와 같이도 가능
				        //personalNo1:{required:true, minlength:6, digits:true},
				        // minlength : 최소 입력 개수, digits: 정수만 입력 가능
				        //personalNo2:{required:true, minlength:7, digits:true},
				        //email:{required:true, email:true},
				        // email 형식 검증
				        //blog:{required:true, url:true}
				        // url 형식 검증
				    },
				    messages:{ // rules에 해당하는 메시지를 지정하는 속성
				        id:{
				            required:"아이디를 입력하세요", // 이와 같이 규칙이름과 메시지를 작성
				            rangelength:"1글자 이상, 10글자 이하여야 합니다.",
				            digits:"숫자만 입력해 주세요."
				        },
				        pwd:{
				            required:"패스워드를 입력하세요",
				            rangelength:"1글자 이상, 30글자 이하여야 합니다"
				        },
				    }
				    //after submit
				    /* submitHandler: function() {
				    } */
				});
			});
			
			$("input[name='password_enc']").keypress(function(e){
				var keyCode = 0;
				var shiftKey=false;
				keyCode=e.keyCode;
				shiftKey=e.shiftKey;
				if (((keyCode >= 65 && keyCode <= 90)&& !shiftKey)||((keyCode >= 97 && keyCode <= 122)&& shiftKey)){
					alert("CapsLock이 켜져 있습니다");
					return false;
				}
			});
			
			$('#formLogin').submit(function () {
				//var v_cc = $.trim($('input[name=company_cd]').val());
				var v_id = $.trim($('input[name=member_id_num]').val());
				var v_pwd = $.trim($('input[name=password_enc]').val());
				
				/* if (v_cc == '') {
					alert("회사코드를 입력하세요.");
					$('input[name=company_cd]').focus();
					return false;
				} */
				
				if (v_id == '') {
					alert("아이디를 입력하세요.");
					$('input[name=member_id_num]').focus();
					return false;
				}
				
				if (v_pwd == '') {
					alert("비밀번호를 입력하세요.");
					$('input[name=password_enc]').focus();
					return false;
				}
				
				var v_saveid_check = $('input:checkbox[id=saveid]').is(':checked');
				var v_savepass_check = $('input:checkbox[id=savepass]').is(':checked');

				// 로그인 정보 저장 체크 확인하여 진행
				if(v_saveid_check)
					saveLogin(v_id);
				else
					saveLogin("");
				
				// 비밀번호 정보 저장 체크 확인하여 진행
				if(v_savepass_check)
					saveLogin2(v_pwd);
				else
					saveLogin2("");
			});
			
			getLogin();
		});
		
		function loginView(check){
			if(check == 'Chrome' || check == '9.0' || check == '10.0' || check == '11.0'){
				//$("#divCompanyCd").html('<input type="id" class="form-control" placeholder="회사코드" maxlength="10" name="company_cd"/>');
				$("#divMemberId").html('<input type="id" class="form-control" placeholder="아이디" maxlength="10" name="member_id_num"/>');
				$("#divMemberPwd").html('<input type="password" class="form-control" placeholder="비밀번호" maxlength="30" name="password_enc"/>');
				$("button").remove();
				$("h5").remove();
				$("#divMemberPwd").after('<button type="submit" class="btn block full-width btn-seller m-b">로그인</button>');
				//$("p.text-center").html('<a href="#">비밀번호 찾기</a>');
				
				var v_html = '<input type="checkbox" name="saveid" id="saveid" onclick="confirmSave(this)" />&nbsp;';
				v_html += '<span class="va_m">아이디 저장</span>';
				//v_html += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
				//v_html += '<input type="checkbox" name="savepass" id="savepass" onclick="confirmSave(this)" />&nbsp;';
				//v_html += '<span class="va_m">비밀번호 저장</span>';
				
				$("#id_pwd_save").html(v_html);
			}
		}
		
		function confirmSave(checkbox){
			var isRemember;

			// 로그인 정보 저장한다고 선택할 경우
			/*
			if(checkbox.checked){
				isRemember = confirm("이 PC에 로그인 정보를 저장하시겠습니까? \n\nPC방등의 공공장소에서는 개인정보가 유출될 수 있으니 주의해주십시오.");
			
				if(!isRemember)
					checkbox.checked = false;
			}
			*/
		}
		
		// 쿠키에서 로그인 정보 가져오기
		function getLogin(){
			var frm = document.loginForm;
			
			var v_id = getCookie("userid");
			var v_pwd = getCookie("userpass");

			if(v_id != ""){
				$('input[name=member_id_num]').val(v_id);
				$('input:checkbox[id=saveid]').prop('checked', true) ;
			}

			if(v_pwd != ""){
				$('input[name=password_enc]').val(v_pwd);
				$('input:checkbox[id=savepass]').prop('checked', true) ;
			}
		}
		
		function saveLogin(v_id){
			if(v_id != ""){
				setCookie("userid", v_id, 7);
			}
			else {
				setCookie("userid", v_id, -1);
			}
		}

		function saveLogin2(v_pwd){
			if(v_pwd != "") {
				setCookie("userpass", v_pwd, 7);
			}
			else {
				setCookie("userpass", v_pwd, -1);
			}
		}
	</script>
</html>
