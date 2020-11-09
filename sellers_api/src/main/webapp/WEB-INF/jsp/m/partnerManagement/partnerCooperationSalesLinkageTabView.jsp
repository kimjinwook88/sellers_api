<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
<title>파트너협업</title>

<link href="${pageContext.request.contextPath}/css/m/style.css" rel="stylesheet" type="text/css">

</head>

<body class="white_bg">

<div class="container_pg">

    <article class="list_pg">

        <div class="topFunc mg_b10">
            <div class="sortArea fl_l">
                <select name="searchvendor" id="searchvendor">
                    <option value="">파트너사 선택</option>
                </select>
            </div>
<!-- 
            <div class="fl_r">
                <a href="/partnerManagement/partnerCooperationSalesLinkageInsertForm.do" class="btn btn-primary r5"><span class="">Cadence 등록</span></a>
            </div>
 -->
        </div>

        <div class="guide_pg2 mg_b20" id="select_info">* 파트너사를 먼저 선택해주세요.</div>

        <!-- 파트너사를 선택하면 아래 영역이 디스플레이 됨. -->
        <h2 class="com_name" id="partner_name"></h2>
        <ul class="list_type_coop" id="list_type_coop">
        <!--// 파트너사를 선택하면 위 영역이 디스플레이 됨. -->
        </ul>
   
        <!-- <a href="#" class="btn_pg_more r2">
            <span class="va_m">더보기 6 of 6</span>
        </a> -->

    </article>   

</div>

<div class="modal_screen"></div>

