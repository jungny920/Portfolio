<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
	
		<!-- Sidebar user panel (optional) -->
		<div class="user-panel">
			<div class="pull-left image">
				<img src="/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
			</div>
			<div class="pull-left info">
				<p>${sessionScope.adminLogin.admin_name}</p>
				<!-- Status -->
				<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
			</div>
		</div>
	
		<!-- search form (Optional) -->
		<form action="#" method="get" class="sidebar-form">
			<div class="input-group">
				<input type="text" name="q" class="form-control" placeholder="Search...">
				<span class="input-group-btn">
					<button type="submit" name="search" id="search-btn" class="btn btn-flat">
						<i class="fa fa-search"></i>
					</button>
				</span>
			</div>
		</form>
		<!-- /.search form -->
	
		<!-- Sidebar Menu -->
		<ul class="sidebar-menu" data-widget="tree">
			<li class="header">HEADER</li>
			<!-- Optionally, you can add icons to the links
			<li class="active">
				<a href="#"><i class="fa fa-link"></i> <span>Link</span></a>
			</li>
			<li>
				<a href="#"><i class="fa fa-link"></i> <span>Another Link</span></a>
			</li> -->
			<li class="treeview">
				<a href="#"><i class="fa fa-link"></i> <span>상품 관리</span> <span class="pull-right-container">
						<i class="fa fa-angle-left pull-right"></i>
					</span> </a>
				<ul class="treeview-menu">
					<li>
						<a href="${pageContext.request.contextPath}/admin/product/insert">상품 등록</a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/admin/product/list">상품 목록</a>
					</li>
				</ul>
			</li>
			<li class="treeview">
				<a href="#"><i class="fa fa-link"></i> <span>주문 관리</span> <span class="pull-right-container">
						<i class="fa fa-angle-left pull-right"></i>
					</span> </a>
				<ul class="treeview-menu">
					<li>
						<a href="${pageContext.request.contextPath}/admin/order/list">주문 목록</a>
					</li>
					<!-- <li>
						<a href="#">Link in level 2</a>
					</li> -->
				</ul>
			</li>
			<li class="treeview">
				<a href="#"><i class="fa fa-link"></i> <span>회원 관리</span> <span class="pull-right-container">
						<i class="fa fa-angle-left pull-right"></i>
					</span> </a>
				<ul class="treeview-menu">
					<li>
						<a href="${pageContext.request.contextPath}/admin/user/list">회원 목록</a>
					</li>
				</ul>
			</li>
			<li class="treeview">
				<a href="#"><i class="fa fa-link"></i> <span>게시판 관리</span> <span class="pull-right-container">
						<i class="fa fa-angle-left pull-right"></i>
					</span> </a>
				<ul class="treeview-menu">
					<li>
						<a href="#">문의 목록</a>
					</li>
				</ul>
			</li>
			<li class="treeview">
				<a href="#"><i class="fa fa-link"></i> <span>통계 / 매출현황 관리</span> <span class="pull-right-container">
						<i class="fa fa-angle-left pull-right"></i>
					</span> </a>
				<ul class="treeview-menu">
					<li>
						<a href="${pageContext.request.contextPath}/admin/order/sale">매출현황</a>
					</li>
				</ul>
			</li>
		</ul>
		<!-- /.sidebar-menu -->
	</section>
	<!-- /.sidebar -->
</aside>