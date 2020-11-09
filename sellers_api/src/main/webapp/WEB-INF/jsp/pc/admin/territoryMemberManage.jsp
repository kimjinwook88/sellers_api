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
        <h2>테리토리관리(직원)</h2>
        <ol class="breadcrumb">
            <li>
                <a href="/main/index.do">Home</a>
            </li>
            <li>
                <a>관리자페이지</a>
            </li>
            <li class="active">
                <strong>테리토리관리</strong>
            </li>
        </ol>
    </div> -->
</div>

<div class="wrapper wrapper-content  animated fadeInRight">
	<div class="row">
	    <div class="ibox">
	        <div class="ibox-content border_n pd-no">
	            <div class="clear">
	                
	                <div class="authority">
	                
                       <div class="col-sm-4">
                       
							<h3>권한 설정할 직원 검색</h3>
                       	
	                       	<div class="mg-l10 mg-r10 authority_search">
	                            <div class="input-group" style="width:100%;"><input type="text" placeholder="직원명을 입력하세요"  class="input form-control" maxlength="10" id="textSearchMember"/></div>
	                        </div>
	                        <div class="mg-l10 mg-r10 member_list">
		                        <ul class="adminMember" style="cursor: pointer;">
								</ul>
							</div>
							
						</div>
						
						<div class="col-sm-4">
							
							<h3>현재 테리토리</h3>
							<div class="mg-l10 mg-r10 territory">
								<table class="territory_list">
	                                <colgroup>
	                                    <col width="150px"/>
	                                    <col width=""/>
	                                    <col width="50px"/>
	                                </colgroup>
	                                <thead>
	                                    <tr>
	                                        <th>고객사ID</th>
	                                        <th>고객사명</th>
	                                        <th>삭제</th>
	                                    </tr>
	                                </thead>
	                                <tbody class="adminTerritoryMemberList">
	                                </tbody>
                                </table>
							</div>
							
						</div>
						
						<div class="col-sm-4">
						
							<h3>산업별 고객사</h3>
							<div class="mg-l10 mg-r10">
								<div class="input-group" style="width:100%;">
									<select class="form-control" name="selectIndustrySegment" id="selectIndustrySegment" onchange="territoryMemberManage.selectIndustrySegment();">
										<option>===선택===</option>
										<c:choose>
											<c:when test="${fn:length(industrySegmentAll) > 0}">
												<c:forEach items="${industrySegmentAll}" var="industrySegmentAll">
													<option value="${industrySegmentAll.SEGMENT_CODE}">${industrySegmentAll.SEGMENT_HAN_NAME}</option>
												</c:forEach>
											</c:when>
										</c:choose>
									</select>
								</div>
							</div>
							<div class="mg-l10 mg-r10 authority_set">
								<ul>
									<li>
										<div class="authority_set" id="divCheckboxSelectCompanyAll" style="display: none;"><input type='checkbox'  value='all'/>전체선택</div>
									</li>
								</ul>
								<ul class="alarm-list-pop adminSegmentCompanyList">
								</ul>
							</div>
						</div>
					</div>
					<div class="func-top-right fl_r pd-b10">
						<button type="button" class="btn btn-outline btn-gray-outline" id="buttonInsertCompany" onClick="territoryMemberManage.insert();" style="display: none;">저장하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%-- <div class="col-sm-12" style="border: 1px solid black;">
	<div class="col-sm-2" style="border: 1px solid black;">
		<input type="text" placeholder="직원검색" maxlength="10" style="margin-bottom: 10px;" id="textSearchMember"/>
		<ul class="alarm-list-pop adminMember" style="cursor: pointer;">
		</ul>
	</div>
	
	<div class="col-sm-5" style="border: 1px solid black;">
		<div><h2>현재 테리토리</h2></div>
		<div class="col-sm-12">
			<ul class="alarm-list-pop adminTerritoryMemberList">
			</ul>
		</div>
	</div>
	
	<div class="col-sm-5" style="border: 1px solid black;">
		<div><h2>산업별 고객사</h2></div>
		<div class="col-sm-12 alarm-list-pop adminTerritoryAllList">
			<select name="selectIndustrySegment" id="selectIndustrySegment" onchange="territoryMemberManage.selectIndustrySegment();">
			<option>===선택===</option>
			<c:choose>
				<c:when test="${fn:length(industrySegmentAll) > 0}">
					<c:forEach items="${industrySegmentAll}" var="industrySegmentAll">
						<option value="${industrySegmentAll.SEGMENT_CODE}">${industrySegmentAll.SEGMENT_HAN_NAME}</option>
					</c:forEach>
				</c:when>
			</c:choose>
			</select>
			<button type="button" id="buttonInsertCompany" onClick="territoryMemberManage.insert();" style="display: none;">저장하기</button>
		</div>
		<div class="col-sm-12">
			<div id="divCheckboxSelectCompanyAll" style="display: none;"><input type='checkbox'  value='all'/>전체선택</div>
			<ul class="alarm-list-pop adminSegmentCompanyList">
			</ul>
		</div>
	</div>
</div> --%>
</body>

<script type="text/javascript">
$(document).ready(function(){
	territoryMemberManage.init();
});

