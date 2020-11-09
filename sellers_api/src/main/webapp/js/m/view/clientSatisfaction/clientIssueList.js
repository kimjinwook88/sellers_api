var totalCnt = 0;
var rowCount = 10;
var pkArray = '';
var curCnt = 0;
var curCategory = '';

var v_page = 0;

/**
 * 이슈 현황
 * @returns
 */
function fncGetIssueCnt() {
	
	// 분기 네비게이션 추가할 경우 동적으로 값 할당
	var searchYear = 2020;
	var searchQuarter = 1;
	
	// Text 셋팅
    $('#issueCntYear').html(searchYear);
    $('#issueCntQuarter').html(searchQuarter);
    
    var param = $.param({
		datatype : 'html',
		jsp : '/clientSatisfaction/clientIssueCntAjax',
		searchYear : searchYear,
		searchQuarter : searchQuarter
	});
	
	$.ajax({
		type : "POST",
		data : param,
		async : false,
		url : "/clientSatisfaction/selectClientIssueStatusCount.do",
		success : function(data) {			
			$('.row').html(data);
		}
	});    
}

/**
 * 2020년 접수 및 처리현황
 * @returns
 */
function fncGetIssueStatus(){
	
	// 분기 네비게이션 추가할 경우 동적으로 값 할당
	var searchYear = 2020;
	var searchQuarter = 1;
	
	// Text 셋팅
    $('#issueSatusYear').html(searchYear);
    $('#issueSatusQuarter').html(searchQuarter);
	
	var param = $.param({
		datatype : 'html',
		jsp : '/clientSatisfaction/clientIssueStatusAjax',
		searchYear : searchYear,
		searchQuarter : searchQuarter
	});
	
	$.ajax({
		type : "POST",
		data : param,
		async : false,
		url : "/clientSatisfaction/selectClientIssueStatus.do",
		success : function(data) {			
			$('#issueStatusTable tbody').html(data);
		}
	});
}

/**
 * 2020년 이슈 종류별 현황
 * @returns
 */
function fncGetIssueTypeStatus(){
	
	// 분기 네비게이션 추가할 경우 동적으로 값 할당
	var searchYear = 2020;
	var searchQuarter = 1;
	
	// Text 셋팅
    $('#issueTypeYear').html(searchYear);
    $('#issueTypeQuarter').html(searchQuarter);
	
	var param = $.param({
		datatype : 'html',
		jsp : '/clientSatisfaction/clientIssueTypeStatusAjax',
		searchYear : searchYear,
		searchQuarter : searchQuarter
	});
	
	$.ajax({
		type : "POST",
		data : param,
		async : false,
		url : "/clientSatisfaction/selectClientIssueTypeStatus.do",
		success : function(data) {			
			$('#issueStatusTypeTable tbody').html(data);
		}
	});
}


/**
 * 이슈 리스트 가져오기
 * @returns
 */
function getList(setTeamNameTf, textSearchKeyword){

	var v_rowCount = 10;
	var v_pageStart = v_page * v_rowCount;
	
	if(!textSearchKeyword){
		textSearchKeyword = '';
	}

	var params = $.param({
		pageStart : v_pageStart,
		rowCount : v_rowCount,
		numberPagingUseYn : 'Y',
		latelyUpdateTable : "CLIENT_ISSUE_LOG",
		searchKeyword : textSearchKeyword,
		searchCategory : $("#contactSelectbox").val(),
		detailSearchStatus : $("#selectProgressCategory").val()
	});

	// 카운트, 최근업데이트, 결과내 검색
	$.ajax({                      
		url : "/clientSatisfaction/selectIssueListCount.do",
		async : false,
		datatype : 'json',
		method : 'POST',
		data : params,
		success : function(data) {
			
			if(setTeamNameTf){
				custom.setTeamNameList(data.searchNoArray, data.searchNameArray, $('#contactSelectbox'));
			}
			
			totalCnt = data.listCount;
		}
	});

	$.ajax({
		type : "POST",
		data : params,
		async : false,
		url : "/clientSatisfaction/selectClientIssueList.do",
		success : function(data) {

			var list = data.rows;
			var list_html = '';

			if (list.length > 0) {
				$('#blank_html').hide();

				for (var i = 0; i < list.length; i++) {
					list_html += fncGetItemHtml(list[i]);
				}

				if (v_page == 0) {
					$('#list_type_coop').html(list_html);
				} else {
					$('#list_type_coop').append(list_html);
				}

				v_page++;
				v_pageStart = v_page * v_rowCount;

				if (parseInt(v_pageStart) >= parseInt(totalCnt)) {
					$('#btn_more').hide();
				} else {
					var cnt_html = '더보기 ' + v_pageStart + ' of ' + totalCnt;
					$('#span_more').html(cnt_html);
					$('#btn_more').show();
				}
			} else {
				$('#list_type_coop').html('');
				$('#btn_more').hide();

				var blank_html = '';
				blank_html += '<div class="result_blank">';

				// 진행,지연,종료 에따른 멘트
				var classify = $("#selectProgressCategory").val();
				
				if (classify == 'statusN') {
					blank_html += '진행중인 고객컨택이 없습니다.';
				} else if (classify == 'statusX') {
					blank_html += '지연된 고객컨택이 없습니다.';
				} else if (classify == 'statusY') {
					blank_html += '종료된 고객컨택이 없습니다.';
				} else {
					blank_html += '등록된 고객컨택이 없습니다.</br>신규등록 해주세요.';
				}

				blank_html += '</div>';

				$("#blank_html").html(blank_html);
				$('#blank_html').show();
			}
		}
	});
}

