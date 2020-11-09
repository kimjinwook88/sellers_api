<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>

<style>
	#images > div, #boards > div {float:left;width:100px;height:100px;border:1px solid #000;margin:5px;}
	#images div img {width:100px;height:100px;}
	#boards {clear:both;}
	#boards > div {font-size:2em;line-height:100px;text-align:center;}
</style>

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-sm-4">
        <h2>대시보드</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>고객만족</a>
            </li>
            <li class="active">
                <strong>서비스 프로젝트</strong>
            </li>
        </ol>
    </div>
    <div class="col-sm-8">
        <div class="time-update">
            <span class="text-muted small pull-right">최근 업데이트: <i class="fa fa-clock-o"></i> <span id="LATELY_UPDATE_DATE"></span></span>
        </div>
        
  			<div class="search-common">
                <div class="input-default  fl_l" style="margin:0;">
                    <span class="input-group-btn">
                            <a href="javascript:void(0);" class="btn btn-search-option"><i class="fa fa-search"></i> 검색</a>
                    </span>
					
	                <div class="search-detail" style="display:none;">
	                    
	                    <div class="col-sm-12 m-b">
	                        <label class="control-label" for="date_modified">고객사</label>
	                        <div class="input-group" style="width:100%;" ><input type="text" placeholder="고객사를 입력해주세요" class="input form-control" id="textSearchCompany" onkeydown="if(event.keyCode == 13){projectMGMTList.reset();projectMGMTList.get();}"></div>
	                    </div>
	                    
	                    <div class="col-sm-12 ag_r">
	                        <label for="result-in-search" class="mg-r10"> <input type="checkbox" id="result-in-search" class="input v-m"> 결과내 검색</label>
	                        <button type="button" class="btn btn-w-m btn-primary btn-seller" onClick="projectMGMTList.reset();projectMGMTList.get(true);"><i class="fa fa-search"></i> 검색</button>
	                    </div>
	                </div>
	                    
                </div>
            </div>
  
    </div>
</div>


<div id="images">
	<div><img src="http://lorempixel.com/100/100/food" id="1"></div>
	<div><img src="http://lorempixel.com/100/100/city" id="1"></div>
	<div><img src="http://lorempixel.com/100/100/sports" id="1"></div>
	<div><img src="http://lorempixel.com/100/100/animals" id="1"></div>
</div>
<div id="boards">
	<div title="1">sports</div>
	<div title="1">food</div>
	<div title="1">animals</div>
	<div title="1">city</div>
</div>

<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script type="text/javascript">
	$(function(){
		$("#images div img").draggable({
			start: function(event,ui) {
				$(this).draggable( "option", "revert", true );
				$("#images div img").css("zIndex",10);
				$(this).css("zIndex",100);
			}
		});
		$("#boards div").droppable({
			drop: function(event,ui) {
				var droptitle = $(this).attr("title");
				var drophtml = $(this).html();
				var dragid = ui.draggable.attr("id");
				if( dragid == droptitle ) {
					ui.draggable.draggable( "option", "revert", false );
					var droppableOffset = $(this).offset();
					var x = droppableOffset.left + 1;
					var y = droppableOffset.top + 1;
					ui.draggable.offset({ top: y, left: x });
				}
			}
		});
	});
	$(document).ready(function(){
		$("#images div").sort(function(){
			return Math.random()*10 > 5 ? 1 : -1;
		}).each(function(){
			$(this).appendTo( $(this).parent() );    
		});
		$("#boards div").sort(function(){
			return Math.random()*10 > 5 ? 1 : -1;
		}).each(function(){
			$(this).appendTo( $(this).parent() );    
		});
	});
</script>
<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>
