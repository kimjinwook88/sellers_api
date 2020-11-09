<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" pageEncoding="UTF-8" %>
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
<%-- <title><c:choose><c:when test="${mode eq 'ins'}">고객사 추가</c:when><c:otherwise>고객사정보 수정페이지</c:otherwise></c:choose></title> --%>

</head>
<body class="gray_bg" onload="tabmenuLiWidth();">

<div class="container_pg">
	<article class="">
			<div class="title_pg ta_c">
				<h2 class="" id="COMPANY_NAME">
					<c:choose>
						<c:when test="${mode eq 'ins'}">
							<h2>고객사 신규 등록</h2>
						</c:when>
						<c:otherwise>
							<h2 class="" id="updateName"></h2>
						</c:otherwise>
					</c:choose>
				</h2>
				<a href="javascript:void(0);" class="btn_back" onclick="window.history.back(); return false;">back</a>
			</div>
			
			<c:set var="now" value="<%=new java.util.Date()%>" />
			<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy-mm-dd" /></c:set> 
			
			<c:if test="${mode eq 'M'}">
			<div class="author" name="divModalNameAndCreateDate" id="divModalNameAndCreateDate">
				<span>${sysYear}</span>
			</div>
		</c:if>
						
			<!-- 
			<div class="author">
				<div id="UPDATE_NAME" name="divModalNameAndCreateDate" id="divModalNameAndCreateDate"></div>
				<span>2016-08-10</span>
			</div>
			 -->

  		<div class="mg_l10 mg_r10">
		<!-- <div class="pg_cont"> -->
		 <ul class="tabmenu tabmenu_type2 mg_b20">
                <li><a href="#" id="tab_1" onclick="fncSelectTab('1'); return false;" class="active">기본정보</a></li>
                <li><a href="#" id="tab_2" onclick="fncSelectTab('2'); return false;">IT정보</a></li>
            </ul>
            
			<form method="post" id="formModalData" class="form-horizontal" enctype="multipart/form-data">
				<div class="cont1 pd_t20">
					<div class="form_input mg_b20">
						<label class="">고객사명 <span style="color:red;">*</span></label>
						<input type="text" id="textModalCompanyName" name="textModalCompanyName" class="form_control" />
						<input type="hidden" class="form_control" id="textModalCompanyId" name="textModalCompanyId" readonly="readonly"/>
					</div>
					
					<div class="form_input mg_b20">
						<label>산업분류 <span style="color:red;">*</span></label>
						<select class="form_control" id="selectModalSegmentCode" name="selectModalSegmentCode"></select>
					</div>
					
					<!-- <div class="form_input mg_b20">
						<label class="">고객사 아이디</label>
						
					</div> -->
					
					<!-- <div class="form_input mg_b20">
						<label class="">고객분류 <span style="color:red;">*</span></label>
						<select class="form_control" id="selectModalHiddenCompany" name="selectModalHiddenCompany"></select>
					</div> -->
					
					<div class="form_input mg_b20">
						<label>대표전화</label>
						<input type="text" class="form_control" id="textModalCompanyTelno" name="textModalCompanyTelno" maxlength="11"/>
					</div>
					
					<!-- <div class="form_input mg_b20">
						<label>FAX</label>
						<input type="text" class="form_control" id="textModalCompanyFax" name="textModalCompanyFax" maxlength="11"/>
					</div> -->
					
					<!-- <div class="form_input mg_b20">
						<label>지역 <span style="color:red;">*</span></label>
						<select class="form_control" id="selectModalCompanyArea" name="selectModalCompanyArea"></select>
					</div> -->
					
					<!-- <div class="form_input mg_b20" style="display: none;" id="countryChange">
						<label>국가 <span style="color:red;">*</span></label>
						<select class="form_control" id="selectModalCountry" name="selectModalCountry"></select>
					</div> -->
					
					
					
					<div class="form_input mg_b20">
						<label>사업자등록번호</label>
						<input type="text" class="form_control" id="textModalBusinessNumber" name="textModalBusinessNumber"/>
					</div>
					
					<!-- <div class="form_input mg_b20">
						<label>사업자등록주소</label>
						<input type="text" class="form_control" id="textModalBusinessPostalAddress" name="textModalBusinessPostalAddress"/>
					</div> -->
					
					<div class="form_input mg_b20">
						<label>주소</label>
						<input type="text" class="form_control" id="textModalPostalAddress" name="textModalPostalAddress"/>
					</div>
					
					<!-- <div class="form_input mg_b20" style="display: none;">
					    <label>ERP 등록번호</label>
					    <input type="text" class="form_control" id="textModalErpRegCode" name="textModalErpRegCode"/>
					</div> -->
					
					<!-- <div class="form_input mg_b20">
						<label>신용도</label>
						<input type="text" class="form_control" id="textModalCompanyCredit" name="textModalCompanyCredit"/>
					</div> -->
					
					<div class="form_input mg_b20">
						<label>업태</label>
						<input type="text" class="form_control" id="textModalBusinessType" name="textModalBusinessType"/>
					</div>
					
					<div class="form_input mg_b20">
						<label>ERP 등록번호</label>
						<input type="text" class="form_control" id="textModalErpRegCode" name="textModalErpRegCode"/>
					</div>
					
					<div class="form_input mg_b20">
						<label>종목</label>
						<input type="text" class="form_control" id="textModalBusinessSector" name="textModalBusinessSector"/>
					</div>
					
					<!-- <div class="form_input mg_b10">
						<label class="">비고</label>
						<textarea class="form_control" row="3" id="textModalCompanyRemarks" name="textModalCompanyRemarks"></textarea>
					</div> -->

					<div class="h_line pd_t10"></div>	
				</div>
						
						
					<div class="cont2 off">	
					<div class="IT_list"><!-- 개인정보  -->
						<span class='title'>HW</span>
					</div>
					
					<div class='view_cata_full'>
						<div class='ti mg_b5'>
							<label class=''>서버</label>
							<textarea class="form_control" row="3" id="textModalHWServer" name="textModalHWServer"></textarea>
						</div>
						
						<div class="ti mg_b5">
	                        <label class="">스토리지</label>
	                       <textarea class="form_control" row="3" id="textModalHWStorage" name="textModalHWStorage"></textarea>
	                    </div>
	                    
	                    <div class="ti mg_b5">
	                        <label class="">백업장치</label>
	                       <textarea class="form_control" row="3" id="textModalHWBackup" name="textModalHWBackup"></textarea>
	                    </div>
	                    
	                     <div class="ti mg_b5">
	                        <label class="">네트워크</label>
	                       <textarea class="form_control" row="3" id="textModalHWNetwork" name="textModalHWNetwork"></textarea>
	                    </div>
	                    
	                    <div class="ti mg_b5">
	                        <label class="">보안장비</label>
	                       <textarea class="form_control" row="3" id="textModalHWSecurity" name="textModalHWSecurity"></textarea>
	                    </div>
					</div>
							                 
	                   <div class="IT_list"><!-- 개인정보  -->
							<span class='title'>SW</span>
					   </div>
					   <div class='view_cata_full'>
					   		<div class="ti mg_b5">
	                       <label class="">DB</label>
	                       <textarea class="form_control" row="3" id="textModalSWDb" name="textModalSWDb"></textarea>
	                    	</div>
	                    	
	                    	<div class="ti mg_b5">
	                       <label class="">MiddleWare</label>
	                       <textarea class="form_control" row="3" id="textModalSWMiddleware" name="textModalSWMiddleware"></textarea>
	                    </div>
	                    
	                     <div class="ti mg_b5">
	                        <label class="">백업SW</label>
	                        <textarea class="form_control" row="3" id="textModalSWBackup" name="textModalSWBackup"></textarea>
	                    </div>
	                    
	                    <div class="ti mg_b5">
	                        <label class="">APM</label>
	                        <textarea class="form_control" row="3" id="textModalSWApm" name="textModalSWApm"></textarea>
	                    </div>
	                    
	                    <div class="ti mg_b5">
	                        <label class="">DPM</label>
	                        <textarea class="form_control" row="3" id="textModalSWDpm" name="textModalSWDpm"></textarea>
	                    </div>
	                    
	                    <div class="ti mg_b10">
	                        <label class="">기타</label>
	                        <textarea class="form_control" row="3" id="textModalEtc" name="textModalEtc"></textarea>
	                    </div>
					   </div>
					</div>
						
	                    
	                     
	                    
	                     
	                     
	                    
                    
                    <% /****************** PC버전에서 조직도 등록 오류가 나서 주석으로 막음  filePK가 null값이 넘어가서 오류 남. 
                        * 2017.06.13 comgyver@dunet.co.kr
                    <!-- 
                    <div class="form_input mg_b20">
                        <label class="">로고 첨부(촬영)</label>
                        <a href="" class="btn lg btn-gray ds_b r5 ta_c">사진첨부 및 촬영</a> <!- 사진첨부 또는 촬영사진 첨부 ->
                        <div class="photo_input ">
                            <img src="${pageContext.request.contextPath}/images/namecard.png" alt="샘플사진" />
                        </div>
                    </div>
                    -->
                    <div class="form_input mg_b20">
                        <label class="">조직도 첨부(촬영)</label>
                        <input type="file" name="fileModalUploadPhoto" id="fileModalUploadPhoto" accept="image/*" capture="camera" onchange="getThumbnailPrivew(this,$('#divModalUploadPhoto'))" />
                        <!-- <a href="" class="btn lg btn-gray ds_b r5 ta_c">사진첨부 및 촬영</a>--> <!-- 사진첨부 또는 촬영사진 첨부 --> 
                        <div class="photo_input" id="divModalUploadPhoto">
                            <img id="imgModalInsertPhoto" src="${pageContext.request.contextPath}/images/m/namecard.png" alt="샘플사진" />
                        </div>
                    </div>
                    ******************************/ %>

				</div>
				<!-- <input type="hidden" name="hiddenModalPK"          id="hiddenModalPK"        value=""/> -->
				<input type="hidden" name="hiddenModalCreatorId"   id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
				<input type="hidden" name="hiddenModalCompanyId"   id="hiddenModalCompanyId"/>
				<input type="hidden" name="hiddenModalSegmentCode" id="hiddenModalSegmentCode"/>
				<input type="hidden" name="hiddenModalItInfoId" id="hiddenModalItInfoId"/>
				<input type="hidden" name="hiddenModalPK" id="hiddenModalPK"/>
				</form>
				
