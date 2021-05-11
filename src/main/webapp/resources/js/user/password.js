$(document).ready(function(){

	var isRegPW = false;
	
	$('#btn_password').on('click', function(e){
		e.preventDefault();
		
		var ui_pw = $('#ui_pw').val();
		var new_pw = $('#new_pw').val();
		var new_re = $('#new_re').val();
		
		if(ui_pw == null || ui_pw == ''){
			alert('기존 비밀번호를 입력해주세요.');
			$('#ui_pw').focus();
			return;
		}
		if(new_pw == null || new_pw == ''){
			alert('새 비밀번호를 입력해주세요.');
			$('#new_pw').focus();
			return;
		}
		if(new_re == null || new_re == ''){
			alert('새 비밀번호 확인을 입력해주세요.');
			$('#new_re').focus();
			return;
		}
		if(!isRegPW){
			alert('조합에 맞게 비밀번호를 입력해주세요.\n(영문, 숫자, 특수문자로 8~16자 조합)');
			$('#new_pw').focus();
			return;
		}
		if(new_pw != new_re){
			alert('새 비밀번호가 일치하지 않습니다.\n확인해주세요.');
			$('#new_pw').focus();
			return;
		}
		if(new_pw == ui_pw){
			alert('같은 비밀번호는 사용할 수 없습니다.');
			$('#new_pw').focus();
			return;
		}
		
		$.ajax({
			type: 'post',
			url: '/user/password',
			data: {
				ui_pw: ui_pw,
				new_pw: new_pw
			},
			dataType: 'text',
			success: function(result){
				if(result == 'success') {
					alert('비밀번호가 변경되었습니다.\n다시 로그인하여 이용해주세요.');
					
					location.href = '/user/login';
				} else if(result == 'password'){
					alert('입력하신 비밀번호가 일치하지 않습니다.');
					
					location.href = '/user/password';
				}
			}
		})
	});
	
	
	
	$('#new_pw').focusout(function(){
        // 3.1 비밀번호 입력 및 정규표현식 확인
        var pw = $(this).val();
        if(pw == null || pw == ''){
            // 3.1.1.1 값이 없으면 출력되는 메세지
            console.log('pw 값이 없음.');
            $('#txt_pw').html('영문, 숫자, 특수문자로 8~16자로 사용해주세요.');
            $('#txt_pw').css({'color': 'gray'});
            isRegPW = false;
            return;
        }
        
        var regex = /^(?=.*[a-zA-z])((?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]))(?!.*[^a-zA-z0-9$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
        // 3.1.2 정규표현식 비교
        if(regexTest(regex, pw)){
            $('#txt_pw').html('<b>사용 가능한 비밀번호입니다.</b>');
            $('#txt_pw').css({'color': 'blue'});
            $('#new_re').focus();
            isRegPW = true;
            return;
        } else {
            $('#txt_pw').html('<b>사용할 수 없는 비밀번호입니다.</b>');
            $('#txt_pw').css({'color': 'red'});
            isRegPW = false;
            return;
        }

    });
	
});

function regexTest(regex, value){
    if(regex.test(value)) {
        return true;
    }
    return false;
}