var searchDetailInit = $("#formSearchDetail").serialize();

// 비번변경 팝업
$('.btn-pwset-pop').click(function(){
    $('.myinfo-pw-modal').toggle();
});

$('.btn-cus-pop').click(function(){
	$('.myinfo-cus-modal').toggle();
});

// 알림팝업
$('.btn-alarm').click(function(){
    $('.alarm-menu').toggle();
});


// 진행률 표시
$( function() {
    //$( ".range_drag" ).draggable();
  } );


// 직원추가 팝업 show/hide //
$('.company-search .btn').click(function(){
   $('.custom-company-pop').show();  
});
$('.custom-company-pop .close').click(function(){
   $('.custom-company-pop').hide(); 
});


// 캘린더 오른쪽 영역 show/hide ///////////////////////////////////////////////////////////////////////////
$('.btn-calendar-on').hide();
$('.btn-calendar').click(function(){
    $(this).hide();
    $(this).next('a').show();
    $('.calendar-grid').addClass('calendar-grid-close');
    return false;
});
$('.btn-calendar-on').click(function(){
    $(this).hide();
    $(this).prev('a').show();
    $('.calendar-grid').removeClass('calendar-grid-close');
});

// step li width 자동조정 : 마일스톤  ///////////////////////////////////////////////////////////////////////////
function stepWidth(){
    var stepLength = $('.step_level li').length;
    var stepliW  = 100/stepLength;
    // alert(stepliW);
    $('.step_level li').css('width',stepliW+"%");
};
if($('.step_level').length > 0){
    stepWidth(); //step_level의 존재여부 확인 후 함수 실행
};



// 다른 캘린더 가져오기 ///////////////////////////////////////////////////////////////////////////////
$('.btn-office').click(function(){
    $('.other-calendar').hide();
    $('.office-calendar').show();
});

$('.btn-outlook').click(function(){
    $('.other-calendar').hide();
    $('.outlook-calendar').show();
});

$('.btn-google').click(function(){
    $('.other-calendar').hide();
    $('.google-calendar').show(); 
});


// a_check 
$('.a_check').click(function(){
    $(this).toggleClass('a_check_on');
    // alert($(this).html()+'의 입력이 가능합니다.');
    return false;
});



// 상세검색 show/hide ////////////////////////////////////////////////////////////////////////////////
$('a.btn-search-option').click(function(){
	// $('a.btn-search-option>i').toggle();
  	$('.search-detail').toggle();
  	/*$("div.search-common input:text").val(null);
  	$("div.search-common select").val(null);
  	$("div.search-common input:checkbox").prop("checked",false);*/
});

// 상세검색을 실행했을 때 리셋 버튼 보이게
$('div.search-detail .btn-seller').click(function(){
	// 검색 조건이 있을 때에만 리셋버튼 출력
	if(searchDetailInit != ($("#formSearchDetail").serialize())){
		$('a.btn-reset-option').css('display', 'inline-block');
	}else{
		$('a.btn-reset-option').css('display', 'none');
	}
});

// 엔터키 누름
$("#formSearchDetail input[type=text].input").keydown(function(event){
	if(event.keyCode == 13){
		event.preventDefault();
		// 검색 조건이 있을 때에만 리셋버튼 출력
		if(searchDetailInit != ($("#formSearchDetail").serialize())){
			$('a.btn-reset-option').css('display', 'inline-block');
		}else{
			$('a.btn-reset-option').css('display', 'none');
		}
	}
});

// 상세검색 리셋 버튼
$('a.btn-reset-option').click(function(){
	$('div.search-detail select, div.search-detail input').val('');
	$('#result-in-search').prop('checked',false);
	$('div.search-detail .btn-seller').trigger('click');
	// 다시 숨김
	$(this).css('display', 'none');
});

// 리스트페이지의 템플릿 다운로드
$('.template-doc>button').click(function(){
    $(this).next().toggle();
})

// 계약금액/추정투자금액 부분 제목설정 팝업
$('.progress-step .ti>a').click(function(){
	$(this).next().toggle();
})

$('.pay-edit-pop>button').click(function(){
	$(this).parent().hide();
	return false;
});

//달력 종일, 반복 설정 버튼 ////////////////////////////////////////////////////////////////////////////////
$('.btn-repeat-set').focusin(function(){
    $('.repeat-option').toggle();
    return false;
});


// 도움말 팝업////////////////////////////////////////////////////////////////////////////////////////////////
$('.btn-help').click(function(){
    $('.help-pop').toggle();
})

