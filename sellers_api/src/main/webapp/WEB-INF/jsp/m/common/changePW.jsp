<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<title>패스워드 변경</title>
<jsp:include page="/WEB-INF/jsp/m/common/top.jsp"/>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ include file="/WEB-INF/jsp/m/common/functions.jsp" %>


	<article class="pd_t35 mg_b35">
        <div class="idpw_area">

            <p class="pd_t20 pd_b20 fc_primary ta_c fs18">
                <strong>비밀번호 재설정</strong>
            </p>

            <!-- 비밀번호 재설정  -->
            <div class="emil_input ">
                <form>
                    <input type="password" placeholder="이전 비밀번호" class="idpw_search_input mg_b10 r5" id="currentPassword" name="currentPassword"/>
                    <input type="password" placeholder="새 비밀번호" class="idpw_search_input mg_b10 r5" id="changePassword" name="changePassword"/>
                    <input type="password" placeholder="새 비밀번호 확인" class="idpw_search_input mg_b10 r5" id="changePasswordConfirm" name="changePasswordConfirm"/>
                    <div class="ta_c mg_b10">
                        <a href="" class="btn_idsearch r5" onclick="change.updatePassword();">변경하기</a>
                    </div>
                </form>
            </div>

        </div>
    </article>
    
    <footer class="ta_c">
        <div class="mg_b10">Copyright (c) 2016, THE Seller's</div>
    </footer>

<script type="text/javascript">
    var change = {
		updatePassword : function(){
			$.ajax({
				url : "/common/updatePassword.do",
				datatype : 'json',
				data :{
					currentPassword	: $("#currentPassword").val(),
					changePassword	: $("#changePassword").val(),
					changePasswordConfirm	: $("#changePasswordConfirm").val()
				},
				async : false,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					if(data.updateStatus == 0){
						alert("변경되었습니다.");
					}else if(data.updateStatus == 9){
						alert("현재 비밀번호가 틀렸습니다.");
					}else if(data.updateStatus == 8){
						alert("새 비밀번호가 다릅니다.");
					}else if(data.updateStatus == 7){
						alert("변경 실패하였습니다. \n관리자에게 문의하세요.");
					}
					//window.close();
					
					$("#currentPassword").val("");
					$("#changePassword").val("");
					$("#changePasswordConfirm").val("");
					$('#passwordPop').hide();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		}
	}
</script>
<jsp:include page="/WEB-INF/jsp/m/common/bottom.jsp"/>