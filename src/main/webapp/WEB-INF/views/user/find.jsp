<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.80.0">
    <title>Signin Template · Bootstrap v4.6</title>

    <style>
      
    </style>

	<%@ include file="/WEB-INF/views/common/config.jsp" %>
	<script src="/js/user/find.js"></script>
    <!-- Custom styles for this template -->
    <link href="/css/user/find.css" rel="stylesheet">
</head>
<body class="text-center">
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container">
	<div class="starter-template">
    	<h1>아이디 / 비밀번호 찾기</h1>
  	</div>
	<form class="form-find">
		<input type="text" name="ui_name" id="find_id_name" class="form-control" placeholder="이름">
		<button type="button" id="btn_find_id" class="btn btn-info btn-block">아이디 찾기</button><hr>
		<label for="ui_id" class="sr-only">ID</label>
		<input type="text" name="ui_id" id="find_pw_id" class="form-control" placeholder="아이디">
		<input type="text" name="ui_email" id="find_pw_email" class="form-control" placeholder="이메일">
		<button type="button" id="btn_find_pw" class="btn btn-info btn-block">비밀번호 찾기</button>
	</form>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
