<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		#nav-tag .nav-item {
			width:33.3%;
			text-align: center;
			font-size: 18px;
		}
		#btn_order, #btn_cart {
			width: 49%;
		}
		#thumbnail {
			height: 192px;
			width: 300px;
			
		}
		/*
		.show{
			position:relative;
			max-width: 1200px; 
			max-height: 800px; 
			overflow: auto;       
		} */
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
		<div class="col-lg-9">
			<!-- 상품 상세설명 카드 -->
			<div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
				<div class="col-auto d-none d-lg-block">
					<img id="thumbnail" src="/util/image?fileName=${detail.pd_image}"><hr>
					<button type="button" id="btn_order" class="btn btn-lg btn-danger">구매하기</button>
					<button type="button" id="btn_cart" class="btn btn-lg btn-primary">장바구니</button>
				</div>
				
				<div class="col p-4 d-flex flex-column position-static">
					<form id="directOrderForm" action="/order/order" method="post">
						<strong class="d-inline-block mb-2 text-primary">${detail.pd_company}</strong>
						<h3 class="mb-0">${detail.pd_name}</h3>
						<div class="mb-1 text-muted">남은 수량 : ${detail.pd_amount}</div>
						<p>구매 수량 <input type="number" id="pd_amount" name="ord_amount" class="form-control" value="1" min="1" max="${detail.pd_amount}" onkeyup="$(this).val() > ${detail.pd_amount} ? $(this).val('${detail.pd_amount}') : $(this).val() < 1 ? $(this).val('1') : ''"></p>
						<p class="card-text mb-auto" style="font-size: 20px"><fmt:formatNumber type="currency" value="${detail.pd_price}" /></p>
						<input type="hidden" id="pd_code" name="pd_code" value="${detail.pd_code}">
		      			<input type="hidden" name="type" value="direct">
	      			</form>
				
					
					<button type="button" id="btn_review" class="btn btn-lg btn-light col">상품후기 작성</button>
				</div>
			</div>
			
			<div>
			  <ul id="nav-tag" class="nav nav-tabs">
			    <li class="nav-item">
			      <a class="nav-link active" data-toggle="tab" href="#menu1"><strong>상세설명</strong></a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" data-toggle="tab" href="#menu2"><strong>상품후기</strong></a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" data-toggle="tab" href="#menu3"><strong>문의하기</strong></a>
			    </li>
			  </ul>
			</div>
			<div class="text-center">
			  <!-- Tab panes -->
			  <div class="tab-content">
			    <div id="menu1" class="container tab-pane active"><br>
			      	<!-- 상품 상세설명 -->
					<div class="col-lg-12">
						<p id="pd_content">${detail.pd_content}</p>
					</div>
			    </div>
			    <div id="menu2" class="container tab-pane fade"><br>
				    <!-- 상품후기 -->
					<div class="panel panel-default">
						<div id="review-none" class="panel-body">
							<h3>상품후기 내용이 없습니다.</h3>
						</div>
						<div id="review-body">
							<div id="review-div" class="panel-body"></div>
							<div id="reviewPaging" class="panel-footer"></div>
						</div>		
					</div>
			    </div>
			    <div id="menu3" class="container tab-pane fade"><br>
			      	<div class="panel panel-default">
						<div id="board-none" class="panel-body">
							<button type="button" id="btnQuestion" class="btn btn-light col float-right" style="width: 25%">문의하기</button>
						</div>
						<div id="board-body">
							<div id="boardView" class="panel-body"></div>
							<div id="boardPaging" class="panel-footer"></div>
						</div>		
					</div>
		    	</div>
			  </div>
				
			</div>
		</div>
	</div>
</main><!-- /.container -->

