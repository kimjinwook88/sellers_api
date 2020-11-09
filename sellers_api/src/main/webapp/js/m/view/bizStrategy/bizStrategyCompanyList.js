var totalCnt = 0;
var curCnt = 0;

/**
 * 
 * @param _no
 * @returns
 */
function fncDetail(_no, cate){
	
	var v_url = 'selectBizStrategyDetail.do?pkNo='+_no
	
	if(cate){
		v_url += '&searchCategory='+cate;
	}else{
		v_url += '&searchCategory='+detailCategory;
	}
	
	var v_search_keyword = $("#search_keyword").val();
	if(v_search_keyword != "")
		v_url += '&search_keyword='+v_search_keyword;
		
	window.location.href = v_url;
}

/**
 * 마일스톤 출력 세팅
 * @returns
 */
function setMilestone(status, milestone, dueDate){
	
	if(isEmpty(milestone)){
		return '';
	}
	
	var milestone_html = '<span class="step">';
	
	switch (status) {
	case "G":
		milestone_html +=  '<span class="status_circle statusColor_green"></span>';
		break;
	case "Y":
		milestone_html +=  '<span class="status_circle statusColor_yellow"></span>';
		break;
	case "R":
		milestone_html +=  '<span class="status_circle statusColor_red"></span>';
		break;
	default:
		milestone_html +=  '<span class="status_circle statusColor_gray"></span>';
		break;
	}
	
	var v_act_due_date1 = (typeof dueDate == 'undefined')?'':dueDate;
	milestone_html += '<span>'+milestone+' ('+v_act_due_date1+')</span>';
	milestone_html += '</span>';
	
	return milestone_html;
}

/**
 * 리스트 폼
 * @param _object
 * @returns
 */
function fncGetItemHtml(_object){
	var obj_html = '';
	obj_html += '<li class="st_'+_object.STATUS+'"><a href="#" onclick="fncDetail('+_object.BIZ_ID+',\''+_object.CATEGORY+'\');return false;">';
	obj_html += '<span class="top">';
	obj_html += '<span class="icon_cata r3">'+_object.CATEGORY+'</span> ';
	obj_html += '<span class="subject">'+_object.SUBJECT+'</span>';
	obj_html += '</span>';
	
	obj_html += '<span class="middle">';
	obj_html += '<span class="name">책임리더 :'+_object.RL_NAME+'/'+_object.RL_DIVISION_NAME+'</span>';
	obj_html += '<span class="date">작성일 :'+_object.SYS_REGISTER_DATE+'</span>';
	obj_html += '</span><span class="bottom">';
	obj_html += '<div class="sub_box"><div class="sub_left">';
	obj_html += '<span class="sub_subject">마일스톤</span>';
	obj_html += '<span class="keymilestones">';
	//마일스톤
	obj_html += setMilestone(_object.STATUS5, _object.KEY_MILESTONE5, _object.ACT_DUE_DATE5);
	obj_html += setMilestone(_object.STATUS4, _object.KEY_MILESTONE4, _object.ACT_DUE_DATE4);
	obj_html += setMilestone(_object.STATUS3, _object.KEY_MILESTONE3, _object.ACT_DUE_DATE3);
	obj_html += setMilestone(_object.STATUS2, _object.KEY_MILESTONE2, _object.ACT_DUE_DATE2);
	obj_html += setMilestone(_object.STATUS1, _object.KEY_MILESTONE1, _object.ACT_DUE_DATE1);
			
	obj_html += '</span></div>';
	
	obj_html += '<div class="sub_right">';
	obj_html += '<span class="sub_subject">이슈상태</span>';
	obj_html += '<span class="keymilestones">';
	//이슈상태
	obj_html += setMilestone(_object.ISSUE_STATUS5, _object.ISSUE_NAME5, _object.ISSUE_DUE_DATE5);
	obj_html += setMilestone(_object.ISSUE_STATUS4, _object.ISSUE_NAME4, _object.ISSUE_DUE_DATE4);
	obj_html += setMilestone(_object.ISSUE_STATUS3, _object.ISSUE_NAME3, _object.ISSUE_DUE_DATE3);
	obj_html += setMilestone(_object.ISSUE_STATUS2, _object.ISSUE_NAME2, _object.ISSUE_DUE_DATE2);
	obj_html += setMilestone(_object.ISSUE_STATUS1, _object.ISSUE_NAME1, _object.ISSUE_DUE_DATE1);
	
	obj_html += '</span></div></div>';
	obj_html += '</span></a>';
	switch (_object.STATUS) {
	case "G":
		obj_html +=  '<div class="status_current statusColor_green"></div>';
		break;
	case "Y":
		obj_html +=  '<div class="status_current statusColor_yellow"></div>';
		break;
	case "R":
		obj_html +=  '<div class="status_current statusColor_red"></div>';
		break;
	default:
		obj_html +=  '<div class="status_current statusColor_gray"></div>';
		break;
	}
	obj_html += '</li>';
	
	return obj_html;
}

/**
 * 마일스톤 상태에 따른 리스트 색상 세팅
 * @returns
 */
function statusCount(){
	var R_count = $('.st_R').length;
	if(R_count == null){
		R_count == '0';
	}
	var Y_count;
	Y_count = $('.st_Y').length;
	if(Y_count == null){
		Y_count == '0';
	}
	var G_count = $('.st_G').length;
	if(G_count == null || G_count == ''){
		G_count == '0';
	}
	
	$("#G_count").html(G_count);
	$("#Y_count").html(Y_count);
	$("#R_count").html(R_count);
}

/**
 * 리스트 조회
 * @returns
 */
function fncShowMore(){
	var v_search_keyword = $("#search_keyword").val();
	var params = $.param({
		"rows" : 10,
		"lastrow" : curCnt,
		"sord" : "asc",
		"strategy" : strategy,
		"detailCategory" : detailCategory,
		"searchKeyword" : v_search_keyword
	});
	
	//카운트
	$.ajax({
		url : "/bizStrategy/viewBizStrategyClientCountMobile.do",
		async : false,
		datatype : 'json',
		method: 'POST',
		data : params,
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
			//$.ajaxLoading();
		},
		success : function(data){
			totalCnt = data.totalCnt;
		},
		error : function(xhr, status, code){
			alert("[에러]\ncode:"+xhr.status+"\n"+"message:"+xhr.responseText+"\n"+"error:"+error);
		},
		complete : function(){
			//$.ajaxLoadingHide();
		}
	});
	
	$.ajax({
		type : "POST",
		data : params,
		async: false,
		url: "/bizStrategy/gridBizStrategyList.do",
		success:function(data){
			var list = data.rows;
			var list_html = '';
			
			if(list.length == 0) {
				$('#result_list').html('<div style="text-align:center">내용이 없습니다.</div>');
			}
			else {
				for (var i = 0; i < list.length; i++){
					list_html += fncGetItemHtml(list[i]);
				}

				if(curCnt == 0) {
					$('#result_list').html(list_html);
				}
				else {
					$('#result_list').append(list_html);
				}

				// 카운트
				curCnt += list.length;
				
				if (parseInt(curCnt) >= parseInt(totalCnt)){
					$('#btn_more').hide();
				}
				else {
					$('#btn_more').show();
					var cnt_html = '더보기 '+curCnt+' of ' + totalCnt;
					$('#span_more').html(cnt_html);
				}
			}
			
			// 상태 색상 셋팅
			setTimeout(function(){
				statusCount();
			},200);
		},
		error : function(xhr, status, code){
			alert("[에러]\ncode:"+xhr.status+"\n"+"message:"+xhr.responseText+"\n"+"error:"+error);
		}
	});
}