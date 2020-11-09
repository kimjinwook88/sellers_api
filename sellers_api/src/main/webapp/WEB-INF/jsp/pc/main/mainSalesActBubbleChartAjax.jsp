<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<%-- <c:choose>
	<c:when test="${fn:length(salesActList) > 0}">
		<c:forEach items="${salesActList}" var="items">
		
		</c:forEach>
	</c:when>
<c:choose> --%>

<div class="col-sm-12" id="divChart" style="width:99.99%;">
	<div class="ibox">
		<div class="ibox-title landing-header">
            <h5>영업기회 현황</h5>
            <!-- <div class="func-area_bg func-top-left fl_l" style="position: absolute; z-index: 100;"> -->
            <div class="pull-right day-nav" style="position: absolute; z-index: 100;">
				<div class="selgrid">
					<div class="fl_l mg-r10">
						<button class="btn btn-white btn-move" onclick="bubbleChart.naviPrevDate();"><i class="fa fa-arrow-left"></i></button>
						<strong class="term-txt" id="bubbleChartStrongDate">2018년 4분기</strong>
						<button class="btn btn-white btn-move" onclick="bubbleChart.naviNextDate();"><i class="fa fa-arrow-right"></i></button>
				    </div>
				    
				</div>
				<div class="fl_l pd-t3">
			        <label for="termBubbleChart1" class="mg-r10">
			            <input type="radio" id="termBubbleChart1" name="radioViewTypeBubbleChart" value="m" class=""> <span class="">월</span>
			        </label>
			        <label for="termBubbleChart2" class="mg-r10">
			            <input type="radio" id="termBubbleChart2" name="radioViewTypeBubbleChart" value="q" class=""> <span class="">분기</span>
			        </label>
			        <label for="termBubbleChart3">
			            <input type="radio" id="termBubbleChart3" name="radioViewTypeBubbleChart" value="y" checked="true" class=""> <span class="">년도</span>
			        </label>
			    </div>
			</div>
        </div>
        
		<div class="ibox-content border_n">
			<div class="clear">
				<div class="google_chart">
					<div class="pop_googleChart_tooltip" id="custom_tooltip" style="display: none;"></div>
				</div>
				<div id="oppData">
					<ul id="chart_div" style="width: 100%; height: 360px;"></ul>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(document).ready(function(){
	bubbleChart.init();
});

