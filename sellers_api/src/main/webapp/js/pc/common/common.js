// LTRIM
String.prototype.ltrim = function() {
	var re = /\s*((\S+\s*)*)/;
	return this.replace(re, "$1");
};

// RTRIM
String.prototype.rtrim = function() {
	var re = /((\s*\S+)*)\s*/;
	return this.replace(re, "$1");
};

// TRIM
String.prototype.trim = function() {
	return this.ltrim().rtrim();
};

// replaceALL
String.prototype.replaceAll = function(str1, str2) {
	var temp = this;

	while (1) {
		if (temp.indexOf(str1) != -1)
			temp = temp.replace(str1, str2);
		else
			break;
	}
	return temp;
};

//쿠키 생성
function setCookie(cName, cValue, cDay){
	
	if(!cValue){
		cValue = '';
	}
	
    var expire = new Date();
    expire.setDate(expire.getDate() + cDay);
    cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
    if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
    document.cookie = cookies;
}

//쿠키 가져오기
function getCookie(cName) {
    cName = cName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cName);
    var cValue = '';
    if(start != -1){
        start += cName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cValue = cookieData.substring(start, end);
    }
    return unescape(cValue);
}

//공백 및 널 체크
function isEmpty(value){
	if( value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){
		return true
	}else{
		return false
	}
};

//필드 초기화
function filedReset(obj){
	obj.find('input').val(null);
	obj.find('textarea').text(null);
	obj.find('select option:first').prop("selected",true);
	obj.find('input:checkbox').prop("checked",false);
}

//새창띄우기
function fncOpenPanel(strUrl, inrWidth, intHeight) {
	var newp = "width=" + inrWidth + ", height=" + intHeight + ", directories=no, scrollbars=no, resizable=yes";
	window.open(strUrl, "new", newp);
}

// 새창띄우기 스크롤
function fncOpenPanel_SC(strUrl, inrWidth, intHeight) {
	var newp = "width=" + inrWidth + ", height=" + intHeight + ", directories=no, scrollbars=yes, resizable=no";
	window.open(strUrl, "new", newp);
}

//핸드폰 번호 - 자동 입력
function autoHypen(obj){
    return $(obj).val(obj.value.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3"));
}

var commonCheckExtension = function(fileExtension){
	if($.inArray(fileExtension, ['.jpg','.png','.gif','.jpeg']) != -1){
		return 'image';
	}else if($.inArray(fileExtension, ['.xls','.xlsx']) != -1){
		return 'excel';
	}else if($.inArray(fileExtension, ['.pdf']) != -1){
		return 'pdf';
	}else if($.inArray(fileExtension, ['.ppt','.pptx']) != -1){
		return 'powerpoint';
	}else if($.inArray(fileExtension, ['.doc','.docx','.hwp','.txt']) != -1){
		return  'word';
	}
}

//데이트 함수
var commonDate = {
		now : new Date(),
		year : new Date().getFullYear(),
		month : (new Date().getMonth()+1)>9 ? ''+(new Date().getMonth()+1) : '0'+(new Date().getMonth()+1),
		day : new Date().getDate()>9 ? ''+new Date().getDate() : '0'+new Date().getDate(),
		quarter : function(month){
			if(isEmpty(month)){
				return Math.ceil( commonDate.month / 3 ); 
			}else{
				return Math.ceil( month / 3 );
			}
		},
		compareDate : function(startDate,endDate){
			var returnFlag = true;
			if((startDate != null && startDate != "") && (endDate != null && endDate != "")){
				alert("시작일이 종료일보다 클 수 없습니다.");
				returnFlag  = false;
			}else if((startDate == null || startDate == "") && (endDate != null && endDate != "")){
				alert("시작일을 선택해 주세요.");
				returnFlag  = false;
			}
			return returnFlag;
		},
		
		naviDate : function(category, currentDate, ad){
			var map = new Object();
			if(category == "y"){ //년
				map.startDate = moment(currentDate).add('year',ad).startOf('year').format('YYYY-MM-DD');
				map.endDate = moment(currentDate).add('year',ad).endOf('year').format('YYYY-MM-DD');
				map.showDate = moment(map.startDate).format('YYYY')+"년";
			}else if(category == "q"){ //분기
				map.startDate = moment(currentDate).add('quarter',ad).startOf('quarter').format('YYYY-MM-DD');
				map.endDate = moment(currentDate).add('quarter',ad).endOf('quarter').format('YYYY-MM-DD');
				map.showDate = moment(map.startDate).format('YYYY')+"년 " + moment(map.startDate).format('Q')+"분기"; 
			}else if(category == "m"){ //월
				map.startDate = moment(currentDate).add('month',ad).startOf('month').format('YYYY-MM-DD');
				map.endDate = moment(currentDate).add('month',ad).endOf('month').format('YYYY-MM-DD');
				map.showDate = moment(map.startDate).format('YYYY')+"년 " + moment(map.startDate).format('MM')+"월";
			}else{ //else는 분기로
				map.startDate = moment(currentDate).add('quarter',ad).startOf('quarter').format('YYYY-MM-DD');
				map.endDate = moment(currentDate).add('quarter',ad).endOf('quarter').format('YYYY-MM-DD');
				map.showDate = moment(map.startDate).format('YYYY')+"년 " + moment(map.startDate).format('Q')+"분기";
			}
			return map;
		}
}


//파일 업로드 (추후 변경 예정)
var commonFile ={
		fileCount : 0,
		fileArray : [],
		returnIcon : null,
		extension : null,
		checkFileBlank : function(pk){
			if($("#divFileUploadList span[name='modalFile"+pk+"']").length == 0){
				$("#divFileUploadList span.blank-ment").show();
			}
		},
		
		reset : function(){
			commonFile.fileArray = [];
			$("input[name='fileModalUploadFile[]']").remove();
			$("div.fileUpload.btn.btn-gray").append('<input type="file" name="fileModalUploadFile[]" onchange="commonFile.upload(this);" class="upload"' +
					' accept=".jpg, .png, .gif, .jpeg, .xls, .xlsx, .pdf, .ppt, .pptx, .doc, .docx, .hwp, .txt" multiple />');
		},
		
		removeFileElement : function(obj,fileName,fileIdx){
			$("input[name='fileModalUploadFile[]']").each(function(i,v){
				for(var i=0; i<$(this)["0"].files.length; i++){
					var file = $(this)["0"].files[i];
					if($(this)[0].files[i]){
						if($(this)["0"].files[i].name == fileName/* && $(this).hasClass("valid")*/){
							commonFile.fileArray[fileIdx].useYN = false;
							//$(this).remove();
						}
					}
				}
				
				/*if($(this)[0].files[0]){
					if(($(this)[0].files[0].name == fileName) && $(this).hasClass("valid")){
						$(this).remove();
					}
				}*/
			});
			$(obj).parent("span[name='spanUploadFile']").remove();
			if($("#divFileUploadList span:visible").not(".blank-ment").length == 0){
				$("#divFileUploadList span.blank-ment").show();
			}
		},
		
		checkExtension : function(fileName){
			commonFile.extension = fileName.split('.').pop().toLowerCase();
			if($.inArray(commonFile.extension, ['jpg','png','gif','jpeg','xls','xlsx','pdf','ppt','pptx','doc','docx','hwp','txt']) == -1) {
				alert("업로드할 수 없는 파일입니다.");
				commonFile.returnIcon = false;
			}else{
				if($.inArray(commonFile.extension, ['jpg','png','gif','jpeg']) != -1){
					commonFile.returnIcon = 'image';
				}else if($.inArray(commonFile.extension, ['xls','xlsx']) != -1){
					commonFile.returnIcon = 'excel';
				}else if($.inArray(commonFile.extension, ['pdf']) != -1){
					commonFile.returnIcon = 'pdf';
				}else if($.inArray(commonFile.extension, ['ppt','pptx']) != -1){
					commonFile.returnIcon = 'powerpoint';
				}else if($.inArray(commonFile.extension, ['doc','docx','hwp','txt']) != -1){
					commonFile.returnIcon =  'word';
				}
			}
		},
		
		upload : function(obj){
			var file = null;
			var fileObj = null;
			var fileFlag = null;
			var fileIdx = commonFile.fileArray.length;
			
			for(var i=0; i<$(obj)["0"].files.length; i++){
				file = $(obj)["0"].files[i];
				fileObj = new Object();
				fileFlag = true;
				
				fileObj.fileName = file.name;
				fileObj.useYN = true;
				
				$("#divFileUploadList span:visible").each(function(idx){
					if(file.name.trim() == $(this).text().trim()){
						//$("div.fileUpload.btn.btn-gray").append('<input type="file" name="fileModalUploadFile[]" onchange="commonFile.upload(this);" class="upload" multiple />');
						//i = i - 1;
						fileFlag = false;
						fileObj.useYN = false;
					}
				});
				commonFile.fileArray.push(fileObj);
				
				if(fileFlag){
					commonFile.checkExtension(file.name);
					if(commonFile.returnIcon != false){
						$("#divFileUploadList span.blank-ment").hide();
						//$(obj).hide();
						//$("div.fileUpload.btn.btn-gray").append('<input type="file" name="fileModalUploadFile[]" onchange="commonFile.upload(this);" class="upload" multiple />');
						$("#divFileUploadList").append('<span name="spanUploadFile" style="padding-left:5px;"><i class="fa fa-file-'+commonFile.returnIcon+'-o fa-lg"></i> '+file.name+' <a href="javascript:void(0);" onClick="commonFile.removeFileElement(this,\''+file.name+'\','+fileIdx+');"><i class="fa fa-times-circle"></i></a></span>');
						//commonFile.fileArray.push($(obj)["0"].files[i]);
					}else{
						//$("div.fileUpload.btn.btn-gray").append('<input type="file" name="fileModalUploadFile[]" onchange="commonFile.upload(this);" class="upload" multiple />');
					}
				}
				fileIdx = fileIdx+1;
			}
			$("div.fileUpload.btn.btn-gray").append('<input type="file" name="fileModalUploadFile[]" onchange="commonFile.upload(this);" class="upload"' +
			' accept=".jpg, .png, .gif, .jpeg, .xls, .xlsx, .pdf, .ppt, .pptx, .doc, .docx, .hwp, .txt" multiple />');
			/*var file = $(obj)[0].files[0]
			var fileFlag = true;
			$("#divFileUploadList span:visible").each(function(idx){
				console.log(idx);
				if(file.name.trim() == $(this).text().trim()){
					$(obj).remove();
					$("div.fileUpload.btn.btn-gray").append('<input type="file" name="fileModalUploadFile[]" onchange="commonFile.upload(this);" class="upload" multiple />');
					fileFlag = false;
					return false;
				}
			});
			if(fileFlag){
				commonFile.checkExtension(file.name);
				if(commonFile.returnIcon != false){
					$("#divFileUploadList span.blank-ment").hide();
					//$(obj).hide();
					$("div.fileUpload.btn.btn-gray").append('<input type="file" name="fileModalUploadFile[]" onchange="commonFile.upload(this);" class="upload" multiple />');
					$("#divFileUploadList").append('<span name="spanUploadFile" style="padding-left:5px;"><i class="fa fa-file-'+commonFile.returnIcon+'-o fa-lg"></i> '+file.name+' <a href="javascript:void(0);" onClick="commonFile.removeFileElement(this,\''+file.name+'\');"><i class="fa fa-times-circle"></i></a></span>');
				}else{
					$(obj).remove();
					$("div.fileUpload.btn.btn-gray").append('<input type="file" name="fileModalUploadFile[]" onchange="commonFile.upload(this);" class="upload" multiple />');
				}
			}*/
		},
		
		//파일삭제 후 새로고침
		reloadFile : function(pk, fileTableName){
			$.ajax({
				url : "/common/reloadFile.do?hiddenModalPK="+pk+"&fileTableName="+fileTableName+"&datatype=json",
				async : false,
				datatype : 'json',
				method: 'POST',
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					var fileList = data.fileList;
					
					commonFile.reset();
					if(!isEmpty(fileList)){
						$("#divFileUploadList span").remove();
						for(var i=0; i<fileList.length; i++){
							$("#divFileUploadList").append('<span style="padding-left:5px;"><a href="/common/downloadFile.do?fileId='+fileList[i].FILE_ID+'&fileTableName=1"><i class="fa fa-file-'+commonCheckExtension(fileList[i].FILE_TYPE)+'-o fa-lg"></i> '+fileList[i].FILE_NAME+'</a> <a href="javascript:void(0);" onClick="modal.deleteFile('+fileList[i].FILE_ID+');"><i class="fa fa-times-circle"></i></a></span>');
						}
					}else{
						$("#divFileUploadList").html('<span class="blank-ment">선택된 파일이 없습니다</span>');
					}
				},
				complete: function(){
					$.ajaxLoadingHide();
				}
			});
		}
} 
	

