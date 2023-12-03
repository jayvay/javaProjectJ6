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
<title>shopCart.jsp</title>
<jsp:include page="/include/bs4.jsp" />
<style>
 @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap');
	body, h2, h4 {
		font-family: 'Noto Sans KR';
	}
	a {
		text-decoration: none;
	}
</style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
	<div class="container">
		<form name="myform" method="post" action="shopPayOk.shop" class="was-validated">
			<h2>장 바 구 니</h2>
			<p><br/></p>
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
					<c:forEach var="vo" items="${vos}" varStatus="st">
						<tr>
							<td class="text-left">
								<img src="${vo.photo}" style="width:150px; height:150px; margin:0 20px;"/>
								<a href="shopAlbumDetail.shop">${vo.alName}</a>
							</td>
							<td><fmt:formatNumber value="${vo.price}" pattern="#,###"/></td>
							<td><fmt:formatNumber value="${vo.salePrice}" pattern="#,###"/></td>
							<td>${vo.albumCnt}</td>
							<td>
								<c:set var="totPrice" value="${vo.salePrice * vo.albumCnt}" />
								<fmt:formatNumber value="${totPrice}" pattern="#,###"/>
							</td>
							<td></td>
						</tr>
					</c:forEach>
					</tbody>
					<tr><td colspan="6" class="p-0 m-0"></td></tr>
				</table>
				
				<p><br/></p>
				<h4>결제정보</h4>
				<table class="table table-bordered">
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
						<td><em>2,500</em> 원 <i class="ri-add-circle-fill"></i></td>
						<td><em>${totPrice + 2500}</em> 원</td>
					</tr>
					</tbody>
					<tfoot>
					<tr>
						<td>
							<dl>
								<dt>상품 ${fn:length(vos)}종(${fn:length(vos)}개)</dt>
								<dd>${totPrice} 원</dd>
							</dl>
							<dl>
								<dt>즉시할인</dt>
								<dd>${vo.price - vo.salePrice} 원</dd>
							</dl>
						</td>
						<td>
							<dl>
								<dt>배송비</dt>
								<dd>2,500 원</dd>
							</dl>
						</td>
						<td>
						</td>
					</tr>
					</tfoot>
				</table>
		</form>
	</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>