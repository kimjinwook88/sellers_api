
/**
 * 카테고리 선택
 * @param _group
 * @returns
 */
function fncSelectGroup(_group){
	
	$('#select_text').html(_group);
	$('.dropdown-toggle').next().toggle();
	$('.caret').toggleClass('caret_up');
	
	if (_group == '전략 선택') _group = '';
	detailCategory = _group;
	curCnt = 0;
	$('#result_list').html('');
		
	fncShowMore();
}

$(document).ready(function() {
	
	// 검색어 셋팅
	/*if(searchKeyword){
		$("#search_keyword").val(searchKeyword);
	}*/
	
	fncShowMore();
	
	$("#btn_search_keyword").click(function(){
		curCnt = 0;		
		fncShowMore();
	});
	
	$('#search_keyword').on('keypress', function(e) {
		if (e.which == 13) {
			$("#btn_search_keyword").click();
		}
	});
});