
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 영업실적 -->
<div class="ibox float-e-margins">
    <div class="ibox-title">
        <h5>영업실적</h5>                                
    </div>
    <div class="ibox-content pd-no">
        <div class="module_height_base">
            <div class="pd10">
                <!-- <h4>박형규</h4> -->                                    
                <div class="tabs-container landing-tab sales_top">
                    <ul class="nav nav-tabs">
                         <li name="resultTab" class=""><a data-toggle="tab" href="#tab-1">1분기</a></li>
                         <li name="resultTab" class=""><a data-toggle="tab" href="#tab-2">2분기</a></li>
                         <li name="resultTab" class=""><a data-toggle="tab" href="#tab-3">3분기</a></li>
                         <li name="resultTab" class=""><a data-toggle="tab" href="#tab-4">4분기</a></li>
                         <!-- <li name="resultTab" class=""><a data-toggle="tab" href="#tab-5"><span name="spanYear"></span>년</a></li> -->
                    </ul>
                    <div class="tab-content ">
                        <div id="tab-1" class="tab-pane active ">
                            <div class="panel-body">
                                <div class="total_year_result">
                                    <ul class="stat-list">
								      <c:choose>
											<c:when test="${fn:length(list) > 0}">
									          <li>
							                       <h2 class="no-margins">
							                       		<span class="small"><strong class="ti">${list.VIEW_NAME}</strong> Target : 
							                                 <strong><fmt:formatNumber value="${list.TARGET_REV/1000000}" type="currency" currencySymbol=""/></strong><span class="ft-s12">(REV)</span> /
							                                 <strong><fmt:formatNumber value="${list.TARGET_GP/1000000}" type="currency" currencySymbol=""/></strong><span class="ft-s12">(GP)</span>
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
							                               <div class="line_100">100%</div>
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
											              		<fmt:formatNumber var="gpPer" pattern="0"  value="${(aga/tg)*100}"/>
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
							                              <div class="line_100">100%</div>
							                          </div>
							                      </div>
							                  </li>
							              </c:when>
											<c:otherwise>
											<li style="text-align: center;"><strong>데이터가 없습니다.</strong></li>
											</c:otherwise>
										</c:choose>
										
										
										 <c:choose>
											<c:when test="${fn:length(list2) > 0}">
											    
							                  <hr style="border: groove; 2px; black;">
							                  
							                  <li>
							                       <h2 class="no-margins">
							                       		<span class="small"><strong class="ti">${list2.VIEW_NAME}</strong> Target : 
							                                 <strong><fmt:formatNumber value="${list2.TARGET_REV/1000000}" type="currency" currencySymbol=""/></strong><span class="ft-s12">(REV)</span> /
							                                 <strong><fmt:formatNumber value="${list2.TARGET_GP/1000000}" type="currency" currencySymbol=""/></strong><span class="ft-s12">(GP)</span>
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
							                               <div class="line_100">100%</div>
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
							                              <div class="line_100">100%</div>
							                          </div>
							                      </div>
							                  </li>
							                  
							                </c:when>
											<c:otherwise>
											<hr style="border: groove; 2px; black;">
											<li style="text-align: center;"><strong>데이터가 없습니다.</strong></li>
											</c:otherwise>
										</c:choose>  
										
										
										<c:choose>
											<c:when test="${fn:length(list3) > 0}">
											
							                  <hr style="border: groove; 2px; black;">
							                  
							                  <li>
							                       <h2 class="no-margins">
							                       		<span class="small"><strong class="ti">${list3.VIEW_NAME}</strong> Target : 
							                                 <strong><fmt:formatNumber value="${list3.TARGET_REV/1000000}" type="currency" currencySymbol=""/></strong><span class="ft-s12">(REV)</span> /
							                                 <strong><fmt:formatNumber value="${list3.TARGET_GP/1000000}" type="currency" currencySymbol=""/></strong><span class="ft-s12">(GP)</span>
							                            </span>
							                       </h2>
							                   </li>
							                   
							                   <li>
							                       <h2 class="subtitle">
							                           <span class="sub">REV</span>
							                           <span class="count">
							                           	<fmt:formatNumber value="${list3.ACTUAL_REV_AMOUNT/1000000}" type="currency" currencySymbol=""/>
							                           	<fmt:parseNumber var="ara" integerOnly="true" value="${list3.ACTUAL_REV_AMOUNT/1000000}"/>
										              	<fmt:parseNumber var="tr" integerOnly="true" value="${list3.TARGET_REV/1000000}"/>
										              	<c:choose>
										              		<c:when test="${list3.TARGET_REV > 0}">
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
							                               <div class="line_100">100%</div>
							                           </div>
							                       </div>
							                   </li>
							                   
							                   <li>
							                      <h2 class="subtitle">
							                          <span class="sub">GP</span>
							                          <span class="count">
							                          		<fmt:formatNumber value="${list3.ACTUAL_GP_AMOUNT/1000000}" type="currency" currencySymbol=""/>
							                          		<fmt:parseNumber var="aga" integerOnly="true" value="${list3.ACTUAL_GP_AMOUNT/1000000}"/>
										              		<fmt:parseNumber var="tg" integerOnly="true" value="${list3.TARGET_GP/1000000}"/>
										              		<c:choose>
											              		<c:when test="${list3.TARGET_GP > 0}">
											              		<fmt:formatNumber var="gpPer" pattern="0"  value="${(aga/tg)*100}"/>
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
							                              <div class="line_100">100%</div>
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
                                </div>
                            </div>
                        </div>
                    </div>                                    
                </div>
            </div>
        </div>
    </div>