var bubbleChart = {
		data : {
			searchDateCategory : null,
			searchStartDate : null,
			searchEndDate : null,
			cdFlag : true, //년도 이동인지 체크 값
			beforeDate : null
		},
		
		arrayData : {
			jan : [],
			feb : [],
			march : [],
			april : [],
			may : [],
			june : [],
			july : [],
			aug : [],
			sep : [],
			oct : [],
			nov : [],
			dec : []
		},
		
		date : function() {
			bubbleChart.data.searchStartDate = moment().format('YYYY-MM-DD');
			bubbleChart.data.searchDateCategory = $("input[name='radioViewTypeBubbleChart']:checked").val();
			var dateMap = commonDate.naviDate(bubbleChart.data.searchDateCategory, bubbleChart.data.searchStartDate, 0);
			bubbleChart.data.searchStartDate = dateMap.startDate;
			bubbleChart.data.searchEndDate = dateMap.endDate;
			
			bubbleChart.naviSetDate(dateMap);
		},
		
		init : function(){
			bubbleChart.date();
			
			$("input[name='radioViewTypeBubbleChart']").on('change',function(){
				if(isEmpty(bubbleChart.data.searchStartDate)){
					bubbleChart.data.searchStartDate = moment().format('YYYY-MM-DD');
					bubbleChart.data.beforeDate = bubbleChart.data.searchStartDate;
				}
				var dateMap = commonDate.naviDate($(this).val(), bubbleChart.data.searchStartDate, 0);
				bubbleChart.data.searchDateCategory = $(this).val();
				bubbleChart.naviSetDate(dateMap); 
			});
			
		},
		
		naviSetDate : function(dateMap){
			if(isEmpty(bubbleChart.data.beforeDate)){
				bubbleChart.data.beforeDate = dateMap.startDate;
				bubbleChart.data.cdFlag = false;
			}else{
				if((bubbleChart.data.beforeDate).substring(0,4) == (dateMap.startDate).substring(0,4)){
					bubbleChart.data.cdFlag = true;
				}else{
					bubbleChart.data.beforeDate = dateMap.startDate;
					bubbleChart.data.cdFlag = false;
				}
			}
			bubbleChart.data.searchStartDate = dateMap.startDate; 
			bubbleChart.data.searchEndDate = dateMap.endDate;
			$("strong#bubbleChartStrongDate").html(dateMap.showDate);
			
			bubbleChart.get(bubbleChart.data.cdFlag);
		},
		
		naviPrevDate : function() {
			var dateMap = commonDate.naviDate(bubbleChart.data.searchDateCategory, bubbleChart.data.searchEndDate, -1);
			bubbleChart.naviSetDate(dateMap);
		},
		
		//분기 다음 버튼
		naviNextDate : function() {
			var dateMap = commonDate.naviDate(bubbleChart.data.searchDateCategory, bubbleChart.data.searchEndDate, 1);
			bubbleChart.naviSetDate(dateMap);
		},
		
		getParams : function(){
			var params = $.param({
				datatype : 'json',
				jsp : '/main/mainSalesActBubbleChartAjax',
				searchDate : bubbleChart.data.searchStartDate,
				searchType : $("input[name='radioViewTypeBubbleChart']:checked").val(),//월 m 분기q 년y
			});
			return params;
		},
		
		get : function(cdflag){
			if(!cdflag){
				$.ajax({
					url : "/main/selectSalesActBubbleChart.do",
					async : false,
		 			datatype : 'json',
		 			method: 'POST',
		 			data : bubbleChart.getParams(),
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoading();
					},
					success : function(data){
						var list = data.salesActList;
						
						//배열 초기화
						bubbleChart.arrayData.jan = [];
						bubbleChart.arrayData.feb = [];
						bubbleChart.arrayData.march = [];
						bubbleChart.arrayData.april = [];
						bubbleChart.arrayData.may = [];
						bubbleChart.arrayData.june = [];
						bubbleChart.arrayData.july = [];
						bubbleChart.arrayData.aug = [];
						bubbleChart.arrayData.sep = [];
						bubbleChart.arrayData.oct = [];
						bubbleChart.arrayData.nov = [];
						bubbleChart.arrayData.dec = [];
						
						if(list.length > 0){
							googleChart.load(drawChartWithJson);
							
							function drawChartWithJson(){
								var columns = [
									{id:'END_USER', label:'고객사', type: 'string'},
									{id:'CONTRACT_DATE', label:'계약일', type: 'date'},
									{id:'ROUND_CONTRACT_AMOUNT', label:'계약금액', type: 'number'},
									{id:'CATEGORY', label:'CATEGORY', type: 'string'},
									{id:'WinRate', label:'WinRate', type: 'number'},
									{id:'OPPORTUNITY_ID', label:'OPPORTUNITY_ID', type: 'number'},
									{id:'CUSTOMER_ID', label:'END_USER_ID', type: 'number'},
									{id:'IDENTIFIER_NAME', label:'IDENTIFIER_NAME', type: 'string'},
									{id:'SUBJECT', label:'SUBJECT', type: 'string'},
									{id:'CONTRACT_AMOUNT', label:'CONTRACT_AMOUNT', type: 'number'}
								];
								
								var chartData = [];
								var dataArr = [];
								
								if(data){
									for(var i=0; i<list.length; i++){
										for(var j=0; j<list[i].length; j++){
											dataArr = [];
											if(i == 0){
												dataArr.push(list[i][j].END_USER);
												dataArr.push(list[i][j].CONTRACT_DATE);
												dataArr.push(list[i][j].ROUND_CONTRACT_AMOUNT);
												dataArr.push(list[i][j].OPPORTUNITY_ID);
												dataArr.push(list[i][j].CUSTOMER_ID);
												dataArr.push(list[i][j].IDENTIFIER_NAME);
												dataArr.push(list[i][j].SUBJECT);
												dataArr.push((list[i][j].CATEGORY).replace(/\사업본부/g,""));
												dataArr.push(list[i][j].CONTRACT_AMOUNT);
												bubbleChart.arrayData.jan.push(dataArr);
											}else if(i == 1){
												dataArr.push(list[i][j].END_USER);
												dataArr.push(list[i][j].CONTRACT_DATE);
												dataArr.push(list[i][j].ROUND_CONTRACT_AMOUNT);
												dataArr.push(list[i][j].OPPORTUNITY_ID);
												dataArr.push(list[i][j].CUSTOMER_ID);
												dataArr.push(list[i][j].IDENTIFIER_NAME);
												dataArr.push(list[i][j].SUBJECT);
												dataArr.push((list[i][j].CATEGORY).replace(/\사업본부/g,""));
												dataArr.push(list[i][j].CONTRACT_AMOUNT);
												bubbleChart.arrayData.feb.push(dataArr);
											}else if(i == 2){
												dataArr.push(list[i][j].END_USER);
												dataArr.push(list[i][j].CONTRACT_DATE);
												dataArr.push(list[i][j].ROUND_CONTRACT_AMOUNT);
												dataArr.push(list[i][j].OPPORTUNITY_ID);
												dataArr.push(list[i][j].CUSTOMER_ID);
												dataArr.push(list[i][j].IDENTIFIER_NAME);
												dataArr.push(list[i][j].SUBJECT);
												dataArr.push((list[i][j].CATEGORY).replace(/\사업본부/g,""));
												dataArr.push(list[i][j].CONTRACT_AMOUNT);
												bubbleChart.arrayData.march.push(dataArr);
											}else if(i == 3){
												dataArr.push(list[i][j].END_USER);
												dataArr.push(list[i][j].CONTRACT_DATE);
												dataArr.push(list[i][j].ROUND_CONTRACT_AMOUNT);
												dataArr.push(list[i][j].OPPORTUNITY_ID);
												dataArr.push(list[i][j].CUSTOMER_ID);
												dataArr.push(list[i][j].IDENTIFIER_NAME);
												dataArr.push(list[i][j].SUBJECT);
												dataArr.push((list[i][j].CATEGORY).replace(/\사업본부/g,""));
												dataArr.push(list[i][j].CONTRACT_AMOUNT);
												bubbleChart.arrayData.april.push(dataArr);
											}else if(i == 4){
												dataArr.push(list[i][j].END_USER);
												dataArr.push(list[i][j].CONTRACT_DATE);
												dataArr.push(list[i][j].ROUND_CONTRACT_AMOUNT);
												dataArr.push(list[i][j].OPPORTUNITY_ID);
												dataArr.push(list[i][j].CUSTOMER_ID);
												dataArr.push(list[i][j].IDENTIFIER_NAME);
												dataArr.push(list[i][j].SUBJECT);
												dataArr.push((list[i][j].CATEGORY).replace(/\사업본부/g,""));
												dataArr.push(list[i][j].CONTRACT_AMOUNT);
												bubbleChart.arrayData.may.push(dataArr);
											}else if(i == 5){
												dataArr.push(list[i][j].END_USER);
												dataArr.push(list[i][j].CONTRACT_DATE);
												dataArr.push(list[i][j].ROUND_CONTRACT_AMOUNT);
												dataArr.push(list[i][j].OPPORTUNITY_ID);
												dataArr.push(list[i][j].CUSTOMER_ID);
												dataArr.push(list[i][j].IDENTIFIER_NAME);
												dataArr.push(list[i][j].SUBJECT);
												dataArr.push((list[i][j].CATEGORY).replace(/\사업본부/g,""));
												dataArr.push(list[i][j].CONTRACT_AMOUNT);
												bubbleChart.arrayData.june.push(dataArr);
											}else if(i == 6){
												dataArr.push(list[i][j].END_USER);
												dataArr.push(list[i][j].CONTRACT_DATE);
												dataArr.push(list[i][j].ROUND_CONTRACT_AMOUNT);
												dataArr.push(list[i][j].OPPORTUNITY_ID);
												dataArr.push(list[i][j].CUSTOMER_ID);
												dataArr.push(list[i][j].IDENTIFIER_NAME);
												dataArr.push(list[i][j].SUBJECT);
												dataArr.push((list[i][j].CATEGORY).replace(/\사업본부/g,""));
												dataArr.push(list[i][j].CONTRACT_AMOUNT);
												bubbleChart.arrayData.july.push(dataArr);
											}else if(i == 7){
												dataArr.push(list[i][j].END_USER);
												dataArr.push(list[i][j].CONTRACT_DATE);
												dataArr.push(list[i][j].ROUND_CONTRACT_AMOUNT);
												dataArr.push(list[i][j].OPPORTUNITY_ID);
												dataArr.push(list[i][j].CUSTOMER_ID);
												dataArr.push(list[i][j].IDENTIFIER_NAME);
												dataArr.push(list[i][j].SUBJECT);
												dataArr.push((list[i][j].CATEGORY).replace(/\사업본부/g,""));
												dataArr.push(list[i][j].CONTRACT_AMOUNT);
												bubbleChart.arrayData.aug.push(dataArr);
											}else if(i == 8){
												dataArr.push(list[i][j].END_USER);
												dataArr.push(list[i][j].CONTRACT_DATE);
												dataArr.push(list[i][j].ROUND_CONTRACT_AMOUNT);
												dataArr.push(list[i][j].OPPORTUNITY_ID);
												dataArr.push(list[i][j].CUSTOMER_ID);
												dataArr.push(list[i][j].IDENTIFIER_NAME);
												dataArr.push(list[i][j].SUBJECT);
												dataArr.push((list[i][j].CATEGORY).replace(/\사업본부/g,""));
												dataArr.push(list[i][j].CONTRACT_AMOUNT);
												bubbleChart.arrayData.sep.push(dataArr);
											}else if(i == 9){
												dataArr.push(list[i][j].END_USER);
												dataArr.push(list[i][j].CONTRACT_DATE);
												dataArr.push(list[i][j].ROUND_CONTRACT_AMOUNT);
												dataArr.push(list[i][j].OPPORTUNITY_ID);
												dataArr.push(list[i][j].CUSTOMER_ID);
												dataArr.push(list[i][j].IDENTIFIER_NAME);
												dataArr.push(list[i][j].SUBJECT);
												dataArr.push((list[i][j].CATEGORY).replace(/\사업본부/g,""));
												dataArr.push(list[i][j].CONTRACT_AMOUNT);
												bubbleChart.arrayData.oct.push(dataArr);
											}else if(i == 10){
												dataArr.push(list[i][j].END_USER);
												dataArr.push(list[i][j].CONTRACT_DATE);
												dataArr.push(list[i][j].ROUND_CONTRACT_AMOUNT);
												dataArr.push(list[i][j].OPPORTUNITY_ID);
												dataArr.push(list[i][j].CUSTOMER_ID);
												dataArr.push(list[i][j].IDENTIFIER_NAME);
												dataArr.push(list[i][j].SUBJECT);
												dataArr.push((list[i][j].CATEGORY).replace(/\사업본부/g,""));
												dataArr.push(list[i][j].CONTRACT_AMOUNT);
												bubbleChart.arrayData.nov.push(dataArr);
											}else if(i == 11){
												dataArr.push(list[i][j].END_USER);
												dataArr.push(list[i][j].CONTRACT_DATE);
												dataArr.push(list[i][j].ROUND_CONTRACT_AMOUNT);
												dataArr.push(list[i][j].OPPORTUNITY_ID);
												dataArr.push(list[i][j].CUSTOMER_ID);
												dataArr.push(list[i][j].IDENTIFIER_NAME);
												dataArr.push(list[i][j].SUBJECT);
												dataArr.push((list[i][j].CATEGORY).replace(/\사업본부/g,""));
												dataArr.push(list[i][j].CONTRACT_AMOUNT);
												bubbleChart.arrayData.dec.push(dataArr);
											}
										}
									}
									
									chartData = bubbleChart.setData();
									var chart = new GoogleChart();
									
									chart.bubbleChart.options.isStacked = 'percent';
									chart.bubbleChart.draw(columns, chartData, 'chart_div', bubbleChart.data.searchDateCategory);
								}
							}
						}else{
							/* googleChart.load(drawChartWithJson);
							
							function drawChartWithJson(){
								var columns = [
									{id:'END_USER', label:'고객사', type: 'string'},
									{id:'CONTRACT_DATE', label:'계약일', type: 'date'},
									{id:'ROUND_CONTRACT_AMOUNT', label:'계약금액', type: 'number'},
									{id:'CATEGORY', label:'CATEGORY', type: 'string'},
									{id:'WinRate', label:'WinRate', type: 'number'},
									{id:'OPPORTUNITY_ID', label:'OPPORTUNITY_ID', type: 'number'},
									{id:'CUSTOMER_ID', label:'END_USER_ID', type: 'number'},
									{id:'IDENTIFIER_NAME', label:'IDENTIFIER_NAME', type: 'string'},
									{id:'SUBJECT', label:'SUBJECT', type: 'string'},
									{id:'CONTRACT_AMOUNT', label:'CONTRACT_AMOUNT', type: 'number'}
								];
								
								var chartData = [];
								var dataArr = [];
								
								chartData = bubbleChart.setData();
								var chart = new GoogleChart();
								
								chart.bubbleChart.options.isStacked = 'percent';
								chart.bubbleChart.draw(columns, chartData, 'chart_div', bubbleChart.data.searchDateCategory);
							} */
							$('#chart_div').html('<div style="text-align: center; padding-top: 160px; font-size: 40px;">데이터가 없습니다.</div>');
						}
					},
					complete : function(){
						//$.ajaxLoadingHide();
					}
				});
			}else{
				googleChart.load(drawChartWithJson);
				
				function drawChartWithJson(){
					var columns = [
						{id:'END_USER', label:'고객사', type: 'string'},
						{id:'CONTRACT_DATE', label:'계약일', type: 'date'},
						{id:'ROUND_CONTRACT_AMOUNT', label:'계약금액', type: 'number'},
						{id:'CATEGORY', label:'CATEGORY', type: 'string'},
						{id:'WinRate', label:'WinRate', type: 'number'},
						{id:'OPPORTUNITY_ID', label:'OPPORTUNITY_ID', type: 'number'},
						{id:'CUSTOMER_ID', label:'END_USER_ID', type: 'number'},
						{id:'IDENTIFIER_NAME', label:'IDENTIFIER_NAME', type: 'string'},
						{id:'SUBJECT', label:'SUBJECT', type: 'string'},
						{id:'CONTRACT_AMOUNT', label:'CONTRACT_AMOUNT', type: 'number'}
					];
					var chartData = [];
					
					chartData = bubbleChart.setData();
					var chart = new GoogleChart();
					
					chart.bubbleChart.options.isStacked = 'percent';
					chart.bubbleChart.draw(columns, chartData, 'chart_div', bubbleChart.data.searchDateCategory);
				}
			}
			
		},
		
		resetDummy : function(array) { //더미 데이터 초기화
			for(var i=0; i<bubbleChart.arrayData.jan.length; i++){
				if(isEmpty(bubbleChart.arrayData.jan[i][0])){
					bubbleChart.arrayData.jan.splice(i, 1);
				}
			}
		},
		
		setData : function() {
			var month = (bubbleChart.data.searchStartDate).substring(5,7);
			var rtData = null;
			if($("input[name='radioViewTypeBubbleChart']:checked").val() == 'y'){
				rtData = JSON.parse(JSON.stringify(bubbleChart.arrayData.jan.concat(bubbleChart.arrayData.feb, bubbleChart.arrayData.march, bubbleChart.arrayData.april, 
						bubbleChart.arrayData.may, bubbleChart.arrayData.june, bubbleChart.arrayData.july, bubbleChart.arrayData.aug, 
						bubbleChart.arrayData.sep, bubbleChart.arrayData.oct, bubbleChart.arrayData.nov, bubbleChart.arrayData.dec)));
				bubbleChart.resetDummy(bubbleChart.arrayData.jan); //더미 데이터 초기화
				bubbleChart.resetDummy(bubbleChart.arrayData.feb); //더미 데이터 초기화
				bubbleChart.resetDummy(bubbleChart.arrayData.march); //더미 데이터 초기화
				bubbleChart.resetDummy(bubbleChart.arrayData.april); //더미 데이터 초기화
				bubbleChart.resetDummy(bubbleChart.arrayData.may); //더미 데이터 초기화
				bubbleChart.resetDummy(bubbleChart.arrayData.june); //더미 데이터 초기화
				bubbleChart.resetDummy(bubbleChart.arrayData.july); //더미 데이터 초기화
				bubbleChart.resetDummy(bubbleChart.arrayData.aug); //더미 데이터 초기화
				bubbleChart.resetDummy(bubbleChart.arrayData.sep); //더미 데이터 초기화
				bubbleChart.resetDummy(bubbleChart.arrayData.oct); //더미 데이터 초기화
				bubbleChart.resetDummy(bubbleChart.arrayData.nov); //더미 데이터 초기화
				bubbleChart.resetDummy(bubbleChart.arrayData.dec); //더미 데이터 초기화
				//if(rtData.length < 2){
					rtData.push(["", bubbleChart.data.searchStartDate, 1, 0, 0, "", "", "", 0]);
					rtData.push(["", bubbleChart.data.searchEndDate, 1, 0, 0, "", "", "", 0]);
				//}
				return rtData;
			}else if($("input[name='radioViewTypeBubbleChart']:checked").val() == 'q'){
				if(month == '01'){
					rtData = JSON.parse(JSON.stringify(bubbleChart.arrayData.jan.concat(bubbleChart.arrayData.feb, bubbleChart.arrayData.march)));
					bubbleChart.resetDummy(bubbleChart.arrayData.jan); //더미 데이터 초기화
					bubbleChart.resetDummy(bubbleChart.arrayData.feb); //더미 데이터 초기화
					bubbleChart.resetDummy(bubbleChart.arrayData.march); //더미 데이터 초기화
					//if(rtData.length < 2){
						rtData.push(["", bubbleChart.data.searchStartDate, 1, 0, 0, "", "", "", 0]);
						rtData.push(["", bubbleChart.data.searchEndDate, 1, 0, 0, "", "", "", 0]);
						//}
					return rtData;
				}else if(month == '04'){
					rtData = JSON.parse(JSON.stringify(bubbleChart.arrayData.april.concat(bubbleChart.arrayData.may, bubbleChart.arrayData.june)));
					bubbleChart.resetDummy(bubbleChart.arrayData.april); //더미 데이터 초기화
					bubbleChart.resetDummy(bubbleChart.arrayData.may); //더미 데이터 초기화
					bubbleChart.resetDummy(bubbleChart.arrayData.june); //더미 데이터 초기화
					//if(rtData.length < 2){
						rtData.push(["", bubbleChart.data.searchStartDate, 1, 0, 0, "", "", "", 0]);
						rtData.push(["", bubbleChart.data.searchEndDate, 1, 0, 0, "", "", "", 0]);
						//}
					return rtData;
				}else if(month == '07'){
					rtData = JSON.parse(JSON.stringify(bubbleChart.arrayData.july.concat(bubbleChart.arrayData.aug, bubbleChart.arrayData.sep)));
					bubbleChart.resetDummy(bubbleChart.arrayData.july); //더미 데이터 초기화
					bubbleChart.resetDummy(bubbleChart.arrayData.aug); //더미 데이터 초기화
					bubbleChart.resetDummy(bubbleChart.arrayData.sep); //더미 데이터 초기화
					//if(rtData.length < 2){
						rtData.push(["", bubbleChart.data.searchStartDate, 1, 0, 0, "", "", "", 0]);
						rtData.push(["", bubbleChart.data.searchEndDate, 1, 0, 0, "", "", "", 0]);
						//}
					return rtData;
				}else if(month == '10'){
					rtData = JSON.parse(JSON.stringify(bubbleChart.arrayData.oct.concat(bubbleChart.arrayData.nov, bubbleChart.arrayData.dec)));
					bubbleChart.resetDummy(bubbleChart.arrayData.oct); //더미 데이터 초기화
					bubbleChart.resetDummy(bubbleChart.arrayData.nov); //더미 데이터 초기화
					bubbleChart.resetDummy(bubbleChart.arrayData.dec); //더미 데이터 초기화
					//if(rtData.length < 2){
						rtData.push(["", bubbleChart.data.searchStartDate, 1, 0, 0, "", "", "", 0]);
						rtData.push(["", bubbleChart.data.searchEndDate, 1, 0, 0, "", "", "", 0]);
						//}
					return rtData;
				}
			}else if($("input[name='radioViewTypeBubbleChart']:checked").val() == 'm'){
				if(month == '01'){
					rtData = JSON.parse(JSON.stringify(bubbleChart.arrayData.jan));
					bubbleChart.resetDummy(bubbleChart.arrayData.jan); //더미 데이터 초기화
					//if(rtData.length < 2){
						rtData.push(["", bubbleChart.data.searchStartDate, 1, 0, 0, "", "", "", 0]);
						rtData.push(["", bubbleChart.data.searchEndDate, 1, 0, 0, "", "", "", 0]);
						//}
					return rtData;
				}else if(month == '02'){
					rtData = JSON.parse(JSON.stringify(bubbleChart.arrayData.feb));
					bubbleChart.resetDummy(bubbleChart.arrayData.feb); //더미 데이터 초기화
					//if(rtData.length < 2){
						rtData.push(["", bubbleChart.data.searchStartDate, 1, 0, 0, "", "", "", 0]);
						rtData.push(["", bubbleChart.data.searchEndDate, 1, 0, 0, "", "", "", 0]);
						//}
					return rtData;
				}else if(month == '03'){
					rtData = JSON.parse(JSON.stringify(bubbleChart.arrayData.march));
					bubbleChart.resetDummy(bubbleChart.arrayData.march); //더미 데이터 초기화
					//if(rtData.length < 2){
						rtData.push(["", bubbleChart.data.searchStartDate, 1, 0, 0, "", "", "", 0]);
						rtData.push(["", bubbleChart.data.searchEndDate, 1, 0, 0, "", "", "", 0]);
						//}
					return rtData;
				}else if(month == '04'){
					rtData = JSON.parse(JSON.stringify(bubbleChart.arrayData.april));
					bubbleChart.resetDummy(bubbleChart.arrayData.april); //더미 데이터 초기화
					//if(rtData.length < 2){
						rtData.push(["", bubbleChart.data.searchStartDate, 1, 0, 0, "", "", "", 0]);
						rtData.push(["", bubbleChart.data.searchEndDate, 1, 0, 0, "", "", "", 0]);
						//}
					return rtData;
				}else if(month == '05'){
					rtData = JSON.parse(JSON.stringify(bubbleChart.arrayData.may));
					bubbleChart.resetDummy(bubbleChart.arrayData.may); //더미 데이터 초기화
					//if(rtData.length < 2){
						rtData.push(["", bubbleChart.data.searchStartDate, 1, 0, 0, "", "", "", 0]);
						rtData.push(["", bubbleChart.data.searchEndDate, 1, 0, 0, "", "", "", 0]);
						//}
					return rtData;
				}else if(month == '06'){
					rtData = JSON.parse(JSON.stringify(bubbleChart.arrayData.june));
					bubbleChart.resetDummy(bubbleChart.arrayData.june); //더미 데이터 초기화
					//if(rtData.length < 2){
						rtData.push(["", bubbleChart.data.searchStartDate, 1, 0, 0, "", "", "", 0]);
						rtData.push(["", bubbleChart.data.searchEndDate, 1, 0, 0, "", "", "", 0]);
						//}
					return rtData;
				}else if(month == '07'){
					rtData = JSON.parse(JSON.stringify(bubbleChart.arrayData.july));
					bubbleChart.resetDummy(bubbleChart.arrayData.july); //더미 데이터 초기화
					//if(rtData.length < 2){
						rtData.push(["", bubbleChart.data.searchStartDate, 1, 0, 0, "", "", "", 0]);
						rtData.push(["", bubbleChart.data.searchEndDate, 1, 0, 0, "", "", "", 0]);
						//}
					return rtData;
				}else if(month == '08'){
					rtData = JSON.parse(JSON.stringify(bubbleChart.arrayData.aug));
					bubbleChart.resetDummy(bubbleChart.arrayData.aug); //더미 데이터 초기화
					//if(rtData.length < 2){
						rtData.push(["", bubbleChart.data.searchStartDate, 1, 0, 0, "", "", "", 0]);
						rtData.push(["", bubbleChart.data.searchEndDate, 1, 0, 0, "", "", "", 0]);
						//}
					return rtData;
				}else if(month == '09'){
					rtData = JSON.parse(JSON.stringify(bubbleChart.arrayData.sep));
					bubbleChart.resetDummy(bubbleChart.arrayData.sep); //더미 데이터 초기화
					//if(rtData.length < 2){
						rtData.push(["", bubbleChart.data.searchStartDate, 1, 0, 0, "", "", "", 0]);
						rtData.push(["", bubbleChart.data.searchEndDate, 1, 0, 0, "", "", "", 0]);
						//}
					return rtData;
				}else if(month == '10'){
					rtData = JSON.parse(JSON.stringify(bubbleChart.arrayData.oct));
					bubbleChart.resetDummy(bubbleChart.arrayData.oct); //더미 데이터 초기화
					//if(rtData.length < 2){
						rtData.push(["", bubbleChart.data.searchStartDate, 1, 0, 0, "", "", "", 0]);
						rtData.push(["", bubbleChart.data.searchEndDate, 1, 0, 0, "", "", "", 0]);
						//}
					return rtData;
				}else if(month == '11'){
					rtData = JSON.parse(JSON.stringify(bubbleChart.arrayData.nov));
					bubbleChart.resetDummy(bubbleChart.arrayData.nov); //더미 데이터 초기화
					//if(rtData.length < 2){
						rtData.push(["", bubbleChart.data.searchStartDate, 1, 0, 0, "", "", "", 0]);
						rtData.push(["", bubbleChart.data.searchEndDate, 1, 0, 0, "", "", "", 0]);
						//}
					return rtData;
				}else if(month == '12'){
					rtData = JSON.parse(JSON.stringify(bubbleChart.arrayData.dec));
					bubbleChart.resetDummy(bubbleChart.arrayData.dec); //더미 데이터 초기화
					//if(rtData.length < 2){
						rtData.push(["", bubbleChart.data.searchStartDate, 1, 0, 0, "", "", "", 0]);
						rtData.push(["", bubbleChart.data.searchEndDate, 1, 0, 0, "", "", "", 0]);
						//}
					return rtData;
				}
			}
		}
}

