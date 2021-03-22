function table_size() {
	var th_seq, th_bat_kind, th_batt_use, th_rel_location, th_rel_place, th_rel_dt, th_ent_location, th_ent_place, th_ent_dt, 
	th_user_id, th_v, th_a, th_soc, th_kwh, th_car_type, th_mileage, th_final_dt, th_barcode;
	
	th_seq = $('#history_log_table').find('.th_seq');
	th_bat_kind = $('#history_log_table').find('.th_bat_kind');
	th_batt_use = $('#history_log_table').find('.th_batt_use');
	th_rel_location = $('#history_log_table').find('.th_rel_location');
	th_rel_place = $('#history_log_table').find('.th_rel_place');
	th_rel_dt = $('#history_log_table').find('.th_rel_dt');
	th_ent_location = $('#history_log_table').find('.th_ent_location');
	th_ent_place = $('#history_log_table').find('.th_ent_place');
	th_ent_dt = $('#history_log_table').find('.th_ent_dt');
	th_user_id = $('#history_log_table').find('.th_user_id');
	th_v = $('#history_log_table').find('.th_v');
	th_a = $('#history_log_table').find('.th_a');
	th_soc = $('#history_log_table').find('.th_soc');
	th_kwh = $('#history_log_table').find('.th_kwh');
	th_car_type = $('#history_log_table').find('.th_car_type');
	th_mileage = $('#history_log_table').find('.th_mileage');
	th_final_dt = $('#history_log_table').find('.th_final_dt');
	th_barcode = $('#history_log_table').find('.th_barcode');
	
	var td_seq, td_bat_kind, td_batt_use, td_rel_location, td_rel_place, td_rel_dt, td_ent_location, td_ent_place, td_ent_dt, 
	td_user_id, td_v, td_a, td_soc, td_kwh, td_car_type, td_mileage, td_final_dt, td_barcode;
	
	td_seq = $('#history_log_table .table_row').find('.td_seq').css("width");
	td_bat_kind = $('#history_log_table .table_row').find('.td_bat_kind').css("width");
	td_batt_use = $('#history_log_table .table_row').find('.td_batt_use').css("width");
	td_rel_location = $('#history_log_table .table_row').find('.td_rel_location').css("width");
	td_rel_place = $('#history_log_table .table_row').find('.td_rel_place').css("width");
	td_rel_dt = $('#history_log_table .table_row').find('.td_rel_dt').css("width");
	td_ent_location = $('#history_log_table .table_row').find('.td_ent_location').css("width");
	td_ent_place = $('#history_log_table .table_row').find('.td_ent_place').css("width");
	td_ent_dt = $('#history_log_table .table_row').find('.td_ent_dt').css("width");
	td_user_id = $('#history_log_table .table_row').find('.td_user_id').css("width");
	td_v = $('#history_log_table .table_row').find('.td_v').css("width");
	td_a = $('#history_log_table .table_row').find('.td_a').css("width");;
	td_soc = $('#history_log_table .table_row').find('.td_soc').css("width");
	td_kwh = $('#history_log_table .table_row').find('.td_kwh').css("width");
	td_car_type = $('#history_log_table .table_row').find('.td_car_type').css("width");
	td_mileage = $('#history_log_table .table_row').find('.td_mileage').css("width");
	td_final_dt = $('#history_log_table .table_row').find('.td_final_dt').css("width");
	td_barcode = $('#history_log_table .table_row').find('.td_barcode').css("width");
	
	th_seq.css("width", td_seq);
	th_bat_kind.css("width", td_bat_kind);
	th_batt_use.css("width", td_batt_use);
	th_rel_location.css("width", td_rel_location);
	th_rel_place.css("width", td_rel_place);
	th_rel_dt.css("width", td_rel_dt);
	th_ent_location.css("width", td_ent_location);
	th_ent_place.css("width", td_ent_place);
	th_ent_dt.css("width", td_ent_dt);
	th_user_id.css("width", td_user_id);
	th_v.css("width", td_v);
	th_a.css("width", td_a);
	th_soc.css("width", td_soc);
	th_kwh.css("width", td_kwh);
	th_car_type.css("width", td_car_type);
	th_mileage.css("width", td_mileage);
	th_final_dt.css("width", td_final_dt);
	th_barcode.css("width", td_barcode);
	
};

function empty_table_size() {
	if($('#tbody').find('tr.table_row').length == 0){
		$('#history_log_table').find('thead').css("position", "relative");
		$('#tbody').find('tr.margin_tr').css("display", "none");
	}
}

$(document).ready(function() {
	table_size();
	
	empty_table_size();
});

$(window).resize(function (){
	table_size();
	
	empty_table_size();
});

function downloadExcel() {
	$("#history_log_table").table2excel({
		exclude : ".noExl",
		name : "history_log",
		filename : "history_log" + '.xls',
		fileext : ".xls",
		exclude_img : true,
		exclude_links : true,
		exclude_inputs : true
	});
}

function moreData() {

	var rows = document.querySelectorAll('#history_log_table tbody tr');

	$.ajax({
		url : "/pkg_history_log/MoreData.do",
		type : "POST",
		dataType : 'html',
		data : {
			"rowLength" : rows[rows.length - 1].dataset.seq_count
		},
		success : function(moreData) {
			if (moreData != 0) {
				$('#history_log_table').append(moreData);
				
				table_size();
			} else {
				alert("데이터가 존재하지 않습니다.");
			}
		}
	});
}

function moreDataEnd() {
	
	var rows = document.querySelectorAll('#history_log_table tbody tr');

	$.ajax({
		url : "/pkg_history_log/MoreDataEnd.do",
		type : "POST",
		dataType : 'html',
		data : {
			"rowLength" : rows[rows.length - 1].dataset.seq_count
		},
		success : function(moreData) {
			if (moreData != 0) {
				$('#history_log_table').append(moreData);
				
				table_size();

			} else {
				alert("데이터가 존재하지 않습니다.");
			}
		}
	});
}

