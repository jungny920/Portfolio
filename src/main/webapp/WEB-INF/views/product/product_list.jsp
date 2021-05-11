<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
	</style>
	
	<%@ include file="/WEB-INF/views/common/config.jsp" %>
	<script src="/js/user/product/list.js"></script>
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
			<div>
				<h4>상품 목록</h4>
			</div>
			<c:if test="${empty product}">
				<div class="text-center"><h5>등록된 상품이 없습니다.</h5></div>
			</c:if>
			<c:if test="${!empty product}">
			<c:set var="i" value="0" />
			<div class="card-deck mb-3 text-center">
			<c:forEach items="${product}" var="pdVO">
			    <div class="card mb-4 shadow-sm">
		      		<div class="card-body">
		      			<a href="/product/detail?pd_code=${pdVO.pd_code}">
			      			<img src="/util/image?fileName=${pdVO.pd_image}"></a><hr>
		      			<ul class="list-unstyled mt-3 mb-4">
				          <li>${pdVO.pd_name}</li>
				          <li><fmt:formatNumber type="currency" value="${pdVO.pd_price}" /></li>
				          <li style="font-size: 13px; color: gray;">남은 수량(${pdVO.pd_amount})</li>
				          <li><input type="number" name="ord_amount" class="form-control" value="1" min="1" max="${pdVO.pd_amount}" onkeyup="$(this).val() > ${pdVO.pd_amount} ? $(this).val('${pdVO.pd_amount}') : $(this).val() < 1 ? $(this).val('1') : ''"></li>
				       	  <li><input type="hidden" name="pd_code" value="${pdVO.pd_code}"/></li>
				        </ul>
			        	<button type="button" name="btnDirectBuy" class="btn btn-danger">구매하기</button>
				       	<button type="button" name="btnAddCart" class="btn btn-primary">장바구니</button>
		      		</div>
		    	</div>
		    	<c:set var="i" value="${i+1}" />
			  	<c:if test="${i == 3}">
				  	</div>
				  	<div class="card-deck mb-3 text-center">
				  	
				  	<c:set var="i" value="0" />
			  	</c:if>
		  	</c:forEach>
		  	<c:forEach begin="${i}" end="2" step="1">
			  	<div class="card mb-4 shadow-sm">
			  	</div>
		  	</c:forEach>
		  	</div>
	    	</c:if>
	    	
	    	<form id="directOrderForm" action="/order/order" method="post">
      			<input type="hidden" name="type" value="direct">
      		</form>
		  	<input type="hidden" id="loginStatus" value="${sessionScope.loginStatus.ui_id}">
		</div>
	</div>
</main><!-- /.container -->

<%@include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>