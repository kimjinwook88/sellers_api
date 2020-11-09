<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 모듈설정 modal -->
		     	<div class="modal inmodal fade" id="mainMenuSetup" tabindex="-1" role="dialog"  aria-hidden="true">
			        <div class="modal-dialog modal-lg">
			            <div class="modal-content">
			                <div class="modal-header">
			                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			                    <h4 class="modal-title">메뉴설정</h4>
			                </div>
			                <div class="modal-body">
			                    <div class="row">
			                        <div class="col-lg-12">
			                            <div class="ibox float-e-margins">
			                                <div class="ibox-content border_n">
		                                        <div class="form-group">
		                                            <div class="">
		                                                <table id="" class="module-set">
		                                                    <colgroup>
		                                                        <col width="15%"/>
		                                                        <col width="20%"/>
		                                                        <col width=""/>
		                                                    </colgroup>
		                                                    <thead>
		                                                        <tr>
		                                                            <th>번호</th>
		                                                            <th>선택</th>
		                                                            <th>메뉴명</th>
		                                                        </tr>
		                                                    </thead>
		                                                    
		                                                    <script type="text/javascript">
		                                                      $(document).ready(function(){
		                                                    		
		                                                    	  //Mian Module
				                                                    $("tbody#tbodyMainMenu").on("click","button",function(e){
				                                                    	var buttonIndex = $("tbody#tbodyMainMenu tr button").index($(this));
				                                                    	
				                                                    	var checkIdx = 0;
				                                                    	$("tbody#tbodyMainMenu input[name='checkMainMenu']").each(function(idx,val){
				                                                    		if($(this).is(":checked")){
				                                                    			checkIdx = idx;
				                                                    			return false;
				                                                    		}
				                                                    	});
				                                                    	
				                                                    	if(buttonIndex == 0){ //up
				                                                    		$("tbody#tbodyMainMenu tr").eq(checkIdx-1).before($("tbody#tbodyMainMenu tr").eq(checkIdx));
				                                                    	}else{ //down
				                                                    		if(checkIdx+1 != $("tbody#tbodyMainMenu tr:not(.lastTr)").length){
				                                                    			$("tbody#tbodyMainMenu tr").eq(checkIdx+1).after($("tbody#tbodyMainMenu tr").eq(checkIdx));
				                                                    		}else{
				                                                    			$("tbody#tbodyMainMenu tr").eq(0).before($("tbody#tbodyMainMenu tr").eq(checkIdx));
				                                                    		}
				                                                    	}
				                                                    	
				                                                    	orderManinModule();
				                                                    });
		                                                    		
		                                                    		//Main selectbox change
		                                                    		 $("tbody#tbodyMainMenu").on("change","select",function(e){
		                                                    			 if($(this).val() == "N"){
		                                                    			 	$(this).parents("tr").addClass("unuse");
		                                                    			 }else{
		                                                    				$(this).parents("tr").removeClass("unuse");
		                                                    			 }
		                                                    		 });
		                                                    		
		                                                    		//Main tr click
		                                                    		 $("tbody#tbodyMainMenu").on("click","tr:not(.lastTr)",function(e){
		                                                    			 $("input[name='checkMainMenu']").attr('checked', false);
		                                                    			 $(this).find("input[name='checkMainMenu']").prop('checked', true);
		                                                    		 });
		                                                    		
		                                                      });
		                                                      
		                                                      function orderManinModule(){
		                                                    	$("tbody#tbodyMainMenu tr").each(function(idx,val){
		                                                    		if(idx+1 != $("tbody#tbodyMainMenu tr").length){
		                                                    			$(this).find("td.first").html(idx+1);	
		                                                    		}
			                                                    });
		                                                      }
		                                                      
		                                                      function saveMainMenu(){
		                                                    	  $.ajax({
			                                          					url : "/main/insertMainMenu.do",
			                                          					async : false,
			                                          		 			datatype : 'json',
			                                          		 			method: 'POST',
			                                          		 			data : {
			                                          		 				datatype : 'json', 					
			                                          		 				member_id_num : '${userInfo.MEMBER_ID_NUM}',
			                                          		 				mainMenuList : function(){
			                                          		 					var list = new Array();
			                                          		 					$("tbody#tbodyMainMenu tr:not(.lastTr)").each(function(idx,val){
			                                          		 						var map = new Object();
			                                          		 						map.menu_id =  $(this).find("input[name='hiddenMainMenuId']").val();
			                                          		 						map.menu_seq = parseInt(idx+1); 
			                                          		 						list.push(map);
			                                          		 					});
			                                          		 					return JSON.stringify(list);
			                                          		 				} 	
			                                          		 			},
			                                          		 			beforeSend : function(xhr){
			                                          		 				if(!confirm("저장하시겠습니까?")){
			                                          		 					return false;
			                                          		 				}
			                                          						xhr.setRequestHeader("AJAX", true);
			                                          						$.ajaxLoading();
			                                          					},
			                                          					success : function(data){
			                                          						alert("저장하였습니다.");
			                                          						document.location.href = "/main/index.do";
			                                          					},
			                                          					complete : function(){
			                                          						$.ajaxLoadingHide();
			                                          					}
			                                          				});
		                                                      }
		                                                      
		                                                      function openMainMenuSetup(){
		                                                    	  var params = $.param({
		                                      						datatype : 'html',
		                                      						jsp : '/main/mainMenuSetupTable',
		                                      						mainCategory : "2" //메뉴
		                                      					  });
		                                                    	  $.ajax({
			                                          					url : "/main/mainSetupTable.do",
			                                          					async : false,
			                                          		 			datatype : 'html',
			                                          		 			data : params,
			                                          		 			method: 'POST',
			                                          		 			beforeSend : function(xhr){
			                                          						$.ajaxLoading();
			                                          					},
			                                          					success : function(data){
			                                          						$("tbody#tbodyMainMenu tr").not("tr.lastTr").remove();
			                                          						$("tbody#tbodyMainMenu").prepend(data);
			                                          					},
			                                          					complete : function(){
			                                          						$.ajaxLoadingHide();
			                                          					}
			                                          				});
		                                                      }
		                                                    </script>
		                                                    
		                                                    <tbody id="tbodyMainMenu">
		                                                    
		                                                    
																<tr class="lastTr">
		                                                            <td class="first" colspan="4">
		                                                                <button class="btn btn-white"><i class="fa fa-chevron-up"></i></button>
		                                                                <button class="btn btn-white mg-l10"><i class="fa fa-chevron-down"></i></button>
		                                                                <p class="pd-t10">※ 메뉴의의 노출 순서를 변경하시려면 해당 메뉴 선택 후 위, 아래 이동버튼을 클릭해주세요.</p>
		                                                            </td>
		                                                        </tr>
		                                                    </tbody>
		                                                </table>
		                                                <div class="pd10 ta-c">
		                                                    <button type="button" class="btn btn-gray" onclick="saveMainMenu();">설정 저장</button>
		                                                </div>
		                                            </div>
		                                        </div>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
			        </div>
			    </div>