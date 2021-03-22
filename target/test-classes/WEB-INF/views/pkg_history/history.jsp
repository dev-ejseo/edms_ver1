<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%
	String user_id = (String) session.getAttribute("user_admin");
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

<link href="/resources/css/pkg_history/history.css" rel="stylesheet">
<%@ include file="/WEB-INF/views/include/link.jsp"%>
</head>

<body id="history">
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<div class="body_width">
		<div class="content_width">
			<div class="search_area">
					<div class="search_barcode">
						<label>바코드</label> 
						<input name="keyword" class="search_form_barcode"  onkeypress="if(event.keyCode == 13){search_submit();}"
						value="${keyword}" autocomplete=off autofocus>
						
					</div>
					
					<div class="submit_button">
						<button onclick="search_submit()"></button>
					</div>
			</div>
			<div class="content_area">
			<div class="insert_area">
			<table>
				<tr>
					<td class="td_seq"><label>순번</label><input name="seq" readonly /></td>
					<td class="td_bat_kind"><label>배터리 종류</label><input name="bat_kind" /></td>
					<td class="td_batt_use"><label>용도</label><input name="batt_use" placeholder="EVESS" readonly /></td>
					<td class="td_user_id"><label>담당자</label><input name="USER_INFO_user_id" readonly /></td>
				</tr>
				<tr>
					<td class="td_final_dt"><label>최종수정일자</label><input name="final_dt" type="datetime" readonly /></td>
					<td class="td_barcode"><label>Barcode</label><input name="BARCODE_INFO_Barcode" readonly /></td>
				</tr>
				<tr>
					<td class="td_rel_location">
						<label>출고지역</label>
						<input name="rel_metro" placeholder="시/도" style="width: 39%; margin-right: 2%;" />
						<input name="rel_area" placeholder="시/군/구" style="width: 39%;" />
					</td>
					<td class="td_rel_place"><label>출고처</label><input name="rel_place" /></td>
					<td class="td_rel_dt"><label>출고일</label><input name="rel_dt" placeholder="yyyy-mm-dd" type="datetime" /></td>
				</tr>
				<tr>
					<td class="td_ent_location">
						<label>입고지역</label>
						<input name="ent_metro" placeholder="시/도" style="width: 39%; margin-right: 2%;" />
						<input name="ent_area" placeholder="시/군/구" style="width: 39%;" />
					</td>
					<td class="td_ent_place"><label>입고처</label><input name="ent_place" /></td>
					<td class="td_ent_dt"><label>입고일</label><input name="ent_dt" placeholder="yyyy-mm-dd" type="datetime" /></td>
				</tr>
				<tr>
					<td class="td_V"><label>전압</label><input name="V" /></td>
					<td class="td_A"><label>전류</label><input name="A" /></td>
					<td class="td_SOC"><label>잔량</label><input name="SOC" /></td>
				</tr>
				<tr>
					<td class="td_Kwh"><label>용량</label><input name="Kwh" /></td>
					<td class="td_car_type"><label>차종</label><input name="car_type" /></td>
					<td class="td_mileage"><label>주행거리</label><input name="mileage" /></td>
				</tr>
				</table>
				<div class="table_footer">
					<div class="db_save">
						<div class="db_save_button" onclick="form_save()">저장</div>
					</div>
					<div class="form_reset">
						<div class="form_reset_button" onclick="form_reset()">취소</div>
					</div>
				</div>
			</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript"
	src="/resources/js/pkg_history/history.js"></script>
</html>
