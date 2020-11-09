<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
				
<script type="text/javascript">
$(document).ready(function() { 
	//매입처 일괄적용 자동완성
	commonSearch.singleCompanyProduct($("#textPsAllCompanySeach"), $('#liAllPsCompanySeach'), $('#hiddenAllPsCompany')); //고객사
	
	$.get("/ajaxHtml/mobileOpportunitySalesProduct.html", function(data){
		oppProduct.salesHtml = data;
	});
	
	$.get("/ajaxHtml/mobileOpportunityPsProduct.html", function(data){
		oppProduct.psHtml = data;
	});
	
	oppProductEvent.on();
});

var oppProductEvent = {
		on : function(){
			// 매출 대표여부 체크박스
			$("div#divSales").on("change", "input[name='sales_product_mainChk']", oppProductEvent.changeSpMainCk);
			
			// 매출품목 자동완성
			$("div#divSales").on("focus", "input[name='textSalesProductSeach']", oppProductEvent.focusSpSearch); 
			
			// 매입품목 자동완성
			$("div#divPs").on("focus", "input[name='textPsProductSeach']", oppProductEvent.focusPsSearch);
			
			// 매입처 자동완성
			$("div#divPs").on("focus", "input[name='textPsCompanySeach']", oppProductEvent.focusPsCompanySearch);
			
			$("div#divSales, div#divPs").on("keydown", "input", oppProductEvent.keydownEnterReturn);
		},
		
		off : function(){
			// 매출 대표여부 체크박스
			$("div#divSales").off("change", "input[name='sales_product_mainChk']", oppProductEvent.changeSpMainCk);
			
			// 매출품목 자동완성
			$("div#divSales").off("focus", "input[name='textSalesProductSeach']", oppProductEvent.focusSpSearch); 
			
			// 매입품목 자동완성
			$("div#divPs").off("focus", "input[name='textPsProductSeach']", oppProductEvent.focusPsSearch);
			
			// 매입처 자동완성
			$("div#divPs").off("focus", "input[name='textPsCompanySeach']", oppProductEvent.focusPsCompanySearch);
			
			$("div#divSales, div#divPs").off("keydown", "input", oppProductEvent.keydownEnterReturn);
		},
		
		changeSpMainCk : function(e){
			var idx = $("div#divSales input[name='sales_product_mainChk']").index(this);
			$('input[name="sales_product_mainChk"]').prop("checked",false);
			$('input[name="sales_product_mainChk"]').val(0);
			
			//품목을 검색하지 않고 대표여부를 체크하면
			if(isEmpty($('div#divSales input[name="hiddenSalesProductCode"]').eq(idx).val())){
				$("div#divSales input[name='sales_product_mainChk']").first().prop("checked",true);
				$('div#divSales input[name="sales_product_mainChk"]').first().val(1);
			}else{
				$(this).prop("checked",true);
				$(this).val(1);					
			}
		},
		
		focusSpSearch : function(e){
			var idx = $("div#divSales input[name='textSalesProductSeach']").index(this);
			if($(this).attr("auto-bind") == "0"){
				commonSearch.singleProduct($(this), idx);
				$(this).attr("auto-bind","1");
			}
		},
		
		focusPsSearch : function(e){
			var idx = $("div#divPs input[name='textPsProductSeach']").index(this);
			if($(this).attr("auto-bind") == "0"){
				commonSearch.singleProduct($(this), idx);
				$(this).attr("auto-bind","1");
			}
		},
		
		focusPsCompanySearch : function(e){
			var idx = $("div#divPs input[name='textPsCompanySeach']").index(this);
			if($(this).attr("auto-bind") == "0"){
				commonSearch.singleCompanyProduct($(this), $(this).parent("li[name='liPsCompanySeach']"), $(this).next("input[name='hiddenPsCompany']"));
				$(this).attr("auto-bind","1");
			}
		},
		
		keydownEnterReturn : function(e){
					var inputList = [
						'textSalesProductSeach',
						'textPsProductSeach',
						'sales_product_count',
						'sales_product_price',
						'sales_product_total',
						'ps_product_count',
						'ps_product_price',
						'ps_product_total',
						'textPsCompanySeach',
						'textModalPsDate'
					];
			if(inputList.indexOf(e.target.name) != -1){
				if(e.keyCode == 13) return false;
			}
		}
		
		
}

