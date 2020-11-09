//var totalCnt = '${totalCnt}';

var totalCnt = 0;
var rowCount = 10;
var pkArray = '';
var curCnt = 0;
var curCategory = '';
var v_page = 0;
var pageEnd = 10;

/*
 * 모바일은 엔터키감지 설정하는 지??? 물어보기 $(document).keydown(function(event) { if
 * (event.keyCode == '13') { fncSearch($("#searchDetail").val()); } });
 */

/**
 * 리스트 클릭하여 디테일페이지로
 * @param _no
 * @param companyId
 * @param searchDetail
 * @returns
 */
function fncDetail(_no, companyId, searchDetail) {
	$("#formDetail #customer_id").val(_no);
	$("#formDetail #company_id").val(companyId);
	$("#formDetail #search_detail").val(searchDetail);
	$("#formDetail").attr("action", "/clientManagement/viewClientIndividualInfoDetail.do");
	$('#formDetail').submit();
}

/**
 * 검색 결과 리스트 폼
 * @param _object
 * @param searchDetail
 * @returns
 */
function fncGetItemHtml(_object, searchDetail) {
	$(".result_on").show();
	var companyId = _object.COMPANY_ID;
	var obj_html = '';

	var division = "";
	if (typeof _object.DIVISION != "undefined") {
		division = _object.DIVISION;
	}// ,'+ searchDetail +'
	obj_html += '<ul class="company_member_list mg_b20">';
	obj_html += '<li><a href="#" class="info" onclick="fncDetail('
			+ _object.CUSTOMER_ID + ',' + companyId + ',\'' + searchDetail
			+ '\'); return false;">';// ,'+ searchDetail +'
	obj_html += '<span class="top pd_b5">';
	obj_html += '<span class="subject">' + _object.CUSTOMER_NAME
			+ ' <span class="fs12">' + _object.POSITION + '</span></span>';
	obj_html += ' <span class="info_inner">' + _object.COMPANY_NAME + ' / '
			+ division + '</span>';
	obj_html += '</span></a>';
	obj_html += '<div class="func_box_man">';

	if (!isEmpty(_object.CELL_PHONE)) {
		obj_html += '<a href="tel:'
				+ _object.CELL_PHONE
				+ '" class="btn_phone_go"><img src="/images/m/icon_phone.png" alt="전화걸기"/></a> ';
	}

	if (!isEmpty(_object.EMAIL)) {
		obj_html += '<a href="mailto:'
				+ _object.EMAIL
				+ '" class="btn_email_go"><img src="/images/m/icon_email.png" alt="메일보내기"/></a> ';
	}

	obj_html += '</div>';
	obj_html += '</li>';
	obj_html += '</ul>';

	return obj_html;
}

/**
 * 검색
 * @param _keyword
 * @returns
 */
function fncSearch(_keyword) {

	// 공백검색 제어
	if (_keyword == " ") {
		alert("키워드 앞에 공백을 제거하고 검색해주세요.");
		return false;
	}

	v_page = 0; // 초기화
	var params = $.param({
		pageStart : curCnt,
		pageEnd : pageEnd,
		rowCount : rowCount,
		serchInfo : $("#searchDetail").val(),
		creatorId : memberId,
		serch : 2,
		datatype : 'json'
	});

	var v_rowCount = 10;
	var v_pageStart = (v_page * v_rowCount)+1;
	var v_pageEnd = (v_page+1) * 10;

	var countParams = $.param({
		datatype : 'json'
	});

	// 카운트, 최근업데이트, 결과내 검색
	$.ajax({
		url : "/clientManagement/clientIndividualInfoList2MConut.do",
		async : false,
		datatype : 'json',
		method : 'POST',
		data : params + "&" + countParams,
		success : function(data) {
			// page count
			var v_count = data.listCount;
			totalCnt = v_count.COUNT;
		},
		complete : function() {
		}
	});

	$.ajax({
		url : "/clientManagement/gridClientIndividualInfoList2.do",
		datatype : 'json',
		method : 'POST',
		data : params,
		beforeSend : function(xhr) {
			xhr.setRequestHeader("AJAX", true);
		},
		success : function(data) {
			$('#result_list2').html('');
			var list = data.rows;
			var list_html = '';

			if (list.length > 0) {
				for (var i = 0; i < list.length; i++) {
					list_html += fncGetItemHtml(list[i], _keyword);
				}

				v_page++;
				v_pageStart = (v_page * v_rowCount)+1;
				v_pageEnd = (v_page+1) * 10;

				if (parseInt(v_pageStart) >= parseInt(totalCnt)) {
					$('#btn_more').hide();
				} else {
					var cnt_html = '더보기 ' + (v_pageStart-1) + ' of ' + totalCnt;
					$('#span_more').html(cnt_html);
					$('#btn_more').show();
				}

				$('#result_cnt').html(totalCnt);
				$('#result_list2').html(list_html);
				$('#tc').show();
				$('#topList').hide();
				$('#topList2').hide();

			} else {
				alert("검색 결과가 없습니다.");
			}
		}
	});
}

