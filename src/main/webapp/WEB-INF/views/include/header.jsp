<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<header class="navbar container-fluid_st">
	<div class="navbar-header">
		<div class="header_logo"
			onclick="location.href='/pkg_dashboard/dashboard'">EDMS</div>
		<ul class="nav navbar-nav" style="cursor: pointer;">
			<li><a href="/pkg_dashboard/dashboard">대시보드</a></li>
			<li style="width: 21%;">
			<a href="/pkg_history/history">배터리 등록 및 수정</a></li>
			<li><a href="/pkg_history_log/history_log">히스토리</a></li>
			<li><a href="/pkg_barcode/barcode">바코드관리</a></li>
			<li><a onclick="admin_check()">사용자관리</a></li>
			<li class="header_logout"><a href="/logout">로그아웃 <i class="fa fa-power-off"></i></a></li>
		</ul>
	</div>
</header>
<script type="text/javascript">
function admin_check() {
	<c:if test="${user_admin != 'Y'}">
	alert("관리자만 접근 가능합니다.");
</c:if>

<c:if test="${user_admin == 'Y'}">
	location.href="/pkg_user/user";
</c:if>
};
</script>