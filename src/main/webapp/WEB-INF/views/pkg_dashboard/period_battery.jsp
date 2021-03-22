<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<div>
	<div class="period_battery_title">
		<span class="chart_area_name">${area_name}</span> <span
			class="chart_name">기간별 배터리 입/출고 이력</span>
		<div class="in_out_btn_area">
			<div class="in_out_btn battery_input"
				onclick="period_battery_input()">입고</div>
			<div class="in_out_btn battery_output"
				onclick="period_battery_output()">출고</div>
		</div>
	</div>
	<div id="period_battery_contnet"></div>
</div>
<script type="text/javascript">
	var chart_area_name = $('.period_battery_title .chart_area_name').text();
	
	function period_battery_input() {
		$.ajax({
    		url : "/pkg_dashboard/termDateChart",
    		type : "POST",
    		dataType : 'html', 
    		data : {
    			"area" : chart_area_name, 
    			"warehouse" : "In"
    		},
    		success : function(data) {
    			$('.period_battery').empty();
    			
    			$('.period_battery').append(data);
    			
    			$('.period_battery_title .battery_input').addClass('on');
    			
    		},
    		error:function(request,status,error){
    			/* console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); */
    		}
    	});
	}
	
	function period_battery_output() {
		$.ajax({
    		url : "/pkg_dashboard/termDateChart",
    		type : "POST",
    		dataType : 'html', 
    		data : {
    			"area" : chart_area_name, 
    			"warehouse" : "Out"
    		},
    		success : function(data) {
    			$('.period_battery').empty();
    			
    			$('.period_battery').append(data);
    			
    			$('.period_battery_title .battery_output').addClass('on');
    		},
    		error:function(request,status,error){
    			/* console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); */
    		}
    	});
	}
	
	$(document).ready(function() {
		
		if ("${warehouse}" == "In") {
		
		var ent_dt_list = []; /* 입고 날짜 */
		var ent_count_list = []; /* 입고 카운트 */
			
		<c:forEach var="data_list" items="${data_list}">
		
		ent_dt_list.push("${data_list.ent_dt}");

		ent_count_list.push(${data_list.ent_count});

		</c:forEach>

		/*기간별 배터리 입/출고 이력*/
		Highcharts.setOptions(Highcharts.theme);
		
		var period_battery_chart = Highcharts.chart('period_battery_contnet', {

			title : {
				text : 'data'
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
			
			xAxis : {
				categories : ent_dt_list
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
			
			var rel_dt_list = []; /* 출고 날짜 */
			var rel_count_list = []; /* 출고 카운트 */
				
			<c:forEach var="data_list" items="${data_list}">
			rel_dt_list.push("${data_list.rel_dt}");

			rel_count_list.push(${data_list.rel_count});

			</c:forEach>

			/*기간별 배터리 입/출고 이력*/
			Highcharts.setOptions(Highcharts.theme);
			
			var period_battery_chart = Highcharts.chart('period_battery_contnet', {

				title : {
					text : 'data'
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
				
				xAxis : {
					categories : rel_dt_list
				},
				
				chart: {
					/* width: 350,  */
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