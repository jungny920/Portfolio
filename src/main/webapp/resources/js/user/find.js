$(document).ready(function(){
     
    // 아이디 찾기
    $("#btn_find_id").on('click', function(){

        var userInfo = {
            ui_name: $('#find_id_name').val() 
        };
        
		if(!userInfo.ui_name == null || userInfo.ui_name == ""){
            alert('이름을 입력해주세요.');
            return;
		}
		
        $.ajax({
            type: 'post',
            url: '/user/find/id',
            data: userInfo,
            dataType: 'text',
            success: function(result){
                console.log('아이디 출력 작업');
                console.log(result);
	            if(result != ""){
	            	alert('아이디 : ' + result);
	            	location.href = '/user/login';
	            } else {
	            	alert('해당 이름으로 등록된 아이디가 없습니다.');
	            	$('#find_id_name').val('');
	            }
            },
            error: function(){
            	alert('FIND ID ERROR');
            }
        });
    });

	// 비밀번호 찾기
    $("#btn_find_pw").on('click', function(){

        var userInfo = {
            ui_id: $('#find_pw_id').val(),
            ui_email: $('#find_pw_email').val() 
        };
        
        if(!userInfo.ui_id == null || userInfo.ui_id == ""){
            alert('아이디를 입력해주세요.');
            return;
		}
		if(!userInfo.ui_email == null || userInfo.ui_email == ""){
            alert('이메일을 입력해주세요.');
            return;
		}
		
        $.ajax({
            type: 'post',
            url: '/user/find/pw',
            data: userInfo,
            dataType: 'text',
            success: function(result){
                console.log('비밀번호 메일전송 작업');
	            if(result != ""){
	            	alert('임시비밀번호: '+result+'\n로그인하여 비밀번호를 변경해주세요.');
	            	//alert("등록된 메일로 임시비밀번호를 전송하였습니다.");
	            	location.href = '/user/login';
	            } else {
	            	alert('입력하신 정보가 다릅니다.');
	            	$('#find_pw_id').val('');
	            	$('#find_pw_email').val('');
	            }
            },
            error: function(){
            	alert('FIND PW ERROR');
            }
        });
    });
    
   
});