var member_id_num = "";
var territoryMemberManage = {
			//초기화
			init : function(){
				territoryMemberManage.searchMember();
				$("#textSearchMember").on({
					'keyup.searchMember' : function(e){
						territoryMemberManage.searchMember();
					}
				});
				
				$("ul.adminMember").on({
					'click.auth' : function(e){
						$('ul.adminMember li').css('background-color','');
						member_id_num = $(this).attr('member-id-num');
						territoryMemberManage.selectMember($(this).attr('member-id-num'));
						$(this).css('background-color','#2dbae7');
					}
				},'li');
				
				$('input:checkbox[value="all"]').on({
					'click' : function(e){
						if($(this).prop('checked')){
							$('input:checkbox[name="companyCheck"]').prop('checked',true);
						}else{
							$('input:checkbox[name="companyCheck"]').prop('checked',false);
						}
					}
				});
			},
			
			insert : function(){
				$.ajax({
					url : "/admin/insertMemberTerritory.do",
					async : false,
		 			datatype : 'json',
		 			method: 'POST',
		 			data : {
		 				member_id_num : member_id_num,
		 				creator_id : ${userInfo.MEMBER_ID_NUM},
		 				company_list : function(){
		 					var arr = [];
		 					$('input:checkbox[name="companyCheck"]:checked').each(function(){
		 						arr.push($(this).attr('value'));
							});
		 					return arr.toString();
		 				}
		 			},
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						if(isEmpty(member_id_num)){
							alert("직원을 선택하세요.");
							return false;
						}
					},
					success : function(data){
						var cnt = data.cnt;
						if(cnt > 0){
							alert("저장하였습니다.");
						}
						territoryMemberManage.selectMember(member_id_num);
					},
					complete : function(){
						
					}
				});
			},
			
			deleteTerritory : function(st_align_id) {
				$.ajax({
					url : "/admin/deleteMemberTerritory.do",
					async : false,
		 			datatype : 'json',
		 			method: 'POST',
		 			data : {
		 				st_align_id : st_align_id,
		 			},
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
						if (!confirm("테리토리를 삭제 하시겠습니까?")){
							return false;
						}
					},
					success : function(data){
						var cnt = data.cnt;
						if(cnt > 0){
							//alert("삭제하였습니다.");
							territoryMemberManage.selectMember(member_id_num);
						}
					},
					complete : function(){
						
					}
				});
			},
			
			searchMember : function(){
				$.ajax({
					url : "/common/searchMemberInfo.do",
					async : false,
		 			datatype : 'json',
		 			method: 'POST',
		 			data : {
		 				memberName : $('#textSearchMember').val()	
		 			},
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
					success : function(data){
						var list = data.list
						$('ul.adminMember').html("");
						for(var i=0; i<list.length; i++){
							$('ul.adminMember').append('<li member-id-num="'+list[i].MEMBER_ID_NUM+'">'+list[i].HAN_NAME+'  '+list[i].POSITION_STATUS+'  '+list[i].TEAM_NAME+'</li>');
						}
					},
					complete : function(){
						
					}
				});
			},
			
			selectMember : function(member_id_num){
				$.ajax({
					url : "/admin/selectTerritoryMemberList.do",
					async : false,
		 			datatype : 'json',
		 			method: 'POST',
		 			data : {
		 				MEMBER_ID_NUM : member_id_num
		 			},
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
					success : function(data){
						var list = data.selectTerritoryMemberList;
						$("tbody.adminTerritoryMemberList").html("");
						if(0 < list.length){
							for(var i = 0; i<list.length; i++){
								$("tbody.adminTerritoryMemberList").append(
									"<tr><td>" + list[i].COMPANY_ID + "</td><td class='ta-l'>" + list[i].COMPANY_NAME 
									+ "</td><td><a href='javascript:void(0);' onClick='territoryMemberManage.deleteTerritory(" 
									+ list[i].ST_ALIGN_ID + ");'><i class='fa fa-times-circle'></i></a></td></tr>"
								);
							}
						}
						territoryMemberManage.selectIndustrySegment();
					},
					complete : function(){
						
					}
				});
			},
			
			selectIndustrySegment : function() {
				$.ajax({
					url : "/admin/selectIndustrySegmentList.do",
					async : false,
		 			datatype : 'json',
		 			method: 'POST',
		 			data : {
		 				SEGMENT_CODE : $("#selectIndustrySegment option:selected").val(),
		 				member_id_num : member_id_num,
		 			},
		 			beforeSend : function(xhr){
						xhr.setRequestHeader("AJAX", true);
					},
					success : function(data){
						var list = data.selectIndustrySegmentList;
						$("ul.alarm-list-pop.adminSegmentCompanyList").html("");
						if(0 < list.length){
							$("#divCheckboxSelectCompanyAll").show();
							$("#buttonInsertCompany").show();
							for(var i = 0; i<list.length; i++){
								$("ul.alarm-list-pop.adminSegmentCompanyList").append(
									"<li><input type='checkbox' name='companyCheck' value='" + list[i].COMPANY_ID + "'/>" + list[i].COMPANY_NAME + "</li>"
								);
							}
						}else{
							$("ul.alarm-list-pop.adminSegmentCompanyList").append(
									"<li>산업별 고객사가 없습니다.</li>"
								);
							$("#divCheckboxSelectCompanyAll").hide();
							$("#buttonInsertCompany").hide();
						}
					},
					complete : function(){
						
					}
				});
			}
			
}
</script>

<%@ include file="/WEB-INF/jsp/pc/common/bottom.jsp"%>
