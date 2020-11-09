<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/pc/common/top.jsp"%>
<style>
ul.adminAuth > li:hover{
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
				             <li class=""><a data-toggle="tab" href="javascript:void(0);" onClick="moveAuthPage('/admin/authMemberManage.do');">직원 권한 관리</a></li>
				             <li class="active"><a data-toggle="tab" href="javascript:void(0);" onClick="moveAuthPage('/admin/authRoleMenu.do');">권한별 메뉴 관리</a></li>
				         </ul>
				     </div>
     
				     <div class="authority">
				                                
			     		<div class="col-sm-6">
					
					         <h3>권한 <span>(아래의 권한을 먼저 선택한 후 적용할 메뉴를 체크해주세요.)</span></h3>
					
					         <div class="member_list">
					         	<ul class="alarm-list-pop adminAuth" style="cursor: pointer;">
					         		<c:choose>
										<c:when test="${fn:length(authListAll) > 0}">
											<c:forEach items="${authListAll}" var="authListAll">
												<li authority_code="${authListAll.AUTHORITY_CODE}">${authListAll.AUTHORITY_NAME}</li>
											</c:forEach>
										</c:when>
									</c:choose>
								</ul>
							</div>
						</div>
     
						<%-- <div class="col-sm-6" style="border: 1px solid black;">
							<!-- <input type="text" placeholder="직원검색" maxlength="10" style="margin-bottom: 10px;" id="textSearchMember"/> -->
							<ul class="alarm-list-pop adminAuth" style="cursor: pointer;">
								<c:choose>
									<c:when test="${fn:length(authListAll) > 0}">
										<c:forEach items="${authListAll}" var="authListAll">
											<li authority_code="${authListAll.AUTHORITY_CODE}">${authListAll.AUTHORITY_NAME}</li>
										</c:forEach>
									</c:when>
								</c:choose>
							</ul>
						</div> --%>
	
						<div class="col-sm-6">
						
						    <h3>권한별로 적용할 메뉴 리스트</h3>
						
						    <div class="mg-l10 mg-r10 authority_set">                                        
					          <ul class="adminMenu">
					          	<li><input type="checkbox" value="all" name="checkAll">전체선택</li>
					          	<c:choose>
									<c:when test="${fn:length(menuList) > 0}">
										<c:forEach items="${menuList}" var="menuList">
											<c:if test="${menuList.MENU_LEVEL == 2 or menuList.CHILDREN_COUNT == 0}">
											<li><input type="checkbox" name="menuCheck" value="${menuList.MENU_ID}">${menuList.MENU_TITLE}</li>
											</c:if>
										</c:forEach>
									</c:when>
								</c:choose>
							  </ul>
							</div>
						</div>
	
						<%-- <div class="col-sm-6" style="border: 1px solid black;">
							<ul class="alarm-list-pop adminMenu">
								<li><input type="checkbox" value="all" name="checkAll">전체선택</li>
								<c:choose>
									<c:when test="${fn:length(menuList) > 0}">
										<c:forEach items="${menuList}" var="menuList">
											<c:if test="${menuList.MENU_LEVEL == 2}">
											<li><input type="checkbox" name="menuCheck" value="${menuList.MENU_ID}">${menuList.MENU_TITLE}</li>
											</c:if>
										</c:forEach>
									</c:when>
								</c:choose>
							</ul>
						</div> --%>

						<div class="cboth func-top-right fl_r pd-b10">
							<button type="button" class="btn btn-outline btn-gray-outline" onClick="authRoleMenu.update();">저장하기</button>
					    </div>
	
    					<!-- <button type="button" onClick="authRoleMenu.update();">저장하기</button> -->
    				</div>
    			</div>
    		</div>
    	</div>
	</div>
</div>
</body>

<script type="text/javascript">
$(document).ready(function(){
	authRoleMenu.init();
});

var auth_code = "";
var authRoleMenu = {
			//초기화
			init : function(){
				//authRoleMenu.selectAllAuthList();
				/* $("#textSearchMember").on({
					'keyup.searchMember' : function(e){
						authRoleMenu.selectMember();
					}
				}); */
				
				$("ul.adminAuth").on({
					'click.auth' : function(e){
						$('ul.adminAuth li').css('background-color','');
						authRoleMenu.selectAuthRoleMenu($(this).attr('authority_code'));
						auth_code = $(this).attr('authority_code');
						$(this).css('background-color','#2dbae7');
					}
				},'li');
				
				$('input:checkbox[value="all"]').on({
					'click' : function(e){
						if($(this).prop('checked')){
							$('input:checkbox[name="menuCheck"]').prop('checked',true);
						}else{
							$('input:checkbox[name="menuCheck"]').prop('checked',false);
						}
					}
				});
			},
			
			update : function(){
				$.ajax({
					url : "/admin/updateRoleMenu.do",
					async : true,
		 			datatype : 'json',
		 			method: 'POST',
		 			data : {
		 				auth_code : auth_code,
		 				menu_list : function(){
		 					var arr = [];
		 					$('input:checkbox[name="menuCheck"]:checked').each(function(){
		 						arr.push($(this).attr('value'));
							});
		 					return arr.toString();
		 				}
		 			},
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						if(isEmpty(auth_code)){
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
			
			selectAuthRoleMenu : function(auth_code){
				$.ajax({
					url : "/admin/selectAuthRoleMenu.do",
					async : true,
		 			datatype : 'json',
		 			method: 'POST',
		 			data : {
		 				auth_code : auth_code
		 			},
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						$.ajaxLoadingShow();
					},
					success : function(data){
						var list = data.list;
						$('input:checkbox[name="checkAll"]').prop('checked',false);
						$('input:checkbox[name="menuCheck"]').prop('checked',false);
						for(var i=0; i<list.length; i++){
							$('input:checkbox[name="menuCheck"][value="'+list[i].MENU_ID+'"]').prop('checked',true);
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
