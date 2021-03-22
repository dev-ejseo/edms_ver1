function table_size() {
	var th_checkRow, th_seq, th_company_name, th_user_id, th_user_pwd, th_user_name, th_user_admin, th_user_tel, th_use_yn, th_red_dt, th_end_dt;
	
	th_checkRow = $('#user_table').find('.th_checkRow');
	th_seq = $('#user_table').find('.th_seq');
	th_company_name = $('#user_table').find('.th_company_name');
	th_user_id = $('#user_table').find('.th_user_id');
	th_user_pwd = $('#user_table').find('.th_user_pwd');
	th_user_name = $('#user_table').find('.th_user_name');
	th_user_admin = $('#user_table').find('.th_user_admin');
	th_user_tel = $('#user_table').find('.th_user_tel');
	th_use_yn = $('#user_table').find('.th_use_yn');
	th_red_dt = $('#user_table').find('.th_red_dt');
	th_end_dt = $('#user_table').find('.th_end_dt');
	
	
	var td_checkRow, td_seq, td_company_name, td_user_id, td_user_pwd, td_user_name, td_user_admin, td_user_tel, td_use_yn, td_red_dt, td_end_dt;
	
	td_checkRow = $('#user_table').find('.td_checkRow').css("width");
	td_seq = $('#user_table').find('.td_seq').css("width");
	td_company_name = $('#user_table').find('.td_company_name').css("width");
	td_user_id = $('#user_table').find('.td_user_id').css("width");
	td_user_pwd = $('#user_table').find('.td_user_pwd').css("width");
	td_user_name = $('#user_table').find('.td_user_name').css("width");
	td_user_admin = $('#user_table').find('.td_user_admin').css("width");
	td_user_tel = $('#user_table').find('.td_user_tel').css("width");
	td_use_yn = $('#user_table').find('.td_use_yn').css("width");
	td_red_dt = $('#user_table').find('.td_red_dt').css("width");
	td_end_dt = $('#user_table').find('.td_end_dt').css("width");
	
	
	th_checkRow.css("width", td_checkRow);
	th_seq.css("width", td_seq);
	th_company_name.css("width", td_company_name);
	th_user_id.css("width", td_user_id);
	th_user_pwd.css("width", td_user_pwd);
	th_user_name.css("width", td_user_name);
	th_user_admin.css("width", td_user_admin);
	th_user_tel.css("width", td_user_tel);
	th_use_yn.css("width", td_use_yn);
	th_red_dt.css("width", td_red_dt);
	th_end_dt.css("width", td_end_dt);
};

$(document).ready(function() {
	table_size();
	
	empty_table_size();
});

$(window).resize(function (){
	table_size();
	
	empty_table_size();
});

function empty_table_size() {
	if($('#user_table').find('tr.table_row').length == 0){
		$('#user_table').find('thead').css("position", "relative");
		$('#insert_tbody').find('tr.margin_tr').css("display", "none");
	}
}

function downloadExcel() {
	$("#user_table").table2excel({
		exclude : ".noExl",
		name : "user",
		filename : "user" + '.xls',
		fileext : ".xls",
		exclude_img : true,
		exclude_links : true,
		exclude_inputs : true
	});
}

/* 체크박스 변경시 data-check 값 변경 jquery  */
$('#user_table tbody').on('change', 'input[type="checkbox"]', function(event) {

	var $trEle = $(this).parentsUntil('tr').parent();

	var hasChecked = $(this).is(':checked');

	if (hasChecked == true) {

		$trEle.attr('data-check', '1');
		$trEle.addClass("selected");
		$trEle.attr('remove-check', '1');
		

	} else if (hasChecked == false) {

		$trEle.attr('data-check', '0');
		$trEle.removeClass("selected");
		$trEle.attr('remove-check', '0');
	}
});

