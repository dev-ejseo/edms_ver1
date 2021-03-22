//Prepare demo data
//Data is joined to map using value of 'hc-key' property by default.
//See API docs for 'joinBy' for more info on linking data and map.
var data = [
 ['kr-4194', 0],
 ['kr-kg', 1],
 ['kr-cb', 2],
 ['kr-kn', 3],
 ['kr-2685', 4],
 ['kr-pu', 5],
 ['kr-2688', 6],
 ['kr-sj', 7],
 ['kr-tj', 8],
 ['kr-ul', 9],
 ['kr-in', 10],
 ['kr-kw', 11],
 ['kr-gn', 12],
 ['kr-cj', 13],
 ['kr-gb', 14],
 ['kr-so', 15],
 ['kr-tg', 16],
 ['kr-kj', 17]
];

//Create the chart
Highcharts.mapChart('container', {
 chart: {
     map: 'countries/kr/kr-all'
 },

 title: {
     text: 'Dashboard Battery Map'
 },

 subtitle: {
     text: 'Source map: <a href="http://code.highcharts.com/mapdata/countries/kr/kr-all.js">South Korea</a>'
 },

 mapNavigation: {
     enabled: true,
     buttonOptions: {
         verticalAlign: 'bottom'
     }
 },
 
 tooltip: '',

 colorAxis: {
     min: 0
 },
 
 plotOptions: {
     series: {
         point: {
             events: {
                 click: function () {
                 	
                     var area_name = this.name;
                     
                     /*기간별 배터리 입/출고 이력*/
                     $.ajax({
                 		url : "/pkg_dashboard/termDateChart",
                 		type : "POST",
                 		dataType : 'html', 
                 		data : {
                 			"area" : area_name, 
                 			"warehouse" : "In"
                 		},
                 		success : function(data) {
                 			$('.period_battery').empty();
                 			
                 			$('.period_battery').append(data);
                 			
                 			$('.period_battery_title .battery_input').addClass('on');
                 		},
                 		error:function(request,status,error){
                 			// 실패 시 처리
                 			/*console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); */
                 		}
                 	});
                     
                     
                     /*지역별 배터리 입/출고 이력*/
                     $.ajax({
                 		url : "/pkg_dashboard/termAreaChart",
                 		type : "POST",
                 		dataType : 'html', 
                 		data : {
                 			"area" : area_name, 
                 			"warehouse" : "In"
                 		},
                 		success : function(data) {
                 			
                 			$('.region_battery').empty();
                 			
                 			$('.region_battery').append(data);
                 			
                 			$('.region_battery_title .battery_input').addClass('on');
                 		},
                 		error:function(request,status,error){
                 			// 실패 시 처리
                 			/*console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); */
                 		}
                 	});
                     
                     
                     /*배터리 용량별 분포*/
                     $.ajax({
                 		url : "/pkg_dashboard/pieChart_bat",
                 		type : "POST",
                 		dataType : 'html', 
                 		data : {
                 			"area" : area_name 
                 		},
                 		success : function(data) {
                 			
                 			$('.capacity_distribute').empty();
                 			
                 			$('.capacity_distribute').append(data);
                 		},
                 		error:function(request,status,error){
                 			// 실패 시 처리
                 			/*console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);*/
                 		}
                 	});
                     
                     /*이전 지역별 분포*/
                     $.ajax({
                 		url : "/pkg_dashboard/pieChart_area",
                 		type : "POST",
                 		dataType : 'html', 
                 		data : {
                 			"area" : area_name 
                 		},
                 		success : function(data) {
                 			$('.region_distribute').empty();
                 			
                 			$('.region_distribute').append(data);
                 		},
                 		error:function(request,status,error){
                 			// 실패 시 처리
                 		    /*console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); */
                 		}
                 	});
                 }
             }
         }
     }
 },
  
 series: [{
     data: data,
     name: '',
     states: {
         hover: {
             color: '#90ee7e',
         },
     },
     dataLabels: {
         enabled: true,
         format: '{point.name}'
     }
 }]
});

