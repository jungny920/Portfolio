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
						<a href="#"><i class="fa fa-dashboard"></i> 상품 관리</a>
					</li>
					<li class="active">상품 목록</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">
			<!-- 검색 -->
				<div class="row">
					<div class="col-lg-12">
						<form id="search_form" action="/admin/product/list" method="get">
							<select id="search_type" name="type">
								<option value="">--</option>
								<option value="N">상품명</option>
								<option value="C">제조사</option>
								<option value="NC">상품명+제조사</option>
							</select>
							<input type="text" name="keyword" value="<c:out value='${paging.cri.keyword}' />">
							<button id="btn_search" type="button" class="btn btn-primary btn-sm">검색</button>
							<input type="hidden" name="page" value="<c:out value='${paging.cri.page}' />">
							<input type="hidden" name="amount" value="<c:out value='${paging.cri.amount}' />">
						</form>
					</div>
				</div>
			
				<!-- 상품목록 폼 -->
				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 style="display: inline;">상품 목록</h4>
								<select class="change_amount pull-right" name="amount">
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
								      <th scope="col">상품번호</th>
								      <th scope="col">상품이미지</th>
								      <th scope="col">상품명</th>
								      <th scope="col">가격</th>
								      <th scope="col">재고</th>
								      <th scope="col">제조사</th>
								      <th scope="col">등록일</th>
								      <th scope="col">상품판매여부</th>
								      <th scope="col">수정</th>
								      <th scope="col">삭제</th>
								    </tr>
								  </thead>
								  <tbody>
								  <c:forEach items="${pro_list}" var="proVO">
								    <tr>
								      <th scope="row"><c:out value="${proVO.pd_code}" /></th>
								      <td>
							      	  	<img src="/util/image?fileName=${proVO.pd_image}" height="40">
							      	  </td>
							      	  <td>
								      	<a class="move" href="#"><c:out value="${proVO.pd_name}" /></a>
							      	  </td>
								      <td><fmt:formatNumber type="currency" value="${proVO.pd_price}" /></td>
								      <td><c:out value="${proVO.pd_amount}" /></td>
								      <td><c:out value="${proVO.pd_company}" /></td>
								      <td><fmt:formatDate pattern="yyyy-MM-dd" value="${proVO.pd_date}" /></td>
							          <td>
							          	<select>
							          	  <option <c:out value="${proVO.pd_buy=='Y'?'selected':''}" />>판매중</option>
							          	  <option <c:out value="${proVO.pd_buy=='N'?'selected':''}" />>판매불가</option>
							          	</select>
							          </td>
							          <td><button type="button" data-pd_code="${proVO.pd_code}" class="btn btn-success btn-sm btn_update">수정</button></td>
							          <td><button type="button" data-pd_code="${proVO.pd_code}" data-pd_image="${proVO.pd_image}" class="btn btn-danger btn-sm btn_delete">삭제</button></td>
							        </tr>
							      </c:forEach>
							      
								  </tbody>
								</table>
								<form id="update_form"  action="/admin/product/product_update" method="get">
									<input type="hidden" name="page" value="<c:out value='${paging.cri.page}' />">
									<input type="hidden" name="amount" value="<c:out value='${paging.cri.amount}' />">
									<input type="hidden" name="keyword" value="<c:out value='${paging.cri.keyword}' />">
									<input type="hidden" name="type" value="<c:out value='${paging.cri.type}' />">
								</form>
							</div>
						</div>
			   		</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<!-- 페이징 표시 -->
						<div class="panel-footer">
							<ul class="pagination">
							  <c:if test="${paging.prev}">
							    <li class="page-item">
							      <a class="page-link" href="${paging.startPage - 1}" tabindex="-1">Prev</a>
							    </li>
							  </c:if>
							  <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="num">
							  	<li class="page-item ${paging.cri.page == num ? 'active' : ''} ">
							  	  <a class="page-link" href="${num}">${num}</a>
							  	</li>
							  </c:forEach>
							  <c:if test="${paging.next}">
							    <li class="page-item">
							      <a class="page-link" href="${paging.endPage + 1}">Next</a>
							    </li>
							  </c:if>
							</ul>
						</div>
					</div>
				</div>
				<form id="action_form" action="/admin/product/list" method="get">
					<input type="hidden" name="page" value="<c:out value='${paging.cri.page}' />">
					<input type="hidden" name="amount" value="<c:out value='${paging.cri.amount}' />">
					<input type="hidden" name="keyword" value="<c:out value='${paging.cri.keyword}' />">
					<input type="hidden" name="type" value="<c:out value='${paging.cri.type}' />">
				</form>
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
<script src="/js/admin/product/list.js"></script>
<script>
$(document).ready(function(){
	$('#search_type').val('${paging.cri.type}').attr('selected', 'selected');
	$('.change_amount').val('${paging.cri.amount}').attr('selected', 'selected');
});
</script>
</body>
</html>