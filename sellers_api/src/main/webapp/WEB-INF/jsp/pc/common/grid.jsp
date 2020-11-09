<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script type="text/javascript">
    $(document).ready(function(){
    	
        //책임자 자동 완성
        $("tbody#tbodyGrid").on("focus", "input[name='textGridMember']", function(e){
            if($(this).attr("auto-bind") == "0"){
                commonSearch.singleMember2($(this),null);
                $(this).attr("auto-bind","1");
            }
        });
        
        // 계획날짜입력
        $("tbody#tbodyGrid").on("change", "input[name='textModalGridPlanDate']", function(e){
            var plan_idx = $("tbody#tbodyGrid input[name='textModalGridPlanDate']").index(this);
            var plan_date = $("tbody#tbodyGrid input[name='textModalGridPlanDate']").eq(plan_idx).val();
            var actual_date = $("tbody#tbodyGrid input[name='textModalGridActualDate']").eq(plan_idx).val();
            var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
            $("td[name='tdGridStatus']").eq(plan_idx).css("background-color",fnStatusColor2(plan_date,actual_date,nowDate));
        });
        
        // 완료날짜 입력
        $("tbody#tbodyGrid").on("change", "input[name='textModalGridActualDate']", function(e){
            var actual_idx = $("tbody#tbodyGrid input[name='textModalGridActualDate']").index(this);
            var plan_date = $("tbody#tbodyGrid input[name='textModalGridPlanDate']").eq(actual_idx).val();
            var actual_date = $("tbody#tbodyGrid input[name='textModalGridActualDate']").eq(actual_idx).val();
            var nowDate = commonDate.year+commonDate.month+commonDate.day.trim();
            $("td[name='tdGridStatus']").eq(actual_idx).css("background-color",fnStatusColor2(plan_date,actual_date, nowDate));
        });
        
        $("tbody#tbodyGrid").on("keydown", "input[name='textGridMember'], input[name='textModalGridActualDate'], input[name='textModalGridPlanDate']", function(e){
            if(e.keyCode == 13){//키가 13이면 실행 (엔터는 13)
                return false;
            }
        });
        
    });

    var grid = {

        gridValid : true,
        // gridCategory : "${param.gridCategory}",
        gridList : null,
        gridHtmlPath : "${param.gridHtmlPath}",
        listObj : "${param.listObj}",
        gridColObj : {},
        
        buildCol : function(widthVal, titleVal){
    		
    		var obj = {width : '', title : ''};
    		
    		if(typeof(widthVal) == 'Number'){
    			obj.width = widthVal + 'px';
    		}else{
    			obj.width = widthVal;
    		}
    		
    		obj.title = titleVal;
    		
    		return obj;
    	},
    	
    	setGrid : function(cols, gridColObj){
        	
        	var colgroups = '';
        	var ths = '';
        	        	
        	$.each(cols, function(index, col){
        		colgroups += ('<col width='+col.width+'>');
        		ths += ('<th>'+ col.title+'</th>');
        	});
        	
        	$('#gridTable colgroup').html(colgroups);
        	$('#gridTable thead tr').html(ths);	
        	
        	// 컬럼 이름 설정
        	grid.gridColObj = gridColObj;
    	},     

    	/**
    	* contents : 내용
    	* plan : 계획
    	* planDate : 목표날짜
    	* actualDate : 실제완료날짜
    	* gridId : 각 row의 id
    	* memberId : 책임자 id
    	* memberName : 책임자 이름
    	* memberPosition : 책임자 직급
    	**/    	
        gridAdd : function(map){
        	
        	colobj = grid.gridColObj;
        	
            $.get(grid.gridHtmlPath, function(data){
                $('tbody#tbodyGrid').append(data);
            }).done(function(){
                if(map){
                    var idx = $('tbody#tbodyGrid tr').length-1;
                    $("textarea[name='textareaGridContents']").eq(idx).text(eval('map.'+colobj.contents));
                    $("textarea[name='textareaGridPlan']").eq(idx).text(eval('map.'+colobj.plan));
                    $("input[name='textModalGridPlanDate']").eq(idx).val(eval('map.'+colobj.planDate));
                    $("input[name='textModalGridActualDate']").eq(idx).val(eval('map.'+colobj.actualDate));
                    $("input[name='hiddenGridId']").eq(idx).val(eval('map.'+colobj.gridId));
                    $("input[name='textModalGridPlanDate']").eq(idx).trigger("change");
                    $("input[name='textModalGridActualDate']").eq(idx).trigger("change");	
                    
                    var memberId = eval('map.'+colobj.memberId);
                    var memberName = eval('map.'+colobj.memberName);
                    $("input[name='textGridMember']").eq(idx).hide();
                    $("input[name='hiddenGridMemberId']").eq(idx).val(memberId);
                    //$("input[name='hiddenGridMemberName']").eq(idx).val(map.SOLVE_OWNER + (map.SOLVE_OWNER_POSITION != null ? ' '+ map.SOLVE_OWNER_POSITION : ''));
                    $("input[name='hiddenGridMemberName']").eq(idx).val(memberName);
                    $("li[name='liGridMemberSeach']").eq(idx).before(
                            '<li class="value">'+
                            '<span class="txt" id="'+ memberId +'">'+ memberName +' ['+ eval('map.'+colobj.memberPosition) +']</span>'+
                            '<a href="#" class="remove" onclick="commonSearch.removeSingleMember2(this,null);">'+
                            '<i class="fa fa-times-circle"></i></a>'+
                            '</li>'
                    );
                }
                compare_before = $("#formModalData").serialize();
            });
        },

        gridDel : function(obj){
            var gridId = $(obj).next("input[name='hiddenGridId']").val();
            var data = {
				hiddenModalPK : $("#hiddenModalPK").val(),
				datatype : 'json'
			};
            eval('data.'+colobj.gridId+'=gridId');
            if(gridId){
                $.ajax({
                    url : "${param.gridDelUrl}",
                    datatype : 'json',
                    async : false,
                    data : data,
                    beforeSend : function(xhr){
                        xhr.setRequestHeader("AJAX", true);
                        if(!confirm("삭제하시겠습니까?")){
                            return false;	
                        }
                        $.ajaxLoadingShow();
                    },
                    success : function(data){
                        if(data.cnt > 0){
                            alert("삭제되었습니다.");
                            $(obj).parent().parent().remove();
                            eval(grid.listObj+'.get()');
                            compare_before = $("#formModalData").serialize();
                        }else{
                            alert("삭제를 실패했습니다.\n관리자에게 문의하세요.");
                        }
                    },
                    complete: function(){
                        $.ajaxLoadingHide();
                    },
                    error: function(xhr, status, err) {
                        $.error(xhr, status, err);
                    }
                });
            }else{
                $(obj).parent().parent().remove();
                compare_before = $("#formModalData").serialize();
            } 
        },

        gridReset : function(){
            $('tbody#tbodyGrid tr').remove();
			$("label#gridTable-error").remove();
        },

        gridSubmitList : function(){

        	colobj = grid.gridColObj;

            grid.gridValid = true;
            grid.gridList = new Array();
            $("label#gridTable-error").remove();
            
            $('tbody#tbodyGrid tr').each(function(idx,val){
                var gridMap = new Object();
                //validation
                if(($("textarea[name='textareaGridContents']").eq(idx).val()).trim()){ //내용을 작성한것만 담는다.
                	var gridId = $("input[name='hiddenGridId']").eq(idx).val();
                	var contents = $("textarea[name='textareaGridContents']").eq(idx).val();
                	var plan = $("textarea[name='textareaGridPlan']").eq(idx).val();
                	var memberId = $("input[name='hiddenGridMemberId']").eq(idx).val();
                	var memberName = $("input[name='hiddenGridMemberName']").eq(idx).val();
                	var planDate = $("input[name='textModalGridPlanDate']").eq(idx).val();
                	var actualDate = $("input[name='textModalGridActualDate']").eq(idx).val();
                	 
                    eval('gridMap.'+colobj.contents+'=contents');
                	eval('gridMap.'+colobj.plan+'=plan');
                    eval('gridMap.'+colobj.memberId+'=memberId');
                    eval('gridMap.'+colobj.memberName+'=memberName');
                    eval('gridMap.'+colobj.planDate+'=planDate');
                    
                    if(isEmpty(memberId)){
                        $("#gridTable").after('<label id="gridTable-error" class="error-custom" for="gridTable">책임자를 입력해 주세요.</label>'	);
                        grid.gridValid = false;
                        return false; 
                    }
                    if(isEmpty(planDate)){
                        $("#gridTable").after('<label id="gridTable-error" class="error-custom" for="gridTable">해결목표일을 입력해 주세요.</label>'	);
                        grid.gridValid = false;
                        return false; 
                    }
                    eval('gridMap.'+colobj.actualDate+'=actualDate');
                	eval('gridMap.'+colobj.gridId+'=gridId'); 
                    
                    grid.gridList.push(gridMap);
                }
            });
            
            return grid.gridList;
        },

        gridGetList : function(){
        	var params = $.param({
				datatype : 'json',
				hiddenModalPK : $("#hiddenModalPK").val()
			});
            $.ajax({
                url : "${param.gridSelectUrl}",
                async : false,
                data : params,
                beforeSend : function(xhr){
                },
                success : function(data){
                    grid.gridReset();
                    var list = data.rows;
                    if(list.length > 0){
                        for(var i=0; i<list.length; i++){
                            var map = list[i];
                            grid.gridAdd(map);
                        }
                    }else{
                        grid.gridAdd();
                    }
                },
                complete: function(data){
                },
                error: function(xhr, status, err) {
                }
            });
        }
    }
</script>					

<table id="gridTable" class="table table-bordered table-inner" style="margin-bottom: 5px;">
	<colgroup>
	</colgroup>
	<thead>
        <tr>
        </tr>
    </thead>
	<tbody id="tbodyGrid">
    </tbody>
</table>

<p class="text-center pd-t10">
    <a href="javascript:void(0);" class="btn-row-add" name="buttonSaleAddRow" onclick="grid.gridAdd();">+ ${param.gridAddBtnName} 추가</a>
</p>
