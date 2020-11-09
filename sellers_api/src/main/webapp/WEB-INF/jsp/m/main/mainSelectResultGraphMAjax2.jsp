<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${fn:contains(auth, 'ROLE_CEO')}">
		<!-- 부서,개인 실적 Progress -->
		<c:if test="${fn:length(list2) > 0}">
			<p class="lang_ti">${list2.VIEW_NAME}</p>
		</c:if>
		
		<c:set var="now" value="<%=new java.util.Date()%>" />
		<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>
		<ul class="tabmenu tabmenu_type4 mg_b10" id="tab_st">
			<li class=""><a href="javascript:void(0);" id="tab1" onclick="fncResultGraph2(1)">1분기</a></li>
			<li class=""><a href="javascript:void(0);" id="tab2" onclick="fncResultGraph2(2)">2분기</a></li>
			<li class=""><a href="javascript:void(0);" id="tab3" onclick="fncResultGraph2(3)">3분기</a></li>
			<li class=""><a href="javascript:void(0);" id="tab4" onclick="fncResultGraph2(4)">4분기</a></li>
			<%-- <li class="year" id="tab5"><a href="javascript:void(0);" onclick="fncResultGraph('${sysYear}');">${sysYear}년도</a></li> --%>
		</ul>
		
		<!-- 1분기 -->
		<div class="cont1 ">
			<ul class="stat_list">
			
				<c:choose>
					<c:when test="${fn:length(list2) > 0}">
					<li>
							<h2 class="no-margins">
								<span class="top_count">
									Target : <fmt:formatNumber value="${list2.TARGET_REV/1000000}" type="currency" currencySymbol=""/>(REV) /
												<fmt:formatNumber value="${list2.TARGET_GP/1000000}" type="currency" currencySymbol=""/>(GP) / 
												<span class="fs11">단위 : 백만원</span>
								</span>
							</h2>
						</li>
				
						<li>
							<h2 class="subtitle">
								<span class="sub">REV</span>
								<span class="count">
									<fmt:formatNumber value="${list2.ACTUAL_REV_AMOUNT/1000000}" type="currency" currencySymbol=""/>
									<fmt:parseNumber var="ara" integerOnly="true" value="${list2.ACTUAL_REV_AMOUNT/1000000}"/>
									<fmt:parseNumber var="tr" integerOnly="true" value="${list2.TARGET_REV/1000000}"/>
									<c:choose>
										<c:when test="${list2.TARGET_REV > 0}">
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
									<fmt:formatNumber value="${list2.ACTUAL_GP_AMOUNT/1000000}" type="currency" currencySymbol=""/>
									<fmt:parseNumber var="aga" integerOnly="true" value="${list2.ACTUAL_GP_AMOUNT/1000000}"/>
									<fmt:parseNumber var="tg" integerOnly="true" value="${list2.TARGET_GP/1000000}"/>
									<c:choose>
										<c:when test="${list2.TARGET_GP > 0}">
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
				</c:choose>
			</ul>
		</div>
	</c:when>
	
	<c:when test="${fn:contains(auth, 'ROLE_DIVISION')}">
		<!-- 부서,개인 실적 Progress -->
		<c:if test="${fn:length(list2) > 0}">
			<p class="lang_ti">${list2.VIEW_NAME}</p>
		</c:if>
		
		<c:set var="now" value="<%=new java.util.Date()%>" />
		<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>
		<ul class="tabmenu tabmenu_type4 mg_b10" id="tab_st">
			<li class=""><a href="javascript:void(0);" id="tab1" onclick="fncResultGraph2(1)">1분기</a></li>
			<li class=""><a href="javascript:void(0);" id="tab2" onclick="fncResultGraph2(2)">2분기</a></li>
			<li class=""><a href="javascript:void(0);" id="tab3" onclick="fncResultGraph2(3)">3분기</a></li>
			<li class=""><a href="javascript:void(0);" id="tab4" onclick="fncResultGraph2(4)">4분기</a></li>
			<%-- <li class="year" id="tab5"><a href="javascript:void(0);" onclick="fncResultGraph('${sysYear}');">${sysYear}년도</a></li> --%>
		</ul>
		
		<!-- 1분기 -->
		<div class="cont1 ">
			<ul class="stat_list">
			
				<c:choose>
					<c:when test="${fn:length(list2) > 0}">
					<li>
							<h2 class="no-margins">
								<span class="top_count">
									Target : <fmt:formatNumber value="${list2.TARGET_REV/1000000}" type="currency" currencySymbol=""/>(REV) /
												<fmt:formatNumber value="${list2.TARGET_GP/1000000}" type="currency" currencySymbol=""/>(GP) / 
												<span class="fs11">단위 : 백만원</span>
								</span>
							</h2>
						</li>
				
						<li>
							<h2 class="subtitle">
								<span class="sub">REV</span>
								<span class="count">
									<fmt:formatNumber value="${list2.ACTUAL_REV_AMOUNT/1000000}" type="currency" currencySymbol=""/>
									<fmt:parseNumber var="ara" integerOnly="true" value="${list2.ACTUAL_REV_AMOUNT/1000000}"/>
									<fmt:parseNumber var="tr" integerOnly="true" value="${list2.TARGET_REV/1000000}"/>
									<c:choose>
										<c:when test="${list2.TARGET_REV > 0}">
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
									<fmt:formatNumber value="${list2.ACTUAL_GP_AMOUNT/1000000}" type="currency" currencySymbol=""/>
									<fmt:parseNumber var="aga" integerOnly="true" value="${list2.ACTUAL_GP_AMOUNT/1000000}"/>
									<fmt:parseNumber var="tg" integerOnly="true" value="${list2.TARGET_GP/1000000}"/>
									<c:choose>
										<c:when test="${list2.TARGET_GP > 0}">
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
				</c:choose>
			</ul>
		</div>
	</c:when>
	
	<c:when test="${fn:contains(auth, 'ROLE_TEAM')}">
		<!-- 부서,개인 실적 Progress -->
		<c:if test="${fn:length(list4) > 0}">
			<p class="lang_ti">${list4.VIEW_NAME}</p>
		</c:if>
		
		<c:set var="now" value="<%=new java.util.Date()%>" />
		<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>
		<ul class="tabmenu tabmenu_type4 mg_b10" id="tab_st">
			<li class=""><a id="tab1" href="javascript:void(0);" onclick="fncResultGraph2(1)">1분기</a></li>
			<li class=""><a id="tab2" href="javascript:void(0);" onclick="fncResultGraph2(2)">2분기</a></li>
			<li class=""><a id="tab3" href="javascript:void(0);" onclick="fncResultGraph2(3)">3분기</a></li>
			<li class=""><a id="tab4" href="javascript:void(0);" onclick="fncResultGraph2(4)">4분기</a></li>
			<%-- <li class="year" id="tab5"><a href="javascript:void(0);" onclick="fncResultGraph('${sysYear}');">${sysYear}년도</a></li> --%>
		</ul>
		
		<!-- 1분기 -->
		<div class="cont1 ">
			<ul class="stat_list">
			
				<c:choose>
					<c:when test="${fn:length(list4) > 0}">
					<li>
							<h2 class="no-margins">
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
				</c:choose>
			</ul>
		</div>
	</c:when>
	<c:otherwise>
		<!-- 부서,개인 실적 Progress -->
		<c:if test="${fn:length(list2) > 0}">
			<p class="lang_ti">${list2.VIEW_NAME}</p>
		</c:if>
		
		<c:set var="now" value="<%=new java.util.Date()%>" />
		<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>
		<ul class="tabmenu tabmenu_type4 mg_b10" id="tab_st">
			<li class=""><a href="javascript:void(0);" id="tab1" onclick="fncResultGraph2(1)">1분기</a></li>
			<li class=""><a href="javascript:void(0);" id="tab2" onclick="fncResultGraph2(2)">2분기</a></li>
			<li class=""><a href="javascript:void(0);" id="tab3" onclick="fncResultGraph2(3)">3분기</a></li>
			<li class=""><a href="javascript:void(0);" id="tab4" onclick="fncResultGraph2(4)">4분기</a></li>
			<%-- <li class="year" id="tab5"><a href="javascript:void(0);" onclick="fncResultGraph('${sysYear}');">${sysYear}년도</a></li> --%>
		</ul>
		
		<!-- 1분기 -->
		<div class="cont1 ">
			<ul class="stat_list">
			
				<c:choose>
					<c:when test="${fn:length(list2) > 0}">
					<li>
							<h2 class="no-margins">
								<span class="top_count">
									Target : <fmt:formatNumber value="${list2.TARGET_REV/1000000}" type="currency" currencySymbol=""/>(REV) /
												<fmt:formatNumber value="${list2.TARGET_GP/1000000}" type="currency" currencySymbol=""/>(GP) / 
												<span class="fs11">단위 : 백만원</span>
								</span>
							</h2>
						</li>
				
						<li>
							<h2 class="subtitle">
								<span class="sub">REV</span>
								<span class="count">
									<fmt:formatNumber value="${list2.ACTUAL_REV_AMOUNT/1000000}" type="currency" currencySymbol=""/>
									<fmt:parseNumber var="ara" integerOnly="true" value="${list2.ACTUAL_REV_AMOUNT/1000000}"/>
									<fmt:parseNumber var="tr" integerOnly="true" value="${list2.TARGET_REV/1000000}"/>
									<c:choose>
										<c:when test="${list2.TARGET_REV > 0}">
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
									<fmt:formatNumber value="${list2.ACTUAL_GP_AMOUNT/1000000}" type="currency" currencySymbol=""/>
									<fmt:parseNumber var="aga" integerOnly="true" value="${list2.ACTUAL_GP_AMOUNT/1000000}"/>
									<fmt:parseNumber var="tg" integerOnly="true" value="${list2.TARGET_GP/1000000}"/>
									<c:choose>
										<c:when test="${list2.TARGET_GP > 0}">
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
				</c:choose>
			</ul>
		</div>
	</c:otherwise>
</c:choose>
	
	