oppData = {
	idx : '${fn:length(salesActList)}',
	data : null
}


googleChart.load(drawChart);

function drawChart() {
	var LColumns = [
			{id:'END_USER', label:'고객사', type: 'string'},
			{id:'CONTRACT_DATE', label:'계약일', type: 'date'},
			{id:'ROUND_CONTRACT_AMOUNT', label:'계약금액', type: 'number'},
			{id:'CATEGORY', label:'CATEGORY', type: 'string'},
			{id:'WinRate', label:'WinRate', type: 'number'},
			{id:'OPPORTUNITY_ID', label:'OPPORTUNITY_ID', type: 'number'},
			{id:'CUSTOMER_ID', label:'END_USER_ID', type: 'number'},
			{id:'IDENTIFIER_NAME', label:'IDENTIFIER_NAME', type: 'string'},
			{id:'SUBJECT', label:'SUBJECT', type: 'string'},
			{id:'CONTRACT_AMOUNT', label:'CONTRACT_AMOUNT', type: 'number'}
		];
	var LChartData = [];
	var dataArr = [];
	
	if(oppData.idx>0){
		<c:forEach items="${salesActList}" var="items" varStatus="status">
			<c:forEach items="${items}" var="items2">
			<c:choose>
				<c:when test='${items2.CONTRACT_MONTH eq "1"}'>
				dataArr = [];
				dataArr.push('${items2.END_USER}');
				dataArr.push('${items2.CONTRACT_DATE}' + ' 00:00');
				dataArr.push('${items2.ROUND_CONTRACT_AMOUNT}');
				dataArr.push('${items2.OPPORTUNITY_ID}');
				dataArr.push('${items2.CUSTOMER_ID}');
				dataArr.push('${items2.IDENTIFIER_NAME}');
				dataArr.push('${items2.SUBJECT}');
				dataArr.push('${items2.CATEGORY}');
				bubbleChart.arrayData.jan.push(dataArr);
				</c:when>
				<c:when test='${items2.CONTRACT_MONTH eq "2"}'>
				dataArr = [];
				dataArr.push('${items2.END_USER}');
				dataArr.push('${items2.CONTRACT_DATE}' + ' 00:00');
				dataArr.push('${items2.ROUND_CONTRACT_AMOUNT}');
				dataArr.push('${items2.OPPORTUNITY_ID}');
				dataArr.push('${items2.CUSTOMER_ID}');
				dataArr.push('${items2.IDENTIFIER_NAME}');
				dataArr.push('${items2.SUBJECT}');
				dataArr.push('${items2.CATEGORY}');
				bubbleChart.arrayData.feb.push(dataArr);
				</c:when>
				<c:when test='${items2.CONTRACT_MONTH eq "3"}'>
				dataArr = [];
				dataArr.push('${items2.END_USER}');
				dataArr.push('${items2.CONTRACT_DATE}' + ' 00:00');
				dataArr.push('${items2.ROUND_CONTRACT_AMOUNT}');
				dataArr.push('${items2.OPPORTUNITY_ID}');
				dataArr.push('${items2.CUSTOMER_ID}');
				dataArr.push('${items2.IDENTIFIER_NAME}');
				dataArr.push('${items2.SUBJECT}');
				dataArr.push('${items2.CATEGORY}');
				bubbleChart.arrayData.march.push(dataArr);
				</c:when>
				<c:when test='${items2.CONTRACT_MONTH eq "4"}'>
				dataArr = [];
				dataArr.push('${items2.END_USER}');
				dataArr.push('${items2.CONTRACT_DATE}' + ' 00:00');
				dataArr.push('${items2.ROUND_CONTRACT_AMOUNT}');
				dataArr.push('${items2.OPPORTUNITY_ID}');
				dataArr.push('${items2.CUSTOMER_ID}');
				dataArr.push('${items2.IDENTIFIER_NAME}');
				dataArr.push('${items2.SUBJECT}');
				dataArr.push('${items2.CATEGORY}');
				bubbleChart.arrayData.april.push(dataArr);
				</c:when>
				<c:when test='${items2.CONTRACT_MONTH eq "5"}'>
				dataArr = [];
				dataArr.push('${items2.END_USER}');
				dataArr.push('${items2.CONTRACT_DATE}' + ' 00:00');
				dataArr.push('${items2.ROUND_CONTRACT_AMOUNT}');
				dataArr.push('${items2.OPPORTUNITY_ID}');
				dataArr.push('${items2.CUSTOMER_ID}');
				dataArr.push('${items2.IDENTIFIER_NAME}');
				dataArr.push('${items2.SUBJECT}');
				dataArr.push('${items2.CATEGORY}');
				bubbleChart.arrayData.may.push(dataArr);
				</c:when>
				<c:when test='${items2.CONTRACT_MONTH eq "6"}'>
				dataArr = [];
				dataArr.push('${items2.END_USER}');
				dataArr.push('${items2.CONTRACT_DATE}' + ' 00:00');
				dataArr.push('${items2.ROUND_CONTRACT_AMOUNT}');
				dataArr.push('${items2.OPPORTUNITY_ID}');
				dataArr.push('${items2.CUSTOMER_ID}');
				dataArr.push('${items2.IDENTIFIER_NAME}');
				dataArr.push('${items2.SUBJECT}');
				dataArr.push('${items2.CATEGORY}');
				bubbleChart.arrayData.june.push(dataArr);
				</c:when>
				<c:when test='${items2.CONTRACT_MONTH eq "7"}'>
				dataArr = [];
				dataArr.push('${items2.END_USER}');
				dataArr.push('${items2.CONTRACT_DATE}' + ' 00:00');
				dataArr.push('${items2.ROUND_CONTRACT_AMOUNT}');
				dataArr.push('${items2.OPPORTUNITY_ID}');
				dataArr.push('${items2.CUSTOMER_ID}');
				dataArr.push('${items2.IDENTIFIER_NAME}');
				dataArr.push('${items2.SUBJECT}');
				dataArr.push('${items2.CATEGORY}');
				bubbleChart.arrayData.july.push(dataArr);
				</c:when>
				<c:when test='${items2.CONTRACT_MONTH eq "8"}'>
				dataArr = [];
				dataArr.push('${items2.END_USER}');
				dataArr.push('${items2.CONTRACT_DATE}' + ' 00:00');
				dataArr.push('${items2.ROUND_CONTRACT_AMOUNT}');
				dataArr.push('${items2.OPPORTUNITY_ID}');
				dataArr.push('${items2.CUSTOMER_ID}');
				dataArr.push('${items2.IDENTIFIER_NAME}');
				dataArr.push('${items2.SUBJECT}');
				dataArr.push('${items2.CATEGORY}');
				bubbleChart.arrayData.aug.push(dataArr);
				</c:when>
				<c:when test='${items2.CONTRACT_MONTH eq "9"}'>
				dataArr = [];
				dataArr.push('${items2.END_USER}');
				dataArr.push('${items2.CONTRACT_DATE}' + ' 00:00');
				dataArr.push('${items2.ROUND_CONTRACT_AMOUNT}');
				dataArr.push('${items2.OPPORTUNITY_ID}');
				dataArr.push('${items2.CUSTOMER_ID}');
				dataArr.push('${items2.IDENTIFIER_NAME}');
				dataArr.push('${items2.SUBJECT}');
				dataArr.push('${items2.CATEGORY}');
				bubbleChart.arrayData.sep.push(dataArr);
				</c:when>
				<c:when test='${items2.CONTRACT_MONTH eq "10"}'>
				dataArr = [];
				dataArr.push('${items2.END_USER}');
				dataArr.push('${items2.CONTRACT_DATE}' + ' 00:00');
				dataArr.push('${items2.ROUND_CONTRACT_AMOUNT}');
				dataArr.push('${items2.OPPORTUNITY_ID}');
				dataArr.push('${items2.CUSTOMER_ID}');
				dataArr.push('${items2.IDENTIFIER_NAME}');
				dataArr.push('${items2.SUBJECT}');
				dataArr.push('${items2.CATEGORY}');
				bubbleChart.arrayData.oct.push(dataArr);
				</c:when>
				<c:when test='${items2.CONTRACT_MONTH eq "11"}'>
				dataArr = [];
				dataArr.push('${items2.END_USER}');
				dataArr.push('${items2.CONTRACT_DATE}' + ' 00:00');
				dataArr.push('${items2.ROUND_CONTRACT_AMOUNT}');
				dataArr.push('${items2.OPPORTUNITY_ID}');
				dataArr.push('${items2.CUSTOMER_ID}');
				dataArr.push('${items2.IDENTIFIER_NAME}');
				dataArr.push('${items2.SUBJECT}');
				dataArr.push('${items2.CATEGORY}');
				bubbleChart.arrayData.nov.push(dataArr);
				</c:when>
				<c:when test='${items2.CONTRACT_MONTH eq "12"}'>
				dataArr = [];
				dataArr.push('${items2.END_USER}');
				dataArr.push('${items2.CONTRACT_DATE}' + ' 00:00');
				dataArr.push('${items2.ROUND_CONTRACT_AMOUNT}');
				dataArr.push('${items2.OPPORTUNITY_ID}');
				dataArr.push('${items2.CUSTOMER_ID}');
				dataArr.push('${items2.IDENTIFIER_NAME}');
				dataArr.push('${items2.SUBJECT}');
				dataArr.push('${items2.CATEGORY}');
				bubbleChart.arrayData.dec.push(dataArr);
				</c:when>
			</c:choose>
			</c:forEach>
		</c:forEach>
		
		if($("input[name='radioViewTypeBubbleChart']:checked").val() == 'y'){
			LChartData = bubbleChart.arrayData.jan.concat(bubbleChart.arrayData.feb, bubbleChart.arrayData.march, bubbleChart.arrayData.april, bubbleChart.arrayData.may, bubbleChart.arrayData.june, bubbleChart.arrayData.july, bubbleChart.arrayData.aug, bubbleChart.arrayData.sep, bubbleChart.arrayData.oct, bubbleChart.arrayData.nov, bubbleChart.arrayData.dec);
		}
		
		var chart = new GoogleChart();
		chart.bubbleChart.options.isStacked = 'percent';
		chart.bubbleChart.draw(LColumns, LChartData, 'chart_div');
	}

}
</script>
