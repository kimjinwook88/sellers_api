<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/m/common/cache.jsp" %>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
<title>파트너협업</title>

<link href="${pageContext.request.contextPath}/css/m/style.css" rel="stylesheet" type="text/css">

</head>

<body class="white_bg" onload="tabmenuLiWidth();">

<div class="container_pg">

    <article class="">
        <div class="title_pg mg_b10 ">
            <h2 class="mg_b5">${searchDetail.COMPANY_NAME}</h2>
            <a href="#" class="btn_back" onclick="window.history.back();return false;">back</a>
        </div>

        <ul class="tabmenu tabmenu_type2 mg_b20">
            <li><a href="#" id="tab_1" class="active" onclick="fncSelectTab('1'); return false;">기본정보</a></li>
            <li><a href="#" id="tab_2" onclick="fncSelectTab('2'); return false;">Cadence History</a></li>        
        </ul>

        <div class="pg_cont">           

            <!-- 위의 탭 클릭시 아래의 cont1, cont2가  하나씩 보여지도록 해주세요 -->

            <div class="cont1 "><!-- 기본정보 -->

                <div class="view_cata b_line">
                    <div class="ti fl_l">
                        <span class="bullet dot"></span> 파트너사
                    </div>
                    <div class="cont fl_l">${searchDetail.COMPANY_NAME}</div>
                </div>

                <div class="view_cata b_line">
                    <div class="ti fl_l">
                        <span class="bullet dot"></span> 유형
                    </div>
                    <div class="cont fl_l">${searchDetail.PARTNER_CODE}</div>
                </div>

                <div class="view_cata b_line">
                    <div class="ti fl_l">
                        <span class="bullet dot"></span> 영업대표
                    </div>
                    <div class="cont fl_l">${searchDetail.SALES_NAME}</div>
                </div>

                <div class="view_cata b_line">
                    <div class="ti fl_l">
                        <span class="bullet dot"></span> BP직원
                    </div>
                    <div class="cont fl_l">${searchDetail.PARTNER_INDIVIDUAL_ID}</div>
                </div>

                <div class="view_cata b_line">
                    <div class="ti fl_l w_120">
                        <span class="bullet dot"></span> Cadence 주기
                    </div>
                    <div class="cont fl_l">${searchDetail.CADENCE_CYCLE}</div>
                </div>

                <div class="view_cata b_line">
                    <div class="ti fl_l w_120">
                        <span class="bullet dot"></span> Cadence Type
                    </div>
                    <div class="cont fl_l">${searchDetail.CADENCE_TYPE}</div>
                </div>

                <!-- <div class="view_cata_full b_line">
                    <div class="ti mg_b5">
                        <span class="bullet dot"></span> Cadence 주기
                    </div>
                    <div class="pd_l15">
                        <label for="f_action1" class="mg_r30"><input type="radio" id="f_action1" name="term" disabled class="va_m"/><span class="va_m">Monthly</span></label>
                        <label for="f_action2" class=""><input type="radio" id="f_action2" checked name="term" disabled class="va_m"/><span class="va_m">Weekly</span></label>
                    </div>
                </div>

                <div class="view_cata_full b_line">
                    <div class="ti mg_b5">
                        <span class="bullet dot"></span> Cadence Type
                    </div>
                    <div class="pd_l15">
                        <label for="f_type1" class="mg_r20"><input type="radio" id="f_type1" name="type" disabled class="va_m"/><span class="va_m">Face</span></label>
                        <label for="f_type2" class="mg_r20"><input type="radio" id="f_type2" name="type" disabled class="va_m"/><span class="va_m">Telephone</span></label>
                        <label for="f_type3" class=""><input type="radio" id="f_type3" checked name="type" disabled class="va_m"/><span class="va_m">email</span></label>
                    </div>
                </div> -->


            </div>

            <div class="cont2 off"><!-- 만족도 상세보기 -->

                <!-- 
                <div class="view_cata_full">
                    <div class="ti mg_b5">
                        <span class="bullet dot"></span> Cadence 이력
                    </div>
                    <div class="cboth cont_box cadence_box">
                        <ul>
                            <li>- 20160721</li>
                            <li>- 20160621</li>
                            <li>- 20160521</li>
                            <li>- 20160421</li>
                            <li>- 20160321</li>
                            <li>- 20160221</li>
                            <li>- 20160121</li>
                        </ul>
                    </div>
                </div>
                 -->

                <div class="view_cata">
                    <label>실행일자</label>
                    <select class="form_control" name="account" id="selectModalCadenceDate" onClick="selectCadenceDetail(this);">
                    </select>
                </div>

                <div class="view_cata_full">
                    <div class="ti mg_b5">
                        <span class="bullet dot"></span> 실행내용
                    </div>
                    <div class="cboth cont_box" id="textareaExecContent" name="textareaExecContent">
                    </div>
                </div>

                <!-- Action Plan -->
                <div class="view_cata_full">
                    <div class="ti mg_r5 fl_l">
                        <span class="bullet dot"></span> Action Plan
                    </div>
                    
                    <!-- 
                    <div class="sortArea mg_b5 fl_l">
                        <div class="dropdown">
                          <button class="dropdown-toggle r5 " type="button" />
                            전체
                            <span class="caret"></span>
                          </button>
                          <ul class="dropdown-menu w_100 r5 off">
                            <li><a href="#">일정/예산</a></li>
                            <li><a href="#">경쟁상황</a></li>
                            <li><a href="#">솔루션</a></li>
                            <li><a href="#">계약조건</a></li>
                          </ul>
                        </div>
                    </div>
                     -->

                    <div class="cboth keymilestones_list" >
                        <ul id="action_result">
                            <!-- 
                            <li>
                                <div class="top top2">
                                    <span class="title">일정대로 진행되는가?</span>
                                    <span class="status_lec statusColor_green"></span>
                                </div>
                                <div class="cont">
                                    <span class="fc_gray_light">담당자 : </span> <span class="fc_black">심윤영</span><br/>
                                    <span class="fc_gray_light">목표일 : </span> <span class="fc_black">2016-08-10</span> / 
                                    <span class="fc_gray_light">완료일 : </span> <span class="fc_black">2016-08-10</span>
                                </div>
                            </li>
                             -->
                        </ul>
                    </div>
                </div>
                <!-- // Action Plan -->

                <div class="view_cata_full">
                    <div class="ti mg_b5">
                        <span class="bullet dot"></span> 회의록
                    </div>
                    <div class="cboth cont_box">
                        <ul class="file_list" id="divFileUploadList">
                            <!-- 
                            <li><a href="">20160724회의록.doc</a></li>
                             -->
                        </ul>
                    </div>
                </div>

            </div>

        </div>

        <div class="partnerCooperationSales">
            <ul>
                <li><a href="#" class="" id="salesLinkageList"> <img src="${pageContext.request.contextPath}/images/m/icon_list.png" /> <span>목록</span></a></li>
                <%-- <li><a href="#" class="" id="updateSalesLinkage"> <img src="${pageContext.request.contextPath}/images/m/icon_edit.png" /> <span>수정</span></a></li> --%>
                <%-- <li><a href="#" class="" id="insertSalesCadence"> <img src="${pageContext.request.contextPath}/images/m/icon_edit.png" /> <span>Cadence등록</span></a></li> --%>
            </ul>
        </div>

    </article>   

