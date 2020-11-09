<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-sm-6">
        <div class="time-update">
            <!-- <span class="text-muted small pull-right">최근 업데이트: <i class="fa fa-clock-o"></i> <span id="LATELY_UPDATE_DATE"></span></span> -->
        </div>
    </div>
</div>

<div class="wrapper wrapper-content  animated fadeInRight">
	<div class="row">
        	<div class="ibox">
                <div class="ibox-content border_n">
                    <div class="clear">
                        <div class="pos-rel">
                        	
                        	<div class="func-top-right fl_r pd-b10">
							    <button type="button" class="btn btn-w-m btn-gray mg-r5" onclick="list.submit();">저장하기</button>
						    </div>
                        
                        	<table id="tech-companies" class="module-set pd-t10">
						  		<colgroup>
							        <col width="" name="cols_TRACKING_CATEGORY_NAME" />
							        <col width="" name="cols_FULL_USE_YN" />
							        <col width="" name="cols_ALARM_USE_YN" />
							        <col width="" name="cols_MAIL_USE_YN" />
							        <col width="" name="cols_MOBILE_USE_YN" />
							        <col width="" name="cols_BEFORE_DUE_RULE" />
							        <col width="" name="cols_AFTER_DUE_RULE" />
							    </colgroup>
							    <thead>
								    <tr>
								        <!-- <th>No</th> -->
								        <th name="cols_TRACKING_CATEGORY_NAME">트래킹 알림 종류</th>
								        <th name="cols_FULL_USE_YN">전체알림 사용여부</th>
								        <th name="cols_ALARM_USE_YN">알람알림 사용여부</th>
								        <th name="cols_MAIL_USE_YN">메일알림 사용여부</th>
								        <th name="cols_MOBILE_USE_YN">모바일알림 사용여부</th>
								        <th name="cols_BEFORE_DUE_RULE">목표일 이전 알림 룰</th>
								        <th name="cols_AFTER_DUE_RULE">목표일 이후 알림 룰</th>
								    </tr>   
							    </thead>
							    <tbody id="row">
					 			</tbody>
							</table>
                        
                        </div>
                    </div>
                </div>
            </div>
    </div>
</div>

</div>
</div>

<jsp:include page="/WEB-INF/jsp/pc/tracking/userTrackingOptionSetup.jsp"/>

</body>

<script type="text/javascript">
$(document).ready(function(){
	list.get();
});

