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

	/* 기간별 추이 그래프 */
	
	var len = ${fn:length(ContactTransitionData)};
	var columnData2 = new Array();
	
	var NameArr = ['방문', 'E-mail','SNS','마케팅','전화'];
	var titleArr = new Array(); // 카테고리 이름용 배열
	
	for(var i = 0; i < len; i++){
		eval('var names' + i); //부서명
		
		eval('var visted' + i);
		eval('var marketing' + i);
		eval('var sns' + i);
		eval('var email' + i);
		eval('var phone' + i);
		
		eval('var EMPArr' + i + ' = new Array();');
	}
	
	var vistedArr = ['방문'];
	var emailArr = ['E-mail'];
	var snsArr = ['SNS'];
	var marketingArr = ['마케팅'];
	var phoneArr = ['전화'];
	
	// 그래프 y측 설정 
	var numArr = [];			// 데이터 숫자
	var uniqueNum = [];		// numArr에서 모든 숫자중에서 중복된 숫자가 제거
	
	<c:forEach items="${ContactTransitionData}" var="ContactTransitionData" varStatus="status">
		visted${status.index} = ["${ContactTransitionData.CONTACT_0}"];
		email${status.index} = ["${ContactTransitionData.CONTACT_1}"];
		sns${status.index} = ["${ContactTransitionData.CONTACT_2}"];		
		marketing${status.index} = ["${ContactTransitionData.CONTACT_3}"];
		phone${status.index} = ["${ContactTransitionData.CONTACT_4}"];
		
		for(var i =0; i < 7; i++){
			numArr.push("${ContactTransitionData.CONTACT_0}","${ContactTransitionData.CONTACT_1}"
					,"${ContactTransitionData.CONTACT_2}","${ContactTransitionData.CONTACT_3}"
					,"${ContactTransitionData.CONTACT_4}"
			);
		}
		
		vistedArr.push("${ContactTransitionData.CONTACT_0}");
		emailArr.push("${ContactTransitionData.CONTACT_1}");
		snsArr.push("${ContactTransitionData.CONTACT_2}");
		marketingArr.push("${ContactTransitionData.CONTACT_3}");
		phoneArr.push("${ContactTransitionData.CONTACT_4}");
		
		
		EMPArr${status.index}.push(
				visted${status.index}
				,email${status.index}
				,sns${status.index}
				,marketing${status.index}
				,phone${status.index}
		); // 데이터 들어가는거
		
		columnData2.push(
			<c:if test="${status.index == 0}">
				NameArr,
			</c:if>
				EMPArr${status.index}
		);
	</c:forEach>
	
	// 4주로 설정하기 위한 값을 자름
	vistedArr.splice(1,4);
	emailArr.splice(1,4);
	snsArr.splice(1,4);
	marketingArr.splice(1,4);
	phoneArr.splice(1,4);
	
	columnData2.splice(1, 4);
	
	var dataArr = [vistedArr , emailArr , snsArr, marketingArr , phoneArr];
	
	// 중복된 숫자 제거 
	$.each(numArr, function(i, el){
		if($.inArray(el, uniqueNum) === -1) uniqueNum.push(el);
	});
	
	// 값들중에 최대 숫자
	var maxValue = Math.max.apply(null, uniqueNum);
	var minValue = Math.min.apply(null, uniqueNum);
	
	
	if(maxValue > 1 || maxValue != null){
		var chart2 = c3.generate({
			bindto: "#ContactTimeSeriesGraph",
			data: {
				//rows : columnData2,
				columns : dataArr,
				type: 'line',
				/* groups: [
					['방문', 'E-mail','SNS','마케팅','전화']
				] */
			},
			axis: {
				x: {
					//show:false
					type: 'category',
					categories: ['w-3','w-2','w-1','w'] //NameArr
				} ,
				y: {
					max: maxValue,
					min: minValue,
					// Range includes padding, set 0 if no padding needed
				}
			},
			line: {
				size: {
					height:3
				}
			}
		});
	}else{
		var chart2 = c3.generate({
			bindto: "#ContactTimeSeriesGraph",
			data: {
				//rows : columnData2,
				columns : dataArr,
				type: 'line',
				/* groups: [
					['방문', 'E-mail','SNS','마케팅','전화']
				] */
			},
			axis: {
				x: {
					//show:false
					type: 'category',
					categories: ['w-3','w-2','w-1','w'] //NameArr
				},
				y: {
					padding: {
							top: 500,
							bottom: 0
						},
					tick: {
						values: [0,1,2],
					}
				}
			},
			line: {
				size: {
					height: 3
				}
			}
		});
	}
	

	
</script>
<div id="ContactTimeSeriesGraph"></div>
