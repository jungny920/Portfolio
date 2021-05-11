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
    <link href="/css/admin/signup.css" rel="stylesheet">
    <script>
    $(document).ready(function(){
        var form = $('.form-signup');
        
        $('#btn_signup').on('click', function(){
        	var id = $('#admin_id').val();
        	var name = $('#admin_name').val();
        	var pw = $('#admin_pw').val();
        	var re = $('#admin_re').val();
        	var regId = /^[A-Za-z0-9+]{4,16}$/;
        	
        	if(id == null || id == ''){
        		alert('아이디를 입력해주세요.');
        		return;
        	} else if(!regId.test(id)){
        		alert('4~16자 이내로 아이디를 작성해주세요.\n( 영문, 숫자만 사용가능 )');
        		return;
        	}
        	if(name == null || name == ''){
        		alert('이름을 입력해주세요.');
        		return;
        	}
        	if(pw == null || pw == ''){
        		alert('비밀번호를 입력해주세요.');
        		return;
        	} else if(pw.length < 4 || pw.length > 16){
        		alert('비밀번호는 4~16자 이내로 작성해주세요.');
        		return;
        	}
        	if(re != pw){
        		alert('비밀번호가 일치하지 않습니다.');
        		return;
        	}
        	
        	alert('회원가입 완료');
        	form.submit();
        });
    });
    </script>
</head>
<body class="text-center">
<div>
	<h1>Admin Sign up</h1>
	<form class="form-signup" method="post" action="/admin/signup">
		  <h2 class="h3 mb-3 font-weight-normal">sign up</h2>
		  <label for="admin_id" class="sr-only">아이디</label>
		  <input type="text" name="admin_id" id="admin_id" class="form-control" maxlength="16" placeholder="아이디" autofocus>
		  <label for="admin_name" class="sr-only">관리자명</label>
		  <input type="text" name="admin_name" id="admin_name" class="form-control" maxlength="10" placeholder="이름">
		  <label for="admin_pw" class="sr-only">비밀번호</label>
		  <input type="password" name="admin_pw" id="admin_pw" class="form-control" placeholder="비밀번호">
		  <label for="admin_re" class="sr-only">비밀번호 확인</label>
		  <input type="password" id="admin_re" class="form-control" placeholder="비밀번호 확인">
		  <button id="btn_signup" class="btn btn-lg btn-info btn-block" type="button">회원가입</button>
	</form>
</div>
</body>
</html>