Highcharts.theme = {
	    colors: ['#2b908f', '#90ee7e', '#f45b5b', '#7798BF', '#aaeeee', '#ff0066',
	        '#eeaaee', '#55BF3B', '#DF5353', '#7798BF', '#aaeeee'],
	    chart: {
	        backgroundColor: {
	            linearGradient: { x1: 0, y1: 0, x2: 1, y2: 1 },
	            stops: [
	                [0, '#2a2a2b'],
	                [1, '#3e3e40']
	            ]
	        },
	        style: {
	            fontFamily: '\'Unica One\', sans-serif'
	        },
	        plotBorderColor: '#606063'
	    },
	    title: {
	        style: {
	            color: 'rgba(0, 0, 0, 0)',
	            textTransform: 'uppercase',
	            fontSize: '20px'
	        }
	    },
	    subtitle: {
	        style: {
	            color: '#E0E0E3',
	            textTransform: 'uppercase'
	        }
	    },
	    xAxis: {
	        gridLineColor: '#707073',
	        labels: {
	            style: {
	                color: '#E0E0E3'
	            }
	        },
	        lineColor: '#707073',
	        minorGridLineColor: '#505053',
	        tickColor: '#707073',
	        title: {
	            style: {
	                color: '#A0A0A3'
	            }
	        }
	    },
	    yAxis: {
	        gridLineColor: '#707073',
	        labels: {
	            style: {
	                color: '#E0E0E3'
	            }
	        },
	        lineColor: '#707073',
	        minorGridLineColor: '#505053',
	        tickColor: '#707073',
	        tickWidth: 1,
	        title: {
	            style: {
	                color: '#A0A0A3'
	            }
	        }
	    },
	    tooltip: {
	        backgroundColor: 'rgba(0, 0, 0, 0.85)',
	        style: {
	            color: '#F0F0F0'
	        }
	    },
	    plotOptions: {
	        series: {
	            dataLabels: {
	                color: '#F0F0F3',
	                style: {
	                    fontSize: '14px'
	                }
	            },
	            marker: {
	                lineColor: '#333'
	            }
	        },
	        boxplot: {
	            fillColor: '#505053'
	        },
	        candlestick: {
	            lineColor: 'white'
	        },
	        errorbar: {
	            color: 'white'
	        }
	    },
	    legend: {
	        backgroundColor: 'rgba(0, 0, 0, 0.5)',
	        itemStyle: {
	            color: '#E0E0E3'
	        },
	        itemHoverStyle: {
	            color: '#FFF'
	        },
	        itemHiddenStyle: {
	            color: '#606063'
	        },
	        title: {
	            style: {
	                color: '#C0C0C0'
	            }
	        }
	    },
	    credits: {
	        style: {
	            color: '#666'
	        }
	    },
	    labels: {
	        style: {
	            color: '#707073'
	        }
	    },
	    drilldown: {
	        activeAxisLabelStyle: {
	            color: '#F0F0F3'
	        },
	        activeDataLabelStyle: {
	            color: '#F0F0F3'
	        }
	    },
	    navigation: {
	        buttonOptions: {
	            symbolStroke: '#DDDDDD',
	            theme: {
	                fill: '#505053'
	            }
	        }
	    },
	    // scroll charts
	    rangeSelector: {
	        buttonTheme: {
	            fill: '#505053',
	            stroke: '#000000',
	            style: {
	                color: '#CCC'
	            },
	            states: {
	                hover: {
	                    fill: '#707073',
	                    stroke: '#000000',
	                    style: {
	                        color: 'white'
	                    }
	                },
	                select: {
	                    fill: '#000003',
	                    stroke: '#000000',
	                    style: {
	                        color: 'white'
	                    }
	                }
	            }
	        },
	        inputBoxBorderColor: '#505053',
	        inputStyle: {
	            backgroundColor: '#333',
	            color: 'silver'
	        },
	        labelStyle: {
	            color: 'silver'
	        }
	    },
	    navigator: {
	        handles: {
	            backgroundColor: '#666',
	            borderColor: '#AAA'
	        },
	        outlineColor: '#CCC',
	        maskFill: 'rgba(255,255,255,0.1)',
	        series: {
	            color: '#7798BF',
	            lineColor: '#A6C7ED'
	        },
	        xAxis: {
	            gridLineColor: '#505053'
	        }
	    },
	    scrollbar: {
	        barBackgroundColor: '#808083',
	        barBorderColor: '#808083',
	        buttonArrowColor: '#CCC',
	        buttonBackgroundColor: '#606063',
	        buttonBorderColor: '#606063',
	        rifleColor: '#FFF',
	        trackBackgroundColor: '#404043',
	        trackBorderColor: '#404043'
	    }
};