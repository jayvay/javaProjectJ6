<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		width: 25%
	}
	.tbl3 th {
		background-color: #eee;
	}
	a {
		text-decoration: none;
	}
	.calcTotBox {
    position: absolute;
    right: 0;
    top: 0;
    bottom: 0;
    width: 318px;
    height: 100%;
    text-align: center;
    background-color: #d4e3f1;
	}
</style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
	<div class="container">
		<form name="myform" method="post" action="shopPayOk.shop" class="was-validated">
			<h2>주 문 결 제</h2>
			<p><br/></p>
			<table class="table table-bordered text-center tbl1">
				<tr>
					<th>주문아이디</th>
					<td>mid</td>
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
						<th>배송일</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td class="text-left">
							<img src="${aVo.photo}" style="width:150px; height:150px; margin:0 20px;"/>
							<a href="shopAlbumDetail.shop">${aVo.alName}</a>
						</td>
						<td><fmt:formatNumber value="${aVo.price}" pattern="#,###"/></td>
						<td><fmt:formatNumber value="${salePrice}" pattern="#,###"/></td>
						<td>${num}</td>
						<td><fmt:formatNumber value="${totPrice}" pattern="#,###"/></td>
						<td></td>
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
							<input type="radio" name="addressRadio" checked> 새로입력 &nbsp;&nbsp;&nbsp;
							<input type="radio" name="addressRadio"> 회원정보와 동일
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
					<tr><td colspan="2" class="p-0 m-0"></td></tr>
				</table>
				<p><br/></p>
				<h4>결제정보</h4>
				<table class="table table-bordered">
					<thead>
					<tr>
						<th>총 상품금액</th>
						<th>총 추가금액</th>
						<th>총 할인금액</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td><em><fmt:formatNumber value="${totPrice}" pattern="#,###"/></em><i class="ri-add-circle-fill"></i></td>
						<td><em>2,500</em>원<i class="ri-indeterminate-circle-fill"></i></td>
						<td><em>0원</em><i class="ri-indeterminate-circle-fill"></i></td>
					</tr>
					</tbody>
					<tfoot>
					<tr>
						<td>
							<dl>
								<dt>상품 1종(1개)</dt>
								<dd>13,000원</dd>
							</dl>
							<dl>
								<dt>즉시할인</dt>
								<dd>2,600원</dd>
							</dl>
						</td>
						<td>
							<dl>
								<dt>배송비</dt>
								<dd>2,500원</dd>
							</dl>
						</td>
					</tr>
					</tfoot>
				</table>
				<div class="calcTotBox">
					<div>
						<p>최종 결제금액</p>
						<p>10,400원</p>
					</div>
				</div>
		</form>
	</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>