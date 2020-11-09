var totalCnt = 0;
var rowCount = 10;
var v_page = 0;

var $jq = jQuery.noConflict();

var searchDetailClick = {
		
	/**
	 * 리스트 폼
	 */
	fncGetItemHtml : function(_object, map){
		var obj_html = '';
		obj_html += '<ul class="company_member_list mg_b20"><li>'; 
		obj_html += '<div class="info">';
		obj_html += '<a href="#" onclick="searchDetailClick.goDetail('+_object.PARTNER_INDIVIDUAL_ID+','+_object.PARTNER_ID+');return false;">';
		obj_html += '<div class="subject ">'+_object.PARTNER_PERSONAL_NAME+'<span class="fs12">'+_object.POSITION+'</span></div>';
		if(_object.PARTNER_PERSONAL_NAME == null || _object.CEO_NAME ==''){
			_object.CEO_NAME = '';
		}
		obj_html += '<span class="info_inner">'+_object.COMPANY_NAME+' / '+_object.TEAM+'</span>';
		obj_html += '<div class="custom_info">휴대전화 : '+_object.CELL_PHONE.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');+'</div>';
		
		obj_html += '<div class="func_box_man">';
		if(_object.CELL_PHONE != null && _object.CELL_PHONE != ''){
			obj_html += '<a href="tel:'+_object.CELL_PHONE+'" class="btn_phone_go mg_r5"><img src="../../../images/m/icon_phone.png" alt="전화걸기"/></a>';
		}
		
		if(_object.EMAIL != null && _object.EMAIL != ''){
			obj_html += '<a href="mailto:'
				+ _object.EMAIL
				+ '" class="btn_email_go"><img src="/images/m/icon_email.png" alt="메일보내기"/></a>';
		}
				
		obj_html += '</div>';
		
		obj_html += '</a>';		
		obj_html += '</div>';
		obj_html += '</li>';
		obj_html += '</ul>';
		
		return obj_html;
	},
		
	/**
	 * 리스트 조회
	 */
	getList : function(){
		
		var v_rowCount = 10;
		var v_pageStart = (v_page * v_rowCount) + v_page;
		var v_pageEnd = v_pageStart + v_rowCount;
		
		var params = $.param({
			pageStart : v_pageStart,
			pageEnd : v_pageEnd,
			serchInfo : $("#searchDetail").val(),
			creatorId : $("#hiddenModalCreatorId").val(),
			serch : 2,
			datatype : 'json'
		});
		
		$.ajax({
			url : '/partnerManagement/selectPartnerIndividualInfoCount.do',
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
			url : "/partnerManagement/selectPartnerIndividualInfoList.do",
			datatype : 'json',
			method: 'POST',
			data : params,
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
				//$jq.ajaxLoading();
			},
			success : function(data){		
				var list = data.rows;
				var map = data.map;
				var list_html = '';
				
				if (list.length > 0){ 
					for (var i = 0; i < list.length; i++){
						list_html += searchDetailClick.fncGetItemHtml(list[i], map);
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
	
	goSearch : function(partnerId, companyId, searchDetail){
		//$jq("#formDetail #customer_id").val(partnerId);
		$jq("#formDetail #company_id").val(companyId);
		$jq("#formDetail #search_detail").val(searchDetail);
		$jq("#formDetail #serchInfo").val(searchDetail);
		$jq("#formDetail").attr({action:"/partnerManagement/viewPartnerIndividualInfoGate.do", method:"get"}).submit();
	},
	
	//파트너사 개인정보 게이트 페이지에서 파트너를 검색하면 파트너 개인 상세 페이지로 이동한다
	goDetail : function(partnerId, companyId, searchDetail){
		//$jq("#formDetail #customer_id").val(partnerId);
		$jq("#formDetail #company_id").val(companyId);
		$jq("#formDetail #search_detail").val(searchDetail);
		$jq("#formDetail #serchInfo").val(searchDetail);
		
		$jq("#formDetail #companyId").val(companyId);
		$jq("#formDetail #customerId").val(partnerId);
		$jq("#formDetail #hiddenModalPK").val(partnerId);
		$jq("#formDetail").attr({action:"/partnerManagement/viewPartnerIndividualInfoDetail.do", method:"get"}).submit();
	}
}

$(document).ready(function() {
	
	$('#btn_search_keyword').on('click', function(e){		
		$('#result_list').html('');
		v_page = 0;
		searchDetailClick.getList();
	});

	$('#searchDetail').on('keypress', function(e) {
		if (e.which == 13) {
			$("#btn_search_keyword").click();
		}
	})
});