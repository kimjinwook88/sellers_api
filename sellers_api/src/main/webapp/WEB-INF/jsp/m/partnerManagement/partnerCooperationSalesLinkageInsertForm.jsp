<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

        <!-- 
        <ul class="tabmenu tabmenu_type2 mg_b20">
            <li><a href="#" id="tab_1" class="active" onclick="fncSelectTab('1'); return false;">기본정보</a></li>
            <li><a href="#" id="tab_2" onclick="fncSelectTab('2'); return false;">Cadence History</a></li>        
        </ul>
         -->

        
        <div class="pg_cont">           

            <!-- 위의 탭 클릭시 아래의 cont1, cont2가  하나씩 보여지도록 해주세요 -->

            <div class="cont1 "><!-- 기본정보 -->
                <form class="form-horizontal" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">
                    <div class="form_input mg_b20">
                        <label class="">파트너사</label>
                        <input type="text" class="form_control" id="textModalCompany" name="textModalCompany" value="${searchDetail.COMPANY_NAME}" readonly/>
                    </div>
    
                    <div class="form_input mg_b20">
                        <label class="">유형</label>
                        <input type="text" value="IBM/WB" class="form_control" id="textModalSegment" name="textModalSegment" value="${searchDetail.PARTNER_CODE}" readonly/>
                    </div>
    
                    <div class="form_input mg_b20">
                        <div class="pos-rel">
                        <label class="">영업대표</label>
                        <input type="text" class="form_control" id="textModalSalesMan" name="textModalSalesMan" placeholder="영업대표를 검색해 주세요." autocomplete="off" value="${searchDetail.SALES_NAME}"/>
                        </div>
                    </div>
    
                    <div class="form_input mg_b20">
                        <label class="">BP직원</label>
                        <input type="text" class="form_control" id="textModalPartnerName" name="textModalPartnerName" value="${searchDetail.PARTNER_INDIVIDUAL_ID}"/>
                    </div>
    
                    <div class="view_cata_full b_line">
                        <div class="ti mg_b5">
                            <span class="bullet dot"></span> Cadence 주기
                        </div>
                        <div class="pd_l15">
                            <label for="f_action1" class="mg_r30"><input type="radio" class="va_m" id="optionsRadios1" name="radioModalCadenceCycle" value="Monthly"/><span class="va_m">Monthly</span></label>
                            <label for="f_action2" class=""><input type="radio" class="va_m" id="optionsRadios2" name="radioModalCadenceCycle" value="Weekly"/><span class="va_m">Weekly</span></label>
                        </div>
                    </div>
    
                    <div class="view_cata_full b_line">
                        <div class="ti mg_b5">
                            <span class="bullet dot"></span> Cadence Type
                        </div>
                        <div class="pd_l15">
                            <label for="f_type1" class="mg_r20"><input type="radio" id="optionsRadios1" name="radioModalCadenceType" class="va_m" value="Face"/><span class="va_m">Face</span></label>
                            <label for="f_type2" class="mg_r20"><input type="radio" id="optionsRadios2" name="radioModalCadenceType" class="va_m" value="Tell"/><span class="va_m">Telephone</span></label>
                            <label for="f_type3" class=""><input type="radio" id="optionsRadios3" checked name="radioModalCadenceType" class="va_m" value="Mail"/><span class="va_m">email</span></label>
                        </div>
                    </div>
                    <input type="hidden"name="hiddenModalPK"         id="hiddenModalPK"        value="${linkage_id}"/>
                    <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
                    <input type="hidden" name="hiddenModalSalesMan"  id="hiddenModalSalesMan"/>
                </form>
                
                <form class="form-horizontal" id="formModalData2" name="formModalData2" method="post" enctype="multipart/form-data">
                    <div class="view_cata">
                        <label>실행일자</label>
                        <select class="form_control" name="account" id="selectModalCadenceDate" onClick="selectCadenceDetail(this);">
                        </select>
                    </div>
    
                    <div class="form_input mg_b20">
                        <label class="">실행내용</label>
                        <textarea class="form_control" row="3" id="textareaExecContent" name="textareaExecContent"></textarea>
                    </div>               
                    <input type="hidden"name="hiddenModalPK"         id="hiddenModalPK"        value="${linkage_id}"/>
                    <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
                    <input type="hidden" name="hiddenModalSalesMan"  id="hiddenModalSalesMan"/>
                </form>
            </div>

        </div>

        <div class="pg_bottom_func len2">
            <ul>
                <li><a href="#" class="" id="salesLinkageList"> <img src="${pageContext.request.contextPath}/images/m/icon_list.png" /> <span>목록</span></a></li>
                <li><a href="#" class="" id="updateSalesLinkage"> <img src="${pageContext.request.contextPath}/images/m/icon_edit.png" /> <span>저장</span></a></li>
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
            //alert('11');
            location.href = '/partnerManagement/viewPartnerSalesLinkage.do';
            e.preventDefault();
        });
    
        //  수정 페이지 이동
        $("#updateSalesLinkage").on("click", function(e) {
            insertSalesLinkage();
            //insertCadenceHistory();
            e.preventDefault();
        });
        
        init();        
        getCadenceDateList();
    });
    
    function init() {
        commonSearch.member($("#formModalData #textModalSalesMan"), $('#formModalData #hiddenModalSalesMan')); //OI

        $('input:radio[name=radioModalCadenceCycle]:input[value=' + '${searchDetail.CADENCE_CYCLE}' + ']').attr("checked", true);
        $('input:radio[name="radioModalCadenceType"]:input[value=' + '${searchDetail.CADENCE_TYPE}' + ']').attr("checked", true);

    }
    
    function insertSalesLinkage() {
        $('#formModalData').ajaxForm({
            url : "/partnerManagement/updateSalesLinkage.do",
            async : false,
            data : {
                datatype : 'json'
            },
            beforeSubmit: function (data,form,option) {
            	//var index = $("#selectModalCadenceDate option").index($("#test option:selected"));
            	//alert(index);
            	
            	var v_data = $("#selectModalCadenceDate option:selected").val();
            	
            	if(v_data == '') {
            		alert("데이타가 존재하지 않습니다.\nCadence 등록 후 저장하세요!");
            		return false;
            	}


            	var opt_size = $("#selectModalCadenceDate option").size();
            	
            	if(opt_size == 0) {
            		alert("실행일자가 존재하지 않습니다.\n관리자에게 문의 바랍니다.");
            		return false;
            	}
            	
                if(!confirm("저장하시겠습니까?")){
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
                    //alert("저장하였습니다.");
                    // 정상적으로 저장하면 실행내역도 저장하자.
                    insertCadenceHistory();
                }else{
                    alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
                }
            },
            complete : function(){
            }
        });
        $('#formModalData').submit();
    }
    
    function insertCadenceHistory() {
         $('#formModalData2').ajaxForm({
                url : "/partnerManagement/insertSalesLinkageHistory.do",
                async : false,
                data : {
                    //selectAccountYear : $("#selectAccountYear").val(),
                    //selectViewList : $("#selectViewList").val(),
                    cadence_id : $("#selectModalCadenceDate").val(),
                    cadenceFlag : 'false',
                    cadenceActionPlanGrid : '[]', //PC버전과의 호환성을 위해 셋팅.  JSON파싱 오류로 인해 셋팅한 후 넘김. 2017.06.15
                    datatype : 'json'
                },
                beforeSubmit: function (data,form,option) {
                    //if(isEmpty($("#textHistoryExecDate").val())){
                    //    alert("날짜를 선택해 주세요.");
                    //    return false;
                    //}
                },
                beforeSend : function(xhr){
                    xhr.setRequestHeader("AJAX", true);
                },
                success: function(data){
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
         $('#formModalData2').submit();
    }
    
    
    // 실행날짜 리스트
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
                	$('#selectModalCadenceDate').html('<option value="">데이터 없음</option>');
                }
            },
            complete : function(){
            }
        });        
    }
    
    // 실행날짜에 해당하는 데이터 가져오기
    function selectCadenceDetail(obj) {
        
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
                    $("#textareaExecContent").val(map.EXEC_CONTENT);
                }
            },
            complete: function(){
            }
        });
    }
    
  
    

    
</script>

</body>
</html>