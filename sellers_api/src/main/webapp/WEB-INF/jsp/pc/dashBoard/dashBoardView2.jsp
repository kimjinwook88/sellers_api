<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>

<style>
	#images > div, #boards > div {float:left;width:100px;height:100px;border:1px solid #000;margin:5px;}
	#images div img {width:100px;height:100px;}
	#boards {clear:both;}
	#boards > div {font-size:2em;line-height:100px;text-align:center;}
</style>

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-sm-4">
        <h2>대시보드</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>고객만족</a>
            </li>
            <li class="active">
                <strong>서비스 프로젝트</strong>
            </li>
        </ol>
    </div>
    <div class="col-sm-8">
        <div class="time-update">
            <span class="text-muted small pull-right">최근 업데이트: <i class="fa fa-clock-o"></i> <span id="LATELY_UPDATE_DATE"></span></span>
        </div>

		<div class="search-common">
			<div class="input-default  fl_l" style="margin: 0;">
				<span class="input-group-btn"> <a href="javascript:void(0);"
					class="btn btn-search-option"><i class="fa fa-search"></i> 검색</a>
				</span>

				<div class="search-detail" style="display: none;">

					<div class="col-sm-12 m-b">
						<label class="control-label" for="date_modified">고객사</label>
						<div class="input-group" style="width: 100%;">
							<input type="text" placeholder="고객사를 입력해주세요"
								class="input form-control" id="textSearchCompany"
								onkeydown="if(event.keyCode == 13){projectMGMTList.reset();projectMGMTList.get();}">
						</div>
					</div>

					<div class="col-sm-12 ag_r">
						<label for="result-in-search" class="mg-r10"> <input
							type="checkbox" id="result-in-search" class="input v-m">
							결과내 검색
						</label>
						<button type="button" class="btn btn-w-m btn-primary btn-seller"
							onClick="projectMGMTList.reset();projectMGMTList.get(true);">
							<i class="fa fa-search"></i> 검색
						</button>
					</div>
				</div>

			</div>
		</div>
	</div>
</div>

<form id="frm">

<div id="checkboxArea">
	<input type="checkbox" name="box" id="box1" value="1" /><label>일정</label> &nbsp; &nbsp;
	<input type="checkbox" name="box" id="box2" value="2" /><label>영업기회</label> &nbsp; &nbsp;
	<input type="checkbox" name="box" id="box3" value="3" /><label>고객이슈</label> &nbsp; &nbsp;
	<input type="checkbox" name="box" id="box4" value="4" /><label>TRACKING</label> &nbsp; &nbsp;
</div>

<br/><br/>

<div id="buttonGroups">
	<button type="button" class="btn btn-w-m btn-primary btn-gray" id="checkAll" name="checkAll" onClick="clickButton.allCheck();">전체 체크</button>
	<button type="button" class="btn btn-w-m btn-primary btn-gray" id="uncheckAll" name="uncheckAll" onClick="clickButton.allUnCheck();">전체 체크 제거</button>
	
	<!-- <button type="button" class="btn btn-w-m btn-primary btn-gray" id="getDashBoardList" name="getDashBoardList" onClick="clickButton.getCalendarEventDashBoard();"> 조회 </button> -->
	<button type="button" class="btn btn-w-m btn-primary btn-gray" id="getDashBoardList" name="getDashBoardList" onClick="checkBoxCnt.check();">검색</button>
</div>
</form>

<br /><br />
<br /><br />
<br /><br />

<div class="row">
	<div class="col-lg-4 pd-no" id="calendarEventDashBoard" style="display:none">
	    <div class="ibox float-e-margins">
			<div id="dd1" class="dd-demo">
		        <div class="ibox-title landing-header">
		            <h5>일정</h5>
		
		            <div class="pull-right day-nav">
		                <button class="btn btn-white btn-sm" onClick="clickButton.timeLineAddDate('m');"><i class="fa fa-arrow-left"></i></button>
		                <strong id="timeLineViewDate"></strong><strong id="timeLineDate" style="display: none;"></strong>
		                <button class="btn btn-white btn-sm" onClick="clickButton.timeLineAddDate('p');"><i class="fa fa-arrow-right"></i></button>
		            </div>
		        </div>
	        
		        <div class="ibox-content" id="divTimeLine">
		        </div>
			</div>
		</div>
    </div>
    
    <!-- 영업활동 -->
     <div class="col-lg-4" id="opportunityDashBoard" style="display:none">
         <div class="ibox float-e-margins">
         	<div id="dd2" class="dd-demo">
	             <div class="ibox-title landing-header"><h5>영업기회 / 잠재기회</h5></div>
	             
	             <div class="ibox-content no-padding landing-act" id="divSalesAct">
	             </div>
             </div>
         </div>
     </div>
     <!--// 나의 영업활동 관리 -->
    
</div>

<!-- 
<div id="sortWrap">
	<div id="dd1" class="dd-demo"></div>
	<div id="dd2" class="dd-demo"></div>
	<div id="dd3" class="dd-demo"></div>
</div>
 -->
 
