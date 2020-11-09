 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- <div class="clearfix mg-b10">
    <a href="javascript:void(0);" onClick="oppSalesPlan.addSalesPlan();" class="btn_add_cell fl_l"> <span class="icon icon_add"></span> 본부 추가하기</a>
    <span class="fl_r fc_gray pd-t5">(단위 : 원)</span>
</div> -->

<div class="form-group">
	<div class="col-sm-12">
		
		<div class="clearfix mg-b5">
			<h4 style="padding-left:3px;">매출/수금 계획</h4>
		</div>
		<table id="tableSalesPlan" class="table basic2">
		    <colgroup>
		        <col width="14%"/>
		        <col width="14%"/>
		        <col width="34%"/>
		        <col width="34%"/>
		        <col width="*"/>
		    </colgroup>
		    <thead>
		        <tr>
		        	<th>매출계획일</th>
		        	<th>수금계획일</th>
		        	<th>P.REV(예상매출) / A.REV(실제매출)</th>
		        	<th>P.GP(예상이익) / A.GP(실제이익)</th>
		        	<th>삭제</th>
		        </tr>
		    </thead>
		    <tbody id="tbodySalesPlan">
		    	 <tr class="total">
		        	<td class="ag_c border_gap"></td>
		        	<td class="ag_c border_gap"></td>
		        	<td class="border_gap cellend"><span class="total" id="totalPlanRev" style="font-size : 13px;">0</span> / <span class="total" id="totalActRev" style="font-size : 13px;">0</span></td>
		        	<td class="border_gap cellend"><span class="total" id="totalPlanGp" style="font-size : 13px;">0</span> / <span class="total" id="totalActGp" style="font-size : 13px;">0</span></td>
		        	<td class="ag_c border_gap"></td>
		        </tr>
		    </tbody>
		</table>
	
		<div class="clearfix mg-b5">
			<h4 style="padding-left:3px;">스플릿</h4>
		</div>
		<table id="tableSalesSplit" class="table basic2">
		    <colgroup>
		        <col width="14%"/>
		        <col width="14%"/>
		        <col width="34%"/>
		        <col width="34%"/>
		        <col width="*"/>
		    </colgroup>
		    <thead>
		        <tr>
		        	<th>영업대표</th>
		        	<th>매출계획일</th>
		        	<th>REV</th>
		        	<th>GP</th>
		        	<th>삭제</th>
		        </tr>
		    </thead>
		    <tbody id="tbodySalesSplit">
		    
		    </tbody>
		</table>
	
		 <p class="text-center pd-t10">
		     <a href="javascript:void(0);" class="btn-row-add" name="buttonSaleAddRow" onclick="oppSalesPlan.add();">+ 매출/수금계획 추가</a>
		     <a href="javascript:void(0);" class="btn-row-add" name="buttonSaleAddRow" onclick="oppSalesSplit.add();">+ 스플릿 추가</a>
		 </p>
	</div>
</div>
 
<script type="text/javascript">
$(document).ready(function(){
	$.get("/ajaxHtml/opportunityModalSalesPlanHtml.html", function(data){
	    oppSalesPlan.salesPlanHtml = data;
	});
	
	$.get("/ajaxHtml/opportunitySalesSplit.html", function(data){
	    oppSalesPlan.salesSplitHtml = data; 
	});
	
});

var oppSalesPlanEvent = {
		on : function(){
			//책임자 자동 완성
			$("tbody#tbodySalesSplit").on("focus", "input[name='textSalesSplit']", oppSalesPlanEvent.focusSalesSplit);	
			
			$("tbody#tbodySalesPlan ,tbody#tbodySalesSplit").on("keydown", "input", oppSalesPlanEvent.keydownEnterReturn);
		},
		
		off : function(){
			
			//책임자 자동 완성
			$("tbody#tbodySalesSplit").off("focus", "input[name='textSalesSplit']", oppSalesPlanEvent.focusSalesSplit);	
			
			$("tbody#tbodySalesPlan ,tbody#tbodySalesSplit").off("keydown", "input", oppSalesPlanEvent.keydownEnterReturn);
		},
		
		focusSalesSplit : function(e){
			if($(this).attr("auto-bind") == "0"){
				commonSearch.singleMember2($(this),null);
				$(this).attr("auto-bind","1");
			}
		},
		
		keydownEnterReturn : function(e){
			var inputList = [
					'textModalSDate',
					'textModalCDate',
					'amount_r',
					'amount_g',
					'textSalesSplit',
					'textModalSplitDate',
					'split_r',
					'split_g'
				];
			
			if(inputList.indexOf(e.target.name) != -1){
				//키가 13이면 실행 (엔터는 13)
				if(e.keyCode == 13) return false;
			}
		}
}

