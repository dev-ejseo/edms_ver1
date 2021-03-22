function table_size() {
	var th_checkRow, th_seq, th_barcode, th_user_id, th_v, th_a, th_soc, th_kwh, th_barcode_path, th_final_dt;
	
	th_checkRow = $('#barcode_table').find('.th_checkRow');
	th_seq = $('#barcode_table').find('.th_seq');
	th_barcode = $('#barcode_table').find('.th_barcode');
	th_user_id = $('#barcode_table').find('.th_user_id');
	th_v = $('#barcode_table').find('.th_v');
	th_a = $('#barcode_table').find('.th_a');
	th_soc = $('#barcode_table').find('.th_soc');
	th_kwh = $('#barcode_table').find('.th_kwh');
	th_barcode_path = $('#barcode_table').find('.th_barcode_path');
	th_final_dt = $('#barcode_table').find('.th_final_dt');
	
	
	var td_checkRow, td_seq, td_barcode, td_user_id, td_v, td_a, td_soc, td_kwh, td_barcode_path, td_final_dt;
	
	td_checkRow = $('#barcode_table').find('.td_checkRow').css("width");
	td_seq = $('#barcode_table').find('.td_seq').css("width");
	td_barcode = $('#barcode_table').find('.td_barcode').css("width");
	td_user_id = $('#barcode_table').find('.td_user_id').css("width");
	td_v = $('#barcode_table').find('.td_v').css("width");
	td_a = $('#barcode_table').find('.td_a').css("width");;
	td_soc = $('#barcode_table').find('.td_soc').css("width");
	td_kwh = $('#barcode_table').find('.td_kwh').css("width");
	td_barcode_path = $('#barcode_table').find('.td_barcode_path').css("width");
	td_final_dt = $('#barcode_table').find('.td_final_dt').css("width");
	
	
	th_checkRow.css("width", td_checkRow);
	th_seq.css("width", td_seq);
	th_barcode.css("width", td_barcode);
	th_user_id.css("width", td_user_id);
	th_v.css("width", td_v);
	th_a.css("width", td_a);
	th_soc.css("width", td_soc);
	th_kwh.css("width", td_kwh);
	th_barcode_path.css("width", td_barcode_path);
	th_final_dt.css("width", td_final_dt);
};

function empty_table_size() {
	if($('.content_tbody').find('tr').length == 0){
		$('#barcode_table').find('thead').css("position", "relative");
		$('#barcode_table').find('#insert_tbody').css("margin-top", 0);
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
	$("#barcode_table").table2excel({
		exclude : ".noExl",
		name : "barcode",
		filename : "barcode" + '.xls',
		fileext : ".xls",
		exclude_img : true,
		exclude_links : true,
		exclude_inputs : true
	})
}

/* 체크박스 변경시 data-check 값 변경 jquery */
$('#barcode_table').on('change', 'input[type="radio"]', function(event) {

	var $trEle = $(this).parentsUntil('tr').parent();
	var $tbodyEle = $(this).parentsUntil('tbody').parent();

	$tbodyEle.find('tr').removeClass("selected");

	var hasChecked = $(this).is(':checked');

	if (hasChecked) {

		$trEle.addClass("selected");

	}
});

function moreData() {

	var rows = document.querySelectorAll('#barcode_table tbody tr');

	$.ajax({
		url : "/pkg_barcode/MoreData.do",
		type : "POST",
		dataType : 'html',
		data : {
			"rowLength" : rows[rows.length - 1].dataset.seq_count
		},
		success : function(moreData) {
			if (moreData != 0) {
				$('#barcode_table').append(moreData);
				
				table_size();
			} else {
				alert("데이터가 존재하지 않습니다.");
			}
		}
	});
}

function moreDataEnd() {

	var rows = document.querySelectorAll('#barcode_table tbody tr');

	$.ajax({
		url : "/pkg_barcode/MoreDataEnd.do",
		type : "POST",
		dataType : 'html',
		data : {
			"rowLength" : rows[rows.length - 1].dataset.seq_count
		},
		success : function(moreData) {
			if (moreData != 0) {
				$('#barcode_table').append(moreData);
				
				table_size();

			} else {
				alert("데이터가 존재하지 않습니다.");
			}
		}
	});
}

function barcodePrint() {

	var select_row = $('tr[class="selected"]');
	var barcode_path = (select_row.find('#barcode_path').text()).replace(/C:/,"");

	var Conbarcode_path = select_row.find('#barcode_path').text();
	
	if(Conbarcode_path == "") {
		alert("출력할 바코드를 선택해주세요.");
	} else {
	$.ajax({
		url : "/pkg_barcode/barcode_print",
		type : "POST",
		dataType : 'html',
		data : {
			"filelocal" : Conbarcode_path
		}, success : function(result) {
			
			if(result == '출력 성공.') {
				
				var img = new Image();
				img.src = barcode_path;
				// 나중에 정리
				var img_width = 300;
				var win_width = 325;
				var height = 60;

				var pContent = "<img src='" + barcode_path + "'width='" + img_width + "'>"

				 openWindow = window.open('', '_blank', 'width='+win_width+',height='+height+', menubars=no, scrollbars=auto');
				 openWindow.document.write(pContent);
						
				 setTimeout(function() {
				     popup_print();
				 }, 1000);
				
			} else {
				
				alert(result);
			}
		}
	});
	}
}

function popup_print() {
	openWindow.print();
	
	openWindow.close();
}

// input box 활성화, 비활성화
$('.search_form_user').on('click', function(event) {
	$('.search_form_barcode').val('');
});

$('.search_form_barcode').on('click', function(event) {
	$('.search_form_user').val('');
});
