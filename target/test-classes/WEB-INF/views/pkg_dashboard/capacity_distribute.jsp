<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<div>
	<div class="capacity_distribute_title">
		<span>배터리 용량별 분포</span>
	</div>
	<div id="capacity_distribute_contnet"></div>
</div>

<script type="text/javascript">
$(document).ready(
		function() {
			
			var kwh_list = [];
			
			var kwh_list_sum =[];

			<c:forEach var="list" items="${list}">
			
			kwh_list = [];
			kwh_list.push("${list.kwh}");
			
			kwh_list.push(${list.kwh_count});
			
			kwh_list_sum.push(kwh_list);
			</c:forEach>
			
			/*배터리 용량별 분포*/
			Highcharts.setOptions(Highcharts.theme);
			
			var capacity_distribute_chart = Highcharts.chart('capacity_distribute_contnet', {
				chart: {
			        type: 'pie',
			        options3d: {
			            enabled: true,
			            alpha: 45,
			            beta: 0
			        },
			        /* width: 350,  */
			        height: 275
			    },
			    
			    title: {
			    	text : 'data'
			    },
			    
			    accessibility: {
			        point: {
			            valueSuffix: '%'
			        }
			    },
			    
			    tooltip: {
			    	 headerFormat: '', 
			         backgroundColor: 'rgba(0, 0, 0, 0.85)',
			         title: '',
			         style: {
			        	 fontSize: '13px'
			         }, 
			         pointFormat: '{point.name} : <b>{point.percentage:.1f}%</b>'
			    },
			    
			    plotOptions: {
			        pie: {
			            allowPointSelect: true,
			            cursor: 'pointer',
			            depth: 35,
			            dataLabels: {
			                enabled: true,
			                format: '{point.name}'
			            }
			        }
			    },
			    
			    series: [{
			        type: 'pie',
			        name: '{point.name}',
			        data: kwh_list_sum
			    }]
			});
		});
</script>