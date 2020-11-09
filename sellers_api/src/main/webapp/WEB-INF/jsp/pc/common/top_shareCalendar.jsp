<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session = "true" %>
<%
	String remoteAddr = request.getRemoteAddr();
	int remotePort = request.getRemotePort();
	String serverName = request.getServerName();
	int serverPort = request.getServerPort();
	
	//String userInfo = SecurityContextHolder.getContext().getAuthentication().getDetail();
	//String userAuth = SecurityContextHolder.getContext().getAuthentication().getAuthorities();
	//${userInfo} jsp
%>
<%-- ex)${userInfo.HAN_NAME} --%>
<%-- ${applicationCompanyGroup} --%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <jsp:include page="/WEB-INF/jsp/pc/common/common.jsp"/>
    <title></title> <!-- 파라미터로 들고 다니자.. -->
</head>
<body class="fixed-sidebar mini-navbar">
    <div id="wrapper">
    	<!-- menu -->
    	<%-- <jsp:include page="/WEB-INF/jsp/pc/common/menu.jsp"/> --%>
    	<!-- menu -->
        <div id="page-wrapper" class="white-bg" style="padding-left: 0px; padding-right: 0px;">
        <div class="row border-bottom">
        <nav class="navbar navbar-static-top" role="navigation" style="display: none;">
        <div class="navbar-header">
            <a class="navbar-minimalize minimalize-styl-2 btn btn-seller" href="javascript:menuClickGrid();void(0);"><i class="fa fa-bars"></i> </a>
        </div>
            <ul class="nav navbar-top-links navbar-right">
                <li>
                    <span class="m-r-sm text-muted welcome-message">Seller's 에 오신것을 환영합니다.</span>
                </li>
                <!-- <li class="">
                    <a class=" count-info" data-toggle="" href="#">
                        <i class="fa fa-envelope"></i>  <span class="label label-warning">16</span>
                    </a>
                </li> -->
                <li class="">
                    <a class=" count-info" data-toggle="" href="javascript:void(0);" onClick="notice.selectDetail();">
                        <i class="fa fa-bell"></i>
                    </a>
                </li>
                <li>
                    <a href="/logout">
                        <i class="fa fa-sign-out"></i> 로그아웃
                    </a>
                </li>
            </ul>
        </nav>
        </div>
                
<script type="text/javascript">
function menuClickGrid(){
	$('#sellersGrid').setGridWidth($('.pos-rel').width()-2);  //그리드
	$('#hiddenActionPlanGrid').setGridWidth($('#hiddenActionPlanGridWidth').width()-2); //영업활동 -> 잠재영업기회
	$('#contactFollowUpAction').setGridWidth($('#contactFollowUpActionWidth').width()-2); //고객컨택정보 입력
}

$(document).ready(function(){
	$sellersGrid = $("#sellersGrid");
	
	 $.ajaxLoading = function(){
  	   $("div.ajax-loader_sellers").show(); //ajax Loading
		  setTimeout(function(){$("div.ajax-loader_sellers").hide();},300); //ajax Loading
     }
	 
	 $.ajaxLoadingShow = function(){
  	   $("div.ajax-loader_sellers").show(); //ajax Loading
     }
	 
	 $.ajaxLoadingHide = function(){
  	   $("div.ajax-loader_sellers").hide(); //ajax Loading
     }
	 notice.selectCount();
});

var notice = {
		//알림 count
		selectCount : function(){
			 $.ajax({
					url : "/common/selectNoticeCount.do",
					async : false,
					datatype : 'json',
					type : "get",
					data : {
						member_id_num  : "${userInfo.MEMBER_ID_NUM}"
					},
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
					success : function(data){
						if(data.noticeCount > 0){
							$("a.count-info").append('<span class="label label-primary">'+data.noticeCount+'</span>');
						}
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
			});
		},
		
		//알림 상세 가져오기
		selectDetail : function(){
			fncOpenPanel("/common/selectNoticeDetail.do?member_id_num=${userInfo.MEMBER_ID_NUM}",400,400);
			/* $.ajax({
					url : "/common/selectNoticeDetail.do",
					async : false,
					type : "post",
					data : {
						member_id_num  : "${userInfo.MEMBER_ID_NUM}"
					},
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
					success : function(data){
						if(data.noticeCount > 0){
							$("a.count-info").append('<span class="label label-primary">'+data.noticeCount+'</span>');
						}
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
			});*/
		}
		
}

</script>