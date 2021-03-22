<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<% 
String user_id = (String)session.getAttribute("user_admin"); 
%>

<!DOCTYPE html>
<html>
<head>
<meta
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"
	name="viewport">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>EDMS</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="/resources/css/pkg_history_log/history_log.css" rel="stylesheet">
<%@ include file="/WEB-INF/views/include/link.jsp"%>
</head>

<body id="history_log">
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<div class="body_width">
		<div class="content_width">
			<div class="search_area">
				<!-- 검색 영역 -->
				<form name="form" method="post" action="${path}/pkg_history_log/history_log">
					<div class="search_barcode">
						<label>바코드</label> 
						<input name="keyword" class="search_form_barcode" value="${keyword}" autocomplete=off autofocus>
					</div>

					<div class="submit_button">
						<button type="submit"></button>
					</div>
				</form>
			</div>
			<div class="table_area">
				<!-- 테이블 영역 -->
				<div class="table_title">
					<!-- 테이블 상위 타이틀 -->
					<div class="count">
						히스토리 : <b>${listCount}건</b>
					</div>
				</div>
				<div class="table_body">
					<table id="history_log_table">
						<thead>
							<tr>
								<th class="th_seq">순번</th>
								<th class="th_bat_kind">종류</th>
								<th class="th_batt_use">용도</th>
								<th class="th_rel_location">출고지역</th>
								<th class="th_rel_place">출고처</th>
								<th class="th_rel_dt">출고일</th>
								<th class="th_ent_location">입고지역</th>
								<th class="th_ent_place">입고처</th>
								<th class="th_ent_dt">입고일</th>
								<th class="th_user_id">담당자</th>
								<th class="th_v">전압</th>
								<th class="th_a">전류</th>
								<th class="th_soc">잔량</th>
								<th class="th_kwh">용량</th>
								<th class="th_car_type">차종</th>
								<th class="th_mileage">주행거리</th>
								<th class="th_final_dt">최종수정일자</th>
								<th class="th_barcode">Barcode</th>
							</tr>
						</thead>
						<tbody id="tbody">
						<tr class="margin_tr" style="height: 32px;"></tr>
							<c:forEach var="row" items="${listHistory}" varStatus="index">
								<tr class="table_row" data-check="0" data-seq_count="${index.count}">
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
						</tbody>
					</table>
				</div>
				<div class="table_footer">
					<!-- 테이블 아래 버튼 영역 -->
					<div class="paging_button">
						<div class="paging_more_data_button" onclick="moreData()">
							<i class="fa fa-angle-right" aria-hidden="true"
								style="line-height: 1.3;"></i>
						</div>
						<div class="paging_more_data_end_button" onclick="moreDataEnd()">
							<i class="fa fa-angle-double-right" aria-hidden="true"
								style="line-height: 1.3;"></i>
						</div>
					</div>
					<div class="excel_save">
						<div class="exel_save_button" onclick="downloadExcel()">내려받기</div>
<!-- 						<div class="exel_save_button">내려받기</div> -->
						<iframe id="txtArea1" style="display: none"></iframe>
						
						<!-- excel 저장 라이브러리가 it에서 호환되기 위한 iframe -->
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="/resources/js/pkg_history_log/history_log.js"></script>
</html>