var commonCheck = {
		prevInteger : null,

		onlyNumber : function(obj){
			obj.value=obj.value.replace(/[^0-9]/g,'');
		},
		
		onlyInteger : function(obj){
			obj.value=obj.value.replace(/[^-|^\d]/g,'');
		},
		
		onlyRealNumber : function(obj){	//실수 정규식
			var pattern = /^[-|0-9]?(\d+?([.]?([\d]?[\d]?[\d]?[\d])?)?)?$/;
			var string = uncomma(obj.value);
			var itg, dcm = 0;
			
			if(pattern.test(string)){
				if(string.charAt(string.length-1) != "."){
					commonCheck.prevInteger = string;
					itg = string.split(".")["0"];
					dcm = string.split(".")["1"];
					
					(!!dcm && dcm != null && dcm !=0) ? dcm = '.' + dcm : dcm = "";
					obj.value = add_comma(itg) + dcm;
				}
			}else{
				string = commonCheck.prevInteger;
				itg = string.split(".")["0"];
				dcm = string.split(".")["1"];
				
				(!!dcm && dcm != null && dcm !=0) ? dcm = '.' + dcm : dcm = "";
				obj.value = add_comma(itg) + dcm;
			}
		}
}

var commonSearchAdd = { //아직 완료 안됨 2018-11-28 김진욱
		singleCompany : function(objLi,companyId,companyNm){
			var html = "";
			html += '<li class="value">';
			html += '<span class="txt" id="'+companyId+'">'+companyNm+'</span>'
			html += '<a href="#" class="remove" onclick="commonSearch.removeSingleCompany(this);"><i class="fa fa-times-circle"></i></a></li>'
			html += '<a href="/clientManagement/viewClientCompanyInfoDetail.do?company_id='+companyId+'&searchDetail='+encodeURI(companyNm)+'" target="_blank" name="aMoveSingleCompany" class="btn-group-sum" style="margin:6px 0 0 5px">바로가기</a>'
			return html;
		},
		
		singleMember : function(memberId,memberNm){
			var html = "";
			html += '<li class="value">';
			html += '<span class="txt" id="'+companyId+'">'+companyNm+'</span>';
			html += '<a href="#" class="remove" onclick="commonSearch.removeSingleCompany(this);"><i class="fa fa-times-circle"></i></a></li>';
			html += '<a href="/clientManagement/viewClientCompanyInfoDetail.do?company_id='+companyId+'&searchDetail='+encodeURI(companyNm)+'" target="_blank" name="aMoveSingleCompany" class="btn-group-sum" style="margin:6px 0 0 5px">바로가기</a>';
			return html;
		},
		
		singleCompany2 : function(textObj,hiddenObj,liObj,companyId,companyNm){
			var html = "";
			html += '<li class="value">';
			html += '<span class="txt" id="'+ companyId +'">'+ companyNm +'</span>';
			html += '<a href="#" class="remove" onclick="commonSearch.removeSingleCompany2(this,null);">';
			html += '<i class="fa fa-times-circle"></i></a>';
			html += '</li>';
			textObj.hide();
			hiddenObj.val(companyId);
			liObj.before(html);
		},
		
		singleMember2 : function(textObj,hiddenObj,liObj,memberId,memberNm,memberPs){
			var html = "";
			html += '<li class="value">';
			html += '<span class="txt" id="'+ memberId +'">'+ memberNm +' ['+ memberPs +']</span>';
			html += '<a href="#" class="remove" onclick="commonSearch.removeSingleMember2(this,null);">';
			html += '<i class="fa fa-times-circle"></i></a>';
			html += '</li>';
			textObj.hide();
			hiddenObj.hide(memberId);
			liObj.before(html);
		}
}