// 주요 고객개인 리스트 top10
// 2018-08-08 현재 기획의도 몰라서 order by COMPANY_NAME ASC 기준으로 뽑음
function toptenList() {
	var params = $.param({
		datatype : 'json'
	});

	$.ajax({
		url : "/clientManagement/selectIndividualTopList.do",
		data : params,
		datatype : 'json',
		method : 'POST',
		beforeSend : function(xhr) {
			xhr.setRequestHeader("AJAX", true);
		},
		success : function(data) {
			var list = data.rows;
			var list_html = '';
			for (var i = 0; i < list.length; i++) {
				list_html += fncGetTopListHtml(list[i]);
			}
			$("#topList").html(list_html);
		},
		complate : function() {

		}
	});
}

function fncGetTopListHtml(_object) {
	var obj_html = '';
	obj_html = '<ul class="company_member_list mg_b20">';
	obj_html += '<li><a href="#" class="info" onclick="fncDetail('
			+ _object.CUSTOMER_ID + ',' + _object.COMPANY_ID + ',\''
			+ searchDetail + '\'); return false;">';// ,'+ searchDetail +'

	obj_html += '<span class="top pd_b5">';
	obj_html += '<span class="subject">' + _object.CUSTOMER_NAME
			+ ' <span class="fs12">' + _object.POSITION + '</span></span>';

	if (_object.TEAM == null || _object.TEAM == '') {
		obj_html += '<span class="info_inner">' + _object.COMPANY_NAME
				+ ' / - </span>';
	} else {
		obj_html += '<span class="info_inner">' + _object.COMPANY_NAME + ' / '
				+ _object.TEAM + '</span>';
	}

	obj_html += '</span></a>';
	obj_html += '<div class="func_box_man">';
	if (_object.CELL_PHONE != undefined && _object.CELL_PHONE != '') {
		obj_html += '<a href="tel:'
				+ _object.CELL_PHONE
				+ '" class="btn_phone_go"><img src="/images/m/icon_phone.png" alt="전화걸기"/></a> ';
	}
	if (_object.EMAIL != undefined && _object.EMAIL != '') {
		obj_html += '<a href="mailto:'
				+ _object.EMAIL
				+ '" class="btn_email_go"><img src="/images/m/icon_email.png" alt="메일보내기"/></a>';
	}
	obj_html += '</div>';

	obj_html += '</li>';
	obj_html += '</ul>';

	return obj_html;
}

function lineGraphGet(value) {
	var params = $.param({
		datatype : 'html',
		jsp : '/clientManagement/clientIndividualInfoLineGraphMAjax',
		selectValue : value,
		DeviceCheck : "mobile"
	});
	$.ajax({
		url : "/clientManagement/selectLineGraphData.do",
		datatype : 'html',
		type : 'GET',
		data : params,
		beforeSend : function(xhr) {
			xhr.setRequestHeader("AJAX", true);
		},
		success : function(data) {
			$("#asd").html('');
			$("#weekDate").hide();
			$("#asd").html(data);
		},
		complete : function() {
		}
	});
}

function changeLineGraphSelectbox(value) {
	//lineGraphGet(value);
}

function showMore() {

	var v_rowCount = 10;
	var v_pageStart = (v_page * v_rowCount)+1;
	var v_pageEnd = (v_page+1) * 10;

	var params = $.param({
		pageStart : v_pageStart,
		pageEnd : v_pageEnd,
		rowCount : v_rowCount,
		serchInfo : $("#searchDetail").val(),
		creatorId : memberId,
		serch : 2,
		datatype : 'json'
	});

	// 카운트, 최근업데이트, 결과내 검색
	$.ajax({
		url : "/clientManagement/clientIndividualInfoList2MConut.do",
		sync : false,
		datatype : 'json',
		method : 'POST',
		data : params,
		success : function(data) {
			var v_count = data.listCount;
			totalCnt = v_count.COUNT;
		},
		complete : function() {
		}
	});

	// 리스트
	$.ajax({
		url : "/clientManagement/gridClientIndividualInfoList2.do",
		datatype : 'json',
		method : 'POST',
		data : params,
		beforeSend : function(xhr) {
			xhr.setRequestHeader("AJAX", true);
		},
		success : function(data) {
			// $('#result_list2').html('');
			var list = data.rows;
			var list_html = '';

			if (list.length > 0) {
				for (var i = 0; i < list.length; i++) {
					list_html += fncGetItemHtml(list[i], $("#searchDetail")
							.val());
				}

				if (v_page == 0) {
					$('#result_list2').html(list_html);
				} else {
					$('#result_list2').append(list_html);
				}

				v_page++;
				v_pageStart = (v_page * v_rowCount)+1;
				v_pageEnd = (v_page * v_rowCount)+1;
				
				$('#result_cnt').html(totalCnt);

				if (parseInt(v_pageStart) >= parseInt(totalCnt)) {
					$('#btn_more').hide();
				} else {
					var cnt_html = '더보기 ' + (v_pageStart-1) + ' of ' + totalCnt;
					$('#span_more').html(cnt_html);
					$('#btn_more').show();
				}

				$('#tc').show();
				$('#topList').hide();
				$('#topList2').hide();

			} else {
				alert("검색 결과가 없습니다.");
			}
		}
	});
}


$(document).ready(function() {

	$('#btn_search').click(function(e) {
		e.preventDefault();
		var search_value = $('#searchDetail').val();
		fncSearch(search_value);
	});

	// 고객 등록
	$("#clientIndvidualInsert").on("click",	function(e) {
		$('#mode').val("ins");
		$("#inserForm").attr("action", "/clientManagement/clientIndividualInsertForm.do");
		$('#inserForm').submit();
		e.preventDefault();
	});
	
	//toptenList();
	//lineGraphGet();
});