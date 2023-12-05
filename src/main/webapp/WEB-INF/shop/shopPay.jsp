<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>shopPay.jsp</title>
<jsp:include page="/include/bs4.jsp" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${ctp}/js/woo.js"></script>
<style>
 @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap');
	body, h2, h4 {
		font-family: 'Noto Sans KR';
	}
	.tbl2 td {
		line-height: 132px;
	}
	.tbl1 th, .tbl1 td {
		width: 25%;
	}
	.tbl3 th, .tbl4 td {
		background-color: #eee;
	}
	.tbl4 th {
		color: white;
		background-color: black;
	}
	.tbl5 tr {
		background-color: #eee;
	}
	a {
		text-decoration: none;
	}
	#totPr {
		font-size: 15pt;
		font-weight: bold;
	}
</style>
<script>
	'use strict';
	
	 function reservCheck() {
    	let mid = '${sMid}';
    	let url = "shopReserv.shop?mid="+mid;
  		window.open(url,"nWin","width=600px,height=750px");
    }
	 
	 function orderCheck() {
		let tel1 = myForm.tel1.value;
		let tel2 = myForm.tel2.value;
		let tel3 = myForm.tel3.value;
		let tel = tel1 + "-" + tel2 + "-" + tel3;
		myForm.tel.value = tel;
		
		let postcode = myForm.postcode.value;
    	let roadAddress = myForm.roadAddress.value;
    	let detailAddress = myForm.detailAddress.value;
    	let extraAddress = myForm.extraAddress.value;
    	myForm.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress + "/";
    	
    	myForm.submit();
	}
