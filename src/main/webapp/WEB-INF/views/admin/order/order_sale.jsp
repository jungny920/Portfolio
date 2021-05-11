<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
<!-- CSS file -->
<%@include file="/WEB-INF/views/admin/include/head_inc.jsp" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>


</head>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">

		<!-- Main Header -->
		<%@include file="/WEB-INF/views/admin/include/main-header.jsp"  %>
		
		
		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="/WEB-INF/views/admin/include/main-sidebar.jsp"  %>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					Page Header <small>Optional description</small>
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="#"><i class="fa fa-dashboard"></i> 통계 / 매출현황 관리</a>
					</li>
					<li class="active">매출현황</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">
			<!-- 검색 -->
				<div class="row">
					<div class="col-lg-12">
						<form id="formDate" action="/admin/order/sale" method="get">
							<c:set var="today" value="<%=new java.util.Date() %>"/>
							<c:set var="year"><fmt:formatDate value="${today}" pattern="yyyy"/></c:set>
							<c:set var="month"><fmt:formatDate value="${today}" pattern="MM"/></c:set>
							<select id="year" name="year">
								<c:forEach begin="0" end="4" var="i" step="1">
								<option value="<c:out value="${year-2+i}" />" ${year-2+i == year ? 'selected' : ''}>
									<c:out value="${year-2+i}" /></option>
								</c:forEach>
							</select><span>년</span>
							<select id="month" name="month">
								<c:forEach begin="1" end="12" var="i" step="1">
								<fmt:formatNumber var="dal" minIntegerDigits="2" value="${i}" type="number"/>
								<option value="${dal}" ${dal == month ? 'selected' : ''}><c:out value="${dal}" /></option>
								</c:forEach>
							</select><span>월</span>
							<button id="btn_search" type="submit" class="btn btn-primary btn-sm">검색</button>
						</form>
						<fmt:formatNumber var="month2" minIntegerDigits="2" value="${sel_month}" type="number"/>
						<input type="hidden" id="year_select" value="${sel_year}">
						<input type="hidden" id="month_select" value="${month2}">
					</div>
				</div>
			
				<!-- 상품목록 폼 -->
				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 style="display: inline;">상품 목록</h4>
								<select class="change_amount pull-right" name="amount">
									<option value="3">3</option>
									<option value="5">5</option>
									<option value="10">10</option>
									<option value="15">15</option>
									<option value="20">20</option>
								</select>
							</div>
							<div class="panel-body">
								<!-- 리스트(테이블) 삽입 -->
								<table class="table table-striped">
								  <thead>
								    <tr>
								      <th scope="col">날짜</th>
								      <th scope="col">주문건수</th>
								      <th scope="col">총 매출</th>
								    </tr>
								  </thead>
								  <tbody>
								  <c:forEach items="${date}" var="sales">
								    <tr>
								      <td><fmt:formatDate value="${sales.dat}" pattern="yyyy-MM-dd" /> (${sales.day})</td>
								      <td><c:out value="${sales.cnt}" /></td>
								      <td><fmt:formatNumber type="currency" value="${sales.price}" /></td>
							        </tr>
							      </c:forEach>
								  </tbody>
								</table>
							</div>
						</div>
			   		</div>
				</div>
				
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<%@include file="/WEB-INF/views/admin/include/main-footer.jsp"  %>

		<!-- Control Sidebar -->
		<%@include file="/WEB-INF/views/admin/include/aside.jsp"  %>
		<!-- /.control-sidebar -->
		
		<!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->

	<!-- REQUIRED JS SCRIPTS -->
	<%@include file="/WEB-INF/views/admin/include/script.jsp"  %>

	<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
<script>
$(document).ready(function(){
	$('#year').val($('#year_select').val()).attr('selected', 'selected');
	$('#month').val($('#month_select').val()).attr('selected', 'selected');
});

</script>
</body>
</html>