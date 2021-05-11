$(document).ready(function(){
    
    var form = $('#delete_form');

	// 수정버튼 클릭
	$('#btn_delete').on('click', function(){
		console.log('delete-click');
		
		
		
		form.submit();
	});
});