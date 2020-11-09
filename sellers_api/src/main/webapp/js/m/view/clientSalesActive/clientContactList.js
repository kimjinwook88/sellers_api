// var curCnt = 0;
// var eventCategory = '';
// var searchAll = '';

var v_page = 0;

/**
 * 탭 선택해서 디테일화면 이동
 * @param pkNo
 * @param tabNo
 * @returns
 */
function shortCuts(pkNo, tabNo){
	location.href = "/clientSalesActive/selectContactDetail.do?pkNo=" + pkNo + "&tabNo=" + tabNo;
}


/**
 * 고객컨택내용 리스트 폼
 * @param _object
 * @returns
 */
function fncGetItemHtml(_object){
	var obj_html = '';
	
	obj_html += '<li><a href="#" onclick="fncDetail('+_object.EVENT_ID+');return false;">';
	obj_html += '<span class="top">';
	obj_html += '<span class="icon_cata r3">'+_object.EVENT_CATEGORY+'</span>';
	obj_html += ' <span class="subject">'+_object.EVENT_SUBJECT+'</span>';
	obj_html += '</span>';
	obj_html += '<span class="bottom">';
	obj_html += '<span class="name">'+_object.COMPANY_NAME+' / '+_object.CUSTOMER_NAME+'</span>';
	obj_html += '<span class="date">컨택일자 : '+_object.EVENT_DATE+'</span>';
	obj_html += '</span></a>';
	obj_html += '<div class="quicklink_right">';
	obj_html += '<a onclick="shortCuts(' + _object.EVENT_ID + ', 1); return false;" >정보</a> ';
	obj_html += '<a onclick="shortCuts(' + _object.EVENT_ID + ', 2); return false;" >Follow-Up</a>';
	obj_html += '<a onclick="shortCuts(' + _object.EVENT_ID	+ ', 3); return false;" style="margin-left:4px;">Coaching Talk</a>';
	obj_html += '</div>';
	obj_html += '</li>';
	
	return obj_html;
}

/**
 * 고객컨택내용 리스트 더보기
 * @param selVal
 * @returns
 */
function showMore(selVal, setTeamNameTf){
	if (!selVal) {
		selVal = $("#contactSelectbox").val();
	} else {
		v_page = 0;
	}
	
	var v_rowCount = 10;
	var v_pageStart = v_page * v_rowCount;
	
	var params = $.param({
		datatype : 'json',
		pageStart : v_pageStart,
		rowCount : v_rowCount,
		latelyUpdateTable : 'CLIENT_EVENT_LOG',
		numberPagingUseYn : 'Y',
		// 검색조건
		searchKeyword : $('#textSearchKeyword').val().trim(),
		selVal : selVal
	});

	// 카운트, 최근업데이트, 결과내 검색
	$.ajax({
		 url : '/clientSalesActive/selectClientContactCount.do',
		 async : false,
		 datatype : 'json',
		 method: 'post',
		 data : params,
		 success : function(data){
			 
			 if(setTeamNameTf){
				custom.setTeamNameList(data.searchNoArray, data.searchNameArray, $('#contactSelectbox'));
			 } 
			 
			// page count
			totalCnt = data.listCount;
		},
		complete : function(){
		}
	});

	// 리스트
	$.ajax({
		type : 'post',
		data : params,
		async: false,
		url: '/clientSalesActive/selectClientContactList.do',
		success:function(data){
			var list = data.rows;
			var list_html = '';
			for (var i = 0; i < list.length; i++){
				list_html += fncGetItemHtml(list[i]);
			}

			if(list.length > 0){
				$('#blank_html').hide();
				
				if(v_page == 0) {
					$('#list_type_coop').html(list_html);
				}else {
					$('#list_type_coop').append(list_html);
				}
				
				v_page++;
				v_pageStart = v_page * v_rowCount;
				
				if (parseInt(v_pageStart) >= parseInt(totalCnt)){
					$('#btn_more').hide();
				}else {
					var cnt_html = '더보기 '+v_pageStart+' of ' + totalCnt;
					$('#span_more').html(cnt_html);
				}
			}else{
				$('#list_type_coop').html('');
				$('#btn_more').hide();
				
				var blank_html = '';
				blank_html += '<div class="result_blank">';
				blank_html += '등록된 고객컨택이 없습니다.</br>신규등록 해주세요.';
				blank_html += '</div>';
				
				$("#blank_html").html(blank_html);
				$('#blank_html').show();
			}
		}
	});
}

