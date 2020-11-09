<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
												
												
												<c:choose>
													<c:when test="${fn:length(selectMainMenuSetUp) > 0}">
														<c:forEach items="${selectMainMenuSetUp}" var="selectMainMenuSetUp" varStatus="status">
															<tr>
	                                                            <td class="first">${status.index+1}</td>
	                                                            <td><input type="checkbox" name="checkMainMenu"/></td>
	                                                            <td>${selectMainMenuSetUp.MENU_TITLE}</td>
	                                                            <%-- <td>
	                                                                <select class="mg-r10">
	                                                                    <option value="Y" <c:if test="${selectMainMenuSetUp.USE_YN eq 'Y'}">selected</c:if> >사용</option>
	                                                                    <option value="N" <c:if test="${selectMainMenuSetUp.USE_YN eq 'N'}">selected</c:if> >미사용</option>
	                                                                </select>
	                                                            </td> --%>
	                                                            <input type="hidden" name="hiddenMainMenuId" value="${selectMainMenuSetUp.MENU_ID}" />
	                                                        </tr>
														</c:forEach>
													</c:when>
												</c:choose>