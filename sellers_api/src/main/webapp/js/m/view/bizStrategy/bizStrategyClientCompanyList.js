$(document).ready(function() {
	
	// 검색어 셋팅
	/*if(searchKeyword){
		$("#search_keyword").val(searchKeyword);
	}*/
	
	// 리스트 조회
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