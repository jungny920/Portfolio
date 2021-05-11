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
	
    <script src="/js/user/login.js"></script>
    
    <!-- Custom styles for this template -->
    <link href="/css/user/login.css" rel="stylesheet">
</head>
<body class="text-center">
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container">
	<div class="starter-template">
    	<h1>로그인</h1>
  	</div>
	<form id="form_login" class="form-signin" method="post" action="/user/loginPost">
		<label for="ui_id" class="sr-only">ID</label>
		<input type="text" name="ui_id" id="ui_id" class="form-control" placeholder="ID" autofocus>
		<label for="ui_pw" class="sr-only">Password</label>
		<input type="password" name="ui_pw" id="ui_pw" class="form-control" placeholder="Password">
		<div class="checkbox mb-3"><label>
		<input type="checkbox" value="remember-me"> Remember me</label></div>
		<button id="btn_login" class="btn btn-lg btn-primary btn-block" type="submit">로그인</button><br>
		<button id="btn_find" class="btn btn-info" style="width: 100%">아이디 / 비밀번호 찾기</button>
	</form>
	<form id="user_form">
	  
	</form>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
