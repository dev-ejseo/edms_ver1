<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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

<link href="/resources/css/pkg_barcode/barcode.css" rel="stylesheet">
<%@ include file="/WEB-INF/views/include/link.jsp"%>

</head>

<body id="barcode">
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<div class="body_width">
		<div class="content_width">
			<div class="search_area">
				<!-- 검색 영역 -->
				<form name="form" method="post" action="${path}/pkg_barcode/barcode">
					<div class="search_user">
						<label>담당자</label> 
						<input name="keyword1" class="search_form_user" value="${keyword}" autocomplete=off>
					</div>

					<div class="search_barcode">
						<label>바코드</label> <input name="keyword2"
							class="search_form_barcode" value="${keyword}" autocomplete=off autofocus >
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
						바코드 관리 : <b>${listCount}건</b>
					</div>
				</div>
				<div class="table_body">
					<table id="barcode_table">
						<thead>
							<tr>
								<th class="th_checkRow" style="width: 3%"></th>
								<th class="th_seq" style="width: 6%">순번</th>
								<th class="th_barcode" style="width: 16%">Barcode</th>
								<th class="th_user_id" style="width: 7%">담당자</th>
								<th class="th_v" style="width: 7%">전압</th>
								<th class="th_a" style="width: 7%">전류</th>
								<th class="th_soc" style="width: 7%">잔량</th>
								<th class="th_kwh" style="width: 7%">용량</th>
								<th class="th_barcode_path" style="width: 20%">경로</th>
								<th class="th_final_dt" style="width: 20%">최종수정일자</th>
							</tr>
							
						</thead>
						<tbody id="insert_tbody">
						<!-- <tr style="height: 32px;"></tr> -->
						</tbody>
						<tbody class="content_tbody">
							<c:forEach var="row" items="${listBarcode}" varStatus="index">
								<tr data-check="0" data-seq_count="${index.count}">
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
					<div class="table_print">
						<div class="print_button" onclick="barcodePrint()">인쇄</div>
					</div>
					<div class="excel_save">
						<div class="exel_save_button" onclick="downloadExcel()">내려받기</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript"
	src="/resources/js/pkg_barcode/barcode.js"></script>
</html>
