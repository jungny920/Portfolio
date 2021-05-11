$(document).ready(function(){
    
    var form = $('#update_form');

	// 수정버튼 클릭
	$('#btn_update').on('click', function(){
		console.log('update-click');
		
		 if($('#cg_first').val() == 'default' || $('#cg_second').val() == 'default'){
            alert('카테고리를 설정해주세요.');
            $('#cg_first').focus();
            return;
        }
        // 가격 결정여부
        if($('#pd_name').val() == null || $('#pd_name').val() == ''){
            alert('상품명을 입력해주세요.');
            $('#pd_name').focus();
            return;
        }
        // 판매회사명 설정 pd_company
        if($('#pd_company').val() == null || $('#pd_company').val() == ''){
            alert('회사명을 입력해주세요.');
            $('#pd_company').focus();
            return;
        }
        // 가격 결정여부
        if($('#pd_price').val() == null || $('#pd_price').val() == ''){
            alert('가격을 입력해주세요.');
            $('#pd_price').focus();
            return;
        }
        // 할인율 설정
        if($('#pd_discount').val() == null || $('#pd_discount').val() == ''){
            alert('할인율을 입력해주세요.');
            $('#pd_discount').focus();
            return;
        }
        // 상품내용 설정
        /*
        if($('#pdt_detail').val() == null || $('#pdt_detail').val() == ''){
            alert('내용을 입력해주세요.');
            $('#pdt_detail').focus();
            return;
        }
        // 업로드 파일 여부
        if($('#file1').val() == null || $('#file1').val() == ''){
            alert('파일을 업로드해주세요.');
            return;
        }
        */
        // pd_amount
        if($('#pd_amount').val() == null || $('#pd_amount').val() == ''){
            alert('상품개수를 입력해주세요.');
            $('#pd_amount').focus();
            return;
        }
		
		form.submit();
	});
});