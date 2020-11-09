<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>

<script type="text/javascript">
var modalFlag = "ins/upd"; //추가 수정 변수
var modalReset = "${param.modalReset}";

var compare_before;
var compare_after;
var compareFlag = false;

var returnValue = '';

$(document).ready(function(){
	//clientList.get();
	commonSearch.company($("#textListSearchCompanyName"), $("#hiddenListSearchCompanyId"), $("#hiddenListSearchCompanyId"));
	commonSearch.customer($("#textListSearchDetail"), $("#hiddenListSearchClientId"), $("#hiddenNone"), $("#hiddenListSearchCompanyId"));
	
	if(modalReset) {
		// 타이틀 설정
		menuCookieSet("고객개인정보");
		setTitle();
		setActiveMenu();
		modal.reset();
	}
	
	$(window).scroll(function() {
	    if ($(window).scrollTop() >= $(document).height() - $(window).height() - 10) {
	    	/*
			 	리스트 총 갯수(page.totalCount) 가져와서 무한 스크롤 방지 해야합니다.
			 	ex) listBizStrategy
			*/
	        console.log("end scroll");
	        page.start = page.start + 20;
	        page.end = page.end + 20;
	        clientList.get();
	    }
	});
	
	/*
		검색창에서 엔터 눌렀을 때 이벤트 발생.
	*/
	$(".singleSearch input[type=text]").keypress(function(e) { 
	    if (e.keyCode == 13){
	    	searchDetailClick.getList();
	    }    
	});
	
	//모달 hidden event
	$('#myModal1').on('hide.bs.modal', function () {
		compare_after = $("#formModalData").serialize();
		if(modalFlag == "upd"){
			if(compare_before != compare_after){
				if(confirm("내용이 수정되었습니다.\n저장하시겠습니까?")) {
					compareFlag = true;
					$("#buttonModalSubmit").trigger("click");
				}
			}
		}else{ //신규등록이면
			if(compare_before != compare_after){
				if(confirm("창을 닫으면 입력한 정보가 지워집니다.\n창을 닫으시겠습니까?")) {
					$("#divModalFile p").hide();
				}else{
					return false;
					attrChk = true;
				}
			}
		}
	});
	
});

var page = {
		start : 1,
		end : 20,
		totalCount : null,
		serchStart : 1,
		serchEnd :20
}

var clientList = {
		
		goDetail : function(clientNo, companyId){
			$("#formDetail #customer_id").val(clientNo);
			$("#formDetail #company_id").val(companyId);
			$("#formDetail").attr({action:"/clientManagement/viewClientIndividualInfoDetail.do", method:"post"}).submit();
		},
		
		/* companySearchCheck : function() {
			if($('#textListSearchCompanyName').val()!='') {
				$('#listSearchClient_first').hide(); 
				$('#listSearchClient_second p.mg-b10').html('<h4>'+$('#textListSearchCompanyName').val()+'</h4>의 고객개인명을 입력해주세요.');
				$('#listSearchClient_second p.mg-b10 h4').css("display", "inline-block");
				$('#listSearchClient_second').show();
			}
		},
		
		companySearchPrev : function() {
			$('#listSearchClient_second').hide(); 
			$('#textListSearchCompanyName').val(); 
			$('#listSearchClient_first').show();
		} */
		
}

