<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<div id="tab2-2" class="tab-pane ">
		<!-- <table id="tech-companies" class="table table-bordered"> -->
		<table id="tech-companies" class="basic4_list mg-b30">
			<thead>
				<tr>
					<th rowspan="">문의자</th>
					<th rowspan="">메뉴</th>
					<th rowspan="">문의내용</th>
					<th rowspan="">문의날짜</th>
					<th colspan="">담당자</th>
					<th colspan="">해결상태</th>
					<th colspan="">삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${fn:length(list) > 0}">
						<c:forEach items="${list}" var="list">
						<tr>
							<td>${list.HAN_NAME}</td>
							<td>${list.MENU_FLAG}</td>
							<td>${list.Q_DETAIL}</td>
							<td><fmt:formatDate value="${list.Q_SEND_DATE}" pattern="yy-MM-dd HH:ss" /></td>
							
							<td><a type="button" href="#" onclick="">${list.THEPERSON_NAME}</a></td>
							<c:choose>
								<c:when test="${list.STATUS eq 'N'}">
									<td style="background-color:#ff0015"><a type="button" href="#" onclick=""></a></td>
								</c:when>
								<c:when test="${list.STATUS eq 'Y'}">
									<td style="background-color:#0255d3"><a type="button" href="#" onclick=""></a></td>
								</c:when>
							</c:choose>
							<td><a href="javascript:void(0);" onClick="changeStatus.deleteQ(${list.Q_ID});"><i class="fa fa-times-circle"></i></a></td>
						</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="17" style="text-align: center;">No Data</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
			
		</table>
	</div>
</div>


<script type="text/javascript">


var changeStatus = {
		
// 		진행 여부
		click : function(qID, status){
			$.ajax({
				url : "/main/updateErrNbugSuccessStatus.do",
				async : false,
				type : "get",
				data : {
					qID : qID,
					member_id_num  : "${userInfo.MEMBER_ID_NUM}",
					status : status
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
// 					alert("상태가 변경되었습니다.");
					sendQ.getErrNbugList();
// 					sendQ.getErrNbugListCount();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		changeManager : function(qId){
			q_Id = qId;
			$('div.custom-company-pop').show();
		},
		
		updateManger : function(value){
			$.ajax({
				url : "/main/updateErrNbugSuccessStatus.do",
				async : false,
				type : "get",
				data : {
					q_Id : q_Id,
					member_id_num  : "${userInfo.MEMBER_ID_NUM}",
					thePersonManagerSelect : $("#thePersonManagerSelect").val(),
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					alert("담당자가 변경되었습니다.");
					sendQ.getErrNbugList();
					$('#custom-company_pop_id').hide();
// 					sendQ.getErrNbugListCount();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		
		deleteQ : function(qID){
			$.ajax({
				url : "/main/deleteQ.do",
				async : false,
				type : "get",
				data : {
					qID : qID,
					member_id_num  : "${userInfo.MEMBER_ID_NUM}",
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					alert("문의가 삭제 되었습니다.");
					sendQ.getErrNbugListView();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		}
}


</script>