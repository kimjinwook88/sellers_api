<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">

var columnData = new Array();

var now_data = ${graph_data.QUARTER_UNTREATED};
var in_data = ${graph_data.QUARTER_IN};
var out_data = ${graph_data.QUARTER_OUT};
columnData = [now_data, in_data, out_data];
/* console.log(columnData); */
var NameArr = ['IN','미처리','OUT'];
var titleArr = new Array(); // 카테고리 이름용 배열


		
var chart = c3.generate({
	bindto: "#Graph_Area",
    data: {
    	rows: columnData,
        type: 'bar',
        labels: true,
        groups: [
            ['성과', 'IN', 'OUT']
        ]
    },
    grid: {
        y: {
            lines: [{value:0}]
        }
    },
    axis: {
		x: {
			type: 'category',
			categories: titleArr
		},
		y: {
			show:false
		}
	},
	size: {
		  height: 80
	},
	tooltip: {
        format: {
            title: function (d) { return titleArr[d]; },
            value: function (value, ratio, id) {
                var format = id === '성과' ? d3.format(',') : d3.format(',');
                return format(value);
            }
        }
    }
});


$(document).ready(function() {
	// 고객 등록
	$("#opportunityInsert").on("click",	function(e) {
		$('#mode').val("ins");
		$("#inserForm").attr("action", "/clientSalesActive/opportunityInsertForm.do");
		$('#inserForm').submit();
		e.preventDefault();
	});
});


</script>

<!-- 영업기회 -->
	<div class="title_head">
		<h2 class="title">영업기회</h2>
		<a href="#" id="opportunityInsert" class="btn_more_landing">+</a>
		<form method="post" id="inserForm" action="">
			<input type="hidden" id="mode" name="mode" value="ins" />
		</form>
	</div>
	<div class="salesOpp_box">
		<ul class="salesList">
			<c:choose>
				<c:when test="${fn:length(row) > 0 }">
					<c:forEach items="${row}" var="row">
						<li>
							<a href="/clientSalesActive/selectOpportunityDetail.do?pkNo=${row.PK}">
								<%-- <span class="date">[${row.CONTRACT_DATE}]</span> --%>
								<span class="subject">${row.SUBJECT}</span>
								<span class="status">
									<span class="icon_status statusColor_${row.STATUS1}"></span>
									<span class="icon_status statusColor_${row.STATUS2}"></span>
									<span class="icon_status statusColor_${row.STATUS3}"></span>
									<span class="icon_status statusColor_${row.STATUS4}"></span>
								</span>
							</a>
						</li>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<li>
						<p class="pd_t20 pd_b20 ta_c">등록된 영업기회가 없습니다.</p>
					</li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>