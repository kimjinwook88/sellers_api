<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	session.invalidate();
%>
<script type="text/javascript">
	alert("아이디 또는 비밀번호를 다시 확인하세요.");
	document.location.href = "/login.do";
</script>