var searchDetailClick = {
		getList : function(){
			var params = $.param({
				pageStart : page.serchStart,
				pageEnd : page.serchEnd,
				serchInfo : $("#searchDetail").val(),
				creatorId : $("#hiddenModalCreatorId").val(),
				serch : 2,
				datatype : 'json'
			});
			$.ajax({
				url : "/clientManagement/gridClientIndividualInfoList2.do",
				datatype : 'json',
				method: 'POST',
				data : params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoading();
				},
				success : function(data){
					//$("div#row").html(data);
					if(data.rows.length > 0) searchDetailClick.goDetail(data.rows[0].CUSTOMER_ID, data.rows[0].COMPANY_ID, $("#searchDetail").val(), false);
					else alert("검색결과가 없습니다.");
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		goDetail : function(clientNo, companyId, searchDetail, chk){
			if(chk)$("#formDetail #customer_id").val(clientNo);
			$("#formDetail #company_id").val(companyId);
			$("#formDetail #search_detail").val(searchDetail);
			$("#formDetail").attr({action:"/clientManagement/viewClientIndividualInfoDetail.do", method:"post"}).submit();
		}
}


</script>

<form id="formDetail">
<input type="hidden" id="customer_id" name="customer_id">
<input type="hidden" id="company_id" name="company_id">
<input type="hidden" id="search_detail" name="search_detail">
</form>

<div class="row wrapper border-bottom white-bg page-heading">
    <!-- <div class="col-sm-6">
        <h2>고객 개인정보</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>고객사 및 고객개인정보</a>
            </li>
            <li class="active">
                <strong>고객개인정보</strong>
            </li>
        </ol>
    </div> -->
    <div class="col-sm-6">
        <div class="time-update">
            <!-- <span class="text-muted small pull-right">최근 업데이트: <i class="fa fa-clock-o"></i> 2:10 pm - 12.06.2014</span> -->
        </div>
        <div class="search-common" style="display: none;">
        	<div class="input-default" style="margin:0;">
                <span onclick="modal.reset();">
                        <a href="#" class="btn" style="color:#666; border:solid 1px #e6eaed; margin-left:5px !important;">고객 추가</a>
                </span>
            </div>
            <div class="input-default" style="margin:0;">
                <span class="input-group-btn">
                       <a href="#" class="btn btn-search-option"><i class="fa fa-search"></i> 검색</a>
                </span>

                <div class="search-detail collapse">
                    <div class="singleSearch">
                        <!-- <input type="text" placeholder="고객사명 또는 고객명을 입력하십시오" class="input form-control" id="searchDetail" value=""> -->
                        <button type="button" class="btn btn-w-s btn-seller" onclick="searchDetailClick.getList()"><i class="fa fa-search"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="wrapper wrapper-content animated fadeInRight">
           	<div class="row" id="row">
<!-- 
                  <div class="col-lg-12 ag_r mg-b10">
                      <button class="btn btn-white btn-sm btn-namecard-view"> <span>명함보기</span> <span style="display:none;">명함가리기</span> <i class="fa fa-eye"></i></button>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3 listType-card">
                      <div class="contact-box center-version pos-rel">
                          <a href="file:///F:/01_Work/2016%EB%85%84_%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8/p01.%EC%86%94%EB%A3%A8%EC%85%98/[2015.11.25]KSI/10.SellersCN/05_html_work/html/05_%EC%A0%95%EB%B3%B4%EA%B2%80%EC%83%8901_%EA%B3%A0%EA%B0%9D%EA%B0%9C%EC%9D%B8%EC%A0%95%EB%B3%B4%EA%B2%80%EC%83%89_%EC%83%81%EC%84%B8%EB%B3%B4%EA%B8%B0.html">

                              사진 또는 명함 이미지
                              <img alt="" class="photo" src="../images/namecard.png">


                              <h3 class="m-b-xs"><strong class="custom-name">황선홍</strong></h3>

                              <div class="font-bold mg-b10">이사</div>
                              <address class="">
                                  <div class="mg-b10">SK텔레콤㈜ / 영업1팀</div>
                                  <strong>02-1234-5628</strong><br/>회사전화 또는 개인 휴대전화
                                  <strong class="email">hongsadfasdfasdfasfd@naver.com</strong>
                              </address>

                              <span class="namecard" style="background:url('../images/namecard.png') no-repeat center center; background-size:cover;"></span>
                          </a>
                      </div>
                  </div>
                  
 -->
	            
	            <div class="gateArea">
	            		<%-- <c:choose>
							<c:when test="${fn:contains(auth, 'ROLE_CRUD')}"> --%>
	                        <div class="newArea ag_c">
	                            <img src="../images/pc/gate_img1.png" class="thum mg-b10" />
	                            <p class="mg-b10">신규 고객개인을 등록하세요.</p>
	
	                            <button type="button" onclick="modal.reset();" class="btn btn-green r3">고객개인 등록</button>
	                        </div>
	                        <%-- </c:when>
	                    </c:choose> --%>
                        <div class="searchArea  ag_c" <%-- <c:if test="${!fn:contains(auth, 'ROLE_CRUD')}">style="width:100%;"</c:if> --%>>
                            <img src="../images/pc/gate_img2.png" class="thum mg-b10" />
                            <p class="mg-b10">고객개인이름 또는 고객사명을 입력하세요. <!-- <strong>(고객명, 고객사)</strong> --></p>
                            <div class="pgsearch pos-rel">
	                            <input type="text" id="searchDetail" onkeydown="if(event.keyCode == 13){$('#serchDetail').val($('#textListSearchDetail').val()); searchDetailClick.getList();}"/>
	                            <button onclick="searchDetailClick.getList();" class="btn"><i class="fa fa-search"></i> 검색</button>
                            </div>
                            <!-- <button type="button" onclick="searchDetailClick.getList();" class="btn">나의 영업영역 전체보기</button> -->
                        </div>
                    </div>
	            
			</div>
			<jsp:include page="/WEB-INF/jsp/pc/clientManagement/clientIndividualInfoModal.jsp"/>
</div>
<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>