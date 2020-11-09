<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>							

<c:choose>
<c:when test="${fn:length(userTrackingOption) > 0}">
	<c:forEach items="${userTrackingOption}" var="rows">
	<tr class="">
		<td name="cols_TRACKING_CATEGORY_NAME">${rows.TRACKING_CATEGORY_NAME}</td>
		
		<c:choose>
		<c:when test="${rows.FULL_USE_YN eq 'N' }">
			<td name="cols_FULL_USE_YN">
			<select onchange="list.changeSelectFullUseYn(this);">
				<option value="Y">Y</option>
				<option value="N" selected="selected">N</option>
			</select>
			</td>
			<td name="cols_ALARM_USE_YN">
			<select name="TableAlarmUseYnName" onchange="list.changeSelectDetailUseYn(this);">
				<option value="Y">Y</option>
				<option value="N" selected="selected">N</option>
			</select>
			</td>
			<td name="cols_MAIL_USE_YN">
			<select name="TableMailUseYnName" onchange="list.changeSelectDetailUseYn(this);">
				<option value="Y">Y</option>
				<option value="N" selected="selected">N</option>
			</select>
			</td>
			<td name="cols_MOBILE_USE_YN">
			<select name="TableMobileUseYnName" onchange="list.changeSelectDetailUseYn(this);">
				<option value="Y">Y</option>
				<option value="N" selected="selected">N</option>
			</select>
			</td>
		</c:when>
		<c:otherwise>
			<td name="cols_FULL_USE_YN">
			<select onchange="list.changeSelectFullUseYn(this);">
				<option value="Y" selected="selected">Y</option>
				<option value="N">N</option>
			</select>
			</td>
			
			<c:choose>
			<c:when test="${rows.ALARM_USE_YN eq 'N' }">
				<td name="cols_ALARM_USE_YN">
				<select name="TableAlarmUseYnName" onchange="list.changeSelectDetailUseYn(this);">
					<option value="Y">Y</option>
					<option value="N" selected="selected">N</option>
				</select>
				</td>
			</c:when>
			<c:otherwise>
				<td name="cols_ALARM_USE_YN">
				<select name="TableAlarmUseYnName" onchange="list.changeSelectDetailUseYn(this);">
					<option value="Y" selected="selected">Y</option>
					<option value="N">N</option>
				</select>
				</td>
			</c:otherwise>
			</c:choose>
			<c:choose>
			<c:when test="${rows.MAIL_USE_YN eq 'N' }">
				<td name="cols_MAIL_USE_YN">
				<select name="TableMailUseYnName" onchange="list.changeSelectDetailUseYn(this);">
					<option value="Y">Y</option>
					<option value="N" selected="selected">N</option>
				</select>
				</td>
			</c:when>
			<c:otherwise>
				<td name="cols_MAIL_USE_YN">
				<select name="TableMailUseYnName" onchange="list.changeSelectDetailUseYn(this);">
					<option value="Y" selected="selected">Y</option>
					<option value="N">N</option>
				</select>
				</td>
			</c:otherwise>
			</c:choose>
			<c:choose>
			<c:when test="${rows.MOBILE_USE_YN eq 'N' }">
				<td name="cols_MOBILE_USE_YN">
				<select name="TableMobileUseYnName" onchange="list.changeSelectDetailUseYn(this);">
					<option value="Y">Y</option>
					<option value="N" selected="selected">N</option>
				</select>
				</td>
			</c:when>
			<c:otherwise>
				<td name="cols_MOBILE_USE_YN">
				<select name="TableMobileUseYnName" onchange="list.changeSelectDetailUseYn(this);">
					<option value="Y" selected="selected">Y</option>
					<option value="N">N</option>
				</select>
				</td>
			</c:otherwise>
			</c:choose>
			
		</c:otherwise>
		</c:choose>
		
		<c:choose>
		<c:when test="${rows.FRQNC_BEFROE_USE_YN eq 'Y' }">
			<c:choose>
			<c:when test="${rows.FRQNC_BEFROE ne null and rows.FRQNC_BEFROE ne '' }">
			<td name="cols_BEFORE_DUE_RULE">각각 ${rows.FRQNC_BEFROE}일 전마다 알림 
			<span class="label black_count_bg" style="cursor: pointer;" data-toggle="modal" data-target="#userTrackingOptionSetup" onClick="list.goDetail(this, 'bf');"><i class="fa fa-gear"></i></span>
			</td>
			</c:when>
			<c:otherwise>
			<td name="cols_BEFORE_DUE_RULE">알림 없음 
			<span class="label black_count_bg" style="cursor: pointer;" data-toggle="modal" data-target="#userTrackingOptionSetup" onClick="list.goDetail(this, 'bf');"><i class="fa fa-gear" onClick="list.goDetail(this);"></i></span>
			</td>
			</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>
			<c:choose>
			<c:when test="${rows.BEFORE_DUE_DATE > 0 }">
			<td name="cols_BEFORE_DUE_RULE">${rows.BEFORE_DUE_DATE}일 전부터 매일 알림 
			<span class="label black_count_bg" style="cursor: pointer;"data-toggle="modal" data-target="#userTrackingOptionSetup" onClick="list.goDetail(this, 'bf');"><i class="fa fa-gear"></i></span>
			</td>
			</c:when>
			<c:otherwise>
			<td name="cols_BEFORE_DUE_RULE">알림 없음 
			<span class="label black_count_bg" style="cursor: pointer;" data-toggle="modal" data-target="#userTrackingOptionSetup" onClick="list.goDetail(this, 'bf');"><i class="fa fa-gear" onClick="list.goDetail(this);"></i></span>
			</td>
			</c:otherwise>
			</c:choose>
		</c:otherwise>
		</c:choose>
		
		<c:choose>
		<c:when test="${rows.FRQNC_AFTER_USE_YN eq 'Y' }">
			<c:choose>
			<c:when test="${rows.FRQNC_AFTER ne null and rows.FRQNC_AFTER ne '' }">
			<td name="cols_AFTER_DUE_RULE">각각 ${rows.FRQNC_AFTER}일 후마다 알림 
			<span class="label black_count_bg" style="cursor: pointer;" data-toggle="modal" data-target="#userTrackingOptionSetup" onClick="list.goDetail(this, 'af');"><i class="fa fa-gear"></i></span>
			</td>
			</c:when>
			<c:otherwise>
			<td name="cols_AFTER_DUE_RULE">알림 없음 
			<span class="label black_count_bg" style="cursor: pointer;" data-toggle="modal" data-target="#userTrackingOptionSetup" onClick="list.goDetail(this, 'af');"><i class="fa fa-gear"></i></span>
			</td>
			</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>
			<c:choose>
			<c:when test="${rows.AFTER_DUE_DATE > 0 }">
			<td name="cols_AFTER_DUE_RULE">${rows.AFTER_DUE_DATE}일 후까지 매일 알림 
			<span class="label black_count_bg" style="cursor: pointer;" data-toggle="modal" data-target="#userTrackingOptionSetup" onClick="list.goDetail(this, 'af');"><i class="fa fa-gear"></i></span>
			</td>
			</c:when>
			<c:otherwise>
			<td name="cols_AFTER_DUE_RULE">알림 없음 
			<span class="label black_count_bg" style="cursor: pointer;" data-toggle="modal" data-target="#userTrackingOptionSetup" onClick="list.goDetail(this, 'af');"><i class="fa fa-gear"></i></span>
			</td>
			</c:otherwise>
			</c:choose>
		</c:otherwise>
		</c:choose>
		<td name="cols_USER_TRACKING_OPTION" style="display: none;">
			<input type="hidden" id="hiddenTableUserTrackingId" name="hiddenTableUserTrackingId" value="${rows.COM_USER_TRACKING_ID}">
			<input type="hidden" id="hiddenTableUserMemIdNumId" name=hiddenTableUserMemIdNumId value="${rows.MEMBER_ID_NUM}">
			<input type="hidden" id="hiddenTableTrackingCategory" name=hiddenTableTrackingCategory value="${rows.TRACKING_CATEGORY}">
			<input type="hidden" id="hiddenTableTrackingCategoryName" name=hiddenTableTrackingCategoryName value="${rows.TRACKING_CATEGORY_NAME}">
			<input type="hidden" id="hiddenTableFullUseYn" name="hiddenTableFullUseYn" value="${rows.FULL_USE_YN}">
			<input type="hidden" id="hiddenTableAlarmUseYn" name="hiddenTableAlarmUseYn" value="${rows.ALARM_USE_YN}">
			<input type="hidden" id="hiddenTableMailUseYn" name="hiddenTableMailUseYn" value="${rows.MAIL_USE_YN}">
			<input type="hidden" id="hiddenTableMobileUseYn" name="hiddenTableMobileUseYn" value="${rows.MOBILE_USE_YN}">
			<input type="hidden" id="hiddenTableBeforeDueDate" name="hiddenTableBeforeDueDate" value="${rows.BEFORE_DUE_DATE}">
			<input type="hidden" id="hiddenTableAfterDueDate" name="hiddenTableAfterDueDate" value="${rows.AFTER_DUE_DATE}">
			<input type="hidden" id="hiddenTableFrqncBeforeUseYn" name="hiddenTableFrqncBeforeUseYn" value="${rows.FRQNC_BEFROE_USE_YN}">
			<input type="hidden" id="hiddenTableFrqncBefore" name="hiddenTableFrqncBefore" value="${rows.FRQNC_BEFROE}">
			<input type="hidden" id="hiddenTableFrqncAfterUseYn" name="hiddenTableFrqncAfterUseYn" value="${rows.FRQNC_AFTER_USE_YN}">
			<input type="hidden" id="hiddenTableFrqncAfter" name="hiddenTableFrqncAfter" value="${rows.FRQNC_AFTER}">
		</td>
    </c:forEach>
</c:when>
<c:otherwise>
	<tr>
		<td colspan="7" style="text-align:center;">No Data</td>
	</tr>
</c:otherwise>
</c:choose>
