/**
 * 목록 버튼 클릭
 * @returns
 */
function fncList(){
	location.href= '/clientSatisfaction/viewClientIssueList.do';
}

/**
 * 수정 버튼 클릭
 * @returns
 */
function fncModify(){
	
	// 탭 확인
	var tabEl = $('.tabmenu .active');
	var tabIdx = $('.tabmenu li a').index(tabEl);
	
	// 코칭톡 탭일 경우 기본정보 탭으로 수정화면
	if(tabIdx == 2){
		tabIdx = 0;
	}
	
	$("#updateForm").attr("action", "/clientSatisfaction/clientIssueInsertForm.do?tabNo="+(tabIdx+1));
	$('#updateForm').submit();
}

/**
 * 이슈해결계획 리스트 출력 폼
 * @param _object
 * @returns
 */
function fncGetItemHtml(_object){
    var obj_html = '';
    var close_date = '';
    var status_color = '';
    
    obj_html += '<li>';
    obj_html += '   <div class="top top2">';
    //obj_html += '       <span class="cata r2">'+_object.STATUS+'</span>';
//    obj_html += '       <span class="cata r2">'+'STATUS'+'</span>';
    obj_html += '       <span class="title">'+_object.SOLVE_PLAN+'</span>';
    if (_object.STATUS == 'G') {
        status_color = 'statusColor_green';
    } else if (_object.STATUS == 'Y') {
        status_color = 'statusColor_yellow';
    } else if (_object.STATUS == 'R') {
        status_color = 'statusColor_red';
    }
    
    obj_html += '       <span class="status_lec '+status_color+'"></span>';
    obj_html += '   </div>';
    obj_html += '   <div class="cont">';
    obj_html += '       <span class="fc_gray_light">책임자 : </span> <span class="fc_black">'+_object.SOLVE_OWNER+'</span><br/>';
    obj_html += '       <span class="fc_gray_light">해결목표일 : </span> <span class="fc_black">'+_object.DUE_DATE+'</span> /';
    
    if (typeof _object.CLOSE_DATE != 'undefined') {
        close_date = _object.CLOSE_DATE;
    }
    obj_html += '       <span class="fc_gray_light">실제완료일 : </span> <span class="fc_black">'+close_date+'</span>';
    obj_html += '   </div>';
    obj_html += '</li>';
    
    return obj_html;
}	

/**
 * 디테일 
 * @returns
 */
function fncActionPlan(){
    
    $.ajax({
        type : "POST",
        async: false,
        datatype : 'json',
        url: "/clientSatisfaction/selectSolvePlanIssue.do?pkNo="+$("#pkNo").val(),
        success:function(data){
            var list = data.rows;
            var list_html = '';
            for (var i = 0; i < list.length; i++){
                list_html += fncGetItemHtml(list[i]);
            } 
            
            $('#result_list').append(list_html);

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


$(document).ready(function() {
	
	// 코칭톡 탭으로 이동
	if(coachingTalkParam.toUpperCase() == 'Y'){
		fncSelectTab('3');
	}else if(!isEmpty(tabNo)){
		fncSelectTab(tabNo);
	}
	
	// 이슈해결계획 조회
	fncActionPlan();
	
	// Coaching Talk 조회
	coachingTalk.view('ISSUE');
	
});