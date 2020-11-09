<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="hr-line-dashed"></div>
<div class="form-group">
	<label class="col-sm-2 control-label">업태</label>
	<div class="col-sm-4">
		<input type="text" class="form-control" id="textModalBusinessType"
			name="textModalBusinessType" autocomplete="off"/>
	</div>
	<label class="col-sm-2 control-label">종목</label>
	<div class="col-sm-4">
		<input type="text" class="form-control" id="textModalBusinessSector"
			name="textModalBusinessSector" autocomplete="off"/>
	</div>
</div>

<div class="hr-line-dashed"></div>
<div class="form-group">
	<label class="col-sm-2 control-label">ERP등록번호</label>
	<div class="col-sm-4">
		<input type="text" class="form-control" id="textModalErpRegCode"
			name="textModalErpRegCode" autocomplete="off"/>
	</div>
</div>

<div class="hr-line-dashed"></div>
<div class="form-group">
	<label class="col-sm-2 control-label">조직도</label>
	<div class="col-sm-10 custom-photo">
		<label for="fileModalUploadPhoto"><a
			class="fileUpload btn btn-gray" onclick="modal.browserCheck();"
			style="color: white">사진첨부</a></label>
	</div>
	<div class="col-sm-12 m-b text-center custom-photo">
		<div id="divModalPhotoUploadArea">
			<div class="filebox photo">

				<!-- <label for="fileModalUploadPhoto" style="background-color: #2dbae7;border-color:#2dbae7;color: #fff;">명함 첨부</label> -->
				<input type="file" name="fileModalUploadPhoto"
					id="fileModalUploadPhoto" accept="image/*" capture="camera"
					onchange="getThumbnailPrivew(this,$('#divModalUploadPhoto'))" />
				<div id="divModalUploadPhoto">
					<span class="blank-ment"><img
						src="../images/pc/icon_org.gif" style="" class="photo" alt="" /></span>
				</div>

			</div>
		</div>
	</div>
</div>