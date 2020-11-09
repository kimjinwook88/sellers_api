<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="org.springframework.web.util.UrlPathHelper"%>
<%@ page import="java.util.ArrayList"  %>
<%@ page import="java.util.HashMap" %>
<%
//URL 파라메터 제거
UrlPathHelper urlPathHelper = new UrlPathHelper();
String originalURL = urlPathHelper.getOriginatingRequestUri(request);
//out.println("originalURL : " + originalURL);

String[][] arrNavi = {
						 {"파트너사협업관리","파트너 현황","/partnerManagement/viewPartnerSalesLinkage.do"}
						
						,{"파트너사협업관리","파트너사정보","/partnerManagement/viewPartnerCompanyInfoGate.do"}
						,{"파트너사협업관리","파트너사정보","/partnerManagement/viewPartnerCompanyInfoDetail.do"}
						,{"파트너사협업관리","파트너사정보","/partnerManagement/formPartnerCompanyInfoDetail.do"}
						
						,{"파트너사협업관리","파트너사개인정보","/partnerManagement/viewPartnerIndividualInfoGate.do"}
						,{"파트너사협업관리","파트너사개인정보","/partnerManagement/viewPartnerIndividualInfoDetail.do"}
						,{"파트너사협업관리","파트너사개인정보","/partnerManagement/formPartnerIndividualInfoDetail.do"}
						
						,{"사업전략","회사/부문별전략","/bizStrategy/viewBizStrategyCompany.do"}
						,{"사업전략","회사/부문별전략","/bizStrategy/selectBizStrategyDetail.do"}
						
						,{"사업전략","고객별전략","/bizStrategy/viewBizStrategyClient.do"}
						,{"사업전략","고객별전략","/bizStrategy/selectBizStrategyDetail.do"}
						
						,{"사업전략","전략프로젝트","/bizStrategy/viewBizStrategyProjectPlan.do"}
						,{"사업전략","전략프로젝트","/bizStrategy/modalProjectPlanInfo.do"}
						
						,{"패스워드","변경","/common/changePW.do"}
					};

String navi_name1 = "";
String navi_name2 = "";

for(int i=0; i<arrNavi.length; i++) {
	if(originalURL.equals(arrNavi[i][2])) {
		navi_name1 = arrNavi[i][0].toString();
		navi_name2 = arrNavi[i][1].toString();
		break;
	}
}

pageContext.setAttribute("navi_name1", navi_name1);

String searchCategory = request.getParameter("searchCategory");
if(searchCategory != null && searchCategory.equals("고객전략")) {
	navi_name2 = "고객별전략";
}
pageContext.setAttribute("navi_name2", navi_name2);
//request.setAttribute("navi_name2", navi_name2);
%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
	
	<jsp:include page="../templates/header.jsp" flush="true"/>
	<title>THE Seller's</title>

<script type="text/javascript">

//var $jq = jQuery.noConflict();

