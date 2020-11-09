<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="col-sm-12" id="divDonut" style="width:99.99%;">
	<div class="ibox">
	     <div class="ibox-title landing-header">
	         <h5></h5>
	         <div class="pull-right day-nav" style="position: absolute; z-index: 100;">
				<div class="selgrid">
					<div class="fl_l mg-r10">
					   	<button class="btn btn-white btn-move" onclick="donutChart.prevDate();"><i class="fa fa-arrow-left"></i></button>
					    <strong class="term-txt" id="strongDate"></strong>
					    <button class="btn btn-white btn-move" onclick="donutChart.nextDate();"><i class="fa fa-arrow-right"></i></button>
					</div>
				</div>
				<div class="fl_l pd-t3" style="margin-right: 20px;">
				   	<label for="term1" class="mg-r10">
				       	<input type="radio" id="term1" name="radioViewType2" value="q" class=""> <span class="">분기</span>
				   	</label>
				   	<label for="term2">
				       	<input type="radio" id="term2" name="radioViewType2" value="y" checked="true" class=""> <span class="">년도</span>
				   	</label>
			   		<label for="term3">
				       	<input type="radio" id="term3" name="radioViewType2" value="y2y" class=""> <span class="">Y2Y</span>
				   	</label>
				</div>
				<div class="selgrid selgrid1 mg-r5">
					<select class="form-control m-b" name="selectFacePost2" id="selectFacePost2">
					</select>
				</div>
			</div>				
	     </div>
	    <div class="ibox-content border_n">
	     	<div class="clear">
				<div class="func-top-right fl_l">
					<div class="fl_l mg-r10">
						<div style="width: 14px; height: 14px; display: inline-block; background-color: #0073ae;"></div>
						<label id="donutChartLegend1">실적</label>
					</div>
				    <div class="fl_l">
				        <div style="width: 14px; height: 14px; display: inline-block; background-color: #81bef7;"></div>
				       	<label id="donutChartLegend2">Forecast</label>
				    </div>
				</div>
				<div class="donut">
					<ul>
						<li class="col-sm-3">
							<div class="chartArea">
								<div class="chartTitle" id="tcvTitle">총 계약금액</div>
								<!-- <div class="oldChart" id="oldTcv"></div> -->
								<div class="newChart" id="new_tcv"></div>
								<div class="chart-percent" id="percent_tcv"><span></span><strong></strong></div>
								<div class="chart-fc-percent" id="fc_tcv"><span></span><strong></strong></div>
								<!-- <div class="startLine" style="display: none;">
									<div class="startBar"></div>
									<div class="startCircle-1"></div>
									<div class="startCircle-2"></div>
								</div> -->
							</div>
						</li>
						<li class="col-sm-3">
							<div class="chartArea">
								<div class="chartTitle" id="revTitle">매출 총액</div>
								<!-- <div class="oldChart" id="oldRev"></div> -->
								<div class="newChart" id="new_rev"></div>
								<div class="chart-percent" id="percent_rev"><span></span><strong></strong></div>
								<div class="chart-fc-percent" id="fc_rev"><span></span><strong></strong></div>
								<!-- <div class="startLine" style="display: none;">
									<div class="startBar"></div>
									<div class="startCircle-1"></div>
									<div class="startCircle-2"></div>
								</div> -->
							</div>
						</li>
						<li class="col-sm-3">
							<div class="chartArea">
								<div class="chartTitle" id="pgpTitle">예상 이익</div>
								<!-- <div class="oldChart" id="oldPgp"></div> -->
								<div class="newChart" id="new_pgp"></div>
								<div class="chart-percent" id="percent_pgp"><span></span><strong></strong></div>
								<div class="chart-fc-percent" id="fc_pgp"><span></span><strong></strong></div>
								<!-- <div class="startLine" style="display: none;">
									<div class="startBar"></div>
									<div class="startCircle-1"></div>
									<div class="startCircle-2"></div>
								</div> -->
							</div>
						</li>
						<li class="col-sm-3">
							<div class="chartArea">
								<div class="chartTitle" id="agpTitle">실제 이익</div>
								<!-- <div class="oldChart" id="oldAgp"></div> -->
								<div class="newChart" id="new_agp"></div>
								<div class="chart-percent" id="percent_agp"><span></span><strong></strong></div>
								<div class="chart-fc-percent" id="fc_agp"><span></span><strong></strong></div>
								<!-- <div class="startLine" style="display: none;">
									<div class="startBar"></div>
									<div class="startCircle-1"></div>
									<div class="startCircle-2"></div>
								</div> -->
							</div>
						</li>
					</ul>
				</div>
			</div>
        </div>
    </div>
