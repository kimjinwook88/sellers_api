<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="form-group">
<label class="col-sm-2 control-label">파일첨부</label>
	<div class="col-sm-10">
		<div class="input-default pop-file">
                <div class="file-dragdrap-area">
                		<!-- <button id="buttonSearchFile" type="button" class="btn btn-seller btn-file">파일찾기</button> -->
	        		<div class="fileUpload btn btn-gray">
	                  <span>파일찾기</span>
	                  <input type="file" name="fileModalUploadFile[]" onchange="commonFile.upload(this);" class="upload"
	                   accept=".jpg, .png, .gif, .jpeg, .xls, .xlsx, .pdf, .ppt, .pptx, .doc, .docx, .hwp, .txt" multiple />
	                </div>
            		<div class="file-in-list" id="divFileUploadList"> <!-- id="divModal`File" -->
                		<!-- 선택된 파일이 없는 경우 아래 멘트 노출 -->
                		<!-- <span class="blank-ment" style="display:none;">선택된 파일이 없습니다</span> -->
                		
                	</div>
             	</div>
		</div>
	</div>
</div>