var oppSalesPlan = {
		init : function(){
			
		},
		
		salesPlanHtml : null,
		salesSplitHtml : null,
		
		salesPlanList : null,
		
		//매출/수금 계획추가
		add : function(map){
			  $('#tbodySalesPlan').append(oppSalesPlan.salesPlanHtml);
		},
		
		setData : function(map){
			var idx = $('tr[name="revTr"]').length - 1; 
			$('input[name="textModalSDate"]').eq(idx).val(map.BASIS_MONTH);
   			$('input[name="textModalCDate"]').eq(idx).val(map.BASIS_MONTH_C);
   			$('input[name="amount_r"]').eq(idx).val(add_comma(map.BASIS_PLAN_REVENUE_AMOUNT.toString()));
			$('input[name="amount_g"]').eq(idx).val(add_comma(map.BASIS_PLAN_GP_AMOUNT.toString()));
			$('span[name="amount_a_r"]').eq(idx).html(add_comma(map.ERP_REV.toString()));
			$('span[name="amount_a_g"]').eq(idx).html(add_comma(map.ERP_GP.toString()));
			$('input[name="amount_id"]').eq(idx).val(map.AMOUNT_ID);
		},
		
		del : function(obj){
			/* var amount_id = $(obj).next("input[name="amount_id"]");
			if(amount_id){
				
			} */
			$(obj).parent("td").parent("tr[name='revTr']").remove();
			oppSalesPlan.sum();
		},
		
		addCb : function(basisMonth){
			oppSalesPlan.sum();
		},
			
		reset : function(){
			$('tr[name="revTr"]').remove();
			$('span#totalPlanRev, span#totalPlanGp').text(0);
			$('span#totalActRev, span#totalActGp').text(0);
		},
		
		zero : function(obj) {
			if(obj.value=="0") obj.value="";
			oppSalesPlan.sum();
		},
		
		blur : function(obj){
			if(isEmpty(obj.value)) obj.value=0;
			oppSalesPlan.sum();
		},
		
		//분기 계산 - 신규등록시		
		quarter : function(){
			//$('th[name="quarterDy"]').remove();
			/* var currentQuarter;
			var contractDate;
			oppSalesPlan.monthArr = [];
			
			if(isEmpty($("#textModalContractDate").val())){
				contractDate = commonDate.year+"-"+commonDate.month+"-"+commonDate.day;
				currentQuarter = commonDate.quarter(commonDate.month);	
			}else{
				contractDate = $("#textModalContractDate").val();
				currentQuarter = commonDate.quarter(moment(contractDate).format("MM"));
			}
			
			var cQuarter = currentQuarter;
			var cYear= parseInt(moment(contractDate).format("YYYY"));
			
			for(var i=0; i<8; i++){
				if(cQuarter > 4){
					cQuarter = 1;
					cYear++;
				}
				$("span[name='quarterDy']").eq(i).html(cYear+" / "+cQuarter+"Q");
				switch (cQuarter) {
				case 1:	 
					oppSalesPlan.monthArr.push(cYear+"-"+"01"+"-"+"01");
					break;
				case 2: "04"
					oppSalesPlan.monthArr.push(cYear+"-"+"04"+"-"+"01");
					break;
				case 3: "07"
					oppSalesPlan.monthArr.push(cYear+"-"+"07"+"-"+"01");
					break;
				case 4: "10"
					oppSalesPlan.monthArr.push(cYear+"-"+"10"+"-"+"01");
					break;
				}
				cQuarter++;
			} */
		},
		
		// 분기 계산 - 수정시
		quarterUpdate : function(basis_month, idx){
		},
		
		//금액 입력 계산
		calSalesPlan : function(){
			oppSalesPlan.salesPlanList = new Array();
			$('tr[name="revTr"]').each(function(idx, val){
				var salesPlanData = new Object() ;
				salesPlanData.amount_r = uncomma($("input[name='amount_r']").eq(idx).val())
				salesPlanData.amount_g = uncomma($("input[name='amount_g']").eq(idx).val())
				salesPlanData.basisMonth_s = $("input[name='textModalSDate']").eq(idx).val(); //매출계힉일
				salesPlanData.basisMonth_c = $("input[name='textModalCDate']").eq(idx).val(); //수금계획일
				oppSalesPlan.salesPlanList.push(salesPlanData);
			});
		},
		
		//합계
		sum : function(){
			var revTotal = 0,  revAtotal = 0; 
			var gpTotal = 0,  gpAtotal = 0;
			
			$('tr[name="revTr"]').each(function(idx, val){
				revTotal += parseInt(uncomma($("input[name='amount_r']").eq(idx).val()));
				gpTotal += parseInt(uncomma($("input[name='amount_g']").eq(idx).val()));
				
				revAtotal += parseInt(uncomma($("span[name='amount_a_r']").eq(idx).html()));
				gpAtotal += parseInt(uncomma($("span[name='amount_a_g']").eq(idx).html()));
			});
			
			$("#totalPlanRev").html(add_comma(revTotal.toString()));
			$("#totalPlanGp").html(add_comma(gpTotal.toString()));
			
			$("#totalActRev").html(add_comma(revAtotal.toString()));
			$("#totalActGp").html(add_comma(gpAtotal.toString()));
		}
		
}


