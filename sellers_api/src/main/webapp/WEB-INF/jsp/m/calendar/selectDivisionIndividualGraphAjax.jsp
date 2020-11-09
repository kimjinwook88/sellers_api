<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<script type="text/javascript">
/*
*
*   INSPINIA - Responsive Admin Theme
*   version 2.4
*
*/


	

	google.charts.load("current", {packages:["corechart"]});
	google.charts.setOnLoadCallback(drawChart);
	
	var len = ${fn:length(rows)};
	//alert(len);	
		function drawChart() {
			<c:choose>
				<c:when test="${gridFaceTimeGraphData.VIEWTYPE == 'y'}">
					var individual_now_quarter = '${rows[0].HAN_NAME}';
					
					var individual_now_quarter_A = ${
						gridFaceTimeGraphData.LEQ0_1 + gridFaceTimeGraphData.LEQ1_1 + gridFaceTimeGraphData.LEQ2_1 + gridFaceTimeGraphData.LEQ3_1
					};
					var individual_now_quarter_B = ${
						gridFaceTimeGraphData.LEQ0_2 + gridFaceTimeGraphData.LEQ1_2 + gridFaceTimeGraphData.LEQ2_2 + gridFaceTimeGraphData.LEQ3_2
					};
					var individual_now_quarter_C = ${
						gridFaceTimeGraphData.LEQ0_3 + gridFaceTimeGraphData.LEQ1_3 + gridFaceTimeGraphData.LEQ2_3 + gridFaceTimeGraphData.LEQ3_3
					};
					var individual_now_quarter_D = ${
						gridFaceTimeGraphData.LEQ0_4 + gridFaceTimeGraphData.LEQ1_4 + gridFaceTimeGraphData.LEQ2_4 + gridFaceTimeGraphData.LEQ3_4
					};
					var individual_now_quarter_E = ${
						gridFaceTimeGraphData.LEQ0_5 + gridFaceTimeGraphData.LEQ1_5 + gridFaceTimeGraphData.LEQ2_5 + gridFaceTimeGraphData.LEQ3_5
					};
					var individual_now_quarter_F = ${
						gridFaceTimeGraphData.LEQ0_6 + gridFaceTimeGraphData.LEQ1_6 + gridFaceTimeGraphData.LEQ2_6 + gridFaceTimeGraphData.LEQ3_6
					};
					var individual_now_quarter_G = ${
						gridFaceTimeGraphData.LEQ0_7 + gridFaceTimeGraphData.LEQ1_7 + gridFaceTimeGraphData.LEQ2_7 + gridFaceTimeGraphData.LEQ3_7
					};
					var individual_now_quarter_H = ${
						gridFaceTimeGraphData.LEQ0_8 + gridFaceTimeGraphData.LEQ1_8 + gridFaceTimeGraphData.LEQ2_8 + gridFaceTimeGraphData.LEQ3_8
					};
					
				</c:when>
				<c:when test="${gridFaceTimeGraphData.VIEWTYPE == 'm'}">
					var individual_now_quarter = '${rows[0].HAN_NAME}';
					
					var individual_now_quarter_A = ${rows[0].THIS_EVENT_TIME_1};
					var individual_now_quarter_B = ${rows[0].THIS_EVENT_TIME_2};
					var individual_now_quarter_C = ${rows[0].THIS_EVENT_TIME_3};
					var individual_now_quarter_D = ${rows[0].THIS_EVENT_TIME_4};
					var individual_now_quarter_E = ${rows[0].THIS_EVENT_TIME_5};
					var individual_now_quarter_F = ${rows[0].THIS_EVENT_TIME_6};
					var individual_now_quarter_G = ${rows[0].THIS_EVENT_TIME_7};
					var individual_now_quarter_H = ${rows[0].THISOTHER};
				</c:when>
				<c:when test="${gridFaceTimeGraphData.VIEWTYPE == 'q'}">
					var individual_now_quarter = '${rows[0].HAN_NAME}';
					
					var individual_now_quarter_A = ${gridFaceTimeGraphData.LEQ0_1};
					var individual_now_quarter_B = ${gridFaceTimeGraphData.LEQ0_2};
					var individual_now_quarter_C = ${gridFaceTimeGraphData.LEQ0_3};
					var individual_now_quarter_D = ${gridFaceTimeGraphData.LEQ0_4};
					var individual_now_quarter_E = ${gridFaceTimeGraphData.LEQ0_5};
					var individual_now_quarter_F = ${gridFaceTimeGraphData.LEQ0_6};
					var individual_now_quarter_G = ${gridFaceTimeGraphData.LEQ0_7};
					var individual_now_quarter_H = ${gridFaceTimeGraphData.LEQ0_8};
				</c:when>
			</c:choose>
			/*
			var individual_now_month1 = '${gridFaceTimeIndividualGraphData.NOW_MONTH0}';
			var individual_now_month2 = '${gridFaceTimeIndividualGraphData.NOW_MONTH1}';
			var individual_now_month3 = '${gridFaceTimeIndividualGraphData.NOW_MONTH2}';
			*/
			
			/*
			var individual_quarter_A1 = ${gridFaceTimeIndividualGraphData.LEQ0_1};
			var individual_quarter_B1 = ${gridFaceTimeIndividualGraphData.LEQ0_2};
			var individual_quarter_C1 = ${gridFaceTimeIndividualGraphData.LEQ0_3};
			var individual_quarter_D1 = ${gridFaceTimeIndividualGraphData.LEQ0_4};
			var individual_quarter_E1 = ${gridFaceTimeIndividualGraphData.LEQ0_5};
			var individual_quarter_F1 = ${gridFaceTimeIndividualGraphData.LEQ0_6};
			var individual_quarter_G1 = ${gridFaceTimeIndividualGraphData.LEQ0_7};
			var individual_quarter_H1 = ${gridFaceTimeIndividualGraphData.LEQ0_8};
			
			var individual_quarter_A2 = ${gridFaceTimeIndividualGraphData.LEQ1_1};
			var individual_quarter_B2 = ${gridFaceTimeIndividualGraphData.LEQ1_2};
			var individual_quarter_C2 = ${gridFaceTimeIndividualGraphData.LEQ1_3};
			var individual_quarter_D2 = ${gridFaceTimeIndividualGraphData.LEQ1_4};
			var individual_quarter_E2 = ${gridFaceTimeIndividualGraphData.LEQ1_5};
			var individual_quarter_F2 = ${gridFaceTimeIndividualGraphData.LEQ1_6};
			var individual_quarter_G2 = ${gridFaceTimeIndividualGraphData.LEQ1_7};
			var individual_quarter_H2 = ${gridFaceTimeIndividualGraphData.LEQ1_8};

			var individual_quarter_A3 = ${gridFaceTimeIndividualGraphData.LEQ2_1};
			var individual_quarter_B3 = ${gridFaceTimeIndividualGraphData.LEQ2_2};
			var individual_quarter_C3 = ${gridFaceTimeIndividualGraphData.LEQ2_3};
			var individual_quarter_D3 = ${gridFaceTimeIndividualGraphData.LEQ2_4};
			var individual_quarter_E3 = ${gridFaceTimeIndividualGraphData.LEQ2_5};
			var individual_quarter_F3 = ${gridFaceTimeIndividualGraphData.LEQ2_6};
			var individual_quarter_G3 = ${gridFaceTimeIndividualGraphData.LEQ2_7};
			var individual_quarter_H3 = ${gridFaceTimeIndividualGraphData.LEQ2_8};
			*/
			
			var data = google.visualization.arrayToDataTable([
				['Genre', '고객대면', '대면준비', '내부회의', '교육', '기타', '휴가', '이동시간', '미입력'],
				[individual_now_quarter, individual_now_quarter_A, individual_now_quarter_B, individual_now_quarter_C, individual_now_quarter_D,  individual_now_quarter_F,  individual_now_quarter_G,  individual_now_quarter_E, individual_now_quarter_H]
				//[individual_now_month1, individual_quarter_A1, individual_quarter_B1, individual_quarter_C1, individual_quarter_D1,  individual_quarter_F1,  individual_quarter_G1,  individual_quarter_E1, individual_quarter_H1],
				//[individual_now_month2, individual_quarter_A2, individual_quarter_B2, individual_quarter_C2, individual_quarter_D2,  individual_quarter_F2,  individual_quarter_G2,  individual_quarter_E2, individual_quarter_H2],
				//[individual_now_month3, individual_quarter_A3, individual_quarter_B3, individual_quarter_C3, individual_quarter_D3,  individual_quarter_F3,  individual_quarter_G3,  individual_quarter_E3, individual_quarter_H3]
			]);
			
			var view = new google.visualization.DataView(data);
			
			var options_fullStacked = {
				isStacked: 'percent',
				//width:600,
				//height: 500,
				legend: {position: 'top', maxLines: 3},
				//colors: ['#00b0f0', '#00cc99', '#c33f3f'],
				vAxis: {
				minValue: 0,
				}
			};
			
			
			
			
			
			
			var data2;

			var type = '<c:out value="${param.viewType}"/>';
			
			<c:choose>
				<c:when test="${gridFaceTimeGraphData.VIEWTYPE == 'y'}">
					var now_quarter1 = '1분기';
					var now_quarter2 = '2분기';
					var now_quarter3 = '3분기';
					var now_quarter4 = '4분기';
					
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
					
					var quarter_A4 = ${gridFaceTimeGraphData.LEQ3_1};
					var quarter_B4 = ${gridFaceTimeGraphData.LEQ3_2};
					var quarter_C4 = ${gridFaceTimeGraphData.LEQ3_3};
					var quarter_D4 = ${gridFaceTimeGraphData.LEQ3_4};
					var quarter_E4 = ${gridFaceTimeGraphData.LEQ3_5};
					var quarter_F4 = ${gridFaceTimeGraphData.LEQ3_6};
					var quarter_G4 = ${gridFaceTimeGraphData.LEQ3_7};
					var quarter_H4 = ${gridFaceTimeGraphData.LEQ3_8};
		
					
					data2 = google.visualization.arrayToDataTable([
						['Genre', '고객대면', '대면준비', '내부회의', '교육', '기타', '휴가', '이동시간', '미입력'],
						['1분기', quarter_A1, quarter_B1, quarter_C1, quarter_D1,  quarter_F1,  quarter_G1,  quarter_E1, quarter_H1],
						['2분기', quarter_A2, quarter_B2, quarter_C2, quarter_D2,  quarter_F2,  quarter_G2,  quarter_E2, quarter_H2],
						['3분기', quarter_A3, quarter_B3, quarter_C3, quarter_D3,  quarter_F3,  quarter_G3,  quarter_E3, quarter_H3],
						['4분기', quarter_A4, quarter_B4, quarter_C4, quarter_D4,  quarter_F4,  quarter_G4,  quarter_E4, quarter_H4]
					]);
					
					var view2 = new google.visualization.DataView(data2);
					
				</c:when>
				<c:when test="${gridFaceTimeGraphData.VIEWTYPE == 'm' || gridFaceTimeGraphData.VIEWTYPE == 'q' }">
				
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
		
					
					data2 = google.visualization.arrayToDataTable([
						['Genre', '고객대면', '대면준비', '내부회의', '교육', '기타', '휴가', '이동시간', '미입력'],
						[now_quarter, now_quarter_A, now_quarter_B, now_quarter_C, now_quarter_D,  now_quarter_F,  now_quarter_G,  now_quarter_E, now_quarter_H],
						[now_month1, quarter_A1, quarter_B1, quarter_C1, quarter_D1,  quarter_F1,  quarter_G1,  quarter_E1, quarter_H1],
						[now_month2, quarter_A2, quarter_B2, quarter_C2, quarter_D2,  quarter_F2,  quarter_G2,  quarter_E2, quarter_H2],
						[now_month3, quarter_A3, quarter_B3, quarter_C3, quarter_D3,  quarter_F3,  quarter_G3,  quarter_E3, quarter_H3]
					]);
					
					var view2 = new google.visualization.DataView(data2);
					
				</c:when>
			</c:choose>
			
			
			
			var options_fullStacked = {
				isStacked: 'percent',
				//width:600,
				//height: 500,
				legend: {position: 'top', maxLines: 3},
				//colors: ['#00b0f0', '#00cc99', '#c33f3f'],
				vAxis: {
				minValue: 0,
				}
			};
			
			var chart = new google.visualization.BarChart(document.getElementById("barchart_values"));
			chart.draw(view, options_fullStacked);
			
			var chart2 = new google.visualization.ColumnChart(document.getElementById("quarter_values"));
			chart2.draw(view2, options_fullStacked);
		}

	
</script>


<!-- 그래프 삽입영역 -->
<div class="row">
    <div class="col-lg-6 col-sm-12">
        <div class="ibox">
            <div class="ibox-title">
                <h5>부서 생산성</h5>
                	<!-- 박스 접기기능  -->
					<div class="ibox-tools">
					    <a class="collapse-link">
					        <i class="fa fa-chevron-up"></i>
					    </a>
					</div>
					<!--// 박스 접기기능  -->
            </div>
            <div class="ibox-content">
                <div id="barchart_values"></div>
            </div>
        </div>
    </div>

    <div class="col-lg-6 col-sm-12">
        <div class="ibox">
            <div class="ibox-title">
                <h5>기간별 추이</h5>
                	<!-- 박스 접기기능  -->
					<div class="ibox-tools">
					    <a class="collapse-link">
					        <i class="fa fa-chevron-up"></i>
					    </a>
					</div>
					<!--// 박스 접기기능  -->
            </div>
            <div class="ibox-content">
                <div id="quarter_values"></div>
            </div>
        </div>
    </div>
</div>
<!--// 그래프 삽입영역 -->




