<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/jsp/m/common/cache.jsp" %>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>
<%@ include file="/WEB-INF/jsp/m/common/functions.jsp" %>
<%
String req_params = getReqParams(request, "mode", "companyId", "customerId", "hiddenModalPK", "salesStatus");
request.setAttribute("req_params", req_params);
String upd_params = getReqParams(request, "mode", "companyId", "hiddenModalPK", "salesStatus");
request.setAttribute("upd_params", upd_params);
%>
    <article class="">

        <div class="title_pg ta_c">
            <h2 class="">${defaultInfo[0].PARTNER_PERSONAL_NAME}<span class="fs12">${defaultInfo[0].POSITION}</span></h2>
            <a href="#" class="btn_back" onclick="window.history.back();">back</a>
        </div>
<%--
        <div class="author">
            <span>이기섭(2016-08-10)</span>
        </div>
 --%>
        <div class="mg_l10 mg_r10 mg_b20">
					
					<div class="view_cata b_line">
             <div class="ti fl_l w_120">
                 <span class="bullet dot"></span> 파트너사 직원ID
             </div>
             <div class="cont fl_l">
             	${defaultInfo[0].PARTNER_INDIVIDUAL_ID}
             </div>
        	</div>
        	
        	<div class="view_cata b_line">
                <div class="ti fl_l w_120">
                    <span class="bullet dot"></span> 소속본부
                </div>
                <div class="cont fl_l">${defaultInfo[0].DIVISION}</div>
            </div>

            <div class="view_cata b_line">
                <div class="ti fl_l w_120">
                    <span class="bullet dot"></span> 소속부서
                </div>
                <div class="cont fl_l">${defaultInfo[0].POST}</div>
            </div>

            <div class="view_cata b_line">
                <div class="ti fl_l w_120">
                    <span class="bullet dot"></span> 소속팀명
                </div>
                <div class="cont fl_l">${defaultInfo[0].TEAM}</div>
            </div>
            
            <div class="view_cata b_line">
                <div class="ti fl_l w_120">
                    <span class="bullet dot"></span> 담당업무
                </div>
                <div class="cont fl_l">${defaultInfo[0].DUTY}</div>
            </div>
            
            <div class="view_cata b_line">
                <div class="ti fl_l w_120">
                    <span class="bullet dot"></span> 파트너사명
                </div>
                <div class="cont fl_l">${defaultInfo[0].COMPANY_NAME}</div>
            </div>
            
            <div class="view_cata b_line">
                <div class="ti fl_l w_120">
                    <span class="bullet dot"></span> 파트너사ID
                </div>
                <div class="cont fl_l">${defaultInfo[0].PARTNER_ID}</div>
            </div>
            
	          <div class="view_cata b_line">
	            <div class="ti fl_l w_120">
	                <span class="bullet dot"></span> 휴대전화
	            </div>
	            <div class="cont fl_l">
	                <span class="phone">${defaultInfo[0].CELL_PHONE}</span>
									<c:if test="${fn:length(defaultInfo[0].CELL_PHONE) > 6}">
					               <a href="tel:${defaultInfo[0].CELL_PHONE}" class="btn_phone_go_view mg_l5"><img src="../../../images/m/icon_phone.png" alt="전화걸기"/></a>
									</c:if>
		           </div>
			       </div>

           		<div class="view_cata b_line">
                <div class="ti fl_l w_120">
                    <span class="bullet dot"></span> 직장전화
                </div>
                <div class="cont fl_l">
                    <span class="phone">${defaultInfo[0].PHONE}</span>
										<c:if test="${fn:length(defaultInfo[0].PHONE) > 6}">
	                    <a href="tel:${defaultInfo[0].PHONE}" class="btn_phone_go_view"><img src="../../../images/m/icon_phone.png" alt="전화걸기"/></a>
                    </c:if>
                </div>
            </div>

            <div class="view_cata b_line">
                <div class="ti fl_l w_120">
                    <span class="bullet dot"></span> 이메일
                </div>
                <div class="cont fl_l">
                <span class="phone">${defaultInfo[0].EMAIL}</span>
								<c:if test="${fn:length(defaultInfo[0].EMAIL) > 0}">
                 <a href="mailto:${defaultInfo[0].EMAIL}" class="btn_phone_go_view"><img src="../../../images/m/icon_email.png" alt="메일보내기"/></a>
                </c:if>
                </div>
            </div>
<%--
            <div class="view_cata b_line">
                <div class="ti fl_l">
                    <span class="bullet dot"></span> 협력사명 
                </div>
                <div class="cont fl_l">디유넷</div>
            </div>

            <div class="view_cata b_line">
                <div class="ti fl_l">
                    <span class="bullet dot"></span> 협력사명 ID
                </div>
                <div class="cont fl_l">OHO98080</div>
            </div>
 --%>


            <div class="view_cata b_line">
                <div class="ti fl_l w_120">
                    <span class="bullet dot"></span> 역할구분
                </div>
                <div class="cont fl_l">${defaultInfo[0].SKILL_TYPE}</div>
            </div>

            <div class="view_cata b_line">
                <div class="ti fl_l w_120">
                    <span class="bullet dot"></span> 사내 친한 직원
                </div>
                <div class="cont fl_l">${defaultInfo[0].FRIENDSHIP_INFO}</div>
            </div>

            <div class="view_cata_full">
                <div class="ti mg_b5">
                    <span class="bullet dot"></span> 개인정보
                </div>
                <div class="cboth cont_box">${defaultInfo[0].PERSONAL_INFO}</div>
            </div>

            <div class="view_cata">
                <label class="">명함</label>
                <div class="">
								<c:if test="${defaultPhoto[0].FILE_NAME ne null && defaultPhoto[0].FILE_NAME ne ''}">
                    <img src="/uploads/${defaultPhoto[0].FILE_PATH}${defaultPhoto[0].FILE_NAME}" alt="명함 사진" />
								</c:if>
                </div>
            </div>

        </div>

        <div class="pg_bottom_func">
            <ul>
                <li><a href="/partnerManagement/viewPartnerIndividualInfoGate.do<c:if test="${req_params ne ''}">?${req_params}</c:if>" class=""> <img src="../../../images/m/icon_list.png" /> <span>목록</span></a></li>
                <li><a href="/partnerManagement/formPartnerIndividualInfoDetail.do?mode=upd&${upd_params}" class=""> <img src="../../../images/m/icon_edit.png" /> <span>수정</span></a></li>
            </ul>
        </div>

    </article>   

<jsp:include page="/WEB-INF/jsp/m/common/bottom.jsp"/>