</div>
 <!--// 영업실적 -->
 
 
 
<%-- 메인 모듈 이전 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tab-pane active">
  <div class="panel-body">
  	<div class="total_year_result">
      <ul class="stat-list">
	      <c:choose>
				<c:when test="${fn:length(list) > 0}">
		          <li>
                       <h2 class="no-margins">
                       		<span class="small"><strong class="ti">${list.VIEW_NAME}</strong> Target : 
                                 <strong><fmt:formatNumber value="${list.TARGET_REV/1000000}" type="currency" currencySymbol=""/></strong><span class="ft-s12">(REV)</span> /
                                 <strong><fmt:formatNumber value="${list.TARGET_GP/1000000}" type="currency" currencySymbol=""/></strong><span class="ft-s12">(GP)</span>
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
                               <div class="line_100">100%</div>
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
				              		<fmt:formatNumber var="gpPer" pattern="0"  value="${(aga/tg)*100}"/>
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
                              <div class="line_100">100%</div>
                          </div>
                      </div>
                  </li>
              </c:when>
				<c:otherwise>
				<li style="text-align: center;"><strong>데이터가 없습니다.</strong></li>
				</c:otherwise>
			</c:choose>
			
			
			 <c:choose>
				<c:when test="${fn:length(list2) > 0}">
				    
                  <hr style="border: groove; 2px; black;">
                  
                  <li>
                       <h2 class="no-margins">
                       		<span class="small"><strong class="ti">${list2.VIEW_NAME}</strong> Target : 
                                 <strong><fmt:formatNumber value="${list2.TARGET_REV/1000000}" type="currency" currencySymbol=""/></strong><span class="ft-s12">(REV)</span> /
                                 <strong><fmt:formatNumber value="${list2.TARGET_GP/1000000}" type="currency" currencySymbol=""/></strong><span class="ft-s12">(GP)</span>
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
                               <div class="line_100">100%</div>
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
                              <div class="line_100">100%</div>
                          </div>
                      </div>
                  </li>
                  
                </c:when>
				<c:otherwise>
				<hr style="border: groove; 2px; black;">
				<li style="text-align: center;"><strong>데이터가 없습니다.</strong></li>
				</c:otherwise>
			</c:choose>  
			
			
			<c:choose>
				<c:when test="${fn:length(list3) > 0}">
				
                  <hr style="border: groove; 2px; black;">
                  
                  <li>
                       <h2 class="no-margins">
                       		<span class="small"><strong class="ti">${list3.VIEW_NAME}</strong> Target : 
                                 <strong><fmt:formatNumber value="${list3.TARGET_REV/1000000}" type="currency" currencySymbol=""/></strong><span class="ft-s12">(REV)</span> /
                                 <strong><fmt:formatNumber value="${list3.TARGET_GP/1000000}" type="currency" currencySymbol=""/></strong><span class="ft-s12">(GP)</span>
                            </span>
                       </h2>
                   </li>
                   
                   <li>
                       <h2 class="subtitle">
                           <span class="sub">REV</span>
                           <span class="count">
                           	<fmt:formatNumber value="${list3.ACTUAL_REV_AMOUNT/1000000}" type="currency" currencySymbol=""/>
                           	<fmt:parseNumber var="ara" integerOnly="true" value="${list3.ACTUAL_REV_AMOUNT/1000000}"/>
			              	<fmt:parseNumber var="tr" integerOnly="true" value="${list3.TARGET_REV/1000000}"/>
			              	<c:choose>
			              		<c:when test="${list3.TARGET_REV > 0}">
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
                               <div class="line_100">100%</div>
                           </div>
                       </div>
                   </li>
                   
                   <li>
                      <h2 class="subtitle">
                          <span class="sub">GP</span>
                          <span class="count">
                          		<fmt:formatNumber value="${list3.ACTUAL_GP_AMOUNT/1000000}" type="currency" currencySymbol=""/>
                          		<fmt:parseNumber var="aga" integerOnly="true" value="${list3.ACTUAL_GP_AMOUNT/1000000}"/>
			              		<fmt:parseNumber var="tg" integerOnly="true" value="${list3.TARGET_GP/1000000}"/>
			              		<c:choose>
				              		<c:when test="${list3.TARGET_GP > 0}">
				              		<fmt:formatNumber var="gpPer" pattern="0"  value="${(aga/tg)*100}"/>
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
                              <div class="line_100">100%</div>
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
      </div>
    </div>
</div> --%>