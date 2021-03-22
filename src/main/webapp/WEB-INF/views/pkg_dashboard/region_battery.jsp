<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<div>
	<div class="region_battery_title">
		<span class="chart_area_name">${area_name}</span> <span
			class="chart_name">지역별 배터리 입/출고 이력</span>
		<div class="in_out_btn_area">
			<div class="in_out_btn battery_input"
				onclick="region_battery_input()">입고</div>
			<div class="in_out_btn battery_output"
				onclick="region_battery_output()">출고</div>
		</div>
	</div>
	<div id="region_battery_contnet"></div>
</div>
<script type="text/javascript">
var chart_area_name = $('.region_battery_title .chart_area_name').text();
	
	function region_battery_input() {
		$.ajax({
    		url : "/pkg_dashboard/termAreaChart",
    		type : "POST",
    		dataType : 'html', 
    		data : {
    			"area" : chart_area_name, 
    			"warehouse" : "In"
    		},
    		success : function(data) {
    			$('.region_battery').empty();
    			
    			$('.region_battery').append(data);
    			
    			$('.region_battery_title .battery_input').addClass('on');
    			
    		},
    		error:function(request,status,error){
    			/* console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); */
    		}
    	});
	}
	
	
	function region_battery_output() {
		$.ajax({
    		url : "/pkg_dashboard/termAreaChart",
    		type : "POST",
    		dataType : 'html', 
    		data : {
    			"area" : chart_area_name, 
    			"warehouse" : "Out"
    		},
    		success : function(data) {
    			$('.region_battery').empty();
    			
    			$('.region_battery').append(data);
    			
    			$('.region_battery_title .battery_output').addClass('on');
    			
    		},
    		error:function(request,status,error){
    			/* console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); */
    		}
    	});
	}
	
	$(document).ready(function() {
		
		if ("${warehouse}" == "In") {
		
			var ent_area_list = []; /* 입고 지역 */
			var ent_count_list = []; /* 입고 카운트 */
			
			<c:forEach var="area_list" items="${area_list}">
			
			ent_area_list.push("${area_list.ent_area}");

			ent_count_list.push(${area_list.ent_count});

			</c:forEach>

			/*지역별 배터리 입/출고 이력*/
			Highcharts.setOptions(Highcharts.theme);
		
			var region_battery_chart = Highcharts.chart(
					'region_battery_contnet', {

						title : {
							text : 'data'
						},

						xAxis : {
							categories : ent_area_list 
						},
						
						tooltip: {
							 headerFormat: '{point.x}<br />', 
					         backgroundColor: 'rgba(0, 0, 0, 0.85)',
					         title: '',
					         style: {
					               fontSize: '13px'
					         }, 
					         pointFormat: 'Count : {point.y}'
					    }, 

					    chart: {
							/* width: 530, */
							height: 275
						},
						
						series : [ {
							type : 'column',
							colorByPoint : true,
							data : ent_count_list,
							showInLegend : false
						} ]

					});
		} else if ("${warehouse}" == "Out") {
			
			var rel_area_list = []; /* 입고 지역 */
			var rel_count_list = []; /* 입고 카운트 */
			
			<c:forEach var="area_list" items="${area_list}">
			
			rel_area_list.push("${area_list.rel_area}");

			rel_count_list.push(${area_list.rel_count});

			</c:forEach>
			
			/*지역별 배터리 입/출고 이력*/
			Highcharts.setOptions(Highcharts.theme);
		
			var region_battery_chart = Highcharts.chart(
					'region_battery_contnet', {

						title : {
							text : 'data'
						},

						xAxis : {
							categories : rel_area_list 
						},
						
						tooltip: {
							 headerFormat: '{point.x}<br />', 
					         backgroundColor: 'rgba(0, 0, 0, 0.85)',
					         title: '',
					         style: {
					               fontSize: '13px'
					         }, 
					         pointFormat: 'Count : {point.y}'
					    },

					    chart: {
							/* width: 530, */
							height: 275
						},
						
						series : [ {
							type : 'column',
							colorByPoint : true,
							data : rel_count_list,
							showInLegend : false
						} ]

					});
		}
	});
</script>