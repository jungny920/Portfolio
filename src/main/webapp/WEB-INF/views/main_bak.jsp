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
	<title>Starter Template · Bootstrap v4.6</title>
	
	<style>
	  .bd-placeholder-img {
	    font-size: 1.125rem;
	    text-anchor: middle;
	    -webkit-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	    user-select: none;
	  }
	
	  @media (min-width: 768px) {
	    .bd-placeholder-img-lg {
	      font-size: 3.5rem;
	    }
	  }
	</style>
	
	<%@ include file="/WEB-INF/views/common/config.jsp" %>
	<script>
		var status = '${status}';
		
		if(status == 'success'){
			alert('로그인 성공!');
		} else if(status == 'failPW'){
			alert('비밀번호가 다릅니다.');
			history.back();
		} else if(status == 'failID'){
			alert('아이디가 존재하지 않습니다.');
			history.back();
		} else if(status == 'logout'){
			alert('로그아웃 되었습니다.')
		} else if(status == 'delete_OK'){
			alert('회원탈퇴 되었습니다.');
		} else if(status == 'delete_FAIL'){
			alert('입력하신 정보가 다릅니다.');
			history.back();
		} else if(status == 'modify_OK'){
			alert('회원정보가 변경되었습니다.');
		}
	</script>
</head>
<body>

<%@include file="/WEB-INF/views/common/nav.jsp" %>

<main role="main" class="container">

  <div class="starter-template">
    <h1>Bootstrap starter template</h1>
    <p class="lead">Use this document as a way to quickly start any new project.<br> All you get is this text and a mostly barebones HTML document.</p>
  </div>

</main><!-- /.container -->

<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>