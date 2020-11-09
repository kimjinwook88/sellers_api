/**
 * 대시보드 depth 체크
 */

var dashboardDepth = {
		
	// 팀의 id 확인하여 멤버 리스트 호출
	memberDepthGet : function(depth3){
		
		var teamList = [];
		
		$.each(depth3, function(key, value){
			
			var team = $(value).attr('data-team');				

			// 팀 id 중복 체크
			if(teamList.indexOf(team) == -1){
				teamList.push(team);

				var imgObj = $('#team_'+team).find('img')[0];
				
				if(!imgObj){
					return;
				}
				
				$(imgObj).trigger('click');
			}
		});
	},
	
	// 본부의 id 확인하여 팀 리스트 호출
	teamDepthGet : function(divisionList, depth3) {
		
		var self = this;
		var l = divisionList.length;
		var cnt = 0;
		
		$.each(divisionList, function(index, value){
				
			var imgObj = $('#division_'+value).find('img')[0];
		
			if(!imgObj){
				cnt++;
				return;
			}
			
			dashboard.teamGet(value, imgObj, function(){
				cnt++;
				
				// 팀 리스트 호출이 완료되지 않음
				if(cnt < l){
					return;
				}
				
				// 팀 리스트 호출이 끝난 후 멤버 depth 체크
				if(depth3){
					self.memberDepthGet(depth3);
				}
			});	
		}); // $.each
	},

	// 팀 depth 체크
	checkDepth3 : function(divisionList){

		var self = this;
		var depth3 = $('tr.depth3');
		
		// 멤버 depth 가 없음
		if(depth3.length < 1){
			
			if(divisionList){
				// 본부 리스트 호출이 끝난 후 팀 리스트를 호출
				dashboard.divisionGet(function(){
					self.teamDepthGet(divisionList);
				});
			}else{
				dashboard.teamGetInit();
			}
			return;
		}
		//================================================
			
		if(divisionList){
			// 본부 리스트 호출이 끝난 후 팀/멤버 리스트를 호출
			dashboard.divisionGet(function(){
				self.teamDepthGet(divisionList, depth3);
			});
		}else{
			// 팀 리스트 호출이 끝난 후 멤버 리스트를 호출
			dashboard.teamGetInit(function(){
				self.memberDepthGet(depth3);
			});
		}
	},
	
	// 본부 depth 체크
	checkDepth2 : function(){
		// 팀 depth
		var depth2 = $('tr.depth2');
		
		// 팀 depth 가 있는 본부 id 리스트
		var divisionList = [];
		
		if(depth2.length < 1){
			dashboard.divisionGet();
			return;
		}
		
		//================================================
		
		// 본부 id 중복 체크
		$.each(depth2, function(index, value){
			var d = $(value).attr('data-division');	
			if(divisionList.indexOf(d) == -1){
				divisionList.push(d);
			}
		});
		
		this.checkDepth3(divisionList);
	}
}