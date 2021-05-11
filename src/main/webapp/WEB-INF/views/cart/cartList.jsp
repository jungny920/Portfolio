<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
	<meta name="generator" content="Hugo 0.80.0">
	<title>Starter Template · Bootstrap v4.6</title>
	
	
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
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4>상품 목록</h4>
				</div>
				<div class="panel-body">
					<!-- 리스트(테이블) 삽입 -->
					<table class="table table-striped">
					  <thead>
					    <tr>
					      <th scope="col"><input type="checkBox" id="sc_code_allCheck"></th>
					      <th scope="col">번호</th>
					      <th scope="col">상품이미지</th>
					      <th scope="col">상품명</th>
					      <th scope="col">가격</th>
					      <th scope="col">수량</th>
					      <th scope="col">제조사</th>
					      <th scope="col">제거</th>
					    </tr>
					  </thead>
					  <tbody>
					  <c:if test="${empty cart_list}">
					  	<tr>
					  		<th colspan="8">
					  			<h4 style="text-align: center">장바구니가 비어있습니다.</h4>
					  		</th>
					  	</tr>
					  </c:if>
					  <c:set var="i" value="0" />
					  <c:set var="price" value="0"/>
					  <c:forEach items="${cart_list}" var="cartVO">
					  	<c:set var="i" value="${i+1}" />
						<c:set var="price" value="${cartVO.pd_price * cartVO.sc_amount}"/>
					    <tr>
					      <td><input type="checkbox" name="sc_codeBox" value="${cartVO.sc_code}"></td>
					      <th scope="row">${i}
					      	<input type="hidden" value="<c:out value="${cartVO.sc_code}" />">
				      	  </th>
					      <td>
				      	  	<img src="/util/image?fileName=${cartVO.pd_image}" height="60">
				      	  </td>
				      	  <td>
					      	<a class="move" href="/product/detail?pd_code=${cartVO.pd_code}"><c:out value="${cartVO.pd_name}" /></a>
				      	  </td>
					      <td><p class="price_view"><fmt:formatNumber type="currency" value="${price}" /></p>
					      	<input type="hidden" name="pd_price" value="${cartVO.pd_price}">
				      		<p data-total="${price}" style="color: gray; font-size: 12px;">
				      		  <fmt:formatNumber type="currency" value="${cartVO.pd_price}" /></p>
				      	  </td>
					      <td><input type="number" name="sc_amount" value="<c:out value="${cartVO.sc_amount}" />" 
					      		min="1" max="${cartVO.pd_amount}" class="form-control" onkeyup="$(this).val() > ${cartVO.pd_amount} ? $(this).val('${cartVO.pd_amount}') : $(this).val() < 1 ? $(this).val('1') : ''">		      	
					      	<button type="button" data-sc_code="${cartVO.sc_code}" name="btnAmount" class="form-control btn btn-primary btn-sm">수량 변경</button>
					      </td>
					      <td><c:out value="${cartVO.pd_company}" /></td>
				          <td><%--<button type="button" data-sc_code="${cartVO.sc_code}" class="btn btn-success btn-sm">결제</button> --%>
				          	<button type="button" data-sc_code="${cartVO.sc_code}" name="btnCartDelete" class="btn btn-danger">제거</button></td>
				        </tr>
				        <c:set var="sum" value="${sum+price}"/>
				      </c:forEach>
					  </tbody>
					</table>
					
				</div>
				<div class="panel-body">
					<!-- 주문금액 출력 -->
					<table class="table table-striped">
						<tr>
							<td>총 금액</td>
							<td><p data-sum="${sum}"><fmt:formatNumber type="currency" value="${sum}" /></p></td>
						</tr>
					</table>
				</div>
				<div class="panel-footer">
					<!-- 주문금액 출력 -->
					<table class="table table-striped">
						<tr>
							<td style="text-align: center;">
								<form id="orderForm" action="/order/order" method="post">
									<button type="button" id="btnCheckedDelete" class="btn btn-info">장바구니 비우기</button>
									<button type="button" name="btnOrder" class="btn btn-danger">구매하기</button>
									<input type="hidden" id="type" name="type" value="cart">
								</form>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</main><!-- /.container -->

