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
    <title>Admin Login</title>

	<%@ include file="/WEB-INF/views/common/config.jsp" %>
	
    <!-- Custom styles for this template -->
    <link href="/css/admin/login.css" rel="stylesheet">
<script>
$(document).ready(function(){
	var status = '${adminStatus}';
	if(status == 'fail'){
		alert('로그인에 실패했습니다.');
	} else if(status == 'logout'){
		alert('로그아웃 되었습니다.');
	}
	
	$('#btn_signup').click(function(){
		location.href = '/admin/join';
	});
});
</script>
</head>
<body class="text-center">
<div>
	<h1>Admin Login</h1>
	<form class="form-signin" method="post" action="/admin/login">
		  <h2 class="h3 mb-3 font-weight-normal">Login</h2>
		  <label for="admin_id" class="sr-only">ID</label>
		  <input type="text" name="admin_id" id="admin_id" class="form-control" placeholder="ID" autofocus>
		  <label for="admin_pw" class="sr-only">Password</label>
		  <input type="password" name="admin_pw" id="admin_pw" class="form-control" placeholder="Password">
		  <div class="checkbox mb-3">
		    <label>
		      <input type="checkbox" value="remember-me"> Remember me
		    </label>
		  </div>
		  <button id="btn_login" class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
		  <button id="btn_signup" class="btn btn-lg btn-info btn-block" type="button">계정 추가</button>
	</form>
</div>
</body>
</html>