var oppSalesSplit = {
		salesSplitList : null,
		
		getList : function(){
			oppSalesSplit.salesSplitList = new Array();
			$('tbody#tbodySalesSplit tr').each(function(idx, val){
				if($(this).find("input[name='hiddenSalesSplitId']").val()){ //영업대표를 입력한 데이터만
					var salesSplitData = new Object() ;
					salesSplitData.member_id_num = $(this).find("input[name='hiddenSalesSplitId']").val(); //스플릿 ID
					salesSplitData.split_date = $(this).find("input[name='textModalSplitDate']").val(); //스플릿 Date
					salesSplitData.split_r = parseInt(uncomma($(this).find("input[name='split_r']").val())); //스플릿 Date
					salesSplitData.split_g = parseInt(uncomma($(this).find("input[name='split_g']").val())); //스플릿 Date
					oppSalesSplit.salesSplitList.push(salesSplitData);	
				}
			});
		},
		
		
		//스플릿 추가
		add : function(map){
			$('#tbodySalesSplit').append(oppSalesPlan.salesSplitHtml);
		},
		
		setData : function(map){
			var idx = $('tbody#tbodySalesSplit').find('tr').length - 1; 
			$('tbody#tbodySalesSplit input[name="hiddenSalesSplitId"]').eq(idx).val(map.MEMBER_ID_NUM);
			$("tbody#tbodySalesSplit input[name='hiddenSalesSplitName']").eq(idx).val(map.HAN_NAME);
			if(map.MEMBER_ID_NUM){
				$("input[name='textSalesSplit']").eq(idx).hide();
				$("tbody#tbodySalesSplit li[name='liSalesSplitSeach']").eq(idx).before(
						'<li class="value">'+
						'<span class="txt" id="'+ map.MEMBER_ID_NUM +'">'+ map.HAN_NAME +' ['+ map.POSITION_STATUS +']</span>'+
						'<a href="#" class="remove" onclick="commonSearch.removeSingleMember2(this,null);">'+
						'<i class="fa fa-times-circle"></i></a>'+
						'</li>'
				);
			}else{
				$("input[name='textSalesSplit']").eq(idx).show();
			}
   			$('tbody#tbodySalesSplit input[name="textModalSplitDate"]').eq(idx).val(map.SPLIT_DATE);
   			$('tbody#tbodySalesSplit input[name="split_r"]').eq(idx).val(add_comma(map.SPLIT_REV.toString()));
   			$('tbody#tbodySalesSplit input[name="split_g"]').eq(idx).val(add_comma(map.SPLIT_GP.toString()));
			$('tbody#tbodySalesSplit input[name="split_id"]').eq(idx).val(map.SPLIT_ID);
		},
		
		reset : function(){
			$('tbody#tbodySalesSplit').find('tr').remove();
		},
			
		del : function(obj){
			$(obj).parent("td").parent("tr").remove();
		}
		
		
}
</script>