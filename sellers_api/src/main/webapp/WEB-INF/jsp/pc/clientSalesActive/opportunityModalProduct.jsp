<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
				
				<div class="clearfix mg-b5">
					<h4 style="padding-left:3px;">매출품목</h4>
				</div> 
				<div class="form-group">
		             <div class="col-sm-12">
		                 <table id="salesTable" class="table table-bordered ">
						<colgroup>
							<col width="8%">
							<col width="*">
							<col width="15%">
							<col width="8%">
							<col width="15%">
							<col width="15%">
							<col width="7%">
						</colgroup>
		              <thead>
		                  <tr>
		                  	  <th>대표여부</th>
		                      <th>품목</th>
		                      <th>규격</th>
		                      <th>수량</th>
		                      <th>단가</th>
		                      <th>금액</th>
		                      <th>삭제</th>
		                  </tr>
		              </thead>
		              <tbody id="tbodySales">
		                     <tr class="total">
						          <td colspan="5"></td>
						          <td><span id="spanSalesTotal" style="color:#2dbae7; font-weight:700;">0</span></td>
						          <td></td>
						     </tr>
		              </tbody>
		          </table>
		
		          <p class="text-right pd-t10">
		              <a href="javascript:void(0);" class="btn-row-add" name="buttonSaleAddRow" onclick="oppProduct.salesAdd();">+ 매출품목 추가</a>
		          </p>
		      </div>
			</div>
			
                <div class="form-group" style="padding:10px 0 5px 0;">
					<div class="col-sm-4">
						<div class="clearfix mg-b5">
							<h4 style="padding-left:3px;">매입품목</h4>
						</div> 
					</div>
                	
                	<div class="col-sm-3">
              			<ul class="flexdatalist-multiple" style="border: 1px solid rgb(204, 204, 204); border-radius: 4px; background-color: rgb(255, 255, 255); padding:none;">
	                        <li class="input-container flexdatalist-multiple-value pos-rel" id="liAllPsCompanySeach" style="width: 100%;">
	                        <input type="text" class="form-control" id="textPsAllCompanySeach" placeholder="매입처를 검색해 주세요." autocomplete="off" style="width: 100%;" auto-bind="0">
	                        <input type="hidden" id="hiddenAllPsCompany" value=""/>
	                        </li>
	                    </ul>
              		</div>
              		
                	<div class="col-sm-3">
                		<div class="data_1">
                             <div class="input-group date">
                                 <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" id="textAllPsDate" value="">
                             </div>
                         </div>
                	</div>
                	
              		<a href="javascript:void(0);" class="btn btn-white btn-sm" onclick="oppProduct.addAllPs();"> 일괄적용</a>
              		
                </div>                            
				
				<div class="form-group">
		             <div class="col-sm-12">
		             	 <!-- <div class="table_container_fade"></div> -->
			             <div class="table_container">
				                <table id="psTable" class="table-bordered" style="width:1000px; margin-bottom: 20px;">
									<colgroup>
										<col width="235px;">
										<col width="110px;">
										<col width="68px;">
										<col width="115px;">
										<col width="125px;">
										<col width="170px;">
										<col width="128px;">
										<col width="48px;">
									</colgroup>
					              <thead>
					                  <tr>
					                      <th>품목</th>
					                      <th>규격</th>
					                      <th>수량</th>
					                      <th>단가</th>
					                      <th>금액</th>
					                      <th>매입처</th>
					                      <th>매입예정일</th>
					                      <th>삭제</th>
					                  </tr>
					              </thead>
					              <tbody id="tbodyPs">
					                     <tr class="total">
									          <td colspan="4"></td>
									          <td><span id="spanPsTotal" style="color:#2dbae7; font-weight:700;">0</span></td>
									          <td></td>
									          <td></td>
									          <td></td>
									     </tr>
					              </tbody>
					         	 </table>
			         	 </div>
		          <p class="text-right pd-t10">
		          	  <a href="javascript:void(0);" class="btn-row-add" name="buttonSaleAddRow" onclick="oppProduct.getSalesAdd();">매출품목 가져오기</a>
		              <a href="javascript:void(0);" class="btn-row-add" name="buttonSaleAddRow" onclick="oppProduct.psAdd();">+ 매입품목 추가</a>
		          </p>
		      </div>
			</div>
			
			
