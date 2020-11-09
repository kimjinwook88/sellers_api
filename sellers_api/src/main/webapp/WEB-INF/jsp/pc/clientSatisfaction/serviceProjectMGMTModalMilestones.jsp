<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

	<div class="col-lg-12" id="divMilestonesProjectMGMT">
			<div class="ibox-content" id="divMilestonesToggle" style="padding-right: 10px;border-style:none;">
				<div id="vertical-timeline" class="vertical-container dark-timeline milestones-list">
					<div class="vertical-timeline-block">
						<div class="vertical-timeline-icon gray-bg">
							<a href="#" class="aMileProjectMGMT"><i class="fa fa-check"></i></a>
						</div>
						<div class="vertical-timeline-content mileStones">
							<a href="#"> <span class="tis" name="milesontesName">분석</span>
								완료목표일 : <input type="text" name="milesontesDueDate" />&nbsp;
								실완료일 : <input type="text" name="milesontesEndDate" />
								<input type="hidden" name="hiddenEndDateCheck" />
							</a>
						</div>
					</div>
					<div class="vertical-timeline-block">
						<div class="vertical-timeline-icon gray-bg">
							<a href="#" class="aMileProjectMGMT"><i class="fa fa-check"></i></a>
						</div>
						<div class="vertical-timeline-content mileStones">
							<a href="#"> <span class="tis" name="milesontesName">설계</span>
								완료목표일 : <input type="text" name="milesontesDueDate" />&nbsp;
								실완료일 : <input type="text" name="milesontesEndDate" />
								<input type="hidden" name="hiddenEndDateCheck" />
							</a>
						</div>
					</div>
					<div class="vertical-timeline-block">
						<div class="vertical-timeline-icon gray-bg">
							<a href="#" class="aMileProjectMGMT"><i class="fa fa-check"></i></a>
						</div>
						<div class="vertical-timeline-content mileStones">
							<a href="#"> <span class="tis" name="milesontesName">구현</span>
								완료목표일 : <input type="text" name="milesontesDueDate" />&nbsp;
								실완료일 : <input type="text" name="milesontesEndDate" />
								<input type="hidden" name="hiddenEndDateCheck" />
							</a>
						</div>
					</div>
					<div class="vertical-timeline-block">
						<div class="vertical-timeline-icon gray-bg">
							<a href="#" class="aMileProjectMGMT"><i class="fa fa-check"></i></a>
						</div>
						<div class="vertical-timeline-content mileStones">
							<a href="#"> <span class="tis" name="milesontesName">테스트</span>
								완료목표일 : <input type="text" name="milesontesDueDate" />&nbsp;
								실완료일 : <input type="text" name="milesontesEndDate" />
								<input type="hidden" name="hiddenEndDateCheck" />
							</a>
						</div>
					</div>
					<div class="vertical-timeline-block">
						<div class="vertical-timeline-icon gray-bg">
							<a href="#" class="aMileProjectMGMT"><i class="fa fa-check"></i></a>
						</div>
						<div class="vertical-timeline-content mileStones">
							<a href="#"> <span class="tis" name="milesontesName">이행</span>
								완료목표일 : <input type="text" name="milesontesDueDate" />&nbsp;
								실완료일 : <input type="text" name="milesontesEndDate" />
								<input type="hidden" name="hiddenEndDateCheck" />
							</a>
						</div>
					</div>

					<!-- MileStonrs 설정 팝업 -->
					<!--  <div class="milestones-edit-pop">
                      <div class="select-com"><label>항목선택</label> 
                          <select class="form-control" name="account">
                          <option>Solutionning</option>
                          <option>Proposal</option>
                          <option>Contact</option>
                          <option>Delivery</option>
                      </select></div>
                      <div class="form-group">
                          <div  id="data_1">
                              <div class="input-group date">
                                  <span class="input-group-addon"><i class="fa fa-calendar"></i></span><input type="text" class="form-control" value="08/09/2014">
                              </div>
                          </div>
                      </div>
                      <p class="text-center">
                          <strong>확정여부</strong>
                          <label for="confirmsel1"><input type="radio" name="confirmsel" id="confirmsel1" /> <span>Yes</span></label>
                          <label for="confirmsel2"><input type="radio" name="confirmsel" id="confirmsel2" /> <span>No</span></label>
                      </p>
                      <p class="text-center">
                          <button class="btn sellers-bg">저장하기</button>
                      </p>
                  </div> -->
				</div>

				<!-- <p class="text-center">
					<button type="submit" class="btn btn-w-m btn-seller" id="buttonMileProjectMGMT" onClick="">MileStones 저장</button>
				</p> -->
			</div>
		</div>


