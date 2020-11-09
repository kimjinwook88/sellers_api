<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="comment-pop" style="z-index: 999;">
	<div class="pop-header">
	    <button type="button" class="close" onclick="coachingTalk.view();"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	    <strong class="pop-title">Coaching Talk</strong>
	</div>
	<div class="col-sm-12 cont">
	    <div class="form-group">
	        <div class="col-sm-12">
	
	            <!-- 미확인 메시지 카운트  -->
	            <!-- <div class="yet-msg-count">읽지않은 메시지 : <strong>21개</strong></div> -->
	            <!--// 미확인 메시지 카운트  -->
	
	            <div class="comment_txt" id="divModalCoachingTalkView">
	
	                <!-- <div class="comment_along">
	                    <span class="writer">홍길동</span>
	                    <span class="msg">안녕하세요. ^^</span>                                                                    
	                    <span class="date">오전 09:00</span>
	                </div>
	
	                <div class="comment_along right">
	                    <span class="writer">이상현</span>
	                    <span class="msg">네 반갑습니다. 이번 주말은 어디 좋은데 가시나요?</span>
	                    <span class="date">오전 09:10</span>
	                </div>
	
	                <div class="comment_along">
	                    <span class="writer">홍길동</span>
	                    <span class="msg">안녕하세요. 윤영씨 오늘 체육대회라고요? 열심히해서 경품 받아요 ㅎㅎ</span>
	                    <span class="date">오전 09:10</span>
	                </div>
	
	                날짜 분계선
	                <div class="day-term">(2017년 4월 21일)</div>
	                // 날짜 분계선
	
	                <div class="comment_along">
	                    <span class="writer">홍길동</span>
	                    <span class="msg">안녕하세요. ^^</span>
	                    <span class="date">오전 09:00</span>
	                </div>
	
	                <div class="comment_along right">
	                    <span class="writer">홍길동</span>
	                    <span class="msg">네 반갑습니다. 이번 주말은 어디 좋은데 가시나요?</span>
	                    <span class="date">오전 09:10</span>
	                </div>
	
	                <div class="comment_along">
	                    <span class="writer">홍길동</span>
	                    <span class="msg">안녕하세요. 윤영씨 오늘 체육대회라고요? 열심히해서 경품 받아요 ㅎㅎ</span>
	                    <span class="date">오전 09:10</span>
	                </div>
	
	                <div class="comment_along right">
	                    <span class="writer">홍길동</span>
	                    <span class="msg">네 반갑습니다. 이번 주말은 어디 좋은데 가시나요? 네 반갑습니다. 이번 주말은 어디 좋은데 가시나요?</span>
	                    <span class="date">오전 09:10</span>
	                </div>
	
	                <div class="comment_along">
	                    <span class="writer">홍길동</span>
	                    <span class="msg">안녕하세요. ^^</span>                                                                    
	                    <span class="date">오전 09:10</span>
	                </div>
	
	                날짜 분계선
	                <div class="day-term">(2017년 4월 22일)</div>
	                // 날짜 분계선
	
	                <div class="comment_along right">
	                    <span class="writer">이상현</span>
	                    <span class="msg">네 반갑습니다. 이번 주말은 어디 좋은데 가시나요? 오늘같이 화창한 날 바닷가 보고싶구만. 바로 예약해야겠다.</span>
	                    <span class="date">오전 09:10</span>
	                </div>
	
	                <div class="comment_along">
	                    <span class="writer">이상현</span>
	                    <span class="msg">안녕하세요.</span>
	                    <span class="date">오전 09:10</span>
	                </div>
	
	                <div class="comment_along right">
	                    <span class="writer">이상현</span>
	                    <span class="msg">네 반갑습니다. 이번 주말은 어디 좋은데 가시나요?</span>
	                    <span class="date">오전 09:10</span>
	                </div> -->
	
	            </div>
	        </div>
	    </div>
	</div>
	<div class="col-sm-12 cont">
	    <div class="form-group">
	        <div class="col-sm-12">
	            <div class="comment-insert mg-b5"><!-- 검색 -->
	            	<a type="button" class="ag_l" onclick="coachingTalk.selectCoachingTalk();"><i class="fa fa-refresh"></i></a>
                    <!-- <input type="text" placeholder="댓글 입력" class="form-control" id="textModalCoachingTalk" name="textModalCoachingTalk"> -->
                    <textarea placeholder="댓글 입력
Enter : 줄바꿈, Shift+Enter : 입력" class="form-control" rows="" cols="" id="textModalCoachingTalk" name="textModalCoachingTalk" style="resize: none;"></textarea>
                    <button type="button" class="btn" onclick="coachingTalk.submit();" id="buttonCoachingTalkSave" disabled="disabled">입력</button>
                    <!-- <button type="button" class="btn btn-w-m btn-seller" onclick="coachingTalk.selectCoachingTalk();" id="buttonCoachingTalkSave">새로고침</button> -->
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 코칭톡 start -->
<!-- <div class="hr-line-dashed"></div>
<div class="form-group">
	<div id="divModalCoachingTalkView"></div>
