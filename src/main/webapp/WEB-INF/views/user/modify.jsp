<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
	<meta name="generator" content="Hugo 0.80.0">
	<title>Starter Template · Bootstrap v4.6</title>
	
	<style>
	  div + label {
	  	display: block;
	  }
	  
	  div p {
	  	font-size: 13px;
	  }
	  
	  .phone_number {
	  	border: solid 1px lightgray;
        height: 38px;
        width: 161px;
        border-radius: 4px;
	  }
	  
	  .dash {
	  	color: gray;
	  	padding-left: 3px;
	  }
	</style>
	
	<%@ include file="/WEB-INF/views/common/config.jsp" %>
	<script src="/js/user/edit.js"></script>
	<script>
	$(document).ready(function(){
		
		var event = '${userInfoVO.ui_event_sms}';
		if(event == 'Y'){
			$('#event_y').attr('checked', true);
		} else {
			$('#event_n').attr('checked', true);
		}
		
		var phone = '${userInfoVO.ui_phone}'.split('-');
		for(var i in phone){
			console.log(phone[i])
			if(i == 0){
				$('#phone00').val(phone[i]);
			} else {
				$('#phone0'+i).attr('value', phone[i]);
			}
		}
		
		var email = '${userInfoVO.ui_email}'.split('@');
		for(var i in email){
			console.log(email[i]);
			$('#email0'+i).attr('value', email[i]);
		}
		
	});
	</script>
	<link href="/css/user/signup.css" rel="stylesheet">
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>

  <div class="starter-template">
    <h1>회원정보 수정</h1>
  </div>
  <div class="container" style="width: 500px;">
	<form id="edit_form" action="/user/modify" method="post">
	  <div class="form-group">
		<label for="ui_name">＊이름</label>
		<input type="text" id="ui_name" name="ui_name" class="form-control" maxlength="10" value="<c:out value='${userInfoVO.ui_name}' />" readonly>
	  </div>
	  <div class="form-group">
		<label for="ui_id">＊아이디</label>
	  	<input type="text" id="ui_id" name="ui_id" class="form-control" maxlength="16" value="<c:out value='${userInfoVO.ui_id}' />" readonly>
	  </div>
	  <div class="form-group">
	  	<label for="ui_pw">＊비밀번호</label>
	  	<button type="button" id="btn_pw_modify" class="form-control" onclick="location.href = '/user/password';">비밀번호 변경</button>
	  </div>
	  <div class="form-group">
	    <label for="ui_email">＊이메일</label><br>
	    <input type="text" id="email00" class="email_tag" readonly>
	    <span class="at">@</span>
	    <input type="text" id="email01" class="email_tag" readonly>
	    <button type="button" id="btn_update_email" class="email_tag" style="width: 120px;">이메일 변경</button>
	    <select id="email_select" class="email_tag" style="width: 120px; display: none;">
	      <option value="">주소 선택</option>
	      <option value="naver.com">naver.com</option>
	      <option value="hanmail.net">hanmail.net</option>
	      <option value="daum.net">daum.net</option>
	      <option value="nate.com">nate.com</option>
	      <option value="gmail.com">gmail.com</option>
	      <option value="other" selected>직접입력</option>
	    </select>
   	    <button id="btn_email_auth" class="form-control" style="display: none;">이메일 인증</button>
	    <div id="div_auth" style="display: none;">
	      <input type="text" id="auth_code" name="e_code" maxlength="6" placeholder="인증코드 입력">
	      <input type="button" id="btn_ecode" name="e_code" value="인증확인">
        </div>
        <p class="txt_email" id="txt_email" style="display: block; color: gray"></p>
	    <input type="hidden" id="ui_email" name="ui_email">
	  </div>
 	  <div class="form-group">
		<label for="phone">＊연락처</label><br>
		<span>
      	<select id="phone00" class="phone_number" style="width: 120px">
          <option value="N">선택</option>
          <option value="010">010</option>
          <option value="011">011</option>
          <option value="0130">0130</option>
          <option value="016">016</option>
          <option value="017">017</option>
          <option value="018">018</option>
          <option value="019">019</option>
        </select><span class="dash">-</span>
	      <input type="text" id="phone01" class="phone_number" maxlength="4"><span class="dash">-</span>
	      <input type="text" id="phone02" class="phone_number" maxlength="4">
	  	</span>
	  	<input type="hidden" id="ui_phone" name="ui_phone">
	  </div>
	  <div class="form-group">
		<!--주소-->
		<label for="ui_addr">＊주소</label><br>
		<input type="text" id="ui_zcode" name="ui_zcode" class="form-control" placeholder="우편번호" readonly value="<c:out value='${userInfoVO.ui_zcode}' />" style="width: 250px; display: inline;">
		<input type="button" onclick="sample2_execDaumPostcode()" name="" class="form-control" value="우편번호 찾기" style="width: 215px; display: inline;"><br>
		<input type="text" id="ui_addr" name="ui_addr" class="form-control" placeholder="주소" readonly value="<c:out value='${userInfoVO.ui_addr}' />"><br>
		<input type="text" id="ui_addr_d" name="ui_addr_d" class="form-control" placeholder="상세주소" value="<c:out value='${userInfoVO.ui_addr_d}' />">
		<input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
	  </div>
	  <div class="form-group">
		<label>＊서비스 및 이벤트 소식 이메일 수신 여부</label>
		<div class="text-center">
		  <label style="font-size: 14px; margin: 10px;">이메일 수신 동의 <input type="radio" name="ui_event_sms" value="Y" id="event_y"></label>
		  <label style="font-size: 14px; margin: 10px;">이메일 수신 거부 <input type="radio" name="ui_event_sms" value="N" id="event_n"></label>
		</div>
		<hr>
	  </div>
	  <div class="text-center">
	  	<button id="btn_submit" class="btn btn-primary">회원정보 수정</button>
	  	<button class="btn btn-secondary">취소</button>
      </div>
    </form>
  </div>
  
<%@include file="/WEB-INF/views/common/footer.jsp" %>
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample2_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample2_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('ui_zcode').value = data.zonecode;
                document.getElementById("ui_addr").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("ui_addr_d").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
   	
</script>
</body>
</html>