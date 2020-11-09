<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
    <title>THE Seller's</title> <!-- 파라미터로 들고 다니자.. -->
</head>
<body class="fixed-sidebar">
    <div id="wrapper">
    	<!-- menu -->
    	<jsp:include page="/WEB-INF/jsp/pc/common/menu.jsp"/>
    	<!-- menu -->
    	<c:set value="${pageContext.request.requestURL}" var="url"></c:set>
    	<c:choose>
    		<c:when test="${fn:contains(url, 'main/main.jsp')}">
    			<div id="page-wrapper" class="gray-bg">
    		</c:when>
    		<c:otherwise>
    			<div id="page-wrapper" class="white-bg">
    		</c:otherwise>
    	</c:choose>
        <div class="row border-bottom white-bg">
        <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
        <div class="navbar-header">
            <a class="navbar-minimalize minimalize-styl-2 btn btn-seller" href="javascript:menuClickGrid();void(0);"><i class="fa fa-bars"></i> </a>
		</div>
		<!---타이틀--->
        <div class="navbar-header">
            <h2 class="navbar-header_tit" id="menu_title_1"></h2>
        </div>
        <!---//타이틀--->
            <ul class="nav navbar-top-links navbar-right">
                <li>
                    <span class="m-r-sm text-muted welcome-message">Seller's 에 오신것을 환영합니다.</span>
                </li>
                <!-- 
                <li class="">
                	<a class="" href="javascript:void(0);" onClick="change.updatePassword();">
                        <i class="fa ">
                        	<span>비밀번호 변경</span>
                       	</i>
                  	</a>
                </li>
                 -->
                 
                <!-- <li class="">
                    <a class=" count-info" data-toggle="" href="#">
                        <i class="fa fa-envelope"></i>  <span class="label label-warning">16</span>
                    </a>
                </li> -->
                
                <li>
                	<!-- <span class="m-r-sm text-muted welcome-message">Seller's 에 오신것을 환영합니다.</span>  -->
                	<!-- <a class="down_apk" href="javascript:void(0);" onClick="downloadApk();">
                  </a> -->
                  <!-- <a class=" count-info" data-toggle="dropdown" href="javascript:void(0);" onClick="notice.selectDetail();">
                        <i class="fa fa-bell"></i>
                    </a> -->
                  <a class="down_apk" href="#" onclick="downloadApk();">
                  	 <span>down</span>
                  </a>
                </li>
                <li class="dropdown">
                    
                    <a class=" count-info" data-toggle="dropdown" href="javascript:void(0);" onClick="notice.selectDetail();">
                        <i class="fa fa-bell"></i>
                    </a>
                    
                    <div class="dropdown-menu dropdown-alerts " id="noticePop" style="width:700px;right:-228px;">
                       <ul class="alarm-list-pop list-group full-height-scroll" id="notice">
                       
                       </ul>
                       <!-- 일단 주석_2016-11-15_Hoon : 쓸 용도 기획 안잡힘
                       <div class="text-center link-block">
                           <a href="#">랜딩페이지로 이동
                               <strong>알림 전체보기</strong>
                               <i class="fa fa-angle-right"></i>
                           </a>
                       </div>
                        -->
                   </div>
                </li>
                
                <li class="pos-rel">
                     <a href="#" class="btn-pwset-pop" data-toggle="modal" data-target="#myinfo-pw">
                         <i class="fa fa-gear"></i> 비밀번호 변경
                     </a>
	                 <div class="myinfo-pw-modal off" id="passwordPop">
	                    <div class="pop-header">
	                        <strong class="pop-title">비밀번호 변경</strong>
	                    </div>
	                    <div class="col-sm-12 cont">
	                        <div class="ibox-content border_n">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                    <div class="col-sm-12 m-b">
	                                        현재 비밀번호
	                                        <input type="password" placeholder="" class="form-control"  maxlength="30" id="currentPassword" name="currentPassword"/>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                    <div class="col-sm-12 m-b">
	                                        새 비밀번호 입력
	                                        <input type="password" placeholder="" class="form-control" maxlength="30" id="changePassword" name="changePassword" />
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                    <div class="col-sm-12">
	                                        새 비밀번호 확인
	                                        <input type="password" placeholder="" class="form-control" maxlength="30" id="changePasswordConfirm" name="changePasswordConfirm"/>
	                                    </div>
	                                </div>
	                            </form>
	                        </div>
	
	                        <div class="col-sm-12 ta-c">
	                            <button type="button" class="btn btn-outline btn-seller-outline mg-r10 btn-cancle">취소</button>
	                            <button type="button" class="btn btn-seller" onclick="change.updatePassword()">변경</button>
	                        </div>
	                    </div>
	                </div>
                </li>
                
                <!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 개발 완료 후 지울 소스 시작@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
                <!-- 
                <li class="pos-rel" id="errNbugAlarm" style="display:none">
                     <a href="#" class="btn-cus-pop" data-toggle="modal" data-target="#myinfo-cus">
                         <i class="fa fa-question"></i>문의
                     </a>
	                 <div class="myinfo-cus-modal off" id="cusPop">
	                    <div class="pop-header">
	                        <strong class="pop-title">문의</strong>
	                    </div>
	                    <div class="col-sm-12 cont">
	                        <div class="ibox-content border_n">
	                            <form method="get" class="form-horizontal">
	                                <div class="form-group">
	                                    <div class="col-sm-12 m-b">
	                                        메뉴 선택
	                                        <select class="form-control m-b" name="menuSelect" id="menuSelect">
												<option value="고객사정보">고객사정보</option>
												<option value="고객개인정보">고객개인정보</option>
												<option value="고객건택내용">고객건택내용</option>
												<option value="영업기회">영업기회</option>
												<option value="잠재영업기회">잠재영업기회</option>
												<option value="고객이슈">고객이슈</option>
												<option value="고객만족도">고객만족도</option>
												<option value="서비스프로젝트">서비스프로젝트</option>
												<option value="파트너사협업관리">파트너사협업관리</option>
												<option value="파트너사정보">파트너사정보</option>
												<option value="파트너사개인정보">파트너사개인정보</option>
												<option value="성과관리">성과관리</option>
												<option value="생산성">생산성</option>
												<option value="제안서정보">제안서정보</option>
												<option value="제안서정보">제안서정보</option>
												<option value="회사/부문별전략">회사/부문별전략</option>
												<option value="고객별전략">고객별전략</option>
												<option value="전략프로젝트">전략프로젝트</option>
												<option value="일정관리">일정관리</option>
											</select>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                    <div class="col-sm-12 m-b">
	                                        개발 담당자 선택
	                                        <select class="form-control m-b" name="thePersonSelect" id="thePersonSelect">
												<option value="0486">김진욱 대리 ( 담당 대표 페이지 : 고객컨택내용, 영업기회, 잠재영업기회 등 )</option>
												<option value="0489">심윤영 사원 ( 담당 대표 페이지 : 고객사정보, 고객개인정보 등 )</option>
												<option value="3">고객건택내용</option>
											</select>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                    <div class="col-sm-12">
	                                        문의 내용
	                                        <input class="form-control" maxlength="500" id="theTextArea" name="theTextArea" placeholder="간략하게 요점만 작성해 주세요. (250자 내)" maxlength="250"/>
	                                    </div>
	                                </div>
	                                
	                                <br />
	                                <div class="form-group">
	                                	<a href="#" onclick="sendQ.getErrNbugListView()"><span id="more" style="CURSOR: hand" onclick="if(sendErrNbugList.style.display=='none') {sendErrNbugList.style.display='';more.innerText='나의 문의 리스트 접기'} else {sendErrNbugList.style.display='none';more.innerText='나의 문의 리스트 보기'}">나의 문의 리스트 보기</span></a>
                                    <a href="#" onclick="sendQ.getErrNbugListView()">나의 문의 리스트 보기</a>
	                                    <div class="col-sm-12" id="sendErrNbugList" style="display: none">
										
	                                    </div>
	                                </div>
	                                
	                            </form>
	                        </div>
	
	                        <div class="col-sm-12 ta-c">
	                            <button type="button" class="btn btn-outline btn-seller-outline mg-r10 btn-cancle">취소</button>
	                            <button type="button" class="btn btn-seller" onclick="sendQ.send()">문의하기</button>
	                        </div>
	                    </div>
	                </div>
                </li>
                
                <li class="pos-rel" id="errNbugAlarmManager" style="display:none">
                     <a href="#" class="btn-cus-pop" data-toggle="modal" data-target="#myinfo-cus" onclick="sendQ.getErrNbugList();">
                         <i class="fa fa-question"></i> 문의 리스트
                     </a>
                     <div class="myinfo-cus-modal off" id="cusPop">
	                    <div class="pop-header">
	                        <strong class="pop-title"> 문의 리스트</strong>
	                    </div>
	                    <div class="col-sm-12 cont">
	                        <div class="ibox-content border_n" id="errNbugListView">
	                        	
	                        </div>
	                        
	                        담당자 변경 창
	                        <div class="custom-company-pop off" id="custom-company_pop_id">
							<div class="pop-header">
									<button type="button" class="close">
										<span aria-hidden="true">&times;</span><span
											class="sr-only">Close</span>
									</button>
									<strong class="pop-title">개발담당자 선택</strong>
								</div>
								<div class="col-sm-12 cont">
									<div class="form-group">
										<select class="form-control m-b" name="thePersonManagerSelect" id="thePersonManagerSelect">
											<option value="0486">김진욱 대리</option>
											<option value="0489">심윤영 사원</option>
										</select>
										<button type="button" class="btn btn-seller" onclick="changeStatus.updateManger()">담당자 변경</button>
									</div>
								</div>
							</div>
	                        
	
	                        <div class="col-sm-12 ta-c">
	                            <button type="button" class="btn btn-outline btn-seller-outline mg-r10 btn-cancle">닫기</button>
	                            <button type="button" class="btn btn-seller" onclick="sendQ.send()">문의하기</button>
	                        </div>
	                        
	                    </div>
	                </div>
                </li>
                 -->
                <!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 개발 완료 후 지울 소스 끝@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
                
                <li>
                    <a href="/logout">
                        <i class="fa fa-sign-out"></i> 로그아웃
                    </a>
                </li>
            </ul>
        </nav>
        </div>
        
        <!-- 메뉴 경로 -->
	    <div class="col-sm-6" id="menu_path" style="display: none;">
	        <ol class="breadcrumb">
	            <li>
	                <a href="/main/index.do">Home</a>
	            </li>
	            <li>
	                <a id="menu_parent"></a>
	            </li>
	            <li class="active">
	                <strong id="menu_title_2"></strong>
	            </li>
	        </ol>
	    </div>