<form id="formDetail" method="post">
	<input type="hidden" id="customer_id" name="customer_id">
	<input type="hidden" id="company_id" name="company_id">
	<input type="hidden" id="searchDetail" name="searchDetail">
	<input type="hidden" id="opportunity_id" name="opportunity_id">
	<input type="hidden" id="issue_id" name="issue_id">
	<input type="hidden" id="returnProjectMGMTId" name="returnProjectMGMTId">
	<input type="hidden" id="returnPK" name="returnPK">
</form>

			

		</div>
	</article>
</div>

<div class="pg_bottom_func">
	<ul>
		<li><a href="#" class="" id="clientCompanyList"> <img src="${pageContext.request.contextPath}/images/m/icon_list.png" /> <span>목록</span></a></li>
		<li><a href="#" class="" id="insertClientCompany"> <img src="${pageContext.request.contextPath}/images/m/icon_edit.png" /> <span>저장</span></a></li>
	</ul>
</div>

<div class="modal_screen"></div>

<!-- Mainly scripts -->
<script src="${pageContext.request.contextPath}/js/m/jquery-1.11.0.js"></script>
<script src="${pageContext.request.contextPath}/js/m/jquery.form.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/plugins/validate/jquery.validate.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/plugins/autocomplete/jquery.auto-complete.js"></script>
<link href="${pageContext.request.contextPath}/js/m/plugins/autocomplete/jquery.auto-complete.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/m/common.js"></script>
<script src="${pageContext.request.contextPath}/js/m/plugins/file/jQuery.MultiFile.min.js"></script>

