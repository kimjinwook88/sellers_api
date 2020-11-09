<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div>
	<div id="tab2-2" class="tab-pane ">
		<!-- <table id="tech-companies" class="table table-bordered"> -->
		<table id="tech-companies" class="basic4_list mg-b30">
			<thead>
				<tr>
					<th rowspan="2">영업직원</th>
					<th rowspan="2">기준일수</th>
					<th colspan="2"><h4>고객컨택</h4></th>
					<th colspan="2"><h4>컨택준비</h4></th>
					<th colspan="2"><h4>내부회의</h4></th>
					<th colspan="2"><h4>교육</h4></th>
					<th colspan="2"><h4>기타</h4></th>
					<th colspan="2"><h4>휴가</h4></th>
					<th colspan="2"><h4>이동시간</h4></th>
					<th rowspan="2">소계</th>
				</tr>
				<tr id="tabTableName">
					<c:choose>
						<c:when test="${fn:length(viewType) > 0}">
							<c:forEach items="${viewType}" var="viewType">
								<th>${viewType.thisName}</th>
								<th>${viewType.lastName}</th>
							</c:forEach>
						</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${fn:length(viewType) > 0}">
							<c:forEach items="${viewType}" var="viewType">
								<th>${viewType.thisName}</th>
								<th>${viewType.lastName}</th>
							</c:forEach>
						</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${fn:length(viewType) > 0}">
							<c:forEach items="${viewType}" var="viewType">
								<th>${viewType.thisName}</th>
								<th>${viewType.lastName}</th>
							</c:forEach>
						</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${fn:length(viewType) > 0}">
							<c:forEach items="${viewType}" var="viewType">
								<th>${viewType.thisName}</th>
								<th>${viewType.lastName}</th>
							</c:forEach>
						</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${fn:length(viewType) > 0}">
							<c:forEach items="${viewType}" var="viewType">
								<th>${viewType.thisName}</th>
								<th>${viewType.lastName}</th>
							</c:forEach>
						</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${fn:length(viewType) > 0}">
							<c:forEach items="${viewType}" var="viewType">
								<th>${viewType.thisName}</th>
								<th>${viewType.lastName}</th>
							</c:forEach>
						</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${fn:length(viewType) > 0}">
							<c:forEach items="${viewType}" var="viewType">
								<th>${viewType.thisName}</th>
								<th>${viewType.lastName}</th>
							</c:forEach>
						</c:when>
					</c:choose>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${fn:length(rows) > 0}">
						<c:forEach items="${rows}" var="rows">
							<td>${rows.HAN_NAME}</td>
							<td>${rows.dayCount}</td>
							<td>${rows.THIS_EVENT_1}</td>
							<c:choose>
								<c:when test="${rows.COMPARE_EVENT_COLOR_1 eq 'red'}">
									<%-- <td style="background-color:#f7674a">${rows.COMPARE_EVENT_TIME_1}%</td> --%>
									<td><font color="#ff0015">${rows.COMPARE_EVENT_TIME_1}%</font></td>
								</c:when>
								<c:when test="${rows.COMPARE_EVENT_COLOR_1 eq 'blue'}">
									<%-- <td style="background-color:#6b92ff">${rows.COMPARE_EVENT_TIME_1}%</td> --%>
									<td><font color="#0255d3">${rows.COMPARE_EVENT_TIME_1}%</font></td>
								</c:when>
								<c:otherwise>
									<td>${rows.COMPARE_EVENT_TIME_1}%</td>
								</c:otherwise>
							</c:choose>
							<td>${rows.THIS_EVENT_2}</td>
							<c:choose>
								<c:when test="${rows.COMPARE_EVENT_COLOR_2 eq 'red'}">
									<%-- <td style="background-color:#f7674a">${rows.COMPARE_EVENT_TIME_2}%</td> --%>
									<td><font color="#ff0015">${rows.COMPARE_EVENT_TIME_2}%</font></td>
								</c:when>
								<c:when test="${rows.COMPARE_EVENT_COLOR_2 eq 'blue'}">
									<%-- <td style="background-color:#6b92ff">${rows.COMPARE_EVENT_TIME_2}%</td> --%>
									<td><font color="#0255d3">${rows.COMPARE_EVENT_TIME_2}%</font></td>
								</c:when>
								<c:otherwise>
									<td>${rows.COMPARE_EVENT_TIME_2}%</td>
								</c:otherwise>
							</c:choose>
							<td>${rows.THIS_EVENT_3}</td>
							<c:choose>
								<c:when test="${rows.COMPARE_EVENT_COLOR_3 eq 'red'}">
									<%-- <td style="background-color:#f7674a">${rows.COMPARE_EVENT_TIME_3}%</td> --%>
									<td><font color="#ff0015">${rows.COMPARE_EVENT_TIME_3}%</font></td>
								</c:when>
								<c:when test="${rows.COMPARE_EVENT_COLOR_3 eq 'blue'}">
									<%-- <td style="background-color:#6b92ff">${rows.COMPARE_EVENT_TIME_3}%</td> --%>
									<td><font color="#0255d3">${rows.COMPARE_EVENT_TIME_3}%</font></td>
								</c:when>
								<c:otherwise>
									<td>${rows.COMPARE_EVENT_TIME_3}%</td>
								</c:otherwise>
							</c:choose>
							<td>${rows.THIS_EVENT_4}</td>
							<c:choose>
								<c:when test="${rows.COMPARE_EVENT_COLOR_4 eq 'red'}">
									<%-- <td style="background-color:#f7674a">${rows.COMPARE_EVENT_TIME_4}%</td> --%>
									<td><font color="#ff0015">${rows.COMPARE_EVENT_TIME_4}%</font></td>
								</c:when>
								<c:when test="${rows.COMPARE_EVENT_COLOR_4 eq 'blue'}">
									<%-- <td style="background-color:#6b92ff">${rows.COMPARE_EVENT_TIME_4}%</td> --%>
									<td><font color="#0255d3">${rows.COMPARE_EVENT_TIME_4}%</font></td>
								</c:when>
								<c:otherwise>
									<td>${rows.COMPARE_EVENT_TIME_4}%</td>
								</c:otherwise>
							</c:choose>
							<td>${rows.THIS_EVENT_6}</td>
							<c:choose>
								<c:when test="${rows.COMPARE_EVENT_COLOR_6 eq 'red'}">
									<%-- <td style="background-color:#f7674a">${rows.COMPARE_EVENT_TIME_6}%</td> --%>
									<td><font color="#ff0015">${rows.COMPARE_EVENT_TIME_6}%</font></td>
								</c:when>
								<c:when test="${rows.COMPARE_EVENT_COLOR_6 eq 'blue'}">
									<%-- <td style="background-color:#6b92ff">${rows.COMPARE_EVENT_TIME_6}%</td> --%>
									<td><font color="#0255d3">${rows.COMPARE_EVENT_TIME_6}%</font></td>
								</c:when>
								<c:otherwise>
									<td>${rows.COMPARE_EVENT_TIME_6}%</td>
								</c:otherwise>
							</c:choose>
							<td>${rows.THIS_EVENT_7}</td>
							<c:choose>
								<c:when test="${rows.COMPARE_EVENT_COLOR_7 eq 'red'}">
									<%-- <td style="background-color:#f7674a">${rows.COMPARE_EVENT_TIME_7}%</td> --%>
									<td><font color="#ff0015">${rows.COMPARE_EVENT_TIME_7}%</font></td>
								</c:when>
								<c:when test="${rows.COMPARE_EVENT_COLOR_7 eq 'blue'}">
									<%-- <td style="background-color:#6b92ff">${rows.COMPARE_EVENT_TIME_7}%</td> --%>
									<td><font color="#0255d3">${rows.COMPARE_EVENT_TIME_7}%</font></td>
								</c:when>
								<c:otherwise>
									<td>${rows.COMPARE_EVENT_TIME_7}%</td>
								</c:otherwise>
							</c:choose>
							<td>${rows.THIS_EVENT_5}</td>
							<c:choose>
								<c:when test="${rows.COMPARE_EVENT_COLOR_5 eq 'red'}">
									<%-- <td style="background-color:#f7674a">${rows.COMPARE_EVENT_TIME_5}%</td> --%>
									<td><font color="#ff0015">${rows.COMPARE_EVENT_TIME_5}%</font></td>
								</c:when>
								<c:when test="${rows.COMPARE_EVENT_COLOR_5 eq 'blue'}">
									<%-- <td style="background-color:#6b92ff">${rows.COMPARE_EVENT_TIME_5}%</td> --%>
									<td><font color="#0255d3">${rows.COMPARE_EVENT_TIME_5}%</font></td>
								</c:when>
								<c:otherwise>
									<td>${rows.COMPARE_EVENT_TIME_5}%</td>
								</c:otherwise>
							</c:choose>
							<td>${rows.THIS_TOTAL}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="17" style="text-align: center;">No Data</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
</div>


<script type="text/javascript">

</script>