var oppProduct = {
		salesHtml : null,
		
		psHtml : null,
		
		salesList : null, //매출
		
		psList : null, //매입
		
		init : function(rFlag){
			
			//초기화
			if(!rFlag){
			}else{
				oppProduct.reset();
			}
		},
		
		reset : function(){
			$("#spanSalesTotal").html(0);
			$("#spanPsTotal").html(0);
			$("div#divSales").find('tr').not('tr.total').remove();
			$("div#divPs").find('tr').not('tr.total').remove();
			$("label#salesTable-error").remove();
			$("label#psTable-error").remove();
			$("#textPsAllCompanySeach").show();
			oppProduct.salesAdd();
			oppProduct.psAdd();
		},
		
		zero : function(obj) {
			if(obj.value=="0") obj.value="";
		},
		
		blur : function(obj){
			var string = obj.value;
			var objName = $(obj).attr("name");
			
			if(isEmpty(string)) obj.value=0;
			
			//끝자리가 .이면 제거
			if(string.charAt(string.length-1) == "."){
				obj.value = string.slice(0,-1);
			}
		},
		
		
		//insert위해서 list에 담기
		setList : function(temp_flag){
			oppProduct.salesList = new Array();
			oppProduct.psList = new Array();
			var salesSeq = 1;
			var psSeq = 1;
			var validFlag = true;
			var tab_no = $("div#divSales").parents('div.modaltabmenu').attr("tab-seq")-1;
			
			$("label#salesTable-error").remove();
			$("label#psTable-error").remove();
			
			//매출품목
			$('div#divSales input[name="hiddenSalesProductCode"]').each(function(idx, val){
				if($(this).val()){
					var salesData = new Object() ;
					
					salesData.product_order = salesSeq++;
					salesData.product_cd = $("input[name='hiddenSalesProductCode']").eq(idx).val();
					
					if(uncomma($("input[name='sales_product_price']").eq(idx).val()) != 0){
						salesData.product_price = uncomma($("input[name='sales_product_price']").eq(idx).val());
					}else{
						if(!temp_flag){
							$(this).after('<label id="salesTable-error" class="error-custom" for="salesTable">단가를 입력해 주세요.</label>'	);
							fncSelectTab('5');
						}

						validFlag = false;
						return false;
					}
					
					if($("input[name='sales_product_count']").eq(idx).val() != 0){
						salesData.product_count = $("input[name='sales_product_count']").eq(idx).val();
					}else{
						if(!temp_flag){
							$(this).after('<label id="salesTable-error" class="error-custom" for="salesTable">수량을 입력해 주세요.</label>'	);
							fncSelectTab('5');
						}
						validFlag = false;
						return false;
					}
					
					salesData.product_yn = $('input[name="sales_product_mainChk"]').eq(idx).val(); 
					salesData.works_cd = $("input[name='hiddenSalesWorksCode']").eq(idx).val();
					oppProduct.salesList.push(salesData);
				}	
			});
			
			//매입품목
			$('div#divPs input[name="hiddenPsProductCode"]').each(function(idx, val){
				if($(this).val()){
					var seq = 1;
					var psData = new Object() ;
					
					psData.product_order = psSeq++;
					psData.product_cd = $("input[name='hiddenPsProductCode']").eq(idx).val();
					
					if(uncomma($("input[name='ps_product_price']").eq(idx).val()) != 0){
						psData.product_price = uncomma($("input[name='ps_product_price']").eq(idx).val()); 
					}else{
						if(!temp_flag){
							$(this).after('<label id="psTable-error" class="error-custom" for="psTable">단가를 입력해 주세요.</label>'	);
							fncSelectTab('5');
						}
						validFlag = false;
						return false;
					}
					
					if($("input[name='ps_product_count']").eq(idx).val() != 0){
						psData.product_count = $("input[name='ps_product_count']").eq(idx).val();
					}else{
						if(!temp_flag){
							$(this).after('<label id="psTable-error" class="error-custom" for="psTable">수량을 입력해 주세요.</label>'	);
							fncSelectTab('5');
						}
						validFlag = false;
						return false;
					}
					
					/* if(!isEmpty($("input[name='hiddenPsCompany']").eq(idx).val())){
						psData.purchase_enter_cd = $("input[name='hiddenPsCompany']").eq(idx).val();
					}else{
						$("#psTable").after('<label id="psTable-error" class="error-custom" for="psTable">매입처를 입력해 주세요.</label>'	);
						$("ul.tabmenu-type li a").eq(1).trigger('click.modalTab');
						validFlag = false;
						return false;
					}
					
					if(!isEmpty($("input[name='textModalPsDate']").eq(idx).val())){
						psData.purchase_date = $("input[name='textModalPsDate']").eq(idx).val();
					}else{
						$("#psTable").after('<label id="psTable-error" class="error-custom" for="psTable">매입예정일을 입력해 주세요.</label>'	);
						$("ul.tabmenu-type li a").eq(1).trigger('click.modalTab');
						validFlag = false;
						return false;
					} */
					
					psData.works_cd = $("input[name='hiddenPsWorksCode']").eq(idx).val();
					psData.purchase_enter_cd = $("input[name='hiddenPsCompany']").eq(idx).val();
					psData.purchase_date = $("input[name='textModalPsDate']").eq(idx).val();
					
					oppProduct.psList.push(psData);
				}	
			});
			
			return validFlag;
		},
		
		//수량 입력시
		salesCount : function(obj) {
			var count, price, total = 0;
			var num, itg, dcm = 0;
			
			count = $(obj).val();
			price = uncomma($(obj).parent().next().children().val());
			total = uncomma($(obj).parent().next().next().children().val());
			
			if(price != 0 && !isEmpty(price)){		//단가가 있으면
				num = ((count*price).toFixed(0)).toString();
				
				$(obj).parent().next().next().children().val(add_comma(parseInt(num).toString()));
			}else if(total != 0 && !isEmpty(total)){		//금액이 있으면
				num = ((total/count).toFixed(4)).toString();
				itg = num.split(".")["0"];
				dcm = num.split(".")["1"];
				(!!dcm && dcm != null && dcm !=0) ? dcm = '.' + dcm : dcm = "";
				
				$(obj).parent().next().children().val(add_comma(itg) + dcm);
			}
			
			//oppProduct.salesSum();
		},
		
		//단가 입력시 무조건 수량 곱하기
		salesPrice : function(obj) {
			var count, price, total = 0;
			var num = 0;
			
			count = $(obj).parent().prev().children("input").val();
			price = uncomma($(obj).val());
			total = uncomma($(obj).parent().next().children("input").val());
			
			num = ((count*price).toFixed(0)).toString();
			$(obj).parent().next().children("input").val(add_comma(parseInt(num).toString()));
			
			//oppProduct.salesSum();
		},
		
		//금액 입력시 무조건 수량 나누기
		salesTotal : function(obj) {
			var count, price, total = 0;
			var num, itg, dcm = 0;
			
			count = $(obj).parent().prev().prev().children("input").val();
			price = uncomma($(obj).parent().prev().children("input").val());
			total = uncomma($(obj).val());
			
			num = ((total/count).toFixed(4)).toString();
			itg = num.split(".")["0"];
			dcm = num.split(".")["1"];
			(!!dcm && dcm != null && dcm !=0) ? dcm = '.' + dcm : dcm = "";
			
			$(obj).parent().prev().children("input").val(add_comma(itg) + dcm);
			
			//oppProduct.salesSum();
		},
		
		//매출품목 Sum
		salesSum : function(obj){
			var allTotal = 0;
			
			$("input[name='sales_product_total']").each(function(idx, val){
				var salesSum = parseInt(uncomma($(this).val()));
				if(salesSum > 0 || salesSum < 0){
					allTotal += salesSum;	
				}
				$('span[id="spanSalesTotal"]').html(add_comma(allTotal.toString()));
			});
			
			if($("input[name='sales_product_total']").length == 0)$('span[id="spanSalesTotal"]').html(0);
		},
		
		//매출품목 더하기
		salesAdd : function(map){
			$('div#divSales').append(oppProduct.salesHtml);
			if($("div#divSales input[name='sales_product_mainChk']:checked").length == 0){
				$("div#divSales input[name='sales_product_mainChk']").first().prop("checked",true);
				$('div#divSales input[name="sales_product_mainChk"]').first().val(1);
			}
		},
		
		//매출품목 셋팅..
		setSalesAdd : function(callback, map){
			$('div#divSales').append(oppProduct.salesHtml);
			if($("div#divSales input[name='sales_product_mainChk']:checked").length == 0){
				$("div#divSales input[name='sales_product_mainChk']").first().prop("checked",true);
				$('div#divSales input[name="sales_product_mainChk"]').first().val(1);
			}
			callback(map);
		},
		
		salesSetData : function(map){
			var idx = $("div#divSales input[name='textSalesProductSeach']").index($("div#divSales input[name='textSalesProductSeach']").last());
			var num, itg, dcm, count = 0;//단가 변수

			if(map){
     			//품목
				$("div#divSales input[name='textSalesProductSeach']").eq(idx).hide();
				$("div#divSales input[name='hiddenSalesProductCode']").eq(idx).val(map.PRODUCT_CD);
				$("div#divSales input[name='hiddenSalesWorksCode']").eq(idx).val(map.WORKS_CD);
             	$('div#divSales li[name="liSalesProductSeach"]').eq(idx).before(
             			'<li class="value">' +
						'<span class="txt" id="'+map.PRODUCT_CD+'">'+map.PRODUCT_CD+'</span>' +
						'<a href="#" class="remove" onclick="commonSearch.removeSingleProduct(this);"><i class="fa fa-times-circle"></i></a></li>'
				);
             	$("div#divSales span[name='spanSales']").eq(idx).html(map.PRODUCT_STANDARD); //규격
             	count = map.PRODUCT_COUNT;
             	num = map.PRODUCT_PRICE.toString();
				itg = num.split(".")["0"];
				dcm = num.split(".")["1"];
				(!!dcm && dcm != null && dcm !=0) ? dcm = '.' + dcm.substr(0,4) : dcm = "";
             	$("div#divSales input[name='sales_product_price']").eq(idx).val(add_comma(itg) + dcm); //단가
             	$("div#divSales input[name='sales_product_count']").eq(idx).val(count); //수량
             	$("div#divSales input[name='sales_product_total']").eq(idx).val(add_comma((parseFloat(num)*count).toFixed(0).toString())); //금액
             	
             	//대표여부
    			if(map.PRODUCT_YN == 1){
    				$('div#divSales input[name="sales_product_mainChk"]').eq(idx).trigger("change");	
    			}
			}
         	
			if($("div#divSales input[name='sales_product_mainChk']:checked").length == 0){
				$("div#divSales input[name='sales_product_mainChk']").first().prop("checked",true);
				$('div#divSales input[name="sales_product_mainChk"]').first().val(1);
			}
		},
		
		//매출품목 Sum
		salesDel : function(obj){
			$(obj).closest("div.product_sub").remove();
			//oppProduct.salesSum();
			//매출품목 대표여부 기본값 1
			if($("div#divSales input[name='sales_product_mainChk']:checked").length == 0){
				$("div#divSales input[name='sales_product_mainChk']").first().prop("checked",true);
				$('div#divSales input[name="sales_product_mainChk"]').first().val(1);
			}
		},
		
		//수량 입력시
		psCount : function(obj) {
			var count, price, total = 0;
			var num, itg, dcm = 0;
			
			count = $(obj).val();
			price = uncomma($(obj).parent().next().children("input").val());
			total = uncomma($(obj).parent().next().next().children("input").val());
			
			if(price != 0 && !isEmpty(price)){		//단가가 있으면
				num = ((count*price).toFixed(0)).toString();
				
				$(obj).parent().next().next().children().val(add_comma(parseInt(num).toString()));
			}else if(total != 0 && !isEmpty(total)){		//금액이 있으면
				num = ((total/count).toFixed(4)).toString();
				itg = num.split(".")["0"];
				dcm = num.split(".")["1"];
				(!!dcm && dcm != null && dcm !=0) ? dcm = '.' + dcm : dcm = "";
				
				$(obj).parent().next().children().val(add_comma(itg) + dcm);
			}
			
			oppProduct.psSum();
		},
		
		//단가 입력시 무조건 수량 곱하기
		psPrice : function(obj) {
			var count, price, total = 0;
			var num = 0;
			
			count = $(obj).parent().prev().children("input").val();
			price = uncomma($(obj).val());
			total = uncomma($(obj).parent().next().children("input").val());
			
			num = ((count*price).toFixed(0)).toString();
			$(obj).parent().next().children().val(add_comma(parseInt(num).toString()));
			
			//oppProduct.psSum();
		},
		
		//금액 입력시 무조건 수량 나누기
		psTotal : function(obj) {
			var count, price, total = 0;
			var num, itg, dcm = 0;
			
			count = $(obj).parent().prev().prev().children("input").val();
			price = uncomma($(obj).parent().prev().children("input").val());
			total = uncomma($(obj).val());
			
			num = ((total/count).toFixed(4)).toString();
			itg = num.split(".")["0"];
			dcm = num.split(".")["1"];
			(!!dcm && dcm != null && dcm !=0) ? dcm = '.' + dcm : dcm = "";
			
			$(obj).parent().prev().children().val(add_comma(itg) + dcm);
			
			//oppProduct.psSum();
		},
		
		//매입품목 Sum
		psSum : function(obj){
			var allTotal = 0;
			
			$("input[name='ps_product_total']").each(function(idx, val){
				var salesSum = parseInt(uncomma($(this).val()));
				if(salesSum > 0 || salesSum < 0){
					allTotal += salesSum;			
				}
				$('span[id="spanPsTotal"]').html(add_comma(allTotal.toString()));
			});
			
			if($("input[name='ps_product_total']").length == 0)$('span[id="spanPsTotal"]').html(0);
		},
		
		//매입품목 추가
		psAdd : function(map){
			$('div#divPs').append(oppProduct.psHtml);
		},
		
		//매입품목 추가
		setPsAdd : function(callback, map){
			$('div#divPs').append(oppProduct.psHtml);
			callback(map);
		},
		
		
		psSetData : function(map){
			var idx = $("div[name='divPs_sub']").length-1;
			var num, itg, dcm, count = 0;//단가 변수
			
			if(map){
 				//품목
				$("div#divPs input[name='textPsProductSeach']").eq(idx).hide();
				$("div#divPs input[name='hiddenPsProductCode']").eq(idx).val(map.PRODUCT_CD);
				$("div#divPs input[name='hiddenPsWorksCode']").eq(idx).val(map.WORKS_CD);
             	$('div#divPs li[name="liPsProductSeach"]').eq(idx).before(
             			'<li class="value">' +
						'<span class="txt" id="'+map.PRODUCT_CD+'">'+map.PRODUCT_CD+'</span>' +
						'<a href="#" class="remove" onclick="commonSearch.removeSingleProduct(this);"><i class="fa fa-times-circle"></i></a></li>'
				);	    	             	
             	$("div#divPs span[name='spanPs']").eq(idx).html(map.PRODUCT_STANDARD); //규격
             	count = map.PRODUCT_COUNT;
             	num = map.PRODUCT_PRICE.toString();
				itg = num.split(".")["0"];
				dcm = num.split(".")["1"];
				(!!dcm && dcm != null && dcm !=0) ? dcm = '.' + dcm.substr(0,4) : dcm = "";
             	$("div#divPs input[name='ps_product_price']").eq(idx).val(add_comma(itg) + dcm); //단가
             	$("div#divPs input[name='ps_product_count']").eq(idx).val(count); //수량
             	$("div#divPs input[name='ps_product_total']").eq(idx).val(add_comma((parseFloat(num)*count).toFixed(0).toString())); //금액
             	//매입처
             	if(map.COMPANY_ID){
					$("div#divPs input[name='textPsCompanySeach']").eq(idx).hide();
					$("div#divPs input[name='hiddenPsCompany']").eq(idx).val(map.COMPANY_ID);
	             	$('div#divPs li[name="liPsCompanySeach"]').eq(idx).before(
	             			'<li class="value">' +
							'<span class="txt" id="'+map.COMPANY_ID+'">'+map.COMPANY_NAME+'</span>' +
							'<a href="#" class="remove" onclick="commonSearch.removeSingleProduct(this);"><i class="fa fa-times-circle"></i></a></li>'
					);
             	}
             	$("div#divPs input[name='textModalPsDate']").eq(idx).val(map.PURCHASE_DATE); //매입예정일
             	
			}
		},
		
		//매입품목 삭제
		psDel : function(obj){
			$(obj).closest("div.product_sub").remove();
			//oppProduct.psSum();
		},
		
		//매출품목 가져오기
		getSalesAdd : function(){
			var psIdx =  $("div#divPs").find('tr').length-1;	//total 빼고
			if($('div#divSales input[name="hiddenSalesProductCode"][value!=""]').length > 0){ //등록된 것만
				$('div#divSales input[name="hiddenSalesProductCode"]').each(function(idx, val){
					if($(this).val()){
						oppProduct.psAdd();
						
						var ppc = $(this).val(); 
						var pwc = $(this).next().val();
						var ulHtml = "";
						
						ulHtml += '<li class="value"><span class="txt" id="'+ppc+'">'+ppc+'</span>';
						ulHtml += '<a href="#" class="remove" onclick="commonSearch.removeSingleProduct(this);"><i class="fa fa-times-circle"></i></a></li>'
						ulHtml += '<li class="input-container flexdatalist-multiple-value pos-rel" name="liProductSeach" style="width: 100%;">';
						ulHtml += '<input type="text" class="form-control" name="textPsProductSeach" placeholder="품목코드 또는 품목명을 검색해 주세요." autocomplete="off" style="width: 100%; display: none;" auto-bind="0">';
						ulHtml += '<input type="hidden" name="hiddenPsProductCode" value="'+ppc+'">';
						ulHtml += '<input type="hidden" name="hiddenPsWorksCode" value="'+pwc+'">';
						ulHtml += '<div class="autocomplete-suggestions "></div></li>';
						
						$("div#divPs input[name='ps_product_price']").eq(psIdx).val($("div#divSales input[name='sales_product_price']").eq(idx).val());
						$("div#divPs input[name='ps_product_count']").eq(psIdx).val($("div#divSales input[name='sales_product_count']").eq(idx).val());
						$("div#divPs input[name='ps_product_total']").eq(psIdx).val($("div#divSales input[name='sales_product_total']").eq(idx).val());
						$("div#divPs span[name='spanPs']").eq(psIdx).html($("div#divSales span[name='spanSales']").eq(idx).html());
						$('div#divPs ul[name="ulPsMultiple"]').eq(psIdx).html(ulHtml);
						++psIdx;
						
					}
				});
			}
			
			oppProduct.psSum();
		},
		
		addAllPs : function(cb){
			var companyId = $("#hiddenAllPsCompany").val(); //매입처 id
			var companyName = $("li#liAllPsCompanySeach").prev("li.value").find("span").html(); //매입처 이름
			var psDate = $("#textAllPsDate").val(); //매입예정일
			
			$('div#divPs ul[name="ulPsCompanyMultiple"]').each(function(idx, val){
				var ulHtml = "";
				ulHtml += '<li class="value"><span class="txt" id="'+companyId+'">'+companyName+'</span>';
				ulHtml += '<a href="#" class="remove" onclick="commonSearch.removeSingleCompany(this);"><i class="fa fa-times-circle"></i></a></li>'
				ulHtml += '<li class="input-container flexdatalist-multiple-value pos-rel" name="liPsCompanySeach" style="width: 100%;">';
				ulHtml += '<input type="text" class="form-control" name="textPsCompanySeach" placeholder="매입처를 검색해 주세요." autocomplete="off" style="width: 100%; display: none;" auto-bind="0">';
				ulHtml += '<input type="hidden" name="hiddenPsCompany" value="'+companyId+'">';
				ulHtml += '<div class="autocomplete-suggestions "></div></li>';
				if(companyId){
					$(this).html(ulHtml);	
				}
			});
			
			if(psDate) $("input[name='textModalPsDate']").val(psDate);
			if(cb) cb(); //callback
		}
}

