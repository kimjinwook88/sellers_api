

var chart2 = c3.generate({
	bindto: "#Graph",
	data: {
		columns: [
			['data1', 4.5],
		],
		type: 'bar',
		//rows : columnData,
		labels: true
	},
	bar: {
		width: {
			ratio: 0.5 // this makes bar width 50% of length between ticks
		}
		// or
		//width: 100 // this makes bar width 100px
	}
});

var totalCnt = 0;
var rowCount = 1;
var pkArray = '';
var curCnt = 0;
var curCategory = '';

var v_page = 0;

function fncChangeCategory(_cate){
	curCategory = _cate;
	$('div.dropdown button').html(_cate);
	$('.dropdown-menu').hide();

	$.ajax({
		type : "POST",
		data : {
			"searchCategory" : curCategory,
			"searchPKArray" : pkArray ,
			"resultInSearch" : 'N'
		},
		async: false,
		url: "/bizStrategy/selectProjectPlanCount.do",
		success:function(data){
			totalCnt = data.listCount;
			curCnt = 0;
			pkArray = data.searchPKArray;
			$('#result_list2').html('');
			$('#btn_more').show();
			fncShowMore();
		}
	});
}

/*
function fncGetTotalCount() {
	params = $.param({
		pageStart : curCnt, //0
		rowCount : rowCount, //10
		latelyUpdateTable : "CLIENT_SAT_LOG",
		satisfactionTargetCategory : $("#selectSatisfactionCategory").val()
	});
	
	$.ajax({
		url : "/clientSatisfaction/selectClientSatisfactionMasterListCount.do",
		async : false,
		datatype : 'json',
		method: 'POST',
		data : params,
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
		},
		success : function(data){
			//page count
			totalCnt = data.listCount;
		},
		complete : function(){
		}
	});
}
*/

/**
 * 권한에 따른 전체 선택 option 세팅
 * @returns
 */
function setAllOption(selectEl){
	
	if(auth.indexOf('ROLE_DIVISION') != -1){
		return;
	}
	
	selectEl.html('');
	var allOption = '';
				
	if(auth.indexOf('ROLE_DIVISION') != -1){
		allOption = '본부전체';
	}else if(auth.indexOf('ROLE_TEAM') != -1){
		allOption = '팀전체';
	}else{
		allOption = '회사전체';
	}
	
	var option = '<option value="">'+allOption+'</option>';
	selectEl.append(option);
}

/**
 * 디테일페이지 탭 선택하여 이동
 * @param pkNo
 * @param tabNo
 * @returns
 */
function shortCuts(pkNo, tabNo){
	location.href = "/clientSatisfaction/selectClientSatisfactionDetail.do?pkNo=" + pkNo + "&tabNo=" + tabNo;
}

/**
 * 디테일페이지 이동
 * @param _no
 * @returns
 */
function fncDetail(_no){
	$('#pkNo').val(_no);
	$("#detailForm").attr("action", "/clientSatisfaction/selectClientSatisfactionDetail.do");
	$('#detailForm').submit();
}

/**
 * 리스트 포맷
 * @param _object
 * @param i
 * @returns
 */
function fncGetItemHtml(_object,i){
	
	var obj_html = '';
	
	obj_html += '<li>';
	obj_html += '<a href="#" onclick="fncDetail('+_object.CSAT_ID+');">';
	obj_html += '<div class="info">';
	obj_html += '<div class="top">';
	obj_html += '<span class="subject">'+_object.CSAT_SUBJECT+'</span>'; // '+_object.TOTAL_COUNT
	obj_html += '</div>';
	obj_html += '<span class="bottom">';
	obj_html += '<span class="name">참여기업 : '+_object.TOTAL_COUNT+'</span>'; //CSAT_SURVEY_DATE 
	obj_html += '<span class="name">책임자 : '+_object.CSAT_SURVEY_NAME+ '/'+ _object.CSAT_SURVEY_POST+'</span>'; //CSAT_SURVEY_DATE
	obj_html += '<span class="com_sum" style="display:block;">조사일 : '+_object.CSAT_SURVEY_DATE+'</span>'; //CSAT_SURVEY_DATE
		
	/*obj_html += '</div>';
	obj_html += '<div class="rate_area">';
	obj_html += '<div id="Graph'+i+'"></div>';
	obj_html += '</div></div>';*/
	
	obj_html += '</span>';
	obj_html += '</a>';
	obj_html += '<div class="quicklink_right">';
	obj_html += '<a onclick="shortCuts(' + _object.CSAT_ID + ', 1); return false;">정보</a> ';
	obj_html += '<a onclick="shortCuts(' + _object.CSAT_ID + ', 2); return false;">결과</a> ';
	obj_html += '<a onclick="shortCuts(' + _object.CSAT_ID + ', 3); return false;">Follow-up</a>';
	obj_html += '</li>';
	
	return obj_html;
}

