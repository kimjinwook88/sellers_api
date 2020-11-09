var totalCnt = 0;
var rowCount = 10;
var v_page = 0;

var $jq = jQuery.noConflict();
 var searchDetailClick = {
		checkText : function() {
			//if($("#textListSearchDetail").val() != '' && $("#textListSearchDetail").val() != null) {
			if(!isEmpty($jq("#textListSearchDetail").val()))	{
				//$('#serchDetail').val($('#textListSearchDetail').val());
				searchDetailClick.getList();
			}else {
				alert("검색어를 입력해 주세요.");
			}
		},
		
		//TODO : ?? datatype이 html 이엿는ㄷㅔ 컨트롤러에서 리턴은 json? 일단 datatype json으로 수정해놓음
		getList : function(){
			
			var v_rowCount = 10;
			var v_pageStart = (v_page * v_rowCount) + v_page;
			var v_pageEnd = v_pageStart + v_rowCount;
		
			var params = $.param({
				serchInfo : $jq("#textListSearchDetail").val(),
				creatorId : $jq("#hiddenModalCreatorId").val(),
				pageStart : v_pageStart,
				pageEnd : v_pageEnd,
				serch : 2,
				datatype : 'json',
			});
			
			$.ajax({
				url : '/partnerManagement/selectPartnerCompanyCount.do',
				datatype : 'json',
				mehtod : 'post',
				data : params,
				beforeSend : function(xhr){
					xhr.setRequestHeader('ajax', true);
				},
				success : function(data){
					totalCnt = data.listCount;
					$('#result_cnt').html(totalCnt);
				}
			});
			
			$.ajax({
				url : "/partnerManagement/selectPartnerCompanyList.do",
				datatype : 'json',
				method: 'POST',
				data : params,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					//$jq.ajaxLoading();
				},
				success : function(data){	
					var list = data.rows;
					var list_html = '';
					
					if (list.length > 0){ 
						for (var i = 0; i < list.length; i++){
							list_html += fncGetItemHtml(list[i]);
						}
						
						$('#result_list').append(list_html);
						
						v_page++;
						v_pageStart = v_page * v_rowCount;
						v_pageEnd = v_pageStart + 10;
						
						if(v_pageStart >= totalCnt){
							$('#btn_more').hide();
						}else{
							var cnt_html = '더보기 ' + v_pageStart + ' of '+ totalCnt;
							$('#span_more').html(cnt_html);
							$('#btn_more').show();
						}
					}
				},
				complete : function(){
					//$jq.ajaxLoadingHide();
				}
			});
		},
		
		goSearch : function(companyId){
			/* $("#formDetail #customer_id").val(clientNo); */
			$jq("#formDetail #searchDetail").val($jq("#textListSearchDetail").val());
			$jq("#formDetail #company_id").val(companyId);
			$jq("#formDetail #serchInfo").val($jq("#textListSearchDetail").val());
			//$("#formDetail").attr({action:"/partnerManagement/viewPartnerCompanyInfoDetail.do", method:"post"}).submit();
			$jq("#formDetail").attr({action:"/partnerManagement/viewPartnerCompanyInfoGate.do", method:"post"}).submit();
		},
		
		goDetail : function(companyId){
			$jq("#formDetail #searchDetail").val($jq("#textListSearchDetail").val());
			$jq("#formDetail #company_id").val(companyId);
			$jq("#formDetail #serchInfo").val($jq("#textListSearchDetail").val());
			$jq("#formDetail").attr({action:"/partnerManagement/viewPartnerCompanyInfoDetail.do", method:"get"}).submit();
		}
}
 
 function fncGetItemHtml(_object){
	var obj_html = '';
	obj_html += '<ul class="company_member_list mg_b20"><li>'; 
	//obj_html += '<a href="/partnerManagement/viewPartnerCompanyInfoDetail.do?companyId='+_object.PARTNER_ID+'">';
	obj_html += '<div class="info">';
	obj_html += '<a href="#" onclick="searchDetailClick.goDetail('+_object.PARTNER_ID+');return false;">';
	obj_html += '<div class="subject ">'+_object.COMPANY_NAME+'</div>';
	if(_object.CEO_NAME == null || _object.CEO_NAME ==''){
		_object.CEO_NAME = '';
	}
	obj_html += '<div class="name">대표 : '+_object.CEO_NAME+'</div>';
	obj_html += '<div class="custom_info">대표전화 : '+_object.COMPANY_TELNO+'</div>';
	
	obj_html += '<div class="func_box_man">';
	if(_object.COMPANY_TELNO != null && _object.COMPANY_TELNO != ''){
		obj_html += '<a href="tel:'+_object.COMPANY_TELNO+'" class="btn_phone_go"><img src="../../../images/m/icon_phone.png" alt="전화걸기"/></a>';
	}
	obj_html += '</a>';
	obj_html += '</div>';
	obj_html += '</div>';
	obj_html += '</li>';
	obj_html += '</ul>';
	
	return obj_html;
}
 
 $(document).ready(function() {
		
	$('#btn_search_keyword').on('click', function(e){		
		$('#serchDetail').val($('#textListSearchDetail').val());
		$('#result_list').html('');
		v_page = 0;
		searchDetailClick.getList();
	});

	$('#textListSearchDetail').on('keypress', function(e) {
		if (e.which == 13) {
			$("#btn_search_keyword").click();
		}
	})
});