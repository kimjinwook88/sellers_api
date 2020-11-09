<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>일정 초대하기</title>
</head>
<body>
	<br>
	<br>
	<%-- 
	<h2>일정 제목 :</h2> <h3>${eventMap.EVENT_SUBJECT}</h3>
	<br>
	<h2>일정 내용 :</h2> <h3>${eventMap.EVENT_DETAIL}</h3>
	<br>
	<h2>시작 날짜 :</h2> <h3>${eventMap.START_DATETIME}</h3>
	<br>
	<h2>종료 날짜 :</h2> <h3>${eventMap.END_DATETIME}</h3>

	<button type="button" onclick="calendar.downICS($('#textGoogleIcsURL').val(), 'google')">확인</button>
	
	
	<h3>${eventMap.EVENT_SUBJECT} 의 일정초대를 수락하였습니다.</h3>
	 --%>
	<input type="hidden" id="status" name="status" value="${eventMap.status}" />
</body>

</html>

<script type="text/javascript">
	var calendarAlert = {
		alert : function() {
			var returnValue;
			//수락 = 0
			//거절 = 1
			if (document.getElementById("status").value == 'Y') {
				returnValue = alert("일정초대에 수락하셨습니다.");
			} else {
				returnValue = alert("일정초대에 거절하셨습니다.");
			}
			document.write("일정 초대 수락!");
			self.opener = self;
			window.close();
			//calendarAlert.closeWin();
		}
	}
	calendarAlert.alert();
</script>