<%@include file="/WEB-INF/views/common/footer.jsp" %>
<script>
$(document).ready(function(){
	// 장바구니 삭제 작업
	$('button[name="btnCartDelete"]').on('click', function(){
		console.log('장바구니 삭제');
		var sc_code = $(this).attr('data-sc_code');
		console.log(sc_code);
		
		var table = $(this).parents('tr');
		
		var price = table.find('p[data-total]').attr('data-total');
		var sum = $('p[data-sum]').attr('data-sum');
		
		console.log(price+', '+sum);
		
		if(!confirm('해당 상품을 장바구니에서 삭제하시겠습니까?')) {
			console.log('삭제 취소');
			return;
		}
		console.log('삭제..');
		// ajax
		$.ajax({
			type: 'post',
			url: '/cart/delete',
			dataType: 'text',
			data: {
				sc_code: sc_code
			},
			success: function(result){
				if(result == 'success'){
					alert(sc_code+' 장바구니에서 삭제되었습니다.');
					// 행을 화면에서 제거
					table.remove();
					
					// 합계 계산
					var sum_price = parseInt(sum)-parseInt(price);
					$('p[data-sum]').text(sum_price);
					$('p[data-sum]').attr('data-sum', sum_price);
				}
			}
		});
		
	});
	
	// 수량 변경 이벤트 작업
	$('button[name="btnAmount"]').on('click', function(){
		console.log('수량 변경');
		
		var sc_code = $(this).attr('data-sc_code');
		var amount = $(this).prevAll('input[name="sc_amount"]').val();
		console.log(amount);
		
		var table = $(this).parents('tr');
		
		var view = table.find('.price_view');
		var price = table.find('input[name="pd_price"]').val();
		
		var sum = $('p[data-sum]').attr('data-sum');
		var total = table.find('p[data-total]').attr('data-total');
		
		var result = parseInt(sum) - parseInt(total) + (parseInt(amount)*parseInt(price));
		
		$('p[data-sum]').text(result);
		$('p[data-sum]').attr('data-sum', result);
		
		result = parseInt(amount)*parseInt(price);
		table.find('p[data-total]').attr('data-total', result);
		
		console.log(result);
		view.text(result);
		
		$.ajax({
			type: 'post',
			url: '/cart/update',
			dataType: 'text',
			data: {
				sc_code: sc_code,
				sc_amount: amount
			},
			success: function(result){
				console.log('[AJAX] 수량 변경 완료')
			}
		});
	});
	
	
	// 3. 장바구니 비우기
	/*
	$('button[name="btnAllDelete"]').on('click', function(){
		if(!confirm('장바구니를 비우겠습니까?')) {
			console.log('취소');
			return;
		}
		console.log('장바구니 비우기');
		
		$.ajax({
			type: 'post',
			url: '/cart/allDelete',
			dataType: 'text',
			success: function(result){
				if(result == 'success'){
					console.log('장바구니 비우기 성공.');
					location.href = '/cart/list';
				}
			}
		})
	});*/
	
	// 전체 선택 버튼 클릭 checked 유무
	$('#sc_code_allCheck').on('click', function(){
		$('input[name="sc_codeBox"]').prop('checked', this.checked);
	});
	
	// 개별 선택시 전체 선택 checked 유무
	$('input[name="sc_codeBox"]').on('click', function(){
		var check = $('input[name="sc_codeBox"]:checked').length;
		var box = $('input[name="sc_codeBox"]').length;
		
		if(check == box) {
			$('#sc_code_allCheck').prop('checked', true);
		} else {
			$('#sc_code_allCheck').prop('checked', false);
		}
	});
	
	// 장바구니 주문하기
	$('button[name="btnOrder"]').on('click', function(e){
		e.preventDefault();
		
		var checkedValue = $('input[name="sc_codeBox"]').length;
		if(checkedValue == 0){
			alert('장바구니가 비어있습니다. \n상품을 추가해주세요');
			return;
		}
		
		if(!confirm('주문페이지로 이동하시겠습니까?')){
			return;
		}
		
		location.href = '/order/order?type=cart'
		/*
		var form = $('#orderForm');
		var checkedValue = $('input[name="sc_codeBox"]:checked').length;

		console.log(checkedValue);
		if(checkedValue == 0) {
			alert('구매할 상품을 선택하세요.');
			return;
		}
		var item = [];

		$('input[name="sc_codeBox"]:checked').each(function(){
			var sc_code = $(this).val();

			item.push(sc_code);
		});
		console.log(item);
		
		$.ajax({
			type: 'post',
			url: '/cart/checkedOrder',
			dataType: 'json',
			data: {
				item: item
			},
			success: function(result){
				if(result != null){
					alert('구매 페이지로 이동합니다.');
					console.log(result);
					//location.href = '/order/order';
				} else {
					alert('주문하신 상품이 없습니다.');
				}
			}
		});*/
	});
	
	// 선택 장바구니 삭제
	$('#btnCheckedDelete').on('click', function(e){
		e.preventDefault();
		var checkedValue = $('input[name="sc_codeBox"]:checked').length;

		console.log(checkedValue);
		if(checkedValue == 0) {
			alert('삭제할 상품을 선택하세요.');
			return;
		}
		
		if(confirm('선택한 상품을 삭제하시겠습니까?')){
			var checkArr = [];

			$('input[name="sc_codeBox"]:checked').each(function(){
				var sc_code = $(this).val();

				checkArr.push(sc_code);
			});
			
			console.log(checkArr);
			
			$.ajax({
				type: 'post',
				url: '/cart/checkedDelete',
				dataType: 'text',
				data: {
					checkArr: checkArr
				},
				success: function(result){
					if(result == 'success'){
						alert('선택한 상품을 삭제했습니다.');
						console.log('장바구니 비우기 성공.');
						location.href = '/cart/list';
					}
				}
			});
		}
	});
	
});
</script>
</body>
</html>