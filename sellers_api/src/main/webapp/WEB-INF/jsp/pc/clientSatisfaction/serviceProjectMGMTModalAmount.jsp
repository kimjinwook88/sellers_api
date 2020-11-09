<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="form-group"><label class="col-sm-2 control-label">계약 금액 및<br/>예상 매출</label>
  <div class="col-sm-10">
    <div class="col-sm-6">
    	<label class="font-noraml">주기 선택</label>
        <div class="select-com"><!-- <label>항목선택</label> --> 
        <select class="form-control" name="selectModalContractAmount" id="selectModalContractAmount" disabled="disabled" onchange="modalAmount.setting('Contract');">
        	<option value="">====선택====</option>
            <option value="m">월별</option>
	        <option value="q">분기별</option>
        </select></div>
    </div>
    <div class="col-sm-6">
   		<label class="font-noraml">전체 계약금액 (화폐단위: 원)</label>
        <input type="text" value="시작, 종료일를 선택해 주세요." name="textModalTotalContractAmount" id="textModalTotalContractAmount" onClick="modalAmount.zero(this)" onblur="modalAmount.calculation(this)" OnKeyUp="comma(this)" class="form-control" disabled="disabled"/><br/>
    </div>
    <div class="col-sm-12" id="divModalContractAmount">
        <div class="progress-cutom">
           <!--  월별 보기의 경우에만 아래의 더 보기 버튼이 노촐 됨 -->
            <!-- <div class="cboth"><a class="btn-more">더보기</a></div> -->
        </div>
        <!-- <p class="pd-t5">* 금액은 해당 란을 선택하시면 바로 수정이 가능합니다.</p> -->
    </div>
    <div class="col-sm-13" id="divModalContractAmountRe" style="display: none">
	    <div class="col-sm-6">
	        <label class="font-noraml">차액 (화폐단위: 원)</label>
	        <input type="text" name="textModalContractAmountRemainder" id="textModalContractAmountRemainder" OnKeyUp="comma(this)" class="form-control paynot" value="0" /><br/>
	    </div>
	    <div class="col-sm-6">
	        <label class="font-noraml">Plan vs Actual (화폐단위: 원)</label>
	        <input type="text" name="textModalContractAmountResult" id="textModalContractAmountResult" OnKeyUp="comma(this)" class="form-control" value="0" /><br/>
	    </div>
    </div>
  </div>
</div>
<input type="hidden" name="hiddenModalContractDate" id="hiddenModalContractDate" value=""/>
<input type="hidden" name="hiddenModalContractPlanAmount" id="hiddenModalContractPlanAmount" value=""/>
<input type="hidden" name="hiddenModalContractActualAmount" id="hiddenModalContractActualAmount" value=""/>

