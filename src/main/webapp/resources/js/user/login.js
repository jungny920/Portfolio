$(document).ready(function(){
	var form_login = $('#form_login');

	$('#btn_login').on('click', function(e){
		e.preventDefault();
		
		var id = $('#ui_id');
		var pw = $('#ui_pw');
		
		if(id.val() == null || id.val() == ""){
			alert('아이디를 입력하세요');
			id.focus();
			return;
		}
		if(pw.val() == null || pw.val() == ""){
			alert('비밀번호를 입력하세요');
			pw.focus();
			return;
		}
		console.log('LOGIN OK');
		
		form_login.submit();
	});
	
	$('#btn_find').click(function(e){
		e.preventDefault();

		location.href = '/user/find';
		
	});
	
});