</script>

					<div class="PS_list">
						<span class="title">매출품목</span>
					</div>
					
					<div class="view_cata_full" id="divSales">
							<div class="product_sub" name="divSales_sub">
						
							<a href="javascript:void(0);" class="icon_delete fl_r mg_b10 mg_t10" onclick="oppProduct.salesDel(this);">삭제</a>
							
							<div class="ti mg_b5">
								<label>대표여부</label>
								<input type="checkbox" name="sales_product_mainChk" value="1" checked/>
							</div>
							
							<div class="ti mg_b5">
		                        <label>매출품목</label>
								<div class="">
			                            <ul class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255); padding:none;">
			                                <li class="input-container flexdatalist-multiple-value pos-rel" name="liSalesProductSeach" style="width: 100%;">
			                                <input type="text" class="form-control" name="textSalesProductSeach" placeholder="검색해 주세요." autocomplete="off" style="width: 100%;" auto-bind="0">
			                                <input type="hidden" name="hiddenSalesProductCode" value=""/>
			                            	<input type="hidden" name="hiddenSalesWorksCode" value=""/>
			                                </li>
			                            </ul>
						    	</div>
		                    </div>
		                    
		                    <div class="ti mg_b5">
		                        <label>규격</label>
								<span name="spanSales"></span>
		                    </div>
		                    
		                     <div class="ti mg_b5">
		                        <label>수량</label>
								<input type="text" style="text-align: right;" onclick="oppProduct.zero(this);" onblur="oppProduct.blur(this);oppProduct.salesCount(this);" onkeyup="commonCheck.onlyInteger(this);" class="form-control" name="sales_product_count" value="0" maxlength="5">
		                    </div>
		                    
		                    <div class="ti mg_b5">
		                        <label>단가</label>
								<input type="text" style="text-align: right;" onclick="oppProduct.zero(this);" onblur="oppProduct.blur(this);oppProduct.salesPrice(this);" onkeyup="commonCheck.onlyRealNumber(this);" class="form-control" name="sales_product_price" value="0">
		                    </div>
		                    
		                    <div class="ti mg_b5">
		                        <label>금액</label>
								<input type="text" style="text-align: right;" onclick="oppProduct.zero(this);" onblur="oppProduct.blur(this);oppProduct.salesTotal(this);" onkeyup="commonCheck.onlyRealNumber(this);" class="form-control" name="sales_product_total" value="0">
		                    </div>
		                    