<%@include file="/WEB-INF/views/common/footer.jsp" %>
<!-- 1) handle bars  -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<!-- 2) UI Template 상품후기 목록 -->
<script id="reviewTemplate" type="text/x-handlebars-template">
<table class="table table-striped">
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">별점</th>
			<th scope="col">작성자</th>
			<th scope="col">내용</th>
			<th scope="col">작성일</th>
			<th scope="col">수정/삭제</th>
		</tr>
	</thead>
	<tbody>
{{#each .}}
		<tr>
			<td data-rv_num="{{rv_num}}">{{rv_num}}</td>
			<td data-rv_score="{{rv_score}}" style="color: red;">{{checkRating rv_score}}</td>
			<td data-ui_id="{{ui_id}}">{{replaceID ui_id}}</td>
			<td data-rv_cnt="{{rv_cnt}}">{{rv_cnt}}{{viewImage rv_image}}</td>
			<td data-rv_date="{{displayTime rv_date}}">{{displayTime rv_date}}</td>
			<td>{{eqReplyer ui_id rv_num}}</td>
		</tr>
{{/each}}
	</tbody>
</table>
</script>
<script id="boardTemplate" type="text/x-handlebars-template">
<table class="table table-striped">
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">답변상태</th>
			<th scope="col">문의유형</th>
			<th scope="col">문의제목</th>
			<th scope="col">작성자</th>
			<th scope="col">작성일자</th>
		</tr>
	</thead>
	<tbody>
{{#each .}}
		<tr>
			<td data-rv_num="{{rv_num}}">
				<input type="hidden" value="{{board_num}}">{{number @index}}</td>
			<td data-board_ast="{{board_ast}}">{{board_ast}}</td>
			<td data-board_cg="{{board_cg}}">{{board_cg}}</td>
			<td data-board_title="{{board_title}}">
				<a href="#">{{board_title}}</a></td>
			<td data-ui_id="{{ui_id}}">{{replaceID ui_id}}</td>
			<td>{{displayTime board_date}}</td>
		</tr>
{{/each}}
	</tbody>
</table>
</script>
<script>
//3) 상품후기 목록 출력작업 / Handlebars 작업 (댓글 데이터 삽입 후 출력)
var reviewData = function(date, target, template) {
	var tmp = Handlebars.compile(template.html());

	var dataResult = tmp(date);
	target.html(dataResult);
}
Handlebars.registerHelper("viewImage", function(image){
	var str;
	if(image == null) {
		str = "";
	} else {
		// <img src="/util/image?fileName={{viewImage rv_image}}">
		str = '<br><img data-image="'+image+'" src="/util/image?fileName='+image+'">';
	}

	return new Handlebars.SafeString(str)
});

// 4) 사용자정의 헬퍼(Handlebars 버전의 함수)
Handlebars.registerHelper("displayTime", function(timeValue){
	/*
	var today = new Date(); // 1970.01.01 00:00:00 0000
	var gap = today.getTime() - timeValue;
	*/
	var dateObj = new Date(timeValue);
	var str = "";

	var yy = dateObj.getFullYear();
	var mm = dateObj.getMonth()+1; // 0~11
	var dd = dateObj.getDate();

	return [ yy, '/', (mm > 9 ? '' :'0') + mm,
				'/', (dd > 9 ? '' : '0') + dd].join('');
	/*
	if(gap < (1000 * 60 * 60 * 24)) {
		var hh = dateObj.getHours();
		var mi = dateObj.getMinutes();
		var ss = dateObj.getSeconds();

		return [(hh > 9 ? '' : '0') + hh, ':', (mi > 9? '' : '0') + mi,
					':', (ss > 9 ? '' : '0') + ss].join('');
	} else {
		var yy = dateObj.getFullYear();
		var mm = dateObj.getMonth();
		var dd = dateObj.getDate();

		return [ yy, '/', (mm > 9 ? '' :'0') + mm,
					'/', (dd > 9 ? '' : '0') + dd].join('');
	}*/
});
// 아이디 별표시
Handlebars.registerHelper('replaceID', function(str){
	return str.substr(0, str.length - 3) + '***';
});

Handlebars.registerHelper('number', function(num){
	return num + 1;
});

// 별점 표시작업
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
// 로그인 사용자와 상품후기 등록자가 동일한 경우 수정, 삭제 표시
Handlebars.registerHelper('eqReplyer', function(id, rv_num){
	var str = "";
	var ui_id = '${sessionScope.loginStatus.ui_id}';
	
	if(ui_id == id){
		str += '<button type="button" data-num="'+rv_num+'" class="btn btn-sm btn-primary btn-edit">수정</button>';
		str += '<button type="button" data-num="'+rv_num+'" class="btn btn-sm btn-danger btn-del">삭제</button>';
		
		//target.style = 'block';
	}
	
	return new Handlebars.SafeString(str);
});

// 상품후기 목록 페이징구현 작업
var pageDisplay = ""; // [이전] 1 2 3 ... [다음]

var pageCount = 10;

var reviewPaging = function(reviewCnt, pageNum){
	// 페이징 알고리즘
	
	var endNum = Math.ceil(pageNum / 10.0) * 10;
	var startNum = endNum - 9;

	var prev = startNum != 1;
	var next = false;

	
	// 마지막 페이지 번호 * 게시글수 >= 총 데이터 개수
	if(endNum * pageCount >= reviewCnt){
		endNum = Math.ceil(reviewCnt / parseFloat(pageCount));
	}

	if(endNum * pageCount < reviewCnt){
		next = true;
	}
	
	var str ='<ul class="pagination">';
	
	if(prev){
		str += '<li class="page-item"><a class="page-link" href="' + (startNum - 1) + '">Prev</a></li>';
	}

	for(var i=startNum; i<=endNum; i++){
		var active = pageNum == i ? 'active' : ''; // 현재페이지 상태를 나타내는 스타일시트 저장.

		str += '<li class="page-item ' + active + '"><a class="page-link" href="' + i + '">'+ i +'</a></li>';
	}

	if(next){
		str += ' <li class="page-item"><a class="page-link" href="' + (endNum + 1) + '">Next</a></li>';
	}
	str += '</ul>';

	//console.log(str);

	
	// 댓글 페이징번호가 삽입되는 위치.
	$('#reviewPaging').html(str);
	$('#boardPaging').html(str);
	// 페이징 정보 표시

}
</script>
<script>
$(document).ready(function(){
	
	$('#pd_content').find('img').css('height', 'auto');
	$('#pd_content').find('img').css('max-width', '800px');
	
	$('#btn_cart').on('click', function(e){
		e.preventDefault();
		console.log('장바구니 버튼 클릭!');
		/* 장바구니 테이블
		장바구니 코드 : 시퀀스
		로그인ID, 상품코드, 수량
		*/
		var pd_code = ${detail.pd_code};
		var pd_amount = $('#pd_amount').val();
		
		$.ajax({
			type: 'post',
			url: '/cart/add',
			data: {
				pd_code: pd_code,
				pd_amount: pd_amount
			},
			dataType: 'text',
			success: function(result){
				if(result == 'success'){
					if(confirm('장바구니에 추가되었습니다.\n 확인 하시겠습니까?')){
						location.href = '/cart/list';
					}
				} else if(result == 'LoginRequired') {
					alert('로그인이 필요한 작업입니다.');
					location.href = '/user/login';
				}
			}
		});
	});
	
	$('#btn_order').on('click', function(){
		console.log('구매하기 버튼 클릭!');
		var form = $('#directOrderForm');
		
		form.submit();
	});
});
</script>
<script>
// 상품 후기 관련 코드
// 목록/페이징
var showReviewList = function(page){
	// 상품코드 ${detail.pd_code}
	let pd_code = $('input[name="pd_code"]').val();
	console.log(pd_code);
	let viewPage = page;
	
	let url = '/review/pages/'+pd_code+'/'+page;

	$.getJSON(url, function(result){
		// 댓글 데이터가 없을 경우.
		if(result.reviewList.length == 0) {
			console.log('상품후기 없음.');
			$('#review-none').show();
			$('#review-body').hide();
		} else {
			// 1)상품후기 목록 출력, 2)페이징 출력
			//console.log(result);
			reviewData(result.reviewList, $('#review-div'), $('#reviewTemplate'));
			reviewPaging(result.reviewCnt, viewPage);
			
			$('#review-none').hide();
			$('#review-body').show();
			console.log('상품후기 출력');
		}
	});
}

let viewPage = 1;
showReviewList(viewPage);

// 문의 관련
var showBoardList = function(page){
	// 상품코드 ${detail.pd_code}
	let pd_code = $('input[name="pd_code"]').val();
	let viewPage = page;
	
	let url = '/board/list/'+pd_code+'/'+page;

	$.getJSON(url, function(result){

		reviewData(result.list, $('#boardView'), $('#boardTemplate'));
		reviewPaging(result.count, viewPage);
			
	});
}

showBoardList(viewPage);
</script>
<script>
// 문의관련 AJAX
$(document).ready(function(){
	$('#btnQuestion').on('click', function(){
		console.log('문의클릭');
		$('.btnModal').hide();
		$('#btnBoardAdd').show();

		$('#modal-board').modal('show');
	});

	$('#btnBoardAdd').on('click', function(){
		let board_cg = $('input[name="board_cg"]:checked').val();
		let board_cnt = $('#board_cnt').val();
		let board_title = $('#board_title').val();
		let pd_code = $('#pd_code').val();

		if(board_cg == null){
			alert('문의 유형을 선택해주세요.');
			return;
		}
		if(board_title == '' || board_title == null){
			alert('문의 제목을 작성해주세요.');
			return;
		}
		if(board_cnt == '' || board_cnt == null){
			alert('문의 내용을 작성해주세요.');
			return;
		}

		// 문의 작성 ajax
		$.ajax({
			type: 'post',
			url: '/board/add',
			data: {
				board_cg: board_cg,
				board_title: board_title,
				board_cnt: board_cnt,
				pd_code: pd_code
			},
			dataType: 'text',
			success: function(result){
				alert('문의 내용을 작성했습니다.');

				$('input[name="board_cg"]').prop('checked', false);
				$('#board_cnt').val('');
				$('#board_title').val('');
				
				$('#modal-board').modal('hide');
				showBoardList(1);
			}
		})
	});
	// 모달상자 닫기 - 내용 초기화
	$('#btnBoardClose').on('click', function(){
		$('input[name="board_cg"]').prop('checked', false);
		$('#board_cnt').val('');
		$('#board_title').val('');
	});
	// 문의 페이징클릭
	$('#boardPaging').on('click', 'li.page-item a', function(e){
		e.preventDefault();
		console.log('페이지 번호 클릭');
		
		viewPage = $(this).attr('href');
		console.log('페이지 이동 '+viewPage);
		
		showReviewList(viewPage);
	});
});
</script>
<script>
$(document).ready(function(){
	// 모달상자 show
	$('#btn_review').on('click', function(){
		// 마이페이지에서만 상품후기 등록 가능하게 변경
		if(confirm('마이페이지에서 상품후기 작성이 가능합니다.\n마이페이지로 이동하시겠습니까?')){
			location.href = '/user/mypage';
		} else {
			
		}
		return;
		
		
		$('#modalLabel').html('Reply Register Modal-Register');
		$('.btnModal').hide();
		$('#btnReviewAdd').show();
		
		$('#modalBox').modal('show');
	});
	// 별점
	$('#star_grade a').click(function(e){
		e.preventDefault();
		$(this).parent().children('a').removeClass('on');
		$(this).addClass('on').prevAll('a').addClass('on');
	});
	
	// 상품후기 작성
	/*
	$('#btnReviewAdd').on('click', function(){
		let rv_score = $('#star_grade').children('a.on').length;
		let rv_cnt = $('#rv_cnt').val();
		let pd_code = $('#pd_code').val();
		
		console.log(rv_score);
		
		$('#star_grade a').each(function(i, e){
			if($(this).attr('class') == 'on'){
				rv_score += 1;
			}
		});
		$('#modal-pd_code').val(pd_code);
		$('#rv_score').val(rv_score);
		
		var formData = new FormData($('#modalForm')[0]);
		
		if(rv_score == 0){
			alert('별점을 선택해주세요.');
			return;
		} else if(rv_cnt == '' || rv_cnt == null){
			alert('내용을 작성해주세요.');
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
				showReviewList(1);
			}
		});
		
	});*/
	
	// 상품후기 목록 수정 버튼 클릭시
	$('#review-div').on('click', '.btn-edit', function(){
		console.log('상품후기 수정');
		
		$('.review-footer').prepend('<span id="img_checkBox"><label><input type="checkbox">기존 이미지 삭제</label></span>');
		
		
		$('.btnModal').hide();
		$('#btnReviewEdit').show();
		var tr = $(this).parents('tr');
		
		var rv_num, ui_id, pd_code, rv_cnt, rv_score, rv_image;
		
		rv_num = tr.find('td[data-rv_num]').attr('data-rv_num');
		ui_id = tr.find('td[data-ui_id]').attr('data-ui_id');
		pd_code = $('#pd_code').val();
		rv_cnt = tr.find('td[data-rv_cnt]').attr('data-rv_cnt');
		rv_score = tr.find('td[data-rv_score]').attr('data-rv_score');
		rv_image = tr.find('img[data-image]').attr('data-image');
		
		$('#modalLabel').html('Reply Register Modal-Modify ('+rv_num+'번)');
		
		$('#modal-pd_code').val(pd_code);
		$('#rv_num').val(rv_num);
		$('#rv_cnt').val(rv_cnt);
		$('#rv_image').val(rv_image);
		// 별점 처리
		$('#star_grade a').each(function(index, item){
			if(index < rv_score){
				$(item).addClass('on');
			} else {
				$(item).removeClass('on');
			}
		});
		
		$('#modalBox').modal('show');
	});
	
	// 상품후기 삭제 모달상자
	$('#review-div').on('click', '.btn-del', function(){
		console.log('상품후기 삭제');
		
		$('.btnModal').hide();
		$('#btnReviewEdit').show();
		var tr = $(this).parents('tr');
		
		var rv_num, ui_id, pd_code, rv_cnt, rv_score, rv_image;
		
		rv_num = tr.find('td[data-rv_num]').attr('data-rv_num');
		ui_id = tr.find('td[data-ui_id]').attr('data-ui_id');
		pd_code = $('#pd_code').val();
		rv_cnt = tr.find('td[data-rv_cnt]').attr('data-rv_cnt');
		rv_score = tr.find('td[data-rv_score]').attr('data-rv_score');

		rv_image = tr.find('img[data-image]').attr('data-image');
		
		$('#modalLabel').html('Reply Register Modal-Delete ('+rv_num+'번)');
		
		$('#modal-pd_code').val(pd_code);
		$('#rv_num').val(rv_num);
		$('#rv_cnt').val(rv_cnt);
		$('#rv_image').val(rv_image);
		// 별점 처리
		$('#star_grade a').each(function(index, item){
			if(index < rv_score){
				$(item).addClass('on');
			} else {
				$(item).removeClass('on');
			}
		});
		
		$('#modalBox').modal('show');
	});
	
	$('#review-div').on('click', '.btn-del', function(){
		$('#modalLabel').html('Reply Register Modal-Delete');
		$('.btnModal').hide();
		$('#btnReviewDel').show();
		
		$('#modalBox').modal('show');
	});
	
	// 모달상자 닫기 내용 초기화
	$('#btnReviewClose').on('click', function(){
		$('#star_grade').children('a').removeClass('on');
		$('#rv_cnt').val('');
		$('#rv_num').val('');
		$('#rv_image').val('');
		
		$('#img_checkBox').remove();
	});
	

	// 상품후기 수정작업
	$('#btnReviewEdit').on('click', function(){
		let rv_score = $('#star_grade').children('a.on').length;
		let rv_cnt = $('#rv_cnt').val();
		let rv_num = $('#rv_num').val();
		let rv_image = $('#rv_image').val();
		console.log(rv_score);
		
		let checkImg = $('#img_checkBox').children('input:checkbox').is(':checked');
		
		if(checkImg){
			console.log('기존 이미지 삭제 작업');
			rv_image = '';
		}
		
		$('#rv_score').val(rv_score);
		
		var formData = new FormData($('#modalForm')[0]);
		
		formData.set('rv_image', rv_image);
		formData.set('rv_num', rv_num);

		if(rv_score == 0){
			alert('별점을 선택해주세요.');
			return;
		} else if(rv_cnt == '' || rv_cnt == null){
			alert('내용을 작성해주세요.');
			return;
		}
		
		// ajax호출 (수정)
		$.ajax({
			url: '/review/modify',
			type: 'post',
			enctype: 'multipart/form-data',
			contentType : false,
	        processData : false,
			data: formData,
			dataType: 'text',
			success: function(result){
				alert('상품후기 수정 완료');
				$('#star_grade').children('a').removeClass('on');
				$('#rv_cnt').val('');
				$('#modal-pd_code').val('');
				$('#rv_score').val('');
				$('#file1').val('');
				$('#rv_num').val('');
				$('#rv_image').val('');
				
				$('#img_checkBox').remove();
				
				$('#modalBox').modal('hide');
				showReviewList(viewPage);
			}
		});
	});
	
	// 상품후기 삭제 작업
	$('#btnReviewDel').on('click', function(){
		let rv_num = $('#rv_num').val();
		let rv_image = $('#rv_image').val();
		
		// ajax호출 (삭제)
		$.ajax({
			url: '/review/delete',
			type: 'post',
			data: {
				rv_num: rv_num,
				rv_image: rv_image
			},
			dataType: 'text',
			success: function(result){
				alert('상품후기 삭제 완료');
				$('#star_grade').children('a').removeClass('on');
				$('#rv_cnt').val('');
				$('#modal-pd_code').val('');
				$('#rv_score').val('');
				$('#file1').val('');
				$('#rv_num').val('');
				$('#rv_image').val('');
				
				$('#modalBox').modal('hide');
				showReviewList(1);
			}
		});
	});
	
	$('#reviewPaging').on('click', 'li.page-item a', function(e){
		e.preventDefault();
		console.log('페이지 번호 클릭');
		
		viewPage = $(this).attr('href');
		console.log('페이지 이동 '+viewPage);
		
		showReviewList(viewPage);
	});
	
});

</script>
<!-- 모달 상자 -->
<div class="modal fade" id="modalBox" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalLabel">Reply Register Modal-Register</h5>
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
        <%--<button type="button" id="btnReviewAdd" class="btn btn-primary btnModal">상품후기 작성</button> --%>
        <button type="button" id="btnReviewEdit" class="btn btn-primary btnModal">상품후기 수정</button>
        <button type="button" id="btnReviewDel" class="btn btn-danger btnModal">상품후기 삭제</button>
      </div>
    </div>
  </div>
</div>
<!-- 문의 관련 모달상자 -->
<div class="modal fade" id="modal-board" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalLabel">Reply Register Modal-Register</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
		<div class="form-group">
			<label>문의유형</label><br>
			<input type="radio" id="board_cg1" name="board_cg" value="상품">
				<label for="board_cg1">상품</label>
			<input type="radio" id="board_cg2" name="board_cg" value="배송">
				<label for="board_cg2">배송</label>
			<input type="radio" id="board_cg3" name="board_cg" value="교환">
				<label for="board_cg3">교환</label>
			<input type="radio" id="board_cg4" name="board_cg" value="반품/환불/취소">
				<label for="board_cg4">반품/환불/취소</label>
			<input type="radio" id="board_cg5" name="board_cg" value="기타">
				<label for="board_cg5">기타</label>
		</div>
      	<div class="form-group">
			<label>문의제목</label>
			<input type="text" id="board_title" name="board_title" class="form-control">
		</div>
        <div class="form-group">
	        <label>문의내용</label>
	        <textarea id="board_cnt" name="board_cnt" class="form-control"></textarea>
        </div>
        
      </div>
      <div class="modal-footer">
        <button type="button" id="btnBoardClose" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" id="btnBoardAdd" class="btn btn-primary btnModal">문의 작성</button>
        <button type="button" id="btnBoardEdit" class="btn btn-primary btnModal">문의 수정</button>
        <button type="button" id="btnBoardDel" class="btn btn-danger btnModal">문의 삭제</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>