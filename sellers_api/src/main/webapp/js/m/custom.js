var custom = {
		
	/**
	 * 팀(본부) 리스트 세팅 (검색조건)
	 * @param searchNoArray   : 팀아이디 리스트
	 * @param searchNameArray : 팀명 리스트
	 * @param selectEl		  : select Element
	 * @returns
	 */
	setTeamNameList : function(searchNoArray, searchNameArray, selectEl){
		var option = '';
		
		if(searchNoArray && searchNameArray){
			var noArr = searchNoArray.split(',');
			var nameArr = searchNameArray.split(',');
			
			for(var key in noArr){
				option = '<option value="'+noArr[key]+'">'+nameArr[key]+'</option>';
				selectEl.append(option);
			}
		}		
	},
	
	/**
	 * Tab 이동
	 * @param tabEl     : 탭 Element
	 * @param tabId     : 탭 리스트의 아이디 공통부분
	 * @param contClass : content Element 클래스 공통부분
	 * @param _no       : 선택한 탭의 인덱스
	 * @returns
	 */
	fncSelectTab : function(tabEl, tabId, contClass, _no){
		
		var tabList = tabEl.children();
		
		for(var i=1; i<=tabList.length; i++){
			$('#'+tabId+i).removeClass('active');
			$('.'+contClass+i).addClass('off');
		}
		
		// 탭 이동
		$('#'+tabId+_no).addClass('active');
		
		// 탭에 해당하는 컨테이너 보여주기
		$('.'+contClass+_no).removeClass('off');
	}
}

//화폐단위 자동 ,(콤머) 입력 : start ////////////////////////////////////////////////////////////////////////
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