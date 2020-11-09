//월반복 변수 (매월 **일, 매월 *번째 *요일)
var monthRruleDate = "";
var monthRruleTh = "";
var monthRruleDayEn = "";
var monthRruleThKo = "";
var monthRruleDay = "";
var monthRruleDayKo = "";

var ruleToString;
var rruleStartList;
var rruleEndList;

var rruleCase = 0;

var rrule = {
	//월 몇주차?
	nthOfMonth : function() {
		/* var monthRruleDate = "";
		var monthRruleTh = "";
		var monthRruleDay = ""; */
		var mntDate = moment($("#textModalStartDate").val());
		//다음주 확인
		var nextMntDate = Math.ceil(moment($("#textModalStartDate").val()).add(7, 'day').date()/7); 
		monthRruleDate = mntDate.toString().slice(8,10);
		monthRruleTh = Math.ceil(mntDate.date() / 7);
		
		if(nextMntDate == 1){
			monthRruleTh = 0;
		}
		switch (monthRruleTh) {
			case 1: monthRruleThKo = '첫째'; 
				break;
			case 2: monthRruleThKo = '둘쩨'; 
				break;
			case 3: monthRruleThKo = '셋째'; 
				break;
			case 4: monthRruleThKo = '넷째'; 
				break;
			case 5: monthRruleThKo = '다섯째'; 
				break;
			default : monthRruleThKo = '마지막'; 
				break;
		}
		switch (moment(mntDate).format("E")) {
			case '1': monthRruleDay = '0'; monthRruleDayEn = 'MO'; monthRruleDayKo = '월';
				break;
			case '2': monthRruleDay = '1'; monthRruleDayEn = 'TU'; monthRruleDayKo = '화';
				break;
			case '3': monthRruleDay = '2'; monthRruleDayEn = 'WE'; monthRruleDayKo = '수';
				break;
			case '4': monthRruleDay = '3'; monthRruleDayEn = 'TH'; monthRruleDayKo = '목';
				break;
			case '5': monthRruleDay = '4'; monthRruleDayEn = 'FR'; monthRruleDayKo = '금';
				break;
			case '6': monthRruleDay = '5'; monthRruleDayEn = 'SA'; monthRruleDayKo = '토';
				break;
			case '7': monthRruleDay = '6'; monthRruleDayEn = 'SU'; monthRruleDayKo = '일';
				break;
		}
		$("#divModalMonthlyRuleDate").html(monthRruleDate+"일");
		$("#divModalMonthlyRuleTh").html(monthRruleThKo+"주 "+monthRruleDayKo+"요일");
	},
	
	//빈도선택
	selectFreq : function(rule) {
		//console.log("selectFreq");
		//console.log(rule);
		var num="";
		var cnt="";
		var txt="";
		if(rule.value=="1"){
			$("#divModalMonthlyByweekday").show();
			$("#divModalElseByweekday").hide();
			cnt=12;
			$("#divModalInterval").css("display", "");
			$("#selectModalInterval").val("1");
			num=['한달','두달','세달','네달','다섯달','여섯달','일곱달','여덟달','아홉달','열달','열한달','일년'];
		}else if(rule.value=="2"){
			$("#divModalMonthlyByweekday").hide();
			$("#divModalElseByweekday").show();
			cnt=9;
			$("#divModalInterval").css("display", "");
			$("#selectModalInterval").val("1");
			num=['1주','2주','3주','4주','5주','6주','7주','8주','9주'];
			var wkDate = moment($("#textModalStartDate").val());
			
			$("#checkboxModalRRule"+monthRruleDayEn).prop("checked",true);
		}else if(rule.value=="3"){
			$("#divModalMonthlyByweekday").show();
			$("#divModalElseByweekday").hide();
			$("#divModalInterval").css("display", "none");
			$("#selectModalInterval").val("3");
		}else if(rule.value=="4"){
			$("#divModalMonthlyByweekday").show();
			$("#divModalElseByweekday").hide();
			$("#divModalInterval").css("display", "none");
			$("#selectModalInterval").val("6");
		}
		if(rule.value=="1" || rule.value=="2"){
			for(var i=1; i<=cnt; i++) {
				txt+="<option value='"+i+"'>"+num[i-1]+"에 한번</option>";
			}
			$("#selectModalInterval").html(txt);
		}
	},
	
	//반복룰 설정
	setRepeat : function() {
		$("#hiddenModalStartRuleDate").val($("#textModalStartDate").val());
		
		switch ($("#selectModalFreq").val()) {
		case "2":
			var byWeekdayCheck = "BYDAY=";
			$("input:checkbox:checked[name=RRulecheckboxModalByweekday]").each(function (index) {
				switch ($(this).val()) {
				case "0":
					if(byWeekdayCheck.length == 6){
						byWeekdayCheck += "MO";
					}else{
						byWeekdayCheck += ",MO";
					}
					break;
				case "1":
					if(byWeekdayCheck.length == 6){
						byWeekdayCheck += "TU";
					}else{
						byWeekdayCheck += ",TU";
					}
					break;
				case "2":
					if(byWeekdayCheck.length == 6){
						byWeekdayCheck += "WE";
					}else{
						byWeekdayCheck += ",WE";
					}
					break;
				case "3":
					if(byWeekdayCheck.length == 6){
						byWeekdayCheck += "TH";
					}else{
						byWeekdayCheck += ",TH";
					}
					break;
				case "4":
					if(byWeekdayCheck.length == 6){
						byWeekdayCheck += "FR";
					}else{
						byWeekdayCheck += ",FR";
					}
					break;
				case "5":
					if(byWeekdayCheck.length == 6){
						byWeekdayCheck += "SA";
					}else{
						byWeekdayCheck += ",SA";
					}
					break;
				case "6":
					if(byWeekdayCheck.length == 6){
						byWeekdayCheck += "SU";
					}else{
						byWeekdayCheck += ",SU";
					}
					break;
				default:
					break;
				}
		    });
			if(byWeekdayCheck.length < 7){ //주간반복 요일체크가 null일 경우 선택한 요일로 자동 세팅.
				byWeekdayCheck = byWeekdayCheck + monthRruleDayEn;
			}
			$("#hiddenModalRuleByweekday").val(byWeekdayCheck);
			break;
		default:
			var byMonthCheck = "";
			if($("input[name=divModalMonthlyRule]:checked").val() == 'BYMONTHDAY'){
				$("#hiddenModalRuleBy").val('BYMONTHDAY=');
				byMonthCheck = $("#divModalMonthlyRuleDate").html().substring(0,2);
			}else if($("input[name=divModalMonthlyRule]:checked").val() == 'BYDAY'){
				$("#hiddenModalRuleBy").val('BYDAY=');
				if(monthRruleTh == 0){
					byMonthCheck = "-1" + monthRruleDayEn;
				}else{
					byMonthCheck = "+" + monthRruleTh + monthRruleDayEn;
				}
			}
			$("#hiddenModalRuleBymonthday").val(byMonthCheck);
			break;
		}
		
		if($("input[name=radioModalEndRule]:checked").val() == ''){ //계속반복 == 4년동안
			$("#hiddenModalEndCondition").val('loop');
			$("#hiddenModalLoopNum").val('4');
		}else if($("input[name=radioModalEndRule]:checked").val() == 'count'){ //횟수 반복
			$("#hiddenModalEndCondition").val('count');
			$("#hiddenModalCountNum").val($("#textModalCountNum").val());
		}else if($("input[name=radioModalEndRule]:checked").val() == 'until'){ //종료일 설정
			$("#hiddenModalEndCondition").val('until');
			$("#hiddenModalEndRuleDate").val($("#textModalEndRuleDate").val());
		}
	},
	
	//불러온 반복룰 문자열 나누기
	getRepeat : function(data) {
		rule = RRule.fromString(data).origOptions;
	},
	
	//반복종료일 2년이내 확인
	chkEndDate : function() {
		if($("#textModalEndRuleDate").val()!="") {
			var startEventRuleDate = new Date($("#textModalStartDate").val());
			var endEventRuleDate = new Date($("#textModalEndRuleDate").val());
			var result = ((endEventRuleDate-startEventRuleDate)/86400000);
			
			if(result > 729) {
				alert("2년 이내로 선택해 주세요.");
				$("#textModalEndRuleDate").val("");
			}
			else if(result < 1) {
				alert("반복 종료일이 시작일보다 이전입니다.");
				$("#textModalEndRuleDate").val("");
			}
		}
	},
	
	inputRrule : function(freqCheck, dtstart, until, count, interval, byweekday, bymonthday) {
		//alert(freqCheck+" "+dtstart+" "+until+" "+interval+" "+byweekday+" "+bymonthday);ruleToString
		if(until != "" && until != null){
			if(byweekday != "" && byweekday != null){
				ruleToString = new RRule({
					freq: freqCheck, //빈도
					dtstart: dtstart, //시작일
					until: until, //종료조건 횟수
					interval: interval, //주기
					byweekday: byweekday //요일 선택 복수일경우 대괄호 or 월별선택 > 요일 체크
				});
			}else if(bymonthday != "" && bymonthday != null){
				ruleToString = new RRule({
					freq: freqCheck, //빈도
					dtstart: dtstart, //시작일
					until: until, //종료조건 횟수
					interval: interval, //주기
					bymonthday : bymonthday //월별선택 > 일자 체크	
				});
			}else{
				ruleToString = new RRule({
					freq: freqCheck, //빈도
					dtstart: dtstart, //시작일
					until: until, //종료조건 횟수
					interval: interval //주기
				});
			}
		}else if(count != "" && count != null){
			if(byweekday != "" && byweekday != null){
				ruleToString = new RRule({
					freq: freqCheck, //빈도
					dtstart: dtstart, //시작일
					count: count, //종료조건 횟수
					interval: interval, //주기
					byweekday : byweekday //요일 선택 복수일경우 대괄호 or 월별선택 > 요일 체크
				});
			}else if(bymonthday != "" && bymonthday != null){
				ruleToString = new RRule({
					freq: freqCheck, //빈도
					dtstart: dtstart, //시작일
					count: count, //종료조건 횟수
					interval: interval, //주기
					bymonthday : bymonthday //월별선택 > 일자 체크	
				});
			}else{
				ruleToString = new RRule({
					freq: freqCheck, //빈도
					dtstart: dtstart, //시작일
					count: count, //종료조건 횟수
					interval: interval //주기
				});
			}
		}
	}
}