<script type="text/javascript">

    $(document).ready(function(e){
    	
    	$("#selectModalHiddenCompany").html('<option value="">===선택===</option>');
		$("#selectModalHiddenCompany").append('<option value="Y">가망고객</option>');
		$("#selectModalHiddenCompany").append('<option value="N">잠재고객</option>');
        
    	$("#selectModalCompanyArea").html('<option value="">===선택===</option>');
		$("#selectModalCompanyArea").append('<option value="Y">국내</option>');
		$("#selectModalCompanyArea").append('<option value="N">국외</option>');
    	
		$("#selectModalCompanyArea").change(function(){
			if(this.value == "N"){
				$("#countryChange").show();
			}else{
				$("#selectModalCountry option:eq(33)").attr("selected", "selected");
				$("#countryChange").hide();
			}
		});
		
		// 산업분류코드 
		fncTextModalSegmentCode();
		fncTextModalCountryCode();
		//유효성 체크
		validate();
		
		//자동완성 검색
		commonSearch.customer($("#formModalData #textModalCeoName"), $('#formModalData #hiddenModalCeoID'), '', $("#formModalData #textModalCompanyId"));
		commonSearch.customer($("#formModalData #textModalCioName"), $('#formModalData #hiddenModalCioID'), '', $("#formModalData #textModalCompanyId"));
		commonSearch.customer($("#formModalData #textModalCtoName"), $('#formModalData #hiddenModalCtoID'), '', $("#formModalData #textModalCompanyId"));
		
		//유효성 검사
		$("#textModalCompanyName, #selectModalSegmentCode").on("blur",function(e){
			$("#formModalData").find(e.target).valid();
		});
		
		//유효성 검사
		$("#selectModalCountry, #selectModalCountry").on("blur",function(e){
			$("#formModalData").find(e.target).valid();
		});
		
		//모달 초기화
		$("#divModalNameAndCreateDate").html("<span>작성일 : "+commonDate.year+"-"+commonDate.month+"-"+commonDate.day+"</span>");
		
		// 고객사 목록 조회 페이지 이동
		$("#clientCompanyList").on("click", function(e) {
			location.href = '/clientManagement/viewClientCompanyInfoGate.do';
			e.preventDefault();
		});
		
		// 저장 
		$("#insertClientCompany").on("click", function(e) {
			insertClientCompany();
			e.preventDefault();
		});
		
		<c:if test="${mode eq 'upd'}">
			updateDetail('${pkNo}');
		</c:if>
	});

	
	function insertClientCompany(){
		var browser = getIEVersionCheck();
		var url = "/clientManagement/insertClientCompanyInfo.do";
		<c:if test="${mode eq 'upd'}">
			url = "/clientManagement/updateClientCompanyInfo.do";
		</c:if>
		try {
			console.log(url);
			$('#formModalData').ajaxForm({
				url : url,
				type: "POST", 
				async : true,
				data : {
					datatype : "json",
					browser : browser
				},
				beforeSubmit: function (data,form,option) {
					if(!confirm("저장하시겠습니까?")) {
						return false;
					}
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success: function(data){
					//성공후 서버에서 받은 데이터 처리
					console.log(data);
					if(data.cnt > 0){
						alert("저장하였습니다.");
						
						window.history.back();
						/* $("#formDetail #company_id").val(data.filePK);
						$("#formDetail").attr("action", "/clientManagement/viewClientCompanyInfoDetail.do?tabNo=1");
						$('#formDetail').submit(); */
						
					}else{
						//console.log("failed");
						alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
					}
				},
				complete: function() {
				},
				error: function(){
					//에러발생을 위한 code페이지
					alert("오류 발생. 입력을 실패했습니다.\n관리자에게 문의하세요.");
				}
			});
			$('#formModalData').submit();
		} catch (err) {
			console.log("Error=" + err.message);
		}
	}
	
	
	// 산업분류코드 리스트 박스 생성
    function fncTextModalSegmentCode() {
        var params = $.param({
            datatype : 'json'
        });
        
        $.ajax({ //산업분류코드
            url : "/clientManagement/selectAllIndustrySegmentCode.do",
            async : false,
            datatype : 'json',
            method : 'POST',
            data : params,
            beforeSend : function(xhr){
                xhr.setRequestHeader("AJAX", true);
            },
            success : function(data){
                $("#selectModalSegmentCode").html('<option value="">===선택===</option>');
                $("#selectModalSegmentCode option:eq(0)").attr("selected", "selected");
                if(data.rows.length > 0){
                    for(var i=0; data.rows.length>i; i++){
                        $("#selectModalSegmentCode").append('<option value="'+ data.rows[i].SEGMENT_CODE +'">'+ data.rows[i].SEGMENT_HAN_NAME +'</option>');
                    }
                }else{
                    alert("산업분류코드를 추가해 주세요.");
                }
            },
            complete: function(){
            }
        });
    }
    
    // 국가코드 및 국가명
    function fncTextModalCountryCode() {
	    var params = $.param({
	        datatype : 'json'
	    });
	    
	    $.ajax({ //국가코드 및 명칭
			url : "/clientManagement/selectCountryCode.do",
			async : false,
			datatype : 'json',
			method : 'POST',
			data : params,
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			success : function(data){
				$("#selectModalCountry").html('<option value="">===선택===</option>');
				$("#selectModalCountry option:eq(0)").attr("selected", "selected");
				if(data.selectCountryCode.length > 0){
					for(var i=0; data.selectCountryCode.length>i; i++){
						$("#selectModalCountry").append('<option value="'+ data.selectCountryCode[i].ALPHA_2 +'">'+ data.selectCountryCode[i].COUNTRY_KR_NAME +'(' + data.selectCountryCode[i].COUNTRY_ENG_NAME + ')</option>');
					}
				}else{
					alert("국가를 추가해 주세요.");
				}
			},
			complete: function(){
			}
		});
    }
    
    
    // 파일 첨부시 해당 파일 썸네일을 보여주는 함수.
    function getThumbnailPrivew(html, $target) {
        if (html.files && html.files[0]) {
            var reader = new FileReader();
            console.log(reader);
            console.log(html.files[0]);
            reader.onload = function (e) {
                //$target.html('<img id="imgModalInsertPhoto" border="0" alt="" src='+ e.target.result + ' no-repeat center center; background-size:cover;" />'); 
                $("#imgModalInsertPhoto").attr("src", e.target.result);
            }
            reader.readAsDataURL(html.files[0]);
        }
    }
    
      
    // 수정하기 위한 고객사 데이터 셋팅
    function updateDetail(_pkNo) {
        console.log("this is update detail.");
        console.log(_pkNo);
        
        var params = $.param({
            datatype : 'json',
            jsp : '/clientManagement/clientCompanyInfoTabAjax'
        });
        
        $.ajax({
            url : "/clientManagement/selectCompanyInfo.do",
            datatype : 'json',
            data : {
                "companyId" : _pkNo, 
                "datatype" : "json"
                
            },
            cache : false,
            method : 'POST',
            beforeSend : function(xhr){
                xhr.setRequestHeader("AJAX", true);
            },
            success : function(data){
                var companyInfo = data.gridClientCompanyInfo[0];
                var companyItInfo = data.clientCompanyItInfo;
               
                //console.log(companyInfo);	
                $("#updateName").html(companyInfo.COMPANY_NAME);
                $("#textModalCompanyId").val(companyInfo.COMPANY_ID);
                $("#textModalCompanyName").val(companyInfo.COMPANY_NAME);
                $("#textModalCeoName").val(companyInfo.CEO_NAME);
                $("#textModalCioName").val(companyInfo.CEO_NAME);
                $("#textModalCtoName").val(companyInfo.CEO_NAME);
                $("#textModalPostalAddress").val(companyInfo.POSTAL_ADDRESS);
                $("#textModalCompanyTelno").val(companyInfo.COMPANY_TELNO);
                //$("#selectModalSegmentCode").val(companyInfo.SEGMENT_HAN_NAME);
                $("#selectModalSegmentCode").val(companyInfo.SEGMENT_CODE).attr("selected", "selected");
                $("#selectModalCountry").val(companyInfo.COMPANY_COUNTRY).attr("selected", "selected");
                $("#textModalBusinessNumber").val(companyInfo.BUSINESS_NUMBER);
                $("#textModalErpRegCode").val(companyInfo.ERP_REG_CODE);
                $("#textModalBusinessType").val(companyInfo.BUSINESS_TYPE);
                $("#textModalBusinessSector").val(companyInfo.BUSINESS_SECTOR);

                $("#hiddenModalCompanyId").val(companyInfo.COMPANY_ID);
                $("#textModalBusinessPostalAddress").val(companyInfo.BUSINESS_POSTAL_ADDRESS);
                $("#hiddenModalItInfoId").val(companyInfo.COMPANY_ID);
                $("#hiddenModalPK").val(companyInfo.COMPANY_ID);
                
 				if(companyItInfo == null){
                	
                }else{
                	$("#textModalSWDb").val(companyItInfo.SW_DB); 
                    $("#textModalSWBackup").val(companyItInfo.SW_BACKUP);
                    $("#textModalHWSecurity").val(companyItInfo.HW_SECURITY);
                    $("#textModalEtc").val(companyItInfo.ETC);
                    $("#textModalHWNetwork").val(companyItInfo.HW_NETWORK);
                    $("#textModalHWServer").val(companyItInfo.HW_SERVER);
                    $("#textModalHWBackup").val(companyItInfo.HW_BACKUP);
                    $("#textModalSWApm").val(companyItInfo.SW_APM);
                    $("#textModalSWMiddleware").val(companyItInfo.SW_MIDDLEWARE);
                    $("#textModalSWDpm").val(companyItInfo.SW_DPM);
                    $("#textModalHWStorage").val(companyItInfo.HW_STORAGE);
                }
                
                if(companyInfo.COMPANY_AREA == "Y"){
                	$("#selectModalCompanyArea option:eq(1)").attr("selected", "selected");
                }else{
                	$("#selectModalCompanyArea option:eq(2)").attr("selected", "selected");
                }
                
                if(companyInfo.HIDDEN_COMPANY_YN == "Y"){
                	$("#selectModalHiddenCompany option:eq(1)").attr("selected", "selected");
                }else{
                	$("#selectModalHiddenCompany option:eq(2)").attr("selected", "selected");
                }
                
                $("#textModalCompanyRemarks").val(companyInfo.REMARKS);
                
            },
            complete : function(){
          
            }
        });
    }
    
    function validate () {
        $("#formModalData").validate({ // joinForm에 validate를 적용
            ignore: '', 
            rules : {
                textModalCompanyName : {
                    required : true,
                    maxlength : 100
                },
                selectModalSegmentCode : {
                    required : true
                },
                selectModalClientCategory : {
                    required : true
                },
                selectModalHiddenCompany : {
					required : true
				},
				selectModalCompanyArea : {
					required : true
				},
				selectModalCountry : {
					required : true
				},
/*                      textareaModalContents : {
                    minlength : 1,
                    maxlength : 2000
                },
*/                     
            //pwdConfirm:{required:true, equalTo:"#pwd"}, 
            // equalTo : id가 pwd인 값과 같아야함
            //name:"required", // 검증값이 하나일 경우 이와 같이도 가능
            //personalNo1:{required:true, minlength:6, digits:true},
            // minlength : 최소 입력 개수, digits: 정수만 입력 가능
            //personalNo2:{required:true, minlength:7, digits:true},
            //email:{required:true, email:true},
            // email 형식 검증
            //blog:{required:true, url:true}
            // url 형식 검증
            },
            messages : { // rules에 해당하는 메시지를 지정하는 속성
                selectModalSegmentCode : {
                    required : "산업분류를 선택하세요.", // 이와 같이 규칙이름과 메시지를 작성
                //rangelength:"1글자 이상, 10글자 이하여야 합니다.",
                //digits:"숫자만 입력해 주세요."
                },
                textModalCompanyName : {
                    required : "고객사를 입력하세요."
                },
                selectModalClientCategory : {
                    required : "고객분류를 선택하세요."
                },
                selectModalHiddenCompany : {
					required : "고객분류를 선택하세요."
				},
				selectModalCompanyArea : {
					required : "지역을 선택하세요."
				},
				selectModalCountry : {
					required : "국가를 선택하세요."
				}
                /* textareaModalContents : {
                    maxlength : "2000글자 이하여야 합니다"
                //rangelength:"1글자 이상, 30글자 이하여야 합니다"
                } */
            },
            errorPlacement : function(error, element) {
                if($(element).prop("id") == "textModalCompanyName") {
                    $("#textModalCompanyName").after(error);
                    location.href = "#textModalCompanyName";
                }
                else {
                    error.insertAfter(element); // default error placement.
                }
            }
        });        
    }
    
    //최영완 - 탭메뉴형식
    function fncSelectTab(_no){
    // 탭 이동
    $('#tab_1').removeClass('active');
    $('#tab_2').removeClass('active');
    $('#tab_'+_no).addClass('active');
    
    // 탭에 해당하는 컨테이너 보여주기
    $('.cont1').addClass('off');
    $('.cont2').addClass('off');
    $('.cont'+_no).removeClass('off');
}
</script>

</body>
</html>
