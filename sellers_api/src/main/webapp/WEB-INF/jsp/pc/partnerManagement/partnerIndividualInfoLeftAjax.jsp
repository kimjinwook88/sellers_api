<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
//리스트 총 갯수
page.totalCount = "${listCount}";
</script>



<!-- 
	데이터 맞는지 확인 부탁드려요 
	데이터 맞는지 확인 부탁드려요
	데이터 맞는지 확인 부탁드려요
	데이터 맞는지 확인 부탁드려요
	데이터 맞는지 확인 부탁드려요
-->
<c:choose>
<c:when test="${fn:length(rows) > 0}">
	<c:forEach items="${rows}" var="rows">
				<div class="col-sm-6 col-md-4 col-lg-3 listType-card">
					<div class="contact-box center-version pos-rel">
						<a href="javascript:void(0);" onclick="clientList.goDetail(${rows.CUSTOMER_ID}, ${rows.COMPANY_ID})">
							<h3 class="m-b-xs"><strong class="custom-name">${rows.CUSTOMER_NAME}</strong></h3>
							<div class="font-bold mg-b10">${rows.POSITION}</div>
							<address class="">
								<div class="mg-b10">${rows.COMPANY_NAME} / ${rows.TEAM}</div>
								<strong>${rows.PHONE}</strong><br>
								<strong class="email">${rows.EMAIL}</strong>
							</address>
							<span class="namecard" style="background:url('../images/namecard.png') no-repeat center center; background-size:cover;"></span>
						</a>
					</div>
				</div>
	</c:forEach>
</c:when>
<c:otherwise>
				<!-- 데이터 없을경우 -->
				<div class="col-sm-12 col-md-12 col-lg-12 ta-c">
                    <div class="blank_ment">
                        <p>
                        현재 등록된 정보가 없습니다.
                        </p>
                    </div>
                </div>
</c:otherwise>
</c:choose>