var totalCnt = 0;
var curCnt = 0;
var rowCount = 10;
var searchDivision = '';

var v_page = 0;

var params;

/**
 * 리스트 출력 폼
 * @param _object
 * @returns
 */
function fncGetItemHtml(_object){
	var money = _object.OPPORTUNITY_AMOUNT;
	var obj_html = '';

	obj_html += '<li name="se_'+_object.TEAM_NAME+'" class="opp_li_hide"><a href="javascript:void(0); return false;" onclick="fncDetail('+_object.OPPORTUNITY_HIDDEN_ID+');return false;">';// <li class="sel_off team_' + _object.TEAM_NAME + '">
	obj_html += '<span class="top">';
	obj_html += '<span class="cata_custom r3">'+_object.COMPANY_NAME+'</span> ';
	obj_html += '<span class="subject">'+_object.SUBJECT+'</span>';
	obj_html += '</span>';
	obj_html += '<span class="bottom">';
	obj_html += '<span class="name">'+_object.CUSTOMER_NAME+' / '+_object.SALESMAN_NAME+' '+_object.SALESMAN_POSITION +'</span>';
	obj_html += '<span class="date">예상규모 : '+ money.toLocaleString() +'원</span>';
	
	if(isEmpty(_object.SALES_CHANGE_DATE)){
		obj_html += '<span class="date">전환시점 : - </span>';
	}else{
		obj_html += '<span class="date">전환시점 : '+_object.SALES_CHANGE_DATE+'</span>';
	}
	
	obj_html += '</span></a>';
	//STATUS
	if(_object.STATUS == '#f20056'){ // 레드
		obj_html += '<div class="status_current statusColor_red"></div>';
	}else if(_object.STATUS == '#ffc000'){ // 노랑
		obj_html += '<div class="status_current statusColor_yellow"></div>';
	}else if(_object.STATUS == '#1ab394'){ // 그린
		obj_html += '<div class="status_current statusColor_green"></div>';
	}else{
		obj_html += '<div class="status_current statusColor_gray"></div>';
	}
	
	obj_html += '<div class="quicklink_right">';
	obj_html += '<a onclick="shortCuts(' + _object.OPPORTUNITY_HIDDEN_ID + ', 1); return false;" >정보</a> ';
	obj_html += '<a onclick="shortCuts(' + _object.OPPORTUNITY_HIDDEN_ID + ', 2); return false;" >Action</a>';
	obj_html += '<a onclick="shortCuts(' + _object.OPPORTUNITY_HIDDEN_ID	+ ', 3); return false;" style="margin-left:4px;">Coaching Talk</a>';
	obj_html += '</div>';
	obj_html += '</li>';
	
	return obj_html;
}

/**
 * 팀(본부) 리스트 세팅 (검색조건)
 * @param data
 * @returns
 */
function setTeamNameList(data){
	
	if(auth.indexOf('ROLE_MEMBER') != -1){		
		return;
	}
	
	var selectEl = $('#textTeamNameList');
	var option = '';
	
	if(!data){
		selectEl.html('');
		
		var allOptionText = '';
		
		if(auth.indexOf('ROLE_CEO') != -1){			
			allOptionText = '회사전체';
		}else if(auth.indexOf('ROLE_DIVISION') != -1){			
			allOptionText = '본부전체';
		}else if(auth.indexOf('ROLE_TEAM') != -1){			
			allOptionText = '팀전체';
		}
		
		option = '<option value="">'+allOptionText+'</option>';
		selectEl.append(option);
		
		return;
	}
	
	var noArr = (data.searchNoArray).split(',');
	var nameArr = (data.searchNameArray).split(',');
	
	for(var key in noArr){
		option = '<option value="'+noArr[key]+'">'+nameArr[key]+'</option>';
		selectEl.append(option);
	}
}


/**
 * 리스트 불러오기
 * @param newSearch
 * @param classify
 * @returns
 */
