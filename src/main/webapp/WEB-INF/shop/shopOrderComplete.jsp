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

	footer {
		position: absolute;
		margin-top: 0px;
		padding: 0px;
		width: 100%;
	}
</style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
	<div class="container text-center mb-3">
		<div class="child">
			<font size="15pt"><i class="ri-checkbox-circle-line"></i></font>
			<h2 class="text-center mt-3 mb-3">주문이 완료되었습니다!</h2>
			<a href="memberMain.mem" class="btn btn-dark btn-lg text-center mt-3">주문내역 확인하기</a>
		</div>
	</div>
<p><br/></p>
<div style="clear:both"></div>
<jsp:include page="/include/footer.jsp" />
</body>
</html>