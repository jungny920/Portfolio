$(document).ready(function(){
	// 구매하기 버튼 클릭 (즉시구매)
	$('button[name="btnDirectBuy"]').on('click', function(){
		console.log('구매하기 클릭!');
		// 상품코드, 구매수량
		var pd_code = $(this).siblings('ul').find('li input[name="pd_code"]').val();
		var ord_amount = $(this).siblings('ul').find('li input[name="ord_amount"]').val();
		console.log(pd_code +", "+ord_amount);

		if($('#loginStatus').val() == null || $('#loginStatus').val() == ''){
			alert('로그인이 필요한 작업입니다.');
			location.href = '/user/login';
			return;
		}
		
		var form = $('#directOrderForm');
		form.append('<input type="hidden" name="pd_code" value="'+pd_code+'">');
		form.append('<input type="hidden" name="ord_amount" value="'+ord_amount+'">');
		form.submit();
	});
	
	// 장바구니 버튼 클릭 (장바구니 추가)
	$('button[name="btnAddCart"]').on('click', function(){
		console.log('장바구니 클릭!');
		
		var pd_code = $(this).siblings('ul').find('li input[name="pd_code"]').val();
		var pd_amount = $(this).siblings('ul').find('li input[name="ord_amount"]').val();
		
		$.ajax({
			type: 'post',
			url: '/cart/add',
			dataType: 'text',
			data: {
				pd_code: pd_code,
				pd_amount: pd_amount
			},
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
});