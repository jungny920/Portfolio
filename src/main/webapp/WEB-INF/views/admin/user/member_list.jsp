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
						<a href="#"><i class="fa fa-dashboard"></i> ?????? ??????</a>
					</li>
					<li class="active">?????? ??????</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">
			<!-- ?????? -->
				<div class="row">
					<div class="col-lg-12">
						<form id="search_form" action="/admin/order/list" method="get">
							<input type="hidden" name="page" value="<c:out value='${paging.cri.page}' />">
							<input type="hidden" name="amount" value="<c:out value='${paging.cri.amount}' />">
							<select id="search_type" name="type">
								<option value="">--</option>
								<option value="N">?????????</option>
								<option value="C">?????????</option>
								<option value="NC">?????????+?????????</option>
							</select>
							<input type="text" name="keyword" value="<c:out value='${paging.cri.keyword}' />">
							<button id="btn_search" type="button" class="btn btn-primary btn-sm">??????</button>
						</form>
					</div>
				</div>
			
				<!-- ???????????? ??? -->
				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 style="display: inline;">?????? ??????</h4>
								<select class="change_amount pull-right" name="amount">
									<option value="3">3</option>
									<option value="5">5</option>
									<option value="10">10</option>
									<option value="15">15</option>
									<option value="20">20</option>
								</select>
							</div>
							<div class="panel-body">
								<!-- ?????????(?????????) ?????? -->
								<table class="table table-striped">
								  <thead>
								    <tr>
								      <th scope="col">??????</th>
								      <th scope="col">?????????</th>
								      <th scope="col">??????</th>
								      <th scope="col">????????????</th>
								      <th scope="col">????????????</th>
								      <th scope="col">?????????</th>
								      <th scope="col">????????????</th>
								      <th scope="col">??????</th>
								      <th scope="col">????????????</th>
								      <th scope="col">?????????</th>
								      <th scope="col">??????</th>
								      <th scope="col">?????????</th>
								      <th scope="col">?????????</th>
								    </tr>
								  </thead>
								  <tbody>
								  <c:set var="i" value="1"/>
								  <c:forEach items="${member}" var="vo" varStatus="status">
								    <tr>
								      <td><c:out value="${i}" /></td>
							      	  <td><c:out value="${vo.user_id}" /></td>
								      <td><c:out value="${vo.user_name}" /></td>
								      <td><c:out value="${vo.user_pw}" /></td>
								      <td><c:out value="${vo.user_phone}" /></td>
								      <td><c:out value="${vo.user_email}" /></td>
								      <td><c:out value="${vo.user_zcode}" /></td>
								      <td><c:out value="${vo.user_addr}" /></td>
								      <td><c:out value="${vo.user_addr_d}" /></td>
								      <td><c:out value="${vo.user_point}" /></td>
								      <td><c:out value="${vo.user_grade}" /></td>
							          <td><fmt:formatDate pattern="yyyy-MM-dd" value="${vo.user_reg_date}" /></td>
								      <td><fmt:formatDate pattern="yyyy-MM-dd" value="${vo.user_update_date}" /></td>
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
						<!-- ????????? ?????? -->
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
				<form id="action_form" action="/admin/order/list" method="get">
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
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Create the tabs -->
			<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
				<li class="active">
					<a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a>
				</li>
				<li>
					<a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a>
				</li>
			</ul>
			<!-- Tab panes -->
			<div class="tab-content">
				<!-- Home tab content -->
				<div class="tab-pane active" id="control-sidebar-home-tab">
					<h3 class="control-sidebar-heading">Recent Activity</h3>
					<ul class="control-sidebar-menu">
						<li>
							<a href="javascript:;"> <i class="menu-icon fa fa-birthday-cake bg-red"></i>

								<div class="menu-info">
									<h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

									<p>Will be 23 on April 24th</p>
								</div>
							</a>
						</li>
					</ul>
					<!-- /.control-sidebar-menu -->

					<h3 class="control-sidebar-heading">Tasks Progress</h3>
					<ul class="control-sidebar-menu">
						<li>
							<a href="javascript:;">
								<h4 class="control-sidebar-subheading">
									Custom Template Design
									<span class="pull-right-container">
										<span class="label label-danger pull-right">70%</span>
									</span>
								</h4>

								<div class="progress progress-xxs">
									<div class="progress-bar progress-bar-danger" style="width: 70%"></div>
								</div>
							</a>
						</li>
					</ul>
					<!-- /.control-sidebar-menu -->

				</div>
				<!-- /.tab-pane -->
				<!-- Stats tab content -->
				<div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
				<!-- /.tab-pane -->
				<!-- Settings tab content -->
				<div class="tab-pane" id="control-sidebar-settings-tab">
					<form method="post">
						<h3 class="control-sidebar-heading">General Settings</h3>

						<div class="form-group">
							<label class="control-sidebar-subheading">
								Report panel usage
								<input type="checkbox" class="pull-right" checked>
							</label>

							<p>Some information about this general settings option</p>
						</div>
						<!-- /.form-group -->
					</form>
				</div>
				<!-- /.tab-pane -->
			</div>
		</aside>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<!-- ?????? ???????????????, ????????? ?????? ?????? -->
<script id="detailTemp" type="text/x-handlebars-template">
<tr class="detailTable">
	<th colspan="2">????????????<br><span style="color: darkgray">(????????????)</span></th>
	<th>???????????????</th>
	<th>?????????</th>
	<th>????????????</th>
	<th>????????????</th>
	<th>??????</th>
	<th>?????????</th>
	<th>?????????</th>
</tr>
{{#each .}}
<tr class="detailTable">
	<th colspan="2">{{pd_code}}<br><span style="color: darkgray">({{ord_code}})</span></th>
	<td><img src="/admin/order/image?fileName={{pd_image}}" style="width: 60px;"></td>
	<td>{{pd_name}}</td>
	<td>{{ord_price}}</td>
	<td>{{ord_amount}}</td>
	<td>{{total-price ord_price ord_amount}}</td>
	<td>{{pd_company}}</td>
	<td>{{ui_id}}</td>
</tr>
{{/each}}
</script>
<script>
// ???????????? ????????? ??????
Handlebars.registerHelper('total-price', function(price, amount){

	return price*amount;
});
</script>
<script>
$(document).ready(function(){
	// ????????? ?????? ?????? ??????
	var action_form = $('#action_form');
	$('.page-item a').on('click', function(e){
		e.preventDefault();
		console.log('page-click');
		
		action_form.find("input[name='page']").val($(this).attr('href'));

		action_form.submit();
	});
	
	// ?????? ?????? ?????? ??????
	$('#btn_search').on('click', function(){
		if(!search_form.find("option:selected").val()){
			alert('?????? ?????? ???????????????.');
			return;
		}
		if(!search_form.find("input[name='keyword']").val()){
			alert('???????????? ???????????????.');
			return;
		}
		
		console.log('search-click');
		
		search_form.find('input[name="page"]').val('1');
		
		search_form.submit();
	});
	
	
	$('#search_type').val('${paging.cri.type}').attr('selected', 'selected');
	$('.change_amount').val('${paging.cri.amount}').attr('selected', 'selected');
	
	// ?????? ?????? ?????? ??????
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
		
		console.log('?????? ?????? ?????? / '+ord_code);
		var tr = $(this).parents('tr');
		
		$.ajax({
			type: 'get',
			url: '/admin/order/detail_list',
			dataType: 'json',
			data: {
				ord_code: ord_code
			},
			success: function(result){
				console.log('?????? ????????????');
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