<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
<!-- CSS file -->
<%@include file="/WEB-INF/views/admin/include/head_inc.jsp" %>
<script src="/ckeditor/ckeditor.js"></script>
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
					<li class="active">상품 등록</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">
			
				<!-- 상품등록 폼 -->
				<div class="row">
					<!-- left column -->
					<div class="col-md-12">
						<!-- general form elements -->
						<div class="box box-primary">
							<div class="box-header">
								<h3 class="box-title">상품 등록</h3>
							</div>
							<!-- /.box-header -->

							<form id='upload_form' role="form" action="/admin/product/insert" method="post" enctype="multipart/form-data">
								<div class="box-body">
									<div class="form-group">
										<label for="cg_first" style="width:30%; margin-right:20px;" >1차 카테고리</label>
										<label for="cg_second" style="width:30%;" >2차 카테고리</label> <br />
										<select class="form-control" id="cg_first" name="cg_parent_code" style="width:30%; margin-right:10px; display: inline-block;" >
										  <option value="default">1차 카테고리 선택</option>
										  <c:forEach items="${category}" var="cgVO">
										  	<option value="<c:out value='${cgVO.cg_code}'/>"><c:out value='${cgVO.cg_name}'/></option>
										  </c:forEach>
										</select>
										<select class="form-control" id="cg_second" name="cg_code" style="width: 30%; display: inline-block;">
										 	<option value="default">2차 카테고리 선택</option>
										</select>
									</div>
									<div class="form-group">
										<label for="pd_name">Product Name</label> <input
											type="text" id="pd_name" name="pd_name" class="form-control"
											placeholder="Enter Product name">
									</div>
									<div class="form-group">
										<label for="pd_company">Company</label> <input
											type="text" id="pd_company" name="pd_company" class="form-control"
											placeholder="Enter company">
									</div>
									<div class="form-group">
										<label for="pd_price" style="width:40%; margin-right:10px;">Price</label> 
										<label for="pd_discount" style="width:40%;">Discount</label> 
										<input style="width:40%; margin-right:10px; display: inline-block;"
											type="number" id="pd_price" name="pd_price" class="form-control" 
											placeholder="Enter price" min="0" />
										<input style="width:40%; display: inline-block;"
											type="number" id="pd_discount" name="pd_discount" class="form-control"
											placeholder="Enter discounted price" min="0" max="100" value="0" onkeyup="$(this).val() > 100 ? $(this).val('100') : $(this).val() < 0 ? $(this).val('0') : ''"/>
									</div>
									<div class="form-group">
										<label for="exampleInputPassword1">Detail</label>
										<textarea class="form-control" id="pdt_detail" name="pd_content" rows="8"
											placeholder="Enter ..."></textarea>
									</div>

									<div class="form-group">
										<label for="exampleInputEmail1">Thumbnail Image</label> <input
											type="file" id="file1" name="file1" class="form-control" />
									</div>
									
									<div class="form-group">
										<label for="exampleInputEmail1" style="width:30%; margin-right:10px;" onkeyup="$(this).val($(this).val().replace(/\D/g,''));">Amount</label> 
										<label for="exampleInputEmail1" style="width:15%;">Buy availability</label><br /> 
										<input style="width:30%; margin-right:10px; display: inline-block;"
											type="number" id="pd_amount" name='pd_amount' class="form-control" 
											placeholder="Enter Amount" min="0"/>
										<select class="form-control" id="pd_buy" name="pd_buy" style="width: 15%; display: inline-block;">
										  <option value="Y">판매가능</option>
										  <option value="N">판매불가</option>
										</select>
									</div>
								</div>

								<!-- /.box-body -->

								<div class="box-footer">
									<div>
										<hr>
									</div>

									<ul class="mailbox-attachments clearfix uploadedList">
									</ul>

									<button id="btn_submit" type="button" class="btn btn-primary">Submit</button>

								</div>
							</form>


						</div>
						<!-- /.box -->	
					</div>
					<!--/.col (left) -->

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
	/* ckEditor 작업 */
	// config.js를 사용하지 않고 개별 설정하는 부분
	var ckeditor_config = {
			resize_enabled : false,
			enterMode : CKEDITOR.ENTER_BR,
			shiftEnterMode : CKEDITOR.ENTER_P,
			toolbarCanCollapse : true,
			removePlugins : "elementspath", 
			// 파일 업로드 기능 추가
			// CKEditor를 이용해 업로드 사용 시 해당 주소에 업로드 됨
			filebrowserUploadUrl: '/admin/product/imgUpload'
	};
	CKEDITOR.replace("pdt_detail", ckeditor_config);
	// config.js의 설정을 사용하려면, 다음과 같이 사용
	// CKEDITOR.replace("desc", "");

	$('#cg_first').on('change', function(){
		var mainCG_code = $(this).val();
		var url = '/admin/product/categoryList/'+mainCG_code;

		$.getJSON(url, function(data){
			// 2차 카테고리 추가 작업.(handlebar 이용)
			subCategoryList(data, $('#cg_second'), $('#cg_second_handlebar'));
		});
	});

});
</script>
<script>
	// 선택한 카테고리의 하위 카테고리 불러오기.
	var subCategoryList = function(cg_date, cg_target, cg_template){
		var subCG = Handlebars.compile(cg_template.html());
		var options = subCG(cg_date);
		// select태그의 id를 제이쿼리 문법에 맞게 작성
		// var target_optionID = '#'+cg_target.attr('id')+' option';
		
		// console.log(target_optionID);
		
		// option 제거
		$('#cg_second option').remove();
		cg_target.append(options);
	};
</script>
<script id="cg_second_handlebar" type="text/x-handlebars-template">
	<option value="default">2차 카테고리 선택</option>
	{{#each .}}
		<option value="{{cg_code}}">{{cg_name}}</option>
	{{/each}}
</script>
<script src="/js/admin/product/insert.js"></script>
</body>
</html>