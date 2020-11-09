<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
			
			<div id="tab2-2" class="tab-pane active">
                	<h2>개인정보</h2>
                	
                	<div class="custom-basic">
					 <div class="view_pg_type1">
                	
                	 <div class="col-lg-12">
                       <div class="col-lg-12">
                           
                           <div class="form-group topline pd-t10">
                               <label class="col-sm-2 control-label ag_r"><span>학력</span></label>
                               <div class="col-sm-4" id="divPersonalInfoProfile">${defaultInfo[0].PINFO_EDUCATION}</div>
                               <label class="col-sm-2 control-label ag_r"><span>학력관련<br/>인맥정보</span></label>
                               <div class="col-sm-4" id="divPersonalInfoProfile">${defaultInfo[0].PINFO_EDUCATION_PERSON}</div>
                           </div>
                           
                           <div class="form-group pd-t10">
                               <label class="col-sm-2 control-label ag_r"><span>경력</span></label>
                               <div class="col-sm-4" id="divPersonalInfoProfile">${defaultInfo[0].PINFO_CAREER}</div>
                               <label class="col-sm-2 control-label ag_r"><span>경력관련<br/>인맥정보</span></label>
                               <div class="col-sm-4" id="divPersonalInfoProfile">${defaultInfo[0].PINFO_CAREER_PERSON}</div>
                           </div>
                       
                           <!--  -->
                           <div class="form-group pd-t10">
                               <label class="col-sm-2 control-label ag_r"><span>가족관계</span></label>
                               <div class="col-sm-4" id="divPersonalInfoFamily">${defaultInfo[0].PINFO_FAMILY}</div>
                               <label class="col-sm-2 control-label ag_r"><span>친한사람</span></label>
                               <div class="col-sm-4" id="divPersonalInfoFamiliars">${defaultInfo[0].PINFO_FAMILIARS}</div>
                           </div>
                           
                           <div class="form-group pd-t10">
                          		<label class="col-sm-2 control-label ag_r"><span>사회활동</span></label>
                               <div class="col-sm-4" id="divPersonalInfoSocialAtcs">${defaultInfo[0].PINFO_SOCIAL_ACTS}</div>
                               <label class="col-sm-2 control-label ag_r"><span>SNS</span></label>
                               <div class="col-sm-4" id="divPersonalInfoSNS">${defaultInfo[0].PINFO_SNS}</div>
                               
                           </div>
                           
                           <div class="form-group pd-t10">
                           		<label class="col-sm-2 control-label ag_r"><span>성향</span></label>
                          		<div class="col-sm-4" id="divPersonalInfoInclination">${defaultInfo[0].PINFO_INCLINATION}</div>
                               <label class="col-sm-2 control-label ag_r"><span>기타</span></label>
                               <div class="col-sm-4" id="divPersonalInfoETC">${defaultInfo[0].PINFO_ETC}</div>
                           </div>
                           
                           <%-- <div class="form-group pd-t10">
                               <label class="col-sm-2 control-label ag_r"><span>정보출처></span></label>
                               <div class="col-sm-4">${defaultInfo[0].INFO_SOURCE}</div>
                           </div>
                            --%>
                        </div>
                   </div>
                   
                   </div>
                   </div>
                	
                </div>