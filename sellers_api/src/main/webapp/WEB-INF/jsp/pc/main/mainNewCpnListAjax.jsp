<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="ibox float-e-margins">
<div class="ibox-title">
    <h5>최근 등록된 고객(최근 1개월내)</h5>                                
</div>
<div class="ibox-content pd-no">

    <div class="module_height_base">

        <div class="pd10">

            <div class="pull-right">
                <button class="btn btn-white " data-toggle="modal" data-target="#myModal1"><i class="fa fa-plus"></i> 고객 간편등록</button>
            </div>                                

                                        <div class="new_custom_sum">
                                            <div class="left">
                                                <span class="ment">신규 고객수</span>
                                                <strong class="count">17</strong>
                                            </div>
                                            <div class="right">
                                                <ul>
                                                    <li class="first">대학: <a href="#">5</a>명</li>
                                                    <li>공공기관: <a href="#">5</a>명</li>
                                                    <li>기타: <a href="#">7</a>명</li>
                                                </ul>
                                            </div>
                                        </div>

                                        <div class="new_custom_list">
                                            <strong class="title">전체 신규고객</strong><!-- 전체, 농민, 거래선, 영향력자의 고객리스트 표시 -->                                    
                                            <ul>
                                                <li>
                                                    <a href="#">
                                                        <span class="name">김정민</span>
                                                        <small class="block text-muted">경성대 / 2018-01-09</small>
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="#">
                                                        <span class="name">홍길동</span>
                                                        <small class="block text-muted">한국세무사회 / 2018-01-09</small>
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="#">
                                                        <span class="name">이상현</span>
                                                        <small class="block text-muted">전남대학교 / 2018-01-09</small>
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="#">
                                                        <span class="name">홍경인</span>
                                                        <small class="block text-muted">수성대 / 2018-01-09</small>
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="#">
                                                        <span class="name">송혜교</span>
                                                        <small class="block text-muted">전남대학교 / 2018-01-09</small>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>

                                    </div>

                                </div>

                            </div>
                        </div>
                        
                        
<div class="left">
    <span class="ment">신규 고객수</span>
    <strong class="count" onclick="main.selectNewCstmList(firstCompanyId, secondCompanyId, null, '전체');" style="cursor: pointer;">${CstTotal}</strong>
</div>
<div class="right">
    <ul>
    	<c:if test="${fn:length(CpnRows) > 0}">
    		<c:forEach items="${CpnRows}" var="CpnRows" varStatus="status">
    			<c:choose>
    				<c:when test="${CpnRows.COMPANY_NAME eq '기타 고객사' }">
		    		<li>
		    			${CpnRows.COMPANY_NAME}: 
		    			<span onclick="main.selectNewCstmList(null, null, null, '기타', firstCompanyId, secondCompanyId);" style="cursor: pointer; color: blue;">
		    			<strong>${CpnRows.COUNT}</strong></span>명
		    			<input type="hidden" id="hiddenCompanyId${status.count}" name="hiddenCompanyId${status.count}" value="${CpnRows.COMPANY_ID}">
		    		</li>
	    			</c:when>
	    			<c:otherwise>
	    			<li>
		    			${CpnRows.COMPANY_NAME}: 
		    			<span href="#" onclick="main.selectNewCstmList(null, null, ${CpnRows.COMPANY_ID}, '${CpnRows.COMPANY_NAME}');" style="cursor: pointer; color: blue;">
		    			<strong>${CpnRows.COUNT}</strong></span>명
		    			<input type="hidden" id="hiddenCompanyId${status.count}" name="hiddenCompanyId${status.count}" value="${CpnRows.COMPANY_ID}">
		    		</li>
	    			</c:otherwise>
	    		</c:choose>
    		</c:forEach>
    	</c:if>
    </ul>
</div>

<script type="text/javascript">
var firstCompanyId = $("#hiddenCompanyId1").val();
var secondCompanyId = $("#hiddenCompanyId2").val();
main.selectNewCstmList(firstCompanyId, secondCompanyId, null, '전체');
</script>