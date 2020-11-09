<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>

			<div id="tab2-3" class="tab-pane active">
		           
		           <div class="pull-right pos_t10m">
						<!-- CRUD 권한 가진 사람만 수정가능 -->
	               		<%-- <c:if test="${fn:contains(auth, 'ROLE_CRUD')}"> --%>
	           			<button class="btn btn-white btn-sm" id="buttonUpdateClientCompany" onClick="modalProjectMg.update();">프로젝트이력 수정</button>
	           			<%-- </c:if> --%>
					</div>
		           
			           
                   <h2>프로젝트이력</h2>
                   
                   <table id="tech-companies" class="basic4_list mg-b30">
                   		<colgroup>
					        <col width="" /> 
					        <col width="12%" /> 
					        <col width="12%" /> 
					        <col width="10%" /> 
					        <col width="5%" /> 
					        <col width="" /> 
					    </colgroup>
                       <thead>
                       <tr>
                           <th>프로젝트명</th>
                           <th>시작일</th>
                           <th>마감일</th>
                           <th>역할</th>
                           <th>포지션</th>
                           <th>상세내용</th>
                       </tr>
                       </thead>
                       <tbody>
							<c:choose>
							  	<c:when test="${fn:length(salesList) > 0}">
						   			<c:forEach items="${salesList}" var="salesList">
				                       <tr>
				                           <td class="ag_l">${salesList.PROJECT_NAME}</td>
				                           <td>${salesList.START_DATE}</td>
				                           <td>${salesList.END_DATE}</td>
				                           <c:choose>
					                           <c:when test="${salesList.ROLE eq '1'}">
					                           <td>정보제공자</td>
					                           </c:when>
					                           <c:when test="${salesList.ROLE eq '2'}">
					                           <td>실무자</td>
					                           </c:when>
					                           <c:when test="${salesList.ROLE eq '3'}">
					                           <td>의사결정자</td>
					                           </c:when>
					                           <c:when test="${salesList.ROLE eq '4'}">
					                           <td>influencer</td>
					                           </c:when>
					                           <c:otherwise>
					                           <td>${salesList.ROLE}</td>
					                           </c:otherwise>
				                           </c:choose>
				                           <c:choose>
					                           <c:when test="${salesList.POSITION eq '1'}">
					                           <td>Pro</td>
					                           </c:when>
					                           <c:when test="${salesList.POSITION eq '2'}">
					                           <td>Anti</td>
					                           </c:when>
					                           <c:when test="${salesList.POSITION eq '3'}">
					                           <td>Natural</td>
					                           </c:when>
					                           <c:otherwise>
					                           <td>${salesList.POSITION}</td>
					                           </c:otherwise>
				                           </c:choose>
				                           <td class="ag_l">${salesList.DETAIL}</td>
				                       </tr>
		                       		</c:forEach>
							   	</c:when>
							   	<c:otherwise>
							   		<tr>
							   			<td colspan="7">No Data</td>
					   				</tr>
							   	</c:otherwise>
			   				</c:choose>
                          </tbody>
                   </table>
               </div>
               
				<div style="height:300px;"></div>
				