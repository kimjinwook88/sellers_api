<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
</div>

<style type="text/css">
	div.ajax-loader_sellers{
		position:fixed; 
		width:100%; 
		height:100%; 
		top:50%; 
		left:50%;
		display:none;
	}
</style>

<div class="ajax-loader_sellers" style="z-index:99999999;">
	<img src = "/img/pc/ajax-loader_sellers.gif" width="70px;"/>
</div>
 
<div class="modal_screen"></div>

</body>
</html>