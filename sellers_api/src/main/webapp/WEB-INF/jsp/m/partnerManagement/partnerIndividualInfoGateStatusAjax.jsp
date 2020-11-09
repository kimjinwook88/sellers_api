<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="top_statusarea_white_bg">
	<h4>파트너 현황</h4>
	<div class="status_box mg_b20">
		<div class="row">
			<ul>
				<li><span class="ti fl_l">전체 파트너</span> <span
					class="count fl_r"> <span class="icon_dash icon_dash_human"></span>
						<span class="va_m">${totalPartnerIndividualCnt}</span>
				</span></li>
				<li><span class="ti fl_l">신규 파트너</span> <span
					class="count fl_r"> <span class="icon_dash icon_dash_human"></span>
						<span class="va_m">${partnerIndividualNewCnt}</span>
				</span></li>
			</ul>
		</div>
	</div>

	<h4>영역별 현황</h4>
	<table class="status_table" summary="">
		<caption></caption>
		<colgroup>
			<col width="" />
			<col width="" />
			<col width="" />
			<col width="" />
			<col width="" />
		</colgroup>
		<thead>
			<tr>
				<c:choose>
					<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
						<th scope="col">부서</th>
					</c:when>
					<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
						<th scope="col">부서</th>
					</c:when>
					<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
						<th scope="col">영업대표</th>
					</c:when>
					<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
						<th scope="col">영업대표</th>
					</c:when>
					<c:otherwise>
						<th scope="col">부서</th>
					</c:otherwise>
				</c:choose>
				<th scope="col">합계</th>
				<th scope="col">ReSeller</th>
				<th scope="col">SI</th>
				<th scope="col">Sol-Partner</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="rows" items="${selecetStatusByAreaList}">
				<tr>
					<c:choose>
						<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
							<th scope="row" class="ta_l">${rows.TARGET_NAME}</th>
						</c:when>
						<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
							<th scope="row" class="ta_l">${rows.TARGET_NAME}</th>
						</c:when>
						<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
							<th scope="row">${rows.TARGET_NAME}</th>
						</c:when>
						<c:when test="${fn:contains(auth, 'ROLE_MEMBER')}">
							<th scope="row">${rows.TARGET_NAME}</th>
						</c:when>
						<c:otherwise>
							<th scope="row" class="ta_l">${rows.TARGET_NAME}</th>
						</c:otherwise>
					</c:choose>

					<td>${rows.TOTAL_CNT}</td>
					<td>${rows.RESELLER_CNT}</td>
					<td>${rows.SI_CNT}</td>
					<td>${rows.PARTNER_CNT}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

</div>