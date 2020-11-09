var partnerSearch = {
		
	/**
	 * 파트너사 자동검색
	 */
	singlePartner : function(obj, obj_view, obj_hidden, obj_id){
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
			                			return {
			                				label: item.COMPANY_NAME,
			                  			 	value: item.PARTNER_ID
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
						'<a href="javascript:void(0);" class="remove" onclick="partnerSearch.removeSinglePartner(this);">'+
						'<i class="fa fa-times-circle"></i></a>'+
						'</li>'
				);
		    	
		    	//유효성검사
//		    	obj_hidden.valid();
		    	
		    }
		}).keyup(function(key){
		});
	},
	
	removeSinglePartner : function(obj){
		$(obj).parent("li").next("li").find("input:nth-child(1)").show();
		$(obj).parent("li").next("li").find("input:nth-child(2)").val("");	
		$(obj).parent("li").remove();
		
		$('#textCommonSearchCompanyId').val('');
		$('#hiddenModalCompanyId').val('');
	},
		
	/**
	 * validate
	 * @returns
	 */
	validate : function(){
		$("#formModalData").validate({ // joinForm에 validate를 적용
			ignore: '', 
			rules : {
				textModalPartnerName : {
					required : true,
					maxlength : 40
				},
				hiddenModalCompanyId : {
					required : true
				},
				textModalEmail : {
					email: true
				}
			},
			messages : { // rules에 해당하는 메시지를 지정하는 속성
				textModalPartnerName : {
					required : "파트너사 개인명을 입력하세요.",
				},
				hiddenModalCompanyId : {
					required : "파트너사를 검색하세요."
				},
				textModalEmail : {
					email : "올바른형식의 이메일을 입력하세요."
				}
			},
			errorPlacement : function(error, element) {
			    if($(element).prop("id") == "hiddenModalCompanyId") {
			        $("#ulModalCompanyName").after(error);
			        location.href = "#ulModalCompanyName";
			    }
			    else {
			        error.insertAfter(element); // default error placement.
			    }
			}
		});
	},
	
	/**
	 * submit
	 * @param html
	 * @param el_id
	 * @returns
	 */
	submit : function(){
		
		var modalFlag = $("#mode").val();
		var url = (modalFlag == "upd")?"/partnerManagement/updatePartnerIndividualInfo.do":"/partnerManagement/insertPartnerIndividualInfo.do";		
		var browser = getIEVersionCheck();
		
		$('#formModalData').ajaxForm({
    		url : url,
    		async : false,
			beforeSubmit: function (data,form,option) {				
				if(!confirm("저장하시겠습니까?")) return false;
			},
			data : {
				datatype : 'json',
				browser : browser
			},
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			success: function(data){
				
				if(data.cnt > 0){
	                alert("저장하였습니다.");
	                                
	                var returnPkValue = data.returnPK;
	                
	                if(!returnPkValue){  
	                	
	                	if($('#hiddenModalPK').val()){
	                		returnPkValue = $('#hiddenModalPK').val();
	                	}else{
	                		location.href= '/partnerManagement/viewPartnerIndividualInfoGate.do';
	                		return;
	                	}
	                }                
	                
	                // 디테일페이지로 이동
	                $("#formDetail #customer_id").val(returnPkValue);
	                $("#formDetail #company_id").val($('#hiddenModalCompanyId').val());		

	        		$("#formDetail #customerId").val(returnPkValue);
	        		$("#formDetail #companyId").val($('#hiddenModalCompanyId').val());
	        		$("#formDetail").attr({action:"/partnerManagement/viewPartnerIndividualInfoDetail.do", method:"get"}).submit();
	            	            	
	             }else{
	                alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
	            }
				
				//성공후 서버에서 받은 데이터 처리
//				if(data.cnt > 0){
//					
//					if(modalFlag == "upd") {
//						salesDetail.insertQualification();
//					}
//					
//					alert("저장하였습니다.");
//					if(modalFlag == "upd") {
//						window.location.href = "/partnerManagement/viewPartnerIndividualInfoGate.do<c:if test="${req_params ne ''}">?${req_params}</c:if>";
//					}
//					else {
//						window.location.href = "/partnerManagement/viewPartnerIndividualInfoGate.do<c:if test="${req_params ne ''}">?${req_params}</c:if>";
//					}
//					
//					if(modalFlag == "upd") {
//						clientSerchList.get(1, 20);
//						clientList.goDetail($("#hiddenPartnerIndividualId").val(), $("#hiddenModalCompanyId").val());
//					}else {
//						searchDetailClick.goDetail(data.filePK, $("#hiddenModalCompanyId").val(), $("#textModalPartnerName").val());
//					}
//
//					if(modalFlag=="upd"){
//						$("#divModalPhotoUploadArea .fileModalUploadPhoto").remove();
//						$('#divFileUploadList').html('<span>파일을 선택해 주세요.</span>');
//						$("#divModalFile > span").remove();
//					}else if(modalFlag=="ins"){
//						$('#myModal1').modal("hide");
//					}
//					
//				}else{
//					alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
//				}
			},
			error : function(xhr, status, code){
				/*alert("[에러]\ncode:"+xhr.status+"\n"+"message:"+xhr.responseText+"\n"+"error:"+error);*/
			},
			complete : function(){
				//$jq.ajaxLoadingHide();
			}
		});
		
		$('#formModalData').submit();
	},
	
	/**
	 * 수정 시, 파트너사 셋팅
	 */
	setPartner : function(){
		
		var partnerId = $('#hiddenModalCompanyId').val();
		var partnerName = $('#hiddenModalCompanyName').val();
				
		$("#textCommonSearchCompany").hide();
	    $('#liModalCompanyName').before(
	    		'<li class="value">'+
				'<span class="txt" id="'+ partnerId +'">'+ partnerName + '</span>'+
				'<a href="javascript:void(0);" class="remove" onclick="partnerSearch.removeSinglePartner(this);">'+
				'<i class="fa fa-times-circle"></i></a>'+
				'</li>'
	    );
	}
}


	
/*jQuery(document).ready(function($jq){
	//자동완성 검색
	//commSearch.partner($jq("#formModalData #textCommonSearchCompany"), $jq('#formModalData #hiddenModalCompanyId'), $jq("#formModalData #textCommonSearchCompanyId"));
	
	$jq("#textCommonSearchCompany").autocomplete({
		width: 300,
		max: 10,
		delay: 100,
		minLength: 2,
		autoFocus: true,
		cacheLength: 1,
		scroll: true,
		highlight: false,
		source: function(request, response) {

			$jq.ajax({
				url: "/common/searchPartnerInfo.do",
				dataType: "json",
				data: {
					companyName: request.term
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success: function( data, textStatus, jqXHR ) {
					//alert("data : " + data);
					//response(data.list);

					response( 
							$jq.map(data.list, function( item ) {
								//console.log(item.PARTNER_PERSONAL_NAME);
								//alert("item.COMPANY_NAME : " + item.COMPANY_NAME)
								return {
									label: item.COMPANY_NAME,
									value: item.PARTNER_ID
								}
							})
					);

				},
				
				complete : function() {
				},
				
				error: function(jqXHR, textStatus, errorThrown){
					//console.log( textStatus);
					alert(textStatus);
				}
			});
		},
		select: function(event, ui) {
			event.preventDefault();
			$jq("input#hiddenModalCompanyId").val(ui.item.value);
			$jq("input#textCommonSearchCompany").val(ui.item.label);
			$jq("input#textCommonSearchCompanyId").val(ui.item.value);
			
			//$jq("input#hiddenModalPartnerId").val(ui.item.value);
			//alert(ui.item.value);
		},
		focus : function(event, ui) {
			event.preventDefault();
			//$jq("input#textCommonSearchCompany").val(ui.item.label);
		}
		
		,
		close : function(event, ui) {
			event.preventDefault();
			$jq("#textModalDivision").focus();
			
		}
		
	});
	
	 $jq('#tab1').click(function(){
		$jq('#formTab1').show();
		$jq('#formTab2').hide();
		
		$jq('#tab1').addClass("active");
		$jq('#tab2').removeClass();
	});
	
	$jq('#tab2').click(function(){
		$jq('#formTab1').hide();
		$jq('#formTab2').show();
		
		$jq('#tab1').removeClass();
		$jq('#tab2').addClass("active");
	}); 
	
	$jq('#photo_upload').click(function(event){
		event.preventDefault();
		$jq("#fileModalUploadPhoto").click();
	});
	
	$jq('#btn_submit').click(function(event){
		//var browser = getIEVersionCheck();
		alert("저장버튼누름");
		//alert($jq("#fileModalUploadPhoto").val());

		var url;
		
		if(comparePerSonalProfile == $("#divPersonalInfoProfile").html())$("#textModalPerSonalProfile").val("");
		if(comparePerSonalActs == $("#divPersonalInfoSocialAtcs").html())$("#textModalPerSonalActs").val("");
		if(comparePerSonalFamily == $("#divPersonalInfoFamily").html())$("#textModalPerSonalFamily").val("");
		if(comparePerSonalInclination == $("#divPersonalInfoInclination").html())$("#textModalPerSonalInclination").val("");
		if(comparePerSonalFamiliars == $("#divPersonalInfoFamiliars").html())$("#textModalPerSonalFamiliars").val("");
		if(comparePerSonalSNS == $("#divPersonalInfoSNS").html())$("#textModalPerSonalSNS").val("");
		if(comparePerSonalETC == $("#divPersonalInfoETC").html())$("#textModalPerSonalETC").val("");
		
		(modalFlag == "ins") ? url = "/partnerManagement/insertPartnerIndividualInfo.do" : url = "/partnerManagement/updatePartnerIndividualInfo.do";
		
		
		var modalFlag = $jq("#mode").val();
		
		url = (modalFlag == "upd")?"/partnerManagement/updatePartnerIndividualInfo.do":"/partnerManagement/insertPartnerIndividualInfo.do";
		
 		//유효성 체크
		//파트너사직원명 유효성 체크
		if(!$('#textModalPartnerName ').val()) {
			alert("파트너사직원명을 입력하세요!");
			$('#textModalPartnerName ').focus();
			return false;
		}
		//직급 유효성 체크
		if(!$('#textModalPosition').val()) {
			alert("직급을 입력하세요!");
			$('#textModalPosition').focus();
			return false;
		}
		//휴대전화 유효성 체크
		if(!$('#textModalCellPhone').val()){
			alert("휴대전화를 입력해주세요!");
			$('#textModalCellPhone').focus();
			return false;
		}
		//직장전화 유효성 체크
		if(!$('#textModalPhone').val()) {
			alert("직장전화를 입력해주세요!");
			$('#textModalPhone').focus();
			return false;
		}
		//이메일 유효성 체크
		if(!$('#textModalEmail').val()){
			alert("이메일을 입력해주세요!");
			$('#textModalEmail').focus();
			return false;
		}
		
 		//소속사정보 탭 포커싱 속성
		function formtab2(){
			$jq('#formTab1').hide();
			$jq('#formTab2').show();
			$jq('#tab_1').removeClass();
			$jq('#tab_2').addClass("active");
		} 
		 
		//파트너사 유효성 체크
		if(!$('#textCommonSearchCompany').val()){
			alert("파트너사를 검색해주세요!");
			formtab2();
			$jq('#textCommonSearchCompany').focus();
			
			return false;
		}
		
		//소속본부 유효성 체크
		if(!$('#textModalDivision').val()){
			alert("소속본부를 입력해주세요!");
			formtab2();
			$jq('#textModalDivision').focus();
			
			return false;
		}
		
		//소속부서 유효성 체크
		if(!$('#textModalPost').val()){
			alert("소속부서를 입력해주세요!");
			formtab2();
			$jq('#textModalPost').focus();
			
			return false;
		}
		
		//소속팀 유효성 체크
		if(!$('#textModalTeam').val()){
			alert("소속팀을 입력해주세요!");
			formtab2();
			$jq('#textModalTeam').focus();
			
			return false;
		}
		
		//직책 유효성 체크
		if(!$('#textModalPositionDuty').val()){
			alert("직책을 입력해주세요!");
			formtab2();
			$jq('#textModalPositionDuty').focus();
			
			return false;
		}
		
		//담당업무 유효성 체크
		if(!$('#textModalDuty').val()){
			alert("담당업무를 입력해주세요!");
			formtab2();
			$jq('#textModalDuty').focus();
			
			return false;
		}
		
		//친한고객사 유효성 체크
		if(!$('#textModalFriendShipCompany').val()){
			alert("친한고객사를 입력해주세요!");
			formtab2();
			$jq('#textModalFriendShipCompany').focus();
			
			return false;
		}
		
		//친한고객 유효성 체크
		if(!$('#textModalFriendShipCustomer').val()){
			alert("친한고객을 입력해주세요!");
			formtab2();
			$jq('#textModalFriendShipCustomer').focus();
			
			return false;
		}
		
		//개인정보 유효성 체크
		if(!$('#textModalPerSonalInfo').val()){
			alert("개인정보를 입력해주세요!");
			formtab2();
			$jq('#textModalPerSonalInfo').focus();
			
			return false;
		} 
		
		$jq('#formModalData').ajaxForm({
    		url : url,
    		async : false,
			beforeSubmit: function (data,form,option) {
				
				if(!compareFlag){
					if(!confirm("저장하시겠습니까?")) return false;
					salesDetail.selectVendor(lastEditRowQ);
				}
				
				
				if(!confirm("저장하시겠습니까?")) return false;
				$jq.ajaxLoadingShow();
			},
			data : {
				datatype : 'json',
				browser:browser
			},
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", true);
			},
			success: function(data){
				//성공후 서버에서 받은 데이터 처리
				if(data.cnt > 0){
					
					if(modalFlag == "upd") {
						salesDetail.insertQualification();
					}
					compare_before = $("#formModalData").serialize();
					compareFlag = false;
					
					alert("저장하였습니다.");
					if(modalFlag == "upd") {
						window.location.href = "/partnerManagement/viewPartnerIndividualInfoGate.do<c:if test="${req_params ne ''}">?${req_params}</c:if>";
					}
					else {
						window.location.href = "/partnerManagement/viewPartnerIndividualInfoGate.do<c:if test="${req_params ne ''}">?${req_params}</c:if>";
					}
					
					if(modalFlag == "upd") {
						clientSerchList.get(1, 20);
						clientList.goDetail($("#hiddenPartnerIndividualId").val(), $("#hiddenModalCompanyId").val());
					}else {
						searchDetailClick.goDetail(data.filePK, $("#hiddenModalCompanyId").val(), $("#textModalPartnerName").val());
					}

					if(modalFlag=="upd"){
						$("#divModalPhotoUploadArea .fileModalUploadPhoto").remove();
						$('#divFileUploadList').html('<span>파일을 선택해 주세요.</span>');
						$("#divModalFile > span").remove();
					}else if(modalFlag=="ins"){
						$('#myModal1').modal("hide");
					}
					
				}else{
					alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
				}
			},
			error : function(xhr, status, code){
				alert("[에러]\ncode:"+xhr.status+"\n"+"message:"+xhr.responseText+"\n"+"error:"+error);
			},
			complete : function(){
				$jq.ajaxLoadingHide();
			}
		});
		
		$jq('#formModalData').submit();
		 
	});

});*/

