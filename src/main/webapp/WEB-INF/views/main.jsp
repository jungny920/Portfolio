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
	
	<%@ include file="/WEB-INF/views/common/config.jsp" %>
	<script>
    var status = '${status}';
    
    if(status == 'success'){
        alert('로그인 성공!');
    }
    
	</script>
</head>
<body>

<%@include file="/WEB-INF/views/common/nav.jsp" %>

<main role="main" class="container-fluid">
	<div class="row">
		<div class="col-lg-2">
			<!-- 상품리스트 출력 위치 -->
			<%@include file="/WEB-INF/views/common/categoryList.jsp" %>
		</div>
		<div class="col-lg-10">
			<div id="myCarousel" class="carousel slide" data-ride="carousel">
			  <!-- Indicators -->
			  <ul class="carousel-indicators">
			    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			    <li data-target="#myCarousel" data-slide-to="1"></li>
			    <li data-target="#myCarousel" data-slide-to="2"></li>
			  </ul>
			  
			  <!-- 업로드 날짜 폴더 데이터 원본파일 중 아무거나 입력하기 -->
			  <div class="carousel-inner" style="text-align: center;">
			    <div class="carousel-item active">
			      <img src="util/image?fileName=2021/05/11/01c665a9-0c29-451b-b2ed-8099d2054906_PIXNIO-shoes_mbr.jfif" alt="Los Angeles" width="1100" height="600">
			    </div>
			    <div class="carousel-item">
			      <img src="util/image?fileName=2021/05/11/387ed246-f833-4c5c-a18f-994e757b7d74_wrist-watch.jpg" alt="Chicago" width="1100" height="600">
			    </div>
			    <div class="carousel-item">
			      <img src="util/image?fileName=2021/05/11/d355ac05-1305-4f29-8c34-e5bb86c2125b_cut_male_suit.jpg" alt="New York" width="1100" height="600">
			    </div>
			  </div>
			  
			  <!-- Left and right controls -->
			  <a class="carousel-control-prev" href="#myCarousel" data-slide="prev">
			    <span class="carousel-control-prev-icon"></span>
			  </a>
			  <a class="carousel-control-next" href="#myCarousel" data-slide="next">
			    <span class="carousel-control-next-icon"></span>
			  </a>
			</div>
		</div>
	</div>
</main><!-- /.container -->
<script>
$(document).ready(function(){
	
});

</script>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>