// 달력 옵션 팝업 ////////////////////////////////////////////////////////////////////////////////////////////
$('.btn-func-pop').click(function(){
    $(this).next().show();
    return false;
});
$('.calendar-add-list>li').mouseleave(function(){
    $(this).find('.calendar-func-pop').hide();
    $('.rename-input').hide();
    $('.delete-input').hide();
});
$('.btn-calendar-rename').click(function(){
	$(this).next().show();
    return false;
});
$('.btn-calendar-delete').click(function(){
	$(this).next().show();
    return false;
});

// 달력 추가 ///////////////////////////////////////
//팝업 열기
$('.btn-calendar-add').click(function(){ 
    $(this).next().show();
    return false;
});

//팝업 닫기
$('.addCalendar-pop .btn-cancle').click(function(){
    $('.addCalendar-pop').hide();
    return false;
});
$('.addCalendar-pop .close').click(function(){
    $('.addCalendar-pop').hide();
    return false;
});
$('.myinfo-pw-modal .btn-cancle').click(function(){
    $('.myinfo-pw-modal').hide();
    return false;
});
//에러&버그문의
$('.myinfo-cus-modal .btn-cancle').click(function(){
    $('.myinfo-cus-modal').hide();
    return false;
});

// CRB 보기
$('a.btn-crb').click(function(){
    $('a.btn-crb>i').toggle();
    $('.crb-area').toggle();
})


// cadence 등록 폼 뷰
// $('.cadence-history-list').click(function(){
//     $('.cadence-update').show();
//     $('.cadence-app').hide();
// });

// $('.btn-cadence-app').click(function(){
//     $('.cadence-update').hide();
//     $('.cadence-app').show();
// });


// 정보검색 리스트 타입 설정 /////////////////////////////////////////////////////////////////////////////////
$('.btn-namecard-view').click(function(){
    $('.btn-namecard-view>span').toggle();
    $('span.namecard').toggle();
});

// 화폐단위 자동 ,(콤머) 입력 : start ////////////////////////////////////////////////////////////////////////
function strip_comma(data)
{
    var flag = 1;
    var valid = "1234567890";
    var output = '';
    if (data.charAt(0) == '-')
    {
        flag = 0;
        data = data.substring(1);
    }
    
    for (var i=0; i<data.length; i++)
    {
        if (valid.indexOf(data.charAt(i)) != -1)
            output += data.charAt(i)
    }
    
    if (flag == 1)
        return output;
    else if (flag == 0)
        return ('-' + output);
}
  
function add_comma(what)
{
    var flag = 1;
    var data = what;
    var len = data.length;
    
    if (data.charAt(0) == '-')
    {
        flag = 0;
        data = data.substring(1);
    }
    if (data.charAt(0) == '0' && data.charAt(1) == '-')
    {
        flag = 0;
        data = data.substring(2);
    }
    
    var number = strip_comma(data);
    number = '' + number;
    if (number.length > 3)
    {
        var mod = number.length % 3;
        var output = (mod > 0 ? (number.substring(0,mod)) : '');
        for (i=0; i<Math.floor(number.length/3); i++)
        {
            if ((mod == 0) && (i == 0))
                output += number.substring(mod+3*i, mod+3*i+3);
            else
                output += ',' + number.substring(mod+3*i, mod+3*i+3);
        }
        if (flag == 0)
        {
            return ('-' + output);
        }
        else
        {
            return (output);
        }
    }
    else
    {
        if (flag == 0)
        {
            return ('-' + number);
        }
        else
        {
            return (number);
        }
    }
}
  
function replace(str, original, replacement)
{
    var result;
    result = "";
    while(str.indexOf(original) != -1)
    {
        if (str.indexOf(original) > 0)
            result = result + str.substring(0, str.indexOf(original)) + replacement;
        else
            result = result + replacement;
            str = str.substring(str.indexOf(original) + original.length, str.length);
    }
    return result + str;
}
  
function comma(what)
{
    var data = what.value;
    
    if ((event.keyCode == 107) || (event.keyCode == 187))
    {
        if ((data == "+") || (data == "0+") || (Math.floor(replace((replace(data,"+","")),",","")) == 0))
        {
            dataval = "";
        }
        else
        {
            var dataval = data + '000';
            dataval = replace(dataval,"+","");
        }
    }
    else
    {
        if (Math.floor(data) == 0)
        {
            dataval = "";
        }
        else
        {
            var dataval = data;
        }
    }
    
    what.value = add_comma(dataval);
}

// 화폐단위 자동 ,(콤머) 입력 : end //
//콤마풀기
function uncomma(str) {
    str = String(str);
    return str.replace(/,/gi, "");
}