/**
 * 만족도 리스트 호출
 * @param selectValue
 * @param newSearch
 * @returns
 */
function fncShowMore(setTeamNameTf){
	var checkValue;
		
	var v_rowCount = 10;
	var v_pageStart = v_page * v_rowCount;
	
	var params = $.param({
		pageStart : v_pageStart,
		rowCount : v_rowCount,
		latelyUpdateTable : "CLIENT_SAT_LOG",
		satisfactionCategory : $('#selectSatisfactionCategory').val(),
		satisfactionTargetCategory : $("#selectSatisfactionTeamList").val(),
		searchKeyword : $('#textSearchKeyword').val()
	});
	
	$.ajax({
		url : "/clientSatisfaction/selectClientSatisfactionMasterListCount.do",
		async : false,
		datatype : 'json',
		method: 'POST',
		data : params,
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
		},
		success : function(data){
			
			if(setTeamNameTf){
				
				// 전체 선택 옵션 세팅
				setAllOption($('#textTeamNameList'));
				
				custom.setTeamNameList(data.searchNoArray, data.searchNameArray, $('#selectSatisfactionTeamList'));
			}
			
			//page count
			totalCnt = data.mListCount;
		},
		complete : function(){
		}
	});
	
	$.ajax({
		type : "POST",
		data : params,
		async: false,
		datatype : 'json',
		url: "/clientSatisfaction/selectClientSatisfactionMasterList.do",
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
		},
		success:function(data){
			
			var list = data.rows;
			var list_html = '';
			var avg;
			
			if(list.length > 0) {
				$("#blank_list").hide();
				$('#btn_more').show();
				
				for (var i = 0; i < list.length; i++){
					list_html += fncGetItemHtml(list[i],i);
				}
				
				v_page++;
				v_pageStart = v_page * v_rowCount;
				
				// 리스트 붙이기
				if(v_page == 0){
					$('#result_list2').html(list_html);
				}else {
					$('#result_list2').append(list_html);
				}
				
				// 더보기 버튼 세팅
				if (parseInt(v_pageStart) >= parseInt(totalCnt)){
					$('#btn_more').hide();
				}else {
					var cnt_html = '더보기 '+v_pageStart+' of ' + totalCnt;
					$('#span_more').html(cnt_html);
					$('#btn_more').show();
				}
				
				// 그래프 
				for (var i = 0; i < list.length; i++){
					var bindName = '#Graph'+i;
					avg = list[i].AVG_CSAT_VALUE;
					if(avg > 0){
						var chart2 = c3.generate({
								bindto: bindName,
								data: {
								columns: [
									['만족도', avg],
								],
								type: 'bar',
								//rows : columnData,
								labels: true
							},
							size: {
								height: 100,
								width:80,
							},
							axis: {
								x: {
									show: false,
									type: 'category',
									categories: ['만족도']
								},
								y: {
										show: false
									}
								}
						});
					}else{
						$(bindName).html("평가 미실시");
					}
				}
				
			}else {
				var blank_html ='';
				blank_html += '<div class="result_blank">';
				blank_html += '등록된 만족도가 없습니다.<br/>신규등록 해주세요';
				blank_html += '</div>';
				
				$('#blank_list').html(blank_html);
				$("#btn_more").hide();
				$("#blank_list").show();
			}
		},
		complete : function(){
		}
	});
}

/**
 * 조사현황
 * @param searchFlag
 * @param selectSortCategory
 * @returns
 */
