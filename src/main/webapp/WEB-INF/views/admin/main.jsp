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
<script src="https://www.gstatic.com/charts/loader.js"></script>
<%@include file="/WEB-INF/views/admin/include/head_inc.jsp" %>
<!-- <script src="/js/admin/admin.js"></script> -->
<script>
    google.charts.load("current", {packages:["corechart"]});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart(){
    	var jsonData = $.ajax({
    		type: 'get',
    		url: '/admin/order/chart', // 주소를 호출하면 구글에서 요구하는 차트데이터 포맷에 맞게 데이터를 json형태로 받아온다.
    		dataType: 'json',
    		async: false,
    		
    	}).responseText; // json내용을 텍스트로 읽어들임.

    	var data = new google.visualization.DataTable(jsonData);
    	//제이슨 형식을 구글의 테이블 형식으로 바꿔주기 위해서 집어넣음
    	//차트를 출력할 div
    	//LineChart, ColumnChart, PieChart에 따라서 차트의 형식이 바뀐다.
    	
    	var chart = new google.visualization.ColumnChart(document.getElementById('chart_div')); //원형 그래프
    	
    	//var chart
    	// = new google.visualization.LineChart(
    			//document.getElementById('chart_div')); 선 그래프 
    			
    	//var chart
    	//  = new google.visualization.ColumnChart(document.getElementById('chart_div'));
    	//차트 객체.draw(데이터 테이블, 옵션) //막대그래프
    	
    	//cuveType : "function" => 곡선처리
    	
    	//데이터를 가지고 (타이틀, 높이, 너비) 차트를 그린다.
    	chart.draw(data, {
    		title : "주간 매출",
    		//curveType : "function", //curveType는 차트의 모양이 곡선으로 바뀐다는 뜻
    		width : 600,
    		height : 400
    	});
    }
</script>
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
				<div id="chart_div"></div>
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
	var status = '${adminStatus}';
	
	if(status == 'login'){
		alert('로그인에 성공하였습니다.');
	}
});
</script>
</body>
</html>