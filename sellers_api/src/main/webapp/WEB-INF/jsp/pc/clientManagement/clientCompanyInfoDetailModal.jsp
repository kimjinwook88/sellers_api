<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="form-group">
	<label class="col-sm-2 control-label">주요 IT정보</label>
	<div class="col-sm-10">
		<table id="tableModalDetailData" class="table table-bordered">
			<colgroup>
				<col width="10%" />
				<col width="20%" />
				<col width="" />
			</colgroup>
			<tr>
				<td>구분</td>
				<td>항 목</td>
				<td>내 용</td>
			</tr>
			<tr>
				<th rowspan="5">HW</th>
				<th>서버</th>
				<td><textarea id="textModalHWServer" name="textModalHWServer" ></textarea></td>
			</tr>
			<tr>
				<th>스토리지</th>
				<td><textarea id="textModalHWStorage" name="textModalHWStorage"></textarea></td>
			</tr>
			<tr>
				<th>백업장치</th>
				<td><textarea id="textModalHWBackup" name="textModalHWBackup"></textarea></td>
			</tr>
			<tr>
				<th>네트워크</th>
				<td><textarea id="textModalHWNetwork" name="textModalHWNetwork"></textarea></td>
			</tr>
			<tr>
				<th>보안장비</th>
				<td><textarea id="textModalHWSecurity" name="textModalHWSecurity"></textarea></td>
			</tr>
			<tr>
				<th rowspan="5">SW</th>
				<th>DB</th>
				<td><textarea id="textModalSWDb" name="textModalSWDb"></textarea></td>
			</tr>
			<tr>
				<th>MiddleWare</th>
				<td><textarea id="textModalSWMiddleware" name="textModalSWMiddleware"></textarea></td>
			</tr>
			<tr>
				<th>백업SW</th>
				<td><textarea id="textModalSWBackup" name="textModalSWBackup"></textarea></td>
			</tr>
			<tr>
				<th>APM</th>
				<td><textarea id="textModalSWApm" name="textModalSWApm"></textarea></td>
			</tr>
			<tr>
				<th>DPM</th>
				<td><textarea id="textModalSWDpm" name="textModalSWDpm"></textarea></td>
			</tr>
			<tr>
				<th colspan="2">기타</th>
				<td><textarea id="textModalEtc" name="textModalEtc"></textarea></td>
			</tr>
		</table>
	</div>
</div>