<!-- form 영역 -->
<form id="formNoticeDetail" name="formNoticeDetail" method="post">
	<input type="hidden" id="notice_event_id" name="notice_event_id">
</form>                
<script type="text/javascript">
var q_Id = "";
function menuClickGrid(){
	//$('#sellersGrid').setGridWidth($('.pos-rel').width()-2);  //그리드
	//$('#hiddenActionPlanGrid').setGridWidth($('#hiddenActionPlanGridWidth').width()-2); //영업활동 -> 잠재영업기회
	//$('#contactFollowUpAction').setGridWidth($('#contactFollowUpActionWidth').width()-2); //고객컨택정보 입력
}

function setTitle(){
	// 메뉴 타이틀 뿌려줌
	var menuTitle = getCookie('clickMenuTitle');
	var menuParent = getCookie('clickMenuParent');
	var url = this.location.pathname;
	
	if((url != '/main/index.do') && (url != '/calendar/viewCalendar.do')){
		
		$("#menu_title_1").html(menuTitle);
		$("#menu_title_2").html(menuTitle);
		$("#menu_parent").html(menuParent);
		
		$("#menu_path").css('display', 'block');
		
		// menuParent 값이 없는 레벨1 메뉴일 경우
		if(!menuParent){			
			var parentEl = $('#menu_parent').parents('li');
			parentEl.remove();
		}
	}	
}