(function($){
	$(document).ready(function(){
		
		//createLocation();
		$.ajaxLoading = function(){
			$("div.ajax-loader_sellers").show(); //ajax Loading
			setTimeout(function(){$("div.ajax-loader_sellers").hide();},300); //ajax Loading
		}
		 
		$.ajaxLoadingShow = function(){
			$("div.ajax-loader_sellers").show(); //ajax Loading
		}
		
		$.ajaxLoadingHide = function(){
			$("div.ajax-loader_sellers").hide(); //ajax Loading
		}
		
		
		
		function createLocation(){
			// 현재 url 값 생성
			var link = document.location.href;
			var linkArray = link.split('/');
			var strLink = linkArray[linkArray.length -2];
			var lastLink = linkArray[linkArray.length -1];
			
			var selectNameArray = lastLink.split('.');
			var nowUrl = selectNameArray[selectNameArray.length -2];
			
			var bizStrategy2 = null;
			bizStrategy2 = '${param.searchCategory}';
			
			/* 
			if(bizStrategy2 == null || bizStrategy2 == ''){
				// 전략프로젝트
				if(nowUrl == 'viewBizStrategyProjectPlan'){
					var html_vv = "";
					html_vv += '<div class="breadcrumb_depth2">';
					html_vv += '<a href="javascript:void(0);" class="active_menu" onclick="openNav2();">&nbsp;전략프로젝트</a>';
					html_vv += '<ol class="menu_select select2" id="nav2" style="display:none;">';
					html_vv += '<li><a href="/bizStrategy/viewBizStrategyCompany.do">회사/부문별전략</a></li>';
					html_vv += '<li><a href="/bizStrategy/viewBizStrategyClient.do">고객별전략</a></li>';
					html_vv += '<li><a href="/bizStrategy/viewBizStrategyProjectPlan.do">전략프로젝트</a></li>';
					html_vv += '</ol>';
					html_vv += '</div>';
					
					$('#test1').html(html_vv);
				
				// 고객별전략
				}else if(nowUrl == 'viewBizStrategyClient'){
					var html_vv = "";
					html_vv += '<div class="breadcrumb_depth2">';
					html_vv += '<a href="javascript:void(0);" class="active_menu" onclick="openNav2();">&nbsp;고객별전략</a>';
					html_vv += '<ol class="menu_select select2" id="nav2" style="display:none;">';
					html_vv += '<li><a href="/bizStrategy/viewBizStrategyCompany.do">회사/부문별전략</a></li>';
					html_vv += '<li><a href="/bizStrategy/viewBizStrategyClient.do">고객별전략</a></li>';
					html_vv += '<li><a href="/bizStrategy/viewBizStrategyProjectPlan.do">전략프로젝트</a></li>';
					html_vv += '</ol>';
					html_vv += '</div>';
					
					$('#test1').html(html_vv);
					
				// 회사/부문별전략
				}else if(nowUrl == 'viewBizStrategyCompany'){
					var html_vv = "";
					html_vv += '<div class="breadcrumb_depth2">';
					html_vv += '<a href="javascript:void(0);" class="active_menu" onclick="openNav2();">&nbsp;회사/부문별전략</a>';
					html_vv += '<ol class="menu_select select2" id="nav2" style="display:none;">';
					html_vv += '<li><a href="/bizStrategy/viewBizStrategyCompany.do">회사/부문별전략</a></li>';
					html_vv += '<li><a href="/bizStrategy/viewBizStrategyClient.do">고객별전략</a></li>';
					html_vv += '<li><a href="/bizStrategy/viewBizStrategyProjectPlan.do">전략프로젝트</a></li>';
					html_vv += '</ol>';
					html_vv += '</div>';
					
					$('#test1').html(html_vv);
					
				// 파트너 게이트 페이지
				}else if(nowUrl == 'viewPartnerIndividualInfoGate'){
				
					var html_vv = "";
					html_vv += '<div class="breadcrumb_depth2">';
					html_vv += '<a href="javascript:void(0);" class="active_menu" onclick="openNav2();">&nbsp;파트너사개인정보</a>';
					html_vv += '<ol class="menu_select select2" id="nav2" style="display:none;">';
					html_vv += '<li><a href="/partnerManagement/viewPartnerSalesLinkage.do">파트너협업</a></li>';
					html_vv += '<li><a href="/partnerManagement/viewPartnerCompanyInfoGate.do">파트너사정보</a></li>';
					html_vv += '<li><a href="/partnerManagement/viewPartnerIndividualInfoGate.do">파트너사개인정보</a></li>';
					html_vv += '</ol>';
					html_vv += '</div>';
					
					$('#test1').html(html_vv);
				
				// 파트너 디테일 페이지
				}else if(nowUrl == 'viewPartnerIndividualInfoDetail'){
					
					var html_vv = "";
					html_vv += '<div class="breadcrumb_depth2">';
					html_vv += '<a href="javascript:void(0);" class="active_menu" onclick="openNav2();">&nbsp;파트너사개인정보</a>';
					html_vv += '<ol class="menu_select select2" id="nav2" style="display:none;">';
					html_vv += '<li><a href="/partnerManagement/viewPartnerSalesLinkage.do">파트너협업</a></li>';
					html_vv += '<li><a href="/partnerManagement/viewPartnerCompanyInfoGate.do">파트너사정보</a></li>';
					html_vv += '<li><a href="/partnerManagement/viewPartnerIndividualInfoGate.do">파트너사개인정보</a></li>';
					html_vv += '</ol>';
					html_vv += '</div>';
					
					$('#test1').html(html_vv);
					
				// 파트너 수정및 등록 페이지
				}else if(nowUrl == 'formPartnerIndividualInfoDetail'){
					
					var html_vv = "";
					html_vv += '<div class="breadcrumb_depth2">';
					html_vv += '<a href="javascript:void(0);" class="active_menu" onclick="openNav2();">&nbsp;파트너사개인정보</a>';
					html_vv += '<ol class="menu_select select2" id="nav2" style="display:none;">';
					html_vv += '<li><a href="/partnerManagement/viewPartnerSalesLinkage.do">파트너협업</a></li>';
					html_vv += '<li><a href="/partnerManagement/viewPartnerCompanyInfoGate.do">파트너사정보</a></li>';
					html_vv += '<li><a href="/partnerManagement/viewPartnerIndividualInfoGate.do">파트너사개인정보</a></li>';
					html_vv += '</ol>';
					html_vv += '</div>';
					
					$('#test1').html(html_vv);
				// 파트너사 게이트 페이지
				}else if(nowUrl == 'viewPartnerCompanyInfoGate'){
					var html_vv = "";
					html_vv += '<div class="breadcrumb_depth2">';
					html_vv += '<a href="javascript:void(0);" class="active_menu" onclick="openNav2();">&nbsp;파트너사정보</a>';
					html_vv += '<ol class="menu_select select2" id="nav2" style="display:none;">';
					html_vv += '<li><a href="/partnerManagement/viewPartnerSalesLinkage.do">파트너협업</a></li>';
					html_vv += '<li><a href="/partnerManagement/viewPartnerCompanyInfoGate.do">파트너사정보</a></li>';
					html_vv += '<li><a href="/partnerManagement/viewPartnerIndividualInfoGate.do">파트너사개인정보</a></li>';
					html_vv += '</ol>';
					html_vv += '</div>';
					
					$('#test1').html(html_vv);
					
				// 파트너사 디테일 페이지
				}else if(nowUrl == 'viewPartnerCompanyInfoDetail'){
					var html_vv = "";
					html_vv += '<div class="breadcrumb_depth2">';
					html_vv += '<a href="javascript:void(0);" class="active_menu" onclick="openNav2();">&nbsp;파트너사정보</a>';
					html_vv += '<ol class="menu_select select2" id="nav2" style="display:none;">';
					html_vv += '<li><a href="/partnerManagement/viewPartnerSalesLinkage.do">파트너협업</a></li>';
					html_vv += '<li><a href="/partnerManagement/viewPartnerCompanyInfoGate.do">파트너사정보</a></li>';
					html_vv += '<li><a href="/partnerManagement/viewPartnerIndividualInfoGate.do">파트너사개인정보</a></li>';
					html_vv += '</ol>';
					html_vv += '</div>';
					
					$('#test1').html(html_vv);
				}
				// 파트너사 수정 및 등록
				else if(nowUrl == 'formPartnerCompanyInfoDetail'){
					var html_vv = "";
					html_vv += '<div class="breadcrumb_depth2">';
					html_vv += '<a href="javascript:void(0);" class="active_menu" onclick="openNav2();">&nbsp;파트너사정보</a>';
					html_vv += '<ol class="menu_select select2" id="nav2" style="display:none;">';
					html_vv += '<li><a href="/partnerManagement/viewPartnerSalesLinkage.do">파트너협업</a></li>';
					html_vv += '<li><a href="/partnerManagement/viewPartnerCompanyInfoGate.do">파트너사정보</a></li>';
					html_vv += '<li><a href="/partnerManagement/viewPartnerIndividualInfoGate.do">파트너사개인정보</a></li>';
					html_vv += '</ol>';
					html_vv += '</div>';
					
					$('#test1').html(html_vv);
				}
			}
			
			if(bizStrategy2 == "회사전략"){
				var html_vv = "";
				html_vv += '<div class="breadcrumb_depth2">';
				html_vv += '<a href="javascript:void(0);" class="active_menu" onclick="openNav2();">&nbsp;회사/부문별전략</a>';
				html_vv += '<ol class="menu_select select2" id="nav2" style="display:none;">';
				html_vv += '<li><a href="/bizStrategy/viewBizStrategyCompany.do">회사/부문별전략</a></li>';
				html_vv += '<li><a href="/bizStrategy/viewBizStrategyClient.do">고객별전략</a></li>';
				html_vv += '<li><a href="/bizStrategy/viewBizStrategyProjectPlan.do">전략프로젝트</a></li>';
				html_vv += '</ol>';
				html_vv += '</div>';
				
				$('#test1').html(html_vv);
				
			}else if(bizStrategy2 == '본부전략'){
				var html_vv = "";
				html_vv += '<div class="breadcrumb_depth2">';
				html_vv += '<a href="javascript:void(0);" class="active_menu" onclick="openNav2();">&nbsp;회사/부문별전략</a>';
				html_vv += '<ol class="menu_select select2" id="nav2" style="display:none;">';
				html_vv += '<li><a href="/bizStrategy/viewBizStrategyCompany.do">회사/부문별전략</a></li>';
				html_vv += '<li><a href="/bizStrategy/viewBizStrategyClient.do">고객별전략</a></li>';
				html_vv += '<li><a href="/bizStrategy/viewBizStrategyProjectPlan.do">전략프로젝트</a></li>';
				html_vv += '</ol>';
				html_vv += '</div>';
				
				$('#test1').html(html_vv);
				
			}else if(bizStrategy2 == "고객전략"){
				var html_vv = "";
				html_vv += '<div class="breadcrumb_depth2">';
				html_vv += '<a href="javascript:void(0);" class="active_menu" onclick="openNav2();">&nbsp;고객별전략</a>';
				html_vv += '<ol class="menu_select select2" id="nav2" style="display:none;">';
				html_vv += '<li><a href="/bizStrategy/viewBizStrategyCompany.do">회사/부문별전략</a></li>';
				html_vv += '<li><a href="/bizStrategy/viewBizStrategyClient.do">고객별전략</a></li>';
				html_vv += '<li><a href="/bizStrategy/viewBizStrategyProjectPlan.do">전략프로젝트</a></li>';
				html_vv += '</ol>';
				html_vv += '</div>';
				
				$('#test1').html(html_vv);
				
			}else if(bizStrategy2 == '선투자프로젝트'){
				var html_vv = "";
				html_vv += '<div class="breadcrumb_depth2">';
				html_vv += '<a href="javascript:void(0);" class="active_menu" onclick="openNav2();">&nbsp;전략프로젝트</a>';
				html_vv += '<ol class="menu_select select2" id="nav2" style="display:none;">';
				html_vv += '<li><a href="/bizStrategy/viewBizStrategyCompany.do">회사/부문별전략</a></li>';
				html_vv += '<li><a href="/bizStrategy/viewBizStrategyClient.do">고객별전략</a></li>';
				html_vv += '<li><a href="/bizStrategy/viewBizStrategyProjectPlan.do">전략프로젝트</a></li>';
				html_vv += '</ol>';
				html_vv += '</div>';
				
				$('#test1').html(html_vv);
			}else if(bizStrategy2 == '신규솔루션'){
				var html_vv = "";
				html_vv += '<div class="breadcrumb_depth2">';
				html_vv += '<a href="javascript:void(0);" class="active_menu" onclick="openNav2();">&nbsp;전략프로젝트</a>';
				html_vv += '<ol class="menu_select select2" id="nav2" style="display:none;">';
				html_vv += '<li><a href="/bizStrategy/viewBizStrategyCompany.do">회사/부문별전략</a></li>';
				html_vv += '<li><a href="/bizStrategy/viewBizStrategyClient.do">고객별전략</a></li>';
				html_vv += '<li><a href="/bizStrategy/viewBizStrategyProjectPlan.do">전략프로젝트</a></li>';
				html_vv += '</ol>';
				html_vv += '</div>';
				
				$('#test1').html(html_vv);
			} */
		}
		createLocation();
	});
/*
	$jq(document).ready(function(){
		$jq.ajaxLoading = function(){
			$jq("div.ajax-loader_sellers").show(); //ajax Loading
			setTimeout(function(){$jq("div.ajax-loader_sellers").hide();},300); //ajax Loading
		}
		 
		$jq.ajaxLoadingShow = function(){
			$jq("div.ajax-loader_sellers").show(); //ajax Loading
		}
		
		$jq.ajaxLoadingHide = function(){
			$jq("div.ajax-loader_sellers").hide(); //ajax Loading
		}
	});
*/
})(jQuery);


</script>
</head>

<body class="gray_bg">
<%
//일정관리를 제외한 메뉴는 현재 메뉴명 노출
if(originalURL.indexOf("/main/") == -1 && originalURL.indexOf("/calendar/") == -1 && originalURL.indexOf("/common/") == -1) {
%>
    <!-- location -->
<%--     <div class="location">
        <a href="/main/index.do" class="home"><img src="../../../images/m/icon_home.svg" /></a>
        <img src="../../../images/m/icon_arrow_gray.svg"/>
        <span>${navi_name1}</span> 
        <img src="../../../images/m/icon_arrow_gray.svg"/>
        <jsp:include page="../common/nav.jsp" flush="true"/>
    </div> --%>
    
	<!-- location -->
	<jsp:include page="/WEB-INF/jsp/m/common/nav.jsp" flush="true"/>
<%
}
%>
<div class="container_pg">