<!-- 	                    <td><a href="javascript:void(0);" onClick="oppProduct.salesDel(this);"><i class="fa fa-trash-o fa-lg"></i></a></td> -->

						</div>
					</div>
							                 
                   <div class="PS_list">
						<span class="title">매입품목</span>
				   </div>
				   <div class="view_cata_full" id="divPs">
				   		<div class="product_sub" name="divPs_sub">
							<a href="javascript:void(0);" class="icon_delete fl_r mg_b10 mg_t10" onclick="oppProduct.psDel(this);">삭제</a>
							
							<div class="ti mg_b5">
			                        <label>매출품목</label>
									<div class="">
											<ul name="ulPsMultiple" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255); padding:none;">
				                                <li class="input-container flexdatalist-multiple-value pos-rel" name="liPsProductSeach" style="width: 100%;">
				                                <input type="text" class="form-control" name="textPsProductSeach" placeholder="검색해 주세요." autocomplete="off" style="width: 100%;" auto-bind="0">
				                                <input type="hidden" name="hiddenPsProductCode" value=""/>
				                            	<input type="hidden" name="hiddenPsWorksCode" value=""/>
				                                <div class="autocomplete-suggestions "></div></li>
				                            </ul>
							    	</div>
			                    </div>
			                    
			                    <div class="ti mg_b5">
			                        <label>규격</label>
									<span name="spanPs"></span>
			                    </div>
			                    
			                     <div class="ti mg_b5">
			                        <label>수량</label>
									<input type="text" style="text-align: right;" onclick="oppProduct.zero(this);" onblur="oppProduct.blur(this);oppProduct.psCount(this);" onkeyup="commonCheck.onlyInteger(this);" class="form-control" name="ps_product_count" value="0" maxlength="5">
			                    </div>
			                    
			                    <div class="ti mg_b5">
			                        <label>단가</label>
									<input type="text" style="text-align: right;" onclick="oppProduct.zero(this);" onblur="oppProduct.blur(this);oppProduct.psPrice(this);" onkeyup="commonCheck.onlyRealNumber(this);" class="form-control" name="ps_product_price" value="0">
			                    </div>
			                    
			                    <div class="ti mg_b5">
			                        <label>금액</label>
									<input type="text" style="text-align: right;" onclick="oppProduct.zero(this);" onblur="oppProduct.blur(this);oppProduct.psTotal(this);" onkeyup="commonCheck.onlyRealNumber(this);" class="form-control" name="ps_product_total" value="0">
			                    </div>
			                    
			                    <div class="ti mg_b5">
			                        <label>매입처</label>
									<div class="">
											<ul name="ulPsCompanyMultiple" class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255); padding:none;">
				                                <li class="input-container flexdatalist-multiple-value pos-rel" name="liPsCompanySeach" style="width: 100%;">
				                                <input type="text" class="form-control" name="textPsCompanySeach" placeholder="검색해 주세요." autocomplete="off" style="width: 100%;" auto-bind="0">
				                                <input type="hidden" name="hiddenPsCompany" value=""/>
				                                <div class="autocomplete-suggestions "></div></li>
				                            </ul>
							    	</div>
			                    </div>
			                    
			                    <div class="ti mg_b5">
			                        <label>매입예정일</label>
									<input type="date" placeholder="ex)1988-11-18" class="form_control" name="textModalPsDate" style="text-indent:5px;"/>
			                    </div>
		                    
		                    <!-- <td><a href="javascript:void(0);" onClick="oppProduct.psDel(this);"><i class="fa fa-trash-o fa-lg"></i></a></td> -->
						</div>
					</div>
					

					
					
				
				
				
				
				