<script type="text/javascript" src="http://www.w3cschool.cc/try/jeasyui/jquery.easyui.min.js"></script>
	<style type="text/css">
		.dd-demo{
			width:280px;
			height:250px;
			border:2px solid #d3d3d3;
			position:absolute;
		}
		.proxy{
			border:1px dotted #333;
			width:60px;
			height:60px;
			text-align:center;
			background:#fafafa;
		}
		#dd1{
			background:#E0ECFF;
			left:100px;
			top:50px;
		}
		#dd2{
			background:#8DB2E3;
			left:100px;
			top:50px;
		}
		#dd3{
			background:#FBEC88;
			left:180px;
			top:20px;
		}
	</style>
	
	
	<script type="text/javascript">
	
	var currentDate = moment().format('YYYY-MM-DD');
	var currentViewDate = moment().format('MM월D일');
	
	
	$(document).ready(function() {
		$('#timeLineDate').html(currentDate);
		$('#timeLineViewDate').html(currentViewDate);
		
		
	});
	
	var checkBoxCnt = {
			
			check : function()
			{
				//일정
				if($("input[id=box1]:checkbox").is(":checked")){
					clickButton.getCalendarEventDashBoard();
				}
				else{
					//숨기기
					document.getElementById("calendarEventDashBoard").style.display="none";
				}
				
				//영업기회
				if($("input[id=box2]:checkbox").is(":checked")){
					clickButton.selectSalesAct();
				}
				else{
					//숨기기
					document.getElementById("opportunityDashBoard").style.display="none";
				}
				
				//고객이슈
				if($("input[id=box3]:checkbox").is(":checked")){
					alert("고객이슈안했지롱");
				}
				else{
					
				}
				
				//TRACKING
				if($("input[id=box4]:checkbox").is(":checked")){
					alert("트래킹안했지롱");
				}else{
					
				}
				
			}
	}
	

	
	var clickButton = {
			allCheck : function()
			{
				alert("111");
				// 체크 박스 모두 체크
				$("input[name=box]:checkbox").each(function() {
					$(this).attr("checked", true);
				});
			},
			
			allUnCheck : function()
			{
				alert("2222");
				// 체크 박스 모두 해제
				$("input[name=box]:checkbox").each(function() {
					$(this).attr("checked", false);
				});
			},
			
			
			//나의 오늘 일정 좌우 버튼
			timeLineAddDate : function(s){
				var timeLineDatae = moment($('#timeLineDate').html());
				if(s == 'p'){//더하기
					$('#timeLineDate').html(timeLineDatae.add(1,'day').format('YYYY-MM-DD'));
					$('#timeLineViewDate').html(moment($('#timeLineDate').html()).format('MM월D일'));
				}else{ //빼기
					$('#timeLineDate').html(timeLineDatae.add(-1,'day').format('YYYY-MM-DD'));
					$('#timeLineViewDate').html(moment($('#timeLineDate').html()).format('MM월D일'));
				}
				clickButton.getCalendarEventDashBoard();
			},
			
			//일정
			getCalendarEventDashBoard : function()
			{
				var params = $.param({
					datatype : 'html',
					jsp : '/dashBoard/dashBoardTimeLineAjax',
					searchDate : $('#timeLineDate').html(),
					searchMemberId : '${userInfo.MEMBER_ID_NUM}'
				});
				$.ajax({
					url : "/main/selectTimeLine.do",
					async : false,
		 			datatype : 'html',
		 			method: 'POST',
		 			data : params,
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoading();
					},
					success : function(data){
						$('#divTimeLine').html(data);
						document.getElementById("calendarEventDashBoard").style.display="block";  //보이기
//						document.getElementById("calendarEventDashBoard").style.display="none";  //숨기기
						
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			},
			
			//영업활동
			selectSalesAct : function(){
				var params = $.param({
					datatype : 'html',
					jsp : '/dashBoard/dashBoardSalesActAjax',
					searchMemberId : '${userInfo.MEMBER_ID_NUM}'
				});
				$.ajax({
					url : "/main/selectSalesAct.do",
					async : false,
		 			datatype : 'html',
		 			method: 'POST',
		 			data : params,
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoading();
					},
					success : function(data){
						$('#divSalesAct').html(data);
						document.getElementById("opportunityDashBoard").style.display="block";  //보이기
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			},
	}
	
	
	var main = {
			
			goSalesAct : function(pk,code){
				var openNewWindow = window.open("about:blank");
				switch (code) {
				case "고객이슈":
					menuCookieSet("고객이슈"); //메뉴 활성화
					openNewWindow.location.href = "/clientSatisfaction/viewClientIssueList.do?issue_id="+pk;
					break;
				case "영업기회":
					menuCookieSet("영업기회"); //메뉴 활성화
					openNewWindow.location.href = "/clientSalesActive/viewOpportunityList.do?opportunity_id="+pk;
					break;
				case "잠재영업기회":
					menuCookieSet("잠재영업기회"); //메뉴 활성화
					openNewWindow.location.href = "/clientSalesActive/viewHiddenOpportunityList.do?opportunity_hidden_id="+pk;
					break;
				}
			},
			
			goTimeLine : function(EVENT_ID){
				var openNewWindow = window.open("about:blank");
				openNewWindow.location.href = "/calendar/viewCalendar.do?notice_event_id="+EVENT_ID;
			},
			
	}
	
	$(function(){
		$('#dd1').draggable();
		$('#dd2').draggable();
		/* 
		$('#dd3').draggable({
			proxy:function(source){
				var p = $('<div class="proxy">뭔데</div>');
				p.appendTo('body');
				return p;
			}
		});
		 */
	});
	</script>
<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>
