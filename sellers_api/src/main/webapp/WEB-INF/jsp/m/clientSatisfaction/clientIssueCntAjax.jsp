<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<ul>
	<li><span class="ti fl_l">총 이슈건수</span> <span class="count fl_r">
			<span class="va_m fc_gray">${selectClientIssueStatusCount.ISSUE_STATUS_1 + selectClientIssueStatusCount.ISSUE_STATUS_2 + selectClientIssueStatusCount.ISSUE_STATUS_3}</span>
			<span class="fs12 fc_gray">건</span>
	</span></li>
	<li><span class="ti fl_l">진행중</span> <span class="count fl_r">
			<span class="va_m">${selectClientIssueStatusCount.ISSUE_STATUS_1}</span>
			<span class="fs12">건</span>
	</span></li>
</ul>

<ul>
	<li><span class="ti fl_l">지연</span> <span class="count fl_r">
			<span class="va_m fc_red">${selectClientIssueStatusCount.ISSUE_STATUS_2}</span>
			<span class="fs12 fc_red">건</span>
	</span></li>
	<li><span class="ti fl_l">완료</span> <span class="count fl_r">
			<span class="va_m fc_gray">${selectClientIssueStatusCount.ISSUE_STATUS_3}</span>
			<span class="fs12 fc_gray">건</span>
	</span></li>
</ul>