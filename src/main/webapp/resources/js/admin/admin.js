$(document).ready(function(){
	$('#logout-tag').on('click', function(e){
		e.preventDefault();
		
		$('#logoutForm').submit();
	});
	
	var status = '${adminStatus}';
	
	if(status == 'login'){
		alert('로그인 되었습니다.');
	}
});