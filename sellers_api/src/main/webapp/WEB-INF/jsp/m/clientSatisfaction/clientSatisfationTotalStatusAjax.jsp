<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<ul>
	<li>
		<span class="ti fl_l">총 조사건수</span>
		<span class="count fl_r">
			<span class="va_m">${selectClientSatisfactionTotalStatus.TOTAL_CNT}</span>
			<span class="fs12">건</span>
		</span>
	</li>
	<li>
		<span class="ti fl_l">평점</span>
		<span class="count fl_r">
			<span class="va_m">${selectClientSatisfactionTotalStatus.SATISFACTION_AVG}</span>
			<span class="fs12">점</span>
		</span>
	</li>
</ul>
<%-- <ul>
	<li>
		<span class="ti fl_l">진행중</span>
		<span class="count fl_r">
			<span class="va_m">${selectClientSatisfactionTotalStatus.IN_PROGRESS}</span>
			<span class="fs12">건</span>
		</span>
	</li>
	<li>
		<span class="ti fl_l">완료</span>
		<span class="count fl_r">
			<span class="va_m">${selectClientSatisfactionTotalStatus.COMPLETE_CNT}</span>
			<span class="fs12">건</span>
		</span>
	</li>
</ul> --%>