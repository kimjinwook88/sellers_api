<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <!-- Align popup -->
<div class="action-pop align off">
    <div class="pop-header">
        <button type="button" class="close" onClick="$('div.action-pop.align').addClass('off');"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <strong class="pop-title">IBM H/W부문(삼성)</strong>
    </div>
    <div class="col-sm-12 cont">
        <div class="col-sm-12 m-b">                    
            <label class="control-label" for="date_modified">얼라인된 파트너사 <!-- <a href="#" class="btn-company-collaborate-add"> <i class="fa fa-plus va_m"></i> 추가하기</a> --></label>
            <div class="">
                <div class="partner-current" id="divModalPartnerList"><!-- 현재 등록된 고객사 -->
               </div>
           </div>                  
       </div>
       <div class="col-sm-9">
           <div class="company-search mg-b10"><!-- 파트너사 검색 -->
               <input type="text" placeholder="파트너사 검색" class="form-control fl_l mg-r5" id="textCommonSearchPartner" onkeydown="if(event.keyCode == 13){modalAlign.partnerInfo();}">
               <button type="button" class="btn btn-gray btn-file" onClick="modalAlign.partnerInfo();">검색</button>
           </div>
        </div>
        <div class="col-sm-12 ">
           <div class="partner-result mg-b10 "><!-- 검색 결과 노출시 "off" 삭제 -->
                <strong>[파트너사 검색 결과]</strong>
                <ul class="partner-list">
                </ul>
            </div>
        </div>
        <div class="col-sm-12 m-b ta-c">
            <button type="button" class="btn btn-w-m btn-primary btn-gray" onClick="modalAlign.submit();">저장하기</button>
        </div>
    </div>
</div>
                                        
                                        
<script type="text/javascript">
$(document).ready(function(){ 
		modalAlign.init();
});		

var modalAlign = {
		init : function(){
			
		},
		
		alignment_id : null,
		partnerDivId : null,
		
		addPartner : function(partnerid,companyName){
			$("#spanNodata").remove();
			 if($("#divModalPartnerList").find("span[name='"+partnerid+"']").length == 0){
				$("#divModalPartnerList").append(
						'<span name='+partnerid+'>'+companyName+'<a href="javascript:void(0);" onClick="modalAlign.deletePartner(this,'+null+','+partnerid+');"><i class="fa fa-times-circle va_m"></i></a></span>'
				);
			}
		},
		
		partnerInfo : function(){
			$.ajax({
				url : "/common/searchPartnerInfo.do",
				datatype : 'json',
				async : false,
				data : {
					companyName : $("#textCommonSearchPartner").val()
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if($("#textCommonSearchPartner").val().length < 2){
						alert("검색어를 2글자 이상 입력해 주세요.");
						return false;
					}
					$.ajaxLoadingShow();
				},
				success : function(data){
				 var partnerList = data.list;
				 $("ul.partner-list").html("");
				 $("div.company-result").removeClass("off");
					if(partnerList.length > 0){
						for(var i=0; i<partnerList.length; i++){
							$("ul.partner-list").append(
								'<li><span>'+partnerList[i].COMPANY_NAME+'</span>&nbsp;<a href="javascript:modalAlign.addPartner('+partnerList[i].PARTNER_ID+',\''+partnerList[i].COMPANY_NAME+'\');void(0);"><i class="fa fa-plus va_m"></i></a></li>'
							);
						} 
					}else{
						$("ul.partner-list").append("<li><span>데이터가 없습니다.</span></li>");
					}
				},
				complete: function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		deletePartner : function(obj, alignmentid, partnerid){
			if(!alignmentid){
				$(obj).parent("span").remove();
				return false;
			}else{
				$.ajax({
					url : "/partnerManagement/deleteCapacityParnter.do",
					datatype : 'json',
					async : false,
					data : {
						selectViewList:$("#selectViewList").val(),
						alignmentid : alignmentid,
						partnerid : partnerid,
						datatype : 'json'
					},
					beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						if(!confirm("삭제하시겠습니까?")){
							return false;	
						}
					},
					success : function(data){
						if(data.cnt > 0){
							alert("삭제되었습니다.");
							$(obj).parent("span").remove();
							jqGrid.reload();
						}else{
							alert("삭제를 실패했습니다.\n관리자에게 문의하세요.");
						}
					},
					complete: function(){
					
					}
				});
			}
		},
		
		reset : function() { 
		},
		
		submit : function(){
			var arrPartnerList=new Array();
			$("#divModalPartnerList span").each(function(index, value){
				arrPartnerList.push($(this).attr("name"));
			});
			$.ajax({
				url : "/partnerManagement/insertCapacityParnter.do",
				datatype : 'json',
				type : "POST",
				async : false,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					if(!confirm("저장하시겠습니까?")){
						return false;	
					}
					$.ajaxLoadingShow();
				},
				data : {
					selectViewList:$("#selectViewList").val(),
					alignment_id : modalAlign.alignment_id,
					arrPartnerList : arrPartnerList.toString(),
					datatype : 'json'
				},
				success : function(data){
					if(data.cnt > 0){
						//$("#buttonSaveCapacity").trigger("click"); 뭐야 왜?
						alert("저장하였습니다");
						setTimeout(function(){jqGrid.reload();},300); //ajax Loading
						$('div.action-pop.align').addClass('off');
					}else{
						alert("저장를 실패했습니다.\n관리자에게 문의하세요.");
					}
				},
				complete: function(){
					$.ajaxLoadingHide();
				}
			});
		}
		
}
</script>