<script type="text/javascript">
	$(document).ready(function() {
		mileOpper.init();
	});
	
	var milestonesEvent = {
			on : function(){
				// 마일스톤 아이콘 클릭
				$("div.gray-bg > .aMileProjectMGMT").on('click', milestonesEvent.clickMileProjectMGMT);
			},
			
			off : function(){
				// 마일스톤 아이콘 클릭
				$("div.gray-bg > .aMileProjectMGMT").off('click', milestonesEvent.clickMileProjectMGMT);
			},
			
			clickMileProjectMGMT : function(event) {
				event.preventDefault();
				var obj = $(this);
				var mileSeq = $(".aMileProjectMGMT").index(obj);
				
				if ($("input[name='hiddenEndDateCheck']").eq(mileSeq).val() == "Y") {
					obj.parent("div.sellers-bg").removeClass("sellers-bg").addClass("gray-bg");
					$("input[name='hiddenEndDateCheck']").eq(mileSeq).val("N");
					$("input[name='milesontesEndDate']").eq(mileSeq).val("");
				} else {
					obj.parent("div.gray-bg").removeClass("gray-bg").addClass("sellers-bg");
					$("input[name='hiddenEndDateCheck']").eq(mileSeq).val("Y");
					$("input[name='milesontesEndDate']").eq(mileSeq).val(commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
				}
			}
	}

	var mileOpper = {
		init : function() {
			$("input[name='milesontesDueDate']").datepicker({
				todayBtn : "linked",
				keyboardNavigation : false,
				forceParse : false,
				calendarWeeks : true,
				autoclose : true,
				onSelect : function(d) {
				}
			}).on('hide.bs.modal', function(event) {
				// prevent datepicker from firing bootstrap modal "show.bs.modal"
				event.stopPropagation();
			}).val(commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			
			/* $("#divMilestonesProjectMGMT").click(function() {
				if (!$("#hiddenModalPK").val()) {
					alert("신규 등록 후 작성해 주세요.");
					return false;
				}
			}); */

			$("input[name='milesontesEndDate']").datepicker({
				todayBtn : "linked",
				keyboardNavigation : false,
				forceParse : false,
				calendarWeeks : true,
				autoclose : true,
				onSelect : function(d) {
				}
			}).on('hide.bs.modal', function(event) {
				// prevent datepicker from firing bootstrap modal "show.bs.modal"
				event.stopPropagation();
			}).val(commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			
			/* $("#divMilestonesProjectMGMT").click(function() {
				if (!$("#hiddenModalPK").val()) {
					alert("신규 등록 후 작성해 주세요.");
					return false;
				}
			}); */

			//update 
			/*$("div.gray-bg > .aMileProjectMGMT").click(
					function(event) {
						event.preventDefault();
						var obj = $(this);
						var mileSeq = $(".aMileProjectMGMT").index(obj);
						
						if ($("input[name='hiddenEndDateCheck']").eq(mileSeq).val() == "Y") {
							obj.parent("div.sellers-bg").removeClass("sellers-bg").addClass("gray-bg");
							$("input[name='hiddenEndDateCheck']").eq(mileSeq).val("N");
							$("input[name='milesontesEndDate']").eq(mileSeq).val("");
						} else {
							obj.parent("div.gray-bg").removeClass("gray-bg").addClass("sellers-bg");
							$("input[name='hiddenEndDateCheck']").eq(mileSeq).val("Y");
							$("input[name='milesontesEndDate']").eq(mileSeq).val(commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
						}
						/* $.ajax({
							url : "/clientSatisfaction/insertOpportunityMilestons.do",
							beforeSend : function(xhr){
								xhr.setRequestHeader("AJAX", true);
								if(confirm("MileStones를 저장하시겠습니까?")){
									obj.parent("div.gray-bg").removeClass("gray-bg").addClass("sellers-bg");
									$.ajaxLoading();
								}else{
									return false;
								}
							},
							success : function(){
								
							},
							complete : function(){
								$.ajaxLoadingHide();
							}
						}); */
					/*});*/
		},

		insert : function() {
			$('#formMileProjectMGMT').ajaxForm({
				url : "/clientSatisfaction/insertProjectMGMTMilestons.do",
				dataType: "json",
				beforeSubmit : function(data, form, option) {
					if (!confirm("저장하시겠습니까?"))
						return false;
                        $.ajaxLoading();
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				data : {
					hiddenModalPK : $("#hiddenModalPK").val(),
					hiddenModalCreatorId : $("#hiddenModalCreatorId").val()
				},
				success : function(data) {
					//성공후 서버에서 받은 데이터 처리
					if (data.cnt > 0) {
						alert("저장하였습니다.");
						$("#buttonMileProjectMGMT").attr("onClick","mileOpper.update();");
						$("#sellersGrid").jqGrid('setGridParam', { datatype: 'json' , url : "/clientSatisfaction/gridProjectMGMT.do?"+searchSerialize, rowNum : listRow}).trigger('reloadGrid');
					} else {
						alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		update : function(){
			$('#formMileProjectMGMT').ajaxForm({
				url : "/clientSatisfaction/updateProjectMGMTMilestons.do",
				dataType: "json",
				beforeSubmit : function(data, form, option) {
					if (!confirm("저장하시겠습니까?"))
						return false;
                        $.ajaxLoading();
				},
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				data : {
					hiddenModalPK : $("#hiddenModalPK").val(),
					hiddenModalCreatorId : $("#hiddenModalCreatorId").val()
				},
				success : function(data) {
					//성공후 서버에서 받은 데이터 처리
					if (data.cnt > 0) {
						alert("저장하였습니다.");
						$("#sellersGrid").jqGrid('setGridParam', { datatype: 'json' , url : "/clientSatisfaction/gridProjectMGMT.do?"+searchSerialize, rowNum : listRow}).trigger('reloadGrid');
					} else {
						alert("입력을 실패했습니다.\n관리자에게 문의하세요.");
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		select : function(){
			$.ajax({
				url : "/clientSatisfaction/selectProjectMGMTMilestons.do",
				datatype : 'json',
				data : {
					hiddenModalPK : $("#hiddenModalPK").val()
				},
				async: false,
				beforeSend : function(xhr){
					xhr.setRequestHeader("AJAX", true);
				},
				success  : function(result){
					var mileList = result.list;
					if(mileList.length > 0){
						mileOpper.reset();
						for(var i=0; i<mileList.length; i++){
							$("input[name='milesontesDueDate']").eq(i).val(mileList[i].ACT_DUE_DATE);
							if(mileList[i].ACT_CLOSE_DATE){
								$("div.vertical-timeline-icon").eq(i).removeClass("gray-bg").addClass("sellers-bg");
								$("input[name='milesontesEndDate']").eq(i).val(mileList[i].ACT_CLOSE_DATE);
								$("input[name='hiddenEndDateCheck']").eq(i).val("Y");
							}
						}
						$("#buttonMileProjectMGMT").attr("onClick","mileOpper.update();");
					}else{
						mileOpper.reset();
						$("#buttonMileProjectMGMT").attr("onClick","mileOpper.insert();");
					}
				},
				complete : function(){
					$.ajaxLoadingHide();
				}
			});
		},
		
		reset : function(){
			$("input[name='hiddenEndDateCheck']").val('');
			$("input[name='milesontesEndDate']").val('');
			$("input[name='milesontesDueDate']").val(commonDate.year+"-"+commonDate.month+"-"+commonDate.day);
			$("div.vertical-timeline-icon").removeClass("sellers-bg").addClass("gray-bg");
		}
	}
</script>