<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<ul class="list-group" style="text-align: center"><!-- 1차 카테고리 출력 -->	   		
	<li class="list-group-item group_cg">
		<h5><a href="#" style="color: black; text-decoration: none;"><strong>카테고리</strong></a></h5>
	</li>	
<c:forEach items="${mainCategoryList}" var="cg_list">
	<li class="list-group-item main_cg" style="background-color: #f5f4f0;">
		<a href="#" data-code="${cg_list.cg_code}" style="color: black; text-decoration: none;">
			<strong>${cg_list.cg_name}</strong></a>
        <!-- 2차 카테고리 출력 위치-->
        <ul class="sub_cg" style="list-style: none; padding: 0;"></ul>
	</li>
</c:forEach>
</ul>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script id="subCGListTemplate" type="text/x-handlebars-template">
	{{#each .}}
	<li>
		<a href="/product/list?cg_code={{cg_code}}" style="color: gray; text-decoration: none;">{{cg_name}}</a>
	</li>
	{{/each}}
</script>
<script>
$(document).ready(function(){
	/*
	$('.group_cg').on('click', function(){
		$('.main_cg').toggle();
		$('.main_cg .sub_cg').empty();
	});
	*/
	$('.main_cg').on('click', function(e){
		var category = $(this);
		// '.main_cg'의 'a'태그의 'href'값을 cg_code로 받아옴.
		var cg_code = $(this).find('a').attr('data-code');
		var url = '/product/subCategoryList/' + cg_code;
		
		//$('.main_cg').find('ul').remove();
		// ajax요청
		// 1차 카테고리를 참조하는 2차 카테고리 정보
		$.getJSON(url, function(data){
			subCGList(data, category, $('#subCGListTemplate'));
		});
	});
});
 
var subCGList = function(subCGData, target, template) {
 
	var temp = Handlebars.compile(template.html());
	var option = temp(subCGData);
	
	$('.main_cg .sub_cg').empty();
	target.find(".sub_cg").append(option);
}
</script>