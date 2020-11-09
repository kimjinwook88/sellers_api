<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/jsp/m/common/cache.jsp" %>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
<title>파트너협업 히스토리 등록</title>

<link href="${pageContext.request.contextPath}/css/m/style.css" rel="stylesheet" type="text/css">

</head>

<body class="white_bg" onload="tabmenuLiWidth();">

<div class="container_pg">

    <article class="">
        <div class="title_pg mg_b20 ta_c">
            <h2>Cadence 등록</h2>
            <a href="#" class="btn_back" onclick="window.history.back();return false;">back</a>
        </div>

        <div class="mg_l10 mg_r10">

            <form class="form-horizontal mg_l10 mg_r10" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">
                <div class="pd_b20"><!-- 고객기본정보  -->

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

                    <div class="form_input mg_b20">
                        <label class="">실행일자</label>
                        <!-- <input type="date" class="form_control" name="account" id="selectModalCadenceDate"/> -->
                        <input type="date" class="form_control" name="textHistoryExecDate" id="textHistoryExecDate"/>
                    </div>

                    <div class="form_input mg_b20">
                        <label class="">실행내용</label>
                        <textarea class="form_control" row="3" id="textareaExecContent" name="textareaExecContent"></textarea>
                    </div>

                    <div class="guideBox">
                            Action Plan과 회의록 업로드는 PC에서만 가능합니다.
                    </div>
                </div>
                <input type="hidden"name="hiddenModalPK"         id="hiddenModalPK"        value="${linkage_id}"/>
                <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
                <input type="hidden" name="hiddenModalSalesMan"  id="hiddenModalSalesMan"/>

            </form>

        </div>

        <div class="pg_bottom_func">
            <ul>
                <li><a href="#" class="" id="salesLinkageList"> <img src="${pageContext.request.contextPath}/images/m/icon_list.png" /> <span>목록</span></a></li>
                <li><a href="#" class="" id="updateSalesCadence"> <img src="${pageContext.request.contextPath}/images/m/icon_edit.png" /> <span>저장</span></a></li>
            </ul>
        </div>

    </article>   

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

    $(document).ready(function() {
        
        //  목록 조회 페이지 이동
        $("#salesLinkageList").on("click", function(e) {
            //alert('11');
            location.href = '/partnerManagement/viewPartnerSalesLinkage.do';
            e.preventDefault();
        });
    
        //  저장
        $("#updateSalesCadence").on("click", function(e) {
            insertCadenceHistory();
            e.preventDefault();
        });
    });
    
    
    function insertCadenceHistory() {
        $('#formModalData').ajaxForm({
                url : "/partnerManagement/insertSalesLinkageHistory.do",
                async : false,
                data : {
                    //cadence_id : $("#selectModalCadenceDate").val(),
                    cadenceFlag : 'true',
                    cadenceActionPlanGrid : '[]', //PC버전과의 호환성을 위해 셋팅.  JSON파싱 오류로 인해 셋팅한 후 넘김. 2017.06.15
                    datatype : 'json'
                },
                beforeSubmit: function (data,form,option) {
                    if(isEmpty($("#textHistoryExecDate").val())){
                        alert("날짜를 선택해 주세요.");
                        return false;
                    }
                },
                beforeSend : function(xhr){
                    xhr.setRequestHeader("AJAX", true);
                },
                success: function(data){
                    console.log(data);
                    //성공후 서버에서 받은 데이터 처리
                    if(data.cnt > 0){
                        alert("저장하였습니다.");
                        location.href="/partnerManagement/viewPartnerSalesLinkage.do";
                    }else{
                        alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
                    }
                },
                complete : function(){
                }
         });  
         $('#formModalData').submit();
    }
    
    
 
  
    

    
</script>


</body>
</html>