function getList(newSearch, textSearchKeyword, setTeamNameTf){

	var ns;
	if(newSearch == 'Y'){
		totalCnt = 0;
		v_page = 0;
		curCnt = 0;
		ns = 'Y';
	}else{
		ns = 'N';
	}
	
	var classify = $('#textSituationList').val();
	
	var v_rowCount = 10;
	var v_pageStart = v_page * v_rowCount;
	
	params = $.param({
		pageStart : v_pageStart,
		rowCount : v_rowCount,
		datatype : 'json',
		numberPagingUseYn : "Y",
		latelyUpdateTable : "OPPORTUNITY_HIDDEN_LOG",
		searchKeyword : textSearchKeyword,
		// 조건 검색
		textTeamNameList : $('#textTeamNameList').val(),
		// 진행중
		textSituationList : classify
	});

	//카운트, 최근업데이트, 결과내 검색
	$.ajax({
		url : "/clientSalesActive/selectHiddenOpportunityCount.do",
		async : false,
		datatype : 'json',
		method: 'POST',
		data : params,
		success : function(data){
			
			if(setTeamNameTf){
				setTeamNameList(data);
			}	
			
			//page count
			totalCnt = data.listCount;
			$('#total_cnt').html(data.listCount);
			
		},
	});	
	
	$.ajax({
		type : "POST",
		data : params,
		async: false,
		datatype : 'json',
		url: "/clientSalesActive/selectHiddenOpportunity.do",
		success:function(data){
			var list = data.rows;
			var list_html = '';
			
			if(list.length > 0){
				for (var i = 0; i < list.length; i++){		
					list_html += fncGetItemHtml(list[i]);
				}
				
				v_page++;
				v_pageStart = v_page * v_rowCount;
				
				$('#blank_html').hide();
				//$('#list_type_coop').html(list_html);
				//$('#list_type_coop').html("");
				
				if(ns == 'Y'){
					$('#list_type_coop').html(list_html);
				}else{
					$('#list_type_coop').append(list_html);
				}
				
				if (parseInt(v_pageStart) >= parseInt(totalCnt)){
					$('#btn_more').hide();
				}else {
					var cnt_html = '더보기 '+v_pageStart+' of ' + totalCnt;
					$('#span_more').html(cnt_html);
					$('#btn_more').show();
				}
				
			}else{
				$('#list_type_coop').html('');
				$('#btn_more').hide();
				
				var blank_html = '';
				blank_html += '<div class="result_blank">';
				
				if(classify == 'all'){
					blank_html += '등록된 고객컨택이 없습니다.</br>신규등록 해주세요.';
				}else if(classify == 'change'){
					blank_html += '전환된 고객컨택이 없습니다.';
				}else if(classify == 'ing'){
					blank_html += '진행중인 고객컨택이 없습니다.';
				}else if(classify == 'delay'){
					blank_html += '지연된 고객컨택이 없습니다.';
				}else{
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
	
	getList('Y', textSearchKeyword);
}

/**
 * 디테일
 * @param _no
 * @returns
 */
function fncDetail(_no){
	//location.href = 'modalOpportunity.do?oppId='+_no;
    $('#pkNo').val(_no);
    $("#detailForm").attr("action", "/clientSalesActive/selectHiddenOpportunityDetail.do");
    $('#detailForm').submit();

}

function fncSelectGroup(_group){
	$('#select_text').html(_group);
	$('.dropdown-toggle').next().toggle();
	$('.caret').toggleClass('caret_up');
	
	/*
	if (_group == '부서선택') _group = '';
	searchDivision = _group;
	curCnt = 0;
	$('#result_list').html('');
	
	fncGetTotalCount();
	fncShowMore();
	*/
}

function fncSelectBox(_group){
	$('#select_text').html(_group);
	$('.dropdown-toggle').next().toggle();
	$('.caret').toggleClass('caret_up');
	
	if(_group == '부서선택'){
		return;
	}else{
		$('#btn_more').hide();
		$('.opp_li_hide').hide();
		$("li[name=se_"+_group+"]").show();
		/*
		$('.sel_off').hide();
		$('.team_'+_group).show();
		
		
		if($('.team_'+_group)){
			$('#btn_more').show();
			fncGetTotalCount();
			fncShowMore();
		}
		*/
	}	
}

function shortCuts(pkNo, tabNo){
	location.href = "/clientSalesActive/selectHiddenOpportunityDetail.do?pkNo=" + pkNo + "&tabNo=" + tabNo;
}

$(document).ready(function() {
	
	// 검색조건 세팅
	setTeamNameList();
	
	getList(null, null, true);
	
	// 잠재영업기회 등록 페이지 이동
	$("#inserthiddenOpportunity").on("click", function(e) {
		$('#mode').val("ins");
		$("#insertForm").attr("action", "/clientSalesActive/hiddenOpportunityInsertForm.do");
		$('#insertForm').submit();
		e.preventDefault();
	});
});

