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
    	.form-signin label {
    		font-size: 15px;
    	}
    </style>
	
	<%@ include file="/WEB-INF/views/common/config.jsp" %>
	
    <script src="/js/user/password.js"></script>
  
    <!-- Custom styles for this template -->
    <link href="/css/user/login.css" rel="stylesheet">
</head>
<body class="text-center">
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container">
	<div class="starter-template">
    	<h1>비밀번호 변경</h1>
  	</div>
  	<form class="form-signin">
		<label for="ui_pw">변경하고자 하는 비밀번호를 입력해주세요.</label>
		<input type="password" name="ui_pw" id="ui_pw" class="form-control" placeholder="기존 비밀번호">
		<input type="password" name="new_pw" id="new_pw" class="form-control" placeholder="새 비밀번호">
		<p id="txt_pw" style="display: block; color: gray; font-size: 13px;">영문, 숫자, 특수문자로 8~16자로 사용해주세요.</p>
		<input type="password" name="new_re" id="new_re" class="form-control" placeholder="새 비밀번호 확인">
		<button type="submit" id="btn_password" class="btn btn-lg btn-info btn-block">비밀번호 변경</button>
	</form>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