/**
 * 컨택방법별 현황
 * @returns
 */
function fncGetContactMethod(){
	
	var param = $.param({
			datatype : 'html',
			jsp : '/clientSalesActive/clientContactMethodAjax'
	});
	
	$.ajax({
		url : '/clientSalesActive/selectClientContactMethod.do',
		method: 'post',
		data : param,
		success : function(data){
			$('#contactMethodTable tbody').html(data);
		},
		complete : function(){
		}
	});	
}

/**
 * 연관 이슈 및 잠재영업기회 현황
 * @returns
 */
function issueOppStatusCnt(){
	
	var param = $.param({
		datatype : 'html',
		jsp : '/clientSalesActive/clientContactIssueOppStatusAjax'
	});
	
	$.ajax({
		url : '/clientSalesActive/issueOppStatusCnt.do',
		method: 'post',
		data : param,
		success : function(data){
			$('#issueOppStatusTable tbody').html(data);
		},
		complete : function(){
		}
	});	
}

/**
 * 고객컨택 기간별 추이
 * @param flag
 * @param value
 * @returns
 */
function lineGraphGet(flag, value){
	if(flag == 'ceo'){
		var params = $.param({
			datatype : 'html',
			jsp : '/clientSalesActive/clientContactDashBoardLineGraphAjax',
			selectValue : value,
		});
	}else{
		var params = $.param({
			datatype : 'html',
			jsp : '/clientSalesActive/clientContactDashBoardLineGraphAjax',
			TeamValue : value,
		});
	}	
	
	$.ajax({
		url : "/clientSalesActive/selectClientContactDashBoardGraphM.do",
		method: 'post',
		data : params,
		beforeSend : function(xhr){
			xhr.setRequestHeader('ajax', true);
		},
		success : function(data){
			$("#LineGraph").html('');
			$("#LineGraph").html(data);
		},
		error: function (xhr, ajaxOptions, thrownError) {
		},
		complete : function(){
		}
	});
}

/**
 * 검색
 * @returns
 */
function fncSearch(){
	var textSearchKeyword = $('#textSearchKeyword').val();
	
	if(textSearchKeyword){
		if (textSearchKeyword.length < 1){
			alert('검색어는 2자 이상 입력해주세요.');
			return;
		}
	}
	
	v_page = 0;
	showMore();
}

/**
 * 디테일
 * @returns
 */
function fncDetail(_no){
	$('#pkNo').val(_no);
	$("#moveForm").attr("action", "/clientSalesActive/selectContactDetail.do");
	$('#moveForm').submit();
}
/*function fncSelectGroup(_group){
	$('#select_text').html(_group);
	$('.dropdown-toggle').next().toggle();
	$('.caret').toggleClass('caret_up');
	
	if (_group == '컨텍 분류선택') _group = '';
	eventCategory = _group;
	curCnt = 0;
	$('#list_type_coop').html('');
	fncShowMore();
}*/


function selectData(selVal){
	v_page = 0;
	$("#textSearchKeyword").val('');
	$('#btn_more').show();
	showMore(selVal);
}

function changeLineGraphSelectbox2(flag, value){
	lineGraphGet(flag, value);
}

function changeLineGraphSelectbox(flag, value){
	lineGraphGet(flag, value);
}

$(document).ready(function() {
	
	// 고객컨택 리스트 조회
    $('#list_type_coop').html('');
	showMore(null, true);
	
	// 컨택방법별 현황 데이터 조회
	fncGetContactMethod();
	
	// 연관이슈 및 잠재영업기회 현황 데이터 조회
	issueOppStatusCnt();
	
	// 고객컨택 기간별 추이
	// data_info 라는 테이블이 없어 주석처리 (2020. 01. 14.)
	// lineGraphGet();
		
    // 컨택 신규등록 이벤트 등록
    $("#clientContactInsertForm").on("click", function(e) {
        $('#mode').val('ins');
        $('#moveForm').attr('action', '/clientSalesActive/clientContactInsertForm.do');
        $('#moveForm').submit();       
        e.preventDefault();
    }.bind(this));	    
    
});