</div>
<div class="form-group"><label class="col-sm-2 control-label">코칭톡</label>
    <div class="col-sm-10"><textarea class="pop-textarea-input" rows="3" id="textModalCoachingTalk" name="textModalCoachingTalk"></textarea></div>
</div>
 
<p class="text-center pd-t20">
<button type="button" class="btn btn-outline btn-primary btn-gray-outline">삭제하기</button>                                        
	<button type="button" class="btn btn-w-m btn-seller" onclick="coachingTalk.submit();" id="buttonCoachingTalkSave">코칭톡 저장</button>
	<button type="button" class="btn btn-w-m btn-seller" onclick="coachingTalk.selectCoachingTalk();" id="buttonCoachingTalkSave">코칭톡 새로고침</button>
</p> -->

<input type="hidden" name="hiddenModalCoachingTalkId" id="hiddenModalCoachingTalkId"/>
      
<!-- 코칭톡 end -->

<script type="text/javascript">
$(document).ready(function(){
	$("textarea[name='textModalCoachingTalk']").keyup(function(e){
		var str = '';
		str = $("textarea[name='textModalCoachingTalk']").val().replace(/\n/g,'');
		str = str.replace(/ /gi,'');
		
		if($("textarea[name='textModalCoachingTalk']").val() == ''){
			$("#buttonCoachingTalkSave").attr('disabled',true);
		}else if(!isEmpty(str)){
			$("#buttonCoachingTalkSave").removeAttr('disabled');
		}else{
			$("#buttonCoachingTalkSave").attr('disabled',true);
		}
		
	});
	
	$("textarea[name='textModalCoachingTalk']").keypress(function(e){
		if(e.keyCode == 13 && e.shiftKey){
			if(!isEmpty($("textarea[name='textModalCoachingTalk']").val()) && $("textarea[name='textModalCoachingTalk']").val() != '\n'){
				coachingTalk.submit();
				return false;
			}else{
				$("textarea[name='textModalCoachingTalk']").val('');
				return false;
			}
		}else if(e.keyCode != 13 && e.keyCode != 32){
		}
	});
});

