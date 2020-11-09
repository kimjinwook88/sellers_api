<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.c3-line {
stroke-width: 2.5px;
}
</style>

<script type="text/javascript">
var len2 = ${fn:length(selectOpportunityDashBoardOpp2)};

var columnData = new Array();

var NameArr = ["성과", "IN", "OUT"];
var titleArr = new Array(); // 카테고리 이름용 배열

for(var i = 0; i < len2; i++){
	eval('var names' + i); //부서명
	
	eval('var forecast_in' + i);
	eval('var forecast_out' + i);
	eval('var result_amount' + i);
	
	eval('var YesArr' + i + ' = new Array();');
}

//그래프 y측 설정 
var numArr = [];			// 데이터 숫자
var uniqueNum = [];		// numArr에서 모든 숫자중에서 중복된 숫자가 제거

<c:forEach items="${selectOpportunityDashBoardOpp2}" var="selectOpportunityDashBoardOpp2" varStatus="status">
	
	forecast_in${status.index} = ["${selectOpportunityDashBoardOpp2.FORECAST_IN}"];
	forecast_out${status.index} = ["${selectOpportunityDashBoardOpp2.FORECAST_OUT}"];
	result_amount${status.index} = ["${selectOpportunityDashBoardOpp2.RESULT_AMOUNT}"];
	
	for(var i =0; i < 7; i++){
		numArr.push("${lineGraphData.LIKEABILITY_CNT}", "${lineGraphData.RELATION_CNT}", "${selectOpportunityDashBoardOpp2.RESULT_AMOUNT}");
	}
	
	YesArr${status.index}.push(forecast_in${status.index}, forecast_out${status.index}, result_amount${status.index}); // 데이터 들어가는거
	
	columnData.push(
		<c:if test="${status.index == 0}">
			NameArr,
		</c:if>
		YesArr${status.index}
	);
</c:forEach>

columnData.splice(1, 4);

$.each(numArr, function(i, el){
	if($.inArray(el, uniqueNum) === -1) uniqueNum.push(el);
});


var data;
if(len2 > 0){
	data = columnData;
}else{
	var Ary = new Array();
	Ary = [
				NameArr,
				[0,0,0],
				[0,0,0],
				[0,0,0],
				[0,0,0]
			]
	data = Ary;
}

var maxValue = Math.max.apply(null, uniqueNum);

var chart2 = c3.generate({
	bindto: "#ForeCastTimeSeriesGraph",
	data: {
		rows : data,
		labels: true,
		colors: {
			성과: '#FF7F0F',
			IN: '#2EA02E',
			OUT: '#D72C2D'
		},
	},
	axis: {
		x: {
			//show:false
			type: 'category',
			categories: ['W-3', 'W-2', 'W-1', 'W']
		},
		y: {
			/* padding: { bottom:0}, */
			padding : {top: 700, bottom: 0},
		}
	},
    line: {
    	  size: {
    		  height: 3
    	  }
    	}
});
</script>

<div id="ForeCastTimeSeriesGraph"></div>