<script type="text/javascript">
var modalAmount = {
		total : 0,
		cnt : 0,
		disable : function() {
			if($("#textModalStartDate").val()!="" && $("#textModalEndDate").val()!="") {
				$("#textModalTotalContractAmount").attr("disabled", false);
				$("#textModalTotalContractAmount").val("0");
				$("#selectModalContractAmount").attr("disabled", false);
				$("#divModalContractAmountRe").css("display", "");
				if($("#selectModalContractAmount").val()=="") $("#selectModalContractAmount").val("m");
				modalAmount.setting();
			}else {
				$("#textModalTotalContractAmount").attr("disabled", true);
				$("#textModalTotalContractAmount").val("시작, 종료일를 선택해 주세요.");
				$("#selectModalContractAmount").attr("disabled", true);
				$("#selectModalContractAmount").val("");
				$("#divModalContractAmountRe").css("display", "none");
				$("#divModalContractAmount .progress-cutom").append('');
			}
		},
		
		zero : function(pay) {
			if(pay.value=="0") pay.value="";
			
		},
		
		setting : function() {
			var today = moment(new Date());
			if($("#selectModalContractAmount").val()=="m") {//월별
				var startDate = $("#textModalStartDate").val();
				var endDate = $("#textModalEndDate").val();
				var mStart = moment(startDate);
				var mEnd = moment(endDate);
				var monthDiff = modalAmount.monthDiff(new Date(mStart),new Date(mEnd)); 
				var startQuarter = modalAmount.getQuarter(mStart.format('MM'));
				modalAmount.cnt = monthDiff+1;
				var monthView = mStart;
				var monthArr = [];
				$("#textModalTotalContractAmount").attr("disabled", false);
				$("#textModalTotalContractAmount").val("0");
				$("#divModalContractAmount .progress-cutom").html('');
				$("#divModalhiddenContractDate").html('');
				$("#divModalhiddenContractPlanAmount").html('');
				$("#divModalhiddenContractActualAmount").html('');
				for(var i=0; i<=monthDiff; i++){
				 	$("#divModalContractAmount .progress-cutom").append('<div class="progress-step" name="'+monthView.format('YYYY')+"년"+monthView.format('MM')+"월"+'"><span class="ti">'+
						 	monthView.format('YYYY')+"년"+monthView.format('MM')+"월"+'</span><div class="paybox">'+
						 	'<div class="hgrid plan"><span class="dt">Plan</span><input type="text" class="pay" name="textModalContractPlanAmount" id="textModalContractPlanAmount'+i+'" onClick="modalAmount.zero(this)" onblur="modalAmount.calculation(this)" OnKeyUp="comma(this)" value="0"/></div><div class="hgrid actual">'+
						 	'<span class="dt">Actual</span><input type="text" class="pay" name="textModalContractActualAmount" id="textModalContractActualAmount'+i+'" onClick="modalAmount.zero(this)" onblur="modalAmount.calculation(this)" OnKeyUp="comma(this)" value="0"/></div></div><div class="point"></div></div>');
				 	
				 	/* $("#divModalhiddenContractDate").append('<input type="hidden" name="hiddenModalContractDate[]" id="hiddenModalContractDate'+i+'">');
				 	$("#hiddenModalContractDate"+i).val(monthView.format('YYYY')+"-"+monthView.format('MM'));
				 	$("#divModalhiddenContractPlanAmount").append('<input type="hidden" name="hiddenModalContractPlanAmount[]" id="hiddenModalContractPlanAmount'+i+'">');
				 	$("#divModalhiddenContractActualAmount").append('<input type="hidden" name="hiddenModalContractActualAmount[]" id="hiddenModalContractActualAmount'+i+'">'); */
				 	monthArr.push(monthView.format('YYYY')+"-"+monthView.format('MM'));
				 	monthView = monthView.add('months', 1);
				}
				$("#hiddenModalContractDate").val(monthArr.toString());
				$('div[class="progress-step"][name="'+today.format('YYYY')+"년"+today.format('MM')+"월"+'"]').attr('class', 'progress-step current-point');
			}else if($("#selectModalContractAmount").val()=="q") {//분기별
				var startDate = $("#textModalStartDate").val();
				var endDate = $("#textModalEndDate").val();
				var mStart = moment(startDate);
				var mEnd = moment(endDate);
				var quarterView = moment(startDate);
				var monthDiff = modalAmount.monthDiff(new Date(mStart),new Date(mEnd)); 
				var startQuarter = modalAmount.getQuarter(mStart.format('MM'));
				var mEndQuarter = modalAmount.getQuarter(mEnd.format('MM'));
				var compareEndDate = mEnd.add('months', (mEndQuarter*3) - moment(endDate).format("M")); 
				var quarterArr = [];
				$("#textModalTotalContractAmount").attr("disabled", false);
				$("#textModalTotalContractAmount").val("0");
				$("#divModalContractAmount .progress-cutom").html('');
				$("#divModalhiddenContractDate").html('');
				$("#divModalhiddenContractPlanAmount").html('');
				$("#divModalhiddenContractActualAmount").html('');
				var i = 0;
				while(quarterView.format("YYYY-MM") <= compareEndDate.format("YYYY-MM")){
					if(startQuarter > 4) startQuarter = 1;
				 	$("#divModalContractAmount .progress-cutom").append('<div class="progress-step" name="'+quarterView.format('YYYY')+"년"+startQuarter+"분기"+'"><span class="ti">'+
							quarterView.format('YYYY')+"년"+startQuarter+"분기"+'</span><div class="paybox">'+
						 	'<div class="hgrid plan"><span class="dt">Plan</span><input type="text" class="pay" name="textModalContractPlanAmount" id="textModalContractPlanAmount'+i+'" onClick="modalAmount.zero(this)" onblur="modalAmount.calculation(this)" OnKeyUp="comma(this)" value="0"/></div><div class="hgrid actual">'+
						 	'<span class="dt">Actual</span><input type="text" class="pay" name="textModalContractActualAmount" id="textModalContractActualAmount'+i+'" onClick="modalAmount.zero(this)" onblur="modalAmount.calculation(this)" OnKeyUp="comma(this)" value="0"/></div></div><div class="point"></div></div>');
					
					/* $("#divModalhiddenContractDate").append('<input type="hidden" name="hiddenModalContractDate" id="hiddenModal[]ContractDate'+i+'">');
				 	$("#divModalhiddenContractPlanAmount").append('<input type="hidden" name="hiddenModalContractPlanAmount" id="hiddenModal[]ContractPlanAmount'+i+'">');
				 	$("#divModalhiddenContractActualAmount").append('<input type="hidden" name="hiddenModalContractActualAmount" id="hiddenModal[]ContractActualAmount'+i+'">');  */
					
					if(quarterView.format("YYYY-MM") < compareEndDate.format("YYYY-MM")) {
						//console.log(quarterView.format("YYYY-MM"));
						//$("#hiddenModalContractDate"+i).val(quarterView.format('YYYY')+"-"+quarterView.format('MM'));
						quarterArr.push(quarterView.format('YYYY')+"-"+quarterView.format('MM'));
					}else {
						if(parseInt(quarterView.format("MM"))<4) {
							//$("#hiddenModalContractDate"+i).val(quarterView.format('YYYY')+"-01");
							quarterArr.push(quarterView.format('YYYY')+"-01");
						}else if(parseInt(quarterView.format("MM"))<7) {
							//$("#hiddenModalContractDate"+i).val(quarterView.format('YYYY')+"-04");
							quarterArr.push(quarterView.format('YYYY')+"-04");
						}else if(parseInt(quarterView.format("MM"))<10) {
							//$("#hiddenModalContractDate"+i).val(quarterView.format('YYYY')+"-07");
							quarterArr.push(quarterView.format('YYYY')+"-07");
						}else {
							//$("#hiddenModalContractDate"+i).val(quarterView.format('YYYY')+"-10");
							quarterArr.push(quarterView.format('YYYY')+"-10");
						}
					}
				 	$("#hiddenModalContractDate").val(quarterArr.toString());
					startQuarter++;
					i++;
					quarterView = quarterView.add('months', 3);
				}
				modalAmount.cnt = i;
				$('div[class="progress-step"][name="'+today.format('YYYY')+"년"+modalAmount.getQuarter(today.format('MM'))+"분기"+'"]').attr('class', 'progress-step current-point');
			}else {
				$("#hiddenModalContractDate").val('');
				$("#divModalContractAmount .progress-cutom").html('');
				$("#divModalhiddenContractDate").html('');
				$("#divModalhiddenContractPlanAmount").html('');
				$("#divModalhiddenContractActualAmount").html('');
				$("#divModalContractAmountRe").css("display", "none");
				$("#textModalTotalContractAmount").attr("disabled", true);
				$("#textModalTotalContractAmount").val("주기를 선택해 주세요.");
			}
		},
		
		//금액 계산
		calculation : function(pay) {
			if(pay.value=="" || pay.value=="undefined") pay.value="0";
			else {
				if(pay.id=="textModalTotalContractAmount") {
					modalAmount.total = parseInt(uncomma(pay.value));
					var avg = Math.floor(modalAmount.total/modalAmount.cnt/1000)*1000;
					var remainder = modalAmount.total -  avg*(modalAmount.cnt - 1);
					
					for(var i=0; i<modalAmount.cnt-1; i++) {
						$("#textModal"+what+"PlanAmount"+i).val(String(avg).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
						$('#hiddenModal'+what+'PlanAmount'+i).val($("#textModal"+what+"PlanAmount"+i).val());
					}
					$("#textModal"+what+"PlanAmount"+i).val(String(remainder).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
					$('#hiddenModal'+what+'PlanAmount'+i).val($("#textModal"+what+"PlanAmount"+i).val());
					$("#textModal"+what+"AmountRemainder").val(modalAmount.total-(avg*i+remainder));
				}else if(pay.id.substring(0, pay.id.lastIndexOf("t")+1)=="textModalContractPlanAmount") {
					var sumPlan = 0;
					for(var i=0; i<modalAmount.cnt; i++) {
						sumPlan += parseInt(uncomma($("#textModalContractPlanAmount"+i).val()));
					}
					var result =  uncomma($("#textModalTotalContractAmount").val())-sumPlan;
					if(result <= 0) {
						$("#textModalContractAmountRemainder").val(String(result).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
					}else {
						$("#textModalContractAmountRemainder").val("+"+String(result).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
					}
				}else if(pay.id.substring(0, pay.id.lastIndexOf("t")+1)=="textModalContractActualAmount") {
					var today = moment(new Date());
					
					moment(new Date());
					var sumPlan = 0;
					var sumActual = 0;
					if($("#selectModalContractAmount").val()=="m") {
						today = today.format('YYYY')+"년"+today.format('MM')+"월";
					}else if($("#selectModalContractAmount").val()=="q") {
						today = today.format('YYYY')+"년"+modalAmount.getQuarter(today.format('MM'))+"분기";
					}
					for(var i=0; i<modalAmount.cnt; i++) {
						sumPlan += parseInt(uncomma($("#textModalContractPlanAmount"+i).val()));
						sumActual += parseInt(uncomma($("#textModalContractActualAmount"+i).val()));
						if($("#textModalContractActualAmount"+i).attr("name")==today) break;
					}
					var result = sumActual-sumPlan;
					if(result <= 0) {
						$("#textModalContractAmountResult").val(String(result).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
					}else {
						$("#textModalContractAmountResult").val("+"+String(result).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
					}
				}
			}
		},
		
		//month차이 
		monthDiff : function(d1,d2){
		    var monthsDiff;
		    monthsDiff = (d2.getFullYear() - d1.getFullYear()) * 12;
		    monthsDiff -= d1.getMonth() + 1;
		    monthsDiff += d2.getMonth();
		    monthsDiff ++;
		    return monthsDiff <= 0 ? 0 : monthsDiff;
		},
		
		//month+1
		getQuarter : function(month) {
			  return Math.ceil( month / 3 );
		}

}
</script>