</div>

<div class="modal_screen"></div>

<form method="post" id="updateForm" action="">
    <input type="hidden" id="mode" name="mode" value="upd" />
    <input type="hidden" id="pkNo" name="pkNo" value="${linkage_id}" />
    <input type="hidden" id="linkage_id" name="linkage_id" value="${linkage_id}" />
    <input type="hidden" id="cadence_id" name="cadence_id" />
</form>  

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

    $(document).ready(function() {
        
        //  목록 조회 페이지 이동
        $("#salesLinkageList").on("click", function(e) {
            location.href = '/partnerManagement/viewPartnerSalesLinkage.do';
            e.preventDefault();
        });
    

        //  수정 페이지 이동
        $("#updateSalesLinkage").on("click", function(e) {
            $("#updateForm").attr("action", "/partnerManagement/partnerCooperationSalesLinkageInsertForm.do");
            $('#updateForm').submit();       
            e.preventDefault();
        });

        //  등록 페이지 이동
        $("#insertSalesCadence").on("click", function(e) {
            $("#updateForm").attr("action", "/partnerManagement/partnerCooperationSalesCadenceInsertForm.do");
            $('#updateForm').submit();       
            e.preventDefault();
        });
        
        $("#selectModalCadenceDate").change(function(){
        });
        
        getCadenceDateList();
    });
    
    function getCadenceDateList() {
        //Cadence 이력
        $.ajax({
            url : "/partnerManagement/selectCadenceDateList.do",
            type : "POST",
            data : {
                linkage_id : '${linkage_id}',
                datatype : 'json'
            },
            beforeSend : function(xhr){
                xhr.setRequestHeader("AJAX", true);
                $("#selectModalCadenceDate").html("");
            },
            success : function(data){
                var list = data.selectCadenceDateList;
                if(!isEmpty(list)){
                    for(var i=0; i<list.length; i++){
                        $('#selectModalCadenceDate').append(
                            '<option value='+list[i].CADENCE_ID+'>'+list[i].EXEC_DATE+'</option>'       
                        )
                    }
                }else{
                    
                }
            },
            complete : function(){
            }
        });        
    }
    
    function selectCadenceDetail(obj) {
        // 실행날짜에 해당하는 데이터 가져오기
        $.ajax({
            url : "/partnerManagement/selectCadenceDetail.do",
            async : false,
            data : {
                cadence_id : $(obj).val(),
                datatype : 'json'
            },
            beforeSend : function(xhr){
                xhr.setRequestHeader("AJAX", true);
            },
            success : function(data){
                var map = data.selectCadenceDetail; 
                if(!isEmpty(map)){
                    $("#textareaExecContent").html(map.EXEC_CONTENT);
                }
            },
            complete: function(){
            }
        });
        
        // 액션 플랜 그리기
        $.ajax({
            url : "/partnerManagement/gridActionPlanSalesLinkage.do",
            async : false,
            data : {
                pkNo : $(obj).val(),
                datatype : 'json'
            },
            beforeSend : function(xhr){
                xhr.setRequestHeader("AJAX", true);
            },
            success : function(data){
                console.log(data.rows);
                
                var list = data.rows;
                $('#action_result').html('');

                var list_html = '';
                
                for(var i=0; i<list.length; i++) {
                    var statusColor = "";
                    // 마일스톤 상태값에 따른 css 변경
                    if (list[i].STATUS == "Y") {
                        statusColor = "yellow";
                    } else if (list[i].STATUS == "R") {
                        statusColor = "red";
                    } else if (list[i].STATUS == "G") {
                        statusColor = "green";
                    }
                    
                    list_html += "<li>";
                    list_html += "    <div class='top top2'>";
                    list_html += "        <span class='title'>" + list[i].DETAIL_CONENTS + "</span>";
                    list_html += "        <span class='status_lec statusColor_" + statusColor + "'></span>";
                    list_html += "    </div>";
                    list_html += "    <div class='cont'>";
                    list_html += "        <span class='fc_gray_light'>담당자 : </span> <span class='fc_black'>" + undefinedCheck(list[i].ACTION_OWNER) + "</span><br/>";
                    list_html += "        <span class='fc_gray_light'>목표일 : </span> <span class='fc_black'>" + undefinedCheck(list[i].DUE_DATE) + "</span> /";
                    list_html += "        <span class='fc_gray_light'>완료일 : </span> <span class='fc_black'>" + undefinedCheck(list[i].CLOSE_DATE) + "</span>";
                    list_html += "    </div>";
                    list_html += "</li>";                    
                }           
                $('#action_result').append(list_html);
                
            },
            complete: function(){
            }
        });        
        
        $.ajax({
            url: "/partnerManagement/salesLinkageFileList.do",
            data : {
                linkage_id : '${linkage_id}',
                cadence_id : $(obj).val(),
                datatype : 'json'
            },
            beforeSend : function(xhr){
                xhr.setRequestHeader("AJAX", true);
            },
            success : function(result){
                var fileList = result.salesLinkageFileList;
                //파일
                if(!isEmpty(fileList)){
                    $("#divFileUploadList").html();
                    for(var i=0; i<fileList.length; i++){
                        $("#divFileUploadList").append('<li><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=11"></li>');
                    }
                }else{
                    $("#divFileUploadList").html('<li>선택된 파일이 없습니다</li>');
                }
            },
            complete : function(){
            }
        });
    }
    
    function getCadenceDetailList() {

        $.ajax({
            url : "/partnerManagement/selectCadenceDetail.do",
            async : false,
            data : {
                cadence_id : '${cadence_id}',
                datatype : 'json'
            },
            beforeSend : function(xhr){
                xhr.setRequestHeader("AJAX", true);
            },
            success : function(data){
                var map = data.selectCadenceDetail; 

                console.log(data);
            },
            complete: function(){
            }
        });
        
        $.ajax({
            url: "/partnerManagement/salesLinkageFileList.do",
            data : {
                linkage_id : '${linkage_id}',
                cadence_id : '${cadence_id}',
                datatype : 'json'
            },
            beforeSend : function(xhr){
                xhr.setRequestHeader("AJAX", true);
            },
            success : function(result){
                var fileList = result.salesLinkageFileList;
                console.log(result);
            },
            complete : function(){
            }
        });
        
    }    
    
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