// checkAll
function checkAll(event) {

	var hasChecked = $("#user_table thead input").is(":checked");

	var $trEle = $("#user_table tbody tr input[type='checkbox']");
	var $tr = $("#user_table tbody tr");

	if (hasChecked == true) {

		$(this).prop('checked', true);

		$tr.attr('data-check', '1');
		$tr.addClass("selected");
		$tr.attr('remove-check', '1');
		$trEle.prop('checked', true);

	} else if (hasChecked == false) {

		$(this).prop('checked', false);

		$tr.attr('data-check', '0');
		$tr.removeClass("selected");
		$tr.attr('remove-check', '0');
		$trEle.prop('checked', false);
	}
}

function moreData() {

	var rows = document.querySelectorAll('#user_table tbody tr');

	$.ajax({
		url : "/pkg_user/MoreData.do",
		type : "POST",
		dataType : 'html',
		data : {
			"rowLength" : rows[rows.length - 1].dataset.seq_count
		},
		success : function(moreData) {
			if (moreData != 0) {
				$('#user_table').append(moreData);
				
				table_size();
			} else {
				alert("데이터가 존재하지 않습니다.");
			}
		}
	});
}

function moreDataEnd() {

	var rows = document.querySelectorAll('#user_table tbody tr');

	$.ajax({
		url : "/pkg_user/MoreDataEnd.do",
		type : "POST",
		dataType : 'html',
		data : {
			"rowLength" : rows[rows.length - 1].dataset.seq_count
		},
		success : function(moreData) {
			if (moreData != 0) {
				$('#user_table').append(moreData);
				
				table_size();

			} else {
				alert("데이터가 존재하지 않습니다.");
			}
		}
	});
}

function insert_form() {

	var insert_area = $('#user_table tbody#insert_tbody');
	var insert_row = "";

	insert_row += '<tr class="insert_row" data-check="0">';
	insert_row += '<td style="width: 47px" class="center_td"><input type="checkbox" id="check" class="checkRow" name="checkRow"></td>';
	insert_row += '<td style="width: 78px"></td>';
	insert_row += '<td style="width: 124px"><input name="company_name" /></td>';
	insert_row += '<td style="width: 155px"><input name="user_id"/></td>';
	insert_row += '<td style="width: 154px"><input name="user_pwd"/></td>';
	insert_row += '<td style="width: 123px"><input name="user_name"/></td>';
	insert_row += '<td style="width: 107px"><select name="user_admin"><option value="Y" class="selected">Y</option><option value="N">N</option></select></td>';
	insert_row += '<td style="width: 184px"><input name="user_tel"/></td>';
	insert_row += '<td style="width: 107px"><select name="use_yn"><option value="Y" class="selected">Y</option><option value="N">N</option></select></td>';
	insert_row += '<td style="width: 231px"><input name="red_dt" type="datetime" readonly /></td>';
	insert_row += '<td style="width: 231px"><input name="end_dt" type="datetime" readonly /></td>';
	insert_row += '</tr>';

	insert_area.append(insert_row);
	
	table_size();
}

$(".row_add .fa-minus-circle").on("click", function(event) {
	
		var all_row = $('#user_table tbody tr.insert_row');
		
		$(".insert_row").each(function(i) {
			if(all_row.eq(i).attr('data-check') == '1') {
				all_row.eq(i).remove();
			}
		});
	})


/*input 값을 수정한 테이블만 체크 -> save*/
$("#user_table tbody tr td input").on("propertychange change keyup paste input", function() {
    var current_row = $(this).parents('tr');
    
    current_row.attr('data-check', '1');
});

/*선택된 값에 selected 클래스 추가*/
$("#user_table .table_row select").change(function() {
    var current_row = $(this).find('option').removeClass('selected');
    
    var select_option = $("#user_table .table_row select option:selected");
    
    select_option.addClass('selected');
    
    var current_row = $(this).parents('tr');
    
    current_row.attr('data-check', '1');
});

/*input 값을 수정한 테이블만 체크 -> save*/
$(document).on("change", "#user_table .insert_row select", function() {
	
    var current_row = $(this).find('option').removeClass('selected');
    
    var select_option = $("#user_table .insert_row select option:selected");
    
    select_option.addClass('selected');
});

