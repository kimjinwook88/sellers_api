var googleChart = {
		
	/**
	 * 구글 차트 로드
	 * @param callback : 콜백함수
	 * @returns
	 */
	load : function (callback){
		google.charts.load('current', {packages: ['corechart']});
		// 차트가 load 된 후에 차트를 그릴 callback 함수가 호출됨
		google.charts.setOnLoadCallback(callback);
	}
}

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var GoogleChart = function GoogleChart() {
	_classCallCheck(this, GoogleChart);

	/**
  * 컬럼형 차트 (세로형 막대)
  * 데이터테이블 :  ['Element',   범례1,  범례2, ..., { role: 'style'}]
  * 			    [요소명, 		  값1,   값2, ..., '스타일']
  * 			    [요소명,        값1,   값2, ..., '스타일']
  * @returns
  */
	this.columnChart = {
		options: {
			animation: { startup: true, // 그래프가 그려질 때 애니메이션 실행
				duration: 700, // 애니메이션 지속시간
				easing: 'out' }, // 애니메이션 빠르게 시작해서 느리게 끝나는 종류
			chartArea: { width: '80%', // 차트 크기 조절
				height: '75%' },
			legend: { textStyle: { fontSize: 12 }, // 범례 텍스트 스타일
				position: 'top', // 범례위치
				maxLines: 2 }, // 창의 길이가 짧아졌을 때 범례를 두 줄로 표시
			series: { 6: { color: 'white', visibleInLegend: 'false' } }, // bar의 색상 변경, '미입력'인 6번 범례는 표시하지 않음
			vAxis: { textStyle: { fontSize: 12 },
				minValue: 0, viewWindow: { min: 0 }, //y축 기준점 0
				/*ticks: [0, 0.2, 0.4, 0.6, 0.8, 1],	*/ // y축의 간격
				gridlines: { color: 'rgb(230, 230, 230)' }, // y축 라인 색상 변경
				minorGridlines: { color: 'white' } }, // y축 보조라인 색상 변경
			hAxis: { textStyle: { fontSize: 12 } }, // x축 텍스트 스타일
			isStacked: false // 각 데이터 시리즈가 전체 가치의 100%에 기여함(한 컬럼의 값들을 100% 합쳐서 표현)
		},
		draw: function draw(columns, chartData, elementId) {
			var chartColArr = ['Element'];
			chartColArr = chartColArr.concat(columns);

			var chartArr = [];
			chartArr.push(chartColArr);
			chartArr = chartArr.concat(chartData);

			// 차트에 적용할 데이터 테이블 생성
			var data = google.visualization.arrayToDataTable(chartArr);

			// 차트를 인스턴스화 한 후 데이터와 옵션을 전달하여 차트를 그림
			var chart = new google.visualization.ColumnChart(document.getElementById(elementId));
			var options = this.options;
			chart.draw(data, options);

			// 반응형 차트
			window.addEventListener('resize', function () {
				chart.draw(data, options);
			}, false);
		}
	}, 
	
	this.bubbleChart = {
		options: {
			//title: '영업기회 현황',
			//hAxis: {title: '계약일'},
			//vAxis: {title: '예상계약금액'},
			chartArea: { 
				width: '85%', // 차트 크기 조절
				height: '75%' },
			series: {'': {
				//visibleInLegend: false,
				color : '#ffffff'
				}
			},
			hAxis: {
				title: '계약일',
				//ticks: [1,2,3,4,5,6], 
				textStyle: {
					color: '#999',
					bold: true
					//fontName: 'Arial Unipoint'
				},
				gridlines: {
					color: '#696966'
				},
				titleTextStyle: {
					italic: '0'
				},
				gridlines: {
					color: '#f3f3f4'
				},
				//ticks: data.getDistinctValues(0),
				format: 'YY/MM/dd'
			},
			vAxis: {
				title: '예상계약금액(백만)',
				maxValue : 3000,
				viewWindow: {
			        min: 1,
			        max: 3500
			    },
				ticks: [1, 500, 1000, 1500, 2000, 2500, 3000, 3500],
				textStyle: {
					color: '#999',
					bold: true
				},
				gridlines: {
					color: '#696966'
				},
				titleTextStyle: {
					italic: '0'
				},
				gridlines: {
					color: '#f3f3f4'
				},
				scaleType : 'log',
			},
			pointSize: 1,
			colorAxis: {
				minValue: 0,
				maxValue: 2,
				legend: {
					position: 'none' //색상 범례 설정
				}
			},
			legend: {
				position: 'top'
			},
			explorer: {
				//actions: ['scrollToZoom', 'rightClickToReset'], //마우스 휠 줌인아웃, 마우스 우클릭 리셋
				maxZoomIn: 1,
				maxZoomOut: 1,
				keepInBounds : true,
				axis: 'horizontal'
					
			},
			bubble: {
				/*textStyle: {
			    	//auraColor: 'none',
			    	italic: true,
			    	fontSize: 9
			    }*/
			},
			sizeAxis: { minValue: 0, maxSize: 5 }, //원크기 조정
			//animation:{easing:'in'},
			tooltip: {
				trigger: 'none'
			},
			backgroundColor: {
		        stroke: 'white',
		        strokeWidth: 0,
		        fill: 'white'
		     }
		},

		draw: function draw(columns, chartData, elementId, dateCategory) {
			/*var chartColArr = [];
		   chartColArr = chartColArr.concat(columns);
		   
		   var chartArr = [];
		   chartArr.push(chartColArr);
		   chartArr = chartArr.concat(chartData);
		   console.log(chartArr);
		   
		   // 차트에 적용할 데이터 테이블 생성
		   var data = google.visualization.arrayToDataTable(chartArr);*/

			//차트 컬럼테이블 양식생성
			var data = new google.visualization.DataTable();

			if (columns) {
				for (var i = 0; i < columns.length; i++) {
					data.addColumn(columns[i]);
				}
			}

			if (chartData) {
				for (var i = 0; i < chartData.length; i++) {
					var dataDateTime = new Date(chartData[i][1]);
					data.addRows([[
						chartData[i][0], //고객사명 endUser
						dataDateTime, //계약일
						parseInt(chartData[i][2]), //계약금액(백만원)
						chartData[i][7], //영업기회 본부,팀 //추후 사용 winRate
						2, //추후 사용 winRate
						parseInt(chartData[i][3]), //영업기회id
						parseInt(chartData[i][4]), //고객사id
						chartData[i][5], //영업기회 영업대표 이름
						chartData[i][6], //영업기회 제목
						chartData[i][8] //계약금액(원)
					]]);
				}
			}

			// 차트를 인스턴스화 한 후 데이터와 옵션을 전달하여 차트를 그림
			var chart = new google.visualization.BubbleChart(document.getElementById(elementId));
			var options = this.options;
			chart.draw(data, options);

			//버블차트는 tooltip 옵션 지원안해서 만들어씀..
			var mouseX;
			var mouseY;
			$('#oppData').mousemove(function (e) {
				mouseX = e.offsetX+40;
				mouseY = e.offsetY+10;
			});
			
			var datePattern = /^\d{2}\/(0[1-9]|1[012])\/(0[1-9]|[12][0-9]|3[0-1])$/;
			var tagNavi = '#chart_div > div > div:nth-child(1) > div > svg > g:nth-child(4) > g:nth-child(4) > g';
			var dateX = [];
			
			//function wheelSetData(e ,callback){
			function wheelSetData(e){
				dateX = [];
				for(var i=0; i<$(tagNavi).length; i++){
					var txt = $(tagNavi+':nth-child('+i+') > text').text();
					if(!(typeof txt === 'undefined')){
						if(datePattern.test(txt)){
							dateX.push({
								date : txt,
								x : $(tagNavi+':nth-child('+i+') > text')[0].attributes[1].nodeValue
							});
						}
					}
				}
				//callback(e);
				wheelGetData(e);
			}
			
			function wheelGetData(e){
				if(!(dateCategory == 'm' && e.originalEvent.wheelDelta >= 0) && !(dateCategory == 'y' && e.originalEvent.wheelDelta <= 0)){
					var wheelX = e.offsetX;
					
					var min = dateX[dateX.length-1].x;
					var near = "";
				    var abs = 0;
					for(var i=0; i<dateX.length; i++){
						abs = ((dateX[i].x - wheelX) < 0) ? - (dateX[i].x - wheelX) : (dateX[i].x - wheelX);
						if(abs < min){
							min = abs;
							near = dateX[i].date;
						}
					}
					bubbleChart.data.searchStartDate = '20' + near.replace(/\//g,"-");
					if(e.originalEvent.wheelDelta >= 0){
						if(dateCategory == 'y'){
							$("input[name='radioViewTypeBubbleChart']:radio[value='q']").prop("checked", true) ;
						}else if(dateCategory == 'q'){
							$("input[name='radioViewTypeBubbleChart']:radio[value='m']").prop("checked", true) ;
						}
					}else{
						if(dateCategory == 'm'){
							$("input:radio[name='radioViewTypeBubbleChart']:radio[value='q']").prop("checked", true) ;
						}else if(dateCategory == 'q'){
							$("input:radio[name='radioViewTypeBubbleChart']:radio[value='y']").prop("checked", true) ;
						}
					}
					bubbleChart.data.searchDateCategory = $("input[name='radioViewTypeBubbleChart']:checked").val();
					var dateMap = commonDate.naviDate(bubbleChart.data.searchDateCategory, bubbleChart.data.searchStartDate, 0);
					bubbleChart.naviSetDate(dateMap); 
					bubbleChart.get(bubbleChart.data.cdFlag);
				}
			}
			
			$('#chart_div > div > div:nth-child(1) > div > svg > g:nth-child(4) > rect').on('DOMMouseScroll mousewheel', function(e){
				//wheelSetData(e, wheelGetData);
				//wheelSetData(e);
				e.preventDefault();
				e.stopPropagation();
			});
			
			google.visualization.events.addListener(chart, 'select', function(e) {
			   	var selectedItem = chart.getSelection()[0];
			   	selectedItem = data.wg[selectedItem.row].c;
			   	
			   	if(!isEmpty(selectedItem[0].v)){
			   		main.goDetail(selectedItem[5].v,'1');
			   		chart.setSelection([]); //선택해제
			   	}else{
			   		chart.setSelection([]); //선택해제
			   	}
		   		
			});
			
			google.visualization.events.addListener(chart, 'drag', function (e) {
				//alert('drag');
				bubbleChart.get(true);
			});

			google.visualization.events.addListener(chart, 'onmouseover', function (e) {
				//$(this).after('<g class="google-visualization-tooltip"></g>');
				var x = mouseX;
				var y = mouseY;
				var selectedItem = data.eg[e.row].c;
				
				if (!isEmpty(selectedItem[0].v)) {
					var amount = (selectedItem[9].v).toString();
					$('div.google_chart').html(
							'<div class="pop_googleChart_tooltip" id="custom_tooltip" style="display: none;"><div>'
					);
					$('#custom_tooltip').html(
							'<div>사업명 : ' + selectedItem[8].v + 
							'<br/>고객사 : ' + selectedItem[0].v + 
							'<br/>영업대표 : ' + selectedItem[7].v + 
							'<br/>계약금액 : ' + add_comma(amount) + '원' +
							'<br/>계약일 : ' + moment(selectedItem[1].v).format('YYYY/MM/DD') + '</div>'
					).css({ 'top': y, 'left': x }).fadeIn('slow');
					$('#custom_tooltip').click(function() {
						main.goDetail(selectedItem[5].v,'1');
					});
				}
			});
			
			google.visualization.events.addListener(chart, 'onmouseout', function (e) {
				$('#custom_tooltip').fadeOut('fast');
			});
			
			// 반응형 차트
			window.addEventListener('resize', function () { 
				chart.draw(data, options); 
				//wheelSetData(null, null);
				}, false);
		}
	},
	
	this.donutChart = {
			options : {
				  width : '100%',
				  legend: 'none',
				  pieSliceBorderColor : "transparent",  // 파이 슬라이스 테두리 투명하게
				  chartArea : {	width: '100%',	
					  			height: '80%'}, 
	  			  pieSliceText:'none',
		          pieStartAngle: 270,
		          tooltip :  {	text : 'value',
		        	  			textStyle : {
		        	  				fontSize  : 16,
		        	  				color : '#58575e'
		        	  			}
				  			},
		          slices: {
		            0: { color: '#0073ae' },
		            1: { color: '#81bef7' },
		            2: { color: '#ededed',
		            	textStyle : {
		            		opacity : 0,
		            		color : 'transparent'
		            	}
		            },
		            3: { color: 'transparent'}
		          },
		          pieSliceTextStyle : {
		        	color : 'black',
		        	fontSize : 20,
		        	fontWeight : 'bold'
		          },
		          pieHole: 0.5,
		          animation:{
		        	    duration: 100,
		        	    easing: 'out',
		        	    startup: true //This is the new option
	        	  }
			},
			tooltipTest : function(columns, chartData, chartTooltips, elementId){
				
				var chartArr = [];
				chartArr.push(['Effort', 'Amount given', {type: 'string', role: 'tooltip'}]);
				
				var l = columns.length;
				
				for(var i=0; i<l; i++){
					chartArr.push([columns[i], chartData[i], chartTooltips[i]]);
				}
				
				// 차트에 적용할 데이터 테이블 생성
				var data = google.visualization.arrayToDataTable(chartArr);
				
				// 차트를 인스턴스화 한 후 데이터와 옵션을 전달하여 차트를 그림
				var chart = new google.visualization.PieChart(document.getElementById(elementId));
				
				var options = this.options;
				chart.draw(data, options);
				
				//				var percent = 0;
//				// start the animation loop
//				var handler = setInterval(function(){
//				    // values increment
//				    percent += 3;
//				    // apply new values
//				    data.setValue(0, 1, percent);
//				    data.setValue(1, 1, 100 - percent);
//
//				    // update the pie
//				    chart.draw(data, options);
//				    // check if we have reached the desired value
//				    if (percent > 25)
//				        // stop the loop
//				        clearInterval(handler);
//				}, 1);
				
				// 값이 없는 슬라이스에서 툴팁을 띄우지 않음
				google.visualization.events.addListener(chart, 'onmouseover', function(e){
					var selectItem = data.eg[e.row].c;
					if(selectItem[0].v == 'gray'){
						$('.google-visualization-tooltip').remove();
					}
				});
				
				// 값이 없는 슬라이스를 클릭했을때 툴팁을 띄우지 않음
				google.visualization.events.addListener(chart, 'select', function(e) {
					var selectedItem = chart.getSelection()[0];
					selectedItem = data.jc[selectedItem.row][0];
					chart.setSelection([]); //선택해제
					if(selectedItem.gf == 'gray'){
						$('.google-visualization-tooltip').remove();
						return false;
				   	}
			   		
				});
				
				// 반응형 차트
				window.addEventListener('resize', function() { chart.draw(data, options); }, false);
					
			},
			draw : function(columns, chartData, elementId){
				
				var chartArr = [];
				chartArr.push(['Effort', 'Amount given']);
				
				var l = columns.length;
				
				for(var i=0; i<l; i++){
					chartArr.push([columns[i], chartData[i]]);
				}
				
				// 차트에 적용할 데이터 테이블 생성
				var data = google.visualization.arrayToDataTable(chartArr);
				
				// 차트를 인스턴스화 한 후 데이터와 옵션을 전달하여 차트를 그림
				var chart = new google.visualization.PieChart(document.getElementById(elementId));
				
				var options = this.options;
				chart.draw(data, options);
				
				//				var percent = 0;
//				// start the animation loop
//				var handler = setInterval(function(){
//				    // values increment
//				    percent += 3;
//				    // apply new values
//				    data.setValue(0, 1, percent);
//				    data.setValue(1, 1, 100 - percent);
//
//				    // update the pie
//				    chart.draw(data, options);
//				    // check if we have reached the desired value
//				    if (percent > 25)
//				        // stop the loop
//				        clearInterval(handler);
//				}, 1);
									
				// 반응형 차트
				window.addEventListener('resize', function() { chart.draw(data, options); }, false);
						
			}
	}
}; //constructor
