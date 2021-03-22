<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<% 
String user_id = (String)session.getAttribute("user_id"); 
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

<link href="/resources/css/pkg_login/home.css" rel="stylesheet">
<%@ include file="/WEB-INF/views/include/link.jsp"%>

<script src="/resources/js/pkg_login/login.js"></script>

</head>

<body id="home">
	<div class="main">
		<div>
			<div class="title_area">
				<div class="title_logo">
					<p>EDMS</p>
				</div>
				<div class="title_sub1">
					<p>EVㆍESS Disuse Management System</p>
				</div>
				<div class="title_sub2">
					<!-- <img src="/resources/img/title_sub.png"> -->
					<p>EVㆍESS 사용 후 배터리 관리 시스템</p>
				</div>
			</div>
			<c:if test="${user_id != null}">
				<div class="idnotnull">
					<a href="/pkg_dashboard/dashboard">
						메뉴로 이동
						<br>
						<i class="fa fa-home fa-2x"></i>
					</a>
				</div>
			</c:if>
			<c:if test="${user_id == null}">
			<div class="sign_area">
				<form class="form-signin" action="/login" method="post">
					<div class="form-group id">
						<label class="col-sm-2 control-label" class="sr-only" for="id">아이디</label>
						<div class="col-sm-10">
							<input class="form-control" id="focusedInput" type="text"
								name="user_id" placeholder="ID" onkeyup="javascript:fn_onlyEngNum(this.id);" autocomplete=off required autofocus>
								<i class="fa fa-user"></i>
						</div>
					</div>
					<div class="form-group password">
						<label class="col-sm-2 control-label" for="inputPassword">비밀번호</label>
						<div class="col-sm-10">
							<input class="form-control" id="inputPassword" type="password" name="user_pwd" placeholder="Password" required>
								<i class="fa fa-lock"></i>
						</div>
					</div>

					<div class="checkbox" style="">
						<label> <input type="checkbox" id="idSaveCheck">
							ID save
						</label>
					</div>
					<button class="btn btn-lg btn-primary btn-block" type="submit">LOGIN</button>
				</form>
			</div>
			</c:if>
		</div>
	</div>
</body>
</html>
