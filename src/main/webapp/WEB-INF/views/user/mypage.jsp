<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		#nav-tag .nav-item {
			width:25%;
			text-align: center;
			font-size: 18px;
		}
		#nav-tag .nav-item a {
		}
		
		.pd_code, .price {
			color: gray;
		}
		#star_grade a{
		 	font-size:22px;
		    text-decoration: none;
		    color: lightgray;
		}
		#star_grade a.on{
		    color: red;
		}
		
		#star_grade_modal a{
		 	font-size:22px;
		    text-decoration: none;
		    color: lightgray;
		}
		#star_grade_modal a.on{
			color: red;
		}
		
		.popup {position: absolute;}
		.back { background-color: gray; opacity:0.5; width: 100%; height: 300%; overflow:hidden;  z-index:1101;}
		.front { 
			z-index:1110; opacity:1; boarder:1px; margin: auto; 
		}
		
		#thumbnail {
			height: 192px;
			width: 300px;
			
		}
	</style>
	<%@ include file="/WEB-INF/views/common/config.jsp" %>
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
				<h4>마이페이지</h4>
			</div>
			<div>
				<ul id="nav-tag" class="nav nav-tabs">
				    <li class="nav-item">
				      	<a class="nav-link active" data-toggle="tab" href="#menu1"><strong>쇼핑내역</strong></a>
				    </li>
				    <li class="nav-item">
				      	<a class="nav-link" data-toggle="tab" href="#menu2"><strong>상품후기</strong></a>
				    </li>
				    <li class="nav-item">
				      	<a class="nav-link" data-toggle="tab" href="#menu3"><strong>문의내역</strong></a>
				    </li>
				    <li class="nav-item">
				      	<a class="nav-link" data-toggle="tab" href="#menu4"><strong>회원정보</strong></a>
				    </li>
			  	</ul>
			</div>
			<div class="text-center">
			  <!-- Tab panes -->
				<div class="tab-content">
			    	<div id="menu1" class="container tab-pane active"><br>
						<div class="col-lg-12">
							<!-- 쇼핑 내역 출력하기(주문코드, 상품이름, 구매일, 주문개수, 주문가격(1개 값과 total), ) -->
							<div class="orderList">
								<table class="table table-striped">
									<thead>
										<tr>
											<th>주문번호<br><span class="pd_code">(상품코드)</span></th>
											<th>상품이미지</th>
											<th>상품명/상품가격/주문개수</th>
											<th>결제금액</th>
											<th>주문일자</th>
										</tr>
									</thead>
									<tbody id="table-target">
									</tbody>
								</table>
								<div class="none-OrderList" style="display: none;"><h4 style="margin-bottom: 30px">최근 주문 상품이 없습니다.</h4></div>
							</div>
							<button type="button" id="btn-OrderList" class="form-control btn btn-lg btn-light">주문상품 더 보기</button>
						</div>
				  	</div>
				    <div id="menu2" class="container tab-pane fade"><br>
				    	<div class="col-lg-12">
							<div class="reviewList">
								<table class="table table-striped">
									<thead>
										<tr>
											<th>상품명/상품번호</th>
											<th>상품이미지</th>
											<th>내용</th>
											<th>별점</th>
											<th>작성일</th>
										</tr>
									</thead>
									<tbody id="reviewTable-target">
									</tbody>
								</table>
								<div class="none-ReviewList" style="display: none;"><h4 style="margin-bottom: 30px">작성하신 상품후기가 없습니다.</h4></div>
							</div>
							<button type="button" id="btn-ReviewList" class="form-control btn btn-lg btn-light">상품후기 더 보기</button>
						</div>
				 	</div>
				 	<div id="menu3" class="container tab-pane fade"><br>
				    	<div class="col-lg-12">
							<!-- 번호	답변상태	문의유형	문의제목	작성자	작성일자 -->
							<div class="boardList">
								<table class="table table-striped">
									<thead>
										<tr>
											<th>상품명/상품번호</th>
											<th>문의유형</th>
											<th style="width: 40%">문의제목</th>
											<th>답변상태</th>
											<th>작성일</th>
										</tr>
									</thead>
									<tbody id="boardTable-target">
									</tbody>
								</table>
								<div class="none-BoardList" style="display: none;"><h4 style="margin-bottom: 30px">작성하신 상품후기가 없습니다.</h4></div>
							</div>
							<button type="button" id="btn-OrderList" class="form-control btn btn-lg btn-light">상품후기 더 보기</button>
						</div>
				 	</div>
				 	<div id="menu4" class="container tab-pane fade"><br>
				    	<div class="col-lg-12">
							<button type="button" class="btn btn-info" onclick="location.href = '/user/auth';">회원정보 수정</button>
							<button type="button" class="btn btn-danger" onclick="location.href = '/user/delete';">회원탈퇴</button>
						</div>
				 	</div>
				</div>
			</div>
		</div>
	</div>