<form id="formDetail" method="post">
    <input type="hidden" id="linkage_id"            name="linkage_id">
    <input type="hidden" id="company_name"          name="company_name">
    <input type="hidden" id="partner_code"          name="partner_code">
    <input type="hidden" id="sales_name"            name="sales_name">
    <input type="hidden" id="partner_indivisual_id" name="partner_indivisual_id">
    <input type="hidden" id="cadence_cycle"         name="cadence_cycle">
    <input type="hidden" id="cadence_type"          name="cadence_type">
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
        // 파트너사 리스트 셋팅
        fncGetPartnerList();
        
        $("#searchvendor").change(function(){

            if ($("#searchvendor option:selected").val() != "") {
                fncGetPartnerSalesLinkage();
            }
        });
    });
    
    // 협업정보를 가져오자
    function fncGetPartnerSalesLinkage() {
        var d = new Date();

        var params = $.param({
            pageStart : 1,
            pageEnd : 100000000,
            //serch : 2,
            datatype : 'json',
        });
        
        $.ajax({
            url : "/partnerManagement/gridSalesLinkage.do",
            datatype : 'json',
            method: 'POST',
            data : {
                //selectAccountYear : $("#selectAccountYear").val(),
                //selectViewList : $("#selectViewList").val(),
                selectAccountYear : d.getFullYear(),
                selectViewList : '',
                searchvendor : $("#searchvendor option:selected").val()
            },
            beforeSend : function(xhr){
                xhr.setRequestHeader("AJAX", true);
            },
            success : function(data){
                $('#select_info').hide();
                $('#partner_name').html($("#searchvendor option:selected").val());
                $('#list_type_coop').html('');

                var prev_month = d.getMonth();
                var curr_month = d.getMonth() + 1;
                var next_month = d.getMonth() +2;
                
                var list = data.rows;
                var list_html = '';
                console.log(list);
                /*
                <!--  총 3단계로 구성하며 가운데 영역은 현재 단계임, 
                    cadence 완료 상태 : clasas="action_divi act_on"
                    cadence 예정 : clasas="action_divi"
                    cadence 미완료 : clasas="action_divi yet"
                    cadence 미등록 : class="action_divi blank"
                -->
                */
                for(var i=0; i<list.length; i++) {
                    var prev_month_status = fncGetSalesLinkageMonth(list[i], prev_month);
                    var curr_month_status = fncGetSalesLinkageMonth(list[i], curr_month);
                    var next_month_status = fncGetSalesLinkageMonth(list[i], next_month);

                    list_html += "<li><a href=\"#\" onclick=\"fncDetail('" + list[i].LINKAGE_ID + "'); return false;\">";
                    list_html += '    <span class="top">';
                    list_html += '        <span class="division">' + list[i].PARTNER_CODE + '</span>';
                    list_html += '        <span class="sales_cap">';
                    list_html += '            ' + undefinedCheck(list[i].SALES_NAME) + '<span class="fc_gray_light fs_12">(영업대표)</span> / ';
                    list_html += '            ' + undefinedCheck(list[i].PARTNER_INDIVIDUAL_ID) + '<span class="fc_gray_light fs_12">(BP직원)</span>';
                    list_html += '            <span class="type">' + undefinedCheck(list[i].CADENCE_CYCLE) + '</span>';
                    list_html += '        </span>';
                    list_html += '    </span>';
                    list_html += '    <span class="action_di">';
                    list_html += '         <span class="action_divi yet">';
                    if(prev_month_status == null || prev_month_status ==''){
                    	prev_month_status = '';
                    }
                    list_html += '              <span class="">' + prev_month + '월 ( ' + prev_month_status + ')</span>';
                    list_html += '         </span>';
                    list_html += '         <span class="action_divi today">';
                    if(curr_month_status == null || curr_month_status ==''){
                    	curr_month_status = '';
                    }
                    list_html += '              <span class="">' + curr_month + '월 ( ' + curr_month_status + ')</span>';
                    list_html += '         </span>';
                    list_html += '         <span class="action_divi act_on">';
                    if(next_month_status == null || next_month_status ==''){
                    	next_month_status = '';
                    }
                    list_html += '              <span class="">' + next_month + '월 ( ' + next_month_status + ')</span>';
                    list_html += '         </span>';
                    list_html += '     </span>';
                    list_html += '</a></li>';                    
                }           
                $('#list_type_coop').append(list_html);
                
            },
            complete : function(){
            }
        });
    }
    
    // 요청한 월의 협업 상태를 리턴한다.
    function fncGetSalesLinkageMonth(_salesInfo, _month) {
        var month_status = "";
        
        switch (_month) {
        case 1   :
            month_status = _salesInfo.MONTH_1;
            break;
        case 2   :
            month_status = _salesInfo.MONTH_2;
            break;
        case 3   :
            month_status = _salesInfo.MONTH_3;
            break;
        case 4   :
            month_status = _salesInfo.MONTH_4;
            break;
        case 5   :
            month_status = _salesInfo.MONTH_5;
            break;
        case 6   :
            month_status = _salesInfo.MONTH_6;
            break;
        case 7   :
            month_status = _salesInfo.MONTH_7;
            break;
        case 8   :
            month_status = _salesInfo.MONTH_8;
            break;
        case 9   :
            month_status = _salesInfo.MONTH_9;
            break;
        case 10  :
            month_status = _salesInfo.MONTH_10;
            break;
        case 11  :
            month_status = _salesInfo.MONTH_11;
            break;
        case 12  :
            month_status = _salesInfo.MONTH_12;
            break;
        default : month_status = "";
            break;
        }        
        return month_status;
    }
    
    
    function fncGetPartnerList() {
        var params = $.param({
            pageStart : 1,
            pageEnd : 100000000,
            //serch : 2,
            datatype : 'json',
        });
        
        $.ajax({
            url : "/partnerManagement/selectPartnerCompanyList.do",
            datatype : 'json',
            method: 'POST',
            data : params,
            beforeSend : function(xhr){
                xhr.setRequestHeader("AJAX", true);
            },
            success : function(data){
                var list = data.rows;
                for(var i=0; i<list.length; i++) {
                    var company_name= undefinedCheck(list[i].COMPANY_NAME);
                    $('#searchvendor').append("<option value='" + company_name + "'>" + company_name + "</option>");
                }
            },
            complete : function(){
            }
        });
     
    }
    
    function fncDetail(_linkage_id){
        $("#formDetail #linkage_id").val(_linkage_id);
        $("#formDetail").attr("action", "/partnerManagement/partnerCooperationSalesLinkageModal.do");
        $('#formDetail').submit();      
    }
    
</script>


</body>
</html>
