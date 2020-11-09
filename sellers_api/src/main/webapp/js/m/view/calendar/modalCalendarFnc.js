var compare_before;
var compare_after;
var compareFlag = false;

var invite_members = [];

/**
 * 캘린더로 이동
 * @returns
 */
function fncList(){
	window.history.back();
}

/**
 * 반복수정 / 삭제 선택 레이어
 * @param el
 * @returns
 */
function layer_open(el){

	var temp = $('#' + el);		//레이어의 id를 temp변수에 저장
	var bg = temp.prev().hasClass('bg');	//dimmed 레이어를 감지하기 위한 boolean 변수

	if(bg){
		$('.layer').fadeIn();
	}else{
		temp.fadeIn();	//bg 클래스가 없으면 일반레이어로 실행한다.
	}

	//alert($(document).height());
	//alert(temp.outerHeight() + '/' + temp.outerHeight() / 2);
	// 화면의 중앙에 레이어를 띄운다.
	if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', $(document).outerHeight()/2.2+'px'); //temp.css('margin-top', '-'+$(document).outerHeight()/2+'px');
	else temp.css('top', '0px');
	if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
	else temp.css('left', '0px');

	temp.find('a.cbtn').click(function(e){
		if(bg){
			$('.layer').fadeOut();
		}else{
			temp.fadeOut();  //'닫기'버튼을 클릭하면 레이어가 사라진다.
		}
		e.preventDefault();
	});

	$('.layer .bg').click(function(e){
		$('.layer').fadeOut();
		e.preventDefault();
	});

}

var modalFlag = "ins/upd"; //추가 수정 변수
var v_mode = mode;

if(v_mode == 'M') {
	modalFlag = "upd";
}
else {
	modalFlag = "ins";
}