function getMaster(){
	
	// 분기 네비게이션 추가할 경우 동적으로 값 할당
	var searchYear = '2020';
	var searchQuarter = '1';
	
	// Text 셋팅
    $('#csatMasterYear').html(searchYear);
    $('#csatMasterQuarter').html(searchQuarter);
	
	var params = $.param({
		datatype : 'html',
		jsp : '/clientSatisfaction/clientSatisfactionStatusAjax',
		latelyUpdateTable : "CLIENT_SAT_LOG",
		selectValue : $("#textTeamNameList").val(),
		selectSortCategory : $("#selectSortCategory").val(),
		satisfactionCategory : $('#selectSatisfactionCategory').val(),
		searchYear : searchYear,
		searchQuarter : searchQuarter
	});
		
	// 마스터 리스트
	$.ajax({
		url : "/clientSatisfaction/selectClientSatisfactionMasterListM.do",
		async : false,
		datatype : 'html',
		method: 'POST',
		data : params,
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
		},
		success : function(data){
			$('#row2').html(data);
		},
		complete : function(){
		}
	});
}

/**
 * 조회현황 팀 리스트
 * @returns
 */
function getMasterTeamList(){
	
	// 분기 네비게이션 추가할 경우 동적으로 값 할당
	var searchYear = '2020';
	var searchQuarter = '1';
		
	var params = $.param({
		datatype : 'json',
		satisfactionCategory : $('#selectSatisfactionCategory').val(),
		searchYear : searchYear,
		searchQuarter : searchQuarter
	});
	
	$.ajax({
		url : "/clientSatisfaction/selectClientSatisfactionMasterTeamList.do",
		async : false,
		datatype : 'json',
		method: 'POST',
		data : params,
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
		},
		success : function(data){
			
			var rows = data.selectTeamNameList;
			
			if(rows.length < 1 || auth.indexOf('ROLE_MEMBER') != -1){
				return;
			}
			
			// 전체 선택 옵션 세팅
			setAllOption($('#textTeamNameList'));
			
			// 팀 중복 제거위한 Array
			var teamArr = [];
			
			for(var i=0; i<rows.length; i++){
				
				if(teamArr.indexOf(rows[i].TARGET_NO) == -1){
					option = '<option value='+rows[i].TARGET_NO+'>'+rows[i].TARGET_NAME+'</option>';
					$('#textTeamNameList').append(option);
					
					teamArr.push(rows[i].TARGET_NO);
				}
			}			
		},
		complete : function(){
		}
	});
}

/**
 * 만족도 현황
 * @returns
 */
function getTotalStatus(){
	
	// 분기 네비게이션 추가할 경우 동적으로 값 할당
	var searchYear = 2020;
	var searchQuarter = 1;
	
	// Text 셋팅
    $('#csatTotalYear').html(searchYear);
    $('#csatTotalQuarter').html(searchQuarter);
	
	var params = $.param({
		datatype : 'html',
		jsp : '/clientSatisfaction/clientSatisfationTotalStatusAjax',
		searchYear : searchYear,
		searchQuarter : searchQuarter,
		satisfactionCategory : $('#selectSatisfactionCategory').val()
	});
	
	$.ajax({
		url : "/clientSatisfaction/selectClientSatisfactionTotalStatus.do",
		async : false,
		datatype : 'html',
		method: 'POST',
		data : params,
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
		},
		success : function(data){
			$('#row').html(data);
		},
		complete : function(){
		}
	});
}

/**
 * 초기 함수 호출
 * @returns
 */
function pageInit(){
	// 만족도 현황
	getTotalStatus();
	
	// 조사현황 팀 리스트
	getMasterTeamList();
	
	// 조사현황
	getMaster();
	
	// 만족 리스트 가져오기
	fncShowMore(true);
}

/**
 * 리스트 리셋
 * @returns
 */
function fncRest() {
	curCnt = 0;
	totalCnt = 0;
	v_page = 0;
	$('#result_list2').html('');
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
	
	// 리스트 초기화하고, 팀리스트도 다시 불러와야 함
	fncRest();
	fncShowMore(true);
}

$(document).ready(function(){
	
	// 컨택방법 초기셋팅
	$('#selectSatisfactionCategory').val('고객만족');
	
	pageInit();
	
	// 컨택 방법 변경
	$("#selectSatisfactionCategory").change(function(){
		// 조사현황 sort 카테고리 초기화
		$("#selectSortCategory option:eq(0)").prop("selected", true);
		
		// 화면 초기화
		fncRest();
		pageInit();
	});
	
	// 리스트 카테고리 변경
	$("#selectSatisfactionTeamList").change(function(){		
		fncRest();
		fncShowMore();
	});
});