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
	var search_form = $('#search_form');
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
	
	// 수정 클릭 폼 이동
	$('table td .btn_update').on('click', function(){
		console.log('update-click');
		action_form.append('<input type="hidden" name="pd_code" value="'+$(this).attr('data-pd_code')+'">');
		action_form.attr('action', '/admin/product/update');
		action_form.attr('method', 'get');

		console.log($(this).attr('data-pd_code'));
		
		action_form.submit();
	});
	
	// 삭제 클릭 데이터 삭제
	$('table td .btn_delete').on('click', function(){
		console.log('delete-click');
		
		if(confirm('상품번호: '+$(this).attr('data-pd_code')+' - 해당 상품을 삭제하시겠습니까?')) {
			action_form.append('<input type="hidden" name="pd_code" value="'+$(this).attr('data-pd_code')+'">');
			action_form.append('<input type="hidden" name="pd_image" value="'+$(this).attr('data-pd_image')+'">');
			action_form.attr('action', '/admin/product/delete');
			action_form.attr('method', 'get');
			
			console.log($(this).attr('data-pd_code'));
			alert('삭제되었습니다.');
			action_form.submit();
		}
		
	});
	
	
	// 목록 출력 개수 조정
	$('.change_amount').on('change', function(){
		console.log('change Amount');
		
		var amount = $(this).val();
		action_form.find('input[name="amount"]').val(amount);
		action_form.find('input[name="page"]').val('1');
		action_form.submit();
	});
	
});