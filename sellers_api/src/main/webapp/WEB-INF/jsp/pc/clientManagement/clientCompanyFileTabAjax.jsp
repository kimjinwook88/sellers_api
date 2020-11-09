<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>

			<div id="tab2-7" class="tab-pane active">
                   <h2>첨부파일</h2>
                   <table id="tech-companies" class="basic4_list mg-b30">
                       <thead>
                       <tr>
                           <th>파일명</th>
                           <th width="20%">업로드날짜</th>
                           <%-- <c:choose>
								<c:when test="${fn:contains(auth, 'ROLE_CRUD')}"> --%>	           
								<th width="4%">삭제</th>
								<%-- </c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose> --%>
                       </tr>
                       </thead>
                       <tbody>
                       <c:choose>
						  <c:when test="${fn:length(fileList) > 0}">
					   		<c:forEach items="${fileList}" var="fileList">
	                       <tr>
	                           <td class="ag_l">
	                           	<a href="/common/downloadFile.do?fileId=${fileList.FILE_ID}&fileTableName=12">
	                           	<c:choose>
	                           		<c:when test="${fileList.FILE_PATH ne 'organizationChart/client/'}">
	                           		${fileList.FILE_NAME}
	                           		</c:when>
	                           		<c:otherwise>
	                           		조직도
	                           		</c:otherwise>
	                           	</c:choose>
	                           	</a>
	                           </td>
	                           	<td>${fileList.SYS_UPDATE_DATE}</td>
	                           	<%-- <c:choose>
									<c:when test="${fn:contains(auth, 'ROLE_CRUD')}"> --%>
									<td><a href="javascript:void(0);" onClick="modal.deleteFile(${fileList.FILE_ID});"><i class="fa fa-times-circle"></i></a></td>
									<%-- </c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose> --%>
	                       </tr>
	                       </c:forEach>
						   </c:when>
						   <c:otherwise>
						   	<td colspan="3">업로드된 파일이 없습니다.</td>
						   </c:otherwise>
					   </c:choose>
                       </tbody>
                   </table>
                   
                   <form class="form-horizontal" id="formDetailFileData" name="formDetailFileData" method="post" enctype="multipart/form-data">
                   <%-- <c:choose>
						<c:when test="${fn:contains(auth, 'ROLE_CRUD')}"> --%>
						<div class="file-dragdrap-area crb-file">
					        <div class="fileUpload btn btn-gray">
					            <span>파일찾기</span>
					             <input type="file" name="fileModalUploadFile[]" id="fileModalUploadFile" onchange="commonFile.upload(this);" class="upload"
					              accept=".jpg, .png, .gif, .jpeg, .xls, .xlsx, .pdf, .ppt, .pptx, .doc, .docx, .hwp, .txt" multiple />
					        </div>
					        <div class="file-in-list" id="divFileUploadList">
					            <span class="blank-ment">
							  		업로드할 파일을 등록해 주세요.
					            </span>
					        </div>
					    </div>
						<%-- </c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose> --%>
                   
				    <input type="hidden" name="hiddenDetailCreatorId" id="hiddenDetailCreatorId" value="${userInfo.MEMBER_ID_NUM}">
				    <input type="hidden" name="hiddenDetailCompanyId" id="hiddenDetailCompanyId" value="${gridClientCompanyInfo[0].COMPANY_ID}">
				    
				    <%-- <c:choose>
						<c:when test="${fn:contains(auth, 'ROLE_CRUD')}"> --%>
						<p class="text-right">
							<button type="submit" class="btn btn-w-m btn-seller" id="buttonSaveCRB" onClick="detail.uploadFile();">파일저장</button>
						</p>
						<%-- </c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose> --%>
				    </form>
				    
				</div>