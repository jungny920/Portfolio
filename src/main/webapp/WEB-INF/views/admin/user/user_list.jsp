<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
<!-- CSS file -->
<%@include file="/WEB-INF/views/admin/include/head_inc.jsp" %>
<!-- <script src="/js/admin/admin.js"></script> -->

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
						<a href="#"><i class="fa fa-dashboard"></i> Level</a>
					</li>
					<li class="active">Here</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">
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
								      <th scope="col">번호</th>
								      <th scope="col">아이디</th>
								      <th scope="col">이름</th>
								      <th scope="col">전화번호</th>
								      <th scope="col">이메일</th>
								      <th scope="col">우편번호</th>
								      <th scope="col">주소</th>
								      <th scope="col">상세주소</th>
								      <th scope="col">포인트</th>
								      <th scope="col">등급</th>
								      <th scope="col">가입일</th>
								    </tr>
								  </thead>
								  <tbody>
								  <c:set var="i" value="1"/>
								  <c:forEach items="${userList}" var="vo" varStatus="status">
								    <tr>
								      <td><c:out value="${i}" /></td>
							      	  <td><c:out value="${vo.ui_id}" /></td>
								      <td><c:out value="${vo.ui_name}" /></td>
								      <td><c:out value="${vo.ui_phone}" /></td>
								      <td><c:out value="${vo.ui_email}" /></td>
								      <td><c:out value="${vo.ui_zcode}" /></td>
								      <td><c:out value="${vo.ui_addr}" /></td>
								      <td><c:out value="${vo.ui_addr_d}" /></td>
								      <td><c:out value="${vo.ui_point}" /></td>
								      <td><c:out value="${vo.ui_grade}" /></td>
							          <td><fmt:formatDate pattern="yyyy-MM-dd" value="${vo.ui_reg_date}" /></td>
								      <%--<td><fmt:formatDate pattern="yyyy-MM-dd" value="${vo.ui_update_date}" /></td> --%>
							        </tr><c:set var="i" value="${i+1}" />
							      </c:forEach>
								  </tbody>
								</table>
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
				<form id="action_form" action="" method="get">
					<input type="hidden" name="page" value="<c:out value='${paging.cri.page}' />">
					<input type="hidden" name="amount" value="<c:out value='${paging.cri.amount}' />">
					<input type="hidden" name="keyword" value="<c:out value='${paging.cri.keyword}' />">
					<input type="hidden" name="type" value="<c:out value='${paging.cri.type}' />">
				</form>
		<!--------------------------
        | Your Page Content Here |
        -------------------------->

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
	// 페이징 기능 클릭 출력
	var action_form = $('#action_form');
	$('.page-item a').on('click', function(e){
		e.preventDefault();
		console.log('page-click');
		
		action_form.find("input[name='page']").val($(this).attr('href'));

		action_form.submit();
	});
	
	// 검색 클릭 내용 출력
	$('#btn_search').on('click', function(){
		if(!search_form.find("option:selected").val()){
			alert('검색 종류 선택하세요.');
			return;
		}
		if(!search_form.find("input[name='keyword']").val()){
			alert('키워드를 입력하세요.');
			return;
		}
		
		console.log('search-click');
		
		search_form.find('input[name="page"]').val('1');
		
		search_form.submit();
	});
	
	
	$('#search_type').val('${paging.cri.type}').attr('selected', 'selected');
	$('.change_amount').val('${paging.cri.amount}').attr('selected', 'selected');
	
	// 목록 출력 개수 조정
	$('.change_amount').on('change', function(){
		console.log('change Amount');
		
		var amount = $(this).val();
		action_form.find('input[name="amount"]').val(amount);
		action_form.find('input[name="page"]').val('1');
		action_form.submit();
	});
	
	
	$('a[data-orderCode]').on('click', function(e){
		e.preventDefault();
		var ord_code = $(this).attr('data-orderCode');
		
		console.log('주문 상세 보기 / '+ord_code);
		var tr = $(this).parents('tr');
		
		$.ajax({
			type: 'get',
			url: '/admin/order/detail_list',
			dataType: 'json',
			data: {
				ord_code: ord_code
			},
			success: function(result){
				console.log('주문 상세보기');
				detailList(result, tr, $('#detailTemp'));
			}
		});
	});
});

var detailList = function(data, target, temp){
	var tmp = Handlebars.compile(temp.html());
	var option = tmp(data);
	
	console.log(data);
	//console.log(option);
	
	$('.detailTable').remove();
	target.after(option);
}
</script>
</body>
</html>