function getThumbnailPrivew(html, el_id) {
    if (html.files && html.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            //$target.css('display', '');
            document.getElementById(el_id).style.display = "";
            /* console.log($target);
            console.log(html);
            console.log(html.files);
            console.log(e.target.result);
            console.log(html.files[0]);
            console.log(); */
            //$target.css('background-image', 'url(\"' + e.target.result + '\")'); // 배경으로 지정시
            
            //$('#divModalUploadPhoto span').hide();
            //$target.html('<img class="photo" id="imgModalInsertPhoto" border="0" alt="" style="background:url('+ e.target.result + ') no-repeat center center; background-size:cover;" />');
            
            //$jq('#divModalUploadPhoto').html();
            //$target.html('<img src="'+ e.target.result + '" alt="명함 사진" />');
            document.getElementById(el_id).innerHTML = '<img src="'+ e.target.result + '" alt="명함 사진" />'; 
        }
        reader.readAsDataURL(html.files[0]);
    }
}

function fncSelectTab(_no){
	// 탭 이동
	$('#tab_1').removeClass('active');
	$('#tab_2').removeClass('active');
	$('#tab_'+_no).addClass('active');
	
	// 탭에 해당하는 컨테이너 보여주기
	$('.cont1').addClass('off');
	$('.cont2').addClass('off');
	$('.cont'+_no).removeClass('off');
}

$(document).ready(function() {
	
	partnerSearch.validate();
	
	// 파트너사 자동검색
	partnerSearch.singlePartner($("#formModalData #textCommonSearchCompany"), $('#formModalData #liModalCompanyName'), $('#formModalData #hiddenModalCompanyId'), $('#formModalData #textCommonSearchCompanyId'));
	
	// 수정시 파트너사가 있으면 파트너사 세팅
	if($('#mode').val() == 'upd'){
		partnerSearch.setPartner();
	}
	
});