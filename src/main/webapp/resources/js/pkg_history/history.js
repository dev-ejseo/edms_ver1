function downloadExcel() {
	$("#history_table").table2excel({
		exclude : ".noExl",
		name : "history",
		filename : "history" + '.xls',
		fileext : ".xls",
		exclude_img : true,
		exclude_links : true,
		exclude_inputs : true
	});
}

function form_save() {

	var param_list = [];

	var insert_row = $('.insert_area table tr');
	
	var blank_check;
	
			function insert() {
				
				blank_check = 0;
				var param_object = {};

				param_object.bat_kind = insert_row.find('input[name="bat_kind"]').val();
				param_object.user_id = "1";
				
				param_object.barcode = "1";
				
				param_object.rel_metro = insert_row.find('input[name="rel_metro"]').val();
				param_object.rel_area = insert_row.find('input[name="rel_area"]').val();
				param_object.rel_place = insert_row.find('input[name="rel_place"]').val();
				param_object.rel_dt = insert_row.find('input[name="rel_dt"]').val();
				
				param_object.ent_metro = insert_row.find('input[name="ent_metro"]').val();
				param_object.ent_area = insert_row.find('input[name="ent_area"]').val();
				param_object.ent_place = insert_row.find('input[name="ent_place"]').val();
				param_object.ent_dt = insert_row.find('input[name="ent_dt"]').val();
				
				param_object.V = insert_row.find('input[name="V"]').val();
				param_object.A = insert_row.find('input[name="A"]').val();
				param_object.SOC = insert_row.find('input[name="SOC"]').val();
				param_object.Kwh = insert_row.find('input[name="Kwh"]').val();
				param_object.car_type = insert_row.find('input[name="car_type"]').val();
				param_object.mileage = insert_row.find('input[name="mileage"]').val();
				
				param_list.push(param_object);
				
				if (insert_row.find('input[name="bat_kind"]').val() == "" ||
						insert_row.find('input[name="rel_metro"]').val() == "" || insert_row.find('input[name="rel_area"]').val() == "" || 
						insert_row.find('input[name="rel_place"]').val() == "" || insert_row.find('input[name="rel_dt"]').val() == "" || 
						insert_row.find('input[name="ent_metro"]').val() == "" || insert_row.find('input[name="ent_area"]').val() == "" || 
						insert_row.find('input[name="ent_place"]').val() == "" || insert_row.find('input[name="ent_dt"]').val() == "" || 
						insert_row.find('input[name="V"]').val() == "" || insert_row.find('input[name="A"]').val() == "" || 
						insert_row.find('input[name="SOC"]').val() == "" || insert_row.find('input[name="Kwh"]').val() == "" || 
						insert_row.find('input[name="car_type"]').val() == "" || insert_row.find('input[name="mileage"]').val() == "") {
					
					blank_check = 1;
					
					return blank_check;
				};
			};
			
			insert();
	if (blank_check == 1 || param_list=="") {
		alert("항목을 모두 입력해주세요.");
	} else if (blank_check != 1) {
	jQuery.ajaxSettings.traditional = true;

	$.ajax({
		url : "/pkg_history/Insert",
		type : "POST",
		dataType : 'text',
		contentType : "application/json",
		data : JSON.stringify(param_list), // Array를 JSON string형태로 변환
		success : function(data) {
			window.location.reload();
		}, error:function(request,status,error){
		    /*alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);*/
		}
	});
	}
}

function form_update() {


	var param_list = [];

	var update_row = $('#history .content_area tr');
	
			function update() {
				var param_object = {};
				
					param_object.bat_kind = update_row.find('input[name="bat_kind"]').val();
					param_object.user_id = "1";
					
					param_object.barcode = update_row.find('input[name="BARCODE_INFO_Barcode"]').val();
					
					param_object.rel_metro = update_row.find('input[name="rel_metro"]').val();
					param_object.rel_area = update_row.find('input[name="rel_area"]').val();
					param_object.rel_place = update_row.find('input[name="rel_place"]').val();
					param_object.rel_dt = update_row.find('input[name="rel_dt"]').val();
					
					param_object.ent_metro = update_row.find('input[name="ent_metro"]').val();
					param_object.ent_area = update_row.find('input[name="ent_area"]').val();
					param_object.ent_place = update_row.find('input[name="ent_place"]').val();
					param_object.ent_dt = update_row.find('input[name="ent_dt"]').val();
					
					param_object.V = update_row.find('input[name="V"]').val();
					param_object.A = update_row.find('input[name="A"]').val();
					param_object.SOC = update_row.find('input[name="SOC"]').val();
					param_object.Kwh = update_row.find('input[name="Kwh"]').val();
					param_object.car_type = update_row.find('input[name="car_type"]').val();
					param_object.mileage = update_row.find('input[name="mileage"]').val();
					
					param_list.push(param_object);
				}
			
			update();
			
	jQuery.ajaxSettings.traditional = true;

	$.ajax({
		url : "/pkg_history/Insert",
		type : "POST",
		dataType : 'text',
		contentType : "application/json",
		data : JSON.stringify(param_list), // Array를 JSON string형태로 변환
		success : function(data) {
			window.location.reload();
		}, error:function(request,status,error){
		    /*alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);*/
		}
	});
}

function search_submit() {
	var search_barcode = $(".search_form_barcode").val();
	
	if (search_barcode == "") {
	 alert("검색어를 입력하세요.");
	} else {
    /*기간별 배터리 입/출고 이력*/
    $.ajax({
		url : "/pkg_history/history_search",
		type : "POST",
		dataType : 'html', 
		data : {
			"search_barcode" : search_barcode
		},
		success : function(data) {
			
			$('.insert_area').empty();
			$('.content_area').empty();
			
			$('.content_area').append(data);
		},
		error:function(request,status,error){
			// 실패 시 처리
			/*alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); */
		}
	});
	}
}

function form_reset() {
	$('.insert_area').find('table tr input').val('');
}