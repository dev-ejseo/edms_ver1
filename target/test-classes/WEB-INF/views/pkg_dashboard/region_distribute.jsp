<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<div>
	<div class="region_distribute_title">
		<span>이전 지역별 분포</span>
	</div>
	<div id="region_distribute_contnet"></div>
</div>

<script type="text/javascript">
$(document).ready(
		function() {
			
			var rel_list = [];
			
			var rel_list_sum =[];

			<c:forEach var="list" items="${list}">
			
			rel_list = [];
			rel_list.push("${list.rel_area}");
			
			rel_list.push(${list.rel_count});
			
			rel_list_sum.push(rel_list);
			</c:forEach>
			
			/*이전 지역별 분포*/
			Highcharts.setOptions(Highcharts.theme);
			
			var region_distribute_chart = Highcharts.chart('region_distribute_contnet', {
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
			        data: rel_list_sum
			    }]
			});
		});
</script>