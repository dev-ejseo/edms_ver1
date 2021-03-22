<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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

<link href="/resources/css/pkg_user/user.css" rel="stylesheet">
<%@ include file="/WEB-INF/views/include/link.jsp"%>
</head>

<body id="user">
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<div class="body_width">
		<div class="content_width">
			<div class="search_area">
				<!-- 검색 영역 -->
				<form name="form" method="post" action="${path}/pkg_user/user">
					<div class="search_user">
						<label>아이디</label> 
						<input name="keyword1" class="search_form_user" value="${keyword}" autocomplete=off>
					</div>

					<div class="search_company">
						<label>소속</label> 
						<input name="keyword2" class="search_form_company" value="${keyword}" autocomplete=off>
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
						사용자 관리 : <b>${listCount}건</b>
					</div>
					<div class="row_add">
						<i class="fa fa-plus-circle" onclick="insert_form();"></i>
						<i class="fa fa-minus-circle"></i>
					</div>
				</div>
				<div class="table_body">
					<table id="user_table">
						<thead>
							<tr>
								<th class="th_checkRow"><input type="checkbox" onclick="checkAll()" /></th>
								<th class="th_seq">순번</th>
								<th class="th_company_name">소속</th>
								<th class="th_user_id">아이디</th>
								<th class="th_user_pwd">비밀번호</th>
								<th class="th_user_name">사용자 이름</th>
								<th class="th_user_admin">권한</th>
								<th class="th_user_tel">연락처</th>
								<th class="th_use_yn">사용 여부</th>
								<th class="th_red_dt">등록 일자</th>
								<th class="th_end_dt">해지 일자</th>
							</tr>
						</thead>
						<tbody id="insert_tbody">
						<tr class="margin_tr" style="height: 32px;"></tr>
						</tbody>
						<tbody class="content_tbody">
							<c:forEach var="row" items="${listUser}" varStatus="index">
								<tr class="table_row" data-check="0" data-seq_count="${index.count}">
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
					<div class="db_save">
						<div class="db_save_button" onclick="form_save()">저장</div>
					</div>
					<div class="db_delete">
						<div class="db_delete_button" onclick="form_delete()">삭제</div>
					</div>
					<div class="excel_save">
						<div class="exel_save_button" onclick="downloadExcel()">내려받기</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="/resources/js/pkg_user/user.js"></script>
</html>
