<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<form id="formSampleFile" name="formSampleFile" method="post">
 	<input type="hidden" name="sampleFileName" value=""/>
</form>

<script type="text/javascript">
$(document).ready(function() {
});

var downFile = {
		
		selectSampleFile : function(file, flag) {
			$("#formSampleFile input[name='sampleFileName']").val('');
			$("#formSampleFile input[name='sampleFileName']").val(file.innerHTML);
			$("#formSampleFile").attr("action","/common/sampleDownloadFile.do?menuFlag="+flag);
			$("#formSampleFile").submit();
		}
		
}
</script>