var list = {
		
		optionList : null,
		
		//fullUseYn 값 변경
		changeSelectFullUseYn : function(e){
			var slct = $(e).parent();
			var option = $(e).parents("tr").find('td[name="cols_USER_TRACKING_OPTION"]');
			if($(e).val() == 'Y'){
				slct.next().children("select").val('Y');
				slct.next().children("select").css("background-color", "#ffffff");
				slct.next().next().children("select").val('Y');
				slct.next().next().children("select").css("background-color", "#ffffff");
				slct.next().next().next().children("select").val('Y');
				slct.next().next().next().children("select").css("background-color", "#ffffff");
				
				option.children('input[name="hiddenTableFullUseYn"]').val('Y');
				option.children('input[name="hiddenTableAlarmUseYn"]').val('Y');
				option.children('input[name="hiddenTableMailUseYn"]').val('Y');
				option.children('input[name="hiddenTableMobileUseYn"]').val('Y');
			}else{
				slct.next().children("select").val('N');
				slct.next().children("select").css("background-color", "#eeeeee");
				slct.next().next().children("select").val('N');
				slct.next().next().children("select").css("background-color", "#eeeeee");
				slct.next().next().next().children("select").val('N');
				slct.next().next().next().children("select").css("background-color", "#eeeeee");
				
				option.children('input[name="hiddenTableFullUseYn"]').val('N');
				option.children('input[name="hiddenTableAlarmUseYn"]').val('N');
				option.children('input[name="hiddenTableMailUseYn"]').val('N');
				option.children('input[name="hiddenTableMobileUseYn"]').val('N');
			}
		},
		
		//세부알림 사용여부 설정
		changeSelectDetailUseYn : function(e) {
			var fullUseYn = $(e).parents("tr").find('td[name="cols_FULL_USE_YN"]').children().first()[0].value;
			var option = $(e).parents("tr").find('td[name="cols_USER_TRACKING_OPTION"]');
			if(fullUseYn == 'N'){
				$(e).val('N');
			}else{
				option.children('input[name="hidden'+ $(e).attr("name")+ '"]').val($(e).val());
			}
		},
		
		//사용자 트래킹 설정 조회
		get : function(){
			var params = {
				datatype : 'html',
				jsp : '/tracking/userTrackingOptionAjax'	
			}
			$.ajax({
				url : "/tracking/selectUserTrackingOption.do",
				async : true,
	 			datatype : 'html',
	 			method: 'POST',
	 			data : $.param(params),
	 			beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					$('tbody#row').html(data);
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		//사용자 트래킹 목표일 상세설정 조회
		goDetail : function(e, cat) {
			var slct = $(e).parent();
			var option = $(e).parents("tr").find('td[name="cols_USER_TRACKING_OPTION"]');
			setUpModal.trackingTr = e;
			
			$("#hiddenModalTrackingOptionCategory").val(cat);
			
			if(cat == 'bf'){
				$("#selectModalTrackingOptionCategory").val(option.children('input[name="hiddenTableFrqncBeforeUseYn"]').val());
				$("#textModalTrackingOptionDueDate").val(option.children('input[name="hiddenTableBeforeDueDate"]').val());
				$("#hiddenModalTrackingOptionFrqnc").val(option.children('input[name="hiddenTableFrqncBefore"]').val());
			}else{
				$("#selectModalTrackingOptionCategory").val(option.children('input[name="hiddenTableFrqncAfterUseYn"]').val());
				$("#textModalTrackingOptionDueDate").val(option.children('input[name="hiddenTableAfterDueDate"]').val());
				$("#hiddenModalTrackingOptionFrqnc").val(option.children('input[name="hiddenTableFrqncAfter"]').val());
			}
			
			setUpModal.restFrqnc();
			setUpModal.changeOption();
			setUpModal.setDocument();
		},
		
		//사용자 트래킹 저장
		submit : function() {
			//설정값 데이터 가공
			list.setData();
			
			$.ajax({
				url : "/tracking/upsertUserTrackingOption.do",
				async : true,
	 			datatype : 'json',
	 			method: 'POST',
	 			data : {
	 				datatype : 'json',
	 				trackingOptionData : JSON.stringify(list.optionList)
	 			},
	 			beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
					$.ajaxLoadingShow();
				},
				success : function(data){
					if(data.cnt == 1){
						alert("저장하였습니다.");
						list.get();
					}else {
						alert("에러가 발생하였습니다.\r관리자에게 문의하세요.");
						list.get();
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		//설정값 데이터 가공
		setData : function() {
			list.optionList = new Array();
			$("tbody#row td[name='cols_USER_TRACKING_OPTION']").each(function(idx, val){
				var opMap = new Object();
				opMap.COM_USER_TRACKING_ID = $("tbody#row input[name='hiddenTableUserTrackingId']").eq(idx).val();
				opMap.MEMBER_ID_NUM = $("tbody#row input[name='hiddenTableUserMemIdNumId']").eq(idx).val();
				opMap.TRACKING_CATEGORY = $("tbody#row input[name='hiddenTableTrackingCategory']").eq(idx).val();
				opMap.TRACKING_CATEGORY_NAME = $("tbody#row input[name='hiddenTableTrackingCategoryName']").eq(idx).val();
				opMap.FULL_USE_YN = $("tbody#row input[name='hiddenTableFullUseYn']").eq(idx).val();
				opMap.ALARM_USE_YN = $("tbody#row input[name='hiddenTableAlarmUseYn']").eq(idx).val();
				opMap.MAIL_USE_YN = $("tbody#row input[name='hiddenTableMailUseYn']").eq(idx).val();
				opMap.MOBILE_USE_YN = $("tbody#row input[name='hiddenTableMobileUseYn']").eq(idx).val();
				opMap.BEFORE_DUE_DATE = $("tbody#row input[name='hiddenTableBeforeDueDate']").eq(idx).val();
				opMap.AFTER_DUE_DATE = $("tbody#row input[name='hiddenTableAfterDueDate']").eq(idx).val();
				opMap.FRQNC_BEFROE_USE_YN = $("tbody#row input[name='hiddenTableFrqncBeforeUseYn']").eq(idx).val();
				opMap.FRQNC_BEFROE = $("tbody#row input[name='hiddenTableFrqncBefore']").eq(idx).val();
				opMap.FRQNC_AFTER_USE_YN = $("tbody#row input[name='hiddenTableFrqncAfterUseYn']").eq(idx).val();
				opMap.FRQNC_AFTER = $("tbody#row input[name='hiddenTableFrqncAfter']").eq(idx).val();
				list.optionList.push(opMap);
			});
		}
}
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>