/**
 * 검색 조건 선택
 * @param selVal
 * @returns
 */
function selectData(){
	v_page = 0;
	$("#textSearchKeyword").val('');
	$('#btn_more').show();
	getList();
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
	getList(false, textSearchKeyword);
}

/**
 * 디테일 화면
 * @param _no
 * @returns
 */
function fncDetail(_no) {
	$('#pkNo').val(_no);
	$("#detailForm").attr("action",	"/clientSatisfaction/selectClientIssueDetail.do");
	$('#detailForm').submit();
}


/**
 * 디테일 화면 탭 지정
 * @param pkNo
 * @param tabNo
 * @returns
 */
function shortCuts(pkNo, tabNo) {
	location.href = "/clientSatisfaction/selectClientIssueDetail.do?pkNo=" + pkNo + "&tabNo=" + tabNo;
}


/**
 * 고객이슈 리스트 출력 폼
 * @param _object
 * @returns
 */
function fncGetItemHtml(_object) {
	var oriName = _object.CUSTOMER_NAME;
	var splitName = oriName.split(',');

	var obj_html = '';
	obj_html += '<li id="issue_' + _object.ISSUE_CATEGORY
			+ '" class="issue_hide"><a href="#" onclick="fncDetail('
			+ _object.ISSUE_ID + ');return false;">';
	obj_html += '<span class="top">';
	obj_html += '<span class="cata_custom  r3">' + _object.COMPANY_NAME
			+ '</span> ';
	obj_html += '<span class="subject">' + _object.ISSUE_SUBJECT + '</span>';
	obj_html += '</span>';
	obj_html += '<span class="bottom">';
	obj_html += '<span class="name">' + splitName[0];

	if (splitName.length > 1) {
		obj_html += ' 외 ' + (splitName.length - 1) + '명';
	}

	obj_html += '/ ' + _object.SALES_REPRESENTIVE_NAME + ' </span>'; // 커스터머
																		// 직급 :
																		// '+_object.POSITION+'
																		// //
																		// 책임자
																		// 직급 :
																		// '+_object.POSITION_STATUS+'
	obj_html += '<span class="date">발생일자 : ' + _object.ISSUE_DATE + '</span>';
	obj_html += '</span>';
	obj_html += '</a>';

	obj_html += '<div class="quicklink_right">';
	obj_html += '<a onclick="shortCuts(' + _object.ISSUE_ID + ', 1); return false;" >정보</a> ';
	obj_html += '<a onclick="shortCuts(' + _object.ISSUE_ID	+ ', 2); return false;" >이슈해결계획</a>';
	obj_html += '<a onclick="shortCuts(' + _object.ISSUE_ID	+ ', 3); return false;" style="margin-left:4px;">Coaching Talk</a>';
	obj_html += '</div>';

	// STATUS
	if (_object.ISSUE_STATUS_TEXT == '#f20056') { // 레드
		obj_html += '<div class="status_current statusColor_red"></div>';
	} else if (_object.ISSUE_STATUS_TEXT == '#ffc000') { // 노랑
		obj_html += '<div class="status_current statusColor_yellow"></div>';
	} else if (_object.ISSUE_STATUS_TEXT == '#1ab394') { // 그린
		obj_html += '<div class="status_current statusColor_green"></div>';
	}

	obj_html += '</li>';
	return obj_html;
}

$(document).ready(function() {
		
	// 이슈 현황
	fncGetIssueCnt();
	
	// 접수 및 처리현황
	fncGetIssueStatus();
	
	// 이슈 종류별 현황
	fncGetIssueTypeStatus();
	
	// 이슈 리스트 가져오기
	getList(true);	
	
	if (issueId != '') {
		location.href = "/salesActive/modalClientIssue.do?issueId="+issueId;
	}

	// 컨택등록 이벤트 등록
	$("#clientIssueInsertForm").on("click",function(e) {
		$('#mode').val("ins");
		$("#inserForm")
				.attr("action",
						"/clientSatisfaction/clientIssueInsertForm.do");
		console.log("mode[" + $('#mode').val()
				+ "]");
		$('#inserForm').submit();
		e.preventDefault();
	});
});