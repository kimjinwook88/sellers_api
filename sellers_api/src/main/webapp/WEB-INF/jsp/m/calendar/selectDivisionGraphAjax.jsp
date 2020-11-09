<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<script type="text/javascript">
	google.charts.load("current", {packages:["corechart"]});
	google.charts.setOnLoadCallback(drawChart);
	
	var len = ${fn:length(rows)};
	//alert(len);
		function drawChart() {
			
			var data = new google.visualization.DataTable();
			
			data.addColumn('string', '이름');
			data.addColumn('number', '고객대면');
			data.addColumn('number', '대면준비');
			data.addColumn('number', '내부회의');
			data.addColumn('number', '교육');
			data.addColumn('number', '기타');
			data.addColumn('number', '휴가');		
			data.addColumn('number', '이동시간');
			data.addColumn('number', '미입력');
			
			for (var i = 0; i < len; i++) {
				
				eval('var names' + i);
				eval('var scheduleA' + i);
				eval('var scheduleB' + i);
				eval('var scheduleC' + i);
				eval('var scheduleD' + i);
				eval('var scheduleE' + i);
				eval('var scheduleF' + i);
				eval('var scheduleG' + i);
				eval('var scheduleH' + i);
				
				eval('var schedule_Arr' + i + ' = new Array();');
			}
			
			<c:forEach items="${rows}" var="divisionStatus" varStatus="status">
				names${status.index} = '${divisionStatus.TEAM_NAME}';
				scheduleA${status.index} = ${divisionStatus.THIS_EVENT_TIME_1};
				scheduleB${status.index} = ${divisionStatus.THIS_EVENT_TIME_2};
				scheduleC${status.index} = ${divisionStatus.THIS_EVENT_TIME_3};
				scheduleD${status.index} = ${divisionStatus.THIS_EVENT_TIME_4};
				scheduleE${status.index} = ${divisionStatus.THIS_EVENT_TIME_6};
				scheduleF${status.index} = ${divisionStatus.THIS_EVENT_TIME_7};
				scheduleG${status.index} = ${divisionStatus.THIS_EVENT_TIME_5};
				scheduleH${status.index} = ${divisionStatus.THISOTHER};
				
				schedule_Arr${status.index}.push(
						names${status.index}
						,scheduleA${status.index}
						,scheduleB${status.index}
						,scheduleC${status.index}
						,scheduleD${status.index}
						,scheduleE${status.index}
						,scheduleF${status.index}
						,scheduleG${status.index}
						,scheduleH${status.index}
				);
			</c:forEach>
			//*************************************************** 회사전체 데이터 생성 ***************************************************//
			// 회사전테 데이터가 들어가 빈 배열
			var company_Arr = new Array();
			
			// 회사 전에이름 고정
			var companyName = '${rows[0].DIVISION_NAME}';
			
			// 컬럼에 맞도록 변수 생성
			for(var w = 0; w <= 8; w++){
				eval('var company' + w + '= 0');
			}
			
			// 배열의 위치에 맞도록 합산
			for(var q = 1, e=0; q <(len+1); q++, e++){
				company0 += eval('schedule_Arr'+e+'[1]');
				company1 += eval('schedule_Arr'+e+'[2]');
				company2 += eval('schedule_Arr'+e+'[3]');
				company3 += eval('schedule_Arr'+e+'[4]');
				company4 += eval('schedule_Arr'+e+'[5]');
				company5 += eval('schedule_Arr'+e+'[6]');
				company6 += eval('schedule_Arr'+e+'[7]');
				company7 += Math.round(eval('schedule_Arr'+e+'[8]'));
			}
			
			// 합산된 데이터를 배열에 넣어줌
			company_Arr.push([
							companyName, company0, company1
							,company2, company3, company4
							,company5, company6, company7
			]);
			
			console.log(company_Arr);
			
			data.addRows(company_Arr);
			//*************************************************** 회사전체 데이터 생성 ***************************************************//
			
			
			for(var e = 0; e< len; e++){
				eval('data.addRows([schedule_Arr' + e + '])');
			}
			
			console.log(data);
			
			var options_fullStacked = {
				isStacked: 'percent',
				height: 500,
				width:600,
				legend: {position: 'top', maxLines: 3},
				hAxis: {
				  minValue: 0,
				  //ticks: [0, .3, .6, .9, 1]
				}
			};
			
			var now_quarter = '${gridFaceTimeGraphData.NOW_QUARTER}';
			
			var now_month1 = '${gridFaceTimeGraphData.NOW_MONTH0}';
			var now_month2 = '${gridFaceTimeGraphData.NOW_MONTH1}';
			var now_month3 = '${gridFaceTimeGraphData.NOW_MONTH2}';
			
			var now_quarter_A = ${gridFaceTimeGraphData.THIS_EVENT_TIME_1};
			var now_quarter_B = ${gridFaceTimeGraphData.THIS_EVENT_TIME_2};
			var now_quarter_C = ${gridFaceTimeGraphData.THIS_EVENT_TIME_3};
			var now_quarter_D = ${gridFaceTimeGraphData.THIS_EVENT_TIME_4};
			var now_quarter_E = ${gridFaceTimeGraphData.THIS_EVENT_TIME_5};
			var now_quarter_F = ${gridFaceTimeGraphData.THIS_EVENT_TIME_6};
			var now_quarter_G = ${gridFaceTimeGraphData.THIS_EVENT_TIME_7};
			var now_quarter_H = ${gridFaceTimeGraphData.THIS_EVENT_TIME_8};
			
			var quarter_A1 = ${gridFaceTimeGraphData.LEQ0_1};
			var quarter_B1 = ${gridFaceTimeGraphData.LEQ0_2};
			var quarter_C1 = ${gridFaceTimeGraphData.LEQ0_3};
			var quarter_D1 = ${gridFaceTimeGraphData.LEQ0_4};
			var quarter_E1 = ${gridFaceTimeGraphData.LEQ0_5};
			var quarter_F1 = ${gridFaceTimeGraphData.LEQ0_6};
			var quarter_G1 = ${gridFaceTimeGraphData.LEQ0_7};
			var quarter_H1 = ${gridFaceTimeGraphData.LEQ0_8};
			
			var quarter_A2 = ${gridFaceTimeGraphData.LEQ1_1};
			var quarter_B2 = ${gridFaceTimeGraphData.LEQ1_2};
			var quarter_C2 = ${gridFaceTimeGraphData.LEQ1_3};
			var quarter_D2 = ${gridFaceTimeGraphData.LEQ1_4};
			var quarter_E2 = ${gridFaceTimeGraphData.LEQ1_5};
			var quarter_F2 = ${gridFaceTimeGraphData.LEQ1_6};
			var quarter_G2 = ${gridFaceTimeGraphData.LEQ1_7};
			var quarter_H2 = ${gridFaceTimeGraphData.LEQ1_8};

			var quarter_A3 = ${gridFaceTimeGraphData.LEQ2_1};
			var quarter_B3 = ${gridFaceTimeGraphData.LEQ2_2};
			var quarter_C3 = ${gridFaceTimeGraphData.LEQ2_3};
			var quarter_D3 = ${gridFaceTimeGraphData.LEQ2_4};
			var quarter_E3 = ${gridFaceTimeGraphData.LEQ2_5};
			var quarter_F3 = ${gridFaceTimeGraphData.LEQ2_6};
			var quarter_G3 = ${gridFaceTimeGraphData.LEQ2_7};
			var quarter_H3 = ${gridFaceTimeGraphData.LEQ2_8};

			
			var data2 = google.visualization.arrayToDataTable([
				['Genre', '고객대면', '대면준비', '내부회의', '교육', '기타', '휴가', '이동시간', '미입력'],
				[now_quarter, now_quarter_A, now_quarter_B, now_quarter_C, now_quarter_D,  now_quarter_F,  now_quarter_G,  now_quarter_E, now_quarter_H],
				[now_month1, quarter_A1, quarter_B1, quarter_C1, quarter_D1,  quarter_F1,  quarter_G1,  quarter_E1, quarter_H1],
				[now_month2, quarter_A2, quarter_B2, quarter_C2, quarter_D2,  quarter_F2,  quarter_G2,  quarter_E2, quarter_H2],
				[now_month3, quarter_A3, quarter_B3, quarter_C3, quarter_D3,  quarter_F3,  quarter_G3,  quarter_E3, quarter_H3]
			]);
			
			var view = new google.visualization.DataView(data2);
			
			var options_fullStacked = {
				isStacked: 'percent',
				width:600,
				height: 500,
				legend: {position: 'top', maxLines: 3},
				//colors: ['#00b0f0', '#00cc99', '#c33f3f'],
				vAxis: {
				minValue: 0,
				}
			};
			
			var chart = new google.visualization.BarChart(document.getElementById("barchart_values"));
			chart.draw(data, options_fullStacked);
			
			var chart2 = new google.visualization.ColumnChart(document.getElementById("quarter_values"));
			chart2.draw(view, options_fullStacked);
		}

	
</script>

<!-- 왼쪽영역 -->
<div ng-app="myApp">
	<!-- 박스 접기기능  -->
	<div class="ibox-tools">
	    <a class="collapse-link">
	        <i class="fa fa-chevron-up"></i>
	    </a>
	</div>
	<!--// 박스 접기기능  -->
	<div class="col-sm-6">
		<div ng-controller="MainCtrl" style="width:600px">
			<nvd3 options="options" data="data" config="config" interactive="true">
				<div id="barchart_values" style="width:600px"></div>
			</nvd3>
		</div>
	</div>

	<!-- 오른쪽 영역 -->
	<div class="col-sm-6">
		<!-- 박스 접기기능  -->
	<div class="ibox-tools">
	    <a class="collapse-link">
	        <i class="fa fa-chevron-up"></i>
	    </a>
	</div>
	<!--// 박스 접기기능  -->
		<div ng-controller="MainCtrl" style="width:600px">
			<nvd3 options="options2" data="data2" config="config" interactive="true">
				<div id="quarter_values" style="width:600px"></div>
			</nvd3>
		</div>
	</div>
</div>