<script type="text/javascript">
$(document).ready(function() { 
	//매입처 일괄적용 자동완성
	commonSearch.singleCompanyProduct($("#textPsAllCompanySeach"), $('#liAllPsCompanySeach'), $('#hiddenAllPsCompany')); //고객사
	
	$.get("/ajaxHtml/opportunitySalesProduct.html", function(data){
		oppProduct.salesHtml = data;
	});
	
	$.get("/ajaxHtml/opportunityPsProduct.html", function(data){
		oppProduct.psHtml = data;
	});
});

var oppProductEvent = {
		on : function(){
			// 매출 대표여부 체크박스
			$("tbody#tbodySales").on("change", "input[name='sales_product_mainChk']", oppProductEvent.changeSpMainCk);
			
			// 매출품목 자동완성
			$("tbody#tbodySales").on("focus", "input[name='textSalesProductSeach']", oppProductEvent.focusSpSearch); 
			
			// 매입품목 자동완성
			$("tbody#tbodyPs").on("focus", "input[name='textPsProductSeach']", oppProductEvent.focusPsSearch);
			
			// 매입처 자동완성
			$("tbody#tbodyPs").on("focus", "input[name='textPsCompanySeach']", oppProductEvent.focusPsCompanySearch);
			
			$("tbody#tbodySales, tbody#tbodyPs").on("keydown", "input", oppProductEvent.keydownEnterReturn);
		},
		
		off : function(){
			// 매출 대표여부 체크박스
			$("tbody#tbodySales").off("change", "input[name='sales_product_mainChk']", oppProductEvent.changeSpMainCk);
			
			// 매출품목 자동완성
			$("tbody#tbodySales").off("focus", "input[name='textSalesProductSeach']", oppProductEvent.focusSpSearch); 
			
			// 매입품목 자동완성
			$("tbody#tbodyPs").off("focus", "input[name='textPsProductSeach']", oppProductEvent.focusPsSearch);
			
			// 매입처 자동완성
			$("tbody#tbodyPs").off("focus", "input[name='textPsCompanySeach']", oppProductEvent.focusPsCompanySearch);
			
			$("tbody#tbodySales, tbody#tbodyPs").off("keydown", "input", oppProductEvent.keydownEnterReturn);
		},
		
		changeSpMainCk : function(e){
			var idx = $("tbody#tbodySales input[name='sales_product_mainChk']").index(this);
			$('input[name="sales_product_mainChk"]').prop("checked",false);
			$('input[name="sales_product_mainChk"]').val(0);
			
			//품목을 검색하지 않고 대표여부를 체크하면
			if(isEmpty($('tbody#tbodySales input[name="hiddenSalesProductCode"]').eq(idx).val())){
				$("tbody#tbodySales input[name='sales_product_mainChk']").first().prop("checked",true);
				$('tbody#tbodySales input[name="sales_product_mainChk"]').first().val(1);
			}else{
				$(this).prop("checked",true);
				$(this).val(1);					
			}
		},
		
		focusSpSearch : function(e){
			var idx = $("tbody#tbodySales input[name='textSalesProductSeach']").index(this);
			if($(this).attr("auto-bind") == "0"){
				commonSearch.singleProduct($(this), idx);
				$(this).attr("auto-bind","1");
			}
		},
		
		focusPsSearch : function(e){
			var idx = $("tbody#tbodyPs input[name='textPsProductSeach']").index(this);
			if($(this).attr("auto-bind") == "0"){
				commonSearch.singleProduct($(this), idx);
				$(this).attr("auto-bind","1");
			}
		},
		
		focusPsCompanySearch : function(e){
			var idx = $("tbody#tbodyPs input[name='textPsCompanySeach']").index(this);
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
			$("tbody#tbodySales").find('tr').not('tr.total').remove();
			$("tbody#tbodyPs").find('tr').not('tr.total').remove();
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
			var tab_no = $("tbody#tbodySales").parents('div.modaltabmenu').attr("tab-seq")-1;
			
			$("label#salesTable-error").remove();
			$("label#psTable-error").remove();
			
			//매출품목
			$('tbody#tbodySales input[name="hiddenSalesProductCode"]').each(function(idx, val){
				if($(this).val()){
					var salesData = new Object() ;
					
					salesData.product_order = salesSeq++;
					salesData.product_cd = $("input[name='hiddenSalesProductCode']").eq(idx).val();
					
					if(uncomma($("input[name='sales_product_price']").eq(idx).val()) != 0){
						salesData.product_price = uncomma($("input[name='sales_product_price']").eq(idx).val());
					}else{
						if(!temp_flag){
							$("#salesTable").after('<label id="salesTable-error" class="error-custom" for="salesTable">단가를 입력해 주세요.</label>'	);
							$("ul.tabmenu-type li a").eq(tab_no).trigger('click.modalTab');
						}

						validFlag = false;
						return false;
					}
					
					if($("input[name='sales_product_count']").eq(idx).val() != 0){
						salesData.product_count = $("input[name='sales_product_count']").eq(idx).val();
					}else{
						if(!temp_flag){
							$("#salesTable").after('<label id="salesTable-error" class="error-custom" for="salesTable">수량을 입력해 주세요.</label>'	);
							$("ul.tabmenu-type li a").eq(tab_no).trigger('click.modalTab');
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
			$('tbody#tbodyPs input[name="hiddenPsProductCode"]').each(function(idx, val){
				if($(this).val()){
					var seq = 1;
					var psData = new Object() ;
					
					psData.product_order = psSeq++;
					psData.product_cd = $("input[name='hiddenPsProductCode']").eq(idx).val();
					
					if(uncomma($("input[name='ps_product_price']").eq(idx).val()) != 0){
						psData.product_price = uncomma($("input[name='ps_product_price']").eq(idx).val()); 
					}else{
						if(!temp_flag){
							$("#psTable").after('<label id="psTable-error" class="error-custom" for="psTable">단가를 입력해 주세요.</label>'	);
							$("ul.tabmenu-type li a").eq(tab_no).trigger('click.modalTab');
						}
						validFlag = false;
						return false;
					}
					
					if($("input[name='ps_product_count']").eq(idx).val() != 0){
						psData.product_count = $("input[name='ps_product_count']").eq(idx).val();
					}else{
						if(!temp_flag){
							$("#psTable").after('<label id="psTable-error" class="error-custom" for="psTable">수량을 입력해 주세요.</label>'	);
							$("ul.tabmenu-type li a").eq(tab_no).trigger('click.modalTab');
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
			
			oppProduct.salesSum();
		},
		
		//단가 입력시 무조건 수량 곱하기
		salesPrice : function(obj) {
			var count, price, total = 0;
			var num = 0;
			
			count = $(obj).parent().prev().children().val();
			price = uncomma($(obj).val());
			total = uncomma($(obj).parent().next().children().val());
			
			num = ((count*price).toFixed(0)).toString();
			$(obj).parent().next().children().val(add_comma(parseInt(num).toString()));
			
			oppProduct.salesSum();
		},
		
		//금액 입력시 무조건 수량 나누기
		salesTotal : function(obj) {
			var count, price, total = 0;
			var num, itg, dcm = 0;
			
			count = $(obj).parent().prev().prev().children().val();
			price = uncomma($(obj).parent().prev().children().val());
			total = uncomma($(obj).val());
			
			num = ((total/count).toFixed(4)).toString();
			itg = num.split(".")["0"];
			dcm = num.split(".")["1"];
			(!!dcm && dcm != null && dcm !=0) ? dcm = '.' + dcm : dcm = "";
			
			$(obj).parent().prev().children().val(add_comma(itg) + dcm);
			
			oppProduct.salesSum();
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
			$('tbody#tbodySales').append(oppProduct.salesHtml);
			if($("tbody#tbodySales input[name='sales_product_mainChk']:checked").length == 0){
				$("tbody#tbodySales input[name='sales_product_mainChk']").first().prop("checked",true);
				$('tbody#tbodySales input[name="sales_product_mainChk"]').first().val(1);
			}
		},
		
		salesSetData : function(map){
			var idx = $("tbody#tbodySales input[name='textSalesProductSeach']").index($("tbody#tbodySales input[name='textSalesProductSeach']").last());
			var num, itg, dcm, count = 0;//단가 변수
			
			if(map){
     			//품목
				$("tbody#tbodySales input[name='textSalesProductSeach']").eq(idx).hide();
				$("tbody#tbodySales input[name='hiddenSalesProductCode']").eq(idx).val(map.PRODUCT_CD);
				$("tbody#tbodySales input[name='hiddenSalesWorksCode']").eq(idx).val(map.WORKS_CD);
             	$('tbody#tbodySales li[name="liSalesProductSeach"]').eq(idx).before(
             			'<li class="value">' +
						'<span class="txt" id="'+map.PRODUCT_CD+'">'+map.PRODUCT_CD+'</span>' +
						'<a href="#" class="remove" onclick="commonSearch.removeSingleProduct(this);"><i class="fa fa-times-circle"></i></a></li>'
				);
             	$("tbody#tbodySales span[name='spanSales']").eq(idx).html(map.PRODUCT_STANDARD); //규격
             	count = map.PRODUCT_COUNT;
             	num = map.PRODUCT_PRICE.toString();
				itg = num.split(".")["0"];
				dcm = num.split(".")["1"];
				(!!dcm && dcm != null && dcm !=0) ? dcm = '.' + dcm.substr(0,4) : dcm = "";
             	$("tbody#tbodySales input[name='sales_product_price']").eq(idx).val(add_comma(itg) + dcm); //단가
             	$("tbody#tbodySales input[name='sales_product_count']").eq(idx).val(count); //수량
             	$("tbody#tbodySales input[name='sales_product_total']").eq(idx).val(add_comma((parseFloat(num)*count).toFixed(0).toString())); //금액
             	
             	//대표여부
    			if(map.PRODUCT_YN == 1){
    				$('tbody#tbodySales input[name="sales_product_mainChk"]').eq(idx).trigger("change");	
    			}
			}
         	
			if($("tbody#tbodySales input[name='sales_product_mainChk']:checked").length == 0){
				$("tbody#tbodySales input[name='sales_product_mainChk']").first().prop("checked",true);
				$('tbody#tbodySales input[name="sales_product_mainChk"]').first().val(1);
			}
		},
		
		//매출품목 Sum
		salesDel : function(obj){
			$(obj).parent("td").parent("tr").remove();
			oppProduct.salesSum();
			//매출품목 대표여부 기본값 1
			if($("tbody#tbodySales input[name='sales_product_mainChk']:checked").length == 0){
				$("tbody#tbodySales input[name='sales_product_mainChk']").first().prop("checked",true);
				$('tbody#tbodySales input[name="sales_product_mainChk"]').first().val(1);
			}
		},
		
		//수량 입력시
		psCount : function(obj) {
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
			
			oppProduct.psSum();
		},
		
		//단가 입력시 무조건 수량 곱하기
		psPrice : function(obj) {
			var count, price, total = 0;
			var num = 0;
			
			count = $(obj).parent().prev().children().val();
			price = uncomma($(obj).val());
			total = uncomma($(obj).parent().next().children().val());
			
			num = ((count*price).toFixed(0)).toString();
			$(obj).parent().next().children().val(add_comma(parseInt(num).toString()));
			
			oppProduct.psSum();
		},
		
		//금액 입력시 무조건 수량 나누기
		psTotal : function(obj) {
			var count, price, total = 0;
			var num, itg, dcm = 0;
			
			count = $(obj).parent().prev().prev().children().val();
			price = uncomma($(obj).parent().prev().children().val());
			total = uncomma($(obj).val());
			
			num = ((total/count).toFixed(4)).toString();
			itg = num.split(".")["0"];
			dcm = num.split(".")["1"];
			(!!dcm && dcm != null && dcm !=0) ? dcm = '.' + dcm : dcm = "";
			
			$(obj).parent().prev().children().val(add_comma(itg) + dcm);
			
			oppProduct.psSum();
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
			$('tbody#tbodyPs').append(oppProduct.psHtml);
		},
		
		psSetData : function(map){
			var idx = $("tbody#tbodyPs input[name='textPsProductSeach']").index($("tbody#tbodyPs input[name='textPsProductSeach']").last());
			var num, itg, dcm, count = 0;//단가 변수
			
			if(map){
 				//품목
				$("tbody#tbodyPs input[name='textPsProductSeach']").eq(idx).hide();
				$("tbody#tbodyPs input[name='hiddenPsProductCode']").eq(idx).val(map.PRODUCT_CD);
				$("tbody#tbodyPs input[name='hiddenPsWorksCode']").eq(idx).val(map.WORKS_CD);
             	$('tbody#tbodyPs li[name="liPsProductSeach"]').eq(idx).before(
             			'<li class="value">' +
						'<span class="txt" id="'+map.PRODUCT_CD+'">'+map.PRODUCT_CD+'</span>' +
						'<a href="#" class="remove" onclick="commonSearch.removeSingleProduct(this);"><i class="fa fa-times-circle"></i></a></li>'
				);	    	             	
             	$("tbody#tbodyPs span[name='spanPs']").eq(idx).html(map.PRODUCT_STANDARD); //규격
             	count = map.PRODUCT_COUNT;
             	num = map.PRODUCT_PRICE.toString();
				itg = num.split(".")["0"];
				dcm = num.split(".")["1"];
				(!!dcm && dcm != null && dcm !=0) ? dcm = '.' + dcm.substr(0,4) : dcm = "";
             	$("tbody#tbodyPs input[name='ps_product_price']").eq(idx).val(add_comma(itg) + dcm); //단가
             	$("tbody#tbodyPs input[name='ps_product_count']").eq(idx).val(count); //수량
             	$("tbody#tbodyPs input[name='ps_product_total']").eq(idx).val(add_comma((parseFloat(num)*count).toFixed(0).toString())); //금액
             	//매입처
             	if(map.COMPANY_ID){
					$("tbody#tbodyPs input[name='textPsCompanySeach']").eq(idx).hide();
					$("tbody#tbodyPs input[name='hiddenPsCompany']").eq(idx).val(map.COMPANY_ID);
	             	$('tbody#tbodyPs li[name="liPsCompanySeach"]').eq(idx).before(
	             			'<li class="value">' +
							'<span class="txt" id="'+map.COMPANY_ID+'">'+map.COMPANY_NAME+'</span>' +
							'<a href="#" class="remove" onclick="commonSearch.removeSingleProduct(this);"><i class="fa fa-times-circle"></i></a></li>'
					);
             	}
             	$("tbody#tbodyPs input[name='textModalPsDate']").eq(idx).val(map.PURCHASE_DATE); //매입예정일
             	
			}
		},
		
		//매입품목 삭제
		psDel : function(obj){
			$(obj).parent("td").parent("tr").remove();
			oppProduct.psSum();
		},
		
		//매출품목 가져오기
		getSalesAdd : function(){
			var psIdx =  $("tbody#tbodyPs").find('tr').length-1;	//total 빼고
			if($('tbody#tbodySales input[name="hiddenSalesProductCode"][value!=""]').length > 0){ //등록된 것만
				$('tbody#tbodySales input[name="hiddenSalesProductCode"]').each(function(idx, val){
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
						
						$("tbody#tbodyPs input[name='ps_product_price']").eq(psIdx).val($("tbody#tbodySales input[name='sales_product_price']").eq(idx).val());
						$("tbody#tbodyPs input[name='ps_product_count']").eq(psIdx).val($("tbody#tbodySales input[name='sales_product_count']").eq(idx).val());
						$("tbody#tbodyPs input[name='ps_product_total']").eq(psIdx).val($("tbody#tbodySales input[name='sales_product_total']").eq(idx).val());
						$("tbody#tbodyPs span[name='spanPs']").eq(psIdx).html($("tbody#tbodySales span[name='spanSales']").eq(idx).html());
						$('tbody#tbodyPs ul[name="ulPsMultiple"]').eq(psIdx).html(ulHtml);
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
			
			$('tbody#tbodyPs ul[name="ulPsCompanyMultiple"]').each(function(idx, val){
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