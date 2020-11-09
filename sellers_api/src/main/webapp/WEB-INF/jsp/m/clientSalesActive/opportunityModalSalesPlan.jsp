 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
$(document).ready(function(){
	$.get("/ajaxHtml/mobileOpportunitySalesPlan.html", function(data){
	    oppSalesPlan.salesPlanHtml = data;
	});
	oppSalesPlanEvent.on();
	/* $.get("/ajaxHtml/opportunitySalesSplit.html", function(data){
	    oppSalesPlan.salesSplitHtml = data; 
	}); */
});

var oppSalesPlanEvent = {
		on : function(){
			//책임자 자동 완성
			$("tbody#tbodySalesSplit").on("focus", "input[name='textSalesSplit']", oppSalesPlanEvent.focusSalesSplit);	
			
			$("tbodyul#salesPlan ,tbody#tbodySalesSplit").on("keydown", "input", oppSalesPlanEvent.keydownEnterReturn);
		},
		
		off : function(){
			
			//책임자 자동 완성
			$("tbody#tbodySalesSplit").off("focus", "input[name='textSalesSplit']", oppSalesPlanEvent.focusSalesSplit);	
			
			$("tbodyul#salesPlan ,tbody#tbodySalesSplit").off("keydown", "input", oppSalesPlanEvent.keydownEnterReturn);
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
			  $('ul#salesPlan').append(oppSalesPlan.salesPlanHtml);
		},
		
		setData : function(map){
			var idx = $('li[name="salesPlan_sub"]').length - 1; 
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
			$(obj).parent("li[name='salesPlan_sub']").remove();
			//oppSalesPlan.sum();
		},
		
		addCb : function(basisMonth){
			oppSalesPlan.sum();
		},
			
		reset : function(){
			$('li[name="salesPlan_sub"]').remove();
			$('span#totalPlanRev, span#totalPlanGp').text(0);
			$('span#totalActRev, span#totalActGp').text(0);
		},
		
		zero : function(obj) {
			if(obj.value=="0") obj.value="";
			//oppSalesPlan.sum();
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
			$('li[name="salesPlan_sub"]').each(function(idx, val){
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
			
			$('li[name="salesPlan_sub"]').each(function(idx, val){
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

</script>

	<ul id="salesPlan">
		<li name="salesPlan_sub">
			<div class="h_line"></div>
			<div class="form_input mg_b10">
			<a href="javascript:void(0);" class="icon_delete fl_r mg_b10 mg_t10" onclick="oppSalesPlan.del(this);">삭제</a>
			</div>
			
			<div class="form_input mg_b10">
				<label>매출계획일<span style="color:red;">*</span></label>
				<input type="date" placeholder="ex)1988-11-18" class="form_control" name="textModalSDate" style="text-indent:5px;"/>
			</div>
			
			<div class="form_input mg_b10">
				<label>수금계획일</label>
				<input type="date" placeholder="ex)1988-11-18" class="form_control" name="textModalCDate" style="text-indent:5px;"/>
			</div>
			
			<div class="form_input mg_b10">
				<label>P.REV(예상매출)</label>
				<input type="text" class="form-control" name="amount_r" onclick="oppSalesPlan.zero(this);" onblur="oppSalesPlan.blur(this);" onkeyup="comma(this);" value="0" style="text-align:right;">
			</div>
			
			<div class="form_input mg_b10">
				<label>P.GP(예상이익)</label>
				<input type="text" class="form-control" name="amount_g" onclick="oppSalesPlan.zero(this);" onblur="oppSalesPlan.blur(this);" onkeyup="comma(this);" value="0" style="text-align:right;">
			</div>
			<input type="hidden" name="amount_id" />		
			<div class="h_line mg_b10"></div>
		</li>
	</ul>
		