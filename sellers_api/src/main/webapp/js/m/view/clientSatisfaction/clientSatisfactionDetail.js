

// 마일스톤  HTML 생성
function fnclientSatisfactionDetailHtml(_object) {
    var obj_html = '';
    var survey_date = "";
    
    // 목표일과 완료일 undefined 체크
    if (typeof _object.CSAT_SURVEY_DATE != "undefined") {
        survey_date = _object.CSAT_SURVEY_DATE;
    }

    obj_html += "<li>";
    obj_html += "    <div class='top'>";
    obj_html += "        <span class='title'>" + _object.COMPANY_NAME + "</span>";
    obj_html += "        <span class='icon_rate r5'>" + _object.CSAT_VALUE + "</span>";
    obj_html += "    </div>";
    obj_html += "    <div class='cont'>";
    obj_html += "        <span class='fc_gray_light'>응답자 : </span> <span class='fc_black'>" + _object.RESP_CUSTOMER_NAME + "</span><br/>";
    obj_html += "        <span class='fc_gray_light'>조사방법 : </span> <span class='fc_black'>" + _object.CSAT_METHOD + "</span> /";
    obj_html += "        <span class='fc_gray_light'>조사일 : </span> <span class='fc_black'>" + survey_date + "</span>";
    obj_html += "        <div class='pd_t5'>" + _object.CSAT_DETAIL + "</div>";
    obj_html += "    </div>";
    //obj_html += "    <a href='#' class='btn_issue_go'>" + "이슈 등록하기" + "</a>"; // PC버전에서 동작 하지 않아 주석처리.  2017.06.09
    obj_html += "</li>";

    return obj_html; 
}


function fncList(){
	location.href= '/clientSatisfaction/viewClientSatisfactionList.do';
}

/**
 * Follow up action  HTML 생성
 * @param _object
 * @returns
 */
function ffncFollowUpActionHtml(_object) {
    
    var obj_html = '';
    var statusColor = "";
    var due_date = "";
    var close_date = "";
    
    // 마일스톤 상태값에 따른 css 변경
    if (_object.STATUS == "Y") {
        statusColor = "yellow";
    } else if (_object.STATUS == "R") {
        statusColor = "red";
    } else if (_object.STATUS == "G") {
        statusColor = "green";
    }
   
    // 목표일과 완료일 undefined 체크
    if (typeof _object.DUE_DATE != "undefined") {
        due_date = _object.DUE_DATE;
    }
    if (typeof _object.CLOSE_DATE != "undefined") {
        close_date = _object.CLOSE_DATE;
    }

    obj_html += "<li>";
    obj_html += "    <div class='top top2'>";
    obj_html += "        <span class='title'>" + _object.CSAT_ACTION_DETAIL + "</span>";
//    obj_html += "        <span class='title'>" + _object.SOLVE_PLAN + "</span>";
    obj_html += "        <span class='status_lec statusColor_" + statusColor + "'></span>";
    obj_html += "    </div>";
    obj_html += "    <div class='cont'>";
    obj_html += "        <span class='fc_gray_light'>책임자 : </span> <span class='fc_black'>" + _object.SOLVE_OWNER + "</span><br/>";
    obj_html += "        <span class='fc_gray_light'>목표일 : </span> <span class='fc_black'>" + due_date + "</span> /";
    obj_html += "        <span class='fc_gray_light'>완료일 : </span> <span class='fc_black'>" + close_date + "</span>";
    obj_html += "        <div class='pd_t5 mg_b30'>"+ _object.SOLVE_PLAN + "</div>";
    obj_html += "    </div>";
    obj_html += "</li>";

    return obj_html; 
}    

/**
 * Follow up action
 * @returns
 */
function fncFollowUpAction() {
    //매출 계획 
    $.ajax({
        url : "/clientSatisfaction/gridSolvePlanClientSatisfaction.do",
        async : false,
        datatype : 'json',
        type : "POST",
        data : {
            pkNo : csatId
        },
        beforeSend : function(xhr){
            xhr.setRequestHeader("AJAX", true);
        },
        success : function(data){
            $('#result_list').html('');
            var list_html = '<ul>';
            for(var i=0; i<data.rows.length; i++){
            	
            	if(!data.rows[i].CSAT_ACTION_DETAIL){
            		continue;
            	}
            	
                list_html += ffncFollowUpActionHtml(data.rows[i]);
            }
            list_html += "</ul>";
            $('#result_list').append(list_html);
        },
        complete : function(){
        }
    });
}

/**
 * 조사결과 탭
 * @returns
 */
function fnclientSatisfactionDetail() {
    //조사결과 계획 
    $.ajax({
        url : "/clientSatisfaction/gridClientSatisfactionDetailList.do",
        async : false,
        datatype : 'json',
        type : "POST",
        data : {
            csat_id : csatId
        },
        beforeSend : function(xhr){
            xhr.setRequestHeader("AJAX", true);
        },
        success : function(data){            
            $('#clientSatisfactionDetail').html('');
            var list_html = '<ul>';
            for(var i=0; i<data.rows.length; i++){
                list_html += fnclientSatisfactionDetailHtml(data.rows[i]);
            }
            list_html += "</ul>";
            $('#clientSatisfactionDetail').append(list_html);
        },
        complete : function(){
        }
    }); 
}

/**
 * 탭 이동
 * @param _no
 * @returns
 */
function fncSelectTab(_no){	
	custom.fncSelectTab($('.tabmenu'), 'tab_', 'cont', _no);
}

/**
 * 탭 이동
 * @param _no
 * @returns
 *//*
function fncSelectTab(_no){
	// 탭 이동
	$('#tab_1').removeClass('active');
	$('#tab_2').removeClass('active');
	$('#tab_3').removeClass('active');
	$('#tab_'+_no).addClass('active');
	
	// 탭에 해당하는 컨테이너 보여주기
	$('.cont1').addClass('off');
	$('.cont2').addClass('off');
	$('.cont3').addClass('off');
	$('.cont'+_no).removeClass('off');
}*/

$(document).ready(function() {

	// 바로가기 파라미터 있는 경우에는 탭이동 함수 실행
	if(tabNo != ''){
		fncSelectTab(tabNo);
	}
	
    // 조사결과
    fnclientSatisfactionDetail();
    
    // Follow-Up-Action
    fncFollowUpAction();
    
});