<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include
	file="/WEB-INF/jsp/pc/common/top_clientIndividualInfoListDetail.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	clientList.init();
	clientList.get();

	//".full-height-scroll"
	$("#leftList").scroll(function() {
		if (Math.ceil(this.scrollTop + this.clientHeight) >= this.scrollHeight) {
			console.log("end scroll");
			page.start = page.start + 20;
			page.end = page.end + 20;
			page.status = 2;
			clientList.get();
		}
	});
	
	//모달 hidden event
	$('#myModal1').on('hide.bs.modal', function() {
		compare_after = $("#formModalData").serialize();
		if (modalFlag == "upd") {
			if (compare_before != compare_after) {
				if (confirm("내용이 수정되었습니다.\n저장하시겠습니까?")) {
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
				}
			}
		}
	});
	
	/* $("div.slimScrollDiv").scroll(function() {
		if ((this.scrollTop+this.clientHeight) == this.scrollHeight) {
	        console.log("end scroll");
	        page.start = page.winStart + 12;
	        page.end = page.winEnd + 12;
	        clientList.get();
	    }
	}); */
	
	/*
		검색창에서 엔터 눌렀을 때 이벤트 발생.
	 */
	$(".left-custom-search input[type=text]").keypress(function(e){
			if (e.keyCode == 13) {
				$('#hiddenPartnerIndividualId')
						.val('');
				clientSerchList.get();
			}
	});

});

var serchDetail = "${param.customer_id}";

var page = {
	status : 1, // 왼쪽 고객 리스트 스크롤 시도시에, 기본정보가 처음으로 돌아오는 현상을 방지하기 위함.
	start : 1,
	end : 20,
	winStart : 1,
	winEnd : 12,
	serchStart : 1,
	serchEnd : 20,
	salesStatus : 1
}

var customer_name = "${param.customer_name}";
var customer_id = "${param.customer_id}";
var company_id = "${param.company_id}";

var search_chk = true;

var clientList = {
	init : function() {
		if (customer_name) {
			$("#serchDetail").val(customer_name);
		}
	},
	//파트너사 개인정보게이트 페이지에서 상세 페이지로 넘어갈때 파트너사 리스트 가져오기
	get : function() {
		customer_id = "${coutomerId}";
		var params = $.param({
			pageStart : page.start,
			pageEnd : page.end,
			serchInfo : $("#serchDetail").val(),
			partnerId : customer_id,
			creatorId : $("#hiddenModalCreatorId").val(),
			serch : 2,
			datatype : 'html',
			jsp : '/partnerManagement/partnerIndividualInfoListLeftAjax'
		});

		$.ajax({
			url : "/partnerManagement/selectPartnerIndividualInfoList2.do",
			datatype : 'html',
			data : params,
			cache : false,
			method : 'POST',
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
				$.ajaxLoadingShow();
			},
			success : function(data) {
				if (search_chk)
					$('div .full-height-scroll .list-group.elements-list')
							.append(data);
				if (data.indexOf('현재 등록된 정보가 없습니다.') != -1)
					search_chk = false;

				if (page.status == '1') {
					//defaultInfo.get();
				} else {
					// status == 2 일때는 상세페이지 왼쪽 고객리스트 스크롤을 내릴 경우이다.
					// 이 때에는 defaultInfo.get()을 호출하지 않고 고객리스트만 뿌려준다.
				}
			},
			complete : function() {
				$.ajaxLoadingHide();
			}
		});
	},

	//파트너사 개인정보 게이트 페이지에서 상세 페이지로 넘어갈때, [상세 정보 탭 내용] 관련 호출
	goDetail : function(clientNo, companyId) {
		defaultInfo.goClickUserDetail(clientNo, companyId);
	}
}

/**
 * clientSerchList.get()
 * 파트너사 개인 상세 페이지에서 검색할 때, 사용되는 function
 */
var clientSerchList = {
	//검색 고객 리스트 가져오기
	get : function(sp, ep) {
		if (!isEmpty(sp) && !isEmpty(ep)) {
			page.start = sp;
			page.end = ep;
		}
		var params = $.param({
			pageStart : page.serchStart,
			pageEnd : page.serchEnd,
			serchInfo : $("#serchDetail").val(),
			creatorId : $("#hiddenModalCreatorId").val(),
			partnerIdvId : $("#hiddenPartnerIndividualId").val(),
			serch : 2,
			datatype : 'html',
			jsp : '/partnerManagement/partnerIndividualInfoListLeftAjax'
		});

		$.ajax({
			url : "/partnerManagement/selectPartnerIndividualInfoList2.do",
			datatype : 'html',
			data : params,
			cache : false,
			method : 'POST',
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
				$.ajaxLoadingShow();
			},
			success : function(data) {
				$('div .full-height-scroll .list-group.elements-list').html(data);
				/* 
				if(page.status == '1') {
					defaultInfo.get();
				}else {
					// 검색 엔터 또는 버튼을 클릭했을 때,
					// 이 때에는 defaultInfo.get()을 호출하지 않고 고객리스트만 뿌려준다.
				}
				 */
				search_chk = true;
			},
			complete : function(){
				$.ajaxLoadingHide();
			}
		});
	},

	//파트너사 개인정보 게이트 페이지에서 상세 페이지로 넘어갈때, [상세 정보 탭 내용] 관련 호출
	goDetail : function(clientNo, companyId) {
		defaultInfo.goClickUserDetail(clientNo, companyId);
	}
}

