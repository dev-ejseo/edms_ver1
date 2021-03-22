<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<tbody>
	<c:choose>
		<c:when test="${fn:length(listHistory) gt 0 }">
			<c:forEach var="row" items="${listHistory}" varStatus="index">
				<tr class="table_row" data-check="0"
					data-seq_count="${rowLength + index.count}">
					<td class="center_td td_seq" style="width: 2.5%"><b>${row.seq}</b></td>
									<td class="center_td td_bat_kind" style="width: 5.5%">${row.bat_kind}</td>
									<td class="center_td td_batt_use" style="width: 4%">${row.batt_use}</td>
									<td class="input_half td_rel_location" style="width: 9%">${row.rel_metro} ${row.rel_area}</td>
									<td class="td_rel_place" style="width: 5%">${row.rel_place}</td>
									<td class="td_rel_dt" style="width: 6%">${row.rel_dt}</td>
									<td class="input_half td_ent_location" style="width: 9%">${row.ent_metro} ${row.ent_area}</td>
									<td class="td_ent_place" style="width: 5%">${row.ent_place}</td>
									<td class="td_ent_dt" style="width: 6%">${row.ent_dt}</td>
									<td class="center_td td_user_id" style="width: 4%">${row.user_id}</td>
									<td class="center_td td_v" style="width: 4%">${row.V}</td>
									<td class="center_td td_a" style="width: 4%">${row.A}</td>
									<td class="center_td td_soc" style="width: 4%">${row.SOC}</td>
									<td class="center_td td_kwh" style="width: 4%">${row.Kwh}</td>
									<td class="center_td td_car_type" style="width: 4%">${row.car_type}</td>
									<td class="center_td td_mileage" style="width: 4%">${row.mileage}</td>
									<td class="td_final_dt" style="width: 12%">${row.final_dt}</td>
									<td class="td_barcode" id="barcode" style="mso-number-format : '\@'; width: 9%;">${row.BARCODE_INFO_Barcode}</td> 
				</tr>
			</c:forEach>
		</c:when>
		<c:otherwise>${fn:length(listHistory)}</c:otherwise>
	</c:choose>
</tbody>
<script>
</script>
