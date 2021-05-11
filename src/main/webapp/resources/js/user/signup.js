$(document).ready(function(){
    
	var isCheckingID = false; // 아이디 중복체크 여부
    var isCheckingPW = false; // 비밀번호 확인 여부
    var isCheckingEmail = false; // 이메일 인증 여부

    // 1. 아이디 중복체크
	$('#ui_id').focusout(function(){
        var id = $(this).val();
        var regex = /^[a-zA-Z0-9]{6,16}$/;

        // 1.1 빈칸일 경우 출력 메세지
        if(!isValue(id)){
            $('#txt_id').html('영문과 숫자가 포함된 6~16자 이내로 사용가능합니다. (대소문자 구분)');
            $('#txt_id').css({'color': 'gray'});
            return;
        }
        // 1.2. AJAX 사용하여 아이디 중복체크 (post)
        $.ajax({
            type: 'post',
            url: '/user/signup/checkingID',
            dataType: 'text',
            data: {
                ui_id: id
            },
            success: function(result){
                console.log(result);
                console.log(ui_id);
                console.log(id);
                if(result == 'success'){
                    if(regexTest(regex, id)){
                        // 1.2 사용가능한 아이디, 정규표현식 검사 후 출력메세지    
                        $('#txt_id').html('<b>사용가능한 아이디입니다.</b>');
                        $('#txt_id').css({'color': 'blue'});
                        isCheckingID = true;
                        console.log(isCheckingID);
                    } else {
                        // 1.3 6~16자 이내로 작성되지않은 아이디 정규표현식 검사 후 출력메세지
                        if(id.length < 6) {
                            $('#txt_id').html('<b>아이디는 6~16자 이내로 작성해주세요.</b>');
                        } else {
                            $('#txt_id').html('<b>아이디는 영문과 숫자만 사용할 수 있습니다.</b>');
                        }
                        $('#txt_id').css({'color': 'red'});
                        isCheckingID = false;
                        console.log(isCheckingID);
                    }
                } else {
                    // 1.4 이미 사용중인 아이디
                    $('#txt_id').html('<b>이미 사용중인 아이디입니다.</b>');
                    $('#txt_id').css({'color': 'red'});
                    isCheckingID = false;
                    console.log(isCheckingID);
                }
            }
        });
        
        
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
		
		if($('#email00').val() == null || $('#email00').val() == ''
			|| $('#email01').val() == null || $('#email01').val() == ''){
			alert('이메일을 입력해주세요.');
			return;
		}
		
        alert('이메일이 인증 되었습니다');
        isCheckingEmail = true;
        return;
        
   		$("#div_auth").hide();7
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
	// 3. 패스워드 정규표현식 및 비밀번호 확인 일치여부
    var isRegPW = false;
    $('#ui_pw').focusout(function(){
        // 3.1 비밀번호 입력 및 정규표현식 확인
        var pw = $(this).val();
        if(!isValue(pw)){
            // 3.1.1.1 값이 없으면 출력되는 메세지
            console.log('pw 값이 없음.');
            $('#txt_pw').html('영문, 숫자, 특수문자로 8~16자 조합으로 사용해주세요. (대소문자 구분)');
            $('#txt_pw').css({'color': 'gray'});
            isRegPW = false;
            return;
        }
        
        var regex = /^(?=.*[a-zA-z])((?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]))(?!.*[^a-zA-z0-9$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
        // 3.1.2 정규표현식 비교
        if(regexTest(regex, pw)){
            $('#txt_pw').html('<b>사용 가능한 비밀번호입니다.</b>');
            $('#txt_pw').css({'color': 'blue'});
            $('#re_pw').focus();
            isRegPW = true;
            return;
        } else {
            $('#txt_pw').html('<b>사용할 수 없는 비밀번호입니다.</b>');
            $('#txt_pw').css({'color': 'red'});
            isRegPW = false;
            return;
        }

    });

    $('#re_pw').focusout(function(){
        // 3.2 비밀번호 확인 여부 (isCheckingPW, isRegPW)
        var pw = $('#ui_pw').val();
        var repw = $(this).val();
        if(!isValue(repw)){
            // 3.1.1.1 값이 없으면 출력되는 메세지
            $('#txt_re_pw').hide();
            isCheckingPW = false;
            return;
        }
        $('#txt_re_pw').show();
        if(pw == repw){
            console.log('일치하는 비밀번호');
            $('#txt_re_pw').html('<b>비밀번호가 일치합니다.</b>');
            $('#txt_re_pw').css({'color': 'blue'});
            isCheckingPW = true;
            return;
        } else {
            console.log('비밀번호 일치하지 않음');
            $('#txt_re_pw').html('<b>비밀번호가 일치하지 않습니다.</b>');
            $('#txt_re_pw').css({'color': 'red'});
            isCheckingPW = false;
            return;
        }
    });


    var form = $('#form_signup');

    // 회원가입 클릭
    $('#btn_signup').on('click', function(e){
    	e.preventDefault();
        // 값 입력 여부 확인, 미입력시 focus() 이동
        
        if(!isValue($('#ui_name').val())){
            alert('이름을 입력해주세요.');
            $('#ui_name').focus();
            return;
        }
        if(!isValue($('#ui_pw').val())){
            alert('비밀번호를 입력해주세요.');
            $('#ui_pw').focus();
            return;
        }
        if(!isValue($('#re_pw').val())){
            alert('비밀번호 재입력해주세요.');
            $('#re_pw').focus();
            return;
        }
        if(!isValue($('#email00').val()) || !isValue($('#email01').val())){
            alert('이메일을 입력해주세요.');
            $('#email00').focus();
            return;
        }
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
        if(!$('input:radio[name=ui_event_sms]').is(':checked')){
            alert('서비스 및 이벤트 소식 이메일 수신여부를 확인해주세요.');
            $('input[name=ui_event_sms]').focus();
            return;
        }

        // 아이디 중복체크, 
        if(!isCheckingID){
            alert('아이디 중복 확인해주세요.');
            console.log('ID 중복체크 실패');
            $('#ui_id').focus();
            return;
        }
        // 사용 가능한지 비밀번호 확인
        if(!isRegPW){
            alert('사용할 수 없는 비밀번호입니다.');
            console.log('사용할 수 없는 비밀번호');
            $('#ui_pw').focus();
            return;
        }
        // 두 비밀번호 일치여부
        if(!isCheckingPW){
            alert('비밀번호가 일치하지 않습니다.');
            console.log('비밀번호가 일치하지 않음');
            $('#re_pw').focus();
            return;
        }
        
        // 이메일 인증 isCheckingEmail = true, auth_email (실 사용시 주석처리)
        //isCheckingEmail = true;
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

        console.log($('#ui_email').val());
        console.log($('#ui_phone').val());

        console.log(email + " / " +auth_email);

        if(email != auth_email){
            console.log('인증받은 메일과 다릅니다.');
            $('#email00').focus();
            return;
        }
        
        

        alert('회원가입 되었습니다.\n로그인하여 이용해주세요.');
        console.log('회원가입 성공!');
        form.submit();
    });
});

// 0.1 정규표현식 비교 함수
function regexTest(regex, value){
    if(regex.test(value)) {
        return true;
    }
    return false;
}

// 0.2 해당 값 입력 여부 확인 (없으면 false, 있으면 true)
function isValue(value){
    if(value == null || value == ''){
        return false;
    }
    return true;
}