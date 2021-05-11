<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	  .bd-placeholder-img {
	    font-size: 1.125rem;
	    text-anchor: middle;
	    -webkit-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	    user-select: none;
	  }
	
	  @media (min-width: 768px) {
	    .bd-placeholder-img-lg {
	      font-size: 3.5rem;
	    }
	  }
	</style>
	
	<%@ include file="/WEB-INF/views/common/config.jsp" %>
	
<link href="/css/order/orderList.css" rel="stylesheet">
</head>
<body>

<%@include file="/WEB-INF/views/common/nav.jsp" %>

<main role="main" class="container-fluid">
	<div class="row">
		<div class="col-lg-2">
			<!-- 상품리스트 출력 위치 -->
			<%@include file="/WEB-INF/views/common/categoryList.jsp" %>
		</div>
		<div class="col-lg-10">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4>상품 목록</h4>
				</div>
				<div class="panel-body">
					<!-- 리스트(테이블) 삽입 -->
					<table class="table table-striped">
					  <thead>
					    <tr>
					      <th scope="col">번호</th>
					      <th scope="col">상품이미지</th>
					      <th scope="col">상품명</th>
					      <th scope="col">가격</th>
					      <th scope="col">수량</th>
					      <th scope="col">제조사</th>
					    </tr>
					  </thead>
					  <tbody>
					  <c:if test="${empty cart_list}">
					  	<tr>
					  		<th colspan="7">
					  			<h4 style="text-align: center">장바구니가 비어있습니다.</h4>
					  		</th>
					  	</tr>
					  </c:if>
					  <c:set var="i" value="0" />
					  <c:set var="price" value="0"/>
					  <c:forEach items="${cart_list}" var="cartVO">
					  	<c:set var="i" value="${i+1}" />
						<c:set var="price" value="${cartVO.pd_price * cartVO.sc_amount}"/>
					    <tr>
					      <th scope="row">${i}
					      	<input type="hidden" value="<c:out value="${cartVO.sc_code}" />">
				      	  </th>
					      <td>
				      	  	<img src="/util/image?fileName=${cartVO.pd_image}" height="60">
				      	  </td>
				      	  <td>
					      	<c:out value="${cartVO.pd_name}" />
				      	  </td>
					      <td><fmt:formatNumber type="currency" value="${price}" />
					      	<input type="hidden" name="pd_price" value="${cartVO.pd_price}">
				      		<p data-price="${price}" style="color: gray; font-size: 12px;">
				      		  <fmt:formatNumber type="currency" value="${cartVO.pd_price}" /></p>
				      	  </td>
					      <td><c:out value="${cartVO.sc_amount}" /></td>
					      <td><c:out value="${cartVO.pd_company}" /></td>
				        </tr>
				        <c:set var="sum" value="${sum+price}"/>
				      </c:forEach>
					  </tbody>
					</table>
				</div>
				
			</div>
			<div>
				<div class="panel-body">
					<!-- 주문금액 출력 -->
					<table class="table table-striped">
						<tr>
							<td>총 금액</td>
							<td><p data-sum="${sum}"><fmt:formatNumber type="currency" value="${sum}" /></p></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="container info" style="width: 650px;">
				<h5>배송자 정보</h5>
				<input type="radio" id="og" name="user" checked><label for="og">기존 배송지</label>
				<form id="orderForm" action="/order/orderBuy" method="post">
				<div>
					<input type="hidden" name="ui_id" value="${sessionScope.loginStatus.ui_id}">
					<input type="hidden" name="pd_code" value="${pd_code}">
					<input type="hidden" name="ord_price" value="${ord_price}">
					<input type="hidden" name="ord_amount" value="${ord_amount}">
			    	<input type="hidden" name="ord_total_price" value="${sum}">
					<div>
						<div class="form-group">
							<label for="ui_name">＊이름</label>
							<input type="text" id="ui_name" name="ord_name" class="form-control" maxlength="10" value="${sessionScope.loginStatus.ui_name}" readonly>
							<input type="hidden" name="type" value="${type}">
						</div>
						<div class="form-group">
							<label for="phone">＊휴대폰</label><br>
					      	<span>
						      	<select id="phone00" class="phone_number" style="width: 120px" readonly>
						          <option value="">선택</option>
						          <option value="010">010</option>
						          <option value="011">011</option>
						          <option value="0130">0130</option>
						          <option value="016">016</option>
						          <option value="017">017</option>
						          <option value="018">018</option>
						          <option value="019">019</option>
						        </select><span class="dash">-</span>
						        <input type="text" id="phone01" class="phone_number" maxlength="4" readonly><span class="dash">-</span>
						        <input type="text" id="phone02" class="phone_number" maxlength="4" readonly>
						  	</span>
					      	<input type="hidden" id="ui_phone" name="ord_phone" value="${sessionScope.loginStatus.ui_phone}">
					    	<input type="hidden" name="ord_total_price" value="${sum}">
					    </div>
					</div>
					<div class="form-group">
						<!-- 주소 -->
						<label for="ui_addr">＊주소</label><br>
						<input type="text" id="ui_zcode" name="ord_zcode" class="form-control" value="${sessionScope.loginStatus.ui_zcode}" placeholder="우편번호" readonly style="width: 250px; display: inline;">
						<input type="button" class="form-control" value="우편번호 찾기" style="width: 215px; display: inline;"><br>
						<!-- <input type="button" onclick="sample2_execDaumPostcode()" name="" class="form-control" value="우편번호 찾기" style="width: 215px; display: inline;"><br> -->
						<input type="text" id="ui_addr" name="ord_addr" class="form-control" value="${sessionScope.loginStatus.ui_addr}" placeholder="주소" readonly><br>
						<input type="text" id="ui_addr_d" name="ord_addr_d" class="form-control" value="${sessionScope.loginStatus.ui_addr_d}" placeholder="상세주소" readonly>
						<input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
		  			</div>
		  			<button id="btnOrderBuy" type="submit" class="btn btn-primary">구매하기</button>
  				</div>
				</form>
			</div>
		</div>
	</div>
</main><!-- /.container -->
<script>
$(document).ready(function(){
	var phone = $('#ui_phone').val().split('-');
	for(var i in phone){
		console.log(phone[i])
		if(i == 0){
			$('#phone00').val(phone[i]);
		} else {
			$('#phone0'+i).attr('value', phone[i]);
		}
	}
	
	var form = $('#orderForm');
	
	$('#btnOrderBuy').on('click', function(e){
		e.preventDefault();
		if(!confirm('해당 상품을 구매하시겠습니까?')){
			return;
		}
		alert('구매되었습니다.\n마이페이지에서 구매하신 상품을 확인하실 수 있습니다.');
		form.submit();
	});
	
});
</script>
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