<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%  
response.setHeader("Cache-Control","no-store");  
response.setHeader("Pragma","no-cache");  
response.setDateHeader("Expires",0);  
if (request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache");
%>
<%@ include file="/WEB-INF/jsp/m/common/top.jsp" %>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" name="viewport">
<title>
<c:choose><c:when test="${mode eq 'ins'}">고객사개인 추가</c:when><c:otherwise>고객사개인 수정페이지</c:otherwise></c:choose>
</title>

<link href="${pageContext.request.contextPath}/css/m/style.css" rel="stylesheet">

</head>

<body class="gray_bg" onload="tabmenuLiWidth();">


<div class="container_pg">
    <article class="">
        <div class="title_pg ta_c">
            <c:choose>
                <c:when test="${mode eq 'ins'}">
                    <h2>고객 신규 등록</h2>
                </c:when>
                <c:otherwise>
                    <h2 id="updateTitle">${detail.CUSTOMER_NAME} <span class="fs12">${detail.POSITION}</span></h2>
                </c:otherwise>
            </c:choose>
            <a href="javascript:void(0);" class="btn_back" onClick="window.history.back(); return false;">back</a>
        </div>
        
		<c:if test="${mode eq 'M'}">
	        <div class="author" id="updateAuthor">
	            <span>${sysYear}</span>
	        </div>
        </c:if>

        <div class="mg_l10 mg_r10">
            <ul class="tabmenu tabmenu_type2 mg_b20">
                <li><a href="#" id="tab_1" onclick="fncSelectTab('1'); return false;" class="active">기본정보</a></li>
                <li><a href="#" id="tab_2" onclick="fncSelectTab('2'); return false;">개인정보</a></li>
            </ul>

            <form class="form-horizontal mg_l10 mg_r10" id="formModalData" name="formModalData" method="post" enctype="multipart/form-data">

                <div class="cont1 pd_b20 "><!-- 기본정보  -->
                    <div class="form_input mg_b20">
                        <label class="">고객명 <span style="color:red;">*</span> </label>
                        <input type="text" class="form_control" id="textModalClientName" name="textModalClientName"/>
                    </div>

                    <div class="form_input mg_b20">
                        <label class="">직급</label>
                        <input type="text" class="form_control" id="textModalPosition" name="textModalPosition"/>
                    </div>

                    <div class="form_input mg_b20">
                        <label class="">휴대전화</label>
                        <input type="text" placeholder="예) 01012345678" class="form_control" id="textModalCellPhone" name="textModalCellPhone" maxlength="11" onblur="autoHypen(this);" onkeyup="commonCheck.onlyNumber(this);" autocomplete="off"/>
                    </div>

                    <div class="form_input mg_b20">
                        <label class="">직장전화</label>
                        <input type="text" placeholder="예) 01012345678" class="form_control" id="textModalPhone" name="textModalPhone" maxlength="11" onblur="autoHypen(this);" onkeyup="commonCheck.onlyNumber(this);" autocomplete="off"/>
                    </div>

                    <div class="form_input mg_b20">
                        <label class="">전자메일</label>
                        <input type="text" class="form_control" id="textModalEmail" name="textModalEmail"/>
                    </div>

                    <div class="form_input mg_b20">
                        <label class="">재직여부</label>
                        <div>
                            <label for="f_action1" class="mg_r30"><input type="radio" class="va_m" value="Y" name="radioModalUseYN" checked/><span class="va_m">재직</span></label>
                            <label for="f_action2" class=""><input type="radio" class="va_m" value="N" id="radioModalUseYN" name="radioModalUseYN"/><span class="va_m">퇴사</span></label>
                        </div>
                    </div>
                    
                    
                    <div class="form_input mg_b20">
                           	    	<label class="col-sm-2 control-label">ERP연동 여부</label>
                        			<div class="col-sm-4">
                        				<span nmae="spanERPClientCodeCheck" id="spanERPClientCodeCheck" style="margin-right:20px">
                        					<i class="fa fa-close" style="color: red;"></i>
                        					<i class="fa fa-check" style="color: green;"></i>
                        				</span>
                        				<button type="button" class="btn btn-outline btn-seller-outline ag_r" id="buttonUpdateERPClientCode" onClick="duzonSearch.reset();"> 연동하기</button>
                        			</div>
                        			<div class="custom-company-pop_m off">
                                        <div class="pop-header" style="height: 70px;line-height: 35px;">
                                            <strong class="pop-title">거래처 대표 검색</strong>
                                            <button type="button" class="close" onClick="duzonSearch.close();" style="float:right; border-radius:7px;"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                            <span style="font-size: 14px; color: red;"><br>*ERP거래처대표로 등록된 고객만 검색됩니다.</span>
                                        </div>
                                        <div class="col-sm-12 cont">
                                            <div class="form-group">
                                                <div class="col-sm-12">
                                                    <div class="company-search-after mg-b5">
                                                        <input type="text" placeholder="거래처 대표 검색" class="form-control fl_l mg-r5" id="textDuzonSearchSalesMan">
                                                        <button type="button" class="btn btn-gray btn-file" onClick="duzonSearch.salesManPop();" style="border-radius:5ps">검색</button>
                                                    </div>
                                                </div>
                                                <div class="col-sm-12 company-result mg-b10">
                                                    <ul class="company-list">
                                                    </ul>
                                                </div>
                                            </div>
                                            <!-- <div class="ta-c">
                                                <button type="button" class="btn btn-gray btn-file">추가하기</button>
                                            </div> -->
                                        </div>
                                    </div>
                           	    </div>
                           	    
                           	        
                           	    <div class="form_input mg_b20">   
                           	        <label class="col-sm-2 control-label">ERP코드</label>
                                    <div class="col-sm-4">
                                    	<input type="text" class="form-control" id="textModalERPClientCode" name="textModalERPClientCode" readOnly style="width:100%; background-color: #eee;"/>
                                    </div>
                                </div>
                           	                        
                    

                    <div class="form_input mg_b20">
                        <div class="pos-rel">                        
                            <label class="">고객사 <span style="color:red;">*</span></label>
	                            <input type="text" class="form_control" id="textCommonSearchCompany" name="textCommonSearchCompany" placeholder="고객사를 검색해 주세요." autocomplete="off"/>
                        </div>
                    </div>
                    
                    <div class="form_input mg_b20">
                        <label class="">고객사ID</label>
                        <input type="text" class="form_control" id="textCommonSearchCompanyId" name="textCommonSearchCompanyId" readOnly style="background-color: #eee;"/>
                    </div>
                    

                    <div class="form_input mg_b20">
                        <label class="">소속본부</label>
                        <input type="text" placeholder="" class="form_control" id="textModalDivision" name="textModalDivision"/>
                    </div>

                    <div class="form_input mg_b20">
                        <label class="">소속부서</label>
                        <input type="text" placeholder="" class="form_control" id="textModalPost" name="textModalPost"/>
                    </div>

                    <div class="form_input mg_b20">
                        <label class="">소속팀</label>
                        <input type="text" placeholder="" class="form_control" id="textModalTeam" name="textModalTeam"/>
                    </div>

                    <div class="form_input mg_b20">
                        <label class="">직책</label>
                        <input type="text" placeholder="" class="form_control" id="textModalPositionDuty" name="textModalPositionDuty"/>
                    </div>

                  <div class="h_line pd_t10"></div>
                    <div class="form_input mg_b20">
                        <label class="">보고라인</label>
                        
                        <div class="form_input mg_b20">
                            <span class="">소속팀</span>
                            	<div class=" col-sm-4 pos-rel">
                                <input type="text" class="form_control" placeholder="고객명 입력" id="textModalReportingLineTeamName" name="textModalReportingLineTeamName" autocomplete="off"/>
                                
                            	<input type="hidden" id="textModalReportingTeamResult" name="textModalReportingTeamResult" readOnly/>
                            </div>
                            </div>
                        <div class="form_input mg_b20">
                            <span class="">소속부서</span>
                            	<div class=" col-sm-4 pos-rel">
                                <input type="text" class="form_control" placeholder="고객명 입력" id="textModalReportingLinePostName" name="textModalReportingLinePostName" autocomplete="off"/>
                            </div>
                            	<input type="hidden" id="textModalReportingPostResult" name="textModalReportingPostResult" readOnly/>
                            
                        </div>
                        <div class="form_input mg_b20">
                            <span class="">소속본부</span>
                            <div class=" col-sm-4 pos-rel">
                                <input type="text" class="form_control" placeholder="고객명 입력" id="textModalReportingLineDivisionName" name="textModalReportingLineDivisionName" autocomplete="off"/>
                            </div>
                            	<input type="hidden" id="textModalReportingDivisionResult" name="textModalReportingDivisionResult" readOnly/>
                            
                        </div>
                    </div>

                    <div class="h_line pd_t10"></div>

                    <div class="form_input mg_b20">
                        <label class="">담당업무</label>
                        <input type="text" placeholder="" class="form_control" id="textModalDuty" name="textModalDuty"/>
                    </div>

                    <div class="form_input mg_b20">
                        <label class="">직장주소</label>
                        <input type="text" placeholder="" class="form_control" id="textModalAddress" name="textModalAddress"/>
                    </div>

                    <div class="form_input mg_b20">
                        <label class="">자사와의 관계</label>
                        <input type="text" placeholder="" class="form_control" id="textModalRelationshipInfo" name="textModalRelationshipInfo"/>
                    </div>

                    <div class="form_input mg_b20">
                        <label>관계수립</label>
                        <select class="form_control" id="selectModalRelation" name="selectModalRelation">
                            <option value="green" selected="selected">YES</option>
                            <option value="red">NO</option>
                        </select>
                    </div>                    
                    
                    <div class="form_input mg_b20">
                        <label>호감도</label>
                        <select class="form_control" id="selectModalLikeAbility" name="selectModalLikeAbility">
                            <option value="green" selected="selected">Positive</option>
                            <option value="orange">Neutral</option>
                            <option value="red">Negative</option>
                            <option value="gray">None</option>
                        </select>
                    </div>                    
                    

                    <div class="form_input mg_b20">
                        <label class="">사내친한직원</label>
                        <input type="text" placeholder="" class="form_control" id="textModalFriendshipInfo" name="textModalFriendshipInfo"/>
                    </div>

                    <div class="form_input mg_b20">
                        <div class="pos-rel">
                            <label class="">책임자</label>
                            <input type="text" class="form_control"  id="textModalDirectorName" name="textModalDirectorName" autocomplete="off"/>
                        </div>
                    </div>

                    <div class="form_input mg_b20">
                        <label class="">정보출처</label>
                        <input type="text" placeholder="" class="form_control" id="textModalPerSonalInfoSource" name="textModalPerSonalInfoSource"/>
                    </div>

                    <div class="form_input mg_b20">
                        <div class="pos-rel">
                            <label class="">이전영업사원</label>
                            <input type="text" class="form_control" id="textModalPerSonalPrevSales" name="textModalPerSonalPrevSales" autocomplete="off"/>
                        </div>
                    </div>

                    <div class="h_line pd_t10"></div>

                    <% /****************** PC버전에서 조직도 등록 오류가 나서 주석으로 막음  filePK가 null값이 넘어가서 오류 남. 
                    <div class="form_input mg_b20">
                        <label class="">명함</label>
                        <input type="file" name="fileModalUploadPhoto" id="fileModalUploadPhoto" accept="image/*" capture="camera" onchange="getThumbnailPrivew(this,$('#divModalUploadPhoto'))" />
                        <!-- <a href="" class="btn lg btn-gray ds_b r5 ta_c">사진첨부 및 촬영</a>--> <!-- 사진첨부 또는 촬영사진 첨부 --> 
                        <div class="photo_input" id="divModalUploadPhoto">
                            <img id="imgModalInsertPhoto" src="${pageContext.request.contextPath}/images/m/namecard.png" alt="샘플사진" />
                        </div>
                    </div>
                    ******************************/ %>
                    
                </div>

                <div class="cont2 pd_b20 off"><!-- 개인정보  -->

                    <div class="form_input mg_b20">
                        <label class="">학력</label>
                        <textarea class="form_control" row="3" id="textModalPerSonalEducation" name="textModalPerSonalEducation"></textarea>
                    </div>

                    <div class="form_input mg_b20">
                        <label class="">학력관련인맥</label>
                        <textarea class="form_control" row="3" id="textModalPerSonalEducationPerson" name="textModalPerSonalEducationPerson"></textarea>
                    </div>

                    <div class="form_input mg_b20">
                        <label class="">경력</label>
                        <textarea class="form_control" row="3" id="textModalPerSonalCareer" name="textModalPerSonalCareer"></textarea>
                    </div>

                    <div class="form_input mg_b20">
                        <label class="">경력관련인맥</label>
                        <textarea class="form_control" row="3" id="textModalPerSonalCareerPerson" name="textModalPerSonalCareerPerson"></textarea>
                    </div>
                    
					<div class="form_input mg_b20">
                        <label class="">가족관계</label>
                        <textarea class="form_control" row="3" id="textModalPerSonalFamily" name="textModalPerSonalFamily"></textarea>
                    </div>
                    
                    
                    <div class="form_input mg_b20">
                        <label class="">친한 사람</label>
                        <textarea class="form_control" row="3" id="textModalPerSonalFamiliars" name="textModalPerSonalFamiliars"></textarea>
                    </div>
                    
                    <div class="form_input mg_b20">
                        <label class="">사회활동</label>
                        <textarea class="form_control" row="3" id="textModalPerSonalActs" name="textModalPerSonalActs"></textarea>
                    </div>

                    <div class="form_input mg_b20">
                        <label class="">SNS</label>
                        <textarea class="form_control" row="3" id="textModalPerSonalSNS" name="textModalPerSonalSNS"></textarea>
                    </div>

                    <div class="form_input mg_b20">
                        <label class="">성향</label>
                        <textarea class="form_control" row="3" id="textModalPerSonalInclination" name="textModalPerSonalInclination"></textarea>
                    </div>

                    <div class="form_input mg_b20">
                        <label class="">기타</label>
                        <textarea class="form_control" row="3" id="textModalPerSonalETC" name="textModalPerSonalETC"></textarea>
                        <div id="hiddenModalPerSonalETC"></div>
                    </div>
                </div>
                    
                <input type="hidden" name="hiddenModalPK"        id="hiddenModalPK"        value=""/>
                <input type="hidden" name="hiddenModalCreatorId" id="hiddenModalCreatorId" value="${userInfo.MEMBER_ID_NUM}"/>
                <input type="hidden" name="hiddenModalCompanyId" id="hiddenModalCompanyId"/>
                <input type="hidden" name="hiddenModalDirectorId" id="hiddenModalDirectorId"/>
                <input type="hidden" name="hiddenERPClientCode" id="hiddenERPClientCode" value="${clientInfo.ERP_CLIENT_CODE}"/>
                
                <!-- <input type="hidden" name="hiddenModalPrevSalesMemberId" id="hiddenModalPerSonalETC"/> -->
            </form>

        </div>

        
    </article>

    <jsp:include page="../templates/footer.jsp" flush="true"/>
</div>
<div class="pg_bottom_func">
    <ul>
        <li><a href="#" class="" id="clientIndividualList"> <img src="${pageContext.request.contextPath}/images/m/icon_list.png" /> <span>목록</span></a></li>
        <li><a href="#" class="" id="insertClientIndividual"> <img src="${pageContext.request.contextPath}/images/m/icon_edit.png" /> <span>저장</span></a></li>
    </ul>
</div>
<div class="modal_screen"></div>

<!-- Mainly scripts -->
<script src="${pageContext.request.contextPath}/js/m/jquery-1.11.0.js"></script>
<script src="${pageContext.request.contextPath}/js/m/jquery.form.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/plugins/validate/jquery.validate.min.js"></script>
<script src="${pageContext.request.contextPath}/js/m/plugins/autocomplete/jquery.auto-complete.js"></script>
<link href="${pageContext.request.contextPath}/js/m/plugins/autocomplete/jquery.auto-complete.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/m/common.js"></script>
<script src="${pageContext.request.contextPath}/js/m/plugins/file/jQuery.MultiFile.min.js"></script>

<script>
var mode = '${mode}';
var pkNo = '${pkNo}';
</script>

<script src="${pageContext.request.contextPath}/js/m/view/clientManagement/clientIndividualInsertForm.js"></script>

</body>
</html>

<style>
.custom-company-pop_m {
	width:100%;
	height:100%;
    border: 1px solid #808080;
    border-radius: 7px;
    margin:0 auto;
}
</style>