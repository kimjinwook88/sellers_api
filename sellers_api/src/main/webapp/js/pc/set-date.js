
var setDate = {
		
		/**
		 * 년도, 달, 분기 select 박스 셋팅
		 * @param selectYear
		 * @param selectMonth
		 * @param selectQuarter
		 * @param viewType
		 * @returns
		 */
		appendOption : function(selectFaceYear, selectFaceMonth, selectFaceQuarter, viewType){	
			$("div.viewType").hide();
			
			if (selectFaceYear) {
				$("#selectFaceYear").val(selectFaceYear);
			} else {
				$("#selectFaceYear").val(commonDate.year);
			}
			
			// 현재 달 or 분기까지만 option 넣기
			if($("#selectFaceYear").val() == commonDate.year){
				var currentMonth = commonDate.month;
				
				$('#selectFaceMonth').empty();
				
				for(var i=0; i<currentMonth; i++){
					 var month = i+1;
					 if(month < 10){
						 month = '0'+month;
					 }
					 var option = $('<option value="'+month+'">'+month+'월</option>');
			         $('#selectFaceMonth').append(option);
				}
				
				var currentQuarter = commonDate.quarter(commonDate.month);
				
				$('#selectFaceQuarter').empty();
				
				for(var i=0; i<currentQuarter; i++){
					 var option = $('<option value="'+(i+1)+'">'+(i+1)+'분기</option>');
			         $('#selectFaceQuarter').append(option);
				}
			}
			
			if (selectFaceMonth) {
				$("#selectFaceMonth").val(selectFaceMonth);
			} else {
				$("#selectFaceMonth").val(commonDate.month);
			}

			if (selectFaceQuarter) {
				$("#selectFaceQuarter").val(selectFaceQuarter);
			} else {
				$("#selectFaceQuarter").val(commonDate.quarter(commonDate.month));
			}
			
			if(viewType == null || viewType == 'm' || viewType == ''){
				$("div[name='divSerachYear']").show();
				$("div[name='divSerachMonth']").show();
				hearderTitle = $("#selectFaceYear").val()+"년 "+$("#selectFaceMonth").val()+"월 (Hours, %)";
			}else if(viewType == 'y'){
				$("div[name='divSerachYear']").show();
				hearderTitle = $("#selectFaceYear").val()+"년 (Hours, %)";
			}else{
				$("div[name='divSerachYear']").show();
				$("div[name='divSerachQuarter']").show();	
				hearderTitle = $("#selectFaceYear").val()+"년 "+$("#selectFaceQuarter").val()+"분기 (Hours, %)";
			}
		}
}