var commonSearch = {
	//고객사 자동완성 검색	
	company : function(obj, obj_hidden, obj_id){
		obj.autoComplete({
		    minChars: 2,
		    cache: 0,
		    emptyMsg : "고객사",
		    emptyUrl : "/clientManagement/viewClientCompanyInfoGate.do?modalReset=1",
		    source: function(term, response){
		    	$.ajax({
		            url: "/common/searchCompanyInfo.do",
		            dataType: "json",
		            data: {
		              companyName: term
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function( data ) {
		            		response( 
			                	$.map(data.list, function( item ) {
			                			return {
			                  				label: item.COMPANY_NAME,
			                  			 	value: item.COMPANY_ID
				                		}
			              		})
			              	);	
		            },
		            complete : function() {

					}
		        });
		    },
		    onSelect : function(e, term, item){
		    	//선택 값 hidden input
		    	obj_hidden.val($(item).attr("hidden-data"));
		    	//고객사 ID
		    	obj_id.val($(item).attr("hidden-data"));
		    	//유효성검사
		    	obj_hidden.valid();
		    }
		}).keyup(function(key){
			//backspace or delete
			if(key.keyCode == 46 || key.keyCode == 8){
				if((obj.val()).trim() == "" || obj.val() == null){
					obj_hidden.val("");	
					obj_id.val("");	
					obj_hidden.valid();
				}
			}
		});
	},
	
	//고객명 자동완성 검색
	customer : function(obj, obj_hidden, obj_rank, obj_companyId){
		obj.autoComplete({
		    minChars: 2,
		    cache: 0,
		    emptyMsg : "고객",
		    emptyUrl : "/clientManagement/viewClientIndividualInfoGate.do?modalReset=1",
		    source: function(term, response){
		    	$.ajax({
		            url: "/common/searchCustomerInfo.do",
		            dataType: "json",
		            data: {
		            	customerName: term,
		            	companyId : obj_companyId.val()
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function( data ) {
		            		response( 
			                	$.map(data.list, function( item ) {
			                			return {
			                  				label: item.CUSTOMER_NAME,
			                  			 	value: item.CUSTOMER_ID,
			                  			 	position : item.POSITION
				                		}
			              		})
			              	);	
		            },
		            complete : function() {

					}
		        });
		    },
		    onSelect : function(e, term, item){
		    	//선택 값 hidden input
		    	obj_hidden.val($(item).attr("hidden-data"));
		    	obj_rank.val($(item).attr("hidden-position"));
		    	//유효성검사
		    	obj_hidden.valid();
		    }
		}).keyup(function(key){
			//backspace or delete
			if(key.keyCode == 46 || key.keyCode == 8){
				if((obj.val()).trim() == "" || obj.val() == null){
					obj_hidden.val("");	
			    	obj_hidden.valid();
				}
			}
		});
	},
	
	//고객명 자동완성 검색
	singleClientIndividual : function(obj, obj_view, obj_companyName, obj_companyId, obj_clientName, obj_clientId, obj_clientPosition){
		obj.autoComplete({
		    minChars: 2,
		    cache: 0,
		    emptyMsg : "고객",
		    emptyUrl : "/clientManagement/viewClientIndividualInfoGate.do?modalReset=1",
		    source: function(term, response){
		    	$.ajax({
		            url: "/common/searchClientInfo.do",
		            dataType: "json",
		            data: {
		            	clientName: term
		            	//companyId : obj_companyId.val()
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function( data ) {
		            		response( 
			                	$.map(data.list, function( item ) {
			                			return {
			                  				label: item.CUSTOMER_NAME,
			                  			 	value: item.CUSTOMER_ID,
			                  			 	position : item.POSITION,
			                  			 	calendarId : item.COMPANY_ID,
			                  			 	email : item.COMPANY_NAME,
			                  			 	type : 'singleClientIndividual'
				                		}
			              		})
			              	);	
		            },
		            complete : function() {

					}
		        });
		    },
		    onSelect : function(e, term, item){
		    	//선택 값 hidden input
		    	var clientName = $(item).attr("data-val");
		    	var clientId = $(item).attr("hidden-data");
		    	var companyName = $(item).attr("hidden-email");
		    	var companyId = $(item).attr("hidden-calendarId");
		    	var clientPosition = '';
		    	if(!isEmpty($(item).attr("hidden-position"))){ clientPosition = $(item).attr("hidden-position"); }
		    	
		    	var companyNameAttrId = '';
		    	var companyIdAttrId = '';
		    	var clientPositionAttrId = '';
		    
		    	obj_clientName.val(clientName);
		    	obj_clientId.val(clientId);
		    	if(obj_companyName != null && obj_companyName != ''){
		    		obj_companyName.val(companyName);
		    		companyNameAttrId = obj_companyName.attr("id");
		    	}
		    	if(obj_companyId != null && obj_companyId != ''){
		    		obj_companyId.val(companyId);
		    		companyIdAttrId = obj_companyId.attr("id");
		    	}
		    	if(obj_clientPosition != null && obj_clientPosition != ''){
		    		obj_clientPosition.val(clientPosition);
		    		clientPositionAttrId = obj_clientPosition.attr("id");
		    	}
		    	
		    	
		    	//선택된 값 디자인 적용 및 인풋 숨김
		    	obj.val('');
		    	obj.hide();
		    	obj_view.before(
						'<li class="value">'+
						'<span class="txt" id="'+ clientId +'">'+ clientName +' '+ clientPosition +' ['+ companyName +']</span>'+
						'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleClient(\''+obj.attr("id")+'\',\''+
						obj_clientName.attr("id")+'\',\''+obj_clientId.attr("id")+'\',\''+
						companyNameAttrId+'\',\''+companyIdAttrId+'\',\''+clientPositionAttrId+'\');">'+
						'<i class="fa fa-times-circle"></i></a>'+
						'</li>'
				);
		    	
		    	//유효성검사
		    	obj_clientId.valid();
		    }
		}).keyup(function(key){
			//backspace or delete
			/*if(key.keyCode == 46 || key.keyCode == 8){
				if((obj.val()).trim() == "" || obj.val() == null){
					obj_hidden.val("");	
			    	obj_hidden.valid();
				}
			}*/
		});
	},
	
	//단일 고객명 선택 삭제 -고객사,고객개인,고객직급 전부 삭제
	removeSingleClient : function(inputBox, companyName, companyId, clientName, clientId, clientPosition) {
		if(companyName != null && companyName != 'undefined'){
			$("#"+companyName).val('');
		}
		if(companyId != null && companyId != 'undefined'){
			$("#"+companyId).val('');
		}
		if(clientName != null && clientName != 'undefined'){
			$("#"+clientName).val('');
		}
		if(clientId != null && clientId != 'undefined'){
			$("#"+clientId).val('');
		}
		if(clientPosition != null && clientPosition != 'undefined'){
			$("#"+clientPosition).val('');
		}
		$("#"+inputBox).show();
	},
	
	//직원명 자동완성 검색
	member : function(obj, hiddenObj){
		obj.autoComplete({
		    minChars: 2,
		    cache: 0,
		    emptyMsg : "직원",
		    emptyUrl : null,
		    source: function(term, response){
		    	$.ajax({
		            url: "/common/searchMemberInfo.do",
		            dataType: "json",
		            data: {
		            	memberName: term
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function( data ) {
		            		response( 
			                	$.map(data.list, function( item ) {
			                			return {
			                  				label: item.HAN_NAME,
			                  			 	value: item.MEMBER_ID_NUM,
			                  			 	position: item.POSITION_STATUS
				                		}
			              		})
			              	);	
		            },
		            complete : function() {

					}
		        });
		    },
		    onSelect : function(e, term, item){
		    	//선택 값 hidden input
		    	hiddenObj.val($(item).attr("hidden-data"));
		    	//유효성검사
		    	hiddenObj.valid();
		    }
		}).keyup(function(key){
			//backspace or delete
			if(key.keyCode == 46 || key.keyCode == 8){
				if((obj.val()).trim() == "" || obj.val() == null){
					hiddenObj.val("");
					hiddenObj.valid();
				}
			}
		});
	},
	
	//직원명 자동완성 검색 (파트너 현황 Action에서 쓰는것 유효성 검사 때문에 하나 또 만듬)
	memberPartner : function(obj, hiddenObj){
		obj.autoComplete({
			minChars: 2,
			cache: 0,
			emptyMsg : "직원",
			emptyUrl : null,
			source: function(term, response){
				$.ajax({
					url: "/common/searchMemberInfo.do",
					dataType: "json",
					data: {
						memberName: term
					},
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
					success: function( data ) {
						response( 
								$.map(data.list, function( item ) {
									return {
										label: item.HAN_NAME,
										value: item.MEMBER_ID_NUM,
										position: item.POSITION_STATUS
									}
								})
						);	
					},
					complete : function() {
						
					}
				});
			},
			onSelect : function(e, term, item){
				//선택 값 hidden input
				hiddenObj.val($(item).attr("hidden-data"));
				//유효성검사
				//hiddenObj.valid();
			}
		}).keyup(function(key){
			//backspace or delete
			if(key.keyCode == 46 || key.keyCode == 8){
				if((obj.val()).trim() == "" || obj.val() == null){
					hiddenObj.val("");
					hiddenObj.valid();
				}
			}
		});
	},
	
	//고객사 자동완성 검색	(그리드)
	companyGrid : function(obj, obj_hidden, obj_id){
		obj.autoComplete({
		    minChars: 2,
		    cache: 0,
		    emptyMsg : "고객사",
		    emptyUrl : "/clientManagement/viewClientCompanyInfoGate.do?modalReset=1",
		    source: function(term, response){
		    	$.ajax({
		            url: "/common/searchCompanyInfo.do",
		            dataType: "json",
		            data: {
		              companyName: term
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function( data ) {
		            		response( 
			                	$.map(data.list, function( item ) {
			                			return {
			                  				label: item.COMPANY_NAME,
			                  			 	value: item.COMPANY_ID
				                		}
			              		})
			              	);	
		            },
		            complete : function() {

					}
		        });
		    },
		    onSelect : function(e, term, item){
		    	//선택 값 hidden input
		    	obj_hidden.html($(item).attr("hidden-data"));
		    	//고객사 ID
		    	//obj_id.html($(item).attr("hidden-data"));
		    }
		});
	},
	
	//고객명 자동완성 검색 (그리드)
	customerGrid : function(obj, obj_hidden, obj_rank, obj_company){
		obj.autoComplete({
		    minChars: 2,
		    cache: 0,
		    emptyMsg : "고객",
		    emptyUrl : "/clientManagement/viewClientIndividualInfoGate.do?modalReset=1",
		    source: function(term, response){
		    	$.ajax({
		            url: "/common/searchCustomerInfo.do",
		            dataType: "json",
		            data: {
		            	customerName: term,
		            	companyId : obj_company
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function( data ) {
		            		response( 
			                	$.map(data.list, function( item ) {
			                			return {
			                  				label: item.CUSTOMER_NAME,
			                  			 	value: item.CUSTOMER_ID,
			                  			 	position : item.POSITION
				                		}
			              		})
			              	);	
		            },
		            complete : function() {

					}
		        });
		    },
		    onSelect : function(e, term, item){
		    	//선택 값 hidden input
		    	obj_hidden.html($(item).attr("hidden-data"));
		    	obj_rank.html($(item).attr("hidden-position"));
		    }
		});
	},
	
	//직원명 자동완성 검색 (그리드)
	memberGrid : function(obj,hiddenObj){
		obj.autoComplete({
			minChars: 2,
			cache: 0,
			emptyMsg : "직원",
			emptyUrl : null,
			source: function(term, response){
				$.ajax({
					url: "/common/searchMemberInfo.do",
					dataType: "json",
					data: {
						memberName: term
					},
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
					success: function( data ) {
						response( 
								$.map(data.list, function( item ) {
									return {
										label: item.HAN_NAME,
										value: item.MEMBER_ID_NUM,
										position : item.POSITION_STATUS
									}
								})
						);	
					},
					complete : function() {

					}
				});
			},
			onSelect : function(e, term, item){
				hiddenObj.html($(item).attr("hidden-data"));
			}
		}).keyup(function(key){
			//backspace or delete
			if(key.keyCode == 46 || key.keyCode == 8){
				if((obj.val()).trim() == "" || obj.val() == null){
					hiddenObj.html("");
				}
			}
		});
	},
	
	//파트너사 자동완성 검색
	partner : function(obj,hiddenObj,obj_id){
		obj.autoComplete({
			minChars: 2,
			cache: 0,
			emptyMsg : "파트너",
			emptyUrl : "/partnerManagement/listPartnerCompanyGate.do?modalReset=1",
			source: function(term, response){
				$.ajax({
					url: "/common/searchPartnerInfo.do",
					dataType: "json",
					data: {
						companyName: term
					},
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
					success: function( data ) {
						response( 
								$.map(data.list, function( item ) {
									console.log(item.PARTNER_PERSONAL_NAME);
									return {
										label: item.COMPANY_NAME,
										value: item.PARTNER_ID
									}
								})
						);	
					},
					complete : function() {

					}
				});
			},
			onSelect : function(e, term, item){
				hiddenObj.val($(item).attr("hidden-data"));
				//partner사 ID
				obj_id.val($(item).attr("hidden-data"));
				//유효성검사
		    	hiddenObj.valid();
			}
		}).keyup(function(key){
			//backspace or delete
			if(key.keyCode == 46 || key.keyCode == 8){
				if((obj.val()).trim() == "" || obj.val() == null){
					hiddenObj.val("");
					obj_id.val("");
					hiddenObj.valid();
				}
			}
		});
	},
	
	//파트너사 자동완성 검색 (그리드)
	partnerGrid : function(obj,hiddenObj){
		obj.autoComplete({
			minChars: 2,
			cache: 0,
			emptyMsg : "파트너",
			emptyUrl : "/partnerManagement/listPartnerCompanyGate.do?modalReset=1",
			source: function(term, response){
				$.ajax({
					url: "/common/searchPartnerInfo.do",
					dataType: "json",
					data: {
						companyName: term
					},
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
					success: function( data ) {
						response( 
								$.map(data.list, function( item ) {
									console.log(item.PARTNER_PERSONAL_NAME);
									return {
										label: item.COMPANY_NAME,
										value: item.PARTNER_ID
									}
								})
						);	
					},
					complete : function() {

					}
				});
			},
			onSelect : function(e, term, item){
				hiddenObj.html($(item).attr("hidden-data"));
			}
		});
	},
	
	//파트너 개인 자동완성 검색 (그리드)
	partnerMemberGrid : function(obj,hiddenObj){
		obj.autoComplete({
			minChars: 2,
			cache: 0,
			emptyMsg : "파트너 개인",
			emptyUrl : null,
			source: function(term, response){
				$.ajax({
					url: "/common/searchPartnerMemberInfo.do",
					dataType: "json",
					data: {
						partner_personal_name: term
					},
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
					success: function( data ) {
						response( 
								$.map(data.list, function( item ) {
									return {
										label: item.PARTNER_PERSONAL_NAME,
										value: item.PARTNER_INDIVIDUAL_ID,
										position : item.POSITION
									}
								})
						);	
					},
					complete : function() {

					}
				});
			},
			onSelect : function(e, term, item){
				hiddenObj.html($(item).attr("hidden-data"));
			}
		});
	},
	
	//캘린더 초대 직원명 자동완성 검색
	calendarMember : function(obj, hiddenObj, memberEMail, memberCalendarId){
		obj.autoComplete({
		    minChars: 2,
		    cache: 0,
		    emptyMsg : "직원",
		    emptyUrl : null,
		    source: function(term, response){
		    	$.ajax({
		            url: "/common/searchCalendarMemberInfo.do",
		            dataType: "json",
		            data: {
		            	memberName: term
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function( data ) {
		            		response( 
			                	$.map(data.list, function( item ) {
			                			return {
			                  				label: item.HAN_NAME,
			                  			 	value: item.MEMBER_ID_NUM,
			                  			 	position :item.EMAIL, 
			                  			 	calendarId : item.CALENDAR_ID
				                		}
			              		})
			              	);	
		            },
		            complete : function() {
		            	
					}
		        });
		    },
		    onSelect : function(e, term, item){
		    	//선택 값 hidden input
		    	hiddenObj.val($(item).attr("hidden-data"));
		    	memberEMail.val($(item).attr("hidden-position"));
		    	memberCalendarId.val($(item).attr("hidden-calendarId"));
		    }
		});
	},
	
	//===========================================
	inviteMemberArray : [],
	
	inviteMemberSerch : function(){
		$.ajax({
			url: "/common/selectInviteMemberInfo.do",
			async : false,
			dataType: "json",
            data: {
            	memberName: $("#textCommonSearchMultipleMember").val()
            },
			beforeSend : function(xhr) {
				xhr.setRequestHeader("AJAX", true);
				if ($("#textCommonSearchMultipleMember").val().length < 2) {
					alert("검색어를 2글자 이상 입력해 주세요.");
					return false;
				}
				$.ajaxLoading();
			},
			success : function(data) {
				var memberList = data.list;
				$("ul.member-list").html("");
				if (memberList.length > 0) {
					for (var i = 0; i < memberList.length; i++) {
						$("ul.member-list")
								.append(
										"<li><span>"
												+ memberList[i].HAN_NAME + memberList[i].POSITION_STATUS
												+ "</span><input type='checkbox' id='checkboxMultipleMember' name='checkboxMultipleMember' onClick='commonSearch.multipleMemberHtml(this)'; value="
												+ memberList[i].EMAIL + "/" + memberList[i].MEMBER_ID_NUM + "/" + memberList[i].HAN_NAME
												+ "></input></li>");
					}
				} else {
					$("ul.member-list").append(
							"<li><span>데이터가 없습니다.</span></li>");
				}
			},
			complete : function() {
				$.ajaxLoadingHide();
			}
		});
	},
	
	inviteMemberSelect : function(eventId) {
		$.ajax({
			url : "/calendar/getInviteMemberList.do",
			async : false,
			data : {
				hiddenModalEventId : eventId
			},
			beforeSend : function(xhr) {
				xhr.setRequestHeader("AJAX", true);
			},
			success : function(data) {
				var multimemberList = data.InviteMemberList;
				$("div.member-current").html("");
				if (multimemberList.length > 0) {
					for (var i = 0; i < multimemberList.length; i++) {
						$("div.member-current")
								.append(
										'<span id="span_'
												+ multimemberList[i].SHARE_MEMBER_ID
												+ '">'
												+ multimemberList[i].HAN_NAME
												+ '<a href="javascript:void(0);" onClick="$(this).parent(\'span\').remove();commonSearch.partnerIdRemove(\''
												+ multimemberList[i].SHARE_MEMBER_ID
												+ '\');"><i class="fa fa-times-circle va_m"></i></a></span>');
						commonSearch.multipleMemberArray
								.push(multimemberList[i].SHARE_MEMBER_ID);
					}
				}
				$("#hiddenModalMemberList").val(commonSearch.multipleMemberArray);
			},
			complete : function() {
				
			}
		});
	},
	//=============================================
	
	multipleMemberArray : [],
	
	multipleMember : function(){
		$.ajax({
			url: "/common/searchMemberInfo.do",
			async : false,
			dataType: "json",
            data: {
            	memberName: $("#textCommonSearchMember").val()
            },
			beforeSend : function(xhr) {
				xhr.setRequestHeader("AJAX", true);
				if ($("#textCommonSearchMember").val().length < 2) {
					alert("검색어를 2글자 이상 입력해 주세요.");
					return false;
				}
				$.ajaxLoading();
			},
			success : function(data) {
				var memberList = data.list;
				$("ul.member-list").html("");
				if (memberList.length > 0) {
					for (var i = 0; i < memberList.length; i++) {
						$("ul.member-list")
								.append(
										"<li><span>"
												+ memberList[i].HAN_NAME
												+ "</span><input type='checkbox' id='checkboxMultipleMember' name='checkboxMultipleMember' onClick='commonSearch.multipleMemberHtml(this)'; value="
												+ memberList[i].MEMBER_ID_NUM
												+ "></input></li>");
					}
				} else {
					$("ul.member-list").append(
							"<li><span>데이터가 없습니다.</span></li>");
				}
			},
			complete : function() {
				$.ajaxLoadingHide();
			}
		});
	},
	
	multipleMemberSelect : function(data) {
		
		var multimemberList = data.selectShareCalendar;
		$("div.member-current").html("");
		if (multimemberList.length > 0) {
			for (var i = 0; i < multimemberList.length; i++) {
				$("div.member-current")
						.append(
								'<span id="span_'
										+ multimemberList[i].SHARE_MEMBER_ID
										+ '">'
										+ multimemberList[i].HAN_NAME
										+ '<a href="javascript:void(0);" onClick="$(this).parent(\'span\').remove();commonSearch.partnerIdRemove(\''
										+ multimemberList[i].SHARE_MEMBER_ID
										+ '\');"><i class="fa fa-times-circle va_m"></i></a></span>');
				commonSearch.multipleMemberArray
						.push(multimemberList[i].SHARE_MEMBER_ID);
			}
		}
		
		$("#hiddenModalMemberList").val(commonSearch.multipleMemberArray);
		
		/*$.ajax({
				url : "/calendar/selectShareCalendar.do",
				async : false,
				data : {
					datatype : 'json',
					calendarId : calendarId
				},
				beforeSend : function() {
				},
				success : function(data) {
					var multimemberList = data.selectShareCalendar;
					$("div.member-current").html("");
					if (multimemberList.length > 0) {
						for (var i = 0; i < multimemberList.length; i++) {
							$("div.member-current")
									.append(
											'<span id="span_'
													+ multimemberList[i].SHARE_MEMBER_ID
													+ '">'
													+ multimemberList[i].HAN_NAME
													+ '<a href="javascript:void(0);" onClick="$(this).parent(\'span\').remove();commonSearch.partnerIdRemove(\''
													+ multimemberList[i].SHARE_MEMBER_ID
													+ '\');"><i class="fa fa-times-circle va_m"></i></a></span>');
							commonSearch.multipleMemberArray
									.push(multimemberList[i].SHARE_MEMBER_ID);
						}
					}
				},
				complete : function() {
					$("#hiddenModalMemberList").val(
							commonSearch.multipleMemberArray);
				},
				error : function() {
					alert("검색을 실패했습니다.\n관리자에게 문의하세요.");
				}
			});*/
	},
	
	multipleMemberHtml : function(obj) {
		if ($(obj).prop("checked")) {
			$("div.member-current")
					.append(
							'<span id="span_'
									+ $(obj).val()
									+ '">'
									+ $(obj).prev('span').html()
									+ '<a href="javascript:void(0);" onClick="$(this).parent(\'span\').remove();commonSearch.multipleMemberRemove(\''
									+ $(obj).val()
									+ '\');"><i class="fa fa-times-circle va_m"></i></a></span>');
			commonSearch.multipleMemberArray.push($(obj).val());
		} else {
			$("span#span_" + $(obj).val()).remove();
			commonSearch.multipleMemberRemove($(obj).val());
		}
		$("#hiddenModalMemberList").val(commonSearch.multipleMemberArray);
	},

	multipleMemberRemove : function(val) {
		$("input:checkbox[name='checkboxMultipleMember'][value='" + val + "']").prop(
				"checked", false);
		commonSearch.multipleMemberArray = $.grep(commonSearch.multipleMemberArray, function(
				value) {
			return value != val;
		});
		$("#hiddenModalMemberList").val(commonSearch.multipleMemberArray);
	},
	
	//===== 팀구성 사용자 복수 검색로직 start ====
	//직원 복수검색 (공통)
	multipleTeamMemberArray : [], //전역변수~
	multipleTeamMember : function(obj, obj_hidden, obj_list){
		obj.autoComplete({
		    minChars: 2,
		    cache: 0,
		    emptyMsg : "직원",
		    //emptyUrl : "/clientManagement/viewClientIndividualInfoGate.do",
		    source: function(term, response){
		    	$.ajax({
	    		  url: "/common/searchMemberInfo.do",
		            dataType: "json",
		            data: {
		            	memberName: term
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function( data ) {
		            		response( 
			                	$.map(data.list, function( item ) {
			                			return {
			                				label: item.HAN_NAME,
			                  			 	value: item.MEMBER_ID_NUM,
			                  			 	position : item.POSITION_STATUS,
			                  			 	email: item.EMAIL
				                		}
			              		})
			              	);	
		            },
		            complete : function() {

					}
		        });
		    },
		    onSelect : function(e, term, item){
		    	commonSearch.addMultipleTeamMember(obj_hidden,obj_list, $(item).attr("hidden-data"), $(item).attr("data-val"));
		    	obj.val('');
		    }
		}).keyup(function(key){
			//backspace or delete
			/*if(key.keyCode == 46 || key.keyCode == 8){
				if((obj.val()).trim() == "" || obj.val() == null){
					obj_hidden.val("");	
			    	obj_hidden.valid();
				}
			}*/
		});
	},
	
	//팀구성 직원 추가 (공통)
	addMultipleTeamMember : function(obj_hidden, obj_list, memberId, memberName){
		var memberInfo = memberId;
		if($.inArray(memberInfo,commonSearch.multipleTeamMemberArray) == -1) {
			obj_list.before(
	    		'<li class="value">'+
                '<span class="txt" id="'+ memberId +'">'+ memberName +'</span>'+
                '<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeMultipleTeamMember(\''+ memberInfo +'\', \''+ obj_hidden.selector +'\');">'+
                '<i class="fa fa-times-circle"></i></a>'+
                '</li>'
	    	);
			commonSearch.multipleTeamMemberArray.push(memberInfo);
			obj_hidden.val(commonSearch.multipleTeamMemberArray);
		}
	},
	
	//팀구성 직원 삭제(공통)
	removeMultipleTeamMember : function(memberInfo,obj_hidden){
		commonSearch.multipleTeamMemberArray.splice(commonSearch.multipleTeamMemberArray.indexOf(memberInfo),1);
		$(obj_hidden).val(commonSearch.multipleTeamMemberArray);
	},
	//===== 팀구성 사용자 복수 검색로직 end ====
	
	partnerInfo2 : function() {
				$.ajax({
					url : "/common/searchPartnerInfo.do",
					async : false,
					data : {
						companyName : $("#textCommonSearchPartner").val()
					},
					beforeSend : function(xhr) {
						xhr.setRequestHeader("AJAX", true);
						if ($("#textCommonSearchPartner").val().length < 2) {
							alert("검색어를 2글자 이상 입력해 주세요.");
							return false;
						}
						$.ajaxLoading();
					},
					success : function(data) {
						var companyList = data.list;
						$("ul.partner-list").html("");
						if (companyList.length > 0) {
							for (var i = 0; i < companyList.length; i++) {
								$("ul.partner-list")
										.append(
												"<li><span>"
														+ companyList[i].COMPANY_NAME
														+ "</span><input type='radio' id='radioCompany' name='radioCompany' onClick='commonSearch.partnerHtml2(\""
														+ companyList[i].COMPANY_NAME
														+ "\","
														+ companyList[i].PARTNER_ID
														+ ")';/></li>");
							}
						} else {
							$("ul.partner-list").append(
									"<li><span>데이터가 없습니다.</span></li>");
						}
					},
					complete : function() {
						$.ajaxLoadingHide();
					}
				});
	},

	partnerHtml2 : function(companyName, companyId) {
		$("div.partner-current").html("");
		$("div.partner-current")
				.append(
						'<span>'
								+ companyName
								+ '<a href="javascript:void(0);" onClick="$(this).parent(\'span\').remove();$(\'#hiddenModalPartnerId\').val(\'\');"><i class="fa fa-times-circle va_m"></i></a></span>');
		$("#hiddenModalPartnerId").val(companyId);
	},

	companyInfo : function() {
		$.ajax({
					url : "/common/searchCompanyInfo.do",
					async : false,
					data : {
						companyName : $("#textCommonSearchCompany").val()
					},
					beforeSend : function() {
						if ($("#textCommonSearchCompany").val().length < 2) {
							alert("검색어를 2글자 이상 입력해 주세요.");
							return false;
						}
						$.ajaxLoading();
					},
					success : function(data) {
						var companyList = data.list;
						$("ul.company-list").html("");
						if (companyList.length > 0) {
							for (var i = 0; i < companyList.length; i++) {
								$("ul.company-list")
										.append(
												"<li><span>"
														+ companyList[i].COMPANY_NAME
														+ "</span><input type='radio' id='radioCompany' name='radioCompany' onClick='commonSearch.companyHtml(\""
														+ companyList[i].COMPANY_NAME
														+ "\","
														+ companyList[i].COMPANY_ID
														+ ")';/></li>");
							}
						} else {
							$("ul.company-list").append(
									"<li><span>데이터가 없습니다.</span></li>");
						}
					},
					complete : function() {

					},
					error : function() {
						alert("고객사 검색을 실패했습니다.\n관리자에게 문의하세요.");
					}
				});
	},

	companyHtml : function(companyName, companyId) {
		$("div.company-current").html("");
		$("div.company-current")
				.append(
						'<span>'
								+ companyName
								+ '<a href="javascript:void(0);" onClick="$(this).parent(\'span\').remove();$(\'#hiddenModalCompanyId\').val(\'\');"><i class="fa fa-times-circle va_m"></i></a></span>');
		$("#hiddenModalCompanyId").val(companyId);
	},

	partnerArray : [],

	partnerInfo : function() {
		$.ajax({
			url : "/common/searchPartnerInfo.do",
			async : false,
			data : {
				companyName : $("#textCommonSearchPartner").val()
			},
			beforeSend : function(xhr) {
				xhr.setRequestHeader("AJAX", true);
				if ($("#textCommonSearchPartner").val().length < 2) {
					alert("검색어를 2글자 이상 입력해 주세요.");
					return false;
				}
				$.ajaxLoading();
			},
			success : function(data) {
				var partnerList = data.list;
				$("ul.company-list").html("");
				if (partnerList.length > 0) {
					for (var i = 0; i < partnerList.length; i++) {
						$("ul.company-list").append(
								'<li><span>'+partnerList[i].COMPANY_NAME+'</span>&nbsp;<a href="javascript:commonSearch.addPartner('+partnerList[i].PARTNER_ID+',\''+partnerList[i].COMPANY_NAME+'\');void(0);"><i class="fa fa-plus va_m"></i></a></li>'
						);
					}
				} else {
					$("ul.company-list").append(
							"<li><span>데이터가 없습니다.</span></li>");
				}
			},
			complete : function() {
				$.ajaxLoadingHide();
			}
		});
	},
	
	
	
	//파트너사 복수검색 (공통)
	multiplePartnerArray : [], //전역변수~
	multiplePartner : function(obj, obj_hidden, obj_list){
		obj.autoComplete({
		    minChars: 2,
		    cache: 0,
		    emptyMsg : "파트너사",
		    emptyUrl : "/partnerManagement/viewPartnerCompanyInfoGate.do?modalReset=1",
		    source: function(term, response){
		    	$.ajax({
	    		  url: "/common/searchPartnerInfo.do",
		            dataType: "json",
		            data: {
		            	companyName: term
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function( data ) {
		            		response( 
			                	$.map(data.list, function( item ) {
			                			return {
			                				label: item.COMPANY_NAME,
			                  			 	value: item.PARTNER_ID
			                  			 	//position : item.POSITION_STATUS,
			                  			 	//email: item.EMAIL
				                		}
			              		})
			              	);	
		            },
		            complete : function() {

					}
		        });
		    },
		    onSelect : function(e, term, item){
		    	commonSearch.addMultiplePartner(obj_hidden,obj_list, $(item).attr("hidden-data"), $(item).attr("data-val"));
		    	obj.val('');
		    }
		}).keyup(function(key){
			//backspace or delete
			/*if(key.keyCode == 46 || key.keyCode == 8){
				if((obj.val()).trim() == "" || obj.val() == null){
					obj_hidden.val("");	
			    	obj_hidden.valid();
				}
			}*/
		});
	},
	
	//파트너사 복수검색 추가 (공통)
	addMultiplePartner : function(obj_hidden,obj_list, partnerId, partnerName){
		if($.inArray(partnerId,commonSearch.multiplePartnerArray) == -1) {
			obj_list.before(
	    		'<li class="value">'+
                '<span class="txt" id="'+ partnerId +'">'+ partnerName +'</span>'+
                '<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeMultiplePartner(\''+ partnerId +'\', \''+ obj_hidden.selector +'\');">'+
                '<i class="fa fa-times-circle"></i></a>'+
                '</li>'
	    	);
			commonSearch.multiplePartnerArray.push(partnerId);
			obj_hidden.val(commonSearch.multiplePartnerArray);
		}
	},
	
	//파트너사 복수검색 삭제(공통)
	removeMultiplePartner : function(partnerId,obj_hidden){
		commonSearch.multiplePartnerArray.splice(commonSearch.multiplePartnerArray.indexOf(partnerId),1);
		$(obj_hidden).val(commonSearch.multiplePartnerArray);
	},
	
	//파트너사 선택
	selectMultiplePartner : function(partnerArray, obj_hidden, obj_list) {
		$.ajax({
			url : "/common/selectPartnerInfo.do",
			async : false,
			data : {
				partnerArray : partnerArray
			},
			beforeSend : function(xhr) {
				xhr.setRequestHeader("AJAX", true);
			},
			success : function(data) {
				var partnerList = data.list;
				if (partnerList.length > 0) {
					for (var i = 0; i < partnerList.length; i++) {
						obj_list.before(
				    		'<li class="value">'+
			                '<span class="txt" id="'+ partnerList[i].PARTNER_ID +'">'+ partnerList[i].COMPANY_NAME +'</span>'+
			                '<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeMultiplePartner(\''+ partnerList[i].PARTNER_ID +'\', \''+ obj_hidden.selector +'\');">'+
			                '<i class="fa fa-times-circle"></i></a>'+
			                '</li>'
				    	);
						commonSearch.multiplePartnerArray.push(partnerList[i].PARTNER_ID);
					}
				}
				obj_hidden.val(commonSearch.multiplePartnerArray);
			}
		});
	},
	
	addPartner : function(partnerid,companyName){
		if($.inArray(partnerid,commonSearch.partnerArray) == -1) {
			$("div.company-current")
			.append(
					'<span id="span_'
					+ partnerid
					+ '">'
					+ companyName
					+ '<a href="javascript:void(0);" onClick="$(this).parent(\'span\').remove();commonSearch.partnerIdRemove(\''
					+ partnerid
					+ '\');"><i class="fa fa-times-circle va_m"></i></a></span>');
			commonSearch.partnerArray.push(partnerid);
			$("#hiddenModalPartnerId").val(commonSearch.partnerArray);
		}
	},
	
	partnerHtml : function(obj) {

		if ($(obj).prop("checked")) {
			$("div.partner-current")
					.append(
							'<span id="span_'
									+ $(obj).val()
									+ '">'
									+ $(obj).prev('span').html()
									+ '<a href="javascript:void(0);" onClick="$(this).parent(\'span\').remove();commonSearch.partnerIdRemove(\''
									+ $(obj).val()
									+ '\');"><i class="fa fa-times-circle va_m"></i></a></span>');
			commonSearch.partnerArray.push($(obj).val());
		} else {
			$("span#span_" + $(obj).val()).remove();
			commonSearch.partnerIdRemove($(obj).val());
		}
		$("#hiddenModalPartnerId").val(commonSearch.partnerArray);
	},

	partnerIdRemove : function(val) {
		$("input:checkbox[name='checkboxPartner'][value='" + val + "']").prop(
				"checked", false);
		commonSearch.partnerArray = $.grep(commonSearch.partnerArray, function(
				value) {
			return value != val;
		});
		$("#hiddenModalPartnerId").val(commonSearch.partnerArray);
	},

	partnerSelect : function(partnerArray) {
		$.ajax({
			url : "/common/selectPartnerInfo.do",
			async : false,
			data : {
				partnerArray : partnerArray
			},
			beforeSend : function(xhr) {
				xhr.setRequestHeader("AJAX", true);
			},
			success : function(data) {
				var partnerList = data.list;
				$("div.company-current").html("");
				if (partnerList.length > 0) {
					for (var i = 0; i < partnerList.length; i++) {
						$("div.company-current")
								.append(
										'<span id="span_'
												+ partnerList[i].PARTNER_ID
												+ '">'
												+ partnerList[i].COMPANY_NAME
												+ '<a href="javascript:void(0);" onClick="$(this).parent(\'span\').remove();commonSearch.partnerIdRemove(\''
												+ partnerList[i].PARTNER_ID
												+ '\');"><i class="fa fa-times-circle va_m"></i></a></span>');
						commonSearch.partnerArray
								.push(partnerList[i].PARTNER_ID);
					}
				}
				$("#hiddenModalPartnerId").val(commonSearch.partnerArray);
			},
			complete : function() {
				
			}
		});
	},
	
	multipleMemberPop : function(){
		$.ajax({
			url: "/common/searchMemberInfo.do",
			async : false,
			dataType: "json",
            data: {
            	memberName: $("#textCommonSearchMember").val()
            },
			beforeSend : function(xhr) {
				xhr.setRequestHeader("AJAX", true);
				if ($("#textCommonSearchMember").val().length < 2) {
					alert("검색어를 2글자 이상 입력해 주세요.");
					return false;
				}
				$.ajaxLoading();
			},
			success : function(data) {
				var memberList = data.list;
				$("ul.company-list").html("");
				if (memberList.length > 0) {
					for (var i = 0; i < memberList.length; i++) {
						$("ul.company-list").append(
								'<li onClick="commonSearch.addMember(\''+memberList[i].MEMBER_ID_NUM+'\',\''+memberList[i].HAN_NAME+'\',\''+memberList[i].EMAIL+'\');"><span>'+memberList[i].HAN_NAME+'</span>&nbsp;<a href="javascript:void(0);"><i class="fa fa-plus va_m"></i></a></li>'
						);
					}
				} else {
					$("ul.company-list").append(
							"<li><span>데이터가 없습니다.</span></li>");
				}
			},
			complete : function() {
				$.ajaxLoadingHide();
			}
		});
	},
	
	addMember : function(memberId,memberName,email){
		if($.inArray(memberId+"/"+email+"/"+memberName,commonSearch.multipleMemberArray) == -1) {
			$("div.company-current")
			.append(
					'<span id="span_'
					+ memberId
					+ '">'
					+ memberName
					+ '<a href="javascript:void(0);" onClick="$(this).parent(\'span\').remove();commonSearch.memberIdRemove(\''
					+ memberId
					+ '\');"><i class="fa fa-times-circle va_m"></i></a></span>');
			commonSearch.multipleMemberArray.push(memberId+"/"+email+"/"+memberName);
			$("#hiddenModalMemberList").val(commonSearch.multipleMemberArray);
		}
	},
	
	memberIdRemove : function(val){
		$("input:checkbox[name='checkboxPartner'][value='" + val + "']").prop("checked", false);
		commonSearch.multipleMemberArray = $.grep(commonSearch.multipleMemberArray, function(value) {
			return value.split('/')[0] != val;
		});
		$("#hiddenModalMemberList").val(commonSearch.multipleMemberArray);
	},
	
	multipleMemberPop2 : function(){
		$.ajax({
			url: "/common/searchMemberInfo.do",
			async : false,
			dataType: "json",
            data: {
            	memberName: $("#textCommonSearchMember2").val()
            },
			beforeSend : function(xhr) {
				xhr.setRequestHeader("AJAX", true);
				if ($("#textCommonSearchMember2").val().length < 2) {
					alert("검색어를 2글자 이상 입력해 주세요.");
					return false;
				}
				
				$.ajaxLoading();
			},
			success : function(data) {
				var memberList = data.list;
				$("ul.company-list").html("");
				if (memberList.length > 0) {
					for (var i = 0; i < memberList.length; i++) {
						$("ul.company-list").append(
								'<li onClick="commonSearch.addMember(\''+memberList[i].MEMBER_ID_NUM+'\',\''+memberList[i].HAN_NAME+'\',\''+memberList[i].EMAIL+'\');"><span>'+memberList[i].HAN_NAME+'</span>&nbsp;<a href="javascript:void(0);"><i class="fa fa-plus va_m"></i></a></li>'
						);
					}
				} else {
					$("ul.company-list").append(
							"<li><span>데이터가 없습니다.</span></li>");
				}
			},
			complete : function() {
				$.ajaxLoadingHide();
			}
		});
	},
	
	//메일공유 복수검색 (공통)
	multipleMailShareMemberArray : [], //전역변수~
	multipleMailShareMember : function(obj, obj_hidden, obj_list){
		obj.autoComplete({
		    minChars: 2,
		    cache: 0,
		    emptyMsg : "직원",
		    //emptyUrl : "/clientManagement/viewClientIndividualInfoGate.do",
		    source: function(term, response){
		    	$.ajax({
	    		  url: "/common/searchMemberInfo.do",
		            dataType: "json",
		            data: {
		            	memberName: term
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function( data ) {
		            		response( 
			                	$.map(data.list, function( item ) {
			                			return {
			                				label: item.HAN_NAME,
			                  			 	value: item.MEMBER_ID_NUM,
			                  			 	position : item.POSITION_STATUS,
			                  			 	email: item.EMAIL
				                		}
			              		})
			              	);	
		            },
		            complete : function() {

					}
		        });
		    },
		    onSelect : function(e, term, item){
		    	commonSearch.addMultipleMailShareMember(obj_hidden,obj_list, $(item).attr("hidden-data"), $(item).attr("data-val"), $(item).attr("hidden-email"),$(item).attr("hidden-position"));
		    	obj.val('');
		    }
		}).keyup(function(key){
			//backspace or delete
			/*if(key.keyCode == 46 || key.keyCode == 8){
				if((obj.val()).trim() == "" || obj.val() == null){
					obj_hidden.val("");	
			    	obj_hidden.valid();
				}
			}*/
		});
	},
	
	//메일공유 복수검색 추가 (공통)
	addMultipleMailShareMember : function(obj_hidden,obj_list, memberId, memberName, memberEmail, memberPosition){
		var emailInfo = memberId+"/"+memberEmail+"/"+memberName;
		if($.inArray(emailInfo,commonSearch.multipleMailShareMemberArray) == -1) {
			obj_list.before(
	    		'<li class="value">'+
                '<span class="txt" id="'+ memberId +'">'+ memberName +' '+ (memberPosition == null ? memberPosition : '') +'</span>'+
                '<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeMultipleMailShareMember(\''+ emailInfo +'\', \''+ obj_hidden.selector +'\');">'+
                '<i class="fa fa-times-circle"></i></a>'+
                '</li>'
	    	);
			commonSearch.multipleMailShareMemberArray.push(emailInfo);
			obj_hidden.val(commonSearch.multipleMailShareMemberArray);
		}
	},
	
	//메일공유 복수검색 삭제(공통)
	removeMultipleMailShareMember : function(emailInfo,obj_hidden){
		commonSearch.multipleMailShareMemberArray.splice(commonSearch.multipleMailShareMemberArray.indexOf(emailInfo),1);
		$(obj_hidden).val(commonSearch.multipleMailShareMemberArray);
	},
	
	//고객명 복수검색 (공통)
	multipleMultipleClientArray : [], //전역변수~
	multipleMultipleClient : function(obj, obj_hidden, obj_list){
		obj.autoComplete({
			minChars: 2,
			cache: 0,
			emptyMsg : "고객",
			emptyUrl : "/clientManagement/viewClientIndividualInfoGate.do",
			source: function(term, response){
				$.ajax({
					url: "/common/searchClientInfo.do",
					dataType: "json",
					data: {
						clientName: term
					},
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
					success: function( data ) {
						response( 
								$.map(data.list, function( item ) {
									var position = '';
									if(!isEmpty(item.POSITION)){
										position = item.POSITION;
									}
									return {
										label: item.CUSTOMER_NAME,
		                  			 	value: item.CUSTOMER_ID,
		                  			 	position : item.COMPANY_NAME,
		                  			 	calendarId : position,
		                  			 	type : 'multiClientIndividual'
									}
								})
						);	
					},
					complete : function() {
						
					}
				});
			},
			onSelect : function(e, term, item){
				commonSearch.addMultipleClient(obj_hidden,obj_list, $(item).attr("hidden-data"), $(item).attr("data-val"), $(item).attr("hidden-position"));
				obj.val('');
				obj_hidden.valid();
			}
		}).keyup(function(key){
			//backspace or delete
			/*if(key.keyCode == 46 || key.keyCode == 8){
				if((obj.val()).trim() == "" || obj.val() == null){
					obj_hidden.val("");	
			    	obj_hidden.valid();
				}
			}*/
		});
	},
	
	//고객명 복수검색 추가 (공통)
	addMultipleClient : function(obj_hidden,obj_list, clientId, clientName, clientCompany){
		if($.inArray(clientId,commonSearch.multipleMultipleClientArray) == -1) {
			obj_list.before(
					'<li class="value">'+
					'<span class="txt" id="'+ clientId +'">'+ clientName +' ['+ clientCompany +']</span>'+
					'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeMultipleClient(\''+ clientId +'\', \''+ obj_hidden.selector +'\');">'+
					'<i class="fa fa-times-circle"></i></a>'+
					'</li>'
			);
			commonSearch.multipleMultipleClientArray.push(clientId);
			obj_hidden.val(commonSearch.multipleMultipleClientArray);
		}
	},
	
	//고객명 복수검색 삭제(공통)
	removeMultipleClient : function(clientId,obj_hidden){
		commonSearch.multipleMultipleClientArray.splice(commonSearch.multipleMultipleClientArray.indexOf(clientId),1);
		$(obj_hidden).val(commonSearch.multipleMultipleClientArray);
	},
	
	//직원 자동 완성 (single)
	singleMember : function(obj, obj_view, obj_hidden, obj_hidden2){
		obj.autoComplete({
		    minChars: 2,
		    cache: 0,
		    emptyMsg : "직원",
		    emptyUrl : null,
		    source: function(term, response){
		    	$.ajax({
		    		url: "/common/searchMemberInfo.do",
		            dataType: "json",
		            data: {
		            	memberName: term
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function( data ) {
		            		response( 
			                	$.map(data.list, function( item ) {
			                			return {
			                				label: item.HAN_NAME,
			                  			 	value: item.MEMBER_ID_NUM,
			                  			 	position: item.POSITION_STATUS,
			                  			 	type : 'singleMember'
				                		}
			              		})
			              	);	
		            },
		            complete : function() {

					}
		        });
		    },
		    onSelect : function(e, term, item){
		    	//선택 값 hidden input
		    	var han_name = $(item).attr("data-val");
		    	var member_id_num = $(item).attr("hidden-data");
		    	var position = '';
		    	if(!isEmpty($(item).attr("hidden-position"))){
		    		position = ' ['+ $(item).attr("hidden-position") +']';
		    	}
		    	
		    	obj_hidden.val(member_id_num);
		    	obj_hidden.valid();
		    	
		    	//선택된 값 디자인 적용 및 인풋 숨김
		    	obj.val('');
		    	obj.hide();
		    	obj_view.before(
						'<li class="value">'+
						'<span class="txt" id="'+ member_id_num +'">'+ han_name + position +'</span>'+
						'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleMember(\''+obj.attr("id")+'\',\''+obj_view.attr("id")+'\',\''+obj_hidden.attr("id")+'\');">'+
						'<i class="fa fa-times-circle"></i></a>'+
						'</li>'
				);
		    	
		    	if(!isEmpty(obj_hidden2)){
		    		obj_hidden2.val(han_name + ($(item).attr("hidden-position") != null ? ' '+ $(item).attr("hidden-position") : ''));
		    	}
		    	
		    	//유효성검사
		    	//obj_hidden.valid();
		    }
		}).keyup(function(key){
			//backspace or delete
			/*if(key.keyCode == 46 || key.keyCode == 8){
				if((obj.val()).trim() == "" || obj.val() == null){
					obj_hidden.val("");	
			    	obj_hidden.valid();
				}
			}*/
		});
	},
	
	//고객사 삭제시 hidden값 삭제
	removeSingleMember : function(obj, obj_view, obj_hidden){
		$("#" + obj).show();
		$("#" + obj_hidden).val("");
	},
	
	singleMember2 : function(obj,objHidden){
		var obj_view =  obj.parent('li');
		var obj_hidden = "";
		var obj_hidden_name = "";
		if(objHidden){
			obj_hidden = objHidden;
		}else{
			obj_hidden = obj.next();
			obj_hidden_name = obj.next().next();
		}
		
		obj.autoComplete({
		    minChars: 2,
		    cache: 0,
		    emptyMsg : "직원",
		    emptyUrl : null,
		    source: function(term, response){
		    	$.ajax({
		    		url: "/common/searchMemberInfo.do",
		            dataType: "json",
		            data: {
		            	memberName: term
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function( data ) {
		            		response( 
			                	$.map(data.list, function( item ) {
			                			return {
			                				label: item.HAN_NAME,
			                  			 	value: item.MEMBER_ID_NUM,
			                  			 	position: item.POSITION_STATUS
				                		}
			              		})
			              	);	
		            },
		            complete : function() {

					}
		        });
		    },
		    onSelect : function(e, term, item){
		    	//선택 값 hidden input
		    	var memberName = $(item).attr("data-val");
		    	var memberIdNum = $(item).attr("hidden-data");
		    	var memberPosition = '';
		    	if(!isEmpty($(item).attr("hidden-position"))){
		    		memberPosition = ' ['+ $(item).attr("hidden-position") +']';
		    	}
		    	
		    	obj_hidden.val(memberIdNum);
		    	if(obj_hidden_name) obj_hidden_name.val(memberName);
		    	
		    	//선택된 값 디자인 적용 및 인풋 숨김
		    	obj.val('');
		    	obj.hide();
		    	obj_view.before(
						'<li class="value">'+
						'<span class="txt" id="'+ memberIdNum +'">'+ memberName + memberPosition +'</span>'+
						'<a href="#" class="remove" onclick="commonSearch.removeSingleMember2(this,\''+ obj_hidden.attr("id") +'\');">'+
						'<i class="fa fa-times-circle"></i></a>'+
						'</li>'
				);
		    	//유효성검사
		    	//obj_hidden.valid();
		    }
		}).keyup(function(key){
			//backspace or delete
			/*if(key.keyCode == 46 || key.keyCode == 8){
				if((obj.val()).trim() == "" || obj.val() == null){
					obj_hidden.val("");	
			    	obj_hidden.valid();
				}
			}*/
		});
	},
	
	//고객개인 삭제
	removeSingleMember2 : function(obj,obj_hidden) {
		$(obj).parent("li").next("li").find("input[type='text']").show();
		if(obj_hidden && obj_hidden != "undefined"){
			$("#"+obj_hidden).val("");
		}else{
			$(obj).parent("li").next("li").find("input[type='hidden']").val("");
		}
		$(obj).parent("li").remove();
	},
	
	//고객사 자동 완성 (single)
	singleCompany : function(obj, obj_view, obj_hidden, obj_id){
		obj.autoComplete({
		    minChars: 2,
		    cache: 0,
		    emptyMsg : "고객사",
		    emptyUrl : "/clientManagement/viewClientCompanyInfoGate.do?modalReset=1",
		    source: function(term, response){
		    	$.ajax({
		    		url: "/common/searchCompanyInfo.do",
		            dataType: "json",
		            data: {
		            	companyName: term
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function( data ) {
		            		response( 
			                	$.map(data.list, function( item ) {
			                			return {
			                				label: item.COMPANY_NAME,
			                  			 	value: item.COMPANY_ID,
			                  			 	type : 'singleCompany'
				                		}
			              		}), term
			              	);	
		            },
		            complete : function() {

					}
		        });
		    },
		    onSelect : function(e, term, item){
		    	//선택 값 hidden input
		    	var company_name = $(item).attr("data-val");
		    	var company_id = $(item).attr("hidden-data");
		    	
		    	obj_hidden.val(company_id);
		    	obj_hidden.valid();
		    	
		    	if(obj_id){
		    		obj_id.val(company_id);
		    	}
		    	
		    	//선택된 값 디자인 적용 및 인풋 숨김
		    	obj.val('');
		    	obj.hide();
		    	obj_view.before(
						'<li class="value">'+
						'<span class="txt" id="'+ company_id +'">'+ company_name +'</span>'+
						'<a href="#" class="remove" onclick="commonSearch.removeSingleCompany(this);">'+
						'<i class="fa fa-times-circle"></i></a>'+
						'</li>'+
						'<a href="/clientManagement/viewClientCompanyInfoDetail.do?company_id='+company_id+'&searchDetail='+encodeURI(company_name)+'" target="_blank" name="aMoveSingleCompany" class="btn-group-sum" style="margin:6px 0 0 5px">바로가기</a>'
				);
		    	
		    	//유효성검사
		    	//obj_hidden.valid();
		    	
		    }
		}).keyup(function(key){
			//backspace or delete
			/*if(key.keyCode == 46 || key.keyCode == 8){
				if((obj.val()).trim() == "" || obj.val() == null){
					obj_hidden.val("");	
			    	obj_hidden.valid();
				}
			}*/
		});
	},
	
	//고객사 삭제시 hidden값 삭제
	removeSingleCompany : function(obj){
		$(obj).parent("li").next().next("li").find("input:nth-child(1)").show();
		$(obj).parent("li").next().next("li").find("input:nth-child(2)").val("");	
		$(obj).parent("li").next("a").remove();
		$(obj).parent("li").remove();
	},
	
	//고객사2 검색
	singleCompany2 : function(obj,objHidden){
		var obj_view =  obj.parent('li');
		var obj_hidden = "";
		var obj_hidden_name = "";
		if(objHidden){
			obj_hidden = objHidden;
		}else{
			obj_hidden = obj.next();
			obj_hidden_name = obj.next().next();
		}
		
		obj.autoComplete({
			minChars: 2,
		    cache: 0,
		    emptyMsg : "고객사",
		    emptyUrl : "/clientManagement/viewClientCompanyInfoGate.do?modalReset=1",
		    source: function(term, response){
		    	$.ajax({
		    		url: "/common/searchCompanyInfo.do",
		            dataType: "json",
		            data: {
		            	companyName: term
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function( data ) {
		            		response( 
			                	$.map(data.list, function( item ) {
			                			return {
			                				label: item.COMPANY_NAME,
			                  			 	value: item.COMPANY_ID,
			                  			 	type : 'singleCompany'
				                		}
			              		})
			              	);	
		            },
		            complete : function() {

					}
		        });
		    },
		    onSelect : function(e, term, item){
		    	//선택 값 hidden input
		    	var company_name = $(item).attr("data-val");
		    	var company_id = $(item).attr("hidden-data");
		    	
		    	obj_hidden.val(company_id);
		    	if(obj_hidden_name) obj_hidden_name.val(company_name);
		    	
		    	//선택된 값 디자인 적용 및 인풋 숨김
		    	obj.val('');
		    	obj.hide();
		    	obj_view.before(
						'<li class="value">'+
						'<span class="txt" id="'+ company_id +'">'+ company_name +'</span>'+
						'<a href="#" class="remove" onclick="commonSearch.removeSingleCompany2(this,\''+ obj_hidden.attr("id") +'\');">'+
						'<i class="fa fa-times-circle"></i></a>'+
						'</li>'
				);
		    	//유효성검사
		    	//obj_hidden.valid();
		    }
		}).keyup(function(key){
			//backspace or delete
			/*if(key.keyCode == 46 || key.keyCode == 8){
				if((obj.val()).trim() == "" || obj.val() == null){
					obj_hidden.val("");	
			    	obj_hidden.valid();
				}
			}*/
		});
	},
	
	//고객사2 삭제
	removeSingleCompany2 : function(obj,obj_hidden) {
		$(obj).parent("li").next("li").find("input[type='text']").show();
		if(obj_hidden && obj_hidden != "undefined"){
			$("#"+obj_hidden).val("");
		}else{
			$(obj).parent("li").next("li").find("input[type='hidden']").val("");
		}
		$(obj).parent("li").remove();
	},
	
	
	//고객사 자동 완성 (매출품목에서 사용)
	singleCompanyProduct : function(obj, obj_view, obj_hidden){
		obj.autoComplete({
		    minChars: 2,
		    cache: 0,
		    emptyMsg : "고객사",
		    emptyUrl : "/clientManagement/viewClientCompanyInfoGate.do?modalReset=1",
		    source: function(term, response){
		    	$.ajax({
		    		url: "/common/searchCompanyInfo.do",
		            dataType: "json",
		            data: {
		            	companyName: term
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function( data ) {
		            		response( 
			                	$.map(data.list, function( item ) {
			                			return {
			                				label: item.COMPANY_NAME,
			                  			 	value: item.COMPANY_ID,
			                  			 	type : 'singleCompany'
				                		}
			              		})
			              	);	
		            },
		            complete : function() {

					}
		        });
		    },
		    onSelect : function(e, term, item){
		    	//선택 값 hidden input
		    	var company_name = $(item).attr("data-val");
		    	var company_id = $(item).attr("hidden-data");
		    	
		    	obj_hidden.val(company_id);

		    	//선택된 값 디자인 적용 및 인풋 숨김
		    	obj.val('');
		    	obj.hide();
		    	obj_view.before(
						'<li class="value">'+
						'<span class="txt" id="'+ company_id +'">'+ company_name +'</span>'+
						'<a href="#" class="remove" onclick="commonSearch.removeSingleCompanyProduct(this);">'+
						'<i class="fa fa-times-circle"></i></a>'+
						'</li>'
				);
		    	
		    	//유효성검사
		    	//obj_hidden.valid();
		    	
		    }
		}).keyup(function(key){
			//backspace or delete
			/*if(key.keyCode == 46 || key.keyCode == 8){
				if((obj.val()).trim() == "" || obj.val() == null){
					obj_hidden.val("");	
			    	obj_hidden.valid();
				}
			}*/
		});
	},
	
	//고객사 삭제시 hidden값 삭제
	removeSingleCompanyProduct : function(obj){
		$(obj).parent("li").next("li").find("input:nth-child(1)").show();
		$(obj).parent("li").next("li").find("input:nth-child(2)").val("");	
		$(obj).parent("li").remove();
	},
	
	
	//고객담당자 자동 완성 (single) - 고객개인에서 가져옴~
	singleClientMaster : function(obj, obj_view, obj_hidden, obj_erp_hidden){
		obj.autoComplete({
		    minChars: 2,
		    cache: 0,
		    emptyMsg : "고객담당자",
		    emptyUrl : "/clientManagement/viewClientIndividualInfoGate.do?modalReset=1",
		    source: function(term, response){
		    	$.ajax({
		    		url: "/common/searchClientInfo.do",
		            dataType: "json",
		            data: {
		            	clientName: term
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function( data ) {
		            		response( 
			                	$.map(data.list, function( item ) {
			                			return {
		                  			 		label: item.CUSTOMER_NAME,
			                  			 	value: item.CUSTOMER_ID,
			                  			 	position: item.COMPANY_NAME,
			                  			 	erpcd: item.ERP_CLIENT_CODE,
			                  			 	type : 'singleMember'
				                		}
			              		})
			              	);	
		            },
		            complete : function() {
					}
		        });
		    },
		    onSelect : function(e, term, item){
		    	//선택 값 hidden input
		    	var client_name = $(item).attr("data-val");
		    	var client_code = $(item).attr("hidden-data");
		    	var company_name = $(item).attr("hidden-position");
		    	var erp_cd = $(item).attr("hidden-erpcd");
		    	
		    	obj_hidden.val(client_code);
		    	obj_hidden.valid();
		    	
		    	if(erp_cd && erp_cd != 'undefined'){
		    		obj_erp_hidden.val(erp_cd);
		    	}else{
		    		obj_erp_hidden.val("");
		    	}

		    	//선택된 값 디자인 적용 및 인풋 숨김
		    	obj.val('');
		    	obj.hide();
		    	obj_view.before(
						'<li class="value">'+
						'<span class="txt" id="'+ client_code +'">'+ client_name +' ['+ company_name +']</span>'+
						'<a href="#" class="remove" onclick="$(this).parent(\'li\').remove();commonSearch.removeSingleClientMaster(\''+obj.attr("id")+'\',\''+obj_view.attr("id")+'\',\''+obj_hidden.attr("id")+'\');">'+
						'<i class="fa fa-times-circle"></i></a>'+
						'</li>'+
						'<a href="/clientManagement/viewClientIndividualInfoDetail.do?customer_id='+client_code+'&search_detail='+encodeURI(client_name)+'" target="_blank" id="aMoveSingleClientMaster" class="btn-group-sum" style="margin:6px 0 0 5px">바로가기</a>'
				);
		    	//obj_hidden.valid();
		    	
		    }
		}).keyup(function(key){
			//backspace or delete
			/*if(key.keyCode == 46 || key.keyCode == 8){
				if((obj.val()).trim() == "" || obj.val() == null){
					obj_hidden.val("");	
			    	obj_hidden.valid();
				}
			}*/
		});
	},
	
	//고객사 삭제시 hidden값 삭제
	removeSingleClientMaster : function(obj, obj_view, obj_hidden, obj_erp_hidden){
		$("#" + obj).show();
		$("#" + obj_hidden).val("");
		$("#" + obj_erp_hidden).val("");
		$("#divSingleClientMasterErr").hide();
		$("#aMoveSingleClientMaster").remove();
	},
	
	
	//영업기회 품목 자동완성
	singleProduct : function(obj, idx){
		var obj_view =  obj.parent('li');
		var obj_hidden = obj.next();
		var obj_hidden_works = obj.next().next();
		var obj_span = obj.parents('td').next().find("span");
		
		obj.autoComplete({
		    minChars: 3,
		    cache: 0,
		    emptyMsg : "품목",
		    wd : 600,
		    source: function(term, response){
		    	$.ajax({
		            url: "/common/searchProductInfo.do",
		            dataType: "json",
		            data: {
		            	searchProduct: term
		            },
		            beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
		            success: function( data ) {
		            		response( 
			                	$.map(data.list, function( item ) {
			                			return {
			                  				label: item.PRODUCT_NAME,
			                  			 	value: item.PRODUCT_CODE,
			                  			 	position : item.WORKS_CODE,
			                  			 	st : item.PRODUCT_STANDARD,
			                  			 	type : 'singleProduct'
				                		}
			              		})
			              	);	
		            },
		            complete : function() {

					}
		        });
		    },
		    onSelect : function(e, term, item){
		    	//선택 값 hidden input
		    	var productName = $(item).attr("data-val");
		    	var productCode = $(item).attr("hidden-data");
		    	var worksCode = $(item).attr("hidden-position");
		    	var st = $(item).attr("hidden-st");
		    	
		    	obj_hidden.val(productCode);
		    	obj_hidden_works.val(worksCode);
		    	obj_span.html(st);
		    	
		    	//선택된 값 디자인 적용 및 인풋 숨김
		    	obj.val('');
		    	obj.hide();
		    	obj_view.before(
						'<li class="value">'+
						/*'<span class="txt" id="'+ productCode +'">'+ productCode +' ['+ worksCode +']</span>'+*/
						'<span class="txt" id="'+ productCode +'">'+ productCode +'</span>'+
						'<a href="#" class="remove" onclick="commonSearch.removeSingleProduct(this);">'+
						'<i class="fa fa-times-circle"></i></a>'+
						'</li>'
				);
		    	//유효성검사
		    	//obj_hidden.valid();
		    }
		}).keyup(function(key){
			//backspace or delete
			/*if(key.keyCode == 46 || key.keyCode == 8){
				if((obj.val()).trim() == "" || obj.val() == null){
					obj_hidden.val("");	
			    	obj_hidden.valid();
				}
			}*/
		});
	},
	
	//품목 삭제시 hidden값 삭제
	removeSingleProduct : function(obj) {
		$(obj).parent("li").next("li").find("input:nth-child(1)").show();
		$(obj).parent("li").next("li").find("input:nth-child(2)").val("");	
		$(obj).parent("li").next("li").find("input:nth-child(3)").val("");	
		$(obj).parents("td").next("td").find("span").html("");
		$(obj).parents("td").next().next().find("input").val(0);
		$(obj).parents("td").next().next().next().find("input").val(0);
		$(obj).parent("li").remove();
		oppProduct.salesSum();
		oppProduct.psSum();
	}
	
}

//브라우저 확인
function getBrowserCheck(){
	var browser = "";
	var ua = window.navigator.userAgent;
	if(ua.indexOf('MSIE') > 0 || ua.indexOf('Trident') > 0){
		browser = getIEVersionCheck();
		
	}else if(ua.indexOf('Opera') > 0 || ua.indexOf('OPR') > 0){
		browser = "Opera";
	}else if(ua.indexOf('Firefix') > 0){
		browser = "Firefox";
	}else if(ua.indexOf('Safari') > 0){
		if(ua.indexOf('Chrome') > 0){
			browser = "Chrome";
		}else{
			browser = "Safari";
		}
	}
	return browser;
}

//익스플로러 버전 확인
function getIEVersionCheck(){ 
	 var word; 
	 var version = "N/A"; 
	 var agent = navigator.userAgent.toLowerCase(); 
	 var name = navigator.appName; 

	 // IE old version ( IE 10 or Lower ) 
	 if(name == "Microsoft Internet Explorer"){
		 word = "msie "; 
	 }else{ 
		 // IE 11 
		 if(agent.search("trident") > -1) word = "trident/.*rv:"; 
		 // Microsoft Edge  
		 else if(agent.search("edge/") > -1) word = "edge/"; 
	 } 

	 var reg = new RegExp(word + "([0-9]{1,})(\\.{0,}[0-9]{0,1})"); 

	 if(reg.exec( agent ) != null) version = RegExp.$1 + RegExp.$2; 
	 //console.log("IEversion : "+version);
	 switch(version){
	 	case "N/A":
	 		return "N/A";
	 		break; //IE브라우저가 아닐경우
	 	case "11.0":
	 		return "11.0";
	 		break; //IE 11버전일 경우
	 	case "10.0":
	 		return "10.0";
	 		break; //IE 10버전일 경우
	 	case "9.0":
	 		return "9.0";
	 		break; //IE 9버전일 경우
	 	default :
	 		return false;
	 		break; //그 외(IE8 이전 or Edge)
	 }
	 
}

//jqgrid 에러 공통 처리
$.error = function(xhr, status, err){
    if(xhr.status == 401){
        alert("인증에 실패 했습니다. 로그인 페이지로 이동합니다.");
        location.href = "/logout.do";
     }else if(xhr.status == 403){
        alert("세션이 만료가 되었습니다. 로그인 페이지로 이동합니다.");
        location.href = "/logout.do";
     }else if(xhr.status == 404){
	        alert("찾을 수 없는 요청입니다.\n관리자에게 문의하세요.");
     }else if(xhr.status == 500){
    	alert("요청을 실패했습니다.\n관리자에게 문의하세요.");
     }
}

//ajax 공통처리
$.ajaxSetup({
	error : function(xhr, status, err){
	    if(xhr.status == 401){
	        alert("인증에 실패 했습니다. 로그인 페이지로 이동합니다.");
	        location.href = "/logout.do";
	     }else if(xhr.status == 403){
	        alert("세션이 만료가 되었습니다. 로그인 페이지로 이동합니다.");
	        location.href = "/logout.do";
	     }else if(xhr.status == 404){
		        alert("찾을 수 없는 요청입니다.\n관리자에게 문의하세요.");
		 }else if(xhr.status == 500){
	    	alert("요청을 실패했습니다.\n관리자에게 문의하세요.");
	     }
	    $.ajaxLoadingHide();
	}
});

//줄바꿈 시 textarea 높이 조절.
function textAreaResize(obj){
	obj.style.height = "1px";
	obj.style.height = (12+obj.scrollHeight)+"px";
}

//textarea 높이 자동계산
function textAreaAutoSize(obj){
	var regExp = /\n/gi;
	var n = obj.val().match(regExp);
	
	if(n!=null){
		obj.css("height", ((n.length*20)+23)+"px");
	}else{
		obj.css("height", "33px");
	}
}

//더존ERP관련 검색
var duzonSearch = {
		reset : function() {
			$("#textDuzonSearchSalesMan").val("");
			$("ul.company-list").html("");
			$('div.custom-company-pop').show();
		},
		
		salesManPop : function() {
			$.ajax({
				url: "/duzon/searchSalesManInfo.do",
				async : false,
				dataType: "json",
	            data: {
	            	clientName: $("#textDuzonSearchSalesMan").val()
	            },
				beforeSend : function(xhr) {
					xhr.setRequestHeader("AJAX", true);
					if ($("#textDuzonSearchSalesMan").val().length < 2) {
						alert("검색어를 2글자 이상 입력해 주세요.");
						return false;
					}
					$.ajaxLoading();
				},
				success : function(data) {
					var salesManList = data.list;
					$("ul.company-list").html("");
					if (salesManList.length > 0) {
						for (var i = 0; i < salesManList.length; i++) {
							$("ul.company-list").append(
									'<li onClick="duzonSearch.addSalesMan(\''+salesManList[i].COMPANY_CODE+'\',\''+salesManList[i].CLIENT_CODE+'\');"><span><a href="javascript:void(0);">'+salesManList[i].CLIENT_NAME
									+'['+salesManList[i].COMPANY_NAME+']'+'</span>&nbsp;<i class="fa fa-plus va_m"></i></a></li>'
							);
						}
					} else {
						$("ul.company-list").append(
								"<li><span>데이터가 없습니다.</span></li>");
					}
				},
				complete : function() {
					$.ajaxLoadingHide();
				}
			});
		},
		
		salesManPopOpp : function() {
			$.ajax({
				url: "/duzon/searchSalesManInfo.do",
				async : false,
				dataType: "json",
	            data: {
	            	clientName: $("#textDuzonSearchSalesMan").val()
	            },
				beforeSend : function(xhr) {
					xhr.setRequestHeader("AJAX", true);
					if ($("#textDuzonSearchSalesMan").val().length < 2) {
						alert("검색어를 2글자 이상 입력해 주세요.");
						return false;
					}
					$.ajaxLoading();
				},
				success : function(data) {
					var salesManList = data.list;
					$("ul.company-list").html("");
					if (salesManList.length > 0) {
						for (var i = 0; i < salesManList.length; i++) {
							$("ul.company-list").append(
									'<li onClick="duzonSearch.addSalesMan(\''+salesManList[i].COMPANY_CODE+'\',\''+salesManList[i].CLIENT_CODE+'\');"><span><a href="javascript:void(0);">'+salesManList[i].CLIENT_NAME
									+'['+salesManList[i].COMPANY_NAME+']'+'</span>&nbsp;<button type="button" class="btn btn-gray btn-file" onClick="modal.updateClientMasterErpCd(\''+salesManList[i].CLIENT_CODE+'\')">연동</button></li>'
							);
						}
					} else {
						$("ul.company-list").append(
								"<li><span>데이터가 없습니다.</span></li>");
					}
				},
				complete : function() {
					$.ajaxLoadingHide();
				}
			});
		},
		
		addSalesMan : function(erp_company_code, erp_client_code) {
			$("#textModalERPClientCode").val(erp_client_code);
			$("#formModalData #spanERPClientCodeCheck > i.fa.fa-close").hide();
			$("#formModalData #spanERPClientCodeCheck > i.fa.fa-check").show();
			$('div.custom-company-pop').hide();
		}

}

function fnStatusColor(dueDate, closeDate, nowDate){
	var statusColor = "";
	dueDate = (dueDate.replaceAll("-","")).trim();
	closeDate = (closeDate.replaceAll("-","")).trim();
	if((dueDate >= nowDate) && closeDate == ""){
		statusColor = "#ffc000";
	}else if(dueDate < nowDate && closeDate == ""){
		statusColor = "#f20056";
	}else if(closeDate != "" && closeDate != null){
		statusColor = "#1ab394";
	} 
	return statusColor; 
}

function fnStatusColor2(dueDate, closeDate, nowDate){
	var statusColor = "";
	dueDate = (dueDate.replaceAll("-","")).trim();
	closeDate = (closeDate.replaceAll("-","")).trim();
	if((dueDate >= nowDate) && closeDate == ""){
		statusColor = "#ffaa00";
	}else if(dueDate < nowDate && closeDate == ""){
		statusColor = "#f20056";
	}else if(closeDate != "" && closeDate != null){
		statusColor = "#1ab394";
	} 
	return statusColor; 
} 

//공통 페이지 처리
var page = {
		status : 1,  // 왼쪽 고객 리스트 스크롤 시도시에, 기본정보가 처음으로 돌아오는 현상을 방지하기 위함.
		start : 1,
		end : 20,
		winStart : 1,
		winEnd : 12,
		serchStart : 1,
		serchEnd :20,
		salesStatus : 1,
		rowCount : null // 리스트 가져올 갯수
}

//페이징
var pagingParams;
//페이징 초기화
var initPaing = function(cat){
	pagingParams ={
		currentPage : 1, // 현재 페이지
		pagingSize : 5, // 페이징 보여줄 갯수
		totalCount : null
	}
	
	//리스트 페이지 사용자 rowCount설정 조회
	$.ajax({
		url : "/common/selectUserPageRowCount.do",
		async : false,
			datatype : 'json',
			method: 'POST',
		data : {
			category : cat
		},
		beforeSend : function(xhr){
			xhr.setRequestHeader("AJAX", true);
			$.ajaxLoading();
		},
		success : function(data){
			page.rowCount = data.rowCount;
		},
		complete : function(){
			$.ajaxLoadingHide();
		}
	});
};

var pagingCalculation = function(pn,ep){
	var flag = true;
	if(!isEmpty(pn)){
		if(pn < 1 || pn > ep){
			flag = false;
		}else{
			pagingParams.currentPage = pn;
			flag = true;
		}
	}
	return flag;
};

function pageCreateNavi(data) {
	/* 
		cat 
	 	1 : 고객컨택
	 	2 : 영업기회
	 	3 : 잠재영업기회
	 	4 : 고객이슈
		5 : 고객만족도
		6 : 서비스프로젝트
		7 : 제안서정보
		8 : 회사/부문별전략
		9 : 고객별전략
		10 : 전략프로젝트
	*/
	var sp = data.listPaging.startPage;
	var ep = data.listPaging.endPage;
	var toEp = data.listPaging.toEndPage
	var cp = data.listPaging.currentPage;
	var ps = data.listPaging.pagingSize;
	var fc = data.fncName;
	
	var pageView = "";
	pageView += '	<button type="button" class="btn btn-white" onClick="'+ fc +'(' + (sp-ps) + ',' + toEp + ');">' + 
				'		<i class="fa fa-chevron-left"></i>' + 
				'	</button>';
	for(var pi=sp; pi<=ep; pi++){
		pageView += '	<button class="btn btn-white ';
		(pi == cp) ? pageView += 'active' : pageView += "";
		pageView += '" onClick="'+ fc +'(' + pi +',' + toEp + ');">' + pi + '</button>'
	}
	pageView += '	<button type="button" class="btn btn-white" onClick="'+ fc +'(' + (sp+ps) + ',' + toEp + ');">' +
				'		<i class="fa fa-chevron-right"></i> ' + 
				'	</button>';
	
	$("div.btn-group.pull-right.pd-t10").html(pageView);
	
}
