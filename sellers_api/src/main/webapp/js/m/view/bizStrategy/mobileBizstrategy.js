/**
 * Back 버튼 클릭
 * @returns
 */
function fncList(){
	var param = '';
	
	/*if(reqParams){
		param = '?strategy='+reqParams;
	}*/
	
    if(mapSearchCategory){
    	param = '?searchCategory='+mapSearchCategory;
    }
    
    /*if(searchKeyword){
    	if(param){
    		param += '&';
    	}else{
    		parma += '?';
    	}
    	param += 'searchKeyword='+searchKeyword;
    }*/
	
	if(mapSearchCategory == '고객전략'){
		window.location.href= '/bizStrategy/viewBizStrategyClient.do'+param;
	}else{
		window.location.href= '/bizStrategy/viewBizStrategyCompany.do'+param;
	}
}


function fncSelectTab(_no){
	// 탭 이동
	$('#tab_1').removeClass('active');
	$('#tab_2').removeClass('active');
	$('#tab_3').removeClass('active');
	$('#tab_'+_no).addClass('active');
	
	// 탭에 해당하는 컨테이너 보여주기
	$('.cont1').addClass('off');
	$('.cont2').addClass('off');
	$('.cont3').addClass('off');
	$('.cont'+_no).removeClass('off');
}


/**
 * 마일스톤 폼
 * @param _object
 * @returns
 */
function fncGetItemHtml(_object){
	var obj_html = '';
	
	if (_object.KEY_MILESTONE != ''){

		obj_html += '<li><div class="top"><span class="title">'+_object.KEY_MILESTONE+'</span>';
		switch (_object.STATUS) {
		case "G":
			obj_html +=  '<span class="status_lec statusColor_green"></span>';
			break;
		case "Y":
			obj_html +=  '<span class="status_lec statusColor_yellow"></span>';
			break;
		case "R":
			obj_html +=  '<span class="status_lec statusColor_red"></span>';
			break;
		default:
			obj_html +=  '<span class="status_lec statusColor_gray"></span>';
			break;
		}
		
		obj_html += '</div><div class="cont">'; 
		obj_html += '<span class="fc_gray_light">책임담당자 : </span>';
		
		var v_act_name = (typeof _object.ACT_NAME == "undefined")?"":_object.ACT_NAME;
		obj_html += '<span class="fc_black">'+v_act_name+'</span>';
		
		if(typeof _object.ACT_PHONE != "undefined" && _object.ACT_PHONE != '') {
			obj_html += '&nbsp;<a href="tel:'+_object.ACT_PHONE+'" class="btn_phone_go"><img src="/images/m/icon_phone.png" alt="전화걸기"/></a>';
		}
		
		obj_html += '<br/>';
		obj_html += '<span class="fc_gray_light">목표일 : </span> <span class="fc_black">'+_object.ACT_DUE_DATE+'</span>';
		
		var v_act_close_date = (typeof _object.ACT_CLOSE_DATE == "undefined")?"":_object.ACT_CLOSE_DATE;
		obj_html += '<span class="fc_gray_light">/ 완료일 : </span> <span class="fc_black">'+v_act_close_date+'</span>';	
		obj_html += '</div></li>';
	}
	
	return obj_html;
}

/**
 * 키마일스톤 조회
 * @returns
 */
function getMileStone(){
	$.ajax({
		type : "POST",
		data : {
			"biz_id" : bizId
		},
		async: false,
		url: "/bizStrategy/gridMileStonesBizStrategyList.do",
		success:function(data){
			var list = data.rows;
			var list_html = '';
			for (var i = 0; i < list.length; i++){
				list_html += fncGetItemHtml(list[i]);
			} 
			
			$('#result_list').html(list_html);
			
		}
	});
}

$(document).ready(function() {
	getMileStone();
});