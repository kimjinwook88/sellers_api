<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%  
response.setHeader("Cache-Control","no-store");  
response.setHeader("Pragma","no-cache");  
response.setDateHeader("Expires",0);  
if (request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache");
%>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
<title>고객사정보 상세보기</title>

<link href="${pageContext.request.contextPath}/css/m/style.css" rel="stylesheet">

</head>

<body class="gray_bg" onload="tabmenuLiWidth();">


<div class="container_pg">

	

	

	<article class="">
		<div class="title_pg ta_c">
			<h2 class="" id="COMPANY_NAME"></h2>
			<a href="#" class="btn_back" onclick="fncGoBack(); return false;">back</a>
		</div>
		
		<div class="author">
			<div id="UPDATE_NAME"></div>
		</div>
		
		<div class="mg_l10 mg_r10 mg_b20">
			<ul class="tabmenu tabmenu_type2 mg_b20">
				<li><a href="#" id="tab_1" class="active" onclick="fncSelectTab('1'); return false;">기본정보</a></li>
				<li><a href="#" id="tab_2" onclick="fncSelectTab('2'); return false;">IT정보</a></li>
				<li><a href="#" id="tab_3" onclick="fncSelectTab('3'); return false;">영업기회</a></li>
				<li><a href="#" id="tab_4" onclick="fncSelectTab('4'); return false;">고객이슈</a></li>
				<li><a href="#" id="tab_5" onclick="fncSelectTab('5'); return false;">컨택이력</a></li>
				
			</ul>
		
			<div class="cont1"><!-- 기본정보 -->
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 고객사 ID
					</div>
					<div class="cont fl_l" id="COMPANY_ID"></div>
				</div>
				
				<!-- <div class="view_cata b_line">
                    <div class="ti fl_l">
                        <span class="bullet dot"></span> CEO
                    </div>
                    <div class="cont fl_l" id="CEO_NAME"></div>
                </div> -->

                <!-- <div class="view_cata b_line">
                    <div class="ti fl_l">
                        <span class="bullet dot"></span> CIO
                    </div>
                    <div class="cont fl_l" id="CIO_NAME"></div>
                </div>

                <div class="view_cata b_line">
                    <div class="ti fl_l">
                        <span class="bullet dot"></span> CTO
                    </div>
                    <div class="cont fl_l" id="CTO_NAME"></div>
                </div> -->
				
				<!-- <div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 지역
					</div>
					<div class="cont fl_l" id="COMPANY_AREA"></div>
				</div> -->
				
				<!-- <div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 국가
					</div>
					<div class="cont fl_l" id="COMPANY_COUNTRY_NAME"></div>
					<div class="cont fl_l" id="COMPANY_COUNTRY" style="display: none;"></div>
				</div> -->
				
				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 주소
					</div>
					<div class="cont fl_l" id="POSTAL_ADDRESS"></div>
				</div>
				
				<!-- <div class="view_cata b_line">
					<div class="ti fl_l w_120">
						<span class="bullet dot"></span> 사업자등록주소
					</div>
					<div class="cont fl_l" id="BUSINESS_POSTAL_ADDRESS"></div>
				</div> -->

				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 대표전화
					</div>
					<div class="cont fl_l" id="COMPANY_TELNO">
                        <a href="tel:${detail.COMPANY_TELNO}" class="phone ds_in">${detail.COMPANY_TELNO}</a>
                    </div>
				</div>
				
				<!-- <div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> FAX
					</div>
					<div class="cont fl_l" id="COMPANY_FAX"></div>
				</div> -->

				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 산업분류
					</div>
					<div class="cont fl_l" id="SEGMENT_HAN_NAME"></div>
				</div>

				<div class="view_cata b_line">
					<div class="ti fl_l w_120">
						<span class="bullet dot"></span> 사업자등록번호
					</div>
					<div class="cont fl_l" id="BUSINESS_NUMBER"></div>
				</div>

				<div class="view_cata b_line" style="display: none;">
					<div class="ti fl_l w_120">
						<span class="bullet dot"></span> ERP 등록번호
					</div>
					<div class="cont fl_l" id="ERP_REG_CODE"></div>
				</div>

				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 업태
					</div>
					<div class="cont fl_l" id="BUSINESS_TYPE"></div>
				</div>

				<div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 종목
					</div>
					<div class="cont fl_l" id="BUSINESS_SECTOR"></div>
				</div>
				
				<!-- <div class="view_cata b_line">
					<div class="ti fl_l">
						<span class="bullet dot"></span> 신용도
					</div>
					<div class="cont fl_l" id="COMPANY_CREDIT"></div>
				</div> -->
				
			  <!-- 	<div class="view_cata_full">
					<div class="ti mg_b5">
						<span class="bullet dot"></span> 비고
					</div>
					<textarea rows="" cols="cboth cont_box" readonly="readonly" style="height:200px;" id="REMARKS"></textarea>
				</div> -->
				
				
				<!-- <div class="view_cata b_line">
                    <label class="">로고 이미지</label>
                    <div class="photo_input">
                        
                        등록된 로고가 없습니다..
                    </div>
                </div> -->
				<div class="view_cata">
                    <label class="">조직도</label>
                    <div class="ta_c">
                        <div id="img_path"></div>
                        <div id="Organization_default"></div>
                    </div>
                </div>
                
			</div>
			
			<!-- IT정보 -->
			<div class="cont2 off">
				<ul class="IT_list">
                    <li></li>
                </ul>
			</div>
			
			<!-- 영업기회 -->
			<div class="cont3 off">
				<ul class="sale_opp_list">
                    <li></li>
                </ul>
			</div>
			
			<!-- 고객이슈 -->
			<div class="cont4 off">
				<div class="essue_list ul">
                    <ul>
                        <li></li>
                    </ul>
                </div>
			</div>
			
			<!-- 컨택이력 -->
			<div class="cont5 off">
				<ul class="contact_history_list">
                    <li></li>
                </ul>
			</div>
		</div>
		</div>
       			<!--// 검색결과가 있을 경우 -->
				<!-- <a href="#" onclick="showMore(); return false;"
					class="btn_pg_more r2" id="btn_more" style="display: none;"> <span
					class="va_m" id="span_more">더보기 10 of 10</span>
				</a> -->

	</article>   

	<jsp:include page="../templates/footer.jsp" flush="true"/>


</div>
<div class="pg_bottom_func">
	<ul>
		<li><a href="#" class="" onclick="fncList(); return false;"> <img src="${pageContext.request.contextPath}/images/m//icon_list.png"/> <span>목록</span></a></li>
		<li><a href="#" class="" onclick="fncModify(); return false;"> <img src="${pageContext.request.contextPath}/images/m//icon_edit.png"/> <span>수정</span></a></li>
	</ul>
</div>
<div class="modal_screen"></div>

<form method="post" id="updateForm" action="">
    <input type="hidden" id="mode" name="mode" value="upd" />
    <input type="hidden" id="pkNo" name="pkNo" value="" />
</form>  

<!-- Mainly scripts -->
<script src="${pageContext.request.contextPath}/js/m/jquery-1.11.0.js"></script>
<script src="${pageContext.request.contextPath}/js/m/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/common.js"></script>


<script type="text/javascript">
//최영완20200129
var totalCnt = 0;
var rowCount = 15;
var pkArray = '';
var curCnt = 0;
var curCategory = '';
var v_page = 0;
var pageEnd = 10;

	//바로가기 파라미터 있는 경우에는 탭이동 함수 실행
	var tabNum = null;
	tabNum= '${param.tabNo}';
	
	if(tabNum != ''){
		fncSelectTab(tabNum);
	}
	
	function fncSelectTab(_no){
		// 탭 이동
		$('#tab_1').removeClass('active');
		$('#tab_2').removeClass('active');
		$('#tab_3').removeClass('active');
		$('#tab_4').removeClass('active');
		$('#tab_5').removeClass('active');
		$('#tab_'+_no).addClass('active');
		
		// 탭에 해당하는 컨테이너 보여주기
		$('.cont1').addClass('off');
		$('.cont2').addClass('off');
		$('.cont3').addClass('off');
		$('.cont4').addClass('off');
		$('.cont5').addClass('off');
		$('.cont'+_no).removeClass('off');
		
	}
	
	function fncList(){
		location.href= '/clientManagement/viewClientCompanyInfoGate.do';
	}
	
	function fncModify() {
		//location.href= '/clientManagement/formClientCompanyInfo.do?mode=M&company_id=${param.company_id}';
        $("#updateForm").attr("action", "/clientManagement/clientCompanyInsertForm.do");
        $('#updateForm').submit();		
	}
	
	$(document).ready(function() {
        // 상세 정보 가져오기
        fnDetail();
        companyIssue();
        companyContact();
        companyOpp();
        companyItInfo();
        
	});
	

	
	function fnDetail() {
        var params = $.param({
            datatype : 'json',
            jsp : '/clientManagement/clientCompanyInfoTabAjax'
        });
        
        $.ajax({
            url : "/clientManagement/selectCompanyInfo.do",
            datatype : 'json',
            data : {
                "companyId" : '${companyId}',
                "datatype" : "json"
            },
            cache : false,
            method : 'POST',
            beforeSend : function(xhr){
                xhr.setRequestHeader("AJAX", true);
            },
            success : function(data){
            	console.log(data);
                var companyInfo = data.gridClientCompanyInfo[0];
                
                
                //이미지 경로
				var coc = data.companyOrganizationChart;
				var path = data.imagePath; //properties-local.xml에서 경로 설정 필요합니다.
				
				
			
                $("#COMPANY_ID").html(companyInfo.COMPANY_ID);
                $("#COMPANY_NAME").html(companyInfo.COMPANY_NAME);
                $("#CEO_NAME").html(companyInfo.ORIGINALLY_CEO_NAME);
                $("#CIO_NAME").html(companyInfo.CIO_NAME);
                $("#CTO_NAME").html(companyInfo.CTO_NAME);
                $("#POSTAL_ADDRESS").html(companyInfo.POSTAL_ADDRESS);
                
                var phone =  companyInfo.COMPANY_TELNO;
                phone = phone.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
                $("#COMPANY_TELNO").html("<a href='tel:" + companyInfo.COMPANY_TELNO + "' class='phone ds_in'>" + phone + "</a>");
                $("#SEGMENT_HAN_NAME").html(companyInfo.SEGMENT_HAN_NAME);
                $("#BUSINESS_NUMBER").html(companyInfo.BUSINESS_NUMBER);
                $("#ERP_REG_CODE").html(companyInfo.ERP_REG_CODE);
                $("#BUSINESS_TYPE").html(companyInfo.BUSINESS_TYPE);
                $("#BUSINESS_SECTOR").html(companyInfo.BUSINESS_SECTOR);
                
                
                
                 if(companyInfo.COMPANY_AREA == "Y"){
                	 $("#COMPANY_AREA").html("국내");
       			 }else{
       				$("#COMPANY_AREA").html("국외");
       			 }
                
                 $("#BUSINESS_POSTAL_ADDRESS").html(companyInfo.BUSINESS_POSTAL_ADDRESS);
                 $("#COMPANY_FAX").html(companyInfo.COMPANY_FAX);
                 $("#COMPANY_CREDIT").html(companyInfo.COMPANY_CREDIT);
                 $("#REMARKS").html(companyInfo.REMARKS);
                 $("#COMPANY_COUNTRY").html(companyInfo.COMPANY_COUNTRY);
                 $("#COMPANY_COUNTRY_NAME").html(companyInfo.COUNTRY_KR_NAME + '(' + companyInfo.COUNTRY_ENG_NAME + ')' );
                 
                
                
                
                var updateDate = moment(companyInfo.SYS_UPDATE_DATE);
				updateDate = updateDate.format("YYYY-MM-DD");
				$("#UPDATE_NAME").html("<span>" + companyInfo.HAN_NAME + "(" + updateDate + ")</span>");
				
				if(coc.length > 0){
					var path2 = coc[0].FILE_PATH + coc[0].FILE_NAME;
					var imagePath = path + path2;
					
					$("#img_path").html("<img src='../../../" + path2 + "'/>");
				}else{
					$("#Organization_default").html("<img src='../../../images/m/icon_org2.gif'/>");
				}
				
				
                // 수정폼 데이터 입력
                $("#pkNo").val(companyInfo.COMPANY_ID);

            },
            complete : function(){
            }
        });
 	    
	}
	
	
	function companyIssue(){
		v_page = 0; 	
		var params = $.param({
			pageStart : curCnt,
			pageEnd : pageEnd,
			rowCount : rowCount,
			serch : 2,
			//companyId : '${companyId}',	
            datatype : 'json',
            jsp : '/clientManagement/clientCompanyIssueTabAjax',
        });
		var v_rowCount = 10;
		var v_pageStart = v_page * v_rowCount;
		var v_pageEnd = v_pageStart + 10;
		
		var countParams = $.param({
			datatype : 'json'
		});
		$.ajax({
			url : "/clientManagement/selectCompanyIssue.do",
            datatype : 'json',
            //data : params + "&" + countParams,
            data : {
                "companyId" : '${companyId}',
                "datatype" : "json",
			},
			cache : false,
	        method : 'POST',
	        beforeSend : function(xhr){
	            xhr.setRequestHeader("AJAX", true);
	        },
	        success : function(data){
	        	var clientIssue = data.clientIssue;
				var v_count = clientIssue;
				totalCnt = data.totalCnt;
	        	if(clientIssue.length > 0){
		            for(var i=0; i < 1; i++){
		            	$(".essue_list ul").html("");
		            	for(var i=0; i < clientIssue.length; i++){	
		            		
		            		var color_value = clientIssue[i]. ISSUE_STATUS_TEXT;
		            		
		            		if(color_value == "#f20056" && color_value != null){
								var red_value = "<span class='status_lec statusColor_red'></span>";
								var v_html = "<li><a href='/clientSatisfaction/selectClientIssueDetail.do?pkNo=" + clientIssue[i].ISSUE_ID + "'><div class='top'>"
									+ "<span class='title'>" + clientIssue[i].ISSUE_SUBJECT + "</span> "
									+ red_value;
							}else if(color_value == "#1ab394" && color_value != null){
								var green_value = "<span class='status_lec statusColor_green'></span>";
								var v_html = "<li><a href='/clientSatisfaction/selectClientIssueDetail.do?pkNo=" + clientIssue[i].ISSUE_ID + "'><div class='top'>"
									+ "<span class='title'>" + clientIssue[i].ISSUE_SUBJECT + "</span> "
									+ green_value;
							}else if(color_value == "#ffc000" && color_value != null){
								var yellow_value = "<span class='status_lec statusColor_yellow'></span>";
								var v_html = "<li><a href='/clientSatisfaction/selectClientIssueDetail.do?pkNo=" + clientIssue[i].ISSUE_ID + "'><div class='top'>"
									+ "<span class='title'>" + clientIssue[i].ISSUE_SUBJECT + "</span> "
									+  yellow_value;
							};
							
							var v_html2 =  "</div>"
								+ "<div class='cont'>"
									+ "<span class='fc_gray_light'>책임자 : </span> <span class='fc_black'>" + clientIssue[i].SALES_REPRESENTIVE_NAME + "</span><br/>"
									+ "<span class='fc_gray_light'>목표일 : </span> <span class='fc_black'>" + clientIssue[i].ISSUE_DATE + "</span> / "
									+ "<span class='fc_gray_light'>완료일 : </span> <span class='fc_black'>" + clientIssue[i].DUE_DATE + "</span>"
								+ "</div></a></li>";
							
							$(".essue_list ul").append(v_html, v_html2);
		            	}
		            }
	        	}else {
	        		$(".essue_list ul").html("<li><div class='top kansdk'>"
	        			+ "<span class='title'>현재  등록된 데이터가 없습니다.</span>"
	        			+ "</div>"
	        			+ "<div class='cont'>"
	        			+ "<span class='fc_gray_light'>책임자 : </span> <span class='fc_black'> -</span><br/>"
						+ "<span class='fc_gray_light'>목표일 : </span> <span class='fc_black'> -</span> / "
						+ "<span class='fc_gray_light'>완료일 : </span> <span class='fc_black'> -</span>"
	        			+ "</div></li>"
	        			
	        		);
	        	}
	            
	            //console.log(data);
	            // 수정폼 데이터 입력
	            //$("#pkNo").val(companyInfo.COMPANY_ID);
	        },
	        complete : function(){
	        	
	        }
    	});
	}
	
	function companyContact(){
		v_page = 0; 	
		var params = $.param({
			pageStart : curCnt,
			pageEnd : pageEnd,
			rowCount : rowCount,
			serch : 2,
			//companyId : '${companyId}',	
			datatype : 'json',
			jsp : '/clientManagement/clientCompanyContactTabAjax'
		});
		var v_rowCount = 10;
		var v_pageStart = v_page * v_rowCount;
		var v_pageEnd = v_pageStart + 10;
		
		var countParams = $.param({
			datatype : 'json'
		});
		$.ajax({
			url : "/clientManagement/selectCompanyContact.do",
			  //data : params + "&" + countParams,
            data : {
                "companyId" : '${companyId}',
                "datatype" : "json",
			},		
			cache : false,
			method : 'POST',
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			success : function(data){
				var contactList = data.clientContactList;
				var v_count = data.clientContactList;
				totalCnt = data.totalCnt;
				$('#result_list2').html('');
				var list = data.rows;
				var list_html = '';
				
				if( contactList.length > 0){
					for(var i=0; i < 1; i++){
			        	$(".contact_history_list").html("");
			        	for(var i=0; i < contactList.length; i++){//onClick='" + pageMove.contactDetailView(contactList) + ";'
			        		var eventId = contactList[i].EVENT_ID;
			        		var contact_list = "<li><a href='/clientSalesActive/selectContactDetail.do?pkNo=" + contactList[i].EVENT_ID + "'; ><div class='top'>"
			        						+ "<span class='title'>"
				        						+ "<span class='contact_type re va_m'>" + contactList[i].EVENT_CATEGORY + "</span>"
				        						+ "<span class='va_m'> " + contactList[i].EVENT_SUBJECT + "</span>"
			        						+ "</span>"
			        						
			        						+ "<span class='custom_name'>소속본부 : " + contactList[i].DIVISION_NAME + " / 보고자 : " + contactList[i].HAN_NAME + "</span>"
			        						+ "<span class='date'>컨택일 : " + contactList[i].EVENT_DATE + "</span>"
			        						+ "</div></a></li>";
			        		$(".contact_history_list").append(contact_list);
			        	}	
			        }				
				}else{
					$(".contact_history_list").html("<li><div class='top'>"
						+ "<span class='title'>"
						+ "<span class='contact_type re va_m'>-</span>"
						+ "<span class='va_m'> 현재 등록된 데이터가 없습니다.</span>"
						+ "</span>"
						
						+ "<span class='custom_name'>소속본부  : -</span>"
						+ "<span class='date'>컨택일 : -</span>"
						+ "</div></li>");
				}
			},
			complate : function(){
				
			}
		});
	}
	
	function companyOpp(){
		v_page = 0; 	
		var params = $.param({
			/* pageStart : curCnt,
			pageEnd : pageEnd,
			rowCount : rowCount,
			serch : 2, */
			//companyId : '${companyId}',	
			datatype : 'json',
			jsp : '/clientManagement/clientCompanyOppTabAjax'
		});
		var v_rowCount = 10;
		var v_pageStart = v_page * v_rowCount;
		var v_pageEnd = v_pageStart + 10;
		
		var countParams = $.param({
			datatype : 'json'
		});
		$.ajax({
			url : "/clientManagement/selectCompanyOpp.do",
			  //data : params + "&" + countParams,
            data : {
                "companyId" : '${companyId}',
                "datatype" : "json",
			},
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			success : function(data){
				var opp_list = data.currentOpportunity;
				var v_count = opp_list;
				totalCnt = data.totalCnt;
			
				if( opp_list.length > 0){
					for(var i=0; i < 1; i++){
			        	$(".sale_opp_list").html("");
			        	for(var i=0; i < opp_list.length; i++){
			        		var view_html = "<li><a href='/clientSalesActive/selectOpportunityDetail.do?pkNo=" + opp_list[i].OPPORTUNITY_ID + "' onClick='" + pageMove.oppDetailView(opp_list) + ";'>"
			        						+ "<span class='title '>" + opp_list[i].SUBJECT + "</span>"
			        						
			        						+ "<span class='cont'>"
			        							+ "<span class='price'>예상계약금 : " + opp_list[i].CONTRACT_AMOUNT_OR + "</span>"
			        							+ "<span class='date'>예상계약일 : " + opp_list[i].CONTRACT_DATE + "</span>"
			        						+ "</span>";
			        						
			        						+ "</a></li>";
			        		$(".sale_opp_list").append(view_html);
			        	}
					}
				}else {
	        		$(".sale_opp_list").html("<li><span class='title asd'>현재 등록된 데이터가 없습니다.</span>"
	        			+ "<span class='cont'>"
	        			+ "<span class='price'>예상계약금 : -</span>"
						+ "<span class='date'>예상계약일 : -</span>"
	        			+ "</span>"
	        			+ "</span></li>"
	        		);
				}
				//console.log(data);
			},
			complate : function(){
				
			}
		});
	}
	

	function companyItInfo(){
		var params = $.param({
			datatype : 'json',
			jsp : '/clientManagement/clientCompanyItInfoTabAjax' 
		});
		$.ajax({
			url : "/clientManagement/selectClientItInfo.do",
			data :{
				"companyId" : '${companyId}',
				"datatype" : "json"
			},
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			success : function(data){
				var itInfo_list = data.clientCompanyItInfo;
				//console.log(data.clientCompanyItInfo);
				if(itInfo_list == null){
					var view_html = "<span class='title'>HW</span>"
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>서버 : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'></textarea>"
						+ "</div>"
						
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>스토리지 : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'></textarea>"
						+ "</div>"
						
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>백업장치 : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'></textarea>"
						+ "</div>"
						
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>네트워크 : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'></textarea>"
						+ "</div>"
						
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>보안장비 : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'></textarea>"
						+ "</div>"
					

						+ "<span class='title'>SW</span>"
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>DB : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'></textarea>"
						+ "</div>"
						
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>middleware : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'></textarea>"
						+ "</div>"
						
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>백업SW : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'></textarea>"
						+ "</div>"
						
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>APM : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'></textarea>"
						+ "</div>"
						
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>DPM : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'></textarea>"
						+ "</div>"
						
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>기타 : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'></textarea>"
						+ "</div>"
						$(".IT_list").append(view_html);
				}else{
					var view_html = "<span class='title'>HW</span>"
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>서버 : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'>"+ itInfo_list.HW_SERVER +"</textarea>"
						+ "</div>"
						
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>스토리지 : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'>"+ itInfo_list.HW_STORAGE +"</textarea>"
						+ "</div>"
						
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>백업장치 : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'>"+ itInfo_list.HW_BACKUP +"</textarea>"
						+ "</div>"
						
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>네트워크 : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'>"+ itInfo_list.HW_NETWORK +"</textarea>"
						+ "</div>"
						
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>보안장비 : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'>"+ itInfo_list.HW_SECURITY +"</textarea>"
						+ "</div>"
					

						+ "<span class='title'>SW</span>"
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>DB : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'>"+ itInfo_list.SW_DB +"</textarea>"
						+ "</div>"
						
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>middleware : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'>"+ itInfo_list.SW_MIDDLEWARE +"</textarea>"
						+ "</div>"
						
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>백업SW : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'>"+ itInfo_list.SW_BACKUP +"</textarea>"
						+ "</div>"
						
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>APM : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'>"+ itInfo_list.SW_APM +"</textarea>"
						+ "</div>"
						
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>DPM : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'>"+ itInfo_list.SW_DPM +"</textarea>"
						+ "</div>"
						
						+ "<div class='view_cata_full'>"
						+ "<div class='ti mg_b0'>"
						+	"<span class='bullet dot'></span>기타 : "
						+ "</div>"
						+ "<textarea rows='' cols='cboth cont_box' readonly='readonly' style='height:100px;' id='REMARKS'>"+ itInfo_list.ETC +"</textarea>"
						+ "</div>"
						$(".IT_list").append(view_html);
				}
				/* 
				if(itInfo_list.HW_SERVER == null){
					itInfo_list.HW_SERVER="";
				}
				if(itInfo_list.HW_STORAGE == null){
					itInfo_list.HW_STORAGE="";
				}
				if(itInfo_list.HW_BACKUP == null){
					itInfo_list.HW_BACKUP="";
				}
				if(itInfo_list.HW_NETWORK == null){
					itInfo_list.HW_NETWORK="";
				}
				if(itInfo_list.HW_SECURITY == null){
					itInfo_list.HW_SECURITY="";
				}
				if(itInfo_list.SW_DB == null){
					itInfo_list.SW_DB="";
				}
				if(itInfo_list.SW_MIDDLEWARE == null){
					itInfo_list.SW_MIDDLEWARE="";
				}
				if(itInfo_list.SW_BACKUP == null){
					itInfo_list.SW_BACKUP="";
				}
				if(itInfo_list.SW_APM == null){
					itInfo_list.SW_APM="";
				}
				if(itInfo_list.SW_DPM == null){
					itInfo_list.SW_DPM="";
				}
				if(itInfo_list.ETC == null){
					itInfo_list.ETC="";
				} */
				
				
			
			},
			complate : function(){
				
			} 
		});
	}
	
	

	
	
	var pageMove = {
		/* 영업기회 상세보기 */
		oppDetailView : function (opp_list){
			//window.location.href= "/clientSalesActive/selectOpportunityDetail.do";
		},
		/* 컨택이력 상세보기 */
		contactDetailView : function (contactList){
			
			//window.location.href= "/clientSalesActive/selectOpportunityDetail.do";
		}
	}
	
</script>

</body>
</html>