/**
 * 셀러스 apk 파일 다운로드
 */
function downloadApk(){
	
	if(confirm("THE Seller's APK 파일을 다운로드 하시겠습니까?")){
		location.href = location.origin+"/apk.html"; 
	}
}

$(document).ready(function(){
	
	// 메뉴 타이틀 뿌려줌
	setTitle();
	
	/* setInterval(function(){
	 	$.ajax({
			url : "/common/connection.do",
			async : false,
			type : "get",
			dataType : "json",
			timeout: 3000,
			success : function(data){
			},
			complete : function(){
			}
		});
	
		$("#gridAjaxCall").jqGrid({
			url : "/common/connection.do",
 			mtype: 'POST',
			datatype : 'json',
			postData : {
 			},
			 jsonReader : { 
			    root: "rows",
			},
			loadBeforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			loadComplete : function(data){
			}
		}).trigger('reloadGrid');
	}, 250000); */
	
	///////////////////////////  개발 완료 후 지울 소스 시작///////////////////////////
	//에러 & 버그 문의
	/* if("${userInfo.MEMBER_ID_NUM}" == "0489" || "${userInfo.MEMBER_ID_NUM}" == "0486"){
		$('#errNbugAlarmManager').show();
		sendQ.getErrNbugListCount();
	}else{
		$('#errNbugAlarm').show();
	} */
	///////////////////////////  개발 완료 후 지울 소스 끝///////////////////////////
	
	
	$sellersGrid = $("#sellersGrid");
	
	 $.ajaxLoading = function(){
	   $("div.ajaxMask").show(); //ajax Loading
  	   $("div.ajax-loader_sellers").show(); //ajax Loading
		  setTimeout(function(){
			  $("div.ajaxMask").hide(); //ajax Loading
			  $("div.ajax-loader_sellers").hide();
		  },300); //ajax Loading
     }
	 
	 $.ajaxLoadingShow = function(){
  	   $("div.ajaxMask").show(); //ajax Loading
  	   $("div.ajax-loader_sellers").show(); //ajax Loading
     }
	 
	 $.ajaxLoadingHide = function(){
	   $("div.ajaxMask").hide(); //ajax Loading
  	   $("div.ajax-loader_sellers").hide(); //ajax Loading
     }
	 
	 //일정 미리알림
	 calanderAlarm.selectInfo();

	 notice.selectCount();
	 
	 //페이지 접근 기록
	 pageContact.insert();
	 
	//validation mobile
	var regExpMobile =  /^01([0|1|6|7|8|9]?)([0-9]{3,4})([0-9]{4})$/;
	var regExpPhone = /^(0(2|3[1-3]|4[1-4]|5[1-5]|6[1-4]|70|80))(\d{3,4})(\d{4})$/
    $.validator.addMethod(
        'phone', function (value, element) {
        	var str = value.replace(/-/gi, ""); 
            return (regExpMobile.test(str) || regExpPhone.test(str) || isEmpty(str)) ? true : false;
        }, '잘못된 전화번호입니다.'
    );
});

