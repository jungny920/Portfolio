<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<nav class="navbar navbar-expand-md navbar-dark fixed-top" style="background-color: steelblue;">
  <a class="navbar-brand" href="/"><strong>MAIN MALL</strong></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarsExampleDefault">
	<ul class="navbar-nav mr-auto">
	<!-- 
    	<li class="nav-item active">
      		<a class="nav-link" href="#">카테고리 <span class="sr-only">(current)</span></a>
      	</li>
	    <li class="nav-item">
	      	<a class="nav-link" href="#">Link</a>
	    </li>
	    <li class="nav-item">
	      	<a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
	    </li>
      
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Dropdown</a>
        <div class="dropdown-menu" aria-labelledby="dropdown01">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
       -->
    
     <form class="form-inline my-2 my-lg-0" action="/product/search" method="get">
	   <input class="form-control mr-sm-2" type="text" name="keyword" placeholder="Search" aria-label="Search">
	   <button class="btn btn-secondary my-2 my-sm-0" type="submit">검색</button>
	   <input type="hidden" name="page" value="1">
	   <input type="hidden" name="amount" value="9">
	   <input type="hidden" name="type" value="N">
	 </form>
	 
	</ul>
  </div>
  <div style="float: right;">
    <ul class="navbar-nav mr-auto">
      <c:if test="${sessionScope.loginStatus == null}">
  	  <li class="nav-item">
        <a class="nav-link" href="/user/login">로그인</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/user/signup">회원가입</a>
      </li>
      </c:if>
      <c:if test="${sessionScope.loginStatus != null}">
      <li class="nav-item">
        <a class="nav-link" href="/user/logout">로그아웃</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/cart/list">장바구니</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/user/mypage">마이페이지</a>
      </li>
      </c:if>
    </ul>
    <!-- 카테고리 메뉴 표시 -->
    
  </div>
  
</nav>