var coachingTalk = {
		
		category : '',
		
		view : function(category) {
			if($('#divModalCoachingTalk').css('display') == 'none'){
				if(isEmpty(coachingTalk.category)){
					coachingTalk.category = category;
				}
				coachingTalk.selectCoachingTalk();
				$('#divModalCoachingTalk').show();
			}else{
				$('#divModalCoachingTalk').hide();
				/* $('#divModalCoachingTalkView').html('');
				$('#textModalCoachingTalk').val(''); */
			}
		},
		
		selectCoachingTalk : function() {
			var params = $.param({
				datatype : 'html',
				jsp : '/common/coachingTalkModalAjax',
				category : coachingTalk.category,
				delete_yn : 'N',
				dataId : $("#hiddenModalPK").val()
			});
			
			$.ajax({
				url : "/common/selectCoachingTalk.do",
				async : false,
				datatype : 'html',
				cache : false,
				method : 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					//if(!confirm("삭제하시겠습니까?")) return false;
					$.ajaxLoadingShow();
				},
				data : params,
				success : function(data){
					$("#divModalCoachingTalkView").html(data);
					$("#divModalCoachingTalkView").scrollTop($("#divModalCoachingTalkView")[0].scrollHeight); //스크롤 하단으로 이동
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		submit : function() {
			var str = '';
			str = $("textarea[name='textModalCoachingTalk']").val().replace(/\n/g,'');
			str = str.replace(/ /gi,'');
			
			if(isEmpty(str)){
				$("#textModalCoachingTalk").focus();
			}else{
				var params = '';
				var teamMemberIdArray = [];
				var uniqueIdArray = [];
				
				switch (coachingTalk.category) {
				case 'OPP':
					if(!isEmpty($("#hiddenModalCreatorId").val())) teamMemberIdArray.push($("#hiddenModalCreatorId").val());
					if(!isEmpty($("#hiddenModalExecId").val())) teamMemberIdArray.push($("#hiddenModalExecId").val());
					if(!isEmpty($("#hiddenModalOwnerId").val())) teamMemberIdArray.push($("#hiddenModalOwnerId").val());
					if(!isEmpty($("#hiddenModalIdentifierId").val())) teamMemberIdArray.push($("#hiddenModalIdentifierId").val());
					$.each(teamMemberIdArray, function(i, el){
						if($.inArray(el, uniqueIdArray) === -1) uniqueIdArray.push(el);
					});
					
					params = $.param({
						category : coachingTalk.category,
						coachingTalk : $("#textModalCoachingTalk").val(),
						dataId : $("#hiddenModalPK").val(),
						subject : $('h4.modal-title').html(),
						talkName : '${userInfo.HAN_NAME}',
						teamMemberIdArray : uniqueIdArray.join(","),
						datatype : 'json'
					});
					break;
				case 'HOPP':
					if(!isEmpty($("#hiddenModalCreatorId").val())) teamMemberIdArray.push($("#hiddenModalCreatorId").val());
					if(!isEmpty($("#hiddenModalSalesId").val())) teamMemberIdArray.push($("#hiddenModalSalesId").val());
					$.each(teamMemberIdArray, function(i, el){
						if($.inArray(el, uniqueIdArray) === -1) uniqueIdArray.push(el);
					});
					params = $.param({
						category : coachingTalk.category,
						coachingTalk : $("#textModalCoachingTalk").val(),
						dataId : $("#hiddenModalPK").val(),
						subject : $('h4.modal-title').html(),
						talkName : '${userInfo.HAN_NAME}',
						creatorId : $("#hiddenModalCreatorId").val(),
						teamMemberIdArray : uniqueIdArray.join(","),
						datatype : 'json'
					});
					break;
				case 'ISSUE':
					if(!isEmpty($("#hiddenModalCreatorId").val())) teamMemberIdArray.push($("#hiddenModalCreatorId").val());
					if(!isEmpty($("#hiddenModalSalesId").val())) teamMemberIdArray.push($("#hiddenModalSalesId").val());
					if(!isEmpty($("#hiddenModalSolveOwnerId").val())) teamMemberIdArray.push($("#hiddenModalSolveOwnerId").val());
					$.each(teamMemberIdArray, function(i, el){
						if($.inArray(el, uniqueIdArray) === -1) uniqueIdArray.push(el);
					});
					params = $.param({
						category : coachingTalk.category,
						coachingTalk : $("#textModalCoachingTalk").val(),
						dataId : $("#hiddenModalPK").val(),
						subject : $('h4.modal-title').html(),
						talkName : '${userInfo.HAN_NAME}',
						creatorId : $("#hiddenModalCreatorId").val(),
						teamMemberIdArray : uniqueIdArray.join(","),
						datatype : 'json'
					});
					break;
				case 'CONTACT':
					if(!isEmpty($("#hiddenModalCreatorId").val())) teamMemberIdArray.push($("#hiddenModalCreatorId").val());
					$.each(teamMemberIdArray, function(i, el){
						if($.inArray(el, uniqueIdArray) === -1) uniqueIdArray.push(el);
					});
					
					params = $.param({
						category : coachingTalk.category,
						coachingTalk : $("#textModalCoachingTalk").val(),
						dataId : $("#hiddenModalPK").val(),
						subject : $('h4.modal-title').html(),
						talkName : '${userInfo.HAN_NAME}',
						creatorId : $("#hiddenModalCreatorId").val(),
						teamMemberIdArray : uniqueIdArray.join(","),
						datatype : 'json'
					});
					break;
				case 'SVPJ':
					if(!isEmpty($("#hiddenModalCreatorId").val())) teamMemberIdArray.push($("#hiddenModalCreatorId").val());
					if(!isEmpty($("#hiddenModalOurPMId").val())) teamMemberIdArray.push($("#hiddenModalOurPMId").val());
					if(!isEmpty($("#hiddenModalOurEXPMId").val())) teamMemberIdArray.push($("#hiddenModalOurEXPMId").val());
					if(!isEmpty($("#hiddenModalSalesOwnerId").val())) teamMemberIdArray.push($("#hiddenModalSalesOwnerId").val());
					if(!isEmpty($("#hiddenModalTeamMemberIdList").val())) { //팀원들 전체 코칭톡 메세지 전달
						var teamArray = $("#hiddenModalTeamMemberIdList").val().split(',');
						for(var i=0; i<teamArray.length; i++) {
							teamMemberIdArray.push(teamArray[i]);
						}
					}
					
					$.each(teamMemberIdArray, function(i, el){
						if($.inArray(el, uniqueIdArray) === -1) uniqueIdArray.push(el);
					});
					
					params = $.param({
						category : coachingTalk.category,
						coachingTalk : $("#textModalCoachingTalk").val(),
						dataId : $("#hiddenModalPK").val(),
						subject : $('h4.modal-title').html(),
						talkName : '${userInfo.HAN_NAME}',
						creatorId : $("#hiddenModalCreatorId").val(),
						teamMemberIdArray : uniqueIdArray.join(","),
						datatype : 'json'
					});
					break;
				default:
					break;
				}
				
				$.ajax({
					url : "/common/insertCoachingTalk.do",
					async : false,
					method : 'POST',
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						//if(!confirm("하시겠습니까?")) return false;
						$.ajaxLoadingShow();
					},
					data : params,
					success : function(data){
						//if(data.cnt==1){}
						$("#textModalCoachingTalk").val('');
						coachingTalk.selectCoachingTalk();
						
						switch (coachingTalk.category) {
						case 'OPP':
							oppList.get();
							break;
						case 'HOPP':
							$('tbody#row').html('');
				   			list.get();
							break;
						case 'ISSUE':
							$('tbody#row').html('');
							issueList.get();
							break;
						case 'CONTACT':
							$('tbody#row').html('');
							list.get();
							break;
						case 'SVPJ':
							$('tbody#row').html('');
							projectMGMTList.get();
							break;
						default:
							break;
						}
						
						//신규 등록 시 스크롤 맨위로 애니메이트
						$("#divModalCoachingTalkView").animate({
							scrollTop: 0
						}, 500);
						
						
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			}
		}
}
</script>