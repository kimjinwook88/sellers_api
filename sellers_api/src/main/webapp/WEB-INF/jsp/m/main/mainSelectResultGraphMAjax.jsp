<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<h2 class="title">영업실적 (누적)</h2>
<div class="total_year_result">
<c:choose>
	<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
	<ul class="stat_list mg_b20">
		<c:choose>
			<c:when test="${fn:length(list) > 0}">
				<li>
					<h2 class="no-margins">
						<strong class="ti">${list.VIEW_NAME}</strong> 
						<span class="top_count">
							Target : <fmt:formatNumber value="${list.TARGET_REV/1000000}" type="currency" currencySymbol=""/>(REV) /
										<fmt:formatNumber value="${list.TARGET_GP/1000000}" type="currency" currencySymbol=""/>(GP) / 
										<span class="fs11">단위 : 백만원</span>
						</span>
					</h2>
				</li>
		
				<li>
					<h2 class="subtitle">
						<span class="sub">REV</span>
						<span class="count">
							<fmt:formatNumber value="${list.ACTUAL_REV_AMOUNT/1000000}" type="currency" currencySymbol=""/>
							<fmt:parseNumber var="ara" integerOnly="true" value="${list.ACTUAL_REV_AMOUNT/1000000}"/>
							<fmt:parseNumber var="tr" integerOnly="true" value="${list.TARGET_REV/1000000}"/>
							<c:choose>
								<c:when test="${list.TARGET_REV > 0}">
									<fmt:formatNumber var="revPer" pattern="0" value="${(ara/tr)*100}"/>
									<span class="stat-percent">(${revPer}%)</span>
								</c:when>
								<c:otherwise>
									<fmt:parseNumber var="revPer" integerOnly="true" value="100"/>
									<span class="stat-percent">(${revPer}%)</span>
								</c:otherwise>
							</c:choose>
						</span>
					</h2>
					<div class="result_total_track">
						<div class="result_progress">
							<div style="width:${revPer}%;" class="bar rev_color"></div>
							<div class="line_100"></div>
						</div>
					</div>
				</li>
		
				<li>
					<h2 class="subtitle">
						<span class="sub">GP</span>
						<span class="count">
							<fmt:formatNumber value="${list.ACTUAL_GP_AMOUNT/1000000}" type="currency" currencySymbol=""/>
							<fmt:parseNumber var="aga" integerOnly="true" value="${list.ACTUAL_GP_AMOUNT/1000000}"/>
							<fmt:parseNumber var="tg" integerOnly="true" value="${list.TARGET_GP/1000000}"/>
							<c:choose>
								<c:when test="${list.TARGET_GP > 0}">
									<fmt:formatNumber var="gpPer" pattern="0" value="${(aga/tg)*100}"/>
									<span class="stat-percent">(${gpPer}%)</span>
								</c:when>
								<c:otherwise>
									<fmt:parseNumber var="gpPer" integerOnly="true" value="100"/>
									<span class="stat-percent">(${gpPer}%)</span>
								</c:otherwise>
							</c:choose>
						</span>
					</h2>
					<div class="result_total_track">
						<div class="result_progress">
							<div style="width:${gpPer}%;" class="bar gp_color"></div>
							<div class="line_100"></div>
						</div>
					</div>
				</li>
			</c:when>
			<c:otherwise>
				<hr style="border: groove; 2px; black;">
				<li style="text-align: center;"><strong>데이터가 없습니다.</strong></li>
			</c:otherwise>
		</c:choose>
	</ul>
	</c:when>
	
	<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
	<ul class="stat_list mg_b20">
		<c:choose>
			<c:when test="${fn:length(list) > 0}">
				<li>
					<h2 class="no-margins">
						<strong class="ti">${list.VIEW_NAME}</strong> 
						<span class="top_count">
							Target : <fmt:formatNumber value="${list.TARGET_REV/1000000}" type="currency" currencySymbol=""/>(REV) /
										<fmt:formatNumber value="${list.TARGET_GP/1000000}" type="currency" currencySymbol=""/>(GP) / 
										<span class="fs11">단위 : 백만원</span>
						</span>
					</h2>
				</li>
		
				<li>
					<h2 class="subtitle">
						<span class="sub">REV</span>
						<span class="count">
							<fmt:formatNumber value="${list.ACTUAL_REV_AMOUNT/1000000}" type="currency" currencySymbol=""/>
							<fmt:parseNumber var="ara" integerOnly="true" value="${list.ACTUAL_REV_AMOUNT/1000000}"/>
							<fmt:parseNumber var="tr" integerOnly="true" value="${list.TARGET_REV/1000000}"/>
							<c:choose>
								<c:when test="${list.TARGET_REV > 0}">
									<fmt:formatNumber var="revPer" pattern="0" value="${(ara/tr)*100}"/>
									<span class="stat-percent">(${revPer}%)</span>
								</c:when>
								<c:otherwise>
									<fmt:parseNumber var="revPer" integerOnly="true" value="100"/>
									<span class="stat-percent">(${revPer}%)</span>
								</c:otherwise>
							</c:choose>
						</span>
					</h2>
					<div class="result_total_track">
						<div class="result_progress">
							<div style="width:${revPer}%;" class="bar rev_color"></div>
							<div class="line_100"></div>
						</div>
					</div>
				</li>
		
				<li>
					<h2 class="subtitle">
						<span class="sub">GP</span>
						<span class="count">
							<fmt:formatNumber value="${list.ACTUAL_GP_AMOUNT/1000000}" type="currency" currencySymbol=""/>
							<fmt:parseNumber var="aga" integerOnly="true" value="${list.ACTUAL_GP_AMOUNT/1000000}"/>
							<fmt:parseNumber var="tg" integerOnly="true" value="${list.TARGET_GP/1000000}"/>
							<c:choose>
								<c:when test="${list.TARGET_GP > 0}">
									<fmt:formatNumber var="gpPer" pattern="0" value="${(aga/tg)*100}"/>
									<span class="stat-percent">(${gpPer}%)</span>
								</c:when>
								<c:otherwise>
									<fmt:parseNumber var="gpPer" integerOnly="true" value="100"/>
									<span class="stat-percent">(${gpPer}%)</span>
								</c:otherwise>
							</c:choose>
						</span>
					</h2>
					<div class="result_total_track">
						<div class="result_progress">
							<div style="width:${gpPer}%;" class="bar gp_color"></div>
							<div class="line_100"></div>
						</div>
					</div>
				</li>
			</c:when>
			<c:otherwise>
				<hr style="border: groove; 2px; black;">
				<li style="text-align: center;"><strong>데이터가 없습니다.</strong></li>
			</c:otherwise>
		</c:choose>
	</ul>
	</c:when>
	
	<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
	<ul class="stat_list mg_b20">
		<c:choose>
			<c:when test="${fn:length(list4) > 0}">
				<li>
					<h2 class="no-margins">
						<strong class="ti">${list4.VIEW_NAME}</strong> 
						<span class="top_count">
							Target : <fmt:formatNumber value="${list4.TARGET_REV/1000000}" type="currency" currencySymbol=""/>(REV) /
										<fmt:formatNumber value="${list4.TARGET_GP/1000000}" type="currency" currencySymbol=""/>(GP) / 
										<span class="fs11">단위 : 백만원</span>
						</span>
					</h2>
				</li>
		
				<li>
					<h2 class="subtitle">
						<span class="sub">REV</span>
						<span class="count">
							<fmt:formatNumber value="${list4.ACTUAL_REV_AMOUNT/1000000}" type="currency" currencySymbol=""/>
							<fmt:parseNumber var="ara" integerOnly="true" value="${list4.ACTUAL_REV_AMOUNT/1000000}"/>
							<fmt:parseNumber var="tr" integerOnly="true" value="${list4.TARGET_REV/1000000}"/>
							<c:choose>
								<c:when test="${list4.TARGET_REV > 0}">
									<fmt:formatNumber var="revPer" pattern="0" value="${(ara/tr)*100}"/>
									<span class="stat-percent">(${revPer}%)</span>
								</c:when>
								<c:otherwise>
									<fmt:parseNumber var="revPer" integerOnly="true" value="100"/>
									<span class="stat-percent">(${revPer}%)</span>
								</c:otherwise>
							</c:choose>
						</span>
					</h2>
					<div class="result_total_track">
						<div class="result_progress">
							<div style="width:${revPer}%;" class="bar rev_color"></div>
							<div class="line_100"></div>
						</div>
					</div>
				</li>
		
				<li>
					<h2 class="subtitle">
						<span class="sub">GP</span>
						<span class="count">
							<fmt:formatNumber value="${list4.ACTUAL_GP_AMOUNT/1000000}" type="currency" currencySymbol=""/>
							<fmt:parseNumber var="aga" integerOnly="true" value="${list4.ACTUAL_GP_AMOUNT/1000000}"/>
							<fmt:parseNumber var="tg" integerOnly="true" value="${list4.TARGET_GP/1000000}"/>
							<c:choose>
								<c:when test="${list4.TARGET_GP > 0}">
									<fmt:formatNumber var="gpPer" pattern="0" value="${(aga/tg)*100}"/>
									<span class="stat-percent">(${gpPer}%)</span>
								</c:when>
								<c:otherwise>
									<fmt:parseNumber var="gpPer" integerOnly="true" value="100"/>
									<span class="stat-percent">(${gpPer}%)</span>
								</c:otherwise>
							</c:choose>
						</span>
					</h2>
					<div class="result_total_track">
						<div class="result_progress">
							<div style="width:${gpPer}%;" class="bar gp_color"></div>
							<div class="line_100"></div>
						</div>
					</div>
				</li>
			</c:when>
			<c:otherwise>
				<hr style="border: groove; 2px; black;">
				<li style="text-align: center;"><strong>데이터가 없습니다.</strong></li>
			</c:otherwise>
		</c:choose>
	</ul>
	</c:when>
	
	<c:otherwise>
	<ul class="stat_list mg_b20">
		<c:choose>
			<c:when test="${fn:length(list) > 0}">
				<li>
					<h2 class="no-margins">
						<strong class="ti">${list.VIEW_NAME}</strong> 
						<span class="top_count">
							Target : <fmt:formatNumber value="${list.TARGET_REV/1000000}" type="currency" currencySymbol=""/>(REV) /
										<fmt:formatNumber value="${list.TARGET_GP/1000000}" type="currency" currencySymbol=""/>(GP) / 
										<span class="fs11">단위 : 백만원</span>
						</span>
					</h2>
				</li>
		
				<li>
					<h2 class="subtitle">
						<span class="sub">REV</span>
						<span class="count">
							<fmt:formatNumber value="${list.ACTUAL_REV_AMOUNT/1000000}" type="currency" currencySymbol=""/>
							<fmt:parseNumber var="ara" integerOnly="true" value="${list.ACTUAL_REV_AMOUNT/1000000}"/>
							<fmt:parseNumber var="tr" integerOnly="true" value="${list.TARGET_REV/1000000}"/>
							<c:choose>
								<c:when test="${list.TARGET_REV > 0}">
									<fmt:formatNumber var="revPer" pattern="0" value="${(ara/tr)*100}"/>
									<span class="stat-percent">(${revPer}%)</span>
								</c:when>
								<c:otherwise>
									<fmt:parseNumber var="revPer" integerOnly="true" value="100"/>
									<span class="stat-percent">(${revPer}%)</span>
								</c:otherwise>
							</c:choose>
						</span>
					</h2>
					<div class="result_total_track">
						<div class="result_progress">
							<div style="width:${revPer}%;" class="bar rev_color"></div>
							<div class="line_100"></div>
						</div>
					</div>
				</li>
		
				<li>
					<h2 class="subtitle">
						<span class="sub">GP</span>
						<span class="count">
							<fmt:formatNumber value="${list.ACTUAL_GP_AMOUNT/1000000}" type="currency" currencySymbol=""/>
							<fmt:parseNumber var="aga" integerOnly="true" value="${list.ACTUAL_GP_AMOUNT/1000000}"/>
							<fmt:parseNumber var="tg" integerOnly="true" value="${list.TARGET_GP/1000000}"/>
							<c:choose>
								<c:when test="${list.TARGET_GP > 0}">
									<fmt:formatNumber var="gpPer" pattern="0" value="${(aga/tg)*100}"/>
									<span class="stat-percent">(${gpPer}%)</span>
								</c:when>
								<c:otherwise>
									<fmt:parseNumber var="gpPer" integerOnly="true" value="100"/>
									<span class="stat-percent">(${gpPer}%)</span>
								</c:otherwise>
							</c:choose>
						</span>
					</h2>
					<div class="result_total_track">
						<div class="result_progress">
							<div style="width:${gpPer}%;" class="bar gp_color"></div>
							<div class="line_100"></div>
						</div>
					</div>
				</li>
			</c:when>
			<c:otherwise>
				<hr style="border: groove; 2px; black;">
				<li style="text-align: center;"><strong>데이터가 없습니다.</strong></li>
			</c:otherwise>
		</c:choose>
	</ul>
	</c:otherwise>
	
</c:choose>
	<div id="graph2"></div>
</div>