/**
 * defaultInfo.goClickUserDetail()
 * 파트너사 개인정보 상세 페이지에 대한 정보 가져오기.
 * 현재 상세 페이지 관련 데이터를 한방에 가져와서 뿌려준다.
 * 탭별 분기 필요
 */
var defaultInfo = {
	goClickUserDetail : function(clientNo, companyId) {
		var params = $.param({
			pageStart : page.winStart,
			pageEnd : page.winEnd,
			companyId : companyId,
			customerId : clientNo,
			hiddenModalPK : clientNo,
			salesStatus : page.salesStatus,
			datatype : 'html',
			jsp : '/partnerManagement/partnerIndividualInfoDetailAjax'
		});

		/* $("#formDetail #customer_id").val(clientNo); */

		//고객 상세페이지 이름 클릭시 기본정보R
		$.ajax({
			url : "/partnerManagement/selectPartnerIndividualDetail.do",
			datatype : 'html',
			data : params,
			cache : false,
			method : 'POST',
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
				$.ajaxLoadingShow();
			},
			success : function(data) {
				$("div.element-detail-box").html(data);
			},
			complete : function() {
				$.ajaxLoadingHide();
			}
		});
	}
}
</script>
<div class="row wrapper border-bottom white-bg page-heading">

	<!-- <div class="col-sm-6">
		<h2>파트너사 개인정보 검색</h2>
		<ol class="breadcrumb">
			<li><a href="index.html">Home</a></li>
			<li><a>파트너사 협업관리</a></li>
			<li><a href="/partnerManagement/listPartnerIndividualGate.do">파트너사
					개인정보</a></li>
			<li class="active"><strong>파트너사 개인정보 상세보기</strong></li>
		</ol>
	</div>
	<div class="col-sm-6">
		<div class="time-update">
			<span class="text-muted small pull-right">최근 업데이트: <i
				class="fa fa-clock-o"></i> <span id="LATELY_UPDATE_DATE"></span></span>
		</div>
	</div> -->
</div>

<!-- 상세보기 영역:start -->
<input type="hidden" id="hiddenDetailCustomerId" value="${coutomerId}" />
<input type="hidden" id="hiddenDetailCompanyId" value="${companyId}" />
<input type="hidden" id="hiddenDetailSearchDetail"
	value="${searchDetail}" />
<div class="fh-breadcrumb">

	<div class="fh-column" id="fh-column">
		<div class="full-height-scroll" id="leftList"
			style="border-right: 1px solid #e7eaec;">
			<div class="left-custom-search">
				<input type="text" placeholder="파트너사명 또는 파트너사 개인 입력"
					class="input form-control fl_l" id="serchDetail"
					value="${searchDetail}" />
				<button type="button" class="btn btn-w-s btn-seller"
					onclick="$('#hiddenPartnerIndividualId').val('');clientSerchList.get(1, 20)">
					<i class="fa fa-search"></i>
				</button>
			</div>
			<ul class="list-group elements-list">
				<!-- 
                       <li class="list-group-item active">
                           <a data-toggle="tab" href="#tab-1">
                               <small class="pull-right text-muted"> 2016-07-20</small>
                               <strong class="custom-name">황선홍</strong> <span class="custom-level">이사</span>
                               <div class="small m-t-xs">
                                   <p>SK텔레콤(주) / 영업1팀</p>
                               </div>
                           </a>
                       </li>
                       <li class="list-group-item">
                           <a data-toggle="tab" href="#tab-2">
                               <small class="pull-right text-muted"> 2016-07-20</small>
                               <strong class="custom-name">이상현</strong> <span class="custom-level">부장</span>
                               <div class="small m-t-xs">
                                   <p>(주)디유넷 / 디자인팀</p>
                               </div>
                           </a>
                       </li>
                        -->
			</ul>
		</div>
	</div>

	<div class="full-height">
		<div class="white-bg border-left">

			<div class="element-detail-box"
				style="overflow: hidden; width: auto; height: 100%;"></div>

		</div>
	</div>
	<jsp:include
		page="/WEB-INF/jsp/pc/partnerManagement/partnerIndividualInfoModal.jsp" />
</div>
<!-- 상세보기 영역:end -->
<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>