</div>
<script>

var donutChart = {
		
		selectFacePost : null,
		chartStartDate : moment().format('YYYY') + '-01-01',
		chartEndDate : moment().format('YYYY') + '-12-31',
		dateCategory : 'y',
		searchQuarter : moment().format('Q'),
		showDate : null,
		
		init : function(){
			
			$('.chartTitle').css('display', 'none');
			
			// 날짜 출력
			var dateMap = commonDate.naviDate(donutChart.dateCategory, donutChart.chartStartDate);
			$("strong#strongDate").html(dateMap.showDate);
					
			// 본부 선택
			$('#selectFacePost2').empty();
			if("${selectList}"){
				$('#selectFacePost2').append("<option value=''>전체</option>");
				<c:forEach items="${selectList}" var="item">
					var option = $("<option value=${item.SELECT_NO}>${item.SELECT_NAME}</option>");
					$('#selectFacePost2').append(option);
				</c:forEach>	
			}else{
				$('#selectFacePost2').remove();
			}

			$("#selectFacePost2").change(function() {
				donutChart.selectFacePost = $("#selectFacePost2").val();
				//ajax호출
				donutChart.get();
			});
			
			//영업실적 표 년, 월, 분기
			$("input[name='radioViewType2']").on('change',function(){
				if($(this).val() == 'q'){
					dateMap = commonDate.naviDate('q', moment().format('YYYY-MM-DD'), 0);
				}else{
					dateMap = commonDate.naviDate('y', moment().format('YYYY-MM-DD'), 0);
				}
				
				donutChart.dateCategory = $(this).val();	
				donutChart.setDate(dateMap);
			});
			
			googleChart.load(donutChart.drawChart);
		},
		
		setDate : function(dateMap){
			donutChart.chartStartDate = dateMap.startDate;
			donutChart.chartEndDate = dateMap.endDate;
			$("strong#strongDate").html(dateMap.showDate);
			donutChart.showDate = dateMap.showDate;
			donutChart.searchQuarter = moment(dateMap.startDate).format('Q');
			//ajax호출
			donutChart.get();
		},
		
		//분기 이전 버튼
		prevDate : function() {
			var dateMap;
			if(donutChart.dateCategory != 'y2y'){
				dateMap = commonDate.naviDate(donutChart.dateCategory, donutChart.chartStartDate, -1);
			}else{
				dateMap = commonDate.naviDate('y', donutChart.chartStartDate, -1);
			}
			donutChart.setDate(dateMap);
		},
		
		//분기 다음 버튼
		nextDate : function() {
			var dateMap;
			if(donutChart.dateCategory != 'y2y'){
				dateMap = commonDate.naviDate(donutChart.dateCategory, donutChart.chartStartDate, 1);
			}else{
				dateMap = commonDate.naviDate('y', donutChart.chartStartDate, 1);
			}
			donutChart.setDate(dateMap);
		},
		 
		numberWithCommas : function(x) {
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}, 
		
		get : function(){
			var params = $.param({
				datatype : 'json',
				startDate : donutChart.chartStartDate,
				endDate : donutChart.chartEndDate,
				selectQuarter : donutChart.dateCategory,
				selectFacePost : donutChart.selectFacePost,
				searchQuarter : donutChart.searchQuarter,
			});
			$.ajax({
				url : "/main/selectSalesActDonutChart.do",
				data : params,
				datatype : 'json',
				method : 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					donutChart.drawChart(data.salesActList, data.forecastList, data.forecastList2, data.y2yList);
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		drawChart : function(salesActList, forecastList, forecastList2, y2yList){			

			var chart1 = new GoogleChart();
			var typeList = ['tcv', 'rev', 'pgp', 'agp'];
			
			if(donutChart.dateCategory == 'y2y'){
				
				// 구글 차트 옵션 변경
				chart1.donutChart.options.slices[1].color = '#ffc586';
				
				var this_tcv = 0, this_rev = 0, this_pgp = 0, this_agp = 0;
				var last_tcv = 0, last_rev = 0, last_pgp = 0, last_agp = 0;			
				var c = "+";
				
				if("${fn:length(rows) > 1}" && y2yList.length > 1){
					if(!y2yList){
						this_tcv += Number("${y2yList}[0].TCV");
						this_rev += Number("${y2yList}[0].REV");
						this_pgp += Number("${y2yList}[0].PGP");
						this_agp += Number("${y2yList}[0].AGP");
						
						last_tcv += Number("${y2yList}[1].TCV");
						last_rev += Number("${y2yList}[1].REV");
						last_pgp += Number("${y2yList}[1].PGP");
						last_agp += Number("${y2yList}[1].AGP");
					}else{
						
						this_tcv += Number(y2yList[0].TCV);
						this_rev += Number(y2yList[0].REV);
						this_pgp += Number(y2yList[0].PGP);
						this_agp += Number(y2yList[0].AGP);
						
						last_tcv += Number(y2yList[1].TCV);
						last_rev += Number(y2yList[1].REV);
						last_pgp += Number(y2yList[1].PGP);
						last_agp += Number(y2yList[1].AGP);
					}
				}
				
				for(var i in typeList){
					var type = typeList[i];
					
					var percent = 0;
					var grayArea = 0;
					var whiteArea = 0;
					var elementId = 'new_'+type;
					var this_val = eval('this_'+type);
					var last_val = eval('last_'+type);
					
					// 툴팁 설정
					var tooltips = [];
					tooltips.push(donutChart.numberWithCommas(this_val));
					tooltips.push(donutChart.numberWithCommas(last_val));
														
					if(this_val == 0 && last_val == 0){                    	 	// 올해 실적과 작년 실적이 모두 0이면 회색 영역으로 표시
						grayArea = 1;
						whiteArea = 1;
						c = "";
					}
					else if(this_val == 0 && last_val > 0){ 				 	// 올해 실적이 0인 경우 -100%
						percent = 100;
						whiteArea = last_val;
						c = "-";
					}else if(last_val == 0 && this_val > 0){ 				 	
						percent = 100;
						whiteArea = this_val;
						c = "+";
					}else if(this_val >=  last_val){							// 올해 실적이 더 클 때 +
						percent = 100 - Math.floor((last_val/this_val) * 100);
						last_val = 0;
						whiteArea = this_val;
						c = "+";
					}else{														 // 작년 실적이 더 클 때 -
						percent = 100 - Math.floor((this_val/last_val) * 100);
					
						if(percent > 100 && this_val < 0){						 // 올해 실적이 0보다 작을 때
							this_val = 0;
						}
						
						last_val = last_val - this_val;
						whiteArea = this_val+ last_val;
						c = "-";
					}

					$('#percent_'+type+' span').html(c+percent);
					$('#percent_'+type+' strong').html('%');
					$('#fc_'+type+' span').html('');
					$('#fc_'+type+' strong').html('');
					
					chart1.donutChart.tooltipTest(['', '', 'gray', ''], [this_val, last_val, grayArea, whiteArea], tooltips, elementId);
				}
				
				$('.oldChart').css('display', 'block');
				
				$('#donutChartLegend1').html(donutChart.showDate+' 실적');
				$('#donutChartLegend2').html(parseInt(donutChart.showDate)-1+'년 실적');
				$('#donutChartLegend2').prev().css('background-color', '#ffc586');
				
			}else{

				var target_tcv = 0, target_rev = 0, target_pgp = 0, target_agp = 0;
				var actual_tcv = 0, actual_rev = 0, actual_pgp = 0, actual_agp = 0;
				var fc_tcv = 0, fc_rev = 0, fc_pgp = 0, fc_agp = 0;
				
				//실적g
				if(!salesActList){
					<c:forEach items="${salesActList}" var="item">
						target_tcv += Number("${item.TARGET_TCV}");
						actual_tcv += Number("${item.ACTUAL_TCV}");
					
						target_rev += Number("${item.TARGET_REV}");
						actual_rev += Number("${item.ACTUAL_REV}");

						target_pgp += Number("${item.TARGET_PGP}");
						actual_pgp += Number("${item.ACTUAL_PGP}");
						
						target_agp += Number("${item.TARGET_AGP}");
						actual_agp += Number("${item.ACTUAL_AGP}");						
					</c:forEach>
				}else{
					
					var l = salesActList.length
					
					for(var i=0; i<l; i++){
						
						var item = salesActList[i];
						
						target_tcv += Number(item.TARGET_TCV);
						actual_tcv += Number(item.ACTUAL_TCV);
					
						target_rev += Number(item.TARGET_REV);
						actual_rev += Number(item.ACTUAL_REV);
						
						target_pgp += Number(item.TARGET_PGP);
						actual_pgp += Number(item.ACTUAL_PGP);
						
						target_agp += Number(item.TARGET_AGP);
						actual_agp += Number(item.ACTUAL_AGP);
					}
				}
				
				//Forecast TCV, P.GP
				if(!forecastList2){
					<c:forEach items="${forecastList2}" var="item">
						fc_tcv += Number("${item.PLAN_TCV_AMOUNT}");
						fc_pgp += Number("${item.PLAN_PGP_AMOUNT}");
					</c:forEach>
				}else{
					var l = forecastList2.length
					for(var i=0; i<l; i++){
						var item = forecastList2[i];
						fc_tcv += Number(item.PLAN_TCV_AMOUNT);
						fc_pgp += Number(item.PLAN_PGP_AMOUNT);
					}
				}
				
				//Forecast REV, GP
				if(!forecastList){
					<c:forEach items="${forecastList}" var="item">
						fc_rev += Number("${item.PLAN_REV_AMOUNT}");
						fc_agp += Number("${item.PLAN_GP_AMOUNT}");
					</c:forEach>
				}else{
					var l = forecastList.length
					for(var i=0; i<l; i++){
						var item = forecastList[i];
						fc_rev += Number(item.PLAN_REV_AMOUNT);
						fc_agp += Number(item.PLAN_GP_AMOUNT);
					}
				}
				
				// 계산
				for(var i in typeList){
					var type = typeList[i];
					
					var percent = 0;
					var actual_per = 0;
					var fc_per = 0;
					
					var grayArea = 0;
					var whiteArea = 0;
					
					var actual_val = eval('actual_'+type);
					var fc_val = eval('fc_'+type);
					var total_val = actual_val + fc_val;
					var target_val = eval('target_'+type);

					var elementId = 'new_'+type;
					
					// 툴팁 설정
					var tooltips = [];
					tooltips.push(donutChart.numberWithCommas(actual_val));
					tooltips.push(donutChart.numberWithCommas(fc_val));
					
					// 퍼센트 구하기
					if(total_val == 0){                  				 // (실적 + 예상) 이 0이면 0%
						percent = 0;
					}else if(total_val > 0 && target_val == 0){			 // 타겟이 0이면 100%
						percent = 1;							
					}else{											     // 타겟 대비 (실적 + 예상)
						percent = total_val/target_val;      
						
					}
					
					// 실적과 예상 따로 퍼센트 구함
					if(target_val){
						if(actual_val){
							actual_per = actual_val/target_val;
						}
						if(fc_val){
							fc_per = fc_val/target_val;
						}
					}else{
						if(actual_val){
							actual_per = actual_val/total_val;
						}
						if(fc_val){
							fc_per = fc_val/total_val;
						}
					}
					
					// 퍼센트 출력
					$('#percent_'+type+' span').html((Math.floor(actual_per*100)));
					$('#percent_'+type+' strong').html('%');
					$('#fc_'+type+' span').html((Math.floor(percent*100)));
					$('#fc_'+type+' strong').html('%');
					
					// 차트 표현
					if(percent <= 0){														// (실적+예상)이 0이거나 마이너스 이면 회색 영역으로 표시
						grayArea = 1;
						whiteArea = 1;
						
						if(percent < 0){													// 마이너스일 경우 실적과 예상을 0으로 설정하여 차트를 보여주지 않음
							actual_val = 0;
							fc_val = 0;
						}
					}else{																	// (실적+예상)이 0이하가 아님
						whiteArea = total_val;
					
						if(percent < 1){													// (실적+예상)이 100% 이하임
							grayArea = (1-percent) * target_val;
							whiteArea += grayArea;
						}
					}
					
					chart1.donutChart.tooltipTest(['', '', 'gray', ''], [actual_val, fc_val, grayArea, whiteArea], tooltips, elementId);
				}

				$('#donutChartLegend1').html('실적');
				$('#donutChartLegend2').html('Forecast');
				$('#donutChartLegend2').prev().css('background-color', '#81bef7');
			}
			
			$('.chartTitle').css('display', 'block');
		}
}


$(document).ready(function(){
	donutChart.init();
});
	
</script>