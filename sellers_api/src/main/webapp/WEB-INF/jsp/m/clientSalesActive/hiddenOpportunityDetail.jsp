<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>

<!doctype html>
<html lang="ko">

<body class="gray_bg" onload="tabmenuLiWidth();">
<div class="container_pg">
	<article class="">
		<div class="title_pg">
			<h2 class="">${detail.SUBJECT}</h2>
			<a href="#" class="btn_back" onclick="fncGoBack(); return false;">back</a>
		</div>

		<div class="author">
			<span>${detail.HAN_NAME} (${detail.SYS_UPDATE_DATE})</span>
		</div>

    <ul class="tabmenu tabmenu_type2 mg_b20">
        <li><a href="#" id="tab_1" onclick="fncSelectTab('1'); return false;" class="active">기본정보</a></li>
        <li><a href="#" id="tab_2" onclick="fncSelectTab('2'); return false;">Action Plan</a></li>
        <li><a href="#" id="tab_3" onclick="fncSelectTab('3');return false;">Coaching Talk</a></li>
    </ul>

		
		<div class="pg_cont">
			<!-- 위의 탭 클릭시 아래의 cont1, cont2, cont3 가  하나씩 보여지도록 해주세요 -->

			<div class="cont1 "><!-- 기본정보 -->

				<div class="view_cata b_line">
					<div class="ti fl_l w_120">
						<span class="bullet dot"></span> 매출처
					</div>
					<div class="cont fl_l">${detail.COMPANY_NAME}</div>
				</div>

				<div class="view_cata b_line">
					<div class="ti fl_l w_120">
						<span class="bullet dot"></span> End User
					</div>
					<div class="cont fl_l">${detail.CUSTOMER_NAME}</div>
				</div>

                <%-- <div class="view_cata b_line">
                    <div class="ti fl_l">
                        <span class="bullet dot"></span> 고객직급
                    </div>
                    <div class="cont fl_l">${detail.CUSTOMER_POSITION}</div>
                </div> --%>

                <div class="view_cata b_line">
                    <div class="ti fl_l w_120">
                        <span class="bullet dot"></span> 영업대표
                    </div>
                    <div class="cont fl_l">${detail.SALESMAN_NAME} <c:if test="${detail.SALESMAN_POSITION != ''}" > /  ${detail.SALESMAN_POSITION} </c:if></div>
                </div>

                <div class="view_cata b_line">
                    <div class="ti fl_l w_120">
                        <span class="bullet dot"></span> 예상규모
                    </div>
                    <div class="cont fl_l">
                        <fmt:formatNumber value="${detail.OPPORTUNITY_AMOUNT}" pattern="#,###"/>
                    </div>
                </div>

                <div class="view_cata b_line">
                    <div class="ti fl_l w_120">
                        <span class="bullet dot"></span> 영업전환시점
                    </div>
                    <div class="cont fl_l">${detail.SALES_CHANGE_DATE}</div>
                </div>
                
                <%-- <div class="view_cata b_line">
                     <div class="ti fl_l w_120">
                         <span class="bullet dot"></span> 결과
                     </div>
                     <div class="cont fl_l" id="divModalResult">
                     		<c:choose>
                            <c:when test="${detail.OPPORTUNITY_ID != null}"><span class="oppStatusColor">전환완료</span></c:when>
                            <c:otherwise><a href="#" class="oppStatusColor" onclick="goOpportunity("+${detail.OPPORTUNITY_ID}+");">전환하기</a></c:otherwise>
                        </c:choose>
                         <!-- <span>전환전</span>  -->
                     </div>
                 </div> --%>
 
                 <div class="view_cata b_line">
                     <div class="ti fl_l w_120">
                         <span class="bullet dot"></span> 연관 고객컨택
                     </div>
                     <div class="cont fl_l" id="relationContact">
                         <!-- <a href="#" class="btn_quick">바로가기</a> -->
                     </div>
                 </div> 

                <%-- <div class="view_cata b_line">
                    <div class="ti fl_l w_120">
                        <span class="bullet dot"></span> 결과
                    </div>
                    <div class="cont fl_l">
                        <span>
                            <c:choose>
                                <c:when test="${detail.OPPORTUNITY_ID != null}">전환완료</c:when>
                                <c:otherwise>전환하기</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div> --%>
				<c:if test="${!empty detail.OPPORTUNITY_ID}">
                <div class="view_cata b_line">
                    <div class="ti fl_l w_120">
                        <span class="bullet dot"></span> 전환 여부
                    </div>
                    <div class="cont fl_l">
                    	<a href="/clientSalesActive/selectOpportunityDetail.do?pkNo=${detail.OPPORTUNITY_ID}" class="btn_quick">바로가기</a>
                    </div>
                </div>
                </c:if>
                
                
                <c:if test="${!empty detail.EVENT_ID}">
	                <div class="view_cata b_line">
	                    <div class="ti fl_l w_120">
	                        <span class="bullet dot"></span> 연관 고객컨택
	                    </div>
	                    <div class="cont fl_l">
	                    	<a href="/clientSalesActive/selectContactDetail.do?pkNo=${detail.EVENT_ID}" class="btn_quick">바로가기</a>
	                    </div>
	                </div>
                </c:if>
                

                <div class="view_cata_full">
                    <div class="ti mg_b5">
                        <span class="bullet dot"></span> 내용
                    </div>
                    <div class="cboth cont_box">${detail.DETAIL_CONENTS}</div>
                </div>

                <% /***********************************************************************
                    * 메일공유 기능이 PC에 미 구현 되어 있음. comgyver.  2017.04.15 
                   */
                %>
                <div class="view_cata b_line">
                    <div class="ti fl_l w_120">
                        <span class="bullet dot"></span> 메일공유
                    </div>
                    <div class="cont fl_l">
						<c:forEach items="${shareMail}" var="mail" varStatus="status">
							<c:choose>
								<c:when test="${status.index == 0}">
									${mail.HAN_NAME}
								</c:when>
								<c:otherwise>
									,${mail.HAN_NAME}
								</c:otherwise>
							</c:choose>
						</c:forEach>
                    </div>
                </div>                

                <% /***********************************************************************
                     \* PC 버전에는 다운로드가 없어 일단 주석 처리 comgyver.  2017.04.15 
				<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 첨부파일
					</div>
					<div class="cboth cont_box">
						<ul class="file_list">
							<c:forEach items="${fileList}" var="file">
							<li><a href="/common/downloadFile.do?fileId=${file.FILE_ID}&fileTableName=6">${file.FILE_NAME}</a></li>
							</c:forEach>
						</ul>
					</div>
				</div>
                */ %>

			</div>
			
      <div class="cont2 off"><!-- Action Plan-->
          <div class="view_cata_full">
              <!-- <div class="ti mg_b5">
                  <span class="bullet dot"></span> Action Plan
              </div> -->
              <div class="cboth keymilestones_list">
                  <ul class="list_type1" id="result_list">
                      <!-- 내용이 입력됩니다. -->
                  </ul>
              </div>
          </div>
      </div>

			<div class="cont3 off"><!-- Coaching Talk -->
				<div class="view_cata_full">
       		<jsp:include page="/WEB-INF/jsp/m/common/coachingTalkTab.jsp"/>
       	</div>
			</div>
		</div>

		<!-- <div class="pg_bottom">
			<div class="ta_c">
				<button type="button" class="btn lg btn-default pd_r15 pd_l15 r5" onclick="fncList(); return false;">목록</button>
			</div>
		</div> -->

        
	</article>   

	<jsp:include page="../templates/footer.jsp" flush="true"/>

</div>
		<div class="pg_bottom_func">
            <ul>
                <li><a href="#" class="" onclick="fncList(); return false;"> <img src="${pageContext.request.contextPath}/images/m/icon_list.png" /> <span>목록</span></a></li>
                <li><a href="#" class="" onclick="fncModify(); return false;"> <img src="${pageContext.request.contextPath}/images/m/icon_edit.png" /> <span>수정</span></a></li>
            </ul>
        </div>
<div class="modal_screen"></div>

<form id="formSampleFile" name="formSampleFile" method="post">
    <input type="hidden" name="sampleFileName" id="hiddenModalPK" value="${detail.OPPORTUNITY_HIDDEN_ID}"/>
</form>

<form method="post" id="updateForm" action="">
    <input type="hidden" id="mode" name="mode" value="upd" />
    <input type="hidden" id="pkNo" name="pkNo" value="${detail.OPPORTUNITY_HIDDEN_ID}" />
</form>

<script>
var tabNo = '${param.tabNo}';
var coachingTalkParam = '${param.coaching_talk}';
</script>

<script src="${pageContext.request.contextPath}/js/m/view/clientSalesActive/hiddenOpportunityDetail.js"></script>

</body>
</html>