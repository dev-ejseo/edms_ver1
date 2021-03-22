<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<tbody>
	<c:choose>
		<c:when test="${fn:length(listBarcode) gt 0 }">
			<c:forEach var="row" items="${listBarcode}" varStatus="index">
				<tr data-check="0" data-seq_count="${rowLength + index.count}">
					<td class="center_td td_checkRow" style="width: 3%">
									   <input type="radio" id="check" class="checkRow" name="checkRow"></td>
									<td class="center_td td_seq" style="width: 6%"><b>${row.seq}</b></td>
									<td class="td_barcode" style="width: 16%">${row.BARCODE_INFO_Barcode}</td>
									<td class="center_td td_user_id" style="width: 7%">${row.USER_INFO_user_id}</td>
									<td class="center_td td_v" style="width: 7%">${row.V}</td>
									<td class="center_td td_a" style="width: 7%">${row.A}</td>
									<td class="center_td td_soc" style="width: 7%">${row.SOC}</td>
									<td class="center_td td_kwh" style="width: 7%">${row.Kwh}</td>
									<td class="td_barcode_path" id="barcode_path" style="width: 20%">${row.barcode_local}</td>
									<td class="td_final_dt" style="width: 20%">${row.final_dt}</td>
				</tr>
			</c:forEach>
		</c:when>
		<c:otherwise>${fn:length(listBarcode)}</c:otherwise>
	</c:choose>
</tbody>