var modal = {
		
	validate : function(){		
	    $("#formModalData").validate({ // joinForm에 validate를 적용
	        ignore: "", 
	        rules : {
	        	textModalEventSubject : {
	                required : true,
	                maxlength : 100
	            },
	            selectModalEventCode : {
	            	required : true
	            }
	        },
	        messages : { // rules에 해당하는 메시지를 지정하는 속성
	        	textModalEventSubject : {
	                required : "제목을 입력하세요.",
	                maxlength : "100자 이하로 작성해주세요."
	            },
	            selectModalEventCode : {
	            	required : "일정구분을 선택하세요."
	            }
	        },
	        errorPlacement : function(error, element) {        	
//	            if($(element).prop("id") == "hiddenModalCompanyId") {
//	                $("#textCommonSearchCompany").after(error);
//	                location.href = "#textCommonSearchCompany";
//	            }else {
	                error.insertAfter(element); // default error placement.
//	            }
	        }
	    });   
	},
	
	changeEndDate : function() {
		var startDateTime = $("#selectModalStartDateTime").val();
		
		var split = startDateTime.split(":");
		var endHour = "";
		(parseInt(split[0],"10")+1) > 9 ? endHour = parseInt(split[0],"10")+1 : endHour = "0"+(parseInt(split[0],"10")+1);
		$("#selectModalEndDateTime").val(endHour+":"+split[1]);
	},
	changeNotice : function(value){
		console.log(value);
		switch (value) {
		case 'notNotice':
			$('#radioModalAlam0').attr("checked", true);
			break;
		case 'oneHour':
			$('#radioModalAlam1').attr("checked", true);
			break;
		case 'oneDay':
			$('#radioModalAlam2').attr("checked", true);
			break;
		case "oneWeek":
			$('#radioModalAlam3').attr("checked", true);
			break;

		default:
			break;
		}

	},
	//신규등록
	reset : function(date) {
		//modalFlag = "ins";
		
		//$("#divInviteMemberList").html('');
		//$("#divInviteMemberList").html('<div class="form-group"><label class="col-sm-2 control-label" style="text-align: center;">이름</label>'+
		//		'<label class="col-sm-4 control-label" style="text-align: center;">메일</label>'+
		//		'<label class="col-sm-2 control-label" style="text-align: center;">수락여부</label>'+
		//		'<label class="col-sm-4 control-label" style="text-align: center;">수락시간</label></div>');

		//모바일 없음 $("small.font-bold").html("");
		$("#formModalData input:text").val("");
		$("#formModalData select > option:first").prop("selected",true);
		$("#formModalData textarea").val("");
		$("#formModalData textarea").height(1).height(33);
		$("#formModalData .invite-area-list").html("");
		$("#checkboxModalInvite").val("N");
		$("#checkboxModalInvite").prop("checked", false);
		//모바일 없음 $("#divModalConviteOption").css("display", "none");
		
		//$('select[name^="selectModal"]').val("");
		//$('select[name^="selectModal"]').attr("disabled", false);
		$('input[name^="checkboxModal"]').val("N");
		$('input[name^="checkboxModal"]').prop("checked", false);
		
		//$('select[id^="selectModalSyncId"] > option:nth-child(2)').attr("selected", "selected");
		$("#radioModalCountNull").prop("checked", true);
		$("#selectModalBeforeMoveTimeMin").val("0");
		$("#selectModalAfterMoveTimeMin").val("0");
		$("#selectModalFreq").val("2");       //반복일정 매주
		$("#selectModalInterval").val("1");   //반복일정 1주에 한번
		//$("#divModalInterval").hide();
		rrule.selectFreq($("#selectModalFreq")[0]);
		
		$("#hiddenModalAllday_YN").val("N");
		$("#hiddenModalRepeat_YN").val("N");
		
		//모바일 없음 $("h4.modal-title").html("일정관리 신규 등록");
		//모바일 없음 $("#buttonModalSubmit").html("저장하기");
		//모바일 없음 $("#buttonModalMailSubmit").html("저장하고 메일보내기");
		//모바일 없음 $("#buttonModalDelete").css('display','none');

		//if($("#checkboxModalInvite").val()=='N'){
		//	alert("asfasf");
		//	$("#buttonModalMailSubmit").css('display', 'none');
		//}else{
		//	alert("aaa");
		//	$("#buttonModalMailSubmit").css('display', '');
		//} 
		 
		//모바일 없음 $("#buttonModalMailSubmit").css("display", "none");
		$("input:checkbox[name=RRulecheckboxModalByweekday]").each(function (index) {  
			this.checked=false;
	    }); 
		$("#textModalCountNum").attr("disabled", true);    //종료일(OO번 반복 후 종료) 
       	$("#textModalEndRuleDate").attr("disabled", true); //종료일(종료 날짜 텍스트 박스)
       	
       	//모바일 없음 $("div.company-current").html("");
       	$("#hiddenModalMemberList").val("");
       	//모바일 없음 commonSearch.multipleMemberArray=[];
       	
		if(date && date != moment().format("YYYY-MM-DD")) {
			$("#textModalStartDate").val(moment(date).format("YYYY-MM-DD"));    //일정시작일자
			$("#textModalEndDate").val(moment(date).format("YYYY-MM-DD"));      //일정종료날짜
			$("#selectModalStartDateTime").val("09:00");                        //일정시작시간
			$("#selectModalEndDateTime").val("10:00");                          //일정종료시간
		}
		else {
			var hour = new Date().getHours()>9 ? ''+new Date().getHours() : '0'+new Date().getHours();
			var min = new Date().getMinutes()>9 ? ''+new Date().getMinutes() : '0'+new Date().getMinutes();

			if(parseInt(min) == 0) {
				$("#selectModalStartDateTime").val(hour+":00");
				hour = (new Date().getHours()+1) > 9 ? ''+(new Date().getHours()+1) : '0'+(new Date().getHours()+1);
				$("#selectModalEndDateTime").val(hour+":00");
			}
			else if(parseInt(min) > 0 && parseInt(min) <= 30) {
				$("#selectModalStartDateTime").val(hour+":30");
				hour = (new Date().getHours()+1) > 9 ? ''+(new Date().getHours()+1) : '0'+(new Date().getHours()+1);
				$("#selectModalEndDateTime").val(hour+":30");
			}
			else if(parseInt(min) > 30) {
				hour = (new Date().getHours()+1) > 9 ? ''+(new Date().getHours()+1) : '0'+(new Date().getHours()+1);
				$("#selectModalStartDateTime").val(hour+":00");
				hour = (new Date().getHours()+2) > 9 ? ''+(new Date().getHours()+2) : '0'+(new Date().getHours()+2);
				$("#selectModalEndDateTime").val(hour+":00");
			}
			$("#textModalStartDate").val(commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			$("#textModalEndDate").val(commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
		}
		
		// 여기부터
		/*var $officeCalendars = $("#calendar-other-office365").children();
		if($officeCalendars.size() == 0){
			
		}else{
			
		}*/
		
		//이동시간
		if($("#selectModalEventCode option:selected").attr('id')=='meeting') {
			$("#divModalEventCode").show();
			$("#divModalEventCode2").show();
			
			$('#line_move').css("display", "block");
			$('#before_move').css("display", "block");
			$('#after_move').css("display", "block");
		}else {
			$("#divModalEventCode").hide();
			$("#divModalEventCode2").hide();
			
			$('#line_move').css("display", "none");
			$('#before_move').css("display", "none");
			$('#after_move').css("display", "none");
		}
		
		//공개상태
		$("input:radio[name='radioModalShareYN']:radio[value='Y']").prop("checked", true);
		//일정알림
		$("input:radio[name='radioModalAlam']:radio[value='notNotice']").prop("checked", true);
		 
		$("#divModalRepeatOption").hide();  //반복일정 설정 영역
		//모바일 없음 $("#divModalMoveOption").hide();
		//모바일 없음 $("#divModalConviteOption").hide();
		
		rrule.nthOfMonth();
		//$("#myModal1").modal();
		
		//신규등록창도 수정사항 확인.
		compare_before = $("#formModalData").serialize();
	},
	
	/**
	 * 월, 일, 시, 분 포맷
	 */
	setDateForm : function(evenDate){
		
		var dateObj = {};
		
		dateObj.year = evenDate.getFullYear();
		dateObj.month = (evenDate.getMonth() <= 8) ? "0"+(evenDate.getMonth()+1).toString() : evenDate.getMonth()+1;
		dateObj.date = (evenDate.getDate() <= 9) ? "0"+(evenDate.getDate()).toString() : evenDate.getDate();
		dateObj.hour = (evenDate.getHours() <= 9) ? "0"+(evenDate.getHours()).toString() : evenDate.getHours();
		dateObj.min = (evenDate.getMinutes() <= 9) ? "0"+(evenDate.getMinutes()).toString() : evenDate.getMinutes();
		
		return dateObj;
	},
	
	/**
	 * 일정 수정 시, 데이터 불러와 출력
	 */
	getDetail : function() {
		
		if(v_event_code == "") {
			alert("이벤트 코드가 존재하지 않습니다.\n데이터 확인하세요.");
			window.history.back();
		}
		
		// 일정시작 & 일정종료 날짜
		var starteventdate = new Date(v_start);
		var startObj = modal.setDateForm(starteventdate);
		
		var startyear = startObj.year;
		var startmonth = startObj.month;
		var startdate = startObj.date;
		var starthour = startObj.hour;
		var startmin = startObj.min;
		
		var endeventdate;
		var endyear;
		var endmonth;
		var enddate;
		var endhour;
		var endmin;
		
		// 외부 캘린더
		if(v_event_code == 8 || v_event_code == 9 || v_event_code == 10) {
			
			$("#textModalCountNum").val("");
			$("#textModalEndRuleDate").val("");
			
			if(v_end == "" && v_time_gap != "") {
				endeventdate = new Date(v_start);
				endeventdate = new Date(Date.parse(endeventdate) + v_time_gap * 1000 * 60);
				
				var endObj = modal.setDateForm(endeventdate);				
				endyear = endObj.year;
				endmonth = endObj.month;
				enddate = endObj.date;
				endhour = endObj.hour;
				endmin = endObj.min;				
			}
			else if(v_end != "") {
				endeventdate = new Date(v_end);
				
				var endObj = modal.setDateForm(endeventdate);				
				endyear = endObj.year;
				endmonth = endObj.month;
				enddate = endObj.date;
				endhour = endObj.hour;
				endmin = endObj.min;
			}
			else {
				endeventdate = starteventdate;
				endyear = startyear;
				endmonth = startmonth;
				enddate = startdate;
				endhour = starthour;
				endmin = startmin;
			}
			
			//$("#textModalEventSubject2").val(calEvent.title);
			$("#textModalEventSubject2").val(v_title);
			//$("#selectModalEventCode2").val(calEvent.EVENT_CODE);
			//$("#selectModalCalendarID2").val(calEvent.CALENDAR_ID);
			//$("#textareaModalEventDetail2").val(calEvent.EVENT_DETAIL);
			$("#textareaModalEventDetail2").val(v_event_detail);
			var tAreaH = $("#textareaModalEventDetail2")[0].value.substr(0, $("#textareaModalEventDetail2")[0].selectionStart).split("\n").length*17;
			$("#textareaModalEventDetail2").height(1).height($("#textareaModalEventDetail2").prop('scrollHeight')+(tAreaH+12));
			
			$("#selectModalStartDateTime2").val(startyear+"-"+startmonth+"-"+startdate+"  "+starthour+":"+startmin);
			$("#selectModalEndDateTime2").val(endyear+"-"+endmonth+"-"+enddate+"  "+endhour+":"+endmin);
			//$("#textModalEventLocation2").val(calEvent.LOCATION);
			$("#textModalEventLocation2").val(v_location);
			//모바일 없음 $("#buttonModalDelete").css('display','');
			rrule.nthOfMonth();
			//$("#myModalOutlook").modal();
			compare_before = $("#formModalData").serialize();
		}		
		else if(v_event_code != 5) {	// v_event_code 5 : 기타
			
			// 달력 선택 (사용안함)
			//$("#selectModalCalendarID").val(v_calendar_id);
			
			// 제목
			$("#textModalEventSubject").val(v_title);
			// 일정구분
			$("#selectModalEventCode").val(v_event_code);
			// 장소
			$("#textModalEventLocation").val(v_location);
			// 상세내용
			$("#textareaModalEventDetail").val(v_event_detail);
			var tAreaH = $("#textareaModalEventDetail")[0].value.substr(0, $("#textareaModalEventDetail")[0].selectionStart).split("\n").length*17;
			$("#textareaModalEventDetail").height(1).height($("#textareaModalEventDetail").prop('scrollHeight')+(tAreaH+12));

			// 일정종료 날짜 세팅
			if(v_end == "" && v_time_gap != "") {
				endeventdate = new Date(v_start);
				endeventdate = new Date(Date.parse(endeventdate) + v_time_gap * 1000 * 60);
				
				if(v_allDay){
					endeventdate.setDate(endeventdate.getDate()-1);
				}
				
				var endObj = modal.setDateForm(endeventdate);				
				endyear = endObj.year;
				endmonth = endObj.month;
				enddate = endObj.date;
				endhour = endObj.hour;
				endmin = endObj.min;
				
				$("#hiddenModalEndDate").val(moment(endeventdate).format("YYYY-MM-DD"));
			}
			else if(v_end != "") {
				endeventdate = new Date(v_end);
				
				if(v_allDay){
					endeventdate.setDate(endeventdate.getDate()-1);
				}
				
				var endObj = modal.setDateForm(endeventdate);				
				endyear = endObj.year;
				endmonth = endObj.month;
				enddate = endObj.date;
				endhour = endObj.hour;
				endmin = endObj.min;
								
				$("#hiddenModalEndDate").val(moment(endeventdate).format("YYYY-MM-DD"));
			}
			else {
				endeventdate = starteventdate;
				endyear = startyear;
				endmonth = startmonth;
				enddate = startdate;
				endhour = starthour;
				endmin = startmin;
				
				$("#hiddenModalEndDate").val(moment(v_end).format("YYYY-MM-DD"));
			}	
			
			// jsp 화면에서 데이터를 넣어주기 때문에, js에서 한번 더 넣어주지 않아도 됨
//			$("#textModalStartDate").val(startyear+"-"+startmonth+"-"+startdate);
//			$("#textModalEndDate").val(endyear+"-"+endmonth+"-"+enddate);
			$("#selectModalStartDateTime").val(starthour+":"+startmin);
			$("#selectModalEndDateTime").val(endhour+":"+endmin);
			$("#hiddenModalOrgStartDate").val(startyear+"-"+startmonth+"-"+startdate);
					
			// 종일
			if(v_allDay == false || v_allDay == "") {
				$("#checkboxModalAllday").val("N");
				$("#hiddenModalAllday_YN").val("N");
				$("#checkboxModalAllday").prop("checked", false);

				//모바일은 disabled 처리
				$("#selectModalStartDateTime").attr("disabled", false);
				$("#selectModalEndDateTime").attr("disabled", false);
			}
			else if(v_allDay == true){
				$("#checkboxModalAllday").val("Y");
				$("#hiddenModalAllday_YN").val("Y");
				$("#checkboxModalAllday").prop("checked", true);
				
				//모바일은 disabled 처리
				$("#selectModalStartDateTime").attr("disabled", true);
				$("#selectModalEndDateTime").attr("disabled", true);
				
				$('#selectModalStartDateTime').css('background','#ddd');
				$('#selectModalEndDateTime').css('background','#ddd');
			}
			
			//일정초대
			selectInviteMemberList(v_event_id);
			$("#checkboxModalInvite").val("N");
			$("#checkboxModalInvite").prop("checked", false);
			//모바일 없음 $("#divModalConviteOption").css("display", "none");
			$("#textModalInviteName").val(v_invite_name);
			$("#textModalInviteId").val(v_invite_member_id);
			$("#textModalInviteMail").val(v_invite_email);
			$("#textModalInviteCalendarId").val(v_invite_calendar_id);

			// ============== 반복설정 Start =================
			
			$("#hiddenModalRruleString").val('');
			
			// 반복요일 체크박스 해제 (모바일에서는 기능 일시보류)
			$("input:checkbox[name=RRulecheckboxModalByweekday]").each(function (index) {  
				this.checked=false;
			});
			
			// 반복횟수 & 종료일 초기화
			$("#textModalCountNum").val("");
			$("#textModalEndRuleDate").val("");
			
			//REPEAT_YN 값 어디감?, REPEAT_Y는 위에 반복 설정에서 세팅
			//if(v_repeat_yn == "Y" || v_repeat_y == "Y") {
			if(v_repeat_yn == "Y") {
				$("#checkboxModalRepeat").val("Y");
				$("#hiddenModalRepeat_YN").val("Y");
				$("#checkboxModalRepeat").prop("checked", true);
				$("#selectModalFreq").val(v_recurrence_freq);

				if(v_recurrence_freq == '1'){
					rrule.selectFreq($("#selectModalFreq")["0"]);
					$("#divModalMonthlyByweekday").show();
					$("#divModalElseByweekday").hide();
					
					if(isEmpty(v_recurrence_byweekday)){
						$('input:radio[name=divModalMonthlyRule]')["0"].checked=true;
					}
					else{
						$('input:radio[name=divModalMonthlyRule]')["1"].checked=true;
					}
				}
				else if(v_recurrence_freq == '2'){
					rrule.selectFreq($("#selectModalFreq")["0"]);
					$("#divModalMonthlyByweekday").hide();
					$("#divModalElseByweekday").show();
				}
				else if(v_recurrence_freq == '3'){
					rrule.selectFreq($("#selectModalFreq")["0"]);
					$("#divModalMonthlyByweekday").show();
					$("#divModalElseByweekday").hide();
					if(isEmpty(v_recurrence_byweekday)){
						$('input:radio[name=divModalMonthlyRule]')["0"].checked=true;
					}else{
						$('input:radio[name=divModalMonthlyRule]')["1"].checked=true;
					}
				}
				
				$("#selectModalInterval").val(v_recurrence_interval);
				//if(calEvent.RECURRENCE_BYWEEKDAY!=undefined) {
				if(v_recurrence_byweekday != "") {
					var byWeekDay = v_recurrence_byweekday.substring(6, v_recurrence_byweekday.length).split(',');
					for(var i=0; i<byWeekDay.length; i++) {
						$("#checkboxModalRRule" + byWeekDay[i]).prop("checked", true);
					}
				}

				//if(calEvent.RECURRENCE_BYMONTHDAY!=undefined) {
				if(v_recurrence_bymonthday != "") {
					var byMonthDay = v_recurrence_bymonthday.charAt(0);
					if(byMonthDay != '+' && byMonthDay != '-'){
						$('input:radio[name="divModalMonthlyRule"]:input[value="BYMONTHDAY"]').prop("checked", true);
					}else{
						$('input:radio[name="divModalMonthlyRule"]:input[value="BYDAY"]').prop("checked", true);
					}
				}

				//if(calEvent.RECURRENCE_END_DATE!=undefined) {
				if(v_recurrence_end_date != "") {
					$("#checkboxModalEndRuleDate").prop("checked", true);
					$("#textModalEndRuleDate").val(v_recurrence_end_date);
					$("#textModalEndRuleDate").attr("disabled", false);
					$("#textModalCountNum").attr("disabled", true);
				}
				else if(v_recurrence_count == 500) {
					$("#radioModalCountNull").prop("checked", true);
					$("#textModalEndRuleDate").attr("disabled", true);
					$("#textModalCountNum").attr("disabled", true);
				}
				//else if(v_recurrence_count < 500 || v_recurrence_count > 500) {
				else if(v_recurrence_count > 0 && v_recurrence_count != 500) {
					$("#radioModalCountNum").prop("checked", true);
					$("#textModalCountNum").val(v_recurrence_count);
					$("#textModalEndRuleDate").attr("disabled", true);
					$("#textModalCountNum").attr("disabled", false);
				}
				else {
					$("#radioModalCountNull").prop("checked", true);
					$("#textModalCountNum").val("");
					$("#textModalCountNum").attr("disabled", true);
					$("#textModalEndRuleDate").val("");
					$("#textModalEndRuleDate").attr("disabled", true);
				}
				
				$("#hiddenModalRruleString").val(v_recurrence_rule);
				rrule.getRepeat($("#hiddenModalRruleString").val());
				
				// 모바일에서는 반복일정 수정 보류
				//$('#divModalRepeatOption').show();
			}
			//else if(calEvent.REPEAT_YN=="N" || calEvent.REPEAT_YN==null) {
			else if(v_repeat_yn == "N" || v_repeat_yn == "") {
				$("#checkboxModalRepeat").val("N");
				$("#hiddenModalRepeat_YN").val("N");
				$("#checkboxModalRepeat").prop("checked", false);
				//$("#divModalRepeatOption").css("display", "none");
				
				$('#divModalRepeatOption').hide();
			}	
			
			$("#hiddenModalEXDate_YN").val(v_ex_date_yn);
			$("#hiddenModalRruleDateOrder").val(v_recurrence_dateorder);
			/*추가*/
			$("#hiddenModalRruleSyncId").val(v_recurrence_sync_id);
        	$("#hiddenModalRuleByweekday").val(v_recurrence_byweekday);
        	if($("#hiddenModalRruleSyncId").val() != null && $("#hiddenModalRruleSyncId").val() != ""){
        		$("#checkboxModalRepeat").parent().hide();
        	}else{
        		$("#checkboxModalRepeat").parent().show();
        	}
			
			// ============== 반복설정 End =================
						
			//$("#selectModalSyncId").val(v_sync_yn);

			// 공개상태
			if(v_share_yn == "Y"){
				$("#radioModalShareY").prop("checked", true);
				//$("input:radio[name='radioModalShareYN']:radio[value='Y']").prop("checked", true);
			}
			else if (v_share_yn == "N"){
				$("#radioModalShareN").prop("checked", true);
				//$("input:radio[name='radioModalShareYN']:radio[value='N']").prop("checked", true);
			}

			// 일정 알림
			$("#selectModalAlam").val(v_alarm_target);
			if(v_alarm_flag == "H"){
				//한시간전
				$("#radioModalAlam1").prop("checked", true);
			}
			else if(v_alarm_flag == "D"){
				//하루전
				$("#radioModalAlam2").prop("checked", true);
			}
			else if(v_alarm_flag == "W"){
				//일주일전
				$("#radioModalAlam3").prop("checked", true);
			}
			else {
				$("#radioModalAlam0").prop("checked", true);
			}
			
			//if(calEvent.BEFORE_MOVE_TIME =="" || calEvent.BEFORE_MOVE_TIME==null){
			if(v_before_move_time == "" || v_before_move_time == null){
				$("#divModalEventCode").css("display", "none");
			}
			else{
				$("#divModalEventCode").css("display", "");
				$("#selectModalBeforeMoveTimeMin").val(v_before_move_time);
			}
			
			//if(calEvent.AFTER_MOVE_TIME =="" || calEvent.AFTER_MOVE_TIME==null){
			if(v_after_move_time == "" || v_after_move_time == null){
				$("#divModalEventCode2").css("display", "none");
			}
			else{
				$("#divModalEventCode2").css("display", "");
				$("#selectModalAfterMoveTimeMin").val(v_after_move_time);
			}

			//모바일 없음 $("div.company-current").html("");
			$("#hiddenModalMemberList").val("");

			if($("#selectModalEventCode option:selected").attr('id') == 'meeting') {
				$("#divModalEventCode").show();
				$("#divModalEventCode2").show();
				$('#line_move').css("display", "block");
			}
			else {
				$("#divModalEventCode").hide();
				$("#divModalEventCode2").hide();
				$('#line_move').css("display", "none");
			}

			$("#hiddenModalEventId").val(v_event_id);
			        	
			$("#hiddenModalMemberList").val("");
			commonSearch.multipleMemberArray=[];
				
			//모바일 없음 $("#buttonModalSubmit").html("저장하기");
			//모바일 없음 $("#buttonModalMailSubmit").html("저장하고 메일보내기");
			//모바일 없음 $("#buttonModalDelete").css('display','');
			rrule.nthOfMonth();
			
			//$(".repeat_upd_msg_pop").hide();
			//$(".repeat_del_msg_pop").hide();
			
			//$.ajaxLoadingHide();
			//$("#myModal1").modal();
			
			compare_before = $("#formModalData").serialize();
		}
	},

	//외부캘린더 공유여부 확인(사용안하는 듯)
	checkCalendarSync : function() {
		//alert($("#calendarSyncYN").val());
		if($("#calendarSyncYN").val() == 'N'){
			$("#divModalSyncCalendar").hide();
		}else{
			$("#divModalSyncCalendar").show();
		}
		/* 
		if($("#hiddenModalSync_YN option:selected").attr('id')=='Y') {
			$("#divModalSyncCalendar").show();
		}else {
			$("#divModalSyncCalendar").hide();
		}
		 */
	},
	//일정구분
	checkEventCode : function() {
		if($("#selectModalEventCode option:selected").attr('id') == 'meeting') {
			$("#divModalEventCode").show();
			$("#divModalEventCode2").show();
			$('#line_move').css("display", "block");
		}
		else {
			$("#divModalEventCode").hide();
			$("#divModalEventCode2").hide();
			$('#line_move').css("display", "none");
		}
	},
	//반복일정 수정일정인지 아닌지 체크
	bfModal : function(val) {
		compare_after = $("#formModalData").serialize();
		//if(val == 'submit' && compare_before != compare_after){
		if(val == 'submit'){
			if(modalFlag == 'upd' && ($('#hiddenModalRruleString').val() != null && $('#hiddenModalRruleString').val() != '')){
				
				// '이번일정만' 옵션으로 임시 적용
//				layer_open('layer_submit');
				modal.rruleSubmit(1,'submit');
			}
			else{
				modal.submit();
			}
		}
		//else if(val == 'submit' && compare_before == compare_after){
			//$('#myModal1').modal("hide");
		//}
		else if(val == 'delete'){
			if(modalFlag == 'upd' && ($('#hiddenModalRruleString').val() != null && $('#hiddenModalRruleString').val() != '')){
				
				// '이번일정만' 옵션으로 임시 적용 
//				layer_open('layer_delete');
				modal.rruleSubmit(1,'delete');
			}
			else{
				modal.deleteModal();
			}
		}
	},
	//반복일정삭제시 deleteModal()전에 태움 팝업창 버튼3개 1:반복일정 전체삭제, 2:선택한일정만 삭제, 3:선택한 일정부터 반복일정 삭제
	//rruleCase -> 0:캘린더 이벤트 정보만 수정, 1:선택한일정만 삭제, 2:선택한 일정부터 반복일정 삭제, 3:반복일정 전체삭제
	rruleSubmit : function(num, val) {
		compareFlag = true;
		rruleCase = num;
		
		if(rruleCase == 1){
//			$("#checkboxModalRepeat").val("N");
//			$("#hiddenModalRepeat_YN").val("N");
		}
		else if(rruleCase == 2){
			if($("#textModalCountNum").val() != '' && $("#textModalCountNum").val() != null){
				$("#textModalCountNum").val($("#textModalCountNum").val()-$("#hiddenModalRruleDateOrder").val());
			}
		}
		
		if(val == 'submit'){
			modal.submit();
		}
		else if(val == 'delete'){
			modal.deleteModal();
		}
	},
	//일정 추가
	submit : function() {		
		//////////////////////////////일정추가
		$("#hiddenModalSync_YN").val($("#selectModalCalendarID > option:selected").attr("id"));
		$("#hiddenModalCalendarId").val($("#selectModalCalendarID").val());
		
		//종일일정 설정
		if($("#hiddenModalAllday_YN").val() == "Y") {
			var addDate = new Date($("#textModalEndDate").val());
			addDate = new Date(addDate.getFullYear() + "-" + (addDate.getMonth()+1) + "-" + (addDate.getDate()+1));
			$("#hiddenModalEndDate").val(moment(addDate).format("YYYY-MM-DD"));
		}
		else {
			$("#hiddenModalEndDate").val($("#textModalEndDate").val());
		}
		
		//반복룰 설정
		if($("#checkboxModalRepeat").val()=="Y") {
			rrule.setRepeat();
		}

		
		if(typeof rruleStartList == "undefined")
			rruleStartList = new Array();
		
		if(typeof rruleEndList == "undefined")
			rruleEndList = new Array();
		
		var param = $.param({
			datatype : 'json',
			sendMailFlag : 'N',
			rruleStartList : JSON.stringify(rruleStartList),
			rruleEndList : JSON.stringify(rruleEndList),
			rruleCase : rruleCase
		});
		var v_params = $('#formModalData').serialize() + '&' + param;
		
		var url;
		(modalFlag == "ins") ? url = "/calendar/insertCalendarEvent.do" : url = "/calendar/updateCalendarEvent.do";

		$('#formModalData').ajaxForm({
			url : url,
			async : false,
			dataType: "json",
			beforeSubmit: function (data,form,option) {
				//if(!compareFlag) {
					if(!confirm("저장하시겠습니까?")){ 
						return false;
					}
				//}
				//$.ajaxLoadingShow();
			},
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},			
			data :{
				datatype : 'json',
				sendMailFlag : 'N',
				rruleStartList : JSON.stringify(rruleStartList),
				rruleEndList : JSON.stringify(rruleEndList),
				rruleCase : rruleCase,
				EVENT_ID : $("#hiddenModalEventId").val()
			},			
			// data : v_params,
			success: function(data){
				//성공후 서버에서 받은 데이터 처리
				if(data.cnt >= 0){
					if(data.map.insertDupEvent == 'Y'){
						alert("해당 시간에 중복되는 일정이 있습니다.");
					}
					compare_before = $("#formModalData").serialize();
					compareFlag = false;
					alert("일정을 저장하였습니다.");
					//$('#myModal1').modal("hide");
					//$('#calendar').fullCalendar('refetchEvents');
					
					window.location.href = "/calendar/viewCalendar.do";
				}
				else if(data.cnt == -9){
					if(data.map.insertDupEvent == 'Y'){
						alert("해당 시간에 중복되는 일정이 있습니다.");
					}
					compare_before = $("#formModalData").serialize();
					compareFlag = false;
					alert("일정을 등록하였습니다.");
					//$('#myModal1').modal("hide");
					//$('#calendar').fullCalendar('refetchEvents');
					
					window.location.href = "/calendar/viewCalendar.do";
				}
				else {
					alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
				}
			},
			complete: function() {
				//$.ajaxLoadingHide();
			}
		});
		$('#formModalData').submit();
	},
	//메일 보내기
	mailSubmit : function() {
		var textModalEventSubject = $("#textModalEventSubject").val();
		if(!textModalEventSubject) {
			alert("제목을 입력하세요.");
			$("#textModalEventSubject").focus();
			return false;
		}
		
		if(textModalEventSubject.length > 100) {
			alert("100글자 이하여야 합니다.");
			$("#textModalEventSubject").focus();
			return false;
		}
		
		var selectModalEventCode = $("#selectModalEventCode").val();
		if(!selectModalEventCode) {
			alert("일정구분을 선택하세요.");
			$("#selectModalEventCode").focus();
			return false;
		}

		/*
		alert("d");
		return false; */
		var url;
		//alert($("#selectModalSyncCalendarID > option:selected").val());
		//alert($("#selectModalCalendarID > option:selected").attr("id"));
		$("#hiddenModalSync_YN").val($("#selectModalCalendarID > option:selected").attr("id"));
		$("#hiddenModalCalendarId").val($("#selectModalCalendarID").val());
		if($("#checkboxModalRepeat").val() == "Y") {
			rrule.setRepeat();
		}
		
		if($("#hiddenModalAllday_YN").val() == "Y") {
			var addDate = new Date($("#textModalEndDate").val());
			addDate = new Date(addDate.getFullYear() + "-" + (addDate.getMonth()+1) + "-" + (addDate.getDate()+1));
			$("#hiddenModalEndDate").val(moment(addDate).format("YYYY-MM-DD"));
		}
		else {
			$("#hiddenModalEndDate").val($("#textModalEndDate").val());
		}
		
		var param = $.param({
			datatype : 'json',
			sendMailFlag : 'Y',
			rruleCase : rruleCase
		});
		var v_params = $('#formModalData').serialize() + '&' + param;
		
		(modalFlag == "ins") ? url = "/calendar/insertCalendarEvent.do" : url = "/calendar/updateCalendarEvent.do";
		//$('#formModalData').ajaxForm({
		$.ajax({
			url : url,
			async : false,
			dataType: "json",
			beforeSubmit: function (data,form,option) {
				//if(!compareFlag) {
					if(!confirm("저장하시겠습니까?")) return false;
				//}
				//$.ajaxLoadingShow();
			},
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			/*
			data :{
				datatype : 'json',
				sendMailFlag : 'Y',
				rruleCase : rruleCase
			},
			*/
			data : v_params,
			success: function(data){
				//성공후 서버에서 받은 데이터 처리
				if(data.cnt >= 0){
					if(data.map.insertDupEvent == 'Y'){
						alert("해당 시간에 중복되는 일정이 있습니다.");
					}
					compare_before = $("#formModalData").serialize();
					compareFlag = false;
					alert("일정을 저장하였습니다.");
					//$('#myModal1').modal("hide");
					//$('#calendar').fullCalendar('refetchEvents');
					
					window.location.href = "/calendar/viewCalendar.do";
				}
				else if(data.cnt == -9){
					if(data.map.insertDupEvent == 'Y'){
						alert("해당 시간에 중복되는 일정이 있습니다.");
					}
					compare_before = $("#formModalData").serialize();
					compareFlag = false;
					alert("일정을 등록하였습니다. \n\n사내캘린더 일정 등록에는 실패하였습니다 \n관리자에게 문의하세요.");
					//$('#myModal1').modal("hide");
					//$('#calendar').fullCalendar('refetchEvents');
					
					window.location.href = "/calendar/viewCalendar.do";
				}
				else {
					alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
				}

				//반복룰 설정	            	
				//$('#calendar').fullCalendar('refetchEvents');
			},
			complete: function() {
				//$.ajaxLoadingHide();
			}
        });
	},
	deleteModal : function(){
		$.ajax({
			url : "/calendar/deleteCalendarEvent.do",
			datatype : 'json',
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
				//if(!compareFlag) {
					if(!confirm("삭제하시겠습니까?")) return false;
				//}
				//$.ajaxLoadingShow();
			},
			data :{
				datatype : 'json',
				hiddenModalEventId : $("#hiddenModalEventId").val(),
				textModalEventSubject : $("#textModalEventSubject").val(),
				textareaModalEventDetail : $("#textareaModalEventDetail").val(),
				selectModalStartDateTime : $("#selectModalStartDateTime").val(),
				selectModalEndDateTime : $("#selectModalEndDateTime").val(),
				textModalEventLocation : $("#textModalEventLocation").val(),
				rruleCase : rruleCase,
				hiddenModalOrgStartDate : $("#hiddenModalOrgStartDate").val(),
				hiddenModalEXDate_YN : $("#hiddenModalEXDate_YN").val()
			},
			success : function(data){
				if(data.cnt > 0) {/* alert("삭제하였습니다."); */ 
					compareFlag = false;
					//$('#myModal1').modal("hide");
					
					alert("삭제하였습니다.");
					window.location.href = "/calendar/viewCalendar.do";
				}else if(data.cnt == -9){
					alert("삭제하였습니다. \n outlook을 연동하려면 pc에서 로그인해주세요.");
					window.location.href = "/calendar/viewCalendar.do";
				}else{
					alert('정상적으로 삭제되지 않았습니다.');
				}
				
				//$('#calendar').fullCalendar('refetchEvents');
			},
			complete : function(){
				//$.ajaxLoadingHide();
			}
		});
	},
	chkBox : function(data) {
		if(!$("#"+data.id).prop("checked")) {
			$("#"+data.id).val("N");
			switch(data.id) {
				case "checkboxModalAllday" :
					$("#hiddenModalAllday_YN").val("N");
					
					//모바일은 disabled 처리
					$("#selectModalStartDateTime").css("display", "");
					$("#selectModalEndDateTime").css("display", "");
					$('#selectModalStartDateTime').css('background','#fff');
					$('#selectModalEndDateTime').css('background','#fff');
					
					break;
				case "checkboxModalRepeat" :
					$("#hiddenModalRepeat_YN").val("N"); 
					//$("#divModalRepeatOption").css("display", "none");
					$("#divModalRepeatOption").hide();
					break;
				//case "checkboxModalMove"   : $("#divModalMoveOption").css("display", "none"); break;
			}
		}
		else {
			$("#"+data.id).val("Y");
			switch(data.id) {
				case "checkboxModalAllday" :
					$("#hiddenModalAllday_YN").val("Y");

					$("#selectModalStartDateTime").val("00:00");
					$("#selectModalStartDateTime").css("display", "none");
					$("#selectModalEndDateTime").val("00:00");
					$("#selectModalEndDateTime").css("display", "none");

					$('#selectModalStartDateTime').css('background','#ddd');
					$('#selectModalEndDateTime').css('background','#ddd');
					break;
				case "checkboxModalRepeat" :
					$("#hiddenModalRepeat_YN").val("Y");
					//$("#divModalRepeatOption").css("display", "");
					//$("#divModalRepeatOption").show();
					break;
				//case "checkboxModalMove"   : $("#divModalMoveOption").css("display", ""); break;
			}
			rrule.selectFreq($("#selectModalFreq")[0]);
		}
	},
	inviteChkBox : function(data) {
		if(!$("#"+data.id).prop("checked")) {
			$("#"+data.id).val("N");
			/*
			switch(data.id) {
				case "checkboxModalInvite" :
					$("#divModalConviteOption").css("display", "none");
					$("#buttonModalMailSubmit").css("display", "none");
					break;
			}
			*/
			$('#div_invite_area').hide();
		}
		else {
			$("#"+data.id).val("Y");
			/*
			switch(data.id) {
				case "checkboxModalInvite" :
					$("#divModalConviteOption").css("display", "");
					$("#buttonModalMailSubmit").css("display", "");
					break;
			}
			*/
			$('#div_invite_area').show();
		}
	},
	chkDate : function(click) {
		if($("#textModalStartDate").val() != "" && $("#textModalEndDate").val() == "") {
			$("#textModalEndDate").val($("#textModalStartDate").val());
		}
		else if($("#textModalStartDate").val() == "" && $("#textModalEndDate").val() != "") {
			$("#textModalStartDate").val($("#textModalEndDate").val());
		}
		else if($("#textModalStartDate").val() != "" && $("#textModalEndDate").val() != "") {
			var startDate = $("#textModalStartDate").val().split('-');
			startDate = parseInt(startDate[0]+startDate[1]+startDate[2]);
			var endDate = $("#textModalEndDate").val().split('-');
			endDate = parseInt(endDate[0]+endDate[1]+endDate[2]);
			
			if(startDate > endDate) {
				if(click.id == "textModalStartDate")
					$("#textModalEndDate").val($("#textModalStartDate").val());
				else
					$("#textModalStartDate").val($("#textModalEndDate").val());
			}
		}
		$("#hiddenModalEndDate").val($("#textModalEndDate").val());
		
		if($("#checkboxModalRepeat").val() == 'Y'){
			rrule.selectFreq($("#selectModalFreq")[0]);
			$("input:checkbox[name=RRulecheckboxModalByweekday]").each(function (index) {  
				this.checked=false;
		    });
			modal.chkBox($("#checkboxModalRepeat")[0]);
		}
	}
}