</script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
	<div class="container">
		<form name="myForm" method="post" action="shopPayOk.shop" class="was-validated">
			<h2>주 문 결 제</h2>
			<p><br/></p>
			<table class="table table-bordered text-center tbl1">
				<tr>
					<th>주문아이디</th>
					<td>${sMid}</td>
					<th>주문날짜</th>
					<td>${strToday}</td>
				</tr>
			</table>
			<h4>상품확인</h4>
				<table class="table text-center tbl2">
					<thead>
					<tr>
						<th>상품명</th>
						<th>정가</th>
						<th>판매가</th>
						<th>수량</th>
						<th>합계</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td class="text-left">
							<c:if test="${fn:contains(aVo.photo, 'https://')}">
    						<img src="${aVo.photo}" style="width:150px; height:150px; margin:0 20px;"/>
    					</c:if>
    					<c:if test="${not fn:contains(aVo.photo, 'https://')}">
    						<img src="${ctp}/images/album/${aVo.photo}" style="width:150px; height:150px; margin:0 20px;">
    					</c:if>
							
							<a href="shopAlbumDetail.shop?idx=${aVo.idx}">${aVo.alName}</a>
						</td>
						<td><fmt:formatNumber value="${aVo.price}" pattern="#,###"/></td>
						<td><fmt:formatNumber value="${salePrice}" pattern="#,###"/></td>
						<td>${num}</td>
						<td><fmt:formatNumber value="${totPrice}" pattern="#,###"/></td>
					</tr>
					</tbody>
					<tr><td colspan="6" class="p-0 m-0"></td></tr>
				</table>
				<p><br/></p>
				<h4>배송주소</h4>
				<table class="table text-center tbl3">
					<tr><td colspan="2" class="p-0 m-0"></td></tr>
					<tr>
						<th>배송방법</th>
						<td>
							<input type="radio" name="addressRadio" value="0" checked> 새로입력 &nbsp;&nbsp;&nbsp;
							<input type="radio" name="addressRadio" value="1"> 회원정보와 동일
						</td>
					</tr>
					<tr>
						<th><label for="name">이름</label></th>
						<td>
							<div class="form-group">
		            <input type="text" name="name" id="name" placeholder="이름을 입력하세요" class="form-control" required />
			        </div>
						</td>
					</tr>
					<tr>
						<th><label for="tel">휴대폰</label><br/></th>
						<td>
							<div class="form-group">
		        		<div class="input-group mb-3">
					        <input type="text" name="tel1" value="010" readonly class="form-control"/>&nbsp;&nbsp;-&nbsp;&nbsp;
					        <input type="text" name="tel2" size=4 maxlength=4 placeholder="3 또는 4자리 숫자" class="form-control" required/>&nbsp;&nbsp;-&nbsp;&nbsp;
					        <input type="text" name="tel3" size=4 maxlength=4 placeholder="3 또는 4자리 숫자" class="form-control" required/>
					   	  </div>
			        </div>
						</td>
					</tr>
					<tr>
						<th><label for="address">주소</label></th>
						<td>
							<div class="form-group">
					      <div class="input-group mb-1">
					        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control" required/>
					        <div class="input-group-append">
					          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-dark">
					        </div>
					      </div>
					      <input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1" required>
					      <div class="input-group mb-1">
					        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control" required> &nbsp;&nbsp;
					        <div class="input-group-append">
					          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
					        </div>
					      </div>
					    </div>
						</td>
					</tr>
					<tr>
						<th>배송메세지</th>
						<td>
							<div class="form-group">
		            <input type="text" name="content" id="content" placeholder="배송시 요청사항을 입력하세요" class="form-control" />
			        </div>
			      </td>
					</tr>
					<tr>
						<th>배송예약일</th>
						<td>
							<div class="form-group">
								<div class="input-group">
			            <div class="input-group-prepend"><input type="button" value="예약구매" onclick="reservCheck()" class="btn btn-dark" /></div>
			            <input type="text" name="rDate" id="rDate" value="${fn:substring(strToday, 0,10)}" class="form-control" />
			        	</div>
			        </div>
			      </td>
					</tr>
					<tr><td colspan="2" class="p-0 m-0"></td></tr>
				</table>
				<p><br/></p>
				<h4>결제정보</h4>
				<table class="table table-bordered tbl4">
					<thead>
					<tr>
						<th>총 상품금액</th>
						<th>총 추가금액</th>
						<th>최종 결제금액</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td><em><fmt:formatNumber value="${totPrice}" pattern="#,###"/></em> <i class="ri-add-circle-fill"></i></td>
						<td>
							<c:if test="${totPrice < 15000}"><em>2,500</em> 원 <i class="ri-add-circle-fill"></i></c:if>
							<c:if test="${totPrice >= 15000}"><em>0</em> 원 <i class="ri-add-circle-fill"></i></c:if>
						</td>
						<td id="totPr">
							<c:if test="${totPrice < 15000}"><em><fmt:formatNumber value="${totPrice + 2500}" pattern="#,###"/></em> 원</c:if>
							<c:if test="${totPrice >= 15000}"><em><fmt:formatNumber value="${totPrice}" pattern="#,###"/></em> 원</c:if>
						</td>
					</tr>
					</tbody>
					<tfoot>
					<tr>
						<td>
							<dl>
								<dt>상품 ${num}종(${num}개)</dt>
								<dd><fmt:formatNumber value="${aVo.price}" pattern="#,###"/> 원</dd>
							</dl>
							<dl>
								<dt>즉시할인</dt>
								<dd><fmt:formatNumber value="${aVo.price - salePrice}" pattern="#,###"/> 원</dd>
							</dl>
						</td>
						<td>
							<dl>
								<c:if test="${totPrice < 15000}"><dt>배송비</dt><dd>2,500 원</dd></c:if>
								<c:if test="${totPrice >= 15000}"><dt>배송비</dt><dd>0 원</dd></c:if>
							</dl>
						</td>
						<td>
						</td>
					</tr>
					</tfoot>
				</table>
				<p><br/></p>
				<h4>결제방법</h4>
				<table class="table table-borderless text-center tbl5">
					<tr class="row">
						<td class="col">신용카드</td>
						<td class="col col-5">
						  <select name="payment" class="custom-select">
				              <option value="0" selected>카드사 선택</option>
				              <option value="kakao">카카오뱅크</option>
				              <option value="sinhan">신한카드</option>
				              <option value="kb">국민카드</option>
				              <option value="nh">농협카드</option>
				              <option value="woori">우리카드</option>
				              <option value="sam">삼성카드</option>
				              <option value="hyun">현대카드</option>
				              <option value="lotte">롯데카드</option>
			              </select>
						</td>
						<td class="col col-5"><input type="button" onclick="orderCheck()" value="결제하기" class="btn btn-dark form-control"/></td>
					</tr>
				</table>
				<input type="hidden" name="orderDate" value="${strToday}"/>
				<input type="hidden" name="finalPrice" value="${totPrice + 2500}"/>
				<input type="hidden" name="albumIdx" value="${aVo.idx}"/>
				<input type="hidden" name="albumCnt" value="${num}"/>
				<input type="hidden" name="tel" />
				<input type="hidden" name="address" />
		</form>
	</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>