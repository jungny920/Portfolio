$(document).ready(function(){
	var isCheckingEmail = false;
    var form = $('#edit_form');

    $('#btn_submit').on('click', function(e){
        e.preventDefault();

		if(!isValue($('#phone00').val()) || !isValue($('#phone01').val()) || !isValue($('#phone02').val())){
            alert('휴대폰 번호를 입력해주세요.');
            $('#phone00').focus();
            return;
        }
        if(!isValue($('#ui_zcode').val()) || !isValue($('#ui_addr').val()) || !isValue($('#ui_addr_d').val())){
            alert('주소를 입력해주세요.');
            $('#ui_addr_d').focus();
            return;
        }
        
		auth_email = $('#email00').val()+'@'+$('#email01').val();

        if(!isCheckingEmail){
            alert('이메일을 인증해주세요.');
            console.log('이메일 미인증');
            $('#email00').focus();
            return;
        }
        // email, phone 값들을 hidden input태그에 저장
        var email = $('#email00').val()+'@'+$('#email01').val();
        var phone = $('#phone00').val()+'-'+$('#phone01').val()+'-'+$('#phone02').val();
        $('#ui_email').attr('value', email);
        $('#ui_phone').attr('value', phone);

		alert('회원정보가 변경되었습니다.'); 
		
        form.submit();
    });
    
	
	$('#btn_update_email').click(function(){
		$(this).hide();
		$('#btn_email_auth').show();
		$('#email_select').show();
		
		$('#email00').attr('readonly', false);
		$('#email01').attr('readonly', false);
	});
	
	
	 // 2. 이메일주소 설정
    $('#email_select').on('change', function(){
        var email = $('#email_select');

        if(email.val() == 'other'){
        	$('#email01').attr('value', '');
            $('#email01').attr('disabled', false);
            console.log('직접입력');
        } else {
            $('#email01').attr('value', email.val());
            $('#email01').attr('disabled', true);
            console.log('이메일주소 설정');
        }
    })

    // 2.copy 이메일 복사한 내용
	$("#btn_email_auth").on("click", function(e){
   		e.preventDefault();
   		$("#div_auth").hide();
		//var receiveMail = $("#mem_email").val();
		
		if(!isValue($("#email00").val()) || !isValue($('#email01').val())){
			// 메시지를 alert()   사용하지않고, 임의의 위치에 출력하는 형태
			$("#txt_email").html("<b>이메일을 입력해주세요.</b>");
            $("#txt_email").css("color", "red");
			return;
		}
		console.log(ui_email);
		var ui_email = $('#email00').val()+'@'+$('#email01').val();
        var regex = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
        if(!regexTest(regex, ui_email)){
            $("#txt_email").html("<b>이메일 주소를 다시 확인해 주세요.</b>");
            $("#txt_email").css("color", "red");
            return;
        }
        
    	$("#txt_email").css("color", "grey");
    	$("#txt_email").html("인증코드 전송중..");
       
		
		$.ajax({
			url: '/email/send',    // EmailController.java
			type: 'post',
			dataType: 'text',
			data: {receiveMail : ui_email},  //  {key : value}
			success: function(data){
				$("#div_auth").show();
				$("#txt_email").css("color", "grey");
				$("#txt_email").html('인증코드가 전송되었습니다.');
			}
		});
	});
	
    var auth_email;

	/* 인증코드 입력 후 확인 클릭 시 */
	$("#btn_ecode").on("click", function(e){
		e.preventDefault();
		
		var code = $("#auth_code").val(); // 메일을 통하여 받았던 인증코드를 보고 입력하면 인증코드를참조 
		
		$.ajax({
			url: '/user/authCode',
			type: 'post',
			dataType: 'text',
			data: {code : code},
			success: function(data){
				if(data == 'SUCCESS'){
					$("#div_auth").hide(); // 인증코드 입력화면 숨김.
					$("#txt_email").css("color", "blue");
					$("#txt_email").html('<b>인증 성공</b>');
					//$("#mem_email").attr("readonly",true);
					//$("#btn_sendAuthCode").attr("disabled", true);
					isCheckingEmail = "true";  // 인증메일 유효성 검사에 사용하기위한 변수. 
					
                    auth_email = $('#email00').val()+'@'+$('#email01').val();
                    console.log(auth_email);
                    return;
					
				} else {
					$("#div_auth").hide();
					$("#txt_email").css("color", "red");
					$("#txt_email").html('<b>인증 실패. 다시 시도해주세요.</b>');
					return;
				}
			}
		});
	});
});

function regexTest(regex, value){
    if(regex.test(value)) {
        return true;
    }
    return false;
}

function isValue(value){
    if(value == null || value == ''){
        return false;
    }
    return true;
}