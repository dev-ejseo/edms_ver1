<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(listUser) gt 0 }">
				<c:forEach var="row" items="${listUser}" varStatus="index">
					<tr class="table_row" data-check="0" data-seq_count="${rowLength + index.count}">
						<td class="center_td td_checkRow" style="width: 3%"><input type="checkbox" id="check" class="checkRow" name="checkRow"></td>
									<td class="center_td td_seq" style="width: 5%"><b>${row.seq}</b></td>
									<td class="td_company_name" style="width: 10%"><input name="company_name" type="text" placeholder="${row.company_name}" value="${row.company_name}"/></td>
									<td class="center_td td_user_id" style="width: 9%"><input name="user_id1" type="text" placeholder="${row.user_id}" value="${row.user_id}" readonly/></td>
									<td class="center_td td_user_pwd" style="width: 10%"><input name="user_pwd" type="text" placeholder="${row.user_pwd}" value="${row.user_pwd}"/></td>
									<td class="center_td td_user_name" style="width: 9%"><input name="user_name" type="text" placeholder="${row.user_name}" value="${row.user_name}"/></td>
									<td class="center_td td_user_admin" style="width: 7%"><input type="hidden"  value="${row.user_admin}"/>
										<select name="user_admin">
										  <option value="${row.user_admin}" class="selected">${row.user_admin}</option>
										   <option value="Y">Y</option>
										   <option value="N">N</option>
										</select>
									</td>
									<td class="td_user_tel" style="width: 10%"><input name="user_tel" type="text" value="${row.user_tel}"/></td>
									<td class="center_td td_use_yn" style="width: 7%">
									<input type="hidden"  value="${row.use_yn}"/>
										<select name="use_yn">
										  <option value="${row.use_yn}" class="selected">${row.use_yn}</option>
										   <option value="Y">Y</option>
										   <option value="N">N</option>
										</select>
									</td>
									<td class="td_red_dt" style="width: 15%"><input name="red_dt" type="datetime" placeholder="${row.red_dt}" value="${row.red_dt}" readonly/></td>
									<td class="td_end_dt" style="width: 15%"><input name="end_dt" type="datetime" placeholder="${row.end_dt}" value="${row.end_dt}" readonly/></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>${fn:length(listUser)}</c:otherwise>
		</c:choose>
	</tbody>
<script>
/*input 값을 수정한 테이블만 체크 -> save*/
$("#user_table tbody:last tr td input").on("propertychange change keyup paste input", function() {
    var current_row = $(this).parents('tr');
    
    current_row.attr('data-check', '1');
});

$(".row_add .fa-minus-circle").on("click", function(event) {
	console.log("delete!");
		
		var all_row = $('#user_table tbody:last tr.insert_row');
		
		$(".insert_row").each(function(i) {
			if(all_row.eq(i).attr('data-check') == '1') {
				all_row.eq(i).remove();
			}
		});
	})
	
/* input 박스 체크 시 표시 */
$('#user_table tbody:last').on('change', 'input[type="checkbox"]', function(event) {
	
	/* console.log("클릭"); */
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

/*선택된 값에 selected 클래스 추가*/
$("#user_table tbody:last .table_row select").change(function() {
    var current_row = $(this).find('option').removeClass('selected');
    
    var select_option = $("#user_table tbody:last .table_row select option:selected");
    
    select_option.addClass('selected');
    var current_row = $(this).parents('tr');
    
    current_row.attr('data-check', '1');
});
</script>