<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="comment-pop" style="z-index: 999;">
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
                    <textarea placeholder="댓글 입력&#13;&#10;Enter : 줄바꿈, Shift+Enter : 입력" class="form-control" rows="" cols="" id="textModalCoachingTalk" name="textModalCoachingTalk" style="resize: none;"></textarea>
                    <button type="button" class="btn" onclick="coachingTalk.submit();" id="buttonCoachingTalkSave" disabled="disabled">입력</button>
                    <!-- <button type="button" class="btn btn-w-m btn-seller" onclick="coachingTalk.selectCoachingTalk();" id="buttonCoachingTalkSave">새로고침</button> -->
                </div>
            </div>
        </div>
    </div>
</div>

<input type="hidden" name="hiddenModalCoachingTalkId" id="hiddenModalCoachingTalkId"/>

<script src="${pageContext.request.contextPath}/js/m/view/common/coachingTalk.js"></script>
