<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<% 
String user_admin = (String)session.getAttribute("user_admin"); 
%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>EDMS</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<%@ include file="/WEB-INF/views/include/link.jsp"%>

<!-- 하이 맵 -->
<script src="https://code.highcharts.com/maps/highmaps.js"></script>
<script src="https://code.highcharts.com/mapdata/index.js?1"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.js"></script>
<script src="https://code.highcharts.com/maps/modules/exporting.js"></script>
<script src="https://code.highcharts.com/mapdata/countries/kr/kr-all.js"></script>

<!-- 하이 차트 -->
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<link href="/resources/css/pkg_dashboard/dashboard.css" rel="stylesheet">

</head>

<body id="dashboard">
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<div class="body_width">
		<div class="content_width">
			<div id="mapBox">
				<div id="container"></div>
			</div>
			<div class="history_battery">
				<!-- 배터리 입출고 이력 -->

				<!-- 기간별 배터리 입/출고 이력 -->
				<div class="period_battery"></div>

				<!-- 지역별 배터리 입/출고 이력 -->
				<div class="region_battery"> </div>
			</div>

			<div class="distribute_battery">
				<!-- 배터리 분포 -->

				<!-- 용량별 분포 -->
				<div class="capacity_distribute"></div>

				<!-- 지역별 분포 -->
				<div class="region_distribute"></div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {

	/* --------------------기간별 배터리 입/출고 이력-------------------- */
	$.ajax({
		url : "/pkg_dashboard/termDateChart",
		type : "POST",
		dataType : 'html',
		data : {
			"area" : "South Jeolla",
			"warehouse" : "In"
		},
		success : function(data) {
			$('.period_battery').empty();

			$('.period_battery').append(data);

			$('.period_battery_title .battery_input')
					.addClass('on');

			/* console.log("period_battery in test : " + data); */

		},
		error : function(request, status, error) {
			console.log("code = " + request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
		}
	});

	/* --------------------지역별 배터리 입/출고 이력-------------------- */
	$.ajax({
		url : "/pkg_dashboard/termAreaChart",
		type : "POST",
		dataType : 'html',
		data : {
			"area" : "South Jeolla",
			"warehouse" : "In"
		},
		success : function(data) {
			$('.region_battery').empty();

			$('.region_battery').append(data);

			$('.region_battery_title .battery_input')
					.addClass('on');

			/* console.log("region_battery in test : " + data); */

		},
		error : function(request, status, error) {
			console.log("code = " + request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
		}
	});

	/* --------------------배터리 용량별 분포-------------------- */
	$.ajax({
		url : "/pkg_dashboard/pieChart_bat",
		type : "POST",
		dataType : 'html',
		data : {
			"area" : "South Jeolla"
		},
		success : function(data) {

			$('.capacity_distribute').empty();

			$('.capacity_distribute').append(data);
			/*console.log("data : " + data);*/
		},
		error : function(request, status, error) {
			console.log("code = " + request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
		}
	});

	/* --------------------이전 지역별 분포-------------------- */
	$.ajax({
		url : "/pkg_dashboard/pieChart_area",
		type : "POST",
		dataType : 'html',
		data : {
			"area" : "South Jeolla"
		},
		success : function(data) {
			$('.region_distribute').empty();

			$('.region_distribute').append(data);

			/*console.log("region_distribute : " + data);*/
		},
		error : function(request, status, error) {
			console.log("code = " + request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
		}
	});
});
</script>
<script type="text/javascript" src="/resources/js/pkg_dashboard/dashboard_map.js"></script>
</html>
