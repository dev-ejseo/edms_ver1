 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<table>
	<c:forEach var="row" items="${listHistory}" varStatus="index">
				<tr>
					<td class="td_seq"><label>순번</label><input name="seq" value="${row.seq}" readonly /></td>
					<td class="td_bat_kind"><label>배터리 종류</label><input name="bat_kind" value="${row.bat_kind}"/></td>
					<td class="td_batt_use"><label>용도</label><input name="batt_use" placeholder="EVESS" value="${row.batt_use}" readonly /></td>
					<td class="td_user_id"><label>담당자</label><input name="USER_INFO_user_id" value="${row.USER_INFO_user_id}" readonly /></td>
				</tr>
				<tr>
					<td class="td_final_dt"><label>최종수정일자</label><input name="final_dt" type="datetime" value="${row.final_dt}" readonly /></td>
					<td class="td_barcode"><label>Barcode</label><input name="BARCODE_INFO_Barcode" value="${row.BARCODE_INFO_Barcode}" readonly /></td>
				</tr>
				<tr>
					<td class="td_rel_location">
						<label>출고지역</label>
						<input name="rel_metro" style="width: 39%; margin-right: 2%;" value="${row.rel_metro}" />
						<input name="rel_area" style="width: 39%;" value="${row.rel_area}" />
					</td>
					<td class="td_rel_place"><label>출고처</label><input name="rel_place" value="${row.rel_place}" /></td>
					<td class="td_rel_dt"><label>출고일</label><input name="rel_dt" type="datetime" value="${row.rel_dt}" /></td>
				</tr>
				<tr>
					<td class="td_ent_location">
						<label>입고지역</label>
						<input name="ent_metro" style="width: 39%; margin-right: 2%;" value="${row.ent_metro}" />
						<input name="ent_area" style="width: 39%;" value="${row.ent_area}" />
					</td>
					<td class="td_ent_place"><label>입고처</label><input name="ent_place" value="${row.ent_place}" /></td>
					<td class="td_ent_dt"><label>입고일</label><input name="ent_dt" type="datetime" value="${row.ent_dt}" /></td>
				</tr>
				<tr>
					<td class="td_V"><label>전압</label><input name="V" value="${row.V}" /></td>
					<td class="td_A"><label>전류</label><input name="A" value="${row.A}" /></td>
					<td class="td_SOC"><label>잔량</label><input name="SOC" value="${row.SOC}" /></td>
				</tr>
				<tr>
					<td class="td_Kwh"><label>용량</label><input name="Kwh" value="${row.Kwh}" /></td>
					<td class="td_car_type"><label>차종</label><input name="car_type" value="${row.car_type}" /></td>
					<td class="td_mileage"><label>주행거리</label><input name="mileage" value="${row.mileage}" /></td>
				</tr>
				</c:forEach>
				</table>
				<div class="table_footer">
					<div class="db_update">
						<div class="db_save_button" onclick="form_update()">수정</div>
					</div>
				</div>
<script>

	/*input 값을 수정한 테이블만 체크 -> save*/
	$("#history_table tbody:last tr input").on(
			"propertychange change keyup paste input", function(event) {

				var current_row = $(this).parents('tr');

				/* console.log($(this)); */
				/* console.log("22"); */

				current_row.attr('data-check', '1');
			});



	/* input 박스 체크 시 표시 */
	$('#history_table tbody:last').on('change', 'input[type="checkbox"]',
			function(event) {

				console.log("클릭");
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
</script>