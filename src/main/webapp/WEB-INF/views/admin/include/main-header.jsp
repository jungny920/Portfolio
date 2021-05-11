<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<header class="main-header">
	<!-- Logo -->
	<a href="/admin/main" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels --> <span class="logo-mini">
			<b>PF</b>
		</span> <!-- logo for regular state and mobile devices --> <span class="logo-lg">
			<b>PF </b>MALL
		</span>
	</a>

	<!-- Header Navbar -->
	<nav class="navbar navbar-static-top" role="navigation">
		<!-- Sidebar toggle button-->
		<a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button"> <span class="sr-only">Toggle navigation</span>
		</a>
		<!-- Navbar Right Menu -->
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
				<li><a href="#"><span class="hidden-xs">${sessionScope.adminLogin.admin_name}</span></a></li>
				<li><a><span style="color: lightgray; font-size: 12px;">최근접속시간 : 
					<fmt:formatDate pattern="yy-MM-dd hh:mm:ss" value="${sessionScope.adminLogin.admin_date}" /></span></a>
				</li>
				<li><a href="/admin/logout" style="background-color: darkslategray;">로그아웃</a>
					<form id="logoutForm" method="post" action="/admin/logout"></form>
				</li>
			</ul>
		</div>
	</nav>
</header>