var pageContact  = {
		insert : function(){
			$.ajax({
				url : "/common/insertPageContatct.do",
				async : false,
				type : "post",
				data : {
					member_id_num  : "${userInfo.MEMBER_ID_NUM}",
					page_url : location.pathname
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		}
}

//////////////////////////////개발 완료 후 지울 소스 시작 //////////////////////////////
/* var sendQ = {
		send : function(){
			$.ajax({
				url : "/common/sendQ.do",
				async : false,
				type : "get",
				data : {
					member_id_num  : "${userInfo.MEMBER_ID_NUM}",
					thePersonSelect : $("#thePersonSelect").val(),
					theTextArea : $("#theTextArea").val(),
					menuSelect : $("#menuSelect").val()
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					alert("문의를 완료하였습니다.");
					$('#cusPop').hide();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
			
		},
		
		getErrNbugListView : function(){
			$.ajax({
				url : "/main/selectErrNbugList.do",
				async : false,
				type : "get",
				dataType : "html",
				data : {
					member_id_num  : "${userInfo.MEMBER_ID_NUM}",
					thePersonSelect : $("#thePersonSelect").val(),
					theTextArea : $("#theTextArea").val(),
					menuSelect : $("#menuSelect").val(),
					flag : "getErrNbugList",
					sender : "Y"
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					$("#sendErrNbugList").html(data);
// 					$('#sendErrNbugList').show();
				},
				complete : function(){
				}
			});
		},
		
		getErrNbugListCount : function(resetFlag){
			$.ajax({
				url : "/main/selectErrNbugList.do",
				async : false,
				type : "get",
				dataType : "json",
				data : {
					member_id_num  : "${userInfo.MEMBER_ID_NUM}",
					thePersonSelect : $("#thePersonSelect").val(),
					theTextArea : $("#theTextArea").val(),
					menuSelect : $("#menuSelect").val(),
					flag : "getErrNbugListCount",
					countFlag : "Y",
					manager : "Y"
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					if( data.list.length > 0)
					{
						$("a.btn-cus-pop").append('<span class="label alarm_count_bg" id="testaas">'+data.list.length+'</span>');
					}else
					{
						$("a.btn-cus-pop").append('<span class="label label-primary">'+data.list.length+'</span>');
					}
					
				},
				complete : function(){
				}
			});
		},
		
		getErrNbugList : function(){
			$.ajax({
				url : "/main/selectErrNbugList.do",
				async : false,
				type : "get",
				dataType : "html",
				data : {
					member_id_num  : "${userInfo.MEMBER_ID_NUM}",
					thePersonSelect : $("#thePersonSelect").val(),
					theTextArea : $("#theTextArea").val(),
					menuSelect : $("#menuSelect").val(),
					flag : "getErrNbugList",
					manager : "Y"
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					$("#errNbugListView").html(data);
				},
				complete : function(){
				}
			});
		}
} */
//////////////////////////////  개발 완료 후 지울 소스 끝 //////////////////////////////

var calanderAlarm = {
		selectInfo : function(){
			$.ajax({
				url : "/common/selectCalendarAlarmInfo.do",
				async : false,
				type : "get",
				data : {
					member_id_num  : "${userInfo.MEMBER_ID_NUM}"
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		}
}

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
							$("a.count-info").append('<span class="label alarm_count_bg">'+data.noticeCount+'</span>');
							notice.selectDetail();
							
							//알림이 있을경우 최초 접속(랜딩페이지) 에서만 자동으로 알림창 열어 놓기.
							/* 
							var url = "http://"+location.host +"/main/index.do";
							if(url == location.href){
								$('li.dropdown').addClass('open');
							}else{
								$('li.dropdown').addClass('');
							}
							 */
						}else{
							$("a.count-info").append('<span class="label label-primary">'+data.noticeCount+'</span>');
							$('li.dropdown').removeClass('open');
						}
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
			});
		},
		//$("#notice").append('<span class="label label-primary">'+"new" +'</span>');
		//알림 상세 가져오기
		selectDetail : function(){
			//fncOpenPanel("/common/selectNoticeDetail.do?member_id_num=${userInfo.MEMBER_ID_NUM}",400,400);
			
			$.ajax({
				url : "/common/selectNoticeDetail.do",
				async : false,
				datatype : 'json',
				type : "post",
				data : {
					member_id_num  : "${userInfo.MEMBER_ID_NUM}"
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					
					if(data.selectNoticeDetail.length > 0)
					{
						$("#notice").html('');
						for(var i=0; i<data.selectNoticeDetail.length; i++)
						{
							if(data.selectNoticeDetail[i].NOTICE_DEL_YN != "Y")
							{
								if(data.selectNoticeDetail[i].NOTICE_CONFIRM_YN == "Y")
								{
									$("#notice").append('<li id="'+ i +'" class="visited" style="cursor:pointer; font-size:12px">');
								}
								else
								{
									$("#notice").append('<li id="'+ i +'" style="cursor:pointer; font-size:12px">');
								}
								
								//$("#notice").append('<a href="#">');
								/* if(data.selectNoticeDetail[i].NOTICE_CONFIRM_YN == "Y"){
									$("#notice").append('<li class="visited">');
								}
								 */
								$("#notice > li#"+i).append('<div class="alarm-box">');
								
								//알림 컨펌이 'N'이면 알림 내용에 "new" 표시
								if(data.selectNoticeDetail[i].NOTICE_CONFIRM_YN == "N")
								{
									$("#notice > li#"+i).append('<span class="icon_new">'+"new" +'</span>');
								}
								
								//$("#notice > li#"+i).append('<span class="label">'+data.selectNoticeDetail[i].NOTICE_CATEGORY+'</span>');
								//$("#notice").append('<a href="#" onclick="notice.shareCalView('+data.selectNoticeDetail[i].NOTICE_REDIRECT_URL+')">');
								
								if(data.selectNoticeDetail[i].NOTICE_CATEGORY == '캘린더공유')
								{
									$("#notice > li#"+i).append('<span class="label">'+data.selectNoticeDetail[i].NOTICE_CATEGORY+'</span><br />');
									$("#notice > li#"+i).append('<strong onclick="notice.countUpdate(\''+data.selectNoticeDetail[i].NOTICE_ID+'\')"> '+data.selectNoticeDetail[i].NOTICE_DETAIL+'</strong>');
									$("#notice > li#"+i).append('<span class="icon_link" onclick="notice.shareCalView(\''+data.selectNoticeDetail[i].NOTICE_REDIRECT_URL+'\', \''+data.selectNoticeDetail[i].NOTICE_ID+'\')">'+"바로가기"+'</span>');
								}
								else if(data.selectNoticeDetail[i].NOTICE_CATEGORY == '캘린더 일정 초대')
								{
									$("#notice > li#"+i).append('<span class="label">'+data.selectNoticeDetail[i].NOTICE_CATEGORY+'</span><br />');
									$("#notice > li#"+i).append('<strong onclick="notice.convite(\''+data.selectNoticeDetail[i].NOTICE_ID+'\')"> '+data.selectNoticeDetail[i].NOTICE_DETAIL+'</strong>');
								}
								else if(data.selectNoticeDetail[i].NOTICE_CATEGORY == '일정초대수락여부')
								{
									$("#notice > li#"+i).append('<span class="label">'+data.selectNoticeDetail[i].NOTICE_CATEGORY+'</span>');
									$("#notice > li#"+i).append('<strong onclick="notice.countUpdate(\''+data.selectNoticeDetail[i].NOTICE_ID+'\');"> '+data.selectNoticeDetail[i].NOTICE_DETAIL+'</strong>');
									$("#notice > li#"+i).append('<span class="icon_link" onclick="notice.inviteMemberList(\''+data.selectNoticeDetail[i].MEMBER_ID_NUM+'\', \''+data.selectNoticeDetail[i].NOTICE_ID+'\', \''+data.selectNoticeDetail[i].EVENT_ID+'\')">'+"바로가기"+'</span>');
								}
								else if(data.selectNoticeDetail[i].NOTICE_CATEGORY == '일정알림')
								{
									if(data.selectNoticeDetail[i].NOTICE_CODE == '1'){
										$("#notice > li#"+i).append('<img src="/images/pc/calendar_icon1.png" class="v-m"/>')
									}else if(data.selectNoticeDetail[i].NOTICE_CODE == '2'){
										$("#notice > li#"+i).append('<img src="/images/pc/calendar_icon2.png" class="v-m"/>')
									}else if(data.selectNoticeDetail[i].NOTICE_CODE == '3'){
										$("#notice > li#"+i).append('<img src="/images/pc/calendar_icon3.png" class="v-m"/>')
									}else if(data.selectNoticeDetail[i].NOTICE_CODE == '4'){
										$("#notice > li#"+i).append('<img src="/images/pc/calendar_icon4.png" class="v-m"/>')
									}else if(data.selectNoticeDetail[i].NOTICE_CODE == '5'){
										$("#notice > li#"+i).append('<img src="/images/pc/calendar_icon5.png" class="v-m"/>')
									}else if(data.selectNoticeDetail[i].NOTICE_CODE == '7'){
										$("#notice > li#"+i).append('<img src="/images/pc/calendar_icon6.png" class="v-m"/>')
									}else if(data.selectNoticeDetail[i].NOTICE_CODE == '6'){
										$("#notice > li#"+i).append('<img src="/images/pc/calendar_icon7.png" class="v-m"/>')
									}
									
									//$("#notice > li#"+i).append('<span class="label">'+data.selectNoticeDetail[i].NOTICE_CATEGORY+'</span>');
									$("#notice > li#"+i).append('<strong onclick="notice.countUpdate(\''+data.selectNoticeDetail[i].NOTICE_ID+'\')"> '+data.selectNoticeDetail[i].NOTICE_DETAIL+'</strong>');
									$("#notice > li#"+i).append('<span class="icon_link" onclick="notice.meetingNotice(\''+data.selectNoticeDetail[i].EVENT_ID+'\', \''+data.selectNoticeDetail[i].NOTICE_ID+'\')">'+"바로가기"+'</span>');
								}
								else if(data.selectNoticeDetail[i].NOTICE_CATEGORY == '고객이슈')
								{
									/* $("#notice > li#"+i).append('<span class="label">'+data.selectNoticeDetail[i].NOTICE_CATEGORY+'</span>'); */
									$("#notice > li#"+i).append('<span class="label">'+"고객만족"+'</span><br />');
									$("#notice > li#"+i).append('<strong onclick="notice.convite(\''+data.selectNoticeDetail[i].NOTICE_ID+'\')"> '+data.selectNoticeDetail[i].NOTICE_DETAIL+'</strong>');
									/* $("#notice > li#"+i).append('<span class="icon_link" onclick="notice.meetingNotice(\''+data.selectNoticeDetail[i].EVENT_ID+'\', \''+data.selectNoticeDetail[i].NOTICE_ID+'\')">'+"바로가기"+'</span>'); */
								}
								else if(data.selectNoticeDetail[i].NOTICE_CATEGORY == 'TRACKING')
								{
									var url= data.selectNoticeDetail[i].NOTICE_REDIRECT_URL;
									$("#notice > li#"+i).append('<span class="label">'+data.selectNoticeDetail[i].NOTICE_CODE+'</span><br />');
									$("#notice > li#"+i).append('<strong onClick="notice.countUpdate(\''+data.selectNoticeDetail[i].NOTICE_ID+'\');">'+data.selectNoticeDetail[i].NOTICE_DETAIL+'</strong>');
									if(url != null){
										$("#notice > li#"+i).append('<span class="icon_link" onclick="notice.tracking(\''+data.selectNoticeDetail[i].EVENT_ID+'\', \''+data.selectNoticeDetail[i].NOTICE_ID+'\', \''+url+'\')">'+"바로가기"+'</span>');
									}
								}
								else
								{
									$("#notice > li#"+i).append('<span class="label">'+data.selectNoticeDetail[i].NOTICE_CATEGORY+'</span> <br />');
									$("#notice > li#"+i).append('<strong onClick="notice.countUpdate(\''+data.selectNoticeDetail[i].NOTICE_ID+'\');">'+data.selectNoticeDetail[i].NOTICE_DETAIL+'</strong>');
									//$("#notice > li#"+i).append('<a href="'+data.selectNoticeDetail[i].NOTICE_REDIRECT_URL+'" target="_new" onClick="notice.countUpdate(\''+data.selectNoticeDetail[i].NOTICE_ID+'\');"><span class="icon_link">'+"바로가기"+'</span></a>');
									$("#notice > li#"+i).append('<a class="icon_link" href="'+data.selectNoticeDetail[i].NOTICE_REDIRECT_URL+'" target="_new" onClick="notice.countUpdate(\''+data.selectNoticeDetail[i].NOTICE_ID+'\');">'+"바로가기"+'</a>');
								}
								//$("#notice").append('<strong>'+data.selectNoticeDetail[i].NOTICE_DETAIL+'</strong>');
								$("#notice > li#"+i).append('<div><span class="text-muted small"><i class="fa fa-clock-o"></i>'+ moment(data.selectNoticeDetail[i].NOTICE_SEND_DATE).format('YYYY[-]MM[-]DD HH:mm:ss')+ '</span></div>');
								$("#notice > li#"+i).append('<a href="#" class="btn_list_delete" onclick="notice.deleteNotice(\''+data.selectNoticeDetail[i].NOTICE_ID+'\')" style="margin-right: 2px !important;"><img src="/images/pc/icon_check_no.png"></a>');
								$("#notice > li#"+i).append('</div>');
								//$("#notice").append('</a>');
								//$("#notice").append('</li>');
							}
							
						}
					}else{
						$("#notice").html('');
						$("#notice").append('<strong>'+"-----------------알림없음-----------------"+'</strong>')
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		countUpdate : function(noticeId){
			$.ajax({
				url : "/common/updateNoticeDetail.do",
				async : false,
				type : "get",
				data : {
					member_id_num  : "${userInfo.MEMBER_ID_NUM}",
					noticeId : noticeId
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					notice.selectCount();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
			
		},
		
		deleteNotice : function(noticeId){
			$.ajax({
				url : "/common/updateNoticeDetail.do",
				async : false,
				type : "get",
				data : {
					member_id_num  : "${userInfo.MEMBER_ID_NUM}",
					noticeId : noticeId,
					noticeDel : "Y"
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success : function(data){
					notice.selectCount();
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		meetingNotice : function(eventId, noticeId){
			notice.countUpdate(noticeId);
			$("#formNoticeDetail").attr("target", "formNoticeDetail");
			$("#formNoticeDetail #notice_event_id").val(eventId);
			
			var form =  $("#formNoticeDetail")[0];
			var url = "/calendar/viewCalendar.do";
			window.open("" ,"formNoticeDetail"); 
			form.action = url; 
			form.submit();
		},
		
		tracking : function(issueId, noticeId, url){
			notice.countUpdate(noticeId);
			
			$("#formNoticeDetail").attr("target", "formNoticeDetail");
			$("#formNoticeDetail #notice_event_id").val(issueId);
			
			var form =  $("#formNoticeDetail")[0];
			var url = url;
			window.open("" ,"formNoticeDetail"); 
			form.action = url; 
			form.submit();
		},
		
		clientIssue : function(issueId, noticeId){
			notice.countUpdate(noticeId);
			
			$("#formNoticeDetail").attr("target", "formNoticeDetail");
			$("#formNoticeDetail #notice_event_id").val(issueId);
			
			var form =  $("#formNoticeDetail")[0];
			var url = "/clientSatisfaction/viewClientIssueList.do";
			window.open("" ,"formNoticeDetail"); 
			form.action = url; 
			form.submit();
		},
		
		convite : function(noticeId){
			alert("메일에서 확인하세요");
			
			notice.countUpdate(noticeId);
		},
		
		shareCalView : function(linkURL, noticeId){
			window.open("http://" + location.host +linkURL, "동료캘린더창", "width=1000, height=750, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );
			
			notice.countUpdate(noticeId);
		},
		
		inviteMemberList : function(memberIdNum, noticeId, eventId){
			
			notice.countUpdate(noticeId);
			//window.open("http://" + location.host + "/calendar/inviteAnswerList.do?hiddenModalEventId="+eventId+"&memberIdNum="+memberIdNum, "일정초대자명단", "width=500, height=300, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );
			
			$("#formNoticeDetail").attr("target", "formNoticeDetail");
			$("#formNoticeDetail #notice_event_id").val(eventId);
			
			var form =  $("#formNoticeDetail")[0];
			var url = "/calendar/viewCalendar.do";
			window.open("" ,"formNoticeDetail"); 
			form.action = url; 
			form.submit();
		}
}

/**
 * 패스워드 변경
 */
var change = {
	/* 	
	updatePassword : function(){
		fncOpenPanel("/common/updatePasswordPop.do?",200,200);
		
	}
	 */
	 
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

<div style="display:none;">
<table id="gridAjaxCall" style="width: 0px; height: 0px; display:none;"></table>
</div>

