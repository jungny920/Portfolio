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
	
    <script>
    $(document).ready(function(){
    	var status = '${status}';
    	if(status == 'fail'){
    		alert('비밀번호가 일치하지 않습니다.');
    		$('#ui_pw').val('');
    	}
    });
    </script>
  
    <!-- Custom styles for this template -->
    <link href="/css/user/login.css" rel="stylesheet">
</head>
<body class="text-center">
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container">
	<div class="starter-template">
    	<h1>회원정보 수정</h1>
  	</div>
  	<form class="form-signin" method="post" action="/user/auth">
		<label for="ui_pw">본인 인증을 위해 비밀번호를 입력해주세요.</label>
		<input type="password" name="ui_pw" id="ui_pw" class="form-control" placeholder="비밀번호">
		<button type="submit" id="btn_delete" class="btn btn-lg btn-info btn-block">비밀번호 확인</button>
	</form>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
