<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<style>
ul.adminMember > li:hover{
	background-color: #2dbae7;
}
</style>
<div class="row wrapper border-bottom white-bg page-heading">
    <!-- <div class="col-sm-6">
        <h2>권한관리</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>관리자페이지</a>
            </li>
            <li class="active">
                <strong>권한관리</strong>
            </li>
        </ol>
    </div> -->
</div>
	
<div class="wrapper wrapper-content  animated fadeInRight">
	<div class="row">
	    <div class="ibox">
	        <div class="ibox-content border_n pd-no">
	            <div class="clear">	

					<div class="mg-b20">
				         <ul class="nav nav-tabs">
				             <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="moveAuthPage('/admin/authManage.do');">권한 추가 및 삭제</a></li>
				             <li class="active"><a data-toggle="tab" href="javascript:void(0);" onClick="moveAuthPage('/admin/authMemberManage.do');">직원 권한 관리</a></li>
				             <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="moveAuthPage('/admin/authRoleMenu.do');">권한별 메뉴 관리</a></li>
				         </ul>
				     </div>
     
				     <div class="authority">
				                                
						<div class="col-sm-6">
						    <h3>
						        권한 설정할 직원 검색<br/>
						        <span>(직원명을 입력하면 자동으로 해당 직원이 검색됩니다. 권한설정은 한 명씩 부여가 가능합니다.)</span>
						    </h3>
						    <div class="mg-l10 mg-r10 authority_search">
				                <div class="input-group" style="width:100%;"><input type="text" class="input form-control" id="textSearchMember" placeholder="직원명을 입력하세요" maxlength="10"></div>
				            </div>
				            <div class="mg-l10 mg-r10 member_list">
					            <ul class="adminMember" style="cursor: pointer;">
								</ul>
							</div>
				     
						<!-- <div class="col-sm-6" style="border: 1px solid black;">
								<input type="text" placeholder="직원검색" maxlength="10" style="margin-bottom: 10px;"/>
								<ul class="alarm-list-pop adminMember" style="cursor: pointer;"></ul>
							</div> -->
					
						</div>
		
						<div class="col-sm-6">
				
					        <h3>
					           	 권한 설정<br/>
					            <span>(왼쪽의 선택된 직원에게 부여할 권한을 체크해주세요.)</span>
					        </h3>
					        <div class="mg-l10 mg-r10 authority_set">
					        	<ul>
					                <li>                                                
					                    <input type="checkbox" name="checkAll" value="all" />
					                    <label>전체선택</label>
					                </li>
					                
					                <c:choose>
										<c:when test="${fn:length(authListAll) > 0}">
											<c:forEach items="${authListAll}" var="authListAll">
												<li>
													<input type="checkbox" name="authCheck" value="${authListAll.AUTHORITY_CODE}" />
													<label>${authListAll.AUTHORITY_NAME}</label>
												</li>
											</c:forEach>
										</c:when>
									</c:choose>
									
								</ul>
							</div>
							
							<%-- <div class="col-sm-6" style="border: 1px solid black;">
								<ul class="alarm-list-pop adminAuth">
									<li><input type="checkbox" value="all" name="checkAll">전체선택</li>
									<c:choose>
										<c:when test="${fn:length(authListAll) > 0}">
											<c:forEach items="${authListAll}" var="authListAll">
												<li><input type="checkbox" name="authCheck" value="${authListAll.AUTHORITY_CODE}">${authListAll.AUTHORITY_NAME}</li>
											</c:forEach>
										</c:when>
									</c:choose>
								</ul>
							</div> --%>
							
						</div>
	
					</div>
		
					<div class="cboth func-top-right fl_r pd-b10">
				        <button type="button" class="btn btn-outline btn-gray-outline" onClick="authMemberManage.insert();">저장하기</button>
				    </div>

    			<!-- <button type="button" onClick="authMemberManage.insert();">저장하기</button> -->
				</div>
			</div>
		</div>
	</div>
</div>
</body>

<script type="text/javascript">
$(document).ready(function(){
	authMemberManage.init();
});

var member_id_num = "";
var authMemberManage = {
			//초기화
			init : function(){
				authMemberManage.selectMember();
				$("#textSearchMember").on({
					'keyup.searchMember' : function(e){
						authMemberManage.selectMember();
					}
				});
				
				$("ul.adminMember").on({
					'click.auth' : function(e){
						$('ul.adminMember li').css('background-color','');
						authMemberManage.selectAuth($(this).attr('member-id-num'));
						member_id_num = $(this).attr('member-id-num');
						$(this).css('background-color','#2dbae7');
					}
				},'li');
				
				$('input:checkbox[value="all"]').on({
					'click' : function(e){
						if($(this).prop('checked')){
							$('input:checkbox[name="authCheck"]').prop('checked',true);
						}else{
							$('input:checkbox[name="authCheck"]').prop('checked',false);
						}
					}
				});
			},
			
			insert : function(){
				$.ajax({
					url : "/admin/insertMemberAuth.do",
					async : true,
		 			datatype : 'json',
		 			method: 'POST',
		 			data : {
		 				member_id_num : member_id_num,
		 				auth_list : function(){
		 					var arr = [];
		 					$('input:checkbox[name="authCheck"]:checked').each(function(){
		 						arr.push($(this).attr('value'));
							});
		 					return arr.toString();
		 				}
		 			},
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						if(isEmpty(member_id_num)){
							return false;
						}
						$.ajaxLoadingShow();
					},
					success : function(data){
						var cnt = data.cnt;
						if(cnt > 0){
							alert("저장하였습니다.");
						}
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			},
			
			selectMember : function(){
				$.ajax({
					url : "/common/searchMemberInfo.do",
					async : true,
		 			datatype : 'json',
		 			method: 'POST',
		 			data : {
		 				memberName : $('#textSearchMember').val()	
		 			},
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoadingShow();
					},
					success : function(data){
						var list = data.list
						$('ul.adminMember').html("");
						for(var i=0; i<list.length; i++){
							$('ul.adminMember').append('<li member-id-num="'+list[i].MEMBER_ID_NUM+'">'+list[i].HAN_NAME+'  '+list[i].POSITION_STATUS+'  '+list[i].TEAM_NAME+'</li>');
						}
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			},
			
			selectAuth : function(member_id_num){
				$.ajax({
					url : "/common/selectAuthority.do",
					async : true,
		 			datatype : 'json',
		 			method: 'POST',
		 			data : {
		 				MEMBER_ID_NUM : member_id_num
		 			},
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoadingShow();
					},
					success : function(data){
						var list = data.list;
						$('input:checkbox[name="checkAll"]').prop('checked',false);
						$('input:checkbox[name="authCheck"]').prop('checked',false);
						for(var i=0; i<list.length; i++){
							$('input:checkbox[name="authCheck"][value="'+list[i].AUTHORITY_CODE+'"]').prop('checked',true);
						}
					},
					complete : function(){
						$.ajaxLoadingHide();
					}
				});
			}
}

function moveAuthPage(url){
	location.href = url;
}
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>
