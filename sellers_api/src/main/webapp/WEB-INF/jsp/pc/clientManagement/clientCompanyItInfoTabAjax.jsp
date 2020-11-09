<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<% pageContext.setAttribute("enter", "\n"); %>

<div id="tab2-1" class="tab-pane active">
<h2>고객사 IT정보</h2>

    <div class="custom-basic">
        <div class="view_pg_type1">
             <table id="tech-companies" class="basic4_list mg-b30">
             	<thead>
		             <tr>
		                 <th width="7%">구 분</th>
		                 <th width="12%">항 목</th>
		                 <th>내 용</th>
		             </tr>
           		</thead>
           		<tbody>
           			<tr>
           				<th rowspan="6">HW</th>
           			</tr>
	           		<tr>
	      				<th class="ag_l">서버</th>
	      				<td class="ag_l">${fn:replace(clientCompanyItInfo.HW_SERVER, enter, "<br/>")}</td>
	       			</tr>
	       			<tr>
	       				<th class="ag_l">스토리지</th>
	       				<td class="ag_l">${fn:replace(clientCompanyItInfo.HW_STORAGE, enter, "<br/>")}</td>
	       			</tr>
	       			<tr>
	       				<th class="ag_l">백업장치</th>
	       				<td class="ag_l">${fn:replace(clientCompanyItInfo.HW_BACKUP, enter, "<br/>")}</td>
	       			</tr>
	       			<tr>
	       				<th class="ag_l">네트워크</th>
	       				<td class="ag_l">${fn:replace(clientCompanyItInfo.HW_NETWORK, enter, "<br/>")}</td>
	       			</tr>
	       			<tr>
	       				<th class="ag_l">보안장비</th>
	       				<td class="ag_l">${fn:replace(clientCompanyItInfo.HW_SECURITY, enter, "<br/>")}</td>
	       			</tr>
	       			<tr>
	       				<th rowspan="6">SW</th>
	       			</tr>
	       			<tr>
	       				<th class="ag_l">DB</th>
	       				<td class="ag_l">${fn:replace(clientCompanyItInfo.SW_DB, enter, "<br/>")}</td>
	       			</tr>
	       			<tr>
	       				<th class="ag_l">middleware</th>
	       				<td class="ag_l">${fn:replace(clientCompanyItInfo.SW_MIDDLEWARE, enter, "<br/>")}</td>
	       			</tr>
	       			<tr>
	       				<th class="ag_l">백업SW</th>
	       				<td class="ag_l">${fn:replace(clientCompanyItInfo.SW_BACKUP, enter, "<br/>")}</td>
	       			</tr>
	       			<tr>
	       				<th class="ag_l">APM</th>
	       				<td class="ag_l">${fn:replace(clientCompanyItInfo.SW_APM, enter, "<br/>")}</td>
	       			</tr>
	       			<tr>
	       				<th class="ag_l">DPM</th>
	       				<td class="ag_l">${fn:replace(clientCompanyItInfo.SW_DPM, enter, "<br/>")}</td>
	       			</tr>
	       			<tr>
	       				<th colspan="2">기타</th>
	       				<td class="ag_l">${fn:replace(clientCompanyItInfo.ETC, enter, "<br/>")}</td>
	       			</tr>
       		</tbody>
       	</table>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function() {
	$("#LATELY_UPDATE_DATE").html($("#hiddenSysUpdateDate").val());
});
</script>