</main><!-- /.container -->
<!-- 구매내역 -->
<!-- 1) handle bars  -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script id="mypageOrderTemplate" type="text/x-handlebars-template">
{{#each .}}
		<tr>
			<td>{{ord_code}}<br><span class="pd_code">({{pd_code}})</span></td>
			<td>{{viewImage pd_image}}</td>
			<td><a href="/product/detail?pd_code={{pd_code}}">{{pd_name}}</a><hr>{{price-comma ord_price}}원 / {{ord_amount}}개</td>
			<td>{{total-price ord_price ord_amount}}원<br>{{btnModal pd_code}}</td>
			<td>{{displayTime ord_date}}</td>
		</tr>
{{/each}}
</script>
<script>
var dataView = function(data, target, template) {
	var tmp = Handlebars.compile(template.html());

	var dataResult = tmp(data);
	// 계속 추가하는 방식
	target.html(dataResult);
}
Handlebars.registerHelper("viewImage", function(image){
	var str;
	if(image == null) {
		str = "";
	} else {
		str = '<img src="/util/image?fileName='+image+'">';
	}

	return new Handlebars.SafeString(str);
});
Handlebars.registerHelper("reviewImage", function(image){
	var str;
	if(image == null) {
		str = "";
	} else {
		// <img src="/util/image?fileName={{viewImage rv_image}}">
		str = '<br><img data-image="'+image+'" src="/util/image?fileName='+image+'">';
	}

	return new Handlebars.SafeString(str)
});
Handlebars.registerHelper("total-price", function(price, amount){
	
	var str = ''+(price * amount);
	var j = 0;
	for(var i=3; i<str.length-j; i=i+3){
		str = str.substr(0, str.length-i-j)+','+str.substr(str.length-i-j, str.length);
		j++;
	}
	return new Handlebars.SafeString(str);
});
Handlebars.registerHelper("price-comma", function(price){
	var str = ''+price;
	var j = 0;
	for(var i=3; i<str.length-j; i=i+3){
		str = str.substr(0, str.length-i-j)+','+str.substr(str.length-i-j, str.length);
		//str = str.substr(0, str.length-i+j)+','+str.substr(str.length-i+j, 0);
		j++;
	}
	return str;
});
// 4) 사용자정의 헬퍼(Handlebars 버전의 함수)
Handlebars.registerHelper("displayTime", function(timeValue){
	var dateObj = new Date(timeValue);
	var str = "";

	var yy = dateObj.getFullYear();
	var mm = dateObj.getMonth()+1; // 0~11
	var dd = dateObj.getDate();
	var hh = dateObj.getHours();
	var mi = dateObj.getMinutes();
	var ss = dateObj.getSeconds();
	str = [ yy, '/', (mm > 9 ? '' :'0') + mm,
				'/', (dd > 9 ? '' : '0') + dd + '<br>' +
			(hh > 9 ? '' : '0') + hh, ':', (mi > 9? '' : '0') + mi,
				':', (ss > 9 ? '' : '0') + ss].join('');
	return new Handlebars.SafeString(str);
});
// 상품후기 버튼 생성작업
Handlebars.registerHelper("btnModal", function(pd_code){
	var str = '<button type="button" data-code="'+pd_code+'" class="btn btn-secondary btn-review" style="margin-top: 15px;">후기 작성</button>'
	return new Handlebars.SafeString(str);
});
Handlebars.registerHelper('checkRating', function(rating){
	var stars = "";
	
	switch(rating){
		case 1: stars = "★☆☆☆☆"; break;
		case 2: stars = "★★☆☆☆"; break;
		case 3: stars = "★★★☆☆"; break;
		case 4: stars = "★★★★☆"; break;
		case 5: stars = "★★★★★"; break;
		default: stars = "★★★★★";
	}
	
	return stars;
});
var showOrderList = function(page){
	
	orderPage++;
	
	let url = '/user/mypage/order/'+page;

	$.getJSON(url, function(result){
		if(result.length == 0){
			$('.none-OrderList').show();
		} else {
			console.log(result);
			dataView(result, $('#table-target'), $('#mypageOrderTemplate'));
		}
	});
}

let orderPage = 1;
showOrderList(orderPage);
</script>
<script>
$(document).ready(function(){
	$('#btn-OrderList').on('click', function(){
		showOrderList(orderPage);
	});
	$('#btn-ReviewList').on('click', function(){
		showReviewList(reviewPage);
	});
	$('#btn-BoardList').on('click', function(){
		showBoardList(boardPage);
	});
	// 상품후기 작성 클릭 - 모달상자
	$('#table-target').on('click', '.btn-review', function(){
		$('#modalLabel').html('상품후기 작성');
		$('.btnModal').hide();
		$('#btnReviewAdd').show();
		// 상품후기 pd_code 넘기기
		var pd_code = $(this).attr('data-code');
		$('#modal-pd_code').val(pd_code);
		
		$('#modal-Review').modal('show');
	});
	// 모달상자 닫기 내용 초기화
	$('#btnReviewClose').on('click', function(){
		$('#star_grade').children('a').removeClass('on');
		$('#rv_cnt').val('');
		$('#rv_num').val('');
		$('#rv_image').val('');
		
		$('#img_checkBox').remove();
	});
	
	// 별점
	$('#star_grade a').click(function(e){
		e.preventDefault();
		$(this).parent().children('a').removeClass('on');
		$(this).addClass('on').prevAll('a').addClass('on');
	});
	
	// 상품후기 작성
	$('#btnReviewAdd').on('click', function(){
		let rv_score = $('#star_grade').children('a.on').length;
		let rv_cnt = $('#rv_cnt').val();
		let pd_code = $('#modal-pd_code').val();
		
		console.log(rv_score);
		
		$('#rv_score').val(rv_score);
		
		var formData = new FormData($('#modalForm')[0]);
		
		if(rv_score == 0){
			alert('별점을 선택해주세요.');
			return;
		} else if(rv_cnt == '' || rv_cnt == null){
			alert('내용을 작성해주세요.');
			return;
		}
		
		if(!confirm('상품 후기를 등록하시겠습니까?')){
			return;
		}
		
		// ajax호출
		$.ajax({
			url: '/review/add',
			type: 'post',
			enctype: 'multipart/form-data',
			contentType : false,
	        processData : false,
			data: formData,
			dataType: 'text',
			success: function(result){
				alert('상품후기 등록 완료');
				$('#star_grade').children('a').removeClass('on');
				$('#rv_cnt').val('');
				$('#modal-pd_code').val('');
				$('#rv_score').val('');
				$('#file1').val('');
				$('#rv_num').val('');
				$('#rv_image').val('');
				
				$('#modalBox').modal('hide');
			}
		});
		
	});
	
	// 문의 제목 클릭시 아래에 내용 출력
	$('#boardTable-target').on('click', '.board-cnt', function(e){
		e.preventDefault();
		
		var board_num = $(this).data('board_num');
		var tr = $(this).parents('tr');
		
		$.ajax({
			type: 'get',
			url: '/user/mypage/board/cnt',
			dataType: 'text',
			data: {
				board_num: board_num
			},
			success: function(result){
				if(result != null){
					$('tr[name="board_cnt"]').remove();
					tr.after('<tr name="board_cnt" style="background-color: lightgray"><th colspan="1" style="background-color: darkgray">문의내용</th><td colspan="3">'+result+'</td><td>문의번호: '+board_num+'</td></tr>');
				}
			}
		})
	});
});
</script>
<!-- 리뷰(상품후기) -->
<script id="mypageReviewTemplate" type="text/x-handlebars-template">
{{#each .}}
		<tr>
			<td><a href="/product/detail?pd_code={{pd_code}}">{{pd_name}}</a><br>({{pd_code}})</td>
			<td>{{viewImage pd_image}}</td>
			<td>{{rv_cnt}}{{reviewImage rv_image}}</td>
			<td style="color: red;">{{checkRating rv_score}}</td>
			<td>{{displayTime rv_date}}</td>
		</tr>
{{/each}}
</script>
<script>
var showReviewList = function(page){
	
	reviewPage++;
	
	let url = '/user/mypage/review/'+page;

	$.getJSON(url, function(result){
		if(result.length == 0){
			$('.none-ReviewList').show();
		} else {
			console.log(result);
			dataView(result, $('#reviewTable-target'), $('#mypageReviewTemplate'));
		}
	});
}
var reviewPage = 1;
showReviewList(reviewPage);
</script>
<!-- 문의 목록 -->
<script id="mypageBoardTemplate" type="text/x-handlebars-template">
{{#each .}}
		<tr>
			<td><a href="/product/detail?pd_code={{pd_code}}">{{pd_name}}</a><br>({{pd_code}})</td>
			<td>{{board_cg}}</td>
			<td><a href="#" class="board-cnt" data-board_num="{{board_num}}">{{board_title}}</a></td>
			<td>{{board_ast}}</td>
			<td>{{displayTime board_date}}</td>
		</tr>
{{/each}}
</script>
<script>
var showBoardList = function(page){
	
	boardPage++;
	
	let url = '/user/mypage/board/'+page;

	$.getJSON(url, function(result){
		if(result.length == 0){
			$('.none-BoardList').show();
		} else {
			console.log(result);
			dataView(result, $('#boardTable-target'), $('#mypageBoardTemplate'));
		}
	});
}
var boardPage = 1;
showBoardList(boardPage);
</script>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
<!-- 모달 상자 -->
<div class="modal fade" id="modal-Review" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalLabel">상품후기 작성</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <form id="modalForm">
      	<div class="form-group">
			<div class="rating">
				<p id="star_grade">
			        <a href="#">★</a>
			        <a href="#">★</a>
			        <a href="#">★</a>
			        <a href="#">★</a>
			        <a href="#">★</a>
				</p>
			</div>
		</div>
        <div class="form-group">
          <label>상품후기</label>
          <input type="hidden" id="rv_score" name="rv_score" class="form-control">
          <input type="hidden" id="modal-pd_code" name="pd_code" class="form-control">
          <textarea id="rv_cnt" name="rv_cnt" class="form-control"></textarea>
	      <input type="file" id="file1" name="file1" class="form-control">
        </div>
       </form>
      </div>
      <div class="modal-footer review-footer">
        <input type="hidden" id="rv_num" name="rv_num">
        <input type="hidden" id="rv_image" name="rv_image">
        <button type="button" id="btnReviewClose" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" id="btnReviewAdd" class="btn btn-primary btnModal">상품후기 작성</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>