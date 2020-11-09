<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
.c3-line {
stroke-width: 2.5px;
}
</style>

<script type="text/javascript">
	
	var len2 = ${fn:length(lineGraphData)};
	
	var columnData = new Array();
	
	var NameArr = ["고객수","관계수립","호감도"];
	var titleArr = new Array(); // 카테고리 이름용 배열
	
	for(var i = 0; i < len2; i++){
		eval('var names' + i); //부서명
		
		eval('var total_cnt' + i);
		eval('var Likeability' + i);
		eval('var Relation' + i);
		
		eval('var dataArr' + i + ' = new Array();');
	}
	
	var likeAbility = [];
	var relation = [];
	
	// 그래프 y측 설정 
	var numArr = [];			// 데이터 숫자
	var uniqueNum = [];		// numArr에서 모든 숫자중에서 중복된 숫자가 제거
	<c:forEach items="${lineGraphData}" var="lineGraphData" varStatus="status">
		
		total_cnt${status.index} = ["${lineGraphData.TOTAL_CNT}"];	// 호감도
		Likeability${status.index} = ["${lineGraphData.LIKEABILITY_CNT}"];	// 호감도
		Relation${status.index} = ["${lineGraphData.RELATION_CNT}"];	// 관계수립
		
		for(var i =0; i < 7; i++){
			numArr.push("${lineGraphData.TOTAL_CNT}", "${lineGraphData.LIKEABILITY_CNT}", "${lineGraphData.RELATION_CNT}");
		}
		
		dataArr${status.index}.push(total_cnt${status.index}, Relation${status.index}, Likeability${status.index}); // 데이터 들어가는거
		
		// 테스트
		//chart js 데이터 넣는거 테스트 
		//likeAbility.push(Likeability${status.index});
		//relation.push(Relation${status.index});
		
		columnData.push(
			<c:if test="${status.index == 0}">
				 NameArr, 
			</c:if>
			dataArr${status.index}
		);
	</c:forEach>
	
	// 중복된 숫자 제거 
	$.each(numArr, function(i, el){
		if($.inArray(el, uniqueNum) === -1) uniqueNum.push(el);
	});
	
	var maxValue = Math.max.apply(null, uniqueNum);
	var minValue = Math.min.apply(null, uniqueNum);
	//console.log(uniqueNum);
	//console.log(maxValue);

	
	columnData.splice(1, 4);
	
	var chart2 = c3.generate({
		bindto: "#RelationTimeSeriesGraph",
		data: {
			rows : columnData,
			labels: true,
			colors: {
				관계수립 : '#FF7F0F',
				호감도 : '#2EA02E'
			},
		},
		axis: {
			x: {
				//show:false
				type: 'category',
				categories: ['W-3', 'W-2', 'W-1', 'W']
			},
			y: {
				tick: {
					//max: maxValue,
					//min: minValue,
					// 소수점 제거
					format: function(value) {if (value % 1 === 0) {return value;}}
				}
			}
		},
		line: {
				size: {
					height: 3
				}
			}
	});
	
	
	
	//**********************************************************************************************************
	//*********************************************CHART JS TEST 2018-11-05 ****************************************
	//**********************************************************************************************************
	
	//var likeAbility = [];
	//var relation = [];
	
	//console.log(likeAbility);
	//console.log(relation);
	/*
	var asd = [
		{
			data:likeAbility,
			//data:[1,1,1,1,1,1,1,1],
			label: "관계수립",	
			borderColor: "#3e95cd",
			backgroundColor:'rgba(255, 255, 255, 0.1)',
			pointHitRadius : 250/20,
			lineTension : 0,
			borderWidth:1,
			pointBackgroundColor : '#3e95cd'
		},
		{
			data:relation,
			//data:[2,2,2,2,2,2,2,2],
			label: "호감도",
			borderColor: "#ff6384",
			backgroundColor:'rgba(255, 255, 255, 0.1)',
			pointHitRadius : 250/20,
			lineTension : 0,
			borderWidth:1,
			pointBackgroundColor : '#ff6384'
		}
	]
	
	var asd2 = [
	   		{
	   			//data:likeAbility,
	   			data:[100,251,169,201,132,182,210,130],
	   			label: "관계수립",	
	   			borderColor: "#3e95cd",
	   			backgroundColor:'#3e95cd',
	   			pointHitRadius : 250/20,
	   			lineTension : 0
	   		},
	   		{
	   			//data:relation,
	   			data:[200,165,222,124,225,171,164,205],
	   			label: "호감도",
	   			borderColor: "#ff6384",
	   			backgroundColor:'#ff6384',
	   			pointHitRadius : 250/20,
	   			//lineTension : 0
	   		}
	   	]
	
	//배경색 투명
	//backgroundColor:'rgba(255, 255, 255, 0.1)',
	
	var ctx = document.getElementById('myChart').getContext('2d');
	var chart = new Chart(ctx, {
	    // The type of chart we want to create
	    type: 'line',
	    // The data for our dataset
	    data: {
	    	labels: ['W-7', 'W-6', 'W-5', 'W-4', 'W-3', 'W-2', 'W-1', 'W'],
	    	//labels: ['W-3', 'W-2', 'W-1', 'W'],
            datasets: asd /* [{
                data: a, //[10, 20, 30],
                borderColor : '#ff6384',
                pointHitRadius : 250/20,
                //backgroundColor : '#36a2eb'
                backgroundColor:'rgba(255, 255, 255, 0.1)',
            }]
	    },

	    // Configuration options go here
	    options: {
	    	scales: {
	    	      yAxes: [{
	    	        ticks: {
	    	          beginAtZero: true,
	    	          //distribution: 'linear',
	    	          max : maxValue,
	    	          min: minValue,
	    	          //max: 1,
	    	          //min:0,
	    	          callback: function(value) {if (value % 1 === 0) {return value;}}
	    	        }
	    	      }]
	    	    }
	    	,responsive: true,
	    	bounds :'ticks',
	    	legend: {
		    	position : 'bottom'
	    	}
	    }
	    
	});
	
	
	var ctx2 = document.getElementById('myChart2').getContext('2d');
	var myBarChart = new Chart(ctx2, {
	    type: 'bar',
	    data: {
	    	labels: ['W-7', 'W-6', 'W-5', 'W-4', 'W-3', 'W-2', 'W-1', 'W'],
	    	//labels: ['W-3', 'W-2', 'W-1', 'W'],
            datasets: asd2
	    },
	    options: {
	    	scales: {
	    	      yAxes: [{
	    	    	//stacked: true,
	    	        ticks: {
	    	          beginAtZero: true,
	    	          //distribution: 'linear',
	    	          //max : maxValue + maxValue,
	    	          //min: minValue,
	    	          //max: 1,
	    	          //min:0,
	    	          callback: function(value) {if (value % 1 === 0) {return value;}}
	    	        }
	    	      }],
	    	      xAxes: [{
	                  //stacked: true
	              }],
	    	    }
	    	,responsive: true,
	    	bounds :'ticks',
	    	legend: {
		    	position : 'bottom'
	    	}
	    }
	});
	*/
	//**********************************************************************************************************
	//*********************************************CHART JS TEST 2018-11-05 ****************************************
	//**********************************************************************************************************
	
	
	
	
	
	//**********************************************************************************************************
	//*********************************************JELLY-CHART JS TEST 2018-11-05 ***********************************
	//**********************************************************************************************************
	/*
	var bar = jelly.type('bar');
	bar.container('#jelly_chart')
	  .data([
	    {x: 'A', y: 10},
	    {x: 'A', y: 20},
	    {x: 'B', y: 15},
	    {x: 'B', y: 10}
	  ])
	  .dimensions(['x'])
	  .measures(['y'])

	bar.render(); 
	*/
	
	
	
	//**********************************************************************************************************
	//*********************************************JELLY-CHART JS TEST 2018-11-05 ****************************************
	//**********************************************************************************************************
</script>

<div id="RelationTimeSeriesGraph"></div>