function form_save() {

	/* $(".resendChk:checed").each(function(i) {} */

	var param_list = [];

	var insert_row = $('#user_table tr.insert_row');
	var update_row = $('#user_table tr.table_row');

	$(".table_row").each(
			function(i) {
				
				var param_object = {};
				
				if (update_row.eq(i).attr('data-check') == '1') {
					
					param_object.user_id = update_row.eq(i).find('input[name="user_id1"]').val();
					param_object.user_pwd = update_row.eq(i).find('input[name="user_pwd"]').val();
					param_object.user_name = update_row.eq(i).find('input[name="user_name"]').val();
					param_object.company_name = update_row.eq(i).find('input[name="company_name"]').val();
					param_object.user_admin = update_row.eq(i).find('select[name="user_admin"]').find('option[class="selected"]').val();
					param_object.user_tel = update_row.eq(i).find('input[name="user_tel"]').val();
					param_object.use_yn = update_row.eq(i).find('select[name="use_yn"]').find('option[class="selected"]').val();
					
					param_list.push(param_object);
				}
			});
	
	var blank_check;
	
	$(".insert_row").each(
			function(i) {
				
				blank_check = "";
				
				var param_object = {};

				param_object.user_id = insert_row.eq(i).find('input[name="user_id"]').val();
				param_object.user_pwd = insert_row.eq(i).find('input[name="user_pwd"]').val();
				param_object.user_name = insert_row.eq(i).find('input[name="user_name"]').val();
				param_object.company_name = insert_row.eq(i).find('input[name="company_name"]').val();
				param_object.user_admin = insert_row.eq(i).find('select[name="user_admin"]').find('option[class="selected"]').val();
				param_object.user_tel = insert_row.eq(i).find('input[name="user_tel"]').val();
				param_object.use_yn = insert_row.eq(i).find('select[name="use_yn"]').find('option[class="selected"]').val();
				
				param_list.push(param_object);
								
				if (insert_row.eq(i).find('input[name="user_id"]').val() == "" || insert_row.eq(i).find('input[name="user_pwd"]').val() == "" || 
						insert_row.eq(i).find('input[name="user_name"]').val() == "" || insert_row.eq(i).find('input[name="company_name"]').val() == "" || 
						insert_row.eq(i).find('input[name="user_tel"]').val() == "") {
					
					blank_check = 1;
					
					return blank_check;
				};
			});
	
	if (blank_check == 1 || param_list=="") {
		alert("항목을 모두 입력해주세요.");
	} else if (blank_check != 1) {
		jQuery.ajaxSettings.traditional = true;

		$.ajax({
			url : "/pkg_user/Insert",
			type : "POST",
			dataType : 'text',
			contentType : "application/json",
			data : JSON.stringify(param_list), // Array를 JSON string형태로 변환
			success : function() {
				window.location.reload();
			}, error:function(request,status,error){
			}

		});
	}
}

function form_delete() {
	
	var id_array = [];
	var tbody_tr = $("#user_table tbody tr");
	tbody_tr.each(function(i) {
		if (tbody_tr.eq(i).attr('remove-check') == '1') {

			var check_id = tbody_tr.eq(i).find('input[name="user_id1"]').val();

			id_array.push(check_id);
		}
	})
	
	/*console.log(JSON.stringify(id_array));*/
	
	$.ajax({
		url : "/pkg_user/Delete",
		type : "POST",
		dataType : 'html',
		contentType : "application/json",
		traditional : true, 
		data : JSON.stringify(id_array), 
		success : function() {
			window.location.reload();
		}, error:function(request,status,error){
		   /* alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);*/
		}
	});
}

// input box 활성화, 비활성화
$('.search_form_user').on('click',function(event) {
	$('.search_form_company').val('');
});

$('.search_form_company').on('click',function(event) {
	$('.search_form_user').val('');
});