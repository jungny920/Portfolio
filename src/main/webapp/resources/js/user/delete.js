$(document).ready(function(){
	$('#btn_delete').on('click', function(e){
		e.preventDefault();
		var pw = $('#ui_pw').val();

		if(pw == null || pw == ""){
			alert('비밀번호를 입력하세요');
			return;
		}
		
		console.log('DELETE OK');
		if(!confirm('정말 회원탈퇴 하시겠습니까?')){
			return;
		}
		
		$.ajax({
			type: 'post',
			url: '/user/delete',
			data: {
				ui_pw: pw,
			},
			dataType: 'text',
			success: function(result){
				if(result == 'success'){
					alert('회원 탈퇴처리 되었습니다.');
					location.href = '/';
				} else if(result == 'fail'){
					alert('입력하신 패스워드가 다릅니다.');
					$('#ui_pw').val('');
				}
			}
		});
	});
	
});