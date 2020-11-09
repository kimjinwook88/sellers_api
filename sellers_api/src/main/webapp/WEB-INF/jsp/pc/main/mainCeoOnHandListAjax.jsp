<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${fn:length(rows) > 0}">
	<div class="ceocheck full-height-scroll pd20">
		<c:forEach items="${rows}" var="rows">
	       <div class="ceocheck_row" style="cursor:pointer;" onClick="main.goCeoOnHand(${rows.OPPORTUNITY_ID})">
            <a href="#">
                <div class="left">
                    <strong class="subject">${rows.SUBJECT}</strong>
                    <span class="info">담당자: ${rows.EXEC_NAME} ${rows.FORECAST_YN} / <i class="fa fa-clock-o"></i> ${rows.SYS_UPDATE_DATE}</span>
                </div>
                <div class="status_area">
                    <c:choose>
		              	<c:when test="${rows.statusColor eq '-'}">
		              		<td name="cols_STATUS_TEXT">-</td>
		              	</c:when>
	              	<c:otherwise>
	              	
	              		<c:choose>
	              			<c:when test="${rows.statusColor eq 'G'}">
	              				<span class="label statusColor-green">완료</span>
	              			</c:when>
	              			<c:when test="${rows.statusColor eq 'Y'}">
	              				<span class="label statusColor-yellow">진행</span>
	              			</c:when>
	              			<c:when test="${rows.statusColor eq 'R'}">
	              				<span class="label statusColor-red">지연</span>
	              			</c:when>
	              		</c:choose>
	              	
	              		<%-- <td name="cols_STATUS_TEXT" style="background-color: ${rows.ISSUE_ACTION_STATUS_TEXT}"></td> --%>
	              	</c:otherwise>
	              </c:choose>
                </div>
            </a>
        </div>
	 	</c:forEach>
		</tbody>
     </table>
	</div>
	</c:when>
	<c:otherwise>
		<div style="text-align: center;padding-top:15px;" >
		    <strong>신규 및 업데이트 고객이슈가 없습니다.</strong>
		 </div>
	</c:otherwise>
</c:choose>